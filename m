Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264448AbTDXEns (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 00:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264447AbTDXEnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 00:43:47 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:14529 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S264446AbTDXEnM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 00:43:12 -0400
Date: Thu, 24 Apr 2003 10:30:10 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: bcrl@redhat.com, akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, linux-aio@kvack.org,
       linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/7] Filesystem AIO rdwr - aio retry core changes
Message-ID: <20030424103010.A2288@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20030424102221.A2166@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030424102221.A2166@in.ibm.com>; from suparna@in.ibm.com on Thu, Apr 24, 2003 at 10:22:22AM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 24, 2003 at 10:22:22AM +0530, Suparna Bhattacharya wrote:
> Here is a revised version of the filesystem AIO patches
> for 2.5.68.
> 
> It is built on a variation of the simple retry based 
> scheme originally suggested by Ben LaHaise. 
> 
> 01aioretry.patch 	: Base aio retry infrastructure 
> 

 fs/aio.c                  |  371 ++++++++++++++++++++++++++++++++++++----------
 include/linux/aio.h       |   32 +++
 include/linux/errno.h     |    1 
 include/linux/init_task.h |    1 
 include/linux/sched.h     |    2 
 include/linux/wait.h      |    2 
 kernel/fork.c             |    9 -
 7 files changed, 337 insertions(+), 81 deletions(-)


diff -ur -X /home/kiran/dontdiff linux-2.5.68/fs/aio.c linux-aio-2568/fs/aio.c
--- linux-2.5.68/fs/aio.c	Fri Apr 11 21:10:48 2003
+++ linux-aio-2568/fs/aio.c	Wed Apr 23 17:15:30 2003
@@ -39,6 +39,9 @@
 #define dprintk(x...)	do { ; } while (0)
 #endif
 
+long aio_run = 0; /* for testing only */
+long aio_wakeups = 0; /* for testing only */
+
 /*------ sysctl variables----*/
 atomic_t aio_nr = ATOMIC_INIT(0);	/* current system wide number of aio requests */
 unsigned aio_max_nr = 0x10000;	/* system wide maximum number of aio requests */
@@ -281,6 +284,7 @@
 		struct kiocb *iocb = list_kiocb(pos);
 		list_del_init(&iocb->ki_list);
 		cancel = iocb->ki_cancel;
