Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315481AbSG1Jwx>; Sun, 28 Jul 2002 05:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315529AbSG1Jwx>; Sun, 28 Jul 2002 05:52:53 -0400
Received: from mx2.elte.hu ([157.181.151.9]:17614 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S315481AbSG1Jwq>;
	Sun, 28 Jul 2002 05:52:46 -0400
Date: Sun, 28 Jul 2002 11:54:54 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] sched-2.5.29-B1
Message-ID: <Pine.LNX.4.44.0207281152430.12794-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch is a comment update of sched.c and it also does a small
cleanup in migration_thread().

 sched.c |  248 ++++++++++++++++++++++++++++++++++++++++++++++++++++------------
 1 files changed, 202 insertions(+), 46 deletions(-)

	Ingo

--- linux/kernel/sched.c.orig	Sun Jul 28 10:13:00 2002
+++ linux/kernel/sched.c	Sun Jul 28 11:54:34 2002
@@ -111,9 +111,9 @@
  * BASE_TIMESLICE scales user-nice values [ -20 ... 19 ]
  * to time slice values.
  *
- * The higher a process's priority, the bigger timeslices
+ * The higher a thread's priority, the bigger timeslices
  * it gets during one round of execution. But even the lowest
- * priority process gets MIN_TIMESLICE worth of execution time.
+ * priority thread gets MIN_TIMESLICE worth of execution time.
  *
  * task_timeslice() is the interface that is used by the scheduler.
  */
@@ -144,7 +144,7 @@
  * This is the main, per-CPU runqueue data structure.
  *
  * Locking rule: those places that want to lock multiple runqueues
- * (such as the load balancing or the process migration code), lock
+ * (such as the load balancing or the thread migration code), lock
  * acquire operations must be ordered by ascending &runqueue.
  */
 struct runqueue {
@@ -241,21 +241,24 @@
 	p->array = array;
 }
 
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
 	bonus = MAX_USER_PRIO*PRIO_BONUS_RATIO*p->sleep_avg/MAX_SLEEP_AVG/100 -
 			MAX_USER_PRIO*PRIO_BONUS_RATIO/100/2;
 
@@ -267,6 +270,12 @@
 	return prio;
 }
 
+/*
+ * activate_task - move a task to the runqueue.
+
+ * Also update all the scheduling statistics stuff. (sleep average
+ * calculation, priority modifiers, etc.)
+ */
 static inline void activate_task(task_t *p, runqueue_t *rq)
 {
 	unsigned long sleep_time = jiffies - p->sleep_timestamp;
@@ -289,6 +298,9 @@
 	rq->nr_running++;
 }
 
+/*
+ * deactivate_task - remove a task from the runqueue.
+ */
 static inline void deactivate_task(struct task_struct *p, runqueue_t *rq)
 {
 	rq->nr_running--;
@@ -298,6 +310,13 @@
 	p->array = NULL;
 }
 
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
@@ -320,8 +339,10 @@
 #ifdef CONFIG_SMP
 
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
@@ -353,9 +374,10 @@
 #endif
 
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
@@ -367,13 +389,16 @@
 		resched_task(p);
 }
 
-/*
- * Wake up a process. Put it on the run-queue if it's not
- * already there.  The "current" process is always on the
- * run-queue (except when the actual re-schedule is in
- * progress), and as such you're allowed to do the simpler
- * "current->state = TASK_RUNNING" to mark yourself runnable
- * without the overhead of this.
+/***
+ * try_to_wake_up - wake up a thread
+ * @p: the to-be-woken-up thread
+ * @sync: do a synchronous wakeup?
+ *
+ * Put it on the run-queue if it's not already there. The "current"
+ * thread is always on the run-queue (except when the actual
+ * re-schedule is in progress), and as such you're allowed to do
+ * the simpler "current->state = TASK_RUNNING" to mark yourself
+ * runnable without the overhead of this.
  *
  * returns failure only if the task is already active.
  */
@@ -419,6 +444,12 @@
 	return try_to_wake_up(p, 0);
 }
 
