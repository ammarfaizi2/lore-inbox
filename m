Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131066AbQL3NIi>; Sat, 30 Dec 2000 08:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131384AbQL3NI3>; Sat, 30 Dec 2000 08:08:29 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:33444 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S131066AbQL3NIP>; Sat, 30 Dec 2000 08:08:15 -0500
Message-ID: <3A4DD878.342D536E@uow.edu.au>
Date: Sat, 30 Dec 2000 23:43:36 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Andrea Arcangeli <andrea@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [prepatch] 2.4 waitqueues
In-Reply-To: <3A4937D2.B7FE7C28@uow.edu.au> <Pine.LNX.4.10.10012281031520.12260-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Wed, 27 Dec 2000, Andrew Morton wrote:
> >
> > - Introduces a kernel-wide macro `SMP_KERNEL'.  This is designed to
> >   be used as a `compiled ifdef' in place of `#ifdef CONFIG_SMP'.  There
> >   are a few examples in __wake_up_common().
> 
> Please don't do this,

OK.

> >   So this has been changed to:
> >
> >       spin_lock_irq(lock);
> >       spin_unlock(lock);
> >       schedule();
> >       spin_lock(lock);
> >       spin_unlock_irq(lock);
> >
> >   Or did I miss something?
> 
> I'm a bit nervous about changing the old compatibility cruft, but the
> above is probably ok.

Andrea had the following reason to not make this change:

" Because old drivers could be doing ugly stuff like this:
"
"        cli()
"        for (;;) {
"	                if (!resource_available)
"	                        sleep_on(&wait_for_resource)
"	                else
"	                        break
"	        }
"	        ...
"	        sti()
"	
"	If you don't save and restore flags the second sleep_on could be entered with
"	irq enabled and the wakeup from irq could happen before registering in the
"	waitqueue causing a lost wakeup.
"

If anyone _is_ doing this, then they're scheduling with the global_irq_lock
held, which doesn't sound good.  Anyway, it's probably best not to fiddle with
this stuff today.

> Anyway, I'd like you to get rid of the global SMP_KERNEL thing (turning it
> into a local one if you want to for this case), _and_ I'd like to see this
> patch with the wait-queue spinlock _outside_ the __common_wakeup() path.
> 
> Why? Those semaphores will eventually want to re-use the wait-queue
> spinlock as a per-semaphore spinlock, and they would need to call
> __common_wakeup() with the spinlock held to do so. So let's get the
> infrastructure in place
> 

OK, did that.

__wake_up() now looks like this:

void __wake_up(wait_queue_head_t *q, unsigned int mode, unsigned int wq_mode)
{
	if (q) {
		unsigned long flags;
		wq_read_lock_irqsave(&q->lock, flags);
		__wake_up_common(q, mode, wq_mode, 0);
		wq_read_unlock_irqrestore(&q->lock, flags);
	}
}

If we want to use the waitqueue lock to replace semaphore_lock
then I'd suggest we change __wake_up to look like:

void __wake_up(wait_queue_head_t *q, unsigned int mode, unsigned int wq_mode)
{
	if (q) {
		unsigned long flags;
		if (!(wq_mode & WQ_FLAG_UNLOCKED))
			wq_read_lock_irqsave(&q->lock, flags);
		__wake_up_common(q, mode, wq_mode, 0);
		if (!(wq_mode & WQ_FLAG_UNLOCKED))
			wq_read_unlock_irqrestore(&q->lock, flags);
	}
}

So we don't have to expand another instantiation of __wake_up_common.  I always
find this tradeoff hard to make up my mind about...

The USE_RW_WAIT_QUEUE_SPINLOCK option is still there, so we _could_
turn on rwlocks for waitqueues in the future.  I have tested the
rwlock option and it appears to work.  It wasn't safe with the
old (current) __wake_up() implementation, but I think it is safe with
this patch.

rwlocks are a little more scalable here, and will probably allow us to leave
local interrupts enabled while running __wake_up().

BUT!  If we want to throw away semaphore_lock (good move) and then
enable rwlocks in the waitqueues, that means that __down() will
have to do a write_lock of the per-waitqueue lock, so it can
call __add_wait_queue_exclusive() and __remove_wait_queue_exclusive().
We'd need to do this anyway, so the waitqueue locking protects the
semaphore's internals.

