Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261295AbVESXac@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261295AbVESXac (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 19:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261310AbVESXXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 19:23:13 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54946 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261304AbVESW4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 18:56:30 -0400
To: linux-kernel@vger.kernel.org
Subject: [CFR][PATCH] namei fixes (11/19)
Cc: akpm@osdl.org
Message-Id: <E1DYtwm-0007s7-Bg@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Thu, 19 May 2005 23:56:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(11/19)

shifted conditional mntput() calls in __link_path_walk() downstream.

Obviously equivalent transformation.

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC12-rc4-10/fs/namei.c RC12-rc4-11/fs/namei.c
--- RC12-rc4-10/fs/namei.c	2005-05-19 16:39:39.207691029 -0400
+++ RC12-rc4-11/fs/namei.c	2005-05-19 16:39:40.320469292 -0400
@@ -791,8 +791,6 @@
 			break;
 		/* Check mountpoints.. */
 		__follow_mount(&next);
-		if (nd->mnt != next.mnt)
-			mntput(nd->mnt);
 
 		err = -ENOENT;
 		inode = next.dentry->d_inode;
@@ -803,6 +801,8 @@
 			goto out_dput;
 
 		if (inode->i_op->follow_link) {
+			if (nd->mnt != next.mnt)
+				mntput(nd->mnt);
 			err = do_follow_link(&next, nd);
 			if (err)
 				goto return_err;
@@ -815,6 +815,8 @@
 				break;
 		} else {
 			dput(nd->dentry);
+			if (nd->mnt != next.mnt)
+				mntput(nd->mnt);
 			nd->mnt = next.mnt;
 			nd->dentry = next.dentry;
 		}
@@ -851,17 +853,19 @@
 		if (err)
 			break;
 		__follow_mount(&next);
-		if (nd->mnt != next.mnt)
-			mntput(nd->mnt);
 		inode = next.dentry->d_inode;
 		if ((lookup_flags & LOOKUP_FOLLOW)
 		    && inode && inode->i_op && inode->i_op->follow_link) {
+			if (next.mnt != nd->mnt)
+				mntput(nd->mnt);
 			err = do_follow_link(&next, nd);
 			if (err)
 				goto return_err;
 			inode = nd->dentry->d_inode;
 		} else {
 			dput(nd->dentry);
+			if (nd->mnt != next.mnt)
+				mntput(nd->mnt);
 			nd->mnt = next.mnt;
 			nd->dentry = next.dentry;
 		}
@@ -901,6 +905,8 @@
 		return 0;
 out_dput:
 		dput(next.dentry);
+		if (nd->mnt != next.mnt)
+			mntput(nd->mnt);
 		break;
 	}
 	path_release(nd);