+/*
+ * wake_up_forked_process - wake up a freshly forked process.
+ *
+ * This function will do some initial scheduler statistics housekeeping
+ * that must be done for every newly created process.
+ */
 void wake_up_forked_process(task_t * p)
 {
 	runqueue_t *rq = this_rq_lock();
@@ -443,7 +474,7 @@
 /*
  * Potentially available exiting-child timeslices are
  * retrieved here - this way the parent does not get
- * penalized for creating too many processes.
+ * penalized for creating too many threads.
  *
  * (this cannot be used to 'generate' timeslices
  * artificially, because any timeslice recovered here
@@ -467,6 +498,10 @@
 			p->sleep_avg) / (EXIT_WEIGHT + 1);
 }
 
+/**
+ * schedule_tail - first thing a freshly forked thread must call.
+ * @prev: the thread we just switched away from.
+ */
 #if CONFIG_SMP || CONFIG_PREEMPT
 asmlinkage void schedule_tail(task_t *prev)
 {
@@ -474,6 +509,10 @@
 }
 #endif
 
+/*
+ * context_switch - switch to the new MM and the new
+ * thread's register state.
+ */
 static inline task_t * context_switch(task_t *prev, task_t *next)
 {
 	struct mm_struct *mm = next->mm;
@@ -497,6 +536,13 @@
 	return prev;
 }
 
+/*
+ * nr_running, nr_uninterruptible and nr_context_switches:
+ *
+ * externally visible scheduler statistics: current number of runnable
+ * threads, current number of uninterruptible-sleeping threads, total
+ * number of context switches performed since bootup.
+ */
 unsigned long nr_running(void)
 {
 	unsigned long i, sum = 0;
@@ -564,8 +610,10 @@
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
@@ -586,6 +634,9 @@
 	return nr_running;
 }
 
+/*
+ * find_busiest_queue - find the busiest runqueue.
+ */
 static inline runqueue_t *find_busiest_queue(runqueue_t *this_rq, int this_cpu, int idle, int *imbalance)
 {
 	int nr_running, load, max_load, i;
@@ -662,7 +713,7 @@
 }
 
 /*
- * Move a task from a remote runqueue to the local runqueue.
+ * pull_task - move a task from a remote runqueue to the local runqueue.
  * Both runqueues must be locked.
  */
 static inline void pull_task(runqueue_t *src_rq, prio_array_t *src_array, task_t *p, runqueue_t *this_rq, int this_cpu)
@@ -766,8 +817,8 @@
 }
 
 /*
- * One of the idle_cpu_tick() or the busy_cpu_tick() function will
- * gets called every timer tick, on every CPU. Our balancing action
+ * One of the idle_cpu_tick() and busy_cpu_tick() functions will
+ * get called every timer tick, on every CPU. Our balancing action
  * frequency and balancing agressivity depends on whether the CPU is
  * idle or not.
  *
@@ -852,7 +903,7 @@
 	/*
 	 * The task was running during this tick - update the
 	 * time slice counter and the sleep average. Note: we
-	 * do not update a process's priority until it either
+	 * do not update a thread's priority until it either
 	 * goes to sleep or uses up its timeslice. This makes
 	 * it possible for interactive tasks to use up their
 	 * timeslices at their highest priority levels.
@@ -884,7 +935,7 @@
 void scheduling_functions_start_here(void) { }
 
 /*
- * 'schedule()' is the main scheduler function.
+ * schedule() is the main scheduler function.
  */
 asmlinkage void schedule(void)
 {
@@ -1038,6 +1089,12 @@
 	}
 }
 
