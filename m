Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263039AbTAEF1C>; Sun, 5 Jan 2003 00:27:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263137AbTAEF1C>; Sun, 5 Jan 2003 00:27:02 -0500
Received: from franka.aracnet.com ([216.99.193.44]:9658 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S263039AbTAEF0v>; Sun, 5 Jan 2003 00:26:51 -0500
Date: Sat, 04 Jan 2003 21:35:02 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Michael Hohnbaum <hohnbaum@us.ibm.com>, Erich Focht <efocht@ess.nec.de>
cc: Robert Love <rml@tech9.net>, Ingo Molnar <mingo@elte.hu>,
       Stephen Hemminger <shemminger@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.53] NUMA scheduler (1/3)
Message-ID: <108220000.1041744901@titus>
In-Reply-To: <1041645514.21653.29.camel@kenai>
References: <200211061734.42713.efocht@ess.nec.de>
 <200212021629.39060.efocht@ess.nec.de><200212181721.39434.efocht@ess.nec.de>
 <200212311429.04382.efocht@ess.nec.de> <1041645514.21653.29.camel@kenai>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Here comes the minimal NUMA scheduler built on top of the O(1) load
>> balancer rediffed for 2.5.53 with some changes in the core part. As
>> suggested by Michael, I added the cputimes_stat patch, as it is
>> absolutely needed for understanding the scheduler behavior.
>
> Thanks for this latest patch.  I've managed to cobble together
> a 4 node NUMAQ system (16 700 MHZ PIII procs, 16GB memory) and
> ran kernbench and schedbench on this, along with the 2.5.50 and
> 2.5.52 versions.  Results remain fairly consistent with what
> we have been obtaining on earlier versions.
>
> Kernbench:
>                         Elapsed       User     System        CPU
>              sched50     29.96s   288.308s    83.606s    1240.8%
>              sched52    29.836s   285.832s    84.464s    1240.4%
>              sched53    29.364s   284.808s    83.174s    1252.6%
>              stock50    31.074s   303.664s    89.194s    1264.2%
>              stock53    31.204s   306.224s    87.776s    1263.2%

Not sure what you're correllating here because your rows are all named
the same thing. However, the new version seems to be much slower
on systime (about 7-8% for me), which roughly correllates with your
last two rows above. Me no like.

Erich, can you seperate out the cleanups from the functional changes?
The cleanups look cool. The only thing that I can see easily was
BUSY_REBALANCE_TICK - I tried changing that back to the old version
but it made no difference. Here's a diff going from your old scheduler
(that I've been keeping update in my tree) to your new one on 2.5.54.

M.

diff -urpN -X /home/fletch/.diff.exclude 
oldsched/arch/i386/kernel/smpboot.c newsched/arch/i386/kernel/smpboot.c
--- oldsched/arch/i386/kernel/smpboot.c	Sat Jan  4 14:57:43 2003
+++ newsched/arch/i386/kernel/smpboot.c	Sat Jan  4 14:58:25 2003
@@ -1198,9 +1198,7 @@ int __devinit __cpu_up(unsigned int cpu)
 void __init smp_cpus_done(unsigned int max_cpus)
 {
 	zap_low_mappings();
-#ifdef CONFIG_NUMA
 	build_node_data();
-#endif
 }

 void __init smp_intr_init()
diff -urpN -X /home/fletch/.diff.exclude 
oldsched/arch/ia64/kernel/smpboot.c newsched/arch/ia64/kernel/smpboot.c
--- oldsched/arch/ia64/kernel/smpboot.c	Sat Jan  4 14:57:43 2003
+++ newsched/arch/ia64/kernel/smpboot.c	Sat Jan  4 14:58:25 2003
@@ -528,9 +528,7 @@ smp_cpus_done (unsigned int dummy)

 	printk(KERN_INFO"Total of %d processors activated (%lu.%02lu 
BogoMIPS).\n",
 	       num_online_cpus(), bogosum/(500000/HZ), (bogosum/(5000/HZ))%100);
-#ifdef CONFIG_NUMA
 	build_node_data();
-#endif
 }

 int __devinit
