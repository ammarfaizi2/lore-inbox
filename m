Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262704AbTDIEA0 (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 00:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262706AbTDIEA0 (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 00:00:26 -0400
Received: from [12.47.58.221] ([12.47.58.221]:32012 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262704AbTDIEAW (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 00:00:22 -0400
Date: Tue, 8 Apr 2003 21:12:16 -0700
From: Andrew Morton <akpm@digeo.com>
To: "Shawn Starr" <spstarr@sh0n.net>
Cc: roland@topspin.com, rml@tech9.net, rmk@arm.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [BUG][2.5.66bk9+] - tty hangings - patches, dmesg & sysctl+T
 info
Message-Id: <20030408211216.71022d84.akpm@digeo.com>
In-Reply-To: <003001c2fe3d$6eab1080$030aa8c0@unknown>
References: <20030406133827.34bfbf93.akpm@digeo.com>
	<003001c2fe3d$6eab1080$030aa8c0@unknown>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Apr 2003 04:11:54.0362 (UTC) FILETIME=[27835DA0:01C2FE4E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Shawn Starr" <spstarr@sh0n.net> wrote:
>
> login         D C7250C94 4191040372   115      1           116   113 (L-TLB)
> Call Trace:
>  [<c01394a5>] flush_workqueue+0x305/0x450
>  [<c011de30>] default_wake_function+0x0/0x20
>  [<c011de30>] default_wake_function+0x0/0x20
>  [<c0257a44>] release_dev+0x6a4/0x860
>  [<c010cd75>] do_IRQ+0x235/0x370
>  [<c0258204>] tty_release+0x94/0x1b0
>  [<c016dd7c>] __fput+0xac/0x100
>  [<c0258170>] tty_release+0x0/0x1b0
>  [<c016ddcb>] __fput+0xfb/0x100

Well it does look like you've hit the flush_workqueue livelock.

Can you run with this (rather hastily tested) patch?


 kernel/workqueue.c |   80 ++++++++++++++++++++++++++---------------------------
 1 files changed, 40 insertions(+), 40 deletions(-)

diff -puN kernel/workqueue.c~flush_workqueue-hang-fix kernel/workqueue.c
--- 25/kernel/workqueue.c~flush_workqueue-hang-fix	2003-04-08 20:23:22.000000000 -0700
+++ 25-akpm/kernel/workqueue.c	2003-04-08 21:02:10.000000000 -0700
@@ -27,13 +27,20 @@
 #include <linux/slab.h>
 
 /*
- * The per-CPU workqueue:
+ * The per-CPU workqueue.
+ *
+ * The sequnece counters are for flush_scheduled_work().  It wants to wait
+ * until until all currently-scheduled works are completed, but it doesn't
+ * want to be livelocked by new, incoming ones.  So it waits until
+ * remove_sequence is >= the initial insert_sequence
  */
 struct cpu_workqueue_struct {
 
 	spinlock_t lock;
 
-	atomic_t nr_queued;
+	long remove_sequence;	/* Least-recently added (next to run) */
+	long insert_sequence;	/* Next to add */
+
 	struct list_head worklist;
 	wait_queue_head_t more_work;
 	wait_queue_head_t work_done;
@@ -71,10 +78,9 @@ int queue_work(struct workqueue_struct *
 
 		spin_lock_irqsave(&cwq->lock, flags);
 		list_add_tail(&work->entry, &cwq->worklist);
-		atomic_inc(&cwq->nr_queued);
-		spin_unlock_irqrestore(&cwq->lock, flags);
-
+		cwq->insert_sequence++;
 		wake_up(&cwq->more_work);
+		spin_unlock_irqrestore(&cwq->lock, flags);
 		ret = 1;
 	}
 	put_cpu();
@@ -93,11 +99,13 @@ static void delayed_work_timer_fn(unsign
 	 */
 	spin_lock_irqsave(&cwq->lock, flags);
 	list_add_tail(&work->entry, &cwq->worklist);
+	cwq->insert_sequence++;
 	wake_up(&cwq->more_work);
 	spin_unlock_irqrestore(&cwq->lock, flags);
 }
 
-int queue_delayed_work(struct workqueue_struct *wq, struct work_struct *work, unsigned long delay)
+int queue_delayed_work(struct workqueue_struct *wq,
+			struct work_struct *work, unsigned long delay)
 {
 	int ret = 0, cpu = get_cpu();
 	struct timer_list *timer = &work->timer;
@@ -107,18 +115,11 @@ int queue_delayed_work(struct workqueue_
 		BUG_ON(timer_pending(timer));
 		BUG_ON(!list_empty(&work->entry));
 
-		/*
-		 * Increase nr_queued so that the flush function
-		 * knows that there's something pending.
-		 */
-		atomic_inc(&cwq->nr_queued);
 		work->wq_data = cwq;
-
 		timer->expires = jiffies + delay;
 		timer->data = (unsigned long)work;
 		timer->function = delayed_work_timer_fn;
 		add_timer(timer);
-
 		ret = 1;
 	}
 	put_cpu();
@@ -135,7 +136,8 @@ static inline void run_workqueue(struct 
 	 */
 	spin_lock_irqsave(&cwq->lock, flags);
 	while (!list_empty(&cwq->worklist)) {
-		struct work_struct *work = list_entry(cwq->worklist.next, struct work_struct, entry);
+		struct work_struct *work = list_entry(cwq->worklist.next,
+						struct work_struct, entry);
 		void (*f) (void *) = work->func;
 		void *data = work->data;
 
@@ -146,14 +148,9 @@ static inline void run_workqueue(struct 
 		clear_bit(0, &work->pending);
 		f(data);
 
-		/*
-		 * We only wake up 'work done' waiters (flush) when
-		 * the last function has been fully processed.
-		 */
-		if (atomic_dec_and_test(&cwq->nr_queued))
-			wake_up(&cwq->work_done);
-
 		spin_lock_irqsave(&cwq->lock, flags);
+		cwq->remove_sequence++;
+		wake_up(&cwq->work_done);
 	}
 	spin_unlock_irqrestore(&cwq->lock, flags);
 }
@@ -223,8 +220,13 @@ static int worker_thread(void *__startup
  * Forces execution of the workqueue and blocks until its completion.
  * This is typically used in driver shutdown handlers.
  *
- * NOTE: if work is being added to the queue constantly by some other
- * context then this function might block indefinitely.
+ * This function will sample each workqueue's current insert_sequence number and
+ * will sleep until the head sequence is greater than or equal to that.  This
+ * means that we sleep until all works which were queued on entry have been
+ * handled, but we are not livelocked by new incoming ones.
+ *
+ * This function used to run the workqueues itself.  Now we just wait for the
+ * helper threads to do it.
  */
 void flush_workqueue(struct workqueue_struct *wq)
 {
@@ -234,28 +236,25 @@ void flush_workqueue(struct workqueue_st
 	might_sleep();
 
 	for (cpu = 0; cpu < NR_CPUS; cpu++) {
+		DEFINE_WAIT(wait);
+		long sequence_needed;
+
 		if (!cpu_online(cpu))
 			continue;
 		cwq = wq->cpu_wq + cpu;
 
-		if (atomic_read(&cwq->nr_queued)) {
-			DECLARE_WAITQUEUE(wait, current);
+		spin_lock_irq(&cwq->lock);
+		sequence_needed = cwq->insert_sequence;
 
-			if (!list_empty(&cwq->worklist))
-				run_workqueue(cwq);
-
-			/*
-			 * Wait for helper thread(s) to finish up
-			 * the queue:
-			 */
-			set_current_state(TASK_UNINTERRUPTIBLE);
-			add_wait_queue(&cwq->work_done, &wait);
-			if (atomic_read(&cwq->nr_queued))
-				schedule();
-			else
-				set_task_state(current, TASK_RUNNING);
-			remove_wait_queue(&cwq->work_done, &wait);
+		while (sequence_needed - cwq->remove_sequence > 0) {
+			prepare_to_wait(&cwq->work_done, &wait,
+					TASK_UNINTERRUPTIBLE);
+			spin_unlock_irq(&cwq->lock);
+			schedule();
+			spin_lock_irq(&cwq->lock);
 		}
+		finish_wait(&cwq->work_done, &wait);
+		spin_unlock_irq(&cwq->lock);
 	}
 }
 
@@ -281,7 +280,8 @@ struct workqueue_struct *create_workqueu
 		spin_lock_init(&cwq->lock);
 		cwq->wq = wq;
 		cwq->thread = NULL;
-		atomic_set(&cwq->nr_queued, 0);
+		cwq->insert_sequence = 0;
+		cwq->remove_sequence = 0;
 		INIT_LIST_HEAD(&cwq->worklist);
 		init_waitqueue_head(&cwq->more_work);
 		init_waitqueue_head(&cwq->work_done);

_

