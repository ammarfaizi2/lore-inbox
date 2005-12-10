Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964968AbVLJITb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964968AbVLJITb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 03:19:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964973AbVLJITb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 03:19:31 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:15065 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S964968AbVLJITU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 03:19:20 -0500
Date: Sat, 10 Dec 2005 00:19:11 -0800 (PST)
From: Paul Jackson <pj@sgi.com>
To: akpm@osdl.org
Cc: Paul Jackson <pj@sgi.com>, Simon Derr <Simon.Derr@bull.net>,
       linux-kernel@vger.kernel.org, Christoph Lameter <clameter@sgi.com>
Message-Id: <20051210081911.12303.37673.sendpatchset@jackhammer.engr.sgi.com>
In-Reply-To: <20051210081843.12303.13344.sendpatchset@jackhammer.engr.sgi.com>
References: <20051210081843.12303.13344.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH 05/10] Cpuset: combine refresh_mems and update_mems
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The important code paths through alloc_pages_current()
and alloc_page_vma(), by which most kernel page allocations
go, both called cpuset_update_current_mems_allowed(),
which in turn called refresh_mems().  -Both- of these
latter two routines did a tasklock, got the tasks cpuset
pointer, and checked for out of date cpuset->mems_generation.

That was a silly duplication of code and waste of CPU cycles
on an important code path.

Consolidated those two routines into a single routine,
called cpuset_update_task_memory_state(), since it updates
more than just mems_allowed.

Changed all callers of either routine to call the new
consolidated routine.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

 include/linux/cpuset.h |    4 +-
 kernel/cpuset.c        |   95 +++++++++++++++++++++----------------------------
 mm/mempolicy.c         |   10 ++---
 3 files changed, 48 insertions(+), 61 deletions(-)

--- 2.6.15-rc3-mm1.orig/include/linux/cpuset.h	2005-12-07 22:00:40.525006978 -0800
+++ 2.6.15-rc3-mm1/include/linux/cpuset.h	2005-12-07 23:48:54.860211028 -0800
@@ -20,7 +20,7 @@ extern void cpuset_fork(struct task_stru
 extern void cpuset_exit(struct task_struct *p);
 extern cpumask_t cpuset_cpus_allowed(const struct task_struct *p);
 void cpuset_init_current_mems_allowed(void);
-void cpuset_update_current_mems_allowed(void);
+void cpuset_update_task_memory_state(void);
 #define cpuset_nodes_subset_current_mems_allowed(nodes) \
 		nodes_subset((nodes), current->mems_allowed)
 int cpuset_zonelist_valid_mems_allowed(struct zonelist *zl);
@@ -51,7 +51,7 @@ static inline cpumask_t cpuset_cpus_allo
 }
 
 static inline void cpuset_init_current_mems_allowed(void) {}
-static inline void cpuset_update_current_mems_allowed(void) {}
+static inline void cpuset_update_task_memory_state(void) {}
 #define cpuset_nodes_subset_current_mems_allowed(nodes) (1)
 
 static inline int cpuset_zonelist_valid_mems_allowed(struct zonelist *zl)
--- 2.6.15-rc3-mm1.orig/kernel/cpuset.c	2005-12-07 22:12:08.509137821 -0800
+++ 2.6.15-rc3-mm1/kernel/cpuset.c	2005-12-07 23:52:21.746290572 -0800
@@ -584,13 +584,26 @@ static void guarantee_online_mems(const 
 	BUG_ON(!nodes_intersects(*pmask, node_online_map));
 }
 
-/*
- * Refresh current tasks mems_allowed and mems_generation from current
- * tasks cpuset.
+/**
+ * cpuset_update_task_memory_state - update task memory placement
  *
- * Call without callback_sem or task_lock() held.  May be called with
- * or without manage_sem held.  Will acquire task_lock() and might
- * acquire callback_sem during call.
+ * If the current tasks cpusets mems_allowed changed behind our
+ * backs, update current->mems_allowed, mems_generation and task NUMA
+ * mempolicy to the new value.
+ *
+ * Task mempolicy is updated by rebinding it relative to the
+ * current->cpuset if a task has its memory placement changed.
+ * Do not call this routine if in_interrupt().
+ *
+ * Call without callback_sem or task_lock() held.  May be called
+ * with or without manage_sem held.  Except in early boot or
+ * an exiting task, when tsk->cpuset is NULL, this routine will
+ * acquire task_lock().  We don't need to use task_lock to guard
+ * against another task changing a non-NULL cpuset pointer to NULL,
+ * as that is only done by a task on itself, and if the current task
+ * is here, it is not simultaneously in the exit code NULL'ing its
+ * cpuset pointer.  This routine also might acquire callback_sem and
+ * current->mm->mmap_sem during call.
  *
  * The task_lock() is required to dereference current->cpuset safely.
  * Without it, we could pick up the pointer value of current->cpuset
@@ -605,32 +618,36 @@ static void guarantee_online_mems(const 
  * task has been modifying its cpuset.
  */
 
