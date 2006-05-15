Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965255AbWEOVWR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965255AbWEOVWR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 17:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965245AbWEOVWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 17:22:16 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:8094 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S965255AbWEOVWL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 17:22:11 -0400
Subject: [PATCH 4/4] Streamline generic_file_* interfaces and filemap
	cleanups
From: Badari Pulavarty <pbadari@us.ibm.com>
To: akpm@osdl.org
Cc: christoph <hch@lst.de>, Benjamin LaHaise <bcrl@kvack.org>,
       cel@citi.umich.edu, Zach Brown <zach.brown@oracle.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1147727945.20568.53.camel@dyn9047017100.beaverton.ibm.com>
References: <1146582438.8373.7.camel@dyn9047017100.beaverton.ibm.com>
	 <1147197826.27056.4.camel@dyn9047017100.beaverton.ibm.com>
	 <1147361890.12117.11.camel@dyn9047017100.beaverton.ibm.com>
	 <1147727945.20568.53.camel@dyn9047017100.beaverton.ibm.com>
Content-Type: text/plain
Date: Mon, 15 May 2006 14:23:26 -0700
Message-Id: <1147728206.6181.7.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch cleans up generic_file_*_read/write() interfaces.
Christoph Hellwig gave me the idea for this clean ups.

In a nutshell, all filesystems should set .aio_read/.aio_write
methods and use do_sync_read/ do_sync_write() as their .read/.write 
methods. This allows us to cleanup all variants of generic_file_*
routines.

Final available interfaces:

generic_file_aio_read() - read handler
generic_file_aio_write() - write handler
generic_file_aio_write_nolock() - no lock write handler

__generic_file_aio_write_nolock() - internal worker routine 


Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>

 drivers/char/raw.c         |   15 +------
 fs/adfs/file.c             |    6 ++-
 fs/affs/file.c             |    6 ++-
 fs/bfs/file.c              |    6 ++-
 fs/block_dev.c             |   12 +-----
 fs/ext2/file.c             |    4 +-
 fs/fuse/file.c             |    6 ++-
 fs/hfs/inode.c             |    6 ++-
 fs/hfsplus/inode.c         |    6 ++-
 fs/hostfs/hostfs_kern.c    |    4 +-
 fs/hpfs/file.c             |    6 ++-
 fs/jffs/inode-v23.c        |    6 ++-
 fs/jffs2/file.c            |    6 ++-
 fs/jfs/file.c              |    4 +-
 fs/minix/file.c            |    6 ++-
 fs/ntfs/file.c             |    2 -
 fs/qnx4/file.c             |    6 ++-
 fs/ramfs/file-mmu.c        |    6 ++-
 fs/ramfs/file-nommu.c      |    6 ++-
 fs/read_write.c            |    3 +
 fs/smbfs/file.c            |   24 +++++++-----
 fs/sysv/file.c             |    6 ++-
 fs/udf/file.c              |   16 +++++---
 fs/ufs/file.c              |    6 ++-
 fs/xfs/linux-2.6/xfs_lrw.c |    4 +-
 include/linux/fs.h         |    5 --
 mm/filemap.c               |   88 ++-------------------------------------------
 27 files changed, 105 insertions(+), 166 deletions(-)

Index: linux-2.6.17-rc4/drivers/char/raw.c
===================================================================
--- linux-2.6.17-rc4.orig/drivers/char/raw.c	2006-05-15 14:14:00.570624056 -0700
+++ linux-2.6.17-rc4/drivers/char/raw.c	2006-05-15 14:14:12.642788808 -0700
@@ -239,21 +239,10 @@ out:
 	return err;
 }
 
