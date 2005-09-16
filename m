Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161018AbVIPDrU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161018AbVIPDrU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 23:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030589AbVIPDrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 23:47:20 -0400
Received: from [211.100.61.140] ([211.100.61.140]:44478 "EHLO smtp01.east.net")
	by vger.kernel.org with ESMTP id S1030588AbVIPDrU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 23:47:20 -0400
Subject: [PATCH]: Another latency histogram cleanup
From: yangyi <yang.yi@bmrtech.com>
Reply-To: yang.yi@bmrtech.com
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: bmrtech
Message-Id: <1126870970.22039.332.camel@montavista2>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 16 Sep 2005 11:42:50 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ingo

This is another latency histogram cleanup, changes include:

- Remove some definitons to include/linux/latency_hist.h from kenerl/latency.c and kernel/latency_hist.c
- Eliminate most #ifedf from check_critical_timing() and check_wakup_timing()

diffstat:

 include/linux/latency_hist.h |   32 ++++++++++++++++++++
 kernel/latency.c        |   67 ++++++++++++++-----------------------------
 kernel/latency_hist.c     |   12 +------
 3 files changed, 57 insertions(+), 54 deletions(-)


--- /dev/null	2003-12-29 18:00:06.000000000 +0800
+++ b/include/linux/latency_hist.h	2005-09-13 10:33:40.000000000 +0800
@@ -0,0 +1,32 @@
+/*
+ * kernel/latency_hist.h
+ *
+ * Add support for histograms of preemption-off latency and
+ * interrupt-off latency and wakeup latency, it depends on
+ * Real-Time Preemption Support.
+ *
+ *  Copyright (C) 2005 MontaVista Software, Inc.
+ *  Yi Yang <yyang@ch.mvista.com>
+ *
+ */
+#ifndef _LINUX_LATENCY_HIST_H_
+#define _LINUX_LATENCY_HIST_H_
+
+enum {
+        INTERRUPT_LATENCY = 0,
+        PREEMPT_LATENCY,
+        WAKEUP_LATENCY
+};
+
+#define MAX_ENTRY_NUM 10240
+#define LATENCY_TYPE_NUM 3
+
+#ifdef CONFIG_LATENCY_HIST
+extern void latency_hist(int latency_type, int cpu, unsigned long latency);
+#define latency_hist_flag 1
+#else
+#define latency_hist(a,b,c) do {} while(0)
+#define latency_hist_flag 0
+#endif /* CONFIG_LATENCY_HIST */
+
+#endif /* ifndef _LINUX_LATENCY_HIST_H_ */
--- a/kernel/latency.c.orig	2005-08-26 15:46:03.000000000 +0800
+++ b/kernel/latency.c	2005-09-13 11:00:58.000000000 +0800
@@ -20,21 +20,11 @@
 #include <linux/seq_file.h>
 #include <linux/interrupt.h>
 #include <linux/proc_fs.h>
+#include <linux/latency_hist.h>
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
 #include <asm/rtc.h>
 
-
-enum {
-	INTERRUPT_LATENCY,
-	PREEMPT_LATENCY,
-	WAKEUP_LATENCY
-};
-
-#ifdef CONFIG_LATENCY_HIST
-extern void latency_hist(int latency_type, int cpu, unsigned long latency);
-#endif /* CONFIG_LATENCY_HIST */
-
 #ifdef CONFIG_CRITICAL_IRQSOFF_TIMING
 # ifdef CONFIG_CRITICAL_PREEMPT_TIMING
 #  define irqs_off_preempt_count() preempt_count()
