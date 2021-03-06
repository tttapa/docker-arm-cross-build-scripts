#!/usr/bin/env bash

set -ex

version="main" # Release tag on GitHub

# Download
git clone --single-branch --depth=1 --branch $version \
    https://github.com/google/googletest.git
pushd googletest

# Configure
cmake -Bbuild -S. \
    -DCMAKE_INSTALL_PREFIX="/usr/local" \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_TOOLCHAIN_FILE="../../${HOST_TRIPLE}.cmake"

# Build & Install
cmake --build build -j
cmake --install build --prefix "${RPI_SYSROOT}/usr/local"
cmake --install build

popd && rm -rf googletest