Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263268AbVGOKBX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263268AbVGOKBX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 06:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263267AbVGOKBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 06:01:23 -0400
Received: from out01.east.net ([210.56.193.7]:63174 "EHLO out01.east.net")
	by vger.kernel.org with ESMTP id S263269AbVGOKBQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 06:01:16 -0400
Subject: [PATCH] latency logger for realtime-preempt-2.6.12-final-V0.7.51-30
From: yangyi <yang.yi@bmrtech.com>
Reply-To: yang.yi@bmrtech.com
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: bmrtech
Message-Id: <1121421736.4113.329.camel@montavista2>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 15 Jul 2005 18:02:16 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ingo

This patch can record interrupt-off latency, preemption-off latency and
wakeup latency in a big history array, in the meanwhile, it dummies up
printks produced
 by these latency timing.

This patch adds three options: "Log interrupts-off critical section
latency", "Log non-preemptible critical section latency" and "Log wakeup
latency", they may be selected together, but just enabling one of them
will be better.

All the latency history can be viewed via /proc interface:
	
(Note, * presents CPU ID)
###interrupt-off latency history
	cat /proc/latency_log/interrupt_off_latency/CPU*

###preemption-off latency history
	cat /proc/latency_log/preemption_off_latency/CPU*

###wakeup latency history
	cat  /proc/latency_log/wakeup_latency/CPU*

Latency tracing will trace the maximum sample of three options, so
/proc/latency_trace can provide the detailed tracing for maximum sample.

diffstat:
 kernel/Makefile   |    1
 kernel/latency.c   |   96 ++++++++++++++++
 kernel/latency_log.c |  292
+++++++++++++++++++++++++++++++++++++++++++++++++++
 lib/Kconfig.debug  |   59 ++++++++++
 4 files changed, 445 insertions(+), 3 deletions(-)

