Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261362AbSJQLRR>; Thu, 17 Oct 2002 07:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261368AbSJQLRR>; Thu, 17 Oct 2002 07:17:17 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:30433 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261362AbSJQLRK>;
	Thu, 17 Oct 2002 07:17:10 -0400
From: Janet Morgan <janetmor@us.ibm.com>
Message-Id: <200210171122.g9HBMYa12548@eng4.beaverton.ibm.com>
Subject: Re: [RFC] iovec in ->aio_read/->aio_write
To: bcrl@redhat.com (Benjamin LaHaise)
Date: Thu, 17 Oct 2002 04:22:33 -0700 (PDT)
Cc: janetmor@us.ibm.com (Janet Morgan), hch@sgi.com (Christoph Hellwig),
       akpm@digeo.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-aio@kvack.org
In-Reply-To: <20021016110642.A9121@redhat.com> from "Benjamin LaHaise" at Oct 16, 2002 10:06:42 AM PST
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Tue, Oct 15, 2002 at 11:51:21PM -0700, Janet Morgan wrote:
> > - two new opcodes (IOCB_CMD_PREADV and IOCB_CMD_PWRITEV)
> > - a field to the iocb for the user vector
> > - aio_readv/writev methods to the file_operations structure
> > - routine aio.c/io_readv_writev, which borrows heavily from do_readv_writev. 
> 
> A few comments about the interface to userland: don't add fields to the 
> iocb, that breaks the abi.  Also, the iovec should be pointed to by 
> iocb->aio_buf, with aio_nbytes containing the length of the iovec (that 
> avoids the need for an additional field).  The structure of the iovec 
> itself should probably match the iovec struct, but that means we'll need 
> different opcodes for the 32 bit and 64 bit variants.  Alternatively a 
> new iovec that is the same on both (like the iocb) could be defined, but 
> that would be inconvenient for userland.
> 
> Within the kernel, the loff_t *pos shouldn't be a pointer -- I'm trying to 
> get rid of extraneous pointers as that means an additional chunk of memory 
> has to be held over the entirety of the aio request.  Similarly, the iovec 
> passed into the operation itself can never be allocated on the stack.  This 
> probably works for direct io where the iovec gets translated into a scatter 
> gather list of pages, but wouldn't work for something like networking where 
> the iovec itself gets used to determine where in the user address space to 
> copy data (as this can occur after the submit operation has returned).
> 
> Aside from those details, I guess if people really need vectored ios it's 
> okay.
> 
> 		-ben
> 

Thanks for the really helpful comments.  I've attached another version
of the patch. 

In addition to (hopefully) addressing the issues you raised, I also 
removed the calls to locks_verify_area and dnotify_parent from my original 
patch.  Please let me know if you think I should re-instate those calls or 
if you see any new problems. 

-Janet


 fs/aio.c                |  156 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/aio.h     |    1 
 include/linux/aio_abi.h |   14 ++++
 include/linux/fs.h      |    2 
 4 files changed, 173 insertions(+)


--- linux-2.5.43/include/linux/aio_abi.h	Tue Oct 15 20:27:18 2002
+++ aiov/include/linux/aio_abi.h	Wed Oct 16 23:27:40 2002
@@ -41,6 +41,10 @@
 	 * IOCB_CMD_POLL = 5,
 	 */
 	IOCB_CMD_NOOP = 6,
+	IOCB_CMD_PREADV32 = 7, 
+	IOCB_CMD_PREADV64 = 8, 
+	IOCB_CMD_PWRITEV32 = 9,
+	IOCB_CMD_PWRITEV64 = 10,
 };
 
 /* read() from /dev/aio returns these structures. */
@@ -85,6 +89,16 @@
 	__u64	aio_reserved3;
 }; /* 64 bytes */
 
+struct iovec32 {
+        __u32 iov_base;
+        __u32 iov_len;
+};
+
+struct iovec64 {
+        __u64 iov_base;
+        __u64 iov_len;
+};
+
 #undef IFBIG
 #undef IFLITTLE
 
--- linux-2.5.43/include/linux/fs.h	Tue Oct 15 20:27:45 2002
+++ aiov/include/linux/fs.h	Wed Oct 16 20:41:33 2002
@@ -764,6 +764,8 @@
 	ssize_t (*sendfile) (struct file *, struct file *, loff_t *, size_t);
 	ssize_t (*sendpage) (struct file *, struct page *, int, size_t, loff_t *, int);
 	unsigned long (*get_unmapped_area)(struct file *, unsigned long, unsigned long, unsigned long, unsigned long);
