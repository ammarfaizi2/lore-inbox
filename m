Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267578AbTALXqb>; Sun, 12 Jan 2003 18:46:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267653AbTALXqb>; Sun, 12 Jan 2003 18:46:31 -0500
Received: from ophelia.ess.nec.de ([193.141.139.8]:6836 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S267578AbTALXqV>; Sun, 12 Jan 2003 18:46:21 -0500
From: Erich Focht <efocht@ess.nec.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: NUMA scheduler 2nd approach
Date: Mon, 13 Jan 2003 00:55:28 +0100
User-Agent: KMail/1.4.3
Cc: Robert Love <rml@tech9.net>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
References: <52570000.1042156448@flay> <200301101734.56182.efocht@ess.nec.de> <967810000.1042217859@titus>
In-Reply-To: <967810000.1042217859@titus>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_G4LMV274NIP2WSJ4YPQ9"
Message-Id: <200301130055.28005.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_G4LMV274NIP2WSJ4YPQ9
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Martin & Michael,

as discussed on the LSE call I played around with a cross-node
balancer approach put on top of the miniature NUMA scheduler. The
patches are attached and it seems to be clear that we can regain the
good performance for hackbench by adding a cross-node balancer.

The patches are:

01-minisched-2.5.55.patch : the miniature scheduler from
Martin. Balances strictly within a node. Added an inlined function to
make the integration of the cross-node balancer easier. The added code
is optimised away by the compiler.

02-initial-lb-2.5.55.patch : Michael's initial load balancer at
exec().

03-internode-lb-2.5.55.patch : internode load balancer core. Called
after INTERNODE_LB calls of the inter-node load balancer. The most
loaded node's cpu-mask is ORed to the own node's cpu-mask and
find_busiest_in_mask() finds the most loaded CPU in this set.

04-smooth-node-load-2.5.55.patch : The node load measure is smoothed
by adding half of the previous node load (and 1/4 of the one before,
etc..., as discussed in the LSE call). This should improve a bit the
behavior in case of short timed load peaks and avoid bouncing tasks
between nodes.

05-var-intnode-lb2-2.5.55.patch : Replaces the fixed INTERNODE_LB
interval (between cross-node balancer calls) by a variable
node-specific interval. Currently only two values used. Certainly
needs some tweaking and tuning.

01, 02, 03 are enough to produce a working NUMA scheduler, when
including all patches the behavior should be better. I made some
measurements which I'd like to post in a separate email tomorrow.

Comments? Ideas?

Regards,
Erich

--------------Boundary-00=_G4LMV274NIP2WSJ4YPQ9
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="01-minisched-2.5.55.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="01-minisched-2.5.55.patch"

diff -urNp linux-2.5.55/kernel/sched.c linux-2.5.55-ms/kernel/sched.c
--- linux-2.5.55/kernel/sched.c	2003-01-09 05:04:22.000000000 +0100
+++ linux-2.5.55-ms/kernel/sched.c	2003-01-11 15:46:10.000000000 +0100
@@ -652,9 +652,9 @@ static inline unsigned int double_lock_b
 }
 
 /*
- * find_busiest_queue - find the busiest runqueue.
+ * find_busiest_in_mask - find the busiest runqueue among the cpus in cpumask
  */