--- /dev/null	2003-01-30 18:24:37.000000000 +0800
+++ linux-2.6.12/kernel/latency_log.c	2005-07-15 17:45:53.000000000
+0800
@@ -0,0 +1,292 @@
+/*
+ * kernel/latency_log.c
+ *
+ * Add support for history logs of preemption-off latency and
+ * interrupt-off latency and wakeup latency, it depends on 
+ * Real-Time Preemption Support.
+ *
+ *  Copyright (C) 2005, 2007 MontaVista Software, Inc.
+ *  Yi Yang <yyang@ch.mvista.com>
+ *
+ */
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+#include <linux/percpu.h>
+#include <asm/atomic.h>
+
+#define MAX_ENTRY_NUM 10240
+#define LATENCY_TYPE_NUM 3
+
+typedef struct log_data_struct {
+	atomic_t log_mode; /* 0 log, 1 don't log */
+	unsigned long min_lat;
+	unsigned long avg_lat;
+	unsigned long max_lat;
+	unsigned long long beyond_log_bound_samples;
+	unsigned long long accumulate_lat;
+	unsigned long long total_samples;
+	unsigned long long log_array[MAX_ENTRY_NUM];
+} log_data_t;
+
+enum {
+	INTERRUPT_LATENCY = 0,
+	PREEMPT_LATENCY,
+	WAKEUP_LATENCY
+};
+
+static struct proc_dir_entry * latency_log_root = NULL;
+static char * latency_log_proc_dir_root = "latency_log";
+
+static char * percpu_proc_name = "CPU";
+
+#ifdef CONFIG_INTERRUPT_OFF_LOG
+static DEFINE_PER_CPU(log_data_t, interrupt_off_log);
+static char * interrupt_off_log_proc_dir = "interrupt_off_latency";
+#endif
+
+#ifdef CONFIG_PREEMPT_OFF_LOG
+static DEFINE_PER_CPU(log_data_t, preempt_off_log);
+static char * preempt_off_log_proc_dir = "preempt_off_latency";
+#endif
+
+#ifdef CONFIG_WAKEUP_LATENCY_LOG
+static DEFINE_PER_CPU(log_data_t, wakeup_latency_log);
+static char * wakeup_latency_log_proc_dir = "wakeup_latency";
+#endif
+
+static struct proc_dir_entry *entry[LATENCY_TYPE_NUM][NR_CPUS];
+
+static inline u64 u64_div(u64 x, u64 y)
+{
+        do_div(x, y);
+        return x;
+}
+
+void latency_log(int latency_type, int cpu, unsigned long latency)
+{
+	log_data_t * my_log;
+
+
+	if ((cpu < 0) || (cpu >= NR_CPUS) || (latency_type <
INTERRUPT_LATENCY)
+		|| (latency_type > WAKEUP_LATENCY) || (latency < 0)) {
+		return;
+	}
+
+	switch(latency_type) {
+#ifdef CONFIG_INTERRUPT_OFF_LOG
+	case INTERRUPT_LATENCY:
+		my_log = (log_data_t *)&per_cpu(interrupt_off_log, cpu);
+		if (atomic_read(&my_log->log_mode) == 0) {
+			return;
+		}
+		break;
+#endif
+
+#ifdef CONFIG_PREEMPT_OFF_LOG
+	case PREEMPT_LATENCY:
+		my_log = (log_data_t *)&per_cpu(preempt_off_log, cpu);
+		if (atomic_read(&my_log->log_mode) == 0) {
+			return;
+		}
+		break;
+#endif
+
+#ifdef CONFIG_WAKEUP_LATENCY_LOG
+	case WAKEUP_LATENCY:
+		my_log = (log_data_t *)&per_cpu(wakeup_latency_log, cpu);
+		if (atomic_read(&my_log->log_mode) == 0) {
+			return;
+		}
+		break;
+#endif
+	default:
+		return;
+	}
+
+	if (latency >= MAX_ENTRY_NUM) {
+		my_log->beyond_log_bound_samples++;
+	}
+	else {
+		my_log->log_array[latency]++;
+	}
+
+	if (latency < my_log->min_lat) {
+		my_log->min_lat = latency;
+	}
+	else if (latency > my_log->max_lat) { 
+		my_log->max_lat = latency;
+	}
+
+	my_log->total_samples++;
+	my_log->accumulate_lat += latency;
+	my_log->avg_lat = (unsigned long)u64_div(my_log->accumulate_lat,
my_log->total_samples);
+	return;
+}
+
+static void *l_start(struct seq_file *m, loff_t * pos)
+{
+	loff_t *index_ptr = kmalloc(sizeof(loff_t), GFP_KERNEL);
+	loff_t index = *pos;
+	log_data_t *my_log = (log_data_t *) m->private;
+
+	if (index_ptr == NULL) {
+		return NULL;
+	}
+
+	if (index == 0) {
+		atomic_dec(&my_log->log_mode);
+		seq_printf(m, "#Minimum latency: %lu microseconds.\n"
+			   "#Average latency: %lu microseconds.\n"
+			   "#Maximum latency: %lu microseconds.\n"
+			   "#Total samples: %llu\n"
+			   "#There are %llu samples greater or equal than %d microseconds\n"
+			   "#usecs\t%16s\n"
+			   , my_log->min_lat
+			   , my_log->avg_lat
+			   , my_log->max_lat
+			   , my_log->total_samples
+			   , my_log->beyond_log_bound_samples
+			   , MAX_ENTRY_NUM, "samples");
+	}
+	if (index >= MAX_ENTRY_NUM) {
+		return NULL;
+	}
+
+	*index_ptr = index;
+	return index_ptr;
+}
+
+static void *l_next(struct seq_file *m, void *p, loff_t * pos)
+{
+	loff_t *index_ptr = p;
+	log_data_t *my_log = (log_data_t *) m->private;
+
+	if (++*pos >= MAX_ENTRY_NUM) {
+		atomic_inc(&my_log->log_mode);
+		return NULL;
+	}
+	*index_ptr = *pos;
+	return index_ptr;
+}
+
+static void l_stop(struct seq_file *m, void *p)
+{
+	kfree(p);
+}
+
+static int l_show(struct seq_file *m, void *p)
+{
+	int index = *(loff_t *) p;
+	log_data_t *my_log = (log_data_t *) m->private;
+
+	seq_printf(m, "%5d\t%16llu\n", index
+		, my_log->log_array[index]);
+	return 0;
+}
+
+static struct seq_operations latency_log_seq_op = {
+	.start = l_start,
+	.next = l_next,
+	.stop = l_stop,
+	.show = l_show
+};
+
+static int latency_log_seq_open(struct inode *inode, struct file *file)
+{
+	int ret;
+	struct proc_dir_entry *entry_ptr = NULL;
+	int i, j;
+	struct seq_file *seq;
+	int break_flags = 0;
+
+	entry_ptr = PDE(file->f_dentry->d_inode);
+	for (i = 0; i < LATENCY_TYPE_NUM; i++) {
+		for (j = 0; j < NR_CPUS; j++) {
+			if (entry[i][j] == NULL) {
+				continue;
+			}
+			if (entry_ptr->low_ino == entry[i][j]->low_ino) {
+				break_flags = 1;
+				break;
+			}
+		}
+		if (break_flags == 1) {
+			break;
+		}
+	}
+	ret = seq_open(file, &latency_log_seq_op);
+	if (break_flags == 1) {
+		seq = (struct seq_file *)file->private_data;
+		seq->private = entry[i][j]->data;
+	}
+	return ret;
+}
+static struct file_operations latency_log_seq_fops = {
+	.open = latency_log_seq_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release,
+};
+
+static __init int latency_log_init(void)
+{
+	struct proc_dir_entry *tmp_parent_proc_dir;
+	char procname[64];
+	int len = 0;
+	int i = 0;
+	log_data_t *my_log;
+
+	latency_log_root = proc_mkdir(latency_log_proc_dir_root, NULL);
+
+	
+#ifdef CONFIG_INTERRUPT_OFF_LOG
+	tmp_parent_proc_dir = proc_mkdir(interrupt_off_log_proc_dir,
latency_log_root);
+	for (i = 0; i < NR_CPUS; i++) {
+		len = sprintf(procname, "%s%d", percpu_proc_name, i);
+		procname[len] = '\0';
+		entry[INTERRUPT_LATENCY][i] =
+			create_proc_entry(procname, 0, tmp_parent_proc_dir);
+		entry[INTERRUPT_LATENCY][i]->data = (void
*)&per_cpu(interrupt_off_log, i);
+		entry[INTERRUPT_LATENCY][i]->proc_fops = &latency_log_seq_fops;
+		my_log = (log_data_t *) entry[INTERRUPT_LATENCY][i]->data;
+		atomic_set(&my_log->log_mode,1);
+		my_log->min_lat = 0xFFFFFFFFUL;
+	}
+#endif
+
+#ifdef CONFIG_PREEMPT_OFF_LOG
+	tmp_parent_proc_dir = proc_mkdir(preempt_off_log_proc_dir,
latency_log_root);
+	for (i = 0; i < NR_CPUS; i++) {
+		len = sprintf(procname, "%s%d", percpu_proc_name, i);
+		procname[len] = '\0';
+		entry[PREEMPT_LATENCY][i] =
+			create_proc_entry(procname, 0, tmp_parent_proc_dir);
+		entry[PREEMPT_LATENCY][i]->data = (void *)&per_cpu(preempt_off_log,
i);
+                entry[PREEMPT_LATENCY][i]->proc_fops =
&latency_log_seq_fops;
+		my_log = (log_data_t *) entry[PREEMPT_LATENCY][i]->data;
+		atomic_set(&my_log->log_mode,1); 
+		my_log->min_lat = 0xFFFFFFFFUL;
+	}
+#endif
+
+#ifdef CONFIG_WAKEUP_LATENCY_LOG
+	tmp_parent_proc_dir = proc_mkdir(wakeup_latency_log_proc_dir,
latency_log_root);
+	for (i = 0; i < NR_CPUS; i++) {
+		len = sprintf(procname, "%s%d", percpu_proc_name, i);
+		procname[len] = '\0';
+		entry[WAKEUP_LATENCY][i] =
+			create_proc_entry(procname, 0, tmp_parent_proc_dir);
+                entry[WAKEUP_LATENCY][i]->data = (void
*)&per_cpu(wakeup_latency_log, i);
+                entry[WAKEUP_LATENCY][i]->proc_fops =
&latency_log_seq_fops;
+		my_log = (log_data_t *) entry[WAKEUP_LATENCY][i]->data;
+		atomic_set(&my_log->log_mode,1); 
+		my_log->min_lat = 0xFFFFFFFFUL;
+	}
+#endif
+	return 0;
+
+}
+
+__initcall(latency_log_init);
--- linux-2.6.12/kernel/latency.c.orig	2005-07-15 17:45:10.000000000
+0800
+++ linux-2.6.12/kernel/latency.c	2005-07-15 17:45:53.000000000 +0800
@@ -23,6 +23,20 @@
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
 
