Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751083AbWBWJbc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbWBWJbc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 04:31:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751063AbWBWJbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 04:31:15 -0500
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:6370 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1751060AbWBWJbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 04:31:09 -0500
Subject: [Patch 2/3] fast VMA recycling
From: Arjan van de Ven <arjan@intel.linux.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, ak@suse.de
In-Reply-To: <1140686238.2972.30.camel@laptopd505.fenrus.org>
References: <1140686238.2972.30.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 23 Feb 2006 10:30:29 +0100
Message-Id: <1140687029.4672.8.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a per task-struct cache of a free vma. 

In normal operation, it is a really common action during userspace mmap 
or malloc to first allocate a vma, and then find out that it can be merged,
and thus free it again. In fact this is the case roughly 95% of the time.

In addition, this patch allows code to "prepopulate" the cache, and
this is done as example for the x86_64 mmap codepath. The advantage of this
prepopulation is that the memory allocation (which is a sleeping operation
due to the GFP_KERNEL flag, potentially causing either a direct sleep or a 
voluntary preempt sleep) will happen before the mmap_sem is taken, and thus 
reduces lock hold time (and thus the contention potential)

The cache is only allowed to be accessed for "current", and not from IRQ
context. This allows for lockless access, making it a cheap cache.

One could argue that this should be a generic slab feature (the preloading) but
that only gives some of the gains and not all, and vma's are small creatures,
with a high "recycling" rate in typical cases.

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

---
 arch/x86_64/kernel/sys_x86_64.c |    2 +
 include/linux/mm.h              |    2 +
 include/linux/sched.h           |    2 +
 kernel/exit.c                   |    4 +++
 kernel/fork.c                   |    2 +
 mm/mmap.c                       |   50 ++++++++++++++++++++++++++++++++--------
 6 files changed, 52 insertions(+), 10 deletions(-)

Index: linux-work/arch/x86_64/kernel/sys_x86_64.c
===================================================================
--- linux-work.orig/arch/x86_64/kernel/sys_x86_64.c
+++ linux-work/arch/x86_64/kernel/sys_x86_64.c
@@ -55,6 +55,8 @@ asmlinkage long sys_mmap(unsigned long a
 		if (!file)
 			goto out;
 	}
+
+	prepopulate_vma();
 	down_write(&current->mm->mmap_sem);
 	error = do_mmap_pgoff(file, addr, len, prot, flags, off >> PAGE_SHIFT);
 	up_write(&current->mm->mmap_sem);
