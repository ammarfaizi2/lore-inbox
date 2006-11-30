Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967730AbWK3AbX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967730AbWK3AbX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 19:31:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967732AbWK3AbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 19:31:23 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:22233 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S967730AbWK3AbW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 19:31:22 -0500
Date: Wed, 29 Nov 2006 16:32:43 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC PATCH -rt] RCU priority boosting that survives mild testing
Message-ID: <20061130003243.GA12138@us.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch boosts the priority of RCU read-side critical sections when
they block to prevent them from being preempted by other non-realtime
threads.  This patch allows transitive boosting (e.g., to processes
holding locks waited on by the RCU read-side critical section) and
actually survives light testing, in contrast with its rather large
number of predecessors.  (All of which are preserved for posterity at
http://rdrop.com/users/paulmck/patches -- nothing to hide, so there!!!)

The trick is to provide a per-task mutex that is acquired when a task
enters the scheduler while in an RCU read-side critical section.  This
mutex is released by the outermost rcu_read_unlock().  This works even
if rcu_read_unlock() is invoked by (say) a hardware irq handler, since
the critical section cannot be preempted in that case.  One remaining
case not handled is the following:

	rcu_read_lock();
	/* code that might be preempted. */
	local_irq_save(oldirq);
	rcu_read_unlock();
	local_irq_restore(oldirq);

If this case is important to you, please don't keep it a secret!!!

A separate task (not yet implemented, but in process) can then acquire
a given task's mutex, boosting its priority for the duration of the
RCU read-side critical section, as needed to expedite a given RCU
grace period.  The formerly painful races with rcu_read_unlock() are now
harmless -- the boosting task simply needlessly acquires and immediately
releases the mutex in that case.

There is a new CONFIG_PREEMPT_RCU_BOOST that enables the boosting,
defaulting to "n" because this code is quite new and because people
writing realtime applications that carefully avoid realtime-priority CPU
hogs may not want the degradation in scheduling latency that comes with
this patch.  This config variable should also greatly reduce the risk
that this patch might otherwise pose to innocent bystanders.

Some questions:

o	I currently unconditionally boost to the highest non-realtime
	priority when a task blocks in an RCU read-side critical section.
	This is to aid in testing, but I am thinking in terms of
	removing it.  It degrades scheduling latency, and if there
	is a real problem, the TBD booster task should kick it later.
	Plus, getting rid of this would significantly reduce the size
	and intrusiveness of the patch.  Does this approach make sense?

o	I believe I can acquire a mutex with impunity near the beginning
	of __schedule().  I have a flag that prevents more than one
	level of recursion in face of nested preemptions (e.g., due to
	getting a scheduling-clock interrupt just as one was starting
	__schedule() anyway).  Any gotchas I am missing?

o	Is the code snippet above likely to show up?  If it is, I would
	check for interrupts disabled in rcu_read_unlock(), IPI myself if
	so, and clean up in preempt_schedule_irq().  I would like to avoid
	this due to the extra test on the preemption path.  Thoughts?

I am in the process of testing on 2.6.19-rc6-rt10.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---

 include/linux/init_task.h  |   12 ++++++++++++
 include/linux/rcupreempt.h |    4 ++++
 include/linux/sched.h      |   12 ++++++++++++
 kernel/Kconfig.preempt     |   11 +++++++++++
 kernel/rcupreempt.c        |   23 ++++++++++++++++++++---
 kernel/rtmutex.c           |    9 ++++++---
 kernel/sched.c             |   17 +++++++++++++++++
 kernel/softirq.c           |    1 +
 8 files changed, 83 insertions(+), 6 deletions(-)

diff -urpNa -X dontdiff linux-2.6.18-rt3/include/linux/init_task.h linux-2.6.18-rt3-rcubp/include/linux/init_task.h
--- linux-2.6.18-rt3/include/linux/init_task.h	2006-10-09 17:27:12.000000000 -0700
+++ linux-2.6.18-rt3-rcubp/include/linux/init_task.h	2006-11-27 11:04:03.000000000 -0800
@@ -91,6 +91,7 @@ extern struct group_info init_groups;
 	.prio		= MAX_PRIO-20,					\
 	.static_prio	= MAX_PRIO-20,					\
 	.normal_prio	= MAX_PRIO-20,					\
+	INIT_RCU_PRIO							\
 	.policy		= SCHED_NORMAL,					\
 	.cpus_allowed	= CPU_MASK_ALL,					\
 	.mm		= NULL,						\
@@ -98,6 +99,7 @@ extern struct group_info init_groups;
 	.run_list	= LIST_HEAD_INIT(tsk.run_list),			\
 	.ioprio		= 0,						\
 	.time_slice	= HZ,						\
+	INIT_RCU_BOOST							\
 	.tasks		= LIST_HEAD_INIT(tsk.tasks),			\
 	.ptrace_children= LIST_HEAD_INIT(tsk.ptrace_children),		\
 	.ptrace_list	= LIST_HEAD_INIT(tsk.ptrace_list),		\
@@ -132,6 +134,16 @@ extern struct group_info init_groups;
 	INIT_LOCKDEP							\
 }
 
