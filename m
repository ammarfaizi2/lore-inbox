Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268672AbUILMJM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268672AbUILMJM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 08:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268685AbUILMJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 08:09:11 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:52679 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268672AbUILL7Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 07:59:25 -0400
Date: Sun, 12 Sep 2004 04:58:57 -0700 (PDT)
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: IWAMOTO Toshihiro <iwamoto@valinux.co.jp>, linux-kernel@vger.kernel.org,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Simon Derr <Simon.Derr@bull.net>, Andi Kleen <ak@suse.de>,
       Anton Blanchard <anton@samba.org>, Paul Jackson <pj@sgi.com>,
       Dave Hansen <haveblue@us.ibm.com>
Message-Id: <20040912115857.31061.62788.77989@sam.engr.sgi.com>
Subject: [Patch] cpusets interoperate with hotplug online maps
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch gets cpusets working with the cpus_online_map and
nodes_online_map that are manipulated by the hotplug features.

Cpusets keeps bitmaps of CPUs and Memory Nodes where tasks must run.
Hotplug can add and remove CPUs and Memory, which could take all the
CPUs or Memory in a cpuset offline.  This patch handles this case by
using other CPUs and Memory (from parent cpusets) in order to avoid
starving a task of the CPU and Memory it needs to run.

When using hotplug, administrators should reconfigure cpusets to
reflect the actual resources available.  This patch provides a default
allocation of resources if they don't.  It is better to violate
a misconfigured cpusets placement than to starve a process.

This patch also adds the ability to change the top, root cpuset,
adding and removing CPUs and Memory Nodes from it, just as was already
supported for subordinate cpusets, and following the same rules.  This
is necessary to allow the administrator to adapt a cpuset configuration
when adding and removing CPUs and Memory Nodes using hotplug.

Several arch's built.  Arch ia64 sn2_defconfig booted and unit tested.
No actual testing using hotplug to add or remove resources was done.

This patch replaces and extends an earlier patch of a day ago:

  [Patch 4/4] cpusets top mask just online, not all possible

Signed-off-by: Paul Jackson <pj@sgi.com>

Index: 2.6.9-rc1-mm4/Documentation/cpusets.txt
===================================================================
--- 2.6.9-rc1-mm4.orig/Documentation/cpusets.txt	2004-09-12 00:43:29.000000000 -0700
+++ 2.6.9-rc1-mm4/Documentation/cpusets.txt	2004-09-12 00:45:30.000000000 -0700
@@ -241,6 +241,18 @@ rewritten to the 'tasks' file of its cpu
 impacting the scheduler code in the kernel with a check for changes
 in a tasks processor placement.
 
+There is an exception to the above.  If hotplug funtionality is used
+to remove all the CPUs that are currently assigned to a cpuset,
+then the kernel will automatically update the cpus_allowed of all
+tasks attached to CPUs in that cpuset with the online CPUs of the
+nearest parent cpuset that still has some CPUs online.  When memory
+hotplug functionality for removing Memory Nodes is available, a
+similar exception is expected to apply there as well.  In general,
+the kernel prefers to violate cpuset placement, over starving a task
+that has had all its allowed CPUs or Memory Nodes taken offline.  User
+code should reconfigure cpusets to only refer to online CPUs and Memory
+Nodes when using hotplug to add or remove such resources.
+
 To start a new job that is to be contained within a cpuset, the steps are:
 
  1) mkdir /dev/cpuset
