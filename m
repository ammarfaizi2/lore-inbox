Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965252AbWEOVVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965252AbWEOVVw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 17:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965258AbWEOVVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 17:21:51 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:51653 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S965252AbWEOVV1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 17:21:27 -0400
Subject: [PATCH 3/4] Core aio changes to support vectored AIO
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
Date: Mon, 15 May 2006 14:22:41 -0700
Message-Id: <1147728161.6181.5.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This work is initially done by Zach Brown to add support for
vectored aio. These are the core changes for AIO to support
IOCB_CMD_PREADV/IOCB_CMD_PWRITEV. 

I made few extra changes beyond Zach's work. They are
	- took out aio_pread/aio_pwrite and made them
	  a special case into vectored support
	- added single inlined vector to save on kmalloc()
	  for a simple aio_read/aio_write

Signed-off-by: Zach Brown <zach.brown@oracle.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>
Acked-by: Benjamin LaHaise <bcrl@kvack.org>

 fs/aio.c                |  165 +++++++++++++++++++++++++++++++++---------------
 fs/read_write.c         |  127 +++++++++++++++++++++---------------
 include/linux/aio.h     |    4 +
 include/linux/aio_abi.h |    2 
 include/linux/fs.h      |    5 +
 5 files changed, 199 insertions(+), 104 deletions(-)

Index: linux-2.6.17-rc4/fs/aio.c
===================================================================
--- linux-2.6.17-rc4.orig/fs/aio.c	2006-05-15 14:09:44.399567976 -0700
+++ linux-2.6.17-rc4/fs/aio.c	2006-05-15 14:14:02.691301664 -0700
@@ -415,6 +415,7 @@ static struct kiocb fastcall *__aio_get_
 	req->ki_retry = NULL;
 	req->ki_dtor = NULL;
 	req->private = NULL;
