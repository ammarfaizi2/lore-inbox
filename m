Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263428AbTGOGNm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 02:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263407AbTGOGNm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 02:13:42 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:4814 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S263590AbTGOGNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 02:13:11 -0400
Date: Mon, 14 Jul 2003 23:28:00 -0700
From: Frank Cusack <fcusack@fcusack.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] [2/2] workqueue 2.5.74->2.4.21 backport
Message-ID: <20030714232800.B3449@google.com>
References: <20030714232434.A3449@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030714232434.A3449@google.com>; from fcusack@fcusack.com on Mon, Jul 14, 2003 at 11:24:34PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 14, 2003 at 11:24:34PM -0700, Frank Cusack wrote:
> Here is that backport with the glue added.  Next I will send a relative
> diff which incorporates updates as of 2.5.74.

And here is the diff which brings things up to 2.5.74.  It's a tad
inelegant in shed.c:__wake_up_common(), but from my perspective I wanted
to keep the existing code there as simple as possible, to ease future
(2.4.22+) porting.

Any comments/advice appreciated, thanks.
/fc

diff -uNrp linux-2.4.21-wq.51/include/linux/wait.h linux-2.4.21-wq.74/include/linux/wait.h
--- linux-2.4.21-wq.51/include/linux/wait.h	Tue Jul  8 01:45:04 2003
+++ linux-2.4.21-wq.74/include/linux/wait.h	Tue Jul  8 02:24:17 2003
@@ -28,17 +28,21 @@
 #define WAITQUEUE_DEBUG 0
 #endif
 
+typedef struct __wait_queue wait_queue_t;
+typedef int (*wait_queue_func_t)(wait_queue_t *wait, unsigned mode, int sync);
+extern int default_wake_function(wait_queue_t *wait, unsigned mode, int sync);
+
 struct __wait_queue {
 	unsigned int flags;
 #define WQ_FLAG_EXCLUSIVE	0x01
 	struct task_struct * task;
+	wait_queue_func_t func;
 	struct list_head task_list;
 #if WAITQUEUE_DEBUG
 	long __magic;
 	long __waker;
 #endif
 };
-typedef struct __wait_queue wait_queue_t;
 
 /*
  * 'dual' spinlock architecture. Can be switched between spinlock_t and
@@ -174,6 +178,7 @@ static inline void init_waitqueue_entry(
 #endif
 	q->flags = 0;
 	q->task = p;
+	q->func = NULL;
 #if WAITQUEUE_DEBUG
 	q->__magic = (long)&q->__magic;
 #endif
@@ -230,6 +235,25 @@ static inline void __remove_wait_queue(w
 #endif
 	list_del(&old->task_list);
 }
+
+/*
+ * Waitqueues which are removed from the waitqueue_head at wakeup time
+ */
+void FASTCALL(prepare_to_wait(wait_queue_head_t *q,
+				wait_queue_t *wait, int state));
+void FASTCALL(prepare_to_wait_exclusive(wait_queue_head_t *q,
+				wait_queue_t *wait, int state));
+void FASTCALL(finish_wait(wait_queue_head_t *q, wait_queue_t *wait));
+int autoremove_wake_function(wait_queue_t *wait, unsigned mode, int sync);
+
+#define DEFINE_WAIT(name)						\
+	wait_queue_t name = {						\
+		.task		= current,				\
+		.func		= autoremove_wake_function,		\
+		.task_list	= {	.next = &name.task_list,	\
+					.prev = &name.task_list,	\
+				},					\
+	}
 
 #endif /* __KERNEL__ */
 
diff -uNrp linux-2.4.21-wq.51/kernel/fork.c linux-2.4.21-wq.74/kernel/fork.c
--- linux-2.4.21-wq.51/kernel/fork.c	Tue Jul  8 01:45:04 2003
+++ linux-2.4.21-wq.74/kernel/fork.c	Tue Jul  8 02:24:28 2003
@@ -68,6 +68,52 @@ void remove_wait_queue(wait_queue_head_t
 	wq_write_unlock_irqrestore(&q->lock, flags);
 }
 
