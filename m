Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264701AbUDUEBG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264701AbUDUEBG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 00:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264700AbUDUEBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 00:01:06 -0400
Received: from ip-66-80-228-130.sjc.megapath.net ([66.80.228.130]:59634 "EHLO
	sodium.co.intel.com") by vger.kernel.org with ESMTP id S264701AbUDUD6R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 23:58:17 -0400
Date: Tue, 20 Apr 2004 21:03:36 -0700
From: inaky.perez-gonzalez@intel.com
To: linux-kernel@vger.kernel.org
Cc: inaky.perez-gonzalez@intel.com
Subject: [RFC/PATCH] FUSYN 2/11: modifications to the core
Message-ID: <0404202103.Eajc1b.dndIaLbXawacc8drbScVdPaPa1457@intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <0404202103.BdpblbFbObEc7cVdTcFbFdYcCcNcudCb1457@intel.com>
X-Mailer: patchbomb 0.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These are modifications needed to support fuqueues and
fulocks. They are, in a nutshell:

- Move some stuff from kernel/futex.c to futex.h to make it
usable by more people.

- Add neccesary fields to the task_struct.

- Hookup to initialization and cleanup points for process
creation and destruction.

- Hookup into the signalling and time out code for wait
cancellation, as well as for changing task priorities.

- Modify bits of the priority recalculation code so we have
the concept of the priority boost.

- Add error codes for dead-owner and not-recoverable.


 include/asm-generic/errno-base.h |    4 +
 include/linux/futex.h            |   56 ++++++++++++++++++++
 include/linux/init_task.h        |    6 ++
 include/linux/sched.h            |   14 ++++-
 kernel/Makefile                  |    3 -
 kernel/exit.c                    |    3 +
 kernel/fork.c                    |    2 
 kernel/futex.c                   |   39 +-------------
 kernel/sched.c                   |  108 ++++++++++++++++++++++++++++++++++-----
 kernel/signal.c                  |   16 +++++
 kernel/timer.c                   |    6 +-
 11 files changed, 207 insertions(+), 50 deletions(-)

--- include/linux/futex.h:1.1.1.2 Tue Apr 6 00:23:00 2004
+++ include/linux/futex.h Sun Nov 16 07:21:32 2003
@@ -9,8 +9,64 @@
 #define FUTEX_FD (2)
 #define FUTEX_REQUEUE (3)
 
+#ifdef __KERNEL__
+
+#include <linux/jhash.h>
+
+struct timespec;
+asmlinkage long sys_futex(u32 __user *uaddr, int op, int val,
+			  struct timespec __user *utime, u32 __user *uaddr2);
+
 
 long do_futex(unsigned long uaddr, int op, int val,
 		unsigned long timeout, unsigned long uaddr2, int val2);
 
+/*
+ * Futexes are matched on equal values of this key.
+ * The key type depends on whether it's a shared or private mapping.
+ * Don't rearrange members without looking at futex_hash_key().
+ *
+ * offset is aligned to a multiple of sizeof(u32) (== 4) by definition.
+ * We set bit 0 to indicate if it's an inode-based key.
+ */
+union futex_key {
+	struct {
+		unsigned long pgoff;
+		struct inode *inode;
+		int offset;
+	} shared;
+	struct {
+		unsigned long uaddr;
+		struct mm_struct *mm;
+		int offset;
+	} private;
+	struct {
+		unsigned long word;
+		void *ptr;
+		int offset;
+	} both;
+};
+
+static inline
+u32 futex_hash_key (const union futex_key *key)
+{
+  u32 hash = jhash2((u32*)&key->both.word,
+                    (sizeof(key->both.word)+sizeof(key->both.ptr))/4,
+                    key->both.offset);
+  return hash;
+}
+
+static inline
+int match_futex_key (const union futex_key *key1, const union futex_key *key2)
+{
+	return (key1->both.word == key2->both.word
+		&& key1->both.ptr == key2->both.ptr
+		&& key1->both.offset == key2->both.offset);
+}
+
+extern int get_futex_key (unsigned long uaddr, union futex_key *key);
+extern void get_key_refs(union futex_key *key);
+extern void drop_key_refs(union futex_key *key);
+
+#endif /* #ifdef __KERNEL__ */
 #endif
--- include/linux/init_task.h:1.1.1.5 Tue Apr 6 01:51:36 2004
+++ include/linux/init_task.h Tue Apr 6 02:16:35 2004
@@ -72,6 +72,7 @@
 	.lock_depth	= -1,						\
 	.prio		= MAX_PRIO-20,					\
 	.static_prio	= MAX_PRIO-20,					\
+	.boost_prio	= BOTTOM_PRIO,					\
 	.policy		= SCHED_NORMAL,					\
 	.cpus_allowed	= CPU_MASK_ALL,					\
 	.mm		= NULL,						\
@@ -112,6 +113,11 @@
 	.proc_lock	= SPIN_LOCK_UNLOCKED,				\
 	.switch_lock	= SPIN_LOCK_UNLOCKED,				\
 	.journal_info	= NULL,						\
+	.fuqueue_wait_lock	= SPIN_LOCK_UNLOCKED,			\
+	.fuqueue_wait	= NULL,						\
+	.fuqueue_waiter	= NULL,						\
+	.fulock_olist	= olist_INIT(&tsk.fulock_olist),		\
+	.fulock_olist_lock = SPIN_LOCK_UNLOCKED,			\
 }
 
 
