Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319361AbSIKWRA>; Wed, 11 Sep 2002 18:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319363AbSIKWQ7>; Wed, 11 Sep 2002 18:16:59 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:23306
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S319361AbSIKWQt>; Wed, 11 Sep 2002 18:16:49 -0400
Subject: [PATCH] 2.4-ac: scheduler comment infusion
From: Robert Love <rml@tech9.net>
To: alan@redhat.com
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-nUxQqezkd5+pGsiZU81p"
X-Mailer: Ximian Evolution 1.0.8 
Date: 11 Sep 2002 18:21:37 -0400
Message-Id: <1031782897.1023.31.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-nUxQqezkd5+pGsiZU81p
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Alan,

Add a largish amount of comments, mostly by Ingo.  Most functions now
have a nice explanation above them.

Patch is against 2.4.20-pre5-ac4, please apply.

	Robert Love


--=-nUxQqezkd5+pGsiZU81p
Content-Disposition: attachment; filename=210-sched-comments.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=210-sched-comments.patch; charset=ISO-8859-1

diff -urN linux-2.4.20-pre5-ac4-rml/kernel/sched.c linux/kernel/sched.c
--- linux-2.4.20-pre5-ac4-rml/kernel/sched.c	Wed Sep 11 16:56:20 2002
+++ linux/kernel/sched.c	Wed Sep 11 16:57:10 2002
@@ -227,21 +227,24 @@
 	p->array =3D array;
 }
=20
+/*
+ * effective_prio - return the priority that is based on the static
+ * priority but is modified by bonuses/penalties.
+ *
+ * We scale the actual sleep average [0 .... MAX_SLEEP_AVG]
+ * into the -5 ... 0 ... +5 bonus/penalty range.
+ *
+ * We use 25% of the full 0...39 priority range so that:
+ *
+ * 1) nice +19 interactive tasks do not preempt nice 0 CPU hogs.
+ * 2) nice -20 CPU hogs do not get preempted by nice 0 tasks.
+ *
+ * Both properties are important to certain workloads.
+ */
 static inline int effective_prio(task_t *p)
 {
 	int bonus, prio;
=20
-	/*
-	 * Here we scale the actual sleep average [0 .... MAX_SLEEP_AVG]
-	 * into the -5 ... 0 ... +5 bonus/penalty range.
-	 *
-	 * We use 25% of the full 0...39 priority range so that:
-	 *
-	 * 1) nice +19 interactive tasks do not preempt nice 0 CPU hogs.
-	 * 2) nice -20 CPU hogs do not get preempted by nice 0 tasks.
-	 *
-	 * Both properties are important to certain workloads.
-	 */
 	bonus =3D MAX_USER_PRIO*PRIO_BONUS_RATIO*p->sleep_avg/MAX_SLEEP_AVG/100 -
 			MAX_USER_PRIO*PRIO_BONUS_RATIO/100/2;
=20
@@ -253,6 +256,12 @@
 	return prio;
 }
=20
+/*
+ * activate_task - move a task to the runqueue.
+ *
+ * Also update all the scheduling statistics stuff. (sleep average
+ * calculation, priority modifiers, etc.)
+ */
 static inline void activate_task(task_t *p, runqueue_t *rq)
 {
 	unsigned long sleep_time =3D jiffies - p->sleep_timestamp;
@@ -275,6 +284,9 @@
 	rq->nr_running++;
 }
=20
+/*
+ * deactivate_task - remove a task from the runqueue.
+ */
 static inline void deactivate_task(struct task_struct *p, runqueue_t *rq)
 {
 	rq->nr_running--;
@@ -284,6 +296,13 @@
 	p->array =3D NULL;
 }
