Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267772AbUGWQAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267772AbUGWQAr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 12:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267808AbUGWP7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 11:59:52 -0400
Received: from fmr05.intel.com ([134.134.136.6]:17798 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S267810AbUGWPlY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 11:41:24 -0400
Date: Fri, 23 Jul 2004 08:49:41 -0700
From: inaky.perez-gonzalez@intel.com
To: linux-kernel@vger.kernel.org
Cc: inaky.perez-gonzalez@intel.com, robustmutexes@lists.osdl.org
Subject: [RFC/PATCH] FUSYN 11/11: Modifications to the core: scheduler
Message-ID: <0407230849.fdYd7bfdSc9d3aId2bsdQb1cccraydZb17066@intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <0407230849.IbGdeaVc4cHb1asaZc5cubdcLdZaaaCb17066@intel.com>
X-Mailer: patchbomb 0.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for priority boosting, hooks into the scheduling
code.

As we modify the task struct, fix the init_task. Currently
ugly as hell, needs to be improved.


 arch/i386/kernel/init_task.c |    1 
 include/linux/init_task.h    |   31 ++++++++++++
 include/linux/sched.h        |   22 ++++++++-
 kernel/exit.c                |    2 
 kernel/fork.c                |    2 
 kernel/sched.c               |  103 +++++++++++++++++++++++++++++++++++++------
 kernel/signal.c              |   14 +++++
 7 files changed, 160 insertions(+), 15 deletions(-)

--- include/linux/init_task.h:1.1.1.5 Tue Apr 6 01:51:36 2004
+++ include/linux/init_task.h Wed May 26 22:14:47 2004
@@ -60,6 +60,32 @@
 extern struct group_info init_groups;
 
 /*
+ * Initialize the init task fuqueue's and fulock side
+ *
+ * Ugly as hell--any ideas on how to make this look better? The
+ * problem is that we remove stuff from the task struct when we
+ * disable FUSYN or FULOCK.
+ */
+#ifndef CONFIG_FUSYN
+#  define FUQUEUE_INIT_TASK(a) /* Emtpy, nothing to init */
+#else           /* #ifndef CONFIG_FUSYN */
+#  define FUQUEUE_INIT_TASK(task)					\
+	,	/* Grumble, mumble, @od damn it	*/			\
+	.fuqueue_wait_lock = SPIN_LOCK_UNLOCKED,			\
+	.fuqueue_wait = NULL,						\
+	.fuqueue_waiter	= NULL
+#  ifndef CONFIG_FULOCK
+#    define FULOCK_INIT_TASK(a) /* Emtpy, nothing to init */
+#  else         /* #ifndef CONFIG_FULOCK */
+#    define FULOCK_INIT_TASK(task)					\
+	,	/* Grumble, mumble, @od damn it	*/			\
+	.fulock_olist = plist_INIT (&(task).fulock_olist, BOTTOM_PRIO),	\
+	.fulock_olist_lock = SPIN_LOCK_UNLOCKED
+#  endif
+#endif /* #ifndef CONFIG_FUSYN
+ */
+
+/*
  *  INIT_TASK is used to set up the first task table, touch at
  * your own risk!. Base=0, limit=0x1fffff (=2MB)
  */
@@ -72,6 +98,7 @@
 	.lock_depth	= -1,						\
 	.prio		= MAX_PRIO-20,					\
 	.static_prio	= MAX_PRIO-20,					\
+	.boost_prio	= BOTTOM_PRIO,					\
 	.policy		= SCHED_NORMAL,					\
 	.cpus_allowed	= CPU_MASK_ALL,					\
 	.mm		= NULL,						\
@@ -111,7 +138,9 @@
 	.alloc_lock	= SPIN_LOCK_UNLOCKED,				\
 	.proc_lock	= SPIN_LOCK_UNLOCKED,				\
 	.switch_lock	= SPIN_LOCK_UNLOCKED,				\
-	.journal_info	= NULL,						\
+	.journal_info	= NULL						\
+	FUQUEUE_INIT_TASK(tsk)						\
+	FULOCK_INIT_TASK(tsk),						\
 }
 
 
--- include/linux/sched.h:1.1.1.14 Tue Apr 6 01:51:36 2004
+++ include/linux/sched.h Wed Jun 9 23:36:40 2004
@@ -29,6 +29,7 @@
 #include <linux/completion.h>
 #include <linux/pid.h>
 #include <linux/percpu.h>
+#include <linux/plist.h>    /* fulock ownership list */
 
 struct exec_domain;
 
@@ -174,6 +175,9 @@
 
 #define	MAX_SCHEDULE_TIMEOUT	LONG_MAX
 extern signed long FASTCALL(schedule_timeout(signed long timeout));