--- include/linux/sched.h:1.1.1.14 Tue Apr 6 01:51:36 2004
+++ include/linux/sched.h Tue Apr 6 02:16:35 2004
@@ -29,6 +29,7 @@
 #include <linux/completion.h>
 #include <linux/pid.h>
 #include <linux/percpu.h>
+#include <linux/fulock-olist.h>    /* olist_t */
 
 struct exec_domain;
 
@@ -286,6 +287,7 @@
 #define MAX_RT_PRIO		MAX_USER_RT_PRIO
 
 #define MAX_PRIO		(MAX_RT_PRIO + 40)
+#define BOTTOM_PRIO             INT_MAX
 
 #define rt_task(p)		((p)->prio < MAX_RT_PRIO)
 
@@ -330,6 +332,8 @@
 };
 
 
+struct fuqueue;
+struct fuqueue_waiter;
 struct io_context;			/* See blkdev.h */
 void exit_io_context(void);
 
@@ -369,7 +373,7 @@
 
 	int lock_depth;		/* Lock depth */
 
-	int prio, static_prio;
+	int prio, static_prio, boost_prio;
 	struct list_head run_list;
 	prio_array_t *array;
 
@@ -493,6 +497,11 @@
 
 	unsigned long ptrace_message;
 	siginfo_t *last_siginfo; /* For ptrace use.  */
+	struct fuqueue *fuqueue_wait; /* waiting for this qeueue */
+	struct fuqueue_waiter *fuqueue_waiter; /* waiting for this qeueue */
+	spinlock_t fuqueue_wait_lock; /* FIXME: locking too heavy -- better sollution? */
+	olist_t fulock_olist;	      /* Fulock ownership list */
+	spinlock_t fulock_olist_lock;
 };
 
 static inline pid_t process_group(struct task_struct *tsk)
@@ -557,6 +566,9 @@
 extern int task_curr(task_t *p);
 extern int idle_cpu(int cpu);
 