+	ssize_t (*aio_readv) (struct kiocb *, const struct iovec *, unsigned long , loff_t);
+	ssize_t (*aio_writev) (struct kiocb *, const struct iovec *, unsigned long, loff_t);
 };
 
 struct inode_operations {
--- linux-2.5.43/include/linux/aio.h	Tue Oct 15 20:27:09 2002
+++ aiov/include/linux/aio.h	Wed Oct 16 20:41:33 2002
@@ -51,6 +51,7 @@
 	int			ki_users;
 	unsigned		ki_key;		/* id of this request */
 
+ 	struct iovec		*ki_iov;        /* io vector for readv/writev */
 	struct file		*ki_filp;
 	struct kioctx		*ki_ctx;	/* may be NULL for sync ops */
 	int			(*ki_cancel)(struct kiocb *, struct io_event *);
--- linux-2.5.43/fs/aio.c	Tue Oct 15 20:27:57 2002
+++ aiov/fs/aio.c	Thu Oct 17 02:40:49 2002
@@ -28,6 +28,7 @@
 #include <linux/module.h>
 #include <linux/highmem.h>
 #include <linux/workqueue.h>
+#include <linux/dnotify.h>
 
 #include <asm/kmap_types.h>
 #include <asm/uaccess.h>
@@ -393,6 +394,7 @@
 	req->ki_users = 1;
 	req->ki_key = 0;
 	req->ki_ctx = ctx;
+	req->ki_iov = NULL;
 	req->ki_cancel = NULL;
 	req->ki_retry = NULL;
 	req->ki_user_obj = NULL;
@@ -444,6 +446,9 @@
 	req->ki_ctx = NULL;
 	req->ki_filp = NULL;
 	req->ki_user_obj = NULL;
+	if (req->ki_iov)
+		kfree(req->ki_iov);
+	req->ki_iov = NULL;
 	kmem_cache_free(kiocb_cachep, req);
 	ctx->reqs_active--;
 
@@ -987,6 +992,139 @@
 	return -EINVAL;
 }
 
