Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264631AbTANQO1>; Tue, 14 Jan 2003 11:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264646AbTANQO1>; Tue, 14 Jan 2003 11:14:27 -0500
Received: from ophelia.ess.nec.de ([193.141.139.8]:11917 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S264631AbTANQOS>; Tue, 14 Jan 2003 11:14:18 -0500
From: Erich Focht <efocht@ess.nec.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrew Theurer <habanero@us.ibm.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 2.5.58] new NUMA scheduler: fix
Date: Tue, 14 Jan 2003 17:23:29 +0100
User-Agent: KMail/1.4.3
Cc: Robert Love <rml@tech9.net>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
References: <52570000.1042156448@flay> <200301141214.12323.efocht@ess.nec.de> <200301141655.06660.efocht@ess.nec.de>
In-Reply-To: <200301141655.06660.efocht@ess.nec.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_5JPPT47MGR8JXQTO75VF"
Message-Id: <200301141723.29613.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_5JPPT47MGR8JXQTO75VF
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

In the previous email the patch 02-initial-lb-2.5.58.patch had a bug
and this was present in the numa-sched-2.5.58.patch and
numa-sched-add-2.5.58.patch, too. Please use the patches attached to
this email! Sorry for the silly mistake...

Christoph, I used your way of coding nr_running_inc/dec now.

Regards,
Erich


On Tuesday 14 January 2003 16:55, Erich Focht wrote:
> Here's the new version of the NUMA scheduler built on top of the
> miniature scheduler of Martin. I incorporated Michael's ideas and
> Christoph's suggestions and rediffed for 2.5.58.
>
> The whole patch is really tiny: 9.5k. This time I attached the numa
> scheduler in form of two patches:
>
> numa-sched-2.5.58.patch     (7k) : components 01, 02, 03
> numa-sched-add-2.5.58.patch (3k) : components 04, 05
>
> The single components are also attached in a small tgz archive:
>
> 01-minisched-2.5.58.patch : the miniature scheduler from
> Martin. Balances strictly within a node. Removed the
> find_busiest_in_mask() function.
>
> 02-initial-lb-2.5.58.patch : Michael's initial load balancer at
> exec(). Cosmetic corrections sugegsted by Christoph.
>
> 03-internode-lb-2.5.58.patch : internode load balancer core. Called
> after NODE_BALANCE_RATE calls of the inter-node load balancer. Tunable
> parameters:
>   NODE_BALANCE_RATE  (default: 10)
>   NODE_THRESHOLD     (default: 125) : consider only nodes with load
>                      above NODE_THRESHOLD/100 * own_node_load
>   I added the constant factor of 4 suggested by Michael, but I'm not
>   really happy with it. This should be nr_cpus_in_node, but we don't
>   have that info in topology.h
>
> 04-smooth-node-load-2.5.58.patch : The node load measure is smoothed
> by adding half of the previous node load (and 1/4 of the one before,
> etc..., as discussed in the LSE call). This should improve a bit the
> behavior in case of short timed load peaks and avoid bouncing tasks
> between nodes.
>
> 05-var-intnode-lb-2.5.58.patch : Replaces the fixed NODE_BALANCE_RATE
> interval (between cross-node balancer calls) by a variable
> node-specific interval. Currently only two values used:
>    NODE_BALANCE_MIN : 10
>    NODE_BALANCE_MAX : 40
> If the node load is less than avg_node_load/2, we switch to
> NODE_BALANCE_MIN, otherwise we use the large interval.
> I also added a function to reduce the number of tasks stolen from
> remote nodes.
>
> Regards,
> Erich

--------------Boundary-00=_5JPPT47MGR8JXQTO75VF
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="numa-sched-2.5.58.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="numa-sched-2.5.58.patch"