+/* Set the boost priority */
+extern unsigned __prio_boost (task_t *, int);
+
 void yield(void);
 
 /*
--- kernel/Makefile:1.1.1.10 Tue Apr 6 01:51:37 2004
+++ kernel/Makefile Tue Apr 6 02:16:42 2004
@@ -7,7 +7,8 @@
 	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o workqueue.o pid.o \
 	    rcupdate.o intermodule.o extable.o params.o posix-timers.o \
-	    kthread.o
+	    kthread.o \
+	    fuqueue.o fulock.o vlocator.o ufuqueue.o ufulock.o
 
 obj-$(CONFIG_FUTEX) += futex.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
--- kernel/exit.c:1.1.1.11 Tue Apr 6 01:51:37 2004
+++ kernel/exit.c Tue Apr 6 02:16:42 2004
@@ -743,6 +743,8 @@
 
 }
 
+extern void exit_fulocks(struct task_struct *);
+
 asmlinkage NORET_TYPE void do_exit(long code)
 {
 	struct task_struct *tsk = current;
@@ -771,6 +773,7 @@
 	}
 
 	acct_process(code);
+	exit_fulocks(tsk);
 	__exit_mm(tsk);
 
 	exit_sem(tsk);
--- kernel/fork.c:1.1.1.14 Tue Apr 6 01:51:37 2004
+++ kernel/fork.c Tue Apr 6 02:16:42 2004
@@ -41,6 +41,7 @@
 
 extern int copy_semundo(unsigned long clone_flags, struct task_struct *tsk);
 extern void exit_sem(struct task_struct *tsk);
+extern void init_fulock (struct task_struct *task);
 
 /* The idle threads do not count..
  * Protected by write_lock_irq(&tasklist_lock)
@@ -964,6 +965,7 @@
 		goto bad_fork_cleanup_signal;
 	if ((retval = copy_namespace(clone_flags, p)))
 		goto bad_fork_cleanup_mm;
+	init_fulock(p);
 	retval = copy_thread(0, clone_flags, stack_start, stack_size, p, regs);
 	if (retval)
 		goto bad_fork_cleanup_namespace;
--- kernel/futex.c:1.1.1.7 Tue Apr 6 00:23:05 2004
+++ kernel/futex.c Tue Apr 6 02:16:42 2004
@@ -41,31 +41,6 @@
 
 #define FUTEX_HASHBITS 8
 
-/*
- * Futexes are matched on equal values of this key.
- * The key type depends on whether it's a shared or private mapping.
- * Don't rearrange members without looking at hash_futex().
- *
- * offset is aligned to a multiple of sizeof(u32) (== 4) by definition.
- * We set bit 0 to indicate if it's an inode-based key.
- */
-union futex_key {
-	struct {
-		unsigned long pgoff;
-		struct inode *inode;
-		int offset;
-	} shared;
-	struct {
-		unsigned long uaddr;
-		struct mm_struct *mm;
-		int offset;
-	} private;
-	struct {
-		unsigned long word;
-		void *ptr;
-		int offset;
-	} both;
-};
 
 /*
  * We use this hashed waitqueue instead of a normal wait_queue_t, so
@@ -109,9 +84,7 @@
  */
 static struct futex_hash_bucket *hash_futex(union futex_key *key)
 {
-	u32 hash = jhash2((u32*)&key->both.word,
-			  (sizeof(key->both.word)+sizeof(key->both.ptr))/4,
-			  key->both.offset);
+	u32 hash = futex_hash_key (key);
 	return &futex_queues[hash & ((1 << FUTEX_HASHBITS)-1)];
 }
 
@@ -120,9 +93,7 @@
  */
 static inline int match_futex(union futex_key *key1, union futex_key *key2)
 {
-	return (key1->both.word == key2->both.word
-		&& key1->both.ptr == key2->both.ptr
-		&& key1->both.offset == key2->both.offset);
+	return match_futex_key (key1, key2);
 }
 
 /*
@@ -137,7 +108,7 @@
  *
  * Should be called with &current->mm->mmap_sem but NOT any spinlocks.
  */
-static int get_futex_key(unsigned long uaddr, union futex_key *key)
+int get_futex_key(unsigned long uaddr, union futex_key *key)
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
@@ -232,7 +203,7 @@
  * NOTE: mmap_sem MUST be held between get_futex_key() and calling this
  * function, if it is called at all.  mmap_sem keeps key->shared.inode valid.
  */
