Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261211AbUCAGxo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 01:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262255AbUCAGxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 01:53:44 -0500
Received: from mail009.syd.optusnet.com.au ([211.29.132.64]:1461 "EHLO
	mail009.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261211AbUCAGxd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 01:53:33 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] SMT Nice 2.6.4-rc1-mm1
Date: Mon, 1 Mar 2004 17:52:46 +1100
User-Agent: KMail/1.6
Cc: Andrew Morton <akpm@osdl.org>, Nick Piggin <piggin@cyberone.com.au>,
       Ingo Molnar <mingo@elte.hu>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_+2tQAmjBe6TF6qC"
Message-Id: <200403011752.56600.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_+2tQAmjBe6TF6qC
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


This patch provides full per-package priority support for SMT processors (a=
ka=20
pentium4 hyperthreading) when combined with CONFIG_SCHED_SMT.

It maintains cpu percentage distribution within each physical cpu package b=
y=20
limiting the time a lower priority task can run on a sibling cpu concurrent=
ly=20
with a higher priority task.

It introduces a new flag into the scheduler domain
unsigned int per_cpu_gain;	/* CPU % gained by adding domain cpus */

This is empirically set to 15% for pentium4 at the moment and can be modifi=
ed=20
to support different values dynamically as newer processors come out with=20
improved SMT performance. It should not matter how many siblings there are.

How it works is it compares tasks running on sibling cpus and when a lower=
=20
static priority task is running it will delay it till=20
high_priority_timeslice * (100 - per_cpu_gain) / 100 <=3D low_prio_timeslice

eg. a nice 19 task timeslice is 10ms and nice 0 timeslice is 102ms
On vanilla the nice 0 task runs on one logical cpu while the nice 19 task r=
uns=20
unabated on the other logical cpu. With smtnice the nice 0 runs on one=20
logical cpu for 102ms and the nice 19 sleeps till the nice 0 task has 12ms=
=20
remaining and then will schedule.

Real time tasks and kernel threads are not altered by this code, and kernel=
=20
threads do not delay lower priority user tasks.

with lots of thanks to Zwane Mwaikambo and Nick Piggin for help with the=20
coding of this version.

If this is merged, it is probably best to delay pushing this upstream in=20
mainline till sched_domains gets tested for at least one major release.

Con Kolivas
=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAQt2+ZUg7+tp6mRURAvp0AJ0bBZRByQ3FRDwBaSGQALE28hYkywCghWNY
rUjZKrA+G0UHHCYsQsmXuPk=3D
=3DE06v
=2D----END PGP SIGNATURE-----

--Boundary-00=_+2tQAmjBe6TF6qC
Content-Type: text/x-diff;
  charset="us-ascii";
  name="patch-domain-smtnice"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="patch-domain-smtnice"