diff -urNp 2.5.58/fs/exec.c 2.5.58-ms-ilb-nb/fs/exec.c
--- 2.5.58/fs/exec.c	2003-01-14 06:58:33.000000000 +0100
+++ 2.5.58-ms-ilb-nb/fs/exec.c	2003-01-14 17:02:08.000000000 +0100
@@ -1031,6 +1031,8 @@ int do_execve(char * filename, char ** a
 	int retval;
 	int i;
 
+	sched_balance_exec();
+
 	file = open_exec(filename);
 
 	retval = PTR_ERR(file);
diff -urNp 2.5.58/include/linux/sched.h 2.5.58-ms-ilb-nb/include/linux/sched.h
--- 2.5.58/include/linux/sched.h	2003-01-14 06:58:06.000000000 +0100
+++ 2.5.58-ms-ilb-nb/include/linux/sched.h	2003-01-14 17:06:44.000000000 +0100
@@ -160,7 +160,6 @@ extern void update_one_process(struct ta
 extern void scheduler_tick(int user_tick, int system);
 extern unsigned long cache_decay_ticks;
 
-
 #define	MAX_SCHEDULE_TIMEOUT	LONG_MAX
 extern signed long FASTCALL(schedule_timeout(signed long timeout));
 asmlinkage void schedule(void);
@@ -444,6 +443,13 @@ extern void set_cpus_allowed(task_t *p, 
 # define set_cpus_allowed(p, new_mask) do { } while (0)
 #endif
 
+#ifdef CONFIG_NUMA
+extern void sched_balance_exec(void);
+extern void node_nr_running_init(void);
+#else
+#define sched_balance_exec() {}
+#endif
+
 extern void set_user_nice(task_t *p, long nice);
 extern int task_prio(task_t *p);
 extern int task_nice(task_t *p);
diff -urNp 2.5.58/init/main.c 2.5.58-ms-ilb-nb/init/main.c
--- 2.5.58/init/main.c	2003-01-14 06:58:20.000000000 +0100
+++ 2.5.58-ms-ilb-nb/init/main.c	2003-01-14 17:02:08.000000000 +0100
@@ -495,6 +495,7 @@ static void do_pre_smp_initcalls(void)
 
 	migration_init();
 #endif
+	node_nr_running_init();
 	spawn_ksoftirqd();
 }
 
diff -urNp 2.5.58/kernel/sched.c 2.5.58-ms-ilb-nb/kernel/sched.c
--- 2.5.58/kernel/sched.c	2003-01-14 06:59:11.000000000 +0100
+++ 2.5.58-ms-ilb-nb/kernel/sched.c	2003-01-14 17:10:37.000000000 +0100
@@ -67,6 +67,8 @@
 #define INTERACTIVE_DELTA	2
 #define MAX_SLEEP_AVG		(2*HZ)
 #define STARVATION_LIMIT	(2*HZ)
+#define NODE_BALANCE_RATIO	10
+#define NODE_THRESHOLD          125
 
 /*
  * If a task is 'interactive' then we reinsert it in the active
@@ -153,7 +155,10 @@ struct runqueue {
 	task_t *curr, *idle;
 	prio_array_t *active, *expired, arrays[2];
 	int prev_nr_running[NR_CPUS];
-
+#ifdef CONFIG_NUMA
+	atomic_t * node_ptr;
+	unsigned int nr_balanced;
+#endif
 	task_t *migration_thread;
 	struct list_head migration_queue;
 
@@ -177,6 +182,35 @@ static struct runqueue runqueues[NR_CPUS
 # define task_running(rq, p)		((rq)->curr == (p))
 #endif
 
+#if CONFIG_NUMA
+static atomic_t node_nr_running[MAX_NUMNODES] ____cacheline_maxaligned_in_smp =
+	{[0 ...MAX_NUMNODES-1] = ATOMIC_INIT(0)};
+
+static inline void nr_running_inc(runqueue_t *rq)
+{
+	atomic_inc(rq->node_ptr);
+	rq->nr_running++;
+}
+
+static inline void nr_running_dec(runqueue_t *rq)
+{
+	atomic_dec(rq->node_ptr);
+	rq->nr_running--;
+}
+
+__init void node_nr_running_init(void)
+{
+	int i;
+
+	for (i = 0; i < NR_CPUS; i++)
+		cpu_rq(i)->node_ptr = &node_nr_running[__cpu_to_node(i)];
+}
+#else
+# define nr_running_init(rq)   do { } while (0)
+# define nr_running_inc(rq)    do { (rq)->nr_running++; } while (0)
+# define nr_running_dec(rq)    do { (rq)->nr_running--; } while (0)
+#endif /* CONFIG_NUMA */
+
 /*
  * task_rq_lock - lock the runqueue a given task resides on and disable
  * interrupts.  Note the ordering: we can safely lookup the task_rq without
@@ -294,7 +328,7 @@ static inline void activate_task(task_t 
 		p->prio = effective_prio(p);
 	}
 	enqueue_task(p, array);
-	rq->nr_running++;
+	nr_running_inc(rq);
 }
 
 /*
@@ -302,7 +336,7 @@ static inline void activate_task(task_t 
  */
 static inline void deactivate_task(struct task_struct *p, runqueue_t *rq)
 {
-	rq->nr_running--;
+	nr_running_dec(rq);
 	if (p->state == TASK_UNINTERRUPTIBLE)
 		rq->nr_uninterruptible++;
 	dequeue_task(p, p->array);
@@ -624,6 +658,94 @@ static inline void double_rq_unlock(runq
 		spin_unlock(&rq2->lock);
 }
 
+#if CONFIG_NUMA
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
+
+static int find_busiest_node(int this_node)
+{
+	int i, node = -1, load, this_load, maxload;
+	
+	this_load = maxload = atomic_read(&node_nr_running[this_node]);
+	for (i = 0; i < numnodes; i++) {
+		if (i == this_node)
+			continue;
+		load = atomic_read(&node_nr_running[i]);
+		if (load > maxload &&
+		    (100*load > ((NODE_THRESHOLD*100*this_load)/100))) {
+			maxload = load;
+			node = i;
+		}
+	}
+	if (maxload <= 4)
+		node = -1;
+	return node;
+}
+#endif /* CONFIG_NUMA */
+
 #if CONFIG_SMP
 
 /*
@@ -652,9 +774,9 @@ static inline unsigned int double_lock_b
 }
 
 /*
- * find_busiest_queue - find the busiest runqueue.
+ * find_busiest_queue - find the busiest runqueue among the cpus in cpumask
  */
-static inline runqueue_t *find_busiest_queue(runqueue_t *this_rq, int this_cpu, int idle, int *imbalance)
+static inline runqueue_t *find_busiest_queue(runqueue_t *this_rq, int this_cpu, int idle, int *imbalance, unsigned long cpumask)
 {
 	int nr_running, load, max_load, i;
 	runqueue_t *busiest, *rq_src;
@@ -689,7 +811,7 @@ static inline runqueue_t *find_busiest_q
 	busiest = NULL;
 	max_load = 1;
 	for (i = 0; i < NR_CPUS; i++) {
-		if (!cpu_online(i))
+		if (!cpu_online(i) || !((1UL << i) & cpumask) )
 			continue;
 
 		rq_src = cpu_rq(i);
@@ -736,9 +858,9 @@ out:
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
@@ -763,8 +885,21 @@ static void load_balance(runqueue_t *thi
 	prio_array_t *array;
 	struct list_head *head, *curr;
 	task_t *tmp;
+	int this_node = __cpu_to_node(this_cpu);
+	unsigned long cpumask = __node_to_cpu_mask(this_node);
 
-	busiest = find_busiest_queue(this_rq, this_cpu, idle, &imbalance);
+#if CONFIG_NUMA
+	/*
+	 * Avoid rebalancing between nodes too often.
+	 */
+	if (!(++(this_rq->nr_balanced) % NODE_BALANCE_RATIO)) {
+		int node = find_busiest_node(this_node);
+		if (node >= 0)
+			cpumask = __node_to_cpu_mask(node) | (1UL << this_cpu);
+	}
+#endif
+	busiest = find_busiest_queue(this_rq, this_cpu, idle, &imbalance,
+				    cpumask);
 	if (!busiest)
 		goto out;
 
@@ -2231,6 +2366,10 @@ void __init sched_init(void)
 		spin_lock_init(&rq->lock);
 		INIT_LIST_HEAD(&rq->migration_queue);
 		atomic_set(&rq->nr_iowait, 0);
+#if CONFIG_NUMA
+		rq->node_ptr = &node_nr_running[0];
+#endif /* CONFIG_NUMA */
+
 
 		for (j = 0; j < 2; j++) {
 			array = rq->arrays + j;

--------------Boundary-00=_5JPPT47MGR8JXQTO75VF
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="numa-sched-add-2.5.58.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="numa-sched-add-2.5.58.patch"

diff -urNp 2.5.58-ms-ilb-nb/kernel/sched.c 2.5.58-ms-ilb-nb-sm-var/kernel/sched.c
--- 2.5.58-ms-ilb-nb/kernel/sched.c	2003-01-14 17:10:37.000000000 +0100
+++ 2.5.58-ms-ilb-nb-sm-var/kernel/sched.c	2003-01-14 17:12:35.000000000 +0100
@@ -67,8 +67,9 @@
 #define INTERACTIVE_DELTA	2
 #define MAX_SLEEP_AVG		(2*HZ)
 #define STARVATION_LIMIT	(2*HZ)
-#define NODE_BALANCE_RATIO	10
 #define NODE_THRESHOLD          125
+#define NODE_BALANCE_MIN	10
+#define NODE_BALANCE_MAX	40
 
 /*
  * If a task is 'interactive' then we reinsert it in the active
@@ -158,6 +159,7 @@ struct runqueue {
 #ifdef CONFIG_NUMA
 	atomic_t * node_ptr;
 	unsigned int nr_balanced;
+	int prev_node_load[MAX_NUMNODES];
 #endif
 	task_t *migration_thread;
 	struct list_head migration_queue;
@@ -185,6 +187,8 @@ static struct runqueue runqueues[NR_CPUS
 #if CONFIG_NUMA
 static atomic_t node_nr_running[MAX_NUMNODES] ____cacheline_maxaligned_in_smp =
 	{[0 ...MAX_NUMNODES-1] = ATOMIC_INIT(0)};
+static int internode_lb[MAX_NUMNODES] ____cacheline_maxaligned_in_smp =
+	{[0 ...MAX_NUMNODES-1] = NODE_BALANCE_MAX};
 
 static inline void nr_running_inc(runqueue_t *rq)
 {
@@ -725,25 +729,54 @@ void sched_balance_exec(void)
 	}
 }
 
+/*
+ * Find the busiest node. All previous node loads contribute with a 
+ * geometrically deccaying weight to the load measure:
+ *      load_{t} = load_{t-1}/2 + nr_node_running_{t}
+ * This way sudden load peaks are flattened out a bit.
+ */
 static int find_busiest_node(int this_node)
 {
 	int i, node = -1, load, this_load, maxload;
+	int avg_load;
 	
-	this_load = maxload = atomic_read(&node_nr_running[this_node]);
+	this_load = maxload = (this_rq()->prev_node_load[this_node] >> 1)
+		+ atomic_read(&node_nr_running[this_node]);
+	this_rq()->prev_node_load[this_node] = this_load;
+	avg_load = this_load;
 	for (i = 0; i < numnodes; i++) {
 		if (i == this_node)
 			continue;
-		load = atomic_read(&node_nr_running[i]);
+		load = (this_rq()->prev_node_load[i] >> 1)
+			+ atomic_read(&node_nr_running[i]);
+		avg_load += load;
+		this_rq()->prev_node_load[i] = load;
 		if (load > maxload &&
 		    (100*load > ((NODE_THRESHOLD*100*this_load)/100))) {
 			maxload = load;
 			node = i;
 		}
 	}
-	if (maxload <= 4)
+	avg_load = avg_load / (numnodes ? numnodes : 1);
+	if (this_load < (avg_load / 2)) {
+		if (internode_lb[this_node] == MAX_INTERNODE_LB)
+			internode_lb[this_node] = MIN_INTERNODE_LB;
+	} else
+		if (internode_lb[this_node] == MIN_INTERNODE_LB)
+			internode_lb[this_node] = MAX_INTERNODE_LB;
+	if (maxload <= 4+2+1 || this_load >= avg_load)
 		node = -1;
 	return node;
 }
+
+static inline int remote_steal_factor(runqueue_t *rq)
+{
+	int cpu = __cpu_to_node(task_cpu(rq->curr));
+
+	return (cpu == __cpu_to_node(smp_processor_id())) ? 1 : 2;
+}
+#else
+#define remote_steal_factor(rq) 1
 #endif /* CONFIG_NUMA */
 
 #if CONFIG_SMP
@@ -956,7 +989,7 @@ skip_queue:
 		goto skip_bitmap;
 	}
 	pull_task(busiest, array, tmp, this_rq, this_cpu);
-	if (!idle && --imbalance) {
+	if (!idle && ((--imbalance)/remote_steal_factor(busiest))) {
 		if (curr != head)
 			goto skip_queue;
 		idx++;

--------------Boundary-00=_5JPPT47MGR8JXQTO75VF
Content-Type: application/x-tgz;
  name="numa-sched-patches.tgz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="numa-sched-patches.tgz"

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

--------------Boundary-00=_5JPPT47MGR8JXQTO75VF--

