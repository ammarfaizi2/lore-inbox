Return-Path: <linux-kernel-owner+w=401wt.eu-S932312AbXAPCES@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbXAPCES (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 21:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932242AbXAPCEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 21:04:04 -0500
Received: from 64.221.212.177.ptr.us.xo.net ([64.221.212.177]:25129 "EHLO
	ext.agami.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932254AbXAPCDg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 21:03:36 -0500
X-Greylist: delayed 510 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Jan 2007 21:03:27 EST
From: Nate Diller <nate@agami.com>
To: Nate Diller <nate.diller@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Benjamin LaHaise <bcrl@kvack.org>,
       Alexander Viro <viro@zeniv.linux.org.uk>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Kenneth W Chen <kenneth.w.chen@intel.com>,
       David Brownell <dbrownell@users.sourceforge.net>,
       Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       netdev@vger.kernel.org, ocfs2-devel@oss.oracle.com, linux-aio@kvack.org,
       xfs-masters@oss.sgi.com
Date: Mon, 15 Jan 2007 17:54:50 -0800
Message-Id: <20070116015450.9764.38389.patchbomb.py@nate-64.agami.com>
In-Reply-To: <20070116015450.9764.37697.patchbomb.py@nate-64.agami.com>
Subject: [PATCH -mm 4/10][RFC] aio: convert aio_complete to file_endio_t
X-OriginalArrivalTime: 16 Jan 2007 01:55:11.0286 (UTC) FILETIME=[5B54CD60:01C73911]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Define a new function typedef for I/O completion at the file/iovec level --

typedef void (file_endio_t)(void *endio_data, ssize_t count, int err);

and convert aio_complete and all its callers to this new prototype.

---

 drivers/usb/gadget/inode.c |   24 +++++++-----------
 fs/aio.c                   |   59 ++++++++++++++++++++++++---------------------
 fs/block_dev.c             |    8 +-----
 fs/direct-io.c             |   18 +++++--------
 fs/nfs/direct.c            |    9 ++----
 include/linux/aio.h        |   11 +++-----
 include/linux/fs.h         |    2 +
 7 files changed, 61 insertions(+), 70 deletions(-)

---

diff -urpN -X dontdiff a/drivers/usb/gadget/inode.c b/drivers/usb/gadget/inode.c
--- a/drivers/usb/gadget/inode.c	2007-01-12 14:42:29.000000000 -0800
+++ b/drivers/usb/gadget/inode.c	2007-01-12 14:25:34.000000000 -0800
@@ -559,35 +559,32 @@ static int ep_aio_cancel(struct kiocb *i
 	return value;
 }
 
-static ssize_t ep_aio_read_retry(struct kiocb *iocb)
+static int ep_aio_read_retry(struct kiocb *iocb)
 {
 	struct kiocb_priv	*priv = iocb->private;
-	ssize_t			len, total;
-	int			i;
+	ssize_t			total;
+	int			i, err = 0;
 
   	/* we "retry" to get the right mm context for this: */
 
  	/* copy stuff into user buffers */
  	total = priv->actual;
- 	len = 0;
  	for (i=0; i < priv->nr_segs; i++) {
  		ssize_t this = min((ssize_t)(priv->iv[i].iov_len), total);
 
  		if (copy_to_user(priv->iv[i].iov_base, priv->buf, this)) {
- 			if (len == 0)
- 				len = -EFAULT;
+ 			err = -EFAULT;
  			break;
  		}
 
  		total -= this;
- 		len += this;
  		if (total == 0)
  			break;
  	}
   	kfree(priv->buf);
   	kfree(priv);
   	aio_put_req(iocb);
- 	return len;
+ 	return err;
 }
 
 static void ep_aio_complete(struct usb_ep *ep, struct usb_request *req)
@@ -610,9 +607,7 @@ static void ep_aio_complete(struct usb_e
 		if (unlikely(kiocbIsCancelled(iocb)))
 			aio_put_req(iocb);
 		else
-			aio_complete(iocb,
-				req->actual ? req->actual : req->status,
-				req->status);
+			aio_complete(iocb, req->actual, req->status);
 	} else {
 		/* retry() won't report both; so we hide some faults */
 		if (unlikely(0 != req->status))
@@ -702,16 +697,17 @@ ep_aio_read(struct kiocb *iocb, const st
 {
 	struct ep_data		*epdata = iocb->ki_filp->private_data;
 	char			*buf;
+	size_t			len = iov_length(iov, nr_segs);
 
 	if (unlikely(epdata->desc.bEndpointAddress & USB_DIR_IN))
 		return -EINVAL;
 
-	buf = kmalloc(iocb->ki_left, GFP_KERNEL);
+	buf = kmalloc(len, GFP_KERNEL);
 	if (unlikely(!buf))
 		return -ENOMEM;
 
 	iocb->ki_retry = ep_aio_read_retry;
-	return ep_aio_rwtail(iocb, buf, iocb->ki_left, epdata, iov, nr_segs);
+	return ep_aio_rwtail(iocb, buf, len, epdata, iov, nr_segs);
 }
 
 static ssize_t
@@ -726,7 +722,7 @@ ep_aio_write(struct kiocb *iocb, const s
 	if (unlikely(!(epdata->desc.bEndpointAddress & USB_DIR_IN)))
 		return -EINVAL;
 
-	buf = kmalloc(iocb->ki_left, GFP_KERNEL);
+	buf = kmalloc(iov_length(iov, nr_segs), GFP_KERNEL);
 	if (unlikely(!buf))
 		return -ENOMEM;
 
diff -urpN -X dontdiff a/fs/aio.c b/fs/aio.c
--- a/fs/aio.c	2007-01-12 14:42:29.000000000 -0800
+++ b/fs/aio.c	2007-01-12 14:29:20.000000000 -0800
@@ -658,16 +658,16 @@ static inline int __queue_kicked_iocb(st
  * simplifies the coding of individual aio operations as
  * it avoids various potential races.
  */
-static ssize_t aio_run_iocb(struct kiocb *iocb)
+static void aio_run_iocb(struct kiocb *iocb)
 {
 	struct kioctx	*ctx = iocb->ki_ctx;
-	ssize_t (*retry)(struct kiocb *);
+	int (*retry)(struct kiocb *);
 	wait_queue_t *io_wait = current->io_wait;
-	ssize_t ret;
+	int err;
 
 	if (!(retry = iocb->ki_retry)) {
 		printk("aio_run_iocb: iocb->ki_retry = NULL\n");
-		return 0;
+		return;
 	}
 
 	/*
@@ -702,8 +702,8 @@ static ssize_t aio_run_iocb(struct kiocb
 
 	/* Quit retrying if the i/o has been cancelled */
 	if (kiocbIsCancelled(iocb)) {
-		ret = -EINTR;
-		aio_complete(iocb, ret, 0);
+		err = -EINTR;
+		aio_complete(iocb, iocb->ki_nbytes - iocb->ki_left, err);
 		/* must not access the iocb after this */
 		goto out;
 	}
@@ -720,17 +720,17 @@ static ssize_t aio_run_iocb(struct kiocb
 	 */
 	BUG_ON(!is_sync_wait(current->io_wait));
 	current->io_wait = &iocb->ki_wait.wait;
-	ret = retry(iocb);
+	err = retry(iocb);
 	current->io_wait = io_wait;
 
-	if (ret != -EIOCBRETRY && ret != -EIOCBQUEUED) {
+	if (err != -EIOCBRETRY && err != -EIOCBQUEUED) {
 		BUG_ON(!list_empty(&iocb->ki_wait.wait.task_list));
-		aio_complete(iocb, ret, 0);
+		aio_complete(iocb, iocb->ki_nbytes - iocb->ki_left, err);
 	}
 out:
 	spin_lock_irq(&ctx->ctx_lock);
 
-	if (-EIOCBRETRY == ret) {
+	if (-EIOCBRETRY == err) {
 		/*
 		 * OK, now that we are done with this iteration
 		 * and know that there is more left to go,
@@ -754,7 +754,6 @@ out:
 			aio_queue_work(ctx);
 		}
 	}
-	return ret;
 }
 
 /*
@@ -918,19 +917,25 @@ EXPORT_SYMBOL(kick_iocb);
 
 /* aio_complete
  *	Called when the io request on the given iocb is complete.
- *	Returns true if this is the last user of the request.  The 
+ *	Frees ioctx if this is the last user of the request.  The 
  *	only other user of the request can be the cancellation code.
  */
-int fastcall aio_complete(struct kiocb *iocb, long res, long res2)
+void fastcall aio_complete(void *endio_data, ssize_t count, int err)
 {
+	struct kiocb *iocb = endio_data;
 	struct kioctx	*ctx = iocb->ki_ctx;
 	struct aio_ring_info	*info;
 	struct aio_ring	*ring;
 	struct io_event	*event;
 	unsigned long	flags;
 	unsigned long	tail;
+	long		result;
 	int		ret;
 
+	result = (long) err;
+	if (!result)
+		result = (long) count;
+
 	/*
 	 * Special case handling for sync iocbs:
 	 *  - events go directly into the iocb for fast handling
@@ -940,10 +945,10 @@ int fastcall aio_complete(struct kiocb *
 	 */
 	if (is_sync_kiocb(iocb)) {
 		BUG_ON(iocb->ki_users != 1);
-		iocb->ki_user_data = res;
+		iocb->ki_user_data = result;
 		iocb->ki_users = 0;
 		wake_up_process(iocb->ki_obj.tsk);
-		return 1;
+		return;
 	}
 
 	info = &ctx->ring_info;
@@ -975,12 +980,12 @@ int fastcall aio_complete(struct kiocb *
 
 	event->obj = (u64)(unsigned long)iocb->ki_obj.user;
 	event->data = iocb->ki_user_data;
-	event->res = res;
-	event->res2 = res2;
+	event->res = result;
+	event->res2 = err;
 
 	dprintk("aio_complete: %p[%lu]: %p: %p %Lx %lx %lx\n",
 		ctx, tail, iocb, iocb->ki_obj.user, iocb->ki_user_data,
-		res, res2);
+		result, err);
 
 	/* after flagging the request as done, we
 	 * must never even look at it again
@@ -1002,7 +1007,7 @@ put_rq:
 		wake_up(&ctx->wait);
 
 	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
-	return ret;
+	return;
 }
 
 /* aio_read_evt
@@ -1307,7 +1312,7 @@ static void aio_advance_iovec(struct kio
 	BUG_ON(ret > 0 && iocb->ki_left == 0);
 }
 
-static ssize_t aio_rw_vect_retry(struct kiocb *iocb)
+static int aio_rw_vect_retry(struct kiocb *iocb)
 {
 	struct file *file = iocb->ki_filp;
 	struct address_space *mapping = file->f_mapping;
@@ -1341,26 +1346,26 @@ static ssize_t aio_rw_vect_retry(struct 
 
 	/* This means we must have transferred all that we could */
 	/* No need to retry anymore */
-	if ((ret == 0) || (iocb->ki_left == 0))
-		ret = iocb->ki_nbytes - iocb->ki_left;
+	if (iocb->ki_left == 0)
+		ret = 0;
 
-	return ret;
+	return (int) ret;
 }
 
-static ssize_t aio_fdsync(struct kiocb *iocb)
+static int aio_fdsync(struct kiocb *iocb)
 {
 	struct file *file = iocb->ki_filp;
-	ssize_t ret = -EINVAL;
+	int ret = -EINVAL;
 
 	if (file->f_op->aio_fsync)
 		ret = file->f_op->aio_fsync(iocb, 1);
 	return ret;
 }
 
-static ssize_t aio_fsync(struct kiocb *iocb)
+static int aio_fsync(struct kiocb *iocb)
 {
 	struct file *file = iocb->ki_filp;
-	ssize_t ret = -EINVAL;
+	int ret = -EINVAL;
 
 	if (file->f_op->aio_fsync)
 		ret = file->f_op->aio_fsync(iocb, 0);
diff -urpN -X dontdiff a/fs/block_dev.c b/fs/block_dev.c
--- a/fs/block_dev.c	2007-01-12 11:19:45.000000000 -0800
+++ b/fs/block_dev.c	2007-01-12 14:42:05.000000000 -0800
@@ -147,12 +147,8 @@ static int blk_end_aio(struct bio *bio, 
 	if (error)
 		iocb->ki_nbytes = -EIO;
 
-	if (atomic_dec_and_test(bio_count)) {
-		if ((long)iocb->ki_nbytes < 0)
-			aio_complete(iocb, iocb->ki_nbytes, 0);
-		else
-			aio_complete(iocb, iocb->ki_left, 0);
-	}
+	if (atomic_dec_and_test(bio_count))
+		aio_complete(iocb, iocb->ki_left, iocb->ki_nbytes);
 
 	return 0;
 }
diff -urpN -X dontdiff a/fs/direct-io.c b/fs/direct-io.c
--- a/fs/direct-io.c	2007-01-12 14:42:29.000000000 -0800
+++ b/fs/direct-io.c	2007-01-12 14:25:34.000000000 -0800
@@ -224,8 +224,6 @@ static struct page *dio_get_page(struct 
  */
 static int dio_complete(struct dio *dio, loff_t offset, int ret)
 {
-	ssize_t transferred = 0;
-
 	/*
 	 * AIO submission can race with bio completion to get here while
 	 * expecting to have the last io completed by bio completion.
@@ -236,15 +234,13 @@ static int dio_complete(struct dio *dio,
 		ret = 0;
 
 	if (dio->result) {
-		transferred = dio->result;
-
 		/* Check for short read case */
-		if ((dio->rw == READ) && ((offset + transferred) > dio->i_size))
-			transferred = dio->i_size - offset;
+		if ((dio->rw == READ) && ((offset + dio->result) > dio->i_size))
+			dio->result = dio->i_size - offset;
 	}
 
 	if (dio->end_io && dio->result)
-		dio->end_io(dio->iocb, offset, transferred,
+		dio->end_io(dio->iocb, offset, dio->result,
 			    dio->map_bh.b_private);
 	if (dio->lock_type == DIO_LOCKING)
 		/* lockdep: non-owner release */
@@ -254,8 +250,6 @@ static int dio_complete(struct dio *dio,
 		ret = dio->page_errors;
 	if (ret == 0)
 		ret = dio->io_error;
-	if (ret == 0)
-		ret = transferred;
 
 	return ret;
 }
@@ -283,8 +277,8 @@ static int dio_bio_end_aio(struct bio *b
 	spin_unlock_irqrestore(&dio->bio_lock, flags);
 
 	if (remaining == 0) {
-		int ret = dio_complete(dio, dio->iocb->ki_pos, 0);
-		aio_complete(dio->iocb, ret, 0);
+		int err = dio_complete(dio, dio->iocb->ki_pos, 0);
+		aio_complete(dio->iocb, dio->result, err);
 		kfree(dio);
 	}
 
@@ -1110,6 +1104,8 @@ direct_io_worker(int rw, struct kiocb *i
 	BUG_ON(!dio->is_async && ret2 != 0);
 	if (ret2 == 0) {
 		ret = dio_complete(dio, offset, ret);
+		if (ret == 0)
+			ret = dio->result;	/* bytes transferred */
 		kfree(dio);
 	} else
 		BUG_ON(ret != -EIOCBQUEUED);
diff -urpN -X dontdiff a/fs/nfs/direct.c b/fs/nfs/direct.c
--- a/fs/nfs/direct.c	2007-01-12 11:18:52.000000000 -0800
+++ b/fs/nfs/direct.c	2007-01-12 14:39:48.000000000 -0800
@@ -200,12 +200,9 @@ out:
  */
 static void nfs_direct_complete(struct nfs_direct_req *dreq)
 {
-	if (dreq->iocb) {
-		long res = (long) dreq->error;
-		if (!res)
-			res = (long) dreq->count;
-		aio_complete(dreq->iocb, res, 0);
-	}
+	if (dreq->iocb)
+		aio_complete(dreq->iocb, dreq->count, dreq->error);
+
 	complete_all(&dreq->completion);
 
 	kref_put(&dreq->kref, nfs_direct_req_release);
diff -urpN -X dontdiff a/include/linux/aio.h b/include/linux/aio.h
--- a/include/linux/aio.h	2007-01-12 14:42:29.000000000 -0800
+++ b/include/linux/aio.h	2007-01-12 14:25:34.000000000 -0800
@@ -15,10 +15,9 @@
 struct kioctx;
 
 /* Notes on cancelling a kiocb:
- *	If a kiocb is cancelled, aio_complete may return 0 to indicate 
- *	that cancel has not yet disposed of the kiocb.  All cancel 
- *	operations *must* call aio_put_req to dispose of the kiocb 
- *	to guard against races with the completion code.
+ *	If a kiocb is cancelled, aio_complete may not yet have disposed of
+ *	the kiocb.  All cancel operations *must* call aio_put_req to dispose
+ *	of the kiocb to guard against races with the completion code.
  */
 #define KIOCB_C_CANCELLED	0x01
 #define KIOCB_C_COMPLETE	0x02
@@ -98,7 +97,7 @@ struct kiocb {
 	struct file		*ki_filp;
 	struct kioctx		*ki_ctx;	/* may be NULL for sync ops */
 	int			(*ki_cancel)(struct kiocb *, struct io_event *);
-	ssize_t			(*ki_retry)(struct kiocb *);
+	int			(*ki_retry)(struct kiocb *);
 	void			(*ki_dtor)(struct kiocb *);
 
 	union {
@@ -208,7 +207,7 @@ extern unsigned aio_max_size;
 extern ssize_t FASTCALL(wait_on_sync_kiocb(struct kiocb *iocb));
 extern int FASTCALL(aio_put_req(struct kiocb *iocb));
 extern void FASTCALL(kick_iocb(struct kiocb *iocb));
-extern int FASTCALL(aio_complete(struct kiocb *iocb, long res, long res2));
+extern void FASTCALL(aio_complete(void *endio_data, ssize_t count, int err));
 extern void FASTCALL(__put_ioctx(struct kioctx *ctx));
 struct mm_struct;
 extern void FASTCALL(exit_aio(struct mm_struct *mm));
diff -urpN -X dontdiff a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h	2007-01-12 14:42:29.000000000 -0800
+++ b/include/linux/fs.h	2007-01-12 14:25:34.000000000 -0800
@@ -1109,6 +1109,8 @@ typedef int (*read_actor_t)(read_descrip
 #define HAVE_COMPAT_IOCTL 1
 #define HAVE_UNLOCKED_IOCTL 1
 
+typedef void (file_endio_t)(void *endio_data, ssize_t count, int err);
+
 /*
  * NOTE:
  * read, write, poll, fsync, readv, writev, unlocked_ioctl and compat_ioctl
