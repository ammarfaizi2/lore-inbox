Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266643AbTAOPBy>; Wed, 15 Jan 2003 10:01:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266645AbTAOPBy>; Wed, 15 Jan 2003 10:01:54 -0500
Received: from ophelia.ess.nec.de ([193.141.139.8]:33717 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S266643AbTAOPBn>; Wed, 15 Jan 2003 10:01:43 -0500
From: Erich Focht <efocht@ess.nec.de>
To: Michael Hohnbaum <hohnbaum@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2.5.58] new NUMA scheduler: fix
Date: Wed, 15 Jan 2003 16:10:43 +0100
User-Agent: KMail/1.4.3
Cc: Andrew Theurer <habanero@us.ibm.com>, Robert Love <rml@tech9.net>,
       Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
References: <52570000.1042156448@flay> <200301141743.25513.efocht@ess.nec.de> <1042570956.27149.178.camel@dyn9-47-17-164.beaverton.ibm.com>
In-Reply-To: <1042570956.27149.178.camel@dyn9-47-17-164.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_VTGRG3BFV90HDCM8JTOK"
Message-Id: <200301151610.43204.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_VTGRG3BFV90HDCM8JTOK
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

Thanks for the patience with the problems in the yesterday patches. I
resend the patches in the same form. Made following changes:

- moved NODE_BALANCE_{RATE,MIN,MAX} to topology.h
- removed the divide in the find_busiest_node() loop (thanks, Martin)
- removed the modulo (%) in in the cross-node balancing trigger
- re-added node_nr_running_init() stub, nr_running_init() and comments
  from Christoph
- removed the constant factor 4 in find_busiest_node. The
  find_busiest_queue routine will take care of the case where the
  busiest_node is running only few processes (at most one per CPU) and
  return busiest=3DNULL .

I hope we can start tuning the parameters now. In the basic NUMA
scheduler part these are:
  NODE_THRESHOLD     : minimum percentage of node overload to
                       trigger cross-node balancing
  NODE_BALANCE_RATE  : arch specific, cross-node balancing is called
                       after this many intra-node load balance calls

In the extended NUMA scheduler the fixed value of NODE_BALANCE_RATE is
replaced by a variable rate set to :
  NODE_BALANCE_MIN : if own node load is less then avg_load/2
  NODE_BALANCE_MAX : if load is larger than avg_load/2
Together with the reduced number of steals across nodes this might
help us in achieving equal load among nodes. I'm not aware of any
simple benchmark which can demonstrate this...

Regards,
Erich

--------------Boundary-00=_VTGRG3BFV90HDCM8JTOK
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="numa-sched-2.5.58.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="numa-sched-2.5.58.patch"

