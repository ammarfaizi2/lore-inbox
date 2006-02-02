Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932108AbWBBQPr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbWBBQPr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 11:15:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932111AbWBBQPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 11:15:47 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:21429 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932108AbWBBQPq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 11:15:46 -0500
Subject: [PATCH 3/3] Zack's core aio changes to support vectored AIO.
From: Badari Pulavarty <pbadari@us.ibm.com>
To: christoph <hch@lst.de>
Cc: Benjamin LaHaise <bcrl@kvack.org>, Zach Brown <zach.brown@oracle.com>,
       lkml <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>
In-Reply-To: <1138896758.28382.112.camel@dyn9047017102.beaverton.ibm.com>
References: <1138896758.28382.112.camel@dyn9047017102.beaverton.ibm.com>
Content-Type: multipart/mixed; boundary="=-feylF3Y/4dBYEBUFxQ7y"
Date: Thu, 02 Feb 2006 08:16:36 -0800
Message-Id: <1138896996.28382.119.camel@dyn9047017102.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-feylF3Y/4dBYEBUFxQ7y
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This work is initailly done by Zack Brown to add support for
vectored aio. These are the core changes for AIO to support
IOCB_CMD_PREADV/IOCB_CMD_PWRITEV.

Zack, can you please review the changes as I took most of the
core changes and incorporated into my set. And also could we
further colapse aio_pread/aio_write also into aio_rw_vect_retry() ?
BTW, I haven't done any testing on vectored AIO since I don't have
user-level library changes :( 
Please do.

Thanks,
Badari




--=-feylF3Y/4dBYEBUFxQ7y
Content-Disposition: attachment; filename=zack-aiocore-changes.patch
Content-Type: text/x-patch; name=zack-aiocore-changes.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

This work is initailly done by Zack Brown to add support for
vectored aio. These are the core changes for AIO to support
IOCB_CMD_PREADV/IOCB_CMD_PWRITEV. 

Zack, can you please review the changes as I took most of the
core changes and incorporated into my set. And also could we 
further colapse aio_pread/aio_write also into aio_rw_vect_retry() ?
BTW, I haven't done any testing on vectored AIO :( Please do.

Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>
Index: linux-2.6.16-rc1.quilt/fs/aio.c
===================================================================
--- linux-2.6.16-rc1.quilt.orig/fs/aio.c	2006-02-01 11:04:28.000000000 -0800
+++ linux-2.6.16-rc1.quilt/fs/aio.c	2006-02-01 14:25:32.000000000 -0800
@@ -416,6 +416,7 @@
 	req->ki_retry = NULL;
 	req->ki_dtor = NULL;
 	req->private = NULL;
+	req->ki_iovec = NULL;
 	INIT_LIST_HEAD(&req->ki_run_list);
 
 	/* Check if the completion queue has enough free space to
@@ -461,6 +462,7 @@
 
 	if (req->ki_dtor)
 		req->ki_dtor(req);
+	kfree(req->ki_iovec);
 	kmem_cache_free(kiocb_cachep, req);
 	ctx->reqs_active--;
 
@@ -1302,6 +1304,64 @@
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
+		rw_op = file->f_op->aio_read;
+	else
+		rw_op = file->f_op->aio_write;
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
@@ -1393,6 +1453,27 @@
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
@@ -1434,6 +1515,28 @@
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
+		if (file->f_op->aio_read)
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
+		if (file->f_op->aio_write)
+			kiocb->ki_retry = aio_rw_vect_retry;
+		break;
 	case IOCB_CMD_FDSYNC:
 		ret = -EINVAL;
 		if (file->f_op->aio_fsync)
Index: linux-2.6.16-rc1.quilt/include/linux/aio.h
===================================================================
--- linux-2.6.16-rc1.quilt.orig/include/linux/aio.h	2006-01-16 23:44:47.000000000 -0800
+++ linux-2.6.16-rc1.quilt/include/linux/aio.h	2006-02-01 14:58:08.000000000 -0800
@@ -112,6 +112,9 @@
 	long			ki_retried; 	/* just for testing */
 	long			ki_kicked; 	/* just for testing */
 	long			ki_queued; 	/* just for testing */
+	struct iovec		*ki_iovec;
+	unsigned long		ki_nr_segs;
+	unsigned long		ki_cur_seg;
 
 	struct list_head	ki_list;	/* the aio core uses this
 						 * for cancellation */
Index: linux-2.6.16-rc1.quilt/include/linux/aio_abi.h
===================================================================
--- linux-2.6.16-rc1.quilt.orig/include/linux/aio_abi.h	2006-01-16 23:44:47.000000000 -0800
+++ linux-2.6.16-rc1.quilt/include/linux/aio_abi.h	2006-02-01 14:58:42.000000000 -0800
@@ -41,6 +41,8 @@
 	 * IOCB_CMD_POLL = 5,
 	 */
 	IOCB_CMD_NOOP = 6,
+	IOCB_CMD_PREADV = 7,
+	IOCB_CMD_PWRITEV = 8,
 };
 
 /* read() from /dev/aio returns these structures. */
