Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030189AbVKBX1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030189AbVKBX1t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 18:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030190AbVKBX1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 18:27:49 -0500
Received: from tetsuo.zabbo.net ([207.173.201.20]:40324 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S1030189AbVKBX1s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 18:27:48 -0500
From: Zach Brown <zach.brown@oracle.com>
To: linux-aio@kvack.org, linux-kernel@vger.kernel.org
Cc: Benjamin LaHaise <bcrl@kvack.org>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@lst.de>
Message-Id: <20051102233020.27835.89951.sendpatchset@volauvent.pdx.zabbo.net>
Subject: [Patch] vectored aio: IO_CMD_P{READ,WRITE}V and fops->aio_{read,write}v
Date: Wed,  2 Nov 2005 15:27:29 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


vectored aio: IO_CMD_P{READ,WRITE}V and fops->aio_{read,write}v

This adds IO_CMD_IO_CMD_P{READ,WRITE}V to let userspace specify buffers with
iovecs.  aio_{read,write}v file operations are then used by the AIO core to
hand the iovecs to filesystems, a significant number of whom already implement
their IO methods in terms of iovecs.  It lets applications work with vectored
file IO in single AIO operations instead of having to issue multiple AIO ops.
This is of particular use with O_DIRECT when the iovecs are pushed all the way
down to devices which are capable of scatter-gather DMA.

  Signed-off-by: Zach Brown <zach.brown@oracle.com>
---

 fs/aio.c                |  104 ++++++++++++++++++++++++++++++++++++++
 fs/bad_inode.c          |    2 
 fs/block_dev.c          |   10 +++
 fs/ext2/file.c          |    2 
 fs/ext3/file.c          |   16 +++++
 fs/jfs/file.c           |    2 
 fs/ntfs/file.c          |   23 ++++++--
 fs/read_write.c         |  129 +++++++++++++++++++++++++++++-------------------
 fs/reiserfs/file.c      |    2 
 include/linux/aio.h     |    3 +
 include/linux/aio_abi.h |    2 
 include/linux/fs.h      |    9 +++
 mm/filemap.c            |   28 ++++++++--
 13 files changed, 268 insertions(+), 64 deletions(-)

Index: 2.6.14-git5-vectored-aio/fs/aio.c
===================================================================
--- 2.6.14-git5-vectored-aio.orig/fs/aio.c	2005-11-02 11:04:21.000000000 -0800
+++ 2.6.14-git5-vectored-aio/fs/aio.c	2005-11-02 14:09:20.893889525 -0800
@@ -30,6 +30,7 @@
 #include <linux/workqueue.h>
 #include <linux/security.h>
 #include <linux/rcuref.h>
+#include <linux/uio.h>
 
 #include <asm/kmap_types.h>
 #include <asm/uaccess.h>
@@ -406,6 +407,7 @@
 	req->ki_retry = NULL;
 	req->ki_dtor = NULL;
 	req->private = NULL;
+	req->ki_iovec = NULL;
 	INIT_LIST_HEAD(&req->ki_run_list);
 
 	/* Check if the completion queue has enough free space to
@@ -449,6 +451,7 @@
 {
 	if (req->ki_dtor)
 		req->ki_dtor(req);
+	kfree(req->ki_iovec);
 	kmem_cache_free(kiocb_cachep, req);
 	ctx->reqs_active--;
 
@@ -1295,6 +1298,64 @@
 	return -EINVAL;
 }
 
+static void aio_advance_iovec(struct kiocb *iocb, ssize_t ret)
+{
+	struct iovec *iov = &iocb->ki_iovec[iocb->ki_cur_seg];
+
+	BUG_ON(ret <= 0);
+
+	while (iocb->ki_cur_seg < iocb->ki_nr_segs && ret > 0) {
+		ssize_t this = min(iov->iov_len, (size_t)ret);
+		iov->iov_base += this;
+		iov->iov_len -= this;
+		iocb->ki_left -= this;
+		ret -= this;
+		if (iov->iov_len == 0) {
+			iocb->ki_cur_seg++;
+			iov++;
+		}
+	}
+
+	/* the caller should not have done more io than what fit in
+	 * the remaining iovecs */
+	BUG_ON(ret > 0 && iocb->ki_left == 0);
+}
+
+static ssize_t aio_rw_vect_retry(struct kiocb *iocb)
+{
+	struct file *file = iocb->ki_filp;
+	struct address_space *mapping = file->f_mapping;
+	struct inode *inode = mapping->host;
+	ssize_t (*rw_op)(struct kiocb *, const struct iovec *,
+			 unsigned long, loff_t);
+	ssize_t ret = 0;
+
+	if (iocb->ki_opcode == IOCB_CMD_PREADV)
+		rw_op = file->f_op->aio_readv;
+	else
+		rw_op = file->f_op->aio_writev;
+
+	do {
+		ret = rw_op(iocb, &iocb->ki_iovec[iocb->ki_cur_seg],
+			    iocb->ki_nr_segs - iocb->ki_cur_seg,
+			    iocb->ki_pos);
+		if (ret > 0)
+			aio_advance_iovec(iocb, ret);
+
+	/* retry all partial writes.  retry partial reads as long as its a
+	 * regular file. */
+	} while (ret > 0 && iocb->ki_left > 0 &&
+		 (iocb->ki_opcode == IOCB_CMD_PWRITEV ||
+		  (!S_ISFIFO(inode->i_mode) && !S_ISSOCK(inode->i_mode))));
+
+	/* This means we must have transferred all that we could */
+	/* No need to retry anymore */
+	if ((ret == 0) || (iocb->ki_left == 0))
+		ret = iocb->ki_nbytes - iocb->ki_left;
+
+	return ret;
+}
+
 /*
  * aio_p{read,write} are the default  ki_retry methods for
  * IO_CMD_P{READ,WRITE}.  They maintains kiocb retry state around potentially
@@ -1378,6 +1439,27 @@
 	return ret;
 }
 
+static ssize_t aio_setup_vectored_rw(struct kiocb *kiocb)
+{
+	ssize_t ret;
+
+	ret = rw_copy_check_uvector((struct iovec __user *)kiocb->ki_buf,
+				    kiocb->ki_nbytes, 0, NULL,
+				    &kiocb->ki_iovec);
+	if (ret < 0)
+		goto out;
+
+	kiocb->ki_nr_segs = kiocb->ki_nbytes;
+	kiocb->ki_cur_seg = 0;
+	/* ki_nbytes/left now reflect bytes instead of segs */
+	kiocb->ki_nbytes = ret;
+	kiocb->ki_left = ret;
+
+	ret = 0;
+out:
+	return ret;
+}	
+
 /*
  * aio_setup_iocb:
  *	Performs the initial checks and aio retry method
@@ -1419,6 +1501,28 @@
 		if (file->f_op->aio_write)
 			kiocb->ki_retry = aio_pwrite;
 		break;
+	case IOCB_CMD_PREADV:
+		ret = -EBADF;
+		if (unlikely(!(file->f_mode & FMODE_READ)))
+			break;
+		ret = aio_setup_vectored_rw(kiocb);
+		if (ret)
+			break;
+		ret = EINVAL;
+		if (file->f_op->aio_readv)
+			kiocb->ki_retry = aio_rw_vect_retry;
+		break;
+	case IOCB_CMD_PWRITEV:
+		ret = -EBADF;
+		if (unlikely(!(file->f_mode & FMODE_WRITE)))
+			break;
+		ret = aio_setup_vectored_rw(kiocb);
+		if (ret)
+			break;
+		ret = EINVAL;
+		if (file->f_op->aio_writev)
+			kiocb->ki_retry = aio_rw_vect_retry;
+		break;
 	case IOCB_CMD_FDSYNC:
 		ret = -EINVAL;
 		if (file->f_op->aio_fsync)
Index: 2.6.14-git5-vectored-aio/fs/bad_inode.c
===================================================================
--- 2.6.14-git5-vectored-aio.orig/fs/bad_inode.c	2005-11-02 11:02:21.000000000 -0800
+++ 2.6.14-git5-vectored-aio/fs/bad_inode.c	2005-11-02 11:09:35.000000000 -0800
@@ -26,9 +26,11 @@
 {
 	.llseek		= EIO_ERROR,
 	.aio_read	= EIO_ERROR,
+	.aio_readv	= EIO_ERROR,
 	.read		= EIO_ERROR,
 	.write		= EIO_ERROR,
 	.aio_write	= EIO_ERROR,
+	.aio_writev	= EIO_ERROR,
 	.readdir	= EIO_ERROR,
 	.poll		= EIO_ERROR,
 	.ioctl		= EIO_ERROR,
Index: 2.6.14-git5-vectored-aio/fs/block_dev.c
===================================================================
--- 2.6.14-git5-vectored-aio.orig/fs/block_dev.c	2005-11-02 11:03:14.000000000 -0800
+++ 2.6.14-git5-vectored-aio/fs/block_dev.c	2005-11-02 11:12:07.000000000 -0800
@@ -777,6 +777,14 @@
 	return generic_file_aio_write_nolock(iocb, &local_iov, 1, &iocb->ki_pos);
 }
 
+static ssize_t blkdev_file_aio_writev(struct kiocb *iocb,
+					const struct iovec *iov,
+					unsigned long nr_segs, loff_t pos)
+{
+	return generic_file_aio_write_nolock(iocb, iov, nr_segs, &iocb->ki_pos);
+}
+
+
 static long block_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 {
 	return blkdev_ioctl(file->f_mapping->host, file, cmd, arg);
@@ -799,7 +807,9 @@
 	.read		= generic_file_read,
 	.write		= blkdev_file_write,
   	.aio_read	= generic_file_aio_read,
+  	.aio_readv	= generic_file_aio_readv,
   	.aio_write	= blkdev_file_aio_write, 
+  	.aio_writev	= blkdev_file_aio_writev,
 	.mmap		= generic_file_mmap,
 	.fsync		= block_fsync,
 	.unlocked_ioctl	= block_ioctl,
Index: 2.6.14-git5-vectored-aio/fs/ext2/file.c
===================================================================
--- 2.6.14-git5-vectored-aio.orig/fs/ext2/file.c	2005-11-02 11:03:14.000000000 -0800
+++ 2.6.14-git5-vectored-aio/fs/ext2/file.c	2005-11-02 11:09:35.000000000 -0800
@@ -44,7 +44,9 @@
 	.read		= generic_file_read,
 	.write		= generic_file_write,
 	.aio_read	= generic_file_aio_read,
+	.aio_readv	= generic_file_aio_readv,
 	.aio_write	= generic_file_aio_write,
+	.aio_writev	= generic_file_aio_writev,
 	.ioctl		= ext2_ioctl,
 	.mmap		= generic_file_mmap,
 	.open		= generic_file_open,
Index: 2.6.14-git5-vectored-aio/fs/ext3/file.c
===================================================================
--- 2.6.14-git5-vectored-aio.orig/fs/ext3/file.c	2005-11-02 11:03:14.000000000 -0800
+++ 2.6.14-git5-vectored-aio/fs/ext3/file.c	2005-11-02 11:09:35.000000000 -0800
@@ -23,6 +23,7 @@
 #include <linux/jbd.h>
 #include <linux/ext3_fs.h>
 #include <linux/ext3_jbd.h>
+#include <linux/uio.h>
 #include "xattr.h"
 #include "acl.h"
 
@@ -48,14 +49,15 @@
 }
 
 static ssize_t
-ext3_file_write(struct kiocb *iocb, const char __user *buf, size_t count, loff_t pos)
+ext3_file_aio_writev(struct kiocb *iocb, const struct iovec *iov,
+		     unsigned long nr_segs, loff_t pos)
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file->f_dentry->d_inode;
 	ssize_t ret;
 	int err;
 
-	ret = generic_file_aio_write(iocb, buf, count, pos);
+	ret = generic_file_aio_writev(iocb, iov, nr_segs, pos);
 
 	/*
 	 * Skip flushing if there was an error, or if nothing was written.
@@ -105,12 +107,22 @@
 	return ret;
 }
 
+static ssize_t
+ext3_file_write(struct kiocb *iocb, const char __user *buf, size_t count, loff_t pos)
+{
+	struct iovec local_iov = { .iov_base = (void __user *)buf,
+					.iov_len = count };
+	return ext3_file_aio_writev(iocb, &local_iov, 1, pos);
+}
+
 struct file_operations ext3_file_operations = {
 	.llseek		= generic_file_llseek,
 	.read		= do_sync_read,
 	.write		= do_sync_write,
 	.aio_read	= generic_file_aio_read,
+	.aio_readv	= generic_file_aio_readv,
 	.aio_write	= ext3_file_write,
+	.aio_writev	= ext3_file_aio_writev,
 	.readv		= generic_file_readv,
 	.writev		= generic_file_writev,
 	.ioctl		= ext3_ioctl,
Index: 2.6.14-git5-vectored-aio/fs/jfs/file.c
===================================================================
--- 2.6.14-git5-vectored-aio.orig/fs/jfs/file.c	2005-11-02 11:03:14.000000000 -0800
+++ 2.6.14-git5-vectored-aio/fs/jfs/file.c	2005-11-02 11:09:35.000000000 -0800
@@ -106,7 +106,9 @@
 	.write		= generic_file_write,
 	.read		= generic_file_read,
 	.aio_read	= generic_file_aio_read,
+	.aio_readv	= generic_file_aio_readv,
 	.aio_write	= generic_file_aio_write,
+	.aio_writev	= generic_file_aio_writev,
 	.mmap		= generic_file_mmap,
 	.readv		= generic_file_readv,
 	.writev		= generic_file_writev,
Index: 2.6.14-git5-vectored-aio/fs/ntfs/file.c
===================================================================
--- 2.6.14-git5-vectored-aio.orig/fs/ntfs/file.c	2005-11-02 11:05:06.000000000 -0800
+++ 2.6.14-git5-vectored-aio/fs/ntfs/file.c	2005-11-02 13:31:21.000000000 -0800
@@ -2182,22 +2182,20 @@
 }
 
 /**
- * ntfs_file_aio_write -
+ * ntfs_file_aio_writev -
  */