+		kiocbSetCancelled(iocb);
 		if (cancel) {
 			iocb->ki_users++;
 			spin_unlock_irq(&ctx->ctx_lock);
@@ -395,6 +400,7 @@
 	req->ki_cancel = NULL;
 	req->ki_retry = NULL;
 	req->ki_user_obj = NULL;
+	INIT_LIST_HEAD(&req->ki_run_list);
 
 	/* Check if the completion queue has enough free space to
 	 * accept an event from this io.
@@ -544,60 +550,147 @@
 	struct mm_struct *active_mm = current->active_mm;
 	atomic_inc(&mm->mm_count);
 	current->mm = mm;
-	if (mm != active_mm) {
-		current->active_mm = mm;
-		activate_mm(active_mm, mm);
-	}
+
+	current->active_mm = mm;
+	activate_mm(active_mm, mm);
+
 	mmdrop(active_mm);
 }
 
-static void unuse_mm(struct mm_struct *mm)
+void unuse_mm(struct mm_struct *mm)
 {
 	current->mm = NULL;
 	/* active_mm is still 'mm' */
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
+		iocb->ki_queued++;
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
 
-		kiocbClearKicked(iocb);
-		ret = iocb->ki_retry(iocb);
+	if (!(iocb->ki_retried & 0xff)) {
+		printk("%ld retry: %d of %d (kick %ld, Q %ld run %ld, wake %ld)\n",
+			iocb->ki_retried, 
+			iocb->ki_nbytes - iocb->ki_left, iocb->ki_nbytes,
+			iocb->ki_kicked, iocb->ki_queued, aio_run, aio_wakeups);
+	}
+
+	if (!(retry = iocb->ki_retry)) {
+		printk("aio_run_iocb: iocb->ki_retry = NULL\n");
+		return 0;
+	}
+
+	iocb->ki_users ++;
+	kiocbClearKicked(iocb);
+	iocb->ki_run_list.next = iocb->ki_run_list.prev = NULL;
+	iocb->ki_retry = NULL;	
+	spin_unlock_irq(&ctx->ctx_lock);
+	
+	if (kiocbIsCancelled(iocb)) {
+		aio_complete(iocb, -EINTR, 0);
+		spin_lock_irq(&ctx->ctx_lock);
+		__aio_put_req(ctx, iocb);
+		return -EINTR;
+	}
+
+	BUG_ON(current->io_wait != NULL);
+	current->io_wait = &iocb->ki_wait;
+	ret = retry(iocb);
+	current->io_wait = NULL;
+
+	if (-EIOCBRETRY != ret) {
 		if (-EIOCBQUEUED != ret) {
+			BUG_ON(!list_empty(&iocb->ki_wait.task_list)); 
 			aio_complete(iocb, ret, 0);
-			iocb = NULL;
 		}
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
+		BUG_ON(ret != -EIOCBRETRY);
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
+	int count = 0;
+
+	spin_lock_irq(&ctx->ctx_lock);
+	while (!list_empty(&ctx->run_list)) {
+		iocb = list_entry(ctx->run_list.next, struct kiocb,
+			ki_run_list);
+		list_del(&iocb->ki_run_list);
+		ret = aio_run_iocb(iocb);
+		count++;
 	}
 	spin_unlock_irq(&ctx->ctx_lock);
+	aio_run++;
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
 
+	spin_lock_irqsave(&ctx->ctx_lock, flags);
+	run = __queue_kicked_iocb(iocb);
+	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
+	if (run) {
+		queue_work(aio_wq, &ctx->wq);
+		aio_wakeups++;
+	}
+}
+
+void kick_iocb(struct kiocb *iocb)
+{
 	/* sync iocbs are easy: they can only ever be executing from a 
 	 * single context. */
 	if (is_sync_kiocb(iocb)) {
@@ -606,12 +699,9 @@
 		return;
 	}
 
+	iocb->ki_kicked++;
 	if (!kiocbTryKick(iocb)) {
-		unsigned long flags;
-		spin_lock_irqsave(&ctx->ctx_lock, flags);
-		list_add_tail(&iocb->ki_run_list, &ctx->run_list);
-		spin_unlock_irqrestore(&ctx->ctx_lock, flags);
-		schedule_work(&ctx->wq);
+		queue_kicked_iocb(iocb);
 	}
 }
 
@@ -664,6 +754,9 @@
 	 */
 	spin_lock_irqsave(&ctx->ctx_lock, flags);
 
+	if (iocb->ki_run_list.prev && !list_empty(&iocb->ki_run_list))
+		list_del_init(&iocb->ki_run_list);
+
 	ring = kmap_atomic(info->ring_pages[0], KM_IRQ1);
 
 	tail = info->tail;
@@ -693,6 +786,11 @@
 
 	pr_debug("added to ring %p at [%lu]\n", iocb, tail);
 
+	pr_debug("%ld retries: %d of %d (kicked %ld, Q %ld run %ld wake %ld)\n",
+		iocb->ki_retried, 
+		iocb->ki_nbytes - iocb->ki_left, iocb->ki_nbytes,
+		iocb->ki_kicked, iocb->ki_queued, aio_run, aio_wakeups);
+
 	/* everything turned out well, dispose of the aiocb. */
 	ret = __aio_put_req(ctx, iocb);
 
@@ -807,6 +905,7 @@
 	int			i = 0;
 	struct io_event		ent;
 	struct timeout		to;
+	int 			event_loop = 0; /* testing only */
 
 	/* needed to zero any padding within an entry (there shouldn't be 
 	 * any, but C is fun!
@@ -856,7 +955,6 @@
 		add_wait_queue_exclusive(&ctx->wait, &wait);
 		do {
 			set_task_state(tsk, TASK_INTERRUPTIBLE);
-
 			ret = aio_read_evt(ctx, &ent);
 			if (ret)
 				break;
@@ -866,6 +964,7 @@
 			if (to.timed_out)	/* Only check after read evt */
 				break;
 			schedule();
+			event_loop++;
 			if (signal_pending(tsk)) {
 				ret = -EINTR;
 				break;
@@ -893,6 +992,9 @@
 	if (timeout)
 		clear_timeout(&to);
 out:
+	pr_debug("event loop executed %d times\n", event_loop);
+	pr_debug("aio_run %ld\n", aio_run);
+	pr_debug("aio_wakeups %ld\n", aio_wakeups);
 	return i ? i : ret;
 }
 
@@ -984,6 +1086,143 @@
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
+	/*
+	 * Can't just depend on iocb->ki_left to determine 
+	 * whether we are done. This may have been a short read.
+	 */
+	if (ret > 0) {
+		iocb->ki_buf += ret;
+		iocb->ki_left -= ret;
+
+		ret = -EIOCBRETRY;
+	}
+
+	/* This means we must have transferred all that we could */
+	/* No need to retry anymore */
+	if ((ret == 0) || (iocb->ki_left == 0)) 
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
+		ret = -EIOCBRETRY;
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
 int FASTCALL(io_submit_one(struct kioctx *ctx, struct iocb *user_iocb,
 				  struct iocb *iocb));
 int io_submit_one(struct kioctx *ctx, struct iocb *user_iocb,
@@ -992,7 +1231,6 @@
 	struct kiocb *req;
 	struct file *file;
 	ssize_t ret;
-	char *buf;
 
 	/* enforce forwards compatibility on users */
 	if (unlikely(iocb->aio_reserved1 || iocb->aio_reserved2 ||
@@ -1033,51 +1271,31 @@
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
+	req->ki_kicked = 0;
+	req->ki_queued = 0;
+	aio_run = 0;
+	aio_wakeups = 0;
 
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
+	if (-EIOCBRETRY == ret)
+		queue_work(aio_wq, &ctx->wq);
 
-	if (likely(-EIOCBQUEUED == ret))
-		return 0;
-	aio_complete(req, ret, 0);
 	return 0;
 
 out_put_req:
diff -ur -X /home/kiran/dontdiff linux-2.5.68/include/linux/aio.h linux-aio-2568/include/linux/aio.h
--- linux-2.5.68/include/linux/aio.h	Fri Apr 11 21:10:50 2003
+++ linux-aio-2568/include/linux/aio.h	Thu Apr 17 18:03:53 2003
@@ -54,7 +54,7 @@
 	struct file		*ki_filp;
 	struct kioctx		*ki_ctx;	/* may be NULL for sync ops */
 	int			(*ki_cancel)(struct kiocb *, struct io_event *);
-	long			(*ki_retry)(struct kiocb *);
+	ssize_t			(*ki_retry)(struct kiocb *);
 
 	struct list_head	ki_list;	/* the aio core uses this
 						 * for cancellation */
@@ -62,6 +62,16 @@
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
+	long			ki_kicked; 	/* just for testing */
+	long			ki_queued; 	/* just for testing */
 
 	char			private[KIOCB_PRIVATE_SIZE];
 };
@@ -77,6 +87,8 @@
 		(x)->ki_ctx = &tsk->active_mm->default_kioctx;	\
 		(x)->ki_cancel = NULL;			\
 		(x)->ki_user_obj = tsk;			\
+		(x)->ki_user_data = 0;			\
+		init_wait((&(x)->ki_wait));		\
 	} while (0)
 
 #define AIO_RING_MAGIC			0xa10a10a1
@@ -156,6 +168,24 @@
 #define get_ioctx(kioctx)	do { if (unlikely(atomic_read(&(kioctx)->users) <= 0)) BUG(); atomic_inc(&(kioctx)->users); } while (0)
 #define put_ioctx(kioctx)	do { if (unlikely(atomic_dec_and_test(&(kioctx)->users))) __put_ioctx(kioctx); else if (unlikely(atomic_read(&(kioctx)->users) < 0)) BUG(); } while (0)
 
+#define in_aio() !is_sync_wait(current->io_wait)
+
+/* when sync behaviour is desired even if running in async context */
+#define do_sync_op(op)		if (in_aio()) { \
+	wait_queue_t *wait = current->io_wait; \
+	current->io_wait = NULL; \
+	op; \
+	current->io_wait = wait; \
+} else { \
+	op; \
+}	
+
+#define warn_if_async()	if (in_aio()) {\
+	printk(KERN_ERR "%s(%s:%d) called in async context!\n", \
+	__FUNCTION__, __FILE__, __LINE__); \
+	dump_stack(); \
+	}
+
 #include <linux/aio_abi.h>
 
 static inline struct kiocb *list_kiocb(struct list_head *h)
