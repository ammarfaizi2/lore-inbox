Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265448AbSJaX2S>; Thu, 31 Oct 2002 18:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265470AbSJaX2S>; Thu, 31 Oct 2002 18:28:18 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:5021 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265448AbSJaX2K>;
	Thu, 31 Oct 2002 18:28:10 -0500
Subject: [PATCH 2.5.45] NUMA Scheduler  (1/2)
From: Michael Hohnbaum <hohnbaum@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Cc: mingo@elte.hu, Erich Focht <efocht@ess.nec.de>
Content-Type: multipart/mixed; boundary="=-Y0EJ+Ab7PFAwTWp7/J0L"
X-Mailer: Ximian Evolution 1.0.8 
Date: 31 Oct 2002 15:31:37 -0800
Message-Id: <1036107098.21647.104.camel@dyn9-47-17-164.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Y0EJ+Ab7PFAwTWp7/J0L
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Linus,

Erich Focht has written scheduler extensions in support of
NUMA systems.  These extensions are being used at customer
sites.  I have branched off and done some similar NUMA scheduler
extensions, though on a much smaller scale.  We have combined
efforts and produced two patches which provide minimal NUMA
scheduler capabilities.

The first patch provides node awareness to the load balancer.
This is derived directly from Erich's Node aware NUMA scheduler.
The second patch adds load balancing at exec.  This is derived
from work that I have done.  Together, these patches provide
performance gains for kernel compilation of between 5 and 10%.
On memory bandwidth extensive microbenchmarks we have seen gains
of 50-100%.  

Please consider for inclusion in 2.5.

-- 

Michael Hohnbaum                      503-578-5486
hohnbaum@us.ibm.com                   T/L 775-5486

--=-Y0EJ+Ab7PFAwTWp7/J0L
Content-Disposition: attachment; filename=01-numa_sched_core-2.5.44-21.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=01-numa_sched_core-2.5.44-21.patch;
	charset=ISO-8859-1

diff -urNp a/arch/i386/kernel/smpboot.c b/arch/i386/kernel/smpboot.c
--- a/arch/i386/kernel/smpboot.c	Sat Oct 19 06:01:53 2002
+++ b/arch/i386/kernel/smpboot.c	Thu Oct 31 18:40:29 2002
@@ -1195,6 +1195,9 @@ int __devinit __cpu_up(unsigned int cpu)
 void __init smp_cpus_done(unsigned int max_cpus)
 {
 	zap_low_mappings();
+#ifdef CONFIG_NUMA
+	build_node_data();
+#endif
 }
=20
 void __init smp_intr_init()
diff -urNp a/arch/ia64/kernel/smpboot.c b/arch/ia64/kernel/smpboot.c
--- a/arch/ia64/kernel/smpboot.c	Thu Oct 31 12:49:25 2002
+++ b/arch/ia64/kernel/smpboot.c	Thu Oct 31 18:40:29 2002
@@ -397,7 +397,7 @@ unsigned long cache_decay_ticks;	/* # of
 static void
 smp_tune_scheduling (void)
 {
-	cache_decay_ticks =3D 10;	/* XXX base this on PAL info and cache-bandwidt=
h estimate */
+	cache_decay_ticks =3D 8;	/* XXX base this on PAL info and cache-bandwidth=
 estimate */
=20
 	printk("task migration cache decay timeout: %ld msecs.\n",
 	       (cache_decay_ticks + 1) * 1000 / HZ);
@@ -522,6 +522,9 @@ smp_cpus_done (unsigned int dummy)
=20
 	printk(KERN_INFO"Total of %d processors activated (%lu.%02lu BogoMIPS).\n=
",
 	       num_online_cpus(), bogosum/(500000/HZ), (bogosum/(5000/HZ))%100);
+#ifdef CONFIG_NUMA
+	build_node_data();
+#endif
 }
=20
 int __devinit
