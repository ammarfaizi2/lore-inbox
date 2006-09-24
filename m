Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751358AbWIXR5o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbWIXR5o (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 13:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbWIXR5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 13:57:44 -0400
Received: from w241.dkm.cz ([62.24.88.241]:40404 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751358AbWIXR5o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 13:57:44 -0400
Date: Sun, 24 Sep 2006 19:57:42 +0200
From: Petr Baudis <pasky@suse.cz>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [RESEND][PATCH] Script for automated historical Git tree grafting
Message-ID: <20060924175542.13734.79434.stgit@machine.or.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This script enables Git users to easily graft the historical Git tree
(Bitkeeper history import) to the current history. It will also record
the appropriate tags in your refs tree as suggested by Marcel Holtmann.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

  Yet another resend, this time with actual difference! :-)

  I have pondered adding support for "local grafting" suggested by
Marcel Holtmann but setting up the tags properly would be impossible
in that case and overally you are much better off just setting manually
alternates and the single line in grafts file.

 scripts/git-gethistory.sh |   47 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/scripts/git-gethistory.sh b/scripts/git-gethistory.sh
new file mode 100755
index 0000000..2f19372
--- /dev/null
+++ b/scripts/git-gethistory.sh
@@ -0,0 +1,47 @@
+#!/bin/sh
+#
+# Graft the development history imported from BitKeeper to the current Git
+# history tree.
+#
+# Note that this will download about 160M.
+
+httpget="curl -O -C -"
+if [ -z "`which curl 2>/dev/null`" ]; then
+	httpget="wget -c"
+	if [ -z "`which wget 2>/dev/null`" ]; then
+		echo "Error: You need to have wget or curl installed so that I can fetch the history." >&2
+		exit 1
+	fi
+fi
+
+[ "$GIT_DIR" ] || GIT_DIR=.git
+if ! [ -d "$GIT_DIR" ]; then
+	echo "Error: You must run this from the project root (or set GIT_DIR to your .git directory)." >&2
+	exit 1
+fi
+cd "$GIT_DIR"
+export GIT_DIR="$(pwd)"
+
+echo "[git-gethistory] Downloading the history"
+mkdir -p objects/pack
+cd objects/pack
+$httpget http://www.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/objects/pack/pack-4d27038611fe7755938efd4a2745d5d5d35de1c1.idx
+$httpget http://www.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/objects/pack/pack-4d27038611fe7755938efd4a2745d5d5d35de1c1.pack
+
+echo "[git-gethistory] Setting up the grafts"
+cd "$GIT_DIR"
+mkdir -p info
+# master
+echo 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 e7e173af42dbf37b1d946f9ee00219cb3b2bea6a >>info/grafts
+
+echo "[git-gethistory] Setting up tag refs"
+cd "$GIT_DIR"
+git-ls-remote http://www.kernel.org/pub/scm/linux/kernel/git/tglx/history.git | \
+	grep refs/tags | grep -v '\^{}$' | \
+	while read obj ref; do
+		git-update-ref "$ref" "$obj"
+	done
+
+echo "[git-gethistory] Refreshing the dumb server info wrt. new packs"
+cd "$GIT_DIR"
+git-update-server-info
