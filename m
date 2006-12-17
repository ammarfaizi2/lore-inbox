Return-Path: <linux-kernel-owner+w=401wt.eu-S1753130AbWLQWek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753130AbWLQWek (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 17:34:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753131AbWLQWek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 17:34:40 -0500
Received: from mail.screens.ru ([213.234.233.54]:57725 "EHLO mail.screens.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753130AbWLQWej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 17:34:39 -0500
Date: Mon, 18 Dec 2006 01:34:16 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH, RFC] reimplement flush_workqueue()
Message-ID: <20061217223416.GA6872@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove ->remove_sequence, ->insert_sequence, and ->work_done from
struct cpu_workqueue_struct. To implement flush_workqueue() we can
queue a barrier work on each CPU and wait for its completition.

We don't need to worry about CPU going down while we are are sleeping
on the completition. take_over_work() will move this work on another
CPU, and the handler will wake up us eventually.

NOTE: I removed 'int cpu' parameter, flush_workqueue() locks/unlocks
workqueue_mutex unconditionally. It may be restored, but I think it
doesn't make much sense, we take the mutex for the very short time,
and the code becomes simpler.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

 workqueue.c |   87 ++++++++++++++++++++----------------------------------------
 1 files changed, 29 insertions(+), 58 deletions(-)

--- mm-6.20-rc1/kernel/workqueue.c~1_flush_q	2006-12-18 00:56:58.000000000 +0300
+++ mm-6.20-rc1/kernel/workqueue.c	2006-12-18 01:13:22.000000000 +0300
@@ -36,23 +36,13 @@
 /*
  * The per-CPU workqueue (if single thread, we always use the first
  * possible cpu).
- *
- * The sequence counters are for flush_scheduled_work().  It wants to wait
- * until all currently-scheduled works are completed, but it doesn't
- * want to be livelocked by new, incoming ones.  So it waits until
- * remove_sequence is >= the insert_sequence which pertained when
- * flush_scheduled_work() was called.
  */
 struct cpu_workqueue_struct {
 
 	spinlock_t lock;
 
-	long remove_sequence;	/* Least-recently added (next to run) */
-	long insert_sequence;	/* Next to add */
-
 	struct list_head worklist;
 	wait_queue_head_t more_work;
-	wait_queue_head_t work_done;
 
 	struct workqueue_struct *wq;
 	struct task_struct *thread;
@@ -138,8 +128,6 @@ static int __run_work(struct cpu_workque
 		f(work);
 
 		spin_lock_irqsave(&cwq->lock, flags);
-		cwq->remove_sequence++;
-		wake_up(&cwq->work_done);
 		ret = 1;
 	}
 	spin_unlock_irqrestore(&cwq->lock, flags);
@@ -187,7 +175,6 @@ static void __queue_work(struct cpu_work
 	spin_lock_irqsave(&cwq->lock, flags);
 	set_wq_data(work, cwq);
 	list_add_tail(&work->entry, &cwq->worklist);
-	cwq->insert_sequence++;
 	wake_up(&cwq->more_work);
 	spin_unlock_irqrestore(&cwq->lock, flags);
 }
@@ -338,8 +325,6 @@ static void run_workqueue(struct cpu_wor
 		}
 
 		spin_lock_irqsave(&cwq->lock, flags);
-		cwq->remove_sequence++;
-		wake_up(&cwq->work_done);
 	}
 	cwq->run_depth--;
 	spin_unlock_irqrestore(&cwq->lock, flags);
@@ -394,45 +379,39 @@ static int worker_thread(void *__cwq)
 	return 0;
 }
 
