Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293050AbSBWAAl>; Fri, 22 Feb 2002 19:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293048AbSBWAA1>; Fri, 22 Feb 2002 19:00:27 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:30194 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S293046AbSBWAAI>;
	Fri, 22 Feb 2002 19:00:08 -0500
Date: Fri, 22 Feb 2002 15:59:50 -0800
From: Mike Kravetz <kravetz@us.ibm.com>
To: lse-tech@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] NUMA scheduling
Message-ID: <20020222155950.A2815@w-mikek2.des.beaverton.ibm.com>
In-Reply-To: <20020222105606.C1575@w-mikek2.des.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020222105606.C1575@w-mikek2.des.beaverton.ibm.com>; from kravetz@us.ibm.com on Fri, Feb 22, 2002 at 10:56:06AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2002 at 10:56:06AM -0800, Mike Kravetz wrote:
> Below is preliminary patch to implement some form of NUMA scheduling
> on top of Ingo's K3 scheduler patch for 2.4.17.

My apologies, the previously included patch was created on top of
of Ingo's J9 scheduler patch.  The patch below is built on K3.

-- 
Mike

diff -Naur linux-2.4.17-K3/arch/i386/kernel/smpboot.c linux-2.4.17-K3-ns/arch/i386/kernel/smpboot.c
--- linux-2.4.17-K3/arch/i386/kernel/smpboot.c	Thu Feb 14 18:42:53 2002
+++ linux-2.4.17-K3-ns/arch/i386/kernel/smpboot.c	Thu Feb 14 17:38:51 2002
@@ -1198,6 +1198,11 @@
 			}
 		}
 	}
