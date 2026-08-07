#!/bin/sh
# Helix from source installer.

if [ ! -d "helix" ]
then
  echo "Cloning."
  git clone --depth=1 https://github.com/helix-editor/helix
else
  echo "Already cloned."
fi

echo "Entering."
cd helix/

echo "Installing."
echo "Installing: cargo check."
hash cargo
if [ $? -ne 0 ]
then
  echo "Installing Rust."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

echo "Installing: cargo install."
cargo install --path helix-term --locked

echo "Creating necessary directories."
mkdir -p ~/.local/bin/
mkdir -p ~/.config/helix/

echo "Deleting old artifacts."
rm ~/.local/bin/hx
rm -rf ~/.config/helix/runtime/

echo "Copying artifacts."
cp target/release/hx ~/.local/bin/hx
cp -r runtime ~/.config/helix/runtime

echo "Setting grammars."
hx --grammar fetch
hx --grammar build
