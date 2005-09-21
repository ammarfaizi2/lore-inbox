Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932122AbVIUBZ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbVIUBZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 21:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932111AbVIUBZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 21:25:28 -0400
Received: from sccrmhc14.comcast.net ([204.127.202.59]:62943 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S932102AbVIUBZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 21:25:27 -0400
Date: Tue, 20 Sep 2005 21:25:26 -0400
From: Latchesar Ionkov <lucho@ionkov.net>
To: linux-kernel@vger.kernel.org
Cc: v9fs-developer@lists.sourceforge.net
Subject: [PATCH] v9fs-get-sb-cleanup.patch
Message-ID: <20050921012526.GF2008@ionkov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Latchesar Ionkov <lucho@ionkov.net>

if error occurs while in v9fs_get_sb, some objects are freed twice -- once
in v9fs_get_sb, the second time when v9fs_kill_super is (indirectly
called).

---
commit f3f3a1deaaf88410ab71e9cf806c440d66103fad
tree d2e9deb7d763fc10eba2ef23ff90640f1c21f1f6
parent 0b381cf7efcd34bb6b316baf7ed5d18d402e62f0
author Latchesar Ionkov <lucho@ionkov.net> Tue, 20 Sep 2005 19:33:39 -0400
committer Latchesar Ionkov <lucho@ionkov.net> Tue, 20 Sep 2005 19:33:39 -0400

 fs/9p/vfs_super.c |   24 +++++++-----------------
 1 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -129,8 +129,8 @@ static struct super_block *v9fs_get_sb(s
 
 	if ((newfid = v9fs_session_init(v9ses, dev_name, data)) < 0) {
 		dprintk(DEBUG_ERROR, "problem initiating session\n");
-		retval = newfid;
-		goto free_session;
+		kfree(v9ses);
+		return ERR_PTR(newfid);
 	}
 
 	sb = sget(fs_type, NULL, v9fs_set_super, v9ses);
@@ -150,7 +150,7 @@ static struct super_block *v9fs_get_sb(s
 
 	if (!root) {
 		retval = -ENOMEM;
-		goto release_inode;
+		goto put_back_sb;
 	}
 
 	sb->s_root = root;
@@ -159,7 +159,7 @@ static struct super_block *v9fs_get_sb(s
 	root_fid = v9fs_fid_create(root);
 	if (root_fid == NULL) {
 		retval = -ENOMEM;
-		goto release_dentry;
+		goto put_back_sb;
 	}
 
 	root_fid->fidopen = 0;
@@ -182,25 +182,15 @@ static struct super_block *v9fs_get_sb(s
 
 	if (stat_result < 0) {
 		retval = stat_result;
-		goto release_dentry;
+		goto put_back_sb;
 	}
 
 	return sb;
 
-      release_dentry:
-	dput(sb->s_root);
-
-      release_inode:
-	iput(inode);
-
-      put_back_sb:
+put_back_sb:
+	/* deactivate_super calls v9fs_kill_super which will frees the rest */
 	up_write(&sb->s_umount);
 	deactivate_super(sb);
-	v9fs_session_close(v9ses);
-
-      free_session:
-	kfree(v9ses);
-
 	return ERR_PTR(retval);
 }
 
