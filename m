Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268899AbUIHHMm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268899AbUIHHMm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 03:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268907AbUIHHMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 03:12:42 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:19344 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S268899AbUIHHKH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 03:10:07 -0400
Message-Id: <200409080709.i88790J27770@owlet.beaverton.ibm.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
cc: linux-kernel@vger.kernel.org
Subject: Re: schedstat-2.6.8.1 [was: Re: 2.6.9-rc1-mm1] 
In-reply-to: Your message of "Fri, 03 Sep 2004 23:11:27 +0200."
             <200409032311.27908.rjw@sisk.pl> 
Date: Wed, 08 Sep 2004 00:09:00 -0700
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:

    A schedstats patch for 2.6.8.1 is available at
    http://eaglet.rain.com/rick/linux/schedstat/patches/schedstat-2.6.8.1
    or
    http://oss.software.ibm.com/linux/patches/?patch_id=3D730

Rafael replied:
    
    It does not compile for me on a UP system:

Mea culpa.  This was fixed once but didn't propogate into my last patch.
Please try this patch instead.

diff -rupN linux-2.6.8.1/Documentation/sched-stats.txt linux-2.6.8.1-ss/Documentation/sched-stats.txt
--- linux-2.6.8.1/Documentation/sched-stats.txt	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.8.1-ss/Documentation/sched-stats.txt	2004-09-07 22:30:10.000000000 -0700
@@ -0,0 +1,150 @@
+Version 9 of schedstats introduces support for sched_domains, which
+hit the mainline kernel in 2.6.7.  Some counters make more sense to be
+per-runqueue; other to be per-domain.
+
+In version 9 of schedstat, there is at least one level of domain
+statistics for each cpu listed, and there may well be more than one
+domain.  Domains have no particular names in this implementation, but
+the highest numbered one typically arbitrates balancing across all the
+cpus on the machine, while domain0 is the most tightly focused domain,
+sometimes balancing only between pairs of cpus.  At this time, there
+are no architectures which need more than three domain levels. The first
+field in the domain stats is a bit map indicating which cpus are affected
+by that domain.
+
+These fields are counters, and only increment.  Programs which make use
+of these will need to start with a baseline observation and then calculate
+the change in the counters at each subsequent observation.  A perl script
+which does this for many of the fields is available at
+
+    http://eaglet.rain.com/rick/linux/schedstat/
+
+Note that any such script will necessarily be version-specific, as the main
+reason to change versions is changes in the output format.  For those wishing
+to write their own scripts, the fields are described here.
+
+CPU statistics
+--------------
+cpu<N> 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28
+
+NOTE: In the sched_yield() statistics, the active queue is considered empty
+    if it has only one process in it, since obviously the process calling
+    sched_yield() is that process.
+
+First four fields are sched_yield() statistics:
+     1) # of times both the active and the expired queue were empty
+     2) # of times just the active queue was empty
+     3) # of times just the expired queue was empty
+     4) # of times sched_yield() was called
+
+Next four are schedule() statistics:
+     5) # of times the active queue had at least one other process on it.
+     6) # of times we switched to the expired queue and reused it
+     7) # of times schedule() was called
+     8) # of times schedule() left the processor idle
+
+Next four are active_load_balance() statistics:
+     9) # of times active_load_balance() was called
+    10) # of times active_load_balance() caused this cpu to gain a task
+    11) # of times active_load_balance() caused this cpu to lose a task
+    12) # of times active_load_balance() tried to move a task and failed
+
+Next three are try_to_wake_up() statistics:
+    13) # of times try_to_wake_up() was called
+    14) # of times try_to_wake_up() successfully moved the awakening task
+    15) # of times try_to_wake_up() attempted to move the awakening task
+
+Next two are wake_up_forked_thread() statistics:
+    16) # of times wake_up_forked_thread() was called
+    17) # of times wake_up_forked_thread() successfully moved the forked task
+
+Next one is a sched_migrate_task() statistic:
+    18) # of times sched_migrate_task() was called
+
+Next one is a sched_balance_exec() statistic:
+    19) # of times sched_balance_exec() was called
+
+Next three are statistics describing scheduling latency:
+    20) sum of all time spent running by tasks on this processor (in ms)
+    21) sum of all time spent waiting to run by tasks on this processor (in ms)
+    22) # of tasks (not necessarily unique) given to the processor
+
+The last six are statistics dealing with pull_task():
+    23) # of times pull_task() moved a task to this cpu when newly idle
+    24) # of times pull_task() stole a task from this cpu when another cpu
+	was newly idle
+    25) # of times pull_task() moved a task to this cpu when idle
+    26) # of times pull_task() stole a task from this cpu when another cpu
+	was idle
+    27) # of times pull_task() moved a task to this cpu when busy
+    28) # of times pull_task() stole a task from this cpu when another cpu
+	was busy
+
+
+Domain statistics
+-----------------
+One of these is produced per domain for each cpu described.
+
+domain<N> 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
+
+The first field is a bit mask indicating what cpus this domain operates over.
+
+The next fifteen are a variety of load_balance() statistics:
+
+     1) # of times in this domain load_balance() was called when the cpu
+	was idle
+     2) # of times in this domain load_balance() was called when the cpu
+	was busy
+     3) # of times in this domain load_balance() was called when the cpu
+	was just becoming idle
+     4) # of times in this domain load_balance() tried to move one or more
+	tasks and failed, when the cpu was idle
+     5) # of times in this domain load_balance() tried to move one or more
+	tasks and failed, when the cpu was busy
+     6) # of times in this domain load_balance() tried to move one or more
+	tasks and failed, when the cpu was just becoming idle
+     7) sum of imbalances discovered (if any) with each call to
+	load_balance() in this domain when the cpu was idle
+     8) sum of imbalances discovered (if any) with each call to
+	load_balance() in this domain when the cpu was busy
+     9) sum of imbalances discovered (if any) with each call to
+	load_balance() in this domain when the cpu was just becoming idle
+    10) # of times in this domain load_balance() was called but did not find
+	a busier queue while the cpu was idle
+    11) # of times in this domain load_balance() was called but did not find
+	a busier queue while the cpu was busy
+    12) # of times in this domain load_balance() was called but did not find
+	a busier queue while the cpu was just becoming idle
+    13) # of times in this domain a busier queue was found while the cpu was
+	idle but no busier group was found
+    14) # of times in this domain a busier queue was found while the cpu was
+	busy but no busier group was found
+    15) # of times in this domain a busier queue was found while the cpu was
+	just becoming idle but no busier group was found
+
+Next two are sched_balance_exec() statistics:
+    17) # of times in this domain sched_balance_exec() successfully pushed
+	a task to a new cpu
+    18) # of times in this domain sched_balance_exec() tried but failed to
+	push a task to a new cpu
+
+Next two are try_to_wake_up() statistics:
+    19) # of times in this domain try_to_wake_up() tried to move a task based
+	on affinity and cache warmth
+    20) # of times in this domain try_to_wake_up() tried to move a task based
+	on load balancing
+
+
+/proc/<pid>/stat
+----------------
+schedstats also changes the stat output of individual processes to
+include some of the same information on a per-process level, obtainable
+from /proc/<pid>/stat.  Three new fields correlating to fields 20, 21,
+and 22 in the CPU fields, are tacked on to the end but apply only for
+that process.
+
+A program could be easily written to make use of these extra fields to
+report on how well a particular process or set of processes is faring
+under the scheduler's policies.  A simple version of such a program is
+available at
+    http://eaglet.rain.com/rick/linux/schedstat/v9/latency.c
diff -rupN linux-2.6.8.1/arch/i386/Kconfig linux-2.6.8.1-ss/arch/i386/Kconfig
--- linux-2.6.8.1/arch/i386/Kconfig	2004-08-14 03:54:50.000000000 -0700
+++ linux-2.6.8.1-ss/arch/i386/Kconfig	2004-09-07 22:30:10.000000000 -0700
@@ -1298,6 +1298,19 @@ config 4KSTACKS
 	  on the VM subsystem for higher order allocations. This option
 	  will also use IRQ stacks to compensate for the reduced stackspace.
 