diff -urNp 2.5.58/fs/exec.c 2.5.58-ms-ilb-nb/fs/exec.c
--- 2.5.58/fs/exec.c	2003-01-14 06:58:33.000000000 +0100
+++ 2.5.58-ms-ilb-nb/fs/exec.c	2003-01-15 11:47:32.000000000 +0100
@@ -1031,6 +1031,8 @@ int do_execve(char * filename, char ** a
 	int retval;
 	int i;
 
+	sched_balance_exec();
+
 	file = open_exec(filename);
 
 	retval = PTR_ERR(file);
diff -urNp 2.5.58/include/asm-generic/topology.h 2.5.58-ms-ilb-nb/include/asm-generic/topology.h
--- 2.5.58/include/asm-generic/topology.h	2003-01-14 06:58:06.000000000 +0100
+++ 2.5.58-ms-ilb-nb/include/asm-generic/topology.h	2003-01-15 15:24:45.000000000 +0100
@@ -48,4 +48,9 @@
 #define __node_to_memblk(node)		(0)
 #endif
 
+/* Cross-node load balancing interval. */
+#ifndef NODE_BALANCE_RATE
+#define NODE_BALANCE_RATE 10
+#endif
+
 #endif /* _ASM_GENERIC_TOPOLOGY_H */
diff -urNp 2.5.58/include/asm-i386/topology.h 2.5.58-ms-ilb-nb/include/asm-i386/topology.h
--- 2.5.58/include/asm-i386/topology.h	2003-01-14 06:58:20.000000000 +0100
+++ 2.5.58-ms-ilb-nb/include/asm-i386/topology.h	2003-01-15 15:25:11.000000000 +0100
@@ -61,6 +61,9 @@ static inline int __node_to_first_cpu(in
 /* Returns the number of the first MemBlk on Node 'node' */
 #define __node_to_memblk(node) (node)
 
+/* Cross-node load balancing interval. */
+#define NODE_BALANCE_RATE 100
+
 #else /* !CONFIG_NUMA */
 /*
  * Other i386 platforms should define their own version of the 
diff -urNp 2.5.58/include/asm-ia64/topology.h 2.5.58-ms-ilb-nb/include/asm-ia64/topology.h
--- 2.5.58/include/asm-ia64/topology.h	2003-01-14 06:58:03.000000000 +0100
+++ 2.5.58-ms-ilb-nb/include/asm-ia64/topology.h	2003-01-15 15:25:28.000000000 +0100
@@ -60,4 +60,7 @@
  */
 #define __node_to_memblk(node) (node)
 
+/* Cross-node load balancing interval. */
+#define NODE_BALANCE_RATE 10
+
 #endif /* _ASM_IA64_TOPOLOGY_H */
diff -urNp 2.5.58/include/asm-ppc64/topology.h 2.5.58-ms-ilb-nb/include/asm-ppc64/topology.h
--- 2.5.58/include/asm-ppc64/topology.h	2003-01-14 06:59:29.000000000 +0100
+++ 2.5.58-ms-ilb-nb/include/asm-ppc64/topology.h	2003-01-15 15:24:15.000000000 +0100
@@ -46,6 +46,9 @@ static inline unsigned long __node_to_cp
 	return mask;
 }
 
+/* Cross-node load balancing interval. */
+#define NODE_BALANCE_RATE 10
+
 #else /* !CONFIG_NUMA */
 
 #define __cpu_to_node(cpu)		(0)
diff -urNp 2.5.58/include/linux/sched.h 2.5.58-ms-ilb-nb/include/linux/sched.h
--- 2.5.58/include/linux/sched.h	2003-01-14 06:58:06.000000000 +0100
+++ 2.5.58-ms-ilb-nb/include/linux/sched.h	2003-01-15 11:47:32.000000000 +0100
@@ -160,7 +160,6 @@ extern void update_one_process(struct ta
 extern void scheduler_tick(int user_tick, int system);
 extern unsigned long cache_decay_ticks;
 
-
 #define	MAX_SCHEDULE_TIMEOUT	LONG_MAX
 extern signed long FASTCALL(schedule_timeout(signed long timeout));
 asmlinkage void schedule(void);
@@ -444,6 +443,14 @@ extern void set_cpus_allowed(task_t *p, 
 # define set_cpus_allowed(p, new_mask) do { } while (0)
 #endif
 
+#ifdef CONFIG_NUMA
+extern void sched_balance_exec(void);
+extern void node_nr_running_init(void);
+#else
+#define sched_balance_exec()   {}
+#define node_nr_running_init() {}
+#endif
+
 extern void set_user_nice(task_t *p, long nice);
 extern int task_prio(task_t *p);
 extern int task_nice(task_t *p);
diff -urNp 2.5.58/init/main.c 2.5.58-ms-ilb-nb/init/main.c
--- 2.5.58/init/main.c	2003-01-14 06:58:20.000000000 +0100
+++ 2.5.58-ms-ilb-nb/init/main.c	2003-01-15 11:47:32.000000000 +0100
@@ -495,6 +495,7 @@ static void do_pre_smp_initcalls(void)
 
 	migration_init();
 #endif
+	node_nr_running_init();
 	spawn_ksoftirqd();
 }
 
diff -urNp 2.5.58/kernel/sched.c 2.5.58-ms-ilb-nb/kernel/sched.c
--- 2.5.58/kernel/sched.c	2003-01-14 06:59:11.000000000 +0100
+++ 2.5.58-ms-ilb-nb/kernel/sched.c	2003-01-15 15:26:29.000000000 +0100
@@ -67,6 +67,7 @@
 #define INTERACTIVE_DELTA	2
 #define MAX_SLEEP_AVG		(2*HZ)
 #define STARVATION_LIMIT	(2*HZ)
+#define NODE_THRESHOLD          125
 
 /*
  * If a task is 'interactive' then we reinsert it in the active
@@ -153,7 +154,10 @@ struct runqueue {
 	task_t *curr, *idle;
 	prio_array_t *active, *expired, arrays[2];
 	int prev_nr_running[NR_CPUS];
-
+#ifdef CONFIG_NUMA
+	atomic_t *node_nr_running;
+	unsigned int nr_balanced;
+#endif
 	task_t *migration_thread;
 	struct list_head migration_queue;
 
@@ -178,6 +182,44 @@ static struct runqueue runqueues[NR_CPUS
 #endif
 
 /*
+ * Keep track of running tasks.
+ */
+#if CONFIG_NUMA
+/* XXX(hch): this should go into a struct sched_node_data */
+static atomic_t node_nr_running[MAX_NUMNODES] ____cacheline_maxaligned_in_smp =
+	{[0 ...MAX_NUMNODES-1] = ATOMIC_INIT(0)};
+
+static inline void nr_running_init(struct runqueue *rq)
+{
+	rq->node_nr_running = &node_nr_running[0];
+}
+
+static inline void nr_running_inc(runqueue_t *rq)
+{
+	atomic_inc(rq->node_nr_running);
+	rq->nr_running++;
+}
+
+static inline void nr_running_dec(runqueue_t *rq)
+{
+	atomic_dec(rq->node_nr_running);
+	rq->nr_running--;
+}
+
+__init void node_nr_running_init(void)
+{
+	int i;
+
+	for (i = 0; i < NR_CPUS; i++)
+		cpu_rq(i)->node_nr_running = &node_nr_running[__cpu_to_node(i)];
+}
+#else
+# define nr_running_init(rq)   do { } while (0)
+# define nr_running_inc(rq)    do { (rq)->nr_running++; } while (0)
+# define nr_running_dec(rq)    do { (rq)->nr_running--; } while (0)
+#endif /* CONFIG_NUMA */
+
+/*
  * task_rq_lock - lock the runqueue a given task resides on and disable
  * interrupts.  Note the ordering: we can safely lookup the task_rq without
  * explicitly disabling preemption.
@@ -294,7 +336,7 @@ static inline void activate_task(task_t 
 		p->prio = effective_prio(p);
 	}
 	enqueue_task(p, array);
-	rq->nr_running++;
+	nr_running_inc(rq);
 }
 
 /*
@@ -302,7 +344,7 @@ static inline void activate_task(task_t 
  */
 static inline void deactivate_task(struct task_struct *p, runqueue_t *rq)
 {
-	rq->nr_running--;
+	nr_running_dec(rq);
 	if (p->state == TASK_UNINTERRUPTIBLE)
 		rq->nr_uninterruptible++;
 	dequeue_task(p, p->array);
@@ -624,6 +666,91 @@ static inline void double_rq_unlock(runq
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
+		if (load > maxload && (100*load > NODE_THRESHOLD*this_load)) {
+			maxload = load;
+			node = i;
+		}
+	}
+	return node;
+}
+#endif /* CONFIG_NUMA */
+
 #if CONFIG_SMP
 
 /*
@@ -652,9 +779,9 @@ static inline unsigned int double_lock_b
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
@@ -689,7 +816,7 @@ static inline runqueue_t *find_busiest_q
 	busiest = NULL;
 	max_load = 1;
 	for (i = 0; i < NR_CPUS; i++) {
-		if (!cpu_online(i))
+		if (!cpu_online(i) || !((1UL << i) & cpumask))
 			continue;
 
 		rq_src = cpu_rq(i);
@@ -736,9 +863,9 @@ out:
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
@@ -758,13 +885,30 @@ static inline void pull_task(runqueue_t 
  */
 static void load_balance(runqueue_t *this_rq, int idle)
 {
-	int imbalance, idx, this_cpu = smp_processor_id();
+	int imbalance, idx, this_cpu, this_node;
+	unsigned long cpumask;
 	runqueue_t *busiest;
 	prio_array_t *array;
 	struct list_head *head, *curr;
 	task_t *tmp;
 
-	busiest = find_busiest_queue(this_rq, this_cpu, idle, &imbalance);
+	this_cpu = smp_processor_id();
+	this_node = __cpu_to_node(this_cpu);
+	cpumask = __node_to_cpu_mask(this_node);
+
+#if CONFIG_NUMA
+	/*
+	 * Avoid rebalancing between nodes too often.
+	 */
+	if (++(this_rq->nr_balanced) == NODE_BALANCE_RATE) {
+		int node = find_busiest_node(this_node);
+		this_rq->nr_balanced = 0;
+		if (node >= 0)
+			cpumask = __node_to_cpu_mask(node) | (1UL << this_cpu);
+	}
+#endif
+	busiest = find_busiest_queue(this_rq, this_cpu, idle, &imbalance,
+				    cpumask);
 	if (!busiest)
 		goto out;
 
@@ -2231,6 +2375,7 @@ void __init sched_init(void)
 		spin_lock_init(&rq->lock);
 		INIT_LIST_HEAD(&rq->migration_queue);
 		atomic_set(&rq->nr_iowait, 0);
+		nr_running_init(rq);
 
 		for (j = 0; j < 2; j++) {
 			array = rq->arrays + j;

--------------Boundary-00=_VTGRG3BFV90HDCM8JTOK
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="numa-sched-add-2.5.58.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="numa-sched-add-2.5.58.patch"

diff -urNp 2.5.58-ms-ilb-nb/include/asm-generic/topology.h 2.5.58-ms-ilb-nb-sm-var/include/asm-generic/topology.h
--- 2.5.58-ms-ilb-nb/include/asm-generic/topology.h	2003-01-15 15:24:45.000000000 +0100
+++ 2.5.58-ms-ilb-nb-sm-var/include/asm-generic/topology.h	2003-01-15 15:32:39.000000000 +0100
@@ -49,8 +49,11 @@
 #endif
 
 /* Cross-node load balancing interval. */
-#ifndef NODE_BALANCE_RATE
-#define NODE_BALANCE_RATE 10
+#ifndef NODE_BALANCE_MIN
+#define NODE_BALANCE_MIN 10
+#endif
+#ifndef NODE_BALANCE_MAX
+#define NODE_BALANCE_MAX 50
 #endif
 
 #endif /* _ASM_GENERIC_TOPOLOGY_H */
diff -urNp 2.5.58-ms-ilb-nb/include/asm-i386/topology.h 2.5.58-ms-ilb-nb-sm-var/include/asm-i386/topology.h
--- 2.5.58-ms-ilb-nb/include/asm-i386/topology.h	2003-01-15 15:25:11.000000000 +0100
+++ 2.5.58-ms-ilb-nb-sm-var/include/asm-i386/topology.h	2003-01-15 15:33:50.000000000 +0100
@@ -62,7 +62,8 @@ static inline int __node_to_first_cpu(in
 #define __node_to_memblk(node) (node)
 
 /* Cross-node load balancing interval. */
-#define NODE_BALANCE_RATE 100
+#define NODE_BALANCE_MIN 10
+#define NODE_BALANCE_MAX 250
 
 #else /* !CONFIG_NUMA */
 /*
diff -urNp 2.5.58-ms-ilb-nb/include/asm-ia64/topology.h 2.5.58-ms-ilb-nb-sm-var/include/asm-ia64/topology.h
--- 2.5.58-ms-ilb-nb/include/asm-ia64/topology.h	2003-01-15 15:25:28.000000000 +0100
+++ 2.5.58-ms-ilb-nb-sm-var/include/asm-ia64/topology.h	2003-01-15 15:34:11.000000000 +0100
@@ -61,6 +61,7 @@
 #define __node_to_memblk(node) (node)
 
 /* Cross-node load balancing interval. */
-#define NODE_BALANCE_RATE 10
+#define NODE_BALANCE_MIN 10
+#define NODE_BALANCE_MAX 50
 
 #endif /* _ASM_IA64_TOPOLOGY_H */
diff -urNp 2.5.58-ms-ilb-nb/include/asm-ppc64/topology.h 2.5.58-ms-ilb-nb-sm-var/include/asm-ppc64/topology.h
--- 2.5.58-ms-ilb-nb/include/asm-ppc64/topology.h	2003-01-15 15:24:15.000000000 +0100
+++ 2.5.58-ms-ilb-nb-sm-var/include/asm-ppc64/topology.h	2003-01-15 15:34:36.000000000 +0100
@@ -47,7 +47,8 @@ static inline unsigned long __node_to_cp
 }
 
 /* Cross-node load balancing interval. */
-#define NODE_BALANCE_RATE 10
+#define NODE_BALANCE_MIN 10
+#define NODE_BALANCE_MAX 50
 
 #else /* !CONFIG_NUMA */
 
diff -urNp 2.5.58-ms-ilb-nb/kernel/sched.c 2.5.58-ms-ilb-nb-sm-var/kernel/sched.c
--- 2.5.58-ms-ilb-nb/kernel/sched.c	2003-01-15 15:26:29.000000000 +0100
+++ 2.5.58-ms-ilb-nb-sm-var/kernel/sched.c	2003-01-15 15:31:35.000000000 +0100
@@ -157,6 +157,7 @@ struct runqueue {
 #ifdef CONFIG_NUMA
 	atomic_t *node_nr_running;
 	unsigned int nr_balanced;
+	int prev_node_load[MAX_NUMNODES];
 #endif
 	task_t *migration_thread;
 	struct list_head migration_queue;
@@ -188,6 +189,8 @@ static struct runqueue runqueues[NR_CPUS
 /* XXX(hch): this should go into a struct sched_node_data */
 static atomic_t node_nr_running[MAX_NUMNODES] ____cacheline_maxaligned_in_smp =
 	{[0 ...MAX_NUMNODES-1] = ATOMIC_INIT(0)};
+static int internode_lb[MAX_NUMNODES] ____cacheline_maxaligned_in_smp =
+	{[0 ...MAX_NUMNODES-1] = NODE_BALANCE_MAX};
 
 static inline void nr_running_init(struct runqueue *rq)
 {
@@ -733,22 +736,53 @@ void sched_balance_exec(void)
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
 		if (load > maxload && (100*load > NODE_THRESHOLD*this_load)) {
 			maxload = load;
 			node = i;
 		}
 	}
+	avg_load = avg_load / (numnodes ? numnodes : 1);
+	if (this_load < (avg_load / 2)) {
+		if (internode_lb[this_node] == NODE_BALANCE_MAX)
+			internode_lb[this_node] = NODE_BALANCE_MIN;
+	} else
+		if (internode_lb[this_node] == NODE_BALANCE_MIN)
+			internode_lb[this_node] = NODE_BALANCE_MAX;
+	if (this_load >= avg_load)
+  		node = -1;
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
+# define remote_steal_factor(rq) 1
 #endif /* CONFIG_NUMA */
 
 #if CONFIG_SMP
@@ -900,7 +934,7 @@ static void load_balance(runqueue_t *thi
 	/*
 	 * Avoid rebalancing between nodes too often.
 	 */
-	if (++(this_rq->nr_balanced) == NODE_BALANCE_RATE) {
+	if (++(this_rq->nr_balanced) == internode_lb[this_node]) {
 		int node = find_busiest_node(this_node);
 		this_rq->nr_balanced = 0;
 		if (node >= 0)
@@ -965,7 +999,7 @@ skip_queue:
 		goto skip_bitmap;
 	}
 	pull_task(busiest, array, tmp, this_rq, this_cpu);
-	if (!idle && --imbalance) {
+	if (!idle && ((--imbalance)/remote_steal_factor(busiest))) {
 		if (curr != head)
 			goto skip_queue;
 		idx++;

--------------Boundary-00=_VTGRG3BFV90HDCM8JTOK
Content-Type: application/x-tgz;
  name="numa-sched-patches.tgz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="numa-sched-patches.tgz"

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

--------------Boundary-00=_VTGRG3BFV90HDCM8JTOK--

