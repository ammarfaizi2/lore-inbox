Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267474AbUHEE34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267474AbUHEE34 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 00:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267476AbUHEE34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 00:29:56 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:26310 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267474AbUHEE3D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 00:29:03 -0400
Date: Thu, 5 Aug 2004 10:08:26 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: akpm@osdl.org
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Collected AIO retry fixes and enhancements
Message-ID: <20040805043826.GA4028@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20040805043301.GA3532@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040805043301.GA3532@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2004 at 10:03:01AM +0530, Suparna Bhattacharya wrote:
> 
> [1] aio-retry.patch
>   Collection of AIO retry infrastructure fixes and enhancements
>   AIO: Split iocb setup and execution in io_submit 
>        (also fixes io_submit error reporting)
>   AIO: Default high level retry methods
>   AIO: Subtle use_mm/unuse_mm fix
>   AIO: Code commenting
>   AIO: Fix aio process hang on EINVAL (Daniel McNeil)
>   AIO: flush workqueues before destroying ioctx'es 
>   AIO: hold the context lock across unuse_mm
>   AIO: Acquire task_lock in use_mm()
>   AIO: Allow fops to override the retry method with their own
>   AIO: Elevated ref count for AIO retries (Daniel McNeil)
>   AIO: set_fs needed when calling use_mm
>   AIO: flush workqueue on __put_ioctx (Chris Mason)
>   AIO: Fix io_cancel to work with retries (Chris Mason)
>   AIO: read-immediate option for socket/pipe retry support
> 

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

-----------------------------------------------------------

DESC
AIO: retry infrastructure fixes and enhancements
EDESC

Reorganises, comments and fixes the AIO retry logic. Fixes include:
- use_mm/unuse_mm race fixes
- split io submit into setup and submission, return correct error
  code
- uses the aio workqueue instead of keventd for retries
- code commenting
- support for default high-level retry routines (fops can
  still set up operation specific retry routines if suitable)

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
AIO: Fix aio process hang on EINVAL
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
AIO: Acquire task_lock in use_mm()
EDESC
From: Suparna Bhattacharya <suparna@in.ibm.com>

Another patch based on a suggestion from Ben.  use_mm wasn't acquiring the
task_lock - its possible this might be causing a race with procps.

DESC
AIO: Allow fops to override the retry method with their own
EDESC
From: Suparna Bhattacharya <suparna@in.ibm.com>

David Brownell <david-b@pacbell.net> has a patch to implement AIO
support for gadgetfs which specified its own ->retry() method to
perform the copy_to_user from the AIO workqueue after I/O completion.
To enable that to work correctly, with our retry code, we should
drop the lines that nullify and reinstate the ->ki_retry() field 
in aio_run_iocb. 

 include/linux/errno.h     |    1 
 include/linux/init_task.h |    1 
 include/linux/sched.h     |    8 
 include/linux/wait.h      |    9 

DESC
AIO: Elevated ref count for AIO retries
EDESC
From: Daniel McNeil <daniel@osdl.org>

Here is the patch for AIO retry to hold an extra ref count.  The patch is
small, but I wanted to make sure it was safe.

I spent time looking over the retry code and this patch looks ok to me.  It
is potentially calling put_ioctx() while holding ctx->ctx_lock, I do not
think that will cause any problems.  This should never be the last reference
on the ioctx anyway, since the loop is checking list_empty(&ctx->run_list). 
The first ref is taken in sys_io_setup() and last removed in io_destroy(). 
It also looks like holding ctx->ctx_lock prevents any races between any
retries and an io_destroy() which would try to cancel all iocbs.

I've tested this on my 2-proc by coping a raw partitions and copying ext3
files using using AIO and O_DIRECT, O_SYNC, and both.

DESC
AIO: set_fs needed when calling use_mm 
EDESC
From: Suparna Bhattacharya <suparna@in.ibm.com>

This patch appears to fix the hangs seen with AIO and 4G-4G for me.  It
ensures that the indirect versions of copy_xxx_user are used during aio
retries running in worker thread context (i.e.  access aio issuer's
user-space instead of kernel-space).

