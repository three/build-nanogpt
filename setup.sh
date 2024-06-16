#!/usr/bin/env bash
set -euo pipefail

# Generated with help by ChatGPT by giving it output of history after setting up
# Lambda Labs 1xA100 instance

# Function to handle errors
error_exit() {
    echo "Error on line $1"
    exit 1
}
trap 'error_exit $LINENO' ERR

# Update package list
echo "Updating package list..."
sudo apt update

# Upgrade installed packages
echo "Upgrading installed packages..."
sudo apt dist-upgrade -y

# Install necessary packages
echo "Installing necessary packages..."
sudo apt install -y neovim vim wget htop curl file git ncdu ripgrep tmux tree jq gron neofetch

# Install Python and related tools
echo "Installing Python and related tools..."
sudo apt install -y python3 python3-pip python3-virtualenv

# Remove unnecessary packages
echo "Removing unnecessary packages..."
sudo apt autoremove -y

# Set up Python virtual environment if it doesn't exist
if [ ! -d "venv" ]; then
    echo "Setting up Python virtual environment..."
    python3 -m venv venv
else
    echo "Virtual environment already exists. Skipping creation."
fi

# Activate virtual environment
source venv/bin/activate

# Install requirements from requirements.txt if the file exists and packages are not already installed
if [ -f "requirements.txt" ]; then
    if [ ! -f "venv/.installed" ]; then
        echo "Installing Python packages from requirements.txt..."
        pip install -r requirements.txt
        touch venv/.installed
    else
        echo "Requirements already installed. Skipping installation."
    fi
else
    echo "requirements.txt not found. Skipping Python packages installation."
fi

echo "Setup completed successfully."

