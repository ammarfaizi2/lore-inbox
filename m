Return-Path: <linux-kernel-owner+w=401wt.eu-S1750769AbWLLATl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbWLLATl (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 19:19:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750773AbWLLATl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 19:19:41 -0500
Received: from mga07.intel.com ([143.182.124.22]:42051 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750769AbWLLATk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 19:19:40 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,521,1157353200"; 
   d="scan'208"; a="156908332:sNHT32519501"
Date: Mon, 11 Dec 2006 15:53:04 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: mingo@elte.hu, nickpiggin@yahoo.com.au, vatsa@in.ibm.com, clameter@sgi.com,
       tglx@linutronix.de, arjan@linux.intel.com
Cc: linux-kernel@vger.kernel.org
Subject: [RFC] Patch: dynticks: idle load balancing
Message-ID: <20061211155304.A31760@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Appended patch attempts to fix the process idle load balancing in the
presence of dynticks. cpus for which ticks are stopped will sleep
till the next event wakes it up. Potentially these sleeps can be for large
durations and during which today, there is no idle load balancing being done.
There was some discussion happened(last year) on this topic on lkml, where two
main approaches were gettting debated. One is to back off the idle load
balancing for bigger intervals and the second is a watchdog mechanism where
the busy cpu will trigger the load balance on an idle cpu.  Both of these
mechanisms have its drawbacks.

For the first mechanism, defining the interval will be tricky and if it is too
much, then the response time will also be high and we won't be able to respond
for sudden changes in the load. If it is small, then we won't be able to save
power.

Second mechanism will be making changes to the busy load balancing(which will
be doing more load balancing work, while the current busy task on that cpu
is eagerly waiting for the cpu cycles). Also busy load balancing intervals are
quite different from idle load balancing intervals. Similar to the first
mechanism, we won't be able to respond quickly to change in loads. And also
figuring out that a cpu is heavily loaded and where that extra load need to
moved, is some what difficult job, especially so in the case of hierarchical
scheduler domains.

Appended patch takes a third route which nominates an owner among
the idle cpus, which does the idle load balancing on behalf of the other
idle cpus. And once all the cpus are completely idle, then we can stop
this idle load balancing too. Checks added in fast path are minimized.
Whenever there are busy cpus in the system, there will be an owner(idle cpu)
doing the system wide idle load balancing. If we nominate this owner
carefully(like an idle core in a busy package), we can minimize the power
wasted also.

Some of the questions I have are: Will this single owner become bottleneck?
Idle load balancing is now serialized among all the idle cpus. This perhaps
will add some delays in load movement to different idle cpus. IMO, these
delays will be small and tolerable. If this comes out to be a concern, we
can offload the actual load movement work to the idle cpu, where the load
will be finally run.

Any more optimizations we can do to start/stop_sched_tick() routines to track
this info more efficiently?

Comments and review feedback welcome. Minimal testing done on couple of
i386 platforms. Perf testing yet to be done.

thanks,
suresh
---
Track the cpus for which ticks are stopped and one among these cpus will
be doing the idle load balancing on behalf of all the remaining cpus.
If the ticks are stopped for all the cpus in the system, idle load balancing
will stop at that moment. And restarts as soon as there is a busy cpu in
the system.

TBD: Select the appropriate idle cpu for doing this idle load balancing.
Such as an idle core in a busy package(which has a busy core). Selecting an idle
thread as the owner when there are other busy thread siblings is
not a good idea.

We can also think of offloading the task movements from the idle load balancing
owner to the idle cpu on behalf of which this work is being done.

Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>
---

diff -pNru linux-2.6.19-mm1/include/linux/sched.h linux/include/linux/sched.h
--- linux-2.6.19-mm1/include/linux/sched.h	2006-12-12 06:39:22.000000000 -0800
+++ linux/include/linux/sched.h	2006-12-12 06:51:03.000000000 -0800
@@ -195,6 +195,14 @@ extern void sched_init_smp(void);
 extern void init_idle(struct task_struct *idle, int cpu);
 
 extern cpumask_t nohz_cpu_mask;
+#ifdef CONFIG_SMP
+extern int select_notick_load_balancer(int cpu);
+#else
+static inline int select_notick_load_balancer(int cpu)
+{
+	return 0;
+}
+#endif
 
 /*
  * Only dump TASK_* tasks. (-1 for all tasks)
diff -pNru linux-2.6.19-mm1/kernel/hrtimer.c linux/kernel/hrtimer.c
--- linux-2.6.19-mm1/kernel/hrtimer.c	2006-12-12 06:39:22.000000000 -0800
+++ linux/kernel/hrtimer.c	2006-12-12 06:51:03.000000000 -0800
@@ -600,6 +600,9 @@ void hrtimer_stop_sched_tick(void)
 		 * the scheduler tick in hrtimer_restart_sched_tick.
 		 */
 		if (!cpu_base->tick_stopped) {
+			if (select_notick_load_balancer(1))
+				goto end;
+
 			cpu_base->idle_tick = cpu_base->sched_timer.expires;
 			cpu_base->tick_stopped = 1;
 			cpu_base->idle_jiffies = last_jiffies;
@@ -616,6 +619,7 @@ void hrtimer_stop_sched_tick(void)
 			raise_softirq_irqoff(TIMER_SOFTIRQ);
 	}
 
+end:
 	local_irq_restore(flags);
 }
 
@@ -630,6 +634,8 @@ void hrtimer_restart_sched_tick(void)
 	unsigned long ticks;
 	ktime_t now, delta;
 
+	select_notick_load_balancer(0);
+
 	if (!cpu_base->hres_active || !cpu_base->tick_stopped)
 		return;
 
diff -pNru linux-2.6.19-mm1/kernel/sched.c linux/kernel/sched.c
--- linux-2.6.19-mm1/kernel/sched.c	2006-12-12 06:39:22.000000000 -0800
+++ linux/kernel/sched.c	2006-12-12 07:03:38.000000000 -0800
@@ -1041,6 +1041,15 @@ static void resched_task(struct task_str
 	if (!tsk_is_polling(p))
 		smp_send_reschedule(cpu);
 }
+static void resched_cpu(int cpu)
+{
+	struct rq *rq = cpu_rq(cpu);
+	unsigned int flags;
+
+	spin_lock_irqsave(&rq->lock, flags);
+	resched_task(cpu_curr(cpu));
+	spin_unlock_irqrestore(&rq->lock, flags);
+}
 #else
 static inline void resched_task(struct task_struct *p)
 {
@@ -2641,6 +2650,9 @@ redo:
 		double_rq_unlock(this_rq, busiest);
 		local_irq_restore(flags);
 
+		if (nr_moved && this_cpu != smp_processor_id())
+			resched_cpu(this_cpu);
+
 		/* All tasks on this runqueue were pinned by CPU affinity */
 		if (unlikely(all_pinned)) {
 			cpu_clear(cpu_of(busiest), cpus);
@@ -2909,6 +2921,66 @@ static void update_load(struct rq *this_
 	}
 }
 
+#ifdef CONFIG_NO_HZ
+struct {
+	int load_balancer;
+	cpumask_t  cpu_mask;
+} notick ____cacheline_aligned = {
+	.load_balancer = -1,
+	.cpu_mask = CPU_MASK_NONE,
+};
+
+/*
+ * This routine will try to nominate the ilb (idle load balancing)
+ * owner among the cpus whose ticks are stopped. ilb owner will do the idle
+ * load balancing on behalf of all those cpus. If all the cpus in the system
+ * go into this tickless mode, then there will be no ilb owner (as there is
+ * no need for one) and all the cpus will sleep till the next wakeup event
+ * arrives...
+ *
+ * For the ilb owner, tick is not stopped. And this tick will be used
+ * for idle load balancing. ilb owner will still be part of
+ * notick.cpu_mask..
+ *
+ * While stopping the tick, this cpu will become the ilb owner if there
+ * is no other owner. And will be the owner till that cpu becomes busy
+ * or if all cpus in the system stop their ticks at which point
+ * there is no need for ilb owner.
+ *
+ * When the ilb owner becomes busy, it nominates another owner, during the
+ * schedule()
+ */
+int select_notick_load_balancer(int stop_tick)
+{
+	int cpu = smp_processor_id();
+
+	if (stop_tick) {
+		cpu_set(cpu, notick.cpu_mask);
+
+		/* time for ilb owner also to sleep */
+		if (cpus_weight(notick.cpu_mask) == num_online_cpus())
+			return 0;
+
+		if (notick.load_balancer == -1) {
+			/* make me the ilb owner */
+			if (cmpxchg(&notick.load_balancer, -1, cpu) == -1)
+				return 1;
+		} else if (notick.load_balancer == cpu)
+			return 1;
+	} else {
+		if (!cpu_isset(cpu, notick.cpu_mask))
+			return 0;
+
+		cpu_clear(cpu, notick.cpu_mask);
+
+		if (notick.load_balancer == cpu)
+			if (cmpxchg(&notick.load_balancer,  cpu, -1) != cpu)
+				BUG();
+	}
+	return 0;
+}
+#endif
+
 /*
  * run_rebalance_domains is triggered when needed from the scheduler tick.
  *
@@ -2925,18 +2997,47 @@ static void run_rebalance_domains(struct
 	struct rq *this_rq = cpu_rq(this_cpu);
 	unsigned long interval;
 	struct sched_domain *sd;
+	enum idle_type idle;
+	unsigned long next_balance;
+#ifdef CONFIG_NO_HZ
+	cpumask_t cpus = notick.cpu_mask;
+	int local_cpu = this_cpu;
+
+	/*
+	 * Check if it is time for ilb to stop.
+	 */
+	if (idle_cpu(local_cpu) && notick.load_balancer == local_cpu &&
+	    cpus_weight(cpus) == num_online_cpus()) {
+		resched_cpu(local_cpu);
+		return;
+	}
+
+restart:
+	if (idle_cpu(local_cpu) && notick.load_balancer == local_cpu) {
+		this_cpu = first_cpu(cpus);
+		this_rq = cpu_rq(this_cpu);
+		cpu_clear(this_cpu, cpus);
+	}
+#endif
+
 	/*
 	 * We are idle if there are no processes running. This
 	 * is valid even if we are the idle process (SMT).
 	 */
-	enum idle_type idle = !this_rq->nr_running ?
+	idle = !this_rq->nr_running ?
 				SCHED_IDLE : NOT_IDLE;
 	/* Earliest time when we have to call run_rebalance_domains again */
-	unsigned long next_balance = jiffies + 60*HZ;
+	next_balance = jiffies + 60*HZ;
 
 	__count_vm_event(SCHED_BALANCE_SOFTIRQ);
 
 	for_each_domain(this_cpu, sd) {
+#ifdef CONFIG_NO_HZ
+		if (idle_cpu(local_cpu) && notick.load_balancer == local_cpu
+		    && need_resched())
+			return;
+#endif
+
 		if (!(sd->flags & SD_LOAD_BALANCE))
 			continue;
 
@@ -2983,6 +3084,12 @@ out:
 			break;
 	}
 	this_rq->next_balance = next_balance;
+
+#ifdef CONFIG_NO_HZ
+	if (idle_cpu(local_cpu) && notick.load_balancer == local_cpu &&
+	    !cpus_empty(cpus))
+		goto restart;
+#endif
 }
 #else
 /*
@@ -3562,6 +3669,21 @@ switch_tasks:
 		++*switch_count;
 
 		prepare_task_switch(rq, next);
+#if defined(CONFIG_HZ) && defined(CONFIG_SMP)
+		if (prev == rq->idle && notick.load_balancer == -1) {
+			/*
+			 * simple selection for now: Nominate the first cpu in
+			 * the notick list to be the next ilb owner.
+			 *
+			 * TBD: Traverse the sched domains and nominate
+			 * the nearest cpu in the notick.cpu_mask.
+			 */
+			int ilb = first_cpu(notick.cpu_mask);
+
+			if (ilb != NR_CPUS)
+				resched_cpu(ilb);
+		}
+#endif
 		prev = context_switch(rq, prev, next);
 		barrier();
 		/*