+struct timeout;
+#define	MAX_SCHEDULE_TIMEOUT_EXT ((struct timeout *) ~0)
+extern void FASTCALL(schedule_timeout_ext (const struct timeout *timeout));
 asmlinkage void schedule(void);
 
 struct namespace;
@@ -286,6 +290,7 @@
 #define MAX_RT_PRIO		MAX_USER_RT_PRIO
 
 #define MAX_PRIO		(MAX_RT_PRIO + 40)
+#define BOTTOM_PRIO		INT_MAX
 
 #define rt_task(p)		((p)->prio < MAX_RT_PRIO)
 
@@ -330,6 +335,8 @@
 };
 
 
+struct fuqueue;
+struct fuqueue_waiter;
 struct io_context;			/* See blkdev.h */
 void exit_io_context(void);
 
@@ -369,7 +376,7 @@
 
 	int lock_depth;		/* Lock depth */
 
-	int prio, static_prio;
+	int prio, static_prio, boost_prio;
 	struct list_head run_list;
 	prio_array_t *array;
 
@@ -493,6 +500,15 @@
 
 	unsigned long ptrace_message;
 	siginfo_t *last_siginfo; /* For ptrace use.  */
+#ifdef CONFIG_FUSYN   /* FIXME: I don't really like this... */
+	struct fuqueue *fuqueue_wait;		/* waiting for this qeueue */
+	struct fuqueue_waiter *fuqueue_waiter;	/* waiting for this qeueue */
+	spinlock_t fuqueue_wait_lock;
+#endif
+#ifdef CONFIG_FULOCK   /* FIXME: I don't really like this... */
+	struct plist fulock_olist;		/* Fulock ownership list */
+	spinlock_t fulock_olist_lock;
+#endif
 };
 
 static inline pid_t process_group(struct task_struct *tsk)
@@ -557,6 +573,9 @@
 extern int task_curr(task_t *p);
 extern int idle_cpu(int cpu);
 
+/* Set the boost priority */
+extern unsigned __prio_boost (task_t *, int);
+
 void yield(void);
 
 /*
@@ -599,6 +618,7 @@
 extern unsigned long itimer_next;
 extern void do_timer(struct pt_regs *);
 
+extern int try_to_wake_up(struct task_struct *p, unsigned int state, int sync);
 extern int FASTCALL(wake_up_state(struct task_struct * tsk, unsigned int state));
 extern int FASTCALL(wake_up_process(struct task_struct * tsk));
 #ifdef CONFIG_SMP
--- kernel/exit.c:1.1.1.11 Tue Apr 6 01:51:37 2004
+++ kernel/exit.c Wed May 26 22:14:57 2004
@@ -22,6 +22,7 @@
 #include <linux/profile.h>
 #include <linux/mount.h>
 #include <linux/proc_fs.h>
+#include <linux/fulock.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -771,6 +772,7 @@
 	}
 
 	acct_process(code);
+	exit_fulocks(tsk);
 	__exit_mm(tsk);
 
 	exit_sem(tsk);
--- kernel/fork.c:1.1.1.14 Tue Apr 6 01:51:37 2004
+++ kernel/fork.c Wed May 26 22:14:57 2004
@@ -31,6 +31,7 @@
 #include <linux/futex.h>
 #include <linux/ptrace.h>
 #include <linux/mount.h>
+#include <linux/fulock.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -964,6 +965,7 @@
 		goto bad_fork_cleanup_signal;
 	if ((retval = copy_namespace(clone_flags, p)))
 		goto bad_fork_cleanup_mm;
+	init_fulocks(p);
 	retval = copy_thread(0, clone_flags, stack_start, stack_size, p, regs);
 	if (retval)
 		goto bad_fork_cleanup_namespace;
--- kernel/sched.c:1.1.1.18 Tue Apr 6 01:51:37 2004
+++ kernel/sched.c Wed Jun 23 00:07:06 2004
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
@@ -647,7 +652,7 @@
  *
  * returns failure only if the task is already active.
  */