Index: linux-2.6.16-rc1.quilt/fs/read_write.c
===================================================================
--- linux-2.6.16-rc1.quilt.orig/fs/read_write.c	2006-02-01 11:04:33.000000000 -0800
+++ linux-2.6.16-rc1.quilt/fs/read_write.c	2006-02-01 15:10:42.000000000 -0800
@@ -511,72 +511,103 @@
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
 {
-	size_t tot_len;
+	ssize_t tot_len;
 	struct iovec iovstack[UIO_FASTIOV];
 	struct iovec *iov = iovstack;
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
-		goto out;
-
-	/*
-	 * First get the "struct iovec" from user memory and
-	 * verify all the pointers
-	 */
-	ret = -EINVAL;
-	if ((nr_segs > UIO_MAXIOV) || (nr_segs <= 0))
-		goto out;
-	if (!file->f_op)
+	if (!file->f_op) {
+		ret = -EINVAL;
 		goto out;
-	if (nr_segs > UIO_FASTIOV) {
-		ret = -ENOMEM;
-		iov = kmalloc(nr_segs*sizeof(struct iovec), GFP_KERNEL);
-		if (!iov)
-			goto out;
 	}
-	ret = -EFAULT;
-	if (copy_from_user(iov, uvector, nr_segs*sizeof(*uvector)))
+
+	ret = rw_copy_check_uvector(uvector, nr_segs, ARRAY_SIZE(iovstack),
+			iovstack, &iov);
+
+	if (ret < 0)
 		goto out;
 
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
-	}
-	if (tot_len == 0) {
-		ret = 0;
+	if (ret == 0)
 		goto out;
-	}
 
+	tot_len = ret;
 	ret = rw_verify_area(type, file, pos, tot_len);
 	if (ret < 0)
 		goto out;
@@ -608,9 +639,6 @@
 			fsnotify_modify(file->f_dentry);
 	}
 	return ret;
-Efault:
-	ret = -EFAULT;
-	goto out;
 }
 
 ssize_t vfs_readv(struct file *file, const struct iovec __user *vec,
Index: linux-2.6.16-rc1.quilt/include/linux/fs.h
===================================================================
--- linux-2.6.16-rc1.quilt.orig/include/linux/fs.h	2006-02-01 11:04:33.000000000 -0800
+++ linux-2.6.16-rc1.quilt/include/linux/fs.h	2006-02-01 15:12:51.000000000 -0800
@@ -1048,6 +1048,11 @@
 
 struct seq_file;
 
+ssize_t rw_copy_check_uvector(const struct iovec __user * uvector,
+				unsigned long nr_segs, unsigned long fast_segs,
+				struct iovec *fast_pointer,
+				struct iovec **ret_pointer);
+
 extern ssize_t vfs_read(struct file *, char __user *, size_t, loff_t *);
 extern ssize_t vfs_write(struct file *, const char __user *, size_t, loff_t *);
 extern ssize_t vfs_readv(struct file *, const struct iovec __user *,

--=-feylF3Y/4dBYEBUFxQ7y--

