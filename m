Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264934AbSJPGqE>; Wed, 16 Oct 2002 02:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264935AbSJPGqD>; Wed, 16 Oct 2002 02:46:03 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:43501 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S264934AbSJPGpv>; Wed, 16 Oct 2002 02:45:51 -0400
From: Janet Morgan <janetmor@us.ibm.com>
Message-Id: <200210160651.g9G6pMm17385@eng4.beaverton.ibm.com>
Subject: Re: [RFC] iovec in ->aio_read/->aio_write
To: bcrl@redhat.com (Benjamin LaHaise)
Date: Tue, 15 Oct 2002 23:51:21 -0700 (PDT)
Cc: hch@sgi.com (Christoph Hellwig), akpm@digeo.com,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org
In-Reply-To: <20021015153427.A16156@redhat.com> from "Benjamin LaHaise" at Oct 15, 2002 02:34:27 PM PST
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Tue, Oct 15, 2002 at 10:33:15PM -0400, Christoph Hellwig wrote:
> > Proposed next steps:  Convert over all readv/writev users
> > to aio_read/aio_write and remove the methods.  Implement
> > aio_read/aio_write in all filesystems using the generic
> > pagecache code and kill the "normal" generic_file_read
> > and generic_file_write.
> > 
> > Comments?
> 
> Please not right now? ;-)  At least introduce it as aio_readv/aio_writev 
> as currently the way we deal with iovecs uglifies a lot of code, with no 
> benefit for the vast majority of applications.  As for killing 
> generic_file_read/write and using the aio counterparts, that is the plan 
> pending a bit more testing of things.  I want to get there step by step 
> without breaking everything along the way.
> 
> 		-ben

Here's a patch for aio readv/writev support.  Basically it adds:

- two new opcodes (IOCB_CMD_PREADV and IOCB_CMD_PWRITEV)
- a field to the iocb for the user vector
- aio_readv/writev methods to the file_operations structure
- routine aio.c/io_readv_writev, which borrows heavily from do_readv_writev. 

I tested this using the aio dio patch that Badari submitted a while back. 
I compared:
                readv/writev io_submit for a vector of N iovecs 
                vs read/write io_submit for N iocbs.

My performance data is only preliminary at this point, but aio readv/writev 
appears to outperform aio read/write -- twice as fast in some cases.  The 
results generally make sense to me:  while there is only one io_submit in both 
cases, aio readv/writev shortens codepath (one instead of N calls to the 
underlying filesystem routine) and should normally result in fewer 
bios/callbacks (at least for direct-io).  As importantly, aio readv/writev 
in my testing also reduces the number of (system) calls to io_getevents.

-Janet


 fs/aio.c                |  110 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/aio_abi.h |   12 +++++
 include/linux/fs.h      |    2 
 3 files changed, 124 insertions(+)

--- linux-2.5.42/include/linux/aio_abi.h	Fri Oct 11 21:21:33 2002
+++ aiov/include/linux/aio_abi.h	Tue Oct 15 22:19:05 2002
@@ -41,6 +41,8 @@
 	 * IOCB_CMD_POLL = 5,
 	 */
 	IOCB_CMD_NOOP = 6,
+	IOCB_CMD_PREADV = 7, 
+	IOCB_CMD_PWRITEV = 8,
 };
 
 /* read() from /dev/aio returns these structures. */
@@ -65,6 +67,12 @@
  * proper padding and aio_error abstraction
  */
 
+struct io_iocb_vector {
+       	const struct iovec	*vec;           
+       	__s32			nr;
+       	__s64			offset;
+}; 
+
 struct iocb {
 	/* these are internal to the kernel/libc. */
 	__u64	aio_data;	/* data to be returned in event's data */
@@ -80,6 +88,10 @@
 	__u64	aio_nbytes;
 	__s64	aio_offset;
 
+	union {
+		struct io_iocb_vector	v;
+	} u;
+
 	/* extra parameters */
 	__u64	aio_reserved2;	/* TODO: use this for a (struct sigevent *) */
 	__u64	aio_reserved3;
--- linux-2.5.42/include/linux/fs.h	Fri Oct 11 21:21:35 2002
+++ aiov/include/linux/fs.h	Tue Oct 15 22:14:19 2002
@@ -763,6 +763,8 @@
 	ssize_t (*sendfile) (struct file *, struct file *, loff_t *, size_t);
 	ssize_t (*sendpage) (struct file *, struct page *, int, size_t, loff_t *, int);
 	unsigned long (*get_unmapped_area)(struct file *, unsigned long, unsigned long, unsigned long, unsigned long);
+	ssize_t (*aio_readv) (struct kiocb *, const struct iovec *, unsigned long , loff_t *);
+	ssize_t (*aio_writev) (struct kiocb *, const struct iovec *, unsigned long, loff_t *);
 };
 
 struct inode_operations {
--- linux-2.5.42/fs/aio.c	Fri Oct 11 21:22:07 2002
+++ aiov/fs/aio.c	Tue Oct 15 22:37:29 2002
@@ -33,6 +33,7 @@
 #include <linux/module.h>
 #include <linux/highmem.h>
 #include <linux/workqueue.h>
+#include <linux/dnotify.h>
 
 #include <asm/kmap_types.h>
 #include <asm/uaccess.h>
@@ -992,6 +993,97 @@
 	return -EINVAL;
 }
 
