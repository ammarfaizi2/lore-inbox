Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261872AbVBOUIV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbVBOUIV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 15:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261870AbVBOUIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 15:08:09 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:19425 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261852AbVBOUA5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 15:00:57 -0500
Date: Tue, 15 Feb 2005 13:56:33 -0600
From: Jake Moilanen <moilanen@austin.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: pwil3058@bigpond.net.au
Subject: [ANNOUNCE 4/4] Genetic-lib version 0.2
Message-Id: <20050215135633.348210ab.moilanen@austin.ibm.com>
In-Reply-To: <20050215132906.33f88505.moilanen@austin.ibm.com>
References: <20050215132906.33f88505.moilanen@austin.ibm.com>
Organization: IBM
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the patch to hook the zaphod cpu scheduler.  

Working w/ Peter Williams, we broke down the zaphod into 6 phenotypes:

Real-Time phenotype
genes: 		sched_rr_time_slice and contributes to general phenotype
fitness:	child's delta for total_rt_delay

Interactiveness phenotype
genes:		ia_threshold and contributes to general phenotype
		cpu_hog_threshold
fitness:	child's delta for total_intr_delay

Fork phenotype
genes:		initial_ia_bonus
fitness:	child's delta for total_fork_delay

Total Delay phenotype
genes:		contributes to general phenotype
fitness:	child's delta for total_delay - total_rt_delay - (total_intr_delay - total_rt_intr_delay)

Context Switch phenotype
genes: 		contributes to general phenotype
fitness:	child's delta for nr_context_switches()

General phenotype
genes:		time_slice
		max_ia_bonus
		max_tpt_bonus
		bgnd_time_slice_multiplier
		zaphod_mode
fitness:	Gives weighted points to each child depending on what their ranking was in each of the contributing phenotypes.
		(see zaphod_general_calc_post_fitness())


Signed-off-by: Jake Moilanen <moilanen@austin.ibm.com>


1/12/2004
- Reworked to use phenotypes in the genetic lib.
- Moved snapshots out of set_genes
- Added code in for snapshot call
- Added nr_context_switches as a fitness function

1/7/2004
- Made fixes suggested by Peter Williams such as:
- Fixed up zaphod table gene_param table.
- Made base_prom_interval be a ratio of time_slice.
- Fitness routine uses total_delay.


---


diff -puN include/linux/sched.h~genetic-zaphod-cpu-sched include/linux/sched.h
--- linux-2.6.10/include/linux/sched.h~genetic-zaphod-cpu-sched	Fri Jan 28 15:53:51 2005
+++ linux-2.6.10-moilanen/include/linux/sched.h	Thu Feb  3 16:00:12 2005
@@ -139,6 +139,19 @@ struct sched_param {
 #include <linux/spinlock.h>
 
 /*
+ * These are the 'tuning knobs' of the scheduler:
+ *
+ * Default configurable timeslice is 100 msecs, maximum configurable
+ * timeslice is 1000 msecs and minumum configurable timeslice is 1 jiffy.
+ * Timeslices get renewed on task creation, on wake up and after they expire.
+ */
+#define MIN_TIMESLICE		1
+#define DEF_TIMESLICE		(100 * HZ / 1000)
+#define MAX_TIMESLICE		(1000 * HZ / 1000)
+
+#define DEFAULT_UNPRIV_RT_THRESHOLD 10
+
+/*
  * This serializes "schedule()" and also protects
  * the run-queue from deletions/modifications (but
  * _adding_ to the beginning of the run-queue has
@@ -766,6 +779,8 @@ extern int task_nice(const task_t *p);
 extern int task_curr(const task_t *p);
 extern int idle_cpu(int cpu);
 
+extern void genetic_cpu_sched_init(void);
+
 void yield(void);
 
 /*
@@ -1137,8 +1152,61 @@ static inline void arch_pick_mmap_layout
 }
 #endif
 
+enum zaphod_mode_enum {
+	ZAPHOD_MODE_PRIORITY_BASED,
+	ZAPHOD_MODE_ENTITLEMENT_BASED
+};
+
+#ifdef CONFIG_GENETIC_ZAPHOD_CPU_SCHED
 extern long sched_setaffinity(pid_t pid, cpumask_t new_mask);
 extern long sched_getaffinity(pid_t pid, cpumask_t *mask);
+
+
+#define ZAPHOD_SCHED_NUM_GENES 9
+#define ZAPHOD_SCHED_NUM_CHILDREN 8
+//#define ZAPHOD_SCHED_CHILD_LIFESPAN (9 * (HZ / 2))
+#define ZAPHOD_SCHED_CHILD_LIFESPAN (4 * HZ)
+//#define ZAPHOD_SCHED_CHILD_LIFESPAN (6 * HZ)
+
+struct zaphod_rt_genes {
+	unsigned long sched_rr_time_slice;
+};
+struct zaphod_intr_genes {
+	unsigned long ia_threshold;
+	unsigned long cpu_hog_threshold;
+};
+
+struct zaphod_fork_genes {
+	unsigned long initial_ia_bonus;
+};
+
+struct zaphod_general_genes {
+	unsigned long time_slice;
+	unsigned long max_ia_bonus;
+	unsigned long max_tpt_bonus;
+	unsigned long bgnd_time_slice_multiplier;
+	unsigned long zaphod_mode;
+};
+
+struct zaphod_stats_snapshot {
+	/* from struct runq_cpustats */
+	unsigned long long total_delay;
+	unsigned long long total_rt_delay;
+	unsigned long long total_intr_delay;
+	unsigned long long total_rt_intr_delay;
+	unsigned long long total_fork_delay;
+
+	/* from struct cpu_cpustats */
+	unsigned long long nr_switches;
+
+#ifdef CONFIG_SCHEDSTATS
+	/* from sched_info */
+	unsigned long	cpu_time;
+	unsigned long	run_delay;
+#endif
+};
+
+#endif /* CONFIG_GENETIC_ZAPHOD_CPU_SCHED */
 
 #ifdef CONFIG_MAGIC_SYSRQ
 
