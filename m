Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263323AbTCNNHg>; Fri, 14 Mar 2003 08:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263324AbTCNNHg>; Fri, 14 Mar 2003 08:07:36 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:46823 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S263323AbTCNNHW>; Fri, 14 Mar 2003 08:07:22 -0500
Date: Fri, 14 Mar 2003 18:53:10 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: bcrl@redhat.com, akpm@digeo.com
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
Subject: Re: [Patch 1/2] Retry based aio read - core aio changes
Message-ID: <20030314185310.A3119@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20030305144754.A1600@in.ibm.com> <20030305145633.A1627@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030305145633.A1627@in.ibm.com>; from suparna@in.ibm.com on Wed, Mar 05, 2003 at 02:56:33PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 05, 2003 at 02:56:33PM +0530, Suparna Bhattacharya wrote:
> On Wed, Mar 05, 2003 at 02:47:54PM +0530, Suparna Bhattacharya wrote:
> > For the last few days I've been playing with prototyping 
> > a particular flavour of a retry based implementation for 
> > filesystem aio read.
> 
>  
> # aioretry.patch : Core aio infrastructure modifications
> 		   for high-level retry based aio

Ben pointed out that at least, we shouldn't be duplicating 
the switch on every retry. So here's another take which 
cleans things up a bit as well. 

It is still very high-level (would like to experiment with 
it a little further to find out how it behaves/performs in 
practice).

