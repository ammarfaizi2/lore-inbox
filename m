Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268440AbTBNPzP>; Fri, 14 Feb 2003 10:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268447AbTBNPzO>; Fri, 14 Feb 2003 10:55:14 -0500
Received: from franka.aracnet.com ([216.99.193.44]:46745 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S268440AbTBNPzN>; Fri, 14 Feb 2003 10:55:13 -0500
Date: Fri, 14 Feb 2003 08:04:53 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: lse-tech <lse-tech@lists.sourceforge.net>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Rick Lindsley <ricklind@us.ibm.com>
Subject: Re: breaking down the performance of D7 scheduler patch
Message-ID: <62180000.1045238692@[10.10.2.4]>
In-Reply-To: <7790000.1045177072@[10.10.2.4]>
References: <7790000.1045177072@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Rick broke the non HT parts of D7 out into patches 2,3,4,5 for us.
> This has been useful in all sorts of ways ...
> http://marc.theaimsgroup.com/?l=lse-tech&m=104436251927067&w=2
> (I'll attatch his patches here for convenience, they're small, and I don't
> trust the archives not to munge them).
> 
> Below I've done two runs on each interesting combo (2 is a no-op).
> Overall results are a slight improvement in kernbench and a degredation
> in SDET. My impressions from the data below (16x NUMA-Q)
> 
> 3 - gives a good boost to kernbench, marginal degreadation on SDET.
> 4 - doesn't do much.
> 5 - gives some degredation to kernebench, most of the degredation of SDET.
> 
> Conclusion: 3 = good (mostly). 5 = bad.

Breaking patch 3 down starts to get ugly as they seem to interact.

key:

                 2.5.59 - virgin
        2.5.59-sched2.5 - first part of patch 3 (below)
      2.5.59-sched2.5-2 - ditto
         2.5.59-sched3B - second part of patch 3 (below)
       2.5.59-sched3B-2 - ditto
          2.5.59-sched3 - patch 2 & 3
        2.5.59-sched3-2 - patch 2 & 3

Kernbench-2: (make -j N vmlinux, where N = 2 x num_cpus)
                            Elapsed        User      System         CPU
                 2.5.59       46.08      563.88      118.38     1480.00
        2.5.59-sched2.5       46.39      567.53      117.39     1475.83
      2.5.59-sched2.5-2       46.56      567.31      118.03     1471.50
         2.5.59-sched3B       45.84      563.63      116.31     1482.67
       2.5.59-sched3B-2       45.69      563.92      117.26     1490.50
          2.5.59-sched3       46.12      567.52      115.82     1480.83
        2.5.59-sched3-2       46.37      567.81      116.48     1475.00

Conclusion: looking at system times - part 1 doesn't make much difference,
part 2  makes small improvment, both parts together work well But part 2
alone is the only thing that improves elapsed times.

Kernbench-16: (make -j N vmlinux, where N = 16 x num_cpus)
                            Elapsed        User      System         CPU
                 2.5.59       47.45      568.02      143.17     1498.17
        2.5.59-sched2.5       46.90      570.21      135.39     1503.83
      2.5.59-sched2.5-2       47.03      570.14      135.93     1500.67
         2.5.59-sched3B       47.58      567.37      137.88     1481.83
       2.5.59-sched3B-2       47.35      568.26      138.61     1492.50
          2.5.59-sched3       47.59      573.48      139.78     1498.33
        2.5.59-sched3-2       47.61      573.63      139.97     1498.17

Conclusion: systime - part 1 is best,  part 2 also helps, but not so much. 
Both together do a *little* bit worse than the either part alone.
Part 1 alone improves elapsed a little bit.

Patch 3:

--- sched-2.5.59-02/kernel/sched.c      Tue Feb  4 00:30:05 2003
+++ sched-2.5.59-03/kernel/sched.c      Tue Feb  4 00:31:43 2003
@@ -54,20 +54,19 @@
 /*
  * These are the 'tuning knobs' of the scheduler:
  *
- * Minimum timeslice is 10 msecs, default timeslice is 150 msecs,
- * maximum timeslice is 300 msecs. Timeslices get refilled after
+ * Minimum timeslice is 10 msecs, default timeslice is 100 msecs,
+ * maximum timeslice is 200 msecs. Timeslices get refilled after
  * they expire.
  */
 #define MIN_TIMESLICE          ( 10 * HZ / 1000)
-#define MAX_TIMESLICE          (300 * HZ / 1000)
-#define CHILD_PENALTY          95
+#define MAX_TIMESLICE          (200 * HZ / 1000)
+#define CHILD_PENALTY          50
 #define PARENT_PENALTY         100
 #define EXIT_WEIGHT            3

--------------------- BROKE IT HALF HERE --------------

 #define PRIO_BONUS_RATIO       25
 #define INTERACTIVE_DELTA      2
-#define MAX_SLEEP_AVG          (2*HZ)
-#define STARVATION_LIMIT       (2*HZ)
-#define NODE_THRESHOLD          125
+#define MAX_SLEEP_AVG          (10*HZ)
+#define STARVATION_LIMIT       (30*HZ)
 
 /*
  * If a task is 'interactive' then we reinsert it in the active
@@ -1035,9 +1034,9 @@
  * increasing number of running tasks:
  */
 #define EXPIRED_STARVING(rq) \
-               ((rq)->expired_timestamp && \
+               (STARVATION_LIMIT && ((rq)->expired_timestamp && \
                (jiffies - (rq)->expired_timestamp >= \
-                       STARVATION_LIMIT * ((rq)->nr_running) + 1))
+                       STARVATION_LIMIT * ((rq)->nr_running) + 1)))
 
 /*
  * This function gets called by the timer code, with HZ frequency.