+void prepare_to_wait(wait_queue_head_t *q, wait_queue_t *wait, int state)
+{
+	unsigned long flags;
+
+	__set_current_state(state);
+	wait->flags &= ~WQ_FLAG_EXCLUSIVE;
+	spin_lock_irqsave(&q->lock, flags);
+	if (list_empty(&wait->task_list))
+		__add_wait_queue(q, wait);
+	spin_unlock_irqrestore(&q->lock, flags);
+}
+
+void
+prepare_to_wait_exclusive(wait_queue_head_t *q, wait_queue_t *wait, int state)
+{
+	unsigned long flags;
+
+	__set_current_state(state);
+	wait->flags |= WQ_FLAG_EXCLUSIVE;
+	spin_lock_irqsave(&q->lock, flags);
+	if (list_empty(&wait->task_list))
+		__add_wait_queue_tail(q, wait);
+	spin_unlock_irqrestore(&q->lock, flags);
+}
+
+void finish_wait(wait_queue_head_t *q, wait_queue_t *wait)
+{
+	unsigned long flags;
+
+	__set_current_state(TASK_RUNNING);
+	if (!list_empty(&wait->task_list)) {
+		spin_lock_irqsave(&q->lock, flags);
+		list_del_init(&wait->task_list);
+		spin_unlock_irqrestore(&q->lock, flags);
+	}
+}
+
+int autoremove_wake_function(wait_queue_t *wait, unsigned mode, int sync)
+{
+	int ret = default_wake_function(wait, mode, sync);
+
+	if (ret)
+		list_del_init(&wait->task_list);
+	return ret;
+}
+
 void __init fork_init(unsigned long mempages)
 {
 	/*
diff -uNrp linux-2.4.21-wq.51/kernel/ksyms.c linux-2.4.21-wq.74/kernel/ksyms.c
--- linux-2.4.21-wq.51/kernel/ksyms.c	Tue Jul  8 01:45:04 2003
+++ linux-2.4.21-wq.74/kernel/ksyms.c	Tue Jul  8 02:35:38 2003
@@ -378,6 +378,10 @@ EXPORT_SYMBOL(irq_stat);
 EXPORT_SYMBOL(add_wait_queue);
 EXPORT_SYMBOL(add_wait_queue_exclusive);
 EXPORT_SYMBOL(remove_wait_queue);
+EXPORT_SYMBOL(prepare_to_wait);
+EXPORT_SYMBOL(prepare_to_wait_exclusive);
+EXPORT_SYMBOL(finish_wait);
+EXPORT_SYMBOL(autoremove_wake_function);
 
 /* completion handling */
 EXPORT_SYMBOL(wait_for_completion);
@@ -444,6 +448,7 @@ EXPORT_SYMBOL(iomem_resource);
 
 /* process management */
 EXPORT_SYMBOL(complete_and_exit);
+EXPORT_SYMBOL(default_wake_function);
 EXPORT_SYMBOL(__wake_up);
 EXPORT_SYMBOL(__wake_up_sync);
 EXPORT_SYMBOL(wake_up_process);
diff -uNrp linux-2.4.21-wq.51/kernel/sched.c linux-2.4.21-wq.74/kernel/sched.c
--- linux-2.4.21-wq.51/kernel/sched.c	Tue Jul  8 01:45:04 2003
+++ linux-2.4.21-wq.74/kernel/sched.c	Tue Jul  8 02:24:43 2003
@@ -702,6 +702,12 @@ same_process:
 	return;
 }
 
