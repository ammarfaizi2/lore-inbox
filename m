Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264085AbUGBNA3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264085AbUGBNA3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 09:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264414AbUGBNA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 09:00:29 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:53696 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264085AbUGBM5h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 08:57:37 -0400
Date: Fri, 2 Jul 2004 18:37:09 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: linux-aio@kvack.org, linux-kernel@vger.kernel.org
Cc: linux-osdl@osdl.org
Subject: Re: [PATCH 1/22] High-level AIO retry infrastructure and fixes
Message-ID: <20040702130709.GA4374@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20040702130030.GA4256@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040702130030.GA4256@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 02, 2004 at 06:30:30PM +0530, Suparna Bhattacharya wrote:
> The patchset contains modifications and fixes to the AIO core
> to support the full retry model, an implementation of AIO
> support for buffered filesystem AIO reads and O_SYNC writes
> (the latter courtesy O_SYNC speedup changes from Andrew Morton),
> an implementation of AIO reads and writes to pipes (from
> Chris Mason) and AIO poll (again from Chris Mason).
> 
> Full retry infrastructure and fixes
> [1] aio-retry.patch

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India
---------------------------------------

From: Suparna Bhattacharya <suparna@in.ibm.com>

Core retry infrastructure for AIO. 

Allows an AIO request to be executed as a series of non-blocking
iterations, where each iteration retries the remaining part of the
request from where the last iteration left off, by reissuing the
corresponding AIO fop routine with modified arguments representing
the remaining I/O. The retries are "kicked" via the AIO waitqueue 
callback aio_wake_function() which replaces the default wait 
queue entry used for blocking waits.

The high level retry infrastructure is responsible for running the 
iterations in the mm context (address space) of the caller, and 
ensures that only one retry instance is active at a given time, 
thus relieving the fops themselves from having to deal with potential 
races of that sort.

Follow on fixes:

DESC
Fix aio process hang on EINVAL
EDESC
From: Daniel McNeil <daniel@osdl.org>

Here is a patch to fix EINVAL handling in io_submit_one() that was causing
a process hang when attempting AIO to a device not able to handle aio.  I
hit this doing a AIO read from /dev/zero.  The process would hang on exit
in wait_for_all_aios().  The fix is to check for EINVAL coming back from
aio_setup_iocb() in addition to the EFAULT and EBADF already there.  This
causes the io_submit to fail with EINVAL.  That check looks error prone. 
Are there other error return values where it should jump to the
aio_put_req()?  Should the check be:

	if (ret != 0 && ret != -EIOCBQUEUED)
		goto out_put_req;


DESC
AIO: flush workqueues before destroying ioctx'es
EDESC
From: Suparna Bhattacharya <suparna@in.ibm.com>

Flush out the workqueue before destroying the ioctx which may be sitting on
it.
DESC
AIO: hold the context lock across unuse_mm
EDESC

Hold the context lock across unuse_mm
DESC
task task_lock in use_mm()
EDESC
From: Suparna Bhattacharya <suparna@in.ibm.com>

Another patch based on a suggestion from Ben.  use_mm wasn't acquiring the
task_lock - its possible this might be causing a race with procps.

DESC
Allow fops to override the retry method with their own
EDESC
From: Suparna Bhattacharya <suparna@in.ibm.com>

David Brownell <david-b@pacbell.net> has a patch to implement AIO
support for gadgetfs which specified its own ->retry() method to
perform the copy_to_user from the AIO workqueue after I/O completion.
To enable that to work correctly, with our retry code, we should
drop the lines that nullify and reinstate the ->ki_retry() field 
in aio_run_iocb. 


 fs/aio.c                  |  576 ++++++++++++++++++++++++++++++++++++++-------- include/linux/aio.h       |   25 +
 include/linux/errno.h     |    1 
 include/linux/init_task.h |    1 
 include/linux/sched.h     |    8 
 include/linux/wait.h      |    9 
 kernel/fork.c             |   15 +
 7 files changed, 543 insertions(+), 92 deletions(-)

--- aio/fs/aio.c	2004-06-15 22:19:22.000000000 -0700
+++ aio-retry/fs/aio.c	2004-06-22 10:40:30.844285048 -0700
@@ -38,6 +38,9 @@
 #define dprintk(x...)	do { ; } while (0)
 #endif
 
