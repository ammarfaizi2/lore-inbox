Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261311AbVESXRy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbVESXRy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 19:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbVESW4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 18:56:35 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48802 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261289AbVESWzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 18:55:45 -0400
To: linux-kernel@vger.kernel.org
Subject: [CFR][PATCH] namei fixes (2/19)
Cc: akpm@osdl.org
Message-Id: <E1DYtw2-0007qi-Vr@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Thu, 19 May 2005 23:56:10 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(2/19)

All callers of do_follow_link() do mntget() right before it and dput()+mntput()
right after.  These calls are moved inside do_follow_link() now.

Obviously equivalent transformation.

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC12-rc4-1/fs/namei.c RC12-rc4-2/fs/namei.c
--- RC12-rc4-1/fs/namei.c	2005-05-19 16:39:29.104704191 -0400
+++ RC12-rc4-2/fs/namei.c	2005-05-19 16:39:30.202485443 -0400
@@ -526,6 +526,7 @@
 static inline int do_follow_link(struct path *path, struct nameidata *nd)
 {
 	int err = -ELOOP;
+	mntget(path->mnt);
 	if (current->link_count >= MAX_NESTED_LINKS)
 		goto loop;
 	if (current->total_link_count >= 40)
@@ -541,9 +542,13 @@
 	err = __do_follow_link(path->dentry, nd);
 	current->link_count--;
 	nd->depth--;
+	dput(path->dentry);
+	mntput(path->mnt);
 	return err;
 loop:
 	path_release(nd);
+	dput(path->dentry);
+	mntput(path->mnt);
 	return err;
 }
 
@@ -783,10 +788,7 @@
 			goto out_dput;
 
 		if (inode->i_op->follow_link) {
-			mntget(next.mnt);
 			err = do_follow_link(&next, nd);
-			dput(next.dentry);
-			mntput(next.mnt);
 			if (err)
 				goto return_err;
 			err = -ENOENT;
@@ -837,10 +839,7 @@
 		inode = next.dentry->d_inode;
 		if ((lookup_flags & LOOKUP_FOLLOW)
 		    && inode && inode->i_op && inode->i_op->follow_link) {
-			mntget(next.mnt);
 			err = do_follow_link(&next, nd);
-			dput(next.dentry);
-			mntput(next.mnt);
 			if (err)
 				goto return_err;
 			inode = nd->dentry->d_inode;
