Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751063AbWBWJbd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751063AbWBWJbd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 04:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751078AbWBWJbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 04:31:13 -0500
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:5602 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1751063AbWBWJbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 04:31:09 -0500
Subject: [Patch 3/3] prepopulate/cache cleared pages
From: Arjan van de Ven <arjan@intel.linux.com>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, akpm@osdl.org
In-Reply-To: <1140686238.2972.30.camel@laptopd505.fenrus.org>
References: <1140686238.2972.30.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 23 Feb 2006 10:29:54 +0100
Message-Id: <1140686994.4672.4.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds an entry for a cleared page to the task struct. The main
purpose of this patch is to be able to pre-allocate and clear a page in a
pagefault scenario before taking any locks (esp mmap_sem),
opportunistically. Allocating+clearing a page is an very expensive 
operation that currently increases lock hold times quite bit (in a threaded 
environment that allocates/use/frees memory on a regular basis, this leads
to contention).

This is probably the most controversial patch of the 3, since there is
a potential to take up 1 page per thread in this cache. In practice it's
not as bad as it sounds (a large degree of the pagefaults are anonymous 
and thus immediately use up the page). One could argue "let the VM reap
these" but that has a few downsides; it increases locking needs but more,
clearing a page is relatively expensive, if the VM reaps the page again
in case it wasn't needed, the work was just wasted.


Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

---
 arch/x86_64/mm/fault.c |    2 ++
 include/linux/mm.h     |    1 +
 include/linux/sched.h  |    1 +
 kernel/exit.c          |    4 ++++
 kernel/fork.c          |    1 +
 mm/mempolicy.c         |   37 +++++++++++++++++++++++++++++++++++++
 6 files changed, 46 insertions(+)

Index: linux-work/arch/x86_64/mm/fault.c
===================================================================
--- linux-work.orig/arch/x86_64/mm/fault.c
+++ linux-work/arch/x86_64/mm/fault.c
@@ -375,6 +375,8 @@ asmlinkage void __kprobes do_page_fault(
 		goto bad_area_nosemaphore;
 
  again:
+	prepare_cleared_page();
+
 	/* When running in the kernel we expect faults to occur only to
 	 * addresses in user space.  All other faults represent errors in the
 	 * kernel and should generate an OOPS.  Unfortunatly, in the case of an
Index: linux-work/include/linux/mm.h
===================================================================
--- linux-work.orig/include/linux/mm.h
+++ linux-work/include/linux/mm.h
@@ -1052,6 +1052,7 @@ void drop_pagecache(void);
 void drop_slab(void);
 
 extern void prepopulate_vma(void);
+extern void prepopulate_cleared_page(void);
 
 extern int randomize_va_space;
 
Index: linux-work/include/linux/sched.h
===================================================================
--- linux-work.orig/include/linux/sched.h
+++ linux-work/include/linux/sched.h
@@ -839,6 +839,7 @@ struct task_struct {
 	struct reclaim_state *reclaim_state;
 
 	struct vm_area_struct *free_vma_cache;  /* keep 1 free vma around as cache */
+	struct page *cleared_page;		/* optionally keep 1 cleared page around */
 
 	struct dentry *proc_dentry;
 	struct backing_dev_info *backing_dev_info;
Index: linux-work/kernel/exit.c
===================================================================
--- linux-work.orig/kernel/exit.c
+++ linux-work/kernel/exit.c
@@ -882,6 +882,10 @@ fastcall NORET_TYPE void do_exit(long co
 		kmem_cache_free(vm_area_cachep, tsk->free_vma_cache);
 	tsk->free_vma_cache = NULL;
 
+	if (tsk->cleared_page)
+		__free_page(tsk->cleared_page);
+	tsk->cleared_page = NULL;
+
 	/* PF_DEAD causes final put_task_struct after we schedule. */
 	preempt_disable();
 	BUG_ON(tsk->flags & PF_DEAD);
Index: linux-work/kernel/fork.c
===================================================================
--- linux-work.orig/kernel/fork.c
+++ linux-work/kernel/fork.c
@@ -180,6 +180,7 @@ static struct task_struct *dup_task_stru
 	atomic_set(&tsk->usage,2);
 	atomic_set(&tsk->fs_excl, 0);
 	tsk->free_vma_cache = NULL;
+	tsk->cleared_page = NULL;
 
 	return tsk;
 }
Index: linux-work/mm/mempolicy.c
===================================================================
--- linux-work.orig/mm/mempolicy.c
+++ linux-work/mm/mempolicy.c
@@ -1231,6 +1231,13 @@ alloc_page_vma(gfp_t gfp, struct vm_area
 {
 	struct mempolicy *pol = get_vma_policy(current, vma, addr);
 
+	if ( (gfp & __GFP_ZERO) && current->cleared_page) {
+		struct page *addr;
+		addr = current->cleared_page;
+		current->cleared_page = NULL;
+		return addr;
+	}
+
 	cpuset_update_task_memory_state();
 
 	if (unlikely(pol->policy == MPOL_INTERLEAVE)) {
@@ -1242,6 +1249,36 @@ alloc_page_vma(gfp_t gfp, struct vm_area
 	return __alloc_pages(gfp, 0, zonelist_policy(gfp, pol));
 }
 
+
+/**
+ *	prepare_cleared_page - populate the per-task zeroed-page cache
+ *
+ *	This function populates the per-task cache with one zeroed page
+ *	(if there wasn't one already)
+ *	The idea is that this (expensive) clearing is done before any
+ *	locks are taken, speculatively, and that when the page is actually
+ *	needed under a lock, it is ready for immediate use
+ */
+
+void prepare_cleared_page(void)
+{
+	struct mempolicy *pol = current->mempolicy;
+
+	if (current->cleared_page)
+		return;
+
+	cpuset_update_task_memory_state();
+
+	if (!pol)
+		pol = &default_policy;
+	if (pol->policy == MPOL_INTERLEAVE)
+		current->cleared_page = alloc_page_interleave(
+			GFP_HIGHUSER | __GFP_ZERO, 0, interleave_nodes(pol));
+	current->cleared_page = __alloc_pages(GFP_USER | __GFP_ZERO,
+			0, zonelist_policy(GFP_USER, pol));
+}
+
+
 /**
  * 	alloc_pages_current - Allocate pages.
  *

