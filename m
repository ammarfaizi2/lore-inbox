Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932208AbVHKBp3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbVHKBp3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 21:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932209AbVHKBp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 21:45:28 -0400
Received: from out01.east.net ([210.56.193.7]:668 "EHLO out01.east.net")
	by vger.kernel.org with ESMTP id S932208AbVHKBp1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 21:45:27 -0400
Subject: [Patch]: latency histogram patch cleanup
From: yangyi <yang.yi@bmrtech.com>
Reply-To: yang.yi@bmrtech.com
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: bmrtech
Message-Id: <1123753388.4092.173.camel@montavista2>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 11 Aug 2005 09:43:08 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ingo

According to your suggestion, I check your cleanup and correct some errors and modify latency type decision.

This patch corrects some latency histogram configration options name, adds 
a field to cpu_trace struct, removes that ugly latenct type decision statement
 block, adds a latency_type parameter to __start_critical_timing. 

diffstat:
 kernel/latency.c  |   51 +++++++++++++++------------------------------------
 lib/Kconfig.debug |    4 ++--
 2 files changed, 17 insertions(+), 38 deletions(-)

--- linux-2.6.12/lib/Kconfig.debug.orig	2005-08-10 12:07:13.000000000 +0800
+++ linux-2.6.12/lib/Kconfig.debug	2005-08-10 12:07:32.000000000 +0800
@@ -180,7 +180,7 @@ config CRITICAL_PREEMPT_TIMING
 	  enabled. This option and the irqs-off timing option can be
 	  used together or separately.)
 
-config PREEMPT_OFF_LOG
+config PREEMPT_OFF_HIST
         bool "non-preemptible critical section latency histogram"
         default n
         depends on CRITICAL_PREEMPT_TIMING
@@ -244,7 +244,7 @@ config LATENCY_TIMING
 config CRITICAL_LATENCY_HIST
 	bool
 	default y
-	depends on PREEMPT_OFF_LOG || INTERRUPT_OFF_LOG
+	depends on PREEMPT_OFF_HIST || INTERRUPT_OFF_HIST
 
 config LATENCY_HIST
 	bool
--- linux-2.6.12/kernel/latency.c.orig	2005-08-10 12:07:24.000000000 +0800
+++ linux-2.6.12/kernel/latency.c	2005-08-10 12:08:11.000000000 +0800
@@ -25,14 +25,16 @@
 #include <asm/rtc.h>
 
 
-#ifdef CONFIG_LATENCY_HIST
 
 enum {
 	INTERRUPT_LATENCY,
 	PREEMPT_LATENCY,
 	WAKEUP_LATENCY
 };
+
+#ifdef CONFIG_LATENCY_HIST
 extern void latency_hist(int latency_type, int cpu, unsigned long latency);
+#endif /* CONFIG_LATENCY_HIST */
 
 #ifdef CONFIG_CRITICAL_IRQSOFF_TIMING
 # ifdef CONFIG_CRITICAL_PREEMPT_TIMING
