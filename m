Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262898AbVAFQcc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262898AbVAFQcc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 11:32:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262900AbVAFQcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 11:32:31 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:42751 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262898AbVAFQay
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 11:30:54 -0500
Date: Thu, 6 Jan 2005 10:27:42 -0600
From: Jake Moilanen <moilanen@austin.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE 4/4][RFC] Genetic Algorithm Library
Message-ID: <20050106102742.050d508f@localhost>
In-Reply-To: <20050106100844.53a762a0@localhost>
References: <20050106100844.53a762a0@localhost>
Organization: LTC
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The hooked zaphod CPU scheduler patch.  

It depends on the zaphod-v6 patch.  

The ranges for the tunables could be tweaked better.

Signed-off-by: Jake Moilanen <moilanen@austin.ibm.com>

---


diff -puN kernel/sched_zaphod.c~genetic-zaphod-cpu-sched kernel/sched_zaphod.c
--- linux-2.6.9/kernel/sched_zaphod.c~genetic-zaphod-cpu-sched	Wed Jan  5 15:46:00 2005
+++ linux-2.6.9-moilanen/kernel/sched_zaphod.c	Wed Jan  5 15:46:00 2005
@@ -21,15 +21,12 @@
  */
 #include <linux/sched.h>
 #include <linux/proc_fs.h>
+#include <linux/genetic.h>
+#include <linux/random.h>
 
 #include <asm/uaccess.h>
 
