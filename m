Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261746AbUEAMIW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbUEAMIW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 08:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261766AbUEAMIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 08:08:21 -0400
Received: from cfcafw.sgi.com ([198.149.23.1]:17398 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261746AbUEAMIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 08:08:07 -0400
Date: Sat, 1 May 2004 07:08:05 -0500
From: Jack Steiner <steiner@sgi.com>
To: linux-kernel@vger.kernel.org
Subject: RCU scaling on large systems
Message-ID: <20040501120805.GA7767@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Has anyone investigated scaling of the RCU algorithms on large
cpu-count systems?

We are running 2.6.5 on a 512p system. The RCU update code is causing 
a near-livelock when booting. Several times, I dropped into kdb &
found many of the cpus in the RCU code. The cpus are in
rcu_check_quiescent_state() spinning on the rcu_ctrlblk.mutex.


I also found an interesting anomaly that was traced to RCU. I have
a program that measures "cpu efficiency". Basically, the program 
creates a cpu bound thread for each cpu & measures the percentage 
of time that each cpu ACTUALLY spends executing user code.
On an idle each system, each cpu *should* spend >99% in user mode.

On a 512p idle 2.6.5 system, each cpu spends ~6% of the time in the kernel
RCU code. The time is spent contending for shared cache lines.

Even more bizarre: if I repeatedly type "ls" in a *single* window 
(probably 5 times/sec), then EVERY CPU IN THE SYSTEM spends ~50%
of the time in the RCU code.

The RCU algorithms don't scale - at least on our systems!!!!!


Attached is an experimental hack that fixes the problem. I
don't believe that this is the correct fix but it does prove
that slowing down the frequency of updates fixes the problem.


With this hack, "ls" no longer measurable disturbs other cpus. Each
cpu spends ~99.8% of its time in user code regardless of the frequency
of typing "ls".



By default, the RCU code attempts to process callbacks on each cpu
every tick. The hack adds a mask so that only a few cpus process
callbacks each tick. 

I ran a simple experiment to vary the mask. Col 1 shows the mask
value, col 2 show system time when system is idle, col 3 shows
system time when typing "ls" on a single cpu. The percentages are
"eyeballed averages" for all cpus.

	VAL	idle%	"ls" %
	0	6.00	55.00
	1	2.00	50.00
	3	 .20	20.00
	7	 .20	  .22
	15	 .20	  .24
	31	 .19	  .25
	63	 .19	  .26
	127	 .19	  .25
	511	 .19	  .19

Looks like any value >7 or 15 should be ok on our hardware. I picked 
a larger value because I don't understand how heavy loads affect the 
optimal value.  I suspect that the optimal value is architecture
dependent & probably platform dependent.


Is anyone already working on this issue?

Comments and additional insight appreciated..........




Index: linux/include/linux/rcupdate.h
===================================================================
--- linux.orig/include/linux/rcupdate.h	2004-04-30 09:59:00.000000000 -0500
+++ linux/include/linux/rcupdate.h	2004-04-30 10:01:37.000000000 -0500
@@ -41,6 +41,7 @@
 #include <linux/threads.h>
 #include <linux/percpu.h>
 #include <linux/cpumask.h>
+#include <linux/jiffies.h>
 
 /**
  * struct rcu_head - callback structure for use with RCU
@@ -84,6 +85,14 @@
         return (a - b) > 0;
 }
 
+#define RCU_JIFFIES_MASK 15
+
+/* Is it time to process a batch on this cpu */
+static inline int rcu_time(int cpu)
+{
+	return (((jiffies - cpu) & RCU_JIFFIES_MASK) == 0);
+}
+
 /*
  * Per-CPU data for Read-Copy Update.
  * nxtlist - new callbacks are added here
@@ -111,11 +120,11 @@
 
 static inline int rcu_pending(int cpu) 
 {
-	if ((!list_empty(&RCU_curlist(cpu)) &&
+	if (rcu_time(cpu) && ((!list_empty(&RCU_curlist(cpu)) &&
 	     rcu_batch_before(RCU_batch(cpu), rcu_ctrlblk.curbatch)) ||
 	    (list_empty(&RCU_curlist(cpu)) &&
 			 !list_empty(&RCU_nxtlist(cpu))) ||
-	    cpu_isset(cpu, rcu_ctrlblk.rcu_cpu_mask))
+	    cpu_isset(cpu, rcu_ctrlblk.rcu_cpu_mask)))
 		return 1;
 	else
 		return 0;
-- 
Thanks

Jack Steiner (steiner@sgi.com)          651-683-5302
Principal Engineer                      SGI - Silicon Graphics, Inc.


