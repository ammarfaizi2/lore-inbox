Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261289AbVESXWT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261289AbVESXWT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 19:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261306AbVESXWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 19:22:10 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55714 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261289AbVESW4f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 18:56:35 -0400
To: linux-kernel@vger.kernel.org
Subject: [CFR][PATCH] namei fixes (12/19)
Cc: akpm@osdl.org
Message-Id: <E1DYtwr-0007sU-Ec@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Thu, 19 May 2005 23:57:01 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(12/19)

In open_namei() we take mntput(nd->mnt);nd->mnt=path.mnt; out of the
if (__follow_mount(...)), making it conditional on nd->mnt != path.mnt
instead.

Then we shift the result downstream.

Equivalent transformations.

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC12-rc4-11/fs/namei.c RC12-rc4-12/fs/namei.c
--- RC12-rc4-11/fs/namei.c	2005-05-19 16:39:40.320469292 -0400
+++ RC12-rc4-12/fs/namei.c	2005-05-19 16:39:41.456242973 -0400
@@ -1506,8 +1506,6 @@
 			mntput(path.mnt);
 			goto exit;
 		}
-		mntput(nd->mnt);
-		nd->mnt = path.mnt;
 	}
 	error = -ENOENT;
 	if (!path.dentry->d_inode)
@@ -1517,6 +1515,9 @@
 
 	dput(nd->dentry);
 	nd->dentry = path.dentry;
+	if (nd->mnt != path.mnt)
+		mntput(nd->mnt);
+	nd->mnt = path.mnt;
 	error = -EISDIR;
 	if (path.dentry->d_inode && S_ISDIR(path.dentry->d_inode->i_mode))
 		goto exit;
@@ -1528,6 +1529,9 @@
 
 exit_dput:
 	dput(path.dentry);
+	if (nd->mnt != path.mnt)
+		mntput(nd->mnt);
+	nd->mnt = path.mnt;
 exit:
 	path_release(nd);
 	return error;
@@ -1550,6 +1554,9 @@
 	error = security_inode_follow_link(path.dentry, nd);
 	if (error)
 		goto exit_dput;
+	if (nd->mnt != path.mnt)
+		mntput(nd->mnt);
+	nd->mnt = path.mnt;
 	error = __do_follow_link(&path, nd);
 	if (error)
 		return error;
