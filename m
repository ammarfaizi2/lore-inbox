Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318349AbSHUPPL>; Wed, 21 Aug 2002 11:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318355AbSHUPPK>; Wed, 21 Aug 2002 11:15:10 -0400
Received: from ophelia.ess.nec.de ([193.141.139.8]:13731 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S318349AbSHUPOd>; Wed, 21 Aug 2002 11:14:33 -0400
From: Erich Focht <efocht@ess.nec.de>
To: LSE <lse-tech@lists.sourceforge.net>
Subject: [PATCH] node affine NUMA scheduler Nod20
Date: Wed, 21 Aug 2002 17:17:59 +0200
User-Agent: KMail/1.4.1
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>,
       "linux-ia64" <linux-ia64@linuxia64.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_Z597HHSOK77EJPHDC1DA"
Message-Id: <200208211717.59353.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_Z597HHSOK77EJPHDC1DA
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

here is an update of the node affine NUMA scheduler built on top of
the O(1) scheduler. General information about it can be found at
http://home.arcor.de/efocht/sched

The main changes compared to the previous version are:
 - modified migration_thread to allow "asynchronous" pushing of a task
   to another CPU from within load_balance().
 - load_balance() checks for the case of a single task running on a
   remote node. As this task cannot be stolen by a CPU from its homenode
   (because a running task cannot be stolen within the O(1) scheduler
   framework), it will be pushed to its homenode if that one has <25%
   load.

These changes should solve the problem of long running tasks beeing
pushed away from their homenodes during short peaks of load on the
machine and not beeing able to return to their homenodes even if those
are idle.

The patch at
http://home.arcor.de/efocht/sched/Nod20_2.4.18-ia64-O1ef7.patch
is for 2.4.18-IA64 and requires the O(1) patch
http://home.arcor.de/efocht/sched/O1_ia64-ef7-2.4.18.patch.bz2
These patches are well tested on IA64 platforms (16xItanium NEC Azusa,
32xItanium NEC Asama, non-NUMA Itanium).

For monitoring the runqueue loads and load balancer decisions one can
apply additionally
http://home.arcor.de/efocht/sched/proc_sched_hist_2.4.18-ia64-O1ef7.patch
This creates per runqueue files in /proc/sched/load and
/proc/sched/history that which let one monitor the load, the initial
load balancing and the stealing decisions of the load balancer.

The attached patch is for the latest 2.5.31 bitkeeper tree. It is very
experimental and pretty untested. Thanks to Michael Hohnbaum who ported
the Nod18 version to 2.5.25 and helped a lot with the transition to 2.5.
This patch might work on NUMA-Q... I'll try to keep the BK tree
bk://numa-ef.bkbits.net/2.5-numa-sched up to date, so if someone has
fixes, improvements, ports to other platforms, please send patches
or changesets against that tree.

Thanks,
best regards,
Erich


--=20
Global warming and climate change is everyones business!
Links? http://unfccc.int/ http://www.climnet.org/
       http://www.fossil-of-the-day.org/

--------------Boundary-00=_Z597HHSOK77EJPHDC1DA
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="Nod20_numa_sched-2.5.31.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="Nod20_numa_sched-2.5.31.patch"

diff -Nru a/arch/i386/config.in b/arch/i386/config.in
--- a/arch/i386/config.in	Wed Aug 21 15:43:52 2002
+++ b/arch/i386/config.in	Wed Aug 21 15:43:52 2002
@@ -166,6 +166,10 @@
       define_bool CONFIG_X86_IO_APIC y
    fi
 else
+   bool '  Enable NUMA scheduler' CONFIG_NUMA_SCHED
+   if [ "$CONFIG_NUMA_SCHED" = "y" ]; then
+      bool '  Enable node affine scheduler' CONFIG_NODE_AFFINE_SCHED
+   fi
    bool 'Multiquad NUMA system' CONFIG_MULTIQUAD
 fi
 
diff -Nru a/arch/i386/kernel/smpboot.c b/arch/i386/kernel/smpboot.c
--- a/arch/i386/kernel/smpboot.c	Wed Aug 21 15:43:52 2002
+++ b/arch/i386/kernel/smpboot.c	Wed Aug 21 15:43:52 2002
@@ -764,6 +764,8 @@
 
 extern unsigned long cpu_initialized;
 
+static int __initdata nr_lnodes = 0;
+
 static void __init do_boot_cpu (int apicid) 
 /*
  * NOTE - on most systems this is a PHYSICAL apic ID, but on multiquad
@@ -772,11 +774,17 @@
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
@@ -995,6 +1003,10 @@
 	set_bit(0, &cpu_callout_map);
 	boot_cpu_logical_apicid = logical_smp_processor_id();
 	map_cpu_to_boot_apicid(0, boot_cpu_apicid);
+#ifdef CONFIG_NUMA_SCHED
+	pnode_to_lnode[SAPICID_TO_PNODE(boot_cpu_apicid)] = nr_lnodes++;
+	printk("boot_cpu_apicid = %d, nr_lnodes = %d, lnode = %d\n", boot_cpu_apicid, nr_lnodes, pnode_to_lnode[0]);
+#endif
 
 	current_thread_info()->cpu = 0;
 	smp_tune_scheduling();
@@ -1221,4 +1233,9 @@
 void __init smp_cpus_done(unsigned int max_cpus)
 {
 	zap_low_mappings();
+#ifdef CONFIG_NUMA_SCHED
+	pooldata_lock();
+	bld_pools();
+	pooldata_unlock();
+#endif
 }
diff -Nru a/arch/ia64/config.in b/arch/ia64/config.in
--- a/arch/ia64/config.in	Wed Aug 21 15:43:52 2002
+++ b/arch/ia64/config.in	Wed Aug 21 15:43:52 2002
@@ -67,11 +67,19 @@
 if [ "$CONFIG_IA64_GENERIC" = "y" -o "$CONFIG_IA64_DIG" = "y" -o "$CONFIG_IA64_HP_ZX1" = "y" ];
 then
 	bool '  Enable IA-64 Machine Check Abort' CONFIG_IA64_MCA
+   	bool '  Enable NUMA scheduler' CONFIG_NUMA_SCHED
+   	if [ "$CONFIG_NUMA_SCHED" = "y" ]; then
+      	   bool '  Enable node affine scheduler' CONFIG_NODE_AFFINE_SCHED
+   	fi
 	define_bool CONFIG_PM y
 fi
 
 if [ "$CONFIG_IA64_SGI_SN1" = "y" -o "$CONFIG_IA64_SGI_SN2" = "y" ]; then
 	define_bool CONFIG_IA64_SGI_SN y
+   	bool '  Enable NUMA scheduler' CONFIG_NUMA_SCHED
+   	if [ "$CONFIG_NUMA_SCHED" = "y" ]; then
+      	   bool '  Enable node affine scheduler' CONFIG_NODE_AFFINE_SCHED
+   	fi
 	bool '  Enable extra debugging code' CONFIG_IA64_SGI_SN_DEBUG
 	bool '  Enable SGI Medusa Simulator Support' CONFIG_IA64_SGI_SN_SIM
 	bool '  Enable autotest (llsc). Option to run cache test instead of booting' \
diff -Nru a/arch/ia64/kernel/smpboot.c b/arch/ia64/kernel/smpboot.c
--- a/arch/ia64/kernel/smpboot.c	Wed Aug 21 15:43:51 2002
+++ b/arch/ia64/kernel/smpboot.c	Wed Aug 21 15:43:51 2002
@@ -16,6 +16,7 @@
 
 #include <linux/config.h>
 
+#include <linux/acpi.h>
 #include <linux/bootmem.h>
 #include <linux/delay.h>
 #include <linux/init.h>
@@ -103,6 +104,22 @@
 
 __setup("nointroute", nointroute);
 
+void __init
+bub_sort(int n, int *a)
+{
+	int end, j, t;
+
+	for (end = n-1; end >= 0; end--) {
+		for (j = 0; j < end; j++) {
+			if (a[j] > a[j+1]) {
+				t = a[j+1];
+				a[j+1] = a[j];
+				a[j] = t;
+			}
+		}
+	}
+}
+
 void
 sync_master (void *arg)
 {
@@ -364,11 +381,22 @@
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
@@ -421,7 +449,7 @@
 static void
 smp_tune_scheduling (void)
 {
-	cache_decay_ticks = 10;	/* XXX base this on PAL info and cache-bandwidth estimate */
+	cache_decay_ticks = 8;	/* XXX base this on PAL info and cache-bandwidth estimate */
 
 	printk("task migration cache decay timeout: %ld msecs.\n",
 	       (cache_decay_ticks + 1) * 1000 / HZ);
@@ -474,6 +502,9 @@
 
 	local_cpu_data->loops_per_jiffy = loops_per_jiffy;
 	ia64_cpu_to_sapicid[0] = boot_cpu_id;
+#ifdef CONFIG_NUMA_SCHED
+	pnode_to_lnode[SAPICID_TO_PNODE(boot_cpu_id)] = nr_lnodes++;
+#endif
 
 	printk("Boot processor id 0x%x/0x%x\n", 0, boot_cpu_id);
 
@@ -488,6 +519,12 @@
 		cpu_online_map = phys_cpu_present_map = 1;
 		return;
 	}
