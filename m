Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965079AbWGFABc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965079AbWGFABc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 20:01:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965080AbWGFABc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 20:01:32 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:8095 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S965079AbWGFABa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 20:01:30 -0400
Subject: [PATCH 1/3] Vectorize aio_read/aio_write fileop methods
From: Badari Pulavarty <pbadari@us.ibm.com>
To: akpm@osdl.org
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1152144166.1969.5.camel@dyn9047017100.beaverton.ibm.com>
References: <1152144166.1969.5.camel@dyn9047017100.beaverton.ibm.com>
Content-Type: text/plain
Date: Wed, 05 Jul 2006 17:03:42 -0700
Message-Id: <1152144222.1969.7.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch vectorizes aio_read() and aio_write() methods to prepare
for collapsing all aio & vectored operations into one interface -
which is aio_read()/aio_write().

Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>

 Documentation/filesystems/Locking |    5 --
 Documentation/filesystems/vfs.txt |    4 -
 drivers/char/raw.c                |   14 ------
 drivers/usb/gadget/inode.c        |   78 ++++++++++++++++++++++++++------------
 fs/aio.c                          |   15 +++++--
 fs/block_dev.c                    |   10 ----
 fs/cifs/cifsfs.c                  |    6 +-
 fs/ext3/file.c                    |    5 +-
 fs/gfs2/ops_file.c                |   30 +++++---------
 fs/nfs/direct.c                   |   26 +++++++++---
 fs/nfs/file.c                     |   34 ++++++++--------
 fs/ntfs/file.c                    |    8 +--
 fs/ocfs2/file.c                   |   28 ++++++-------
 fs/read_write.c                   |   20 +++++++--
 fs/reiserfs/file.c                |    4 -
 fs/xfs/linux-2.6/xfs_file.c       |   46 +++++++++++-----------
 include/linux/aio.h               |    2 
 include/linux/fs.h                |   10 ++--
 include/linux/nfs_fs.h            |   10 ++--
 include/net/sock.h                |    1 
 mm/filemap.c                      |   39 +++++++++----------
 net/socket.c                      |   48 +++++++++++------------
 22 files changed, 241 insertions(+), 202 deletions(-)

Index: linux-2.6.17/Documentation/filesystems/Locking
===================================================================
--- linux-2.6.17.orig/Documentation/filesystems/Locking	2006-07-05 10:57:25.000000000 -0700
+++ linux-2.6.17/Documentation/filesystems/Locking	2006-07-05 10:58:46.000000000 -0700
@@ -356,10 +356,9 @@ The last two are called only from check_
 prototypes:
 	loff_t (*llseek) (struct file *, loff_t, int);
 	ssize_t (*read) (struct file *, char __user *, size_t, loff_t *);
-	ssize_t (*aio_read) (struct kiocb *, char __user *, size_t, loff_t);
 	ssize_t (*write) (struct file *, const char __user *, size_t, loff_t *);
