Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262784AbTI1X2x (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 19:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262787AbTI1X2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 19:28:53 -0400
Received: from hera.cwi.nl ([192.16.191.8]:24814 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S262784AbTI1X2H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 19:28:07 -0400
From: Andries.Brouwer@cwi.nl
Date: Mon, 29 Sep 2003 01:28:04 +0200 (MEST)
Message-Id: <UTC200309282328.h8SNS4J28281.aeb@smtp.cwi.nl>
To: torvalds@osdl.org
Subject: [PATCH] ext3 sparse fixes
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --recursive --new-file -X /linux/dontdiff a/fs/ext3/file.c b/fs/ext3/file.c
--- a/fs/ext3/file.c	Mon Sep 29 01:05:41 2003
+++ b/fs/ext3/file.c	Mon Sep 29 01:10:52 2003
@@ -47,7 +47,7 @@
  * the caller didn't specify O_LARGEFILE.  On 64bit systems we force
  * on this flag in sys_open.
  */
-static int ext3_open_file (struct inode * inode, struct file * filp)
+static int ext3_open_file (struct inode *inode, struct file *filp)
 {
 	if (!(filp->f_flags & O_LARGEFILE) &&
 	    inode->i_size > 0x7FFFFFFFLL)
@@ -56,7 +56,7 @@
 }
 
 static ssize_t
-ext3_file_write(struct kiocb *iocb, const char *buf, size_t count, loff_t pos)
+ext3_file_write(struct kiocb *iocb, const char __user *buf, size_t count, loff_t pos)
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file->f_dentry->d_inode;
@@ -117,8 +117,8 @@
 	.llseek		= generic_file_llseek,
 	.read		= do_sync_read,
 	.write		= do_sync_write,
-	.aio_read		= generic_file_aio_read,
-	.aio_write		= ext3_file_write,
+	.aio_read	= generic_file_aio_read,
+	.aio_write	= ext3_file_write,
 	.readv		= generic_file_readv,
 	.writev		= generic_file_writev,
 	.ioctl		= ext3_ioctl,
diff -u --recursive --new-file -X /linux/dontdiff a/fs/ext3/symlink.c b/fs/ext3/symlink.c
--- a/fs/ext3/symlink.c	Mon Sep 29 01:05:41 2003
+++ b/fs/ext3/symlink.c	Mon Sep 29 01:10:52 2003
@@ -22,7 +22,8 @@
 #include <linux/ext3_fs.h>
 #include "xattr.h"
 
-static int ext3_readlink(struct dentry *dentry, char *buffer, int buflen)
+static int
+ext3_readlink(struct dentry *dentry, char __user *buffer, int buflen)
 {
 	struct ext3_inode_info *ei = EXT3_I(dentry->d_inode);
 	return vfs_readlink(dentry, buffer, buflen, (char*)ei->i_data);
