Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262898AbUCRTnr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 14:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262903AbUCRTnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 14:43:47 -0500
Received: from ida.rowland.org ([192.131.102.52]:31492 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S262898AbUCRTn0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 14:43:26 -0500
Date: Thu, 18 Mar 2004 14:43:23 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Andrew Morton <akpm@osdl.org>
cc: Kernel development list <linux-kernel@vger.kernel.org>
Subject: PATCH: (as230) Work around compiler error in proc_misc.c
Message-ID: <Pine.LNX.4.44L0.0403181434100.3530-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew:

A change you recently applied to fs/proc/proc_misc.c included a comment
about splitting a seq_printf into two pieces to work around a bug in
gcc-2.95.3.  Unfortunately gcc-2.96 still chokes on the statements.  The
patch below makes it work better, albeit at the cost of generating a
little more code.

Please apply if you think this is correct.

Alan Stern


===== fs/proc/proc_misc.c 1.56 vs edited =====
--- 1.56/fs/proc/proc_misc.c	Mon Mar 15 16:48:00 2004
+++ edited/fs/proc/proc_misc.c	Thu Mar 18 14:26:25 2004
@@ -391,24 +391,24 @@
 		(unsigned long long)jiffies_64_to_clock_t(irq),
 		(unsigned long long)jiffies_64_to_clock_t(softirq));
 	for_each_cpu(i) {
-		/* two separate calls here to work around gcc-2.95.3 ICE */
-		seq_printf(p, "cpu%d %llu %llu %llu ",
+
+		/* Copy values here to work around gcc-2.95.3, gcc-2.96 */
+		user = kstat_cpu(i).cpustat.user;
+		nice = kstat_cpu(i).cpustat.nice;
+		system = kstat_cpu(i).cpustat.system;
+		idle = kstat_cpu(i).cpustat.idle;
+		iowait = kstat_cpu(i).cpustat.iowait;
+		irq = kstat_cpu(i).cpustat.irq;
+		softirq = kstat_cpu(i).cpustat.softirq;
+		seq_printf(p, "cpu%d %llu %llu %llu %llu %llu %llu %llu\n",
 			i,
-			(unsigned long long)
-			  jiffies_64_to_clock_t(kstat_cpu(i).cpustat.user),
-			(unsigned long long)
-			  jiffies_64_to_clock_t(kstat_cpu(i).cpustat.nice),
-			(unsigned long long)
-			  jiffies_64_to_clock_t(kstat_cpu(i).cpustat.system));
-		seq_printf(p, "%llu %llu %llu %llu\n",
-			(unsigned long long)
-			  jiffies_64_to_clock_t(kstat_cpu(i).cpustat.idle),
-			(unsigned long long)
-			  jiffies_64_to_clock_t(kstat_cpu(i).cpustat.iowait),
-			(unsigned long long)
-			  jiffies_64_to_clock_t(kstat_cpu(i).cpustat.irq),
-			(unsigned long long)
-			  jiffies_64_to_clock_t(kstat_cpu(i).cpustat.softirq));
+			(unsigned long long)jiffies_64_to_clock_t(user),
+			(unsigned long long)jiffies_64_to_clock_t(nice),
+			(unsigned long long)jiffies_64_to_clock_t(system),
+			(unsigned long long)jiffies_64_to_clock_t(idle),
+			(unsigned long long)jiffies_64_to_clock_t(iowait),
+			(unsigned long long)jiffies_64_to_clock_t(irq),
+			(unsigned long long)jiffies_64_to_clock_t(softirq));
 	}
 	seq_printf(p, "intr %llu", (unsigned long long)sum);
 

