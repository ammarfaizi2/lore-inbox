Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132220AbQL0AzA>; Tue, 26 Dec 2000 19:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132222AbQL0Ayv>; Tue, 26 Dec 2000 19:54:51 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:15521 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S132220AbQL0Ayp>; Tue, 26 Dec 2000 19:54:45 -0500
Message-ID: <3A4937D2.B7FE7C28@uow.edu.au>
Date: Wed, 27 Dec 2000 11:29:06 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>, Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [prepatch] 2.4 waitqueues
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's been quiet around here lately...


This is a rework of the 2.4 wakeup code based on the discussions Andrea
and I had last week.  There were two basic problems:

- If two tasks are on a waitqueue in exclusive mode and one gets
  woken, it will put itself back into TASK_[UN]INTERRUPTIBLE state for a
  few instructions and can soak up another wakeup which should have
  gone to the other task.

- If a task is on two waitqueues and two CPUs simultaneously run a
  wakeup, one on each waitqueue, they can both try to wake the same
  task which may be a lost wakeup, depending upon how the waitqueue
  users are coded.

The first problem is the most serious.  The second is kinda baroque...

The approach taken by this patch is the one which Andrea is proposing
for 2.2: if a task was already on the runqueue, continue scanning for
another exclusive task to wake up.

It ended up getting complicated because of the "find a process affine
to this CPU" thing.  Plus I did go slightly berzerk, but I believe the
result is pretty good.

- wake_up_process() now returns a success value if it managed to move
  something to the runqueue.

  Tidied up the code here a bit as well.

  wake_up_process_synchronous() is no more.

- Got rid of all the debugging ifdefs - these have been folded into
  wait.h

- Removed all the USE_RW_WAIT_QUEUE_SPINLOCK code and just used
  spinlocks.

  The read_lock option was pretty questionable anyway.  It hasn't had
  the widespread testing and, umm, the kernel is using wq_write_lock
  *everywhere* anyway, so enabling USE_RW_WAIT_QUEUE_SPINLOCK wouldn't
  change anything, except for using a more expensive spinlock!

  So it's gone.

- Introduces a kernel-wide macro `SMP_KERNEL'.  This is designed to
  be used as a `compiled ifdef' in place of `#ifdef CONFIG_SMP'.  There
  are a few examples in __wake_up_common().

  People shouldn't go wild with this, because gcc's dead code
  elimination isn't perfect.  But it's nice for little things.

- This patch's _use_ of SMP_KERNEL in __wake_up_common is fairly
  significant.  There was quite a lot of code in that function which
  was an unnecessary burden for UP systems.  All gone now.

- This patch shrinks sched.o by 100 bytes (SMP) and 300 bytes (UP). 
  Note that try_to_wake_up() is now only expanded in a single place
  in __wake_up_common().  It has a large footprint.

- I have finally had enough of printk() deadlocking or going
  infinitely mutually recursive on me so printk()'s wake_up(log_wait)
  call has been moved into a tq_timer callback.

- SLEEP_ON_VAR, SLEEP_ON_HEAD and SLEEP_ON_TAIL have been changed.  I
  see no valid reason why these functions were, effectively, doing
  this:

	spin_lock_irqsave(lock, flags);
	spin_unlock(lock);
	schedule();
	spin_lock(lock);
	spin_unlock_irqrestore(lock, flags);

  What's the point in saving the interrupt status in `flags'? If the
  caller _wants_ interrupt status preserved then the caller is buggy,
  because schedule() enables interrupts.  2.2 does the same thing.

  So this has been changed to:

	spin_lock_irq(lock);
	spin_unlock(lock);
	schedule();
	spin_lock(lock);
	spin_unlock_irq(lock);

  Or did I miss something?



--- linux-2.4.0-test13pre4-ac2/include/linux/sched.h	Fri Dec 22 16:00:26 2000
+++ linux-akpm/include/linux/sched.h	Wed Dec 27 01:17:06 2000
@@ -545,7 +545,7 @@
 extern void FASTCALL(interruptible_sleep_on(wait_queue_head_t *q));
 extern long FASTCALL(interruptible_sleep_on_timeout(wait_queue_head_t *q,
 						    signed long timeout));
