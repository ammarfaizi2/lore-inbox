Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbUCICXz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 21:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbUCICXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 21:23:55 -0500
Received: from alt.aurema.com ([203.217.18.57]:41600 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S261497AbUCICXm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 21:23:42 -0500
Date: Tue, 9 Mar 2004 13:23:38 +1100
From: Kingsley Cheung <kingsley@aurema.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] For preventing kstat overflow
Message-ID: <20040309132338.A30341@aurema.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi All,

What do people think of a patch to change the fields in cpu_usage_stat
from unsigned ints to unsigned long longs?  And the same change for
nr_switches in the runqueue structure too?

My colleagues and I believe this is necessary given that the accrued
usage for one CPU will overflow 32 bits fairly quickly if its
continuously busy.  If I understand it correctly, for HZ being 100,
overflow can occur in 497 days.  Its actually worse for context
switches on a busy system, for we've been seeing an average of ten
switches a tick for some of the statistics we have.

I haven't made any changes to the interrupt statistics to use unisnged
long long however.  Perhaps that should be considered as well, but
that'll mean changes to architecture dependent code...

-- 
		Kingsley

--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="kstat.patch"

diff -u -r1.1.1.1 proc_misc.c
--- Linux-2.6.3/fs/proc/proc_misc.c	23 Feb 2004 05:28:59 -0000	1.1.1.1
+++ Linux-2.6.3/fs/proc/proc_misc.c	9 Mar 2004 02:12:21 -0000
@@ -361,7 +361,7 @@
 	int i;
 	extern unsigned long total_forks;
 	unsigned long jif;
-	unsigned int sum = 0, user = 0, nice = 0, system = 0, idle = 0, iowait = 0, irq = 0, softirq = 0;
+	unsigned long long sum = 0, user = 0, nice = 0, system = 0, idle = 0, iowait = 0, irq = 0, softirq = 0;
 
 	jif = - wall_to_monotonic.tv_sec;
 	if (wall_to_monotonic.tv_nsec)
@@ -381,26 +381,26 @@
 			sum += kstat_cpu(i).irqs[j];
 	}
 
-	seq_printf(p, "cpu  %u %u %u %u %u %u %u\n",
-		jiffies_to_clock_t(user),
-		jiffies_to_clock_t(nice),
-		jiffies_to_clock_t(system),
-		jiffies_to_clock_t(idle),
-		jiffies_to_clock_t(iowait),
-		jiffies_to_clock_t(irq),
-		jiffies_to_clock_t(softirq));
+	seq_printf(p, "cpu  %llu %llu %llu %llu %llu %llu %llu\n",
+		jiffies_64_to_clock_t(user),
+		jiffies_64_to_clock_t(nice),
+		jiffies_64_to_clock_t(system),
+		jiffies_64_to_clock_t(idle),
+		jiffies_64_to_clock_t(iowait),
+		jiffies_64_to_clock_t(irq),
+		jiffies_64_to_clock_t(softirq));
 	for_each_online_cpu(i) {
-		seq_printf(p, "cpu%d %u %u %u %u %u %u %u\n",
+		seq_printf(p, "cpu%d %llu %llu %llu %llu %llu %llu %llu\n",
 			i,
-			jiffies_to_clock_t(kstat_cpu(i).cpustat.user),
-			jiffies_to_clock_t(kstat_cpu(i).cpustat.nice),
-			jiffies_to_clock_t(kstat_cpu(i).cpustat.system),
-			jiffies_to_clock_t(kstat_cpu(i).cpustat.idle),
-			jiffies_to_clock_t(kstat_cpu(i).cpustat.iowait),
-			jiffies_to_clock_t(kstat_cpu(i).cpustat.irq),
-			jiffies_to_clock_t(kstat_cpu(i).cpustat.softirq));
+			jiffies_64_to_clock_t(kstat_cpu(i).cpustat.user),
+			jiffies_64_to_clock_t(kstat_cpu(i).cpustat.nice),
+			jiffies_64_to_clock_t(kstat_cpu(i).cpustat.system),
+			jiffies_64_to_clock_t(kstat_cpu(i).cpustat.idle),
+			jiffies_64_to_clock_t(kstat_cpu(i).cpustat.iowait),
+			jiffies_64_to_clock_t(kstat_cpu(i).cpustat.irq),
+			jiffies_64_to_clock_t(kstat_cpu(i).cpustat.softirq));
 	}
-	seq_printf(p, "intr %u", sum);
+	seq_printf(p, "intr %llu", sum);
 
 #if !defined(CONFIG_PPC64) && !defined(CONFIG_ALPHA)
 	for (i = 0; i < NR_IRQS; i++)
@@ -408,7 +408,7 @@
 #endif
 
 	seq_printf(p,
-		"\nctxt %lu\n"
+		"\nctxt %llu\n"
 		"btime %lu\n"
 		"processes %lu\n"
 		"procs_running %lu\n"
diff -u -r1.1.1.1 kernel_stat.h
--- Linux-2.6.3/include/linux/kernel_stat.h	23 Feb 2004 05:28:47 -0000	1.1.1.1
+++ Linux-2.6.3/include/linux/kernel_stat.h	9 Mar 2004 02:12:21 -0000
@@ -14,13 +14,13 @@
  */
 
 struct cpu_usage_stat {
-	unsigned int user;
-	unsigned int nice;
-	unsigned int system;
-	unsigned int softirq;
-	unsigned int irq;
-	unsigned int idle;
-	unsigned int iowait;
+	unsigned long long user;
+	unsigned long long nice;
+	unsigned long long system;
+	unsigned long long softirq;
+	unsigned long long irq;
+	unsigned long long idle;
+	unsigned long long iowait;
 };
 
 struct kernel_stat {
@@ -34,7 +34,7 @@
 /* Must have preemption disabled for this to be meaningful. */
 #define kstat_this_cpu	__get_cpu_var(kstat)
 
-extern unsigned long nr_context_switches(void);
+extern unsigned long long nr_context_switches(void);
 
 /*
  * Number of interrupts per specific IRQ source, since bootup
diff -u -r1.1.1.1 sched.c
--- Linux-2.6.3/kernel/sched.c	23 Feb 2004 05:29:07 -0000	1.1.1.1
+++ Linux-2.6.3/kernel/sched.c	9 Mar 2004 02:12:21 -0000
@@ -199,8 +199,9 @@
  */
 struct runqueue {
 	spinlock_t lock;
-	unsigned long nr_running, nr_switches, expired_timestamp,
-		      nr_uninterruptible, timestamp_last_tick;
+	unsigned long long nr_switches;
+	unsigned long nr_running, expired_timestamp, nr_uninterruptible,
+		timestamp_last_tick;
 	task_t *curr, *idle;
 	struct mm_struct *prev_mm;
 	prio_array_t *active, *expired, arrays[2];
@@ -948,9 +949,9 @@
 	return sum;
 }
 
-unsigned long nr_context_switches(void)
+unsigned long long nr_context_switches(void)
 {
-	unsigned long i, sum = 0;
+	unsigned long long i, sum = 0;
 
 	for_each_cpu(i)
 		sum += cpu_rq(i)->nr_switches;

--ReaqsoxgOBHFXBhH--