Index: 2.6.9-rc1-mm4/kernel/cpuset.c
===================================================================
--- 2.6.9-rc1-mm4.orig/kernel/cpuset.c	2004-09-11 20:02:37.000000000 -0700
+++ 2.6.9-rc1-mm4/kernel/cpuset.c	2004-09-12 01:23:34.000000000 -0700
@@ -455,6 +455,55 @@ out:
 }
 
 /*
+ * Return in *pmask the portion of a cpusets's cpus_allowed that
+ * are online.  If none are online, walk up the cpuset hierarchy
+ * until we find one that does have some online cpus.  If we get
+ * all the way to the top and still haven't found any online cpus,
+ * return cpu_online_map.  Or if passed a NULL cs from an exit'ing
+ * task, return cpu_online_map.
+ *
+ * One way or another, we guarantee to return some non-empty subset
+ * of cpu_online_map.
+ *
+ * Call with cpuset_sem held.
+ */
+
+static void guarantee_online_cpus(const struct cpuset *cs, cpumask_t *pmask)
+{
+	while (cs && !cpus_intersects(cs->cpus_allowed, cpu_online_map))
+		cs = cs->parent;
+	if (cs)
+		cpus_and(*pmask, cs->cpus_allowed, cpu_online_map);
+	else
+		*pmask = cpu_online_map;
+	BUG_ON(!cpus_intersects(*pmask, cpu_online_map));
+}
+
+/*
+ * Return in *pmask the portion of a cpusets's mems_allowed that
+ * are online.  If none are online, walk up the cpuset hierarchy
+ * until we find one that does have some online mems.  If we get
+ * all the way to the top and still haven't found any online mems,
+ * return node_online_map.
+ *
+ * One way or another, we guarantee to return some non-empty subset
+ * of node_online_map.
+ *
+ * Call with cpuset_sem held.
+ */
+
+static void guarantee_online_mems(const struct cpuset *cs, nodemask_t *pmask)
+{
+	while (cs && !nodes_intersects(cs->mems_allowed, node_online_map))
+		cs = cs->parent;
+	if (cs)
+		nodes_and(*pmask, cs->mems_allowed, node_online_map);
+	else
+		*pmask = node_online_map;
+	BUG_ON(!nodes_intersects(*pmask, node_online_map));
+}
+
+/*
  * is_cpuset_subset(p, q) - Is cpuset p a subset of cpuset q?
  *
  * One cpuset is a subset of another if all its allowed CPUs and
@@ -492,18 +541,7 @@ static int is_cpuset_subset(const struct
 
 static int validate_change(const struct cpuset *cur, const struct cpuset *trial)
 {
-	struct cpuset *c, *par = cur->parent;
-
-	/*
-	 * Don't mess with Big Daddy - top_cpuset must remain maximal.
-	 * And besides, the rest of this routine blows chunks if par == 0.
-	 */
-	if (cur == &top_cpuset)
-		return -EPERM;
-
-	/* We must be a subset of our parent cpuset */
-	if (!is_cpuset_subset(trial, par))
-		return -EACCES;
+	struct cpuset *c, *par;
 
 	/* Each of our child cpusets must be a subset of us */
 	list_for_each_entry(c, &cur->children, sibling) {
@@ -511,6 +549,14 @@ static int validate_change(const struct 
 			return -EBUSY;
 	}
 
+	/* Remaining checks don't apply to root cpuset */
+	if ((par = cur->parent) == NULL)
+		return 0;
+
+	/* We must be a subset of our parent cpuset */
+	if (!is_cpuset_subset(trial, par))
+		return -EACCES;
+
 	/* If either I or some sibling (!= me) is exclusive, we can't overlap */
 	list_for_each_entry(c, &par->children, sibling) {
 		if ((is_cpu_exclusive(trial) || is_cpu_exclusive(c)) &&
@@ -536,6 +582,8 @@ static int update_cpumask(struct cpuset 
 	if (retval < 0)
 		return retval;
 	cpus_and(trialcs.cpus_allowed, trialcs.cpus_allowed, cpu_online_map);
+	if (cpus_empty(trialcs.cpus_allowed))
+		return -ENOSPC;
 	retval = validate_change(cs, &trialcs);
 	if (retval == 0)
 		cs->cpus_allowed = trialcs.cpus_allowed;
@@ -551,6 +599,9 @@ static int update_nodemask(struct cpuset
 	retval = nodelist_parse(buf, trialcs.mems_allowed);
 	if (retval < 0)
 		return retval;
+	nodes_and(trialcs.mems_allowed, trialcs.mems_allowed, node_online_map);
+	if (nodes_empty(trialcs.mems_allowed))
+		return -ENOSPC;
 	retval = validate_change(cs, &trialcs);
 	if (retval == 0) {
 		cs->mems_allowed = trialcs.mems_allowed;
@@ -597,6 +648,7 @@ static int attach_task(struct cpuset *cs
 	pid_t pid;
 	struct task_struct *tsk;
 	struct cpuset *oldcs;
+	cpumask_t cpus;
 
 	if (sscanf(buf, "%d", &pid) != 1)
 		return -EIO;
@@ -636,7 +688,8 @@ static int attach_task(struct cpuset *cs
 	tsk->cpuset = cs;
 	task_unlock(tsk);
 
-	set_cpus_allowed(tsk, cs->cpus_allowed);
+	guarantee_online_cpus(cs, &cpus);
+	set_cpus_allowed(tsk, cpus);
 
 	put_task_struct(tsk);
 	if (atomic_dec_and_test(&oldcs->count))
@@ -1271,7 +1324,9 @@ int __init cpuset_init(void)
 	struct dentry *root;
 	int err;
 
-	top_cpuset.mems_allowed = node_possible_map;
+	top_cpuset.cpus_allowed = CPU_MASK_ALL;
+	top_cpuset.mems_allowed = NODE_MASK_ALL;
+
 	atomic_inc(&cpuset_mems_generation);
 	top_cpuset.mems_generation = atomic_read(&cpuset_mems_generation);
 
@@ -1300,12 +1355,13 @@ out:
 /**
  * cpuset_init_smp - initialize cpus_allowed
  *
- * Description: Initialize cpus_allowed after cpu_possible_map is initialized
+ * Description: Finish top cpuset after cpu, node maps are initialized
  **/
 
 void __init cpuset_init_smp(void)
 {
-	top_cpuset.cpus_allowed = cpu_possible_map;
+	top_cpuset.cpus_allowed = cpu_online_map;
+	top_cpuset.mems_allowed = node_online_map;
 }
 
 /**
@@ -1353,7 +1409,9 @@ void cpuset_exit(struct task_struct *tsk
  * @tsk: pointer to task_struct from which to obtain cpuset->cpus_allowed.
  *
  * Description: Returns the cpumask_t cpus_allowed of the cpuset
- * attached to the specified @tsk.
+ * attached to the specified @tsk.  Guaranteed to return some non-empty
+ * subset of cpu_online_map, even if this means going outside the
+ * tasks cpuset.
  **/
 
 const cpumask_t cpuset_cpus_allowed(const struct task_struct *tsk)
@@ -1362,10 +1420,7 @@ const cpumask_t cpuset_cpus_allowed(cons
 
 	down(&cpuset_sem);
 	task_lock((struct task_struct *)tsk);
-	if (tsk->cpuset)
-		mask = tsk->cpuset->cpus_allowed;
-	else
-		mask = CPU_MASK_ALL;
+	guarantee_online_cpus(tsk->cpuset, &mask);
 	task_unlock((struct task_struct *)tsk);
 	up(&cpuset_sem);
 
@@ -1382,6 +1437,7 @@ void cpuset_init_current_mems_allowed(vo
  * update current->mems_allowed and mems_generation to the new value.
  * Do not call this routine if in_interrupt().
  */
+
 void cpuset_update_current_mems_allowed()
 {
 	struct cpuset *cs = current->cpuset;
@@ -1390,7 +1446,7 @@ void cpuset_update_current_mems_allowed(
 		return;		/* task is exiting */
 	if (current->cpuset_mems_generation != cs->mems_generation) {
 		down(&cpuset_sem);
-		current->mems_allowed = cs->mems_allowed;
+		guarantee_online_mems(cs, &current->mems_allowed);
 		current->cpuset_mems_generation = cs->mems_generation;
 		up(&cpuset_sem);
 	}
Index: 2.6.9-rc1-mm4/kernel/sched.c
===================================================================
--- 2.6.9-rc1-mm4.orig/kernel/sched.c	2004-09-08 15:09:56.000000000 -0700
+++ 2.6.9-rc1-mm4/kernel/sched.c	2004-09-11 20:20:27.000000000 -0700
@@ -3808,9 +3808,7 @@ static void move_task_off_dead_cpu(int d
 
 	/* No more Mr. Nice Guy. */
 	if (dest_cpu == NR_CPUS) {
-			tsk->cpus_allowed = cpuset_cpus_allowed(tsk);
-			if (!cpus_intersects(tsk->cpus_allowed, cpu_online_map))
-				cpus_setall(tsk->cpus_allowed);
+		tsk->cpus_allowed = cpuset_cpus_allowed(tsk);
 		dest_cpu = any_online_cpu(tsk->cpus_allowed);
 
 		/*

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
