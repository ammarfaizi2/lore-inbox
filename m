Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129810AbQL0MLK>; Wed, 27 Dec 2000 07:11:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129931AbQL0MLA>; Wed, 27 Dec 2000 07:11:00 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:58793 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129810AbQL0MKy>; Wed, 27 Dec 2000 07:10:54 -0500
Message-ID: <3A49D659.843821FE@uow.edu.au>
Date: Wed, 27 Dec 2000 22:45:29 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [prepatch] 2.4 waitqueues
In-Reply-To: <3A4937D2.B7FE7C28@uow.edu.au>, <3A4937D2.B7FE7C28@uow.edu.au>; <20001227033459.A29610@athlon.random> <3A495A88.D44D19E6@uow.edu.au>,
				<3A495A88.D44D19E6@uow.edu.au>; from andrewm@uow.edu.au on Wed, Dec 27, 2000 at 01:57:12PM +1100 <20001227043957.E29610@athlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> 
> Not a big deal but still I'd prefer the CONFIG_SMP #ifdef though, it looks even
> more obvious that it's a compile check and at least in your usage I cannot see
> a relevant readability advantage. And my own feeling is not having to rely on
> more things to produce the wanted asm when there's no relevant advantage, but
> if Linus likes it I won't object further.

Oh sob, what have you done?  My beautiful patch is full of ifdefs!

> > It's not just open-coded printks - it's oopses.  If you take an oops or a
> > BUG or a panic within wake_up() or _anywhere_ with the runqueue_lock held,
> > the machine deadlocks and you don't get any diagnostics.  This is bad.
> > We really do need to get that wake_up() out of printk().  tq_timer may
> > not be the best way.  Suggestions welcome.
> 
> For kernel autodiagnostics we need to trust something. This something is
> everything that gets into the oops path. wake_up is one of those things.  You
> want to replace wake_up with queue_task, why shouldn't queue_task break instead
> of wake_up? You're replacing a thing with another thing that can of course
> break too if there's a bug (hardware or software).

umm.. This use of queue_task almost _can't_ fail.  That's the point.

When kumon@fujitsu's 8-way was taking an oops in schedule() it took
several days of mucking about to get the runqueue_lock deadlock out
of the way. In fact we never got a decent backtrace because of it.

> But they're so core things
> that we need to trust anyway and we need to get them right from sources without
> relying on any testing anyways. So I simply don't see any advantage of using
> queue_task other than making things slower and more complex.

It's actually faster if you're doing more than one printk
per jiffy.

> For the runqueue_lock right way to not having to trust schedule as well is to
> add it to the bust_spinlocks list.

Yes.  Several weeks ago I did put up a patch which was designed to avoid
all the remaining oops-deadlocks.  Amongst other things it did this:

        if (!oops_in_progress)
		wake_up_interruptible(&log_wait);

I'll resuscitate that patch.  Using this approach we can still get infinite
recursion with WAITQUEUE_DEBUG enabled, but I guess we can live with that.

Anyway, here's the revised patch.  Unless Linus wants SMP_KERNEL, I think
we're done with this.



--- linux-2.4.0-test13pre4-ac2/include/linux/sched.h	Fri Dec 22 16:00:26 2000
+++ linux-akpm/include/linux/sched.h	Wed Dec 27 22:03:16 2000
@@ -545,7 +545,7 @@
 extern void FASTCALL(interruptible_sleep_on(wait_queue_head_t *q));
 extern long FASTCALL(interruptible_sleep_on_timeout(wait_queue_head_t *q,
 						    signed long timeout));
-extern void FASTCALL(wake_up_process(struct task_struct * tsk));
+extern int FASTCALL(wake_up_process(struct task_struct * tsk));
 
 #define wake_up(x)			__wake_up((x),TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE,WQ_FLAG_EXCLUSIVE)
 #define wake_up_all(x)			__wake_up((x),TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE,0)
