Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030255AbWD1Bin@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030255AbWD1Bin (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 21:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030260AbWD1Bim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 21:38:42 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:54690 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030266AbWD1Bib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 21:38:31 -0400
From: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net
Cc: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>
Date: Fri, 28 Apr 2006 10:37:56 +0900
Message-Id: <20060428013756.9582.84189.sendpatchset@moscone.dvs.cs.fujitsu.co.jp>
In-Reply-To: <20060428013730.9582.9351.sendpatchset@moscone.dvs.cs.fujitsu.co.jp>
References: <20060428013730.9582.9351.sendpatchset@moscone.dvs.cs.fujitsu.co.jp>
Subject: [PATCH 5/9] CPU controller - Documentation how the controller works
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

5/9: cpurc_docs

Documentation that describes how the CPU resource controller works.

Signed-off-by: Kurosawa Takahiro <kurosawa@valinux.co.jp>
Signed-off-by: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>

 Documentation/res_groups/cpurc-internals |  167 +++++++++++++++++++++++++++++++
 1 files changed, 167 insertions(+)

Index: linux-2.6.17-rc3/Documentation/res_groups/cpurc-internals
===================================================================
--- /dev/null
+++ linux-2.6.17-rc3/Documentation/res_groups/cpurc-internals
@@ -0,0 +1,167 @@
+CPU resource controller internals
+
+ There are 3 components in the CPU resource controller:
+
+ (1)  load estimation
+ (2)  hungry detection
+ (3)  timeslice scaling
+
+ We need to estimate the resource group load in order to check whether
+ the share is satisfied or not.  Resource group load also gets lower than
+ the share when all the tasks in the resoruce group tends to sleep. We need to
+ check whether the resource group needs to schedule more or not by hungry
+ detection.  If a resource group needs to schedule more, timeslices of tasks
+ are scaled by timeslice scaling.
+
+1. Load estimation
+
+ We calculate the resource group load as the accumulation of task loads in the
+ resource group.  We need to calculate the task load first, then calculate the
+ resource group load from the task loads.
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
+ Resource group load estimation:
+
+  Resource group load is the accumulation of load values of tasks in
+  the resource group in the duration of CPU_RC_SPREAD_PERIOD.
+  Per-CPU resource group load is recalculated each time the task load is
+  calculated in the cpu_rc_account() function.
+  Then on CPU_RC_RECALC_INTERVAL intervals, the resource group load value
+  per-CPU value is calculated as the average of the per-CPU resource group load.
+
+  Task load is accumulated to the per-CPU resource group load as if the resource
+  group uses Ts/Tr of the CPU time from task->ts_alloced to now (the time
+  the timeslice expired).
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
+  Also, we assume that the resource group uses the CPU at the rate of
+  the resource group load from (now - CPU_RC_SPREAD_PERIOD) to the last time
+  the per-CPU resource group load was calculated 
+  (stored in struct cpu_rc::stat[cpu].timestamp).  
+  If cpu_rc::stat[cpu].timestamp < now - CPU_RC_SPREAD_PERIOD, we assume that
+  the resource group doesn't use the CPU from (now - CPU_RC_SPREAD_PERIOD) to
+  task->ts_alloced.
+
+  So the time that the resource group use the CPU from 
+  (now - CPU_RC_SPREAD_PERIOD) to now (Trgrp) should be:
+   if cpu_rc::stat[cpu].timestamp < now - CPU_RC_SPREAD_PERIOD:
+     0
+   else:
+     cpu_rc::stat[cpu].load * (cpu_rc::stat[cpu].timestamp - (now - CPU_RC_SPREAD_PERIOD))
+
+  The new per-CPU resource group load that will be assigned to
+  cpu_rc::stat[cpu].load is calculated as:
+    (Ttsk + Trgrp) / CPU_RC_SPREAD_PERIOD
+
+2. Hungry detection
+
+ When the resource group load is less than the share, there are 2 cases:
+  (a) the share is enough and tasks in the resource group have time for sleep
+  (b) tasks in other resource groups overuse the CPU
+
+ We should not scale the timeslice in case (a) even if the resource group load
+ is lower than the share.  In order to distinguish case (b) from
+ case (a), we measure the time (Tsch) from when a task is activated
+ (stored in task->last_activated) till when the task is actually
+ scheduled.  If the resource group load is lower than the share but tasks
+ in the resource group are quickly scheduled, it can be classified to case (a).
+ If Tsch / timeslice of a task is lower than the share, the resource group
+ that has the task is marked as "maybe hungry."  If the resource group load of
+ the resource group that is marked as "maybe hungry" is lower than the
+ share, it is treated as hungry and the timeslices of tasks in
+ other resource groups will be scaled down.
+
+
+3. Timeslice scaling
+
+ If there are hungry resource groups, we need to adjust timeslices to satisfy
+ the share.  To scale timeslices, we introduce a scaling factor
+ used for scaling timeslices.  The scaling factor is associated with
+ the resource group (stored in the cpu_rc structure) and adaptively adjusted
+ according to the resource group load and the share.
+
+ If some resource groups are hungry, the scaling factor of the resource group
+ that is not hungry is calculated as follows (note: F is the scaling factor):
+   F_new = F * share / resource_group_load
+
+ And the scaling factor of the hungry resource group is calculated as:
+   F_new = F + CPU_RC_TSFACTOR_INC_LO   (CPU_RC_TSFACTOR_INC_LO is defined as 2)
+
+ When all the resource groups are not hungry, the scaling factor is calculated
+ as follows in order to recover the timeslices:
+   F_new = F + CPU_RC_TSFACTOR_INC_HI   (CPU_RC_TSFACTOR_INC_HI is defined as 5)
+
+ Note that the maximum value of F is limited to CPU_RC_TSFACTOR_MAX.
+ The timeslice assigned to each task is:
+   timeslice_scaled = timeslice_orig * F / CPU_RC_TSFACTOR_MAX
+
+ where timeslice_orig is the value that is calculated by the conventional
+ O(1) scheduler.
