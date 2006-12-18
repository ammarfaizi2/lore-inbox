Return-Path: <linux-kernel-owner+w=401wt.eu-S1754529AbWLRURa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754529AbWLRURa (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 15:17:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754530AbWLRURa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 15:17:30 -0500
Received: from mail.screens.ru ([213.234.233.54]:40151 "EHLO mail.screens.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754529AbWLRUR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 15:17:29 -0500
Date: Mon, 18 Dec 2006 23:17:14 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH, RFC rc1-mm1] implement flush_work()
Message-ID: <20061218201714.GA501@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On top of "[PATCH, RFC] reimplement flush_workqueue()", see
	http://marc.theaimsgroup.com/?l=linux-kernel&m=116639510029010

Andrew Morton wrote:
>
> A basic problem with flush_scheduled_work() is that it blocks behind _all_
> presently-queued works, rather than just the work whcih the caller wants to
> flush.  If the caller holds some lock, and if one of the queued work happens
> to want that lock as well then accidental deadlocks can occur.
>
> One example of this is the phy layer: it wants to flush work while holding
> rtnl_lock().  But if a linkwatch event happens to be queued, the phy code will
> deadlock because the linkwatch callback function takes rtnl_lock.
>
> So we implement a new function which will flush a *single* work - just the one
> which the caller wants to free up.  Thus we avoid the accidental deadlocks
> which can arise from unrelated subsystems' callbacks taking shared locks.

Add ->current_work to the "struct cpu_workqueue_struct", it points to
currently running "struct queue_work". When flush_work(work) detects
->current_work == work, it inserts a barrier at the _head_ of ->worklist
(and thus right _after_ that work) and waits for completition. This means
that the next work fired on that CPU will be this barrier, or another
barrier queued by concurrent flush_work(), so the caller of flush_work()
will be woken before any "regular" work has a chance to run.

Since __queue_work() does both set_wq_data() and list_add_tail() atomically
under cwq->lock, flush_work() can remove the pending work from queue when
it sees "get_wq_data(work) == cwq".

NOTE: flush_work() doesn't like no-auto-release works. Unless they go away
we can fix this later or add the "don't do this" comment.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- mm-6.20-rc1/include/linux/workqueue.h~2_flush_w	2006-12-17 19:06:41.000000000 +0300
+++ mm-6.20-rc1/include/linux/workqueue.h	2006-12-18 22:14:02.000000000 +0300
@@ -160,6 +160,7 @@ extern int FASTCALL(queue_delayed_work(s
 extern int queue_delayed_work_on(int cpu, struct workqueue_struct *wq,
 	struct delayed_work *work, unsigned long delay);
 extern void FASTCALL(flush_workqueue(struct workqueue_struct *wq));
+extern void flush_work(struct workqueue_struct *wq, struct work_struct *work);
 
 extern int FASTCALL(schedule_work(struct work_struct *work));
 extern int FASTCALL(run_scheduled_work(struct work_struct *work));
@@ -180,7 +181,7 @@ int execute_in_process_context(work_func
 /*
  * Kill off a pending schedule_delayed_work().  Note that the work callback
  * function may still be running on return from cancel_delayed_work().  Run
- * flush_scheduled_work() to wait on it.
+ * flush_scheduled_work() or flush_work() to wait on it.
  */
 static inline int cancel_delayed_work(struct delayed_work *work)
 {
--- mm-6.20-rc1/kernel/workqueue.c~2_flush_w	2006-12-18 01:13:22.000000000 +0300
+++ mm-6.20-rc1/kernel/workqueue.c	2006-12-18 23:11:48.000000000 +0300
@@ -46,6 +46,7 @@ struct cpu_workqueue_struct {
 
 	struct workqueue_struct *wq;
 	struct task_struct *thread;
+	struct work_struct *current_work;
 
 	int run_depth;		/* Detect run_workqueue() recursion depth */
 
@@ -120,6 +121,7 @@ static int __run_work(struct cpu_workque
 	    && work_pending(work)
 	    && !list_empty(&work->entry)) {
 		work_func_t f = work->func;
+		cwq->current_work = work;
 		list_del_init(&work->entry);
 		spin_unlock_irqrestore(&cwq->lock, flags);
 
@@ -128,6 +130,7 @@ static int __run_work(struct cpu_workque
 		f(work);
 
 		spin_lock_irqsave(&cwq->lock, flags);
+		cwq->current_work = NULL;
 		ret = 1;
 	}
 	spin_unlock_irqrestore(&cwq->lock, flags);
@@ -166,6 +169,17 @@ int fastcall run_scheduled_work(struct w
 }
 EXPORT_SYMBOL(run_scheduled_work);
 
+static inline void insert_work(struct cpu_workqueue_struct *cwq,
+				struct work_struct *work, int tail)
+{
+	set_wq_data(work, cwq);
+	if (tail)
+		list_add_tail(&work->entry, &cwq->worklist);
+	else
+		list_add(&work->entry, &cwq->worklist);
+	wake_up(&cwq->more_work);
+}
+
 /* Preempt must be disabled. */
 static void __queue_work(struct cpu_workqueue_struct *cwq,
 			 struct work_struct *work)
@@ -173,9 +187,7 @@ static void __queue_work(struct cpu_work
 	unsigned long flags;
 
 	spin_lock_irqsave(&cwq->lock, flags);
-	set_wq_data(work, cwq);
-	list_add_tail(&work->entry, &cwq->worklist);
-	wake_up(&cwq->more_work);
+	insert_work(cwq, work, 1);
 	spin_unlock_irqrestore(&cwq->lock, flags);
 }
 
@@ -305,6 +317,7 @@ static void run_workqueue(struct cpu_wor
 						struct work_struct, entry);
 		work_func_t f = work->func;
 
+		cwq->current_work = work;
 		list_del_init(cwq->worklist.next);
 		spin_unlock_irqrestore(&cwq->lock, flags);
 
@@ -325,6 +338,7 @@ static void run_workqueue(struct cpu_wor
 		}
 
 		spin_lock_irqsave(&cwq->lock, flags);
+		cwq->current_work = NULL;
 	}
 	cwq->run_depth--;
 	spin_unlock_irqrestore(&cwq->lock, flags);
@@ -390,6 +404,14 @@ static void wq_barrier_func(struct work_
 	complete(&barr->done);
 }
 
+static inline void init_wq_barrier(struct wq_barrier *barr)
+{
+	INIT_WORK(&barr->work, wq_barrier_func);
+	init_completion(&barr->done);
+
+	__set_bit(WORK_STRUCT_PENDING, &barr->work.management);
+}
+
 static void flush_cpu_workqueue(struct cpu_workqueue_struct *cwq)
 {
 	if (cwq->thread == current) {
@@ -401,12 +423,9 @@ static void flush_cpu_workqueue(struct c
 		run_workqueue(cwq);
 		mutex_lock(&workqueue_mutex);
 	} else {
-		struct wq_barrier barr = {
-			.work = __WORK_INITIALIZER(barr.work, wq_barrier_func),
-			.done = COMPLETION_INITIALIZER_ONSTACK(barr.done),
-		};
+		struct wq_barrier barr;
 
-		__set_bit(WORK_STRUCT_PENDING, &barr.work.management);
+		init_wq_barrier(&barr);
 		__queue_work(cwq, &barr.work);
 
 		mutex_unlock(&workqueue_mutex);
@@ -444,6 +463,61 @@ void fastcall flush_workqueue(struct wor
 }
 EXPORT_SYMBOL_GPL(flush_workqueue);
 
+static void wait_on_work(struct cpu_workqueue_struct *cwq,
+				struct work_struct *work)
+{
+	struct wq_barrier barr;
+	int running = 0;
+
+	spin_lock_irq(&cwq->lock);
+	if (get_wq_data(work) == cwq) {
+		list_del_init(&work->entry);
+		work_release(work);
+	}
+	if (unlikely(cwq->current_work == work)) {
+		init_wq_barrier(&barr);
+		insert_work(cwq, &barr.work, 0);
+		running = 1;
+	}
+	spin_unlock_irq(&cwq->lock);
+
+	if (unlikely(running)) {
+		mutex_unlock(&workqueue_mutex);
+		wait_for_completion(&barr.done);
+		mutex_lock(&workqueue_mutex);
+	}
+}
+
+/**
+ * flush_work - block until a work_struct's callback has terminated
+ * @wq: the workqueue on which the work is queued
+ * @work: the work which is to be flushed
+ *
+ * flush_work() will attempt to cancel the work if it is queued.  If the work's
+ * callback appears to be running, flush_work() will block until it has
+ * completed.
+ *
+ * flush_work() is designed to be used when the caller is tearing down data
+ * structures which the callback function operates upon.  It is expected that,
+ * prior to calling flush_work(), the caller has arranged for the work to not
+ * be requeued.
+ */
+void flush_work(struct workqueue_struct *wq, struct work_struct *work)
+{
+	mutex_lock(&workqueue_mutex);
+	if (is_single_threaded(wq)) {
+		/* Always use first cpu's area. */
+		wait_on_work(per_cpu_ptr(wq->cpu_wq, singlethread_cpu), work);
+	} else {
+		int cpu;
+
+		for_each_online_cpu(cpu)
+			wait_on_work(per_cpu_ptr(wq->cpu_wq, cpu), work);
+	}
+	mutex_unlock(&workqueue_mutex);
+}
+EXPORT_SYMBOL_GPL(flush_work);
+
 static struct task_struct *create_workqueue_thread(struct workqueue_struct *wq,
 						   int cpu, int freezeable)
 {