Index: linux-work/include/linux/mm.h
===================================================================
--- linux-work.orig/include/linux/mm.h
+++ linux-work/include/linux/mm.h
@@ -1051,6 +1051,8 @@ int shrink_slab(unsigned long scanned, g
 void drop_pagecache(void);
 void drop_slab(void);
 
+extern void prepopulate_vma(void);
+
 extern int randomize_va_space;
 
 #endif /* __KERNEL__ */
Index: linux-work/include/linux/sched.h
===================================================================
--- linux-work.orig/include/linux/sched.h
+++ linux-work/include/linux/sched.h
@@ -838,6 +838,8 @@ struct task_struct {
 /* VM state */
 	struct reclaim_state *reclaim_state;
 
+	struct vm_area_struct *free_vma_cache;  /* keep 1 free vma around as cache */
+
 	struct dentry *proc_dentry;
 	struct backing_dev_info *backing_dev_info;
 
Index: linux-work/kernel/exit.c
===================================================================
--- linux-work.orig/kernel/exit.c
+++ linux-work/kernel/exit.c
@@ -878,6 +878,10 @@ fastcall NORET_TYPE void do_exit(long co
 	 */
 	mutex_debug_check_no_locks_held(tsk);
 
+	if (tsk->free_vma_cache)
+		kmem_cache_free(vm_area_cachep, tsk->free_vma_cache);
+	tsk->free_vma_cache = NULL;
+
 	/* PF_DEAD causes final put_task_struct after we schedule. */
 	preempt_disable();
 	BUG_ON(tsk->flags & PF_DEAD);
Index: linux-work/kernel/fork.c
===================================================================
--- linux-work.orig/kernel/fork.c
+++ linux-work/kernel/fork.c
@@ -179,6 +179,8 @@ static struct task_struct *dup_task_stru
 	/* One for us, one for whoever does the "release_task()" (usually parent) */
 	atomic_set(&tsk->usage,2);
 	atomic_set(&tsk->fs_excl, 0);
+	tsk->free_vma_cache = NULL;
+
 	return tsk;
 }
 
Index: linux-work/mm/mmap.c
===================================================================
--- linux-work.orig/mm/mmap.c
+++ linux-work/mm/mmap.c
@@ -65,6 +65,36 @@ int sysctl_overcommit_ratio = 50;	/* def
 int sysctl_max_map_count __read_mostly = DEFAULT_MAX_MAP_COUNT;
 atomic_t vm_committed_space = ATOMIC_INIT(0);
 
+
+static void free_vma(struct vm_area_struct *vma)
+{
+	struct vm_area_struct *oldvma;
+
+	oldvma = current->free_vma_cache;
+	current->free_vma_cache = vma;
+	if (oldvma)
+		kmem_cache_free(vm_area_cachep, oldvma);
+}
+
+static struct vm_area_struct *alloc_vma(void)
+{
+	if (current->free_vma_cache)  {
+		struct vm_area_struct *vma;
+		vma = current->free_vma_cache;
+		current->free_vma_cache = NULL;
+		return vma;
+	}
+	return kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
+}
+
+void prepopulate_vma(void)
+{
+	if (!current->free_vma_cache)
+		current->free_vma_cache =
+			kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
+}
+
+
 /*
  * Check that a process has enough memory to allocate a new virtual
  * mapping. 0 means there is enough memory for the allocation to
@@ -206,7 +236,7 @@ static struct vm_area_struct *remove_vma
 	if (vma->vm_file)
 		fput(vma->vm_file);
 	mpol_free(vma_policy(vma));
-	kmem_cache_free(vm_area_cachep, vma);
+	free_vma(vma);
 	return next;
 }
 
@@ -593,7 +623,7 @@ again:			remove_next = 1 + (end > next->
 			fput(file);
 		mm->map_count--;
 		mpol_free(vma_policy(next));
-		kmem_cache_free(vm_area_cachep, next);
+		free_vma(next);
 		/*
 		 * In mprotect's case 6 (see comments on vma_merge),
 		 * we must remove another next too. It would clutter
@@ -1048,7 +1078,7 @@ munmap_back:
 	 * specific mapper. the address has already been validated, but
 	 * not unmapped, but the maps are removed from the list.
 	 */
-	vma = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
+	vma = alloc_vma();
 	if (!vma) {
 		error = -ENOMEM;
 		goto unacct_error;
@@ -1113,7 +1143,7 @@ munmap_back:
 			fput(file);
 		}
 		mpol_free(vma_policy(vma));
-		kmem_cache_free(vm_area_cachep, vma);
+		free_vma(vma);
 	}
 out:	
 	mm->total_vm += len >> PAGE_SHIFT;
@@ -1140,7 +1170,7 @@ unmap_and_free_vma:
 	unmap_region(mm, vma, prev, vma->vm_start, vma->vm_end);
 	charged = 0;
 free_vma:
-	kmem_cache_free(vm_area_cachep, vma);
+	free_vma(vma);
 unacct_error:
 	if (charged)
 		vm_unacct_memory(charged);
@@ -1711,7 +1741,7 @@ int split_vma(struct mm_struct * mm, str
 	if (mm->map_count >= sysctl_max_map_count)
 		return -ENOMEM;
 
-	new = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
+	new = alloc_vma();
 	if (!new)
 		return -ENOMEM;
 
@@ -1727,7 +1757,7 @@ int split_vma(struct mm_struct * mm, str
 
 	pol = mpol_copy(vma_policy(vma));
 	if (IS_ERR(pol)) {
-		kmem_cache_free(vm_area_cachep, new);
+		free_vma(new);
 		return PTR_ERR(pol);
 	}
 	vma_set_policy(new, pol);
@@ -1904,7 +1934,7 @@ unsigned long do_brk(unsigned long addr,
 	/*
 	 * create a vma struct for an anonymous mapping
 	 */
-	vma = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
+	vma = alloc_vma();
 	if (!vma) {
 		vm_unacct_memory(len >> PAGE_SHIFT);
 		return -ENOMEM;
@@ -2024,12 +2054,12 @@ struct vm_area_struct *copy_vma(struct v
 		    vma_start < new_vma->vm_end)
 			*vmap = new_vma;
 	} else {
-		new_vma = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
+		new_vma = alloc_vma();
 		if (new_vma) {
 			*new_vma = *vma;
 			pol = mpol_copy(vma_policy(vma));
 			if (IS_ERR(pol)) {
-				kmem_cache_free(vm_area_cachep, new_vma);
+				free_vma(new_vma);
 				return NULL;
 			}
 			vma_set_policy(new_vma, pol);

