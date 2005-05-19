Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261307AbVESXWV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261307AbVESXWV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 19:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261308AbVESXVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 19:21:30 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56994 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261307AbVESW4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 18:56:45 -0400
To: linux-kernel@vger.kernel.org
Subject: [CFR][PATCH] namei fixes (14/19)
Cc: akpm@osdl.org
Message-Id: <E1DYtx1-0007sp-H6@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Thu, 19 May 2005 23:57:11 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(14/19)

shifted conditional mntput() into do_follow_link() - all callers
were doing the same thing.

Obviously equivalent transformation.

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC12-rc4-13/fs/namei.c RC12-rc4-14/fs/namei.c
--- RC12-rc4-13/fs/namei.c	2005-05-19 16:39:42.545026018 -0400
+++ RC12-rc4-14/fs/namei.c	2005-05-19 16:39:43.660803683 -0400
@@ -543,11 +543,15 @@
 	current->link_count++;
 	current->total_link_count++;
 	nd->depth++;
+	if (path->mnt != nd->mnt)
+		mntput(nd->mnt);
 	err = __do_follow_link(path, nd);
 	current->link_count--;
 	nd->depth--;
 	return err;
 loop:
+	if (path->mnt != nd->mnt)
+		mntput(nd->mnt);
 	dput(path->dentry);
 	path_release(nd);
 	return err;
@@ -801,8 +805,6 @@
 			goto out_dput;
 
 		if (inode->i_op->follow_link) {
-			if (nd->mnt != next.mnt)
-				mntput(nd->mnt);
 			err = do_follow_link(&next, nd);
 			if (err)
 				goto return_err;
@@ -856,8 +858,6 @@
 		inode = next.dentry->d_inode;
 		if ((lookup_flags & LOOKUP_FOLLOW)
 		    && inode && inode->i_op && inode->i_op->follow_link) {
-			if (next.mnt != nd->mnt)
-				mntput(nd->mnt);
 			err = do_follow_link(&next, nd);
 			if (err)
 				goto return_err;