-static int try_to_wake_up(task_t * p, unsigned int state, int sync)
+int try_to_wake_up(task_t * p, unsigned int state, int sync)
 {
 	unsigned long flags;
 	int success = 0;
@@ -733,6 +738,8 @@
 	 */
 	p->thread_info->preempt_count = 1;
 #endif
+	/* Initially the task has no priority boosting */
+	p->boost_prio = BOTTOM_PRIO;
 	/*
 	 * Share the timeslice between parent and child, thus the
 	 * total amount of pending timeslices in the system doesn't change,
@@ -1772,6 +1779,9 @@
  * There are circumstances in which we can try to wake a task which has already
  * started to run but is not in state TASK_RUNNING.  try_to_wake_up() returns
  * zero in this (rare) case, and we handle it by continuing to scan the queue.
+ *
+ * fuqueue_wait_cancel needs to hook up here to properly rescheduler
+ * priority inheritance/protected tasks. Check its doc to learn why.
  */
 static void __wake_up_common(wait_queue_head_t *q, unsigned int mode,
 			     int nr_exclusive, int sync)
@@ -1783,6 +1793,7 @@
 		unsigned flags;
 		curr = list_entry(tmp, wait_queue_t, task_list);
 		flags = curr->flags;
+		fuqueue_waiter_cancel(curr->task, -EINTR);
 		if (curr->func(curr, mode, sync) &&
 		    (flags & WQ_FLAG_EXCLUSIVE) &&
 		    !--nr_exclusive)
@@ -1965,12 +1976,17 @@
 
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
@@ -1993,11 +2009,12 @@
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
@@ -2010,6 +2027,7 @@
 	}
 out_unlock:
 	task_rq_unlock(rq, &flags);
+	fuqueue_waiter_chprio(p, old_prio);
 }
 
 EXPORT_SYMBOL(set_user_nice);
@@ -2102,20 +2120,79 @@
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
+       int old_prio, new_dynamic_prio, newprio;
+
+	if (p->boost_prio == prio)
+		return 0;
+	
+	rq = task_rq_lock(p, &flags);
+	old_prio = p->prio;
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
@@ -2150,7 +2227,7 @@
 	 * runqueue lock must be held.
 	 */
 	rq = task_rq_lock(p, &flags);
-
+	oldprio = p->prio;
 	if (policy < 0)
 		policy = p->policy;
 	else {
@@ -2186,7 +2263,6 @@
 	if (array)
 		deactivate_task(p, task_rq(p));
 	retval = 0;
-	oldprio = p->prio;
 	__setscheduler(p, policy, lp.sched_priority);
 	if (array) {
 		__activate_task(p, task_rq(p));
@@ -2204,9 +2280,9 @@
 
 out_unlock:
 	task_rq_unlock(rq, &flags);
+	fuqueue_waiter_chprio(p, oldprio);
 out_unlock_tasklist:
 	read_unlock_irq(&tasklist_lock);
-
 out_nounlock:
 	return retval;
 }
@@ -2868,6 +2944,7 @@
 	struct task_struct *p;
 	struct runqueue *rq;
 	unsigned long flags;
+	unsigned old_prio;
 
 	switch (action) {
 	case CPU_UP_PREPARE:
@@ -2877,8 +2954,10 @@
 		kthread_bind(p, cpu);
 		/* Must be high prio: stop_machine expects to yield to it. */
 		rq = task_rq_lock(p, &flags);
+		old_prio = p->prio;
 		__setscheduler(p, SCHED_FIFO, MAX_RT_PRIO-1);
 		task_rq_unlock(rq, &flags);
+		fuqueue_waiter_chprio(p, old_prio);
 		cpu_rq(cpu)->migration_thread = p;
 		break;
 	case CPU_ONLINE:
--- kernel/signal.c:1.1.1.12 Tue Apr 6 01:51:37 2004
+++ kernel/signal.c Wed Jun 23 00:06:23 2004
@@ -21,6 +21,7 @@
 #include <linux/binfmts.h>
 #include <linux/security.h>
 #include <linux/ptrace.h>
+#include <linux/fuqueue.h>
 #include <asm/param.h>
 #include <asm/uaccess.h>
 #include <asm/siginfo.h>
@@ -521,6 +522,7 @@
 	return signr;
 }
 
+
 /*
  * Tell a process that it has a new active signal..
  *
@@ -544,12 +546,20 @@
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
+	fuqueue_waiter_cancel(t, -EINTR);
+	if (!wake_up_state(t, mask)) {
 		kick_process(t);
+	}
 }
 
 /*
@@ -672,6 +682,8 @@
 				set_tsk_thread_flag(t, TIF_SIGPENDING);
 				state |= TASK_INTERRUPTIBLE;
 			}
+			/* FIXME: I am not that sure we need to cancel here */
+			fuqueue_waiter_cancel(t, -EINTR);
 			wake_up_state(t, state);
 
 			t = next_thread(t);
--- arch/i386/kernel/init_task.c:1.1.1.4 Tue Apr 6 00:21:44 2004
+++ arch/i386/kernel/init_task.c Wed May 26 21:14:03 2004
@@ -4,6 +4,7 @@
 #include <linux/init.h>
 #include <linux/init_task.h>
 #include <linux/fs.h>
+#include <linux/fuqueue.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
