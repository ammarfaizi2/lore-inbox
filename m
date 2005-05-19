Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261296AbVESW6Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbVESW6Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 18:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261314AbVESW5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 18:57:14 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49314 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261296AbVESWzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 18:55:50 -0400
To: linux-kernel@vger.kernel.org
Subject: [CFR][PATCH] namei fixes (3/19)
Cc: akpm@osdl.org
Message-Id: <E1DYtw8-0007qq-0p@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Thu, 19 May 2005 23:56:16 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(3/19)

Replaced struct dentry *dentry in namei with struct path path.  All uses of
dentry replaced with path.dentry there.

Obviously equivalent transformation.

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC12-rc4-2/fs/namei.c RC12-rc4-3/fs/namei.c
--- RC12-rc4-2/fs/namei.c	2005-05-19 16:39:30.202485443 -0400
+++ RC12-rc4-3/fs/namei.c	2005-05-19 16:39:31.314263905 -0400
@@ -1397,7 +1397,7 @@
 int open_namei(const char * pathname, int flag, int mode, struct nameidata *nd)
 {
 	int acc_mode, error = 0;
-	struct dentry *dentry;
+	struct path path;
 	struct dentry *dir;
 	int count = 0;
 
@@ -1441,23 +1441,23 @@
 	dir = nd->dentry;
 	nd->flags &= ~LOOKUP_PARENT;
 	down(&dir->d_inode->i_sem);
-	dentry = __lookup_hash(&nd->last, nd->dentry, nd);
+	path.dentry = __lookup_hash(&nd->last, nd->dentry, nd);
 
 do_last:
-	error = PTR_ERR(dentry);
-	if (IS_ERR(dentry)) {
+	error = PTR_ERR(path.dentry);
+	if (IS_ERR(path.dentry)) {
 		up(&dir->d_inode->i_sem);
 		goto exit;
 	}
 
 	/* Negative dentry, just create the file */
-	if (!dentry->d_inode) {
+	if (!path.dentry->d_inode) {
 		if (!IS_POSIXACL(dir->d_inode))
 			mode &= ~current->fs->umask;
-		error = vfs_create(dir->d_inode, dentry, mode, nd);
+		error = vfs_create(dir->d_inode, path.dentry, mode, nd);
 		up(&dir->d_inode->i_sem);
 		dput(nd->dentry);
-		nd->dentry = dentry;
+		nd->dentry = path.dentry;
 		if (error)
 			goto exit;
 		/* Don't check for write permission, don't truncate */
@@ -1475,22 +1475,22 @@
 	if (flag & O_EXCL)
 		goto exit_dput;
 
-	if (d_mountpoint(dentry)) {
+	if (d_mountpoint(path.dentry)) {
 		error = -ELOOP;
 		if (flag & O_NOFOLLOW)
 			goto exit_dput;
-		while (__follow_down(&nd->mnt,&dentry) && d_mountpoint(dentry));
+		while (__follow_down(&nd->mnt,&path.dentry) && d_mountpoint(path.dentry));
 	}
 	error = -ENOENT;
-	if (!dentry->d_inode)
+	if (!path.dentry->d_inode)
 		goto exit_dput;
-	if (dentry->d_inode->i_op && dentry->d_inode->i_op->follow_link)
+	if (path.dentry->d_inode->i_op && path.dentry->d_inode->i_op->follow_link)
 		goto do_link;
 
 	dput(nd->dentry);
-	nd->dentry = dentry;
+	nd->dentry = path.dentry;
 	error = -EISDIR;
-	if (dentry->d_inode && S_ISDIR(dentry->d_inode->i_mode))
+	if (path.dentry->d_inode && S_ISDIR(path.dentry->d_inode->i_mode))
 		goto exit;
 ok:
 	error = may_open(nd, acc_mode, flag);
@@ -1499,7 +1499,7 @@
 	return 0;
 
 exit_dput:
-	dput(dentry);
+	dput(path.dentry);
 exit:
 	path_release(nd);
 	return error;
@@ -1519,16 +1519,16 @@
 	 * are done. Procfs-like symlinks just set LAST_BIND.
 	 */
 	nd->flags |= LOOKUP_PARENT;
-	error = security_inode_follow_link(dentry, nd);
+	error = security_inode_follow_link(path.dentry, nd);
 	if (error)
 		goto exit_dput;
-	error = __do_follow_link(dentry, nd);
-	dput(dentry);
+	error = __do_follow_link(path.dentry, nd);
+	dput(path.dentry);
 	if (error)
 		return error;
 	nd->flags &= ~LOOKUP_PARENT;
 	if (nd->last_type == LAST_BIND) {
-		dentry = nd->dentry;
+		path.dentry = nd->dentry;
 		goto ok;
 	}
 	error = -EISDIR;
@@ -1545,7 +1545,7 @@
 	}
 	dir = nd->dentry;
 	down(&dir->d_inode->i_sem);
-	dentry = __lookup_hash(&nd->last, nd->dentry, nd);
+	path.dentry = __lookup_hash(&nd->last, nd->dentry, nd);
 	putname(nd->last.name);
 	goto do_last;
 }