-/*
- * If cpu == -1 it's a single-threaded workqueue and the caller does not hold
- * workqueue_mutex
- */
-static void flush_cpu_workqueue(struct cpu_workqueue_struct *cwq, int cpu)
+struct wq_barrier {
+	struct work_struct	work;
+	struct completion	done;
+};
+
+static void wq_barrier_func(struct work_struct *work)
+{
+	struct wq_barrier *barr = container_of(work, struct wq_barrier, work);
+	complete(&barr->done);
+}
+
+static void flush_cpu_workqueue(struct cpu_workqueue_struct *cwq)
 {
 	if (cwq->thread == current) {
 		/*
 		 * Probably keventd trying to flush its own queue. So simply run
 		 * it by hand rather than deadlocking.
 		 */
-		if (cpu != -1)
-			mutex_unlock(&workqueue_mutex);
+		mutex_unlock(&workqueue_mutex);
 		run_workqueue(cwq);
-		if (cpu != -1)
-			mutex_lock(&workqueue_mutex);
+		mutex_lock(&workqueue_mutex);
 	} else {
-		DEFINE_WAIT(wait);
-		long sequence_needed;
+		struct wq_barrier barr = {
+			.work = __WORK_INITIALIZER(barr.work, wq_barrier_func),
+			.done = COMPLETION_INITIALIZER_ONSTACK(barr.done),
+		};
 
-		spin_lock_irq(&cwq->lock);
-		sequence_needed = cwq->insert_sequence;
+		__set_bit(WORK_STRUCT_PENDING, &barr.work.management);
+		__queue_work(cwq, &barr.work);
 
-		while (sequence_needed - cwq->remove_sequence > 0) {
-			prepare_to_wait(&cwq->work_done, &wait,
-					TASK_UNINTERRUPTIBLE);
-			spin_unlock_irq(&cwq->lock);
-			if (cpu != -1)
-				mutex_unlock(&workqueue_mutex);
-			schedule();
-			if (cpu != -1) {
-				mutex_lock(&workqueue_mutex);
-				if (!cpu_online(cpu))
-					return; /* oops, CPU unplugged */
-			}
-			spin_lock_irq(&cwq->lock);
-		}
-		finish_wait(&cwq->work_done, &wait);
-		spin_unlock_irq(&cwq->lock);
+		mutex_unlock(&workqueue_mutex);
+		wait_for_completion(&barr.done);
+		mutex_lock(&workqueue_mutex);
 	}
 }
 
@@ -443,30 +422,25 @@ static void flush_cpu_workqueue(struct c
  * Forces execution of the workqueue and blocks until its completion.
  * This is typically used in driver shutdown handlers.
  *
- * This function will sample each workqueue's current insert_sequence number and
- * will sleep until the head sequence is greater than or equal to that.  This
- * means that we sleep until all works which were queued on entry have been
- * handled, but we are not livelocked by new incoming ones.
+ * We sleep until all works which were queued on entry have been handled,
+ * but we are not livelocked by new incoming ones.
  *
  * This function used to run the workqueues itself.  Now we just wait for the
  * helper threads to do it.
  */
 void fastcall flush_workqueue(struct workqueue_struct *wq)
 {
-	might_sleep();
-
+	mutex_lock(&workqueue_mutex);
 	if (is_single_threaded(wq)) {
 		/* Always use first cpu's area. */
-		flush_cpu_workqueue(per_cpu_ptr(wq->cpu_wq, singlethread_cpu),
-					-1);
+		flush_cpu_workqueue(per_cpu_ptr(wq->cpu_wq, singlethread_cpu));
 	} else {
 		int cpu;
 
-		mutex_lock(&workqueue_mutex);
 		for_each_online_cpu(cpu)
-			flush_cpu_workqueue(per_cpu_ptr(wq->cpu_wq, cpu), cpu);
-		mutex_unlock(&workqueue_mutex);
+			flush_cpu_workqueue(per_cpu_ptr(wq->cpu_wq, cpu));
 	}
+	mutex_unlock(&workqueue_mutex);
 }
 EXPORT_SYMBOL_GPL(flush_workqueue);
 
@@ -479,12 +453,9 @@ static struct task_struct *create_workqu
 	spin_lock_init(&cwq->lock);
 	cwq->wq = wq;
 	cwq->thread = NULL;
-	cwq->insert_sequence = 0;
-	cwq->remove_sequence = 0;
 	cwq->freezeable = freezeable;
 	INIT_LIST_HEAD(&cwq->worklist);
 	init_waitqueue_head(&cwq->more_work);
-	init_waitqueue_head(&cwq->work_done);
 
 	if (is_single_threaded(wq))
 		p = kthread_create(worker_thread, cwq, "%s", wq->name);