diff -urpN -X /home/fletch/.diff.exclude oldsched/arch/ppc64/kernel/smp.c 
newsched/arch/ppc64/kernel/smp.c
--- oldsched/arch/ppc64/kernel/smp.c	Sat Jan  4 14:57:43 2003
+++ newsched/arch/ppc64/kernel/smp.c	Sat Jan  4 14:58:25 2003
@@ -685,7 +685,5 @@ void __init smp_cpus_done(unsigned int m

 	/* XXX fix this, xics currently relies on it - Anton */
 	smp_threads_ready = 1;
-#ifdef CONFIG_NUMA
 	build_node_data();
-#endif
 }
diff -urpN -X /home/fletch/.diff.exclude oldsched/include/linux/sched.h 
newsched/include/linux/sched.h
--- oldsched/include/linux/sched.h	Sat Jan  4 14:57:50 2003
+++ newsched/include/linux/sched.h	Sat Jan  4 14:58:28 2003
@@ -20,7 +20,6 @@
 #include <asm/mmu.h>

 #include <linux/smp.h>
-#include <asm/topology.h>
 #include <linux/sem.h>
 #include <linux/signal.h>
 #include <linux/securebits.h>
@@ -160,19 +159,6 @@ extern void update_one_process(struct ta
 			       unsigned long system, int cpu);
 extern void scheduler_tick(int user_tick, int system);
 extern unsigned long cache_decay_ticks;
-#ifdef CONFIG_NUMA
-extern void sched_balance_exec(void);
-extern void node_nr_running_init(void);
-#define nr_running_inc(rq) atomic_inc(rq->node_ptr); \
-	rq->nr_running++
-#define nr_running_dec(rq) atomic_dec(rq->node_ptr); \
-	rq->nr_running--
-#else
-#define sched_balance_exec() {}
-#define node_nr_running_init() {}
-#define nr_running_inc(rq) rq->nr_running++
-#define nr_running_dec(rq) rq->nr_running--
-#endif

 #define	MAX_SCHEDULE_TIMEOUT	LONG_MAX
 extern signed long FASTCALL(schedule_timeout(signed long timeout));