diff -urNp a/arch/ppc64/kernel/smp.c b/arch/ppc64/kernel/smp.c
--- a/arch/ppc64/kernel/smp.c	Sat Oct 19 06:02:27 2002
+++ b/arch/ppc64/kernel/smp.c	Thu Oct 31 18:40:29 2002
@@ -679,4 +679,7 @@ void __init smp_cpus_done(unsigned int m
=20
 	/* XXX fix this, xics currently relies on it - Anton */
 	smp_threads_ready =3D 1;
+#ifdef CONFIG_NUMA
+	build_node_data();
+#endif
 }
diff -urNp a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h	Thu Oct 31 11:34:14 2002
+++ b/include/linux/sched.h	Thu Oct 31 18:40:29 2002
@@ -22,6 +22,7 @@ extern unsigned long event;
 #include <asm/mmu.h>
=20
 #include <linux/smp.h>
+#include <asm/topology.h>
 #include <linux/sem.h>
 #include <linux/signal.h>
 #include <linux/securebits.h>
@@ -157,7 +158,6 @@ extern void update_one_process(struct ta
 extern void scheduler_tick(int user_tick, int system);
 extern unsigned long cache_decay_ticks;
=20
-
 #define	MAX_SCHEDULE_TIMEOUT	LONG_MAX
 extern signed long FASTCALL(schedule_timeout(signed long timeout));
 asmlinkage void schedule(void);
@@ -443,6 +443,9 @@ extern void set_cpus_allowed(task_t *p,=20
 # define set_cpus_allowed(p, new_mask) do { } while (0)
 #endif
=20
+#ifdef CONFIG_NUMA
+extern void build_pools(void);
+#endif
 extern void set_user_nice(task_t *p, long nice);
 extern int task_prio(task_t *p);
 extern int task_nice(task_t *p);
diff -urNp a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	Sat Oct 19 06:02:28 2002
+++ b/kernel/sched.c	Thu Oct 31 19:23:57 2002
@@ -157,6 +157,9 @@ struct runqueue {
 	task_t *migration_thread;
 	struct list_head migration_queue;
=20
+	unsigned long wait_time;
+	int wait_node;
+
 } ____cacheline_aligned;
=20
 static struct runqueue runqueues[NR_CPUS] __cacheline_aligned;
@@ -176,6 +179,56 @@ static struct runqueue runqueues[NR_CPUS
 # define task_running(rq, p)		((rq)->curr =3D=3D (p))
 #endif
=20
+#define cpu_to_node(cpu) __cpu_to_node(cpu)
+#define LOADSCALE 128
+
+#ifdef CONFIG_NUMA
+/* Number of CPUs per node: sane values until all CPUs are up */
+int _node_nr_cpus[MAX_NUMNODES] =3D { [0 ... MAX_NUMNODES-1] =3D NR_CPUS }=
;
+int node_ptr[MAX_NUMNODES+1]; /* first cpu of node (logical cpus are sorte=
d!)*/
+#define node_ncpus(node)  _node_nr_cpus[node]
+
+#define NODE_DELAY_IDLE  (1*HZ/1000)
+#define NODE_DELAY_BUSY  (20*HZ/1000)
+
+/* the following macro implies that logical CPUs are sorted by node number=
 */
+#define loop_over_node(cpu,node) \
+	for(cpu=3Dnode_ptr[node]; cpu<node_ptr[node+1]; cpu++)
+
+/*
+ * Build node_ptr and node_ncpus data after all CPUs have come up. This
+ * expects that the logical CPUs are sorted by their node numbers! Check
+ * out the NUMA API for details on why this should be that way.     [EF]
+ */
+void build_node_data(void)
+{
+	int n, cpu, ptr;
+	unsigned long mask;
+
+	ptr=3D0;
+	for (n=3D0; n<numnodes; n++) {
+		mask =3D __node_to_cpu_mask(n) & cpu_online_map;
+		node_ptr[n] =3D ptr;
+		for (cpu=3D0; cpu<NR_CPUS; cpu++)
+			if (mask  & (1UL << cpu))
+				ptr++;
+		node_ncpus(n) =3D ptr - node_ptr[n];;
+	}
+	printk("CPU nodes : %d\n",numnodes);
+	for (n=3D0; n<numnodes; n++)
+		printk("node %d : %d .. %d\n",n,node_ptr[n],node_ptr[n+1]-1);
+	if (cache_decay_ticks=3D=3D1)
+		printk("WARNING: cache_decay_ticks=3D1, probably unset by platform. Runn=
ing with poor CPU affinity!\n");
+}
+
+#else
+#define node_ncpus(node)  num_online_cpus()
+#define NODE_DELAY_IDLE 0
+#define NODE_DELAY_BUSY 0
+#define loop_over_node(cpu,n) for(cpu=3D0; cpu<NR_CPUS; cpu++)
+#endif
+
+
 /*
  * task_rq_lock - lock the runqueue a given task resides on and disable
  * interrupts.  Note the ordering: we can safely lookup the task_rq withou=
t
@@ -635,81 +688,134 @@ static inline unsigned int double_lock_b
 }
=20
 /*
- * find_busiest_queue - find the busiest runqueue.
- */
-static inline runqueue_t *find_busiest_queue(runqueue_t *this_rq, int this=
_cpu, int idle, int *imbalance)
-{
-	int nr_running, load, max_load, i;
-	runqueue_t *busiest, *rq_src;
+ * Find a runqueue from which to steal a task. We try to do this as locall=
y as
+ * possible because we don't want to let tasks get far from their node.
+ *=20
+ * 1. First try to find a runqueue within the own node with
+ * imbalance larger than 25% (relative to the current runqueue).
+ * 2. If the local node is well balanced, locate the most loaded node and =
its
+ * most loaded CPU.
+ *
+ * This routine implements node balancing by delaying steals from remote
+ * nodes more if the own node is (within margins) averagely loaded. The
+ * most loaded node is remembered as well as the time (jiffies). In the
+ * following calls to the load_balancer the time is compared with
+ * NODE_DELAY_BUSY (if load is around the average) or NODE_DELAY_IDLE (if =
own
+ * node is unloaded) if the most loaded node didn't change. This gives les=
s=20
+ * loaded nodes the chance to approach the average load but doesn't exclud=
e
+ * busy nodes from stealing (just in case the cpus_allowed mask isn't good
+ * for the idle nodes).
+ * This concept can be extended easilly to more than two levels (multi-lev=
el
+ * scheduler), e.g.: CPU -> node -> supernode... by implementing node-dist=
ance
+ * dependent steal delays.
+ *
+ *                                                         <efocht@ess.nec=
.de>
+ */
+
+struct node_queue_data {
+	int total_load;
+	int average_load;
+	int busiest_cpu;
+	int busiest_cpu_load;
+};
+
+/*
+ * Check if CPUs are balanced. The check is more involved than the O(1) or=
iginal
+ * because that one is simply wrong in certain cases (integer arithmetic !=
!!) EF
+ */
+#define CPUS_BALANCED(m,t) (((m)<=3D1) || (((m)-(t))/2 < (((m)+(t))/2 + 3)=
/4))
+/*
+ * Check if nodes are imbalanced. "this" node is balanced (compared to the=
 "comp"
+ * node) when it's load is not smaller than "comp"'s load - LOADSCALE/2.
+ */
+#define NODES_BALANCED(comp,this) (((comp)-(this)) < LOADSCALE/2)
+
+static inline runqueue_t *find_busiest_queue(int this_cpu, int idle, int *=
nr_running)
+{
+	runqueue_t *busiest_rq =3D NULL, *this_rq =3D cpu_rq(this_cpu), *src_rq;
+	int busiest_cpu, busiest_node=3D0, cpu, load, max_avg_load, avg_load;
+	int n, steal_delay, system_load =3D 0, this_node=3Dcpu_to_node(this_cpu);=
=20
+	struct node_queue_data nd[MAX_NUMNODES], *node;
=20
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
 	if (idle || (this_rq->nr_running > this_rq->prev_nr_running[this_cpu]))
-		nr_running =3D this_rq->nr_running;
+		*nr_running =3D this_rq->nr_running;
 	else
-		nr_running =3D this_rq->prev_nr_running[this_cpu];
+		*nr_running =3D this_rq->prev_nr_running[this_cpu];
=20
-	busiest =3D NULL;
-	max_load =3D 1;
-	for (i =3D 0; i < NR_CPUS; i++) {
-		if (!cpu_online(i))
-			continue;
+	for (n =3D 0; n < numnodes; n++) {
+		nd[n].busiest_cpu_load =3D -1;
+		nd[n].total_load =3D 0;
+	}
=20
-		rq_src =3D cpu_rq(i);
-		if (idle || (rq_src->nr_running < this_rq->prev_nr_running[i]))
-			load =3D rq_src->nr_running;
+	/* compute all node loads and save their max cpu loads */
+	for (cpu =3D 0; cpu < NR_CPUS; cpu++) {
+		if (!cpu_online(cpu)) continue;
+		node =3D &nd[cpu_to_node(cpu)];
+		src_rq =3D cpu_rq(cpu);
+		if (idle || (src_rq->nr_running < this_rq->prev_nr_running[cpu]))
+			load =3D src_rq->nr_running;
 		else
-			load =3D this_rq->prev_nr_running[i];
-		this_rq->prev_nr_running[i] =3D rq_src->nr_running;
-
-		if ((load > max_load) && (rq_src !=3D this_rq)) {
-			busiest =3D rq_src;
-			max_load =3D load;
+			load =3D this_rq->prev_nr_running[cpu];
+		this_rq->prev_nr_running[cpu] =3D src_rq->nr_running;
+		node->total_load +=3D load;
+		if (load > node->busiest_cpu_load) {
+			node->busiest_cpu_load =3D load;
+			node->busiest_cpu =3D cpu;
 		}
 	}
=20
-	if (likely(!busiest))
-		goto out;
+	busiest_cpu =3D nd[this_node].busiest_cpu;
+	if (busiest_cpu !=3D this_cpu) {
+		if (!CPUS_BALANCED(nd[this_node].busiest_cpu_load,*nr_running)) {
+			busiest_rq =3D cpu_rq(busiest_cpu);
+			this_rq->wait_node =3D -1;
+			goto out;
+		}
+	}
=20
-	*imbalance =3D (max_load - nr_running) / 2;
+#ifdef CONFIG_NUMA
+	max_avg_load =3D -1;
+	for (n =3D 0; n < numnodes; n++) {
+		node =3D &nd[n];
+		system_load +=3D node->total_load;
+		node->average_load =3D node->total_load*LOADSCALE/node_ncpus(n);
+		if (node->average_load > max_avg_load) {
+			max_avg_load =3D node->average_load;
+			busiest_node =3D n;
+		}
+	}
=20
-	/* It needs an at least ~25% imbalance to trigger balancing. */
-	if (!idle && (*imbalance < (max_load + 3)/4)) {
-		busiest =3D NULL;
+	/* Exit if not enough imbalance on any remote node. */
+	if ((busiest_node =3D=3D this_node) || (max_avg_load <=3D LOADSCALE) ||
+	    NODES_BALANCED(max_avg_load,nd[this_node].average_load)) {
+		this_rq->wait_node =3D -1;
 		goto out;
 	}
=20
-	nr_running =3D double_lock_balance(this_rq, busiest, this_cpu, idle, nr_r=
unning);
-	/*
-	 * Make sure nothing changed since we checked the
-	 * runqueue length.
-	 */
-	if (busiest->nr_running <=3D nr_running + 1) {
-		spin_unlock(&busiest->lock);
-		busiest =3D NULL;
+	busiest_cpu =3D nd[busiest_node].busiest_cpu;
+	avg_load =3D system_load*LOADSCALE/num_online_cpus();
+	/* Wait longer before stealing if own node's load is average. */
+	if (NODES_BALANCED(avg_load,nd[this_node].average_load))
+		steal_delay =3D NODE_DELAY_BUSY;
+	else
+		steal_delay =3D NODE_DELAY_IDLE;
+	/* if we have a new most loaded node: just mark it */
+	if (this_rq->wait_node !=3D busiest_node) {
+		this_rq->wait_node =3D busiest_node;
+		this_rq->wait_time =3D jiffies;
+		goto out;
+	} else
+	/* old most loaded node: check if waited enough */
+		if (jiffies - this_rq->wait_time < steal_delay)
+			goto out;
+
+	if ((!CPUS_BALANCED(nd[busiest_node].busiest_cpu_load,*nr_running))) {
+		busiest_rq =3D cpu_rq(busiest_cpu);
+		this_rq->wait_node =3D -1;
 	}
-out:
-	return busiest;
+#endif
+ out:
+	return busiest_rq;
 }
=20
 /*
@@ -741,16 +847,21 @@ static inline void pull_task(runqueue_t=20
  */
 static void load_balance(runqueue_t *this_rq, int idle)
 {
-	int imbalance, idx, this_cpu =3D smp_processor_id();
+	int imbalance, nr_running, idx, this_cpu =3D smp_processor_id();
 	runqueue_t *busiest;
 	prio_array_t *array;
 	struct list_head *head, *curr;
 	task_t *tmp;
=20
-	busiest =3D find_busiest_queue(this_rq, this_cpu, idle, &imbalance);
+	busiest =3D find_busiest_queue(this_cpu, idle, &nr_running);
 	if (!busiest)
 		goto out;
=20
+	imbalance =3D (busiest->nr_running - nr_running)/2;
+
+	nr_running =3D double_lock_balance(this_rq, busiest, this_cpu, idle, nr_r=
unning);
+	if (busiest->nr_running <=3D nr_running + 1)
+		goto out_unlock;
 	/*
 	 * We first consider expired tasks. Those will likely not be
 	 * executed in the near future, and they are most likely to
@@ -822,10 +933,10 @@ out:
  * frequency and balancing agressivity depends on whether the CPU is
  * idle or not.
  *
- * busy-rebalance every 250 msecs. idle-rebalance every 1 msec. (or on
+ * busy-rebalance every 200 msecs. idle-rebalance every 1 msec. (or on
  * systems with HZ=3D100, every 10 msecs.)
  */
-#define BUSY_REBALANCE_TICK (HZ/4 ?: 1)
+#define BUSY_REBALANCE_TICK (HZ/5 ?: 1)
 #define IDLE_REBALANCE_TICK (HZ/1000 ?: 1)
=20
 static inline void idle_tick(runqueue_t *rq)
@@ -2036,7 +2147,8 @@ static int migration_thread(void * data)
 		spin_unlock_irqrestore(&rq->lock, flags);
=20
 		p =3D req->task;
-		cpu_dest =3D __ffs(p->cpus_allowed);
+		cpu_dest =3D __ffs(p->cpus_allowed & cpu_online_map);
+
 		rq_dest =3D cpu_rq(cpu_dest);
 repeat:
 		cpu_src =3D task_cpu(p);
@@ -2136,6 +2248,8 @@ void __init sched_init(void)
 			__set_bit(MAX_PRIO, array->bitmap);
 		}
 	}
+	if (cache_decay_ticks)
+		cache_decay_ticks=3D1;
 	/*
 	 * We have to do a little magic to get the first
 	 * thread right in SMP mode.

--=-Y0EJ+Ab7PFAwTWp7/J0L--