+#ifdef CONFIG_IA64_DIG
+	/* 
+ 	 * To be on the safe side: sort SAPIC IDs of CPUs
+ 	 */
+	bub_sort(smp_boot_data.cpu_count, &smp_boot_data.cpu_phys_id[0]);
+#endif
 }
 
 void
diff -Nru a/fs/exec.c b/fs/exec.c
--- a/fs/exec.c	Wed Aug 21 15:43:52 2002
+++ b/fs/exec.c	Wed Aug 21 15:43:52 2002
@@ -865,6 +865,11 @@
 	int retval;
 	int i;
 
+#ifdef CONFIG_NODE_AFFINE_SCHED
+	if (current->node_policy == NODPOL_EXEC)
+		sched_balance_exec();
+#endif
+
 	file = open_exec(filename);
 
 	retval = PTR_ERR(file);
diff -Nru a/include/asm-i386/atomic.h b/include/asm-i386/atomic.h
--- a/include/asm-i386/atomic.h	Wed Aug 21 15:43:52 2002
+++ b/include/asm-i386/atomic.h	Wed Aug 21 15:43:52 2002
@@ -111,6 +111,18 @@
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
diff -Nru a/include/asm-i386/smp.h b/include/asm-i386/smp.h
--- a/include/asm-i386/smp.h	Wed Aug 21 15:43:51 2002
+++ b/include/asm-i386/smp.h	Wed Aug 21 15:43:51 2002
@@ -124,5 +124,11 @@
 
 #define NO_PROC_ID		0xFF		/* No processor magic marker */
 
