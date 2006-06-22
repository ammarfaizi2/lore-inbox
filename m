Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030496AbWFVBwn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030496AbWFVBwn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 21:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030497AbWFVBwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 21:52:43 -0400
Received: from omta04ps.mx.bigpond.com ([144.140.83.156]:1529 "EHLO
	omta04ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1030496AbWFVBwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 21:52:42 -0400
From: Peter Williams <pwil3058@bigpond.net.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Con Kolivas <kernel@kolivas.org>, Sam Vilain <sam@vilain.net>,
       Balbir Singh <bsingharora@gmail.com>, Srivatsa <vatsa@in.ibm.com>,
       Peter Williams <pwil3058@bigpond.net.au>,
       Kirill Korotaev <dev@openvz.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Mike Galbraith <efault@gmx.de>, Kingsley Cheung <kingsley@aurema.com>,
       CKRM <ckrm-tech@lists.sourceforge.net>, Ingo Molnar <mingo@elte.hu>,
       Rene Herman <rene.herman@keyaccess.nl>
Date: Thu, 22 Jun 2006 11:52:37 +1000
Message-Id: <20060622015237.14498.37712.sendpatchset@heathwren.pw.nest>
Subject: [PATCH 0/4] sched: Add CPU rate caps
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These patches implement CPU usage rate limits for tasks.

Although the rlimit mechanism already has a CPU usage limit (RLIMIT_CPU)
it is a total usage limit and therefore (to my mind) not very useful.
These patches provide an alternative whereby the (recent) average CPU
usage rate of a task can be limited to a (per task) specified proportion
of a single CPU's capacity.  The limits are specified in parts per
thousand and come in two varieties -- hard and soft.  The difference
between the two is that the system tries to enforce hard caps regardless
of the other demand for CPU resources but allows soft caps to be
exceeded if there are spare CPU resources available.  By default, tasks
will have both caps set to 1000 (i.e. no limit) but newly forked tasks
will inherit any caps that have been imposed on their parent from the
parent.  The mimimim soft cap allowed is 0 (which effectively puts the
task in the background) and the minimim hard cap allowed is 1.

Care has been taken to minimize the overhead inflicted on tasks that
have no caps and my tests using kernbench indicate that it is hidden in
the noise.

Note:

1. Caps are not enforced for SCHED_FIFO and SCHED_RR tasks.

2. This versions incorporates improvements and bug fixes as a result of
feedback from an earlier post.  Special thanks to Con Kolivas whose
suggestions with respect to improved methods for avoiding starvation
and priority inversion have enabled cap enforcement to be stricter.

3. To reduce overhead for uncapped tasks, no CPU usage rate statistics
are kept for tasks that have a hard or soft cap less than 1000 parts
per thousand.  However, these statistics in conjunction with the
weighted load values for tasks and run queues can be used to determine
if a task is getting a "fair" share of CPU i.e. the ratio of the tasks
load to the run queues total load weight should be the same as the
ratio of its average on cpu time per cycle to the average length of
its cycle.  This could be of use to the normal scheduling code.

4. This patch is against 2.6.17-mm1.

5. Overhead Measurements.  To measure the implications for overhead
introduced by these patches kernbench was used on a dual 500Mhz
Centrino SMP system.  Runs were done for a kernel without these
patches applied, one with the patches applied but no caps being used
and one with the patches applied and running kernbench with a soft cap
of zero (which would be inherited by all its children).

Average Optimal -j 8 Load Run:

                  Vanilla          Patch Applied    Soft Cap 0%

Elapsed Time      1056.1   (1.92)  1048.2   (0.62)  1064.1   (1.59)
User Time         1908.1   (1.09)  1895.2   (1.30)  1926.6   (1.39)
System Time        181.7   (0.60)   177.5   (0.74)   173.8   (1.07)
   Total          2089.8           2072.7           2100.4
Percent CPU        197.6   (0.55)   197.0   (0)      197.0   (0)
Context Switches 49253.6 (136.31) 48881.4  (92.03) 92490.8 (163.71)
Sleeps           28038.8 (228.11) 28136.0 (250.65) 25769.4 (280.40)

As can be seen there is no significant overhead penalty for having
these patches applied and leaving them unused (in fact, based on
these numbers, there's actually a small improvement).  Similarly,
the overhead for running kernbench as a background (soft cap of
zero) job is not significant.  As expected, the context switches for
the background run are double (due to the fact that ANY OTHER task
running on the machine would be able to preempt the kernbench tasks)
but have not seriously effected the CPU usage statistics.  The
similarity of the "Percent CPU" numbers indicate that load balancing
hasn't been adversely effected.

6. Code size measurements:

Vanilla kernel:

   text    data     bss     dec     hex filename
  30305    4881     704   35890    8c32 kernel/sched.o
    907       0       0     907     38b kernel/mutex.o
  10183    3424       0   13607    3527 fs/proc/base.o

Patches applied:

   text    data     bss     dec     hex filename
  33027    4913     704   38644    96f4 kernel/sched.o
    979       0       0     979     3d3 kernel/mutex.o
  10962    3712       0   14674    3952 fs/proc/base.o

Indicating that the size cost of the patch proper is about
2.7 kilobytes and the procfs costs about another 0.8 kilobytes.
This is a reduction of 0.7 kilobytes on the previous version and
is due to a rationalization of the interface code.

7. A patch to use task watchers to implement per process (as opposed to
per task) caps is under development to demonstrate the suitability of
these mechanisms for implementing higher level capping from outside the
scheduling code.

Signed-off-by: Peter Williams <pwil3058@bigpond.com.au>


-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
 -- Ambrose Bierce