DESC
AIO: flush workqueue on __put_ioctx
EDESC
From: Chris Mason

While testing fsaio here, I hit an oops in kick_iocb because iocb->mm
was null.  This was right as the program was exiting.

With the patch below, I wasn't able to reproduce, it makes sure we flush
the workqueue every time __put_ioctx gets called.

DESC
AIO: Fix io_cancel to work with retries
EDESC
From: Chris Mason <mason@suse.com>

Fix for sys_io_cancel to work properly with retries when a cancel
method is specified for an iocb. Needed with pipe AIO support. 

There's a bug in my aio cancel patch, aio_complete still makes an event
for cancelled iocbs.  If nobody asks for this event, we effectively leak
space in the event ring buffer.  I've attached a new aio_cancel patch
that just skips the event creation for canceled iocbs.

DESC
AIO: read-immediate option for socket/pipe retry support
EDESC
From: Suparna Bhattacharya <suparna@in.ibm.com>

Currently, the high level AIO code keeps issuing retries until the
entire transfer is done, i.e. until all the bytes requested are
read (See aio_pread), which is what we needed for filesystem aio
read. However, in the pipe read case, the expected semantics would
be to return as soon as it has any bytes transferred, rather than
waiting for the entire transfer.  This will also be true in for
network aio reads if/when we implement it.
                                                                         
Hmm, so we need to get the generic code to allow for this
possibility - maybe based on a check for ISFIFO/ISSOCK ?



 linux-2.6.8-rc3-suparna/fs/aio.c                  |  600 ++++++++++++++++++----
 linux-2.6.8-rc3-suparna/include/linux/aio.h       |   25 
 linux-2.6.8-rc3-suparna/include/linux/errno.h     |    1 
 linux-2.6.8-rc3-suparna/include/linux/init_task.h |    1 
 linux-2.6.8-rc3-suparna/include/linux/sched.h     |    8 
 linux-2.6.8-rc3-suparna/include/linux/wait.h      |    9 
 linux-2.6.8-rc3-suparna/kernel/fork.c             |   15 
 7 files changed, 560 insertions(+), 99 deletions(-)

diff -puN fs/aio.c~aio-retry fs/aio.c
--- linux-2.6.8-rc3/fs/aio.c~aio-retry	2004-08-04 14:31:21.000000000 +0530
+++ linux-2.6.8-rc3-suparna/fs/aio.c	2004-08-04 14:31:21.000000000 +0530
@@ -39,6 +39,9 @@
 #define dprintk(x...)	do { ; } while (0)
 #endif
 
+long aio_run = 0; /* for testing only */
+long aio_wakeups = 0; /* for testing only */
+
 /*------ sysctl variables----*/
 atomic_t aio_nr = ATOMIC_INIT(0);	/* current system wide number of aio requests */
 unsigned aio_max_nr = 0x10000;	/* system wide maximum number of aio requests */