+	req->ki_iovec = NULL;
 	INIT_LIST_HEAD(&req->ki_run_list);
 
 	/* Check if the completion queue has enough free space to
@@ -460,6 +461,8 @@ static inline void really_put_req(struct
 
 	if (req->ki_dtor)
 		req->ki_dtor(req);
+	if (req->ki_iovec != &req->ki_inline_vec)
+		kfree(req->ki_iovec);
 	kmem_cache_free(kiocb_cachep, req);
 	ctx->reqs_active--;
 
@@ -1301,69 +1304,63 @@ asmlinkage long sys_io_destroy(aio_conte
 	return -EINVAL;
 }
 
-/*
- * aio_p{read,write} are the default  ki_retry methods for
- * IO_CMD_P{READ,WRITE}.  They maintains kiocb retry state around potentially
- * multiple calls to f_op->aio_read().  They loop around partial progress
- * instead of returning -EIOCBRETRY because they don't have the means to call
- * kick_iocb().
- */
-static ssize_t aio_pread(struct kiocb *iocb)
+static void aio_advance_iovec(struct kiocb *iocb, ssize_t ret)
 {
-	struct file *file = iocb->ki_filp;
-	struct address_space *mapping = file->f_mapping;
-	struct inode *inode = mapping->host;
-	ssize_t ret = 0;
+	struct iovec *iov = &iocb->ki_iovec[iocb->ki_cur_seg];
 
-	do {
-		iocb->ki_inline_vec.iov_base = iocb->ki_buf;
-		iocb->ki_inline_vec.iov_len = iocb->ki_left;
+	BUG_ON(ret <= 0);
 
-		ret = file->f_op->aio_read(iocb, &iocb->ki_inline_vec,
-						1, iocb->ki_pos);
-		/*
-		 * Can't just depend on iocb->ki_left to determine
-		 * whether we are done. This may have been a short read.
-		 */
-		if (ret > 0) {
-			iocb->ki_buf += ret;
-			iocb->ki_left -= ret;
+	while (iocb->ki_cur_seg < iocb->ki_nr_segs && ret > 0) {
+		ssize_t this = min((ssize_t)iov->iov_len, ret);
+		iov->iov_base += this;
+		iov->iov_len -= this;
+		iocb->ki_left -= this;
+		ret -= this;
+		if (iov->iov_len == 0) {
+			iocb->ki_cur_seg++;
+			iov++;
 		}
+	}
 
-		/*
-		 * For pipes and sockets we return once we have some data; for
-		 * regular files we retry till we complete the entire read or
-		 * find that we can't read any more data (e.g short reads).
-		 */
-	} while (ret > 0 && iocb->ki_left > 0 &&
-		 !S_ISFIFO(inode->i_mode) && !S_ISSOCK(inode->i_mode));
-
-	/* This means we must have transferred all that we could */
-	/* No need to retry anymore */
-	if ((ret == 0) || (iocb->ki_left == 0))
-		ret = iocb->ki_nbytes - iocb->ki_left;
-
-	return ret;
+	/* the caller should not have done more io than what fit in
+	 * the remaining iovecs */
+	BUG_ON(ret > 0 && iocb->ki_left == 0);
 }
 
-/* see aio_pread() */
-static ssize_t aio_pwrite(struct kiocb *iocb)
+static ssize_t aio_rw_vect_retry(struct kiocb *iocb)
 {
 	struct file *file = iocb->ki_filp;
+	struct address_space *mapping = file->f_mapping;
+	struct inode *inode = mapping->host;
+	ssize_t (*rw_op)(struct kiocb *, const struct iovec *,
+			 unsigned long, loff_t);
 	ssize_t ret = 0;
+	unsigned short opcode;
+
+	if ((iocb->ki_opcode == IOCB_CMD_PREADV) ||
+		(iocb->ki_opcode == IOCB_CMD_PREAD)) {
+		rw_op = file->f_op->aio_read;
+		opcode = IOCB_CMD_PREADV;
+	} else {
+		rw_op = file->f_op->aio_write;
+		opcode = IOCB_CMD_PWRITEV;
+	}
 
 	do {
-		iocb->ki_inline_vec.iov_base = iocb->ki_buf;
-		iocb->ki_inline_vec.iov_len = iocb->ki_left;
+		ret = rw_op(iocb, &iocb->ki_iovec[iocb->ki_cur_seg],
+			    iocb->ki_nr_segs - iocb->ki_cur_seg,
+			    iocb->ki_pos);
+		if (ret > 0)
+			aio_advance_iovec(iocb, ret);
 
-		ret = file->f_op->aio_write(iocb, &iocb->ki_inline_vec,
-						1, iocb->ki_pos);
-		if (ret > 0) {
-			iocb->ki_buf += ret;
-			iocb->ki_left -= ret;
-		}
-	} while (ret > 0 && iocb->ki_left > 0);
+	/* retry all partial writes.  retry partial reads as long as its a
+	 * regular file. */
+	} while (ret > 0 && iocb->ki_left > 0 &&
+		 (opcode == IOCB_CMD_PWRITEV ||
+		  (!S_ISFIFO(inode->i_mode) && !S_ISSOCK(inode->i_mode))));
 
+	/* This means we must have transferred all that we could */
+	/* No need to retry anymore */
 	if ((ret == 0) || (iocb->ki_left == 0))
 		ret = iocb->ki_nbytes - iocb->ki_left;
 
@@ -1390,6 +1387,38 @@ static ssize_t aio_fsync(struct kiocb *i
 	return ret;
 }
 
+static ssize_t aio_setup_vectored_rw(struct kiocb *kiocb)
+{
+	ssize_t ret;
+
+	ret = rw_copy_check_uvector((struct iovec __user *)kiocb->ki_buf,
+				    kiocb->ki_nbytes, 1,
+				    &kiocb->ki_inline_vec, &kiocb->ki_iovec);
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
+static ssize_t aio_setup_single_vector(struct kiocb *kiocb)
+{
+	kiocb->ki_iovec = &kiocb->ki_inline_vec;
+	kiocb->ki_iovec->iov_base = kiocb->ki_buf;
+	kiocb->ki_iovec->iov_len = kiocb->ki_left;
+	kiocb->ki_nr_segs = 1;
+	kiocb->ki_cur_seg = 0;
+	kiocb->ki_nbytes = kiocb->ki_left;
+	return 0;
+}
+
 /*
  * aio_setup_iocb:
  *	Performs the initial checks and aio retry method
@@ -1412,9 +1441,12 @@ static ssize_t aio_setup_iocb(struct kio
 		ret = security_file_permission(file, MAY_READ);
 		if (unlikely(ret))
 			break;
+		ret = aio_setup_single_vector(kiocb);
+		if (ret)
+			break;
 		ret = -EINVAL;
 		if (file->f_op->aio_read)
-			kiocb->ki_retry = aio_pread;
+			kiocb->ki_retry = aio_rw_vect_retry;
 		break;
 	case IOCB_CMD_PWRITE:
 		ret = -EBADF;
@@ -1427,9 +1459,40 @@ static ssize_t aio_setup_iocb(struct kio
 		ret = security_file_permission(file, MAY_WRITE);
 		if (unlikely(ret))
 			break;
+		ret = aio_setup_single_vector(kiocb);
+		if (ret)
+			break;
+		ret = -EINVAL;
+		if (file->f_op->aio_write)
+			kiocb->ki_retry = aio_rw_vect_retry;
+		break;
+	case IOCB_CMD_PREADV:
+		ret = -EBADF;
+		if (unlikely(!(file->f_mode & FMODE_READ)))
+			break;
+		ret = security_file_permission(file, MAY_READ);
+		if (unlikely(ret))
+			break;
+		ret = aio_setup_vectored_rw(kiocb);
+		if (ret)
+			break;
+		ret = -EINVAL;
+		if (file->f_op->aio_read)
+			kiocb->ki_retry = aio_rw_vect_retry;
+		break;
+	case IOCB_CMD_PWRITEV:
+		ret = -EBADF;
+		if (unlikely(!(file->f_mode & FMODE_WRITE)))
+			break;
+		ret = security_file_permission(file, MAY_WRITE);
+		if (unlikely(ret))
+			break;
+		ret = aio_setup_vectored_rw(kiocb);
+		if (ret)
+			break;
 		ret = -EINVAL;
 		if (file->f_op->aio_write)
-			kiocb->ki_retry = aio_pwrite;
+			kiocb->ki_retry = aio_rw_vect_retry;
 		break;
 	case IOCB_CMD_FDSYNC:
 		ret = -EINVAL;
Index: linux-2.6.17-rc4/include/linux/aio.h
===================================================================
--- linux-2.6.17-rc4.orig/include/linux/aio.h	2006-05-15 14:09:44.400567824 -0700
+++ linux-2.6.17-rc4/include/linux/aio.h	2006-05-15 14:14:02.692301512 -0700
@@ -7,6 +7,7 @@
 #include <linux/uio.h>
 
 #include <asm/atomic.h>
+#include <linux/uio.h>
 
 #define AIO_MAXSEGS		4
 #define AIO_KIOGRP_NR_ATOMIC	8
@@ -114,6 +115,9 @@ struct kiocb {
 	long			ki_kicked; 	/* just for testing */
 	long			ki_queued; 	/* just for testing */
 	struct iovec		ki_inline_vec;	/* inline vector */
+ 	struct iovec		*ki_iovec;
+ 	unsigned long		ki_nr_segs;
+ 	unsigned long		ki_cur_seg;
 
 	struct list_head	ki_list;	/* the aio core uses this
 						 * for cancellation */
Index: linux-2.6.17-rc4/include/linux/aio_abi.h
===================================================================
--- linux-2.6.17-rc4.orig/include/linux/aio_abi.h	2006-05-15 14:09:44.400567824 -0700
+++ linux-2.6.17-rc4/include/linux/aio_abi.h	2006-05-15 14:14:02.692301512 -0700
@@ -41,6 +41,8 @@ enum {
 	 * IOCB_CMD_POLL = 5,
 	 */
 	IOCB_CMD_NOOP = 6,
+	IOCB_CMD_PREADV = 7,
+	IOCB_CMD_PWRITEV = 8,
 };
 
 /* read() from /dev/aio returns these structures. */
Index: linux-2.6.17-rc4/fs/read_write.c
===================================================================
--- linux-2.6.17-rc4.orig/fs/read_write.c	2006-05-15 14:14:00.584621928 -0700
+++ linux-2.6.17-rc4/fs/read_write.c	2006-05-15 14:14:02.693301360 -0700
@@ -507,6 +507,74 @@ ssize_t do_loop_readv_writev(struct file
 	return ret;
 }
 
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
+	if (nr_segs > UIO_MAXIOV) {
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
 /* A write operation does a read from user space and vice versa */
 #define vrfy_dir(type) ((type) == READ ? VERIFY_WRITE : VERIFY_READ)
 
@@ -518,64 +586,20 @@ static ssize_t do_readv_writev(int type,
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
+	if (!file->f_op) {
+		ret = -EINVAL;
 		goto out;
-
-	/*
-	 * First get the "struct iovec" from user memory and
-	 * verify all the pointers
-	 */
-	ret = -EINVAL;
-	if (nr_segs > UIO_MAXIOV)
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
-	}
-	if (tot_len == 0) {
-		ret = 0;
+	ret = rw_copy_check_uvector(uvector, nr_segs, ARRAY_SIZE(iovstack),
+			iovstack, &iov);
+	if (ret <= 0)
 		goto out;
-	}
 
+	tot_len = ret;
 	ret = rw_verify_area(type, file, pos, tot_len);
 	if (ret < 0)
 		goto out;
@@ -608,9 +632,6 @@ out:
 			fsnotify_modify(file->f_dentry);
 	}
 	return ret;
-Efault:
-	ret = -EFAULT;
-	goto out;
 }
 
 ssize_t vfs_readv(struct file *file, const struct iovec __user *vec,
Index: linux-2.6.17-rc4/include/linux/fs.h
===================================================================
--- linux-2.6.17-rc4.orig/include/linux/fs.h	2006-05-15 14:14:00.587621472 -0700
+++ linux-2.6.17-rc4/include/linux/fs.h	2006-05-15 14:14:02.695301056 -0700
@@ -1068,6 +1068,11 @@ struct inode_operations {
 
 struct seq_file;
 
+ssize_t rw_copy_check_uvector(const struct iovec __user * uvector,
+				unsigned long nr_segs, unsigned long fast_segs,
+				struct iovec *fast_pointer,
+				struct iovec **ret_pointer);
+
 extern ssize_t vfs_read(struct file *, char __user *, size_t, loff_t *);
 extern ssize_t vfs_write(struct file *, const char __user *, size_t, loff_t *);
 extern ssize_t vfs_readv(struct file *, const struct iovec __user *,