+
+	/*
+	 * Hack to get cpu sets initialized on NUMA architectures
+	 */
+	numa_sched_init();
 	     
 #ifndef CONFIG_VISWS
 	/*
diff -Naur linux-2.4.17-K3/fs/exec.c linux-2.4.17-K3-ns/fs/exec.c
--- linux-2.4.17-K3/fs/exec.c	Fri Dec 21 17:41:55 2001
+++ linux-2.4.17-K3-ns/fs/exec.c	Thu Feb 14 17:38:51 2002
@@ -860,6 +860,10 @@
 	int retval;
 	int i;
 
+#if CONFIG_SMP
+	sched_exec_migrate();
+#endif
+
 	file = open_exec(filename);
 
 	retval = PTR_ERR(file);
diff -Naur linux-2.4.17-K3/include/linux/sched.h linux-2.4.17-K3-ns/include/linux/sched.h
--- linux-2.4.17-K3/include/linux/sched.h	Thu Feb 14 18:46:54 2002
+++ linux-2.4.17-K3-ns/include/linux/sched.h	Thu Feb 14 17:52:18 2002
@@ -152,6 +152,7 @@
 extern void sched_task_migrated(task_t *p);
 extern void smp_migrate_task(int cpu, task_t *task);
 extern unsigned long cache_decay_ticks;
+extern void sched_exec_migrate(void);
 
 #define	MAX_SCHEDULE_TIMEOUT	LONG_MAX
 extern signed long FASTCALL(schedule_timeout(signed long timeout));
diff -Naur linux-2.4.17-K3/kernel/sched.c linux-2.4.17-K3-ns/kernel/sched.c
--- linux-2.4.17-K3/kernel/sched.c	Thu Feb 14 18:42:52 2002
+++ linux-2.4.17-K3-ns/kernel/sched.c	Thu Feb 14 17:40:47 2002
@@ -22,6 +22,53 @@
 #include <linux/kernel_stat.h>
 
 /*
+ * Definitions that depend on/should be part of NUMA topology discovery
+ */
+/*
+ * Periodically poll for new (off cpu set) work as part of the idle loop
+#define IDLE_LOOP_REBALANCE
+ */
+/*
+ * Look for off cpu set work before going idle
+ */
+#define GOING_IDLE_REBALANCE
+/*
+ * Attempt to balance load between cpu sets (even when busy)
+#define BUSY_REBALANCE
+ */
+/*
+ * Send tasks to least loaded CPU at exec time
+ */
+#define EXEC_BALANCE
+
+#define NR_CPU_SETS		NR_CPUS
+
+union cpu_set {
+	struct cpu_set_data {
+		spinlock_t lock;
+		unsigned long local_cpus;
+		unsigned long load_avg;
+	} csd;
+	char __pad [SMP_CACHE_BYTES];
+};
+typedef union cpu_set cpu_set_t;
+#define cs_lock		csd.lock
+#define	cs_local_cpus	csd.local_cpus
+#define cs_load_avg	csd.load_avg
+
+static int numa_num_cpu_sets = 0;
+static int numa_cpus_per_local_set = NR_CPUS;
+static int numa_cpu_set_distance = 1;
+static cpu_set_t cpu_sets[NR_CPU_SETS] __cacheline_aligned;
+
+#define cpu_to_set_id(c)	((c) / numa_cpus_per_local_set)
+#define next_cs_id(c)		((c) + 1 == numa_num_cpu_sets ? 0 : (c) + 1)
+#define cpu_to_set(c)		(cpu_sets + ((c) / numa_cpus_per_local_set))
+/*
+ * End of NUMA definitions
+ */
+
+/*
  * Priority of a process goes from 0 to 139. The 0-99
  * priority range is allocated to RT tasks, the 100-139
  * range is for SCHED_OTHER tasks. Priority values are
@@ -140,6 +187,7 @@
  */
 struct runqueue {
 	spinlock_t lock;
+	cpu_set_t *cpu_set;
 	unsigned long nr_running, nr_switches, expired_timestamp;
 	task_t *curr, *idle;
 	prio_array_t *active, *expired, arrays[2];
@@ -484,11 +532,13 @@
 static void load_balance(runqueue_t *this_rq, int idle)
 {
 	int imbalance, nr_running, load, max_load,
-		idx, i, this_cpu = smp_processor_id();
+		idx, i, this_cpu = smp_processor_id(),
+		total_set_load = 0, cpus_in_set = 0;
 	task_t *next = this_rq->idle, *tmp;
 	runqueue_t *busiest, *rq_src;
 	prio_array_t *array;
 	list_t *head, *curr;
+	unsigned long target_cpu_set;
 
 	/*
 	 * We search all runqueues to find the most busy one.
@@ -519,7 +569,11 @@
 
 	busiest = NULL;
 	max_load = 1;
+	target_cpu_set = this_rq->cpu_set->cs_local_cpus;
 	for (i = 0; i < smp_num_cpus; i++) {
+		/* Skip CPUs not in the target set */
+		if (!(target_cpu_set & (1UL << cpu_logical_map(i))))
+			continue;
 		rq_src = cpu_rq(cpu_logical_map(i));
 		if (idle || (rq_src->nr_running < this_rq->prev_nr_running[i]))
 			load = rq_src->nr_running;
@@ -527,6 +581,9 @@
 			load = this_rq->prev_nr_running[i];
 		this_rq->prev_nr_running[i] = rq_src->nr_running;
 
+		total_set_load += load;
+		cpus_in_set++;
+
 		if ((load > max_load) && (rq_src != this_rq)) {
 			busiest = rq_src;
 			max_load = load;
@@ -547,10 +604,20 @@
 	 * Make sure nothing changed since we checked the
 	 * runqueue length.
 	 */
-	if (busiest->nr_running <= this_rq->nr_running + 1)
+	if (busiest->nr_running <= nr_running + 1)
 		goto out_unlock;
 
 	/*
+	 * Update cpu set load average
+	 */
+	total_set_load = total_set_load / cpus_in_set;
+	if (total_set_load != this_rq->cpu_set->cs_load_avg) {
+		spin_lock(&this_rq->cpu_set->cs_lock);
+		this_rq->cpu_set->cs_load_avg = total_set_load;
+		spin_unlock(&this_rq->cpu_set->cs_lock);
+	}
+
+	/*
 	 * We first consider expired tasks. Those will likely not be
 	 * executed in the near future, and they are most likely to
 	 * be cache-cold, thus switching CPUs has the least effect
@@ -623,6 +690,49 @@
 	spin_unlock(&busiest->lock);
 }
 
+#if defined(IDLE_LOOP_REBALANCE) || defined(GOING_IDLE_REBALANCE) || \
+    defined(BUSY_REBALANCE)
+/*
+ * Load balance CPU sets
+ */
+static void balance_cpu_sets(runqueue_t *this_rq, int idle)
+{
+	int i, this_load, max_load;
+	cpu_set_t *this_set, *target_set = NULL;
+
+	this_set = cpu_to_set(smp_processor_id());
+	this_load = this_set->cs_load_avg;
+
+	if (this_load > 1)
+		max_load = this_load;
+	else {
+		if (idle)
+			max_load = 0;	/* Looking for anything! */
+		else
+			max_load = 1;
+	}
+
+	for(i = 0; i < numa_num_cpu_sets; i++) {
+		if (cpu_sets[i].cs_load_avg > max_load) {
+			max_load = cpu_sets[i].cs_load_avg;
+			target_set = &cpu_sets[i];
+		}
+	}
+
+	if (!target_set || (max_load <= this_load))
+		return;
+
+	/*
+	 * We point current CPU at target cpu_set.  This is safe
+	 * because the caller ensures the current CPUs runqueue
+	 * is locked.
+	 */
+	this_rq()->cpu_set = target_set;
+	load_balance(this_rq, idle);
+	this_rq()->cpu_set = this_set;
+}
+#endif
+
 /*
  * One of the idle_cpu_tick() or the busy_cpu_tick() function will
  * gets called every timer tick, on every CPU. Our balancing action
@@ -634,16 +744,104 @@
  */
 #define BUSY_REBALANCE_TICK (HZ/4 ?: 1)
 #define IDLE_REBALANCE_TICK (HZ/1000 ?: 1)
+#define CS_IDLE_REBALANCE_TICK (IDLE_REBALANCE_TICK * numa_cpu_set_distance)
+#define CS_BUSY_REBALANCE_TICK (BUSY_REBALANCE_TICK * numa_cpu_set_distance)
 
 static inline void idle_tick(void)
 {
-	if (jiffies % IDLE_REBALANCE_TICK)
+	unsigned long now = jiffies;
+
+	if (now % IDLE_REBALANCE_TICK)
 		return;
 	spin_lock(&this_rq()->lock);
 	load_balance(this_rq(), 1);
+
+#ifdef IDLE_LOOP_REBALANCE
+	/*
+	 * If there are no waiting tasks on the local cpu set, then
+	 * at least take a look at other sets.
+	 */
+	if (!this_rq()->nr_running && !(now % CS_IDLE_REBALANCE_TICK))
+		balance_cpu_sets(this_rq(), 1);
+#endif
+
 	spin_unlock(&this_rq()->lock);
 }
 
+/*
+ * Code to be executed as part of the exec path on NUMA architectures.
+ * Since exec throws away the old process image, there is little
+ * advantage to keeping the task on the same cpu set.  Therefore, we
+ * consider moving the task to the least laded cpu set.
+ */
+void sched_exec_migrate(void)
+{
+#ifdef EXEC_BALANCE
+	int this_cpu, this_cs_id, this_load_avg, min_load_avg,
+		i, target_cs_id, target_cpu;
+	unsigned long target_cs_mask,
+		cpus_allowed = current->cpus_allowed;
+	runqueue_t *rq;
+
+	/*
+	 * Only consider migration if other tasks are waiting for
+	 * this CPU, and the load average for this cpu set is
+	 * greater than 1.  Also, make sure the task is allowed
+	 * to run on another cpu set.
+	 */
+	this_cpu = smp_processor_id();
+	if (cpu_rq(this_cpu)->nr_running < 2)
+		return;
+
+	this_cs_id = cpu_to_set_id(this_cpu);
+	this_load_avg = cpu_sets[this_cs_id].cs_load_avg;
+	if (this_load_avg < 1)
+		return;
+
+	if (!(cpus_allowed & ~(cpu_sets[this_cs_id].cs_local_cpus)))
+		return;
+
+	/*
+	 * Look for another cpu set with a lower load average.
+	 */
+	min_load_avg = this_load_avg;
+	target_cs_id = this_cs_id;
+	for (i = next_cs_id(this_cs_id); i != this_cs_id; i = next_cs_id(i)) {
+		if (!(cpus_allowed & cpu_sets[i].cs_local_cpus))
+			continue;
+		if (cpu_sets[i].cs_load_avg < min_load_avg) {
+			min_load_avg = cpu_sets[i].cs_load_avg;
+			target_cs_id = i;
+		}
+	}
+	if (!(min_load_avg < this_load_avg))
+		return;
+
+	/*
+	 * Find shortest runqueue on target cpu set.
+	 */
+	min_load_avg = INT_MAX;
+	target_cs_mask = cpu_sets[target_cs_id].cs_local_cpus;
+	target_cpu = this_cpu;
+	for (i=0; i < smp_num_cpus; i++) {
+		if (!(cpus_allowed & target_cs_mask & (1UL << i)))
+			continue;
+		rq = cpu_rq(cpu_logical_map(i));
+		if (rq->nr_running < min_load_avg) {
+			min_load_avg = rq->nr_running;
+			target_cpu = cpu_logical_map(i);
+		}
+	}
+			
+	/*
+	 * Migrate task
+	 */
+	current->state = TASK_UNINTERRUPTIBLE;
+	smp_migrate_task(target_cpu, current);
+	schedule();
+#endif
+}
+
 #endif
 
 /*
@@ -732,6 +930,11 @@
 #if CONFIG_SMP
 	if (!(jiffies % BUSY_REBALANCE_TICK))
 		load_balance(rq, 0);
+
+#ifdef BUSY_REBALANCE
+	if (!(now % CS_BUSY_REBALANCE_TICK))
+		balance_cpu_sets(rq, 0);
+#endif
 #endif
 	spin_unlock(&rq->lock);
 }
@@ -772,6 +975,10 @@
 	if (unlikely(!rq->nr_running)) {
 #if CONFIG_SMP
 		load_balance(rq, 1);
+#ifdef GOING_IDLE_REBALANCE
+		if (!rq->nr_running)
+			balance_cpu_sets(rq, 1);
+#endif
 		if (rq->nr_running)
 			goto pick_next_task;
 #endif
@@ -1488,10 +1695,20 @@
 	runqueue_t *rq;
 	int i, j, k;
 
+	/*
+	 * Default is to have a single cpu set containing all CPUs
+	 */
+	numa_num_cpu_sets = 0;
+	cpu_sets[0].cs_lock = SPIN_LOCK_UNLOCKED;
+	cpu_sets[0].cs_local_cpus = -1;
+	cpu_sets[0].cs_load_avg = 0;
+
 	for (i = 0; i < NR_CPUS; i++) {
 		runqueue_t *rq = cpu_rq(i);
 		prio_array_t *array;
 
+		rq->cpu_set = &cpu_sets[0];
+
 		rq->active = rq->arrays + 0;
 		rq->expired = rq->arrays + 1;
 		spin_lock_init(&rq->lock);
@@ -1528,3 +1745,42 @@
 	atomic_inc(&init_mm.mm_count);
 	enter_lazy_tlb(&init_mm, current, smp_processor_id());
 }
+
+void numa_sched_init(void)
+{
+	int i, cpu_set_num;
+	unsigned long numa_local_cpu_set_mask;
+
+#define NUMA_CPUS_PER_LOCAL_SET	4
+#define NUMA_CPU_SET_DISTANCE	2
+
+	numa_cpus_per_local_set = NUMA_CPUS_PER_LOCAL_SET;
+	numa_cpu_set_distance = NUMA_CPU_SET_DISTANCE;
+
+	numa_local_cpu_set_mask = 0UL;
+	for (i=0; i<numa_cpus_per_local_set; i++) {
+		numa_local_cpu_set_mask = numa_local_cpu_set_mask << 1;
+		numa_local_cpu_set_mask |= 0x1UL;
+	}
+
+	/*
+	 * Make sure all runqueues point to the correct cpu_set
+	 */
+	cpu_set_num = -1;
+	numa_num_cpu_sets = 0;
+	for (i=0; i<smp_num_cpus; i++) {
+		if (cpu_to_set_id(i) != cpu_set_num) {
+			cpu_set_num = cpu_to_set_id(i);
+
+			cpu_sets[cpu_set_num].cs_lock = SPIN_LOCK_UNLOCKED;
+			cpu_sets[cpu_set_num].cs_local_cpus =
+				numa_local_cpu_set_mask <<
+				(cpu_set_num * numa_cpus_per_local_set);
+			cpu_sets[cpu_set_num].cs_load_avg = 0;
+
+			numa_num_cpu_sets++;
+		}
+
+		runqueues[i].cpu_set = &cpu_sets[cpu_set_num];
+	}
+}