-static inline runqueue_t *find_busiest_queue(runqueue_t *this_rq, int this_cpu, int idle, int *imbalance)
+static inline runqueue_t *find_busiest_in_mask(runqueue_t *this_rq, int this_cpu, int idle, int *imbalance, unsigned long cpumask)
 {
 	int nr_running, load, max_load, i;
 	runqueue_t *busiest, *rq_src;
@@ -689,7 +689,7 @@ static inline runqueue_t *find_busiest_q
 	busiest = NULL;
 	max_load = 1;
 	for (i = 0; i < NR_CPUS; i++) {
-		if (!cpu_online(i))
+		if (!cpu_online(i) || !((1UL << i) & cpumask) )
 			continue;
 
 		rq_src = cpu_rq(i);
@@ -730,6 +730,16 @@ out:
 }
 
 /*
+ * find_busiest_queue - find the busiest runqueue.
+ */
+static inline runqueue_t *find_busiest_queue(runqueue_t *this_rq, int this_cpu, int idle, int *imbalance)
+{
+	unsigned long cpumask = __node_to_cpu_mask(__cpu_to_node(this_cpu));
+	return find_busiest_in_mask(this_rq, this_cpu, idle, imbalance,
+				    cpumask);
+}
+
+/*
  * pull_task - move a task from a remote runqueue to the local runqueue.
  * Both runqueues must be locked.
  */

--------------Boundary-00=_G4LMV274NIP2WSJ4YPQ9
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="02-initial-lb-2.5.55.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="02-initial-lb-2.5.55.patch"

diff -urNp linux-2.5.55-ms/fs/exec.c linux-2.5.55-ms-ilb/fs/exec.c
--- linux-2.5.55-ms/fs/exec.c	2003-01-09 05:04:00.000000000 +0100
+++ linux-2.5.55-ms-ilb/fs/exec.c	2003-01-11 01:09:25.000000000 +0100
@@ -1027,6 +1027,8 @@ int do_execve(char * filename, char ** a
 	int retval;
 	int i;
 
+	sched_balance_exec();
+
 	file = open_exec(filename);
 
 	retval = PTR_ERR(file);
diff -urNp linux-2.5.55-ms/include/linux/sched.h linux-2.5.55-ms-ilb/include/linux/sched.h
--- linux-2.5.55-ms/include/linux/sched.h	2003-01-09 05:03:53.000000000 +0100
+++ linux-2.5.55-ms-ilb/include/linux/sched.h	2003-01-11 01:10:31.000000000 +0100
@@ -160,7 +160,6 @@ extern void update_one_process(struct ta
 extern void scheduler_tick(int user_tick, int system);
 extern unsigned long cache_decay_ticks;
 
-
 #define	MAX_SCHEDULE_TIMEOUT	LONG_MAX
 extern signed long FASTCALL(schedule_timeout(signed long timeout));
 asmlinkage void schedule(void);
@@ -444,6 +443,20 @@ extern void set_cpus_allowed(task_t *p, 
 # define set_cpus_allowed(p, new_mask) do { } while (0)
 #endif
 
+#ifdef CONFIG_NUMA
+extern void sched_balance_exec(void);
+extern void node_nr_running_init(void);
+#define nr_running_inc(rq) atomic_inc(rq->node_ptr); \
+	rq->nr_running++
+#define nr_running_dec(rq) atomic_dec(rq->node_ptr); \
+	rq->nr_running--
+#else
+#define sched_balance_exec() {}
+#define node_nr_running_init() {}
+#define nr_running_inc(rq) rq->nr_running++
+#define nr_running_dec(rq) rq->nr_running--
+#endif
+
 extern void set_user_nice(task_t *p, long nice);
 extern int task_prio(task_t *p);
 extern int task_nice(task_t *p);
diff -urNp linux-2.5.55-ms/init/main.c linux-2.5.55-ms-ilb/init/main.c
--- linux-2.5.55-ms/init/main.c	2003-01-09 05:03:55.000000000 +0100
+++ linux-2.5.55-ms-ilb/init/main.c	2003-01-11 01:09:25.000000000 +0100
@@ -495,6 +495,7 @@ static void do_pre_smp_initcalls(void)
 
 	migration_init();
 #endif
+	node_nr_running_init();
 	spawn_ksoftirqd();
 }
 
diff -urNp linux-2.5.55-ms/kernel/sched.c linux-2.5.55-ms-ilb/kernel/sched.c
--- linux-2.5.55-ms/kernel/sched.c	2003-01-10 23:01:02.000000000 +0100
+++ linux-2.5.55-ms-ilb/kernel/sched.c	2003-01-11 01:12:43.000000000 +0100
@@ -153,6 +153,7 @@ struct runqueue {
 	task_t *curr, *idle;
 	prio_array_t *active, *expired, arrays[2];
 	int prev_nr_running[NR_CPUS];
+	atomic_t * node_ptr;
 
 	task_t *migration_thread;
 	struct list_head migration_queue;
@@ -294,7 +295,7 @@ static inline void activate_task(task_t 
 		p->prio = effective_prio(p);
 	}
 	enqueue_task(p, array);
-	rq->nr_running++;
+	nr_running_inc(rq);
 }
 
 /*
@@ -302,7 +303,7 @@ static inline void activate_task(task_t 
  */
 static inline void deactivate_task(struct task_struct *p, runqueue_t *rq)
 {
-	rq->nr_running--;
+	nr_running_dec(rq);
 	if (p->state == TASK_UNINTERRUPTIBLE)
 		rq->nr_uninterruptible++;
 	dequeue_task(p, p->array);
@@ -736,9 +737,9 @@ out:
 static inline void pull_task(runqueue_t *src_rq, prio_array_t *src_array, task_t *p, runqueue_t *this_rq, int this_cpu)
 {
 	dequeue_task(p, src_array);
-	src_rq->nr_running--;
+	nr_running_dec(src_rq);
 	set_task_cpu(p, this_cpu);
-	this_rq->nr_running++;
+	nr_running_inc(this_rq);
 	enqueue_task(p, this_rq->active);
 	/*
 	 * Note that idle threads have a prio of MAX_PRIO, for this test
@@ -2171,6 +2172,86 @@ __init int migration_init(void)
 
 #endif
 
+#if CONFIG_NUMA
+static atomic_t node_nr_running[MAX_NUMNODES] ____cacheline_maxaligned_in_smp = {[0 ...MAX_NUMNODES-1] = ATOMIC_INIT(0)};
+
+__init void node_nr_running_init(void)
+{
+	int i;
+
+	for (i = 0; i < NR_CPUS; i++) {
+		cpu_rq(i)->node_ptr = &node_nr_running[__cpu_to_node(i)];
+	}
+	return;
+}
+
+/*
+ * If dest_cpu is allowed for this process, migrate the task to it.
+ * This is accomplished by forcing the cpu_allowed mask to only
+ * allow dest_cpu, which will force the cpu onto dest_cpu.  Then
+ * the cpu_allowed mask is restored.
+ */
+static void sched_migrate_task(task_t *p, int dest_cpu)
+{
+	unsigned long old_mask;
+
+	old_mask = p->cpus_allowed;
+	if (!(old_mask & (1UL << dest_cpu)))
+		return;
+	/* force the process onto the specified CPU */
+	set_cpus_allowed(p, 1UL << dest_cpu);
+
+	/* restore the cpus allowed mask */
+	set_cpus_allowed(p, old_mask);
+}
+
+/*
+ * Find the least loaded CPU.  Slightly favor the current CPU by
+ * setting its runqueue length as the minimum to start.
+ */
+static int sched_best_cpu(struct task_struct *p)
+{
+	int i, minload, load, best_cpu, node = 0;
+	unsigned long cpumask;
+
+	best_cpu = task_cpu(p);
+	if (cpu_rq(best_cpu)->nr_running <= 2)
+		return best_cpu;
+
+	minload = 10000000;
+	for (i = 0; i < numnodes; i++) {
+		load = atomic_read(&node_nr_running[i]);
+		if (load < minload) {
+			minload = load;
+			node = i;
+		}
+	}
+
+	minload = 10000000;
+	cpumask = __node_to_cpu_mask(node);
+	for (i = 0; i < NR_CPUS; ++i) {
+		if (!(cpumask & (1UL << i)))
+			continue;
+		if (cpu_rq(i)->nr_running < minload) {
+			best_cpu = i;
+			minload = cpu_rq(i)->nr_running;
+		}
+	}
+	return best_cpu;
+}
+
+void sched_balance_exec(void)
+{
+	int new_cpu;
+
+	if (numnodes > 1) {
+		new_cpu = sched_best_cpu(current);
+		if (new_cpu != smp_processor_id())
+			sched_migrate_task(current, new_cpu);
+	}
+}
+#endif /* CONFIG_NUMA */
+
 #if CONFIG_SMP || CONFIG_PREEMPT
 /*
  * The 'big kernel lock'
@@ -2232,6 +2313,10 @@ void __init sched_init(void)
 		spin_lock_init(&rq->lock);
 		INIT_LIST_HEAD(&rq->migration_queue);
 		atomic_set(&rq->nr_iowait, 0);
+#if CONFIG_NUMA
+		rq->node_ptr = &node_nr_running[0];
+#endif /* CONFIG_NUMA */
+
 
 		for (j = 0; j < 2; j++) {
 			array = rq->arrays + j;

--------------Boundary-00=_G4LMV274NIP2WSJ4YPQ9
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="03-internode-lb-2.5.55.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="03-internode-lb-2.5.55.patch"

diff -urNp linux-2.5.55-ms-ilb/include/linux/sched.h linux-2.5.55-ms-ilb-nb/include/linux/sched.h
--- linux-2.5.55-ms-ilb/include/linux/sched.h	2003-01-12 18:03:07.000000000 +0100
+++ linux-2.5.55-ms-ilb-nb/include/linux/sched.h	2003-01-11 17:19:49.000000000 +0100
@@ -450,11 +450,13 @@ extern void node_nr_running_init(void);
 	rq->nr_running++
 #define nr_running_dec(rq) atomic_dec(rq->node_ptr); \
 	rq->nr_running--
+#define decl_numa_int(ctr) int ctr
 #else
 #define sched_balance_exec() {}
 #define node_nr_running_init() {}
 #define nr_running_inc(rq) rq->nr_running++
 #define nr_running_dec(rq) rq->nr_running--
+#define decl_numa_int(ctr) {}
 #endif
 
 extern void set_user_nice(task_t *p, long nice);
diff -urNp linux-2.5.55-ms-ilb/kernel/sched.c linux-2.5.55-ms-ilb-nb/kernel/sched.c
--- linux-2.5.55-ms-ilb/kernel/sched.c	2003-01-12 18:03:07.000000000 +0100
+++ linux-2.5.55-ms-ilb-nb/kernel/sched.c	2003-01-12 18:12:27.000000000 +0100
@@ -154,6 +154,7 @@ struct runqueue {
 	prio_array_t *active, *expired, arrays[2];
 	int prev_nr_running[NR_CPUS];
 	atomic_t * node_ptr;
+	decl_numa_int(lb_cntr);
 
 	task_t *migration_thread;
 	struct list_head migration_queue;
@@ -703,6 +704,23 @@ void sched_balance_exec(void)
 			sched_migrate_task(current, new_cpu);
 	}
 }
+
+static int find_busiest_node(int this_node)
+{
+	int i, node = this_node, load, this_load, maxload;
+	
+	this_load = maxload = atomic_read(&node_nr_running[this_node]);
+	for (i = 0; i < numnodes; i++) {
+		if (i == this_node)
+			continue;
+		load = atomic_read(&node_nr_running[i]);
+		if (load > maxload && (4*load > ((5*4*this_load)/4))) {
+			maxload = load;
+			node = i;
+		}
+	}
+	return node;
+}
 #endif /* CONFIG_NUMA */
 
 #if CONFIG_SMP
@@ -816,6 +834,16 @@ out:
 static inline runqueue_t *find_busiest_queue(runqueue_t *this_rq, int this_cpu, int idle, int *imbalance)
 {
 	unsigned long cpumask = __node_to_cpu_mask(__cpu_to_node(this_cpu));
+#if CONFIG_NUMA
+	int node;
+#       define INTERNODE_LB 10
+
+	/* rebalance across nodes only every INTERNODE_LB call */
+	if (!(++(this_rq->lb_cntr) % INTERNODE_LB)) {
+		node = find_busiest_node(__cpu_to_node(this_cpu));
+		cpumask |= __node_to_cpu_mask(node);
+	}
+#endif
 	return find_busiest_in_mask(this_rq, this_cpu, idle, imbalance,
 				    cpumask);
 }

--------------Boundary-00=_G4LMV274NIP2WSJ4YPQ9
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="04-smooth-node-load-2.5.55.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="04-smooth-node-load-2.5.55.patch"

diff -urNp linux-2.5.55-ms-ilb-nb/include/linux/sched.h linux-2.5.55-ms-ilb-nba/include/linux/sched.h
--- linux-2.5.55-ms-ilb-nb/include/linux/sched.h	2003-01-11 17:19:49.000000000 +0100
+++ linux-2.5.55-ms-ilb-nba/include/linux/sched.h	2003-01-11 17:17:53.000000000 +0100
@@ -451,12 +451,14 @@ extern void node_nr_running_init(void);
 #define nr_running_dec(rq) atomic_dec(rq->node_ptr); \
 	rq->nr_running--
 #define decl_numa_int(ctr) int ctr
+#define decl_numa_nodeint(v) int v[MAX_NUMNODES]
 #else
 #define sched_balance_exec() {}
 #define node_nr_running_init() {}
 #define nr_running_inc(rq) rq->nr_running++
 #define nr_running_dec(rq) rq->nr_running--
 #define decl_numa_int(ctr) {}
+#define decl_numa_nodeint(v) {}
 #endif
 
 extern void set_user_nice(task_t *p, long nice);
diff -urNp linux-2.5.55-ms-ilb-nb/kernel/sched.c linux-2.5.55-ms-ilb-nba/kernel/sched.c
--- linux-2.5.55-ms-ilb-nb/kernel/sched.c	2003-01-12 18:18:16.000000000 +0100
+++ linux-2.5.55-ms-ilb-nba/kernel/sched.c	2003-01-12 18:15:34.000000000 +0100
@@ -155,6 +155,7 @@ struct runqueue {
 	int prev_nr_running[NR_CPUS];
 	atomic_t * node_ptr;
 	decl_numa_int(lb_cntr);
+	decl_numa_nodeint(prev_node_load);
 
 	task_t *migration_thread;
 	struct list_head migration_queue;
@@ -705,15 +706,25 @@ void sched_balance_exec(void)
 	}
 }
 
+/*
+ * Find the busiest node. All previous node loads contribute with a geometrically
+ * deccaying weight to the load measure:
+ *      load_{t} = load_{t-1}/2 + nr_node_running_{t}
+ * This way sudden load peaks are flattened out a bit.
+ */
 static int find_busiest_node(int this_node)
 {
 	int i, node = this_node, load, this_load, maxload;
 	
-	this_load = maxload = atomic_read(&node_nr_running[this_node]);
+	this_load = maxload = (this_rq()->prev_node_load[this_node] >> 1)
+		+ atomic_read(&node_nr_running[this_node]);
+	this_rq()->prev_node_load[this_node] = this_load;
 	for (i = 0; i < numnodes; i++) {
 		if (i == this_node)
 			continue;
-		load = atomic_read(&node_nr_running[i]);
+		load = (this_rq()->prev_node_load[i] >> 1)
+			+ atomic_read(&node_nr_running[i]);
+		this_rq()->prev_node_load[i] = load;
 		if (load > maxload && (4*load > ((5*4*this_load)/4))) {
 			maxload = load;
 			node = i;

--------------Boundary-00=_G4LMV274NIP2WSJ4YPQ9
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="05-var-intnode-lb2-2.5.55.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="05-var-intnode-lb2-2.5.55.patch"

diff -urNp linux-2.5.55-ms-ilb-nba/kernel/sched.c linux-2.5.55-ms-ilb-nbav/kernel/sched.c
--- linux-2.5.55-ms-ilb-nba/kernel/sched.c	2003-01-12 18:15:34.000000000 +0100
+++ linux-2.5.55-ms-ilb-nbav/kernel/sched.c	2003-01-12 23:16:25.000000000 +0100
@@ -629,6 +629,9 @@ static inline void double_rq_unlock(runq
 
 #if CONFIG_NUMA
 static atomic_t node_nr_running[MAX_NUMNODES] ____cacheline_maxaligned_in_smp = {[0 ...MAX_NUMNODES-1] = ATOMIC_INIT(0)};
+#define MAX_INTERNODE_LB 40
+#define MIN_INTERNODE_LB 4
+static int internode_lb[MAX_NUMNODES] ____cacheline_maxaligned_in_smp = {[0 ...MAX_NUMNODES-1] = MAX_INTERNODE_LB};
 
 __init void node_nr_running_init(void)
 {
@@ -715,21 +718,31 @@ void sched_balance_exec(void)
 static int find_busiest_node(int this_node)
 {
 	int i, node = this_node, load, this_load, maxload;
+	int avg_load;
 	
 	this_load = maxload = (this_rq()->prev_node_load[this_node] >> 1)
 		+ atomic_read(&node_nr_running[this_node]);
 	this_rq()->prev_node_load[this_node] = this_load;
+	avg_load = this_load;
 	for (i = 0; i < numnodes; i++) {
 		if (i == this_node)
 			continue;
 		load = (this_rq()->prev_node_load[i] >> 1)
 			+ atomic_read(&node_nr_running[i]);
+		avg_load += load;
 		this_rq()->prev_node_load[i] = load;
 		if (load > maxload && (4*load > ((5*4*this_load)/4))) {
 			maxload = load;
 			node = i;
 		}
 	}
+	avg_load = avg_load / (numnodes ? numnodes : 1);
+	if (this_load < (avg_load / 2)) {
+		if (internode_lb[this_node] == MAX_INTERNODE_LB)
+			internode_lb[this_node] = MIN_INTERNODE_LB;
+	} else
+		if (internode_lb[this_node] == MIN_INTERNODE_LB)
+			internode_lb[this_node] = MAX_INTERNODE_LB;
 	return node;
 }
 #endif /* CONFIG_NUMA */
@@ -846,11 +859,10 @@ static inline runqueue_t *find_busiest_q
 {
 	unsigned long cpumask = __node_to_cpu_mask(__cpu_to_node(this_cpu));
 #if CONFIG_NUMA
-	int node;
-#       define INTERNODE_LB 10
+	int node, this_node = __cpu_to_node(this_cpu);
 
-	/* rebalance across nodes only every INTERNODE_LB call */
-	if (!(++(this_rq->lb_cntr) % INTERNODE_LB)) {
+	/* rarely rebalance across nodes */
+	if (!(++(this_rq->lb_cntr) % internode_lb[this_node])) {
 		node = find_busiest_node(__cpu_to_node(this_cpu));
 		cpumask |= __node_to_cpu_mask(node);
 	}

--------------Boundary-00=_G4LMV274NIP2WSJ4YPQ9--

