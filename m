Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267624AbTAMPSO>; Mon, 13 Jan 2003 10:18:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267633AbTAMPSO>; Mon, 13 Jan 2003 10:18:14 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:42770 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267624AbTAMPSF>; Mon, 13 Jan 2003 10:18:05 -0500
Date: Mon, 13 Jan 2003 15:26:42 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Erich Focht <efocht@ess.nec.de>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>, Robert Love <rml@tech9.net>,
       Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] Re: NUMA scheduler 2nd approach
Message-ID: <20030113152642.A21994@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Erich Focht <efocht@ess.nec.de>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Michael Hohnbaum <hohnbaum@us.ibm.com>, Robert Love <rml@tech9.net>,
	Ingo Molnar <mingo@elte.hu>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	lse-tech <lse-tech@lists.sourceforge.net>
References: <52570000.1042156448@flay> <200301130055.28005.efocht@ess.nec.de> <20030113080207.A9119@infradead.org> <200301131232.40600.efocht@ess.nec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200301131232.40600.efocht@ess.nec.de>; from efocht@ess.nec.de on Mon, Jan 13, 2003 at 12:32:40PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anyone interested in this cleaned up minimal numa scheduler?  This
is basically Erich's patches 1-3 with my suggestions applied.

This does not mean I don't like 4 & 5, but I'd rather get a small,
non-intrusive patch into Linus' tree now and do the fine-tuning later.


--- 1.62/fs/exec.c	Fri Jan 10 08:21:00 2003
+++ edited/fs/exec.c	Mon Jan 13 15:33:32 2003
@@ -1031,6 +1031,8 @@
 	int retval;
 	int i;
 
+	sched_balance_exec();
+
 	file = open_exec(filename);
 
 	retval = PTR_ERR(file);
--- 1.119/include/linux/sched.h	Sat Jan 11 07:44:15 2003
+++ edited/include/linux/sched.h	Mon Jan 13 15:58:11 2003
@@ -444,6 +444,14 @@
 # define set_cpus_allowed(p, new_mask) do { } while (0)
 #endif
 
+#ifdef CONFIG_NUMA
+extern void sched_balance_exec(void);
+extern void node_nr_running_init(void);
+#else
+# define sched_balance_exec()	do { } while (0)
+# define node_nr_running_init()	do { } while (0)
+#endif
+
 extern void set_user_nice(task_t *p, long nice);
 extern int task_prio(task_t *p);
 extern int task_nice(task_t *p);
--- 1.91/init/main.c	Mon Jan  6 04:08:49 2003
+++ edited/init/main.c	Mon Jan 13 15:33:33 2003
@@ -495,6 +495,7 @@
 
 	migration_init();
 #endif
+	node_nr_running_init();
 	spawn_ksoftirqd();
 }
 
--- 1.148/kernel/sched.c	Sat Jan 11 07:44:22 2003
+++ edited/kernel/sched.c	Mon Jan 13 16:17:34 2003
@@ -67,6 +67,7 @@
 #define INTERACTIVE_DELTA	2
 #define MAX_SLEEP_AVG		(2*HZ)
 #define STARVATION_LIMIT	(2*HZ)
+#define NODE_BALANCE_RATIO	10
 
 /*
  * If a task is 'interactive' then we reinsert it in the active
@@ -154,6 +155,11 @@
 	prio_array_t *active, *expired, arrays[2];
 	int prev_nr_running[NR_CPUS];
 
+#ifdef CONFIG_NUMA
+	atomic_t *node_nr_running;
+	int nr_balanced;
+#endif
+
 	task_t *migration_thread;
 	struct list_head migration_queue;
 
@@ -178,6 +184,38 @@
 #endif
 
 /*
+ * Keep track of running tasks.
+ */
+#if CONFIG_NUMA
+
+/* XXX(hch): this should go into a struct sched_node_data */
+static atomic_t node_nr_running[MAX_NUMNODES] ____cacheline_maxaligned_in_smp =
+	{[0 ...MAX_NUMNODES-1] = ATOMIC_INIT(0)};
+
+static inline void nr_running_init(struct runqueue *rq)
+{
+	rq->node_nr_running = &node_nr_running[0];
+}
+
+static inline void nr_running_inc(struct runqueue *rq)
+{
+	atomic_inc(rq->node_nr_running);
+	rq->nr_running++;
+}
+
+static inline void nr_running_dec(struct runqueue *rq)
+{
+	atomic_dec(rq->node_nr_running);
+	rq->nr_running--;
+}
+
+#else
+# define nr_running_init(rq)	do { } while (0)
+# define nr_running_inc(rq)	do { (rq)->nr_running++; } while (0)
+# define nr_running_dec(rq)	do { (rq)->nr_running--; } while (0)
+#endif /* CONFIG_NUMA */
+
+/*
  * task_rq_lock - lock the runqueue a given task resides on and disable
  * interrupts.  Note the ordering: we can safely lookup the task_rq without
  * explicitly disabling preemption.
@@ -294,7 +332,7 @@
 		p->prio = effective_prio(p);
 	}
 	enqueue_task(p, array);
-	rq->nr_running++;
+	nr_running_inc(rq);
 }
 
 /*
@@ -302,7 +340,7 @@
  */
 static inline void deactivate_task(struct task_struct *p, runqueue_t *rq)
 {
-	rq->nr_running--;
+	nr_running_dec(rq);
 	if (p->state == TASK_UNINTERRUPTIBLE)
 		rq->nr_uninterruptible++;
 	dequeue_task(p, p->array);
@@ -624,9 +662,108 @@
 		spin_unlock(&rq2->lock);
 }
 