+#ifdef CONFIG_NUMA_SCHED
+#define NR_NODES               8
+#define cpu_physical_id(cpuid) (cpu_to_physical_apicid(cpuid))
+#define SAPICID_TO_PNODE(hwid)  (hwid >> 4)
+#endif
+
 #endif
 #endif
diff -Nru a/include/asm-ia64/smp.h b/include/asm-ia64/smp.h
--- a/include/asm-ia64/smp.h	Wed Aug 21 15:43:52 2002
+++ b/include/asm-ia64/smp.h	Wed Aug 21 15:43:52 2002
@@ -13,6 +13,7 @@
 
 #ifdef CONFIG_SMP
 
+#include <linux/cache.h>
 #include <linux/init.h>
 #include <linux/threads.h>
 #include <linux/kernel.h>
@@ -129,6 +130,32 @@
 extern void __cpu_die (unsigned int cpu);
 extern int __cpu_up (unsigned int cpu);
 extern void __init smp_build_cpu_map(void);
+
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
+#else   /* CONFIG_NODE_AFFINE_SCHED */
+#define NR_NODES               1
+#define CPU_TO_NODE(cpu)       0
+#define SAPICID_TO_PNODE(hwid)  0
+#endif  /* CONFIG_NODE_AFFINE_SCHED */
 
 extern void __init init_smp_config (void);
 extern void smp_do_timer (struct pt_regs *regs);
