Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261415AbSITGzy>; Fri, 20 Sep 2002 02:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261297AbSITGyp>; Fri, 20 Sep 2002 02:54:45 -0400
Received: from dp.samba.org ([66.70.73.150]:36736 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261228AbSITGyP>;
	Fri, 20 Sep 2002 02:54:15 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: [PATCH] Re-xmit: task_t removal patch
Date: Fri, 20 Sep 2002 16:19:24 +1000
Message-Id: <20020920065921.8BAC72C05E@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Against 2.5.36.

Name: task_t removal patch
Author: Rusty Russell
Section: Misc
Status: Trivial

D: This removes task_t, which is a gratuitous typedef for a "struct
D: task_struct".  Unless there is good reason, the kernel doesn't usually
D: typedef, as typedefs cannot be predeclared unlike structs.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .4321-linux-2.5.36/Documentation/sched-coding.txt .4321-linux-2.5.36.updated/Documentation/sched-coding.txt
--- .4321-linux-2.5.36/Documentation/sched-coding.txt	2002-05-30 10:00:45.000000000 +1000
+++ .4321-linux-2.5.36.updated/Documentation/sched-coding.txt	2002-09-18 14:54:25.000000000 +1000
@@ -31,14 +31,14 @@ to be locked, lock acquires must be orde
 
 A specific runqueue is locked via
 
-	task_rq_lock(task_t pid, unsigned long *flags)
+	task_rq_lock(struct task_struct *task, unsigned long *flags)
 
-which disables preemption, disables interrupts, and locks the runqueue pid is
+which disables preemption, disables interrupts, and locks the runqueue task is
 running on.  Likewise,
 
-	task_rq_unlock(task_t pid, unsigned long *flags)
+	task_rq_unlock(struct task_struct *task, unsigned long *flags)
 
-unlocks the runqueue pid is running on, restores interrupts to their previous
+unlocks the runqueue task is running on, restores interrupts to their previous
 state, and reenables preemption.
 
 The routines
@@ -99,11 +99,11 @@ rt_task(pid)
 Process Control Methods
 -----------------------
 
-void set_user_nice(task_t *p, long nice)
+void set_user_nice(struct task_struct *p, long nice)
 	Sets the "nice" value of task p to the given value.
 int setscheduler(pid_t pid, int policy, struct sched_param *param)
 	Sets the scheduling policy and parameters for the given pid.
-void set_cpus_allowed(task_t *p, unsigned long new_mask)
+void set_cpus_allowed(struct task_struct *p, unsigned long new_mask)
 	Sets a given task's CPU affinity and migrates it to a proper cpu.
 	Callers must have a valid reference to the task and assure the
 	task not exit prematurely.  No locks can be held during the call.
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .4321-linux-2.5.36/arch/alpha/kernel/process.c .4321-linux-2.5.36.updated/arch/alpha/kernel/process.c
--- .4321-linux-2.5.36/arch/alpha/kernel/process.c	2002-09-12 20:42:07.000000000 +1000
+++ .4321-linux-2.5.36.updated/arch/alpha/kernel/process.c	2002-09-18 14:54:25.000000000 +1000
@@ -443,7 +443,7 @@ out:
  */
 
 unsigned long
-thread_saved_pc(task_t *t)
+thread_saved_pc(struct task_struct *t)
 {
 	unsigned long base = (unsigned long)t->thread_info;
 	unsigned long fp, sp = t->thread_info->pcb.ksp;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .4321-linux-2.5.36/arch/ia64/kernel/smpboot.c .4321-linux-2.5.36.updated/arch/ia64/kernel/smpboot.c
--- .4321-linux-2.5.36/arch/ia64/kernel/smpboot.c	2002-09-01 12:22:58.000000000 +1000
+++ .4321-linux-2.5.36.updated/arch/ia64/kernel/smpboot.c	2002-09-18 14:54:25.000000000 +1000
@@ -75,7 +75,7 @@ extern void start_ap (void);
 extern unsigned long ia64_iobase;
 
 int cpucount;
-task_t *task_for_booting_cpu;
+struct task_struct *task_for_booting_cpu;
 
 /* Bitmask of currently online CPUs */
 volatile unsigned long cpu_online_map;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .4321-linux-2.5.36/include/linux/sched.h .4321-linux-2.5.36.updated/include/linux/sched.h
--- .4321-linux-2.5.36/include/linux/sched.h	2002-09-18 13:52:21.000000000 +1000
+++ .4321-linux-2.5.36.updated/include/linux/sched.h	2002-09-18 14:55:05.000000000 +1000
@@ -146,10 +146,8 @@ struct sched_param {
 extern rwlock_t tasklist_lock;
 extern spinlock_t mmlist_lock;
 
-typedef struct task_struct task_t;
-
-extern void sched_init(void);
-extern void init_idle(task_t *idle, int cpu);
+ extern void sched_init(void);
+extern void init_idle(struct task_struct *idle, int cpu);
 extern void show_state(void);
 extern void cpu_init (void);
 extern void trap_init(void);
@@ -219,7 +217,7 @@ struct signal_struct {
 	spinlock_t		siglock;
 
         /* current thread group signal load-balancing target: */
-        task_t                  *curr_target;
+        struct task_struct	*curr_target;
 
 	struct sigpending	shared_pending;
 
@@ -442,15 +440,15 @@ do { if (atomic_dec_and_test(&(tsk)->usa
 #define _STK_LIM	(8*1024*1024)
 
 #if CONFIG_SMP
-extern void set_cpus_allowed(task_t *p, unsigned long new_mask);
+extern void set_cpus_allowed(struct task_struct *p, unsigned long new_mask);
 #else
 # define set_cpus_allowed(p, new_mask) do { } while (0)
 #endif
 
-extern void set_user_nice(task_t *p, long nice);
-extern int task_prio(task_t *p);
-extern int task_nice(task_t *p);
-extern int task_curr(task_t *p);
+extern void set_user_nice(struct task_struct *p, long nice);
+extern int task_prio(struct task_struct *p);
+extern int task_nice(struct task_struct *p);
+extern int task_curr(struct task_struct *p);
 extern int idle_cpu(int cpu);
 
 void yield(void);
@@ -532,7 +530,7 @@ extern long FASTCALL(interruptible_sleep
 						    signed long timeout));
 extern int FASTCALL(wake_up_process(struct task_struct * tsk));
 extern void FASTCALL(wake_up_forked_process(struct task_struct * tsk));
-extern void FASTCALL(sched_exit(task_t * p));
+extern void FASTCALL(sched_exit(struct task_struct * p));
 
 #define wake_up(x)			__wake_up((x),TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, 1)
 #define wake_up_nr(x, nr)		__wake_up((x),TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, nr)
@@ -682,7 +680,7 @@ extern void remove_thread_group(struct t
 
 extern void reparent_to_init(void);
 extern void daemonize(void);
-extern task_t *child_reaper;
+extern struct task_struct *child_reaper;
 
 extern int do_execve(char *, char **, char **, struct pt_regs *);
 extern struct task_struct *do_fork(unsigned long, unsigned long, struct pt_regs *, unsigned long, int *);
@@ -692,11 +690,11 @@ extern void FASTCALL(add_wait_queue_excl
 extern void FASTCALL(remove_wait_queue(wait_queue_head_t *q, wait_queue_t * wait));
 
 #ifdef CONFIG_SMP
-extern void wait_task_inactive(task_t * p);
+extern void wait_task_inactive(struct task_struct *p);
 #else
 #define wait_task_inactive(p)	do { } while (0)
 #endif
-extern void kick_if_running(task_t * p);
+extern void kick_if_running(struct task_struct *p);
 
 #define __wait_event(wq, condition) 					\
 do {									\
@@ -824,7 +822,7 @@ static inline struct task_struct *younge
 #define while_each_thread(g, t) \
 	while ((t = next_thread(t)) != g)
 
-static inline task_t *next_thread(task_t *p)
+static inline struct task_struct *next_thread(struct task_struct *p)
 {
 	if (!p->sig)
 		BUG();
@@ -833,10 +831,11 @@ static inline task_t *next_thread(task_t
 				!rwlock_is_locked(&tasklist_lock))
 		BUG();
 #endif
-	return list_entry((p)->thread_group.next, task_t, thread_group);
+	return list_entry((p)->thread_group.next,
+			  struct task_struct, thread_group);
 }
 
-static inline task_t *prev_thread(task_t *p)
+static inline struct task_struct *prev_thread(struct task_struct *p)
 {
 	if (!p->sig)
 		BUG();
@@ -845,7 +844,8 @@ static inline task_t *prev_thread(task_t
 				!rwlock_is_locked(&tasklist_lock))
 		BUG();
 #endif
-	return list_entry((p)->thread_group.prev, task_t, thread_group);
+	return list_entry((p)->thread_group.prev,
+			  struct task_struct, thread_group);
 }
 
 #define thread_group_leader(p)	(p->pid == p->tgid)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .4321-linux-2.5.36/kernel/capability.c .4321-linux-2.5.36.updated/kernel/capability.c
--- .4321-linux-2.5.36/kernel/capability.c	2002-09-16 12:43:49.000000000 +1000
+++ .4321-linux-2.5.36.updated/kernel/capability.c	2002-09-18 14:55:32.000000000 +1000
@@ -33,7 +33,7 @@ asmlinkage long sys_capget(cap_user_head
      int ret = 0;
      pid_t pid;
      __u32 version;
-     task_t *target;
+     struct task_struct *target;
      struct __user_cap_data_struct data;
 
      if (get_user(version, &header->version))
@@ -83,7 +83,7 @@ static inline void cap_set_pg(int pgrp, 
 			      kernel_cap_t *inheritable,
 			      kernel_cap_t *permitted)
 {
-     task_t *g, *target;
+     struct task_struct *g, *target;
 
      do_each_thread(g, target) {
              if (target->pgrp != pgrp)
@@ -100,7 +100,7 @@ static inline void cap_set_all(kernel_ca
 			       kernel_cap_t *inheritable,
 			       kernel_cap_t *permitted)
 {
-     task_t *g, *target;
+     struct task_struct *g, *target;
 
      do_each_thread(g, target) {
              if (target == current || target->pid == 1)
@@ -125,7 +125,7 @@ asmlinkage long sys_capset(cap_user_head
 {
      kernel_cap_t inheritable, permitted, effective;
      __u32 version;
-     task_t *target;
+     struct task_struct *target;
      int ret;
      pid_t pid;
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .4321-linux-2.5.36/kernel/exit.c .4321-linux-2.5.36.updated/kernel/exit.c
--- .4321-linux-2.5.36/kernel/exit.c	2002-09-18 13:52:21.000000000 +1000
+++ .4321-linux-2.5.36.updated/kernel/exit.c	2002-09-18 14:55:16.000000000 +1000
@@ -268,7 +268,9 @@ void daemonize(void)
 	reparent_to_init();
 }
 
-static void reparent_thread(task_t *p, task_t *reaper, task_t *child_reaper)
+static void reparent_thread(struct task_struct *p,
+			    struct task_struct *reaper,
+			    struct task_struct *child_reaper)
 {
 	/* We dont want people slaying init */
 	if (p->exit_signal != -1)
@@ -468,11 +470,13 @@ static inline void forget_original_paren
 	}
 }
 
-static inline void zap_thread(task_t *p, task_t *father, int traced)
+static inline void zap_thread(struct task_struct *p,
+			      struct task_struct *father,
+			      int traced)
 {
 	/* If someone else is tracing this thread, preserve the ptrace links.  */
 	if (unlikely(traced)) {
-		task_t *trace_task = p->parent;
+		struct task_struct *trace_task = p->parent;
 		int ptrace_flag = p->ptrace;
 		BUG_ON (ptrace_flag == 0);
 
@@ -696,7 +700,7 @@ asmlinkage long sys_exit_group(int error
 	do_exit(exit_code);
 }
 
-static int eligible_child(pid_t pid, int options, task_t *p)
+static int eligible_child(pid_t pid, int options, struct task_struct *p)
 {
 	if (pid > 0) {
 		if (p->pid != pid)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .4321-linux-2.5.36/kernel/fork.c .4321-linux-2.5.36.updated/kernel/fork.c
--- .4321-linux-2.5.36/kernel/fork.c	2002-09-16 12:43:49.000000000 +1000
+++ .4321-linux-2.5.36.updated/kernel/fork.c	2002-09-18 14:54:25.000000000 +1000
@@ -65,7 +65,7 @@ rwlock_t tasklist_lock __cacheline_align
  * the very last portion of sys_exit() is executed with
  * preemption turned off.
  */
-static task_t *task_cache[NR_CPUS] __cacheline_aligned;
+static struct task_struct *task_cache[NR_CPUS] __cacheline_aligned;
 
 void __put_task_struct(struct task_struct *tsk)
 {
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .4321-linux-2.5.36/kernel/ptrace.c .4321-linux-2.5.36.updated/kernel/ptrace.c
--- .4321-linux-2.5.36/kernel/ptrace.c	2002-09-18 13:52:21.000000000 +1000
+++ .4321-linux-2.5.36.updated/kernel/ptrace.c	2002-09-18 14:54:25.000000000 +1000
@@ -24,7 +24,7 @@
  *
  * Must be called with the tasklist lock write-held.
  */
-void __ptrace_link(task_t *child, task_t *new_parent)
+void __ptrace_link(struct task_struct *child, struct task_struct *new_parent)
 {
 	if (!list_empty(&child->ptrace_list))
 		BUG();
@@ -42,7 +42,7 @@ void __ptrace_link(task_t *child, task_t
  *
  * Must be called with the tasklist lock write-held.
  */
-void __ptrace_unlink(task_t *child)
+void __ptrace_unlink(struct task_struct *child)
 {
 	if (!child->ptrace)
 		BUG();
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .4321-linux-2.5.36/kernel/sched.c .4321-linux-2.5.36.updated/kernel/sched.c
--- .4321-linux-2.5.36/kernel/sched.c	2002-09-16 12:43:49.000000000 +1000
+++ .4321-linux-2.5.36.updated/kernel/sched.c	2002-09-18 14:54:42.000000000 +1000
@@ -117,7 +117,7 @@
 #define BASE_TIMESLICE(p) (MIN_TIMESLICE + \
 	((MAX_TIMESLICE - MIN_TIMESLICE) * (MAX_PRIO-1-(p)->static_prio)/(MAX_USER_PRIO - 1)))
 
-static inline unsigned int task_timeslice(task_t *p)
+static inline unsigned int task_timeslice(struct task_struct *p)
 {
 	return BASE_TIMESLICE(p);
 }
@@ -147,11 +147,11 @@ struct runqueue {
 	spinlock_t lock;
 	unsigned long nr_running, nr_switches, expired_timestamp,
 			nr_uninterruptible;
-	task_t *curr, *idle;
+	struct task_struct *curr, *idle;
 	prio_array_t *active, *expired, arrays[2];
 	int prev_nr_running[NR_CPUS];
 
-	task_t *migration_thread;
+	struct task_struct *migration_thread;
 	struct list_head migration_queue;
 
 } ____cacheline_aligned;
@@ -178,7 +178,8 @@ static struct runqueue runqueues[NR_CPUS
  * interrupts.  Note the ordering: we can safely lookup the task_rq without
  * explicitly disabling preemption.
  */
-static inline runqueue_t *task_rq_lock(task_t *p, unsigned long *flags)
+static inline runqueue_t *task_rq_lock(struct task_struct *p,
+				       unsigned long *flags)
 {
 	struct runqueue *rq;
 
@@ -250,7 +251,7 @@ static inline void enqueue_task(struct t
  *
  * Both properties are important to certain workloads.
  */
-static inline int effective_prio(task_t *p)
+static inline int effective_prio(struct task_struct *p)
 {
 	int bonus, prio;
 
@@ -271,7 +272,7 @@ static inline int effective_prio(task_t 
  * Also update all the scheduling statistics stuff. (sleep average
  * calculation, priority modifiers, etc.)
  */
-static inline void activate_task(task_t *p, runqueue_t *rq)
+static inline void activate_task(struct task_struct *p, runqueue_t *rq)
 {
 	unsigned long sleep_time = jiffies - p->sleep_timestamp;
 	prio_array_t *array = rq->active;
@@ -312,7 +313,7 @@ static inline void deactivate_task(struc
  * might also involve a cross-CPU call to trigger the scheduler on
  * the target CPU.
  */
-static inline void resched_task(task_t *p)
+static inline void resched_task(struct task_struct *p)
 {
 #ifdef CONFIG_SMP
 	int need_resched, nrpolling;
@@ -339,7 +340,7 @@ static inline void resched_task(task_t *
  * The caller must ensure that the task *will* unschedule sometime soon,
  * else this function might spin for a *long* time.
  */
-void wait_task_inactive(task_t * p)
+void wait_task_inactive(struct task_struct * p)
 {
 	unsigned long flags;
 	runqueue_t *rq;
@@ -378,7 +379,7 @@ repeat:
  * while the message is in flight then it will notice the
  * sigpending condition anyway.)
  */
-void kick_if_running(task_t * p)
+void kick_if_running(struct task_struct * p)
 {
 	if ((task_running(task_rq(p), p)) && (task_cpu(p) != smp_processor_id()))
 		resched_task(p);
@@ -397,7 +398,7 @@ void kick_if_running(task_t * p)
  *
  * returns failure only if the task is already active.
  */
-static int try_to_wake_up(task_t * p, int sync)
+static int try_to_wake_up(struct task_struct * p, int sync)
 {
 	unsigned long flags;
 	int success = 0;
@@ -434,7 +435,7 @@ repeat_lock_task:
 	return success;
 }
 
-int wake_up_process(task_t * p)
+int wake_up_process(struct task_struct * p)
 {
 	return try_to_wake_up(p, 0);
 }
@@ -445,7 +446,7 @@ int wake_up_process(task_t * p)
  * This function will do some initial scheduler statistics housekeeping
  * that must be done for every newly created process.
  */
-void wake_up_forked_process(task_t * p)
+void wake_up_forked_process(struct task_struct * p)
 {
 	runqueue_t *rq = this_rq_lock();
 
@@ -475,7 +476,7 @@ void wake_up_forked_process(task_t * p)
  * artificially, because any timeslice recovered here
  * was given away by the parent in the first place.)
  */
-void sched_exit(task_t * p)
+void sched_exit(struct task_struct * p)
 {
 	local_irq_disable();
 	if (p->first_time_slice) {
@@ -498,7 +499,7 @@ void sched_exit(task_t * p)
  * @prev: the thread we just switched away from.
  */
 #if CONFIG_SMP || CONFIG_PREEMPT
-asmlinkage void schedule_tail(task_t *prev)
+asmlinkage void schedule_tail(struct task_struct *prev)
 {
 	finish_arch_switch(this_rq(), prev);
 }
@@ -508,7 +509,8 @@ asmlinkage void schedule_tail(task_t *pr
  * context_switch - switch to the new MM and the new
  * thread's register state.
  */
-static inline task_t * context_switch(task_t *prev, task_t *next)
+static inline struct task_struct *context_switch(struct task_struct *prev,
+						 struct task_struct *next)
 {
 	struct mm_struct *mm = next->mm;
 	struct mm_struct *oldmm = prev->active_mm;
@@ -711,7 +713,7 @@ out:
  * pull_task - move a task from a remote runqueue to the local runqueue.
  * Both runqueues must be locked.
  */
-static inline void pull_task(runqueue_t *src_rq, prio_array_t *src_array, task_t *p, runqueue_t *this_rq, int this_cpu)
+static inline void pull_task(runqueue_t *src_rq, prio_array_t *src_array, struct task_struct *p, runqueue_t *this_rq, int this_cpu)
 {
 	dequeue_task(p, src_array);
 	src_rq->nr_running--;
@@ -740,7 +742,7 @@ static void load_balance(runqueue_t *thi
 	runqueue_t *busiest;
 	prio_array_t *array;
 	struct list_head *head, *curr;
-	task_t *tmp;
+	struct task_struct *tmp;
 
 	busiest = find_busiest_queue(this_rq, this_cpu, idle, &imbalance);
 	if (!busiest)
@@ -776,7 +778,7 @@ skip_bitmap:
 	head = array->queue + idx;
 	curr = head->prev;
 skip_queue:
-	tmp = list_entry(curr, task_t, run_list);
+	tmp = list_entry(curr, struct task_struct, run_list);
 
 	/*
 	 * We do not migrate tasks that are:
@@ -856,7 +858,7 @@ void scheduler_tick(int user_ticks, int 
 {
 	int cpu = smp_processor_id();
 	runqueue_t *rq = this_rq();
-	task_t *p = current;
+	struct task_struct *p = current;
 
 	if (p == rq->idle) {
 		/* note: this timer irq context must be accounted for as well */
@@ -934,7 +936,7 @@ void scheduling_functions_start_here(voi
  */
 asmlinkage void schedule(void)
 {
-	task_t *prev, *next;
+	struct task_struct *prev, *next;
 	runqueue_t *rq;
 	prio_array_t *array;
 	struct list_head *queue;
@@ -998,7 +1000,7 @@ pick_next_task:
 
 	idx = sched_find_first_bit(array->bitmap);
 	queue = array->queue + idx;
-	next = list_entry(queue->next, task_t, run_list);
+	next = list_entry(queue->next, struct task_struct, run_list);
 
 switch_tasks:
 	prefetch(next);
@@ -1053,7 +1055,7 @@ need_resched:
 
 int default_wake_function(wait_queue_t *curr, unsigned mode, int sync)
 {
-	task_t *p = curr->task;
+	struct task_struct *p = curr->task;
 	return ((p->state & mode) && try_to_wake_up(p, sync));
 }
 
@@ -1233,7 +1235,7 @@ long sleep_on_timeout(wait_queue_head_t 
 
 void scheduling_functions_end_here(void) { }
 
-void set_user_nice(task_t *p, long nice)
+void set_user_nice(struct task_struct *p, long nice)
 {
 	unsigned long flags;
 	prio_array_t *array;
@@ -1321,7 +1323,7 @@ asmlinkage long sys_nice(int increment)
  * RT tasks are offset by -200. Normal tasks are centered
  * around 0, value goes from -16 to +15.
  */
-int task_prio(task_t *p)
+int task_prio(struct task_struct *p)
 {
 	return p->prio - MAX_USER_RT_PRIO;
 }
@@ -1330,7 +1332,7 @@ int task_prio(task_t *p)
  * task_nice - return the nice value of a given task.
  * @p: the task in question.
  */
-int task_nice(task_t *p)
+int task_nice(struct task_struct *p)
 {
 	return TASK_NICE(p);
 }
@@ -1339,7 +1341,7 @@ int task_nice(task_t *p)
  * task_curr - is this task currently executing on a CPU?
  * @p: the task in question.
  */
-int task_curr(task_t *p)
+int task_curr(struct task_struct *p)
 {
 	return cpu_curr(task_cpu(p)) == p;
 }
@@ -1357,7 +1359,7 @@ int idle_cpu(int cpu)
  * find_process_by_pid - find a process with a matching PID value.
  * @pid: the pid in question.
  */
-static inline task_t *find_process_by_pid(pid_t pid)
+static inline struct task_struct *find_process_by_pid(pid_t pid)
 {
 	return pid ? find_task_by_pid(pid) : current;
 }
@@ -1372,7 +1374,7 @@ static int setscheduler(pid_t pid, int p
 	prio_array_t *array;
 	unsigned long flags;
 	runqueue_t *rq;
-	task_t *p;
+	struct task_struct *p;
 
 	if (!param || pid < 0)
 		goto out_nounlock;
@@ -1480,7 +1482,7 @@ asmlinkage long sys_sched_setparam(pid_t
 asmlinkage long sys_sched_getscheduler(pid_t pid)
 {
 	int retval = -EINVAL;
-	task_t *p;
+	struct task_struct *p;
 
 	if (pid < 0)
 		goto out_nounlock;
@@ -1508,7 +1510,7 @@ asmlinkage long sys_sched_getparam(pid_t
 {
 	struct sched_param lp;
 	int retval = -EINVAL;
-	task_t *p;
+	struct task_struct *p;
 
 	if (!param || pid < 0)
 		goto out_nounlock;
@@ -1550,7 +1552,7 @@ asmlinkage int sys_sched_setaffinity(pid
 {
 	unsigned long new_mask;
 	int retval;
-	task_t *p;
+	struct task_struct *p;
 
 	if (len < sizeof(new_mask))
 		return -EINVAL;
@@ -1603,7 +1605,7 @@ asmlinkage int sys_sched_getaffinity(pid
 	unsigned int real_len;
 	unsigned long mask;
 	int retval;
-	task_t *p;
+	struct task_struct *p;
 
 	real_len = sizeof(mask);
 	if (len < real_len)
@@ -1741,7 +1743,7 @@ asmlinkage long sys_sched_rr_get_interva
 {
 	int retval = -EINVAL;
 	struct timespec t;
-	task_t *p;
+	struct task_struct *p;
 
 	if (pid < 0)
 		goto out_nounlock;
@@ -1767,10 +1769,10 @@ out_unlock:
 	return retval;
 }
 
-static void show_task(task_t * p)
+static void show_task(struct task_struct * p)
 {
 	unsigned long free = 0;
-	task_t *relative;
+	struct task_struct *relative;
 	int state;
 	static const char * stat_nam[] = { "R", "S", "D", "Z", "T", "W" };
 
@@ -1816,7 +1818,7 @@ static void show_task(task_t * p)
 		printk(" (NOTLB)\n");
 
 	{
-		extern void show_trace_task(task_t *tsk);
+		extern void show_trace_task(struct task_struct *tsk);
 		show_trace_task(p);
 	}
 }
@@ -1838,7 +1840,7 @@ char * render_sigset_t(sigset_t *set, ch
 
 void show_state(void)
 {
-	task_t *g, *p;
+	struct task_struct *g, *p;
 
 #if (BITS_PER_LONG == 32)
 	printk("\n"
@@ -1862,7 +1864,7 @@ void show_state(void)
 	read_unlock(&tasklist_lock);
 }
 
-void __init init_idle(task_t *idle, int cpu)
+void __init init_idle(struct task_struct *idle, int cpu)
 {
 	runqueue_t *idle_rq = cpu_rq(cpu), *rq = cpu_rq(task_cpu(idle));
 	unsigned long flags;
@@ -1907,7 +1909,7 @@ void __init init_idle(task_t *idle, int 
 
 typedef struct {
 	struct list_head list;
-	task_t *task;
+	struct task_struct *task;
 	struct completion done;
 } migration_req_t;
 
@@ -1920,7 +1922,7 @@ typedef struct {
  * task must not exit() & deallocate itself prematurely.  The
  * call is not atomic; no spinlocks may be held.
  */
-void set_cpus_allowed(task_t *p, unsigned long new_mask)
+void set_cpus_allowed(struct task_struct *p, unsigned long new_mask)
 {
 	unsigned long flags;
 	migration_req_t req;
@@ -2001,7 +2003,7 @@ static int migration_thread(void * data)
 		int cpu_src, cpu_dest;
 		migration_req_t *req;
 		unsigned long flags;
-		task_t *p;
+		struct task_struct *p;
 
 		spin_lock_irqsave(&rq->lock, flags);
 		head = &rq->migration_queue;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .4321-linux-2.5.36/kernel/signal.c .4321-linux-2.5.36.updated/kernel/signal.c
--- .4321-linux-2.5.36/kernel/signal.c	2002-09-16 12:43:49.000000000 +1000
+++ .4321-linux-2.5.36.updated/kernel/signal.c	2002-09-18 14:54:25.000000000 +1000
@@ -874,7 +874,7 @@ int __broadcast_thread_group(struct task
 
 	/* send a signal to all members of the list */
 	list_for_each(entry, &p->thread_group) {
-		tmp = list_entry(entry, task_t, thread_group);
+		tmp = list_entry(entry, struct task_struct, thread_group);
 		err = __force_sig_info(sig, tmp);
 	}
 	return err;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .4321-linux-2.5.36/kernel/timer.c .4321-linux-2.5.36.updated/kernel/timer.c
--- .4321-linux-2.5.36/kernel/timer.c	2002-09-16 12:43:49.000000000 +1000
+++ .4321-linux-2.5.36.updated/kernel/timer.c	2002-09-18 14:54:25.000000000 +1000
@@ -790,7 +790,7 @@ asmlinkage long sys_getegid(void)
 
 static void process_timeout(unsigned long __data)
 {
-	wake_up_process((task_t *)__data);
+	wake_up_process((struct task_struct *)__data);
 }
 
 /**

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
