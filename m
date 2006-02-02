Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932105AbWBBQNy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbWBBQNy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 11:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbWBBQNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 11:13:54 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:33682 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932099AbWBBQNw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 11:13:52 -0500
Subject: [PATCH 1/3] Vectorize aio_read/aio_write methods
From: Badari Pulavarty <pbadari@us.ibm.com>
To: christoph <hch@lst.de>
Cc: Benjamin LaHaise <bcrl@kvack.org>, Zach Brown <zach.brown@oracle.com>,
       lkml <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>
In-Reply-To: <1138896758.28382.112.camel@dyn9047017102.beaverton.ibm.com>
References: <1138896758.28382.112.camel@dyn9047017102.beaverton.ibm.com>
Content-Type: multipart/mixed; boundary="=-P5uGF8ktv1dKdmfHkwJI"
Date: Thu, 02 Feb 2006 08:14:38 -0800
Message-Id: <1138896879.28382.114.camel@dyn9047017102.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-P5uGF8ktv1dKdmfHkwJI
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch vectorizes aio_read() and aio_write() methods to prepare
for colapsing all the vectored operations into one interface -
which is aio_read()/aio_write().


Thanks,
Badari

--=-P5uGF8ktv1dKdmfHkwJI
Content-Disposition: attachment; filename=aiovector.patch
Content-Type: text/x-patch; name=aiovector.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

