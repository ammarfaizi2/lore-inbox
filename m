Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751889AbWCHAUl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751889AbWCHAUl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 19:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751833AbWCHAUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 19:20:41 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:43747 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751825AbWCHAUj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 19:20:39 -0500
Subject: [PATCH 1/3] Vectorize aio_read/aio_write methods
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Zach Brown <zach.brown@oracle.com>
Cc: christoph <hch@lst.de>, lkml <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>
In-Reply-To: <1141777204.17095.33.camel@dyn9047017100.beaverton.ibm.com>
References: <1141777204.17095.33.camel@dyn9047017100.beaverton.ibm.com>
Content-Type: multipart/mixed; boundary="=-dLEXWUOxgd91Lv2g1L18"
Date: Tue, 07 Mar 2006 16:22:10 -0800
Message-Id: <1141777330.17095.36.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-dLEXWUOxgd91Lv2g1L18
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch vectorizes aio_read() and aio_write() methods to prepare
for colapsing all the vectored operations into one interface -
which is aio_read()/aio_write().



--=-dLEXWUOxgd91Lv2g1L18
Content-Disposition: attachment; filename=aiovector.patch
Content-Type: text/x-patch; name=aiovector.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

This patch vectorizes aio_read() and aio_write() methods to prepare
for colapsing all the vectored operations into one interface -
which is aio_read()/aio_write().


Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>
Index: linux-2.6.16-rc5/Documentation/filesystems/Locking
===================================================================
--- linux-2.6.16-rc5.orig/Documentation/filesystems/Locking	2006-02-26 21:09:35.000000000 -0800
+++ linux-2.6.16-rc5/Documentation/filesystems/Locking	2006-02-27 08:33:22.000000000 -0800
@@ -355,10 +355,9 @@ The last two are called only from check_
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
Index: linux-2.6.16-rc5/Documentation/filesystems/vfs.txt
===================================================================
--- linux-2.6.16-rc5.orig/Documentation/filesystems/vfs.txt	2006-02-26 21:09:35.000000000 -0800
+++ linux-2.6.16-rc5/Documentation/filesystems/vfs.txt	2006-02-27 08:33:22.000000000 -0800
@@ -526,9 +526,9 @@ This describes how the VFS can manipulat
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
Index: linux-2.6.16-rc5/drivers/char/raw.c
===================================================================
--- linux-2.6.16-rc5.orig/drivers/char/raw.c	2006-02-26 21:09:35.000000000 -0800
+++ linux-2.6.16-rc5/drivers/char/raw.c	2006-03-07 13:52:28.000000000 -0800
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
 static struct file_operations raw_fops = {
 	.read	=	generic_file_read,
 	.aio_read = 	generic_file_aio_read,
 	.write	=	raw_file_write,
-	.aio_write = 	raw_file_aio_write,
+	.aio_write = 	generic_file_aio_write_nolock,
 	.open	=	raw_open,
 	.release=	raw_release,
 	.ioctl	=	raw_ioctl,
Index: linux-2.6.16-rc5/fs/aio.c
===================================================================
--- linux-2.6.16-rc5.orig/fs/aio.c	2006-02-26 21:09:35.000000000 -0800
+++ linux-2.6.16-rc5/fs/aio.c	2006-03-07 13:44:09.000000000 -0800
@@ -15,6 +15,7 @@
 #include <linux/aio_abi.h>
 #include <linux/module.h>
 #include <linux/syscalls.h>
+#include <linux/uio.h>
 
 #define DEBUG 0
 
@@ -1316,8 +1317,11 @@ static ssize_t aio_pread(struct kiocb *i
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
@@ -1350,8 +1354,11 @@ static ssize_t aio_pwrite(struct kiocb *
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
Index: linux-2.6.16-rc5/fs/block_dev.c
===================================================================
--- linux-2.6.16-rc5.orig/fs/block_dev.c	2006-02-26 21:09:35.000000000 -0800
+++ linux-2.6.16-rc5/fs/block_dev.c	2006-03-07 13:52:28.000000000 -0800
@@ -769,14 +769,6 @@ static ssize_t blkdev_file_write(struct 
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
@@ -799,7 +791,7 @@ struct file_operations def_blk_fops = {
 	.read		= generic_file_read,
 	.write		= blkdev_file_write,
   	.aio_read	= generic_file_aio_read,
-  	.aio_write	= blkdev_file_aio_write, 
+  	.aio_write	= generic_file_aio_write_nolock,
 	.mmap		= generic_file_mmap,
 	.fsync		= block_fsync,
 	.unlocked_ioctl	= block_ioctl,
Index: linux-2.6.16-rc5/fs/cifs/cifsfs.c
===================================================================
--- linux-2.6.16-rc5.orig/fs/cifs/cifsfs.c	2006-02-26 21:09:35.000000000 -0800
+++ linux-2.6.16-rc5/fs/cifs/cifsfs.c	2006-03-07 13:52:28.000000000 -0800
@@ -501,13 +501,13 @@ static ssize_t cifs_file_writev(struct f
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
Index: linux-2.6.16-rc5/fs/ext3/file.c
===================================================================
--- linux-2.6.16-rc5.orig/fs/ext3/file.c	2006-02-26 21:09:35.000000000 -0800
+++ linux-2.6.16-rc5/fs/ext3/file.c	2006-03-07 13:52:28.000000000 -0800
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
Index: linux-2.6.16-rc5/fs/nfs/file.c
===================================================================
--- linux-2.6.16-rc5.orig/fs/nfs/file.c	2006-02-26 21:09:35.000000000 -0800
+++ linux-2.6.16-rc5/fs/nfs/file.c	2006-02-27 08:33:22.000000000 -0800
@@ -40,8 +40,10 @@ static int nfs_file_release(struct inode
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
@@ -52,8 +54,8 @@ struct file_operations nfs_file_operatio
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
@@ -213,7 +215,8 @@ nfs_file_flush(struct file *file)
 }
 
 static ssize_t
-nfs_file_read(struct kiocb *iocb, char __user * buf, size_t count, loff_t pos)
+nfs_file_read(struct kiocb *iocb, const struct iovec *iov,
+		unsigned long nr_segs, loff_t pos)
 {
 	struct dentry * dentry = iocb->ki_filp->f_dentry;
 	struct inode * inode = dentry->d_inode;
@@ -221,16 +224,15 @@ nfs_file_read(struct kiocb *iocb, char _
 
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
 
@@ -333,7 +335,8 @@ struct address_space_operations nfs_file
  * Write to a file (through the page cache).
  */
 static ssize_t
-nfs_file_write(struct kiocb *iocb, const char __user *buf, size_t count, loff_t pos)
+nfs_file_write(struct kiocb *iocb, const struct iovec *iov,
+		unsigned long nr_segs, loff_t pos)
 {
 	struct dentry * dentry = iocb->ki_filp->f_dentry;
 	struct inode * inode = dentry->d_inode;
@@ -341,12 +344,12 @@ nfs_file_write(struct kiocb *iocb, const
 
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
@@ -361,11 +364,7 @@ nfs_file_write(struct kiocb *iocb, const
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
 
Index: linux-2.6.16-rc5/fs/read_write.c
===================================================================
--- linux-2.6.16-rc5.orig/fs/read_write.c	2006-02-26 21:09:35.000000000 -0800
+++ linux-2.6.16-rc5/fs/read_write.c	2006-03-07 13:52:28.000000000 -0800
@@ -227,14 +227,19 @@ static void wait_on_retry_sync_kiocb(str
 
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
 
 	if (-EIOCBQUEUED == ret)
 		ret = wait_on_sync_kiocb(&kiocb);
@@ -279,14 +284,19 @@ EXPORT_SYMBOL(vfs_read);
 
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
Index: linux-2.6.16-rc5/fs/reiserfs/file.c
===================================================================
--- linux-2.6.16-rc5.orig/fs/reiserfs/file.c	2006-02-26 21:09:35.000000000 -0800
+++ linux-2.6.16-rc5/fs/reiserfs/file.c	2006-02-27 08:33:22.000000000 -0800
@@ -1560,12 +1560,6 @@ static ssize_t reiserfs_file_write(struc
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
@@ -1575,7 +1569,7 @@ struct file_operations reiserfs_file_ope
 	.fsync = reiserfs_sync_file,
 	.sendfile = generic_file_sendfile,
 	.aio_read = generic_file_aio_read,
-	.aio_write = reiserfs_aio_write,
+	.aio_write = generic_file_aio_write,
 };
 
 struct inode_operations reiserfs_file_inode_operations = {
Index: linux-2.6.16-rc5/fs/xfs/linux-2.6/xfs_file.c
===================================================================
--- linux-2.6.16-rc5.orig/fs/xfs/linux-2.6/xfs_file.c	2006-02-26 21:09:35.000000000 -0800
+++ linux-2.6.16-rc5/fs/xfs/linux-2.6/xfs_file.c	2006-03-07 13:52:28.000000000 -0800
@@ -51,12 +51,11 @@ static struct vm_operations_struct linvf
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
@@ -65,7 +64,7 @@ __linvfs_read(
 
 	if (unlikely(file->f_flags & O_DIRECT))
 		ioflags |= IO_ISDIRECT;
-	VOP_READ(vp, iocb, &iov, 1, &iocb->ki_pos, ioflags, NULL, rval);
+	VOP_READ(vp, iocb, iov, nr_segs, &iocb->ki_pos, ioflags, NULL, rval);
 	return rval;
 }
 
@@ -73,33 +72,32 @@ __linvfs_read(
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
@@ -109,7 +107,7 @@ __linvfs_write(
 	if (unlikely(file->f_flags & O_DIRECT))
 		ioflags |= IO_ISDIRECT;
 
-	VOP_WRITE(vp, iocb, &iov, 1, &iocb->ki_pos, ioflags, NULL, rval);
+	VOP_WRITE(vp, iocb, iov, nr_segs, &iocb->ki_pos, ioflags, NULL, rval);
 	return rval;
 }
 
@@ -117,21 +115,21 @@ __linvfs_write(
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
 
 
Index: linux-2.6.16-rc5/include/linux/fs.h
===================================================================
--- linux-2.6.16-rc5.orig/include/linux/fs.h	2006-02-26 21:09:35.000000000 -0800
+++ linux-2.6.16-rc5/include/linux/fs.h	2006-03-07 13:52:28.000000000 -0800
@@ -999,9 +999,9 @@ struct file_operations {
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
@@ -1561,11 +1561,11 @@ extern int file_send_actor(read_descript
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
Index: linux-2.6.16-rc5/include/net/sock.h
===================================================================
--- linux-2.6.16-rc5.orig/include/net/sock.h	2006-02-26 21:09:35.000000000 -0800
+++ linux-2.6.16-rc5/include/net/sock.h	2006-02-27 08:33:22.000000000 -0800
@@ -650,7 +650,6 @@ struct sock_iocb {
 	struct sock		*sk;
 	struct scm_cookie	*scm;
 	struct msghdr		*msg, async_msg;
-	struct iovec		async_iov;
 	struct kiocb		*kiocb;
 };
 
Index: linux-2.6.16-rc5/mm/filemap.c
===================================================================
--- linux-2.6.16-rc5.orig/mm/filemap.c	2006-02-26 21:09:35.000000000 -0800
+++ linux-2.6.16-rc5/mm/filemap.c	2006-03-07 13:52:28.000000000 -0800
@@ -1065,14 +1065,12 @@ out:
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
@@ -2132,22 +2130,21 @@ out:
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
@@ -2155,6 +2152,7 @@ generic_file_aio_write_nolock(struct kio
 	}
 	return ret;
 }
+EXPORT_SYMBOL(generic_file_aio_write_nolock);
 
 static ssize_t
 __generic_file_write_nolock(struct file *file, const struct iovec *iov,
@@ -2164,9 +2162,11 @@ __generic_file_write_nolock(struct file 
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
 
@@ -2178,28 +2178,27 @@ generic_file_write_nolock(struct file *f
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
Index: linux-2.6.16-rc5/net/socket.c
===================================================================
--- linux-2.6.16-rc5.orig/net/socket.c	2006-02-26 21:09:35.000000000 -0800
+++ linux-2.6.16-rc5/net/socket.c	2006-03-07 13:53:40.000000000 -0800
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
@@ -656,7 +656,7 @@ static ssize_t sock_sendpage(struct file
 }
 
 static struct sock_iocb *alloc_sock_iocb(struct kiocb *iocb,
-		char __user *ubuf, size_t size, struct sock_iocb *siocb)
+		struct sock_iocb *siocb)
 {
 	if (!is_sync_kiocb(iocb)) {
 		siocb = kmalloc(sizeof(*siocb), GFP_KERNEL);
@@ -666,15 +666,13 @@ static struct sock_iocb *alloc_sock_iocb
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
@@ -705,31 +703,33 @@ static ssize_t sock_readv(struct file *f
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
+	if (iocb->ki_left == 0)		/* Match SYS5 behaviour */
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
@@ -762,28 +762,28 @@ static ssize_t sock_writev(struct file *
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
+	if (iocb->ki_left == 0)		/* Match SYS5 behaviour */
 		return 0;
 
-	x = alloc_sock_iocb(iocb, (void __user *)ubuf, count, &siocb);
+	x = alloc_sock_iocb(iocb, &siocb);
 	if (!x)
 		return -ENOMEM;
 
-	return do_sock_write(&x->async_msg, iocb, iocb->ki_filp,
-			&x->async_iov, 1);
+	return do_sock_write(&x->async_msg, iocb, iocb->ki_filp, iov, nr_segs);
 }
 
 
Index: linux-2.6.16-rc5/fs/nfs/direct.c
===================================================================
--- linux-2.6.16-rc5.orig/fs/nfs/direct.c	2006-02-26 21:09:35.000000000 -0800
+++ linux-2.6.16-rc5/fs/nfs/direct.c	2006-02-27 08:38:28.000000000 -0800
@@ -626,6 +626,32 @@ nfs_direct_IO(int rw, struct kiocb *iocb
 	return result;
 }
 
+static ssize_t
+check_access_ok(int type, const struct iovec *iov, unsigned long nr_segs)
+{
+	ssize_t	tot_len = 0;
+	ssize_t ret = -EINVAL;
+	int seg;
+
+	for (seg = 0; seg < nr_segs; seg++) {
+		void __user *buf = iov[seg].iov_base;
+		ssize_t len = (ssize_t)iov[seg].iov_len;
+
+		if (len < 0)	/* size_t not fitting an ssize_t .. */
+			goto out;
+		if (unlikely(!access_ok(type, buf, len))) {
+			ret = -EFAULT;
+			goto out;
+		}
+		tot_len += len;
+		if ((ssize_t)tot_len < 0) /* maths overflow on the ssize_t */
+			goto out;
+	}
+	ret = tot_len;
+out:
+	return ret;
+}
+
 /**
  * nfs_file_direct_read - file direct read operation for NFS files
  * @iocb: target I/O control block
@@ -648,7 +674,8 @@ nfs_direct_IO(int rw, struct kiocb *iocb
  * cache.
  */
 ssize_t
-nfs_file_direct_read(struct kiocb *iocb, char __user *buf, size_t count, loff_t pos)
+nfs_file_direct_read(struct kiocb *iocb, const struct iovec *iov,
+			unsigned long nr_segs, loff_t pos)
 {
 	ssize_t retval = -EINVAL;
 	loff_t *ppos = &iocb->ki_pos;
@@ -657,32 +684,24 @@ nfs_file_direct_read(struct kiocb *iocb,
 			(struct nfs_open_context *) file->private_data;
 	struct address_space *mapping = file->f_mapping;
 	struct inode *inode = mapping->host;
-	struct iovec iov = {
-		.iov_base = buf,
-		.iov_len = count,
-	};
 
-	dprintk("nfs: direct read(%s/%s, %lu@%Ld)\n",
+	dprintk("nfs: direct read(%s/%s, @%Ld)\n",
 		file->f_dentry->d_parent->d_name.name,
 		file->f_dentry->d_name.name,
-		(unsigned long) count, (long long) pos);
+		(long long) pos);
 
 	if (!is_sync_kiocb(iocb))
 		goto out;
-	if (count < 0)
-		goto out;
-	retval = -EFAULT;
-	if (!access_ok(VERIFY_WRITE, iov.iov_base, iov.iov_len))
-		goto out;
-	retval = 0;
-	if (!count)
+
+	retval = check_access_ok(VERIFY_WRITE, iov, nr_segs);
+	if (retval <= 0)
 		goto out;
 
 	retval = nfs_sync_mapping(mapping);
 	if (retval)
 		goto out;
 
-	retval = nfs_direct_read(inode, ctx, &iov, pos, 1);
+	retval = nfs_direct_read(inode, ctx, iov, pos, nr_segs);
 	if (retval > 0)
 		*ppos = pos + retval;
 
@@ -716,7 +735,8 @@ out:
  * is no atomic O_APPEND write facility in the NFS protocol.
  */
 ssize_t
-nfs_file_direct_write(struct kiocb *iocb, const char __user *buf, size_t count, loff_t pos)
+nfs_file_direct_write(struct kiocb *iocb, const struct iovec *iov,
+			unsigned long nr_segs, loff_t pos)
 {
 	ssize_t retval;
 	struct file *file = iocb->ki_filp;
@@ -724,40 +744,32 @@ nfs_file_direct_write(struct kiocb *iocb
 			(struct nfs_open_context *) file->private_data;
 	struct address_space *mapping = file->f_mapping;
 	struct inode *inode = mapping->host;
-	struct iovec iov = {
-		.iov_base = (char __user *)buf,
-	};
+	ssize_t count;
 
-	dfprintk(VFS, "nfs: direct write(%s/%s, %lu@%Ld)\n",
+	dfprintk(VFS, "nfs: direct write(%s/%s, @%Ld)\n",
 		file->f_dentry->d_parent->d_name.name,
 		file->f_dentry->d_name.name,
-		(unsigned long) count, (long long) pos);
+		(long long) pos);
 
 	retval = -EINVAL;
 	if (!is_sync_kiocb(iocb))
 		goto out;
 
-	retval = generic_write_checks(file, &pos, &count, 0);
-	if (retval)
+	retval = check_access_ok(VERIFY_READ, iov, nr_segs);
+	if (retval <= 0)
 		goto out;
 
-	retval = -EINVAL;
-	if ((ssize_t) count < 0)
-		goto out;
-	retval = 0;
-	if (!count)
-		goto out;
-	iov.iov_len = count,
-
-	retval = -EFAULT;
-	if (!access_ok(VERIFY_READ, iov.iov_base, iov.iov_len))
+	/* FIXME:  how to adjust iovec if count gets adjusted ? */
+	count = retval;
+	retval = generic_write_checks(file, &pos, &count, 0);
+	if (retval)
 		goto out;
 
 	retval = nfs_sync_mapping(mapping);
 	if (retval)
 		goto out;
 
-	retval = nfs_direct_write(inode, ctx, &iov, pos, 1);
+	retval = nfs_direct_write(inode, ctx, iov, pos, nr_segs);
 	if (mapping->nrpages)
 		invalidate_inode_pages2(mapping);
 	if (retval > 0)
Index: linux-2.6.16-rc5/include/linux/nfs_fs.h
===================================================================
--- linux-2.6.16-rc5.orig/include/linux/nfs_fs.h	2006-02-26 21:09:35.000000000 -0800
+++ linux-2.6.16-rc5/include/linux/nfs_fs.h	2006-02-27 08:33:22.000000000 -0800
@@ -369,10 +369,10 @@ extern int nfs3_removexattr (struct dent
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
Index: linux-2.6.16-rc5/drivers/usb/gadget/inode.c
===================================================================
--- linux-2.6.16-rc5.orig/drivers/usb/gadget/inode.c	2006-02-26 21:09:35.000000000 -0800
+++ linux-2.6.16-rc5/drivers/usb/gadget/inode.c	2006-03-07 13:26:46.000000000 -0800
@@ -529,7 +529,8 @@ struct kiocb_priv {
 	struct usb_request	*req;
 	struct ep_data		*epdata;
 	void			*buf;
-	char __user		*ubuf;
+	struct iovec 		*iv;
+	unsigned long 		count;
 	unsigned		actual;
 };
 
@@ -557,18 +558,32 @@ static int ep_aio_cancel(struct kiocb *i
 static ssize_t ep_aio_read_retry(struct kiocb *iocb)
 {
 	struct kiocb_priv	*priv = iocb->private;
-	ssize_t			status = priv->actual;
+	ssize_t			len, total;
 
 	/* we "retry" to get the right mm context for this: */
-	status = copy_to_user(priv->ubuf, priv->buf, priv->actual);
-	if (unlikely(0 != status))
-		status = -EFAULT;
-	else
-		status = priv->actual;
+
+	/* copy stuff into user buffers */
+	total = priv->actual;
+	len = 0;
+	for (i=0; i < priv->count; i++) {
+		ssize_t this = min(priv->iv[i].iov_len, (size_t)total);
+
+		if (copy_to_user(priv->iv[i].iov_buf, priv->buf, this))
+			break;
+
+		total -= this;
+		len += this;
+		if (total <= 0)
+			break;
+	}
+
+	if (unlikely(len != 0))
+		len = -EFAULT;
+
 	kfree(priv->buf);
 	kfree(priv);
 	aio_put_req(iocb);
-	return status;
+	return len;
 }
 
 static void ep_aio_complete(struct usb_ep *ep, struct usb_request *req)
@@ -616,7 +631,8 @@ ep_aio_rwtail(
 	char		*buf,
 	size_t		len,
 	struct ep_data	*epdata,
-	char __user	*ubuf
+	const struct iovec *iv,
+	unsigned long 	count
 )
 {
 	struct kiocb_priv	*priv = (void *) &iocb->private;
@@ -631,7 +647,8 @@ fail:
 		return value;
 	}
 	iocb->private = priv;
-	priv->ubuf = ubuf;
+	priv->iovec = iv;
+	priv->count = count;
 
 	value = get_ready_ep(iocb->ki_filp->f_flags, epdata);
 	if (unlikely(value < 0)) {
@@ -676,36 +693,52 @@ fail:
 }
 
 static ssize_t
-ep_aio_read(struct kiocb *iocb, char __user *ubuf, size_t len, loff_t o)
+ep_aio_read(struct kiocb *iocb, const struct iovec *iv,
+		unsigned long count, loff_t o)
 {
 	struct ep_data		*epdata = iocb->ki_filp->private_data;
 	char			*buf;
+	size_t			len;
+	int			i = 0;
+	ssize_t			ret;
 
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
+	return ep_aio_rwtail(iocb, buf, len, epdata, iv, count);
 }
 
 static ssize_t
-ep_aio_write(struct kiocb *iocb, const char __user *ubuf, size_t len, loff_t o)
+ep_aio_write(struct kiocb *iocb, const struct iovec *iv,
+		unsigned long count, loff_t o)
 {
 	struct ep_data		*epdata = iocb->ki_filp->private_data;
 	char			*buf;
+	size_t			len = 0;
+	int			i = 0;
+	ssize_t			ret;
 
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
+	for (i=0; i < count; i++) {
+		if (unlikely(copy_from_user(&buf[len], iv[i]->iov_base,
+				iv[i]->iov_len) != 0)) {
+			kfree(buf);
+			return -EFAULT;
+		}
+		len += iv[i]->iov_len;
 	}
-	return ep_aio_rwtail(iocb, buf, len, epdata, NULL);
+	return ep_aio_rwtail(iocb, buf, len, epdata, NULL, 0);
 }
 
 /*----------------------------------------------------------------------*/
Index: linux-2.6.16-rc5/include/linux/aio.h
===================================================================
--- linux-2.6.16-rc5.orig/include/linux/aio.h	2006-03-07 08:37:05.000000000 -0800
+++ linux-2.6.16-rc5/include/linux/aio.h	2006-03-07 13:44:09.000000000 -0800
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

--=-dLEXWUOxgd91Lv2g1L18--