-static ssize_t raw_file_write(struct file *file, const char __user *buf,
-				   size_t count, loff_t *ppos)
-{
-	struct iovec local_iov = {
-		.iov_base = (char __user *)buf,
-		.iov_len = count
-	};
-
-	return generic_file_write_nolock(file, &local_iov, 1, ppos);
-}
-
 static struct file_operations raw_fops = {
-	.read	=	generic_file_read,
+	.read	=	do_sync_read,
 	.aio_read = 	generic_file_aio_read,
-	.write	=	raw_file_write,
+	.write	=	do_sync_write,
 	.aio_write = 	generic_file_aio_write_nolock,
 	.open	=	raw_open,
 	.release=	raw_release,
Index: linux-2.6.17-rc4/fs/adfs/file.c
===================================================================
--- linux-2.6.17-rc4.orig/fs/adfs/file.c	2006-05-15 14:09:43.030776064 -0700
+++ linux-2.6.17-rc4/fs/adfs/file.c	2006-05-15 14:14:12.642788808 -0700
@@ -27,10 +27,12 @@
 
 const struct file_operations adfs_file_operations = {
 	.llseek		= generic_file_llseek,
-	.read		= generic_file_read,
+	.read		= do_sync_read,
+	.aio_read	= generic_file_aio_read,
 	.mmap		= generic_file_mmap,
 	.fsync		= file_fsync,
-	.write		= generic_file_write,
+	.write		= do_sync_write,
+	.aio_write	= generic_file_aio_write,
 	.sendfile	= generic_file_sendfile,
 };
 
Index: linux-2.6.17-rc4/fs/affs/file.c
===================================================================
--- linux-2.6.17-rc4.orig/fs/affs/file.c	2006-05-15 14:09:43.031775912 -0700
+++ linux-2.6.17-rc4/fs/affs/file.c	2006-05-15 14:14:12.644788504 -0700
@@ -27,8 +27,10 @@ static int affs_file_release(struct inod
 
 const struct file_operations affs_file_operations = {
 	.llseek		= generic_file_llseek,
-	.read		= generic_file_read,
-	.write		= generic_file_write,
+	.read		= do_sync_read,
+	.aio_read	= generic_file_aio_read,
+	.write		= do_sync_write,
+	.aio_write	= generic_file_aio_write,
 	.mmap		= generic_file_mmap,
 	.open		= affs_file_open,
 	.release	= affs_file_release,
Index: linux-2.6.17-rc4/fs/bfs/file.c
===================================================================
--- linux-2.6.17-rc4.orig/fs/bfs/file.c	2006-05-15 14:09:43.028776368 -0700
+++ linux-2.6.17-rc4/fs/bfs/file.c	2006-05-15 14:14:12.644788504 -0700
@@ -19,8 +19,10 @@
 
 const struct file_operations bfs_file_operations = {
 	.llseek 	= generic_file_llseek,
-	.read		= generic_file_read,
-	.write		= generic_file_write,
+	.read		= do_sync_read,
+	.aio_read	= generic_file_aio_read,
+	.write		= do_sync_write,
+	.aio_write	= generic_file_aio_write,
 	.mmap		= generic_file_mmap,
 	.sendfile	= generic_file_sendfile,
 };
Index: linux-2.6.17-rc4/fs/block_dev.c
===================================================================
--- linux-2.6.17-rc4.orig/fs/block_dev.c	2006-05-15 14:14:00.574623448 -0700
+++ linux-2.6.17-rc4/fs/block_dev.c	2006-05-15 14:14:12.645788352 -0700
@@ -1056,14 +1056,6 @@ static int blkdev_close(struct inode * i
 	return blkdev_put(bdev);
 }
 
-static ssize_t blkdev_file_write(struct file *file, const char __user *buf,
-				   size_t count, loff_t *ppos)
-{
-	struct iovec local_iov = { .iov_base = (void __user *)buf, .iov_len = count };
-
-	return generic_file_write_nolock(file, &local_iov, 1, ppos);
-}
-
 static long block_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 {
 	return blkdev_ioctl(file->f_mapping->host, file, cmd, arg);
@@ -1083,8 +1075,8 @@ const struct file_operations def_blk_fop
 	.open		= blkdev_open,
 	.release	= blkdev_close,
 	.llseek		= block_llseek,
-	.read		= generic_file_read,
-	.write		= blkdev_file_write,
+	.read		= do_sync_read,
+	.write		= do_sync_write,
   	.aio_read	= generic_file_aio_read,
   	.aio_write	= generic_file_aio_write_nolock,
 	.mmap		= generic_file_mmap,
Index: linux-2.6.17-rc4/fs/ext2/file.c
===================================================================
--- linux-2.6.17-rc4.orig/fs/ext2/file.c	2006-05-15 14:14:00.577622992 -0700
+++ linux-2.6.17-rc4/fs/ext2/file.c	2006-05-15 14:14:12.646788200 -0700
@@ -41,8 +41,8 @@ static int ext2_release_file (struct ino
  */
 const struct file_operations ext2_file_operations = {
 	.llseek		= generic_file_llseek,
-	.read		= generic_file_read,
-	.write		= generic_file_write,
+	.read		= do_sync_read,
+	.write		= do_sync_write,
 	.aio_read	= generic_file_aio_read,
 	.aio_write	= generic_file_aio_write,
 	.ioctl		= ext2_ioctl,
Index: linux-2.6.17-rc4/fs/fuse/file.c
===================================================================
--- linux-2.6.17-rc4.orig/fs/fuse/file.c	2006-05-15 14:09:43.031775912 -0700
+++ linux-2.6.17-rc4/fs/fuse/file.c	2006-05-15 14:14:12.646788200 -0700
@@ -621,8 +621,10 @@ static int fuse_set_page_dirty(struct pa
 
 static const struct file_operations fuse_file_operations = {
 	.llseek		= generic_file_llseek,
-	.read		= generic_file_read,
-	.write		= generic_file_write,
+	.read		= do_sync_read,
+	.aio_read	= generic_file_aio_read,
+	.write		= do_sync_write,
+	.aio_write	= generic_file_aio_write,
 	.mmap		= fuse_file_mmap,
 	.open		= fuse_open,
 	.flush		= fuse_flush,
Index: linux-2.6.17-rc4/fs/hfs/inode.c
===================================================================
--- linux-2.6.17-rc4.orig/fs/hfs/inode.c	2006-05-15 14:09:43.028776368 -0700
+++ linux-2.6.17-rc4/fs/hfs/inode.c	2006-05-15 14:14:12.647788048 -0700
@@ -603,8 +603,10 @@ int hfs_inode_setattr(struct dentry *den
 
 static const struct file_operations hfs_file_operations = {
 	.llseek		= generic_file_llseek,
-	.read		= generic_file_read,
-	.write		= generic_file_write,
+	.read		= do_sync_read,
+	.aio_read	= generic_file_aio_read,
+	.write		= do_sync_write,
+	.aio_write	= generic_file_aio_write,
 	.mmap		= generic_file_mmap,
 	.sendfile	= generic_file_sendfile,
 	.fsync		= file_fsync,
Index: linux-2.6.17-rc4/fs/hfsplus/inode.c
===================================================================
--- linux-2.6.17-rc4.orig/fs/hfsplus/inode.c	2006-05-15 14:09:43.036775152 -0700
+++ linux-2.6.17-rc4/fs/hfsplus/inode.c	2006-05-15 14:14:12.648787896 -0700
@@ -282,8 +282,10 @@ static struct inode_operations hfsplus_f
 
 static const struct file_operations hfsplus_file_operations = {
 	.llseek 	= generic_file_llseek,
-	.read		= generic_file_read,
-	.write		= generic_file_write,
+	.read		= do_sync_read,
+	.aio_read	= generic_file_aio_read,
+	.write		= do_sync_write,
+	.aio_write	= generic_file_aio_write,
 	.mmap		= generic_file_mmap,
 	.sendfile	= generic_file_sendfile,
 	.fsync		= file_fsync,
Index: linux-2.6.17-rc4/fs/hostfs/hostfs_kern.c
===================================================================
--- linux-2.6.17-rc4.orig/fs/hostfs/hostfs_kern.c	2006-05-15 14:14:00.580622536 -0700
+++ linux-2.6.17-rc4/fs/hostfs/hostfs_kern.c	2006-05-15 14:14:12.649787744 -0700
@@ -386,11 +386,11 @@ int hostfs_fsync(struct file *file, stru
 
 static const struct file_operations hostfs_file_fops = {
 	.llseek		= generic_file_llseek,
-	.read		= generic_file_read,
+	.read		= do_sync_read,
 	.sendfile	= generic_file_sendfile,
 	.aio_read	= generic_file_aio_read,
 	.aio_write	= generic_file_aio_write,
-	.write		= generic_file_write,
+	.write		= do_sync_write,
 	.mmap		= generic_file_mmap,
 	.open		= hostfs_file_open,
 	.release	= NULL,
Index: linux-2.6.17-rc4/fs/hpfs/file.c
===================================================================
--- linux-2.6.17-rc4.orig/fs/hpfs/file.c	2006-05-15 14:09:43.032775760 -0700
+++ linux-2.6.17-rc4/fs/hpfs/file.c	2006-05-15 14:14:12.649787744 -0700
@@ -113,7 +113,7 @@ static ssize_t hpfs_file_write(struct fi
 {
 	ssize_t retval;
 
-	retval = generic_file_write(file, buf, count, ppos);
+	retval = do_sync_write(file, buf, count, ppos);
 	if (retval > 0)
 		hpfs_i(file->f_dentry->d_inode)->i_dirty = 1;
 	return retval;
@@ -122,8 +122,10 @@ static ssize_t hpfs_file_write(struct fi
 const struct file_operations hpfs_file_ops =
 {
 	.llseek		= generic_file_llseek,
-	.read		= generic_file_read,
+	.read		= do_sync_read,
+	.aio_read	= generic_file_aio_read,
 	.write		= hpfs_file_write,
+	.aio_write	= generic_file_aio_write,
 	.mmap		= generic_file_mmap,
 	.release	= hpfs_file_release,
 	.fsync		= hpfs_file_fsync,
Index: linux-2.6.17-rc4/fs/jffs/inode-v23.c
===================================================================
--- linux-2.6.17-rc4.orig/fs/jffs/inode-v23.c	2006-05-15 14:09:43.032775760 -0700
+++ linux-2.6.17-rc4/fs/jffs/inode-v23.c	2006-05-15 14:14:12.651787440 -0700
@@ -1633,8 +1633,10 @@ static const struct file_operations jffs
 {
 	.open		= generic_file_open,
 	.llseek		= generic_file_llseek,
-	.read		= generic_file_read,
-	.write		= generic_file_write,
+	.read		= do_sync_read,
+	.aio_read	= generic_file_aio_read,
+	.write		= do_sync_write,
+	.aio_write	= generic_file_aio_write,
 	.ioctl		= jffs_ioctl,
 	.mmap		= generic_file_readonly_mmap,
 	.fsync		= jffs_fsync,
Index: linux-2.6.17-rc4/fs/jffs2/file.c
===================================================================
--- linux-2.6.17-rc4.orig/fs/jffs2/file.c	2006-05-15 14:09:43.034775456 -0700
+++ linux-2.6.17-rc4/fs/jffs2/file.c	2006-05-15 14:14:12.652787288 -0700
@@ -42,8 +42,10 @@ const struct file_operations jffs2_file_
 {
 	.llseek =	generic_file_llseek,
 	.open =		generic_file_open,
-	.read =		generic_file_read,
-	.write =	generic_file_write,
+	.read =		do_sync_read,
+	.aio_read =	generic_file_aio_read,
+	.write =	do_sync_write,
+	.aio_write =	generic_file_aio_write,
 	.ioctl =	jffs2_ioctl,
 	.mmap =		generic_file_readonly_mmap,
 	.fsync =	jffs2_fsync,
Index: linux-2.6.17-rc4/fs/jfs/file.c
===================================================================
--- linux-2.6.17-rc4.orig/fs/jfs/file.c	2006-05-15 14:14:00.580622536 -0700
+++ linux-2.6.17-rc4/fs/jfs/file.c	2006-05-15 14:14:12.652787288 -0700
@@ -103,8 +103,8 @@ struct inode_operations jfs_file_inode_o
 const struct file_operations jfs_file_operations = {
 	.open		= jfs_open,
 	.llseek		= generic_file_llseek,
-	.write		= generic_file_write,
-	.read		= generic_file_read,
+	.write		= do_sync_write,
+	.read		= do_sync_read,
 	.aio_read	= generic_file_aio_read,
 	.aio_write	= generic_file_aio_write,
 	.mmap		= generic_file_mmap,
Index: linux-2.6.17-rc4/fs/minix/file.c
===================================================================
--- linux-2.6.17-rc4.orig/fs/minix/file.c	2006-05-15 14:09:43.034775456 -0700
+++ linux-2.6.17-rc4/fs/minix/file.c	2006-05-15 14:14:12.653787136 -0700
@@ -17,8 +17,10 @@ int minix_sync_file(struct file *, struc
 
 const struct file_operations minix_file_operations = {
 	.llseek		= generic_file_llseek,
-	.read		= generic_file_read,
-	.write		= generic_file_write,
+	.read		= do_sync_read,
+	.aio_read	= generic_file_aio_read,
+	.write		= do_sync_write,
+	.aio_write	= generic_file_aio_write,
 	.mmap		= generic_file_mmap,
 	.fsync		= minix_sync_file,
 	.sendfile	= generic_file_sendfile,
Index: linux-2.6.17-rc4/fs/ntfs/file.c
===================================================================
--- linux-2.6.17-rc4.orig/fs/ntfs/file.c	2006-05-15 14:14:00.582622232 -0700
+++ linux-2.6.17-rc4/fs/ntfs/file.c	2006-05-15 14:14:12.654786984 -0700
@@ -2294,7 +2294,7 @@ static int ntfs_file_fsync(struct file *
 
 const struct file_operations ntfs_file_ops = {
 	.llseek		= generic_file_llseek,	 /* Seek inside file. */
-	.read		= generic_file_read,	 /* Read from file. */
+	.read		= do_sync_read,		 /* Read from file. */
 	.aio_read	= generic_file_aio_read, /* Async read from file. */
 #ifdef NTFS_RW
 	.write		= ntfs_file_write,	 /* Write to file. */
Index: linux-2.6.17-rc4/fs/qnx4/file.c
===================================================================
--- linux-2.6.17-rc4.orig/fs/qnx4/file.c	2006-05-15 14:09:43.033775608 -0700
+++ linux-2.6.17-rc4/fs/qnx4/file.c	2006-05-15 14:14:12.655786832 -0700
@@ -22,11 +22,13 @@
 const struct file_operations qnx4_file_operations =
 {
 	.llseek		= generic_file_llseek,
-	.read		= generic_file_read,
+	.read		= do_sync_read,
+	.aio_read	= generic_file_aio_read,
 	.mmap		= generic_file_mmap,
 	.sendfile	= generic_file_sendfile,
 #ifdef CONFIG_QNX4FS_RW
-	.write		= generic_file_write,
+	.write		= do_sync_write,
+	.aio_write	= generic_file_aio_write,
 	.fsync		= qnx4_sync_file,
 #endif
 };
Index: linux-2.6.17-rc4/fs/ramfs/file-mmu.c
===================================================================
--- linux-2.6.17-rc4.orig/fs/ramfs/file-mmu.c	2006-05-15 14:09:43.035775304 -0700
+++ linux-2.6.17-rc4/fs/ramfs/file-mmu.c	2006-05-15 14:14:12.655786832 -0700
@@ -33,8 +33,10 @@ struct address_space_operations ramfs_ao
 };
 
 const struct file_operations ramfs_file_operations = {
-	.read		= generic_file_read,
-	.write		= generic_file_write,
+	.read		= do_sync_read,
+	.aio_read	= generic_file_aio_read,
+	.write		= do_sync_write,
+	.aio_write	= generic_file_aio_write,
 	.mmap		= generic_file_mmap,
 	.fsync		= simple_sync_file,
 	.sendfile	= generic_file_sendfile,
Index: linux-2.6.17-rc4/fs/ramfs/file-nommu.c
===================================================================
--- linux-2.6.17-rc4.orig/fs/ramfs/file-nommu.c	2006-05-15 14:09:43.035775304 -0700
+++ linux-2.6.17-rc4/fs/ramfs/file-nommu.c	2006-05-15 14:14:12.656786680 -0700
@@ -36,8 +36,10 @@ struct address_space_operations ramfs_ao
 const struct file_operations ramfs_file_operations = {
 	.mmap			= ramfs_nommu_mmap,
 	.get_unmapped_area	= ramfs_nommu_get_unmapped_area,
-	.read			= generic_file_read,
-	.write			= generic_file_write,
+	.read			= do_sync_read,
+	.aio_read		= generic_file_aio_read,
+	.write			= do_sync_write,
+	.aio_write		= generic_file_aio_write,
 	.fsync			= simple_sync_file,
 	.sendfile		= generic_file_sendfile,
 	.llseek			= generic_file_llseek,
Index: linux-2.6.17-rc4/fs/read_write.c
===================================================================
--- linux-2.6.17-rc4.orig/fs/read_write.c	2006-05-15 14:14:02.693301360 -0700
+++ linux-2.6.17-rc4/fs/read_write.c	2006-05-15 14:14:12.657786528 -0700
@@ -22,7 +22,8 @@
 
 const struct file_operations generic_ro_fops = {
 	.llseek		= generic_file_llseek,
-	.read		= generic_file_read,
+	.read		= do_sync_read,
+	.aio_read	= generic_file_aio_read,
 	.mmap		= generic_file_readonly_mmap,
 	.sendfile	= generic_file_sendfile,
 };
Index: linux-2.6.17-rc4/include/linux/fs.h
===================================================================
--- linux-2.6.17-rc4.orig/include/linux/fs.h	2006-05-15 14:14:02.695301056 -0700
+++ linux-2.6.17-rc4/include/linux/fs.h	2006-05-15 14:14:12.658786376 -0700
@@ -1594,11 +1594,8 @@ extern int generic_file_mmap(struct file
 extern int generic_file_readonly_mmap(struct file *, struct vm_area_struct *);
 extern int file_read_actor(read_descriptor_t * desc, struct page *page, unsigned long offset, unsigned long size);
 extern int file_send_actor(read_descriptor_t * desc, struct page *page, unsigned long offset, unsigned long size);
-extern ssize_t generic_file_read(struct file *, char __user *, size_t, loff_t *);
 int generic_write_checks(struct file *file, loff_t *pos, size_t *count, int isblk);
-extern ssize_t generic_file_write(struct file *, const char __user *, size_t, loff_t *);
 extern ssize_t generic_file_aio_read(struct kiocb *, const struct iovec *, unsigned long, loff_t);
-extern ssize_t __generic_file_aio_read(struct kiocb *, const struct iovec *, unsigned long, loff_t *);
 extern ssize_t generic_file_aio_write(struct kiocb *, const struct iovec *, unsigned long, loff_t);
 extern ssize_t generic_file_aio_write_nolock(struct kiocb *, const struct iovec *,
 		unsigned long, loff_t);
@@ -1608,8 +1605,6 @@ extern ssize_t generic_file_buffered_wri
 		unsigned long, loff_t, loff_t *, size_t, ssize_t);
 extern ssize_t do_sync_read(struct file *filp, char __user *buf, size_t len, loff_t *ppos);
 extern ssize_t do_sync_write(struct file *filp, const char __user *buf, size_t len, loff_t *ppos);
-ssize_t generic_file_write_nolock(struct file *file, const struct iovec *iov,
-				unsigned long nr_segs, loff_t *ppos);
 extern ssize_t generic_file_sendfile(struct file *, loff_t *, size_t, read_actor_t, void *);
 extern void do_generic_mapping_read(struct address_space *mapping,
 				    struct file_ra_state *, struct file *,
Index: linux-2.6.17-rc4/mm/filemap.c
===================================================================
--- linux-2.6.17-rc4.orig/mm/filemap.c	2006-05-15 14:14:00.589621168 -0700
+++ linux-2.6.17-rc4/mm/filemap.c	2006-05-15 14:14:12.660786072 -0700
@@ -1050,13 +1050,14 @@ success:
  * that can use the page cache directly.
  */
 ssize_t
-__generic_file_aio_read(struct kiocb *iocb, const struct iovec *iov,
-		unsigned long nr_segs, loff_t *ppos)
+generic_file_aio_read(struct kiocb *iocb, const struct iovec *iov,
+		unsigned long nr_segs, loff_t pos)
 {
 	struct file *filp = iocb->ki_filp;
 	ssize_t retval;
 	unsigned long seg;
 	size_t count;
+	loff_t *ppos = &iocb->ki_pos;
 
 	count = 0;
 	for (seg = 0; seg < nr_segs; seg++) {
@@ -1080,7 +1081,7 @@ __generic_file_aio_read(struct kiocb *io
 
 	/* coalesce the iovecs and go direct-to-BIO for O_DIRECT */
 	if (filp->f_flags & O_DIRECT) {
-		loff_t pos = *ppos, size;
+		loff_t size;
 		struct address_space *mapping;
 		struct inode *inode;
 
@@ -1125,33 +1126,8 @@ out:
 	return retval;
 }
 
-EXPORT_SYMBOL(__generic_file_aio_read);
-
-ssize_t
-generic_file_aio_read(struct kiocb *iocb, const struct iovec *iov,
-		unsigned long nr_segs, loff_t pos)
-{
-	BUG_ON(iocb->ki_pos != pos);
-	return __generic_file_aio_read(iocb, iov, nr_segs, &iocb->ki_pos);
-}
 EXPORT_SYMBOL(generic_file_aio_read);
 
-ssize_t
-generic_file_read(struct file *filp, char __user *buf, size_t count, loff_t *ppos)
-{
-	struct iovec local_iov = { .iov_base = buf, .iov_len = count };
-	struct kiocb kiocb;
-	ssize_t ret;
-
-	init_sync_kiocb(&kiocb, filp);
-	ret = __generic_file_aio_read(&kiocb, &local_iov, 1, ppos);
-	if (-EIOCBQUEUED == ret)
-		ret = wait_on_sync_kiocb(&kiocb);
-	return ret;
-}
-
-EXPORT_SYMBOL(generic_file_read);
-
 int file_send_actor(read_descriptor_t * desc, struct page *page, unsigned long offset, unsigned long size)
 {
 	ssize_t written;
@@ -2217,38 +2193,6 @@ ssize_t generic_file_aio_write_nolock(st
 }
 EXPORT_SYMBOL(generic_file_aio_write_nolock);
 
-static ssize_t
-__generic_file_write_nolock(struct file *file, const struct iovec *iov,
-				unsigned long nr_segs, loff_t *ppos)
-{
-	struct kiocb kiocb;
-	ssize_t ret;
-
-	init_sync_kiocb(&kiocb, file);
-	kiocb.ki_pos = *ppos;
-	ret = __generic_file_aio_write_nolock(&kiocb, iov, nr_segs, ppos);
-	if (-EIOCBQUEUED == ret)
-		ret = wait_on_sync_kiocb(&kiocb);
-	return ret;
-}
-
-ssize_t
-generic_file_write_nolock(struct file *file, const struct iovec *iov,
-				unsigned long nr_segs, loff_t *ppos)
-{
-	struct kiocb kiocb;
-	ssize_t ret;
-
-	init_sync_kiocb(&kiocb, file);
-	kiocb.ki_pos = *ppos;
-	ret = generic_file_aio_write_nolock(&kiocb, iov, nr_segs, *ppos);
-	if (-EIOCBQUEUED == ret)
-		ret = wait_on_sync_kiocb(&kiocb);
-	*ppos = kiocb.ki_pos;
-	return ret;
-}
-EXPORT_SYMBOL(generic_file_write_nolock);
-
 ssize_t generic_file_aio_write(struct kiocb *iocb, const struct iovec *iov,
 		unsigned long nr_segs, loff_t pos)
 {
@@ -2274,30 +2218,6 @@ ssize_t generic_file_aio_write(struct ki
 }
 EXPORT_SYMBOL(generic_file_aio_write);
 
-ssize_t generic_file_write(struct file *file, const char __user *buf,
-			   size_t count, loff_t *ppos)
-{
-	struct address_space *mapping = file->f_mapping;
-	struct inode *inode = mapping->host;
-	ssize_t	ret;
-	struct iovec local_iov = { .iov_base = (void __user *)buf,
-					.iov_len = count };
-
-	mutex_lock(&inode->i_mutex);
-	ret = __generic_file_write_nolock(file, &local_iov, 1, ppos);
-	mutex_unlock(&inode->i_mutex);
-
-	if (ret > 0 && ((file->f_flags & O_SYNC) || IS_SYNC(inode))) {
-		ssize_t err;
-
-		err = sync_page_range(inode, mapping, *ppos - ret, ret);
-		if (err < 0)
-			ret = err;
-	}
-	return ret;
-}
-EXPORT_SYMBOL(generic_file_write);
-
 /*
  * Called under i_mutex for writes to S_ISREG files.   Returns -EIO if something
  * went wrong during pagecache shootdown.
Index: linux-2.6.17-rc4/fs/xfs/linux-2.6/xfs_lrw.c
===================================================================
--- linux-2.6.17-rc4.orig/fs/xfs/linux-2.6/xfs_lrw.c	2006-05-15 14:09:43.030776064 -0700
+++ linux-2.6.17-rc4/fs/xfs/linux-2.6/xfs_lrw.c	2006-05-15 14:14:12.661785920 -0700
@@ -276,7 +276,9 @@ xfs_read(
 
 	xfs_rw_enter_trace(XFS_READ_ENTER, &ip->i_iocore,
 				(void *)iovp, segs, *offset, ioflags);
-	ret = __generic_file_aio_read(iocb, iovp, segs, offset);
+
+	iocb->ki_pos = *offset;
+	ret = generic_file_aio_read(iocb, iovp, segs, *offset);
 	if (ret == -EIOCBQUEUED && !(ioflags & IO_ISAIO))
 		ret = wait_on_sync_kiocb(iocb);
 	if (ret > 0)
Index: linux-2.6.17-rc4/fs/smbfs/file.c
===================================================================
--- linux-2.6.17-rc4.orig/fs/smbfs/file.c	2006-05-15 14:09:43.035775304 -0700
+++ linux-2.6.17-rc4/fs/smbfs/file.c	2006-05-15 14:14:12.662785768 -0700
@@ -214,13 +214,15 @@ smb_updatepage(struct file *file, struct
 }
 
 static ssize_t
-smb_file_read(struct file * file, char __user * buf, size_t count, loff_t *ppos)
+smb_file_aio_read(struct kiocb *iocb, const struct iovec *iov,
+			unsigned long nr_segs, loff_t pos)
 {
+	struct file * file = iocb->ki_filp;
 	struct dentry * dentry = file->f_dentry;
 	ssize_t	status;
 
 	VERBOSE("file %s/%s, count=%lu@%lu\n", DENTRY_PATH(dentry),
-		(unsigned long) count, (unsigned long) *ppos);
+		(unsigned long) iocb->ki_left, (unsigned long) pos);
 
 	status = smb_revalidate_inode(dentry);
 	if (status) {
@@ -233,7 +235,7 @@ smb_file_read(struct file * file, char _
 		(long)dentry->d_inode->i_size,
 		dentry->d_inode->i_flags, dentry->d_inode->i_atime);
 
-	status = generic_file_read(file, buf, count, ppos);
+	status = generic_file_aio_read(iocb, iov, nr_segs, pos);
 out:
 	return status;
 }
@@ -317,14 +319,16 @@ struct address_space_operations smb_file
  * Write to a file (through the page cache).
  */
 static ssize_t
-smb_file_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
+smb_file_aio_write(struct kiocb *iocb, const struct iovec *iov,
+			       unsigned long nr_segs, loff_t pos)
 {
+	struct file * file = iocb->ki_filp;
 	struct dentry * dentry = file->f_dentry;
 	ssize_t	result;
 
 	VERBOSE("file %s/%s, count=%lu@%lu\n",
 		DENTRY_PATH(dentry),
-		(unsigned long) count, (unsigned long) *ppos);
+		(unsigned long) iocb->ki_left, (unsigned long) pos);
 
 	result = smb_revalidate_inode(dentry);
 	if (result) {
@@ -337,8 +341,8 @@ smb_file_write(struct file *file, const 
 	if (result)
 		goto out;
 
-	if (count > 0) {
-		result = generic_file_write(file, buf, count, ppos);
+	if (iocb->ki_left > 0) {
+		result = generic_file_aio_write(iocb, iov, nr_segs, pos);
 		VERBOSE("pos=%ld, size=%ld, mtime=%ld, atime=%ld\n",
 			(long) file->f_pos, (long) dentry->d_inode->i_size,
 			dentry->d_inode->i_mtime, dentry->d_inode->i_atime);
@@ -402,8 +406,10 @@ smb_file_permission(struct inode *inode,
 const struct file_operations smb_file_operations =
 {
 	.llseek		= remote_llseek,
-	.read		= smb_file_read,
-	.write		= smb_file_write,
+	.read		= do_sync_read,
+	.aio_read	= smb_file_aio_read,
+	.write		= do_sync_write,
+	.aio_write	= smb_file_aio_write,
 	.ioctl		= smb_ioctl,
 	.mmap		= smb_file_mmap,
 	.open		= smb_file_open,
Index: linux-2.6.17-rc4/fs/sysv/file.c
===================================================================
--- linux-2.6.17-rc4.orig/fs/sysv/file.c	2006-05-15 14:09:43.033775608 -0700
+++ linux-2.6.17-rc4/fs/sysv/file.c	2006-05-15 14:14:12.663785616 -0700
@@ -21,8 +21,10 @@
  */
 const struct file_operations sysv_file_operations = {
 	.llseek		= generic_file_llseek,
-	.read		= generic_file_read,
-	.write		= generic_file_write,
+	.read		= do_sync_read,
+	.aio_read	= generic_file_aio_read,
+	.write		= do_sync_write,
+	.aio_write	= generic_file_aio_write,
 	.mmap		= generic_file_mmap,
 	.fsync		= sysv_sync_file,
 	.sendfile	= generic_file_sendfile,
Index: linux-2.6.17-rc4/fs/udf/file.c
===================================================================
--- linux-2.6.17-rc4.orig/fs/udf/file.c	2006-05-15 14:09:43.029776216 -0700
+++ linux-2.6.17-rc4/fs/udf/file.c	2006-05-15 14:14:12.663785616 -0700
@@ -103,19 +103,21 @@ struct address_space_operations udf_adin
 	.commit_write		= udf_adinicb_commit_write,
 };
 
-static ssize_t udf_file_write(struct file * file, const char __user * buf,
-	size_t count, loff_t *ppos)
+static ssize_t udf_file_aio_write(struct kiocb *iocb, const struct iovec *iov,
+			      unsigned long nr_segs, loff_t ppos)
 {
 	ssize_t retval;
+	struct file *file = iocb->ki_filp;
 	struct inode *inode = file->f_dentry->d_inode;
 	int err, pos;
+	size_t count = iocb->ki_left;
 
 	if (UDF_I_ALLOCTYPE(inode) == ICBTAG_FLAG_AD_IN_ICB)
 	{
 		if (file->f_flags & O_APPEND)
 			pos = inode->i_size;
 		else
-			pos = *ppos;
+			pos = ppos;
 
 		if (inode->i_sb->s_blocksize < (udf_file_entry_alloc_offset(inode) +
 			pos + count))
@@ -136,7 +138,7 @@ static ssize_t udf_file_write(struct fil
 		}
 	}
 
-	retval = generic_file_write(file, buf, count, ppos);
+	retval = generic_file_aio_write(iocb, iov, nr_segs, ppos);
 
 	if (retval > 0)
 		mark_inode_dirty(inode);
@@ -249,11 +251,13 @@ static int udf_release_file(struct inode
 }
 
 const struct file_operations udf_file_operations = {
-	.read			= generic_file_read,
+	.read			= do_sync_read,
+	.aio_read		= generic_file_aio_read,
 	.ioctl			= udf_ioctl,
 	.open			= generic_file_open,
 	.mmap			= generic_file_mmap,
-	.write			= udf_file_write,
+	.write			= do_sync_write,
+	.aio_write		= udf_file_aio_write,
 	.release		= udf_release_file,
 	.fsync			= udf_fsync_file,
 	.sendfile		= generic_file_sendfile,
Index: linux-2.6.17-rc4/fs/ufs/file.c
===================================================================
--- linux-2.6.17-rc4.orig/fs/ufs/file.c	2006-05-15 14:09:43.029776216 -0700
+++ linux-2.6.17-rc4/fs/ufs/file.c	2006-05-15 14:14:12.664785464 -0700
@@ -33,8 +33,10 @@
  
 const struct file_operations ufs_file_operations = {
 	.llseek		= generic_file_llseek,
-	.read		= generic_file_read,
-	.write		= generic_file_write,
+	.read		= do_sync_read,
+	.aio_read	= generic_file_aio_read,
+	.write		= do_sync_write,
+	.aio_write	= generic_file_aio_write,
 	.mmap		= generic_file_mmap,
 	.open           = generic_file_open,
 	.sendfile	= generic_file_sendfile,


