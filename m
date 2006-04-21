Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932210AbWDUC3T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbWDUC3T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 22:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbWDUC2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 22:28:54 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:47336 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932123AbWDUC2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 22:28:43 -0400
From: maeda.naoaki@jp.fujitsu.com
To: linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
Cc: maeda.naoaki@jp.fujitsu.com
Date: Fri, 21 Apr 2006 11:27:53 +0900
Message-Id: <20060421022753.13598.77686.sendpatchset@moscone.dvs.cs.fujitsu.co.jp>
In-Reply-To: <20060421022727.13598.15397.sendpatchset@moscone.dvs.cs.fujitsu.co.jp>
References: <20060421022727.13598.15397.sendpatchset@moscone.dvs.cs.fujitsu.co.jp>
Subject: [RFC][PATCH 5/9] CPU controller - Documents how the controller works
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

5/9: cpurc_docs

Documentation that describes how the CPU resource controller works.

Signed-off-by: Kurosawa Takahiro <kurosawa@valinux.co.jp>
Signed-off-by: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>

 Documentation/ckrm/cpurc-internals |  166 +++++++++++++++++++++++++++++++++++++
 1 files changed, 166 insertions(+)

Index: linux-2.6.17-rc2/Documentation/ckrm/cpurc-internals
===================================================================
--- /dev/null
+++ linux-2.6.17-rc2/Documentation/ckrm/cpurc-internals
@@ -0,0 +1,166 @@
+CPU resource controller internals
+
+ There are 3 components in the CPU resource controller:
+
+ (1)  load estimation
+ (2)  hungry detection
+ (3)  timeslice scaling
+
+ We need to estimate the class load in order to check whether the
+ share is satisfied or not.  Class load also gets lower than the
+ share when all the tasks in the class tends to sleep. We need to
+ check whether the class needs to schedule more or not by hungry
+ detection.  If a class needs to schedule more, timeslices of tasks
+ are scaled by timeslice scaling.
+
+1. Load estimation
+
+ We calculate the class load as the accumulation of task loads in the
+ class.  We need to calculate the task load first, then calculate the
+ class load from the task loads.
+
+ Task load estimation
+
+  Task load is estimated as the ratio of:
+   * the timeslice value allocated to the task (Ts)
+  to:
+   * the time that is taken for the task to run out the allocated timeslice
+     (Tr).
+  If a task can use all the CPU time, Ts / Tr becomes 1 for example.
+
+  The detailed procedure of the calculation is as follows:
+  (1) Record the timeslice (Ts) and the time when the timeslice is
+      allocated to the task (by calling cpu_rc_record_allocation()).
+      * The timeslice value is recorded to task->last_slice ( = Ts).
+      * The time is recorded to task->ts_alloced.
+  (2) Calculate the task load when the timeslice is expired
+      (by calling cpu_rc_account()).
+      Tr is calculated as:
+       Tr = jiffies - task->ts_alloced
+      Then task load (Ts / Tr) becomes:
+       Ts / Tr = task->last_slice / (jiffies - task->ts_alloced)
+
+      The load value is scaled by CPU_RC_LOAD_SCALE.
+      If the load value equals to CPU_RC_LOAD_SCALE, it indicates 100%
+      CPU usage.
+
+          task->ts_alloced   task scheduled             now
+             v               v                          v
+             |---------------===========================|
+
+                             |<------------------------>|
+                               Ts ( = task->last_slice)
+
+             |<---------------------------------------->|
+                Tr ( = now - task->ts_alloced)
+
+             |<------------->|
+               the time that the task isn't scheduled
+
+
+      Note that task load calculation is also needed for strict
+      accuracy when a task forks or exits, because timeslice is
+      changed on fork and exit.  But we don't do that in order to
+      simplify the code and in order not to introduce overhead on fork
+      and exit.  Probably we can get enough accurate number without
+      calculating the task load on fork/exit.
+
+ Class load estimation:
+
+  Class load is the accumulation of load values of tasks in the class in
+  the duration of CPU_RC_SPREAD_PERIOD.
+  Per-CPU class load is recalculated each time the task load is calculated
+  in the cpu_rc_account() function.
+  Then on CPU_RC_RECALC_INTERVAL intervals, the class load value per-CPU
+  value is calculated as the average of the per-CPU class load.
+
+  Task load is accumulated to the per-CPU class load as if the class uses
+  Ts/Tr of the CPU time from task->ts_alloced to now (the time the timeslice
+  expired).
+
+  So the time that the task has used the CPU from (now - CPU_RC_SPREAD_PERIOD)
+  to now (Ttsk) should be:
+
+   if task->ts_alloced < now - CPU_RC_SPREAD_PERIOD:
+     Ts/Tr * CPU_RC_SPREAD_PERIOD
+     (We assume that the task has used the CPU at the constant rate of Ts/Tr.)
+
+                    now-CPU_RC_SPREAD_PERIOD                now
+                    v                                       v
+                    |---------------------------------------|
+         |==================================================| load: Ts/Tr
+         ^
+         task->ts_alloced
+
+   else:
+     Ts
+
+                    now-CPU_RC_SPREAD_PERIOD                now
+                    v                                       v
+                    |---------------------------------------|
+                               |============================| load: Ts/Tr
+                               ^
+                               task->ts_alloced
+
+  Also, we assume that the class uses the CPU at the rate of the class load
+  from (now - CPU_RC_SPREAD_PERIOD) to the last time the per-CPU class load
+  was calculated (stored in struct cpu_rc::stat[cpu].timestamp).  If
+  cpu_rc::stat[cpu].timestamp < now - CPU_RC_SPREAD_PERIOD, we assume that
+  the class doesn't use the CPU from (now - CPU_RC_SPREAD_PERIOD) to
+  task->ts_alloced.
+
+  So the time that the class use the CPU from (now - CPU_RC_SPREAD_PERIOD)
+  to now (Tcls) should be:
+   if cpu_rc::stat[cpu].timestamp < now - CPU_RC_SPREAD_PERIOD:
+     0
+   else:
+     cpu_rc::stat[cpu].load * (cpu_rc::stat[cpu].timestamp - (now - CPU_RC_SPREAD_PERIOD))
+
+  The new per-CPU class load that will be assigned to cpu_rc::stat[cpu].load
+  is calculated as:
+    (Ttsk + Tcls) / CPU_RC_SPREAD_PERIOD
+
+2. Hungry detection
+
+ When the class load is less than the share, there are 2 cases:
+  (a) the share is enough and tasks in the class have time for sleep
+  (b) tasks in other classes overuse the CPU
+
+ We should not scale the timeslice in case (a) even if the class load
+ is lower than the share.  In order to distinguish case (b) from
+ case (a), we measure the time (Tsch) from when a task is activated
+ (stored in task->last_activated) till when the task is actually
+ scheduled.  If the class load is lower than the share but tasks
+ in the class are quickly scheduled, it can be classified to case (a).
+ If Tsch / timeslice of a task is lower than the share, the class
+ that has the task is marked as "maybe hungry."  If the class load of
+ the class that is marked as "maybe hungry" is lower than the
+ share, it is treated as hungry and the timeslices of tasks in
+ other classes will be scaled down.
+
+
+3. Timeslice scaling
+
+ If there are hungry classes, we need to adjust timeslices to satisfy
+ the share.  To scale timeslices, we introduce a scaling factor
+ used for scaling timeslices.  The scaling factor is associated with
+ the class (stored in the cpu_rc structure) and adaptively adjusted
+ according to the class load and the share.
+
+ If some classes are hungry, the scaling factor of the class that is
+ not hungry is calculated as follows (note: F is the scaling factor):
+   F_new = F * share / class_load
+
+ And the scaling factor of the hungry class is calculated as:
+   F_new = F + CPU_RC_TSFACTOR_INC_LO   (CPU_RC_TSFACTOR_INC_LO is defined as 2)
+
+ When all the classes are not hungry, the scaling factor is calculated
+ as follows in order to recover the timeslices:
+   F_new = F + CPU_RC_TSFACTOR_INC_HI   (CPU_RC_TSFACTOR_INC_HI is defined as 5)
+
+ Note that the maximum value of F is limited to CPU_RC_TSFACTOR_MAX.
+ The timeslice assigned to each task is:
+   timeslice_scaled = timeslice_orig * F / CPU_RC_TSFACTOR_MAX
+
+ where timeslice_orig is the value that is calculated by the conventional
+ O(1) scheduler.