+/**
+ * __wake_up - wake up threads blocked on a waitqueue.
+ * @q: the waitqueue
+ * @mode: which threads
+ * @nr_exclusive: how many wake-one or wake-many threads to wake up
+ */
 void __wake_up(wait_queue_head_t *q, unsigned int mode, int nr_exclusive)
 {
 	unsigned long flags;
@@ -1060,6 +1117,17 @@
 
 #if CONFIG_SMP
 
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
 void __wake_up_sync(wait_queue_head_t *q, unsigned int mode, int nr_exclusive)
 {
 	unsigned long flags;
@@ -1211,11 +1279,12 @@
 #ifndef __alpha__
 
 /*
- * This has been replaced by sys_setpriority.  Maybe it should be
- * moved into the arch dependent tree for those ports that require
- * it for backward compatibility?
+ * sys_nice - change the priority of the current process.
+ * @increment: priority increment
+ *
+ * sys_setpriority is a more generic, but much slower function that
+ * does similar things.
  */
-
 asmlinkage long sys_nice(int increment)
 {
 	int retval;
@@ -1251,9 +1320,11 @@
 
 #endif
 
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
@@ -1262,21 +1333,36 @@
 	return p->prio - MAX_USER_RT_PRIO;
 }
 
+/**
+ * task_nice - return the nice value of a given task.
+ * @p: the task in question.
+ */
 int task_nice(task_t *p)
 {
 	return TASK_NICE(p);
 }
 
+/**
+ * idle_cpu - is a given cpu idle currently?
+ * @cpu: the processor in question.
+ */
 int idle_cpu(int cpu)
 {
 	return cpu_curr(cpu) == cpu_rq(cpu)->idle;
 }
 
+/**
+ * find_process_by_pid - find a process with a matching PID value.
+ * @pid: the pid in question.
+ */
 static inline task_t *find_process_by_pid(pid_t pid)
 {
 	return pid ? find_task_by_pid(pid) : current;
 }
 
+/*
+ * setscheduler - change the scheduling policy and/or RT priority of a thread.
+ */
 static int setscheduler(pid_t pid, int policy, struct sched_param *param)
 {
 	struct sched_param lp;
@@ -1363,17 +1449,32 @@
 	return retval;
 }
 
+/**
+ * sys_sched_setscheduler - set/change the scheduler policy and RT priority
+ * @pid: the pid in question.
+ * @policy: new policy
+ * @param: structure containing the new RT priority.
+ */
 asmlinkage long sys_sched_setscheduler(pid_t pid, int policy,
 				      struct sched_param *param)
 {
 	return setscheduler(pid, policy, param);
 }
 
+/**
+ * sys_sched_setparam - set/change the RT priority of a thread
+ * @pid: the pid in question.
+ * @param: structure containing the new RT priority.
+ */
 asmlinkage long sys_sched_setparam(pid_t pid, struct sched_param *param)
 {
 	return setscheduler(pid, -1, param);
 }
 
+/**
+ * sys_sched_getscheduler - get the policy (scheduling class) of a thread
+ * @pid: the pid in question.
+ */
 asmlinkage long sys_sched_getscheduler(pid_t pid)
 {
 	int retval = -EINVAL;
@@ -1396,6 +1497,11 @@
 	return retval;
 }
 
+/**
+ * sys_sched_getscheduler - get the RT priority of a thread
+ * @pid: the pid in question.
+ * @param: structure containing the RT priority.
+ */
 asmlinkage long sys_sched_getparam(pid_t pid, struct sched_param *param)
 {
 	struct sched_param lp;
@@ -1520,6 +1626,13 @@
 	return real_len;
 }
 
+/**
+ * sys_sched_yield - yield the current processor to other threads.
+ *
+ * this function yields the current CPU by moving the calling thread
+ * to the expired array. If there are no other threads running on this
+ * CPU then this function will return.
+ */
 asmlinkage long sys_sched_yield(void)
 {
 	runqueue_t *rq = this_rq_lock();
@@ -1557,12 +1670,25 @@
 	schedule();
 }
 
+/**
+ * yield - yield the current processor to other threads.
+ *
+ * this is a shortcut for kernel-space yielding - it marks the
+ * thread runnable and calls sys_sched_yield().
+ */
 void yield(void)
 {
 	set_current_state(TASK_RUNNING);
 	sys_sched_yield();
 }
 
+/**
+ * sys_sched_get_priority_max - return maximum RT priority.
+ * @policy: scheduling class.
+ *
+ * this syscall returns the maximum rt_priority that can be used
+ * by a given scheduling class.
+ */
 asmlinkage long sys_sched_get_priority_max(int policy)
 {
 	int ret = -EINVAL;
@@ -1579,6 +1705,13 @@
 	return ret;
 }
 
+/**
+ * sys_sched_get_priority_mix - return minimum RT priority.
+ * @policy: scheduling class.
+ *
+ * this syscall returns the minimum rt_priority that can be used
+ * by a given scheduling class.
+ */
 asmlinkage long sys_sched_get_priority_min(int policy)
 {
 	int ret = -EINVAL;
@@ -1594,6 +1727,14 @@
 	return ret;
 }
 
+/**
+ * sys_sched_rr_get_interval - return the default timeslice of a process.
+ * @pid: pid of the process.
+ * @interval: userspace pointer to the timeslice value.
+ *
+ * this syscall writes the default timeslice value of a given process
+ * into the user-space timespec buffer. A value of '0' means infinity.
+ */
 asmlinkage long sys_sched_rr_get_interval(pid_t pid, struct timespec *interval)
 {
 	int retval = -EINVAL;
@@ -1769,7 +1910,7 @@
 } migration_req_t;
 
 /*
- * Change a given task's CPU affinity. Migrate the process to a
+ * Change a given task's CPU affinity. Migrate the thread to a
  * proper CPU and schedule it away if the CPU it's executing on
  * is removed from the allowed bitmask.
  *
@@ -1794,7 +1935,7 @@
 	p->cpus_allowed = new_mask;
 	/*
 	 * Can the task run on the task's current CPU? If not then
-	 * migrate the process off to a proper CPU.
+	 * migrate the thread off to a proper CPU.
 	 */
 	if (new_mask & (1UL << task_cpu(p))) {
 		task_rq_unlock(rq, &flags);
@@ -1843,11 +1984,15 @@
 	return 0;
 }
 
-static int migration_thread(void * bind_cpu)
+/*
+ * migration_thread - this is a highprio system thread that performs
+ * thread migration by 'pulling' threads into the target runqueue.
+ */
+static int migration_thread(void * data)
 {
-	int cpu = (int) (long) bind_cpu;
 	struct sched_param param = { sched_priority: MAX_RT_PRIO-1 };
 	migration_startup_t startup;
+	int cpu = (long) data;
 	runqueue_t *rq;
 	int ret, pid;
 
@@ -1859,6 +2004,13 @@
 	startup.thread = current;
 	pid = kernel_thread(migration_startup_thread, &startup,
 		CLONE_FS | CLONE_FILES | CLONE_SIGNAL);
+
+	/*
+	 * Migration can happen without a migration thread on the
+	 * target CPU because here we remove the thread from the
+	 * runqueue and the helper thread then moves this thread
+	 * to the target CPU - we'll wake up there.
+	 */
 	down(&migration_startup);
 
 	/* we need to waitpid() to release the helper thread */
@@ -1868,7 +2020,7 @@
 	 * At this point the startup helper thread must have
 	 * migrated us to the proper CPU already:
 	 */
-	if (smp_processor_id() != (int)bind_cpu)
+	if (smp_processor_id() != cpu)
 		BUG();
 
 	printk("migration_task %d on cpu=%d\n", cpu, smp_processor_id());
@@ -1927,6 +2079,10 @@
 	}
 }
 
+/*
+ * migration_call - callback that gets triggered when a CPU is added.
+ * Here we can start up the necessary migration thread for the new CPU.
+ */
 static int migration_call(struct notifier_block *nfb,
 			  unsigned long action,
 			  void *hcpu)
@@ -1989,7 +2145,7 @@
 	}
 	/*
 	 * We have to do a little magic to get the first
-	 * process right in SMP mode.
+	 * thread right in SMP mode.
 	 */
 	rq = this_rq();
 	rq->curr = current;