--- linux-2.6.4-rc1-mm1/arch/i386/kernel/smpboot.c	2004-03-01 10:02:12.000000000 +1100
+++ linux-2.6.4-rc1-mm1-smtnice/arch/i386/kernel/smpboot.c	2004-03-01 16:38:11.179367180 +1100
@@ -1159,8 +1159,12 @@ __init void arch_init_sched_domains(void
 		int j;
 		first_cpu = last_cpu = NULL;
 
-		if (i != first_cpu(cpu_domain->span))
+		if (i != first_cpu(cpu_domain->span)) {
+			cpu_sched_domain(i)->flags |= SD_FLAG_SHARE_CPUPOWER;
+			cpu_sched_domain(first_cpu(cpu_domain->span))->flags |=
+				SD_FLAG_SHARE_CPUPOWER;				
 			continue;
+		}
 
 		for_each_cpu_mask(j, cpu_domain->span) {
 			struct sched_group *cpu = &sched_group_cpus[j];
@@ -1279,8 +1283,12 @@ __init void arch_init_sched_domains(void
 		int j;
 		first_cpu = last_cpu = NULL;
 
-		if (i != first_cpu(cpu_domain->span))
+		if (i != first_cpu(cpu_domain->span)) {
+			cpu_sched_domain(i)->flags |= SD_FLAG_SHARE_CPUPOWER;
+			cpu_sched_domain(first_cpu(cpu_domain->span))->flags |=
+				SD_FLAG_SHARE_CPUPOWER;				
 			continue;
+		}
 
 		for_each_cpu_mask(j, cpu_domain->span) {
 			struct sched_group *cpu = &sched_group_cpus[j];
--- linux-2.6.4-rc1-mm1/include/linux/sched.h	2004-03-01 10:02:14.000000000 +1100
+++ linux-2.6.4-rc1-mm1-smtnice/include/linux/sched.h	2004-03-01 16:12:25.000000000 +1100
@@ -542,6 +542,7 @@ do { if (atomic_dec_and_test(&(tsk)->usa
 #define SD_FLAG_EXEC		2	/* Balance on exec */
 #define SD_FLAG_WAKE		4	/* Balance on task wakeup */
 #define SD_FLAG_FASTMIGRATE	8	/* Sync wakes put task on waking CPU */
+#define SD_FLAG_SHARE_CPUPOWER	16	/* Domain members share cpu power */
 
 struct sched_group {
 	struct sched_group *next;	/* Must be a circular list */
@@ -567,6 +568,7 @@ struct sched_domain {
 	unsigned int imbalance_pct;	/* No balance until over watermark */
 	unsigned long long cache_hot_time; /* Task considered cache hot (ns) */
 	unsigned int cache_nice_tries;	/* Leave cache hot tasks for # tries */
+	unsigned int per_cpu_gain;	/* CPU % gained by adding domain cpus */
 	int flags;			/* See SD_FLAG_* */
 
 	/* Runtime fields. */
@@ -586,6 +588,7 @@ struct sched_domain {
 	.imbalance_pct		= 110,			\
 	.cache_hot_time		= 0,			\
 	.cache_nice_tries	= 0,			\
+	.per_cpu_gain		= 15,			\
 	.flags			= SD_FLAG_FASTMIGRATE | SD_FLAG_NEWIDLE | SD_FLAG_WAKE,\
 	.last_balance		= jiffies,		\
 	.balance_interval	= 1,			\
@@ -603,6 +606,7 @@ struct sched_domain {
 	.imbalance_pct		= 125,			\
 	.cache_hot_time		= (5*1000000/2),	\
 	.cache_nice_tries	= 1,			\
+	.per_cpu_gain		= 100,			\
 	.flags			= SD_FLAG_FASTMIGRATE | SD_FLAG_NEWIDLE,\
 	.last_balance		= jiffies,		\
 	.balance_interval	= 1,			\
@@ -621,6 +625,7 @@ struct sched_domain {
 	.imbalance_pct		= 125,			\
 	.cache_hot_time		= (10*1000000),		\
 	.cache_nice_tries	= 1,			\
+	.per_cpu_gain		= 100,			\
 	.flags			= SD_FLAG_EXEC,		\
 	.last_balance		= jiffies,		\
 	.balance_interval	= 1,			\
--- linux-2.6.4-rc1-mm1/kernel/sched.c	2004-03-01 10:02:14.000000000 +1100
+++ linux-2.6.4-rc1-mm1-smtnice/kernel/sched.c	2004-03-01 13:42:02.000000000 +1100
@@ -207,9 +207,8 @@ struct runqueue {
 	struct mm_struct *prev_mm;
 	prio_array_t *active, *expired, arrays[2];
 	int best_expired_prio;
-
+	int cpu;
 	atomic_t nr_iowait;
-
 #ifdef CONFIG_SMP
 	unsigned long cpu_load[NR_CPUS];
 #endif
@@ -1785,6 +1784,25 @@ static inline void rebalance_tick(int th
 }
 #endif
 
+#ifdef CONFIG_SCHED_SMT
+static inline int wake_priority_sleeper(runqueue_t *rq)
+{	/*
+	 * If an SMT sibling task has been put to sleep for priority
+	 * reasons reschedule the idle task to see if it can now run.
+	 */
+	if (rq->nr_running) {
+		resched_task(rq->idle);
+		return 1;
+	}
+	return 0;
+}
+#else
+static inline int wake_priority_sleeper(runqueue_t *rq)
+{
+	return 0;
+}
+#endif
+
 DEFINE_PER_CPU(struct kernel_stat, kstat);
 
 EXPORT_PER_CPU_SYMBOL(kstat);
@@ -1838,6 +1856,8 @@ void scheduler_tick(int user_ticks, int 
 			cpustat->iowait += sys_ticks;
 		else
 			cpustat->idle += sys_ticks;
+		if (wake_priority_sleeper(rq))
+			goto out;
 		rebalance_tick(cpu, rq, IDLE);
 		return;
 	}
@@ -1925,6 +1945,93 @@ out:
 	rebalance_tick(cpu, rq, NOT_IDLE);
 }
 
+#ifdef CONFIG_SCHED_SMT
+static inline void wake_sleeping_dependent(runqueue_t *rq)
+{
+	int i, this_cpu = rq->cpu;
+	struct sched_domain *sd = cpu_sched_domain(this_cpu);
+	cpumask_t sibling_map;
+	
+	if (!(sd->flags & SD_FLAG_SHARE_CPUPOWER)) {
+		/* Not SMT */
+		return;
+	}
+	
+	cpus_and(sibling_map, sd->span, cpu_online_map);
+	cpu_clear(this_cpu, sibling_map);
+	for_each_cpu_mask(i, sibling_map) {
+		runqueue_t *smt_rq;
+		
+		smt_rq = cpu_rq(i);
+		
+		/*
+		 * If an SMT sibling task is sleeping due to priority
+		 * reasons wake it up now.
+		 */
+		if (smt_rq->curr == smt_rq->idle && smt_rq->nr_running)
+			resched_task(smt_rq->idle);
+	}
+}
+
+static inline int dependent_sleeper(runqueue_t *rq, task_t *p)
+{	
+	int ret = 0, i, this_cpu = rq->cpu;
+	struct sched_domain *sd = cpu_sched_domain(this_cpu);
+	cpumask_t sibling_map;
+	
+	if (!(sd->flags & SD_FLAG_SHARE_CPUPOWER)) {
+		/* Not SMT */
+		return 0;
+	}
+	
+	cpus_and(sibling_map, sd->span, cpu_online_map);
+	cpu_clear(this_cpu, sibling_map);
+	for_each_cpu_mask(i, sibling_map) {
+		runqueue_t *smt_rq;
+		task_t *smt_curr;
+		
+		smt_rq = cpu_rq(i);
+		smt_curr = smt_rq->curr;
+
+		/*
+		 * If a user task with lower static priority than the 
+		 * running task on the SMT sibling is trying to schedule,
+		 * delay it till there is proportionately less timeslice 
+		 * left of the sibling task to prevent a lower priority 
+		 * task from using an unfair proportion of the 
+		 * physical cpu's resources. -ck
+		 */
+		if (p->mm && smt_curr->mm && !rt_task(p) && 
+			((p->static_prio > smt_curr->static_prio && 
+			(smt_curr->time_slice * (100 - sd->per_cpu_gain) /
+			100) > task_timeslice(p)) || 
+			rt_task(smt_curr)))
+				ret |= 1;
+				
+		/*
+		 * Reschedule a lower priority task on the SMT sibling, 
+		 * or wake it up if it has been put to sleep for priority
+		 * reasons.
+		 */
+		if ((smt_curr != smt_rq->idle && 
+			smt_curr->static_prio > p->static_prio) ||
+			(rt_task(p) && !rt_task(smt_curr)) ||
+			(smt_curr == smt_rq->idle && smt_rq->nr_running))
+				resched_task(smt_curr);
+	}
+	return ret;
+}
+#else
+static inline void wake_sleeping_dependent(runqueue_t *rq)
+{
+}
+
+static inline int dependent_sleeper(runqueue_t *rq, task_t *p)
+{
+	return 0;
+}
+#endif
+
 void scheduling_functions_start_here(void) { }
 
 /*
@@ -1996,6 +2103,7 @@ need_resched:
 		if (!rq->nr_running) {
 			next = rq->idle;
 			rq->expired_timestamp = 0;
+			wake_sleeping_dependent(rq);
 			goto switch_tasks;
 		}
 	}
@@ -2015,6 +2123,11 @@ need_resched:
 	idx = sched_find_first_bit(array->bitmap);
 	queue = array->queue + idx;
 	next = list_entry(queue->next, task_t, run_list);
+	
+	if (dependent_sleeper(rq, next)) {
+		next = rq->idle;
+		goto switch_tasks;
+	}
 
 	if (next->activated > 0) {
 		unsigned long long delta = now - next->timestamp;
@@ -3526,6 +3639,7 @@ void __init sched_init(void)
 #endif
 
 		rq = cpu_rq(i);
+		rq->cpu = i;
 		rq->active = rq->arrays;
 		rq->expired = rq->arrays + 1;
 		rq->best_expired_prio = MAX_PRIO;

--Boundary-00=_+2tQAmjBe6TF6qC--