-static void refresh_mems(void)
+void cpuset_update_task_memory_state()
 {
 	int my_cpusets_mem_gen;
+	struct task_struct *tsk = current;
+	struct cpuset *cs = tsk->cpuset;
 
-	task_lock(current);
-	my_cpusets_mem_gen = current->cpuset->mems_generation;
-	task_unlock(current);
+	if (unlikely(!cs))
+		return;
+
+	task_lock(tsk);
+	my_cpusets_mem_gen = cs->mems_generation;
+	task_unlock(tsk);
 
-	if (current->cpuset_mems_generation != my_cpusets_mem_gen) {
-		struct cpuset *cs;
-		nodemask_t oldmem = current->mems_allowed;
+	if (my_cpusets_mem_gen != tsk->cpuset_mems_generation) {
+		nodemask_t oldmem = tsk->mems_allowed;
 		int migrate;
 
 		down(&callback_sem);
-		task_lock(current);
-		cs = current->cpuset;
+		task_lock(tsk);
+		cs = tsk->cpuset;	/* Maybe changed when task not locked */
 		migrate = is_memory_migrate(cs);
-		guarantee_online_mems(cs, &current->mems_allowed);
-		current->cpuset_mems_generation = cs->mems_generation;
-		task_unlock(current);
+		guarantee_online_mems(cs, &tsk->mems_allowed);
+		tsk->cpuset_mems_generation = cs->mems_generation;
+		task_unlock(tsk);
 		up(&callback_sem);
-		if (!nodes_equal(oldmem, current->mems_allowed)) {
-			numa_policy_rebind(&oldmem, &current->mems_allowed);
+		numa_policy_rebind(&oldmem, &tsk->mems_allowed);
+		if (!nodes_equal(oldmem, tsk->mems_allowed)) {
 			if (migrate) {
-				do_migrate_pages(current->mm, &oldmem,
-					&current->mems_allowed,
+				do_migrate_pages(tsk->mm, &oldmem,
+					&tsk->mems_allowed,
 					MPOL_MF_MOVE_ALL);
 			}
 		}
@@ -1630,7 +1647,7 @@ static long cpuset_create(struct cpuset 
 		return -ENOMEM;
 
 	down(&manage_sem);
-	refresh_mems();
+	cpuset_update_task_memory_state();
 	cs->flags = 0;
 	if (notify_on_release(parent))
 		set_bit(CS_NOTIFY_ON_RELEASE, &cs->flags);
@@ -1688,7 +1705,7 @@ static int cpuset_rmdir(struct inode *un
 	/* the vfs holds both inode->i_sem already */
 
 	down(&manage_sem);
-	refresh_mems();
+	cpuset_update_task_memory_state();
 	if (atomic_read(&cs->count) > 0) {
 		up(&manage_sem);
 		return -EBUSY;
@@ -1873,36 +1890,6 @@ void cpuset_init_current_mems_allowed(vo
 }
 
 /**
- * cpuset_update_current_mems_allowed - update mems parameters to new values
- *
- * If the current tasks cpusets mems_allowed changed behind our backs,
- * update current->mems_allowed and mems_generation to the new value.
- * Do not call this routine if in_interrupt().
- *
- * Call without callback_sem or task_lock() held.  May be called
- * with or without manage_sem held.  Unless exiting, it will acquire
- * task_lock().  Also might acquire callback_sem during call to
- * refresh_mems().
- */
-
-void cpuset_update_current_mems_allowed(void)
-{
-	struct cpuset *cs;
-	int need_to_refresh = 0;
-
-	task_lock(current);
-	cs = current->cpuset;
-	if (!cs)
-		goto done;
-	if (current->cpuset_mems_generation != cs->mems_generation)
-		need_to_refresh = 1;
-done:
-	task_unlock(current);
-	if (need_to_refresh)
-		refresh_mems();
-}
-
-/**
  * cpuset_zonelist_valid_mems_allowed - check zonelist vs. curremt mems_allowed
  * @zl: the zonelist to be checked
  *
--- 2.6.15-rc3-mm1.orig/mm/mempolicy.c	2005-12-07 22:00:40.525983551 -0800
+++ 2.6.15-rc3-mm1/mm/mempolicy.c	2005-12-07 23:48:54.994978144 -0800
@@ -389,7 +389,7 @@ static int contextualize_policy(int mode
 	if (!nodes)
 		return 0;
 
-	cpuset_update_current_mems_allowed();
+	cpuset_update_task_memory_state();
 	if (!cpuset_nodes_subset_current_mems_allowed(*nodes))
 		return -EINVAL;
 	return mpol_check_policy(mode, nodes);
@@ -463,7 +463,7 @@ long do_get_mempolicy(int *policy, nodem
 	struct vm_area_struct *vma = NULL;
 	struct mempolicy *pol = current->mempolicy;
 
-	cpuset_update_current_mems_allowed();
+	cpuset_update_task_memory_state();
 	if (flags & ~(unsigned long)(MPOL_F_NODE|MPOL_F_ADDR))
 		return -EINVAL;
 	if (flags & MPOL_F_ADDR) {
@@ -1118,7 +1118,7 @@ alloc_page_vma(gfp_t gfp, struct vm_area
 {
 	struct mempolicy *pol = get_vma_policy(current, vma, addr);
 
-	cpuset_update_current_mems_allowed();
+	cpuset_update_task_memory_state();
 
 	if (unlikely(pol->policy == MPOL_INTERLEAVE)) {
 		unsigned nid;
@@ -1144,7 +1144,7 @@ alloc_page_vma(gfp_t gfp, struct vm_area
  *	interrupt context and apply the current process NUMA policy.
  *	Returns NULL when no page can be allocated.
  *
- *	Don't call cpuset_update_current_mems_allowed() unless
+ *	Don't call cpuset_update_task_memory_state() unless
  *	1) it's ok to take cpuset_sem (can WAIT), and
  *	2) allocating for current task (not interrupt).
  */
@@ -1153,7 +1153,7 @@ struct page *alloc_pages_current(gfp_t g
 	struct mempolicy *pol = current->mempolicy;
 
 	if ((gfp & __GFP_WAIT) && !in_interrupt())
-		cpuset_update_current_mems_allowed();
+		cpuset_update_task_memory_state();
 	if (!pol || in_interrupt())
 		pol = &default_policy;
 	if (pol->policy == MPOL_INTERLEAVE)

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
