#!/usr/bin/env bash
set -euo pipefail
node tests/test_engine.js
python3 - <<'PY'
from pathlib import Path
import shutil
out = Path("dist")
out.mkdir(exist_ok=True)
for name in ("index.html", "LICENSE"):
    shutil.copy2(name, out/name)
for name in ("assets", "explore", "diagnose"):
    shutil.copytree(name, out/name, dirs_exist_ok=True)
(out/"data").mkdir(exist_ok=True)
for name in ("topics.json", "dependencies.json", "cn-curriculum-standards.json", "questions.json", "id-aliases.json"):
    shutil.copy2(Path("data")/name, out/"data"/name)
share=out/"diagnose/share.js"
share.write_text(share.read_text().replace("https://math.pansgo.com/?from=share","https://xuexi.wangdongchao.com/?from=share"))
PY