@@ -458,8 +444,21 @@ extern void set_cpus_allowed(task_t *p,
 #endif

 #ifdef CONFIG_NUMA
-extern void build_pools(void);
+extern void build_node_data(void);
+extern void sched_balance_exec(void);
+extern void node_nr_running_init(void);
+#define nr_running_inc(rq) atomic_inc(rq->node_ptr); \
+	rq->nr_running++
+#define nr_running_dec(rq) atomic_dec(rq->node_ptr); \
+	rq->nr_running--
+#else
+#define build_node_data() {}
+#define sched_balance_exec() {}
+#define node_nr_running_init() {}
+#define nr_running_inc(rq) rq->nr_running++
+#define nr_running_dec(rq) rq->nr_running--
 #endif
+
 extern void set_user_nice(task_t *p, long nice);
 extern int task_prio(task_t *p);
 extern int task_nice(task_t *p);
diff -urpN -X /home/fletch/.diff.exclude oldsched/kernel/sched.c 
newsched/kernel/sched.c
--- oldsched/kernel/sched.c	Sat Jan  4 14:57:50 2003
+++ newsched/kernel/sched.c	Sat Jan  4 14:58:28 2003
@@ -159,10 +159,10 @@ struct runqueue {
 	struct list_head migration_queue;

 	atomic_t nr_iowait;
-
+#ifdef CONFIG_NUMA
 	unsigned long wait_time;
 	int wait_node;
-
+#endif
 } ____cacheline_aligned;

 static struct runqueue runqueues[NR_CPUS] __cacheline_aligned;
@@ -182,24 +182,33 @@ static struct runqueue runqueues[NR_CPUS
 # define task_running(rq, p)		((rq)->curr == (p))
 #endif

-#define cpu_to_node(cpu) __cpu_to_node(cpu)
+/*
+ * Node loads are scaled with LOADSCALE. This way:
+ * - we avoid zeros in integer divisions (dividing by node CPU number),
+ * - loads of nodes with different numbers of CPUs are comparable.
+ */
 #define LOADSCALE 128

 #ifdef CONFIG_NUMA
 /* Number of CPUs per node: sane values until all CPUs are up */
-int _node_nr_cpus[MAX_NUMNODES] = { [0 ... MAX_NUMNODES-1] = NR_CPUS };
-int node_ptr[MAX_NUMNODES+1]; /* first cpu of node (logical cpus are 
sorted!)*/
-#define node_ncpus(node)  _node_nr_cpus[node]
+static int _node_nr_cpus[MAX_NUMNODES] = { [0 ... MAX_NUMNODES-1] = 
NR_CPUS };
+static int node_ptr[MAX_NUMNODES+1]; /* first cpu of node (logical cpus 
are sorted!)*/
+#define node_nr_cpus(node)  _node_nr_cpus[node]

+/*
+ * Delay stealing from remote node when own queue is idle/busy. These 
delays
+ * tend to equalize the node loads. NODE_DELAY_IDLE is nonzero because we
+ * want to give idle CPUs in the busiest node a chance to steal first.
+ */
 #define NODE_DELAY_IDLE  (1*HZ/1000)
 #define NODE_DELAY_BUSY  (20*HZ/1000)

 /* the following macro implies that logical CPUs are sorted by node number 
*/
 #define loop_over_node(cpu,node) \
-	for(cpu=node_ptr[node]; cpu<node_ptr[node+1]; cpu++)
+	for(cpu = node_ptr[node]; cpu < node_ptr[node+1]; cpu++)

 /*
- * Build node_ptr and node_ncpus data after all CPUs have come up. This
+ * Build node_ptr and node_nr_cpus data after all CPUs have come up. This
  * expects that the logical CPUs are sorted by their node numbers! Check
  * out the NUMA API for details on why this should be that way.     [EF]
  */
@@ -209,24 +218,25 @@ void build_node_data(void)
 	unsigned long mask;

 	ptr=0;
-	for (n=0; n<numnodes; n++) {
+	for (n = 0; n < numnodes; n++) {
 		mask = __node_to_cpu_mask(n) & cpu_online_map;
 		node_ptr[n] = ptr;
-		for (cpu=0; cpu<NR_CPUS; cpu++)
+		for (cpu = 0; cpu < NR_CPUS; cpu++)
 			if (mask  & (1UL << cpu))
 				ptr++;
-		node_ncpus(n) = ptr - node_ptr[n];;
+		node_nr_cpus(n) = ptr - node_ptr[n];
 	}
+	node_ptr[numnodes] = ptr;
 	printk("CPU nodes : %d\n",numnodes);
-	for (n=0; n<numnodes; n++)
+	for (n = 0; n < numnodes; n++)
 		printk("node %d : %d .. %d\n",n,node_ptr[n],node_ptr[n+1]-1);
 }

 #else
-#define node_ncpus(node)  num_online_cpus()
+#define node_nr_cpus(node)  num_online_cpus()
 #define NODE_DELAY_IDLE 0
 #define NODE_DELAY_BUSY 0
-#define loop_over_node(cpu,n) for(cpu=0; cpu<NR_CPUS; cpu++)
+#define loop_over_node(cpu,n) for(cpu = 0; cpu < NR_CPUS; cpu++)
 #endif


@@ -740,18 +750,18 @@ struct node_queue_data {
  * Check if CPUs are balanced. The check is more involved than the O(1) 
original
  * because that one is simply wrong in certain cases (integer arithmetic 
!!!) EF
  */
-#define CPUS_BALANCED(m,t) (((m)<=1) || (((m)-(t))/2 < (((m)+(t))/2 + 
3)/4))
+#define cpus_balanced(m,t) (((m)<=1) || (((m)-(t))/2 < (((m)+(t))/2 + 
3)/4))
 /*
  * Check if nodes are imbalanced. "this" node is balanced (compared to the 
"comp"
  * node) when it's load is not smaller than "comp"'s load - LOADSCALE/2.
  */