diff -ur -X /home/kiran/dontdiff linux-2.5.68/include/linux/errno.h linux-aio-2568/include/linux/errno.h
--- linux-2.5.68/include/linux/errno.h	Tue Mar 25 03:31:17 2003
+++ linux-aio-2568/include/linux/errno.h	Wed Apr 16 16:41:23 2003
@@ -22,6 +22,7 @@
 #define EBADTYPE	527	/* Type not supported by server */
 #define EJUKEBOX	528	/* Request initiated, but will not complete before timeout */
 #define EIOCBQUEUED	529	/* iocb queued, will get completion event */
+#define EIOCBRETRY	530	/* iocb queued, will trigger a retry */
 
 #endif
 
diff -ur -X /home/kiran/dontdiff linux-2.5.68/include/linux/init_task.h linux-aio-2568/include/linux/init_task.h
--- linux-2.5.68/include/linux/init_task.h	Mon Apr 21 23:30:39 2003
+++ linux-aio-2568/include/linux/init_task.h	Mon Apr 21 17:26:58 2003
@@ -103,6 +103,7 @@
 	.alloc_lock	= SPIN_LOCK_UNLOCKED,				\
 	.switch_lock	= SPIN_LOCK_UNLOCKED,				\
 	.journal_info	= NULL,						\
