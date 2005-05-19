Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261309AbVESXWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbVESXWX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 19:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261295AbVESXUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 19:20:55 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58530 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261309AbVESW44 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 18:56:56 -0400
To: linux-kernel@vger.kernel.org
Subject: [CFR][PATCH] namei fixes (16/19)
Cc: akpm@osdl.org
Message-Id: <E1DYtxB-0007tU-Ji@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Thu, 19 May 2005 23:57:21 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(16/19)

Conditional mntput() moved into __do_follow_link().  There it collapses with
unconditional mntget() on the same sucker, closing another too-early-mntput()
race.

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC12-rc4-15/fs/namei.c RC12-rc4-16/fs/namei.c
--- RC12-rc4-15/fs/namei.c	2005-05-19 16:39:44.743587923 -0400
+++ RC12-rc4-16/fs/namei.c	2005-05-19 16:39:45.837369971 -0400
@@ -506,7 +506,8 @@
 	touch_atime(nd->mnt, dentry);
 	nd_set_link(nd, NULL);
 
-	mntget(path->mnt);
+	if (path->mnt == nd->mnt)
+		mntget(path->mnt);
 	error = dentry->d_inode->i_op->follow_link(dentry, nd);
 	if (!error) {
 		char *s = nd_get_link(nd);
@@ -543,8 +544,6 @@
 	current->link_count++;
 	current->total_link_count++;
 	nd->depth++;
-	if (path->mnt != nd->mnt)
-		mntput(path->mnt);
 	err = __do_follow_link(path, nd);
 	current->link_count--;
 	nd->depth--;
@@ -1550,8 +1549,6 @@
 	error = security_inode_follow_link(path.dentry, nd);
 	if (error)
 		goto exit_dput;
-	if (nd->mnt != path.mnt)
-		mntput(path.mnt);
 	error = __do_follow_link(&path, nd);
 	if (error)
 		return error;