+#ifdef CONFIG_LATENCY_LOG
+enum {
+	INTERRUPT_LATENCY = 0,
+	PREEMPT_LATENCY,
+	WAKEUP_LATENCY
+};
+extern void latency_log(int latency_type, int cpu, unsigned long
latency);
+
+#ifdef CONFIG_INTERRUPT_OFF_LOG
+static inline int is_interrupt_off_timing(void);
+#endif
+
+#endif
+
 #ifdef CONFIG_PPC
 #include <asm/time.h>
 #endif
@@ -60,7 +74,12 @@ int wakeup_timing = 1;
  * Maximum preemption latency measured. Initialize to maximum,
  * we clear it after bootup.
  */
+#ifdef CONFIG_LATENCY_LOG
+static cycles_t preempt_max_latency = (cycles_t)0UL;
+#else
 static cycles_t preempt_max_latency = (cycles_t)ULONG_MAX;
+#endif
+
 static cycles_t preempt_thresh;
 
 /*
@@ -1220,6 +1239,9 @@ check_critical_timing(int cpu, struct cp
 {
 	unsigned long latency, t0, t1;
 	cycles_t T0, T1, T2, delta;
+#ifdef CONFIG_CRITICAL_LATENCY_LOG
+	int latency_type;
+#endif
 
 	if (trace_user_triggered)
 		return;
@@ -1231,8 +1253,10 @@ check_critical_timing(int cpu, struct cp
 	T1 = cycles();
 	delta = T1-T0;
 
+#ifndef CONFIG_CRITICAL_LATENCY_LOG
 	if (!report_latency(delta))
 		goto out;
+#endif
 	____trace(cpu, TRACE_FN, tr, CALLER_ADDR0, parent_eip, 0, 0, 0);
 	/*
 	 * Update the timestamp, because the trace entry above
@@ -1247,21 +1271,29 @@ check_critical_timing(int cpu, struct cp
 	if (tr->critical_sequence != max_sequence || down_trylock(&max_mutex))
 		goto out;
 
+
+#ifndef CONFIG_CRITICAL_LATENCY_LOG
 	if (!preempt_thresh && preempt_max_latency > delta) {
 		printk("bug: updating %016Lx > %016Lx?\n",
 			preempt_max_latency, delta);
 		printk("  [%016Lx %016Lx %016Lx]\n", T0, T1, T2);
 	}
+#endif
 
+	latency = cycles_to_usecs(delta);
+
+#ifdef CONFIG_CRITICAL_LATENCY_LOG
+if (preempt_max_latency < delta) {
+#endif
 	preempt_max_latency = delta;
 	t0 = cycles_to_usecs(T0);
 	t1 = cycles_to_usecs(T1);
-	latency = cycles_to_usecs(delta);
 
 	tr->critical_end = parent_eip;
 
 	update_max_tr(tr);
 
+#ifndef CONFIG_CRITICAL_LATENCY_LOG
 	if (preempt_thresh)
 		printk("(%16s-%-5d|#%d): %lu us critical section "
 			"violates %lu us threshold.\n"
@@ -1282,10 +1314,35 @@ check_critical_timing(int cpu, struct cp
 	dump_stack();
 	t1 = cycles_to_usecs(cycles());
 	printk(" =>   dump-end timestamp %lu\n\n", t1);
+#endif
 
 	max_sequence++;
 
+#ifdef CONFIG_CRITICAL_LATENCY_LOG
+}
+#endif
+
 	up(&max_mutex);
+
+#ifdef CONFIG_CRITICAL_LATENCY_LOG
+	latency_type = WAKEUP_LATENCY + 1;
+#ifdef CONFIG_INTERRUPT_OFF_LOG
+	if (is_interrupt_off_timing()) {
+                	latency_type = INTERRUPT_LATENCY;
+	}
+#ifdef CONFIG_PREEMPT_OFF_LOG
+	else {
+		latency_type = PREEMPT_LATENCY;
+	}
+#endif /* CONFIG_PREEMPT_OFF_LOG */
+#else
+#ifdef CONFIG_PREEMPT_OFF_LOG
+	latency_type = PREEMPT_LATENCY;
+#endif /* CONFIG_PREEMPT_OFF_LOG */
+#endif /* CONFIG_INTERRUPT_OFF_LOG */
+	latency_log(latency_type, cpu, latency);
+#endif /* CONFIG_CRITICAL_LATENCY_LOG */
+
 out:
 	tr->critical_sequence = max_sequence;
 	tr->preempt_timestamp = cycles();
