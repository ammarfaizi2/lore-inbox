Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932161AbWFBTJ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbWFBTJ0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 15:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932141AbWFBTJ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 15:09:26 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:35725 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932161AbWFBTJY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 15:09:24 -0400
Subject: [PATCH 4/4] Streamline generic_file_* interfaces and filemap
	cleanups
From: Badari Pulavarty <pbadari@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm@osdl.org, christoph <hch@lst.de>, Zach Brown <zach.brown@oracle.com>,
       cel@citi.umich.edu
In-Reply-To: <1149275193.26170.8.camel@dyn9047017100.beaverton.ibm.com>
References: <1149275193.26170.8.camel@dyn9047017100.beaverton.ibm.com>
Content-Type: text/plain
Date: Fri, 02 Jun 2006 12:10:59 -0700
Message-Id: <1149275459.26170.16.camel@dyn9047017100.beaverton.ibm.com>
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
 fs/ecryptfs/file.c         |   20 +++++++---
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
 28 files changed, 120 insertions(+), 171 deletions(-)

Index: linux-2.6.17-rc5-mm2/drivers/char/raw.c
===================================================================
--- linux-2.6.17-rc5-mm2.orig/drivers/char/raw.c	2006-06-02 11:58:08.714512232 -0700
+++ linux-2.6.17-rc5-mm2/drivers/char/raw.c	2006-06-02 12:01:39.695438256 -0700
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
Index: linux-2.6.17-rc5-mm2/fs/adfs/file.c
===================================================================
--- linux-2.6.17-rc5-mm2.orig/fs/adfs/file.c	2006-06-02 11:51:35.242329096 -0700
+++ linux-2.6.17-rc5-mm2/fs/adfs/file.c	2006-06-02 12:01:39.696438104 -0700
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
 