+int default_wake_function(wait_queue_t *curr, unsigned mode, int sync)
+{
+	struct task_struct *p = curr->task;
+	return try_to_wake_up(p, sync);
+}
+
 /*
  * The core wakeup function.  Non-exclusive wakeups (nr_exclusive == 0) just wake everything
  * up.  If it's an exclusive wakeup (nr_exclusive == small +ve number) then we wake all the
@@ -714,22 +720,29 @@ same_process:
 static inline void __wake_up_common (wait_queue_head_t *q, unsigned int mode,
 			 	     int nr_exclusive, const int sync)
 {
-	struct list_head *tmp;
+	struct list_head *tmp, *next;
 	struct task_struct *p;
 
 	CHECK_MAGIC_WQHEAD(q);
 	WQ_CHECK_LIST_HEAD(&q->task_list);
 	
-	list_for_each(tmp,&q->task_list) {
+	list_for_each_safe(tmp, next, &q->task_list) {
 		unsigned int state;
+		unsigned flags;
                 wait_queue_t *curr = list_entry(tmp, wait_queue_t, task_list);
 
 		CHECK_MAGIC(curr->__magic);
+		flags = curr->flags;
 		p = curr->task;
 		state = p->state;
 		if (state & mode) {
+			int r;
 			WQ_NOTE_WAKER(curr);
-			if (try_to_wake_up(p, sync) && (curr->flags&WQ_FLAG_EXCLUSIVE) && !--nr_exclusive)
+			if (curr->func)
+				r = curr->func(curr, mode, sync);
+			else
+				r = try_to_wake_up(p, sync);
+			if (r && (flags&WQ_FLAG_EXCLUSIVE) && !--nr_exclusive)
 				break;
 		}
 	}
diff -uNrp linux-2.4.21-wq.51/kernel/workqueue.c linux-2.4.21-wq.74/kernel/workqueue.c
--- linux-2.4.21-wq.51/kernel/workqueue.c	Tue Jul  8 01:50:31 2003
+++ linux-2.4.21-wq.74/kernel/workqueue.c	Tue Jul  8 02:24:49 2003
@@ -27,13 +27,21 @@
 #include <linux/slab.h>
 
 /*
- * The per-CPU workqueue:
+ * The per-CPU workqueue.
+ *
+ * The sequence counters are for flush_scheduled_work().  It wants to wait
+ * until until all currently-scheduled works are completed, but it doesn't
+ * want to be livelocked by new, incoming ones.  So it waits until
+ * remove_sequence is >= the insert_sequence which pertained when
+ * flush_scheduled_work() was called.
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
@@ -71,10 +79,9 @@ int queue_work(struct workqueue_struct *
 
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
 	return ret;
@@ -92,11 +99,13 @@ static void delayed_work_timer_fn(unsign
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
 	int ret = 0, cpu = smp_processor_id();
 	struct timer_list *timer = &work->timer;
@@ -106,18 +115,11 @@ int queue_delayed_work(struct workqueue_
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
 	return ret;
@@ -133,7 +135,8 @@ static inline void run_workqueue(struct 
 	 */
 	spin_lock_irqsave(&cwq->lock, flags);
 	while (!list_empty(&cwq->worklist)) {
-		struct work_struct *work = list_entry(cwq->worklist.next, struct work_struct, entry);
+		struct work_struct *work = list_entry(cwq->worklist.next,
+						struct work_struct, entry);
 		void (*f) (void *) = work->func;
 		void *data = work->data;
 
@@ -144,14 +147,9 @@ static inline void run_workqueue(struct 
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
@@ -227,8 +225,13 @@ static int worker_thread(void *__startup
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
@@ -236,40 +239,63 @@ void flush_workqueue(struct workqueue_st
 	int cpu;
 
 	for (cpu = 0; cpu < NR_CPUS; cpu++) {
+		DEFINE_WAIT(wait);
+		long sequence_needed;
+
 		if (!cpu_online(cpu))
 			continue;
 		cwq = wq->cpu_wq + cpu_logical_map(cpu);
 
-		if (atomic_read(&cwq->nr_queued)) {
-			DECLARE_WAITQUEUE(wait, current);
-
-			if (!list_empty(&cwq->worklist))
-				run_workqueue(cwq);
+		spin_lock_irq(&cwq->lock);
+		sequence_needed = cwq->insert_sequence;
 
-			/*
-			 * Wait for helper thread(s) to finish up
-			 * the queue:
-			 */
-			set_task_state(current, TASK_INTERRUPTIBLE);
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
 
-struct workqueue_struct *create_workqueue(const char *name)
+static int create_workqueue_thread(struct workqueue_struct *wq,
+				   const char *name,
+				   int cpu)
 {
-	int ret, cpu, destroy = 0;
-	struct cpu_workqueue_struct *cwq;
 	startup_t startup;
+	struct cpu_workqueue_struct *cwq = wq->cpu_wq + cpu_logical_map(cpu);
+	int ret;
+
+	spin_lock_init(&cwq->lock);
+	cwq->wq = wq;
+	cwq->thread = NULL;
+	cwq->insert_sequence = 0;
+	cwq->remove_sequence = 0;
+	INIT_LIST_HEAD(&cwq->worklist);
+	init_waitqueue_head(&cwq->more_work);
+	init_waitqueue_head(&cwq->work_done);
+	init_completion(&cwq->exit);
+
+	init_completion(&startup.done);
+	startup.cwq = cwq;
+	startup.name = name;
+	ret = kernel_thread(worker_thread, &startup, CLONE_FS | CLONE_FILES);
+	if (ret >= 0) {
+		wait_for_completion(&startup.done);
+		BUG_ON(!cwq->thread);
+	}
+	return ret;
+}
+
+struct workqueue_struct *create_workqueue(const char *name)
+{
+	int cpu, destroy = 0;
 	struct workqueue_struct *wq;
 
 	BUG_ON(strlen(name) > 10);
-	startup.name = name;
 
 	wq = kmalloc(sizeof(*wq), GFP_KERNEL);
 	if (!wq)
@@ -278,26 +304,8 @@ struct workqueue_struct *create_workqueu
 	for (cpu = 0; cpu < NR_CPUS; cpu++) {
 		if (!cpu_online(cpu))
 			continue;
-		cwq = wq->cpu_wq + cpu_logical_map(cpu);
-
-		spin_lock_init(&cwq->lock);
-		cwq->wq = wq;
-		cwq->thread = NULL;
-		atomic_set(&cwq->nr_queued, 0);
-		INIT_LIST_HEAD(&cwq->worklist);
-		init_waitqueue_head(&cwq->more_work);
-		init_waitqueue_head(&cwq->work_done);
-
-		init_completion(&startup.done);
-		startup.cwq = cwq;
-		ret = kernel_thread(worker_thread, &startup,
-						CLONE_FS | CLONE_FILES);
-		if (ret < 0)
+		if (create_workqueue_thread(wq, name, cpu) < 0)
 			destroy = 1;
-		else {
-			wait_for_completion(&startup.done);
-			BUG_ON(!cwq->thread);
-		}
 	}
 	/*
 	 * Was there any error during startup? If yes then clean up:
@@ -309,27 +317,29 @@ struct workqueue_struct *create_workqueu
 	return wq;
 }
 
-void destroy_workqueue(struct workqueue_struct *wq)
+static void cleanup_workqueue_thread(struct workqueue_struct *wq, int cpu)
 {
 	struct cpu_workqueue_struct *cwq;
-	int cpu;
 
-	flush_workqueue(wq);
-
-	for (cpu = 0; cpu < NR_CPUS; cpu++) {
-		if (!cpu_online(cpu))
-			continue;
-		cwq = wq->cpu_wq + cpu_logical_map(cpu);
-		if (!cwq->thread)
-			continue;
-		/*
-		 * Initiate an exit and wait for it:
-		 */
-		init_completion(&cwq->exit);
+	cwq = wq->cpu_wq + cpu_logical_map(cpu);
+	if (cwq->thread) {
+		/* Tell thread to exit and wait for it. */
 		cwq->thread = NULL;
 		wake_up(&cwq->more_work);
 
 		wait_for_completion(&cwq->exit);
+	}
+}
+
+void destroy_workqueue(struct workqueue_struct *wq)
+{
+	int cpu;
+
+	flush_workqueue(wq);
+
+	for (cpu = 0; cpu < NR_CPUS; cpu++) {
+		if (cpu_online(cpu))
+			cleanup_workqueue_thread(wq, cpu);
 	}
 	kfree(wq);
 }