-	ssize_t (*aio_write) (struct kiocb *, const char __user *, size_t,
-			loff_t);
+	ssize_t (*aio_read) (struct kiocb *, const struct iovec *, unsigned long, loff_t);
+	ssize_t (*aio_write) (struct kiocb *, const struct iovec *, unsigned long, loff_t);
 	int (*readdir) (struct file *, void *, filldir_t);
 	unsigned int (*poll) (struct file *, struct poll_table_struct *);
 	int (*ioctl) (struct inode *, struct file *, unsigned int,
Index: linux-2.6.17/Documentation/filesystems/vfs.txt
===================================================================
--- linux-2.6.17.orig/Documentation/filesystems/vfs.txt	2006-07-05 10:57:25.000000000 -0700
+++ linux-2.6.17/Documentation/filesystems/vfs.txt	2006-07-05 10:58:46.000000000 -0700
@@ -699,9 +699,9 @@ This describes how the VFS can manipulat
 struct file_operations {
 	loff_t (*llseek) (struct file *, loff_t, int);
 	ssize_t (*read) (struct file *, char __user *, size_t, loff_t *);
-	ssize_t (*aio_read) (struct kiocb *, char __user *, size_t, loff_t);
 	ssize_t (*write) (struct file *, const char __user *, size_t, loff_t *);
-	ssize_t (*aio_write) (struct kiocb *, const char __user *, size_t, loff_t);
+	ssize_t (*aio_read) (struct kiocb *, const struct iovec *, unsigned long, loff_t);
+	ssize_t (*aio_write) (struct kiocb *, const struct iovec *, unsigned long, loff_t);
 	int (*readdir) (struct file *, void *, filldir_t);
 	unsigned int (*poll) (struct file *, struct poll_table_struct *);
 	int (*ioctl) (struct inode *, struct file *, unsigned int, unsigned long);
Index: linux-2.6.17/drivers/char/raw.c
===================================================================
--- linux-2.6.17.orig/drivers/char/raw.c	2006-07-05 10:57:31.000000000 -0700
+++ linux-2.6.17/drivers/char/raw.c	2006-07-05 11:00:02.000000000 -0700
@@ -249,23 +249,11 @@ static ssize_t raw_file_write(struct fil
 	return generic_file_write_nolock(file, &local_iov, 1, ppos);
 }
 
-static ssize_t raw_file_aio_write(struct kiocb *iocb, const char __user *buf,
-					size_t count, loff_t pos)
-{
-	struct iovec local_iov = {
-		.iov_base = (char __user *)buf,
-		.iov_len = count
-	};
-
-	return generic_file_aio_write_nolock(iocb, &local_iov, 1, &iocb->ki_pos);
-}
-
-
 static const struct file_operations raw_fops = {
 	.read	=	generic_file_read,
 	.aio_read = 	generic_file_aio_read,
 	.write	=	raw_file_write,
-	.aio_write = 	raw_file_aio_write,
+	.aio_write = 	generic_file_aio_write_nolock,
 	.open	=	raw_open,
 	.release=	raw_release,
 	.ioctl	=	raw_ioctl,
Index: linux-2.6.17/fs/aio.c
===================================================================
--- linux-2.6.17.orig/fs/aio.c	2006-07-05 10:57:39.000000000 -0700
+++ linux-2.6.17/fs/aio.c	2006-07-05 10:58:46.000000000 -0700
@@ -15,6 +15,7 @@
 #include <linux/aio_abi.h>
 #include <linux/module.h>
 #include <linux/syscalls.h>
+#include <linux/uio.h>
 
 #define DEBUG 0
 
@@ -1315,8 +1316,11 @@ static ssize_t aio_pread(struct kiocb *i
 	ssize_t ret = 0;
 
 	do {
-		ret = file->f_op->aio_read(iocb, iocb->ki_buf,
-			iocb->ki_left, iocb->ki_pos);
+		iocb->ki_inline_vec.iov_base = iocb->ki_buf;
+		iocb->ki_inline_vec.iov_len = iocb->ki_left;
+
+		ret = file->f_op->aio_read(iocb, &iocb->ki_inline_vec,
+						1, iocb->ki_pos);
 		/*
 		 * Can't just depend on iocb->ki_left to determine
 		 * whether we are done. This may have been a short read.
@@ -1349,8 +1353,11 @@ static ssize_t aio_pwrite(struct kiocb *
 	ssize_t ret = 0;
 
 	do {
-		ret = file->f_op->aio_write(iocb, iocb->ki_buf,
-			iocb->ki_left, iocb->ki_pos);
+		iocb->ki_inline_vec.iov_base = iocb->ki_buf;
+		iocb->ki_inline_vec.iov_len = iocb->ki_left;
+
+		ret = file->f_op->aio_write(iocb, &iocb->ki_inline_vec,
+						1, iocb->ki_pos);
 		if (ret > 0) {
 			iocb->ki_buf += ret;
 			iocb->ki_left -= ret;
Index: linux-2.6.17/fs/block_dev.c
===================================================================
--- linux-2.6.17.orig/fs/block_dev.c	2006-07-05 10:57:39.000000000 -0700
+++ linux-2.6.17/fs/block_dev.c	2006-07-05 10:58:46.000000000 -0700
@@ -1161,14 +1161,6 @@ static ssize_t blkdev_file_write(struct 
 	return generic_file_write_nolock(file, &local_iov, 1, ppos);
 }
 
-static ssize_t blkdev_file_aio_write(struct kiocb *iocb, const char __user *buf,
-				   size_t count, loff_t pos)
-{
-	struct iovec local_iov = { .iov_base = (void __user *)buf, .iov_len = count };
-
-	return generic_file_aio_write_nolock(iocb, &local_iov, 1, &iocb->ki_pos);
-}
-
 static long block_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 {
 	return blkdev_ioctl(file->f_mapping->host, file, cmd, arg);
@@ -1191,7 +1183,7 @@ const struct file_operations def_blk_fop
 	.read		= generic_file_read,
 	.write		= blkdev_file_write,
   	.aio_read	= generic_file_aio_read,
-  	.aio_write	= blkdev_file_aio_write, 
+  	.aio_write	= generic_file_aio_write_nolock,
 	.mmap		= generic_file_mmap,
 	.fsync		= block_fsync,
 	.unlocked_ioctl	= block_ioctl,
Index: linux-2.6.17/fs/cifs/cifsfs.c
===================================================================
--- linux-2.6.17.orig/fs/cifs/cifsfs.c	2006-07-05 10:57:39.000000000 -0700
+++ linux-2.6.17/fs/cifs/cifsfs.c	2006-07-05 10:58:46.000000000 -0700
@@ -498,13 +498,13 @@ static ssize_t cifs_file_writev(struct f
 	return written;
 }
 
-static ssize_t cifs_file_aio_write(struct kiocb *iocb, const char __user *buf,
-				   size_t count, loff_t pos)
+static ssize_t cifs_file_aio_write(struct kiocb *iocb, const struct iovec *iov,
+				   unsigned long nr_segs, loff_t pos)
 {
 	struct inode *inode = iocb->ki_filp->f_dentry->d_inode;
 	ssize_t written;
 
-	written = generic_file_aio_write(iocb, buf, count, pos);
+	written = generic_file_aio_write(iocb, iov, nr_segs, pos);
 	if (!CIFS_I(inode)->clientCanCacheAll)
 		filemap_fdatawrite(inode->i_mapping);
 	return written;
Index: linux-2.6.17/fs/ext3/file.c
===================================================================
--- linux-2.6.17.orig/fs/ext3/file.c	2006-06-17 18:49:35.000000000 -0700
+++ linux-2.6.17/fs/ext3/file.c	2006-07-05 10:58:46.000000000 -0700
@@ -48,14 +48,15 @@ static int ext3_release_file (struct ino
 }
 
 static ssize_t
-ext3_file_write(struct kiocb *iocb, const char __user *buf, size_t count, loff_t pos)
+ext3_file_write(struct kiocb *iocb, const struct iovec *iov,
+		unsigned long nr_segs, loff_t pos)
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file->f_dentry->d_inode;
 	ssize_t ret;
 	int err;
 
-	ret = generic_file_aio_write(iocb, buf, count, pos);
+	ret = generic_file_aio_write(iocb, iov, nr_segs, pos);
 
 	/*
 	 * Skip flushing if there was an error, or if nothing was written.
Index: linux-2.6.17/fs/read_write.c
===================================================================
--- linux-2.6.17.orig/fs/read_write.c	2006-07-05 10:57:39.000000000 -0700
+++ linux-2.6.17/fs/read_write.c	2006-07-05 10:58:46.000000000 -0700
@@ -227,14 +227,20 @@ static void wait_on_retry_sync_kiocb(str
 
 ssize_t do_sync_read(struct file *filp, char __user *buf, size_t len, loff_t *ppos)
 {
+	struct iovec iov = { .iov_base = buf, .iov_len = len };
 	struct kiocb kiocb;
 	ssize_t ret;
 
 	init_sync_kiocb(&kiocb, filp);
 	kiocb.ki_pos = *ppos;
-	while (-EIOCBRETRY ==
-		(ret = filp->f_op->aio_read(&kiocb, buf, len, kiocb.ki_pos)))
+	kiocb.ki_left = len;
+
+	for (;;) {
+		ret = filp->f_op->aio_read(&kiocb, &iov, 1, kiocb.ki_pos);
+		if (ret != -EIOCBRETRY)
+			break;
 		wait_on_retry_sync_kiocb(&kiocb);
+	}
 
 	if (-EIOCBQUEUED == ret)
 		ret = wait_on_sync_kiocb(&kiocb);
@@ -279,14 +285,20 @@ EXPORT_SYMBOL(vfs_read);
 
 ssize_t do_sync_write(struct file *filp, const char __user *buf, size_t len, loff_t *ppos)
 {
+	struct iovec iov = { .iov_base = (void __user *)buf, .iov_len = len };
 	struct kiocb kiocb;
 	ssize_t ret;
 
 	init_sync_kiocb(&kiocb, filp);
 	kiocb.ki_pos = *ppos;
-	while (-EIOCBRETRY ==
-	       (ret = filp->f_op->aio_write(&kiocb, buf, len, kiocb.ki_pos)))
+	kiocb.ki_left = len;
+
+	for (;;) {
+		ret = filp->f_op->aio_write(&kiocb, &iov, 1, kiocb.ki_pos);
+		if (ret != -EIOCBRETRY)
+			break;
 		wait_on_retry_sync_kiocb(&kiocb);
+	}
 
 	if (-EIOCBQUEUED == ret)
 		ret = wait_on_sync_kiocb(&kiocb);
Index: linux-2.6.17/fs/reiserfs/file.c
===================================================================
--- linux-2.6.17.orig/fs/reiserfs/file.c	2006-07-05 10:57:39.000000000 -0700
+++ linux-2.6.17/fs/reiserfs/file.c	2006-07-05 10:58:46.000000000 -0700
@@ -1333,7 +1333,7 @@ static ssize_t reiserfs_file_write(struc
 			if (err)
 				return err;
 		}
-		result = generic_file_write(file, buf, count, ppos);
+		result = do_sync_write(file, buf, count, ppos);
 
 		if (after_file_end) {	/* Now update i_size and remove the savelink */
 			struct reiserfs_transaction_handle th;
@@ -1565,7 +1565,7 @@ static ssize_t reiserfs_file_write(struc
 }
 
 const struct file_operations reiserfs_file_operations = {
-	.read = generic_file_read,
+	.read = do_sync_read,
 	.write = reiserfs_file_write,
 	.ioctl = reiserfs_ioctl,
 	.mmap = generic_file_mmap,
Index: linux-2.6.17/fs/xfs/linux-2.6/xfs_file.c
===================================================================
--- linux-2.6.17.orig/fs/xfs/linux-2.6/xfs_file.c	2006-07-05 10:57:39.000000000 -0700
+++ linux-2.6.17/fs/xfs/linux-2.6/xfs_file.c	2006-07-05 10:58:46.000000000 -0700
@@ -49,50 +49,49 @@ static struct vm_operations_struct xfs_d
 STATIC inline ssize_t
 __xfs_file_read(
 	struct kiocb		*iocb,
-	char			__user *buf,
+	const struct iovec	*iov,
+	unsigned long		nr_segs,
 	int			ioflags,
-	size_t			count,
 	loff_t			pos)
 {
-	struct iovec		iov = {buf, count};
 	struct file		*file = iocb->ki_filp;
 	bhv_vnode_t		*vp = vn_from_inode(file->f_dentry->d_inode);
 
 	BUG_ON(iocb->ki_pos != pos);
 	if (unlikely(file->f_flags & O_DIRECT))
 		ioflags |= IO_ISDIRECT;
-	return bhv_vop_read(vp, iocb, &iov, 1, &iocb->ki_pos, ioflags, NULL);
+	return bhv_vop_read(vp, iocb, iov, nr_segs, &iocb->ki_pos,
+				ioflags, NULL);
 }
 
 STATIC ssize_t
 xfs_file_aio_read(
 	struct kiocb		*iocb,
-	char			__user *buf,
-	size_t			count,
+	const struct iovec	*iov,
+	unsigned long		nr_segs,
 	loff_t			pos)
 {
-	return __xfs_file_read(iocb, buf, IO_ISAIO, count, pos);
+	return __xfs_file_read(iocb, iov, nr_segs, IO_ISAIO, pos);
 }
 
 STATIC ssize_t
 xfs_file_aio_read_invis(
 	struct kiocb		*iocb,
-	char			__user *buf,
-	size_t			count,
+	const struct iovec	*iov,
+	unsigned long		nr_segs,
 	loff_t			pos)
 {
-	return __xfs_file_read(iocb, buf, IO_ISAIO|IO_INVIS, count, pos);
+	return __xfs_file_read(iocb, iov, nr_segs, IO_ISAIO|IO_INVIS, pos);
 }
 
 STATIC inline ssize_t
 __xfs_file_write(
-	struct kiocb	*iocb,
-	const char	__user *buf,
-	int		ioflags,
-	size_t		count,
-	loff_t		pos)
+	struct kiocb		*iocb,
+	const struct iovec	*iov,
+	unsigned long		nr_segs,
+	int			ioflags,
+	loff_t			pos)
 {
-	struct iovec	iov = {(void __user *)buf, count};
 	struct file	*file = iocb->ki_filp;
 	struct inode	*inode = file->f_mapping->host;
 	bhv_vnode_t	*vp = vn_from_inode(inode);
@@ -100,27 +99,28 @@ __xfs_file_write(
 	BUG_ON(iocb->ki_pos != pos);
 	if (unlikely(file->f_flags & O_DIRECT))
 		ioflags |= IO_ISDIRECT;
-	return bhv_vop_write(vp, iocb, &iov, 1, &iocb->ki_pos, ioflags, NULL);
+	return bhv_vop_write(vp, iocb, &iov, nr_segs, &iocb->ki_pos,
+				ioflags, NULL);
 }
 
 STATIC ssize_t
 xfs_file_aio_write(
 	struct kiocb		*iocb,
-	const char		__user *buf,
-	size_t			count,
+	const struct iovec	*iov,
+	unsigned long		nr_segs,
 	loff_t			pos)
 {
-	return __xfs_file_write(iocb, buf, IO_ISAIO, count, pos);
+	return __xfs_file_write(iocb, iov, nr_segs, IO_ISAIO, pos);
 }
 
 STATIC ssize_t
 xfs_file_aio_write_invis(
 	struct kiocb		*iocb,
-	const char		__user *buf,
-	size_t			count,
+	const struct iovec	*iov,
+	unsigned long		nr_segs,
 	loff_t			pos)
 {
-	return __xfs_file_write(iocb, buf, IO_ISAIO|IO_INVIS, count, pos);
+	return __xfs_file_write(iocb, iov, nr_segs, IO_ISAIO|IO_INVIS, pos);
 }
 
 STATIC inline ssize_t
Index: linux-2.6.17/include/linux/fs.h
===================================================================
--- linux-2.6.17.orig/include/linux/fs.h	2006-07-05 10:57:46.000000000 -0700
+++ linux-2.6.17/include/linux/fs.h	2006-07-05 10:58:46.000000000 -0700
@@ -1103,9 +1103,9 @@ struct file_operations {
 	struct module *owner;
 	loff_t (*llseek) (struct file *, loff_t, int);
 	ssize_t (*read) (struct file *, char __user *, size_t, loff_t *);
-	ssize_t (*aio_read) (struct kiocb *, char __user *, size_t, loff_t);
 	ssize_t (*write) (struct file *, const char __user *, size_t, loff_t *);
-	ssize_t (*aio_write) (struct kiocb *, const char __user *, size_t, loff_t);
+	ssize_t (*aio_read) (struct kiocb *, const struct iovec *, unsigned long, loff_t);
+	ssize_t (*aio_write) (struct kiocb *, const struct iovec *, unsigned long, loff_t);
 	int (*readdir) (struct file *, void *, filldir_t);
 	unsigned int (*poll) (struct file *, struct poll_table_struct *);
 	int (*ioctl) (struct inode *, struct file *, unsigned int, unsigned long);
@@ -1700,11 +1700,11 @@ extern int file_send_actor(read_descript
 extern ssize_t generic_file_read(struct file *, char __user *, size_t, loff_t *);
 int generic_write_checks(struct file *file, loff_t *pos, size_t *count, int isblk);
 extern ssize_t generic_file_write(struct file *, const char __user *, size_t, loff_t *);
-extern ssize_t generic_file_aio_read(struct kiocb *, char __user *, size_t, loff_t);
+extern ssize_t generic_file_aio_read(struct kiocb *, const struct iovec *, unsigned long, loff_t);
 extern ssize_t __generic_file_aio_read(struct kiocb *, const struct iovec *, unsigned long, loff_t *);
-extern ssize_t generic_file_aio_write(struct kiocb *, const char __user *, size_t, loff_t);
+extern ssize_t generic_file_aio_write(struct kiocb *, const struct iovec *, unsigned long, loff_t);
 extern ssize_t generic_file_aio_write_nolock(struct kiocb *, const struct iovec *,
-		unsigned long, loff_t *);
+		unsigned long, loff_t);
 extern ssize_t generic_file_direct_write(struct kiocb *, const struct iovec *,
 		unsigned long *, loff_t, loff_t *, size_t, size_t);
 extern ssize_t generic_file_buffered_write(struct kiocb *, const struct iovec *,
Index: linux-2.6.17/include/net/sock.h
===================================================================
--- linux-2.6.17.orig/include/net/sock.h	2006-07-05 10:57:46.000000000 -0700
+++ linux-2.6.17/include/net/sock.h	2006-07-05 10:58:46.000000000 -0700
@@ -665,7 +665,6 @@ struct sock_iocb {
 	struct sock		*sk;
 	struct scm_cookie	*scm;
 	struct msghdr		*msg, async_msg;
-	struct iovec		async_iov;
 	struct kiocb		*kiocb;
 };
 
Index: linux-2.6.17/mm/filemap.c
===================================================================
--- linux-2.6.17.orig/mm/filemap.c	2006-07-05 10:57:46.000000000 -0700
+++ linux-2.6.17/mm/filemap.c	2006-07-05 10:58:46.000000000 -0700
@@ -1283,12 +1283,11 @@ out:
 EXPORT_SYMBOL(__generic_file_aio_read);
 
 ssize_t
-generic_file_aio_read(struct kiocb *iocb, char __user *buf, size_t count, loff_t pos)
+generic_file_aio_read(struct kiocb *iocb, const struct iovec *iov,
+		unsigned long nr_segs, loff_t pos)
 {
-	struct iovec local_iov = { .iov_base = buf, .iov_len = count };
-
 	BUG_ON(iocb->ki_pos != pos);
-	return __generic_file_aio_read(iocb, &local_iov, 1, &iocb->ki_pos);
+	return __generic_file_aio_read(iocb, iov, nr_segs, &iocb->ki_pos);
 }
 EXPORT_SYMBOL(generic_file_aio_read);
 
@@ -2394,22 +2393,22 @@ out:
 	current->backing_dev_info = NULL;
 	return written ? written : err;
 }
-EXPORT_SYMBOL(generic_file_aio_write_nolock);
 
-ssize_t
-generic_file_aio_write_nolock(struct kiocb *iocb, const struct iovec *iov,
-				unsigned long nr_segs, loff_t *ppos)
+ssize_t generic_file_aio_write_nolock(struct kiocb *iocb,
+		const struct iovec *iov, unsigned long nr_segs, loff_t pos)
 {
 	struct file *file = iocb->ki_filp;
 	struct address_space *mapping = file->f_mapping;
 	struct inode *inode = mapping->host;
 	ssize_t ret;
-	loff_t pos = *ppos;
 
-	ret = __generic_file_aio_write_nolock(iocb, iov, nr_segs, ppos);
+	BUG_ON(iocb->ki_pos != pos);
+
+	ret = __generic_file_aio_write_nolock(iocb, iov, nr_segs,
+			&iocb->ki_pos);
 
 	if (ret > 0 && ((file->f_flags & O_SYNC) || IS_SYNC(inode))) {
-		int err;
+		ssize_t err;
 
 		err = sync_page_range_nolock(inode, mapping, pos, ret);
 		if (err < 0)
@@ -2417,6 +2416,7 @@ generic_file_aio_write_nolock(struct kio
 	}
 	return ret;
 }
+EXPORT_SYMBOL(generic_file_aio_write_nolock);
 
 static ssize_t
 __generic_file_write_nolock(struct file *file, const struct iovec *iov,
@@ -2426,8 +2426,9 @@ __generic_file_write_nolock(struct file 
 	ssize_t ret;
 
 	init_sync_kiocb(&kiocb, file);
+	kiocb.ki_pos = *ppos;
 	ret = __generic_file_aio_write_nolock(&kiocb, iov, nr_segs, ppos);
-	if (ret == -EIOCBQUEUED)
+	if (-EIOCBQUEUED == ret)
 		ret = wait_on_sync_kiocb(&kiocb);
 	return ret;
 }
@@ -2440,28 +2441,28 @@ generic_file_write_nolock(struct file *f
 	ssize_t ret;
 
 	init_sync_kiocb(&kiocb, file);
-	ret = generic_file_aio_write_nolock(&kiocb, iov, nr_segs, ppos);
+	kiocb.ki_pos = *ppos;
+	ret = generic_file_aio_write_nolock(&kiocb, iov, nr_segs, *ppos);
 	if (-EIOCBQUEUED == ret)
 		ret = wait_on_sync_kiocb(&kiocb);
+	*ppos = kiocb.ki_pos;
 	return ret;
 }
 EXPORT_SYMBOL(generic_file_write_nolock);
 
-ssize_t generic_file_aio_write(struct kiocb *iocb, const char __user *buf,
-			       size_t count, loff_t pos)
+ssize_t generic_file_aio_write(struct kiocb *iocb, const struct iovec *iov,
+		unsigned long nr_segs, loff_t pos)
 {
 	struct file *file = iocb->ki_filp;
 	struct address_space *mapping = file->f_mapping;
 	struct inode *inode = mapping->host;
 	ssize_t ret;
-	struct iovec local_iov = { .iov_base = (void __user *)buf,
-					.iov_len = count };
 
 	BUG_ON(iocb->ki_pos != pos);
 
 	mutex_lock(&inode->i_mutex);
-	ret = __generic_file_aio_write_nolock(iocb, &local_iov, 1,
-						&iocb->ki_pos);
+	ret = __generic_file_aio_write_nolock(iocb, iov, nr_segs,
+			&iocb->ki_pos);
 	mutex_unlock(&inode->i_mutex);
 
 	if (ret > 0 && ((file->f_flags & O_SYNC) || IS_SYNC(inode))) {
Index: linux-2.6.17/net/socket.c
===================================================================
--- linux-2.6.17.orig/net/socket.c	2006-07-05 10:57:50.000000000 -0700
+++ linux-2.6.17/net/socket.c	2006-07-05 10:58:46.000000000 -0700
@@ -95,10 +95,10 @@
 #include <linux/netfilter.h>
 
 static int sock_no_open(struct inode *irrelevant, struct file *dontcare);
-static ssize_t sock_aio_read(struct kiocb *iocb, char __user *buf,
-			 size_t size, loff_t pos);
-static ssize_t sock_aio_write(struct kiocb *iocb, const char __user *buf,
-			  size_t size, loff_t pos);
+static ssize_t sock_aio_read(struct kiocb *iocb, const struct iovec *iov,
+			 unsigned long nr_segs, loff_t pos);
+static ssize_t sock_aio_write(struct kiocb *iocb, const struct iovec *iov,
+			  unsigned long nr_segs, loff_t pos);
 static int sock_mmap(struct file *file, struct vm_area_struct * vma);
 
 static int sock_close(struct inode *inode, struct file *file);
@@ -702,7 +702,7 @@ static ssize_t sock_sendpage(struct file
 }
 
 static struct sock_iocb *alloc_sock_iocb(struct kiocb *iocb,
-		char __user *ubuf, size_t size, struct sock_iocb *siocb)
+		struct sock_iocb *siocb)
 {
 	if (!is_sync_kiocb(iocb)) {
 		siocb = kmalloc(sizeof(*siocb), GFP_KERNEL);
@@ -712,15 +712,13 @@ static struct sock_iocb *alloc_sock_iocb
 	}
 
 	siocb->kiocb = iocb;
-	siocb->async_iov.iov_base = ubuf;
-	siocb->async_iov.iov_len = size;
-
 	iocb->private = siocb;
 	return siocb;
 }
 
 static ssize_t do_sock_read(struct msghdr *msg, struct kiocb *iocb,
-		struct file *file, struct iovec *iov, unsigned long nr_segs)
+		struct file *file, const struct iovec *iov,
+		unsigned long nr_segs)
 {
 	struct socket *sock = file->private_data;
 	size_t size = 0;
@@ -751,31 +749,33 @@ static ssize_t sock_readv(struct file *f
         init_sync_kiocb(&iocb, NULL);
 	iocb.private = &siocb;
 
-	ret = do_sock_read(&msg, &iocb, file, (struct iovec *)iov, nr_segs);
+	ret = do_sock_read(&msg, &iocb, file, iov, nr_segs);
 	if (-EIOCBQUEUED == ret)
 		ret = wait_on_sync_kiocb(&iocb);
 	return ret;
 }
 
-static ssize_t sock_aio_read(struct kiocb *iocb, char __user *ubuf,
-			 size_t count, loff_t pos)
+static ssize_t sock_aio_read(struct kiocb *iocb, const struct iovec *iov,
+			 unsigned long nr_segs, loff_t pos)
 {
 	struct sock_iocb siocb, *x;
 
 	if (pos != 0)
 		return -ESPIPE;
-	if (count == 0)		/* Match SYS5 behaviour */
+
+	if (iocb->ki_left == 0)	/* Match SYS5 behaviour */
 		return 0;
 
-	x = alloc_sock_iocb(iocb, ubuf, count, &siocb);
+
+	x = alloc_sock_iocb(iocb, &siocb);
 	if (!x)
 		return -ENOMEM;
-	return do_sock_read(&x->async_msg, iocb, iocb->ki_filp,
-			&x->async_iov, 1);
+	return do_sock_read(&x->async_msg, iocb, iocb->ki_filp, iov, nr_segs);
 }
 
 static ssize_t do_sock_write(struct msghdr *msg, struct kiocb *iocb,
-		struct file *file, struct iovec *iov, unsigned long nr_segs)
+		struct file *file, const struct iovec *iov,
+		unsigned long nr_segs)
 {
 	struct socket *sock = file->private_data;
 	size_t size = 0;
@@ -808,28 +808,28 @@ static ssize_t sock_writev(struct file *
 	init_sync_kiocb(&iocb, NULL);
 	iocb.private = &siocb;
 
-	ret = do_sock_write(&msg, &iocb, file, (struct iovec *)iov, nr_segs);
+	ret = do_sock_write(&msg, &iocb, file, iov, nr_segs);
 	if (-EIOCBQUEUED == ret)
 		ret = wait_on_sync_kiocb(&iocb);
 	return ret;
 }
 
-static ssize_t sock_aio_write(struct kiocb *iocb, const char __user *ubuf,
-			  size_t count, loff_t pos)
+static ssize_t sock_aio_write(struct kiocb *iocb, const struct iovec *iov,
+			  unsigned long nr_segs, loff_t pos)
 {
 	struct sock_iocb siocb, *x;
 
 	if (pos != 0)
 		return -ESPIPE;
-	if (count == 0)		/* Match SYS5 behaviour */
+
+	if (iocb->ki_left == 0)	/* Match SYS5 behaviour */
 		return 0;
 
-	x = alloc_sock_iocb(iocb, (void __user *)ubuf, count, &siocb);
+	x = alloc_sock_iocb(iocb, &siocb);
 	if (!x)
 		return -ENOMEM;
 
-	return do_sock_write(&x->async_msg, iocb, iocb->ki_filp,
-			&x->async_iov, 1);
+	return do_sock_write(&x->async_msg, iocb, iocb->ki_filp, iov, nr_segs);
 }
 
 
Index: linux-2.6.17/drivers/usb/gadget/inode.c
===================================================================
--- linux-2.6.17.orig/drivers/usb/gadget/inode.c	2006-07-05 10:57:38.000000000 -0700
+++ linux-2.6.17/drivers/usb/gadget/inode.c	2006-07-05 10:58:46.000000000 -0700
@@ -528,7 +528,8 @@ struct kiocb_priv {
 	struct usb_request	*req;
 	struct ep_data		*epdata;
 	void			*buf;
-	char __user		*ubuf;		/* NULL for writes */
+	const struct iovec	*iv;
+	unsigned long		nr_segs;
 	unsigned		actual;
 };
 
@@ -556,17 +557,32 @@ static int ep_aio_cancel(struct kiocb *i
 static ssize_t ep_aio_read_retry(struct kiocb *iocb)
 {
 	struct kiocb_priv	*priv = iocb->private;
-	ssize_t			status = priv->actual;
+	ssize_t			len, total;
+	int			i;
 
-	/* we "retry" to get the right mm context for this: */
-	status = copy_to_user(priv->ubuf, priv->buf, priv->actual);
-	if (unlikely(0 != status))
-		status = -EFAULT;
-	else
-		status = priv->actual;
-	kfree(priv->buf);
-	kfree(priv);
-	return status;
+  	/* we "retry" to get the right mm context for this: */
+
+ 	/* copy stuff into user buffers */
+ 	total = priv->actual;
+ 	len = 0;
+ 	for (i=0; i < priv->nr_segs; i++) {
+ 		ssize_t this = min((ssize_t)(priv->iv[i].iov_len), total);
+
+ 		if (copy_to_user(priv->iv[i].iov_base, priv->buf, this)) {
+ 			if (len == 0)
+ 				len = -EFAULT;
+ 			break;
+ 		}
+
+ 		total -= this;
+ 		len += this;
+ 		if (total == 0)
+ 			break;
+ 	}
+  	kfree(priv->buf);
+  	kfree(priv);
+  	aio_put_req(iocb);
+ 	return len;
 }
 
 static void ep_aio_complete(struct usb_ep *ep, struct usb_request *req)
@@ -579,7 +595,7 @@ static void ep_aio_complete(struct usb_e
 	spin_lock(&epdata->dev->lock);
 	priv->req = NULL;
 	priv->epdata = NULL;
-	if (priv->ubuf == NULL
+	if (priv->iv == NULL
 			|| unlikely(req->actual == 0)
 			|| unlikely(kiocbIsCancelled(iocb))) {
 		kfree(req->buf);
@@ -614,7 +630,8 @@ ep_aio_rwtail(
 	char		*buf,
 	size_t		len,
 	struct ep_data	*epdata,
-	char __user	*ubuf
+	const struct iovec *iv,
+	unsigned long 	nr_segs
 )
 {
 	struct kiocb_priv	*priv;
@@ -629,7 +646,8 @@ fail:
 		return value;
 	}
 	iocb->private = priv;
-	priv->ubuf = ubuf;
+	priv->iv = iv;
+	priv->nr_segs = nr_segs;
 
 	value = get_ready_ep(iocb->ki_filp->f_flags, epdata);
 	if (unlikely(value < 0)) {
@@ -669,41 +687,53 @@ fail:
 		kfree(priv);
 		put_ep(epdata);
 	} else
-		value = (ubuf ? -EIOCBRETRY : -EIOCBQUEUED);
+		value = (iv ? -EIOCBRETRY : -EIOCBQUEUED);
 	return value;
 }
 
 static ssize_t
-ep_aio_read(struct kiocb *iocb, char __user *ubuf, size_t len, loff_t o)
+ep_aio_read(struct kiocb *iocb, const struct iovec *iov,
+		unsigned long nr_segs, loff_t o)
 {
 	struct ep_data		*epdata = iocb->ki_filp->private_data;
 	char			*buf;
 
 	if (unlikely(epdata->desc.bEndpointAddress & USB_DIR_IN))
 		return -EINVAL;
-	buf = kmalloc(len, GFP_KERNEL);
+
+	buf = kmalloc(iocb->ki_left, GFP_KERNEL);
 	if (unlikely(!buf))
 		return -ENOMEM;
+
 	iocb->ki_retry = ep_aio_read_retry;
-	return ep_aio_rwtail(iocb, buf, len, epdata, ubuf);
+	return ep_aio_rwtail(iocb, buf, iocb->ki_left, epdata, iov, nr_segs);
 }
 
 static ssize_t
-ep_aio_write(struct kiocb *iocb, const char __user *ubuf, size_t len, loff_t o)
+ep_aio_write(struct kiocb *iocb, const struct iovec *iov,
+		unsigned long nr_segs, loff_t o)
 {
 	struct ep_data		*epdata = iocb->ki_filp->private_data;
 	char			*buf;
+	size_t			len = 0;
+	int			i = 0;
 
 	if (unlikely(!(epdata->desc.bEndpointAddress & USB_DIR_IN)))
 		return -EINVAL;
-	buf = kmalloc(len, GFP_KERNEL);
+
+	buf = kmalloc(iocb->ki_left, GFP_KERNEL);
 	if (unlikely(!buf))
 		return -ENOMEM;
-	if (unlikely(copy_from_user(buf, ubuf, len) != 0)) {
-		kfree(buf);
-		return -EFAULT;
+
+	for (i=0; i < nr_segs; i++) {
+		if (unlikely(copy_from_user(&buf[len], iov[i].iov_base,
+				iov[i].iov_len) != 0)) {
+			kfree(buf);
+			return -EFAULT;
+		}
+		len += iov[i].iov_len;
 	}
-	return ep_aio_rwtail(iocb, buf, len, epdata, NULL);
+	return ep_aio_rwtail(iocb, buf, len, epdata, NULL, 0);
 }
 
 /*----------------------------------------------------------------------*/
Index: linux-2.6.17/include/linux/aio.h
===================================================================
--- linux-2.6.17.orig/include/linux/aio.h	2006-06-17 18:49:35.000000000 -0700
+++ linux-2.6.17/include/linux/aio.h	2006-07-05 10:58:46.000000000 -0700
@@ -4,6 +4,7 @@
 #include <linux/list.h>
 #include <linux/workqueue.h>
 #include <linux/aio_abi.h>
+#include <linux/uio.h>
 
 #include <asm/atomic.h>
 
@@ -112,6 +113,7 @@ struct kiocb {
 	long			ki_retried; 	/* just for testing */
 	long			ki_kicked; 	/* just for testing */
 	long			ki_queued; 	/* just for testing */
+	struct iovec		ki_inline_vec;	/* inline vector */
 
 	struct list_head	ki_list;	/* the aio core uses this
 						 * for cancellation */
Index: linux-2.6.17/fs/nfs/direct.c
===================================================================
--- linux-2.6.17.orig/fs/nfs/direct.c	2006-07-05 10:57:39.000000000 -0700
+++ linux-2.6.17/fs/nfs/direct.c	2006-07-05 10:58:46.000000000 -0700
@@ -729,8 +729,8 @@ static ssize_t nfs_direct_write(struct k
 /**
  * nfs_file_direct_read - file direct read operation for NFS files
  * @iocb: target I/O control block
- * @buf: user's buffer into which to read data
- * @count: number of bytes to read
+ * @iov: vector of user buffers into which to read data
+ * @nr_segs: size of iov vector
  * @pos: byte offset in file where reading starts
  *
  * We use this function for direct reads instead of calling
@@ -747,17 +747,24 @@ static ssize_t nfs_direct_write(struct k
  * client must read the updated atime from the server back into its
  * cache.
  */
-ssize_t nfs_file_direct_read(struct kiocb *iocb, char __user *buf, size_t count, loff_t pos)
+ssize_t nfs_file_direct_read(struct kiocb *iocb, const struct iovec *iov,
+				unsigned long nr_segs, loff_t pos)
 {
 	ssize_t retval = -EINVAL;
 	struct file *file = iocb->ki_filp;
 	struct address_space *mapping = file->f_mapping;
+	/* XXX: temporary */
+	const char __user *buf = iov[0].iov_base;
+	size_t count = iov[0].iov_len;
 
 	dprintk("nfs: direct read(%s/%s, %lu@%Ld)\n",
 		file->f_dentry->d_parent->d_name.name,
 		file->f_dentry->d_name.name,
 		(unsigned long) count, (long long) pos);
 
+	if (nr_segs != 1)
+		return -EINVAL;
+
 	if (count < 0)
 		goto out;
 	retval = -EFAULT;
@@ -782,8 +789,8 @@ out:
 /**
  * nfs_file_direct_write - file direct write operation for NFS files
  * @iocb: target I/O control block
- * @buf: user's buffer from which to write data
- * @count: number of bytes to write
+ * @iov: vector of user buffers from which to write data
+ * @nr_segs: size of iov vector
  * @pos: byte offset in file where writing starts
  *
  * We use this function for direct writes instead of calling
@@ -804,17 +811,24 @@ out:
  * Note that O_APPEND is not supported for NFS direct writes, as there
  * is no atomic O_APPEND write facility in the NFS protocol.
  */
-ssize_t nfs_file_direct_write(struct kiocb *iocb, const char __user *buf, size_t count, loff_t pos)
+ssize_t nfs_file_direct_write(struct kiocb *iocb, const struct iovec *iov,
+				unsigned long nr_segs, loff_t pos)
 {
 	ssize_t retval;
 	struct file *file = iocb->ki_filp;
 	struct address_space *mapping = file->f_mapping;
+	/* XXX: temporary */
+	const char __user *buf = iov[0].iov_base;
+	size_t count = iov[0].iov_len;
 
 	dfprintk(VFS, "nfs: direct write(%s/%s, %lu@%Ld)\n",
 		file->f_dentry->d_parent->d_name.name,
 		file->f_dentry->d_name.name,
 		(unsigned long) count, (long long) pos);
 
+	if (nr_segs != 1)
+		return -EINVAL;
+
 	retval = generic_write_checks(file, &pos, &count, 0);
 	if (retval)
 		goto out;
Index: linux-2.6.17/fs/nfs/file.c
===================================================================
--- linux-2.6.17.orig/fs/nfs/file.c	2006-07-05 10:57:39.000000000 -0700
+++ linux-2.6.17/fs/nfs/file.c	2006-07-05 10:58:46.000000000 -0700
@@ -41,8 +41,10 @@ static int nfs_file_release(struct inode
 static loff_t nfs_file_llseek(struct file *file, loff_t offset, int origin);
 static int  nfs_file_mmap(struct file *, struct vm_area_struct *);
 static ssize_t nfs_file_sendfile(struct file *, loff_t *, size_t, read_actor_t, void *);
-static ssize_t nfs_file_read(struct kiocb *, char __user *, size_t, loff_t);
-static ssize_t nfs_file_write(struct kiocb *, const char __user *, size_t, loff_t);
+static ssize_t nfs_file_read(struct kiocb *, const struct iovec *iov,
+				unsigned long nr_segs, loff_t pos);
+static ssize_t nfs_file_write(struct kiocb *, const struct iovec *iov,
+				unsigned long nr_segs, loff_t pos);
 static int  nfs_file_flush(struct file *, fl_owner_t id);
 static int  nfs_fsync(struct file *, struct dentry *dentry, int datasync);
 static int nfs_check_flags(int flags);
@@ -53,8 +55,8 @@ const struct file_operations nfs_file_op
 	.llseek		= nfs_file_llseek,
 	.read		= do_sync_read,
 	.write		= do_sync_write,
-	.aio_read		= nfs_file_read,
-	.aio_write		= nfs_file_write,
+	.aio_read	= nfs_file_read,
+	.aio_write	= nfs_file_write,
 	.mmap		= nfs_file_mmap,
 	.open		= nfs_file_open,
 	.flush		= nfs_file_flush,
@@ -196,15 +198,17 @@ nfs_file_flush(struct file *file, fl_own
 }
 
 static ssize_t
-nfs_file_read(struct kiocb *iocb, char __user * buf, size_t count, loff_t pos)
+nfs_file_read(struct kiocb *iocb, const struct iovec *iov,
+		unsigned long nr_segs, loff_t pos)
 {
 	struct dentry * dentry = iocb->ki_filp->f_dentry;
 	struct inode * inode = dentry->d_inode;
 	ssize_t result;
+	size_t count = iov_length(iov, nr_segs);
 
 #ifdef CONFIG_NFS_DIRECTIO
 	if (iocb->ki_filp->f_flags & O_DIRECT)
-		return nfs_file_direct_read(iocb, buf, count, pos);
+		return nfs_file_direct_read(iocb, iov, nr_segs, pos);
 #endif
 
 	dfprintk(VFS, "nfs: read(%s/%s, %lu@%lu)\n",
@@ -214,7 +218,7 @@ nfs_file_read(struct kiocb *iocb, char _
 	result = nfs_revalidate_mapping(inode, iocb->ki_filp->f_mapping);
 	nfs_add_stats(inode, NFSIOS_NORMALREADBYTES, count);
 	if (!result)
-		result = generic_file_aio_read(iocb, buf, count, pos);
+		result = generic_file_aio_read(iocb, iov, nr_segs, pos);
 	return result;
 }
 
@@ -330,24 +334,22 @@ const struct address_space_operations nf
 #endif
 };
 
-/* 
- * Write to a file (through the page cache).
- */
-static ssize_t
-nfs_file_write(struct kiocb *iocb, const char __user *buf, size_t count, loff_t pos)
+static ssize_t nfs_file_write(struct kiocb *iocb, const struct iovec *iov,
+				unsigned long nr_segs, loff_t pos)
 {
 	struct dentry * dentry = iocb->ki_filp->f_dentry;
 	struct inode * inode = dentry->d_inode;
 	ssize_t result;
+	size_t count = iov_length(iov, nr_segs);
 
 #ifdef CONFIG_NFS_DIRECTIO
 	if (iocb->ki_filp->f_flags & O_DIRECT)
-		return nfs_file_direct_write(iocb, buf, count, pos);
+		return nfs_file_direct_write(iocb, iov, nr_segs, pos);
 #endif
 
-	dfprintk(VFS, "nfs: write(%s/%s(%ld), %lu@%lu)\n",
+	dfprintk(VFS, "nfs: write(%s/%s(%ld), %lu@%Ld)\n",
 		dentry->d_parent->d_name.name, dentry->d_name.name,
-		inode->i_ino, (unsigned long) count, (unsigned long) pos);
+		inode->i_ino, (unsigned long) count, (long long) pos);
 
 	result = -EBUSY;
 	if (IS_SWAPFILE(inode))
@@ -366,7 +368,7 @@ nfs_file_write(struct kiocb *iocb, const
 		goto out;
 
 	nfs_add_stats(inode, NFSIOS_NORMALWRITTENBYTES, count);
-	result = generic_file_aio_write(iocb, buf, count, pos);
+	result = generic_file_aio_write(iocb, iov, nr_segs, pos);
 out:
 	return result;
 
Index: linux-2.6.17/include/linux/nfs_fs.h
===================================================================
--- linux-2.6.17.orig/include/linux/nfs_fs.h	2006-07-05 10:57:46.000000000 -0700
+++ linux-2.6.17/include/linux/nfs_fs.h	2006-07-05 10:58:46.000000000 -0700
@@ -368,10 +368,12 @@ extern int nfs3_removexattr (struct dent
  */
 extern ssize_t nfs_direct_IO(int, struct kiocb *, const struct iovec *, loff_t,
 			unsigned long);
-extern ssize_t nfs_file_direct_read(struct kiocb *iocb, char __user *buf,
-			size_t count, loff_t pos);
-extern ssize_t nfs_file_direct_write(struct kiocb *iocb, const char __user *buf,
-			size_t count, loff_t pos);
+extern ssize_t nfs_file_direct_read(struct kiocb *iocb,
+			const struct iovec *iov, unsigned long nr_segs,
+			loff_t pos);
+extern ssize_t nfs_file_direct_write(struct kiocb *iocb,
+			const struct iovec *iov, unsigned long nr_segs,
+			loff_t pos);
 
 /*
  * linux/fs/nfs/dir.c
Index: linux-2.6.17/fs/ocfs2/file.c
===================================================================
--- linux-2.6.17.orig/fs/ocfs2/file.c	2006-06-17 18:49:35.000000000 -0700
+++ linux-2.6.17/fs/ocfs2/file.c	2006-07-05 10:58:46.000000000 -0700
@@ -960,25 +960,23 @@ static inline int ocfs2_write_should_rem
 }
 
 static ssize_t ocfs2_file_aio_write(struct kiocb *iocb,
-				    const char __user *buf,
-				    size_t count,
+				    const struct iovec *iov,
+				    unsigned long nr_segs,
 				    loff_t pos)
 {
-	struct iovec local_iov = { .iov_base = (void __user *)buf,
-				   .iov_len = count };
 	int ret, rw_level = -1, meta_level = -1, have_alloc_sem = 0;
 	u32 clusters;
 	struct file *filp = iocb->ki_filp;
 	struct inode *inode = filp->f_dentry->d_inode;
 	loff_t newsize, saved_pos;
 
-	mlog_entry("(0x%p, 0x%p, %u, '%.*s')\n", filp, buf,
-		   (unsigned int)count,
+	mlog_entry("(0x%p, %u, '%.*s')\n", filp,
+		   (unsigned int)nr_segs,
 		   filp->f_dentry->d_name.len,
 		   filp->f_dentry->d_name.name);
 
 	/* happy write of zero bytes */
-	if (count == 0)
+	if (iocb->ki_left == 0)
 		return 0;
 
 	if (!inode) {
@@ -1047,7 +1045,7 @@ static ssize_t ocfs2_file_aio_write(stru
 		} else {
 			saved_pos = iocb->ki_pos;
 		}
-		newsize = count + saved_pos;
+		newsize = iocb->ki_left + saved_pos;
 
 		mlog(0, "pos=%lld newsize=%lld cursize=%lld\n",
 		     (long long) saved_pos, (long long) newsize,
@@ -1080,7 +1078,7 @@ static ssize_t ocfs2_file_aio_write(stru
 		if (!clusters)
 			break;
 
-		ret = ocfs2_extend_file(inode, NULL, newsize, count);
+		ret = ocfs2_extend_file(inode, NULL, newsize, iocb->ki_left);
 		if (ret < 0) {
 			if (ret != -ENOSPC)
 				mlog_errno(ret);
@@ -1097,7 +1095,7 @@ static ssize_t ocfs2_file_aio_write(stru
 	/* communicate with ocfs2_dio_end_io */
 	ocfs2_iocb_set_rw_locked(iocb);
 
-	ret = generic_file_aio_write_nolock(iocb, &local_iov, 1, &iocb->ki_pos);
+	ret = generic_file_aio_write_nolock(iocb, iov, nr_segs, iocb->ki_pos);
 
 	/* buffered aio wouldn't have proper lock coverage today */
 	BUG_ON(ret == -EIOCBQUEUED && !(filp->f_flags & O_DIRECT));
@@ -1131,16 +1129,16 @@ out:
 }
 
 static ssize_t ocfs2_file_aio_read(struct kiocb *iocb,
-				   char __user *buf,
-				   size_t count,
+				   const struct iovec *iov,
+				   unsigned long nr_segs,
 				   loff_t pos)
 {
 	int ret = 0, rw_level = -1, have_alloc_sem = 0;
 	struct file *filp = iocb->ki_filp;
 	struct inode *inode = filp->f_dentry->d_inode;
 
-	mlog_entry("(0x%p, 0x%p, %u, '%.*s')\n", filp, buf,
-		   (unsigned int)count,
+	mlog_entry("(0x%p, %u, '%.*s')\n", filp,
+		   (unsigned int)nr_segs,
 		   filp->f_dentry->d_name.len,
 		   filp->f_dentry->d_name.name);
 
@@ -1184,7 +1182,7 @@ static ssize_t ocfs2_file_aio_read(struc
 	}
 	ocfs2_meta_unlock(inode, 0);
 
-	ret = generic_file_aio_read(iocb, buf, count, iocb->ki_pos);
+	ret = generic_file_aio_read(iocb, iov, nr_segs, iocb->ki_pos);
 	if (ret == -EINVAL)
 		mlog(ML_ERROR, "generic_file_aio_read returned -EINVAL\n");
 
Index: linux-2.6.17/fs/ntfs/file.c
===================================================================
--- linux-2.6.17.orig/fs/ntfs/file.c	2006-07-05 10:57:39.000000000 -0700
+++ linux-2.6.17/fs/ntfs/file.c	2006-07-05 10:58:46.000000000 -0700
@@ -2176,20 +2176,18 @@ out:
 /**
  * ntfs_file_aio_write -
  */
-static ssize_t ntfs_file_aio_write(struct kiocb *iocb, const char __user *buf,
-		size_t count, loff_t pos)
+static ssize_t ntfs_file_aio_write(struct kiocb *iocb, const struct iovec *iov,
+		unsigned long nr_segs, loff_t pos)
 {
 	struct file *file = iocb->ki_filp;
 	struct address_space *mapping = file->f_mapping;
 	struct inode *inode = mapping->host;
 	ssize_t ret;
-	struct iovec local_iov = { .iov_base = (void __user *)buf,
-				   .iov_len = count };
 
 	BUG_ON(iocb->ki_pos != pos);
 
 	mutex_lock(&inode->i_mutex);
-	ret = ntfs_file_aio_write_nolock(iocb, &local_iov, 1, &iocb->ki_pos);
+	ret = ntfs_file_aio_write_nolock(iocb, iov, nr_segs, &iocb->ki_pos);
 	mutex_unlock(&inode->i_mutex);
 	if (ret > 0 && ((file->f_flags & O_SYNC) || IS_SYNC(inode))) {
 		int err = sync_page_range(inode, mapping, pos, ret);
Index: linux-2.6.17/fs/gfs2/ops_file.c
===================================================================
--- linux-2.6.17.orig/fs/gfs2/ops_file.c	2006-07-05 10:57:39.000000000 -0700
+++ linux-2.6.17/fs/gfs2/ops_file.c	2006-07-05 10:58:46.000000000 -0700
@@ -165,7 +165,7 @@ static ssize_t gfs2_direct_IO_read(struc
 }
 
 /**
- * __gfs2_file_aio_read - The main GFS2 read function
+ * gfs2_file_aio_read - The main GFS2 read function
  * 
  * N.B. This is almost, but not quite the same as __generic_file_aio_read()
  * the important subtle different being that inode->i_size isn't valid
@@ -173,9 +173,9 @@ static ssize_t gfs2_direct_IO_read(struc
  * path since otherwise locking is done entirely at the page cache
  * layer.
  */
-static ssize_t __gfs2_file_aio_read(struct kiocb *iocb,
+static ssize_t gfs2_file_aio_read(struct kiocb *iocb,
 				    const struct iovec *iov,
-				    unsigned long nr_segs, loff_t *ppos)
+				    unsigned long nr_segs, loff_t pos)
 {
 	struct file *filp = iocb->ki_filp;
 	struct gfs2_inode *ip = GFS2_I(filp->f_mapping->host);
@@ -184,6 +184,7 @@ static ssize_t __gfs2_file_aio_read(stru
 	unsigned long seg;
 	size_t count;
 
+	BUG_ON(iocb->ki_pos != pos);
 	count = 0;
 	for (seg = 0; seg < nr_segs; seg++) {
 		const struct iovec *iv = &iov[seg];
@@ -206,7 +207,7 @@ static ssize_t __gfs2_file_aio_read(stru
 
 	/* coalesce the iovecs and go direct-to-BIO for O_DIRECT */
 	if (filp->f_flags & O_DIRECT) {
-		loff_t pos = *ppos, size;
+		loff_t size;
 		struct address_space *mapping;
 		struct inode *inode;
 
@@ -231,7 +232,7 @@ static ssize_t __gfs2_file_aio_read(stru
 			if (retval > 0 && !is_sync_kiocb(iocb))
 				retval = -EIOCBQUEUED;
 			if (retval > 0)
-				*ppos = pos + retval;
+				iocb->ki_pos = pos + retval;
 		}
 		file_accessed(filp);
 		gfs2_glock_dq_m(1, &gh);
@@ -251,7 +252,8 @@ fallback_to_normal:
 			if (desc.count == 0)
 				continue;
 			desc.error = 0;
-			do_generic_file_read(filp,ppos,&desc,file_read_actor);
+			do_generic_file_read(filp, &iocb->ki_pos, &desc,
+						file_read_actor);
 			retval += desc.written;
 			if (desc.error) {
 				retval = retval ?: desc.error;
@@ -283,7 +285,8 @@ static ssize_t gfs2_read(struct file *fi
 	ssize_t ret;
 
 	init_sync_kiocb(&kiocb, filp);
-	ret = __gfs2_file_aio_read(&kiocb, &local_iov, 1, offset);
+	kiocb.ki_pos = *offset;
+	ret = gfs2_file_aio_read(&kiocb, &local_iov, 1, *offset);
 	if (-EIOCBQUEUED == ret)
 		ret = wait_on_sync_kiocb(&kiocb);
 	return ret;
@@ -296,22 +299,13 @@ static ssize_t gfs2_file_readv(struct fi
 	ssize_t ret;
 
 	init_sync_kiocb(&kiocb, filp);
-	ret = __gfs2_file_aio_read(&kiocb, iov, nr_segs, ppos);
+	kiocb.ki_pos = *ppos;
+	ret = gfs2_file_aio_read(&kiocb, iov, nr_segs, *ppos);
 	if (-EIOCBQUEUED == ret)
 		ret = wait_on_sync_kiocb(&kiocb);
 	return ret;
 }
 
-static ssize_t gfs2_file_aio_read(struct kiocb *iocb, char __user *buf,
-				  size_t count, loff_t pos)
-{
-        struct iovec local_iov = { .iov_base = buf, .iov_len = count };
-
-        BUG_ON(iocb->ki_pos != pos);
-        return __gfs2_file_aio_read(iocb, &local_iov, 1, &iocb->ki_pos);
-}
-
-
 /**
  * filldir_reg_func - Report a directory entry to the caller of gfs2_dir_read()
  * @opaque: opaque data used by the function


