Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265065AbTCEJLF>; Wed, 5 Mar 2003 04:11:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265174AbTCEJLF>; Wed, 5 Mar 2003 04:11:05 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:31726 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265065AbTCEJKz>;
	Wed, 5 Mar 2003 04:10:55 -0500
Date: Wed, 5 Mar 2003 14:56:33 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: bcrl@redhat.com, akpm@digeo.com
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch 1/2] Retry based aio read - core aio changes
Message-ID: <20030305145633.A1627@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20030305144754.A1600@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030305144754.A1600@in.ibm.com>; from suparna@in.ibm.com on Wed, Mar 05, 2003 at 02:47:54PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 05, 2003 at 02:47:54PM +0530, Suparna Bhattacharya wrote:
> For the last few days I've been playing with prototyping 
> a particular flavour of a retry based implementation for 
> filesystem aio read.

 
# aioretry.patch : Core aio infrastructure modifications
		   for high-level retry based aio

Includes couple of fixes in the aio code
-The kiocbClearXXX were doing a set_bit instead of 
 clear_bit
-Sync iocbs were not woken up when iocb->ki_users = 1
 (dio takes a different path for sync and async iocbs,
 so maybe that's why we weren't seeing the problem yet)

Regards
Suparna

----------------------------------------------------

diff -ur linux-2.5.62/fs/aio.c linux-2.5.62-aio/fs/aio.c
--- linux-2.5.62/fs/aio.c	Tue Feb 18 04:26:14 2003
+++ linux-2.5.62-aio/fs/aio.c	Tue Mar  4 19:54:24 2003
@@ -314,14 +314,15 @@
  */
 ssize_t wait_on_sync_kiocb(struct kiocb *iocb)
 {
-	while (iocb->ki_users) {
+	printk("wait_on_sync_iocb\n");
+	while ((iocb->ki_users) && !kiocbIsKicked(iocb)) {
 		set_current_state(TASK_UNINTERRUPTIBLE);
-		if (!iocb->ki_users)
+		if (!iocb->ki_users || kiocbIsKicked(iocb))
 			break;
 		schedule();
 	}
 	__set_current_state(TASK_RUNNING);
-	return iocb->ki_user_data;
+	return iocb->ki_users ? -EIOCBQUEUED : iocb->ki_user_data;
 }
 
 /* exit_aio: called when the last user of mm goes away.  At this point, 
@@ -395,6 +396,7 @@
 	req->ki_cancel = NULL;
 	req->ki_retry = NULL;
 	req->ki_user_obj = NULL;
+	INIT_LIST_HEAD(&req->ki_run_list);
 
 	/* Check if the completion queue has enough free space to
 	 * accept an event from this io.
@@ -558,15 +560,20 @@
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
 
+static void aio_run_iocbs(struct kioctx *ctx)
+{
 	spin_lock_irq(&ctx->ctx_lock);
 	while (!list_empty(&ctx->run_list)) {
 		struct kiocb *iocb;
@@ -574,30 +581,67 @@
 
 		iocb = list_entry(ctx->run_list.next, struct kiocb,
 				  ki_run_list);
-		list_del(&iocb->ki_run_list);
+		list_del_init(&iocb->ki_run_list);
 		iocb->ki_users ++;
-		spin_unlock_irq(&ctx->ctx_lock);
 
-		kiocbClearKicked(iocb);
-		ret = iocb->ki_retry(iocb);
-		if (-EIOCBQUEUED != ret) {
-			aio_complete(iocb, ret, 0);
-			iocb = NULL;
+		if (!kiocbTryStart(iocb)) {
+			kiocbClearKicked(iocb);
+			spin_unlock_irq(&ctx->ctx_lock);
+			ret = iocb->ki_retry(iocb);
+			if (-EIOCBQUEUED != ret) {
+				if (list_empty(&iocb->ki_wait.task_list))
+					aio_complete(iocb, ret, 0);
+				else
+					printk("can't delete iocb in use\n");
+			}
+			spin_lock_irq(&ctx->ctx_lock);
+			kiocbClearStarted(iocb);
+			if (kiocbIsKicked(iocb))
+				__queue_kicked_iocb(iocb);
+		} else {
+			printk("iocb already started\n");
 		}
-
-		spin_lock_irq(&ctx->ctx_lock);
 		if (NULL != iocb)
 			__aio_put_req(ctx, iocb);
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
+
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
+
+void kick_iocb(struct kiocb *iocb)
+{
 	/* sync iocbs are easy: they can only ever be executing from a 
 	 * single context. */
 	if (is_sync_kiocb(iocb)) {
@@ -606,12 +650,11 @@
 		return;
 	}
 
-	if (!kiocbTryKick(iocb)) {
-		unsigned long flags;
-		spin_lock_irqsave(&ctx->ctx_lock, flags);
-		list_add_tail(&iocb->ki_run_list, &ctx->run_list);
-		spin_unlock_irqrestore(&ctx->ctx_lock, flags);
-		schedule_work(&ctx->wq);
+
+	if (!kiocbTryKick(iocb) && !kiocbIsStarted(iocb)) {
+		queue_kicked_iocb(iocb);
+	} else {
+		pr_debug("iocb already kicked or in progress\n");
 	}
 }
 
@@ -642,13 +685,13 @@
 		iocb->ki_user_data = res;
 		if (iocb->ki_users == 1) {
 			iocb->ki_users = 0;
-			return 1;
+			ret = 1;
+		} else {
+			spin_lock_irq(&ctx->ctx_lock);
+			iocb->ki_users--;
+			ret = (0 == iocb->ki_users);
+			spin_unlock_irq(&ctx->ctx_lock);
 		}
-		spin_lock_irq(&ctx->ctx_lock);
-		iocb->ki_users--;
-		ret = (0 == iocb->ki_users);
-		spin_unlock_irq(&ctx->ctx_lock);
-
 		/* sync iocbs put the task here for us */
 		wake_up_process(iocb->ki_user_obj);
 		return ret;
@@ -664,6 +707,9 @@
 	 */
 	spin_lock_irqsave(&ctx->ctx_lock, flags);
 
+	if (!list_empty(&iocb->ki_run_list))
+		list_del_init(&iocb->ki_run_list);
+
 	ring = kmap_atomic(info->ring_pages[0], KM_IRQ1);
 
 	tail = info->tail;
@@ -865,6 +911,8 @@
 			ret = 0;
 			if (to.timed_out)	/* Only check after read evt */
 				break;
+			/* accelerate kicked iocbs for this ctx */	
+			aio_run_iocbs(ctx);
 			schedule();
 			if (signal_pending(tsk)) {
 				ret = -EINTR;
@@ -984,6 +1032,114 @@
 	return -EINVAL;
 }
 
+/* Called during initial submission and subsequent retry operations */
+long aio_process_iocb(struct kiocb *iocb)
+{
+	struct file *file = iocb->ki_filp;
+	ssize_t ret = 0;
+	
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
+	BUG_ON(current->iocb != NULL);
+			
+	current->iocb = iocb;
+
+	switch (iocb->ki_opcode) {
+	case IOCB_CMD_PREAD:
+		ret = -EBADF;
+		if (unlikely(!(file->f_mode & FMODE_READ)))
+			goto out;
+		ret = -EFAULT;
+		if (unlikely(!access_ok(VERIFY_WRITE, iocb->ki_buf, 
+			iocb->ki_left)))
+			goto out;
+		ret = -EINVAL;
+		if (file->f_op->aio_read)
+			ret = file->f_op->aio_read(iocb, iocb->ki_buf,
+				iocb->ki_left, iocb->ki_pos);
+		break;
+	case IOCB_CMD_PWRITE:
+		ret = -EBADF;
+		if (unlikely(!(file->f_mode & FMODE_WRITE)))
+			goto out;
+		ret = -EFAULT;
+		if (unlikely(!access_ok(VERIFY_READ, iocb->ki_buf, 
+			iocb->ki_left)))
+			goto out;
+		ret = -EINVAL;
+		if (file->f_op->aio_write)
+			ret = file->f_op->aio_write(iocb, iocb->ki_buf,
+				iocb->ki_left, iocb->ki_pos);
+		break;
+	case IOCB_CMD_FDSYNC:
+		ret = -EINVAL;
+		if (file->f_op->aio_fsync)
+			ret = file->f_op->aio_fsync(iocb, 1);
+		break;
+	case IOCB_CMD_FSYNC:
+		ret = -EINVAL;
+		if (file->f_op->aio_fsync)
+			ret = file->f_op->aio_fsync(iocb, 0);
+		break;
+	default:
+		dprintk("EINVAL: io_submit: no operation provided\n");
+		ret = -EINVAL;
+	}
+
+	pr_debug("aio_process_iocb: fop ret %d\n", ret);
+	if (likely(-EIOCBQUEUED == ret)) {
+		blk_run_queues();
+		goto out;
+	}
+	if (ret > 0) {
+		iocb->ki_buf += ret;
+		iocb->ki_left -= ret;
+
+		/* Not done yet or a short read, or.. */
+		if (iocb->ki_left 
+		/* may have copied out data but not completed writing */
+			|| ((iocb->ki_left == 0) &&
+			(iocb->ki_opcode = IOCB_CMD_PWRITE)) ){
+			/* FIXME:Can we find a better way to handle this ? */
+			/* Force an extra retry to determine if we're done */
+			ret = -EIOCBQUEUED;
+			goto out;
+		}
+		
+	}
+
+	if (ret >= 0) 
+		ret = iocb->ki_nbytes - iocb->ki_left;
+
+out:
+	pr_debug("ki_pos = %llu\n", iocb->ki_pos);
+	current->iocb = NULL;
+	if ((-EIOCBQUEUED == ret) && list_empty(&iocb->ki_wait.task_list)) {
+		kiocbSetKicked(iocb);
+	}
+
+	return ret;
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
@@ -991,8 +1147,7 @@
 {
 	struct kiocb *req;
 	struct file *file;
-	ssize_t ret;
-	char *buf;
+	long ret;
 
 	/* enforce forwards compatibility on users */
 	if (unlikely(iocb->aio_reserved1 || iocb->aio_reserved2 ||
@@ -1033,50 +1188,34 @@
 	req->ki_user_data = iocb->aio_data;
 	req->ki_pos = iocb->aio_offset;
 
-	buf = (char *)(unsigned long)iocb->aio_buf;
+	req->ki_buf = (char *)(unsigned long)iocb->aio_buf;
+	req->ki_left = req->ki_nbytes = iocb->aio_nbytes;
+	req->ki_opcode = iocb->aio_lio_opcode;
+	req->ki_retry = aio_process_iocb;
+	init_waitqueue_func_entry(&req->ki_wait, aio_wake_function);
+	INIT_LIST_HEAD(&req->ki_wait.task_list);
+	req->ki_retried = 0;
+	kiocbSetStarted(req);
 
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
+	ret = aio_process_iocb(req);
+
+	if (likely(-EIOCBQUEUED == ret)) {
+		int run = 0;
+
+		spin_lock_irq(&ctx->ctx_lock);
+		kiocbClearStarted(req);
+		if (kiocbIsKicked(req))
+			run =__queue_kicked_iocb(req);
+		spin_unlock_irq(&ctx->ctx_lock);
+		if (run)
+			queue_work(aio_wq, &ctx->wq);
 
-	if (likely(-EIOCBQUEUED == ret))
 		return 0;
+	}
+
+	if ((-EBADF == ret) || (-EFAULT == ret))
+		goto out_put_req;
+
 	aio_complete(req, ret, 0);
 	return 0;
 
diff -ur linux-2.5.62/include/linux/aio.h linux-2.5.62-aio/include/linux/aio.h
--- linux-2.5.62/include/linux/aio.h	Tue Feb 18 04:25:50 2003
+++ linux-2.5.62-aio/include/linux/aio.h	Mon Mar  3 12:17:12 2003
@@ -29,21 +29,26 @@
 #define KIF_LOCKED		0
 #define KIF_KICKED		1
 #define KIF_CANCELLED		2
+#define KIF_STARTED		3
 
 #define kiocbTryLock(iocb)	test_and_set_bit(KIF_LOCKED, &(iocb)->ki_flags)
 #define kiocbTryKick(iocb)	test_and_set_bit(KIF_KICKED, &(iocb)->ki_flags)
+#define kiocbTryStart(iocb)	test_and_set_bit(KIF_STARTED, &(iocb)->ki_flags)
 
 #define kiocbSetLocked(iocb)	set_bit(KIF_LOCKED, &(iocb)->ki_flags)
 #define kiocbSetKicked(iocb)	set_bit(KIF_KICKED, &(iocb)->ki_flags)
 #define kiocbSetCancelled(iocb)	set_bit(KIF_CANCELLED, &(iocb)->ki_flags)
+#define kiocbSetStarted(iocb)	set_bit(KIF_STARTED, &(iocb)->ki_flags)
 
-#define kiocbClearLocked(iocb)	set_bit(KIF_LOCKED, &(iocb)->ki_flags)
-#define kiocbClearKicked(iocb)	set_bit(KIF_KICKED, &(iocb)->ki_flags)
-#define kiocbClearCancelled(iocb)	set_bit(KIF_CANCELLED, &(iocb)->ki_flags)
+#define kiocbClearLocked(iocb)	clear_bit(KIF_LOCKED, &(iocb)->ki_flags)
+#define kiocbClearKicked(iocb)	clear_bit(KIF_KICKED, &(iocb)->ki_flags)
+#define kiocbClearCancelled(iocb)	clear_bit(KIF_CANCELLED, &(iocb)->ki_flags)
+#define kiocbClearStarted(iocb)	clear_bit(KIF_STARTED, &(iocb)->ki_flags)
 
 #define kiocbIsLocked(iocb)	test_bit(0, &(iocb)->ki_flags)
 #define kiocbIsKicked(iocb)	test_bit(1, &(iocb)->ki_flags)
 #define kiocbIsCancelled(iocb)	test_bit(2, &(iocb)->ki_flags)
+#define kiocbIsStarted(iocb)	test_bit(3, &(iocb)->ki_flags)
 
 struct kiocb {
 	struct list_head	ki_run_list;
@@ -62,6 +67,14 @@
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
@@ -77,6 +90,8 @@
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
@@ -128,6 +128,10 @@
 	spin_lock_irqsave(&q->lock, flags);
 	if (list_empty(&wait->task_list))
 		__add_wait_queue(q, wait);
+	else {
+		if (current->iocb && (wait == &current->iocb->ki_wait))
+			printk("prepare_to_wait: iocb->ki_wait in use\n");
+	}
 	spin_unlock_irqrestore(&q->lock, flags);
 }
 
@@ -834,6 +838,7 @@
 	p->lock_depth = -1;		/* -1 = no lock */
 	p->start_time = get_jiffies_64();
 	p->security = NULL;
+	p->iocb = NULL;
 
 	retval = -ENOMEM;
 	if (security_task_alloc(p))