+#define iov(iocb) iocb->u.v.vec
+#define nr_segs(iocb) iocb->u.v.nr
+
+static ssize_t io_readv_writev(int type, struct kiocb *req, 
+	const struct iovec * vector, unsigned long nr_segs, loff_t pos)
+{
+	size_t tot_len;
+	struct iovec iovstack[UIO_FASTIOV];
+	struct iovec *iov=iovstack;
+	ssize_t ret;
+	int seg;
+	struct file *file = req->ki_filp;
+	struct inode *inode = file->f_dentry->d_inode;
+
+	/*
+	 * SuS says "The readv() function *may* fail if the iovcnt argument
+	 * was less than or equal to 0, or greater than {IOV_MAX}.  Linux has
+	 * traditionally returned zero for zero segments, so...
+	 */
+	ret = 0;
+	if (nr_segs == 0)
+		goto out;
+
+	ret = -EINVAL;
+	if ((nr_segs > UIO_MAXIOV) || (nr_segs <= 0))
+		goto out;
+
+	if (nr_segs > UIO_FASTIOV) {
+		ret = -ENOMEM;
+		iov = kmalloc(nr_segs*sizeof(struct iovec), GFP_KERNEL);
+		if (!iov)
+			goto out;
+	}
+
+	if (copy_from_user(iov, vector, nr_segs*sizeof(*vector))) {
+		ret = -EFAULT;
+		goto out;
+	}
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
+		ssize_t len = (ssize_t)iov[seg].iov_len;
+		void * base = iov[seg].iov_base;
+
+		if (len < 0)	/* size_t not fitting an ssize_t .. */
+			goto out;
+		tot_len += len;
+		if (tot_len < tmp) /* maths overflow on the ssize_t */
+			goto out;
+
+		if (unlikely(!access_ok(type == IOCB_CMD_PREAD ?  
+				VERIFY_WRITE : VERIFY_READ, base, len))) {
+			ret = -EFAULT;
+			goto out;
+		}
+	}
+	/* return zero if total length is zero */
+	if (tot_len == 0) {
+		ret = 0;
+		goto out;
+	}
+
+	ret = locks_verify_area((type == IOCB_CMD_PREADV 
+			 ? FLOCK_VERIFY_READ : FLOCK_VERIFY_WRITE),
+				inode, file, file->f_pos, tot_len);
+	if (ret)
+		goto out;
+
+ 	if (type == IOCB_CMD_PREADV)
+		ret = file->f_op->aio_readv(req, iov, nr_segs, &pos);
+	else 
+		ret = file->f_op->aio_writev(req, iov, nr_segs, &pos);
+
+out:
+	if (iov != iovstack)
+		kfree(iov);
+	if ((ret + (type == IOCB_CMD_PREADV)) > 0)
+		dnotify_parent(file->f_dentry,
+			(type == IOCB_CMD_PREADV) ? DN_MODIFY : DN_ACCESS);
+	return ret;
+}
+
 static int FASTCALL(io_submit_one(struct kioctx *ctx, struct iocb *user_iocb,
 				  struct iocb *iocb));
 static int io_submit_one(struct kioctx *ctx, struct iocb *user_iocb,
@@ -1068,6 +1160,24 @@
 			ret = file->f_op->aio_write(req, buf,
 					iocb->aio_nbytes, req->ki_pos);
 		break;
+	case IOCB_CMD_PREADV:
+		ret = -EBADF;
+		if (unlikely(!(file->f_mode & FMODE_READ)))
+			goto out_put_req;
+		ret = -EINVAL;
+		if (file->f_op->aio_readv)
+			ret = io_readv_writev(IOCB_CMD_PREADV, req, 
+				iov(iocb), nr_segs(iocb), iocb->aio_offset);
+		break;
+	case IOCB_CMD_PWRITEV:
+		ret = -EBADF;
+		if (unlikely(!(file->f_mode & FMODE_WRITE)))
+			goto out_put_req;
+		ret = -EINVAL;
+		if (file->f_op->aio_writev)
+			ret = io_readv_writev(IOCB_CMD_PWRITEV, req, 
+				iov(iocb), nr_segs(iocb), iocb->aio_offset);
+		break;
 	case IOCB_CMD_FDSYNC:
 		ret = -EINVAL;
 		if (file->f_op->aio_fsync)