@@ -89,6 +79,9 @@ static cycles_t preempt_thresh;
  */
 static int report_latency(cycles_t delta)
 {
+	if (latency_hist_flag)
+		return 1;
+
 	if (preempt_thresh) {
 		if (delta < preempt_thresh)
 			return 0;
@@ -1322,10 +1315,9 @@ check_critical_timing(int cpu, struct cp
 
 	raw_local_save_flags(flags);
 
-#ifndef CONFIG_CRITICAL_LATENCY_HIST
 	if (!report_latency(delta))
 		goto out;
-#endif
+
 	____trace(cpu, TRACE_FN, tr, CALLER_ADDR0, parent_eip, 0, 0, 0, flags);
 	/*
 	 * Update the timestamp, because the trace entry above
@@ -1337,6 +1329,14 @@ check_critical_timing(int cpu, struct cp
 		printk("bug: %016Lx < %016Lx!\n", T2, T1);
 	delta = T2-T0;
 
+	latency = cycles_to_usecs(delta);
+	latency_hist(tr->latency_type, cpu, latency);
+	
+	if (latency_hist_flag) {
+		if (preempt_max_latency >= delta)
+			goto out;
+	}
+
 	if (tr->critical_sequence != max_sequence || down_trylock(&max_mutex))
 		goto out;
 
@@ -1348,12 +1348,6 @@ check_critical_timing(int cpu, struct cp
 	}
 #endif
 
-	latency = cycles_to_usecs(delta);
-
-#ifdef CONFIG_CRITICAL_LATENCY_HIST
-if (preempt_max_latency < delta) {
-#endif
-
 	preempt_max_latency = delta;
 	t0 = cycles_to_usecs(T0);
 	t1 = cycles_to_usecs(T1);
@@ -1387,16 +1381,8 @@ if (preempt_max_latency < delta) {
 
 	max_sequence++;
 
-#ifdef CONFIG_CRITICAL_LATENCY_HIST
-}
-#endif
-
 	up(&max_mutex);
 
-#ifdef CONFIG_CRITICAL_LATENCY_HIST
-	latency_hist(tr->latency_type, cpu, latency);
-#endif /* CONFIG_CRITICAL_LATENCY_HIST */
-
 out:
 	tr->critical_sequence = max_sequence;
 	tr->preempt_timestamp = cycles();
@@ -1684,9 +1670,7 @@ check_wakeup_timing(struct cpu_trace *tr
 {
 	unsigned long latency, t0, t1, flags;
 	cycles_t T0, T1, T2, delta;
-#ifdef CONFIG_WAKEUP_LATENCY_HIST
 	int cpu = raw_smp_processor_id();
-#endif
 
 	if (trace_user_triggered)
 		return;
@@ -1705,10 +1689,9 @@ check_wakeup_timing(struct cpu_trace *tr
 		T0 = T1;
 	delta = T1-T0;
 
-#ifndef CONFIG_WAKEUP_LATENCY_HIST
 	if (!report_latency(delta))
 		goto out;
-#endif
+
 	raw_local_save_flags(flags);
 	____trace(smp_processor_id(), TRACE_FN, tr, CALLER_ADDR0, parent_eip, 0, 0, 0, flags);
 	T2 = cycles();
@@ -1716,6 +1699,14 @@ check_wakeup_timing(struct cpu_trace *tr
 		printk("bug2: %016Lx < %016Lx!\n", T2, T1);
 	delta = T2-T0;
 
+	latency = cycles_to_usecs(delta);
+	latency_hist(tr->latency_type, cpu, latency);
+
+	if (latency_hist_flag) {
+		if (preempt_max_latency >= delta)
+			goto out;
+	}
+
 	if (tr->critical_sequence != max_sequence || down_trylock(&max_mutex))
 		goto out;
 
@@ -1727,11 +1718,6 @@ check_wakeup_timing(struct cpu_trace *tr
 	}
 #endif
 
-	latency = cycles_to_usecs(delta);
-
-#ifdef CONFIG_WAKEUP_LATENCY_HIST
-if (preempt_max_latency < delta) {
-#endif
 	preempt_max_latency = delta;
 	t0 = cycles_to_usecs(T0);
 	t1 = cycles_to_usecs(T1);
@@ -1754,16 +1740,8 @@ if (preempt_max_latency < delta) {
 
 	max_sequence++;
 
-#ifdef CONFIG_WAKEUP_LATENCY_HIST
-}
-#endif
-
 	up(&max_mutex);
 
-#ifdef CONFIG_WAKEUP_LATENCY_HIST
-	latency_hist(WAKEUP_LATENCY, cpu, latency);
-#endif
-
 out:
 	atomic_dec(&tr->disabled);
 }
@@ -1806,6 +1784,7 @@ void __trace_start_sched_wakeup(struct t
 //		atomic_inc(&tr->disabled);
 		tr->critical_sequence = max_sequence;
 		tr->preempt_timestamp = cycles();
+		tr->latency_type = WAKEUP_LATENCY;
 		tr->critical_start = CALLER_ADDR0;
 		_trace_cmdline(raw_smp_processor_id(), tr);
 //		atomic_dec(&tr->disabled);
--- a/kernel/latency_hist.c.orig	2005-09-13 11:14:17.000000000 +0800
+++ b/kernel/latency_hist.c	2005-09-13 11:19:05.000000000 +0800
@@ -5,7 +5,7 @@
  * interrupt-off latency and wakeup latency, it depends on
  * Real-Time Preemption Support.
  *
- *  Copyright (C) 2005, 2007 MontaVista Software, Inc.
+ *  Copyright (C) 2005 MontaVista Software, Inc.
  *  Yi Yang <yyang@ch.mvista.com>
  *
  */
@@ -14,11 +14,9 @@
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <linux/percpu.h>
+#include <linux/latency_hist.h>
 #include <asm/atomic.h>
 
-#define MAX_ENTRY_NUM 10240
-#define LATENCY_TYPE_NUM 3
-
 typedef struct hist_data_struct {
 	atomic_t hist_mode; /* 0 log, 1 don't log */
 	unsigned long min_lat;
@@ -30,12 +28,6 @@ typedef struct hist_data_struct {
 	unsigned long long hist_array[MAX_ENTRY_NUM];
 } hist_data_t;
 
-enum {
-	INTERRUPT_LATENCY = 0,
-	PREEMPT_LATENCY,
-	WAKEUP_LATENCY
-};
-
 static struct proc_dir_entry * latency_hist_root = NULL;
 static char * latency_hist_proc_dir_root = "latency_hist";
 