We should also remove the extra wake_up() in __down(), which
is going to hurt someone's brain :)


Here's the patch, tested on x86 UP and SMP.  The only substantive change
since last time is hoisting the `wq_mode & WQ_FLAG_EXCLUSIVE' outside the
browsing loop and then commenting it out!


--- linux-2.4.0-test13-pre6/include/linux/sched.h	Sat Dec 30 22:19:58 2000
+++ linux-akpm/include/linux/sched.h	Sat Dec 30 22:54:21 2000
@@ -545,7 +545,7 @@
 extern void FASTCALL(interruptible_sleep_on(wait_queue_head_t *q));
 extern long FASTCALL(interruptible_sleep_on_timeout(wait_queue_head_t *q,
 						    signed long timeout));
-extern void FASTCALL(wake_up_process(struct task_struct * tsk));
+extern int FASTCALL(wake_up_process(struct task_struct * tsk));
 
 #define wake_up(x)			__wake_up((x),TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE,WQ_FLAG_EXCLUSIVE)
 #define wake_up_all(x)			__wake_up((x),TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE,0)
--- linux-2.4.0-test13-pre6/include/linux/wait.h	Sat Dec 30 22:19:58 2000
+++ linux-akpm/include/linux/wait.h	Sat Dec 30 22:54:21 2000
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
--- linux-2.4.0-test13-pre6/kernel/sched.c	Sat Dec 30 22:19:58 2000
+++ linux-akpm/kernel/sched.c	Sat Dec 30 23:08:51 2000
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
@@ -689,88 +682,101 @@
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
-	unsigned long flags;
-	int best_cpu, irq;
-
-	if (!q)
-		goto out;
-
-	best_cpu = smp_processor_id();
-	irq = in_interrupt();
-	best_exclusive = NULL;
-	wq_write_lock_irqsave(&q->lock, flags);
-
-#if WAITQUEUE_DEBUG
-	CHECK_MAGIC_WQHEAD(q);
+	struct list_head *curr_sleeper, *head;
+	struct task_struct *p;
+#ifdef CONFIG_SMP
+	struct list_head *first_nonaffine_exclusive = NULL;
+	int best_cpu = smp_processor_id();
+	int do_affine = in_interrupt();
 #endif
 
+	CHECK_MAGIC_WQHEAD(q);
 	head = &q->task_list;
-#if WAITQUEUE_DEBUG
-        if (!head->next || !head->prev)
-                WQ_BUG();
+	WQ_CHECK_LIST_HEAD(head);
+	curr_sleeper = head->next;
+	/* Enable the below stmt if/when other bits are defined in wait_queue_head.flags */
+/*	wq_mode &= WQ_FLAG_EXCLUSIVE;	*/
+#ifdef CONFIG_SMP
+retry:
 #endif
-	tmp = head->next;
-	while (tmp != head) {
-		unsigned int state;
-                wait_queue_t *curr = list_entry(tmp, wait_queue_t, task_list);
-
-		tmp = tmp->next;
+	while (curr_sleeper != head) {
+                wait_queue_t *curr = list_entry(curr_sleeper, wait_queue_t, task_list);
 
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
+			if (do_affine && p->processor != best_cpu && (curr->flags & wq_mode)) {
+				if (first_nonaffine_exclusive == NULL)
+					first_nonaffine_exclusive = curr_sleeper;
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
+					if (curr->flags & wq_mode)
+						goto out;
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
 out:
 	return;
 }
 
 void __wake_up(wait_queue_head_t *q, unsigned int mode, unsigned int wq_mode)
 {
-	__wake_up_common(q, mode, wq_mode, 0);
+	if (q) {
+		unsigned long flags;
+		wq_read_lock_irqsave(&q->lock, flags);
+		__wake_up_common(q, mode, wq_mode, 0);
+		wq_read_unlock_irqrestore(&q->lock, flags);
+	}
 }
 
 void __wake_up_sync(wait_queue_head_t *q, unsigned int mode, unsigned int wq_mode)
 {
-	__wake_up_common(q, mode, wq_mode, 1);
+	if (q) {
+		unsigned long flags;
+		wq_read_lock_irqsave(&q->lock, flags);
+		__wake_up_common(q, mode, wq_mode, 1);
+		wq_read_unlock_irqrestore(&q->lock, flags);
+	}
 }
 
 #define	SLEEP_ON_VAR				\
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
