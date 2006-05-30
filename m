Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932475AbWE3VXv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932475AbWE3VXv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 17:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932471AbWE3VXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 17:23:50 -0400
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:32733 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP id S932474AbWE3VXt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 17:23:49 -0400
Subject: [Patch] statistics infrastructure - update 3
From: Martin Peschke <mp3@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Tue, 30 May 2006 23:23:31 +0200
Message-Id: <1149024211.2937.21.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,
this patch makes printk_clock() a generic kernel-wide nsec-resolution
timestamp_clock(). It's used both by printk() as well as the
statistics infrastructure to provide unified time stamps to users.

Signed-off-by: Martin Peschke <mp3@de.ibm.com>
---

 arch/ia64/kernel/setup.c    |    4 ++--
 arch/ia64/kernel/time.c     |   15 ++++++++-------
 arch/ia64/sn/kernel/setup.c |    6 +++---
 include/linux/time.h        |    2 ++
 kernel/printk.c             |    7 +------
 kernel/time.c               |    5 +++++
 lib/statistic.c             |    8 ++++----
 7 files changed, 25 insertions(+), 22 deletions(-)

diff -urp a/arch/ia64/kernel/setup.c b/arch/ia64/kernel/setup.c
--- a/arch/ia64/kernel/setup.c	2006-05-30 22:23:11.000000000 +0200
+++ b/arch/ia64/kernel/setup.c	2006-05-30 22:29:30.000000000 +0200
@@ -71,7 +71,7 @@ unsigned long __per_cpu_offset[NR_CPUS];
 EXPORT_SYMBOL(__per_cpu_offset);
 #endif
 
-extern void ia64_setup_printk_clock(void);
+extern void ia64_setup_timestamp_clock(void);
 
 DEFINE_PER_CPU(struct cpuinfo_ia64, cpu_info);
 DEFINE_PER_CPU(unsigned long, local_per_cpu_offset);
@@ -436,7 +436,7 @@ setup_arch (char **cmdline_p)
 	/* process SAL system table: */
 	ia64_sal_init(__va(efi.sal_systab));
 
-	ia64_setup_printk_clock();
+	ia64_setup_timestamp_clock();
 
 #ifdef CONFIG_SMP
 	cpu_physical_id(0) = hard_smp_processor_id();
diff -urp a/arch/ia64/kernel/time.c b/arch/ia64/kernel/time.c
--- a/arch/ia64/kernel/time.c	2006-05-30 22:23:11.000000000 +0200
+++ b/arch/ia64/kernel/time.c	2006-05-30 22:29:30.000000000 +0200
@@ -279,29 +279,30 @@ udelay (unsigned long usecs)
 }
 EXPORT_SYMBOL(udelay);
 
-static unsigned long long ia64_itc_printk_clock(void)
+static unsigned long long ia64_itc_timestamp_clock(void)
 {
 	if (ia64_get_kr(IA64_KR_PER_CPU_DATA))
 		return sched_clock();
 	return 0;
 }
 
-static unsigned long long ia64_default_printk_clock(void)
+static unsigned long long ia64_default_timestamp_clock(void)
 {
 	return (unsigned long long)(jiffies_64 - INITIAL_JIFFIES) *
 		(1000000000/HZ);
 }
 
-unsigned long long (*ia64_printk_clock)(void) = &ia64_default_printk_clock;
+unsigned long long (*ia64_timestamp_clock)(void) =
+						&ia64_default_timestamp_clock;
 
-unsigned long long printk_clock(void)
+unsigned long long timestamp_clock(void)
 {
-	return ia64_printk_clock();
+	return ia64_timestamp_clock();
 }
 
 void __init
-ia64_setup_printk_clock(void)
+ia64_setup_timestamp_clock(void)
 {
 	if (!(sal_platform_features & IA64_SAL_PLATFORM_FEATURE_ITC_DRIFT))
-		ia64_printk_clock = ia64_itc_printk_clock;
+		ia64_timestamp_clock = ia64_itc_timestamp_clock;
 }
diff -urp a/arch/ia64/sn/kernel/setup.c b/arch/ia64/sn/kernel/setup.c
--- a/arch/ia64/sn/kernel/setup.c	2006-05-30 22:23:11.000000000 +0200
+++ b/arch/ia64/sn/kernel/setup.c	2006-05-30 22:29:30.000000000 +0200
@@ -67,7 +67,7 @@ extern unsigned long last_time_offset;
 extern void (*ia64_mark_idle) (int);
 extern void snidle(int);
 extern unsigned char acpi_kbd_controller_present;
