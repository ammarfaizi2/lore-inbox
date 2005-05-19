Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261306AbVESXWU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261306AbVESXWU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 19:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261307AbVESXVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 19:21:41 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56482 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261306AbVESW4l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 18:56:41 -0400
To: linux-kernel@vger.kernel.org
Subject: [CFR][PATCH] namei fixes (13/19)
Cc: akpm@osdl.org
Message-Id: <E1DYtww-0007se-Fn@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Thu, 19 May 2005 23:57:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(13/19)

In open_namei() exit_dput: we have mntput() done in the wrong order -
if nd->mnt != path.mnt we end up doing
	mntput(nd->mnt);
	nd->mnt = path.mnt;
	dput(nd->dentry);
	mntput(nd->mnt);
which drops nd->dentry too late.  Fixed by having path.mnt go first.
That allows to switch O_NOFOLLOW under if (__follow_mount(...)) back
to exit_dput, while we are at it.

Fix for early-mntput() race + equivalent transformation.

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC12-rc4-12/fs/namei.c RC12-rc4-13/fs/namei.c
--- RC12-rc4-12/fs/namei.c	2005-05-19 16:39:41.456242973 -0400
+++ RC12-rc4-13/fs/namei.c	2005-05-19 16:39:42.545026018 -0400
@@ -1501,11 +1501,8 @@
 
 	if (__follow_mount(&path)) {
 		error = -ELOOP;
-		if (flag & O_NOFOLLOW) {
-			dput(path.dentry);
-			mntput(path.mnt);
-			goto exit;
-		}
+		if (flag & O_NOFOLLOW)
+			goto exit_dput;
 	}
 	error = -ENOENT;
 	if (!path.dentry->d_inode)
@@ -1530,8 +1527,7 @@
 exit_dput:
 	dput(path.dentry);
 	if (nd->mnt != path.mnt)
-		mntput(nd->mnt);
-	nd->mnt = path.mnt;
+		mntput(path.mnt);
 exit:
 	path_release(nd);
 	return error;