@@ -42,19 +44,6 @@ extern void latency_hist(int latency_typ
 # endif
 #endif
 
-#ifdef CONFIG_INTERRUPT_OFF_HIST
-static inline int is_interrupt_off_timing(void)
-{
-	unsigned long flags;
-
-	local_save_flags(flags);
-
-	return (!irqs_off_preempt_count() && raw_irqs_disabled_flags(flags));
-}
-#endif
-
-#endif
-
 #ifdef __i386__
 static inline cycles_t cycles(void)
 {
@@ -198,6 +187,7 @@ struct cpu_trace {
 	unsigned long critical_start, critical_end;
 	int critical_sequence;
 	int early_warning;
+	int latency_type;
 
 #ifdef CONFIG_LATENCY_TRACE
 	struct trace_entry trace[MAX_TRACE];
@@ -1362,9 +1352,6 @@ check_critical_timing(int cpu, struct cp
 {
 	unsigned long latency, t0, t1;
 	cycles_t T0, T1, T2, delta;
-#ifdef CONFIG_CRITICAL_LATENCY_HIST
-	int latency_type;
-#endif
 
 	if (trace_user_triggered)
 		return;
@@ -1376,8 +1363,10 @@ check_critical_timing(int cpu, struct cp
 	T1 = cycles();
 	delta = T1-T0;
 
+#ifndef CONFIG_CRITICAL_LATENCY_HIST
 	if (!report_latency(delta))
 		goto out;
+#endif
 
 	____trace(cpu, TRACE_FN, tr, CALLER_ADDR0, parent_eip, 0, 0, 0);
 	/*
@@ -1393,11 +1382,13 @@ check_critical_timing(int cpu, struct cp
 	if (tr->critical_sequence != max_sequence || down_trylock(&max_mutex))
 		goto out;
 
+#ifndef CONFIG_CRITICAL_LATENCY_HIST
 	if (!preempt_thresh && preempt_max_latency > delta) {
 		printk("bug: updating %016Lx > %016Lx?\n",
 			preempt_max_latency, delta);
 		printk("  [%016Lx %016Lx %016Lx]\n", T0, T1, T2);
 	}
+#endif
 
 	latency = cycles_to_usecs(delta);
 
@@ -1445,20 +1436,7 @@ if (preempt_max_latency < delta) {
 	up(&max_mutex);
 
 #ifdef CONFIG_CRITICAL_LATENCY_HIST
-	latency_type = WAKEUP_LATENCY + 1;
-#ifdef CONFIG_INTERRUPT_OFF_HIST
-	if (is_interrupt_off_timing())
-		latency_type = INTERRUPT_LATENCY;
-#ifdef CONFIG_PREEMPT_OFF_HIST
-	else
-		latency_type = PREEMPT_LATENCY;
-#endif /* CONFIG_PREEMPT_OFF_HIST */
-#else
-#ifdef CONFIG_PREEMPT_OFF_HIST
-	latency_type = PREEMPT_LATENCY;
-#endif /* CONFIG_PREEMPT_OFF_HIST */
-#endif /* CONFIG_INTERRUPT_OFF_HIST */
-	latency_hist(latency_type, cpu, latency);
+	latency_hist(tr->latency_type, cpu, latency);
 #endif /* CONFIG_CRITICAL_LATENCY_HIST */
 
 out:
@@ -1499,7 +1477,7 @@ void notrace stop_critical_timing(void)
 EXPORT_SYMBOL(stop_critical_timing);
 
 static inline void notrace
-__start_critical_timing(unsigned long eip, unsigned long parent_eip)
+__start_critical_timing(unsigned long eip, unsigned long parent_eip, int latency_type)
 {
 	int cpu = raw_smp_processor_id();
 	struct cpu_trace *tr = cpu_traces + cpu;
@@ -1514,6 +1492,7 @@ __start_critical_timing(unsigned long ei
 	tr->preempt_timestamp = cycles();
 	tr->critical_start = eip;
 	tr->trace_idx = 0;
+	tr->latency_type = latency_type;
 	_trace_cmdline(cpu, tr);
 	____trace(cpu, TRACE_FN, tr, eip, parent_eip, 0, 0, 0);
 
@@ -1548,7 +1527,7 @@ void notrace trace_irqs_off_lowlevel(voi
 	raw_local_save_flags(flags);
 
 	if (!irqs_off_preempt_count() && raw_irqs_disabled_flags(flags))
-		__start_critical_timing(CALLER_ADDR0, 0);
+		__start_critical_timing(CALLER_ADDR0, 0, INTERRUPT_LATENCY);
 }
 
 void notrace trace_irqs_off(void)
@@ -1558,7 +1537,7 @@ void notrace trace_irqs_off(void)
 	raw_local_save_flags(flags);
 
 	if (!irqs_off_preempt_count() && raw_irqs_disabled_flags(flags))
-		__start_critical_timing(CALLER_ADDR0, CALLER_ADDR1);
+		__start_critical_timing(CALLER_ADDR0, CALLER_ADDR1, INTERRUPT_LATENCY);
 }
 
 EXPORT_SYMBOL(trace_irqs_off);
@@ -1630,7 +1609,7 @@ void notrace add_preempt_count_ti(struct
 		if (!raw_irqs_disabled_flags(flags))
 #endif
 			if (preempt_count_ti(ti) == val)
-				__start_critical_timing(eip, parent_eip);
+				__start_critical_timing(eip, parent_eip, PREEMPT_LATENCY);
 	}
 #endif
 	(void)eip, (void)parent_eip;
@@ -1701,7 +1680,7 @@ void notrace mask_preempt_count(unsigned
 		if (!raw_irqs_disabled_flags(flags))
 #endif
 			if (preempt_count() == mask)
-				__start_critical_timing(eip, parent_eip);
+				__start_critical_timing(eip, parent_eip, PREEMPT_LATENCY);
 	}
 #endif
 	(void) eip, (void) parent_eip;