This patch vectorizes aio_read() and aio_write() methods to prepare
for colapsing all the vectored operations into one interface -
which is aio_read()/aio_write().


Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>
Index: linux-2.6.16-rc1.quilt/Documentation/filesystems/Locking
===================================================================
--- linux-2.6.16-rc1.quilt.orig/Documentation/filesystems/Locking	2006-02-01 16:36:55.000000000 -0800
+++ linux-2.6.16-rc1.quilt/Documentation/filesystems/Locking	2006-02-01 16:38:14.000000000 -0800
@@ -355,10 +355,9 @@
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
Index: linux-2.6.16-rc1.quilt/Documentation/filesystems/vfs.txt
===================================================================
--- linux-2.6.16-rc1.quilt.orig/Documentation/filesystems/vfs.txt	2006-02-01 16:36:55.000000000 -0800
+++ linux-2.6.16-rc1.quilt/Documentation/filesystems/vfs.txt	2006-02-01 16:38:14.000000000 -0800
@@ -526,9 +526,9 @@
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
Index: linux-2.6.16-rc1.quilt/drivers/char/raw.c
===================================================================
--- linux-2.6.16-rc1.quilt.orig/drivers/char/raw.c	2006-02-01 16:36:55.000000000 -0800
+++ linux-2.6.16-rc1.quilt/drivers/char/raw.c	2006-02-01 16:38:14.000000000 -0800
@@ -249,23 +249,11 @@
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
 static struct file_operations raw_fops = {
 	.read	=	generic_file_read,
 	.aio_read = 	generic_file_aio_read,
 	.write	=	raw_file_write,
-	.aio_write = 	raw_file_aio_write,
+	.aio_write = 	generic_file_aio_write_nolock,
 	.open	=	raw_open,
 	.release=	raw_release,
 	.ioctl	=	raw_ioctl,
Index: linux-2.6.16-rc1.quilt/fs/aio.c
===================================================================
--- linux-2.6.16-rc1.quilt.orig/fs/aio.c	2006-02-01 16:36:55.000000000 -0800
+++ linux-2.6.16-rc1.quilt/fs/aio.c	2006-02-01 16:38:14.000000000 -0800
@@ -15,6 +15,7 @@
 #include <linux/aio_abi.h>
 #include <linux/module.h>
 #include <linux/syscalls.h>
+#include <linux/uio.h>
 
 #define DEBUG 0
 
@@ -1316,8 +1317,12 @@
 	ssize_t ret = 0;
 
 	do {
-		ret = file->f_op->aio_read(iocb, iocb->ki_buf,
-			iocb->ki_left, iocb->ki_pos);
+		struct iovec iov = {
+			.iov_base = iocb->ki_buf,
+			.iov_len = iocb->ki_left
+		};
+
+		ret = file->f_op->aio_read(iocb, &iov, 1, iocb->ki_pos);
 		/*
 		 * Can't just depend on iocb->ki_left to determine
 		 * whether we are done. This may have been a short read.
@@ -1350,8 +1355,12 @@
 	ssize_t ret = 0;
 
 	do {
-		ret = file->f_op->aio_write(iocb, iocb->ki_buf,
-			iocb->ki_left, iocb->ki_pos);
+		struct iovec iov = {
+			.iov_base = iocb->ki_buf,
+			.iov_len = iocb->ki_left
+		};
+
+		ret = file->f_op->aio_write(iocb, &iov, 1, iocb->ki_pos);
 		if (ret > 0) {
 			iocb->ki_buf += ret;
 			iocb->ki_left -= ret;
Index: linux-2.6.16-rc1.quilt/fs/block_dev.c
===================================================================
--- linux-2.6.16-rc1.quilt.orig/fs/block_dev.c	2006-02-01 16:36:55.000000000 -0800
+++ linux-2.6.16-rc1.quilt/fs/block_dev.c	2006-02-01 16:38:14.000000000 -0800
@@ -769,14 +769,6 @@
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
@@ -799,7 +791,7 @@
 	.read		= generic_file_read,
 	.write		= blkdev_file_write,
   	.aio_read	= generic_file_aio_read,
-  	.aio_write	= blkdev_file_aio_write, 
+  	.aio_write	= generic_file_aio_write_nolock,
 	.mmap		= generic_file_mmap,
 	.fsync		= block_fsync,
 	.unlocked_ioctl	= block_ioctl,
Index: linux-2.6.16-rc1.quilt/fs/cifs/cifsfs.c
===================================================================
--- linux-2.6.16-rc1.quilt.orig/fs/cifs/cifsfs.c	2006-02-01 16:36:55.000000000 -0800
+++ linux-2.6.16-rc1.quilt/fs/cifs/cifsfs.c	2006-02-01 16:38:14.000000000 -0800
@@ -501,13 +501,13 @@
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
Index: linux-2.6.16-rc1.quilt/fs/ext3/file.c
===================================================================
--- linux-2.6.16-rc1.quilt.orig/fs/ext3/file.c	2006-02-01 16:36:55.000000000 -0800
+++ linux-2.6.16-rc1.quilt/fs/ext3/file.c	2006-02-01 16:38:14.000000000 -0800
@@ -48,14 +48,15 @@
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
Index: linux-2.6.16-rc1.quilt/fs/nfs/file.c
===================================================================
--- linux-2.6.16-rc1.quilt.orig/fs/nfs/file.c	2006-02-01 16:36:55.000000000 -0800
+++ linux-2.6.16-rc1.quilt/fs/nfs/file.c	2006-02-01 16:38:14.000000000 -0800
@@ -40,8 +40,10 @@
 static loff_t nfs_file_llseek(struct file *file, loff_t offset, int origin);
 static int  nfs_file_mmap(struct file *, struct vm_area_struct *);
 static ssize_t nfs_file_sendfile(struct file *, loff_t *, size_t, read_actor_t, void *);
-static ssize_t nfs_file_read(struct kiocb *, char __user *, size_t, loff_t);
-static ssize_t nfs_file_write(struct kiocb *, const char __user *, size_t, loff_t);
+static ssize_t nfs_file_read(struct kiocb *, const struct iovec *,
+		unsigned long, loff_t);
+static ssize_t nfs_file_write(struct kiocb *, const struct iovec *,
+		unsigned long, loff_t);
 static int  nfs_file_flush(struct file *);
 static int  nfs_fsync(struct file *, struct dentry *dentry, int datasync);
 static int nfs_check_flags(int flags);
@@ -52,8 +54,8 @@
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
@@ -213,7 +215,8 @@
 }
 
 static ssize_t
-nfs_file_read(struct kiocb *iocb, char __user * buf, size_t count, loff_t pos)
+nfs_file_read(struct kiocb *iocb, const struct iovec *iov,
+		unsigned long nr_segs, loff_t pos)
 {
 	struct dentry * dentry = iocb->ki_filp->f_dentry;
 	struct inode * inode = dentry->d_inode;
@@ -221,16 +224,15 @@
 
 #ifdef CONFIG_NFS_DIRECTIO
 	if (iocb->ki_filp->f_flags & O_DIRECT)
-		return nfs_file_direct_read(iocb, buf, count, pos);
+		return nfs_file_direct_read(iocb, iov, nr_segs, pos);
 #endif
 
-	dfprintk(VFS, "nfs: read(%s/%s, %lu@%lu)\n",
-		dentry->d_parent->d_name.name, dentry->d_name.name,
-		(unsigned long) count, (unsigned long) pos);
+	dfprintk(VFS, "nfs: read(%s/%s)\n",
+		dentry->d_parent->d_name.name, dentry->d_name.name);
 
 	result = nfs_revalidate_file(inode, iocb->ki_filp);
 	if (!result)
-		result = generic_file_aio_read(iocb, buf, count, pos);
+		result = generic_file_aio_read(iocb, iov, nr_segs, pos);
 	return result;
 }
 
@@ -333,7 +335,8 @@
  * Write to a file (through the page cache).
  */
 static ssize_t
-nfs_file_write(struct kiocb *iocb, const char __user *buf, size_t count, loff_t pos)
+nfs_file_write(struct kiocb *iocb, const struct iovec *iov,
+		unsigned long nr_segs, loff_t pos)
 {
 	struct dentry * dentry = iocb->ki_filp->f_dentry;
 	struct inode * inode = dentry->d_inode;
@@ -341,12 +344,12 @@
 
 #ifdef CONFIG_NFS_DIRECTIO
 	if (iocb->ki_filp->f_flags & O_DIRECT)
-		return nfs_file_direct_write(iocb, buf, count, pos);
+		return nfs_file_direct_write(iocb, iov, nr_segs, pos);
 #endif
 
-	dfprintk(VFS, "nfs: write(%s/%s(%ld), %lu@%lu)\n",
+	dfprintk(VFS, "nfs: write(%s/%s(%ld))\n",
 		dentry->d_parent->d_name.name, dentry->d_name.name,
-		inode->i_ino, (unsigned long) count, (unsigned long) pos);
+		inode->i_ino);
 
 	result = -EBUSY;
 	if (IS_SWAPFILE(inode))
@@ -361,11 +364,7 @@
 	}
 	nfs_revalidate_mapping(inode, iocb->ki_filp->f_mapping);
 
-	result = count;
-	if (!count)
-		goto out;
-
-	result = generic_file_aio_write(iocb, buf, count, pos);
+	result = generic_file_aio_write(iocb, iov, nr_segs, pos);
 out:
 	return result;
 
Index: linux-2.6.16-rc1.quilt/fs/read_write.c
===================================================================
--- linux-2.6.16-rc1.quilt.orig/fs/read_write.c	2006-02-01 16:36:55.000000000 -0800
+++ linux-2.6.16-rc1.quilt/fs/read_write.c	2006-02-01 16:38:14.000000000 -0800
@@ -227,16 +227,21 @@
 
 ssize_t do_sync_read(struct file *filp, char __user *buf, size_t len, loff_t *ppos)
 {
+	struct iovec iov = { .iov_base = buf, .iov_len = len };
 	struct kiocb kiocb;
 	ssize_t ret;
 
 	init_sync_kiocb(&kiocb, filp);
 	kiocb.ki_pos = *ppos;
-	while (-EIOCBRETRY ==
-		(ret = filp->f_op->aio_read(&kiocb, buf, len, kiocb.ki_pos)))
+
+	for (;;) {
+		ret = filp->f_op->aio_read(&kiocb, &iov, 1, kiocb.ki_pos);
+		if (ret != -EIOCBRETRY)
+			break;
 		wait_on_retry_sync_kiocb(&kiocb);
+	}
 
-	if (-EIOCBQUEUED == ret)
+	if (ret == -EIOCBQUEUED)
 		ret = wait_on_sync_kiocb(&kiocb);
 	*ppos = kiocb.ki_pos;
 	return ret;
@@ -279,14 +284,19 @@
 
 ssize_t do_sync_write(struct file *filp, const char __user *buf, size_t len, loff_t *ppos)
 {
+	struct iovec iov = { .iov_base = (void __user *)buf, .iov_len = len };
 	struct kiocb kiocb;
 	ssize_t ret;
 
 	init_sync_kiocb(&kiocb, filp);
 	kiocb.ki_pos = *ppos;
-	while (-EIOCBRETRY ==
-	       (ret = filp->f_op->aio_write(&kiocb, buf, len, kiocb.ki_pos)))
+
+	for (;;) {
+		ret = filp->f_op->aio_write(&kiocb, &iov, 1, kiocb.ki_pos);
+		if (ret != -EIOCBRETRY)
+			break;
 		wait_on_retry_sync_kiocb(&kiocb);
+	}
 
 	if (-EIOCBQUEUED == ret)
 		ret = wait_on_sync_kiocb(&kiocb);
Index: linux-2.6.16-rc1.quilt/fs/reiserfs/file.c
===================================================================
--- linux-2.6.16-rc1.quilt.orig/fs/reiserfs/file.c	2006-02-01 16:36:55.000000000 -0800
+++ linux-2.6.16-rc1.quilt/fs/reiserfs/file.c	2006-02-01 16:38:14.000000000 -0800
@@ -1541,12 +1541,6 @@
 	return res;
 }
 
-static ssize_t reiserfs_aio_write(struct kiocb *iocb, const char __user * buf,
-				  size_t count, loff_t pos)
-{
-	return generic_file_aio_write(iocb, buf, count, pos);
-}
-
 struct file_operations reiserfs_file_operations = {
 	.read = generic_file_read,
 	.write = reiserfs_file_write,
@@ -1556,7 +1550,7 @@
 	.fsync = reiserfs_sync_file,
 	.sendfile = generic_file_sendfile,
 	.aio_read = generic_file_aio_read,
-	.aio_write = reiserfs_aio_write,
+	.aio_write = generic_file_aio_write,
 };
 
 struct inode_operations reiserfs_file_inode_operations = {
Index: linux-2.6.16-rc1.quilt/fs/xfs/linux-2.6/xfs_file.c
===================================================================
--- linux-2.6.16-rc1.quilt.orig/fs/xfs/linux-2.6/xfs_file.c	2006-02-01 16:36:55.000000000 -0800
+++ linux-2.6.16-rc1.quilt/fs/xfs/linux-2.6/xfs_file.c	2006-02-01 16:38:14.000000000 -0800
@@ -51,12 +51,11 @@
 STATIC inline ssize_t
 __linvfs_read(
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
 	vnode_t			*vp = LINVFS_GET_VP(file->f_dentry->d_inode);
 	ssize_t			rval;
@@ -65,7 +64,7 @@
 
 	if (unlikely(file->f_flags & O_DIRECT))
 		ioflags |= IO_ISDIRECT;
-	VOP_READ(vp, iocb, &iov, 1, &iocb->ki_pos, ioflags, NULL, rval);
+	VOP_READ(vp, iocb, iov, nr_segs, &iocb->ki_pos, ioflags, NULL, rval);
 	return rval;
 }
 
@@ -73,33 +72,32 @@
 STATIC ssize_t
 linvfs_aio_read(
 	struct kiocb		*iocb,
-	char			__user *buf,
-	size_t			count,
+	const struct iovec	*iov,
+	unsigned long		nr_segs,
 	loff_t			pos)
 {
-	return __linvfs_read(iocb, buf, IO_ISAIO, count, pos);
+	return __linvfs_read(iocb, iov, nr_segs, IO_ISAIO, pos);
 }
 
 STATIC ssize_t
 linvfs_aio_read_invis(
 	struct kiocb		*iocb,
-	char			__user *buf,
-	size_t			count,
+	const struct iovec	*iov,
+	unsigned long		nr_segs,
 	loff_t			pos)
 {
-	return __linvfs_read(iocb, buf, IO_ISAIO|IO_INVIS, count, pos);
+	return __linvfs_read(iocb, iov, nr_segs, IO_ISAIO|IO_INVIS, pos);
 }
 
 
 STATIC inline ssize_t
 __linvfs_write(
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
 	vnode_t		*vp = LINVFS_GET_VP(inode);
@@ -109,7 +107,7 @@
 	if (unlikely(file->f_flags & O_DIRECT))
 		ioflags |= IO_ISDIRECT;
 
-	VOP_WRITE(vp, iocb, &iov, 1, &iocb->ki_pos, ioflags, NULL, rval);
+	VOP_WRITE(vp, iocb, iov, nr_segs, &iocb->ki_pos, ioflags, NULL, rval);
 	return rval;
 }
 
@@ -117,21 +115,21 @@
 STATIC ssize_t
 linvfs_aio_write(
 	struct kiocb		*iocb,
-	const char		__user *buf,
-	size_t			count,
+	const struct iovec	*iov,
+	unsigned long		nr_segs,
 	loff_t			pos)
 {
-	return __linvfs_write(iocb, buf, IO_ISAIO, count, pos);
+	return __linvfs_write(iocb, iov, nr_segs, IO_ISAIO, pos);
 }
 
 STATIC ssize_t
 linvfs_aio_write_invis(
 	struct kiocb		*iocb,
-	const char		__user *buf,
-	size_t			count,
+	const struct iovec	*iov,
+	unsigned long		nr_segs,
 	loff_t			pos)
 {
-	return __linvfs_write(iocb, buf, IO_ISAIO|IO_INVIS, count, pos);
+	return __linvfs_write(iocb, iov, nr_segs, IO_ISAIO|IO_INVIS, pos);
 }
 
 
Index: linux-2.6.16-rc1.quilt/include/linux/fs.h
===================================================================
--- linux-2.6.16-rc1.quilt.orig/include/linux/fs.h	2006-02-01 16:36:55.000000000 -0800
+++ linux-2.6.16-rc1.quilt/include/linux/fs.h	2006-02-01 16:38:14.000000000 -0800
@@ -997,9 +997,9 @@
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
@@ -1558,11 +1558,11 @@
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
Index: linux-2.6.16-rc1.quilt/include/net/sock.h
===================================================================
--- linux-2.6.16-rc1.quilt.orig/include/net/sock.h	2006-02-01 16:36:55.000000000 -0800
+++ linux-2.6.16-rc1.quilt/include/net/sock.h	2006-02-01 16:38:14.000000000 -0800
@@ -650,7 +650,6 @@
 	struct sock		*sk;
 	struct scm_cookie	*scm;
 	struct msghdr		*msg, async_msg;
-	struct iovec		async_iov;
 	struct kiocb		*kiocb;
 };
 
Index: linux-2.6.16-rc1.quilt/mm/filemap.c
===================================================================
--- linux-2.6.16-rc1.quilt.orig/mm/filemap.c	2006-02-01 16:36:55.000000000 -0800
+++ linux-2.6.16-rc1.quilt/mm/filemap.c	2006-02-01 16:38:14.000000000 -0800
@@ -1064,14 +1064,12 @@
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
-
 EXPORT_SYMBOL(generic_file_aio_read);
 
 ssize_t
@@ -2131,22 +2129,21 @@
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
+	ret = __generic_file_aio_write_nolock(iocb, iov, nr_segs, &iocb->ki_pos);
 
 	if (ret > 0 && ((file->f_flags & O_SYNC) || IS_SYNC(inode))) {
-		int err;
+		ssize_t err;
 
 		err = sync_page_range_nolock(inode, mapping, pos, ret);
 		if (err < 0)
@@ -2154,6 +2151,7 @@
 	}
 	return ret;
 }
+EXPORT_SYMBOL(generic_file_aio_write_nolock);
 
 static ssize_t
 __generic_file_write_nolock(struct file *file, const struct iovec *iov,
@@ -2163,9 +2161,11 @@
 	ssize_t ret;
 
 	init_sync_kiocb(&kiocb, file);
+	kiocb.ki_pos = *ppos;
 	ret = __generic_file_aio_write_nolock(&kiocb, iov, nr_segs, ppos);
-	if (ret == -EIOCBQUEUED)
+	if (-EIOCBQUEUED == ret)
 		ret = wait_on_sync_kiocb(&kiocb);
+	*ppos = kiocb.ki_pos;
 	return ret;
 }
 
@@ -2177,28 +2177,27 @@
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
+	ret = __generic_file_aio_write_nolock(iocb, iov, nr_segs, &iocb->ki_pos);
 	mutex_unlock(&inode->i_mutex);
 
 	if (ret > 0 && ((file->f_flags & O_SYNC) || IS_SYNC(inode))) {
Index: linux-2.6.16-rc1.quilt/net/socket.c
===================================================================
--- linux-2.6.16-rc1.quilt.orig/net/socket.c	2006-02-01 16:36:55.000000000 -0800
+++ linux-2.6.16-rc1.quilt/net/socket.c	2006-02-01 16:38:14.000000000 -0800
@@ -98,10 +98,10 @@
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
@@ -635,11 +635,6 @@
 	return result;
 }
 
-static void sock_aio_dtor(struct kiocb *iocb)
-{
-	kfree(iocb->private);
-}
-
 static ssize_t sock_sendpage(struct file *file, struct page *page,
 			     int offset, size_t size, loff_t *ppos, int more)
 {
@@ -655,8 +650,13 @@
 	return sock->ops->sendpage(sock, page, offset, size, flags);
 }
 
+static void sock_aio_dtor(struct kiocb *iocb)
+{
+	kfree(iocb->private);
+}
+
 static struct sock_iocb *alloc_sock_iocb(struct kiocb *iocb,
-		char __user *ubuf, size_t size, struct sock_iocb *siocb)
+		struct sock_iocb *siocb)
 {
 	if (!is_sync_kiocb(iocb)) {
 		siocb = kmalloc(sizeof(*siocb), GFP_KERNEL);
@@ -666,15 +666,13 @@
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
@@ -705,31 +703,33 @@
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
+#if 0
 	if (count == 0)		/* Match SYS5 behaviour */
 		return 0;
+#endif
 
-	x = alloc_sock_iocb(iocb, ubuf, count, &siocb);
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
@@ -762,28 +762,29 @@
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
+#if 0
 	if (count == 0)		/* Match SYS5 behaviour */
 		return 0;
+#endif
 
-	x = alloc_sock_iocb(iocb, (void __user *)ubuf, count, &siocb);
+	x = alloc_sock_iocb(iocb, &siocb);
 	if (!x)
 		return -ENOMEM;
 
-	return do_sock_write(&x->async_msg, iocb, iocb->ki_filp,
-			&x->async_iov, 1);
+	return do_sock_write(&x->async_msg, iocb, iocb->ki_filp, iov, nr_segs);
 }
 
 
Index: linux-2.6.16-rc1.quilt/fs/nfs/direct.c
===================================================================
--- linux-2.6.16-rc1.quilt.orig/fs/nfs/direct.c	2006-02-01 16:36:55.000000000 -0800
+++ linux-2.6.16-rc1.quilt/fs/nfs/direct.c	2006-02-01 16:38:14.000000000 -0800
@@ -648,7 +648,8 @@
  * cache.
  */
 ssize_t
-nfs_file_direct_read(struct kiocb *iocb, char __user *buf, size_t count, loff_t pos)
+nfs_file_direct_read(struct kiocb *iocb, const struct iovec *iov,
+			unsigned long nr_segs, loff_t pos)
 {
 	ssize_t retval = -EINVAL;
 	loff_t *ppos = &iocb->ki_pos;
@@ -657,10 +658,11 @@
 			(struct nfs_open_context *) file->private_data;
 	struct address_space *mapping = file->f_mapping;
 	struct inode *inode = mapping->host;
-	struct iovec iov = {
-		.iov_base = buf,
-		.iov_len = count,
-	};
+	ssize_t count;
+
+	/* FIXME: Can we have multiple vectors here ? */
+	BUG_ON(nr_segs != 1);
+	count = iov->iov_len;
 
 	dprintk("nfs: direct read(%s/%s, %lu@%Ld)\n",
 		file->f_dentry->d_parent->d_name.name,
@@ -672,7 +674,7 @@
 	if (count < 0)
 		goto out;
 	retval = -EFAULT;
-	if (!access_ok(VERIFY_WRITE, iov.iov_base, iov.iov_len))
+	if (!access_ok(VERIFY_WRITE, iov->iov_base, iov->iov_len))
 		goto out;
 	retval = 0;
 	if (!count)
@@ -682,7 +684,7 @@
 	if (retval)
 		goto out;
 
-	retval = nfs_direct_read(inode, ctx, &iov, pos, 1);
+	retval = nfs_direct_read(inode, ctx, iov, pos, 1);
 	if (retval > 0)
 		*ppos = pos + retval;
 
@@ -716,7 +718,8 @@
  * is no atomic O_APPEND write facility in the NFS protocol.
  */
 ssize_t
-nfs_file_direct_write(struct kiocb *iocb, const char __user *buf, size_t count, loff_t pos)
+nfs_file_direct_write(struct kiocb *iocb, const struct iovec *iov,
+			unsigned long nr_segs, loff_t pos)
 {
 	ssize_t retval;
 	struct file *file = iocb->ki_filp;
@@ -724,9 +727,11 @@
 			(struct nfs_open_context *) file->private_data;
 	struct address_space *mapping = file->f_mapping;
 	struct inode *inode = mapping->host;
-	struct iovec iov = {
-		.iov_base = (char __user *)buf,
-	};
+	ssize_t count;
+
+	/* FIXME: Can we have multiple vectors here ? */
+	BUG_ON(nr_segs != 1);
+	count = iov->iov_len;
 
 	dfprintk(VFS, "nfs: direct write(%s/%s, %lu@%Ld)\n",
 		file->f_dentry->d_parent->d_name.name,
@@ -747,17 +752,16 @@
 	retval = 0;
 	if (!count)
 		goto out;
-	iov.iov_len = count,
 
 	retval = -EFAULT;
-	if (!access_ok(VERIFY_READ, iov.iov_base, iov.iov_len))
+	if (!access_ok(VERIFY_READ, iov->iov_base, iov->iov_len))
 		goto out;
 
 	retval = nfs_sync_mapping(mapping);
 	if (retval)
 		goto out;
 
-	retval = nfs_direct_write(inode, ctx, &iov, pos, 1);
+	retval = nfs_direct_write(inode, ctx, iov, pos, 1);
 	if (mapping->nrpages)
 		invalidate_inode_pages2(mapping);
 	if (retval > 0)
Index: linux-2.6.16-rc1.quilt/include/linux/nfs_fs.h
===================================================================
--- linux-2.6.16-rc1.quilt.orig/include/linux/nfs_fs.h	2006-02-01 16:36:55.000000000 -0800
+++ linux-2.6.16-rc1.quilt/include/linux/nfs_fs.h	2006-02-01 16:38:14.000000000 -0800
@@ -369,10 +369,10 @@
  */
 extern ssize_t nfs_direct_IO(int, struct kiocb *, const struct iovec *, loff_t,
 			unsigned long);
-extern ssize_t nfs_file_direct_read(struct kiocb *iocb, char __user *buf,
-			size_t count, loff_t pos);
-extern ssize_t nfs_file_direct_write(struct kiocb *iocb, const char __user *buf,
-			size_t count, loff_t pos);
+extern ssize_t nfs_file_direct_read(struct kiocb *iocb, const struct iovec *,
+			unsigned long nr_segs, loff_t pos);
+extern ssize_t nfs_file_direct_write(struct kiocb *iocb, const struct iovec *,
+			unsigned long nr_segs, loff_t pos);
 
 /*
  * linux/fs/nfs/dir.c
Index: linux-2.6.16-rc1.quilt/drivers/usb/gadget/inode.c
===================================================================
--- linux-2.6.16-rc1.quilt.orig/drivers/usb/gadget/inode.c	2006-02-01 16:16:50.000000000 -0800
+++ linux-2.6.16-rc1.quilt/drivers/usb/gadget/inode.c	2006-02-01 16:39:06.000000000 -0800
@@ -675,32 +675,46 @@
 }
 
 static ssize_t
-ep_aio_read(struct kiocb *iocb, char __user *ubuf, size_t len, loff_t o)
+ep_aio_read(struct kiocb *iocb, const struct iovec *iv,
+		unsigned long count, loff_t o)
 {
 	struct ep_data		*epdata = iocb->ki_filp->private_data;
 	char			*buf;
+	size_t			len;
 
 	if (unlikely(epdata->desc.bEndpointAddress & USB_DIR_IN))
 		return -EINVAL;
+
+	/* FIXME: Can we really get a vector here ? If so, handle it */
+	BUG_ON(count != 1);
+	len = iv->iov_len;
+
 	buf = kmalloc(len, GFP_KERNEL);
 	if (unlikely(!buf))
 		return -ENOMEM;
 	iocb->ki_retry = ep_aio_read_retry;
-	return ep_aio_rwtail(iocb, buf, len, epdata, ubuf);
+	return ep_aio_rwtail(iocb, buf, len, epdata, iv->iov_base);
 }
 
 static ssize_t
-ep_aio_write(struct kiocb *iocb, const char __user *ubuf, size_t len, loff_t o)
+ep_aio_write(struct kiocb *iocb, const struct iovec *iv,
+		unsigned long count, loff_t o)
 {
 	struct ep_data		*epdata = iocb->ki_filp->private_data;
 	char			*buf;
+	size_t			len;
 
 	if (unlikely(!(epdata->desc.bEndpointAddress & USB_DIR_IN)))
 		return -EINVAL;
+
+	/* FIXME: Can we really get a vector here ? If so, handle it */
+	BUG_ON(count != 1);
+	len = iv->iov_len;
+
 	buf = kmalloc(len, GFP_KERNEL);
 	if (unlikely(!buf))
 		return -ENOMEM;
-	if (unlikely(copy_from_user(buf, ubuf, len) != 0)) {
+	if (unlikely(copy_from_user(buf, iv->iov_base, len) != 0)) {
 		kfree(buf);
 		return -EFAULT;
 	}

--=-P5uGF8ktv1dKdmfHkwJI--

