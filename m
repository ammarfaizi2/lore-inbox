Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261301AbVESW6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261301AbVESW6N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 18:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbVESW5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 18:57:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51874 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261301AbVESW4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 18:56:10 -0400
To: linux-kernel@vger.kernel.org
Subject: [CFR][PATCH] namei fixes (7/19)
Cc: akpm@osdl.org
Message-Id: <E1DYtwS-0007rX-6Y@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Thu, 19 May 2005 23:56:36 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(7/19)

The first argument of __do_follow_link() switched to struct path *
(__do_follow_link(path->dentry, ...) -> __do_follow_link(path, ...)).

All callers have the same calls of mntget() right before and dput()/mntput()
right after __do_follow_link(); these calls have been moved inside.

Obviously equivalent transformations.

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC12-rc4-6/fs/namei.c RC12-rc4-7/fs/namei.c
--- RC12-rc4-6/fs/namei.c	2005-05-19 16:39:34.668595507 -0400
+++ RC12-rc4-7/fs/namei.c	2005-05-19 16:39:35.831363809 -0400
@@ -498,12 +498,15 @@
 	struct dentry *dentry;
 };
 
-static inline int __do_follow_link(struct dentry *dentry, struct nameidata *nd)
+static inline int __do_follow_link(struct path *path, struct nameidata *nd)
 {
 	int error;
+	struct dentry *dentry = path->dentry;
 
 	touch_atime(nd->mnt, dentry);
 	nd_set_link(nd, NULL);
+
+	mntget(path->mnt);
 	error = dentry->d_inode->i_op->follow_link(dentry, nd);
 	if (!error) {
 		char *s = nd_get_link(nd);
@@ -512,6 +515,8 @@
 		if (dentry->d_inode->i_op->put_link)
 			dentry->d_inode->i_op->put_link(dentry, nd);
 	}
+	dput(dentry);
+	mntput(path->mnt);
 
 	return error;
 }
@@ -538,10 +543,7 @@
 	current->link_count++;
 	current->total_link_count++;
 	nd->depth++;
-	mntget(path->mnt);
-	err = __do_follow_link(path->dentry, nd);
-	dput(path->dentry);
-	mntput(path->mnt);
+	err = __do_follow_link(path, nd);
 	current->link_count--;
 	nd->depth--;
 	return err;
@@ -1523,10 +1525,7 @@
 	error = security_inode_follow_link(path.dentry, nd);
 	if (error)
 		goto exit_dput;
-	mntget(path.mnt);
-	error = __do_follow_link(path.dentry, nd);
-	dput(path.dentry);
-	mntput(path.mnt);
+	error = __do_follow_link(&path, nd);
 	path.mnt = nd->mnt;
 	if (error)
 		return error;