--- linux-2.4.0-test13pre4-ac2/include/linux/wait.h	Tue Nov 21 20:11:21 2000
+++ linux-akpm/include/linux/wait.h	Wed Dec 27 22:30:50 2000
@@ -19,30 +19,10 @@
 #include <asm/processor.h>
 
 /*
- * Temporary debugging help until all code is converted to the new
- * waitqueue usage.
+ * Debug control.  Slow but useful.
  */
 #define WAITQUEUE_DEBUG 0
 
-#if WAITQUEUE_DEBUG
-extern int printk(const char *fmt, ...);
-#define WQ_BUG() do { \
-	printk("wq bug, forcing oops.\n"); \
-	BUG(); \
-} while (0)
-
-#define CHECK_MAGIC(x) if (x != (long)&(x)) \
-	{ printk("bad magic %lx (should be %lx), ", (long)x, (long)&(x)); WQ_BUG(); }
-
-#define CHECK_MAGIC_WQHEAD(x) do { \
-	if (x->__magic != (long)&(x->__magic)) { \
-		printk("bad magic %lx (should be %lx, creator %lx), ", \
-			x->__magic, (long)&(x->__magic), x->__creator); \
-		WQ_BUG(); \
-	} \
-} while (0)
-#endif
-
 struct __wait_queue {
 	unsigned int flags;
 #define WQ_FLAG_EXCLUSIVE	0x01
@@ -99,24 +79,70 @@
 };
 typedef struct __wait_queue_head wait_queue_head_t;
 
+
+/*
+ * Debugging macros.  We eschew `do { } while (0)' because gcc can generate
+ * spurious .aligns.
+ */
+#if WAITQUEUE_DEBUG
+#define WQ_BUG()	BUG()
+#define CHECK_MAGIC(x)							\
+	do {									\
+		if ((x) != (long)&(x)) {					\
+			printk("bad magic %lx (should be %lx), ",		\
+				(long)x, (long)&(x));				\
+			WQ_BUG();						\
+		}								\
+	} while (0)
+#define CHECK_MAGIC_WQHEAD(x)							\
+	do {									\
+		if ((x)->__magic != (long)&((x)->__magic)) {			\
+			printk("bad magic %lx (should be %lx, creator %lx), ",	\
+			(x)->__magic, (long)&((x)->__magic), (x)->__creator);	\
+			WQ_BUG();						\
+		}								\
+	} while (0)
+#define WQ_CHECK_LIST_HEAD(list) 						\
+	do {									\
+		if (!list->next || !list->prev)					\
+			WQ_BUG();						\
+	} while(0)
+#define WQ_NOTE_WAKER(tsk)							\
+	do {									\
+		tsk->__waker = (long)__builtin_return_address(0);		\
+	} while (0)
+#else
+#define WQ_BUG()
+#define CHECK_MAGIC(x)
+#define CHECK_MAGIC_WQHEAD(x)
+#define WQ_CHECK_LIST_HEAD(list)
+#define WQ_NOTE_WAKER(tsk)
+#endif
+
+/*
+ * Macros for declaration and initialisaton of the datatypes
+ */
+
 #if WAITQUEUE_DEBUG
-# define __WAITQUEUE_DEBUG_INIT(name) \
-		, (long)&(name).__magic, 0
-# define __WAITQUEUE_HEAD_DEBUG_INIT(name) \
-		, (long)&(name).__magic, (long)&(name).__magic
+# define __WAITQUEUE_DEBUG_INIT(name) (long)&(name).__magic, 0
+# define __WAITQUEUE_HEAD_DEBUG_INIT(name) (long)&(name).__magic, (long)&(name).__magic
 #else
 # define __WAITQUEUE_DEBUG_INIT(name)
 # define __WAITQUEUE_HEAD_DEBUG_INIT(name)
 #endif
 