=20
+/*
+ * resched_task - mark a task 'to be rescheduled now'.
+ *
+ * On UP this means the setting of the need_resched flag, on SMP it
+ * might also involve a cross-CPU call to trigger the scheduler on
+ * the target CPU.
+ */
 static inline void resched_task(task_t *p)
 {
 #ifdef CONFIG_SMP
@@ -302,8 +321,10 @@
 #ifdef CONFIG_SMP
=20
 /*
- * Wait for a process to unschedule. This is used by the exit() and
- * ptrace() code.
+ * wait_task_inactive - wait for a thread to unschedule.
+ *
+ * The caller must ensure that the task *will* unschedule sometime soon,
+ * else this function might spin for a *long* time.
  */
 void wait_task_inactive(task_t * p)
 {
@@ -325,9 +346,10 @@
 }
=20
 /*
- * Kick the remote CPU if the task is running currently,
- * this code is used by the signal code to signal tasks
- * which are in user-mode as quickly as possible.
+ * kick_if_running - kick the remote CPU if the task is running currently.
+ *
+ * This code is used by the signal code to signal tasks
+ * which are in user-mode, as quickly as possible.
  *
  * (Note that we do this lockless - if the task does anything
  * while the message is in flight then it will notice the
@@ -340,13 +362,18 @@
 }
 #endif
=20
-/*
- * Wake up a process. Put it on the run-queue if it's not
- * already there.  The "current" process is always on the
- * run-queue (except when the actual re-schedule is in
- * progress), and as such you're allowed to do the simpler
- * "current->state =3D TASK_RUNNING" to mark yourself runnable
- * without the overhead of this.
+/***
+ * try_to_wake_up - wake up a thread
+ * @p: the to-be-woken-up thread
+ * @sync: do a synchronous wakeup?
+ *
+ * Put it on the run-queue if it's not already there. The "current"
+ * thread is always on the run-queue (except when the actual
+ * re-schedule is in progress), and as such you're allowed to do
+ * the simpler "current->state =3D TASK_RUNNING" to mark yourself
+ * runnable without the overhead of this.
+ *
+ * returns failure only if the task is already active.
  */
 static int try_to_wake_up(task_t * p, int sync)
 {
@@ -374,9 +401,6 @@
 		if (old_state =3D=3D TASK_UNINTERRUPTIBLE)
 			rq->nr_uninterruptible--;
 		activate_task(p, rq);
-		/*
-		 * If sync is set, a resched_task() is a NOOP
-		 */
 		if (p->prio < rq->curr->prio)
 			resched_task(rq->curr);
 		success =3D 1;
@@ -392,6 +416,12 @@
 	return try_to_wake_up(p, 0);
 }
=20
+/*
+ * wake_up_forked_process - wake up a freshly forked process.
+ *
+ * This function will do some initial scheduler statistics housekeeping
+ * that must be done for every newly created process.
+ */
 void wake_up_forked_process(task_t * p)
 {
 	runqueue_t *rq =3D this_rq_lock();
@@ -416,7 +446,7 @@
 /*
  * Potentially available exiting-child timeslices are
  * retrieved here - this way the parent does not get
- * penalized for creating too many processes.
+ * penalized for creating too many threads.
  *
  * (this cannot be used to 'generate' timeslices
  * artificially, because any timeslice recovered here
@@ -438,6 +468,11 @@
 			p->sleep_avg) / (EXIT_WEIGHT + 1);
 }
=20
+/**
+ * schedule_tail - first thing a freshly forked thread must call.
+ *
+ * @prev: the thread we just switched away from.
+ */
 #if CONFIG_SMP
 asmlinkage void schedule_tail(task_t *prev)
 {
@@ -446,6 +481,10 @@
 }
 #endif
=20
+/*
+ * context_switch - switch to the new MM and the new
+ * thread's register state.
+ */
 static inline task_t * context_switch(task_t *prev, task_t *next)
 {
 	struct mm_struct *mm =3D next->mm;
@@ -469,6 +508,13 @@
 	return prev;
 }
=20
+/*
+ * nr_running, nr_uninterruptible and nr_context_switches:
+ *
+ * externally visible scheduler statistics: current number of runnable
+ * threads, current number of uninterruptible-sleeping threads, total
+ * number of context switches performed since bootup.
+ */
 unsigned long nr_running(void)
 {
 	unsigned long i, sum =3D 0;
@@ -499,6 +545,10 @@
 	return sum;
 }
=20
+/**
+ * idle_cpu - is a given cpu idle currently?
+ * @cpu: the processor in question.
+ */
 inline int idle_cpu(int cpu)
 {
 	return cpu_curr(cpu) =3D=3D cpu_rq(cpu)->idle;
@@ -506,8 +556,10 @@
=20
 #if CONFIG_SMP
 /*
- * Lock the busiest runqueue as well, this_rq is locked already.
- * Recalculate nr_running if we have to drop the runqueue lock.
+ * double_lock_balance - lock the busiest runqueue
+ *
+ * this_rq is locked already. Recalculate nr_running if we have to
+ * drop the runqueue lock.
  */
 static inline unsigned int double_lock_balance(runqueue_t *this_rq,
 	runqueue_t *busiest, int this_cpu, int idle, unsigned int nr_running)
@@ -691,8 +743,8 @@
 }
=20
 /*
- * One of the idle_cpu_tick() or the busy_cpu_tick() function will
- * gets called every timer tick, on every CPU. Our balancing action
+ * One of the idle_cpu_tick() and busy_cpu_tick() functions will
+ * get called every timer tick, on every CPU. Our balancing action
  * frequency and balancing agressivity depends on whether the CPU is
  * idle or not.
  *
@@ -806,7 +858,7 @@
 void scheduling_functions_start_here(void) { }
=20
 /*
- * 'schedule()' is the main scheduler function.
+ * schedule() is the main scheduler function.
  */
 asmlinkage void schedule(void)
 {
@@ -916,6 +968,12 @@
 	}
 }
=20
+/**
+ * __wake_up - wake up threads blocked on a waitqueue.
+ * @q: the waitqueue
+ * @mode: which threads
+ * @nr_exclusive: how many wake-one or wake-many threads to wake up
+ */
 void __wake_up(wait_queue_head_t *q, unsigned int mode, int nr_exclusive)
 {
 	unsigned long flags;
@@ -930,6 +988,17 @@
=20
 #if CONFIG_SMP
=20
+/**
+ * __wake_up - sync- wake up threads blocked on a waitqueue.
+ * @q: the waitqueue
+ * @mode: which threads
+ * @nr_exclusive: how many wake-one or wake-many threads to wake up
+ *
+ * The sync wakeup differs that the waker knows that it will schedule
+ * away soon, so while the target thread will be woken up, it will not
+ * be migrated to another CPU - ie. the two threads are 'synchronized'
+ * with each other. This can prevent needless bouncing between CPUs.
+ */
 void __wake_up_sync(wait_queue_head_t *q, unsigned int mode, int nr_exclus=
ive)
 {
 	unsigned long flags;
@@ -1079,12 +1148,13 @@
=20
 #ifndef __alpha__
=20
-/*
- * This has been replaced by sys_setpriority.  Maybe it should be
- * moved into the arch dependent tree for those ports that require
- * it for backward compatibility?
+/**
+ * sys_nice - change the priority of the current process.
+ * @increment: priority increment
+ *
+ * sys_setpriority is a more generic, but much slower function that
+ * does similar things.
  */
-
 asmlinkage long sys_nice(int increment)
 {
 	long nice;
@@ -1114,9 +1184,11 @@
=20
 #endif
=20
-/*
- * This is the priority value as seen by users in /proc
+/**
+ * task_prio - return the priority value of a given task.
+ * @p: the task in question.
  *
+ * This is the priority value as seen by users in /proc.
  * RT tasks are offset by -200. Normal tasks are centered
  * around 0, value goes from -16 to +15.
  */
@@ -1125,16 +1197,27 @@
 	return p->prio - MAX_USER_RT_PRIO;
 }
=20
+/**
+ * task_nice - return the nice value of a given task.
+ * @p: the task in question.
+ */
 int task_nice(task_t *p)
 {
 	return TASK_NICE(p);
 }
=20
+/**
+ * find_process_by_pid - find a process with a matching PID value.
+ * @pid: the pid in question.
+ */
 static inline task_t *find_process_by_pid(pid_t pid)
 {
 	return pid ? find_task_by_pid(pid) : current;
 }
=20
+/*
+ * setscheduler - change the scheduling policy and/or RT priority of a thr=
ead.
+ */
 static int setscheduler(pid_t pid, int policy, struct sched_param *param)
 {
 	struct sched_param lp;
@@ -1217,17 +1300,32 @@
 	return retval;
 }
=20
+/**
+ * sys_sched_setscheduler - set/change the scheduler policy and RT priorit=
y
+ * @pid: the pid in question.
+ * @policy: new policy
+ * @param: structure containing the new RT priority.
+ */
 asmlinkage long sys_sched_setscheduler(pid_t pid, int policy,
 				      struct sched_param *param)
 {
 	return setscheduler(pid, policy, param);
 }
=20
+/**
+ * sys_sched_setparam - set/change the RT priority of a thread
+ * @pid: the pid in question.
+ * @param: structure containing the new RT priority.
+ */
 asmlinkage long sys_sched_setparam(pid_t pid, struct sched_param *param)
 {
 	return setscheduler(pid, -1, param);
 }
=20
+/**
+ * sys_sched_getscheduler - get the policy (scheduling class) of a thread
+ * @pid: the pid in question.
+ */
 asmlinkage long sys_sched_getscheduler(pid_t pid)
 {
 	int retval =3D -EINVAL;
@@ -1247,6 +1345,11 @@
 	return retval;
 }
=20
+/**
+ * sys_sched_getparam - get the RT priority of a thread
+ * @pid: the pid in question.
+ * @param: sched_param structure containing the RT priority.
+ */
 asmlinkage long sys_sched_getparam(pid_t pid, struct sched_param *param)
 {
 	struct sched_param lp;
@@ -1411,6 +1514,13 @@
 	sys_sched_yield();
 }
=20
+/**
+ * sys_sched_get_priority_max - return maximum RT priority.
+ * @policy: scheduling class.
+ *
+ * this syscall returns the maximum rt_priority that can be used
+ * by a given scheduling class.
+ */
 asmlinkage long sys_sched_get_priority_max(int policy)
 {
 	int ret =3D -EINVAL;
@@ -1427,6 +1537,13 @@
 	return ret;
 }
=20
+/**
+ * sys_sched_get_priority_min - return minimum RT priority.
+ * @policy: scheduling class.
+ *
+ * this syscall returns the minimum rt_priority that can be used
+ * by a given scheduling class.
+ */
 asmlinkage long sys_sched_get_priority_min(int policy)
 {
 	int ret =3D -EINVAL;
@@ -1442,6 +1559,14 @@
 	return ret;
 }
=20
+/**
+ * sys_sched_rr_get_interval - return the default timeslice of a process.
+ * @pid: pid of the process.
+ * @interval: userspace pointer to the timeslice value.
+ *
+ * this syscall writes the default timeslice value of a given process
+ * into the user-space timespec buffer. A value of '0' means infinity.
+ */
 asmlinkage long sys_sched_rr_get_interval(pid_t pid, struct timespec *inte=
rval)
 {
 	int retval =3D -EINVAL;
@@ -1734,6 +1859,10 @@
 	;
 }
=20
+/*
+ * migration_thread - this is a highprio system thread that performs
+ * thread migration by 'pulling' threads into the target runqueue.
+ */
 static int migration_thread(void * bind_cpu)
 {
 	struct sched_param param =3D { sched_priority: MAX_RT_PRIO-1 };

--=-nUxQqezkd5+pGsiZU81p--