diff -puN kernel/sched.c~genetic-zaphod-cpu-sched kernel/sched.c
--- linux-2.6.10/kernel/sched.c~genetic-zaphod-cpu-sched	Fri Jan 28 15:53:51 2005
+++ linux-2.6.10-moilanen/kernel/sched.c	Fri Jan 28 15:53:51 2005
@@ -44,6 +44,7 @@
 #include <linux/seq_file.h>
 #include <linux/syscalls.h>
 #include <linux/times.h>
+#include <linux/genetic.h>
 #include <asm/tlb.h>
 
 #include <asm/unistd.h>
@@ -58,25 +59,13 @@
 #define TASK_NICE(p)		PRIO_TO_NICE((p)->static_prio)
 
 /*
- * These are the 'tuning knobs' of the scheduler:
- *
- * Default configurable timeslice is 100 msecs, maximum configurable
- * timeslice is 1000 msecs and minumum configurable timeslice is 1 jiffy.
- * Timeslices get renewed on task creation, on wake up and after they expire.
- */
-#define MIN_TIMESLICE		1
-#define DEF_TIMESLICE		(100 * HZ / 1000)
-#define MAX_TIMESLICE		(1000 * HZ / 1000)
-
-/*
  * UNPRIV_RT tasks that have a CPU usage rate less than this threshold
  * (in parts per thousand) are treated as psuedo RT tasks
  */
-#define DEFAULT_UNPRIV_RT_THRESHOLD 10
 unsigned long unpriv_rt_threshold = PROP_FM_PPT(DEFAULT_UNPRIV_RT_THRESHOLD);
 
 unsigned long time_slice = DEF_TIMESLICE;
-static unsigned long sched_rr_time_slice = (100 * HZ / 1000);
+unsigned long sched_rr_time_slice = (100 * HZ / 1000);
 
 /*
  * Background tasks may have longer time slices as compensation
@@ -115,6 +104,11 @@ struct prio_slot {
 	struct list_head queue;
 };
 
+#define cpu_rq(cpu)		(&per_cpu(runqueues, (cpu)))
+#define this_rq()		(&__get_cpu_var(runqueues))
+#define task_rq(p)		((p)->rq)
+#define cpu_curr(cpu)		(cpu_rq(cpu)->curr)
+
 /*
  * This is the main, per-CPU runqueue data structure.
  *
@@ -210,11 +204,6 @@ static DEFINE_PER_CPU(struct runqueue, r
 #define for_each_domain(cpu, domain) \
 	for (domain = cpu_rq(cpu)->sd; domain; domain = domain->parent)
 
-#define cpu_rq(cpu)		(&per_cpu(runqueues, (cpu)))
-#define this_rq()		(&__get_cpu_var(runqueues))
-#define task_rq(p)		((p)->rq)
-#define cpu_curr(cpu)		(cpu_rq(cpu)->curr)
-
 #ifdef CONFIG_SMP
 void fastcall set_task_cpu(struct task_struct *p, unsigned int cpu)
 {
@@ -1210,7 +1199,7 @@ void fastcall wake_up_new_task(task_t * 
  * No more timeslice fiddling on exit
  * (Optionally) log scheduler statistics at exit.
  */