-#if CONFIG_SMP
+#if CONFIG_NUMA
+/*
+ * If dest_cpu is allowed for this process, migrate the task to it.
+ * This is accomplished by forcing the cpu_allowed mask to only
+ * allow dest_cpu, which will force the cpu onto dest_cpu.  Then
+ * the cpu_allowed mask is restored.
+ *
+ * Note:  This isn't actually numa-specific, but just not used otherwise.
+ */
+static void sched_migrate_task(task_t *p, int dest_cpu)
+{
+	unsigned long old_mask = p->cpus_allowed;
+
+	if (old_mask & (1UL << dest_cpu)) {
+		unsigned long flags;
+		struct runqueue *rq;
+
+		/* force the process onto the specified CPU */
+		set_cpus_allowed(p, 1UL << dest_cpu);
+
+		/* restore the cpus allowed mask */
+		rq = task_rq_lock(p, &flags);
+		p->cpus_allowed = old_mask;
+		task_rq_unlock(rq, &flags);
+	}
+}
 
 /*
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
+
+	return node;
+}
+
+__init void node_nr_running_init(void)
+{
+	int i;
+
+	for (i = 0; i < NR_CPUS; i++)
+		cpu_rq(i)->node_nr_running = node_nr_running + __cpu_to_node(i);
+}
+#endif /* CONFIG_NUMA */
+
+#if CONFIG_SMP
+/*
  * double_lock_balance - lock the busiest runqueue
  *
  * this_rq is locked already. Recalculate nr_running if we have to
@@ -652,9 +789,10 @@
 }
 
 /*
- * find_busiest_queue - find the busiest runqueue.
+ * find_busiest_queue - find the busiest runqueue among the cpus in cpumask
  */
-static inline runqueue_t *find_busiest_queue(runqueue_t *this_rq, int this_cpu, int idle, int *imbalance)
+static inline runqueue_t *find_busiest_queue(runqueue_t *this_rq, int this_cpu,
+		int idle, int *imbalance, unsigned long cpumask)
 {
 	int nr_running, load, max_load, i;
 	runqueue_t *busiest, *rq_src;
@@ -689,7 +827,7 @@
 	busiest = NULL;
 	max_load = 1;
 	for (i = 0; i < NR_CPUS; i++) {
-		if (!cpu_online(i))
+		if (!cpu_online(i) || !((1UL << i) & cpumask))
 			continue;
 
 		rq_src = cpu_rq(i);
@@ -736,9 +874,9 @@
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
@@ -758,13 +896,27 @@
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
+	if (!(++this_rq->nr_balanced % NODE_BALANCE_RATIO))
+		cpumask |= __node_to_cpu_mask(find_busiest_node(this_node));
+#endif
+
+	busiest = find_busiest_queue(this_rq, this_cpu, idle,
+			&imbalance, cpumask);
 	if (!busiest)
 		goto out;
 
@@ -2231,6 +2383,7 @@
 		spin_lock_init(&rq->lock);
 		INIT_LIST_HEAD(&rq->migration_queue);
 		atomic_set(&rq->nr_iowait, 0);
+		nr_running_init(rq);
 
 		for (j = 0; j < 2; j++) {
 			array = rq->arrays + j;
