Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261489AbVGCSbK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261489AbVGCSbK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 14:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261491AbVGCSbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 14:31:10 -0400
Received: from 238-071.adsl.pool.ew.hu ([193.226.238.71]:45327 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261487AbVGCSaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 14:30:09 -0400
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] FUSE: direct I/O cleanup
Message-Id: <E1Dp9Dx-0005QZ-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sun, 03 Jul 2005 20:29:49 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman suggested using a separate set of file operations
for direct I/O.  This patch implements this cleanup.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

diff -rup linux-2.6.13-rc1-mm1/fs/fuse/file.c linux-fuse/fs/fuse/file.c
--- linux-2.6.13-rc1-mm1/fs/fuse/file.c	2005-07-03 17:51:56.000000000 +0200
+++ linux-fuse/fs/fuse/file.c	2005-07-03 17:57:41.000000000 +0200
@@ -475,44 +475,26 @@ static ssize_t fuse_direct_io(struct fil
 	return res;
 }
 
-static ssize_t fuse_file_read(struct file *file, char __user *buf,
-			      size_t count, loff_t *ppos)
+static ssize_t fuse_direct_read(struct file *file, char __user *buf,
+				     size_t count, loff_t *ppos)
 {
-	struct inode *inode = file->f_dentry->d_inode;
-	struct fuse_conn *fc = get_fuse_conn(inode);
-
-	if (fc->flags & FUSE_DIRECT_IO)
-		return fuse_direct_io(file, buf, count, ppos, 0);
-	else
-		return generic_file_read(file, buf, count, ppos);
+	return fuse_direct_io(file, buf, count, ppos, 0);
 }
 
-static ssize_t fuse_file_write(struct file *file, const char __user *buf,
-			       size_t count, loff_t *ppos)
+static ssize_t fuse_direct_write(struct file *file, const char __user *buf,
+				 size_t count, loff_t *ppos)
 {
 	struct inode *inode = file->f_dentry->d_inode;
-	struct fuse_conn *fc = get_fuse_conn(inode);
-
-	if (fc->flags & FUSE_DIRECT_IO) {
-		ssize_t res;
-		/* Don't allow parallel writes to the same file */
-		down(&inode->i_sem);
-		res = fuse_direct_io(file, buf, count, ppos, 1);
-		up(&inode->i_sem);
-		return res;
-	}
-	else
-		return generic_file_write(file, buf, count, ppos);
+	ssize_t res;
+	/* Don't allow parallel writes to the same file */
+	down(&inode->i_sem);
+	res = fuse_direct_io(file, buf, count, ppos, 1);
+	up(&inode->i_sem);
+	return res;
 }
 
 static int fuse_file_mmap(struct file *file, struct vm_area_struct *vma)
 {
-	struct inode *inode = file->f_dentry->d_inode;
-	struct fuse_conn *fc = get_fuse_conn(inode);
-
-	if (fc->flags & FUSE_DIRECT_IO)
-		return -ENODEV;
-
 	if ((vma->vm_flags & VM_SHARED)) {
 		if ((vma->vm_flags & VM_WRITE))
 			return -ENODEV;
@@ -522,17 +504,6 @@ static int fuse_file_mmap(struct file *f
 	return generic_file_mmap(file, vma);
 }
 
-static ssize_t fuse_file_sendfile(struct file *file, loff_t *ppos,
-				  size_t count, read_actor_t actor,
-				  void *target)
-{
-	struct fuse_conn *fc = get_fuse_conn(file->f_dentry->d_inode);
-	if (fc->flags & FUSE_DIRECT_IO)
-		return -EINVAL;
-	else
-		return generic_file_sendfile(file, ppos, count, actor, target);
-}
-
 static int fuse_set_page_dirty(struct page *page)
 {
 	printk("fuse_set_page_dirty: should not happen\n");
@@ -542,14 +513,25 @@ static int fuse_set_page_dirty(struct pa
 
 static struct file_operations fuse_file_operations = {
 	.llseek		= generic_file_llseek,
-	.read		= fuse_file_read,
-	.write		= fuse_file_write,
+	.read		= generic_file_read,	
+	.write		= generic_file_write,
 	.mmap		= fuse_file_mmap,
 	.open		= fuse_open,
 	.flush		= fuse_flush,
 	.release	= fuse_release,
 	.fsync		= fuse_fsync,
-	.sendfile	= fuse_file_sendfile,
+	.sendfile	= generic_file_sendfile,
+};
+
+static struct file_operations fuse_direct_io_file_operations = {
+	.llseek		= generic_file_llseek,
+	.read		= fuse_direct_read,
+	.write		= fuse_direct_write,
+	.open		= fuse_open,
+	.flush		= fuse_flush,
+	.release	= fuse_release,
+	.fsync		= fuse_fsync,
+	/* no mmap and sendfile */
 };
 
 static struct address_space_operations fuse_file_aops  = {
@@ -562,6 +544,12 @@ static struct address_space_operations f
 
 void fuse_init_file_inode(struct inode *inode)
 {
-	inode->i_fop = &fuse_file_operations;
-	inode->i_data.a_ops = &fuse_file_aops;
+	struct fuse_conn *fc = get_fuse_conn(inode);
+
+	if (fc->flags & FUSE_DIRECT_IO)
+		inode->i_fop = &fuse_direct_io_file_operations;
+	else {
+		inode->i_fop = &fuse_file_operations;
+		inode->i_data.a_ops = &fuse_file_aops;
+	}
 }
