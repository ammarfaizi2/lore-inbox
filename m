Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266914AbUHYRVu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266914AbUHYRVu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 13:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268153AbUHYRVt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 13:21:49 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:63468 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S266914AbUHYRVn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 13:21:43 -0400
Date: Wed, 25 Aug 2004 10:21:38 -0700 (PDT)
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org
Message-Id: <20040825172141.28782.84710.68000@sam.engr.sgi.com>
Subject: [PATCH] Cpusets - simplify memory generation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apply a couple of simplications to the cpuset_mems_generation
mechanism used to trigger a task into updating its mems_allowed
when its cpuset memory placement changes:

  1) Didn't need tasklock, since only dealing with current task,
     and no one else is going to nuke current->cpuset out from
     under us.

  2) Instead of dropping the cpuset semaphore cpuset_sem, and then
     jumping through flaming write-memory-barrier hoops to ensure
     that we didn't get an out of order generation number, rather
     pick off the current cpusets generation number while we have
     the cpuset locked anyway getting its nodemask.

The combination of the above allowed several fussy lines of code to
go poof into thin air.

Applies to 2.6.8.1-mm4.  Builds, boots and unit tests on ia64 sn2_defconfig.

Applies most cleanly on top of the patch just sent:

	Cpusets tasks file: simplify format, fix seeks

but can be taken separately no problem.

Signed-off-by: Paul Jackson <pj@sgi.com>

Index: 2.6.8.1-mm4/include/linux/cpuset.h
===================================================================
--- 2.6.8.1-mm4.orig/include/linux/cpuset.h	2004-08-25 08:10:26.000000000 -0700
+++ 2.6.8.1-mm4/include/linux/cpuset.h	2004-08-25 08:12:30.000000000 -0700
@@ -19,7 +19,6 @@ extern void cpuset_init_smp(void);
 extern void cpuset_fork(struct task_struct *p);
 extern void cpuset_exit(struct task_struct *p);
 extern const cpumask_t cpuset_cpus_allowed(const struct task_struct *p);
-extern const nodemask_t cpuset_mems_allowed(const struct task_struct *p);
 void cpuset_init_current_mems_allowed(void);
 void cpuset_update_current_mems_allowed(void);
 void cpuset_restrict_to_mems_allowed(unsigned long *nodes);
@@ -39,11 +38,6 @@ static inline const cpumask_t cpuset_cpu
 	return cpu_possible_map;
 }
 
-static inline const nodemask_t cpuset_mems_allowed(struct task_struct *p)
-{
-	return node_possible_map;
-}
-
 static inline void cpuset_init_current_mems_allowed(void) {}
 static inline void cpuset_update_current_mems_allowed(void) {}
 static inline void cpuset_restrict_to_mems_allowed(unsigned long *nodes) {}
Index: 2.6.8.1-mm4/kernel/cpuset.c
===================================================================
--- 2.6.8.1-mm4.orig/kernel/cpuset.c	2004-08-25 08:12:04.000000000 -0700
+++ 2.6.8.1-mm4/kernel/cpuset.c	2004-08-25 08:12:30.000000000 -0700
@@ -567,7 +567,6 @@ static int update_nodemask(struct cpuset
 	if (retval == 0) {
 		cs->mems_allowed = trialcs.mems_allowed;
 		atomic_inc(&cpuset_mems_generation);
-		wmb();	/* insure above mems_allowed seen before next line */
 		cs->mems_generation = atomic_read(&cpuset_mems_generation);
 	}
 	return retval;
@@ -1223,7 +1222,6 @@ static long cpuset_create(struct cpuset 
 	INIT_LIST_HEAD(&cs->sibling);
 	INIT_LIST_HEAD(&cs->children);
 	atomic_inc(&cpuset_mems_generation);
-	wmb();	/* insure above mems_allowed seen before next line */
 	cs->mems_generation = atomic_read(&cpuset_mems_generation);
 
 	cs->parent = parent;
@@ -1397,53 +1395,27 @@ const cpumask_t cpuset_cpus_allowed(cons
 	return mask;
 }
 
-/**
- * cpuset_mems_allowed - return mems_allowed mask from a tasks cpuset.
- * @tsk: pointer to task_struct from which to obtain cpuset->mems_allowed.
- *
- * Description: Returns the nodemask_t mems_allowed of the cpuset
- * attached to the specified @tsk.
- **/
-
-const nodemask_t cpuset_mems_allowed(const struct task_struct *tsk)
-{
-	nodemask_t mask;
-
-	down(&cpuset_sem);
-	task_lock((struct task_struct *)tsk);
-	if (tsk->cpuset)
-		mask = tsk->cpuset->mems_allowed;
-	else
-		mask = NODE_MASK_ALL;
-	task_unlock((struct task_struct *)tsk);
-	up(&cpuset_sem);
-
-	return mask;
-}
-
 void cpuset_init_current_mems_allowed(void)
 {
 	current->mems_allowed = NODE_MASK_ALL;
 }
 
 /*
- * If the current tasks cpusets mems_allowed changes behind our backs,
- * update current->mems_allowed to the new value.  While loop for rare
- * race with concurrent cpuset changes.  Must insure that we never see
- * the next generation number with an old mems_allowed, in order to
- * avoid having stale mems_allowed w/o knowing it.  See also the wmb()
- * calls above.  Do not call this routine if in_interrupt().
+ * If the current tasks cpusets mems_allowed changed behind our backs,
+ * update current->mems_allowed and mems_generation to the new value.
+ * Do not call this routine if in_interrupt().
  */
 void cpuset_update_current_mems_allowed()
 {
-	int g;
+	struct cpuset *cs = current->cpuset;
 
-	if (!current->cpuset)
+	if (!cs)
 		return;		/* task is exiting */
-	while ((g = current->cpuset->mems_generation) !=
-					current->cpuset_mems_generation) {
-		current->mems_allowed = cpuset_mems_allowed(current);
-		current->cpuset_mems_generation = g;
+	if (current->cpuset_mems_generation != cs->mems_generation) {
+		down(&cpuset_sem);
+		current->mems_allowed = cs->mems_allowed;
+		current->cpuset_mems_generation = cs->mems_generation;
+		up(&cpuset_sem);
 	}
 }
 

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