-extern unsigned long long (*ia64_printk_clock)(void);
+extern unsigned long long (*ia64_timestamp_clock)(void);
 
 unsigned long sn_rtc_cycles_per_second;
 EXPORT_SYMBOL(sn_rtc_cycles_per_second);
@@ -364,7 +364,7 @@ sn_scan_pcdp(void)
 
 static unsigned long sn2_rtc_initial;
 
-static unsigned long long ia64_sn2_printk_clock(void)
+static unsigned long long ia64_sn2_timestamp_clock(void)
 {
 	unsigned long rtc_now = rtc_time();
 
@@ -451,7 +451,7 @@ void __init sn_setup(char **cmdline_p)
 
 	platform_intr_list[ACPI_INTERRUPT_CPEI] = IA64_CPE_VECTOR;
 
-	ia64_printk_clock = ia64_sn2_printk_clock;
+	ia64_timestamp_clock = ia64_sn2_timestamp_clock;
 
 	/*
 	 * Old PROMs do not provide an ACPI FADT. Disable legacy keyboard
diff -urp a/include/linux/time.h b/include/linux/time.h
--- a/include/linux/time.h	2006-05-30 22:23:16.000000000 +0200
+++ b/include/linux/time.h	2006-05-30 22:29:30.000000000 +0200
@@ -142,6 +142,8 @@ extern struct timespec ns_to_timespec(co
  */
 extern struct timeval ns_to_timeval(const s64 nsec);
 
+extern unsigned long long timestamp_clock(void);
+
 #endif /* __KERNEL__ */
 
 #define NFDBITS			__NFDBITS
diff -urp a/kernel/printk.c b/kernel/printk.c
--- a/kernel/printk.c	2006-05-30 22:25:12.000000000 +0200
+++ b/kernel/printk.c	2006-05-30 22:29:30.000000000 +0200
@@ -447,11 +447,6 @@ static int __init printk_time_setup(char
 
 __setup("time", printk_time_setup);
 
-__attribute__((weak)) unsigned long long printk_clock(void)
-{
-	return sched_clock();
-}
-
 /**
  * printk - print a kernel message
  * @fmt: format string
@@ -531,7 +526,7 @@ asmlinkage int vprintk(const char *fmt, 
 			if (printk_time) {
 				char tbuf[TIMESTAMP_SIZE], *tp;
 				printed_len += nsec_to_timestamp(tbuf,
-							printk_clock());
+							timestamp_clock());
 				for (tp = tbuf; *tp; tp++)
 					emit_log_char(*tp);
 				emit_log_char(' ');
diff -urp a/kernel/time.c b/kernel/time.c
--- a/kernel/time.c	2006-05-30 22:23:16.000000000 +0200
+++ b/kernel/time.c	2006-05-30 22:29:30.000000000 +0200
@@ -641,6 +641,11 @@ struct timeval ns_to_timeval(const s64 n
 	return tv;
 }
 
+__attribute__((weak)) unsigned long long timestamp_clock(void)
+{
+	return sched_clock();
+}
+
 #if (BITS_PER_LONG < 64)
 u64 get_jiffies_64(void)
 {
diff -urp a/lib/statistic.c b/lib/statistic.c
--- a/lib/statistic.c	2006-05-30 22:25:44.000000000 +0200
+++ b/lib/statistic.c	2006-05-30 22:29:30.000000000 +0200
@@ -152,7 +152,7 @@ static int statistic_alloc(struct statis
 			   struct statistic_info *info)
 {
 	int cpu, node;
-	stat->age = sched_clock();
+	stat->age = timestamp_clock();
 	if (unlikely(info->flags & STATISTIC_FLAGS_NOINCR)) {
 		stat->pdata = statistic_alloc_ptr(stat, -1);
 		if (unlikely(!stat->pdata))
@@ -177,7 +177,7 @@ static int statistic_alloc(struct statis
 
 static int statistic_start(struct statistic *stat)
 {
-	stat->started = sched_clock();
+	stat->started = timestamp_clock();
 	stat->state = STATISTIC_STATE_ON;
 	return 0;
 }
@@ -188,7 +188,7 @@ static void _statistic_barrier(void *unu
 
 static int statistic_stop(struct statistic *stat)
 {
-	stat->stopped = sched_clock();
+	stat->stopped = timestamp_clock();
 	stat->state = STATISTIC_STATE_OFF;
 	/* ensures that all CPUs have ceased updating statistics */
 	smp_mb();
@@ -243,7 +243,7 @@ static int statistic_reset(struct statis
 	else
 		for_each_possible_cpu(cpu)
 			statistic_reset_ptr(stat, stat->pdata->ptrs[cpu]);
-	stat->age = sched_clock();
+	stat->age = timestamp_clock();
 	statistic_transition(stat, info, prev_state);
 	return 0;
 }