-static int log_at_exit = 0;
+int log_at_exit = 0;
 void fastcall sched_exit(task_t * p)
 {
 	struct task_cpustats stats;
@@ -4775,3 +4764,174 @@ ctl_table cpu_sched_table[] = {
 	{ .ctl_name = CPU_SCHED_END_OF_LIST }
 };
 #endif
+
+#ifdef CONFIG_GENETIC_ZAPHOD_CPU_SCHED
+
+extern unsigned int max_ia_bonus;
+extern unsigned long ia_threshold;
+extern unsigned long cpu_hog_threshold;
+extern unsigned int initial_ia_bonus;
+extern unsigned int max_tpt_bonus;
+extern enum zaphod_mode_enum zaphod_mode;
+
+void zaphod_rt_set_child_genes(void * in_genes)
+{
+	struct zaphod_rt_genes * genes = (struct zaphod_rt_genes *)in_genes;
+	
+	sched_rr_time_slice = genes->sched_rr_time_slice;
+}
+
+void zaphod_intr_set_child_genes(void * in_genes)
+{
+	struct zaphod_intr_genes * genes = (struct zaphod_intr_genes *)in_genes;
+	
+	ia_threshold = ppt_to_proportion(genes->ia_threshold);
+	cpu_hog_threshold = ppt_to_proportion(genes->cpu_hog_threshold);
+}
+
+void zaphod_fork_set_child_genes(void * in_genes)
+{
+	struct zaphod_fork_genes * genes = (struct zaphod_fork_genes *)in_genes;
+
+	initial_ia_bonus = genes->initial_ia_bonus;
+}
+
+void zaphod_general_set_child_genes(void * in_genes)
+{
+	struct zaphod_general_genes * genes = (struct zaphod_general_genes *)in_genes;
+	
+	time_slice = genes->time_slice;
+	base_prom_interval = ((time_slice * 15) / 10);
+	max_ia_bonus = genes->max_ia_bonus;
+	max_tpt_bonus = genes->max_tpt_bonus;
+	bgnd_time_slice_multiplier = genes->bgnd_time_slice_multiplier;
+	zaphod_mode = genes->zaphod_mode;
+	
+}
+
+/* Just have the general phenotype take the whole snapshot */
+void zaphod_general_take_snapshot(phenotype_t * pt)
+{
+	struct runq_cpustats * csrq;
+	struct zaphod_stats_snapshot * ss = (struct zaphod_stats_snapshot *)pt->child_ranking[0]->stats_snapshot;
+#ifdef CONFIG_SCHEDSTATS
+	runqueue_t * rq;
+#endif
+	int cpu;
+
+	memset(ss, 0, sizeof(struct zaphod_stats_snapshot));
+	
+	/* Get snapshot for this child */
+	for_each_online_cpu(cpu) {
+		csrq = cpu_runq_cpustats(cpu);
+
+		ss->total_delay += csrq->total_delay;
+		ss->total_rt_delay += csrq->total_rt_delay;
+		ss->total_intr_delay += csrq->total_intr_delay;
+		ss->total_rt_intr_delay += csrq->total_rt_intr_delay;
+		ss->total_fork_delay += csrq->total_fork_delay;
+
+	}
+
+#ifdef CONFIG_SCHEDSTATS
+	for_each_online_cpu(cpu) {
+		rq = cpu_rq(cpu);
+
+		ss->cpu_time += rq->rq_sched_info.cpu_time;
+		ss->run_delay += rq->rq_sched_info.run_delay;
+	}
+#endif
+
+	ss->nr_switches += nr_context_switches();
+
+
+
+}
+
+void zaphod_rt_calc_fitness(genetic_child_t * child)
+{
+
+	struct zaphod_stats_snapshot * ss = (struct zaphod_stats_snapshot *)child->stats_snapshot;
+	struct runq_cpustats *csrq;
+	long long total_rt_delay = 0;
+	int cpu;
+	
+	for_each_online_cpu(cpu) {
+		csrq = cpu_runq_cpustats(cpu);
+
+		total_rt_delay += csrq->total_rt_delay;
+	}
+	child->fitness = -(total_rt_delay - ss->total_rt_delay);
+
+}
+
+void zaphod_intr_calc_fitness(genetic_child_t * child)
+{
+	struct zaphod_stats_snapshot * ss = (struct zaphod_stats_snapshot *)child->stats_snapshot;
+	struct runq_cpustats *csrq;
+	long long total_intr_delay = 0;
+	int cpu;
+	
+	for_each_online_cpu(cpu) {
+		csrq = cpu_runq_cpustats(cpu);
+
+		total_intr_delay += csrq->total_intr_delay;
+	}
+	child->fitness = -(total_intr_delay - ss->total_intr_delay);
+
+}
+
+void zaphod_fork_calc_fitness(genetic_child_t * child)
+{
+	struct zaphod_stats_snapshot * ss = (struct zaphod_stats_snapshot *)child->stats_snapshot;
+	struct runq_cpustats *csrq;
+	long long total_fork_delay = 0;
+	int cpu;
+	
+	for_each_online_cpu(cpu) {
+		csrq = cpu_runq_cpustats(cpu);
+
+		total_fork_delay += csrq->total_fork_delay;
+	}
+	child->fitness = -(total_fork_delay - ss->total_fork_delay);
+
+}
+
+void zaphod_total_delay_calc_fitness(genetic_child_t * child)
+{
+	struct zaphod_stats_snapshot * ss = (struct zaphod_stats_snapshot *)child->stats_snapshot;
+	struct runq_cpustats *csrq;
+	long long total_delay = 0;
+	long long total_rt_delay = 0;
+	long long total_intr_delay = 0;
+	long long total_rt_intr_delay = 0;
+	int cpu;
+	
+	for_each_online_cpu(cpu) {
+		csrq = cpu_runq_cpustats(cpu);
+
+		total_delay += csrq->total_delay;
+		total_intr_delay += csrq->total_intr_delay;
+		total_rt_delay += csrq->total_rt_delay;
+		total_rt_intr_delay += csrq->total_rt_intr_delay;
+	}
+
+	/* get delta */
+	total_delay -= ss->total_delay;
+	total_rt_delay -= ss->total_rt_delay;
+	total_intr_delay -= ss->total_intr_delay;
+	total_rt_intr_delay -= ss->total_rt_intr_delay;
+
+	child->fitness = -(total_delay - total_rt_delay - (total_intr_delay - total_rt_intr_delay));
+
+}
+
+void zaphod_context_switches_calc_fitness(genetic_child_t * child)
+{
+	struct zaphod_stats_snapshot * ss = (struct zaphod_stats_snapshot *)child->stats_snapshot;
+
+	child->fitness = -(nr_context_switches() - ss->nr_switches);
+}
+
+#endif /* CONFIG_GENETIC_ZAPHOD_CPU_SCHED */
+
diff -puN kernel/sched_zaphod.c~genetic-zaphod-cpu-sched kernel/sched_zaphod.c
--- linux-2.6.10/kernel/sched_zaphod.c~genetic-zaphod-cpu-sched	Fri Jan 28 15:53:51 2005
+++ linux-2.6.10-moilanen/kernel/sched_zaphod.c	Thu Feb  3 09:02:43 2005
@@ -21,9 +21,13 @@
  */
 #include <linux/sched.h>
 #include <linux/proc_fs.h>
+#include <linux/genetic.h>
+#include <linux/random.h>
 
 #include <asm/uaccess.h>
 
+enum zaphod_mode_enum zaphod_mode = ZAPHOD_MODE_PRIORITY_BASED;
+
 #ifdef CONFIG_CPUSCHED_ZAPHOD
 #define MAX_PRIO ZAPHOD_MAX_PRIO
 #define MIN_NORMAL_PRIO ZAPHOD_MIN_NORMAL_PRIO
@@ -42,13 +46,6 @@
 
 #define EB_YARDSTICK_DECAY_INTERVAL 100
 
-enum zaphod_mode_enum {
-	ZAPHOD_MODE_PRIORITY_BASED,
-	ZAPHOD_MODE_ENTITLEMENT_BASED
-};
-
-static enum zaphod_mode_enum zaphod_mode = ZAPHOD_MODE_PRIORITY_BASED;
-
 #ifdef CONFIG_SYSCTL
 static const char *zaphod_mode_names[] = {
 	"pb",		/* ZAPHOD_MODE_PRIORITY_BASED */
@@ -446,6 +443,353 @@ void zaphod_reassess_at_renice(struct ta
 		calculate_pre_bonus_priority(p);
 }
 
+#ifdef CONFIG_GENETIC_ZAPHOD_CPU_SCHED
+
+extern unsigned long sched_rr_time_slice;
+extern unsigned long base_prom_interval;
+static void zaphod_rt_create_child(genetic_child_t *);
+static void zaphod_intr_create_child(genetic_child_t *);
+static void zaphod_fork_create_child(genetic_child_t *);
+static void zaphod_total_delay_create_child(genetic_child_t *);
+static void zaphod_context_switches_create_child(genetic_child_t *);
+static void zaphod_general_create_child(genetic_child_t *);
+static void zaphod_shift_mutation_rate(phenotype_t * in_pt);
+
+void zaphod_rt_set_child_genes(void *);
+void zaphod_intr_set_child_genes(void *);
+void zaphod_fork_set_child_genes(void *);
+void zaphod_general_set_child_genes(void *);
+
+void zaphod_rt_calc_fitness(genetic_child_t *);
+void zaphod_intr_calc_fitness(genetic_child_t *);
+void zaphod_fork_calc_fitness(genetic_child_t *);
+void zaphod_total_delay_calc_fitness(genetic_child_t *);
+void zaphod_context_switches_calc_fitness(genetic_child_t *);
+ 
+void zaphod_general_calc_post_fitness(phenotype_t *);
+
+void zaphod_general_take_snapshot(phenotype_t *);
+
+/* For real-time tasks */
+struct genetic_ops zaphod_rt_genetic_ops = {
+ 	.create_child = zaphod_rt_create_child,
+ 	.set_child_genes = zaphod_rt_set_child_genes,
+ 	.calc_fitness = zaphod_rt_calc_fitness,
+	.combine_genes = genetic_generic_combine_genes,
+ 	.mutate_child = genetic_generic_mutate_child,
+};
+
+/* For interactivity */
+struct genetic_ops zaphod_intr_genetic_ops = {
+ 	.create_child = zaphod_intr_create_child,
+ 	.set_child_genes = zaphod_intr_set_child_genes,
+ 	.calc_fitness = zaphod_intr_calc_fitness,
+	.combine_genes = genetic_generic_combine_genes,
+ 	.mutate_child = genetic_generic_mutate_child,
+};
+
+/* For new processes */
+struct genetic_ops zaphod_fork_genetic_ops = {
+ 	.create_child = zaphod_fork_create_child,
+ 	.set_child_genes = zaphod_fork_set_child_genes,
+ 	.calc_fitness = zaphod_fork_calc_fitness,
+	.combine_genes = genetic_generic_combine_genes,
+ 	.mutate_child = genetic_generic_mutate_child,
+};
+
+/* For total delay */
+struct genetic_ops zaphod_total_delay_genetic_ops = {
+ 	.create_child = zaphod_total_delay_create_child,
+ 	.calc_fitness = zaphod_total_delay_calc_fitness,
+};
+
+/* For context switches */
+struct genetic_ops zaphod_context_switches_genetic_ops = {
+ 	.create_child = zaphod_context_switches_create_child,
+ 	.calc_fitness = zaphod_context_switches_calc_fitness,
+};
+
+/* For general genes */
+struct genetic_ops zaphod_general_genetic_ops = {
+ 	.create_child = zaphod_general_create_child,
+ 	.set_child_genes = zaphod_general_set_child_genes,
+	.combine_genes = genetic_generic_combine_genes,
+ 	.mutate_child = genetic_generic_mutate_child,
+	.calc_post_fitness = zaphod_general_calc_post_fitness,
+	.take_snapshot = zaphod_general_take_snapshot,
+	.shift_mutation_rate = zaphod_shift_mutation_rate
+};
+
+#define ZAPHOD_RT_UID 1
+#define ZAPHOD_RT_NUM_GENES 1
+gene_param_t zaphod_rt_gene_param[ZAPHOD_RT_NUM_GENES] = {
+ 	{ MIN_TIMESLICE, MAX_TIMESLICE, (100 * HZ / 1000), 0 },		/* sched_rr_time_slice */
+};
+
+#define ZAPHOD_INTR_UID 2
+#define ZAPHOD_INTR_NUM_GENES 2
+#if 1
+gene_param_t zaphod_intr_gene_param[ZAPHOD_INTR_NUM_GENES] = {
+ 	{ 0, 1000, DEFAULT_IA_THRESHOLD, genetic_generic_iterative_mutate_gene },  			/* ia_threshold */
+	{ 0, 1000, DEFAULT_CPU_HOG_THRESHOLD, genetic_generic_iterative_mutate_gene }, 			/* cpu_hog_threshold */
+};
+#else
+gene_param_t zaphod_intr_gene_param[ZAPHOD_INTR_NUM_GENES] = {
+ 	{ 0, 1000, DEFAULT_IA_THRESHOLD, 0 },  				/* ia_threshold */
+	{ 0, 1000, DEFAULT_CPU_HOG_THRESHOLD, 0 }, 			/* cpu_hog_threshold */
+};
+#endif
+
+#define ZAPHOD_FORK_UID 4
+#define ZAPHOD_FORK_NUM_GENES 1
+gene_param_t zaphod_fork_gene_param[ZAPHOD_FORK_NUM_GENES] = {
+ 	{ 0, MAX_MAX_IA_BONUS, 1, 0 },					/* initial_ia_bonus */
+};
+
+#define ZAPHOD_TOTAL_DELAY_UID 8
+#define ZAPHOD_TOTAL_DELAY_NUM_GENES 0
+
+#define ZAPHOD_CONTEXT_SWITCHES_UID 16
+#define ZAPHOD_CONTEXT_SWITCHES_NUM_GENES 0
+
+#define ZAPHOD_GENERAL_UID (ZAPHOD_CONTEXT_SWITCHES_UID | ZAPHOD_TOTAL_DELAY_UID | ZAPHOD_INTR_UID | ZAPHOD_RT_UID)
+#define ZAPHOD_GENERAL_NUM_GENES 5
+#if 0
+gene_param_t zaphod_general_gene_param[ZAPHOD_GENERAL_NUM_GENES] = {
+ 	{ MIN_TIMESLICE, MAX_TIMESLICE, DEF_TIMESLICE, genetic_generic_iterative_mutate_gene },	/* time_slice */
+ 	{ 0, MAX_MAX_IA_BONUS, DEFAULT_MAX_IA_BONUS, 0 },		/* max_ia_bonus */
+ 	{ 0, MAX_MAX_TPT_BONUS, DEFAULT_MAX_TPT_BONUS, 0 },		/* max_tpt_bonus */
+	{ 1, 100, 1, genetic_generic_iterative_mutate_gene }, 		/* bgnd_time_slice_multiplier */
+	{ 0, 1, 0, 0 },							/* zaphod_mode */
+};
+#else
+gene_param_t zaphod_general_gene_param[ZAPHOD_GENERAL_NUM_GENES] = {
+ 	{ MIN_TIMESLICE, MAX_TIMESLICE, DEF_TIMESLICE, 0 },		/* time_slice */
+ 	{ 0, MAX_MAX_IA_BONUS, DEFAULT_MAX_IA_BONUS, 0 },		/* max_ia_bonus */
+ 	{ 0, MAX_MAX_TPT_BONUS, DEFAULT_MAX_TPT_BONUS, 0 },		/* max_tpt_bonus */
+	{ 1, 100, 1, genetic_generic_iterative_mutate_gene },		/* bgnd_time_slice_multiplier */
+	{ 0, 1, 0, 0 },							/* zaphod_mode */
+};
+#endif
+
+struct zaphod_stats_snapshot * zaphod_stats_snapshot;
+
+static int __init genetic_zaphod_sched_init(void)
+{
+	genetic_t * genetic = 0;
+	
+	zaphod_stats_snapshot = (struct zaphod_stats_snapshot *)kmalloc(sizeof(struct zaphod_stats_snapshot), GFP_KERNEL);
+	if (!zaphod_stats_snapshot)
+		panic("zaphod sched: failed to malloc enough space");
+
+	if(genetic_init(&genetic, ZAPHOD_SCHED_NUM_CHILDREN, ZAPHOD_SCHED_CHILD_LIFESPAN,
+			"zaphod-sched"))
+		panic("zaphod sched: failed to init genetic lib");
+
+	if(genetic_register_phenotype(genetic, &zaphod_rt_genetic_ops, ZAPHOD_SCHED_NUM_CHILDREN,
+				      "real-time-tasks", ZAPHOD_RT_NUM_GENES, ZAPHOD_RT_UID))
+		panic("zaphod sched: failed to register real-time tasks phenotype");		
+
+	if(genetic_register_phenotype(genetic, &zaphod_intr_genetic_ops, ZAPHOD_SCHED_NUM_CHILDREN,
+				      "interactiveness", ZAPHOD_INTR_NUM_GENES, ZAPHOD_INTR_UID))
+		panic("zaphod sched: failed to register interactiveness phenotype");
+	
+	if(genetic_register_phenotype(genetic, &zaphod_fork_genetic_ops, ZAPHOD_SCHED_NUM_CHILDREN,
+				      "initial-interactiveness", ZAPHOD_FORK_NUM_GENES, ZAPHOD_FORK_UID))
+		panic("zaphod sched: failed to register initial-interactiveness phenotype");
+	
+	if(genetic_register_phenotype(genetic, &zaphod_total_delay_genetic_ops, ZAPHOD_SCHED_NUM_CHILDREN,
+				      "total-delay", ZAPHOD_TOTAL_DELAY_NUM_GENES, ZAPHOD_TOTAL_DELAY_UID))
+		panic("zaphod sched: failed to register total-delay phenotype");
+	
+	if(genetic_register_phenotype(genetic, &zaphod_context_switches_genetic_ops, ZAPHOD_SCHED_NUM_CHILDREN,
+				      "context-switches", ZAPHOD_CONTEXT_SWITCHES_NUM_GENES, ZAPHOD_CONTEXT_SWITCHES_UID))
+		panic("zaphod sched: failed to register context-switches phenotype");
+
+	if(genetic_register_phenotype(genetic, &zaphod_general_genetic_ops, ZAPHOD_SCHED_NUM_CHILDREN,
+				      "general", ZAPHOD_GENERAL_NUM_GENES, ZAPHOD_GENERAL_UID))
+		panic("zaphod sched: failed to register general phenotype");
+	
+	genetic_start(genetic);
+
+	return 0;
+}
+
+void zaphod_rt_create_child(genetic_child_t * child)
+{
+	BUG_ON(!child);
+	
+	child->genes = (void *)kmalloc(sizeof(struct zaphod_rt_genes), GFP_KERNEL);
+	if (!child->genes) 
+		panic("zaphod_rt_create_child: error kmalloc'n space");
+
+	child->gene_param = zaphod_rt_gene_param;
+	child->num_genes = ZAPHOD_RT_NUM_GENES;
+	child->stats_snapshot = zaphod_stats_snapshot;
+	
+//	genetic_create_child_spread(child, ZAPHOD_SCHED_NUM_CHILDREN);
+	genetic_create_child_defaults(child);
+
+}
+
+void zaphod_intr_create_child(genetic_child_t * child)
+{
+	BUG_ON(!child);
+
+	child->genes = (void *)kmalloc(sizeof(struct zaphod_intr_genes), GFP_KERNEL);
+	if (!child->genes) 
+		panic("zaphod_intr_create_child: error kmalloc'n space");
+
+	child->gene_param = zaphod_intr_gene_param;
+	child->num_genes = ZAPHOD_INTR_NUM_GENES;
+	child->stats_snapshot = zaphod_stats_snapshot;
+
+//	genetic_create_child_spread(child, ZAPHOD_SCHED_NUM_CHILDREN);
+	genetic_create_child_defaults(child);
+}
+
+void zaphod_fork_create_child(genetic_child_t * child)
+{
+	BUG_ON(!child);
+
+	child->genes = (void *)kmalloc(sizeof(struct zaphod_fork_genes), GFP_KERNEL);
+	if (!child->genes) 
+		panic("zaphod_fork_create_child: error kmalloc'n space");
+
+	child->gene_param = zaphod_fork_gene_param;
+	child->num_genes = ZAPHOD_FORK_NUM_GENES;
+	child->stats_snapshot = zaphod_stats_snapshot;
+	
+//	genetic_create_child_spread(child, ZAPHOD_SCHED_NUM_CHILDREN);
+	genetic_create_child_defaults(child);
+}
+
+void zaphod_total_delay_create_child(genetic_child_t * child)
+{
+	BUG_ON(!child);
+
+	child->genes = 0;
+	child->gene_param = 0;
+	child->num_genes = 0;
+	child->stats_snapshot = zaphod_stats_snapshot;
+}
+
+void zaphod_context_switches_create_child(genetic_child_t * child)
+{
+	BUG_ON(!child);
+
+	child->genes = 0;
+	child->gene_param = 0;
+	child->num_genes = 0;
+	child->stats_snapshot = zaphod_stats_snapshot;
+}
+
+void zaphod_general_create_child(genetic_child_t * child)
+{
+	BUG_ON(!child);
+
+	child->genes = (void *)kmalloc(sizeof(struct zaphod_general_genes), GFP_KERNEL);
+	if (!child->genes) 
+		panic("zaphod_general_create_child: error kmalloc'n space");
+
+	child->gene_param = zaphod_general_gene_param;
+	child->num_genes = ZAPHOD_GENERAL_NUM_GENES;
+	child->stats_snapshot = zaphod_stats_snapshot;
+
+	genetic_create_child_spread(child, ZAPHOD_SCHED_NUM_CHILDREN);
+//	genetic_create_child_defaults(child);
+}
+
+
+static void zaphod_shift_mutation_rate(phenotype_t * in_pt)
+{
+	struct list_head * p;
+	phenotype_t * pt;
+	int count = 0;
+	long rate = 0;
+
+	list_for_each(p, &in_pt->genetic->phenotype) {
+		pt = list_entry(p, phenotype_t, phenotype);
+
+		/* Look at everyone else that contributes to this
+		   phenotype */
+		if (pt->uid & ZAPHOD_GENERAL_UID && pt->uid != ZAPHOD_GENERAL_UID) {
+
+			switch (pt->uid) {
+			case ZAPHOD_RT_UID:
+				break;
+			case ZAPHOD_CONTEXT_SWITCHES_UID:
+				break;
+			case ZAPHOD_INTR_UID:
+			case ZAPHOD_TOTAL_DELAY_UID:
+				rate += pt->mutation_rate;
+				count++;
+				break;
+			default:
+				BUG();
+			}
+		}
+	}
+	
+	/* If we are a general phenotype that is made up of other
+	   phenotypes then we take the average */
+	if (count)
+		in_pt->mutation_rate = (rate / count);
+	else 
+		BUG();
+}
+
+
+/* Make the general the one that takes into account all the fitness
+ * routines, since these are the common genes that effect everything.
+ */
+void zaphod_general_calc_post_fitness(phenotype_t * in_pt)
+{
+	struct list_head * p;
+	phenotype_t * pt;
+	genetic_t * genetic = in_pt->genetic;
+	int ranking[ZAPHOD_SCHED_NUM_CHILDREN];
+	int weight = 1;
+	int i;
+
+	memset(ranking, 0, sizeof(ranking));
+
+	list_for_each(p, &genetic->phenotype) {
+		pt = list_entry(p, phenotype_t, phenotype);
+
+		/* Look at everyone else that contributes to this
+		   phenotype */
+		if (pt->uid & ZAPHOD_GENERAL_UID && pt->uid != ZAPHOD_GENERAL_UID) {
+
+			switch (pt->uid) {
+			case ZAPHOD_RT_UID:
+			case ZAPHOD_CONTEXT_SWITCHES_UID:
+				weight = 1;
+				break;
+			case ZAPHOD_INTR_UID:
+				weight = 2;
+				break;
+			case ZAPHOD_TOTAL_DELAY_UID:
+				weight = 3;
+				break;
+			default:
+				BUG();
+			}
+
+			for (i = 0; i < pt->num_children; i++) 
+				ranking[pt->child_ranking[i]->id] += (i * weight);
+		}
+	}
+
+	for (i = 0; i < in_pt->num_children; i++)
+		in_pt->child_ranking[i]->fitness = ranking[i];
+	
+}
+
+core_initcall(genetic_zaphod_sched_init);
+
+#endif /* CONFIG_GENETIC_ZAPHOD_CPU_SCHED */
+
 #if defined(CONFIG_SYSCTL)
 static const unsigned int zero = 0;
 
@@ -455,6 +799,8 @@ int proc_zaphod_mode(ctl_table *ctp, int
     void __user *buffer, size_t *lenp, loff_t *ppos)
 {
 	int res;
+
+	BUG_ON(zaphod_mode >= 2);
 
 	strcpy(current_zaphod_mode, zaphod_mode_names[zaphod_mode]);
 	res = proc_dostring(ctp, write, fp, buffer, lenp, ppos);
diff -puN lib/Kconfig~genetic-zaphod-cpu-sched lib/Kconfig
--- linux-2.6.10/lib/Kconfig~genetic-zaphod-cpu-sched	Fri Jan 28 15:53:51 2005
+++ linux-2.6.10-moilanen/lib/Kconfig	Fri Jan 28 15:53:51 2005
@@ -36,6 +36,13 @@ config GENETIC_LIB
 	  This option will build in a genetic library that will tweak
 	  kernel parameters autonomically to improve performance.
 
+config GENETIC_ZAPHOD_CPU_SCHED
+	bool "Genetic Library - Zaphod CPU scheduler"
+	depends on GENETIC_LIB && EXPERIMENTAL
+	help
+	  This option will enable the genetic library on the zaphod
+	  CPU scheduler.
+
 #
 # compression support is select'ed if needed
 #
diff -puN include/linux/sched_cpustats.h~genetic-zaphod-cpu-sched include/linux/sched_cpustats.h

_
