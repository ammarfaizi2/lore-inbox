Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129302AbQKHP6T>; Wed, 8 Nov 2000 10:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129298AbQKHP6J>; Wed, 8 Nov 2000 10:58:09 -0500
Received: from 213-123-76-7.btconnect.com ([213.123.76.7]:20102 "EHLO
	saturn.homenet") by vger.kernel.org with ESMTP id <S129132AbQKHP6F>;
	Wed, 8 Nov 2000 10:58:05 -0500
Date: Wed, 8 Nov 2000 15:55:02 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [patch-2.4.0-test11-pre1] a few more BUG()s for vfs_XXX()
Message-ID: <Pine.LNX.4.21.0011081552060.5517-100000@saturn.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I think that the check for inode->i_op == NULL in various
vfs_XXX() functions is bogus, i.e. if it is NULL then it must be a bug in
some filesystem's ->read_inode() method and therefore, instead of
returning error to userspace we should immediately panic, since it is a
kernel bug.

The patch below does just that -- i.e. converts them into BUG()s. This
also has the added advantage that if we are 100% confident in our
filesystems (or kernel in general) we can compile with #define BUG /* */
and get a smaller/faster kernel.

Regards,
Tigran

diff -urN -X dontdiff linux/fs/attr.c BUG/fs/attr.c
--- linux/fs/attr.c	Mon Oct 16 21:00:53 2000
+++ BUG/fs/attr.c	Wed Nov  8 15:43:35 2000
@@ -113,6 +113,9 @@
 	if (!inode)
 		BUG();
 
+	if (!inode->i_op)
+		BUG();
+
 	attr->ia_ctime = now;
 	if (!(ia_valid & ATTR_ATIME_SET))
 		attr->ia_atime = now;
@@ -120,7 +123,7 @@
 		attr->ia_mtime = now;
 
 	lock_kernel();
-	if (inode->i_op && inode->i_op->setattr) 
+	if (inode->i_op->setattr) 
 		error = inode->i_op->setattr(dentry, attr);
 	else {
 		error = inode_change_ok(inode, attr);
diff -urN -X dontdiff linux/fs/namei.c BUG/fs/namei.c
--- linux/fs/namei.c	Fri Sep 22 22:21:18 2000
+++ BUG/fs/namei.c	Wed Nov  8 15:43:10 2000
@@ -156,7 +156,10 @@
 {
 	int mode = inode->i_mode;
 
-	if (inode->i_op && inode->i_op->permission) {
+	if (!inode->i_op)
+		BUG();
+
+	if (inode->i_op->permission) {
 		int retval;
 		lock_kernel();
 		retval = inode->i_op->permission(inode, mask);
@@ -898,13 +901,16 @@
 	mode &= S_IALLUGO & ~current->fs->umask;
 	mode |= S_IFREG;
 
+	if (!dir->i_op)
+		BUG();
+
 	down(&dir->i_zombie);
 	error = may_create(dir, dentry);
 	if (error)
 		goto exit_lock;
 
 	error = -EACCES;	/* shouldn't it be ENOSYS? */
-	if (!dir->i_op || !dir->i_op->create)
+	if (!dir->i_op->create)
 		goto exit_lock;
 
 	DQUOT_INIT(dir);
@@ -1173,6 +1179,9 @@
 {
 	int error = -EPERM;
 
+	if (!dir->i_op)
+		BUG();
+
 	mode &= ~current->fs->umask;
 
 	down(&dir->i_zombie);
@@ -1184,7 +1193,7 @@
 		goto exit_lock;
 
 	error = -EPERM;
-	if (!dir->i_op || !dir->i_op->mknod)
+	if (!dir->i_op->mknod)
 		goto exit_lock;
 
 	DQUOT_INIT(dir);
@@ -1245,13 +1254,16 @@
 {
 	int error;
 
+	if (!dir->i_op)
+		BUG();
+
 	down(&dir->i_zombie);
 	error = may_create(dir, dentry);
 	if (error)
 		goto exit_lock;
 
 	error = -EPERM;
-	if (!dir->i_op || !dir->i_op->mkdir)
+	if (!dir->i_op->mkdir)
 		goto exit_lock;
 
 	DQUOT_INIT(dir);
@@ -1328,12 +1340,15 @@
 int vfs_rmdir(struct inode *dir, struct dentry *dentry)
 {
 	int error;
+ 
+	if (!dir->i_op)
+		BUG();
 
 	error = may_delete(dir, dentry, 1);
 	if (error)
 		return error;
-
-	if (!dir->i_op || !dir->i_op->rmdir)
+ 
+	if (!dir->i_op->rmdir)
 		return -EPERM;
 
 	DQUOT_INIT(dir);
@@ -1404,11 +1419,14 @@
 {
 	int error;
 
+	if (!dir->i_op)
+		BUG();
+
 	down(&dir->i_zombie);
 	error = may_delete(dir, dentry, 0);
 	if (!error) {
 		error = -EPERM;
-		if (dir->i_op && dir->i_op->unlink) {
+		if (dir->i_op->unlink) {
 			DQUOT_INIT(dir);
 			if (d_mountpoint(dentry))
 				error = -EBUSY;
@@ -1474,13 +1492,16 @@
 {
 	int error;
 
+	if (!dir->i_op)
+		BUG();
+
 	down(&dir->i_zombie);
 	error = may_create(dir, dentry);
 	if (error)
 		goto exit_lock;
 
 	error = -EPERM;
-	if (!dir->i_op || !dir->i_op->symlink)
+	if (!dir->i_op->symlink)
 		goto exit_lock;
 
 	DQUOT_INIT(dir);
@@ -1534,6 +1555,9 @@
 	struct inode *inode;
 	int error;
 
+	if (!dir->i_op)
+		BUG();
+
 	down(&dir->i_zombie);
 	error = -ENOENT;
 	inode = old_dentry->d_inode;
@@ -1554,7 +1578,7 @@
 	error = -EPERM;
 	if (IS_APPEND(inode) || IS_IMMUTABLE(inode))
 		goto exit_lock;
-	if (!dir->i_op || !dir->i_op->link)
+	if (!dir->i_op->link)
 		goto exit_lock;
 
 	DQUOT_INIT(dir);
@@ -1658,6 +1682,9 @@
 	if (old_dentry->d_inode == new_dentry->d_inode)
 		return 0;
 
+	if (!old_dir->i_op)
+		BUG();
+
 	error = may_delete(old_dir, old_dentry, 1);
 	if (error)
 		return error;
@@ -1672,7 +1699,7 @@
 	if (error)
 		return error;
 
-	if (!old_dir->i_op || !old_dir->i_op->rename)
+	if (!old_dir->i_op->rename)
 		return -EPERM;
 
 	/*
@@ -1734,6 +1761,9 @@
 	if (old_dentry->d_inode == new_dentry->d_inode)
 		return 0;
 
+	if (!old_dir->i_op)
+		BUG();
+
 	error = may_delete(old_dir, old_dentry, 0);
 	if (error)
 		return error;
@@ -1748,7 +1778,7 @@
 	if (error)
 		return error;
 
-	if (!old_dir->i_op || !old_dir->i_op->rename)
+	if (!old_dir->i_op->rename)
 		return -EPERM;
 
 	DQUOT_INIT(old_dir);

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