-#define __WAITQUEUE_INITIALIZER(name,task) \
-	{ 0x0, task, { NULL, NULL } __WAITQUEUE_DEBUG_INIT(name)}
-#define DECLARE_WAITQUEUE(name,task) \
-	wait_queue_t name = __WAITQUEUE_INITIALIZER(name,task)
-
-#define __WAIT_QUEUE_HEAD_INITIALIZER(name) \
-{ WAITQUEUE_RW_LOCK_UNLOCKED, { &(name).task_list, &(name).task_list } \
-		__WAITQUEUE_HEAD_DEBUG_INIT(name)}
+#define __WAITQUEUE_INITIALIZER(name, tsk) {				\
+	task:		tsk,						\
+	task_list:	{ NULL, NULL },					\
+			 __WAITQUEUE_DEBUG_INIT(name)}
+
+#define DECLARE_WAITQUEUE(name, tsk)					\
+	wait_queue_t name = __WAITQUEUE_INITIALIZER(name, tsk)
+
+#define __WAIT_QUEUE_HEAD_INITIALIZER(name) {				\
+	lock:		WAITQUEUE_RW_LOCK_UNLOCKED,			\
+	task_list:	{ &(name).task_list, &(name).task_list },	\
+			__WAITQUEUE_HEAD_DEBUG_INIT(name)}
 
 #define DECLARE_WAIT_QUEUE_HEAD(name) \
 	wait_queue_head_t name = __WAIT_QUEUE_HEAD_INITIALIZER(name)
@@ -135,8 +161,7 @@
 #endif
 }
 
-static inline void init_waitqueue_entry(wait_queue_t *q,
-				 struct task_struct *p)
+static inline void init_waitqueue_entry(wait_queue_t *q, struct task_struct *p)
 {
 #if WAITQUEUE_DEBUG
 	if (!q || !p)
--- linux-2.4.0-test13pre4-ac2/kernel/sched.c	Tue Dec 12 19:24:23 2000
+++ linux-akpm/kernel/sched.c	Wed Dec 27 16:33:13 2000
@@ -326,9 +326,10 @@
  * "current->state = TASK_RUNNING" to mark yourself runnable
  * without the overhead of this.
  */
-inline void wake_up_process(struct task_struct * p)
+static inline int try_to_wake_up(struct task_struct * p, int synchronous)
 {
 	unsigned long flags;
+	int success = 0;
 
 	/*
 	 * We want the common case fall through straight, thus the goto.
@@ -338,25 +339,17 @@
 	if (task_on_runqueue(p))
 		goto out;
 	add_to_runqueue(p);
-	reschedule_idle(p);
+	if (!synchronous)
+		reschedule_idle(p);
+	success = 1;
 out:
 	spin_unlock_irqrestore(&runqueue_lock, flags);
+	return success;
 }
 
-static inline void wake_up_process_synchronous(struct task_struct * p)
+inline int wake_up_process(struct task_struct * p)
 {
-	unsigned long flags;
-
-	/*
-	 * We want the common case fall through straight, thus the goto.
-	 */
-	spin_lock_irqsave(&runqueue_lock, flags);
-	p->state = TASK_RUNNING;
-	if (task_on_runqueue(p))
-		goto out;
-	add_to_runqueue(p);
-out:
-	spin_unlock_irqrestore(&runqueue_lock, flags);
+	return try_to_wake_up(p, 0);
 }
 
 static void process_timeout(unsigned long __data)
@@ -689,76 +682,88 @@
 	return;
 }
 
