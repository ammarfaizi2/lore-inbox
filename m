Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750972AbWEEVdh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972AbWEEVdh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 17:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751786AbWEEVdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 17:33:37 -0400
Received: from w241.dkm.cz ([62.24.88.241]:22411 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750972AbWEEVdh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 17:33:37 -0400
Date: Fri, 5 May 2006 23:34:49 +0200
From: Petr Baudis <pasky@suse.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RESEND][PATCH] Script for automated historical Git tree grafting
Message-ID: <20060505213448.GA23221@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This script enables Git users to easily graft the historical Git tree
(Bitkeeper history import) to the current history.

Signed-off-by: Petr Baudis <pasky@suse.cz>

---
 git-gethistory.sh |   40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/scripts/git-gethistory.sh b/scripts/git-gethistory.sh
new file mode 100755
index 0000000..97b3e78
--- /dev/null
+++ b/scripts/git-gethistory.sh
@@ -0,0 +1,39 @@
+#!/bin/sh
+#
+# Graft the development history imported from BitKeeper to the current Git
+# history tree.
+#
+# Note that this will download about 260M.
+
+httpget="curl -O -C -"
+
+if [ -z "`which curl 2>/dev/null`" ]; then
+  httpget="wget -c"
+  if [ -z "`which wget 2>/dev/null`" ]; then
+    echo "Error: You need to have wget or curl installed so that I can fetch the history." >&2
+    exit 1
+  fi
+fi
+
+[ "$GIT_DIR" ] || GIT_DIR=.git
+if ! [ -d "$GIT_DIR" ]; then
+  echo "Error: You must run this from the project root (or set GIT_DIR to your .git directory)." >&2
+  exit 1
+fi
+cd "$GIT_DIR"
+
+echo "[git-gethistory] Downloading the history"
+mkdir -p objects/pack
+cd objects/pack
+$httpget http://www.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/objects/pack/pack-cc3517351ecce3ef7ba010559992bdfc10b7acd4.idx
+$httpget http://www.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/objects/pack/pack-cc3517351ecce3ef7ba010559992bdfc10b7acd4.pack
+
+echo "[git-gethistory] Setting up the grafts"
+cd ../..
+mkdir -p info
+# master
+echo 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 e7e173af42dbf37b1d946f9ee00219cb3b2bea6a >>info/grafts
+
+echo "[git-gethistory] Refreshing the dumb server info wrt. new packs"
+cd ..
+git-update-server-info


-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
