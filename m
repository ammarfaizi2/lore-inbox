Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932145AbVLNIkv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbVLNIkv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 03:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbVLNIku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 03:40:50 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:41918 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932143AbVLNIkt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 03:40:49 -0500
Date: Wed, 14 Dec 2005 00:40:31 -0800 (PST)
From: Paul Jackson <pj@sgi.com>
To: akpm@osdl.org
Cc: Eric Dumazet <dada1@cosmosbay.com>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>, Simon Derr <Simon.Derr@bull.net>,
       Andi Kleen <ak@suse.de>, Paul Jackson <pj@sgi.com>,
       Christoph Lameter <clameter@sgi.com>
Message-Id: <20051214084031.21054.13829.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH 01/04] Cpuset: remove rcu slab cache optimization
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reverse the two patches that added slab-based rcu opimization:
  cpuset-rcu-slab-cache-optimization
  cpuset-rcu-slab-cache-optimization-comment

An improved version, not using the slab cache, will be used
instead.  Each slab cache created costs some memory on each cpu
to manage the cache, which is not worth it in this case.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

 kernel/cpuset.c |   48 +++++++++++-------------------------------------
 1 files changed, 11 insertions(+), 37 deletions(-)

--- 2.6.15-rc3-mm1.orig/kernel/cpuset.c	2005-12-13 16:46:31.446507555 -0800
+++ 2.6.15-rc3-mm1/kernel/cpuset.c	2005-12-13 16:49:01.767509666 -0800
@@ -63,18 +63,6 @@
  */
 int number_of_cpusets;
 
-/*
- * Take cpusets from a slab cache marked SLAB_DESTROY_BY_RCU, so
- * that on the critical code path cpuset_update_task_memory_state(),
- * we can safely read task->cpuset->mems_generation with just
- * an rcu lock, w/o risk of a slab cache free invalidating that
- * memory location.  It might not be our tasks cpuset anymore,
- * but at least it will be safe to load from it, which is good
- * enough when checking for a changed mems_generation.
- */
-
-static kmem_cache_t *cpuset_cache;
-
 /* See "Frequency meter" comments, below. */
 
 struct fmeter {
@@ -260,10 +248,6 @@ static struct super_block *cpuset_sb;
  * a tasks cpuset pointer we use task_lock(), which acts on a spinlock
  * (task->alloc_lock) already in the task_struct routinely used for
  * such matters.
- *
- * P.S.  One more locking exception.  See the use of rcu_read_lock
- * when checking a tasks cpuset->mems_generation in the routine
- * cpuset_update_task_memory_state below.
  */
 
 static DECLARE_MUTEX(manage_sem);
@@ -305,7 +289,7 @@ static void cpuset_diput(struct dentry *
 	if (S_ISDIR(inode->i_mode)) {
 		struct cpuset *cs = dentry->d_fsdata;
 		BUG_ON(!(is_removed(cs)));
-		kmem_cache_free(cpuset_cache, cs);
+		kfree(cs);
 	}
 	iput(inode);
 }
@@ -626,17 +610,12 @@ static void guarantee_online_mems(const 
  * cpuset pointer.  This routine also might acquire callback_sem and
  * current->mm->mmap_sem during call.
  *
- * Reading current->cpuset->mems_generation doesn't need task_lock,
- * because cpusets are on a slab cache marked SLAB_DESTROY_BY_RCU,
- * so the rcu_read_lock() insures the memory read will not yet be
- * unmapped.  It's ok if attach_task() replaces our cpuset with
- * another while we are reading mems_generation, and even frees it.
- *
- * We do -not- need to guard the 'cs' pointer dereference within the
- * rcu_read_lock section with rcu_dereference(), because we don't
- * mind getting bogus out-of-order results.  New cpuset pointer and
- * old mems_generation is ok - we'll realize that our cpuset memory
- * placement changed the next time through here.
+ * The task_lock() is required to dereference current->cpuset safely.
+ * Without it, we could pick up the pointer value of current->cpuset
+ * in one instruction, and then attach_task could give us a different
+ * cpuset, and then the cpuset we had could be removed and freed,
+ * and then on our next instruction, we could dereference a no longer
+ * valid cpuset pointer to get its mems_generation field.
  *
  * This routine is needed to update the per-task mems_allowed data,
  * within the tasks context, when it is trying to allocate memory
@@ -650,9 +629,9 @@ void cpuset_update_task_memory_state()
 	struct task_struct *tsk = current;
 	struct cpuset *cs = tsk->cpuset;
 
-	rcu_read_lock();
+	task_lock(tsk);
 	my_cpusets_mem_gen = cs->mems_generation;
-	rcu_read_unlock();
+	task_unlock(tsk);
 
 	if (my_cpusets_mem_gen != tsk->cpuset_mems_generation) {
 		down(&callback_sem);
@@ -1758,7 +1737,7 @@ static long cpuset_create(struct cpuset 
 	struct cpuset *cs;
 	int err;
 
-	cs = kmem_cache_alloc(cpuset_cache, GFP_KERNEL);
+	cs = kmalloc(sizeof(*cs), GFP_KERNEL);
 	if (!cs)
 		return -ENOMEM;
 
@@ -1800,7 +1779,7 @@ static long cpuset_create(struct cpuset 
 err:
 	list_del(&cs->sibling);
 	up(&manage_sem);
-	kmem_cache_free(cpuset_cache, cs);
+	kfree(cs);
 	return err;
 }
 
@@ -1878,11 +1857,6 @@ int __init cpuset_init(void)
 	struct dentry *root;
 	int err;
 
-	cpuset_cache = kmem_cache_create("cpuset_cache",
-					sizeof(struct cpuset), 0,
-					SLAB_DESTROY_BY_RCU | SLAB_PANIC,
-					NULL, NULL);
-
 	top_cpuset.cpus_allowed = CPU_MASK_ALL;
 	top_cpuset.mems_allowed = NODE_MASK_ALL;
 

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