diff -Nru a/include/linux/prctl.h b/include/linux/prctl.h
--- a/include/linux/prctl.h	Wed Aug 21 15:43:52 2002
+++ b/include/linux/prctl.h	Wed Aug 21 15:43:52 2002
@@ -34,4 +34,10 @@
 # define PR_FP_EXC_ASYNC	2	/* async recoverable exception mode */
 # define PR_FP_EXC_PRECISE	3	/* precise exception mode */
 
+/* Get/set node for node-affine scheduling */
+#define PR_GET_NODE       16
+#define PR_SET_NODE       17
+#define PR_GET_NODPOL     18
+#define PR_SET_NODPOL     19
+
 #endif /* _LINUX_PRCTL_H */
diff -Nru a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h	Wed Aug 21 15:43:51 2002
+++ b/include/linux/sched.h	Wed Aug 21 15:43:51 2002
@@ -155,7 +155,16 @@
 			       unsigned long system, int cpu);
 extern void scheduler_tick(int user_tick, int system);
 extern unsigned long cache_decay_ticks;
-
+#ifdef CONFIG_NUMA_SCHED
+extern void sched_balance_exec(void);
+extern void sched_balance_fork(task_t *p);
+extern void set_task_node(task_t *p, int node);
+#else
+#define sched_balance_exec() {}
+#define sched_balance_fork(p) {}
+#define set_task_node(p,n) {}
+#endif
+extern void sched_migrate_task(task_t *p, int cpu);
 
 #define	MAX_SCHEDULE_TIMEOUT	LONG_MAX
 extern signed long FASTCALL(schedule_timeout(signed long timeout));
@@ -268,7 +277,10 @@
 	unsigned long policy;
 	unsigned long cpus_allowed;
 	unsigned int time_slice, first_time_slice;
-
+#ifdef CONFIG_NUMA_SCHED
+	int node;
+	int node_policy;
+#endif
 	struct list_head tasks;
 	struct list_head ptrace_children;
 	struct list_head ptrace_list;
@@ -420,6 +432,48 @@
 extern void set_cpus_allowed(task_t *p, unsigned long new_mask);
 #else
 # define set_cpus_allowed(p, new_mask) do { } while (0)
+#endif
+
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
+# define HOMENODE_INC(rq,node) (rq)->nr_homenode[node]++
+# define HOMENODE_DEC(rq,node) (rq)->nr_homenode[node]--
+#else
+# define HOMENODE_INC(rq,node) {}
+# define HOMENODE_DEC(rq,node) {}
 #endif
 
 extern void set_user_nice(task_t *p, long nice);
diff -Nru a/kernel/fork.c b/kernel/fork.c
--- a/kernel/fork.c	Wed Aug 21 15:43:51 2002
+++ b/kernel/fork.c	Wed Aug 21 15:43:51 2002
@@ -727,6 +727,13 @@
 #ifdef CONFIG_SMP
 	{
 		int i;
+#ifdef CONFIG_NODE_AFFINE_SCHED
+		if (p->node_policy == NODPOL_FORK_ALL ||
+		    (p->node_policy == NODPOL_FORK && !(clone_flags & CLONE_VM)))
+			{
+			sched_balance_fork(p);
+			}
+#endif
 
 		/* ?? should we just memset this ?? */
 		for(i = 0; i < NR_CPUS; i++)
diff -Nru a/kernel/ksyms.c b/kernel/ksyms.c
--- a/kernel/ksyms.c	Wed Aug 21 15:43:51 2002
+++ b/kernel/ksyms.c	Wed Aug 21 15:43:51 2002
@@ -601,6 +601,18 @@
 
 EXPORT_SYMBOL(tasklist_lock);
 EXPORT_SYMBOL(pidhash);
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
diff -Nru a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	Wed Aug 21 15:43:52 2002
+++ b/kernel/sched.c	Wed Aug 21 15:43:52 2002
@@ -154,6 +154,11 @@
 	task_t *migration_thread;
 	list_t migration_queue;
 
+	unsigned long wait_time;
+	int wait_node;
+	short nr_homenode[NR_NODES];
+	int load[2][NR_CPUS];
+
 } ____cacheline_aligned;
 
 static struct runqueue runqueues[NR_CPUS] __cacheline_aligned;
@@ -174,6 +179,39 @@
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
@@ -291,6 +329,7 @@
 	}
 	enqueue_task(p, array);
 	rq->nr_running++;
