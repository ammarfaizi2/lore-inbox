Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275885AbSIUJz5>; Sat, 21 Sep 2002 05:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275889AbSIUJz5>; Sat, 21 Sep 2002 05:55:57 -0400
Received: from ophelia.ess.nec.de ([193.141.139.8]:34197 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S275885AbSIUJzp>; Sat, 21 Sep 2002 05:55:45 -0400
From: Erich Focht <efocht@ess.nec.de>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] node affine NUMA scheduler
Date: Sat, 21 Sep 2002 11:59:41 +0200
User-Agent: KMail/1.4.1
Cc: LSE <lse-tech@lists.sourceforge.net>, Ingo Molnar <mingo@elte.hu>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_H39SRHAKGPZ790RK7DOT"
Message-Id: <200209211159.41751.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_H39SRHAKGPZ790RK7DOT
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

here is an update of the NUMA scheduler for the 2.5.37 kernel. It
contains some bugfixes and the coupling to discontigmem memory
allocation (memory is allocated from the processes' homenode).

The node affine NUMA scheduler is targeted for multi-node platforms
and built on top of the O(1) scheduler. Its main objective is to
keep the memory access latency for each task as low as possible by
scheduling it on or near the node on which its memory is allocated.
This should achieve the hard-affinity benefits automatically.

The patch comes in two parts. The first part is the core NUMA scheduler,
it is functional without the second part and provides following features:
 - Node aware scheduler (implemented CPU pools).
 - Scheduler behaves like O(1) scheduler within a node.
 - Equal load among nodes is targeted, stealing tasks from remote nodes
   is delayed more if the current node is averagely loaded, less if it's
   unloaded.
 - Multi-level node hierarchies are supported by stealing delays adjusted
   by the relative "node-distance" (memory access latency ratio).
=20
The second part of the patch extends the pooling NUMA scheduler to
have node affine tasks:
 - Each process has a homenode assigned to it at creation time
   (initial load balancing). Memory will be allocated from this node.
 - Each process is preferentially scheduled on its homenode and
   attracted back to it if scheduled away for some reason. For
   multi-level node hierarchies the task is attracted to its
   supernode, too.

The patch was tested on IA64 platforms but should work on NUMAQ i386,
too. Similar code for 2.4.18 (cf. http://home.arcor.de/efocht/sched)=20
runs in production environments since months.

Comments, tests, ports to other platforms/architectures are very welcome!

Regards,
Erich


--------------Boundary-00=_H39SRHAKGPZ790RK7DOT
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="01-numa_sched_core-2.5.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="01-numa_sched_core-2.5.patch"

diff -urNp a/arch/i386/config.in b/arch/i386/config.in
--- a/arch/i386/config.in	Fri Sep 20 17:20:22 2002
+++ b/arch/i386/config.in	Sat Sep 21 11:44:48 2002
@@ -177,6 +177,7 @@ else
      fi
      # Common NUMA Features
      if [ "$CONFIG_X86_NUMAQ" = "y" ]; then
+        bool 'Enable NUMA scheduler' CONFIG_NUMA_SCHED
         bool 'Numa Memory Allocation Support' CONFIG_NUMA
         if [ "$CONFIG_NUMA" = "y" ]; then
            define_bool CONFIG_DISCONTIGMEM y
diff -urNp a/arch/i386/kernel/smpboot.c b/arch/i386/kernel/smpboot.c
--- a/arch/i386/kernel/smpboot.c	Fri Sep 20 17:20:26 2002
+++ b/arch/i386/kernel/smpboot.c	Sat Sep 21 11:44:48 2002
@@ -765,6 +765,8 @@ static int __init wakeup_secondary_via_I
 
 extern unsigned long cpu_initialized;
 
+static int __initdata nr_lnodes = 0;
+
 static void __init do_boot_cpu (int apicid) 
 /*
  * NOTE - on most systems this is a PHYSICAL apic ID, but on multiquad
@@ -773,11 +775,17 @@ static void __init do_boot_cpu (int apic
 {
 	struct task_struct *idle;
 	unsigned long boot_error = 0;
-	int timeout, cpu;
+	int timeout, cpu, cell;
 	unsigned long start_eip;
 	unsigned short nmi_high, nmi_low;
 
 	cpu = ++cpucount;
+#ifdef CONFIG_NUMA_SCHED
+	cell = SAPICID_TO_PNODE(apicid);
+	if (pnode_to_lnode[cell] < 0) {
+		pnode_to_lnode[cell] = nr_lnodes++;
+	}
+#endif
 	/*
 	 * We can't use kernel_thread since we must avoid to
 	 * reschedule the child.
@@ -996,6 +1004,10 @@ static void __init smp_boot_cpus(unsigne
 	set_bit(0, &cpu_callout_map);
 	boot_cpu_logical_apicid = logical_smp_processor_id();
 	map_cpu_to_boot_apicid(0, boot_cpu_apicid);
+#ifdef CONFIG_NUMA_SCHED
+	pnode_to_lnode[SAPICID_TO_PNODE(boot_cpu_apicid)] = nr_lnodes++;
+	printk("boot_cpu_apicid = %d, nr_lnodes = %d, lnode = %d\n", boot_cpu_apicid, nr_lnodes, pnode_to_lnode[0]);
+#endif
 
 	current_thread_info()->cpu = 0;
 	smp_tune_scheduling();
@@ -1194,6 +1206,11 @@ int __devinit __cpu_up(unsigned int cpu)
 void __init smp_cpus_done(unsigned int max_cpus)
 {
 	zap_low_mappings();
+#ifdef CONFIG_NUMA_SCHED
+	pooldata_lock();
+	bld_pools();
+	pooldata_unlock();
+#endif
 }
 
 void __init smp_intr_init()
diff -urNp a/arch/ia64/config.in b/arch/ia64/config.in
--- a/arch/ia64/config.in	Fri Sep 20 17:20:37 2002
+++ b/arch/ia64/config.in	Sat Sep 21 11:44:48 2002
@@ -67,11 +67,13 @@ fi
 if [ "$CONFIG_IA64_GENERIC" = "y" -o "$CONFIG_IA64_DIG" = "y" -o "$CONFIG_IA64_HP_ZX1" = "y" ];
 then
 	bool '  Enable IA-64 Machine Check Abort' CONFIG_IA64_MCA
+   	bool '  Enable NUMA scheduler' CONFIG_NUMA_SCHED
 	define_bool CONFIG_PM y
 fi
 
 if [ "$CONFIG_IA64_SGI_SN1" = "y" -o "$CONFIG_IA64_SGI_SN2" = "y" ]; then
 	define_bool CONFIG_IA64_SGI_SN y
+   	bool '  Enable NUMA scheduler' CONFIG_NUMA_SCHED
 	bool '  Enable extra debugging code' CONFIG_IA64_SGI_SN_DEBUG
 	bool '  Enable SGI Medusa Simulator Support' CONFIG_IA64_SGI_SN_SIM
 	bool '  Enable autotest (llsc). Option to run cache test instead of booting' \
diff -urNp a/arch/ia64/kernel/smpboot.c b/arch/ia64/kernel/smpboot.c
--- a/arch/ia64/kernel/smpboot.c	Fri Sep 20 17:20:20 2002
+++ b/arch/ia64/kernel/smpboot.c	Sat Sep 21 11:55:03 2002
@@ -16,6 +16,7 @@
 
 #include <linux/config.h>
 
+#include <linux/acpi.h>
 #include <linux/bootmem.h>
 #include <linux/delay.h>
 #include <linux/init.h>
@@ -364,11 +365,22 @@ fork_by_hand (void)
 	return do_fork(CLONE_VM|CLONE_IDLETASK, 0, 0, 0);
 }
 
+#ifdef CONFIG_NUMA_SCHED
+static int __initdata nr_lnodes=0;
+#endif
+
 static int __init
 do_boot_cpu (int sapicid, int cpu)
 {
 	struct task_struct *idle;
-	int timeout;
+	int timeout, cell;
+
+#ifdef CONFIG_NUMA_SCHED
+	cell = SAPICID_TO_PNODE(sapicid);
+	if (pnode_to_lnode[cell] < 0) {
+		pnode_to_lnode[cell] = nr_lnodes++;
+	}
+#endif
 
 	/*
 	 * We can't use kernel_thread since we must avoid to reschedule the child.
@@ -421,7 +433,7 @@ unsigned long cache_decay_ticks;	/* # of
 static void
 smp_tune_scheduling (void)
 {
-	cache_decay_ticks = 10;	/* XXX base this on PAL info and cache-bandwidth estimate */
+	cache_decay_ticks = 8;	/* XXX base this on PAL info and cache-bandwidth estimate */
 
 	printk("task migration cache decay timeout: %ld msecs.\n",
 	       (cache_decay_ticks + 1) * 1000 / HZ);
@@ -474,6 +486,9 @@ smp_prepare_cpus (unsigned int max_cpus)
 
 	local_cpu_data->loops_per_jiffy = loops_per_jiffy;
 	ia64_cpu_to_sapicid[0] = boot_cpu_id;
+#ifdef CONFIG_NUMA_SCHED
+	pnode_to_lnode[SAPICID_TO_PNODE(boot_cpu_id)] = nr_lnodes++;
+#endif
 
 	printk("Boot processor id 0x%x/0x%x\n", 0, boot_cpu_id);
 
@@ -506,6 +521,11 @@ smp_cpus_done (unsigned int dummy)
 
 	printk(KERN_INFO"Total of %d processors activated (%lu.%02lu BogoMIPS).\n",
 	       num_online_cpus(), bogosum/(500000/HZ), (bogosum/(5000/HZ))%100);
+#ifdef CONFIG_NUMA_SCHED
+	pooldata_lock();
+	bld_pools();
+	pooldata_unlock();
+#endif
 }
 
 int __devinit
diff -urNp a/include/asm-i386/atomic.h b/include/asm-i386/atomic.h
--- a/include/asm-i386/atomic.h	Fri Sep 20 17:20:21 2002
+++ b/include/asm-i386/atomic.h	Sat Sep 21 11:44:48 2002
@@ -111,6 +111,18 @@ static __inline__ void atomic_inc(atomic
 }
 
 /**
+ * atomic_inc_return - increment atomic variable and return new value
+ * @v: pointer of type atomic_t
+ *
+ * Atomically increments @v by 1 and return it's new value.  Note that
+ * the guaranteed useful range of an atomic_t is only 24 bits.
+ */
+static inline int atomic_inc_return(atomic_t *v){
+	atomic_inc(v);
+	return v->counter;
+}
+
+/**
  * atomic_dec - decrement atomic variable
  * @v: pointer of type atomic_t
  * 
diff -urNp a/include/asm-i386/smp.h b/include/asm-i386/smp.h
--- a/include/asm-i386/smp.h	Fri Sep 20 17:20:15 2002
+++ b/include/asm-i386/smp.h	Sat Sep 21 11:44:48 2002
@@ -124,5 +124,11 @@ static inline int num_booting_cpus(void)
 
 #define NO_PROC_ID		0xFF		/* No processor magic marker */
 
+#ifdef CONFIG_NUMA_SCHED
+#define NR_NODES               8
+#define cpu_physical_id(cpuid) (cpu_to_physical_apicid(cpuid))
+#define SAPICID_TO_PNODE(hwid)  (hwid >> 4)
+#endif
+
 #endif
 #endif
diff -urNp a/include/asm-ia64/smp.h b/include/asm-ia64/smp.h
--- a/include/asm-ia64/smp.h	Fri Sep 20 17:20:26 2002
+++ b/include/asm-ia64/smp.h	Sat Sep 21 11:44:48 2002
@@ -13,6 +13,7 @@
 
 #ifdef CONFIG_SMP
 
+#include <linux/cache.h>
 #include <linux/init.h>
 #include <linux/threads.h>
 #include <linux/kernel.h>
@@ -130,6 +131,31 @@ extern void __cpu_die (unsigned int cpu)
 extern int __cpu_up (unsigned int cpu);
 extern void __init smp_build_cpu_map(void);
 
+#ifdef CONFIG_NUMA_SCHED
+#ifdef CONFIG_IA64_DIG
+/* sooner or later this should be a configurable parameter [EF] */
+#define NR_NODES 8
+/* 
+ * This is the node ID on the NEC AzusA, 
+ * on LION and BigSur it correctly initializes to node 0
+ */
+#define SAPICID_TO_PNODE(hwid) ((hwid >> 12) & 0xff)
+
+#elif defined(CONFIG_IA64_SGI_SN)
+
+/*
+ * SGI SN1 & SN2 specific macros
+ */
+#define NR_NODES 32
+#define SAPICID_TO_PNODE(hwid) cpuid_to_cnodeid(hwid)
+
+#endif
+
+#else   /* CONFIG_NUMA_SCHED */
+#define NR_NODES               1
+#define SAPICID_TO_PNODE(hwid)  0
+#endif  /* CONFIG_NUMA_SCHED */
+
 extern void __init init_smp_config (void);
 extern void smp_do_timer (struct pt_regs *regs);
 
diff -urNp a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h	Fri Sep 20 17:20:16 2002
+++ b/include/linux/sched.h	Sat Sep 21 11:44:48 2002
@@ -159,7 +159,7 @@ extern void update_one_process(struct ta
 			       unsigned long system, int cpu);
 extern void scheduler_tick(int user_tick, int system);
 extern unsigned long cache_decay_ticks;
-
+extern void sched_migrate_task(task_t *p, int cpu);
 
 #define	MAX_SCHEDULE_TIMEOUT	LONG_MAX
 extern signed long FASTCALL(schedule_timeout(signed long timeout));
@@ -449,6 +449,46 @@ extern void set_cpus_allowed(task_t *p, 
 # define set_cpus_allowed(p, new_mask) do { } while (0)
 #endif
 
+/* Avoid zeroes in integer divides for load calculations */
+#define BALANCE_FACTOR 100
+/*
+ * If the current node has average load it waits 100ms before trying to
+ * steal a task from a remote node.
+ */
+
+#ifdef CONFIG_NUMA_SCHED
+
+#define POOL_DELAY(this_node,node)      \
+                (_pool_delay[this_node * numpools + node])
+#define POOL_WEIGHT(this_node,node)     \
+                (_pool_weight[this_node * numpools + node])
+
+#define NODPOL_EXEC         0   /* choose node & cpu in do_exec */
+#define NODPOL_FORK         1   /* choose node & cpu in do_fork if !CLONE_VM */
+#define NODPOL_FORK_ALL     2   /* choose node & cpu in do_fork */
+
+extern int node_levels[NR_NODES];
+extern int nr_node_levels;
+/* extern void find_node_levels(int numpools); */
+
+extern int numpools;
+extern int pool_ptr[NR_NODES+1];
+extern int pool_cpus[NR_CPUS];
+extern int pool_nr_cpus[NR_NODES];
+extern unsigned long pool_mask[NR_NODES];
+extern int pnode_to_lnode[NR_NODES];
+extern atomic_t pool_lock;
+extern void *runqueues_address;
+extern char lnode_number[NR_CPUS] __cacheline_aligned;
+#define CPU_TO_NODE(cpu) lnode_number[cpu]
+
+extern void pooldata_lock(void);
+extern void pooldata_unlock(void);
+#else
+# define POOL_DELAY(x,y)  (0)
+# define CPU_TO_NODE(cpu) (0)
+#endif
+
 extern void set_user_nice(task_t *p, long nice);
 extern int task_prio(task_t *p);
 extern int task_nice(task_t *p);
diff -urNp a/kernel/ksyms.c b/kernel/ksyms.c
--- a/kernel/ksyms.c	Fri Sep 20 17:20:14 2002
+++ b/kernel/ksyms.c	Sat Sep 21 11:44:48 2002
@@ -606,6 +606,18 @@ EXPORT_SYMBOL(init_task);
 EXPORT_SYMBOL(init_thread_union);
 
 EXPORT_SYMBOL(tasklist_lock);
+
+#ifdef CONFIG_NUMA_SCHED
+#include <linux/sched.h>
+EXPORT_SYMBOL(runqueues_address);
+EXPORT_SYMBOL(numpools);
+EXPORT_SYMBOL(pool_ptr);
+EXPORT_SYMBOL(pool_cpus);
+EXPORT_SYMBOL(pool_nr_cpus);
+EXPORT_SYMBOL(pool_mask);
+EXPORT_SYMBOL(sched_migrate_task);
+#endif
+
 #if defined(CONFIG_SMP) && defined(__GENERIC_PER_CPU)
 EXPORT_SYMBOL(__per_cpu_offset);
 #endif
diff -urNp a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	Fri Sep 20 17:20:32 2002
+++ b/kernel/sched.c	Sat Sep 21 11:44:48 2002
@@ -154,6 +154,10 @@ struct runqueue {
 	task_t *migration_thread;
 	struct list_head migration_queue;
 
+	unsigned long wait_time;
+	int wait_node;
+	int load[2][NR_CPUS];
+
 } ____cacheline_aligned;
 
 static struct runqueue runqueues[NR_CPUS] __cacheline_aligned;
@@ -174,6 +178,39 @@ static struct runqueue runqueues[NR_CPUS
 #endif
 
 /*
+ * Variables for describing and accessing processor pools. Using a
+ * compressed row format like notation. Processor pools are treated
+ * like logical node numbers.
+ *
+ * numpools: number of CPU pools (nodes),
+ * pool_cpus[]: CPUs in pools sorted by their pool ID,
+ * pool_ptr[pool]: index of first element in pool_cpus[] belonging to pool.
+ * pnode_to_lnode[pnode]: pool number corresponding to a physical node ID.
+ * pool_mask[]: cpu mask of a pool.
+ * _pool_delay[]: delay when stealing a task from remote nodes for multilevel
+ *               topology. Needed by the macro POOL_DELAY().
+ *
+ * Example: loop over all CPUs in a pool p:
+ * for (i = pool_ptr[p]; i < pool_ptr[p+1]; i++) {
+ *      cpu = pool_cpus[i];
+ *      ...
+ * }
+ *                                                      <efocht@ess.nec.de>
+ */
+int numpools = 1;
+int pool_ptr[NR_NODES+1] = { 0, NR_CPUS, };
+int pool_cpus[NR_CPUS];
+int pool_nr_cpus[NR_NODES] = { NR_CPUS, };
+unsigned long pool_mask[NR_NODES] = { -1L, };
+int pnode_to_lnode[NR_NODES] = { [0 ... NR_NODES-1] = -1 };
+void *runqueues_address = (void *)runqueues; /* export this symbol to modules */
+char lnode_number[NR_CPUS] __cacheline_aligned;
+static int _pool_delay[NR_NODES*NR_NODES] __cacheline_aligned;
+static int _pool_weight[NR_NODES*NR_NODES] __cacheline_aligned;
+static atomic_t pool_lock = ATOMIC_INIT(0); /* set to 1 while modifying pool data */
+#define MAX_CACHE_WEIGHT 100
+
+/*
  * task_rq_lock - lock the runqueue a given task resides on and disable
  * interrupts.  Note the ordering: we can safely lookup the task_rq without
  * explicitly disabling preemption.
@@ -447,8 +484,10 @@ int wake_up_process(task_t * p)
  */
 void wake_up_forked_process(task_t * p)
 {
-	runqueue_t *rq = this_rq_lock();
+	runqueue_t *rq;
+	unsigned long flags;
 
+	rq = task_rq_lock(p, &flags);
 	p->state = TASK_RUNNING;
 	if (!rt_task(p)) {
 		/*
@@ -462,8 +501,9 @@ void wake_up_forked_process(task_t * p)
 	}
 	set_task_cpu(p, smp_processor_id());
 	activate_task(p, rq);
-
-	rq_unlock(rq);
+	if (p->prio < rq->curr->prio)
+		resched_task(rq->curr);
+	task_rq_unlock(rq, &flags);
 }
 
 /*
@@ -548,6 +588,11 @@ unsigned long nr_running(void)
 	return sum;
 }
 
+unsigned long qnr_running(int cpu)
+{
+	return cpu_rq(cpu)->nr_running;
+}
+
 unsigned long nr_uninterruptible(void)
 {
 	unsigned long i, sum = 0;
@@ -630,46 +675,21 @@ static inline unsigned int double_lock_b
 }
 
 /*
- * find_busiest_queue - find the busiest runqueue.
+ * Calculate load of a CPU pool, store results in data[][NR_CPUS].
+ * Return the index of the most loaded runqueue.
+ *
  */
-static inline runqueue_t *find_busiest_queue(runqueue_t *this_rq, int this_cpu, int idle, int *imbalance)
+static int calc_pool_load(int data[][NR_CPUS], int this_cpu, int pool, int idle)
 {
-	int nr_running, load, max_load, i;
-	runqueue_t *busiest, *rq_src;
-
-	/*
-	 * We search all runqueues to find the most busy one.
-	 * We do this lockless to reduce cache-bouncing overhead,
-	 * we re-check the 'best' source CPU later on again, with
-	 * the lock held.
-	 *
-	 * We fend off statistical fluctuations in runqueue lengths by
-	 * saving the runqueue length during the previous load-balancing
-	 * operation and using the smaller one the current and saved lengths.
-	 * If a runqueue is long enough for a longer amount of time then
-	 * we recognize it and pull tasks from it.
-	 *
-	 * The 'current runqueue length' is a statistical maximum variable,
-	 * for that one we take the longer one - to avoid fluctuations in
-	 * the other direction. So for a load-balance to happen it needs
-	 * stable long runqueue on the target CPU and stable short runqueue
-	 * on the local runqueue.
-	 *
-	 * We make an exception if this CPU is about to become idle - in
-	 * that case we are less picky about moving a task across CPUs and
-	 * take what can be taken.
-	 */
-	if (idle || (this_rq->nr_running > this_rq->prev_nr_running[this_cpu]))
-		nr_running = this_rq->nr_running;
-	else
-		nr_running = this_rq->prev_nr_running[this_cpu];
+	runqueue_t *rq_src, *this_rq = cpu_rq(this_cpu);
+	int this_pool = CPU_TO_NODE(this_cpu);
+	int i, ii, idx=-1, refload, load;
 
-	busiest = NULL;
-	max_load = 1;
-	for (i = 0; i < NR_CPUS; i++) {
-		if (!cpu_online(i))
-			continue;
+	data[1][pool] = 0;
+	refload = -1;
 
+	for (ii = pool_ptr[pool]; ii < pool_ptr[pool+1]; ii++) {
+		i = pool_cpus[ii];
 		rq_src = cpu_rq(i);
 		if (idle || (rq_src->nr_running < this_rq->prev_nr_running[i]))
 			load = rq_src->nr_running;
@@ -677,74 +697,125 @@ static inline runqueue_t *find_busiest_q
 			load = this_rq->prev_nr_running[i];
 		this_rq->prev_nr_running[i] = rq_src->nr_running;
 
-		if ((load > max_load) && (rq_src != this_rq)) {
-			busiest = rq_src;
-			max_load = load;
+		data[0][i] = load;
+		data[1][pool] += load;
+
+		if (load > refload) {
+			idx = i;
+			refload = load;
 		}
 	}
+	data[1][pool] = data[1][pool] * BALANCE_FACTOR / pool_nr_cpus[pool];
+	return idx;
+}
 
-	if (likely(!busiest))
-		goto out;
+/*
+ * Find a runqueue from which to steal a task. We try to do this as locally as
+ * possible because we don't want to let tasks get far from their home node.
+ * This is done in two steps:
+ * 1. First try to find a runqueue within the own CPU pool (AKA node) with
+ * imbalance larger than 25% (relative to the current runqueue).
+ * 2. If the local node is well balanced, locate the most loaded node and its
+ * most loaded CPU. Remote runqueues running tasks having their homenode on the
+ * current node are preferred (those tasks count twice in the load calculation).
+ * If the current load is far below the average try to steal a task from the
+ * most loaded node/cpu. Otherwise wait 100ms and give less loaded nodes the
+ * chance to approach the average load.
+ *
+ * This concept can be extended easilly to more than two levels (multi-level
+ * scheduler?), e.g.: CPU -> multi-core package -> node -> supernode...
+ *                                                         <efocht@ess.nec.de>
+ */
+static inline runqueue_t *find_busiest_queue(runqueue_t *this_rq, int this_cpu,
+					     int idle, int *nr_running)
+{
+	runqueue_t *busiest = NULL;
+	int imax, best_cpu, pool, max_pool_load, max_pool_idx;
+	int i, del_shift;
+	int avg_load=-1, this_pool = CPU_TO_NODE(this_cpu);
 
-	*imbalance = (max_load - nr_running) / 2;
+	/* Need at least ~25% imbalance to trigger balancing. */
+#define BALANCED(m,t) (((m) <= 1) || (((m) - (t))/2 < (((m) + (t))/2 + 3)/4))
+
+	if (idle || (this_rq->nr_running > this_rq->prev_nr_running[this_cpu]))
+		*nr_running = this_rq->nr_running;
+	else
+		*nr_running = this_rq->prev_nr_running[this_cpu];
 
-	/* It needs an at least ~25% imbalance to trigger balancing. */
-	if (!idle && (*imbalance < (max_load + 3)/4)) {
-		busiest = NULL;
+	best_cpu = calc_pool_load(this_rq->load, this_cpu, this_pool, idle);
+	if (best_cpu != this_cpu)
+		goto check_out;
+
+ scan_all:
+	best_cpu = -1;
+	max_pool_load = this_rq->load[1][this_pool];
+	max_pool_idx = this_pool;
+	avg_load = max_pool_load * pool_nr_cpus[this_pool];
+	for (i = 1; i < numpools; i++) {
+		pool = (i + this_pool) % numpools;
+		imax = calc_pool_load(this_rq->load, this_cpu, pool, idle);
+		avg_load += this_rq->load[1][pool]*pool_nr_cpus[pool];
+		if (this_rq->load[1][pool] > max_pool_load) {
+			max_pool_load = this_rq->load[1][pool];
+			max_pool_idx = pool;
+			best_cpu = imax;
+		}
+	}
+	/* Exit if not enough imbalance on any remote node. */
+	if ((best_cpu < 0) ||
+	    BALANCED(max_pool_load,this_rq->load[1][this_pool])) {
+		this_rq->wait_node = -1;
 		goto out;
 	}
+	avg_load /= num_online_cpus();
+	/* Wait longer before stealing if load is average. */
+	if (BALANCED(avg_load,this_rq->load[1][this_pool]))
+		del_shift = 0;
+	else
+		del_shift = 6;
 
-	nr_running = double_lock_balance(this_rq, busiest, this_cpu, idle, nr_running);
-	/*
-	 * Make sure nothing changed since we checked the
-	 * runqueue length.
-	 */
-	if (busiest->nr_running <= nr_running + 1) {
-		spin_unlock(&busiest->lock);
-		busiest = NULL;
-	}
-out:
+	if (this_rq->wait_node != max_pool_idx) {
+		this_rq->wait_node = max_pool_idx;
+		this_rq->wait_time = jiffies;
+		goto out;
+	} else
+		if (jiffies - this_rq->wait_time <
+		    (POOL_DELAY(this_pool,this_rq->wait_node) >> del_shift))
+			goto out;
+ check_out:
+	/* Enough imbalance in the remote cpu loads? */
+	if (!BALANCED(this_rq->load[0][best_cpu],*nr_running)) {
+		busiest = cpu_rq(best_cpu);
+		this_rq->wait_node = -1;
+	} else if (avg_load == -1)
+		/* only scanned local pool, so let's look at all of them */
+		goto scan_all;
+ out:
 	return busiest;
 }
 
 /*
- * pull_task - move a task from a remote runqueue to the local runqueue.
- * Both runqueues must be locked.
- */
-static inline void pull_task(runqueue_t *src_rq, prio_array_t *src_array, task_t *p, runqueue_t *this_rq, int this_cpu)
-{
-	dequeue_task(p, src_array);
-	src_rq->nr_running--;
-	set_task_cpu(p, this_cpu);
-	this_rq->nr_running++;
-	enqueue_task(p, this_rq->active);
-	/*
-	 * Note that idle threads have a prio of MAX_PRIO, for this test
-	 * to be always true for them.
-	 */
-	if (p->prio < this_rq->curr->prio)
-		set_need_resched();
-}
-
-/*
- * Current runqueue is empty, or rebalance tick: if there is an
- * inbalance (current runqueue is too short) then pull from
- * busiest runqueue(s).
- *
- * We call this with the current runqueue locked,
- * irqs disabled.
+ * Find a task to steal from the busiest RQ. The busiest->lock must be held
+ * while calling this routine. 
  */
-static void load_balance(runqueue_t *this_rq, int idle)
+static inline task_t *task_to_steal(runqueue_t *busiest, int this_cpu)
 {
-	int imbalance, idx, this_cpu = smp_processor_id();
-	runqueue_t *busiest;
+	int idx;
+	task_t *next = NULL, *tmp;
 	prio_array_t *array;
 	struct list_head *head, *curr;
-	task_t *tmp;
+	int this_pool=CPU_TO_NODE(this_cpu), weight, maxweight=0;
 
-	busiest = find_busiest_queue(this_rq, this_cpu, idle, &imbalance);
-	if (!busiest)
-		goto out;
+	/*
+	 * We do not migrate tasks that are:
+	 * 1) running (obviously), or
+	 * 2) cannot be migrated to this CPU due to cpus_allowed.
+	 */
+
+#define CAN_MIGRATE_TASK(p,rq,this_cpu)	\
+		((jiffies - (p)->sleep_timestamp > cache_decay_ticks) && \
+		p != rq->curr && \
+		 ((p)->cpus_allowed & (1UL<<(this_cpu))))
 
 	/*
 	 * We first consider expired tasks. Those will likely not be
@@ -770,7 +841,7 @@ skip_bitmap:
 			array = busiest->active;
 			goto new_array;
 		}
-		goto out_unlock;
+		goto out;
 	}
 
 	head = array->queue + idx;
@@ -778,33 +849,72 @@ skip_bitmap:
 skip_queue:
 	tmp = list_entry(curr, task_t, run_list);
 
+	if (CAN_MIGRATE_TASK(tmp, busiest, this_cpu)) {
+		weight = (jiffies - tmp->sleep_timestamp)/cache_decay_ticks;
+		if (weight > maxweight) {
+			maxweight = weight;
+			next = tmp;
+		}
+	}
+	curr = curr->next;
+	if (curr != head)
+		goto skip_queue;
+	idx++;
+	goto skip_bitmap;
+
+ out:
+	return next;
+}
+
+/*
+ * pull_task - move a task from a remote runqueue to the local runqueue.
+ * Both runqueues must be locked.
+ */
+static inline void pull_task(runqueue_t *src_rq, prio_array_t *src_array, task_t *p, runqueue_t *this_rq, int this_cpu)
+{
+	dequeue_task(p, src_array);
+	src_rq->nr_running--;
+	set_task_cpu(p, this_cpu);
+	this_rq->nr_running++;
+	enqueue_task(p, this_rq->active);
 	/*
-	 * We do not migrate tasks that are:
-	 * 1) running (obviously), or
-	 * 2) cannot be migrated to this CPU due to cpus_allowed, or
-	 * 3) are cache-hot on their current CPU.
+	 * Note that idle threads have a prio of MAX_PRIO, for this test
+	 * to be always true for them.
 	 */
+	if (p->prio < this_rq->curr->prio)
+		set_need_resched();
+}
 
-#define CAN_MIGRATE_TASK(p,rq,this_cpu)					\
-	((jiffies - (p)->sleep_timestamp > cache_decay_ticks) &&	\
-		!task_running(rq, p) &&					\
-			((p)->cpus_allowed & (1UL << (this_cpu))))
-
-	curr = curr->prev;
-
-	if (!CAN_MIGRATE_TASK(tmp, busiest, this_cpu)) {
-		if (curr != head)
-			goto skip_queue;
-		idx++;
-		goto skip_bitmap;
-	}
-	pull_task(busiest, array, tmp, this_rq, this_cpu);
-	if (!idle && --imbalance) {
-		if (curr != head)
-			goto skip_queue;
-		idx++;
-		goto skip_bitmap;
-	}
+/*
+ * Current runqueue is empty, or rebalance tick: if there is an
+ * inbalance (current runqueue is too short) then pull from
+ * busiest runqueue(s).
+ *
+ * We call this with the current runqueue locked,
+ * irqs disabled.
+ */
+static void load_balance(runqueue_t *this_rq, int idle)
+{
+	int nr_running, this_cpu = task_cpu(this_rq->curr);
+	task_t *tmp;
+	runqueue_t *busiest;
+
+	/* avoid deadlock by timer interrupt on own cpu */
+	if (atomic_read(&pool_lock)) return;
+	busiest = find_busiest_queue(this_rq, this_cpu, idle, &nr_running);
+
+	nr_running = double_lock_balance(this_rq, busiest, this_cpu, idle, nr_running);
+	/*
+	 * Make sure nothing changed since we checked the
+	 * runqueue length.
+	 */
+	if (busiest->nr_running <= nr_running + 1)
+		goto out_unlock;
+
+	tmp = task_to_steal(busiest, this_cpu);
+	if (!tmp)
+		goto out_unlock;
+	pull_task(busiest, tmp->array, tmp, this_rq, this_cpu);
 out_unlock:
 	spin_unlock(&busiest->lock);
 out:
@@ -817,10 +927,10 @@ out:
  * frequency and balancing agressivity depends on whether the CPU is
  * idle or not.
  *
- * busy-rebalance every 250 msecs. idle-rebalance every 1 msec. (or on
+ * busy-rebalance every 200 msecs. idle-rebalance every 1 msec. (or on
  * systems with HZ=100, every 10 msecs.)
  */
-#define BUSY_REBALANCE_TICK (HZ/4 ?: 1)
+#define BUSY_REBALANCE_TICK (HZ/5 ?: 1)
 #define IDLE_REBALANCE_TICK (HZ/1000 ?: 1)
 
 static inline void idle_tick(runqueue_t *rq)
@@ -1862,6 +1972,176 @@ void show_state(void)
 	read_unlock(&tasklist_lock);
 }
 
+#ifdef CONFIG_NUMA_SCHED
+void pools_info(void)
+{
+	int i, j;
+
+	printk("CPU pools : %d\n",numpools);
+	for (i=0;i<numpools;i++) {
+		printk("pool %d :",i);
+		for (j=pool_ptr[i];j<pool_ptr[i+1];j++)
+			printk("%d ",pool_cpus[j]);
+		printk("\n");
+	}
+}
+
+void pooldata_lock(void)
+{
+	int i;
+ retry:
+	while (atomic_read(&pool_lock));
+	if (atomic_inc_return(&pool_lock) > 1) {
+		atomic_dec(&pool_lock);
+		goto retry;
+	}
+	/* 
+	 * Wait a while, any loops using pool data should finish
+	 * in between. This is VERY ugly and should be replaced
+	 * by some real RCU stuff. [EF]
+	 */
+	for (i=0; i<100; i++)
+		udelay(1000);
+}
+
+void pooldata_unlock(void)
+{
+	atomic_dec(&pool_lock);
+}
+
+int node_levels[NR_NODES];
+int nr_node_levels;
+
+/*
+ * Default setting of node_distance() for up to 8 nodes.
+ * Each platform should initialize this to more appropriate values
+ * in the arch dependent part.
+ */
+#ifndef node_distance
+int __node_distance[ 8 * 8]    = { 10, 15, 15, 15, 20, 20, 20, 20,
+				   15, 10, 15, 15, 20, 20, 20, 20,
+				   15, 15, 10, 15, 20, 20, 20, 20,
+				   15, 15, 15, 10, 20, 20, 20, 20,
+				   20, 20, 20, 20, 10, 15, 15, 15,
+				   20, 20, 20, 20, 15, 10, 15, 15,
+				   20, 20, 20, 20, 15, 15, 10, 15,
+				   20, 20, 20, 20, 15, 15, 15, 10 };
+#define node_distance(i,j)  __node_distance[i*8+j]
+#endif
+
+/*
+ * Find all values of node distances in the SLIT table and sort them
+ * into the array node_levels[].
+ */
+static void find_node_levels(int numpools)
+{
+	int lev, tgtlev, nlarger, i;
+
+	nr_node_levels = 1;
+	node_levels[0] = node_distance(0, 0);
+	do {
+		nlarger = 0;
+		tgtlev = 100000;
+		for (i=1; i<numpools; i++) {
+			lev = node_distance(0, i);
+			if (lev > node_levels[nr_node_levels-1] &&
+			    lev < tgtlev) {
+				if (tgtlev < 100000) nlarger++;
+				tgtlev = lev;
+			}
+			if (lev > tgtlev) nlarger++;
+		}
+		if (tgtlev != 100000)
+			node_levels[nr_node_levels++] = tgtlev;
+	} while (nlarger);
+
+	for (i=0; i<nr_node_levels; i++)
+		printk("node level %d : %d\n",i,node_levels[i]);
+}
+
+/*
+ * Initialize the pool_weight[] matrix.
+ */
+static void
+init_pool_weight(void)
+{
+	int i, j, lev;
+
+	for (i=0; i<numpools; i++)
+		for (j=0; j<numpools; j++)
+			for (lev=0; lev<nr_node_levels; lev++)
+				if (node_distance(i,j) == node_levels[lev]) {
+					_pool_weight[i*numpools+j] =
+						(2*(nr_node_levels-lev)-1)
+						*MAX_CACHE_WEIGHT;
+					break;
+				}
+}
+
+/*
+ * Initialize delay for stealing tasks from remote nodes
+ */
+static void
+init_pool_delay(void)
+{
+	int i, j;
+
+	for(i=0; i<numpools; i++)
+		for(j=0; j<numpools; j++)
+			_pool_delay[i * numpools + j] = HZ * \
+				node_distance(i,j) / 77;
+
+	printk("pool_delay matrix:\n");
+	for(i=0; i<numpools; i++){
+		for(j=0; j<numpools; j++)
+			printk("%4d ",_pool_delay[i*numpools+j]);
+		printk("\n");
+	}
+}
+
+/*
+ * Call pooldata_lock() before calling this function and
+ * pooldata_unlock() after!
+ */
+void bld_pools(void)
+{
+	int i, j, ptr;
+	int flag[NR_CPUS] = { [ 0 ... NR_CPUS-1] = 0 };
+	unsigned long mask;
+
+	/* build translation table for CPU_TO_NODE macro */
+	for (i = 0; i < NR_CPUS; i++)
+		if (cpu_online(i))
+			lnode_number[i] = pnode_to_lnode[SAPICID_TO_PNODE(cpu_physical_id(i))];
+
+	numpools = 0;
+	ptr = 0;
+	for (i = 0; i < NR_CPUS; i++) {
+		if (!cpu_online(i)) continue;
+		if (!flag[i]) {
+			pool_ptr[numpools]=ptr;
+			mask = 0UL;
+			for (j = 0; j < NR_CPUS; j++) {
+				if (!cpu_online(j)) continue;
+				if (i == j || CPU_TO_NODE(i) == CPU_TO_NODE(j)) {
+					pool_cpus[ptr++]=j;
+					flag[j]=1;
+					mask |= (1UL<<j);
+				}
+			}
+			pool_nr_cpus[numpools] = ptr - pool_ptr[numpools];
+			pool_mask[numpools] = mask;
+			numpools++;
+		}
+	}
+	pool_ptr[numpools]=ptr;
+	pools_info();
+	find_node_levels(numpools);
+	init_pool_weight();
+	init_pool_delay();
+}
+
+#endif /* CONFIG_NUMA_SCHED */
 void __init init_idle(task_t *idle, int cpu)
 {
 	runqueue_t *idle_rq = cpu_rq(cpu), *rq = cpu_rq(task_cpu(idle));
@@ -1909,6 +2189,8 @@ typedef struct {
 	struct list_head list;
 	task_t *task;
 	struct completion done;
+	int cpu_dest;
+	int sync;
 } migration_req_t;
 
 /*
@@ -1954,6 +2236,7 @@ void set_cpus_allowed(task_t *p, unsigne
 	}
 	init_completion(&req.done);
 	req.task = p;
+	req.sync = 1;
 	list_add(&req.list, &rq->migration_queue);
 	task_rq_unlock(rq, &flags);
 	wake_up_process(rq->migration_thread);
@@ -1963,6 +2246,17 @@ out:
 	preempt_enable();
 }
 
+void sched_migrate_task(task_t *p, int dest_cpu)
+{
+	unsigned long old_mask;
+
+	old_mask = p->cpus_allowed;
+	if (!(old_mask & (1UL << dest_cpu)))
+		return;
+	set_cpus_allowed(p, 1UL << dest_cpu);
+	set_cpus_allowed(p, old_mask);
+}
+
 /*
  * migration_thread - this is a highprio system thread that performs
  * thread migration by 'pulling' threads into the target runqueue.
@@ -1998,7 +2292,7 @@ static int migration_thread(void * data)
 	for (;;) {
 		runqueue_t *rq_src, *rq_dest;
 		struct list_head *head;
-		int cpu_src, cpu_dest;
+		int cpu_src, cpu_dest, sync;
 		migration_req_t *req;
 		unsigned long flags;
 		task_t *p;
@@ -2013,10 +2307,17 @@ static int migration_thread(void * data)
 		}
 		req = list_entry(head->next, migration_req_t, list);
 		list_del_init(head->next);
-		spin_unlock_irqrestore(&rq->lock, flags);
 
 		p = req->task;
-		cpu_dest = __ffs(p->cpus_allowed);
+		sync = req->sync;
+		if (sync)
+			cpu_dest = __ffs(p->cpus_allowed & cpu_online_map);
+		else {
+			cpu_dest = req->cpu_dest;
+			req->task = NULL;
+		}
+		spin_unlock_irqrestore(&rq->lock, flags);
+
 		rq_dest = cpu_rq(cpu_dest);
 repeat:
 		cpu_src = task_cpu(p);
@@ -2039,7 +2340,8 @@ repeat:
 		double_rq_unlock(rq_src, rq_dest);
 		local_irq_restore(flags);
 
-		complete(&req->done);
+		if (sync)
+			complete(&req->done);
 	}
 }
 
@@ -2119,6 +2421,15 @@ void __init sched_init(void)
 			__set_bit(MAX_PRIO, array->bitmap);
 		}
 	}
+#ifdef CONFIG_NUMA_SCHED
+	pool_ptr[0] = 0;
+	pool_ptr[1] = NR_CPUS;
+
+	numpools = 1;
+	pool_mask[0] = -1L;
+	pool_nr_cpus[0] = NR_CPUS;
+#endif
+
 	/*
 	 * We have to do a little magic to get the first
 	 * thread right in SMP mode.

--------------Boundary-00=_H39SRHAKGPZ790RK7DOT--