-extern void FASTCALL(wake_up_process(struct task_struct * tsk));
+extern int FASTCALL(wake_up_process(struct task_struct * tsk));
 
 #define wake_up(x)			__wake_up((x),TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE,WQ_FLAG_EXCLUSIVE)
 #define wake_up_all(x)			__wake_up((x),TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE,0)
--- linux-2.4.0-test13pre4-ac2/include/linux/wait.h	Tue Nov 21 20:11:21 2000
+++ linux-akpm/include/linux/wait.h	Wed Dec 27 01:13:54 2000
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
@@ -55,42 +35,8 @@
 };
 typedef struct __wait_queue wait_queue_t;
 
-/*
- * 'dual' spinlock architecture. Can be switched between spinlock_t and
- * rwlock_t locks via changing this define. Since waitqueues are quite
- * decoupled in the new architecture, lightweight 'simple' spinlocks give
- * us slightly better latencies and smaller waitqueue structure size.
- */
-#define USE_RW_WAIT_QUEUE_SPINLOCK 0
-
-#if USE_RW_WAIT_QUEUE_SPINLOCK
-# define wq_lock_t rwlock_t
-# define WAITQUEUE_RW_LOCK_UNLOCKED RW_LOCK_UNLOCKED
-
-# define wq_read_lock read_lock
-# define wq_read_lock_irqsave read_lock_irqsave
-# define wq_read_unlock_irqrestore read_unlock_irqrestore
-# define wq_read_unlock read_unlock
-# define wq_write_lock_irq write_lock_irq
-# define wq_write_lock_irqsave write_lock_irqsave
-# define wq_write_unlock_irqrestore write_unlock_irqrestore
-# define wq_write_unlock write_unlock
-#else
-# define wq_lock_t spinlock_t
-# define WAITQUEUE_RW_LOCK_UNLOCKED SPIN_LOCK_UNLOCKED
-
-# define wq_read_lock spin_lock
-# define wq_read_lock_irqsave spin_lock_irqsave
-# define wq_read_unlock spin_unlock
-# define wq_read_unlock_irqrestore spin_unlock_irqrestore
-# define wq_write_lock_irq spin_lock_irq
-# define wq_write_lock_irqsave spin_lock_irqsave
-# define wq_write_unlock_irqrestore spin_unlock_irqrestore
-# define wq_write_unlock spin_unlock
-#endif
-
 struct __wait_queue_head {
-	wq_lock_t lock;
+	spinlock_t lock;
 	struct list_head task_list;
 #if WAITQUEUE_DEBUG
 	long __magic;
@@ -99,35 +45,85 @@
 };
 typedef struct __wait_queue_head wait_queue_head_t;
 
+
+/*
+ * Debugging macros.  We eschew `do { } while (0)' because gcc can generate
+ * spurious .aligns.
+ */
 #if WAITQUEUE_DEBUG
-# define __WAITQUEUE_DEBUG_INIT(name) \
-		, (long)&(name).__magic, 0
-# define __WAITQUEUE_HEAD_DEBUG_INIT(name) \
-		, (long)&(name).__magic, (long)&(name).__magic
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
+#if WAITQUEUE_DEBUG
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
+	lock:		SPIN_LOCK_UNLOCKED,				\
+	task_list:	{ &(name).task_list, &(name).task_list },	\
+			__WAITQUEUE_HEAD_DEBUG_INIT(name)}
 
 #define DECLARE_WAIT_QUEUE_HEAD(name) \
 	wait_queue_head_t name = __WAIT_QUEUE_HEAD_INITIALIZER(name)
 