-static ssize_t ntfs_file_aio_write(struct kiocb *iocb, const char __user *buf,
-		size_t count, loff_t pos)
+static ssize_t ntfs_file_aio_writev(struct kiocb *iocb, const struct iovec *iov,
+		unsigned long nr_segs, loff_t pos)
 {
 	struct file *file = iocb->ki_filp;
 	struct address_space *mapping = file->f_mapping;
 	struct inode *inode = mapping->host;
 	ssize_t ret;
-	struct iovec local_iov = { .iov_base = (void __user *)buf,
-				   .iov_len = count };
 
 	BUG_ON(iocb->ki_pos != pos);
 
 	down(&inode->i_sem);
-	ret = ntfs_file_aio_write_nolock(iocb, &local_iov, 1, &iocb->ki_pos);
+	ret = ntfs_file_aio_write_nolock(iocb, iov, nr_segs, &iocb->ki_pos);
 	up(&inode->i_sem);
 	if (ret > 0 && ((file->f_flags & O_SYNC) || IS_SYNC(inode))) {
 		int err = sync_page_range(inode, mapping, pos, ret);
@@ -2208,6 +2206,17 @@
 }
 
 /**
+ * ntfs_file_aio_write -
+ */
+static ssize_t ntfs_file_aio_write(struct kiocb *iocb, const char __user *buf,
+		size_t count, loff_t pos)
+{
+	struct iovec local_iov = { .iov_base = (void __user *)buf,
+				   .iov_len = count };
+	return ntfs_file_aio_writev(iocb, &local_iov, 1, pos);
+}
+
+/**
  * ntfs_file_writev -
  *
  * Basically the same as generic_file_writev() except that it ends up calling
@@ -2308,10 +2317,12 @@
 	.llseek		= generic_file_llseek,	 /* Seek inside file. */
 	.read		= generic_file_read,	 /* Read from file. */
 	.aio_read	= generic_file_aio_read, /* Async read from file. */
+	.aio_readv	= generic_file_aio_readv,/* Async readv from file. */
 	.readv		= generic_file_readv,	 /* Read from file. */
 #ifdef NTFS_RW
 	.write		= ntfs_file_write,	 /* Write to file. */
 	.aio_write	= ntfs_file_aio_write,	 /* Async write to file. */
+	.aio_writev	= ntfs_file_aio_writev,  /* Async writev to file. */
 	.writev		= ntfs_file_writev,	 /* Write to file. */
 	/*.release	= ,*/			 /* Last file is closed.  See
 						    fs/ext2/file.c::
Index: 2.6.14-git5-vectored-aio/fs/read_write.c
===================================================================
--- 2.6.14-git5-vectored-aio.orig/fs/read_write.c	2005-11-02 11:04:22.000000000 -0800
+++ 2.6.14-git5-vectored-aio/fs/read_write.c	2005-11-02 11:09:35.000000000 -0800
@@ -427,6 +427,77 @@
 /* A write operation does a read from user space and vice versa */
 #define vrfy_dir(type) ((type) == READ ? VERIFY_WRITE : VERIFY_READ)
 
+ssize_t rw_copy_check_uvector(const struct iovec __user * uvector,
+			      unsigned long nr_segs, unsigned long fast_segs,
+			      struct iovec *fast_pointer,
+			      struct iovec **ret_pointer)
+  {
+	unsigned long seg;
+  	ssize_t ret;
+	struct iovec *iov = fast_pointer;
+  
+  	/*
+  	 * SuS says "The readv() function *may* fail if the iovcnt argument
+  	 * was less than or equal to 0, or greater than {IOV_MAX}.  Linux has
+  	 * traditionally returned zero for zero segments, so...
+  	 */
+	if (nr_segs == 0) {
+		ret = 0;
+  		goto out;
+	}
+  
+  	/*
+  	 * First get the "struct iovec" from user memory and
+  	 * verify all the pointers
+  	 */
+	if ((nr_segs > UIO_MAXIOV) || (nr_segs <= 0)) {
+		ret = -EINVAL;
+  		goto out;
+	}
+	if (nr_segs > fast_segs) {
+  		iov = kmalloc(nr_segs*sizeof(struct iovec), GFP_KERNEL);
+		if (iov == NULL) {
+			ret = -ENOMEM;
+  			goto out;
+		}
+  	}
+	if (copy_from_user(iov, uvector, nr_segs*sizeof(*uvector))) {
+		ret = -EFAULT;
+  		goto out;
+	}
+  
+  	/*
+	 * According to the Single Unix Specification we should return EINVAL
+	 * if an element length is < 0 when cast to ssize_t or if the
+	 * total length would overflow the ssize_t return value of the
+	 * system call.
+  	 */
+	ret = 0;
+  	for (seg = 0; seg < nr_segs; seg++) {
+  		void __user *buf = iov[seg].iov_base;
+  		ssize_t len = (ssize_t)iov[seg].iov_len;
+  
+		/* see if we we're about to use an invalid len or if
+		 * it's about to overflow ssize_t */
+		if (len < 0 || (ret + len < ret)) {
+			ret = -EINVAL;
+  			goto out;
+		}
+		if (unlikely(!access_ok(vrfy_dir(type), buf, len))) {
+			ret = -EFAULT;
+  			goto out;
+		}
+
+		ret += len;
+  	}
+out:
+	*ret_pointer = iov;
+	return ret;
+}
+
+/* A write operation does a read from user space and vice versa */
+#define vrfy_dir(type) ((type) == READ ? VERIFY_WRITE : VERIFY_READ)
+
 static ssize_t do_readv_writev(int type, struct file *file,
 			       const struct iovec __user * uvector,
 			       unsigned long nr_segs, loff_t *pos)
@@ -434,62 +505,23 @@
 	typedef ssize_t (*io_fn_t)(struct file *, char __user *, size_t, loff_t *);
 	typedef ssize_t (*iov_fn_t)(struct file *, const struct iovec *, unsigned long, loff_t *);
 
-	size_t tot_len;
+	ssize_t tot_len;
 	struct iovec iovstack[UIO_FASTIOV];
 	struct iovec *iov=iovstack, *vector;
 	ssize_t ret;
-	int seg;
 	io_fn_t fn;
 	iov_fn_t fnv;
 
-	/*
-	 * SuS says "The readv() function *may* fail if the iovcnt argument
-	 * was less than or equal to 0, or greater than {IOV_MAX}.  Linux has
-	 * traditionally returned zero for zero segments, so...
-	 */
-	ret = 0;
-	if (nr_segs == 0)
+	if (!file->f_op) {
+		ret = -EINVAL;
 		goto out;
-
-	/*
-	 * First get the "struct iovec" from user memory and
-	 * verify all the pointers
-	 */
-	ret = -EINVAL;
-	if ((nr_segs > UIO_MAXIOV) || (nr_segs <= 0))
-		goto out;
-	if (!file->f_op)
-		goto out;
-	if (nr_segs > UIO_FASTIOV) {
-		ret = -ENOMEM;
-		iov = kmalloc(nr_segs*sizeof(struct iovec), GFP_KERNEL);
-		if (!iov)
-			goto out;
 	}
-	ret = -EFAULT;
-	if (copy_from_user(iov, uvector, nr_segs*sizeof(*uvector)))
-		goto out;
 
-	/*
-	 * Single unix specification:
-	 * We should -EINVAL if an element length is not >= 0 and fitting an
-	 * ssize_t.  The total length is fitting an ssize_t
-	 *
-	 * Be careful here because iov_len is a size_t not an ssize_t
-	 */
-	tot_len = 0;
-	ret = -EINVAL;
-	for (seg = 0; seg < nr_segs; seg++) {
-		void __user *buf = iov[seg].iov_base;
-		ssize_t len = (ssize_t)iov[seg].iov_len;
-
-		if (len < 0)	/* size_t not fitting an ssize_t .. */
-			goto out;
-		if (unlikely(!access_ok(vrfy_dir(type), buf, len)))
-			goto Efault;
-		tot_len += len;
-		if ((ssize_t)tot_len < 0) /* maths overflow on the ssize_t */
-			goto out;
+	tot_len = rw_copy_check_uvector(uvector, nr_segs, ARRAY_SIZE(iovstack), 
+					iovstack, &iov);
+	if (tot_len < 0) {
+		ret = tot_len;
+		goto out;
 	}
 	if (tot_len == 0) {
 		ret = 0;
@@ -549,9 +581,6 @@
 			fsnotify_modify(file->f_dentry);
 	}
 	return ret;
-Efault:
-	ret = -EFAULT;
-	goto out;
 }
 
 ssize_t vfs_readv(struct file *file, const struct iovec __user *vec,
Index: 2.6.14-git5-vectored-aio/fs/reiserfs/file.c
===================================================================
--- 2.6.14-git5-vectored-aio.orig/fs/reiserfs/file.c	2005-11-02 11:04:22.000000000 -0800
+++ 2.6.14-git5-vectored-aio/fs/reiserfs/file.c	2005-11-02 11:11:10.000000000 -0800
@@ -1556,7 +1556,9 @@
 	.fsync = reiserfs_sync_file,
 	.sendfile = generic_file_sendfile,
 	.aio_read = generic_file_aio_read,
+	.aio_readv  = generic_file_aio_readv,
 	.aio_write = reiserfs_aio_write,
+	.aio_writev = generic_file_aio_writev,
 };
 
 struct inode_operations reiserfs_file_inode_operations = {
Index: 2.6.14-git5-vectored-aio/include/linux/aio.h
===================================================================
--- 2.6.14-git5-vectored-aio.orig/include/linux/aio.h	2005-11-02 11:04:25.000000000 -0800
+++ 2.6.14-git5-vectored-aio/include/linux/aio.h	2005-11-02 11:09:35.459019411 -0800
@@ -113,6 +113,9 @@
 	long			ki_kicked; 	/* just for testing */
 	long			ki_queued; 	/* just for testing */
 
+	struct iovec		*ki_iovec;
+	unsigned long		ki_nr_segs;
+	unsigned long		ki_cur_seg;
 	void			*private;
 };
 
Index: 2.6.14-git5-vectored-aio/include/linux/aio_abi.h
===================================================================
--- 2.6.14-git5-vectored-aio.orig/include/linux/aio_abi.h	2005-11-02 11:02:22.000000000 -0800
+++ 2.6.14-git5-vectored-aio/include/linux/aio_abi.h	2005-11-02 11:09:35.460019110 -0800
@@ -41,6 +41,8 @@
 	 * IOCB_CMD_POLL = 5,
 	 */
 	IOCB_CMD_NOOP = 6,
+	IOCB_CMD_PREADV = 7,
+	IOCB_CMD_PWRITEV = 8,
 };
 
 /* read() from /dev/aio returns these structures. */
Index: 2.6.14-git5-vectored-aio/include/linux/fs.h
===================================================================
--- 2.6.14-git5-vectored-aio.orig/include/linux/fs.h	2005-11-02 11:05:07.000000000 -0800
+++ 2.6.14-git5-vectored-aio/include/linux/fs.h	2005-11-02 11:09:35.461018809 -0800
@@ -954,8 +954,10 @@
 	loff_t (*llseek) (struct file *, loff_t, int);
 	ssize_t (*read) (struct file *, char __user *, size_t, loff_t *);
 	ssize_t (*aio_read) (struct kiocb *, char __user *, size_t, loff_t);
+	ssize_t (*aio_readv) (struct kiocb *, const struct iovec *, unsigned long, loff_t);
 	ssize_t (*write) (struct file *, const char __user *, size_t, loff_t *);
 	ssize_t (*aio_write) (struct kiocb *, const char __user *, size_t, loff_t);
+	ssize_t (*aio_writev) (struct kiocb *, const struct iovec *, unsigned long, loff_t);
 	int (*readdir) (struct file *, void *, filldir_t);
 	unsigned int (*poll) (struct file *, struct poll_table_struct *);
 	int (*ioctl) (struct inode *, struct file *, unsigned int, unsigned long);
@@ -1005,6 +1007,11 @@
 
 struct seq_file;
 
+ssize_t rw_copy_check_uvector(const struct iovec __user * uvector,
+			      unsigned long nr_segs, unsigned long fast_segs,
+			      struct iovec *fast_pointer,
+			      struct iovec **ret_pointer);
+
 extern ssize_t vfs_read(struct file *, char __user *, size_t, loff_t *);
 extern ssize_t vfs_write(struct file *, const char __user *, size_t, loff_t *);
 extern ssize_t vfs_readv(struct file *, const struct iovec __user *,
@@ -1497,8 +1504,10 @@
 int generic_write_checks(struct file *file, loff_t *pos, size_t *count, int isblk);
 extern ssize_t generic_file_write(struct file *, const char __user *, size_t, loff_t *);
 extern ssize_t generic_file_aio_read(struct kiocb *, char __user *, size_t, loff_t);
+extern ssize_t generic_file_aio_readv(struct kiocb *, const struct iovec *, unsigned long, loff_t);
 extern ssize_t __generic_file_aio_read(struct kiocb *, const struct iovec *, unsigned long, loff_t *);
 extern ssize_t generic_file_aio_write(struct kiocb *, const char __user *, size_t, loff_t);
+extern ssize_t generic_file_aio_writev(struct kiocb *, const struct iovec *, unsigned long, loff_t);
 extern ssize_t generic_file_aio_write_nolock(struct kiocb *, const struct iovec *,
 		unsigned long, loff_t *);
 extern ssize_t generic_file_direct_write(struct kiocb *, const struct iovec *,
Index: 2.6.14-git5-vectored-aio/mm/filemap.c
===================================================================
--- 2.6.14-git5-vectored-aio.orig/mm/filemap.c	2005-11-02 11:05:07.000000000 -0800
+++ 2.6.14-git5-vectored-aio/mm/filemap.c	2005-11-02 11:09:35.000000000 -0800
@@ -1054,6 +1054,15 @@
 EXPORT_SYMBOL(generic_file_aio_read);
 
 ssize_t
+generic_file_aio_readv(struct kiocb *iocb, const struct iovec *iov,
+		unsigned long nr_segs, loff_t pos)
+{
+	BUG_ON(iocb->ki_pos != pos);
+	return __generic_file_aio_read(iocb, iov, nr_segs, &iocb->ki_pos);
+}
+EXPORT_SYMBOL(generic_file_aio_readv);
+
+ssize_t
 generic_file_read(struct file *filp, char __user *buf, size_t count, loff_t *ppos)
 {
 	struct iovec local_iov = { .iov_base = buf, .iov_len = count };
@@ -2141,32 +2150,39 @@
 }
 EXPORT_SYMBOL(generic_file_write_nolock);
 
-ssize_t generic_file_aio_write(struct kiocb *iocb, const char __user *buf,
-			       size_t count, loff_t pos)
+ssize_t generic_file_aio_writev(struct kiocb *iocb, const struct iovec *iov,
+			        unsigned long nr_segs, loff_t pos)
 {
 	struct file *file = iocb->ki_filp;
 	struct address_space *mapping = file->f_mapping;
 	struct inode *inode = mapping->host;
 	ssize_t ret;
-	struct iovec local_iov = { .iov_base = (void __user *)buf,
-					.iov_len = count };
 
 	BUG_ON(iocb->ki_pos != pos);
 
 	down(&inode->i_sem);
-	ret = __generic_file_aio_write_nolock(iocb, &local_iov, 1,
-						&iocb->ki_pos);
+ 	ret = generic_file_aio_write_nolock(iocb, iov, nr_segs, &iocb->ki_pos);
 	up(&inode->i_sem);
 
 	if (ret > 0 && ((file->f_flags & O_SYNC) || IS_SYNC(inode))) {
 		ssize_t err;
 
+
 		err = sync_page_range(inode, mapping, pos, ret);
 		if (err < 0)
 			ret = err;
 	}
 	return ret;
 }
+EXPORT_SYMBOL(generic_file_aio_writev);
+
+ssize_t generic_file_aio_write(struct kiocb *iocb, const char __user *buf,
+			       size_t count, loff_t pos)
+{
+	struct iovec local_iov = { .iov_base = (void __user *)buf,
+					.iov_len = count };
+	return generic_file_aio_writev(iocb, &local_iov, 1, pos);
+}
 EXPORT_SYMBOL(generic_file_aio_write);
 
 ssize_t generic_file_write(struct file *file, const char __user *buf,