+	HOMENODE_INC(rq,p->node);
 }
 
 /*
@@ -298,6 +337,7 @@
  */
 static inline void deactivate_task(struct task_struct *p, runqueue_t *rq)
 {
+	HOMENODE_DEC(rq,p->node);
 	rq->nr_running--;
 	if (p->state == TASK_UNINTERRUPTIBLE)
 		rq->nr_uninterruptible++;
@@ -447,8 +487,10 @@
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
@@ -462,8 +504,9 @@
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
@@ -548,6 +591,11 @@
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
@@ -630,121 +678,152 @@
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
+	runqueue_t *rq_src, *this_rq = cpu_rq(this_cpu);
+	int this_pool = CPU_TO_NODE(this_cpu);
+	int i, ii, idx=-1, refload, load;
 
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
-
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
 		else
 			load = this_rq->prev_nr_running[i];
 		this_rq->prev_nr_running[i] = rq_src->nr_running;
+#ifdef CONFIG_NODE_AFFINE_SCHED
+		/* prefer cpus running tasks from this node */
+		if (pool != this_pool)
+			load += rq_src->nr_homenode[this_pool];
+#endif
+
+		data[0][i] = load;
+		data[1][pool] += load;
 
-		if ((load > max_load) && (rq_src != this_rq)) {
-			busiest = rq_src;
-			max_load = load;
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
+
+	/* Need at least ~25% imbalance to trigger balancing. */
+#define BALANCED(m,t) (((m) <= 1) || (((m) - (t))/2 < (((m) + (t))/2 + 3)/4))
 
-	*imbalance = (max_load - nr_running) / 2;
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
 	list_t *head, *curr;
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
@@ -770,7 +849,7 @@
 			array = busiest->active;
 			goto new_array;
 		}
-		goto out_unlock;
+		goto out;
 	}
 
 	head = array->queue + idx;
@@ -778,33 +857,118 @@
 skip_queue:
 	tmp = list_entry(curr, task_t, run_list);
 