+/*
+ * Inline functions
+ */
+
 static inline void init_waitqueue_head(wait_queue_head_t *q)
 {
 #if WAITQUEUE_DEBUG
 	if (!q)
 		WQ_BUG();
 #endif
-	q->lock = WAITQUEUE_RW_LOCK_UNLOCKED;
+	q->lock = SPIN_LOCK_UNLOCKED;
 	INIT_LIST_HEAD(&q->task_list);
 #if WAITQUEUE_DEBUG
 	q->__magic = (long)&q->__magic;
@@ -135,8 +131,7 @@
 #endif
 }
 
-static inline void init_waitqueue_entry(wait_queue_t *q,
-				 struct task_struct *p)
+static inline void init_waitqueue_entry(wait_queue_t *q, struct task_struct *p)
 {
 #if WAITQUEUE_DEBUG
 	if (!q || !p)
--- linux-2.4.0-test13pre4-ac2/include/linux/smp.h	Sat Sep  9 16:19:30 2000
+++ linux-akpm/include/linux/smp.h	Wed Dec 27 01:13:54 2000
@@ -88,4 +88,15 @@
 #define cpu_online_map				1
 
 #endif
+
+/*
+ * SMP_KERNEL may be used in very simple `if' statements in place
+ * of `#ifdef CONFIG_SMP'
+ */
+#ifdef CONFIG_SMP
+#define SMP_KERNEL	1
+#else
+#define SMP_KERNEL	0
+#endif
+
 #endif
--- linux-2.4.0-test13pre4-ac2/kernel/sched.c	Tue Dec 12 19:24:23 2000
+++ linux-akpm/kernel/sched.c	Wed Dec 27 01:52:08 2000
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
@@ -689,76 +682,78 @@
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
+	struct list_head *curr_sleeper, *head, *first_nonaffine_exclusive;
+	struct task_struct *p;
 	unsigned long flags;
-	int best_cpu, irq;
+	int best_cpu, do_affine;
 
 	if (!q)
 		goto out;
 
-	best_cpu = smp_processor_id();
-	irq = in_interrupt();
-	best_exclusive = NULL;
-	wq_write_lock_irqsave(&q->lock, flags);
-
-#if WAITQUEUE_DEBUG
+	if (SMP_KERNEL) {
+		best_cpu = smp_processor_id();
+		do_affine = in_interrupt();
+		first_nonaffine_exclusive = NULL;
+	}
+	spin_lock_irqsave(&q->lock, flags);
 	CHECK_MAGIC_WQHEAD(q);
-#endif
-
 	head = &q->task_list;
-#if WAITQUEUE_DEBUG
-        if (!head->next || !head->prev)
-                WQ_BUG();
-#endif
-	tmp = head->next;
-	while (tmp != head) {
-		unsigned int state;
-                wait_queue_t *curr = list_entry(tmp, wait_queue_t, task_list);
-
-		tmp = tmp->next;
+	WQ_CHECK_LIST_HEAD(head);
+	curr_sleeper = head->next;
+retry:
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
-#endif
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
-				}
+		if (p->state & mode) {
+			WQ_NOTE_WAKER(curr);
+
+			if (SMP_KERNEL && do_affine && p->processor != best_cpu &&
+				(curr->flags & wq_mode & WQ_FLAG_EXCLUSIVE)) {
+					if (first_nonaffine_exclusive == NULL)
+						first_nonaffine_exclusive = curr_sleeper;
 			} else {
-				if (sync)
-					wake_up_process_synchronous(p);
-				else
-					wake_up_process(p);
-				if (curr->flags & wq_mode & WQ_FLAG_EXCLUSIVE)
-					break;
+				if (try_to_wake_up(p, sync)) {
+					if (curr->flags & wq_mode & WQ_FLAG_EXCLUSIVE)
+						goto woke_one;
+				}
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
+	if (SMP_KERNEL && first_nonaffine_exclusive) {
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
+woke_one:
+	spin_unlock_irqrestore(&q->lock, flags);
 out:
 	return;
 }
@@ -774,19 +769,18 @@
 }
 
 #define	SLEEP_ON_VAR				\
-	unsigned long flags;			\
 	wait_queue_t wait;			\
 	init_waitqueue_entry(&wait, current);
 
 #define	SLEEP_ON_HEAD					\
-	wq_write_lock_irqsave(&q->lock,flags);		\
+	spin_lock_irq(&q->lock);			\
 	__add_wait_queue(q, &wait);			\
-	wq_write_unlock(&q->lock);
+	spin_unlock(&q->lock);
 
 #define	SLEEP_ON_TAIL						\
-	wq_write_lock_irq(&q->lock);				\
+	spin_lock_irq(&q->lock);				\
 	__remove_wait_queue(q, &wait);				\
-	wq_write_unlock_irqrestore(&q->lock,flags);
+	spin_unlock_irq(&q->lock);
 
 void interruptible_sleep_on(wait_queue_head_t *q)
 {
--- linux-2.4.0-test13pre4-ac2/kernel/printk.c	Sat Dec 23 17:24:20 2000
+++ linux-akpm/kernel/printk.c	Wed Dec 27 01:13:54 2000
@@ -19,6 +19,7 @@
 #include <linux/smp_lock.h>
 #include <linux/console.h>
 #include <linux/init.h>
+#include <linux/tqueue.h>
 
 #include <asm/uaccess.h>
 
@@ -251,6 +252,16 @@
 	return do_syslog(type, buf, len);
 }
 
+/*
+ * We can get deadlocks or infinite recursion calling wake_up() from within
+ * printk(), so we use a tq_timer callback.  But don't put a printk() in
+ * queue_task()!
+ */
+static void wake_log_wait(void *dummy)
+{
+	wake_up_interruptible(&log_wait);
+}
+	
 asmlinkage int printk(const char *fmt, ...)
 {
 	va_list args;
@@ -259,6 +270,9 @@
 	int line_feed;
 	static signed char msg_level = -1;
 	long flags;
+	static struct tq_struct log_wait_waker = {
+		routine: wake_log_wait,
+	};
 
 	spin_lock_irqsave(&console_lock, flags);
 	va_start(args, fmt);
@@ -308,7 +322,7 @@
 			msg_level = -1;
 	}
 	spin_unlock_irqrestore(&console_lock, flags);
-	wake_up_interruptible(&log_wait);
+	queue_task(&log_wait_waker, &tq_timer);
 	return i;
 }
 
--- linux-2.4.0-test13pre4-ac2/kernel/fork.c	Fri Dec 22 16:00:26 2000
+++ linux-akpm/kernel/fork.c	Wed Dec 27 00:37:49 2000
@@ -38,29 +38,29 @@
 {
 	unsigned long flags;
 
-	wq_write_lock_irqsave(&q->lock, flags);
+	spin_lock_irqsave(&q->lock, flags);
 	wait->flags = 0;
 	__add_wait_queue(q, wait);
-	wq_write_unlock_irqrestore(&q->lock, flags);
+	spin_unlock_irqrestore(&q->lock, flags);
 }
 
 void add_wait_queue_exclusive(wait_queue_head_t *q, wait_queue_t * wait)
 {
 	unsigned long flags;
 
-	wq_write_lock_irqsave(&q->lock, flags);
+	spin_lock_irqsave(&q->lock, flags);
 	wait->flags = WQ_FLAG_EXCLUSIVE;
 	__add_wait_queue_tail(q, wait);
-	wq_write_unlock_irqrestore(&q->lock, flags);
+	spin_unlock_irqrestore(&q->lock, flags);
 }
 
 void remove_wait_queue(wait_queue_head_t *q, wait_queue_t * wait)
 {
 	unsigned long flags;
 
-	wq_write_lock_irqsave(&q->lock, flags);
+	spin_lock_irqsave(&q->lock, flags);
 	__remove_wait_queue(q, wait);
-	wq_write_unlock_irqrestore(&q->lock, flags);
+	spin_unlock_irqrestore(&q->lock, flags);
 }
 
 void __init fork_init(unsigned long mempages)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