-enum zaphod_mode_enum {
-	ZAPHOD_MODE_PRIORITY_BASED,
-	ZAPHOD_MODE_ENTITLEMENT_BASED
-};
-
-static enum zaphod_mode_enum zaphod_mode = ZAPHOD_MODE_PRIORITY_BASED;
+enum zaphod_mode_enum zaphod_mode = ZAPHOD_MODE_PRIORITY_BASED;
 
 #ifdef CONFIG_SYSCTL
 static const char *zaphod_mode_names[] = {
@@ -720,3 +717,81 @@ int proc_zaphod_mode(ctl_table *ctp, int
 
 	return res;
 }
+
+#ifdef CONFIG_GENETIC_CPU_SCHED
+
+extern unsigned long sched_rr_time_slice;
+extern unsigned long base_prom_interval;
+static void zaphod_sched_create_child(genetic_child_t *);
+static void genetic_mutate_proportion(genetic_child_t *, unsigned long);
+void zaphod_sched_set_child_genes(void *);
+void zaphod_sched_calc_fitness(genetic_child_t *);
+
+struct genetic_ops zaphod_sched_genetic_ops = {
+	.create_child = zaphod_sched_create_child,
+	.set_child_genes = zaphod_sched_set_child_genes,
+	.calc_fitness = zaphod_sched_calc_fitness,
+	.combine_genes = genetic_generic_combine_genes,
+	.mutate_child = genetic_generic_mutate_child,
+};
+
+/* Each gene and their attributes */
+gene_param_t zaphod_sched_gene_param[ZAPHOD_SCHED_NUM_GENES] = {
+	{ MIN_TIMESLICE, MAX_TIMESLICE, DEF_TIMESLICE, 0 },		/* time_slice */
+	{ MIN_TIMESLICE, MAX_TIMESLICE, (100 * HZ / 1000), 0 },		/* sched_rr_time_slice */
+//	{ MIN_TIMESLICE, ULONG_MAX, ((DEF_TIMESLICE * 15) / 10), 0 },	/* base_prom_interval */
+	{ MIN_TIMESLICE, MAX_TIMESLICE, ((DEF_TIMESLICE * 15) / 10), 0 },	/* base_prom_interval */
+	{ 0, MAX_MAX_IA_BONUS, DEFAULT_MAX_IA_BONUS, 0 },		/* max_ia_bonus */
+	{ 0, MAX_MAX_IA_BONUS, 1, 0 },					/* initial_ia_bonus */
+	{ 1, 1000, DEFAULT_IA_THRESHOLD, 0 },  				/* ia_threshold */
+	{ 1, 1000, DEFAULT_CPU_HOG_THRESHOLD, 0 }, 			/* cpu_hog_threshold */
+	{ 0, MAX_MAX_TPT_BONUS, DEFAULT_MAX_TPT_BONUS, 0 },		/* max_tpt_bonus */
+	{ 1, 1000, DEFAULT_UNPRIV_RT_THRESHOLD, 0 }, 			/* unpriv_rt_threshold */
+	{ 1, 100, 1, 0 }, 						/* bgnd_time_slice_multiplier */
+	{ 0, 1, 0, 0 },							/* zaphod_mode */
+};
+
+void __init genetic_cpu_sched_init()
+{
+	if(genetic_init(0, &zaphod_sched_genetic_ops, ZAPHOD_SCHED_NUM_CHILDREN,
+			ZAPHOD_SCHED_CHILD_LIFESPAN, "zaphod-sched"))
+		panic("zaphod sched: failed to init genetic lib");
+}
+
+void zaphod_sched_create_child(genetic_child_t * child)
+{
+	int i;
+	static int child_num = 0;
+	unsigned long range;
+	int range_incr;
+	unsigned long * genes;
+	
+	BUG_ON(!child);
+	
+	child->genes = (void *)kmalloc(sizeof(struct zaphod_sched_genes), GFP_KERNEL);
+	if (!child->genes) 
+		panic("zaphod_sched_create_child: error kmalloc'n space");
+
+	child->gene_param = zaphod_sched_gene_param;
+
+	genes = (unsigned long *)child->genes;
+		
+	for (i = 0; i < ZAPHOD_SCHED_NUM_GENES; i++) {
+		range = child->gene_param[i].max - child->gene_param[i].min + 1;
+		range_incr = range / ZAPHOD_SCHED_NUM_CHILDREN;
+		if (range_incr)
+			genes[i] = child->gene_param[i].min +
+				(range_incr * child_num);
+		else
+			genes[i] = child->gene_param[i].min +
+				(child_num / (ZAPHOD_SCHED_NUM_CHILDREN / range));
+	}
+
+	child->num_genes = ZAPHOD_SCHED_NUM_GENES;
+	
+	child_num++;
+}
+
+core_initcall(genetic_cpu_sched_init);
+
+#endif /* CONFIG_GENETIC_CPU_SCHED */
diff -puN lib/Kconfig~genetic-zaphod-cpu-sched lib/Kconfig
--- linux-2.6.9/lib/Kconfig~genetic-zaphod-cpu-sched	Wed Jan  5 15:46:00 2005
+++ linux-2.6.9-moilanen/lib/Kconfig	Wed Jan  5 15:46:00 2005
@@ -36,6 +36,13 @@ config GENETIC_LIB
 	  This option will build in a genetic library that will tweak
 	  kernel parameters autonomically to improve performance.
 
+config GENETIC_CPU_SCHED
+	bool "Genetic Library - Zaphod CPU scheduler"
+	depends on GENETIC_LIB && EXPERIMENTAL && SCHEDSTATS
+	help
+	  This option will enable the genetic library on the zaphod
+	  CPU scheduler.
+
 #
 # compression support is select'ed if needed
 #
diff -puN kernel/sched.c~genetic-zaphod-cpu-sched kernel/sched.c
--- linux-2.6.9/kernel/sched.c~genetic-zaphod-cpu-sched	Wed Jan  5 15:46:00 2005
+++ linux-2.6.9-moilanen/kernel/sched.c	Wed Jan  5 15:46:00 2005
@@ -43,6 +43,7 @@
 #include <linux/kthread.h>
 #include <linux/seq_file.h>
 #include <linux/times.h>
+#include <linux/genetic.h>
 #include <asm/tlb.h>
 
 #include <asm/unistd.h>
@@ -71,19 +72,8 @@
 #define NS_TO_JIFFIES(TIME)	((TIME) / (1000000000 / HZ))
 #define JIFFIES_TO_NS(TIME)	((TIME) * (1000000000 / HZ))
 
-/*
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
 unsigned long time_slice = DEF_TIMESLICE;
-static unsigned long sched_rr_time_slice = (100 * HZ / 1000);
+unsigned long sched_rr_time_slice = (100 * HZ / 1000);
 
 static unsigned long task_timeslice(const task_t *p)
 {
@@ -116,6 +106,13 @@ struct prio_slot {
 	struct list_head queue;
 };
 
+static DEFINE_PER_CPU(struct runqueue, runqueues);
+
+#define cpu_rq(cpu)		(&per_cpu(runqueues, (cpu)))
+#define this_rq()		(&__get_cpu_var(runqueues))
+#define task_rq(p)		((p)->rq)
+#define cpu_curr(cpu)		(cpu_rq(cpu)->curr)
+
 /*
  * This is the main, per-CPU runqueue data structure.
  *
@@ -199,8 +196,6 @@ struct runqueue {
 #endif
 };
 
-static DEFINE_PER_CPU(struct runqueue, runqueues);
-
 /*
  * sched-domains (multiprocessor balancing) declarations:
  */
@@ -338,11 +333,6 @@ struct sched_domain {
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
@@ -1357,7 +1347,7 @@ void fastcall wake_up_new_task(task_t * 
 /**
  * (Optionally) log scheduler statistics at exit.
  */
-static int log_at_exit = 0;
+int log_at_exit = 0;
 /*
  * No more timeslice fiddling on exit
  */
@@ -4938,3 +4928,60 @@ ctl_table cpu_sched_table[] = {
 	{ .ctl_name = CPU_SCHED_END_OF_LIST }
 };
 #endif
+
+#ifdef CONFIG_GENETIC_CPU_SCHED
+
+extern enum zaphod_mode_enum zaphod_mode;
+
+void zaphod_sched_set_child_genes(void * in_genes)
+{
+	struct zaphod_sched_genes * genes = (struct zaphod_sched_genes *)in_genes;
+	int cpu;
+	runqueue_t * rq;
+
+	time_slice = genes->time_slice;
+	sched_rr_time_slice = genes->sched_rr_time_slice;
+	base_prom_interval = genes->base_prom_interval;
+	max_ia_bonus = genes->max_ia_bonus;
+	initial_ia_bonus = genes->initial_ia_bonus;
+	ia_threshold = ppt_to_proportion(genes->ia_threshold);
+	cpu_hog_threshold = ppt_to_proportion(genes->cpu_hog_threshold);
+	max_tpt_bonus = genes->max_tpt_bonus;
+	unpriv_rt_threshold = ppt_to_proportion(genes->unpriv_rt_threshold);
+	bgnd_time_slice_multiplier = genes->bgnd_time_slice_multiplier;
+	zaphod_mode = genes->zaphod_mode;
+	
+	/* Get snapshot for this child */
+	for_each_online_cpu(cpu) {
+		rq = cpu_rq(cpu);
+
+		rq->rq_sched_info.cpu_time_snapshot = rq->rq_sched_info.cpu_time;
+		rq->rq_sched_info.run_delay_snapshot = rq->rq_sched_info.run_delay;
+		rq->rq_sched_info.pcnt_snapshot = rq->rq_sched_info.pcnt;
+	}
+}
+
+void zaphod_sched_calc_fitness(genetic_child_t * child)
+{
+	int cpu;
+	runqueue_t * rq;
+	long cpu_time = 0;
+	long run_delay = 0;
+	long pcnt = 0;
+
+	/* XXX at some point make sure onlining or offlining a CPU
+	   doesn't screw us */
+	for_each_online_cpu(cpu) {
+		rq = cpu_rq(cpu);
+
+		cpu_time += rq->rq_sched_info.cpu_time - rq->rq_sched_info.cpu_time_snapshot;
+		run_delay += rq->rq_sched_info.run_delay - rq->rq_sched_info.run_delay_snapshot;
+		pcnt += rq->rq_sched_info.pcnt - rq->rq_sched_info.pcnt_snapshot;
+	}
+
+	child->fitness = cpu_time - run_delay;
+//	child->fitness = 1 - run_delay;
+}
+
+#endif
+
diff -puN include/linux/sched.h~genetic-zaphod-cpu-sched include/linux/sched.h
--- linux-2.6.9/include/linux/sched.h~genetic-zaphod-cpu-sched	Wed Jan  5 15:46:00 2005
+++ linux-2.6.9-moilanen/include/linux/sched.h	Wed Jan  5 15:46:00 2005
@@ -138,6 +138,17 @@ struct sched_param {
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
+/*
  * This serializes "schedule()" and also protects
  * the run-queue from deletions/modifications (but
  * _adding_ to the beginning of the run-queue has
@@ -392,6 +403,12 @@ struct sched_info {
 	/* timestamps */
 	unsigned long	last_arrival,	/* when we last ran on a cpu */
 			last_queued;	/* when we were last queued to run */
+
+#ifdef CONFIG_GENETIC_CPU_SCHED
+	unsigned long	cpu_time_snapshot;
+	unsigned long	run_delay_snapshot;
+	unsigned long	pcnt_snapshot;
+#endif	
 };
 
 extern struct file_operations proc_schedstat_operations;
@@ -657,6 +674,8 @@ extern int task_nice(const task_t *p);
 extern int task_curr(const task_t *p);
 extern int idle_cpu(int cpu);
 
+extern void genetic_cpu_sched_init(void);
+
 void yield(void);
 
 /*
@@ -1031,8 +1050,35 @@ static inline void arch_pick_mmap_layout
 }
 #endif
 
+enum zaphod_mode_enum {
+	ZAPHOD_MODE_PRIORITY_BASED,
+	ZAPHOD_MODE_ENTITLEMENT_BASED
+};
+
+#ifdef CONFIG_GENETIC_CPU_SCHED
 extern long sched_setaffinity(pid_t pid, cpumask_t new_mask);
 extern long sched_getaffinity(pid_t pid, cpumask_t *mask);
+
+
+#define ZAPHOD_SCHED_NUM_GENES 11
+#define ZAPHOD_SCHED_NUM_CHILDREN 8
+//#define ZAPHOD_SCHED_CHILD_LIFESPAN (9 * (HZ / 2))
+#define ZAPHOD_SCHED_CHILD_LIFESPAN (4 * HZ)
+
+struct zaphod_sched_genes {
+	unsigned long time_slice;
+	unsigned long sched_rr_time_slice;
+	unsigned long base_prom_interval;
+	unsigned long max_ia_bonus;
+	unsigned long initial_ia_bonus;
+	unsigned long ia_threshold;
+	unsigned long cpu_hog_threshold;
+	unsigned long max_tpt_bonus;
+	unsigned long unpriv_rt_threshold;
+	unsigned long bgnd_time_slice_multiplier;
+	unsigned long zaphod_mode;
+};
+#endif /* CONFIG_GENETIC_CPU_SCHED */
 
 #endif /* __KERNEL__ */
 

_
