Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750917AbVLKXbk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750917AbVLKXbk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 18:31:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750919AbVLKXbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 18:31:40 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:9120 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750915AbVLKXbk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 18:31:40 -0500
Date: Sun, 11 Dec 2005 15:31:30 -0800 (PST)
From: Paul Jackson <pj@sgi.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
       Simon Derr <Simon.Derr@bull.net>, Andi Kleen <ak@suse.de>,
       Paul Jackson <pj@sgi.com>, Christoph Lameter <clameter@sgi.com>
Message-Id: <20051211233130.18000.2748.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH] Cpuset: rcu optimization of page alloc hook
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Optimize the cpuset impact on page allocation, the most
performance critical cpuset hook in the kernel.

On each page allocation, the cpuset hook needs to check for a
possible change in the current tasks cpuset.  It can now handle
the common case, of no change, without taking any spinlock or
semaphore, thanks to RCU.

Convert a spinlock on the current task to an rcu_read_lock(),
saving approximately a memory barrier and an atomic op, depending
on architecture.

This is done by putting struct cpusets in a slab cache marked
SLAB_DESTROY_BY_RCU, so that an rcu_read_lock can ensure that
the slab won't free the memory behind a cpuset struct.

Thanks to Andi Kleen and Nick Piggin for the suggestion.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

 kernel/cpuset.c |   42 +++++++++++++++++++++++++++++++-----------
 1 files changed, 31 insertions(+), 11 deletions(-)

--- 2.6.15-rc3-mm1.orig/kernel/cpuset.c	2005-12-11 13:31:16.925866678 -0800
+++ 2.6.15-rc3-mm1/kernel/cpuset.c	2005-12-11 14:26:57.184694603 -0800
@@ -63,6 +63,18 @@
  */
 int number_of_cpusets;
 
+/*
+ * Take cpusets from a slab cache marked SLAB_DESTROY_BY_RCU, so
+ * that on the critical code path cpuset_update_task_memory_state(),
+ * we can safely read task->cpuset->mems_generation with just
+ * an rcu lock, w/o risk of a slab cache free invalidating that
+ * memory location.  It might not be our tasks cpuset anymore,
+ * but at least it will be safe to load from it, which is good
+ * enough when checking for a changed mems_generation.
+ */
+
+static kmem_cache_t *cpuset_cache;
+
 /* See "Frequency meter" comments, below. */
 
 struct fmeter {
@@ -248,6 +260,10 @@ static struct super_block *cpuset_sb;
  * a tasks cpuset pointer we use task_lock(), which acts on a spinlock
  * (task->alloc_lock) already in the task_struct routinely used for
  * such matters.
+ *
+ * P.S.  One more locking exception.  See the use of rcu_read_lock
+ * when checking a tasks cpuset->mems_generation in the routine
+ * cpuset_update_task_memory_state below.
  */
 
 static DECLARE_MUTEX(manage_sem);
@@ -289,7 +305,7 @@ static void cpuset_diput(struct dentry *
 	if (S_ISDIR(inode->i_mode)) {
 		struct cpuset *cs = dentry->d_fsdata;
 		BUG_ON(!(is_removed(cs)));
-		kfree(cs);
+		kmem_cache_free(cpuset_cache, cs);
 	}
 	iput(inode);
 }
@@ -612,12 +628,11 @@ static void guarantee_online_mems(const 
  * cpuset pointer.  This routine also might acquire callback_sem and
  * current->mm->mmap_sem during call.
  *
- * The task_lock() is required to dereference current->cpuset safely.
- * Without it, we could pick up the pointer value of current->cpuset
- * in one instruction, and then attach_task could give us a different
- * cpuset, and then the cpuset we had could be removed and freed,
- * and then on our next instruction, we could dereference a no longer
- * valid cpuset pointer to get its mems_generation field.
+ * Reading current->cpuset->mems_generation doesn't need task_lock,
+ * because cpusets are on a slab cache marked SLAB_DESTROY_BY_RCU,
+ * so the rcu_read_lock() insures the memory read will not yet be
+ * unmapped.  It's ok if attach_task() replaces our cpuset with
+ * another while we are reading mems_generation, and even frees it.
  *
  * This routine is needed to update the per-task mems_allowed data,
  * within the tasks context, when it is trying to allocate memory
@@ -634,9 +649,9 @@ void cpuset_update_task_memory_state()
 	if (unlikely(!cs))
 		return;
 
-	task_lock(tsk);
+	rcu_read_lock();
 	my_cpusets_mem_gen = cs->mems_generation;
-	task_unlock(tsk);
+	rcu_read_unlock();
 
 	if (my_cpusets_mem_gen != tsk->cpuset_mems_generation) {
 		down(&callback_sem);
@@ -1742,7 +1757,7 @@ static long cpuset_create(struct cpuset 
 	struct cpuset *cs;
 	int err;
 
-	cs = kmalloc(sizeof(*cs), GFP_KERNEL);
+	cs = kmem_cache_alloc(cpuset_cache, GFP_KERNEL);
 	if (!cs)
 		return -ENOMEM;
 
@@ -1784,7 +1799,7 @@ static long cpuset_create(struct cpuset 
 err:
 	list_del(&cs->sibling);
 	up(&manage_sem);
-	kfree(cs);
+	kmem_cache_free(cpuset_cache, cs);
 	return err;
 }
 
@@ -1847,6 +1862,11 @@ int __init cpuset_init(void)
 	struct dentry *root;
 	int err;
 
+	cpuset_cache = kmem_cache_create("cpuset_cache",
+					sizeof(struct cpuset), 0,
+					SLAB_DESTROY_BY_RCU | SLAB_PANIC,
+					NULL, NULL);
+
 	top_cpuset.cpus_allowed = CPU_MASK_ALL;
 	top_cpuset.mems_allowed = NODE_MASK_ALL;
 

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
