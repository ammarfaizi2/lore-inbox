Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964965AbVLJIU2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964965AbVLJIU2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 03:20:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964967AbVLJIUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 03:20:00 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:35033 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S964971AbVLJITr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 03:19:47 -0500
Date: Sat, 10 Dec 2005 00:19:39 -0800 (PST)
From: Paul Jackson <pj@sgi.com>
To: akpm@osdl.org
Cc: Simon Derr <Simon.Derr@bull.net>, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org, Christoph Lameter <clameter@sgi.com>
Message-Id: <20051210081939.12303.77511.sendpatchset@jackhammer.engr.sgi.com>
In-Reply-To: <20051210081843.12303.13344.sendpatchset@jackhammer.engr.sgi.com>
References: <20051210081843.12303.13344.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH 10/10] Cpuset: migrate all tasks in cpuset at once
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Given the mechanism in the previous patch to handle rebinding
the per-vma mempolicies of all tasks in a cpuset that changes its
memory placement, it is now easier to handle the page migration
requirements of such tasks at the same time.

The previous code didn't actually attempt to migrate the pages
of the tasks in a cpuset whose memory placement changed until
the next time each such task tried to allocate memory.  This was
undesirable, as users invoking memory page migration exected
to happen when the placement changed, not some unspecified time
later when the task needed more memory.

It is now trivial to handle the page migration at the same time
as the per-vma rebinding is done.

The routine cpuset.c:update_nodemask(), which handles changing a
cpusets memory placement ('mems') now checks for the special case
of being asked to write a placement that is the same as before.
It was harmless enough before to just recompute everything again,
even though nothing had changed.  But page migration is a heavy
weight operation - moving pages about.  So now it is worth
avoiding that if asked to move a cpuset to its current location.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

 kernel/cpuset.c |   29 ++++++++++++++++-------------
 1 files changed, 16 insertions(+), 13 deletions(-)

--- 2.6.15-rc3-mm1.orig/kernel/cpuset.c	2005-12-09 05:08:00.834840778 -0800
+++ 2.6.15-rc3-mm1/kernel/cpuset.c	2005-12-09 05:09:55.573472784 -0800
@@ -639,25 +639,14 @@ void cpuset_update_task_memory_state()
 	task_unlock(tsk);
 
 	if (my_cpusets_mem_gen != tsk->cpuset_mems_generation) {
-		nodemask_t oldmem = tsk->mems_allowed;
-		int migrate;
-
 		down(&callback_sem);
 		task_lock(tsk);
 		cs = tsk->cpuset;	/* Maybe changed when task not locked */
-		migrate = is_memory_migrate(cs);
 		guarantee_online_mems(cs, &tsk->mems_allowed);
 		tsk->cpuset_mems_generation = cs->mems_generation;
 		task_unlock(tsk);
 		up(&callback_sem);
 		mpol_rebind_task(tsk, &tsk->mems_allowed);
-		if (!nodes_equal(oldmem, tsk->mems_allowed)) {
-			if (migrate) {
-				do_migrate_pages(tsk->mm, &oldmem,
-					&tsk->mems_allowed,
-					MPOL_MF_MOVE_ALL);
-			}
-		}
 	}
 }
 
@@ -815,7 +804,9 @@ static int update_cpumask(struct cpuset 
  * Handle user request to change the 'mems' memory placement
  * of a cpuset.  Needs to validate the request, update the
  * cpusets mems_allowed and mems_generation, and for each
- * task in the cpuset, rebind any vma mempolicies.
+ * task in the cpuset, rebind any vma mempolicies and if
+ * the cpuset is marked 'memory_migrate', migrate the tasks
+ * pages to the new memory.
  *
  * Call with manage_sem held.  May take callback_sem during call.
  * Will take tasklist_lock, scan tasklist for tasks in cpuset cs,
@@ -826,9 +817,11 @@ static int update_cpumask(struct cpuset 
 static int update_nodemask(struct cpuset *cs, char *buf)
 {
 	struct cpuset trialcs;
+	nodemask_t oldmem;
 	struct task_struct *g, *p;
 	struct mm_struct **mmarray;
 	int i, n, ntasks;
+	int migrate;
 	int fudge;
 	int retval;
 
@@ -837,6 +830,11 @@ static int update_nodemask(struct cpuset
 	if (retval < 0)
 		goto done;
 	nodes_and(trialcs.mems_allowed, trialcs.mems_allowed, node_online_map);
+	oldmem = cs->mems_allowed;
+	if (nodes_equal(oldmem, trialcs.mems_allowed)) {
+		retval = 0;		/* Too easy - nothing to do */
+		goto done;
+	}
 	if (nodes_empty(trialcs.mems_allowed)) {
 		retval = -ENOSPC;
 		goto done;
@@ -912,12 +910,17 @@ static int update_nodemask(struct cpuset
 	 * cpuset manage_sem, we know that no other rebind effort will
 	 * be contending for the global variable cpuset_being_rebound.
 	 * It's ok if we rebind the same mm twice; mpol_rebind_mm()
-	 * is idempotent.
+	 * is idempotent.  Also migrate pages in each mm to new nodes.
 	 */
+	migrate = is_memory_migrate(cs);
 	for (i = 0; i < n; i++) {
 		struct mm_struct *mm = mmarray[i];
 
 		mpol_rebind_mm(mm, &cs->mems_allowed);
+		if (migrate) {
+			do_migrate_pages(mm, &oldmem, &cs->mems_allowed,
+							MPOL_MF_MOVE_ALL);
+		}
 		mmput(mm);
 	}
 

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
