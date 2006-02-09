Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422815AbWBIGLo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422815AbWBIGLo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 01:11:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422816AbWBIGLo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 01:11:44 -0500
Received: from sv1.valinux.co.jp ([210.128.90.2]:60133 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S1422815AbWBIGLn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 01:11:43 -0500
From: KUROSAWA Takahiro <kurosawa@valinux.co.jp>
To: linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
Cc: KUROSAWA Takahiro <kurosawa@valinux.co.jp>
Message-Id: <20060209061142.2164.35994.sendpatchset@debian>
Subject: [PATCH 0/2] CKRM CPU resource controller
Date: Thu,  9 Feb 2006 15:11:42 +0900 (JST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds a CPU resource controller for CKRM.  The CPU
resource controller manages CPU resources by scaling timeslice
allocated for each task without changing the algorithm of the O(1)
scheduler.  A document that describes how the resource controller
works is attached at the end of this mail.

Performance tests showed us that the overhead introduced by this
patchset was negligible small.  Here are the summary of performance tests:

(1) overhead

 lat_ctx -s 0 -W 100 -N 1000 $N,N=(2..500)

  N    2.6.15  cpurc	delta (cpurc - 2.6.15) [us]
-------------------------------------------------
  2	0.48	0.50	 0.02
  3	0.69	0.70	 0.01
  4	0.65	0.71	 0.06
  5	0.68	0.70	 0.02
  6	0.66	0.73	 0.07
  7	0.74	0.69	-0.05
  8	0.67	0.76	 0.09
  9	0.68	0.71	 0.03
 10	0.66	0.71	 0.05
 20	0.72	0.74	 0.02
 30	0.75	0.77	 0.04
 40	0.77	0.79	 0.02
 50	0.83	0.84	 0.02
 60	0.86	0.86	-0.02
 70	0.90	0.86	-0.04
 80	0.92	0.89	-0.03
 90	1.00	0.92	-0.08
100	0.96	1.03	 0.07
200	1.55	1.65	 0.10
300	2.30	2.23	-0.07
400	2.80	2.85	 0.05
500	3.12	3.20	 0.08

The overhead is smaller than the error limit.

See also the following graph:
http://prdownloads.sourceforge.net/ckrm/cpurc-v0.3-2615-lat_ctx.pdf?download

(2) accuracy of share

 kernbench running with 2 infinite loops on 2 CPU machine

%Share   Elaps   User    Sys	%CPU
-------------------------------------
 10	2515.5  571.8   61.6	 24.8
 20	1349.3  578.1	59.7	 46.8
 30 	 905.5	575.7	59.8	 69.8
 40	 706.9	574.1	60.1	 89.4
 50 	 586.8	572.4	60.1	107.2
 60 	 494.2	572.6	60.1	127.2
 70 	 430.0	572.4	60.9	146.6
 80	 368.4  571.2	60.5	171.0
 90	 328.4  572.1	60.6	192.2
100	 320.5	571.8	60.6	196.8

Notice that maximun share is 100% regardless of # of CPU, and
maximum %CPU is 200%. Therefore, %CPU should be two times of %Share.

See also the following graph:
http://prdownloads.sourceforge.net/ckrm/cpurc-v0.3-2615-kernbench.pdf?download


-----------------------------------------------------------------------------

How the CPU resource controller works

 There are 3 components in the CPU resource controller:

 (1)  load estimation
 (2)  hungry detection
 (3)  timeslice scaling
 (3') task requeueing

 We need to estimate the class load in order to check whether the
 guarantee is satisfied or not.  Class load also gets lower than the
 guarantee when all the tasks in the class tends to sleep. We need to
 check whether the class needs to schedule more or not by hungry
 detection.  If a class needs to schedule more, timeslices of tasks
 are scaled by timeslice scaling.  When timeslice scaling can't satisfy 
 the guarantee, task requeueing supplements timeslice scaling.
 

1. Load estimation

 We calculate the class load as the accumulation of task loads in the
 class.  We need to calculate the task load first, then calculate the
 class load from the task loads.

 Task load estimation

  Task load is estimated as the ratio of:
   * the timeslice value allocated to the task (Ts)
  to:
   * the time that is taken for the task to run out the allocated timeslice
     (Tr).
  If a task can use all the CPU time, Ts / Tr becomes 1 for example.

  The detailed procedure of the calculation is as follows:
  (1) Record the timeslice (Ts) and the time when the timeslice is 
      allocated to the task (by calling cpu_rc_record_allocation()).
      * The timeslice value is recorded to task->last_slice ( = Ts).
      * The time is recorded to task->ts_alloced.
  (2) Calculate the task load when the timeslice is expired
      (by calling cpu_rc_account()).
      Tr is calculated as:
       Tr = jiffies - task->ts_alloced
      Then task load (Ts / Tr) becomes:
       Ts / Tr = task->last_slice / (jiffies - task->ts_alloced)

      The load value is scaled by CPU_RC_LOAD_SCALE.
      If the load value equals to CPU_RC_LOAD_SCALE, it indicates 100% 
      CPU usage.

          task->ts_alloced   task scheduled             now
             v               v                          v
             |---------------===========================|

                             |<------------------------>|
                               Ts ( = task->last_slice)

             |<---------------------------------------->|
                Tr ( = now - task->ts_alloced)

             |<------------->|
               the time that the task isn't scheduled


      Note that task load calculation is also needed for strict
      accuracy when a task forks or exits, because timeslice is
      changed on fork and exit.  But we don't do that in order to
      simplify the code and in order not to introduce overhead on fork
      and exit.  Probably we can get enough accurate number without
      calculating the task load on fork/exit.

 Class load estimation:

  Class load is the accumulation of load values of tasks in the class in
  the duration of CPU_RC_SPREAD_PERIOD.
  Per-CPU class load is recalculated each time the task load is calculated
  in the cpu_rc_account() function.
  Then on CPU_RC_RECALC_INTERVAL intervals, the class load value per-CPU 
  value is calculated as the average of the per-CPU class load.

  Task load is accumulated to the per-CPU class load as if the class uses 
  Ts/Tr of the CPU time from task->ts_alloced to now (the time the timeslice 
  expired).

  So the time that the task has used the CPU from (now - CPU_RC_SPREAD_PERIOD)
  to now (Ttsk) should be:

   if task->ts_alloced < now - CPU_RC_SPREAD_PERIOD:
     Ts/Tr * CPU_RC_SPREAD_PERIOD
     (We assume that the task has used the CPU at the constant rate of Ts/Tr.)

                    now-CPU_RC_SPREAD_PERIOD                now
                    v                                       v
                    |---------------------------------------|
         |==================================================| load: Ts/Tr
         ^
         task->ts_alloced

   else:
     Ts

                    now-CPU_RC_SPREAD_PERIOD                now
                    v                                       v
                    |---------------------------------------|
                               |============================| load: Ts/Tr
                               ^
                               task->ts_alloced             

  Also, we assume that the class uses the CPU at the rate of the class load
  from (now - CPU_RC_SPREAD_PERIOD) to the last time the per-CPU class load
  was calculated (stored in struct cpu_rc::stat[cpu].timestamp).  If
  cpu_rc::stat[cpu].timestamp < now - CPU_RC_SPREAD_PERIOD, we assume that
  the class doesn't use the CPU from (now - CPU_RC_SPREAD_PERIOD) to
  task->ts_alloced.

  So the time that the class use the CPU from (now - CPU_RC_SPREAD_PERIOD)
  to now (Tcls) should be:
   if cpu_rc::stat[cpu].timestamp < now - CPU_RC_SPREAD_PERIOD:
     0
   else:
     cpu_rc::stat[cpu].load * (cpu_rc::stat[cpu].timestamp - (now - CPU_RC_SPREAD_PERIOD))

  The new per-CPU class load that will be assigned to cpu_rc::stat[cpu].load
  is calculated as:
    (Ttsk + Tcls) / CPU_RC_SPREAD_PERIOD

2. Hungry detection

 When the class load is less than the guarantee, there are 2 cases:
  (a) the guarantee is enough and tasks in the class have time for sleep
  (b) tasks in other classes overuse the CPU

 We should not scale the timeslice in case (a) even if the class load
 is lower than the guarantee.  In order to distinguish case (b) from
 case (a), we measure the time (Tsch) from when a task is activated
 (stored in task->last_activated) till when the task is actually
 scheduled.  If the class load is lower than the guarantee but tasks
 in the class are quickly scheduled, it can be classified to case (a).
 If Tsch / timeslice of a task is lower than the guarantee, the class
 that has the task is marked as "maybe hungry."  If the class load of
 the class that is marked as "maybe hungry" is lower than the
 guarantee, it is treated as hungry and the timeslices of tasks in
 other classes will be scaled down.


3. Timeslice scaling

 If there are hungry classes, we need to adjust timeslices to satisfy
 the guarantee.  To scale timeslices, we introduce a scaling factor
 used for scaling timeslices.  The scaling factor is associated with
 the class (stored in the cpu_rc structure) and adaptively adjusted
 according to the class load and the guarantee.

 If some classes are hungry, the scaling factor of the class that is
 not hungry is calculated as follows (note: F is the scaling factor):
   F_new = F * guarantee / class_load

 And the scaling factor of the hungry class is calculated as:
   F_new = F + 1

 When all the classes are not hungry, the scaling factor is calculated
 as follows in order to recover the timeslices:
   F_new = F + CPU_RC_TSFACTOR_INC   (CPU_RC_TSFACTOR_INC is defined as 5)

 Note that the maximum value of F is limited to CPU_RC_TSFACTOR_MAX.
 The timeslice assigned to each task is:
   timeslice_scaled = timeslice_orig * F / CPU_RC_TSFACTOR_MAX

 where timeslice_orig is the value that is calculated by the conventional 
 O(1) scheduler.

3'. Task requeueing

 There is cases that timeslice scaling is not enough for satisfying
 the guarantee because there is highest and lowest value defined for
 the timeslice.  The lowest value is 1, so a class that has low
 guarantee but has huge number of tasks may beat another class that
 has high guarantee but has small number of tasks.  Task requeueing
 works in such cases.

 If the hungry state continues more than CPU_RC_STARVE_THRESHOLD
 (defined as 2) on the scale factor recalculation, the class is
 considered as starving.  Tasks in the starving classes are requeued
 to the active queue again when the timeslices are expired.

-- 
KUROSAWA, Takahiro