@@ -277,6 +280,7 @@ static void aio_cancel_all(struct kioctx
 		struct kiocb *iocb = list_kiocb(pos);
 		list_del_init(&iocb->ki_list);
 		cancel = iocb->ki_cancel;
+		kiocbSetCancelled(iocb);
 		if (cancel) {
 			iocb->ki_users++;
 			spin_unlock_irq(&ctx->ctx_lock);
@@ -337,6 +341,11 @@ void fastcall exit_aio(struct mm_struct 
 		aio_cancel_all(ctx);
 
 		wait_for_all_aios(ctx);
+		/*
+		 * this is an overkill, but ensures we don't leave
+		 * the ctx on the aio_wq
+		 */
+		flush_workqueue(aio_wq);
 
 		if (1 != atomic_read(&ctx->users))
 			printk(KERN_DEBUG
@@ -359,6 +368,7 @@ void fastcall __put_ioctx(struct kioctx 
 	if (unlikely(ctx->reqs_active))
 		BUG();
 
+	flush_workqueue(aio_wq);
 	aio_free_ring(ctx);
 	mmdrop(ctx->mm);
 	ctx->mm = NULL;
@@ -398,6 +408,7 @@ static struct kiocb fastcall *__aio_get_
 	req->ki_obj.user = NULL;
 	req->ki_dtor = NULL;
 	req->private = NULL;
+	INIT_LIST_HEAD(&req->ki_run_list);
 
 	/* Check if the completion queue has enough free space to
 	 * accept an event from this io.
@@ -543,85 +554,323 @@ struct kioctx *lookup_ioctx(unsigned lon
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
 
-	spin_lock_irq(&ctx->ctx_lock);
-	while (!list_empty(&ctx->run_list)) {
-		struct kiocb *iocb;
-		long ret;
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
 
-		iocb = list_entry(ctx->run_list.next, struct kiocb,
-				  ki_run_list);
-		list_del(&iocb->ki_run_list);
-		iocb->ki_users ++;
-		spin_unlock_irq(&ctx->ctx_lock);
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
+
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
 
-		kiocbClearKicked(iocb);
-		ret = iocb->ki_retry(iocb);
-		if (-EIOCBQUEUED != ret) {
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
 			aio_complete(iocb, ret, 0);
-			iocb = NULL;
+			/* must not access the iocb after this */
 		}
+	} else {
+		/*
+		 * Issue an additional retry to avoid waiting forever if
+		 * no waits were queued (e.g. in case of a short read).
+		 */
+		if (list_empty(&iocb->ki_wait.task_list))
+			kiocbSetKicked(iocb);
+	}
+out:
+	spin_lock_irq(&ctx->ctx_lock);
 
-		spin_lock_irq(&ctx->ctx_lock);
-		if (NULL != iocb)
-			__aio_put_req(ctx, iocb);
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
 	}
+	return ret;
+}
+
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
+	int count = 0;
+
+	while (!list_empty(&ctx->run_list)) {
+		iocb = list_entry(ctx->run_list.next, struct kiocb,
+			ki_run_list);
+		list_del(&iocb->ki_run_list);
+		/*
+		 * Hold an extra reference while retrying i/o.
+		 */
+		iocb->ki_users++;       /* grab extra reference */
+		aio_run_iocb(iocb);
+		if (__aio_put_req(ctx, iocb))  /* drop extra ref */
+			put_ioctx(ctx);
+		count++;
+ 	}
+	aio_run++;
+}
+
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
+ *	mm context before running the iocbs, so that
+ *	copy_xxx_user operates on the issuer's address
+ *      space.
+ * Run on aiod's context.
+ */
+static void aio_kick_handler(void *data)
+{
+	struct kioctx *ctx = data;
+	mm_segment_t oldfs = get_fs();
+
+	set_fs(USER_DS);
+	use_mm(ctx->mm);
+	spin_lock_irq(&ctx->ctx_lock);
+	__aio_run_iocbs(ctx);
+ 	unuse_mm(ctx->mm);
 	spin_unlock_irq(&ctx->ctx_lock);
+	set_fs(oldfs);
+}
+
+
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
 
-	unuse_mm(ctx->mm);
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
 EXPORT_SYMBOL(kick_iocb);