-#define NODES_BALANCED(comp,this) (((comp)-(this)) < LOADSCALE/2)
+#define nodes_balanced(comp,this) (((comp)-(this)) < LOADSCALE/2)

 static inline runqueue_t *find_busiest_queue(int this_cpu, int idle, int 
*nr_running)
 {
 	runqueue_t *busiest_rq = NULL, *this_rq = cpu_rq(this_cpu), *src_rq;
 	int busiest_cpu, busiest_node=0, cpu, load, max_avg_load, avg_load;
-	int n, steal_delay, system_load = 0, this_node=cpu_to_node(this_cpu);
+	int n, steal_delay, system_load = 0, this_node=__cpu_to_node(this_cpu);
 	struct node_queue_data nd[MAX_NUMNODES], *node;

 	if (idle || (this_rq->nr_running > this_rq->prev_nr_running[this_cpu]))
@@ -766,8 +776,9 @@ static inline runqueue_t *find_busiest_q

 	/* compute all node loads and save their max cpu loads */
 	for (cpu = 0; cpu < NR_CPUS; cpu++) {
-		if (!cpu_online(cpu)) continue;
-		node = &nd[cpu_to_node(cpu)];
+		if (!cpu_online(cpu))
+			continue;
+		node = &nd[__cpu_to_node(cpu)];
 		src_rq = cpu_rq(cpu);
 		if (idle || (src_rq->nr_running < this_rq->prev_nr_running[cpu]))
 			load = src_rq->nr_running;
@@ -783,7 +794,7 @@ static inline runqueue_t *find_busiest_q

 	busiest_cpu = nd[this_node].busiest_cpu;
 	if (busiest_cpu != this_cpu) {
-		if (!CPUS_BALANCED(nd[this_node].busiest_cpu_load,*nr_running)) {
+		if (!cpus_balanced(nd[this_node].busiest_cpu_load,*nr_running)) {
 			busiest_rq = cpu_rq(busiest_cpu);
 			this_rq->wait_node = -1;
 			goto out;
@@ -795,7 +806,7 @@ static inline runqueue_t *find_busiest_q
 	for (n = 0; n < numnodes; n++) {
 		node = &nd[n];
 		system_load += node->total_load;
-		node->average_load = node->total_load*LOADSCALE/node_ncpus(n);
+		node->average_load = node->total_load*LOADSCALE/node_nr_cpus(n);
 		if (node->average_load > max_avg_load) {
 			max_avg_load = node->average_load;
 			busiest_node = n;
@@ -804,7 +815,7 @@ static inline runqueue_t *find_busiest_q

 	/* Exit if not enough imbalance on any remote node. */
 	if ((busiest_node == this_node) || (max_avg_load <= LOADSCALE) ||
-	    NODES_BALANCED(max_avg_load,nd[this_node].average_load)) {
+	    nodes_balanced(max_avg_load,nd[this_node].average_load)) {
 		this_rq->wait_node = -1;
 		goto out;
 	}
@@ -812,7 +823,7 @@ static inline runqueue_t *find_busiest_q
 	busiest_cpu = nd[busiest_node].busiest_cpu;
 	avg_load = system_load*LOADSCALE/num_online_cpus();
 	/* Wait longer before stealing if own node's load is average. */
-	if (NODES_BALANCED(avg_load,nd[this_node].average_load))
+	if (nodes_balanced(avg_load,nd[this_node].average_load))
 		steal_delay = NODE_DELAY_BUSY;
 	else
 		steal_delay = NODE_DELAY_IDLE;
@@ -821,12 +832,11 @@ static inline runqueue_t *find_busiest_q
 		this_rq->wait_node = busiest_node;
 		this_rq->wait_time = jiffies;
 		goto out;
-	} else
 	/* old most loaded node: check if waited enough */
-		if (jiffies - this_rq->wait_time < steal_delay)
-			goto out;
+	} else if (jiffies - this_rq->wait_time < steal_delay)
+		goto out;

-	if ((!CPUS_BALANCED(nd[busiest_node].busiest_cpu_load,*nr_running))) {
+	if ((!cpus_balanced(nd[busiest_node].busiest_cpu_load,*nr_running))) {
 		busiest_rq = cpu_rq(busiest_cpu);
 		this_rq->wait_node = -1;
 	}
@@ -950,10 +960,10 @@ out:
  * frequency and balancing agressivity depends on whether the CPU is
  * idle or not.
  *
- * busy-rebalance every 200 msecs. idle-rebalance every 1 msec. (or on
+ * busy-rebalance every 250 msecs. idle-rebalance every 1 msec. (or on
  * systems with HZ=100, every 10 msecs.)
  */
-#define BUSY_REBALANCE_TICK (HZ/5 ?: 1)
+#define BUSY_REBALANCE_TICK (HZ/4 ?: 1)
 #define IDLE_REBALANCE_TICK (HZ/1000 ?: 1)

 static inline void idle_tick(runqueue_t *rq)

