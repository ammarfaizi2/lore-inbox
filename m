Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261182AbUJ3Oh4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbUJ3Oh4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 10:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbUJ3Ohz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 10:37:55 -0400
Received: from mail23.syd.optusnet.com.au ([211.29.133.164]:24795 "EHLO
	mail23.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261182AbUJ3Ogi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 10:36:38 -0400
Message-ID: <4183A6E3.9000402@kolivas.org>
Date: Sun, 31 Oct 2004 00:36:19 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Peter Williams <pwil3058@bigpond.net.au>,
       Alexander Nyberg <alexn@dsv.su.se>,
       William Lee Irwin III <wli@holomorphy.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: [PATCH][plugsched 2/28] Export unique functions
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB9131988B4514F7DDDA3659B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB9131988B4514F7DDDA3659B
Content-Type: multipart/mixed;
 boundary="------------090103060705020809070905"

This is a multi-part message in MIME format.
--------------090103060705020809070905
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Export unique functions



--------------090103060705020809070905
Content-Type: text/x-patch;
 name="export_functions.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="export_functions.diff"

Take the functions that will be unique to each scheduler, make them static
and add entries to the task struct for the identity of that scheduler.

Signed-off-by: Con Kolivas <kernel@kolivas.org>


Index: linux-2.6.10-rc1-mm2-plugsched1/kernel/sched.c
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched1.orig/kernel/sched.c	2004-10-30 21:59:44.181892284 +1000
+++ linux-2.6.10-rc1-mm2-plugsched1/kernel/sched.c	2004-10-30 22:00:00.168344500 +1000
@@ -599,6 +599,11 @@ static inline void enqueue_task_head(str
 	p->array = array;
 }
 
+static void ingo_set_oom_timeslice(task_t *p)
+{
+	p->time_slice = HZ;
+}
+
 /*
  * effective_prio - return the priority that is based on the static
  * priority but is modified by bonuses/penalties.
@@ -816,7 +821,7 @@ static inline void resched_task(task_t *
  * task_curr - is this task currently executing on a CPU?
  * @p: the task in question.
  */
-inline int task_curr(const task_t *p)
+static int ingo_task_curr(const task_t *p)
 {
 	return cpu_curr(task_cpu(p)) == p;
 }
@@ -875,7 +880,7 @@ static int migrate_task(task_t *p, int d
  * smp_call_function() if an IPI is sent by the same process we are
  * waiting to become inactive.
  */
-void wait_task_inactive(task_t * p)
+static void ingo_wait_task_inactive(task_t * p)
 {
 	unsigned long flags;
 	runqueue_t *rq;
@@ -993,7 +998,7 @@ static inline int wake_idle(int cpu, tas
  *
  * returns failure only if the task is already active.
  */
-static int try_to_wake_up(task_t * p, unsigned int state, int sync)
+static int ingo_try_to_wake_up(task_t * p, unsigned int state, int sync)
 {
 	int cpu, this_cpu, success = 0;
 	unsigned long flags;
@@ -1153,7 +1158,7 @@ static int find_idlest_cpu(struct task_s
  * Perform scheduler related setup for a newly forked process p.
  * p is forked by current.
  */
-void fastcall sched_fork(task_t *p)
+static void ingo_sched_fork(task_t *p)
 {
 	/*
 	 * We mark the process as running here, but have not actually
@@ -1213,7 +1218,7 @@ void fastcall sched_fork(task_t *p)
  * that must be done for every newly created context, then puts the task
  * on the runqueue and wakes it.
  */
-void fastcall wake_up_new_task(task_t * p, unsigned long clone_flags)
+static void ingo_wake_up_new_task(task_t * p, unsigned long clone_flags)
 {
 	unsigned long flags;
 	int this_cpu, cpu;
@@ -1301,7 +1306,7 @@ void fastcall wake_up_new_task(task_t * 
  * artificially, because any timeslice recovered here
  * was given away by the parent in the first place.)
  */
-void fastcall sched_exit(task_t * p)
+static void ingo_sched_exit(task_t * p)
 {
 	unsigned long flags;
 	runqueue_t *rq;
@@ -1367,7 +1372,7 @@ static void finish_task_switch(task_t *p
  * schedule_tail - first thing a freshly forked thread must call.
  * @prev: the thread we just switched away from.
  */
-asmlinkage void schedule_tail(task_t *prev)
+static void ingo_schedule_tail(task_t *prev)
 {
 	finish_task_switch(prev);
 
@@ -1411,7 +1416,7 @@ task_t * context_switch(runqueue_t *rq, 
  * threads, current number of uninterruptible-sleeping threads, total
  * number of context switches performed since bootup.
  */
-unsigned long nr_running(void)
+static unsigned long ingo_nr_running(void)
 {
 	unsigned long i, sum = 0;
 
@@ -1421,7 +1426,7 @@ unsigned long nr_running(void)
 	return sum;
 }
 
-unsigned long nr_uninterruptible(void)
+static unsigned long ingo_nr_uninterruptible(void)
 {
 	unsigned long i, sum = 0;
 
@@ -1431,7 +1436,7 @@ unsigned long nr_uninterruptible(void)
 	return sum;
 }
 
-unsigned long long nr_context_switches(void)
+static unsigned long long ingo_nr_context_switches(void)
 {
 	unsigned long long i, sum = 0;
 
@@ -1441,7 +1446,7 @@ unsigned long long nr_context_switches(v
 	return sum;
 }
 
-unsigned long nr_iowait(void)
+static unsigned long ingo_nr_iowait(void)
 {
 	unsigned long i, sum = 0;
 
@@ -1587,7 +1592,7 @@ out:
  * execve() is a valuable balancing opportunity, because at this point
  * the task has the smallest effective memory and cache footprint.
  */
-void sched_exec(void)
+static void ingo_sched_exec(void)
 {
 	struct sched_domain *tmp, *sd = NULL;
 	int new_cpu, this_cpu = get_cpu();
@@ -2230,10 +2235,6 @@ static inline int wake_priority_sleeper(
 	return ret;
 }
 
-DEFINE_PER_CPU(struct kernel_stat, kstat);
-
-EXPORT_PER_CPU_SYMBOL(kstat);
-
 /*
  * We place interactive tasks back into the active array, if possible.
  *
@@ -2399,7 +2400,7 @@ void account_steal_time(struct task_stru
  * It also gets called by the fork code, when changing the parent's
  * timeslices.
  */
-void scheduler_tick(void)
+static void ingo_scheduler_tick(void)
 {
 	int cpu = smp_processor_id();
 	runqueue_t *rq = this_rq();
@@ -2652,7 +2653,7 @@ EXPORT_SYMBOL(sub_preempt_count);
 /*
  * schedule() is the main scheduler function.
  */
-asmlinkage void __sched schedule(void)
+static void __sched ingo_schedule(void)
 {
 	long *switch_count;
 	task_t *prev, *next;
@@ -2825,8 +2826,6 @@ switch_tasks:
 		goto need_resched;
 }
 
-EXPORT_SYMBOL(schedule);
-
 #ifdef CONFIG_PREEMPT
 /*
  * this is is the entry point to schedule() from in-kernel preemption
@@ -3080,7 +3079,7 @@ long fastcall __sched sleep_on_timeout(w
 
 EXPORT_SYMBOL(sleep_on_timeout);
 
-void set_user_nice(task_t *p, long nice)
+static void ingo_set_user_nice(task_t *p, long nice)
 {
 	unsigned long flags;
 	prio_array_t *array;
@@ -3127,8 +3126,6 @@ out_unlock:
 	task_rq_unlock(rq, &flags);
 }
 
-EXPORT_SYMBOL(set_user_nice);
-
 #ifdef CONFIG_KGDB
 struct task_struct *kgdb_get_idle(int this_cpu)
 {
@@ -3188,7 +3185,7 @@ asmlinkage long sys_nice(int increment)
  * RT tasks are offset by -200. Normal tasks are centered
  * around 0, value goes from -16 to +15.
  */
-int task_prio(const task_t *p)
+static int ingo_task_prio(const task_t *p)
 {
 	return p->prio - MAX_RT_PRIO;
 }
@@ -3197,24 +3194,20 @@ int task_prio(const task_t *p)
  * task_nice - return the nice value of a given task.
  * @p: the task in question.
  */
-int task_nice(const task_t *p)
+static int ingo_task_nice(const task_t *p)
 {
 	return TASK_NICE(p);
 }
 
-EXPORT_SYMBOL(task_nice);
-
 /**
  * idle_cpu - is a given cpu idle currently?
  * @cpu: the processor in question.
  */
-int idle_cpu(int cpu)
+static int ingo_idle_cpu(int cpu)
 {
 	return cpu_curr(cpu) == cpu_rq(cpu)->idle;
 }
 
-EXPORT_SYMBOL_GPL(idle_cpu);
-
 /**
  * find_process_by_pid - find a process with a matching PID value.
  * @pid: the pid in question.
@@ -3239,7 +3232,7 @@ static void __setscheduler(struct task_s
 /*
  * setscheduler - change the scheduling policy and/or RT priority of a thread.
  */
-static int setscheduler(pid_t pid, int policy, struct sched_param __user *param)
+static int ingo_setscheduler(pid_t pid, int policy, struct sched_param __user *param)
 {
 	struct sched_param lp;
 	int retval = -EINVAL;
@@ -3563,7 +3556,7 @@ asmlinkage long sys_sched_getaffinity(pi
  * to the expired array. If there are no other threads running on this
  * CPU then this function will return.
  */
-asmlinkage long sys_sched_yield(void)
+static long ingo_sys_sched_yield(void)
 {
 	runqueue_t *rq = this_rq_lock();
 	prio_array_t *array = current->array;
@@ -3764,8 +3757,8 @@ asmlinkage long sys_sched_get_priority_m
  * this syscall writes the default timeslice value of a given process
  * into the user-space timespec buffer. A value of '0' means infinity.
  */
-asmlinkage
-long sys_sched_rr_get_interval(pid_t pid, struct timespec __user *interval)
+static long
+ingo_sys_sched_rr_get_interval(pid_t pid, struct timespec __user *interval)
 {
 	int retval = -EINVAL;
 	struct timespec t;
@@ -3893,7 +3886,7 @@ void show_state(void)
 	read_unlock(&tasklist_lock);
 }
 
-void __devinit init_idle(task_t *idle, int cpu)
+static void __devinit ingo_init_idle(task_t *idle, int cpu)
 {
 	runqueue_t *rq = cpu_rq(cpu);
 	unsigned long flags;
@@ -3953,7 +3946,7 @@ cpumask_t nohz_cpu_mask = CPU_MASK_NONE;
  * task must not exit() & deallocate itself prematurely.  The
  * call is not atomic; no spinlocks may be held.
  */
-int set_cpus_allowed(task_t *p, cpumask_t new_mask)
+static int ingo_set_cpus_allowed(task_t *p, cpumask_t new_mask)
 {
 	unsigned long flags;
 	int ret = 0;
@@ -4164,7 +4157,7 @@ static void migrate_live_tasks(int src_c
  * It does so by boosting its priority to highest possible and adding it to
  * the _front_ of runqueue. Used by CPU offline code.
  */
-void sched_idle_next(void)
+static void ingo_sched_idle_next(void)
 {
 	int cpu = smp_processor_id();
 	runqueue_t *rq = this_rq();
@@ -4305,7 +4298,7 @@ static struct notifier_block __devinitda
 	.priority = 10
 };
 
-int __init migration_init(void)
+static int __init ingo_migration_init(void)
 {
 	void *cpu = (void *)(long)smp_processor_id();
 	/* Start one for boot CPU. */
@@ -4321,7 +4314,7 @@ int __init migration_init(void)
  * Attach the domain 'sd' to 'cpu' as its base domain.  Callers must
  * hold the hotplug lock.
  */
-void __devinit cpu_attach_domain(struct sched_domain *sd, int cpu)
+static void __devinit ingo_cpu_attach_domain(struct sched_domain *sd, int cpu)
 {
 	migration_req_t req;
 	unsigned long flags;
@@ -4739,7 +4732,7 @@ static int update_sched_domains(struct n
 }
 #endif
 
-void __init sched_init_smp(void)
+static void __init ingo_sched_init_smp(void)
 {
 	lock_cpu_hotplug();
 	arch_init_sched_domains();
@@ -4749,7 +4742,7 @@ void __init sched_init_smp(void)
 	hotcpu_notifier(update_sched_domains, 0);
 }
 #else
-void __init sched_init_smp(void)
+static void __init ingo_sched_init_smp(void)
 {
 }
 #endif /* CONFIG_SMP */
@@ -4763,7 +4756,7 @@ int in_sched_functions(unsigned long add
 		&& addr < (unsigned long)__sched_text_end);
 }
 
-void __init sched_init(void)
+static void __init ingo_sched_init(void)
 {
 	runqueue_t *rq;
 	int i, j, k;
@@ -4971,3 +4964,39 @@ void destroy_sched_domain_sysctl()
 {
 }
 #endif
+
+struct sched_drv ingo_sched_drv = {
+	.set_oom_timeslice	= ingo_set_oom_timeslice,
+	.nr_running		= ingo_nr_running,
+	.nr_uninterruptible	= ingo_nr_uninterruptible,
+	.nr_context_switches	= ingo_nr_context_switches,
+	.nr_iowait		= ingo_nr_iowait,
+	.idle_cpu		= ingo_idle_cpu,
+	.init_idle		= ingo_init_idle,
+	.exit			= ingo_sched_exit,
+	.fork			= ingo_sched_fork,
+	.init			= ingo_sched_init,
+	.init_smp		= ingo_sched_init_smp,
+	.schedule		= ingo_schedule,
+	.tick			= ingo_scheduler_tick,
+	.tail			= ingo_schedule_tail,
+	.setscheduler		= ingo_setscheduler,
+	.set_user_nice		= ingo_set_user_nice,
+	.rr_get_interval	= ingo_sys_sched_rr_get_interval,
+	.yield			= ingo_sys_sched_yield,
+	.task_curr		= ingo_task_curr,
+	.task_nice		= ingo_task_nice,
+	.task_prio		= ingo_task_prio,
+	.try_to_wake_up		= ingo_try_to_wake_up,
+	.wake_up_new_task	= ingo_wake_up_new_task,
+#ifdef CONFIG_SMP
+	.migration_init		= ingo_migration_init,
+	.exec			= ingo_sched_exec,
+	.set_cpus_allowed	= ingo_set_cpus_allowed,
+	.wait_task_inactive	= ingo_wait_task_inactive,
+	.cpu_attach_domain	= ingo_cpu_attach_domain,
+#ifdef CONFIG_HOTPLUG_CPU
+	.sched_idle_next	= ingo_sched_idle_next,
+#endif	
+#endif
+};
Index: linux-2.6.10-rc1-mm2-plugsched1/kernel/scheduler.c
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched1.orig/kernel/scheduler.c	2004-10-30 21:59:45.966607853 +1000
+++ linux-2.6.10-rc1-mm2-plugsched1/kernel/scheduler.c	2004-10-30 21:59:47.308394011 +1000
@@ -40,6 +40,9 @@
 
 #include <asm/unistd.h>
 
+DEFINE_PER_CPU(struct kernel_stat, kstat);
+EXPORT_PER_CPU_SYMBOL(kstat);
+
 extern struct sched_drv ingo_sched_drv;
 static const struct sched_drv *scheduler = &ingo_sched_drv;
 


--------------090103060705020809070905--

--------------enigB9131988B4514F7DDDA3659B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBg6bjZUg7+tp6mRURAjv3AJ9LtMbU8/vPvKXousqyp57hSdb5dgCeJ8Xp
Wd/LzPLjue/vvDIvmYCV4ZA=
=l/BH
-----END PGP SIGNATURE-----

--------------enigB9131988B4514F7DDDA3659B--
