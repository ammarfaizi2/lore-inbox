Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292909AbSBVS53>; Fri, 22 Feb 2002 13:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292933AbSBVS5V>; Fri, 22 Feb 2002 13:57:21 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:27779 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S292909AbSBVS5L>;
	Fri, 22 Feb 2002 13:57:11 -0500
Date: Fri, 22 Feb 2002 10:56:06 -0800
From: Mike Kravetz <kravetz@us.ibm.com>
To: lse-tech@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: NUMA scheduling
Message-ID: <20020222105606.C1575@w-mikek2.des.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Below is preliminary patch to implement some form of NUMA scheduling
on top of Ingo's K3 scheduler patch for 2.4.17.  This is VERY early
code and brings up some issues that need to be discussed/explored in
more detail.  This patch was created to form a basis for discussion,
rather than as a solution.  The patch was created for the i386 based
NUMA system I have access to.  It will not work on other architectures.
However, the only architecture specific code is a call to initialize
some of the NUMA specific scheduling data structures.  Therefore, it
should be trivial to port.

Here is what the patch does:
- Creates 'cpu sets', which are sets of cpus that tasks can be scheduled
  on.  The cpus in these sets should all have something in common
  such as local memory, a shared cache, etc.

- In general, once a task begins execution on a cpu set, it remains
  on that cpu set.  The load balancing code that exists in the K3
  scheduler is used to balance the load among cpus within a set.

- Load balancing also takes place across cpu set boundaries.  Load
  balancing across set boundaries can happen:
  - at exec time.  This is an obvious choice since we have just thrown
    away a tasks address space and are about to create a new one.  The
    exec'ing task is migrated to the least loaded cpu set
  - when a cpu goes idle.  At this time we first look for another
    task to run within the cpu set.  If there is no task available
    within the set, then we attempt to get a task from the most
    loaded cpu set.
  - at specified intervals when a cpu is idle.  In the K3 scheduler,
    the timer code notices a cpu is idle and looks for more work
    to do.  First it checks other runqueues within the cpu set.  If
    nothing is found, it attempts to get a task from the most loaded
    cpu set.
  - at specified intervals when a cpu is busy.  This is also kicked
    off via the timer interrupt code.  It simply attempts to move
    tasks from the most loaded cpu sets to the least loaded cpu sets.
  For the most part, cpu set load balancing is invoked in the same places
  as cpu to cpu load balancing in the K3 scheduler.  The only exception
  is exec time task placement.  In the patch, the various forms of
  cpu set load balancing are behind #defines which can be turned on or
  off for experimentation.

Things not addressed in the patch:
- Topology discovery.  To create cpu sets, a routine numa_sched_init()
  is called after we know how many cpus there are in the system.
  Inside numa_sched_init(), there are hard coded values used to indicate
  the number of cpus per set, and the 'distance' between sets.
  Obviously, creation of cpu sets would be based on topology information
  that is not available at this time.  In addition, there should be
  support for (or at least an understanding of) non-symmetric and
  multi-level topologies.
- Tasks should have a notion of a 'home' cpu set.  Short term execution
  of a task on a remote cpu set should only be done to take advantage
  of idle cpus.  Tasks should only execute for short periods of time on
  remote cpu sets.  Most task execution should occur on the home cpu set.
  Long term execution on a remote cpu set would involve a full task
  migration which includes moving/copying the memory associated with
  the task.
- Partitioning of scheduling data.  On a NUMA architecture, data
  structures should be backed by memory local to the cpus which will be
  accessing them most frequently.  Therefore, things like runqueues
  and cpu_sets should not be arrays.
- Better determination for what tasks to execute remotely/migrate.
  The path uses the existing code in load_balance().  Most likely this
  will be sufficient.

-- 
Mike

diff -Naur linux-2.4.17-sched.orig/arch/i386/kernel/smpboot.c linux-2.4.17-ns/arch/i386/kernel/smpboot.c
--- linux-2.4.17-sched.orig/arch/i386/kernel/smpboot.c	Thu Feb  7 17:43:14 2002
+++ linux-2.4.17-ns/arch/i386/kernel/smpboot.c	Mon Feb 11 18:54:33 2002
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
diff -Naur linux-2.4.17-sched.orig/fs/exec.c linux-2.4.17-ns/fs/exec.c
--- linux-2.4.17-sched.orig/fs/exec.c	Fri Dec 21 17:41:55 2001
+++ linux-2.4.17-ns/fs/exec.c	Mon Feb 11 19:39:59 2002
@@ -860,6 +860,10 @@
 	int retval;
 	int i;
 
+#if CONFIG_SMP
+	sched_exec_migrate();
+#endif
+
 	file = open_exec(filename);
 
 	retval = PTR_ERR(file);
diff -Naur linux-2.4.17-sched.orig/include/linux/sched.h linux-2.4.17-ns/include/linux/sched.h
--- linux-2.4.17-sched.orig/include/linux/sched.h	Thu Feb  7 20:25:29 2002
+++ linux-2.4.17-ns/include/linux/sched.h	Tue Feb 12 22:45:59 2002
@@ -152,6 +152,7 @@
 extern void sched_task_migrated(task_t *p);
 extern void smp_migrate_task(int cpu, task_t *task);
 extern unsigned long cache_decay_ticks;
+extern void sched_exec_migrate(void);
 
 #define	MAX_SCHEDULE_TIMEOUT	LONG_MAX
 extern signed long FASTCALL(schedule_timeout(signed long timeout));
diff -Naur linux-2.4.17-sched.orig/kernel/sched.c linux-2.4.17-ns/kernel/sched.c
--- linux-2.4.17-sched.orig/kernel/sched.c	Thu Feb  7 17:43:13 2002
+++ linux-2.4.17-ns/kernel/sched.c	Thu Feb 14 16:59:57 2002
@@ -20,6 +20,53 @@
 #include <linux/interrupt.h>
 #include <asm/mmu_context.h>
 
+/*
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
 #define BITMAP_SIZE ((((MAX_PRIO+7)/8)+sizeof(long)-1)/sizeof(long))
 
 typedef struct runqueue runqueue_t;
@@ -41,6 +88,7 @@
  */
 struct runqueue {
 	spinlock_t lock;
+	cpu_set_t *cpu_set;
 	unsigned long nr_running, nr_switches, expired_timestamp;
 	task_t *curr, *idle;
 	prio_array_t *active, *expired, arrays[2];
@@ -395,11 +443,13 @@
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
@@ -430,7 +480,11 @@
 
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
@@ -438,6 +492,9 @@
 			load = this_rq->prev_nr_running[i];
 		this_rq->prev_nr_running[i] = rq_src->nr_running;
 
+		total_set_load += load;
+		cpus_in_set++;
+
 		if ((load > max_load) && (rq_src != this_rq)) {
 			busiest = rq_src;
 			max_load = load;
@@ -458,10 +515,20 @@
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
@@ -534,6 +601,49 @@
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
@@ -545,16 +655,104 @@
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
@@ -618,6 +816,11 @@
 #if CONFIG_SMP
 	if (!(now % BUSY_REBALANCE_TICK))
 		load_balance(rq, 0);
+
+#ifdef BUSY_REBALANCE
+	if (!(now % CS_BUSY_REBALANCE_TICK))
+		balance_cpu_sets(rq, 0);
+#endif
 #endif
 	spin_unlock(&rq->lock);
 }
@@ -659,6 +862,10 @@
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
@@ -1332,10 +1539,20 @@
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
@@ -1372,3 +1589,42 @@
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