+long aio_run = 0; /* for testing only */
+long aio_wakeups = 0; /* for testing only */
+
 /*------ sysctl variables----*/
 atomic_t aio_nr = ATOMIC_INIT(0);	/* current system wide number of aio requests */
 unsigned aio_max_nr = 0x10000;	/* system wide maximum number of aio requests */
@@ -276,6 +279,7 @@ static void aio_cancel_all(struct kioctx
 		struct kiocb *iocb = list_kiocb(pos);
 		list_del_init(&iocb->ki_list);
 		cancel = iocb->ki_cancel;
+		kiocbSetCancelled(iocb);
 		if (cancel) {
 			iocb->ki_users++;
 			spin_unlock_irq(&ctx->ctx_lock);
@@ -336,6 +340,11 @@ void fastcall exit_aio(struct mm_struct 
 		aio_cancel_all(ctx);
 
 		wait_for_all_aios(ctx);
+		/*
+		 * this is an overkill, but ensures we don't leave
+		 * the ctx on the aio_wq
+		 */
+		flush_workqueue(aio_wq);
 
 		if (1 != atomic_read(&ctx->users))
 			printk(KERN_DEBUG
@@ -395,6 +404,7 @@ static struct kiocb fastcall *__aio_get_
 	req->ki_cancel = NULL;
 	req->ki_retry = NULL;
 	req->ki_obj.user = NULL;
+	INIT_LIST_HEAD(&req->ki_run_list);
 
 	/* Check if the completion queue has enough free space to
 	 * accept an event from this io.
@@ -536,85 +546,313 @@ struct kioctx *lookup_ioctx(unsigned lon
 	return ioctx;
 }
 
+/*
+ * use_mm
+ *	Makes the calling kernel thread take on the specified
+ *	mm context.
+ *	Called by the retry thread execute retries within the
+ *	iocb issuer's mm context, so that copy_from/to_user
+ *	operations work seamlessly for aio.
+ *	(Note: this routine is intended to be called only
+ *	from a kernel thread context)
+ */
 static void use_mm(struct mm_struct *mm)
 {
 	struct mm_struct *active_mm;
+	struct task_struct *tsk = current;
 
+	task_lock(tsk);
+	active_mm = tsk->active_mm;
 	atomic_inc(&mm->mm_count);
-	task_lock(current);
-	active_mm = current->active_mm;
-	current->mm = mm;
-	if (mm != active_mm) {
-		current->active_mm = mm;
-		activate_mm(active_mm, mm);
-	}
-	task_unlock(current);
+	tsk->mm = mm;
+	tsk->active_mm = mm;
+	activate_mm(active_mm, mm);
+	task_unlock(tsk);
+
 	mmdrop(active_mm);
 }
 
-static void unuse_mm(struct mm_struct *mm)
+/*
+ * unuse_mm
+ *	Reverses the effect of use_mm, i.e. releases the
+ *	specified mm context which was earlier taken on
+ *	by the calling kernel thread
+ *	(Note: this routine is intended to be called only
+ *	from a kernel thread context)
+ *
+ * Comments: Called with ctx->ctx_lock held. This nests
+ * task_lock instead ctx_lock.
+ */
+void unuse_mm(struct mm_struct *mm)
 {
-	task_lock(current);
-	current->mm = NULL;
-	task_unlock(current);
+	struct task_struct *tsk = current;
+
+	task_lock(tsk);
+	tsk->mm = NULL;
 	/* active_mm is still 'mm' */
-	enter_lazy_tlb(mm, current);
+	enter_lazy_tlb(mm, tsk);
+	task_unlock(tsk);
 }
 
-/* Run on kevent's context.  FIXME: needs to be per-cpu and warn if an
- * operation blocks.
+/*
+ * Queue up a kiocb to be retried. Assumes that the kiocb
+ * has already been marked as kicked, and places it on
+ * the retry run list for the corresponding ioctx, if it
+ * isn't already queued. Returns 1 if it actually queued
+ * the kiocb (to tell the caller to activate the work
+ * queue to process it), or 0, if it found that it was
+ * already queued.
+ *
+ * Should be called with the spin lock iocb->ki_ctx->ctx_lock
+ * held
  */
-static void aio_kick_handler(void *data)
+static inline int __queue_kicked_iocb(struct kiocb *iocb)
 {
-	struct kioctx *ctx = data;
+	struct kioctx *ctx = iocb->ki_ctx;
 
-	use_mm(ctx->mm);
+	if (list_empty(&iocb->ki_run_list)) {
+		list_add_tail(&iocb->ki_run_list,
+			&ctx->run_list);
+		iocb->ki_queued++;
+		return 1;
+	}
+	return 0;
+}
+
+/* aio_run_iocb
+ *	This is the core aio execution routine. It is
+ *	invoked both for initial i/o submission and
+ *	subsequent retries via the aio_kick_handler.
+ *	Expects to be invoked with iocb->ki_ctx->lock
+ *	already held. The lock is released and reaquired
+ *	as needed during processing.
+ *
+ * Calls the iocb retry method (already setup for the
+ * iocb on initial submission) for operation specific
+ * handling, but takes care of most of common retry
+ * execution details for a given iocb. The retry method
+ * needs to be non-blocking as far as possible, to avoid
+ * holding up other iocbs waiting to be serviced by the
+ * retry kernel thread.
+ *
+ * The trickier parts in this code have to do with
+ * ensuring that only one retry instance is in progress
+ * for a given iocb at any time. Providing that guarantee
+ * simplifies the coding of individual aio operations as
+ * it avoids various potential races.
+ */
+static ssize_t aio_run_iocb(struct kiocb *iocb)
+{
+	struct kioctx	*ctx = iocb->ki_ctx;
+	ssize_t (*retry)(struct kiocb *);
+	ssize_t ret;
+ 
+	if (iocb->ki_retried++ > 1024*1024) {
+		printk("Maximal retry count.  Bytes done %Zd\n",
+			iocb->ki_nbytes - iocb->ki_left);
+		return -EAGAIN;
+	}
+
+	if (!(iocb->ki_retried & 0xff)) {
+		pr_debug("%ld retry: %d of %d (kick %ld, Q %ld run %ld, wake %ld)\n",
+			iocb->ki_retried,
+			iocb->ki_nbytes - iocb->ki_left, iocb->ki_nbytes,
+			iocb->ki_kicked, iocb->ki_queued, aio_run, aio_wakeups);
+	}
 
+	if (!(retry = iocb->ki_retry)) {
+		printk("aio_run_iocb: iocb->ki_retry = NULL\n");
+		return 0;
+	}
+ 
+	/*
+	 * We don't want the next retry iteration for this
+	 * operation to start until this one has returned and
+	 * updated the iocb state. However, wait_queue functions
+	 * can trigger a kick_iocb from interrupt context in the
+	 * meantime, indicating that data is available for the next
+	 * iteration. We want to remember that and enable the
+	 * next retry iteration _after_ we are through with
+	 * this one.
+	 *
+	 * So, in order to be able to register a "kick", but
+	 * prevent it from being queued now, we clear the kick
+	 * flag, but make the kick code *think* that the iocb is
+	 * still on the run list until we are actually done.
+	 * When we are done with this iteration, we check if
+	 * the iocb was kicked in the meantime and if so, queue
+	 * it up afresh.
+	 */
+
+	kiocbClearKicked(iocb);
+
+	/*
+	 * This is so that aio_complete knows it doesn't need to
+	 * pull the iocb off the run list (We can't just call
+	 * INIT_LIST_HEAD because we don't want a kick_iocb to
+	 * queue this on the run list yet)
+	 */
+	iocb->ki_run_list.next = iocb->ki_run_list.prev = NULL;
+	spin_unlock_irq(&ctx->ctx_lock);
+
+	/* Quit retrying if the i/o has been cancelled */
+	if (kiocbIsCancelled(iocb)) {
+		ret = -EINTR;
+		aio_complete(iocb, ret, 0);
+		/* must not access the iocb after this */
+		goto out;
+	}
+
+	/*
+	 * Now we are all set to call the retry method in async
+	 * context. By setting this thread's io_wait context
+	 * to point to the wait queue entry inside the currently
+	 * running iocb for the duration of the retry, we ensure
+	 * that async notification wakeups are queued by the
+	 * operation instead of blocking waits, and when notified,
+	 * cause the iocb to be kicked for continuation (through
+	 * the aio_wake_function callback).
+	 */
+	BUG_ON(current->io_wait != NULL);
+	current->io_wait = &iocb->ki_wait;
+	ret = retry(iocb);
+	current->io_wait = NULL;
+
+	if (-EIOCBRETRY != ret) {
+ 		if (-EIOCBQUEUED != ret) {
+			BUG_ON(!list_empty(&iocb->ki_wait.task_list));
+			aio_complete(iocb, ret, 0);
+			/* must not access the iocb after this */
+		}
+	} else {
+		/*
+		 * Issue an additional retry to avoid waiting forever if
+		 * no waits were queued (e.g. in case of a short read).
+		 */
+		if (list_empty(&iocb->ki_wait.task_list))
+			kiocbSetKicked(iocb);
+	}
+out:
 	spin_lock_irq(&ctx->ctx_lock);
-	while (!list_empty(&ctx->run_list)) {
-		struct kiocb *iocb;
-		long ret;
+ 
+	if (-EIOCBRETRY == ret) {
+		/*
+		 * OK, now that we are done with this iteration
+		 * and know that there is more left to go,
+		 * this is where we let go so that a subsequent
+		 * "kick" can start the next iteration
+		 */
+
+		/* will make __queue_kicked_iocb succeed from here on */
+		INIT_LIST_HEAD(&iocb->ki_run_list);
+		/* we must queue the next iteration ourselves, if it
+		 * has already been kicked */
+		if (kiocbIsKicked(iocb)) {
+			__queue_kicked_iocb(iocb);
+		}
+	}
+	return ret;
+}
 
+/*
+ * __aio_run_iocbs:
+ * 	Process all pending retries queued on the ioctx
+ * 	run list.
+ * Assumes it is operating within the aio issuer's mm
+ * context. Expects to be called with ctx->ctx_lock held
+ */
+static void __aio_run_iocbs(struct kioctx *ctx)
+{
+	struct kiocb *iocb;
+	ssize_t ret;
+	int count = 0;
+
+	while (!list_empty(&ctx->run_list)) {
 		iocb = list_entry(ctx->run_list.next, struct kiocb,
-				  ki_run_list);
+			ki_run_list);
 		list_del(&iocb->ki_run_list);
-		iocb->ki_users ++;
-		spin_unlock_irq(&ctx->ctx_lock);
+		ret = aio_run_iocb(iocb);
+		count++;
+ 	}
+	aio_run++;
+}
 
-		kiocbClearKicked(iocb);
-		ret = iocb->ki_retry(iocb);
-		if (-EIOCBQUEUED != ret) {
-			aio_complete(iocb, ret, 0);
-			iocb = NULL;
-		}
+/*
+ * aio_run_iocbs:
+ * 	Process all pending retries queued on the ioctx
+ * 	run list.
+ * Assumes it is operating within the aio issuer's mm
+ * context.
+ */
+static inline void aio_run_iocbs(struct kioctx *ctx)
+{
+	spin_lock_irq(&ctx->ctx_lock);
+	__aio_run_iocbs(ctx);
+ 	spin_unlock_irq(&ctx->ctx_lock);
+}
+ 
+/*
+ * aio_kick_handler:
+ * 	Work queue handler triggered to process pending
+ * 	retries on an ioctx. Takes on the aio issuer's
+ * 	mm context before running the iocbs.
+ * Run on aiod's context.
+ */
+static void aio_kick_handler(void *data)
+{
+	struct kioctx *ctx = data;
 
-		spin_lock_irq(&ctx->ctx_lock);
-		if (NULL != iocb)
-			__aio_put_req(ctx, iocb);
-	}
+	use_mm(ctx->mm);
+	spin_lock_irq(&ctx->ctx_lock);
+	__aio_run_iocbs(ctx);
+ 	unuse_mm(ctx->mm);
 	spin_unlock_irq(&ctx->ctx_lock);
+}
+ 
 
-	unuse_mm(ctx->mm);
+/*
+ * Called by kick_iocb to queue the kiocb for retry
+ * and if required activate the aio work queue to process
+ * it
+ */
+void queue_kicked_iocb(struct kiocb *iocb)
+{
+ 	struct kioctx	*ctx = iocb->ki_ctx;
+	unsigned long flags;
+	int run = 0;
+
+	WARN_ON((!list_empty(&iocb->ki_wait.task_list)));
+
+	spin_lock_irqsave(&ctx->ctx_lock, flags);
+	run = __queue_kicked_iocb(iocb);
+	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
+	if (run) {
+		queue_work(aio_wq, &ctx->wq);
+		aio_wakeups++;
+	}
 }
 
+/*
+ * kick_iocb:
+ *      Called typically from a wait queue callback context
+ *      (aio_wake_function) to trigger a retry of the iocb.
+ *      The retry is usually executed by aio workqueue
+ *      threads (See aio_kick_handler).
+ */
 void fastcall kick_iocb(struct kiocb *iocb)
 {
-	struct kioctx	*ctx = iocb->ki_ctx;
-
 	/* sync iocbs are easy: they can only ever be executing from a 
 	 * single context. */
 	if (is_sync_kiocb(iocb)) {
 		kiocbSetKicked(iocb);
-		wake_up_process(iocb->ki_obj.tsk);
+	        wake_up_process(iocb->ki_obj.tsk);
 		return;
 	}
 
+	iocb->ki_kicked++;
+	/* If its already kicked we shouldn't queue it again */
 	if (!kiocbTryKick(iocb)) {
-		unsigned long flags;
-		spin_lock_irqsave(&ctx->ctx_lock, flags);
-		list_add_tail(&iocb->ki_run_list, &ctx->run_list);
-		spin_unlock_irqrestore(&ctx->ctx_lock, flags);
-		queue_work(aio_wq, &ctx->wq);
+		queue_kicked_iocb(iocb);
 	}
 }
 
@@ -667,6 +905,9 @@ int fastcall aio_complete(struct kiocb *
 	 */
 	spin_lock_irqsave(&ctx->ctx_lock, flags);
 
+	if (iocb->ki_run_list.prev && !list_empty(&iocb->ki_run_list))
+		list_del_init(&iocb->ki_run_list);
+
 	ring = kmap_atomic(info->ring_pages[0], KM_IRQ1);
 
 	tail = info->tail;
@@ -695,6 +936,11 @@ int fastcall aio_complete(struct kiocb *
 
 	pr_debug("added to ring %p at [%lu]\n", iocb, tail);
 
+	pr_debug("%ld retries: %d of %d (kicked %ld, Q %ld run %ld wake %ld)\n",
+		iocb->ki_retried,
+		iocb->ki_nbytes - iocb->ki_left, iocb->ki_nbytes,
+		iocb->ki_kicked, iocb->ki_queued, aio_run, aio_wakeups);
+
 	/* everything turned out well, dispose of the aiocb. */
 	ret = __aio_put_req(ctx, iocb);
 
@@ -801,6 +1047,7 @@ static int read_events(struct kioctx *ct
 	int			i = 0;
 	struct io_event		ent;
 	struct timeout		to;
+	int 			event_loop = 0; /* testing only */
 
 	/* needed to zero any padding within an entry (there shouldn't be 
 	 * any, but C is fun!
@@ -850,7 +1097,6 @@ static int read_events(struct kioctx *ct
 		add_wait_queue_exclusive(&ctx->wait, &wait);
 		do {
 			set_task_state(tsk, TASK_INTERRUPTIBLE);
-
 			ret = aio_read_evt(ctx, &ent);
 			if (ret)
 				break;
@@ -860,6 +1106,7 @@ static int read_events(struct kioctx *ct
 			if (to.timed_out)	/* Only check after read evt */
 				break;
 			schedule();
+			event_loop++;
 			if (signal_pending(tsk)) {
 				ret = -EINTR;
 				break;
@@ -887,6 +1134,9 @@ static int read_events(struct kioctx *ct
 	if (timeout)
 		clear_timeout(&to);
 out:
+	pr_debug("event loop executed %d times\n", event_loop);
+	pr_debug("aio_run %ld\n", aio_run);
+	pr_debug("aio_wakeups %ld\n", aio_wakeups);
 	return i ? i : ret;
 }
 
@@ -916,6 +1166,11 @@ static void io_destroy(struct kioctx *io
 
 	aio_cancel_all(ioctx);
 	wait_for_all_aios(ioctx);
+	/*
+	 * this is an overkill, but ensures we don't leave
+	 * the ctx on the aio_wq
+	 */
+	flush_workqueue(aio_wq);
 	put_ioctx(ioctx);	/* once for the lookup */
 }
 
@@ -954,7 +1209,7 @@ asmlinkage long sys_io_setup(unsigned nr
 		ret = put_user(ioctx->user_id, ctxp);
 		if (!ret)
 			return 0;
-	 	get_ioctx(ioctx);
+	 	
 		io_destroy(ioctx);
 	}
 
@@ -979,13 +1234,179 @@ asmlinkage long sys_io_destroy(aio_conte
 	return -EINVAL;
 }
 
+/*
+ * Retry method for aio_read (also used for first time submit)
+ * Responsible for updating iocb state as retries progress
+ */
+static ssize_t aio_pread(struct kiocb *iocb)
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
+/*
+ * Retry method for aio_write (also used for first time submit)
+ * Responsible for updating iocb state as retries progress
+ */
+static ssize_t aio_pwrite(struct kiocb *iocb)
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
+static ssize_t aio_fdsync(struct kiocb *iocb)
+{
+	struct file *file = iocb->ki_filp;
+	ssize_t ret = -EINVAL;
+
+	if (file->f_op->aio_fsync)
+		ret = file->f_op->aio_fsync(iocb, 1);
+	return ret;
+}
+
+static ssize_t aio_fsync(struct kiocb *iocb)
+{
+	struct file *file = iocb->ki_filp;
+	ssize_t ret = -EINVAL;
+
+	if (file->f_op->aio_fsync)
+		ret = file->f_op->aio_fsync(iocb, 0);
+	return ret;
+}
+
+/*
+ * aio_setup_iocb:
+ *	Performs the initial checks and aio retry method
+ *	setup for the kiocb at the time of io submission.
+ */
+ssize_t aio_setup_iocb(struct kiocb *kiocb)
+{
+	struct file *file = kiocb->ki_filp;
+	ssize_t ret = 0;
+
+	switch (kiocb->ki_opcode) {
+	case IOCB_CMD_PREAD:
+		ret = -EBADF;
+		if (unlikely(!(file->f_mode & FMODE_READ)))
+			break;
+		ret = -EFAULT;
+		if (unlikely(!access_ok(VERIFY_WRITE, kiocb->ki_buf,
+			kiocb->ki_left)))
+			break;
+		ret = -EINVAL;
+		if (file->f_op->aio_read)
+			kiocb->ki_retry = aio_pread;
+		break;
+	case IOCB_CMD_PWRITE:
+		ret = -EBADF;
+		if (unlikely(!(file->f_mode & FMODE_WRITE)))
+			break;
+		ret = -EFAULT;
+		if (unlikely(!access_ok(VERIFY_READ, kiocb->ki_buf,
+			kiocb->ki_left)))
+			break;
+		ret = -EINVAL;
+		if (file->f_op->aio_write)
+			kiocb->ki_retry = aio_pwrite;
+		break;
+	case IOCB_CMD_FDSYNC:
+		ret = -EINVAL;
+		if (file->f_op->aio_fsync)
+			kiocb->ki_retry = aio_fdsync;
+		break;
+	case IOCB_CMD_FSYNC:
+		ret = -EINVAL;
+		if (file->f_op->aio_fsync)
+			kiocb->ki_retry = aio_fsync;
+		break;
+	default:
+		dprintk("EINVAL: io_submit: no operation provided\n");
+		ret = -EINVAL;
+	}
+
+	if (!kiocb->ki_retry)
+		return ret;
+
+	return 0;
+}
+
+/*
+ * aio_wake_function:
+ * 	wait queue callback function for aio notification,
+ * 	Simply triggers a retry of the operation via kick_iocb.
+ *
+ * 	This callback is specified in the wait queue entry in
+ *	a kiocb	(current->io_wait points to this wait queue
+ *	entry when an aio operation executes; it is used
+ * 	instead of a synchronous wait when an i/o blocking
+ *	condition is encountered during aio).
+ *
+ * Note:
+ * This routine is executed with the wait queue lock held.
+ * Since kick_iocb acquires iocb->ctx->ctx_lock, it nests
+ * the ioctx lock inside the wait queue lock. This is safe
+ * because this callback isn't used for wait queues which
+ * are nested inside ioctx lock (i.e. ctx->wait)
+ */
+int aio_wake_function(wait_queue_t *wait, unsigned mode, int sync, void *key)
+{
+	struct kiocb *iocb = container_of(wait, struct kiocb, ki_wait);
+
+	list_del_init(&wait->task_list);
+	kick_iocb(iocb);
+	return 1;
+}
+
 int fastcall io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
 			 struct iocb *iocb)
 {
 	struct kiocb *req;
 	struct file *file;
 	ssize_t ret;
-	char __user *buf;
 
 	/* enforce forwards compatibility on users */
 	if (unlikely(iocb->aio_reserved1 || iocb->aio_reserved2 ||
@@ -1026,52 +1447,31 @@ int fastcall io_submit_one(struct kioctx
 	req->ki_user_data = iocb->aio_data;
 	req->ki_pos = iocb->aio_offset;
 
-	buf = (char __user *)(unsigned long)iocb->aio_buf;
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
 
+	if (ret)
+		goto out_put_req;
+
+	spin_lock_irq(&ctx->ctx_lock);
+	ret = aio_run_iocb(req);
+	spin_unlock_irq(&ctx->ctx_lock);
+
+	if (-EIOCBRETRY == ret)
+		queue_work(aio_wq, &ctx->wq);
 	aio_put_req(req);	/* drop extra ref to req */
-	if (likely(-EIOCBQUEUED == ret))
-		return 0;
-	aio_complete(req, ret, 0);	/* will drop i/o ref to req */
 	return 0;
 
 out_put_req:
--- linux-2.6.7/include/linux/aio.h	2004-06-15 22:18:54.000000000 -0700
+++ aio/include/linux/aio.h	2004-06-17 16:21:47.263378632 -0700
@@ -54,7 +54,7 @@ struct kiocb {
 	struct file		*ki_filp;
 	struct kioctx		*ki_ctx;	/* may be NULL for sync ops */
 	int			(*ki_cancel)(struct kiocb *, struct io_event *);
-	long			(*ki_retry)(struct kiocb *);
+	ssize_t			(*ki_retry)(struct kiocb *);
 
 	struct list_head	ki_list;	/* the aio core uses this
 						 * for cancellation */
@@ -66,6 +66,16 @@ struct kiocb {
 	__u64			ki_user_data;	/* user's data for completion */
 	loff_t			ki_pos;
 
+	/* State that we remember to be able to restart/retry  */
+	unsigned short		ki_opcode;
+	size_t			ki_nbytes; 	/* copy of iocb->aio_nbytes */
+	char 			*ki_buf;	/* remaining iocb->aio_buf */
+	size_t			ki_left; 	/* remaining bytes */
+	wait_queue_t		ki_wait;
+	long			ki_retried; 	/* just for testing */
+	long			ki_kicked; 	/* just for testing */
+	long			ki_queued; 	/* just for testing */
+
 	char			private[KIOCB_PRIVATE_SIZE];
 };
 
@@ -80,6 +90,8 @@ struct kiocb {
 		(x)->ki_ctx = &tsk->active_mm->default_kioctx;	\
 		(x)->ki_cancel = NULL;			\
 		(x)->ki_obj.tsk = tsk;			\
+		(x)->ki_user_data = 0;                  \
+		init_wait((&(x)->ki_wait));             \
 	} while (0)
 
 #define AIO_RING_MAGIC			0xa10a10a1
@@ -162,6 +174,17 @@ int FASTCALL(io_submit_one(struct kioctx
 #define get_ioctx(kioctx)	do { if (unlikely(atomic_read(&(kioctx)->users) <= 0)) BUG(); atomic_inc(&(kioctx)->users); } while (0)
 #define put_ioctx(kioctx)	do { if (unlikely(atomic_dec_and_test(&(kioctx)->users))) __put_ioctx(kioctx); else if (unlikely(atomic_read(&(kioctx)->users) < 0)) BUG(); } while (0)
 
+#define in_aio() !is_sync_wait(current->io_wait)
+/* may be used for debugging */
+#define warn_if_async()	if (in_aio()) {\
+	printk(KERN_ERR "%s(%s:%d) called in async context!\n", \
+	__FUNCTION__, __FILE__, __LINE__); \
+	dump_stack(); \
+	}
+
+#define io_wait_to_kiocb(wait) container_of(wait, struct kiocb, ki_wait)
+#define is_retried_kiocb(iocb) ((iocb)->ki_retried > 1)
+
 #include <linux/aio_abi.h>
 
 static inline struct kiocb *list_kiocb(struct list_head *h)
--- linux-2.6.7/include/linux/errno.h	2004-06-15 22:19:52.000000000 -0700
+++ aio/include/linux/errno.h	2004-06-17 16:20:51.562846400 -0700
@@ -22,6 +22,7 @@
 #define EBADTYPE	527	/* Type not supported by server */
 #define EJUKEBOX	528	/* Request initiated, but will not complete before timeout */
 #define EIOCBQUEUED	529	/* iocb queued, will get completion event */
+#define EIOCBRETRY	530	/* iocb queued, will trigger a retry */
 
 #endif
 
--- linux-2.6.7/include/linux/init_task.h	2004-06-15 22:18:57.000000000 -0700
+++ aio/include/linux/init_task.h	2004-06-17 16:20:51.563846248 -0700
@@ -112,6 +112,7 @@ extern struct group_info init_groups;
 	.proc_lock	= SPIN_LOCK_UNLOCKED,				\
 	.switch_lock	= SPIN_LOCK_UNLOCKED,				\
 	.journal_info	= NULL,						\
+	.io_wait	= NULL,						\
 }
 
 
--- linux-2.6.7/include/linux/sched.h	2004-06-15 22:18:57.000000000 -0700
+++ aio/include/linux/sched.h	2004-06-17 16:22:20.997250304 -0700
@@ -508,7 +508,13 @@ struct task_struct {
 
 	unsigned long ptrace_message;
 	siginfo_t *last_siginfo; /* For ptrace use.  */
-
+/*
+ * current io wait handle: wait queue entry to use for io waits
+ * If this thread is processing aio, this points at the waitqueue
+ * inside the currently handled kiocb. It may be NULL (i.e. default
+ * to a stack based synchronous wait) if its doing sync IO.
+ */
+	wait_queue_t *io_wait;
 #ifdef CONFIG_NUMA
   	struct mempolicy *mempolicy;
   	short il_next;		/* could be shared with used_math */
--- linux-2.6.7/include/linux/wait.h	2004-06-15 22:19:31.000000000 -0700
+++ aio/include/linux/wait.h	2004-06-17 16:20:51.567845640 -0700
@@ -80,6 +80,15 @@ static inline int waitqueue_active(wait_
 	return !list_empty(&q->task_list);
 }
 
+/*
+ * Used to distinguish between sync and async io wait context:
+ * sync i/o typically specifies a NULL wait queue entry or a wait
+ * queue entry bound to a task (current task) to wake up.
+ * aio specifies a wait queue entry with an async notification
+ * callback routine, not associated with any task.
+ */
+#define is_sync_wait(wait)	(!(wait) || ((wait)->task))
+
 extern void FASTCALL(add_wait_queue(wait_queue_head_t *q, wait_queue_t * wait));
 extern void FASTCALL(add_wait_queue_exclusive(wait_queue_head_t *q, wait_queue_t * wait));
 extern void FASTCALL(remove_wait_queue(wait_queue_head_t *q, wait_queue_t * wait));
--- linux-2.6.7/kernel/fork.c	2004-06-15 22:18:57.000000000 -0700
+++ aio/kernel/fork.c	2004-06-17 16:20:51.569845336 -0700
@@ -151,7 +151,12 @@ void fastcall prepare_to_wait(wait_queue
 	spin_lock_irqsave(&q->lock, flags);
 	if (list_empty(&wait->task_list))
 		__add_wait_queue(q, wait);
-	set_current_state(state);
+	/*
+	 * don't alter the task state if this is just going to
+	 * queue an async wait queue callback
+	 */
+	if (is_sync_wait(wait))
+		set_current_state(state);
 	spin_unlock_irqrestore(&q->lock, flags);
 }
 
@@ -166,7 +171,12 @@ prepare_to_wait_exclusive(wait_queue_hea
 	spin_lock_irqsave(&q->lock, flags);
 	if (list_empty(&wait->task_list))
 		__add_wait_queue_tail(q, wait);
-	set_current_state(state);
+	/*
+	 * don't alter the task state if this is just going to
+ 	 * queue an async wait queue callback
+	 */
+	if (is_sync_wait(wait))
+		set_current_state(state);
 	spin_unlock_irqrestore(&q->lock, flags);
 }
 
@@ -964,6 +974,7 @@ struct task_struct *copy_process(unsigne
 	p->start_time = get_jiffies_64();
 	p->security = NULL;
 	p->io_context = NULL;
+	p->io_wait = NULL;
 	p->audit_context = NULL;
 #ifdef CONFIG_NUMA
  	p->mempolicy = mpol_copy(p->mempolicy);