-static inline void get_key_refs(union futex_key *key)
+inline void get_key_refs(union futex_key *key)
 {
 	if (key->both.ptr != 0) {
 		if (key->both.offset & 1)
@@ -246,7 +217,7 @@
  * Drop a reference to the resource addressed by a key.
  * The hash bucket spinlock must not be held.
  */
-static void drop_key_refs(union futex_key *key)
+inline void drop_key_refs(union futex_key *key)
 {
 	if (key->both.ptr != 0) {
 		if (key->both.offset & 1)
--- kernel/sched.c:1.1.1.18 Tue Apr 6 01:51:37 2004
+++ kernel/sched.c Wed Apr 14 01:51:51 2004
@@ -33,6 +33,7 @@
 #include <linux/suspend.h>
 #include <linux/blkdev.h>
 #include <linux/delay.h>
+#include <linux/fuqueue.h>
 #include <linux/smp.h>
 #include <linux/timer.h>
 #include <linux/rcupdate.h>
@@ -356,13 +357,10 @@
  *
  * Both properties are important to certain workloads.
  */
-static int effective_prio(task_t *p)
+static inline int __effective_prio(task_t *p)
 {
 	int bonus, prio;
 
-	if (rt_task(p))
-		return p->prio;
-
 	bonus = CURRENT_BONUS(p) - MAX_BONUS / 2;
 
 	prio = p->static_prio - bonus;
@@ -372,6 +370,13 @@
 		prio = MAX_PRIO-1;
 	return prio;
 }
+static int effective_prio(task_t *p)
+{
+	int new_prio;
+	new_prio = rt_task(p)? p->prio : __effective_prio(p);
+	return min (new_prio, p->boost_prio);
+}
+
 
 /*
  * __activate_task - move a task to the runqueue.
@@ -653,7 +658,8 @@
 	int success = 0;
 	long old_state;
 	runqueue_t *rq;
-
+	
+		
 repeat_lock_task:
 	rq = task_rq_lock(p, &flags);
 	old_state = p->state;
@@ -733,6 +739,8 @@
 	 */
 	p->thread_info->preempt_count = 1;
 #endif
+	/* Initially the task has no priority boosting */
+	p->boost_prio = BOTTOM_PRIO;
 	/*
 	 * Share the timeslice between parent and child, thus the
 	 * total amount of pending timeslices in the system doesn't change,
@@ -1772,6 +1780,9 @@
  * There are circumstances in which we can try to wake a task which has already
  * started to run but is not in state TASK_RUNNING.  try_to_wake_up() returns
  * zero in this (rare) case, and we handle it by continuing to scan the queue.
+ *
+ * fuqueue_wait_cancel needs to hook up here to properly rescheduler
+ * priority inheritance/protected tasks. Check its doc to learn why.
  */
 static void __wake_up_common(wait_queue_head_t *q, unsigned int mode,
 			     int nr_exclusive, int sync)
@@ -1783,6 +1794,8 @@
 		unsigned flags;
 		curr = list_entry(tmp, wait_queue_t, task_list);
 		flags = curr->flags;
+		if (unlikely(curr->task->fuqueue_wait != NULL))
+			fuqueue_waiter_cancel(curr->task, -EINTR);
 		if (curr->func(curr, mode, sync) &&
 		    (flags & WQ_FLAG_EXCLUSIVE) &&
 		    !--nr_exclusive)
@@ -1965,12 +1978,17 @@
 
 void scheduling_functions_end_here(void) { }
 
+/*
+ * Note the initialization of old_prio and new_dynamic_prio. If we
+ * fall back through 'out_unlock', they will help to skip the call to
+ * fuqueue_waiter_chprio(). 
+ */
 void set_user_nice(task_t *p, long nice)
 {
 	unsigned long flags;
 	prio_array_t *array;
 	runqueue_t *rq;
-	int old_prio, new_prio, delta;
+	int old_prio = p->prio, new_prio, delta;
 
 	if (TASK_NICE(p) == nice || nice < -20 || nice > 19)
 		return;
@@ -1993,11 +2011,12 @@
 	if (array)
 		dequeue_task(p, array);
 
-	old_prio = p->prio;
 	new_prio = NICE_TO_PRIO(nice);
 	delta = new_prio - old_prio;
 	p->static_prio = NICE_TO_PRIO(nice);
 	p->prio += delta;
+	old_prio = p->prio;
+	p->prio = min (p->prio, p->boost_prio);
 
 	if (array) {
 		enqueue_task(p, array);
@@ -2010,6 +2029,8 @@
 	}
 out_unlock:
 	task_rq_unlock(rq, &flags);
+	if (old_prio != p->prio && p->fuqueue_wait != NULL)
+		fuqueue_waiter_chprio(p);
 }
 
 EXPORT_SYMBOL(set_user_nice);
@@ -2102,20 +2123,79 @@
 	return pid ? find_task_by_pid(pid) : current;
 }
 
+
+/**
+ * Boost the priority of a task from a new dynamic priority. 
+ *
+ * On SCHED_NORMAL, sets boost_prio in as __effective_prio()
+ * would do to get the same prio when it is reinserted in the list.
+ * 
+ * @p: Pointer to the task in question
+ * @prio: New boost priority to set
+ * @returns: !0 if the final new dynamic priority of the task has
+ * changed, 0 otherwise.
+ *
+ * This does not do fuqueue priority propagation (to avoid infinite
+ * recursion in the fuqueue code).
+ */
+unsigned __prio_boost(task_t *p, int prio)
+{
+	runqueue_t *rq;
+	prio_array_t *array;
+	long flags;
+        int old_prio, new_dynamic_prio, newprio;
+
+	if (p->boost_prio == prio)
+		return 0;
+	
+	rq = task_rq_lock(p, &flags);
+        old_prio = p->prio;
+	array = p->array;
+	if (array)
+		deactivate_task(p, task_rq(p));
+	p->boost_prio = prio;
+	new_dynamic_prio = p->policy != SCHED_NORMAL?
+		MAX_USER_RT_PRIO - 1 - p->rt_priority
+		: __effective_prio(p);
+	newprio = min (new_dynamic_prio, p->boost_prio);
+	p->prio = newprio;
+	if (array) {
+		__activate_task(p, task_rq(p));
+		if (rq->curr == p) {
+			if (p->prio > old_prio)
+				resched_task(rq->curr);
+		}
+		else if (TASK_PREEMPTS_CURR (p, rq))
+			resched_task(rq->curr);
+	}
+	task_rq_unlock (rq, &flags);
+	return old_prio != newprio;
+}
+
+
 /* Actually do priority change: must hold rq lock. */
 static void __setscheduler(struct task_struct *p, int policy, int prio)
 {
+	int newprio, oldprio;
+
 	BUG_ON(p->array);
 	p->policy = policy;
 	p->rt_priority = prio;
 	if (policy != SCHED_NORMAL)
-		p->prio = MAX_USER_RT_PRIO-1 - p->rt_priority;
+		newprio = MAX_USER_RT_PRIO-1 - p->rt_priority;
 	else
-		p->prio = p->static_prio;
+		newprio = p->static_prio;
+	oldprio = p->prio;
+	p->prio = min (newprio, p->boost_prio);
 }
 
 /*
  * setscheduler - change the scheduling policy and/or RT priority of a thread.
+ * 
+ * Note the initialization of old_prio. If we fall back through
+ * 'out_unlock*', it will help to skip the call to
+ * fuqueue_waiter_chprio(); this way we avoid the extra check on
+ * 'retval == 0'.
  */
 static int setscheduler(pid_t pid, int policy, struct sched_param __user *param)
 {
@@ -2150,7 +2230,7 @@
 	 * runqueue lock must be held.
 	 */
 	rq = task_rq_lock(p, &flags);
-
+	oldprio = p->prio;
 	if (policy < 0)
 		policy = p->policy;
 	else {
@@ -2186,7 +2266,6 @@
 	if (array)
 		deactivate_task(p, task_rq(p));
 	retval = 0;
-	oldprio = p->prio;
 	__setscheduler(p, policy, lp.sched_priority);
 	if (array) {
 		__activate_task(p, task_rq(p));
@@ -2204,9 +2283,10 @@
 
 out_unlock:
 	task_rq_unlock(rq, &flags);
+	if (oldprio != p->prio && p->fuqueue_wait != NULL)
+		fuqueue_waiter_chprio(p);
 out_unlock_tasklist:
 	read_unlock_irq(&tasklist_lock);
-
 out_nounlock:
 	return retval;
 }
@@ -2868,6 +2948,7 @@
 	struct task_struct *p;
 	struct runqueue *rq;
 	unsigned long flags;
+	unsigned old_prio;
 
 	switch (action) {
 	case CPU_UP_PREPARE:
@@ -2877,8 +2958,11 @@
 		kthread_bind(p, cpu);
 		/* Must be high prio: stop_machine expects to yield to it. */
 		rq = task_rq_lock(p, &flags);
+		old_prio = p->prio;
 		__setscheduler(p, SCHED_FIFO, MAX_RT_PRIO-1);
 		task_rq_unlock(rq, &flags);
+		if (old_prio != p->prio && p->fuqueue_wait != NULL)
+			fuqueue_waiter_chprio (p);
 		cpu_rq(cpu)->migration_thread = p;
 		break;
 	case CPU_ONLINE:
--- kernel/signal.c:1.1.1.12 Tue Apr 6 01:51:37 2004
+++ kernel/signal.c Wed Apr 14 20:21:24 2004
@@ -521,6 +521,8 @@
 	return signr;
 }
 
+extern void fuqueue_waiter_cancel (struct task_struct *, int);
+
 /*
  * Tell a process that it has a new active signal..
  *
@@ -544,12 +546,21 @@
 	 * executing another processor and just now entering stopped state.
 	 * By calling wake_up_process any time resume is set, we ensure
 	 * the process will wake up and handle its stop or death signal.
+	 * 
+	 * fuqueue_waiter_cancel needs to hook up here to properly rescheduler
+	 * priority inheritance/protected tasks. The reason is that
+	 * when we resched a process that has boosted another one, we
+	 * need to kick its butt off the CPU (and lower its priority) ASAP
+	 * so that 't' can run.
 	 */
 	mask = TASK_INTERRUPTIBLE;
 	if (resume)
 		mask |= TASK_STOPPED;
-	if (!wake_up_state(t, mask))
+	if (unlikely (t->fuqueue_wait != NULL))
+		fuqueue_waiter_cancel(t, -EINTR);
+	if (!wake_up_state(t, mask)) {
 		kick_process(t);
+	}
 }
 
 /*
@@ -672,6 +683,9 @@
 				set_tsk_thread_flag(t, TIF_SIGPENDING);
 				state |= TASK_INTERRUPTIBLE;
 			}
+			/* FIXME: I am not that sure we need to cancel here */
+			if (unlikely(t->fuqueue_wait != NULL))
+				fuqueue_waiter_cancel(t, -EINTR);
 			wake_up_state(t, state);
 
 			t = next_thread(t);
--- kernel/timer.c:1.1.1.13 Tue Apr 6 01:51:37 2004
+++ kernel/timer.c Tue Apr 6 02:16:42 2004
@@ -31,6 +31,7 @@
 #include <linux/time.h>
 #include <linux/jiffies.h>
 #include <linux/cpu.h>
+#include <linux/fuqueue.h>
 
 #include <asm/uaccess.h>
 #include <asm/div64.h>
@@ -967,7 +968,10 @@
 
 static void process_timeout(unsigned long __data)
 {
-	wake_up_process((task_t *)__data);
+	struct task_struct *task = (task_t *) __data;
+	if (unlikely(task->fuqueue_wait != NULL))
+		fuqueue_waiter_cancel(task, -ETIMEDOUT);
+	wake_up_process(task);
 }
 
 /**
--- include/asm-generic/errno-base.h:1.1.1.1 Thu Jul 10 12:27:27 2003
+++ include/asm-generic/errno-base.h Sun Nov 16 07:21:32 2003
@@ -36,4 +36,8 @@
 #define	EDOM		33	/* Math argument out of domain of func */
 #define	ERANGE		34	/* Math result not representable */
 
+  /* FIXME: ugly hack to avoid conflicts -- need to get better numbers */
+#define EOWNERDEAD      525     /* Mutex owner died */
+#define ENOTRECOVERABLE 526     /* Mutex state is not recoverable */
+
 #endif