+config SCHEDSTATS
+	bool "Collect scheduler statistics"
+	depends on PROC_FS
+	default y
+	help
+	  If you say Y here, additional code will be inserted into the
+	  scheduler and related routines to collect statistics about
+	  scheduler behavior and provide them in /proc/schedstat.  These
+	  stats may be useful for both tuning and debugging the scheduler
+	  If you aren't debugging the scheduler or trying to tune a specific
+	  application, you can say N to avoid the very slight overhead
+	  this adds.
+
 config X86_FIND_SMP_CONFIG
 	bool
 	depends on X86_LOCAL_APIC || X86_VOYAGER
diff -rupN linux-2.6.8.1/arch/ppc/Kconfig linux-2.6.8.1-ss/arch/ppc/Kconfig
--- linux-2.6.8.1/arch/ppc/Kconfig	2004-08-14 03:56:23.000000000 -0700
+++ linux-2.6.8.1-ss/arch/ppc/Kconfig	2004-09-07 22:30:10.000000000 -0700
@@ -1333,6 +1333,19 @@ config DEBUG_INFO
 	  debug the kernel.
 	  If you don't debug the kernel, you can say N.
 
+config SCHEDSTATS
+	bool "Collect scheduler statistics"
+	depends on PROC_FS
+	default y
+	help
+	  If you say Y here, additional code will be inserted into the
+	  scheduler and related routines to collect statistics about
+	  scheduler behavior and provide them in /proc/schedstat.  These
+	  stats may be useful for both tuning and debugging the scheduler
+	  If you aren't debugging the scheduler or trying to tune a specific
+	  application, you can say N to avoid the very slight overhead
+	  this adds.
+	  
 config BOOTX_TEXT
 	bool "Support for early boot text console (BootX or OpenFirmware only)"
 	depends PPC_OF
diff -rupN linux-2.6.8.1/arch/ppc64/Kconfig linux-2.6.8.1-ss/arch/ppc64/Kconfig
--- linux-2.6.8.1/arch/ppc64/Kconfig	2004-08-14 03:55:33.000000000 -0700
+++ linux-2.6.8.1-ss/arch/ppc64/Kconfig	2004-09-07 22:30:10.000000000 -0700
@@ -424,6 +424,19 @@ config IRQSTACKS
 	  for handling hard and soft interrupts.  This can help avoid
 	  overflowing the process kernel stacks.
 	  
+config SCHEDSTATS
+	bool "Collect scheduler statistics"
+	depends on PROC_FS
+	default y
+	help
+	  If you say Y here, additional code will be inserted into the
+	  scheduler and related routines to collect statistics about
+	  scheduler behavior and provide them in /proc/schedstat.  These
+	  stats may be useful for both tuning and debugging the scheduler
+	  If you aren't debugging the scheduler or trying to tune a specific
+	  application, you can say N to avoid the very slight overhead
+	  this adds.
+
 config SPINLINE
 	bool "Inline spinlock code at each call site"
 	depends on SMP && !PPC_SPLPAR && !PPC_ISERIES