+/*
+ * The core wakeup function.  Non-exclusive wakeups just wake everything up.
+ * If it's an exclusive wakeup then we wake all the non-exclusive tasks
+ * and one exclusive task.
+ * If called from interrupt context we wake the least-recently queued exclusive task
+ * which wants to run on the current CPU.
+ * If not called from interrupt context we simply wake the least-recently queued
+ * exclusive task.
+ * There are circumstances in which we can try to wake a task which has already
+ * started to run but is not in state TASK_RUNNING.  try_to_wake_up() returns zero
+ * in this (rare) case, and we handle it by rescanning the exclusive tasks and
+ * trying to wake *someone*.
+ */
 static inline void __wake_up_common (wait_queue_head_t *q, unsigned int mode,
 				     unsigned int wq_mode, const int sync)
 {
-	struct list_head *tmp, *head;
-	struct task_struct *p, *best_exclusive;
+	struct list_head *curr_sleeper, *head;
+	struct task_struct *p;
 	unsigned long flags;
-	int best_cpu, irq;
-
+#ifdef CONFIG_SMP
+	struct list_head *first_nonaffine_exclusive;
+	int best_cpu, do_affine;
+#endif
 	if (!q)
 		goto out;
 
+#ifdef CONFIG_SMP
 	best_cpu = smp_processor_id();
-	irq = in_interrupt();
-	best_exclusive = NULL;
-	wq_write_lock_irqsave(&q->lock, flags);
-
-#if WAITQUEUE_DEBUG
-	CHECK_MAGIC_WQHEAD(q);
+	do_affine = in_interrupt();
+	first_nonaffine_exclusive = NULL;
 #endif
-
+	wq_read_lock_irqsave(&q->lock, flags);
+	CHECK_MAGIC_WQHEAD(q);
 	head = &q->task_list;
-#if WAITQUEUE_DEBUG
-        if (!head->next || !head->prev)
-                WQ_BUG();
+	WQ_CHECK_LIST_HEAD(head);
+	curr_sleeper = head->next;
+#ifdef CONFIG_SMP
+retry:
 #endif
-	tmp = head->next;
-	while (tmp != head) {
-		unsigned int state;
-                wait_queue_t *curr = list_entry(tmp, wait_queue_t, task_list);
+	while (curr_sleeper != head) {
+                wait_queue_t *curr = list_entry(curr_sleeper, wait_queue_t, task_list);
 
-		tmp = tmp->next;
-
-#if WAITQUEUE_DEBUG
 		CHECK_MAGIC(curr->__magic);
-#endif
 		p = curr->task;
-		state = p->state;
-		if (state & mode) {
-#if WAITQUEUE_DEBUG
-			curr->__waker = (long)__builtin_return_address(0);
+		if (p->state & mode) {
+			WQ_NOTE_WAKER(curr);
+
+#ifdef CONFIG_SMP
+			if (do_affine && p->processor != best_cpu &&
+				(curr->flags & wq_mode & WQ_FLAG_EXCLUSIVE)) {
+					if (first_nonaffine_exclusive == NULL)
+						first_nonaffine_exclusive = curr_sleeper;
+			}
+			else
 #endif
-			/*
-			 * If waking up from an interrupt context then
-			 * prefer processes which are affine to this
-			 * CPU.
-			 */
-			if (irq && (curr->flags & wq_mode & WQ_FLAG_EXCLUSIVE)) {
-				if (!best_exclusive)
-					best_exclusive = p;
-				if (p->processor == best_cpu) {
-					best_exclusive = p;
-					break;
+			{
+				if (try_to_wake_up(p, sync)) {
+					if (curr->flags & wq_mode & WQ_FLAG_EXCLUSIVE)
+						goto woke_one;
 				}
-			} else {
-				if (sync)
-					wake_up_process_synchronous(p);
-				else
-					wake_up_process(p);
-				if (curr->flags & wq_mode & WQ_FLAG_EXCLUSIVE)
-					break;
 			}
 		}
+		curr_sleeper = curr_sleeper->next;
 	}
-	if (best_exclusive) {
-		if (sync)
-			wake_up_process_synchronous(best_exclusive);
-		else
-			wake_up_process(best_exclusive);
+
+#ifdef CONFIG_SMP
+	if (first_nonaffine_exclusive) {
+		/*
+		 * If we get here, there were exclusive sleepers on the queue, but we didn't
+		 * wake any up.  We've already tried to wake all the sleepers who are affine
+		 * to this CPU and we failed.  So we now try _all_ the exclusive sleepers.
+		 * We start with the least-recently-queued non-affine task.  It's almost certainly
+		 * not on the runqueue, so we'll terminate the above loop on the first pass.
+		 */
+		do_affine = 0;
+		curr_sleeper = first_nonaffine_exclusive;
+		first_nonaffine_exclusive = NULL;
+		goto retry;
 	}
-	wq_write_unlock_irqrestore(&q->lock, flags);
+#endif
+woke_one:
+	wq_read_unlock_irqrestore(&q->lock, flags);
 out:
 	return;
 }
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