@@ -675,6 +924,16 @@ int fastcall aio_complete(struct kiocb *
 	 */
 	spin_lock_irqsave(&ctx->ctx_lock, flags);
 
+	if (iocb->ki_run_list.prev && !list_empty(&iocb->ki_run_list))
+		list_del_init(&iocb->ki_run_list);
+
+	/*
+	 * cancelled requests don't get events, userland was given one
+	 * when the event got cancelled.
+	 */
+	if (kiocbIsCancelled(iocb))
+		goto put_rq;
+
 	ring = kmap_atomic(info->ring_pages[0], KM_IRQ1);
 
 	tail = info->tail;
@@ -703,6 +962,11 @@ int fastcall aio_complete(struct kiocb *
 
 	pr_debug("added to ring %p at [%lu]\n", iocb, tail);
 
+	pr_debug("%ld retries: %d of %d (kicked %ld, Q %ld run %ld wake %ld)\n",
+		iocb->ki_retried,
+		iocb->ki_nbytes - iocb->ki_left, iocb->ki_nbytes,
+		iocb->ki_kicked, iocb->ki_queued, aio_run, aio_wakeups);
+put_rq:
 	/* everything turned out well, dispose of the aiocb. */
 	ret = __aio_put_req(ctx, iocb);
 
@@ -809,6 +1073,7 @@ static int read_events(struct kioctx *ct
 	int			i = 0;
 	struct io_event		ent;
 	struct timeout		to;
+	int 			event_loop = 0; /* testing only */
 
 	/* needed to zero any padding within an entry (there shouldn't be 
 	 * any, but C is fun!
@@ -858,7 +1123,6 @@ static int read_events(struct kioctx *ct
 		add_wait_queue_exclusive(&ctx->wait, &wait);
 		do {
 			set_task_state(tsk, TASK_INTERRUPTIBLE);
-
 			ret = aio_read_evt(ctx, &ent);
 			if (ret)
 				break;
@@ -868,6 +1132,7 @@ static int read_events(struct kioctx *ct
 			if (to.timed_out)	/* Only check after read evt */
 				break;
 			schedule();
+			event_loop++;
 			if (signal_pending(tsk)) {
 				ret = -EINTR;
 				break;
@@ -895,6 +1160,9 @@ static int read_events(struct kioctx *ct
 	if (timeout)
 		clear_timeout(&to);
 out:
+	pr_debug("event loop executed %d times\n", event_loop);
+	pr_debug("aio_run %ld\n", aio_run);
+	pr_debug("aio_wakeups %ld\n", aio_wakeups);
 	return i ? i : ret;
 }
 
@@ -962,7 +1230,7 @@ asmlinkage long sys_io_setup(unsigned nr
 		ret = put_user(ioctx->user_id, ctxp);
 		if (!ret)
 			return 0;
-	 	get_ioctx(ioctx);
+
 		io_destroy(ioctx);
 	}
 
@@ -987,13 +1255,181 @@ asmlinkage long sys_io_destroy(aio_conte
 	return -EINVAL;
 }
 
+/*
+ * Default retry method for aio_read (also used for first time submit)
+ * Responsible for updating iocb state as retries progress
+ */
+static ssize_t aio_pread(struct kiocb *iocb)
+{
+	struct file *file = iocb->ki_filp;
+	struct address_space *mapping = file->f_mapping;
+	struct inode *inode = mapping->host;
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
+		/*
+		 * For pipes and sockets we return once we have
+		 * some data; for regular files we retry till we
+		 * complete the entire read or find that we can't
+		 * read any more data (e.g short reads).
+		 */
+		if (!S_ISFIFO(inode->i_mode) && !S_ISSOCK(inode->i_mode))
+			ret = -EIOCBRETRY;
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
+ * Default retry method for aio_write (also used for first time submit)
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
@@ -1034,58 +1470,31 @@ int fastcall io_submit_one(struct kioctx
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
-		ret = security_file_permission (file, MAY_READ);
-		if (ret)
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
-		ret = security_file_permission (file, MAY_WRITE);
-		if (ret)
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
+	if (ret)
+		goto out_put_req;
+
+	spin_lock_irq(&ctx->ctx_lock);
+	ret = aio_run_iocb(req);
+	spin_unlock_irq(&ctx->ctx_lock);
 
+	if (-EIOCBRETRY == ret)
+		queue_work(aio_wq, &ctx->wq);
 	aio_put_req(req);	/* drop extra ref to req */
-	if (likely(-EIOCBQUEUED == ret))
-		return 0;
-	aio_complete(req, ret, 0);	/* will drop i/o ref to req */
 	return 0;
 
 out_put_req:
@@ -1201,6 +1610,7 @@ asmlinkage long sys_io_cancel(aio_contex
 	if (kiocb && kiocb->ki_cancel) {
 		cancel = kiocb->ki_cancel;
 		kiocb->ki_users ++;
+		kiocbSetCancelled(kiocb);
 	} else
 		cancel = NULL;
 	spin_unlock_irq(&ctx->ctx_lock);
diff -puN include/linux/aio.h~aio-retry include/linux/aio.h
--- linux-2.6.8-rc3/include/linux/aio.h~aio-retry	2004-08-04 14:31:21.000000000 +0530
+++ linux-2.6.8-rc3-suparna/include/linux/aio.h	2004-08-04 14:31:21.000000000 +0530
@@ -52,7 +52,7 @@ struct kiocb {
 	struct file		*ki_filp;
 	struct kioctx		*ki_ctx;	/* may be NULL for sync ops */
 	int			(*ki_cancel)(struct kiocb *, struct io_event *);
-	long			(*ki_retry)(struct kiocb *);
+	ssize_t			(*ki_retry)(struct kiocb *);
 	void			(*ki_dtor)(struct kiocb *);
 
 	struct list_head	ki_list;	/* the aio core uses this
@@ -64,6 +64,16 @@ struct kiocb {
 	} ki_obj;
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
 	void			*private;
 };
 
@@ -79,6 +89,8 @@ struct kiocb {
 		(x)->ki_cancel = NULL;			\
 		(x)->ki_dtor = NULL;			\
 		(x)->ki_obj.tsk = tsk;			\
+		(x)->ki_user_data = 0;                  \
+		init_wait((&(x)->ki_wait));             \
 	} while (0)
 
 #define AIO_RING_MAGIC			0xa10a10a1
@@ -161,6 +173,17 @@ int FASTCALL(io_submit_one(struct kioctx
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
diff -puN include/linux/errno.h~aio-retry include/linux/errno.h
--- linux-2.6.8-rc3/include/linux/errno.h~aio-retry	2004-08-04 14:31:21.000000000 +0530
+++ linux-2.6.8-rc3-suparna/include/linux/errno.h	2004-08-04 14:31:21.000000000 +0530
@@ -22,6 +22,7 @@
 #define EBADTYPE	527	/* Type not supported by server */
 #define EJUKEBOX	528	/* Request initiated, but will not complete before timeout */
 #define EIOCBQUEUED	529	/* iocb queued, will get completion event */
+#define EIOCBRETRY	530	/* iocb queued, will trigger a retry */
 
 #endif
 
diff -puN include/linux/init_task.h~aio-retry include/linux/init_task.h
--- linux-2.6.8-rc3/include/linux/init_task.h~aio-retry	2004-08-04 14:31:21.000000000 +0530
+++ linux-2.6.8-rc3-suparna/include/linux/init_task.h	2004-08-04 14:31:21.000000000 +0530
@@ -112,6 +112,7 @@ extern struct group_info init_groups;
 	.proc_lock	= SPIN_LOCK_UNLOCKED,				\
 	.switch_lock	= SPIN_LOCK_UNLOCKED,				\
 	.journal_info	= NULL,						\
+	.io_wait	= NULL,						\
 }
 
 
diff -puN include/linux/sched.h~aio-retry include/linux/sched.h
--- linux-2.6.8-rc3/include/linux/sched.h~aio-retry	2004-08-04 14:31:21.000000000 +0530
+++ linux-2.6.8-rc3-suparna/include/linux/sched.h	2004-08-04 14:31:21.000000000 +0530
@@ -522,7 +522,13 @@ struct task_struct {
 
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
diff -puN include/linux/wait.h~aio-retry include/linux/wait.h
--- linux-2.6.8-rc3/include/linux/wait.h~aio-retry	2004-08-04 14:31:21.000000000 +0530
+++ linux-2.6.8-rc3-suparna/include/linux/wait.h	2004-08-04 14:31:21.000000000 +0530
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
diff -puN kernel/fork.c~aio-retry kernel/fork.c
--- linux-2.6.8-rc3/kernel/fork.c~aio-retry	2004-08-04 14:31:21.000000000 +0530
+++ linux-2.6.8-rc3-suparna/kernel/fork.c	2004-08-04 14:31:21.000000000 +0530
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

_