+	.io_wait	= NULL,						\
 }
 
 
diff -ur -X /home/kiran/dontdiff linux-2.5.68/include/linux/sched.h linux-aio-2568/include/linux/sched.h
--- linux-2.5.68/include/linux/sched.h	Mon Apr 21 23:30:40 2003
+++ linux-aio-2568/include/linux/sched.h	Mon Apr 21 17:26:58 2003
@@ -438,6 +438,8 @@
 
 	unsigned long ptrace_message;
 	siginfo_t *last_siginfo; /* For ptrace use.  */
+/* current io wait handle */
+	wait_queue_t *io_wait;
 };
 
 extern void __put_task_struct(struct task_struct *tsk);
diff -ur -X /home/kiran/dontdiff linux-2.5.68/include/linux/wait.h linux-aio-2568/include/linux/wait.h
--- linux-2.5.68/include/linux/wait.h	Tue Mar 25 03:30:44 2003
+++ linux-aio-2568/include/linux/wait.h	Tue Apr 22 00:07:42 2003
@@ -80,6 +80,8 @@
 	return !list_empty(&q->task_list);
 }
 
+#define is_sync_wait(wait)	(!(wait) || ((wait)->task))
+
 extern void FASTCALL(add_wait_queue(wait_queue_head_t *q, wait_queue_t * wait));
 extern void FASTCALL(add_wait_queue_exclusive(wait_queue_head_t *q, wait_queue_t * wait));
 extern void FASTCALL(remove_wait_queue(wait_queue_head_t *q, wait_queue_t * wait));
diff -ur -X /home/kiran/dontdiff linux-2.5.68/kernel/fork.c linux-aio-2568/kernel/fork.c
--- linux-2.5.68/kernel/fork.c	Mon Apr 21 23:30:40 2003
+++ linux-aio-2568/kernel/fork.c	Mon Apr 21 17:26:58 2003
@@ -139,8 +139,9 @@
 void prepare_to_wait(wait_queue_head_t *q, wait_queue_t *wait, int state)
 {
 	unsigned long flags;
-
-	__set_current_state(state);
+	
+	if (is_sync_wait(wait))
+		__set_current_state(state);
 	wait->flags &= ~WQ_FLAG_EXCLUSIVE;
 	spin_lock_irqsave(&q->lock, flags);
 	if (list_empty(&wait->task_list))
@@ -153,7 +154,8 @@
 {
 	unsigned long flags;
 
-	__set_current_state(state);
+	if (is_sync_wait(wait))
+		__set_current_state(state);
 	wait->flags |= WQ_FLAG_EXCLUSIVE;
 	spin_lock_irqsave(&q->lock, flags);
 	if (list_empty(&wait->task_list))
@@ -856,6 +858,7 @@
 	p->lock_depth = -1;		/* -1 = no lock */
 	p->start_time = get_jiffies_64();
 	p->security = NULL;
+	p->io_wait = NULL;
 
 	retval = -ENOMEM;
 	if (security_task_alloc(p))

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India

