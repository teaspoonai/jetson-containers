#!/usr/bin/env bash
set -ex
# teaspoon patch: on this build host (Docker 27.5.1 / cu126 / jetson-containers master) there is
# no prebuilt onnxruntime-gpu tarball or wheel for this exact combo, and the CUDA execution-provider
# source build fails to compile (random_impl.cu.o / tensorscatter_impl.cu.o). teagram uses onnxruntime
# only as a CPU transitive dependency (faster-whisper's built-in Silero VAD); the GPU EP is never used
# at runtime. Install the CPU wheel from PyPI (aarch64 cp310 wheels exist) so this layer succeeds
# deterministically without a source build. To restore the GPU build, revert this file (.orig).
uv pip install onnxruntime
python3 -c 'import onnxruntime; print(onnxruntime.__version__);'