Index: linux-2.6.17-rc5-mm2/fs/affs/file.c
===================================================================
--- linux-2.6.17-rc5-mm2.orig/fs/affs/file.c	2006-06-02 11:51:35.243328944 -0700
+++ linux-2.6.17-rc5-mm2/fs/affs/file.c	2006-06-02 12:01:39.697437952 -0700
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
Index: linux-2.6.17-rc5-mm2/fs/bfs/file.c
===================================================================
--- linux-2.6.17-rc5-mm2.orig/fs/bfs/file.c	2006-06-02 11:51:35.239329552 -0700
+++ linux-2.6.17-rc5-mm2/fs/bfs/file.c	2006-06-02 12:01:39.697437952 -0700
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
Index: linux-2.6.17-rc5-mm2/fs/block_dev.c
===================================================================
--- linux-2.6.17-rc5-mm2.orig/fs/block_dev.c	2006-06-02 11:58:08.716511928 -0700
+++ linux-2.6.17-rc5-mm2/fs/block_dev.c	2006-06-02 12:01:39.698437800 -0700
@@ -1158,14 +1158,6 @@ static int blkdev_close(struct inode * i
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
@@ -1185,8 +1177,8 @@ const struct file_operations def_blk_fop
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
Index: linux-2.6.17-rc5-mm2/fs/ext2/file.c
===================================================================
--- linux-2.6.17-rc5-mm2.orig/fs/ext2/file.c	2006-06-02 11:58:08.719511472 -0700
+++ linux-2.6.17-rc5-mm2/fs/ext2/file.c	2006-06-02 12:01:39.699437648 -0700
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
Index: linux-2.6.17-rc5-mm2/fs/fuse/file.c
===================================================================
--- linux-2.6.17-rc5-mm2.orig/fs/fuse/file.c	2006-06-02 11:51:35.243328944 -0700
+++ linux-2.6.17-rc5-mm2/fs/fuse/file.c	2006-06-02 12:01:39.700437496 -0700
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
Index: linux-2.6.17-rc5-mm2/fs/hfs/inode.c
===================================================================
--- linux-2.6.17-rc5-mm2.orig/fs/hfs/inode.c	2006-06-02 11:51:35.239329552 -0700
+++ linux-2.6.17-rc5-mm2/fs/hfs/inode.c	2006-06-02 12:01:39.700437496 -0700
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
Index: linux-2.6.17-rc5-mm2/fs/hfsplus/inode.c
===================================================================
--- linux-2.6.17-rc5-mm2.orig/fs/hfsplus/inode.c	2006-06-02 11:51:35.248328184 -0700
+++ linux-2.6.17-rc5-mm2/fs/hfsplus/inode.c	2006-06-02 12:01:39.701437344 -0700
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
Index: linux-2.6.17-rc5-mm2/fs/hostfs/hostfs_kern.c
===================================================================
--- linux-2.6.17-rc5-mm2.orig/fs/hostfs/hostfs_kern.c	2006-06-02 11:58:08.722511016 -0700
+++ linux-2.6.17-rc5-mm2/fs/hostfs/hostfs_kern.c	2006-06-02 12:01:39.702437192 -0700
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
Index: linux-2.6.17-rc5-mm2/fs/hpfs/file.c
===================================================================
--- linux-2.6.17-rc5-mm2.orig/fs/hpfs/file.c	2006-06-02 11:51:35.244328792 -0700
+++ linux-2.6.17-rc5-mm2/fs/hpfs/file.c	2006-06-02 12:01:39.703437040 -0700
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
Index: linux-2.6.17-rc5-mm2/fs/jffs/inode-v23.c
===================================================================
--- linux-2.6.17-rc5-mm2.orig/fs/jffs/inode-v23.c	2006-06-02 11:51:35.244328792 -0700
+++ linux-2.6.17-rc5-mm2/fs/jffs/inode-v23.c	2006-06-02 12:01:39.704436888 -0700
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
Index: linux-2.6.17-rc5-mm2/fs/jffs2/file.c
===================================================================
--- linux-2.6.17-rc5-mm2.orig/fs/jffs2/file.c	2006-06-02 11:51:35.246328488 -0700
+++ linux-2.6.17-rc5-mm2/fs/jffs2/file.c	2006-06-02 12:01:39.705436736 -0700
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
 	.mmap =		generic_file_readonly_mmap,
 	.fsync =	jffs2_fsync,
 	.sendfile =	generic_file_sendfile
Index: linux-2.6.17-rc5-mm2/fs/jfs/file.c
===================================================================
--- linux-2.6.17-rc5-mm2.orig/fs/jfs/file.c	2006-06-02 11:58:08.723510864 -0700
+++ linux-2.6.17-rc5-mm2/fs/jfs/file.c	2006-06-02 12:01:39.705436736 -0700
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
Index: linux-2.6.17-rc5-mm2/fs/minix/file.c
===================================================================
--- linux-2.6.17-rc5-mm2.orig/fs/minix/file.c	2006-06-02 11:51:35.247328336 -0700
+++ linux-2.6.17-rc5-mm2/fs/minix/file.c	2006-06-02 12:01:39.706436584 -0700
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
Index: linux-2.6.17-rc5-mm2/fs/ntfs/file.c
===================================================================
--- linux-2.6.17-rc5-mm2.orig/fs/ntfs/file.c	2006-06-02 11:58:08.724510712 -0700
+++ linux-2.6.17-rc5-mm2/fs/ntfs/file.c	2006-06-02 12:01:39.707436432 -0700
@@ -2295,7 +2295,7 @@ static int ntfs_file_fsync(struct file *
 
 const struct file_operations ntfs_file_ops = {
 	.llseek		= generic_file_llseek,	 /* Seek inside file. */
-	.read		= generic_file_read,	 /* Read from file. */
+	.read		= do_sync_read,		 /* Read from file. */
 	.aio_read	= generic_file_aio_read, /* Async read from file. */
 #ifdef NTFS_RW
 	.write		= ntfs_file_write,	 /* Write to file. */
Index: linux-2.6.17-rc5-mm2/fs/qnx4/file.c
===================================================================
--- linux-2.6.17-rc5-mm2.orig/fs/qnx4/file.c	2006-06-02 11:51:35.245328640 -0700
+++ linux-2.6.17-rc5-mm2/fs/qnx4/file.c	2006-06-02 12:01:39.708436280 -0700
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
Index: linux-2.6.17-rc5-mm2/fs/ramfs/file-mmu.c
===================================================================
--- linux-2.6.17-rc5-mm2.orig/fs/ramfs/file-mmu.c	2006-06-02 11:51:35.247328336 -0700
+++ linux-2.6.17-rc5-mm2/fs/ramfs/file-mmu.c	2006-06-02 12:01:39.709436128 -0700
@@ -33,8 +33,10 @@ const struct address_space_operations ra
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
Index: linux-2.6.17-rc5-mm2/fs/ramfs/file-nommu.c
===================================================================
--- linux-2.6.17-rc5-mm2.orig/fs/ramfs/file-nommu.c	2006-06-02 11:51:35.247328336 -0700
+++ linux-2.6.17-rc5-mm2/fs/ramfs/file-nommu.c	2006-06-02 12:01:39.709436128 -0700
@@ -36,8 +36,10 @@ const struct address_space_operations ra
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
Index: linux-2.6.17-rc5-mm2/fs/read_write.c
===================================================================
--- linux-2.6.17-rc5-mm2.orig/fs/read_write.c	2006-06-02 12:01:35.266111616 -0700
+++ linux-2.6.17-rc5-mm2/fs/read_write.c	2006-06-02 12:01:39.710435976 -0700
@@ -22,7 +22,8 @@
 
 const struct file_operations generic_ro_fops = {
 	.llseek		= generic_file_llseek,
-	.read		= generic_file_read,
+	.read		= do_sync_read,
+	.aio_read	= generic_file_aio_read,
 	.mmap		= generic_file_readonly_mmap,
 	.sendfile	= generic_file_sendfile,
 };
Index: linux-2.6.17-rc5-mm2/include/linux/fs.h
===================================================================
--- linux-2.6.17-rc5-mm2.orig/include/linux/fs.h	2006-06-02 12:01:35.268111312 -0700
+++ linux-2.6.17-rc5-mm2/include/linux/fs.h	2006-06-02 12:01:39.711435824 -0700
@@ -1687,11 +1687,8 @@ extern int generic_file_mmap(struct file
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
@@ -1701,8 +1698,6 @@ extern ssize_t generic_file_buffered_wri
 		unsigned long, loff_t, loff_t *, size_t, ssize_t);
 extern ssize_t do_sync_read(struct file *filp, char __user *buf, size_t len, loff_t *ppos);
 extern ssize_t do_sync_write(struct file *filp, const char __user *buf, size_t len, loff_t *ppos);
-ssize_t generic_file_write_nolock(struct file *file, const struct iovec *iov,
-				unsigned long nr_segs, loff_t *ppos);
 extern ssize_t generic_file_sendfile(struct file *, loff_t *, size_t, read_actor_t, void *);
 extern void do_generic_mapping_read(struct address_space *mapping,
 				    struct file_ra_state *, struct file *,
Index: linux-2.6.17-rc5-mm2/mm/filemap.c
===================================================================
--- linux-2.6.17-rc5-mm2.orig/mm/filemap.c	2006-06-02 11:58:08.731509648 -0700
+++ linux-2.6.17-rc5-mm2/mm/filemap.c	2006-06-02 12:01:39.713435520 -0700
@@ -1121,13 +1121,14 @@ EXPORT_SYMBOL(file_read_actor);
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
@@ -1151,7 +1152,7 @@ __generic_file_aio_read(struct kiocb *io
 
 	/* coalesce the iovecs and go direct-to-BIO for O_DIRECT */
 	if (filp->f_flags & O_DIRECT) {
-		loff_t pos = *ppos, size;
+		loff_t size;
 		struct address_space *mapping;
 		struct inode *inode;
 
@@ -1196,33 +1197,8 @@ out:
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
@@ -2310,38 +2286,6 @@ ssize_t generic_file_aio_write_nolock(st
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
@@ -2367,30 +2311,6 @@ ssize_t generic_file_aio_write(struct ki
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
Index: linux-2.6.17-rc5-mm2/fs/xfs/linux-2.6/xfs_lrw.c
===================================================================
--- linux-2.6.17-rc5-mm2.orig/fs/xfs/linux-2.6/xfs_lrw.c	2006-06-02 11:51:35.241329248 -0700
+++ linux-2.6.17-rc5-mm2/fs/xfs/linux-2.6/xfs_lrw.c	2006-06-02 12:01:39.714435368 -0700
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
Index: linux-2.6.17-rc5-mm2/fs/smbfs/file.c
===================================================================
--- linux-2.6.17-rc5-mm2.orig/fs/smbfs/file.c	2006-06-02 11:51:35.248328184 -0700
+++ linux-2.6.17-rc5-mm2/fs/smbfs/file.c	2006-06-02 12:01:39.715435216 -0700
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
@@ -317,14 +319,16 @@ const struct address_space_operations sm
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
Index: linux-2.6.17-rc5-mm2/fs/sysv/file.c
===================================================================
--- linux-2.6.17-rc5-mm2.orig/fs/sysv/file.c	2006-06-02 11:51:35.245328640 -0700
+++ linux-2.6.17-rc5-mm2/fs/sysv/file.c	2006-06-02 12:01:39.716435064 -0700
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
Index: linux-2.6.17-rc5-mm2/fs/udf/file.c
===================================================================
--- linux-2.6.17-rc5-mm2.orig/fs/udf/file.c	2006-06-02 11:51:35.240329400 -0700
+++ linux-2.6.17-rc5-mm2/fs/udf/file.c	2006-06-02 12:01:39.716435064 -0700
@@ -103,19 +103,21 @@ const struct address_space_operations ud
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
Index: linux-2.6.17-rc5-mm2/fs/ufs/file.c
===================================================================
--- linux-2.6.17-rc5-mm2.orig/fs/ufs/file.c	2006-06-02 11:51:35.241329248 -0700
+++ linux-2.6.17-rc5-mm2/fs/ufs/file.c	2006-06-02 12:01:39.717434912 -0700
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
Index: linux-2.6.17-rc5-mm2/fs/ecryptfs/file.c
===================================================================
--- linux-2.6.17-rc5-mm2.orig/fs/ecryptfs/file.c	2006-06-02 11:51:35.242329096 -0700
+++ linux-2.6.17-rc5-mm2/fs/ecryptfs/file.c	2006-06-02 12:01:39.718434760 -0700
@@ -99,14 +99,22 @@ out:
  * returns without any errors. This is to be used only for file reads.
  * The function to be used for directory reads is ecryptfs_read.
  */
-static ssize_t ecryptfs_read_update_atime(struct file *file, char __user * buf,
-					  size_t count, loff_t * ppos)
+static ssize_t ecryptfs_read_update_atime(struct kiocb *iocb,
+				const struct iovec *iov,
+				unsigned long nr_segs, loff_t pos)
 {
 	int rc;
 	struct dentry *lower_dentry;
 	struct vfsmount *lower_vfsmount;
+	struct file *file = iocb->ki_filp;
 
-	rc = generic_file_read(file, buf, count, ppos);
+	rc = generic_file_aio_read(iocb, iov, nr_segs, pos);
+	/*
+	 * Even though this is a async interface, we need to wait
+	 * for IO to finish to update atime
+	 */
+	if (-EIOCBQUEUED == rc)
+		rc = wait_on_sync_kiocb(iocb);
 	if (rc >= 0) {
 		lower_dentry = ecryptfs_dentry_to_lower(file->f_dentry);
 		lower_vfsmount = ecryptfs_superblock_to_private(
@@ -473,8 +481,10 @@ const struct file_operations ecryptfs_di
 
 const struct file_operations ecryptfs_main_fops = {
 	.llseek = ecryptfs_llseek,
-	.read = ecryptfs_read_update_atime,
-	.write = generic_file_write,
+	.read = do_sync_read,
+	.aio_read = ecryptfs_read_update_atime,
+	.write = do_sync_write,
+	.aio_write = generic_file_aio_write,
 	.readdir = ecryptfs_readdir,
 	.ioctl = ecryptfs_ioctl,
 	.mmap = generic_file_mmap,