(I've checked that that patch applies to 2.5.64-bk8)

Earlier today I posted separate patches for the 
fixes listed below, so they are no longer part of this 
patch.

Comments/feedback welcome.

> 
> Includes couple of fixes in the aio code
> -The kiocbClearXXX were doing a set_bit instead of 
>  clear_bit
> -Sync iocbs were not woken up when iocb->ki_users = 1
>  (dio takes a different path for sync and async iocbs,
>  so maybe that's why we weren't seeing the problem yet)
> 

Regards
Suparna


diff -ur linux-2.5.62/fs/aio.c linux-2.5.62-aio/fs/aio.c
--- linux-2.5.62/fs/aio.c	Tue Feb 18 04:26:14 2003
+++ linux-2.5.62-aio/fs/aio.c	Tue Mar 11 21:07:35 2003
@@ -395,6 +396,7 @@
 	req->ki_cancel = NULL;
 	req->ki_retry = NULL;
 	req->ki_user_obj = NULL;
+	INIT_LIST_HEAD(&req->ki_run_list);
 
 	/* Check if the completion queue has enough free space to
 	 * accept an event from this io.
@@ -558,46 +560,121 @@
 	enter_lazy_tlb(mm, current, smp_processor_id());
 }
 
-/* Run on kevent's context.  FIXME: needs to be per-cpu and warn if an
- * operation blocks.
- */
-static void aio_kick_handler(void *data)
+static inline int __queue_kicked_iocb(struct kiocb *iocb)
 {
-	struct kioctx *ctx = data;
+	struct kioctx	*ctx = iocb->ki_ctx;
 
-	use_mm(ctx->mm);
+	if (list_empty(&iocb->ki_run_list)) {
+		list_add_tail(&iocb->ki_run_list, 
+			&ctx->run_list);
+		return 1;
+	}
+	return 0;
+}
 
-	spin_lock_irq(&ctx->ctx_lock);
-	while (!list_empty(&ctx->run_list)) {
-		struct kiocb *iocb;
-		long ret;
+/* Expects to be called with iocb->ki_ctx->lock held */
+static ssize_t aio_run_iocb(struct kiocb *iocb)
+{
+	struct kioctx	*ctx = iocb->ki_ctx;
+	ssize_t (*retry)(struct kiocb *);
+	ssize_t ret;
 
-		iocb = list_entry(ctx->run_list.next, struct kiocb,
-				  ki_run_list);
-		list_del(&iocb->ki_run_list);
-		iocb->ki_users ++;
-		spin_unlock_irq(&ctx->ctx_lock);
+	if (iocb->ki_retried++ > 1024*1024) {
+		printk("Maximal retry count. Bytes done %d\n",
+			iocb->ki_nbytes - iocb->ki_left);
+		return -EAGAIN;
+	}
+
+	if (!(iocb->ki_retried & 0xff)) {
+		printk("%ld aio retries completed %d bytes of %d\n",
+			iocb->ki_retried, 
+			iocb->ki_nbytes - iocb->ki_left, iocb->ki_nbytes);
+	}
+
+	if (!(retry = iocb->ki_retry))
+		return 0;
+
+	iocb->ki_users ++;
+	kiocbClearKicked(iocb);
+	iocb->ki_retry = NULL;	
+	spin_unlock_irq(&ctx->ctx_lock);
+	
+	BUG_ON(current->iocb != NULL);
+	
+	current->iocb = iocb;
+	ret = retry(iocb);
+	current->iocb = NULL;
 
-		kiocbClearKicked(iocb);
-		ret = iocb->ki_retry(iocb);
-		if (-EIOCBQUEUED != ret) {
+	if (-EIOCBQUEUED != ret) {
+		if (list_empty(&iocb->ki_wait.task_list)) 
 			aio_complete(iocb, ret, 0);
-			iocb = NULL;
-		}
+		else
+			printk("can't delete iocb in use\n");
+	} else {
+		if (list_empty(&iocb->ki_wait.task_list)) 
+			kiocbSetKicked(iocb);
+	}
+	spin_lock_irq(&ctx->ctx_lock);
 
-		spin_lock_irq(&ctx->ctx_lock);
-		if (NULL != iocb)
-			__aio_put_req(ctx, iocb);
+	iocb->ki_retry = retry;
+	INIT_LIST_HEAD(&iocb->ki_run_list);
+	if (kiocbIsKicked(iocb)) {
+		BUG_ON(ret != -EIOCBQUEUED);
+		__queue_kicked_iocb(iocb);
+	} 
+	__aio_put_req(ctx, iocb);
+	return ret;
+}
+
+static void aio_run_iocbs(struct kioctx *ctx)
+{
+	struct kiocb *iocb;
+	ssize_t ret;
+
+	spin_lock_irq(&ctx->ctx_lock);
+	while (!list_empty(&ctx->run_list)) {
+		iocb = list_entry(ctx->run_list.next, struct kiocb,
+			ki_run_list);
+		list_del(&iocb->ki_run_list);
+		ret = aio_run_iocb(iocb);
 	}
 	spin_unlock_irq(&ctx->ctx_lock);
+}
+
+/* Run on aiod/kevent's context.  FIXME: needs to be per-cpu and warn if an
+ * operation blocks.
+ */
+static void aio_kick_handler(void *data)
+{
+	struct kioctx *ctx = data;
 
+	use_mm(ctx->mm);
+	aio_run_iocbs(ctx);
 	unuse_mm(ctx->mm);
 }
 
-void kick_iocb(struct kiocb *iocb)
+
+void queue_kicked_iocb(struct kiocb *iocb)
 {
 	struct kioctx	*ctx = iocb->ki_ctx;
+	unsigned long flags;
+	int run = 0;
+
+	WARN_ON((!list_empty(&iocb->ki_wait.task_list)));
+
+	spin_lock_irqsave(&ctx->ctx_lock, flags);
+	run = __queue_kicked_iocb(iocb);
+	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
+	if (run) {
+		if (waitqueue_active(&ctx->wait))
+			wake_up(&ctx->wait);
+		else
+			queue_work(aio_wq, &ctx->wq);
+	}
+}
 
+void kick_iocb(struct kiocb *iocb)
+{
 	/* sync iocbs are easy: they can only ever be executing from a 
 	 * single context. */
 	if (is_sync_kiocb(iocb)) {
@@ -607,11 +684,9 @@
 	}
 
 	if (!kiocbTryKick(iocb)) {
-		unsigned long flags;
-		spin_lock_irqsave(&ctx->ctx_lock, flags);
-		list_add_tail(&iocb->ki_run_list, &ctx->run_list);
-		spin_unlock_irqrestore(&ctx->ctx_lock, flags);
-		schedule_work(&ctx->wq);
+		queue_kicked_iocb(iocb);
+	} else {
+		pr_debug("iocb already kicked or in progress\n");
 	}
 }
 
@@ -664,6 +739,9 @@
 	 */
 	spin_lock_irqsave(&ctx->ctx_lock, flags);
 
+	if (!list_empty(&iocb->ki_run_list))
+		list_del_init(&iocb->ki_run_list);
+
 	ring = kmap_atomic(info->ring_pages[0], KM_IRQ1);
 
 	tail = info->tail;
@@ -865,6 +943,8 @@
 			ret = 0;
 			if (to.timed_out)	/* Only check after read evt */
 				break;
+			/* accelerate kicked iocbs for this ctx */	
+			aio_run_iocbs(ctx);
 			schedule();
 			if (signal_pending(tsk)) {
 				ret = -EINTR;
@@ -984,6 +1064,149 @@
 	return -EINVAL;
 }
 
+ssize_t aio_pread(struct kiocb *iocb)
+{
+	struct file *file = iocb->ki_filp;
+	ssize_t ret = 0;
+
+	ret = file->f_op->aio_read(iocb, iocb->ki_buf,
+		iocb->ki_left, iocb->ki_pos);
+
+	pr_debug("aio_pread: fop ret %d\n", ret);
+
+	/*
+	 * Can't just depend on iocb->ki_left to determine 
+	 * whether we are done. This may have been a short read.
+	 */
+	if (ret > 0) {
+		iocb->ki_buf += ret;
+		iocb->ki_left -= ret;
+
+		ret = -EIOCBQUEUED;
+	}
+
+	/* This means we must have transferred all that we could */
+	/* No need to retry anymore */
+	if (ret == 0) 
+		ret = iocb->ki_nbytes - iocb->ki_left;
+
+	return ret;
+}
+
+ssize_t aio_pwrite(struct kiocb *iocb)
+{
+	struct file *file = iocb->ki_filp;
+	ssize_t ret = 0;
+
+	ret = file->f_op->aio_write(iocb, iocb->ki_buf,
+		iocb->ki_left, iocb->ki_pos);
+
+	pr_debug("aio_pread: fop ret %d\n", ret);
+
+	/* 
+	 * TBD: Even if iocb->ki_left = 0, could we need to 
+	 * wait for data to be sync'd ? Or can we assume
+	 * that aio_fdsync/aio_fsync would be called explicitly
+	 * as required.
+	 */
+	if (ret > 0) {
+		iocb->ki_buf += ret;
+		iocb->ki_left -= ret;
+
+		ret = -EIOCBQUEUED;
+	}
+
+	/* This means we must have transferred all that we could */
+	/* No need to retry anymore */
+	if (ret == 0) 
+		ret = iocb->ki_nbytes - iocb->ki_left;
+
+	return ret;
+}
+
+ssize_t aio_fdsync(struct kiocb *iocb)
+{
+	struct file *file = iocb->ki_filp;
+	ssize_t ret = -EINVAL;
+
+	if (file->f_op->aio_fsync)
+		ret = file->f_op->aio_fsync(iocb, 1);
+	return ret;
+}
+	
+ssize_t aio_fsync(struct kiocb *iocb)
+{
+	struct file *file = iocb->ki_filp;
+	ssize_t ret = -EINVAL;
+
+	if (file->f_op->aio_fsync)
+		ret = file->f_op->aio_fsync(iocb, 0);
+	return ret;
+}
+	
+/* Called during initial submission and subsequent retry operations */
+ssize_t aio_setup_iocb(struct kiocb *iocb)
+{
+	struct file *file = iocb->ki_filp;
+	ssize_t ret = 0;
+	
+	switch (iocb->ki_opcode) {
+	case IOCB_CMD_PREAD:
+		ret = -EBADF;
+		if (unlikely(!(file->f_mode & FMODE_READ)))
+			break;
+		ret = -EFAULT;
+		if (unlikely(!access_ok(VERIFY_WRITE, iocb->ki_buf, 
+			iocb->ki_left)))
+			break;
+		ret = -EINVAL;
+		if (file->f_op->aio_read)
+			iocb->ki_retry = aio_pread;
+		break;
+	case IOCB_CMD_PWRITE:
+		ret = -EBADF;
+		if (unlikely(!(file->f_mode & FMODE_WRITE)))
+			break;
+		ret = -EFAULT;
+		if (unlikely(!access_ok(VERIFY_READ, iocb->ki_buf, 
+			iocb->ki_left)))
+			break;
+		ret = -EINVAL;
+		if (file->f_op->aio_write)
+			iocb->ki_retry = aio_pwrite;
+		break;
+	case IOCB_CMD_FDSYNC:
+		ret = -EINVAL;
+		if (file->f_op->aio_fsync)
+			iocb->ki_retry = aio_fdsync;
+		break;
+	case IOCB_CMD_FSYNC:
+		ret = -EINVAL;
+		if (file->f_op->aio_fsync)
+			iocb->ki_retry = aio_fsync;
+		break;
+	default:
+		dprintk("EINVAL: io_submit: no operation provided\n");
+		ret = -EINVAL;
+	}
+
+	if (!iocb->ki_retry)
+		return ret;
+
+	pr_debug("ki_pos = %llu\n", iocb->ki_pos);
+
+	return 0;
+}
+
+int aio_wake_function(wait_queue_t *wait, unsigned mode, int sync)
+{
+	struct kiocb *iocb = container_of(wait, struct kiocb, ki_wait);
+
+	list_del_init(&wait->task_list);
+	kick_iocb(iocb);
+	return 1;
+}
+
 static int FASTCALL(io_submit_one(struct kioctx *ctx, struct iocb *user_iocb,
 				  struct iocb *iocb));
 static int io_submit_one(struct kioctx *ctx, struct iocb *user_iocb,
@@ -992,7 +1215,6 @@
 	struct kiocb *req;
 	struct file *file;
 	ssize_t ret;
-	char *buf;
 
 	/* enforce forwards compatibility on users */
 	if (unlikely(iocb->aio_reserved1 || iocb->aio_reserved2 ||
@@ -1033,51 +1255,27 @@
 	req->ki_user_data = iocb->aio_data;
 	req->ki_pos = iocb->aio_offset;
 
-	buf = (char *)(unsigned long)iocb->aio_buf;
+	req->ki_buf = (char *)(unsigned long)iocb->aio_buf;
+	req->ki_left = req->ki_nbytes = iocb->aio_nbytes;
+	req->ki_opcode = iocb->aio_lio_opcode;
+	init_waitqueue_func_entry(&req->ki_wait, aio_wake_function);
+	INIT_LIST_HEAD(&req->ki_wait.task_list);
+	req->ki_run_list.next = req->ki_run_list.prev = NULL;
+	req->ki_retry = NULL;
+	req->ki_retried = 0;
 
-	switch (iocb->aio_lio_opcode) {
-	case IOCB_CMD_PREAD:
-		ret = -EBADF;
-		if (unlikely(!(file->f_mode & FMODE_READ)))
-			goto out_put_req;
-		ret = -EFAULT;
-		if (unlikely(!access_ok(VERIFY_WRITE, buf, iocb->aio_nbytes)))
-			goto out_put_req;
-		ret = -EINVAL;
-		if (file->f_op->aio_read)
-			ret = file->f_op->aio_read(req, buf,
-					iocb->aio_nbytes, req->ki_pos);
-		break;
-	case IOCB_CMD_PWRITE:
-		ret = -EBADF;
-		if (unlikely(!(file->f_mode & FMODE_WRITE)))
-			goto out_put_req;
-		ret = -EFAULT;
-		if (unlikely(!access_ok(VERIFY_READ, buf, iocb->aio_nbytes)))
-			goto out_put_req;
-		ret = -EINVAL;
-		if (file->f_op->aio_write)
-			ret = file->f_op->aio_write(req, buf,
-					iocb->aio_nbytes, req->ki_pos);
-		break;
-	case IOCB_CMD_FDSYNC:
-		ret = -EINVAL;
-		if (file->f_op->aio_fsync)
-			ret = file->f_op->aio_fsync(req, 1);
-		break;
-	case IOCB_CMD_FSYNC:
-		ret = -EINVAL;
-		if (file->f_op->aio_fsync)
-			ret = file->f_op->aio_fsync(req, 0);
-		break;
-	default:
-		dprintk("EINVAL: io_submit: no operation provided\n");
-		ret = -EINVAL;
-	}
+	ret = aio_setup_iocb(req);
+
+	if ((-EBADF == ret) || (-EFAULT == ret))
+		goto out_put_req;
+
+	spin_lock_irq(&ctx->ctx_lock);
+	ret = aio_run_iocb(req);
+	spin_unlock_irq(&ctx->ctx_lock);
+
+	if (-EIOCBQUEUED == ret)
+		queue_work(aio_wq, &ctx->wq);
 
-	if (likely(-EIOCBQUEUED == ret))
-		return 0;
-	aio_complete(req, ret, 0);
 	return 0;
 
 out_put_req:
diff -ur linux-2.5.62/include/linux/aio.h linux-2.5.62-aio/include/linux/aio.h
--- linux-2.5.62/include/linux/aio.h	Tue Feb 18 04:25:50 2003
+++ linux-2.5.62-aio/include/linux/aio.h	Tue Mar 11 21:31:22 2003
@@ -54,7 +54,7 @@
 	struct file		*ki_filp;
 	struct kioctx		*ki_ctx;	/* may be NULL for sync ops */
 	int			(*ki_cancel)(struct kiocb *, struct io_event *);
-	long			(*ki_retry)(struct kiocb *);
+	ssize_t			(*ki_retry)(struct kiocb *);
 
 	struct list_head	ki_list;	/* the aio core uses this
 						 * for cancellation */
@@ -62,6 +62,14 @@
 	void			*ki_user_obj;	/* pointer to userland's iocb */
 	__u64			ki_user_data;	/* user's data for completion */
 	loff_t			ki_pos;
+	
+	/* State that we remember to be able to restart/retry  */
+	unsigned short		ki_opcode;
+	size_t			ki_nbytes; 	/* copy of iocb->aio_nbytes */
+	char 			*ki_buf;	/* remaining iocb->aio_buf */
+	size_t			ki_left; 	/* remaining bytes */
+	wait_queue_t		ki_wait;
+	long			ki_retried; 	/* just for testing */
 
 	char			private[KIOCB_PRIVATE_SIZE];
 };
@@ -77,6 +85,8 @@
 		(x)->ki_ctx = &tsk->active_mm->default_kioctx;	\
 		(x)->ki_cancel = NULL;			\
 		(x)->ki_user_obj = tsk;			\
+		(x)->ki_user_data = 0;			\
+		init_wait((&(x)->ki_wait));		\
 	} while (0)
 
 #define AIO_RING_MAGIC			0xa10a10a1
diff -ur linux-2.5.62/include/linux/init_task.h linux-2.5.62-aio/include/linux/init_task.h
--- linux-2.5.62/include/linux/init_task.h	Tue Feb 18 04:25:53 2003
+++ linux-2.5.62-aio/include/linux/init_task.h	Thu Feb 27 19:01:39 2003
@@ -101,6 +101,7 @@
 	.alloc_lock	= SPIN_LOCK_UNLOCKED,				\
 	.switch_lock	= SPIN_LOCK_UNLOCKED,				\
 	.journal_info	= NULL,						\
+	.iocb		= NULL,						\
 }
 
 
diff -ur linux-2.5.62/include/linux/sched.h linux-2.5.62-aio/include/linux/sched.h
--- linux-2.5.62/include/linux/sched.h	Tue Feb 18 04:25:53 2003
+++ linux-2.5.62-aio/include/linux/sched.h	Thu Feb 27 19:01:39 2003
@@ -418,6 +418,8 @@
 
 	unsigned long ptrace_message;
 	siginfo_t *last_siginfo; /* For ptrace use.  */
+/* current aio handle */
+	struct kiocb *iocb;
 };
 
 extern void __put_task_struct(struct task_struct *tsk);
diff -ur linux-2.5.62/kernel/fork.c linux-2.5.62-aio/kernel/fork.c
--- linux-2.5.62/kernel/fork.c	Tue Feb 18 04:25:53 2003
+++ linux-2.5.62-aio/kernel/fork.c	Tue Mar  4 14:58:44 2003
@@ -834,6 +838,7 @@
 	p->lock_depth = -1;		/* -1 = no lock */
 	p->start_time = get_jiffies_64();
 	p->security = NULL;
+	p->iocb = NULL;
 
 	retval = -ENOMEM;
 	if (security_task_alloc(p))