+#ifdef CONFIG_PREEMPT_RCU_BOOST
+#define INIT_RCU_PRIO .rcu_prio = MAX_PRIO,
+#define INIT_RCU_BOOST \
+	.rcu_boost = __SPIN_LOCK_UNLOCKED(tsk.rcu_boost), \
+	.rcu_boost_held = 0,
+#else /* #ifdef CONFIG_PREEMPT_RCU_BOOST */
+#define INIT_RCU_PRIO
+#define INIT_RCU_BOOST
+#endif /* #else #ifdef CONFIG_PREEMPT_RCU_BOOST */
+
 
 #define INIT_CPU_TIMERS(cpu_timers)					\
 {									\
diff -urpNa -X dontdiff linux-2.6.18-rt3/include/linux/rcupreempt.h linux-2.6.18-rt3-rcubp/include/linux/rcupreempt.h
--- linux-2.6.18-rt3/include/linux/rcupreempt.h	2006-10-09 17:27:12.000000000 -0700
+++ linux-2.6.18-rt3-rcubp/include/linux/rcupreempt.h	2006-11-27 11:05:13.000000000 -0800
@@ -42,6 +42,10 @@
 #include <linux/cpumask.h>
 #include <linux/seqlock.h>
 
+#ifdef CONFIG_PREEMPT_RCU_BOOST
+#define PREEMPT_RCU_BOOST_PRIO MAX_USER_RT_PRIO  /* Initial boost level. */
+#endif /* #ifdef CONFIG_PREEMPT_RCU_BOOST */
+
 #define rcu_qsctr_inc(cpu)
 #define rcu_bh_qsctr_inc(cpu)
 #define call_rcu_bh(head, rcu) call_rcu(head, rcu)
diff -urpNa -X dontdiff linux-2.6.18-rt3/include/linux/sched.h linux-2.6.18-rt3-rcubp/include/linux/sched.h
--- linux-2.6.18-rt3/include/linux/sched.h	2006-10-09 17:27:12.000000000 -0700
+++ linux-2.6.18-rt3-rcubp/include/linux/sched.h	2006-11-27 17:25:35.000000000 -0800
@@ -652,6 +652,13 @@ struct signal_struct {
 #define batch_task(p)		(unlikely((p)->policy == SCHED_BATCH))
 #define has_rt_policy(p) \
 	unlikely((p)->policy != SCHED_NORMAL && (p)->policy != SCHED_BATCH)
+#ifdef CONFIG_PREEMPT_RCU_BOOST
+#define set_rcu_prio(p, prio)  ((p)->rcu_prio = (prio))
+#define get_rcu_prio(p) ((p)->rcu_prio)
+#else /* #ifdef CONFIG_PREEMPT_RCU_BOOST */
+#define set_rcu_prio(p, prio)  do { } while (0)
+#define get_rcu_prio(p) MAX_PRIO
+#endif /* #else #ifdef CONFIG_PREEMPT_RCU_BOOST */
 
 /*
  * Some day this will be a full-fledged user tracking system..
@@ -926,6 +933,11 @@ struct task_struct {
 #endif
 	int load_weight;	/* for niceness load balancing purposes */
 	int prio, static_prio, normal_prio;
+#ifdef CONFIG_PREEMPT_RCU_BOOST
+	int rcu_prio;
+	spinlock_t rcu_boost;
+	int rcu_boost_held;
+#endif
 	struct list_head run_list;
 	struct prio_array *array;
 
diff -urpNa -X dontdiff linux-2.6.18-rt3/kernel/Kconfig.preempt linux-2.6.18-rt3-rcubp/kernel/Kconfig.preempt
--- linux-2.6.18-rt3/kernel/Kconfig.preempt	2006-10-09 17:27:12.000000000 -0700
+++ linux-2.6.18-rt3-rcubp/kernel/Kconfig.preempt	2006-11-28 12:52:34.000000000 -0800
@@ -175,3 +175,14 @@ config RCU_TRACE
 
 	  Say Y here if you want to enable RCU tracing
 	  Say N if you are unsure.
+
+config PREEMPT_RCU_BOOST
+	bool "Enable priority boosting of RCU read-side critical sections"
+	depends on PREEMPT_RCU
+	default n
+	help
+	  This option permits priority boosting of RCU read-side critical
+	  sections that have been preempted in order to prevent indefinite
+	  delay of grace periods in face of runaway non-realtime processes.
+
+	  Say N if you are unsure.
diff -urpNa -X dontdiff linux-2.6.18-rt3/kernel/rcupreempt.c linux-2.6.18-rt3-rcubp/kernel/rcupreempt.c
--- linux-2.6.18-rt3/kernel/rcupreempt.c	2006-10-09 17:27:12.000000000 -0700
+++ linux-2.6.18-rt3-rcubp/kernel/rcupreempt.c	2006-11-29 12:03:31.000000000 -0800
@@ -139,7 +139,9 @@ void __rcu_read_unlock(void)
 	unsigned long oldirq;
 
 	local_irq_save(oldirq);
-	if (--current->rcu_read_lock_nesting == 0) {
+	if (--current->rcu_read_lock_nesting != 0) {
+		local_irq_restore(oldirq);
+	} else {
 
 		/*
 		 * Just atomically decrement whatever we incremented.
@@ -155,9 +157,24 @@ void __rcu_read_unlock(void)
 			atomic_dec(current->rcu_flipctr2);
 			current->rcu_flipctr2 = NULL;
 		}
+		local_irq_restore(oldirq);
+#ifdef CONFIG_PREEMPT_RCU_BOOST
+		if (unlikely(current->rcu_prio <= PREEMPT_RCU_BOOST_PRIO)) {
+			int new_prio = MAX_PRIO;
+
+			if (current->rcu_boost_held) {
+				spin_unlock(&current->rcu_boost);
+				current->rcu_boost_held = 0;
+			}
+			if (new_prio > current->static_prio)
+				new_prio = current->static_prio;
+			if (new_prio > current->normal_prio)
+				new_prio = current->normal_prio;
+			rt_mutex_setprio(current, new_prio);
+			current->rcu_prio = MAX_PRIO;
+		}
+#endif /* #ifdef CONFIG_PREEMPT_RCU_BOOST */
 	}
-
-	local_irq_restore(oldirq);
 }
 
 static void __rcu_advance_callbacks(void)
diff -urpNa -X dontdiff linux-2.6.18-rt3/kernel/rtmutex.c linux-2.6.18-rt3-rcubp/kernel/rtmutex.c
--- linux-2.6.18-rt3/kernel/rtmutex.c	2006-10-09 17:27:12.000000000 -0700
+++ linux-2.6.18-rt3-rcubp/kernel/rtmutex.c	2006-11-27 17:22:51.000000000 -0800
@@ -128,11 +128,14 @@ static inline void init_lists(struct rt_
  */
 int rt_mutex_getprio(struct task_struct *task)
 {
+	int prio = task->normal_prio;
+
+	if (get_rcu_prio(task) < prio)
+		prio = get_rcu_prio(task);
 	if (likely(!task_has_pi_waiters(task)))
-		return task->normal_prio;
+		return prio;
 
-	return min(task_top_pi_waiter(task)->pi_list_entry.prio,
-		   task->normal_prio);
+	return min(task_top_pi_waiter(task)->pi_list_entry.prio, prio);
 }
 
 /*
diff -urpNa -X dontdiff linux-2.6.18-rt3/kernel/sched.c linux-2.6.18-rt3-rcubp/kernel/sched.c
--- linux-2.6.18-rt3/kernel/sched.c	2006-10-09 17:27:12.000000000 -0700
+++ linux-2.6.18-rt3-rcubp/kernel/sched.c	2006-11-29 12:01:59.000000000 -0800
@@ -1918,6 +1918,7 @@ void fastcall sched_fork(struct task_str
 	 * Make sure we do not leak PI boosting priority to the child:
 	 */
 	p->prio = current->normal_prio;
+	set_rcu_prio(p, MAX_PRIO);
 
 	INIT_LIST_HEAD(&p->run_list);
 	p->array = NULL;
@@ -2000,6 +2001,7 @@ void fastcall wake_up_new_task(struct ta
 			else {
 				p->prio = current->prio;
 				p->normal_prio = current->normal_prio;
+				set_rcu_prio(p, MAX_PRIO);
 				__activate_task_after(p, current, rq);
 			}
 			set_need_resched();
@@ -3725,6 +3727,20 @@ void __sched __schedule(void)
 	}
 	profile_hit(SCHED_PROFILING, __builtin_return_address(0));
 
+#ifdef CONFIG_PREEMPT_RCU_BOOST
+	if (unlikely(current->rcu_read_lock_nesting > 0) &&
+	    (current->rcu_prio > PREEMPT_RCU_BOOST_PRIO)) {
+		current->rcu_prio = PREEMPT_RCU_BOOST_PRIO;
+		if (current->rcu_prio < current->prio) {
+			rt_mutex_setprio(current, current->rcu_prio);
+			if (!current->rcu_boost_held) {
+				current->rcu_boost_held = 1;
+				spin_lock(&current->rcu_boost);
+			}
+		}
+	}
+#endif /* #ifdef CONFIG_PREEMPT_RCU_BOOST */
+
 	preempt_disable(); // FIXME: disable irqs here
 	prev = current;
 	release_kernel_lock(prev);
@@ -5479,6 +5525,7 @@ void __devinit init_idle(struct task_str
 	idle->sleep_avg = 0;
 	idle->array = NULL;
 	idle->prio = idle->normal_prio = MAX_PRIO;
+	set_rcu_prio(idle, MAX_PRIO);
 	idle->state = TASK_RUNNING;
 	idle->cpus_allowed = cpumask_of_cpu(cpu);
 	set_task_cpu(idle, cpu);
diff -urpNa -X dontdiff linux-2.6.18-rt3/kernel/softirq.c linux-2.6.18-rt3-rcubp/kernel/softirq.c
--- linux-2.6.18-rt3/kernel/softirq.c	2006-10-09 17:27:12.000000000 -0700
+++ linux-2.6.18-rt3-rcubp/kernel/softirq.c	2006-11-27 17:25:06.000000000 -0800
@@ -108,6 +108,7 @@ static void wakeup_softirqd_prio(int sof
 	struct task_struct *tsk = __get_cpu_var(ksoftirqd[softirq].tsk);
 
 	if (tsk) {
+		/* Why not tsk->normal_prio > prio? */
 		if (tsk->normal_prio != prio)
 			set_thread_priority(tsk, prio);
 

----- End forwarded message -----