diff -rupN linux-2.6.8.1/arch/x86_64/Kconfig linux-2.6.8.1-ss/arch/x86_64/Kconfig
--- linux-2.6.8.1/arch/x86_64/Kconfig	2004-08-14 03:55:59.000000000 -0700
+++ linux-2.6.8.1-ss/arch/x86_64/Kconfig	2004-09-07 22:30:10.000000000 -0700
@@ -461,6 +461,19 @@ config DEBUG_INFO
 	  Say Y here only if you plan to use gdb to debug the kernel.
 	  Please note that this option requires new binutils.
 	  If you don't debug the kernel, you can say N.
+
+config SCHEDSTATS
+	bool "Collect scheduler statistics"
+	depends on PROC_FS
+	default y 
+	help
+	  If you say Y here, additional code will be inserted into the
+	  scheduler and related routines to collect statistics about
+	  scheduler behavior and provide them in /proc/schedstat.  These
+	  stats may be useful for both tuning and debugging the scheduler
+	  If you aren't debugging the scheduler or trying to tune a specific
+	  application, you can say N to avoid the very slight overhead
+	  this adds.
 	  
 config FRAME_POINTER
        bool "Compile the kernel with frame pointers"
diff -rupN linux-2.6.8.1/fs/proc/array.c linux-2.6.8.1-ss/fs/proc/array.c
--- linux-2.6.8.1/fs/proc/array.c	2004-08-14 03:55:34.000000000 -0700
+++ linux-2.6.8.1-ss/fs/proc/array.c	2004-09-07 22:30:10.000000000 -0700
@@ -358,9 +358,15 @@ int proc_pid_stat(struct task_struct *ta
 	/* Temporary variable needed for gcc-2.96 */
 	start_time = jiffies_64_to_clock_t(task->start_time - INITIAL_JIFFIES);
 
+#ifdef CONFIG_SCHEDSTATS
+	res = sprintf(buffer,"%d (%s) %c %d %d %d %d %d %lu %lu \
+%lu %lu %lu %lu %lu %ld %ld %ld %ld %d %ld %llu %lu %ld %lu %lu %lu %lu %lu \
+%lu %lu %lu %lu %lu %lu %lu %lu %d %d %lu %lu %lu %lu %lu\n",
+#else
 	res = sprintf(buffer,"%d (%s) %c %d %d %d %d %d %lu %lu \
 %lu %lu %lu %lu %lu %ld %ld %ld %ld %d %ld %llu %lu %ld %lu %lu %lu %lu %lu \
 %lu %lu %lu %lu %lu %lu %lu %lu %d %d %lu %lu\n",
+#endif
 		task->pid,
 		task->comm,
 		state,
@@ -405,7 +411,14 @@ int proc_pid_stat(struct task_struct *ta
 		task->exit_signal,
 		task_cpu(task),
 		task->rt_priority,
+#ifdef CONFIG_SCHEDSTATS
+		task->policy,
+		task->sched_info.cpu_time,
+		task->sched_info.run_delay,
+		task->sched_info.pcnt);
+#else
 		task->policy);
+#endif /* CONFIG_SCHEDSTATS */
 	if(mm)
 		mmput(mm);
 	return res;
diff -rupN linux-2.6.8.1/fs/proc/proc_misc.c linux-2.6.8.1-ss/fs/proc/proc_misc.c
--- linux-2.6.8.1/fs/proc/proc_misc.c	2004-08-14 03:54:50.000000000 -0700
+++ linux-2.6.8.1-ss/fs/proc/proc_misc.c	2004-09-07 22:30:10.000000000 -0700
@@ -282,6 +282,10 @@ static struct file_operations proc_vmsta
 	.release	= seq_release,
 };
 
+#ifdef CONFIG_SCHEDSTATS
+extern struct file_operations proc_schedstat_operations;
+#endif
+
 #ifdef CONFIG_PROC_HARDWARE
 static int hardware_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
@@ -681,6 +685,9 @@ void __init proc_misc_init(void)
 #ifdef CONFIG_MODULES
 	create_seq_entry("modules", 0, &proc_modules_operations);
 #endif
+#ifdef CONFIG_SCHEDSTATS
+	create_seq_entry("schedstat", 0, &proc_schedstat_operations);
+#endif
 #ifdef CONFIG_PROC_KCORE
 	proc_root_kcore = create_proc_entry("kcore", S_IRUSR, NULL);
 	if (proc_root_kcore) {
diff -rupN linux-2.6.8.1/include/linux/sched.h linux-2.6.8.1-ss/include/linux/sched.h
--- linux-2.6.8.1/include/linux/sched.h	2004-08-14 03:54:49.000000000 -0700
+++ linux-2.6.8.1-ss/include/linux/sched.h	2004-09-07 22:53:00.000000000 -0700
@@ -96,6 +96,16 @@ extern unsigned long nr_running(void);
 extern unsigned long nr_uninterruptible(void);
 extern unsigned long nr_iowait(void);
 
+#ifdef CONFIG_SCHEDSTATS
+struct sched_info;
+extern void cpu_sched_info(struct sched_info *, int);
+#define schedstat_inc(rq, field)	rq->field++;
+#define schedstat_add(rq, field, amt)	rq->field += amt;
+#else
+#define schedstat_inc(rq, field)	do { } while (0);
+#define schedstat_add(rq, field, amt)	do { } while (0);
+#endif
+
 #include <linux/time.h>
 #include <linux/param.h>
 #include <linux/resource.h>
@@ -347,6 +357,18 @@ struct k_itimer {
 	struct timespec wall_to_prev;   /* wall_to_monotonic used when set */
 };
 
+#ifdef CONFIG_SCHEDSTATS
+struct sched_info {
+	/* cumulative counters */
+	unsigned long	cpu_time,	/* time spent on the cpu */
+			run_delay,	/* time spent waiting on a runqueue */
+			pcnt;		/* # of timeslices run on this cpu */
+
+	/* timestamps */
+	unsigned long	last_arrival,	/* when we last ran on a cpu */
+			last_queued;	/* when we were last queued to run */
+};
+#endif /* CONFIG_SCHEDSTATS */
 
 struct io_context;			/* See blkdev.h */
 void exit_io_context(void);
@@ -409,6 +431,10 @@ struct task_struct {
 	cpumask_t cpus_allowed;
 	unsigned int time_slice, first_time_slice;
 
+#ifdef CONFIG_SCHEDSTATS
+	struct sched_info sched_info;
+#endif /* CONFIG_SCHEDSTATS */
+
 	struct list_head tasks;
 	/*
 	 * ptrace_list/ptrace_children forms the list of my children
@@ -564,6 +590,14 @@ do { if (atomic_dec_and_test(&(tsk)->usa
 #define PF_LESS_THROTTLE 0x00100000	/* Throttle me less: I clean memory */
 #define PF_SYNCWRITE	0x00200000	/* I am doing a sync write */
 
+enum idle_type
+{
+	IDLE,
+	NOT_IDLE,
+	NEWLY_IDLE,
+	MAX_IDLE_TYPES
+};
+
 #ifdef CONFIG_SMP
 #define SCHED_LOAD_SCALE	128UL	/* increase resolution of load */
 
@@ -606,6 +640,23 @@ struct sched_domain {
 	unsigned long last_balance;	/* init to jiffies. units in jiffies */
 	unsigned int balance_interval;	/* initialise to 1. units in ms. */
 	unsigned int nr_balance_failed; /* initialise to 0 */
+
+#ifdef CONFIG_SCHEDSTATS
+	/* load_balance() stats */
+	unsigned long lb_cnt[MAX_IDLE_TYPES];
+	unsigned long lb_failed[MAX_IDLE_TYPES];
+	unsigned long lb_imbalance[MAX_IDLE_TYPES];
+	unsigned long lb_nobusyg[MAX_IDLE_TYPES];
+	unsigned long lb_nobusyq[MAX_IDLE_TYPES];
+
+	/* sched_balance_exec() stats */
+	unsigned long sbe_attempts;
+	unsigned long sbe_pushed;
+
+	/* try_to_wake_up() stats */
+	unsigned long ttwu_wake_affine;
+	unsigned long ttwu_wake_balance;
+#endif
 };
 
 /* Common values for SMT siblings */
diff -rupN linux-2.6.8.1/kernel/fork.c linux-2.6.8.1-ss/kernel/fork.c
--- linux-2.6.8.1/kernel/fork.c	2004-08-14 03:54:49.000000000 -0700
+++ linux-2.6.8.1-ss/kernel/fork.c	2004-09-07 22:30:10.000000000 -0700
@@ -965,6 +965,11 @@ struct task_struct *copy_process(unsigne
 	p->security = NULL;
 	p->io_context = NULL;
 	p->audit_context = NULL;
+
+#ifdef CONFIG_SCHEDSTATS
+	memset(&p->sched_info, 0, sizeof(p->sched_info));
+#endif /* CONFIG_SCHEDSTATS */
+
 #ifdef CONFIG_NUMA
  	p->mempolicy = mpol_copy(p->mempolicy);
  	if (IS_ERR(p->mempolicy)) {
diff -rupN linux-2.6.8.1/kernel/sched.c linux-2.6.8.1-ss/kernel/sched.c
--- linux-2.6.8.1/kernel/sched.c	2004-08-14 03:55:59.000000000 -0700
+++ linux-2.6.8.1-ss/kernel/sched.c	2004-09-07 23:55:54.000000000 -0700
@@ -40,6 +40,8 @@
 #include <linux/cpu.h>
 #include <linux/percpu.h>
 #include <linux/kthread.h>
+#include <linux/seq_file.h>
+#include <linux/times.h>
 #include <asm/tlb.h>
 
 #include <asm/unistd.h>
@@ -218,6 +220,9 @@ struct runqueue {
 	unsigned long expired_timestamp, nr_uninterruptible;
 	unsigned long long timestamp_last_tick;
 	task_t *curr, *idle;
+#ifdef CONFIG_SCHEDSTATS
+	int cpu;  /* to make easy reverse-lookups with per-cpu runqueues */
+#endif
 	struct mm_struct *prev_mm;
 	prio_array_t *active, *expired, arrays[2];
 	int best_expired_prio;
@@ -233,6 +238,48 @@ struct runqueue {
 	task_t *migration_thread;
 	struct list_head migration_queue;
 #endif
+
+#ifdef CONFIG_SCHEDSTATS
+	/* latency stats */
+	struct sched_info rq_sched_info;
+
+	/* sys_sched_yield() stats */
+	unsigned long yld_exp_empty;
+	unsigned long yld_act_empty;
+	unsigned long yld_both_empty;
+	unsigned long yld_cnt;
+
+	/* schedule() stats */
+	unsigned long sched_noswitch;
+	unsigned long sched_switch;
+	unsigned long sched_cnt;
+	unsigned long sched_goidle;
+
+	/* pull_task() stats */
+	unsigned long pt_gained[MAX_IDLE_TYPES];
+	unsigned long pt_lost[MAX_IDLE_TYPES];
+
+	/* active_load_balance() stats */
+	unsigned long alb_cnt;
+	unsigned long alb_lost;
+	unsigned long alb_gained;
+	unsigned long alb_failed;
+
+	/* try_to_wake_up() stats */
+	unsigned long ttwu_cnt;
+	unsigned long ttwu_attempts;
+	unsigned long ttwu_moved;
+
+	/* wake_up_forked_thread() stats */
+	unsigned long wuft_cnt;
+	unsigned long wuft_moved;
+
+	/* sched_migrate_task() stats */
+	unsigned long smt_cnt;
+
+	/* sched_balance_exec() stats */
+	unsigned long sbe_cnt;
+#endif
 };
 
 static DEFINE_PER_CPU(struct runqueue, runqueues);
@@ -279,6 +326,100 @@ static inline void task_rq_unlock(runque
 	spin_unlock_irqrestore(&rq->lock, *flags);
 }
 
+#ifdef CONFIG_SCHEDSTATS
+/*
+ * bump this up when changing the output format or the meaning of an existing
+ * format, so that tools can adapt (or abort)
+ */
+#define SCHEDSTAT_VERSION	9
+
+static int show_schedstat(struct seq_file *seq, void *v)
+{
+	int cpu;
+	enum idle_type itype;
+
+	seq_printf(seq, "version %d\n", SCHEDSTAT_VERSION);
+	seq_printf(seq, "timestamp %lu\n", jiffies);
+	for_each_online_cpu (cpu) {
+
+		runqueue_t *rq = cpu_rq(cpu);
+#ifdef CONFIG_SMP
+		struct sched_domain *sd;
+		int dcnt = 0;
+#endif
+
+		/* runqueue-specific stats */
+		seq_printf(seq, 
+		    "cpu%d %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu "
+		    "%lu %lu %lu %lu %lu %lu %lu %lu %lu %lu",
+		    cpu, rq->yld_both_empty,
+		    rq->yld_act_empty, rq->yld_exp_empty,
+		    rq->yld_cnt, rq->sched_noswitch,
+		    rq->sched_switch, rq->sched_cnt, rq->sched_goidle,
+		    rq->alb_cnt, rq->alb_gained, rq->alb_lost,
+		    rq->alb_failed,
+		    rq->ttwu_cnt, rq->ttwu_moved, rq->ttwu_attempts,
+		    rq->wuft_cnt, rq->wuft_moved,
+		    rq->smt_cnt, rq->sbe_cnt, rq->rq_sched_info.cpu_time,
+		    rq->rq_sched_info.run_delay, rq->rq_sched_info.pcnt);
+
+		for (itype = IDLE; itype < MAX_IDLE_TYPES; itype++)
+		    seq_printf(seq, " %lu %lu", rq->pt_gained[itype],
+			rq->pt_lost[itype]);
+
+		seq_printf(seq, "\n");
+
+#ifdef CONFIG_SMP
+		/* domain-specific stats */
+		for_each_domain(cpu, sd) {
+			char mask_str[NR_CPUS];
+
+			cpumask_scnprintf(mask_str, NR_CPUS, sd->span);
+			seq_printf(seq, "domain%d %s", dcnt++, mask_str);
+			for (itype = IDLE; itype < MAX_IDLE_TYPES; itype++) {
+				seq_printf(seq, " %lu %lu %lu %lu %lu",
+				    sd->lb_cnt[itype],
+				    sd->lb_failed[itype],
+				    sd->lb_imbalance[itype],
+				    sd->lb_nobusyq[itype],
+				    sd->lb_nobusyg[itype]);
+			}
+			seq_printf(seq, " %lu %lu %lu %lu\n",
+			    sd->sbe_pushed, sd->sbe_attempts,
+			    sd->ttwu_wake_affine, sd->ttwu_wake_balance);
+		}
+#endif
+	}
+	return 0;
+}
+
+static int schedstat_open(struct inode *inode, struct file *file)
+{
+	unsigned size = PAGE_SIZE * (1 + num_online_cpus() / 32);
+	char *buf = kmalloc(size, GFP_KERNEL);
+	struct seq_file *m;
+	int res;
+
+	if (!buf)
+		return -ENOMEM;
+	res = single_open(file, show_schedstat, NULL);
+	if (!res) {
+		m = file->private_data;
+		m->buf = buf;
+		m->size = size;
+	} else
+		kfree(buf);
+	return res;
+}
+
+struct file_operations proc_schedstat_operations = {
+	.open    = schedstat_open,
+	.read    = seq_read,
+	.llseek  = seq_lseek,
+	.release = single_release,
+};
+#endif
+
 /*
  * rq_lock - lock a given runqueue and disable interrupts.
  */
@@ -298,6 +439,113 @@ static inline void rq_unlock(runqueue_t 
 	spin_unlock_irq(&rq->lock);
 }
 
+#ifdef CONFIG_SCHEDSTATS
+/*
+ * Called when a process is dequeued from the active array and given
+ * the cpu.  We should note that with the exception of interactive
+ * tasks, the expired queue will become the active queue after the active
+ * queue is empty, without explicitly dequeuing and requeuing tasks in the
+ * expired queue.  (Interactive tasks may be requeued directly to the
+ * active queue, thus delaying tasks in the expired queue from running;
+ * see scheduler_tick()).
+ *
+ * This function is only called from sched_info_arrive(), rather than
+ * dequeue_task(). Even though a task may be queued and dequeued multiple
+ * times as it is shuffled about, we're really interested in knowing how
+ * long it was from the *first* time it was queued to the time that it
+ * finally hit a cpu.
+ */
+static inline void sched_info_dequeued(task_t *t)
+{
+	t->sched_info.last_queued = 0;
+}
+
+/*
+ * Called when a task finally hits the cpu.  We can now calculate how
+ * long it was waiting to run.  We also note when it began so that we
+ * can keep stats on how long its timeslice is.
+ */
+static inline void sched_info_arrive(task_t *t)
+{
+	unsigned long now  = jiffies;
+	unsigned long diff = 0;
+	struct runqueue *rq = task_rq(t);
+
+	if (t->sched_info.last_queued)
+		diff = now - t->sched_info.last_queued;
+	sched_info_dequeued(t);
+	t->sched_info.run_delay += diff;
+	t->sched_info.last_arrival = now;
+	t->sched_info.pcnt++;
+
+	if (!rq)
+		return;
+	
+	rq->rq_sched_info.run_delay += diff;
+	rq->rq_sched_info.pcnt++;
+}
+
+/*
+ * Called when a process is queued into either the active or expired
+ * array.  The time is noted and later used to determine how long we
+ * had to wait for us to reach the cpu.  Since the expired queue will
+ * become the active queue after active queue is empty, without dequeuing
+ * and requeuing any tasks, we are interested in queuing to either. It
+ * is unusual but not impossible for tasks to be dequeued and immediately
+ * requeued in the same or another array: this can happen in sched_yield(),
+ * set_user_nice(), and even load_balance() as it moves tasks from runqueue
+ * to runqueue.
+ *
+ * This function is only called from enqueue_task(), but also only updates
+ * the timestamp if it is already not set.  It's assumed that
+ * sched_info_dequeued() will clear that stamp when appropriate.
+ */
+static inline void sched_info_queued(task_t *t)
+{
+	if (!t->sched_info.last_queued)
+		t->sched_info.last_queued = jiffies;
+}
+
+/*
+ * Called when a process ceases being the active-running process, either
+ * voluntarily or involuntarily.  Now we can calculate how long we ran.
+ */
+static inline void sched_info_depart(task_t *t)
+{
+	struct runqueue *rq = task_rq(t);
+	unsigned long diff = jiffies - t->sched_info.last_arrival;
+
+	t->sched_info.cpu_time += diff;
+
+	if (rq)
+		rq->rq_sched_info.cpu_time += diff;
+}
+
+/*
+ * Called when tasks are switched involuntarily due, typically, to expiring
+ * their time slice.  (This may also be called when switching to or from
+ * the idle task.)  We are only called when prev != next.
+ */
+static inline void sched_info_switch(task_t *prev, task_t *next)
+{
+	struct runqueue *rq = task_rq(prev);
+
+	/*
+	 * prev now departs the cpu.  It's not interesting to record
+	 * stats about how efficient we were at scheduling the idle
+	 * process, however.
+	 */
+	if (prev != rq->idle)
+		sched_info_depart(prev);
+
+	if (next != rq->idle)
+		sched_info_arrive(next);
+}
+#else
+#define sched_info_queued(t)		{}
+#define sched_info_switch(t, next)	{}
+#endif /* CONFIG_SCHEDSTATS */
+
 /*
  * Adding/removing a task to/from a priority array:
  */
@@ -311,6 +559,7 @@ static void dequeue_task(struct task_str
 
 static void enqueue_task(struct task_struct *p, prio_array_t *array)
 {
+	sched_info_queued(p);
 	list_add_tail(&p->run_list, array->queue + p->prio);
 	__set_bit(p->prio, array->bitmap);
 	array->nr_active++;
@@ -735,11 +984,12 @@ static int try_to_wake_up(task_t * p, un
 	runqueue_t *rq;
 #ifdef CONFIG_SMP
 	unsigned long load, this_load;
-	struct sched_domain *sd;
+	struct sched_domain *sd = NULL;
 	int new_cpu;
 #endif
 
 	rq = task_rq_lock(p, &flags);
+	schedstat_inc(rq, ttwu_cnt);
 	old_state = p->state;
 	if (!(old_state & state))
 		goto out;
@@ -787,23 +1037,35 @@ static int try_to_wake_up(task_t * p, un
 		 */
 		imbalance = sd->imbalance_pct + (sd->imbalance_pct - 100) / 2;
 
-		if ( ((sd->flags & SD_WAKE_AFFINE) &&
-				!task_hot(p, rq->timestamp_last_tick, sd))
-			|| ((sd->flags & SD_WAKE_BALANCE) &&
-				imbalance*this_load <= 100*load) ) {
+		if ((sd->flags & SD_WAKE_AFFINE) &&
+				!task_hot(p, rq->timestamp_last_tick, sd)) {
+			/*
+			 * This domain has SD_WAKE_AFFINE and p is cache cold
+			 * in this domain.
+			 */
+			if (cpu_isset(cpu, sd->span)) {
+				schedstat_inc(sd, ttwu_wake_affine);
+				goto out_set_cpu;
+			}
+		} else if ((sd->flags & SD_WAKE_BALANCE) &&
+				imbalance*this_load <= 100*load) {
 			/*
-			 * Now sd has SD_WAKE_AFFINE and p is cache cold in sd
-			 * or sd has SD_WAKE_BALANCE and there is an imbalance
+			 * This domain has SD_WAKE_BALANCE and there is
+			 * an imbalance.
 			 */
-			if (cpu_isset(cpu, sd->span))
+			if (cpu_isset(cpu, sd->span)) {
+				schedstat_inc(sd, ttwu_wake_balance);
 				goto out_set_cpu;
+			}
 		}
 	}
 
 	new_cpu = cpu; /* Could not wake to this_cpu. Wake to cpu instead */
 out_set_cpu:
+	schedstat_inc(rq, ttwu_attempts);
 	new_cpu = wake_idle(new_cpu, p);
 	if (new_cpu != cpu && cpu_isset(new_cpu, p->cpus_allowed)) {
+		schedstat_inc(rq, ttwu_moved);
 		set_task_cpu(p, new_cpu);
 		task_rq_unlock(rq, &flags);
 		/* might preempt at this point */
@@ -855,7 +1117,7 @@ out:
 int fastcall wake_up_process(task_t * p)
 {
 	return try_to_wake_up(p, TASK_STOPPED |
-		       		 TASK_INTERRUPTIBLE | TASK_UNINTERRUPTIBLE, 0);
+				 TASK_INTERRUPTIBLE | TASK_UNINTERRUPTIBLE, 0);
 }
 
 EXPORT_SYMBOL(wake_up_process);
@@ -1155,13 +1417,6 @@ static void double_rq_unlock(runqueue_t 
 		spin_unlock(&rq2->lock);
 }
 
-enum idle_type
-{
-	IDLE,
-	NOT_IDLE,
-	NEWLY_IDLE,
-};
-
 #ifdef CONFIG_SMP
 
 /*
@@ -1228,6 +1483,7 @@ void fastcall wake_up_forked_thread(task
 	 * Find the largest domain that this CPU is part of that
 	 * is willing to balance on clone:
 	 */
+	schedstat_inc(this_rq, wuft_cnt);
 	for_each_domain(this_cpu, tmp)
 		if (tmp->flags & SD_BALANCE_CLONE)
 			sd = tmp;
@@ -1280,6 +1536,7 @@ lock_again:
 			rq->nr_running++;
 		}
 	} else {
+		schedstat_inc(this_rq, wuft_moved);
 		/* Not the local CPU - must adjust timestamp */
 		p->timestamp = (p->timestamp - this_rq->timestamp_last_tick)
 					+ rq->timestamp_last_tick;
@@ -1310,6 +1567,7 @@ static void sched_migrate_task(task_t *p
 	    || unlikely(cpu_is_offline(dest_cpu)))
 		goto out;
 
+	schedstat_inc(rq, smt_cnt);
 	/* force the process onto the specified CPU */
 	if (migrate_task(p, dest_cpu, &req)) {
 		/* Need to wait for migration thread (might exit: take ref). */
@@ -1337,6 +1595,7 @@ void sched_balance_exec(void)
 	struct sched_domain *tmp, *sd = NULL;
 	int new_cpu, this_cpu = get_cpu();
 
+	schedstat_inc(this_rq(), sbe_cnt);
 	/* Prefer the current CPU if there's only this task running */
 	if (this_rq()->nr_running <= 1)
 		goto out;
@@ -1345,9 +1604,11 @@ void sched_balance_exec(void)
 		if (tmp->flags & SD_BALANCE_EXEC)
 			sd = tmp;
 
+	schedstat_inc(sd, sbe_attempts);
 	if (sd) {
 		new_cpu = find_idlest_cpu(current, this_cpu, sd);
 		if (new_cpu != this_cpu) {
+			schedstat_inc(sd, sbe_pushed);
 			put_cpu();
 			sched_migrate_task(current, new_cpu);
 			return;
@@ -1486,6 +1747,15 @@ skip_queue:
 		idx++;
 		goto skip_bitmap;
 	}
+
+	/*
+	 * Right now, this is the only place pull_task() is called,
+	 * so we can safely collect pull_task() stats here rather than
+	 * inside pull_task().
+	 */
+	schedstat_inc(this_rq, pt_gained[idle]);
+	schedstat_inc(busiest, pt_lost[idle]);
+
 	pull_task(busiest, array, tmp, this_rq, dst_array, this_cpu);
 	pulled++;
 
@@ -1680,14 +1950,20 @@ static int load_balance(int this_cpu, ru
 	int nr_moved;
 
 	spin_lock(&this_rq->lock);
-
-	group = find_busiest_group(sd, this_cpu, &imbalance, idle);
-	if (!group)
-		goto out_balanced;
+	schedstat_inc(sd, lb_cnt[idle]);
+  
+  	group = find_busiest_group(sd, this_cpu, &imbalance, idle);
+	if (!group) {
+		schedstat_inc(sd, lb_nobusyg[idle]);
+  		goto out_balanced;
+	}
 
 	busiest = find_busiest_queue(group);
-	if (!busiest)
-		goto out_balanced;
+	if (!busiest) {
+		schedstat_inc(sd, lb_nobusyq[idle]);
+  		goto out_balanced;
+	}
+
 	/*
 	 * This should be "impossible", but since load
 	 * balancing is inherently racy and statistical,
@@ -1698,6 +1974,8 @@ static int load_balance(int this_cpu, ru
 		goto out_balanced;
 	}
 
+ 	schedstat_add(sd, lb_imbalance[idle], imbalance);
+
 	nr_moved = 0;
 	if (busiest->nr_running > 1) {
 		/*
@@ -1714,6 +1992,7 @@ static int load_balance(int this_cpu, ru
 	spin_unlock(&this_rq->lock);
 
 	if (!nr_moved) {
+		schedstat_inc(sd, lb_failed[idle]);
 		sd->nr_balance_failed++;
 
 		if (unlikely(sd->nr_balance_failed > sd->cache_nice_tries+2)) {
@@ -1768,20 +2047,29 @@ static int load_balance_newidle(int this
 	unsigned long imbalance;
 	int nr_moved = 0;
 
+	schedstat_inc(sd, lb_cnt[NEWLY_IDLE]);
 	group = find_busiest_group(sd, this_cpu, &imbalance, NEWLY_IDLE);
-	if (!group)
+	if (!group) {
+		schedstat_inc(sd, lb_nobusyg[NEWLY_IDLE]);
 		goto out;
+	}
 
 	busiest = find_busiest_queue(group);
-	if (!busiest || busiest == this_rq)
+	if (!busiest || busiest == this_rq) {
+		schedstat_inc(sd, lb_nobusyq[NEWLY_IDLE]);
 		goto out;
+	}
 
 	/* Attempt to move tasks */
 	double_lock_balance(this_rq, busiest);
 
+	schedstat_add(sd, lb_imbalance[NEWLY_IDLE], imbalance);
 	nr_moved = move_tasks(this_rq, this_cpu, busiest,
 					imbalance, sd, NEWLY_IDLE);
 
+	if (!nr_moved)
+	    schedstat_inc(sd, lb_failed[NEWLY_IDLE]);
+
 	spin_unlock(&busiest->lock);
 
 out:
@@ -1820,6 +2108,7 @@ static void active_load_balance(runqueue
 	struct sched_group *group, *busy_group;
 	int i;
 
+	schedstat_inc(busiest, alb_cnt);
 	if (busiest->nr_running <= 1)
 		return;
 
@@ -1866,7 +2155,12 @@ static void active_load_balance(runqueue
 		if (unlikely(busiest == rq))
 			goto next_group;
 		double_lock_balance(busiest, rq);
-		move_tasks(rq, push_cpu, busiest, 1, sd, IDLE);
+		if (move_tasks(rq, push_cpu, busiest, 1, sd, IDLE)) {
+			schedstat_inc(busiest, alb_lost);
+			schedstat_inc(rq, alb_gained);
+		} else {
+			schedstat_inc(busiest, alb_failed);
+		}
 		spin_unlock(&rq->lock);
 next_group:
 		group = group->next;
@@ -2210,6 +2504,7 @@ need_resched:
 	rq = this_rq();
 
 	release_kernel_lock(prev);
+	schedstat_inc(rq, sched_cnt);
 	now = sched_clock();
 	if (likely(now - prev->timestamp < NS_MAX_SLEEP_AVG))
 		run_time = now - prev->timestamp;
@@ -2256,18 +2551,21 @@ need_resched:
 		/*
 		 * Switch the active and expired arrays.
 		 */
+		schedstat_inc(rq, sched_switch);
 		rq->active = rq->expired;
 		rq->expired = array;
 		array = rq->active;
 		rq->expired_timestamp = 0;
 		rq->best_expired_prio = MAX_PRIO;
-	}
+	} else
+		schedstat_inc(rq, sched_noswitch);
 
 	idx = sched_find_first_bit(array->bitmap);
 	queue = array->queue + idx;
 	next = list_entry(queue->next, task_t, run_list);
 
 	if (dependent_sleeper(cpu, rq, next)) {
+		schedstat_inc(rq, sched_goidle);
 		next = rq->idle;
 		goto switch_tasks;
 	}
@@ -2297,6 +2595,7 @@ switch_tasks:
 	}
 	prev->timestamp = now;
 
+	sched_info_switch(prev, next);
 	if (likely(prev != next)) {
 		next->timestamp = now;
 		rq->nr_switches++;
@@ -3008,6 +3307,7 @@ asmlinkage long sys_sched_yield(void)
 	prio_array_t *array = current->array;
 	prio_array_t *target = rq->expired;
 
+	schedstat_inc(rq, yld_cnt);
 	/*
 	 * We implement yielding by moving the task into the expired
 	 * queue.
@@ -3018,6 +3318,15 @@ asmlinkage long sys_sched_yield(void)
 	if (unlikely(rt_task(current)))
 		target = rq->active;
 
+	if (current->array->nr_active == 1) {
+		schedstat_inc(rq, yld_act_empty);
+		if (!rq->expired->nr_active) {
+			schedstat_inc(rq, yld_both_empty);
+		}
+	} else if (!rq->expired->nr_active) {
+		schedstat_inc(rq, yld_exp_empty);
+	}
+
 	dequeue_task(current, array);
 	enqueue_task(current, target);
 
@@ -3603,7 +3912,7 @@ static int migration_call(struct notifie
 		rq->idle->static_prio = MAX_PRIO;
 		__setscheduler(rq->idle, SCHED_NORMAL, 0);
 		task_rq_unlock(rq, &flags);
- 		BUG_ON(rq->nr_running != 0);
+		BUG_ON(rq->nr_running != 0);
 
 		/* No need to migrate the tasks: it was best-effort if
 		 * they didn't do lock_cpu_hotplug().  Just wake up
@@ -3618,7 +3927,7 @@ static int migration_call(struct notifie
 			complete(&req->done);
 		}
 		spin_unlock_irq(&rq->lock);
- 		break;
+		break;
 #endif
 	}
 	return NOTIFY_OK;
@@ -3937,6 +4246,9 @@ void __init sched_init(void)
 		spin_lock_init(&rq->lock);
 		rq->active = rq->arrays;
 		rq->expired = rq->arrays + 1;
+#ifdef CONFIG_SCHEDSTATS
+		rq->cpu = i;
+#endif /* CONFIG_SCHEDSTATS */
 		rq->best_expired_prio = MAX_PRIO;
 
 #ifdef CONFIG_SMP