+#define _32bit_kiov (sizeof(struct iovec) == sizeof(struct iovec32)) 
+#define _64bit_kiov (sizeof(struct iovec) == sizeof(struct iovec64)) 
+
+#define _32bit(cmd) 		\
+	(((cmd) == IOCB_CMD_PREADV32) || ((cmd) == IOCB_CMD_PWRITEV32))
+#define _64bit(cmd) 		\
+	(((cmd) == IOCB_CMD_PREADV64) || ((cmd) == IOCB_CMD_PWRITEV64))
+
+#define is_readv(cmd)		\
+	(((cmd) == IOCB_CMD_PREADV32) || ((cmd) == IOCB_CMD_PREADV64))
+
+#define can_fast_copy(cmd) 	\
+	((_32bit(cmd) && _32bit_kiov) || ((_64bit(cmd) && _64bit_kiov)))
+
+int resize_user_vec(int cmd, struct kiocb *req, const struct iovec *uiov, 
+		         unsigned long nr_segs)
+{
+	size_t len;
+	struct iovec32 *iov32;
+	struct iovec64 *iov64;
+	struct iovec *kiov = req->ki_iov; 
+	int seg, ret = 0;
+
+	/* 
+	 * copy 32-bit user iovecs to 64-bit kernel iovecs or vice versa 
+	 */
+	if (_32bit(cmd)) {
+		len = nr_segs*sizeof(struct iovec32);
+		iov32 = kmalloc(len, GFP_KERNEL);
+		if (!iov32)
+			return -ENOMEM;
+		if (copy_from_user(iov32, uiov, len)) 
+			ret = -EFAULT;
+		else for (seg = 0; seg < nr_segs; seg++) {
+			kiov[seg].iov_base = (void *)iov32[seg].iov_base;
+			kiov[seg].iov_len = iov32[seg].iov_len;
+		}
+		kfree(iov32);
+
+	} else {
+		len = nr_segs*sizeof(struct iovec64);
+		iov64 = kmalloc(len, GFP_KERNEL);
+		if (!iov64)
+			return -ENOMEM;
+		if (copy_from_user(iov64, uiov, len)) 
+			ret = -EFAULT;
+		else for (seg = 0; seg < nr_segs; seg++) {
+			kiov[seg].iov_base = 
+				(void *)(unsigned long)iov64[seg].iov_base;
+			kiov[seg].iov_len = iov64[seg].iov_len;
+		}
+		kfree(iov64);
+	}
+out:
+	return ret;
+}
+
+#define iov(iocb) (const struct iovec *)(unsigned long)iocb->aio_buf
+#define nr_segs(iocb) (unsigned long)iocb->aio_nbytes
+
+static ssize_t io_readv_writev(int cmd, struct kiocb *req, struct iocb *iocb)
+{
+	size_t tot_len;
+	int seg;
+	struct file *file = req->ki_filp;
+	const struct iovec *uiov = iov(iocb);
+	unsigned long nr_segs = nr_segs(iocb);
+	ssize_t ret = 0;
+
+	if (nr_segs == 0) 
+		goto out;
+
+	if ((nr_segs > UIO_MAXIOV) || ((ssize_t)nr_segs < 0)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	req->ki_iov = kmalloc(nr_segs*sizeof(struct iovec), GFP_KERNEL);
+	if (!req->ki_iov) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	ret = -EFAULT;
+	if (can_fast_copy(cmd)) { 
+		int len = nr_segs * sizeof(struct iovec);
+		if (copy_from_user(req->ki_iov, uiov, len)) {
+			goto out;
+		}
+	} else if (resize_user_vec(cmd, req, uiov, nr_segs)) 
+		goto out;
+
+	/*
+	 * Single unix specification:
+	 * We should -EINVAL if an element length is not >= 0 or if 
+	 * the total length does not fit a ssize_t.
+	 *
+	 * Be careful here because iov_len is a size_t not a ssize_t.
+	 */
+	tot_len = 0;
+	ret = -EINVAL;
+	for (seg = 0 ; seg < nr_segs; seg++) {
+		ssize_t tmp = tot_len;
+		ssize_t len = (ssize_t)req->ki_iov[seg].iov_len;
+		void * base = req->ki_iov[seg].iov_base;
+
+		if (len < 0)	/* size_t not fitting an ssize_t .. */
+			goto out;
+		tot_len += len;
+		if (tot_len < tmp) /* maths overflow on the ssize_t */
+			goto out;
+
+		if (unlikely(!access_ok(is_readv(cmd) ?  
+				VERIFY_WRITE : VERIFY_READ, base, len))) {
+			ret = -EFAULT;
+			goto out;
+		}
+	}
+	if (tot_len == 0) {
+		ret = 0;
+		goto out;
+	}
+
+	if (is_readv(cmd))
+		ret = file->f_op->aio_readv(req, req->ki_iov, 
+				nr_segs(iocb), iocb->aio_offset);
+	else 
+		ret = file->f_op->aio_writev(req, req->ki_iov, 
+				nr_segs(iocb), iocb->aio_offset);
+out:
+	return ret;
+}
+
 static int FASTCALL(io_submit_one(struct kioctx *ctx, struct iocb *user_iocb,
 				  struct iocb *iocb));
 static int io_submit_one(struct kioctx *ctx, struct iocb *user_iocb,
@@ -1063,6 +1201,24 @@
 			ret = file->f_op->aio_write(req, buf,
 					iocb->aio_nbytes, req->ki_pos);
 		break;
+	case IOCB_CMD_PREADV32:
+	case IOCB_CMD_PREADV64:
+		ret = -EBADF;
+		if (unlikely(!(file->f_mode & FMODE_READ)))
+			goto out_put_req;
+		ret = -EINVAL;
+		if (file->f_op->aio_readv)
+			ret = io_readv_writev(iocb->aio_lio_opcode, req, iocb); 
+		break;
+	case IOCB_CMD_PWRITEV32:
+	case IOCB_CMD_PWRITEV64:
+		ret = -EBADF;
+		if (unlikely(!(file->f_mode & FMODE_WRITE)))
+			goto out_put_req;
+		ret = -EINVAL;
+		if (file->f_op->aio_writev)
+			ret = io_readv_writev(iocb->aio_lio_opcode, req, iocb); 
+		break;
 	case IOCB_CMD_FDSYNC:
 		ret = -EINVAL;
 		if (file->f_op->aio_fsync)

