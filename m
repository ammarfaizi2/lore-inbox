Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263165AbSIPWLD>; Mon, 16 Sep 2002 18:11:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263167AbSIPWLD>; Mon, 16 Sep 2002 18:11:03 -0400
Received: from h00010256f583.ne.client2.attbi.com ([66.30.243.14]:2518 "EHLO
	portent.dyndns.org") by vger.kernel.org with ESMTP
	id <S263165AbSIPWLA>; Mon, 16 Sep 2002 18:11:00 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Lev Makhlis <mlev@despammed.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC] [PATCH] [2.5.35] Run Queue Statistics
Date: Mon, 16 Sep 2002 18:20:44 -0400
User-Agent: KMail/1.4.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200209161820.44702.mlev@despammed.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds two counters, runque and runocc, similar to those
in traditional UNIX systems, to measure the run queue occupancy.
Every second, 'runque' is incremented by the run queue size, and
'runocc' is incremented by one if the run queue is not empty.

I am not comfortable about putting the calculation in the same function
as the load average calculation, but I didn't want to call
count_active_tasks() twice. Comments are welcome.

Lev

--------------------------------------------------------------------------
diff -urN linux-2.5.35.orig/fs/proc/proc_misc.c 
linux-2.5.35/fs/proc/proc_misc.c
--- linux-2.5.35.orig/fs/proc/proc_misc.c	Sun Sep 15 22:18:21 2002
+++ linux-2.5.35/fs/proc/proc_misc.c	Mon Sep 16 13:36:14 2002
@@ -386,7 +386,8 @@
 		"allocstall %u\n"
 		"ctxt %lu\n"
 		"btime %lu\n"
-		"processes %lu\n",
+		"processes %lu\n"
+		"runque %u %u\n",
 		kstat.pgalloc,
 		kstat.pgfree,
 		kstat.pgactivate,
@@ -399,7 +400,9 @@
 		kstat.allocstall,
 		nr_context_switches(),
 		xtime.tv_sec - jif / HZ,
-		total_forks);
+		total_forks,
+		kstat.runque,
+		kstat.runocc);
 
 	return proc_calc_metrics(page, start, off, count, eof, len);
 }
diff -urN linux-2.5.35.orig/include/linux/kernel_stat.h 
linux-2.5.35/include/linux/kernel_stat.h
--- linux-2.5.35.orig/include/linux/kernel_stat.h	Sun Sep 15 22:18:27 2002
+++ linux-2.5.35/include/linux/kernel_stat.h	Mon Sep 16 13:35:30 2002
@@ -31,6 +31,7 @@
 	unsigned int pgfault, pgmajfault;
 	unsigned int pgscan, pgsteal;
 	unsigned int pageoutrun, allocstall;
+	unsigned int runque, runocc;
 #if !defined(CONFIG_ARCH_S390)
 	unsigned int irqs[NR_CPUS][NR_IRQS];
 #endif
diff -urN linux-2.5.35.orig/kernel/timer.c linux-2.5.35/kernel/timer.c
--- linux-2.5.35.orig/kernel/timer.c	Sun Sep 15 22:18:24 2002
+++ linux-2.5.35/kernel/timer.c	Mon Sep 16 13:36:31 2002
@@ -592,11 +592,11 @@
 }
 
 /*
- * Nr of active tasks - counted in fixed-point numbers
+ * Nr of active tasks
  */
 static unsigned long count_active_tasks(void)
 {
-	return (nr_running() + nr_uninterruptible()) * FIXED_1;
+	return nr_running() + nr_uninterruptible();
 }
 
 /*
@@ -615,16 +615,29 @@
  */
 static inline void calc_load(unsigned long ticks)
 {
-	unsigned long active_tasks; /* fixed-point */
-	static int count = LOAD_FREQ;
+	unsigned long active_tasks;
+	unsigned long fp_active_tasks; /* fixed-point */
+	static int load_count = LOAD_FREQ;
+	static int runq_count = HZ;
 
-	count -= ticks;
-	if (count < 0) {
-		count += LOAD_FREQ;
+	load_count -= ticks;
+	runq_count -= ticks;
+	if (load_count < 0 || runq_count < 0) {
 		active_tasks = count_active_tasks();
-		CALC_LOAD(avenrun[0], EXP_1, active_tasks);
-		CALC_LOAD(avenrun[1], EXP_5, active_tasks);
-		CALC_LOAD(avenrun[2], EXP_15, active_tasks);
+		if (runq_count < 0) {
+			runq_count += HZ;
+			if (active_tasks) {
+				kstat.runque += active_tasks;
+				kstat.runocc ++;
+			}
+		}
+		if (load_count < 0) {
+			load_count += LOAD_FREQ;
+			fp_active_tasks = active_tasks * FIXED_1;
+			CALC_LOAD(avenrun[0], EXP_1, fp_active_tasks);
+			CALC_LOAD(avenrun[1], EXP_5, fp_active_tasks);
+			CALC_LOAD(avenrun[2], EXP_15, fp_active_tasks);
+		}
 	}
 }
 