+	if (CAN_MIGRATE_TASK(tmp, busiest, this_cpu)) {
+		weight = (jiffies - tmp->sleep_timestamp)/cache_decay_ticks;
+#ifdef CONFIG_NODE_AFFINE_SCHED
+		/* limit weight influence of sleep_time and cache coolness */
+		if (weight >= MAX_CACHE_WEIGHT) weight=MAX_CACHE_WEIGHT-1;
+		/* weight depending on homenode of task */
+		weight += POOL_WEIGHT(this_pool,tmp->node);
+		/* task gets bonus if running on its homenode */
+		if (tmp->node == CPU_TO_NODE(task_cpu(busiest->curr)))
+			weight -= MAX_CACHE_WEIGHT;
+#endif
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
+
+static inline void
+try_push_home(runqueue_t *this_rq, int this_cpu, int nr_running)
+{
+#ifdef CONFIG_NODE_AFFINE_SCHED
+	task_t *p;
+	int tgt_pool, tgt_cpu, i, ii;
+	runqueue_t *rq;
+	static int sched_push_task(task_t *p, int cpu_dest);
 
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
+	if (nr_running != 1)
+		return;
+	p = this_rq->curr;
+	tgt_pool = p->node;
+	if (tgt_pool != CPU_TO_NODE(this_cpu)) {
+		/* compute how many own tasks run on the tgt node */
+		int load = 0;
+		for (ii=pool_ptr[tgt_pool]; ii<pool_ptr[tgt_pool+1]; ii++) {
+			i = pool_cpus[ii];
+			rq = cpu_rq(cpu_logical_map(i));
+			load += rq->nr_homenode[tgt_pool];
+		}
+		load = BALANCE_FACTOR * load / pool_nr_cpus[tgt_pool];
+		if (load < BALANCE_FACTOR/4) {
+			tgt_cpu = __ffs(p->cpus_allowed & pool_mask[tgt_pool]
+					& cpu_online_map);
+			if (tgt_cpu)
+				sched_push_task(p, tgt_cpu);
+		}
 	}
-	pull_task(busiest, array, tmp, this_rq, this_cpu);
-	if (!idle && --imbalance) {
-		if (curr != head)
-			goto skip_queue;
-		idx++;
-		goto skip_bitmap;
+#endif
+}
+
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
+	prio_array_t *array;
+
+	/* avoid deadlock by timer interrupt on own cpu */
+	if (atomic_read(&pool_lock)) return;
+	busiest = find_busiest_queue(this_rq, this_cpu, idle, &nr_running);
+	if (!busiest) {
+		try_push_home(this_rq, this_cpu, nr_running);
+		goto out;
 	}
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
+	pull_task(busiest, array, tmp, this_rq, this_cpu);
 out_unlock:
 	spin_unlock(&busiest->lock);
 out:
@@ -817,10 +981,10 @@
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
@@ -1854,6 +2018,284 @@
 	read_unlock(&tasklist_lock);
 }
 
+/* used as counter for round-robin node-scheduling */
+static atomic_t sched_node=ATOMIC_INIT(0);
+
+/*
+ * Find the least loaded CPU on the current node of the task.
+ */
+#ifdef CONFIG_NUMA_SCHED
+static int sched_best_cpu(struct task_struct *p)
+{
+	int n, cpu, load, best_cpu = task_cpu(p);
+	
+	load = 1000000;
+	for (n = pool_ptr[p->node]; n < pool_ptr[p->node+1]; n++) {
+		cpu = pool_cpus[n];
+		if (!(p->cpus_allowed & (1UL << cpu) & cpu_online_map))
+			continue;
+		if (cpu_rq(cpu)->nr_running < load) {
+			best_cpu = cpu;
+			load = cpu_rq(cpu)->nr_running;
+		}
+	}
+	return best_cpu;
+}
+
+/*
+ * Find the node with fewest tasks assigned to it. Don't bother about the
+ * current load of the nodes, the load balancer should take care.
+ * The argument  flag  gives some options for initial load balancing:
+ *    flag = 0:  don't count own task (when balancing at do_exec())
+ *    flag = 1:  count own task (when balancing at do_fork())
+ */
+static int sched_best_node(struct task_struct *p, int flag)
+{
+	int n, best_node=0, min_load, pool_load, min_pool=p->node;
+	int pool, load[NR_NODES];
+	unsigned long mask = p->cpus_allowed & cpu_online_map;
+
+	do {
+		best_node = atomic_inc_return(&sched_node) % numpools;
+	} while (!(pool_mask[best_node] & mask));
+
+	for (pool = 0; pool < numpools; pool++)
+		load[pool] = 0;
+
+	for (n = 0; n < num_online_cpus(); n++)
+#ifdef CONFIG_NODE_AFFINE_SCHED
+		for (pool = 0; pool < numpools; pool++)
+			load[pool] += cpu_rq(n)->nr_homenode[pool];
+#else
+		load[CPU_TO_NODE(n)] += cpu_rq(n)->nr_running;
+#endif
+
+	/* don't count own process, this one will be moved */
+	if (!flag)
+		--load[p->node];
+
+	min_load = 100000000;
+	for (n = 0; n < numpools; n++) {
+		pool = (best_node + n) % numpools;
+		pool_load = (100*load[pool])/pool_nr_cpus[pool];
+		if ((pool_load < min_load) && (pool_mask[pool] & mask)) {
+			min_load = pool_load;
+			min_pool = pool;
+		}
+	}
+	atomic_set(&sched_node, min_pool);
+	return min_pool;
+}
+
+void sched_balance_exec(void)
+{
+	int new_cpu, new_node;
+
+	while (atomic_read(&pool_lock))
+		cpu_relax();
+	if (numpools > 1) {
+		new_node = sched_best_node(current, 0);
+		if (new_node != current->node) {
+			set_task_node(current, new_node);
+		}
+	}
+	new_cpu = sched_best_cpu(current);
+	if (new_cpu != smp_processor_id())
+		sched_migrate_task(current, new_cpu);
+}
+
+void sched_balance_fork(task_t *p)
+{
+	while (atomic_read(&pool_lock))
+		cpu_relax();
+	if (numpools > 1)
+		p->node = sched_best_node(p, 1);
+	set_task_cpu(p, sched_best_cpu(p));
+}
+
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
+	for (i = 0; i < num_online_cpus(); i++)
+		if (cpu_online_map & (1UL<<i))
+			lnode_number[i] = pnode_to_lnode[SAPICID_TO_PNODE(cpu_physical_id(i))];
+
+	numpools = 0;
+	ptr = 0;
+	for (i = 0; i < num_online_cpus(); i++) {
+		if (!(cpu_online_map & (1UL<<i))) continue;
+		if (!flag[i]) {
+			pool_ptr[numpools]=ptr;
+			mask = 0UL;
+			for (j = 0; j < num_online_cpus(); j++) {
+				if (! (cpu_online_map & (1UL<<j))) continue;
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
+void set_task_node(task_t *p, int node)
+{
+	runqueue_t *rq;
+	unsigned long flags;
+
+	if (node < 0 || node >= numpools) return;
+	rq = task_rq_lock(p, &flags);
+	if (p->array) {
+		HOMENODE_DEC(rq, p->node);
+		HOMENODE_INC(rq, node);
+	}
+	p->node = node;
+	task_rq_unlock(rq, &flags);
+}
+#endif /* CONFIG_NUMA_SCHED */
 void __init init_idle(task_t *idle, int cpu)
 {
 	runqueue_t *idle_rq = cpu_rq(cpu), *rq = cpu_rq(task_cpu(idle));
@@ -1868,6 +2310,9 @@
 	idle->prio = MAX_PRIO;
 	idle->state = TASK_RUNNING;
 	set_task_cpu(idle, cpu);
+#ifdef CONFIG_NUMA_SCHED
+	idle->node = 0; /* was: SAPICID_TO_PNODE(cpu_physical_id(cpu)); */
+#endif
 	double_rq_unlock(idle_rq, rq);
 	set_tsk_need_resched(idle);
 	local_irq_restore(flags);
@@ -1902,6 +2347,8 @@
 	list_t list;
 	task_t *task;
 	struct semaphore sem;
+	int cpu_dest;
+	int sync;
 } migration_req_t;
 
 /*
@@ -1947,6 +2394,7 @@
 	}
 	init_MUTEX_LOCKED(&req.sem);
 	req.task = p;
+	req.sync = 1;
 	list_add(&req.list, &rq->migration_queue);
 	task_rq_unlock(rq, &flags);
 	wake_up_process(rq->migration_thread);
@@ -1957,6 +2405,53 @@
 }
 
 /*
+ * Static per cpu migration request structures for pushing the current
+ * process to another CPU from within load_balance().
+ */
+static migration_req_t migr_req[NR_CPUS];
+
+/*
+ * Push the current task to another cpu asynchronously. To be used from within
+ * load_balance() to push tasks running alone on a remote node back to their
+ * homenode. The RQ lock must be held when calling this function, it protects
+ * migr_req[cpu]. Function should not be preempted!
+ */
+static int sched_push_task(task_t *p, int cpu_dest)
+{
+	int cpu = smp_processor_id();
+	runqueue_t *rq = this_rq();
+	unsigned long flags;
+
+	if (migr_req[cpu].task)
+		return -1;
+	else {
+		migr_req[cpu].task = p;
+		migr_req[cpu].cpu_dest = cpu_dest;
+		migr_req[cpu].sync = 0;
+		list_add(&migr_req[cpu].list, &rq->migration_queue);
+
+		if (!rq->migration_thread->array) {
+			activate_task(rq->migration_thread, rq);
+			if (rq->migration_thread->prio < rq->curr->prio)
+				resched_task(rq->curr);
+		}
+		rq->migration_thread->state = TASK_RUNNING;
+		return 0;
+	}
+}
+
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
+/*
  * migration_thread - this is a highprio system thread that performs
  * thread migration by 'pulling' threads into the target runqueue.
  */
@@ -1972,6 +2467,7 @@
 	set_fs(KERNEL_DS);
 
 	set_cpus_allowed(current, 1UL << cpu);
+	set_task_node(current, CPU_TO_NODE(cpu));
 
 	/*
 	 * Migration can happen without a migration thread on the
@@ -1991,7 +2487,7 @@
 	for (;;) {
 		runqueue_t *rq_src, *rq_dest;
 		struct list_head *head;
-		int cpu_src, cpu_dest;
+		int cpu_src, cpu_dest, sync;
 		migration_req_t *req;
 		unsigned long flags;
 		task_t *p;
@@ -2006,10 +2502,17 @@
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
@@ -2032,7 +2535,8 @@
 		double_rq_unlock(rq_src, rq_dest);
 		local_irq_restore(flags);
 
-		up(&req->sem);
+		if (sync)
+			up(&req->sem);
 	}
 }
 
@@ -2098,7 +2602,21 @@
 			// delimiter for bitsearch
 			__set_bit(MAX_PRIO, array->bitmap);
 		}
+#ifdef CONFIG_NUMA_SCHED
+		for (j = 0; j < NR_NODES; j++)
+			rq->nr_homenode[j]=0;
+		pool_cpus[i] = i;
+#endif
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
diff -Nru a/kernel/softirq.c b/kernel/softirq.c
--- a/kernel/softirq.c	Wed Aug 21 15:43:51 2002
+++ b/kernel/softirq.c	Wed Aug 21 15:43:51 2002
@@ -365,6 +365,7 @@
 	set_cpus_allowed(current, 1UL << cpu);
 	if (smp_processor_id() != cpu)
 		BUG();
+	set_task_node(current, CPU_TO_NODE(cpu));
 
 	sprintf(current->comm, "ksoftirqd_CPU%d", cpu);
 
diff -Nru a/kernel/sys.c b/kernel/sys.c
--- a/kernel/sys.c	Wed Aug 21 15:43:51 2002
+++ b/kernel/sys.c	Wed Aug 21 15:43:51 2002
@@ -1253,6 +1253,8 @@
 {
 	int error = 0;
 	int sig;
+	int pid;
+	struct task_struct *child;
 
 	error = security_ops->task_prctl(option, arg2, arg3, arg4, arg5);
 	if (error)
@@ -1313,6 +1315,65 @@
 			}
 			current->keep_capabilities = arg2;
 			break;
+#ifdef CONFIG_NODE_AFFINE_SCHED
+		case PR_GET_NODE:
+			pid = (int) arg3;
+			read_lock(&tasklist_lock);
+			child = find_task_by_pid(pid);
+			if (child) {
+				error = put_user(child->node,(int *)arg2);
+			} else {
+				printk("prctl: could not find process %d\n",pid);
+				error = -EINVAL;
+			}
+			read_unlock(&tasklist_lock);
+			break;
+		case PR_SET_NODE:
+			pid = (int) arg3;
+			read_lock(&tasklist_lock);
+			child = find_task_by_pid(pid);
+			if (child) {
+				if (child->uid == current->uid || \
+				    current->uid == 0) {
+					printk("setting node of pid %d to %d\n",pid,(int)arg2);
+					set_task_node(child,(int)arg2);
+				}
+			} else {
+				printk("prctl: could not find pid %d\n",pid);
+				error = -EINVAL;
+			}
+			read_unlock(&tasklist_lock);
+			break;
+
+		case PR_GET_NODPOL:
+			pid = (int) arg3;
+			read_lock(&tasklist_lock);
+			child = find_task_by_pid(pid);
+			if (child) {
+				error = put_user(child->node_policy,(int *)arg2);
+			} else {
+				printk("prctl: could not find pid %d\n",pid);
+				error = -EINVAL;
+			}
+			read_unlock(&tasklist_lock);
+			break;
+		case PR_SET_NODPOL:
+			pid = (int) arg3;
+			read_lock(&tasklist_lock);
+			child = find_task_by_pid(pid);
+			if (child) {
+				if (child->uid == current->uid || \
+				    current->uid == 0) {
+					printk("setting node policy of process %d to %d\n",pid,(int)arg2);
+					child->node_policy = (int) arg2;
+				}
+			} else {
+				printk("prctl: could not find pid %d\n",pid);
+				error = -EINVAL;
+			}
+			read_unlock(&tasklist_lock);
+			break;
+#endif
 		default:
 			error = -EINVAL;
 			break;

--------------Boundary-00=_Z597HHSOK77EJPHDC1DA--