@@ -1293,6 +1350,7 @@ out:
 	tr->trace_idx = 0;
 	_trace_cmdline(cpu, tr);
 	____trace(cpu, TRACE_FN, tr, CALLER_ADDR0, parent_eip, 0, 0, 0);
+
 }
 
 void notrace touch_critical_timing(void)
@@ -1371,6 +1429,17 @@ __stop_critical_timing(unsigned long eip
 # define irqs_off_preempt_count() 0
 #endif
 
+#ifdef CONFIG_INTERRUPT_OFF_LOG
+static inline int is_interrupt_off_timing(void)
+{
+	unsigned long flags;
+
+	raw_local_save_flags(flags);
+
+	return (!irqs_off_preempt_count() && raw_irqs_disabled_flags(flags));
+} 
+#endif
+
 void notrace trace_irqs_off_lowlevel(void)
 {
 	unsigned long flags;
@@ -1575,6 +1644,9 @@ check_wakeup_timing(struct cpu_trace *tr
 	unsigned long latency;
 	unsigned long t0, t1;
 	cycles_t T0, T1, T2, delta;
+#ifdef CONFIG_WAKEUP_LATENCY_LOG
+	int cpu = _smp_processor_id();
+#endif
 
 	if (trace_user_triggered)
 		return;
@@ -1593,8 +1665,10 @@ check_wakeup_timing(struct cpu_trace *tr
 		T0 = T1;
 	delta = T1-T0;
 
+#ifndef CONFIG_WAKEUP_LATENCY_LOG
 	if (!report_latency(delta))
 		goto out;
+#endif
 
 	____trace(smp_processor_id(), TRACE_FN, tr, CALLER_ADDR0, parent_eip,
0, 0, 0);
 	T2 = cycles();
@@ -1605,21 +1679,27 @@ check_wakeup_timing(struct cpu_trace *tr
 	if (tr->critical_sequence != max_sequence || down_trylock(&max_mutex))
 		goto out;
 
+#ifndef CONFIG_WAKEUP_LATENCY_LOG
 	if (!preempt_thresh && preempt_max_latency > delta) {
 		printk("bug2: updating %016Lx > %016Lx?\n",
 			preempt_max_latency, delta);
 		printk("  [%016Lx %016Lx %016Lx]\n", T0, T1, T2);
 	}
+#endif
 
+	latency = cycles_to_usecs(delta);
+
+#ifdef CONFIG_WAKEUP_LATENCY_LOG
+if (preempt_max_latency < delta) {
+#endif
 	preempt_max_latency = delta;
 	t0 = cycles_to_usecs(T0);
 	t1 = cycles_to_usecs(T1);
-	latency = cycles_to_usecs(delta);
-
 	tr->critical_end = parent_eip;
 
 	update_max_tr(tr);
 
+#ifndef CONFIG_WAKEUP_LATENCY_LOG
 	if (preempt_thresh)
 		printk("(%16s-%-5d|#%d): %lu us wakeup latency "
 			"violates %lu us threshold.\n",
@@ -1630,12 +1710,22 @@ check_wakeup_timing(struct cpu_trace *tr
 		printk("(%16s-%-5d|#%d): new %lu us maximum-latency "
 			"wakeup.\n", current->comm, current->pid,
 				_smp_processor_id(), latency);
+#endif
 
 	max_sequence++;
 
+#ifdef CONFIG_WAKEUP_LATENCY_LOG
+}
+#endif
 	up(&max_mutex);
+
+#ifdef CONFIG_WAKEUP_LATENCY_LOG
+	latency_log(WAKEUP_LATENCY, cpu, latency);
+#endif
+
 out:
 	atomic_dec(&tr->disabled);
+
 }
 
 /*
--- linux-2.6.12/kernel/Makefile.orig	2005-07-15 17:44:56.000000000
+0800
+++ linux-2.6.12/kernel/Makefile	2005-07-15 17:45:53.000000000 +0800
@@ -13,6 +13,7 @@ obj-$(CONFIG_PREEMPT_RT) += rt.o
 
 obj-$(CONFIG_DEBUG_PREEMPT) += latency.o
 obj-$(CONFIG_LATENCY_TIMING) += latency.o
+obj-$(CONFIG_LATENCY_LOG) += latency_log.o
 
 obj-$(CONFIG_FUTEX) += futex.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
--- linux-2.6.12/lib/Kconfig.debug.orig	2005-07-15 17:45:34.000000000
+0800
+++ linux-2.6.12/lib/Kconfig.debug	2005-07-15 18:07:15.000000000 +0800
@@ -143,6 +143,21 @@ config WAKEUP_TIMING
 
 	      echo 0 > /proc/sys/kernel/preempt_max_latency
 
+config WAKEUP_LATENCY_LOG
+	bool "Log wakeup latency"
+	default n
+	depends on WAKEUP_TIMING
+	help
+	  This option logs all the wakeup latency timing to a big histogram
+	  bucket, in the meanwhile, it also dummies up printk produced by 
+	  wakeup latency timing.
+
+	  The wakeup latency timing histogram can be viewed via:
+
+	      cat /proc/latency_log/wakeup_latency/CPU*
+
+	  (Note: * presents CPU ID.)
+
 config PREEMPT_TRACE
 	bool
 	default y
@@ -165,6 +180,23 @@ config CRITICAL_PREEMPT_TIMING
 	  enabled. This option and the irqs-off timing option can be
 	  used together or separately.)
 
+config PREEMPT_OFF_LOG
+        bool "Log non-preemptible critical section latency"
+        default n
+        depends on CRITICAL_PREEMPT_TIMING
+        help
+          This option logs all the non-preemptible critical section
latency
+	  timing to a big histogram bucket, in the meanwhile, it also 
+	  dummies up printk produced by non-preemptible critical section
+	  latency timing.
+
+          The non-preemptible critical section latency timing histogram
can
+	  be viewed via:
+
+              cat /proc/latency_log/preempt_off_latency/CPU*
+
+          (Note: * presents CPU ID.)
+
 config CRITICAL_IRQSOFF_TIMING
 	bool "Interrupts-off critical section latency timing"
 	default n
@@ -181,6 +213,23 @@ config CRITICAL_IRQSOFF_TIMING
 	  enabled. This option and the preempt-off timing option can be
 	  used together or separately.)
 
+config INTERRUPT_OFF_LOG
+        bool "Log interrupts-off critical section latency"
+        default n
+        depends on CRITICAL_IRQSOFF_TIMING
+        help
+          This option logs all the interrupts-off critical section
latency 
+          timing to a big histogram bucket, in the meanwhile, it also 
+          dummies up printk produced by interrupts-off critical section
+          latency timing.
+
+          The interrupts-off critical section latency timing histogram
can 
+          be viewed via:
+
+              cat /proc/latency_log/interrupt_off_latency/CPU*
+
+          (Note: * presents CPU ID.)
+
 config CRITICAL_TIMING
 	bool
 	default y
@@ -191,6 +240,16 @@ config LATENCY_TIMING
 	default y
 	depends on WAKEUP_TIMING || CRITICAL_TIMING
 
+config CRITICAL_LATENCY_LOG
+	bool
+	default y
+	depends on PREEMPT_OFF_LOG || INTERRUPT_OFF_LOG
+
+config LATENCY_LOG
+	bool
+	default y
+	depends on WAKEUP_LATENCY_LOG || CRITICAL_LATENCY_LOG
+
 config LATENCY_TRACE
 	bool "Latency tracing"
 	default n


