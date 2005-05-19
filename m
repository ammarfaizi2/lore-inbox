Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261290AbVESW4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261290AbVESW4N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 18:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261302AbVESW4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 18:56:12 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48290 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261290AbVESWzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 18:55:41 -0400
To: linux-kernel@vger.kernel.org
Subject: [CFR][PATCH] namei fixes (1/19)
Cc: akpm@osdl.org
Message-Id: <E1DYtvx-0007qX-UN@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Thu, 19 May 2005 23:56:05 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Note: that will be a long series of very small steps massaging namei.c to
fix too-early-mntput() bugs; I apologize for the length of that animal,
but I *really* want to be extremely careful in that area]

(1/19)

Declaration of struct path moved up.
The first argument of do_follow_link() switched to struct path *; all callers
used to pass foo.dentry there, now they pass &foo instead.

Obviously equivalent transformations.

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC12-rc4-0/fs/namei.c RC12-rc4-1/fs/namei.c
--- RC12-rc4-0/fs/namei.c	2005-05-07 04:04:51.000000000 -0400
+++ RC12-rc4-1/fs/namei.c	2005-05-19 16:39:29.104704191 -0400
@@ -493,6 +493,11 @@
 	return PTR_ERR(link);
 }
 
+struct path {
+	struct vfsmount *mnt;
+	struct dentry *dentry;
+};
+
 static inline int __do_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
 	int error;
@@ -518,7 +523,7 @@
  * Without that kind of total limit, nasty chains of consecutive
  * symlinks can cause almost arbitrarily long lookups. 
  */
-static inline int do_follow_link(struct dentry *dentry, struct nameidata *nd)
+static inline int do_follow_link(struct path *path, struct nameidata *nd)
 {
 	int err = -ELOOP;
 	if (current->link_count >= MAX_NESTED_LINKS)
@@ -527,13 +532,13 @@
 		goto loop;
 	BUG_ON(nd->depth >= MAX_NESTED_LINKS);
 	cond_resched();
-	err = security_inode_follow_link(dentry, nd);
+	err = security_inode_follow_link(path->dentry, nd);
 	if (err)
 		goto loop;
 	current->link_count++;
 	current->total_link_count++;
 	nd->depth++;
-	err = __do_follow_link(dentry, nd);
+	err = __do_follow_link(path->dentry, nd);
 	current->link_count--;
 	nd->depth--;
 	return err;
@@ -641,11 +646,6 @@
 	follow_mount(mnt, dentry);
 }
 
-struct path {
-	struct vfsmount *mnt;
-	struct dentry *dentry;
-};
-
 /*
  *  It's more convoluted than I'd like it to be, but... it's still fairly
  *  small and for now I'd prefer to have fast path as straight as possible.
@@ -784,7 +784,7 @@
 
 		if (inode->i_op->follow_link) {
 			mntget(next.mnt);
-			err = do_follow_link(next.dentry, nd);
+			err = do_follow_link(&next, nd);
 			dput(next.dentry);
 			mntput(next.mnt);
 			if (err)
@@ -838,7 +838,7 @@
 		if ((lookup_flags & LOOKUP_FOLLOW)
 		    && inode && inode->i_op && inode->i_op->follow_link) {
 			mntget(next.mnt);
-			err = do_follow_link(next.dentry, nd);
+			err = do_follow_link(&next, nd);
 			dput(next.dentry);
 			mntput(next.mnt);
 			if (err)
