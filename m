Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268259AbUIWEdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268259AbUIWEdi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 00:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268260AbUIWEdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 00:33:38 -0400
Received: from ms-smtp-03.texas.rr.com ([24.93.47.42]:41980 "EHLO
	ms-smtp-03-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S268259AbUIWEck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 00:32:40 -0400
Date: Wed, 22 Sep 2004 23:32:35 -0500 (CDT)
From: Ray Bryant <raybry@austin.rr.com>
To: Andi Kleen <ak@suse.de>
Cc: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@osdl.org>,
       linux-mm <linux-mm@kvack.org>, Jesse Barnes <jbarnes@sgi.com>,
       Dan Higgins <djh@sgi.com>, Dave Hansen <haveblue@us.ibm.com>,
       lse-tech <lse-tech@lists.sourceforge.net>,
       Brent Casavant <bcasavan@sgi.com>, Ray Bryant <raybry@austin.rr.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ray Bryant <raybry@sgi.com>, Paul Jackson <pj@sgi.com>,
       Nick Piggin <piggin@cyberone.com.au>
Message-Id: <20040923043246.2132.91877.24290@raybryhome.rayhome.net>
In-Reply-To: <20040923043236.2132.2385.23158@raybryhome.rayhome.net>
References: <20040923043236.2132.2385.23158@raybryhome.rayhome.net>
Subject: [PATCH 1/2] mm: page cache mempolicy for page cache allocation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is version 2 of the page cache memory policy patch.

Changes from the previous version:

(1)  This patch no longer requires MPOL_ROUNDROBIN so that patch
     has been deleted from this series.

(2)  This patch provides a mechanism for setting and getting
     not only the process's policies for allocating pages and
     page cache (if any), but also for getting and setting the
     system-wide default policies for these allocations.  (Admin
     capabaility is required to set the default policies.)
     Specification of which policy to set and whether it is 
     the page allocation policy or the page cache allocation
     policy is done in the upper bits of the first argument to
     sys_set_mempolicy() and in the flags argument of
     sys_get_mempolicy().  These values are defined so that
     existing users will not see a change.

     See sys_set_mempolicy(), sys_get_mempolicy() and
     include/linux/mempolicy.h for further details.

     It is expected that the default policies will be set during
     boot processing of startup scripts and will not be changed
     thereafter (without quiescing the system and/or flushing the
     page cache).

(3)  This patch uses the existing infrastructure from the 
     the previous version of alloc_pages_current() to do the
     round robin allocation of page cache pages across nodes
     if the page cache allocation policy is MPOL_INTERLEAVE.
     That is, this patch uses current->il_next and
     interleave_node() to decide what node to allocate the
     current page on. 

     This means that regular pages and page cache pages are
     allocated using the same "rotator" if both policies are
     MPOL_INTERLEAVE and avoids having to pass an offset,
     a dev_t, and an inode into page_cache_alloc().

Signed-off-by: Ray Bryant <raybry@sgi.com>

Index: linux-2.6.9-rc2-mm1/include/linux/gfp.h
===================================================================
--- linux-2.6.9-rc2-mm1.orig/include/linux/gfp.h	2004-09-16 12:54:27.000000000 -0700
+++ linux-2.6.9-rc2-mm1/include/linux/gfp.h	2004-09-22 08:48:44.000000000 -0700
@@ -92,7 +92,22 @@ static inline struct page *alloc_pages_n
 }
 
 #ifdef CONFIG_NUMA
-extern struct page *alloc_pages_current(unsigned gfp_mask, unsigned order);
+extern struct page *alloc_pages_by_policy(unsigned gfp, unsigned order, 
+	unsigned policy);
+
+static inline
+struct page *alloc_pages_current(unsigned gfp, unsigned order)
+{
+	/* 
+	 * include order keeps us from including mempolicy.h here
+	 * the following should be:
+	 *    return alloc_pages_by_policy(gfp, order, POLICY_PAGE);
+	 * but POLICY_PAGE is not defined yet.
+	 * We assume here that POLICY_PAGE is defined to be 0
+	 * See include/linux/mempolicy.h.
+	 */
+	return alloc_pages_by_policy(gfp, order, 0);
+}
 
 static inline struct page *
 alloc_pages(unsigned int gfp_mask, unsigned int order)
Index: linux-2.6.9-rc2-mm1/include/linux/mempolicy.h
===================================================================
--- linux-2.6.9-rc2-mm1.orig/include/linux/mempolicy.h	2004-09-16 10:41:23.000000000 -0700
+++ linux-2.6.9-rc2-mm1/include/linux/mempolicy.h	2004-09-22 08:48:44.000000000 -0700
@@ -16,6 +16,29 @@
 
 #define MPOL_MAX MPOL_INTERLEAVE
 
+/* 
+ * Policy indicies
+ * These specify the index into either the task->mempolicy array or the
+ * default_policy array to indicate which policy is to be used for a
+ * particular allocation.
+ */
+#define NR_MEM_POLICIES 	2
+/* policy to use for page allocation and the default kernel policy */
+/* this value is hard coded into alloc_pages() in gfp.h do not change it */
+#define POLICY_PAGE		0
+/* policy to use for pagecache allocation */
+#define POLICY_PAGECACHE 	1
+
+/* policy selection bits are passed from user shifted left by this amount */
+#define REQUEST_POLICY_SHIFT	16
+#define REQUEST_POLICY_PAGE     POLICY_PAGE << REQUEST_POLICY_SHIFT
+#define REQUEST_POLICY_PAGECACHE POLICY_PAGECACHE << REQUEST_POLICY_SHIFT
+#define REQUEST_POLICY_MASK     (0x3FFF) << REQUEST_POLICY_SHIFT
+#define REQUEST_MODE_MASK       (0xFFFF)
+/* by default, user requests are for the process policy -- this flag 
+ * informs sys_set_policy() that this request is for the default policy */
+#define REQUEST_POLICY_DEFAULT  (0x8000) << REQUEST_POLICY_SHIFT
+
 /* Flags for get_mem_policy */
 #define MPOL_F_NODE	(1<<0)	/* return next IL mode instead of node mask */
 #define MPOL_F_ADDR	(1<<1)	/* look up vma using address */
@@ -31,6 +54,8 @@
 #include <linux/slab.h>
 #include <linux/rbtree.h>
 #include <asm/semaphore.h>
+#include <linux/sched.h>
+#include <asm/current.h>
 
 struct vm_area_struct;
 
@@ -68,6 +93,9 @@ struct mempolicy {
 	} v;
 };
 
+extern struct page *
+alloc_pages_by_policy(unsigned gfp, unsigned order, unsigned int policy);
+
 /*
  * Support for managing mempolicy data objects (clone, copy, destroy)
  * The default fast path of a NULL MPOL_DEFAULT policy is always inlined.
Index: linux-2.6.9-rc2-mm1/include/linux/pagemap.h
===================================================================
--- linux-2.6.9-rc2-mm1.orig/include/linux/pagemap.h	2004-09-16 12:54:19.000000000 -0700
+++ linux-2.6.9-rc2-mm1/include/linux/pagemap.h	2004-09-22 08:48:45.000000000 -0700
@@ -50,6 +50,7 @@ static inline void mapping_set_gfp_mask(
 #define page_cache_release(page)	put_page(page)
 void release_pages(struct page **pages, int nr, int cold);
 
+#ifndef CONFIG_NUMA
 static inline struct page *page_cache_alloc(struct address_space *x)
 {
 	return alloc_pages(mapping_gfp_mask(x), 0);
@@ -59,6 +60,30 @@ static inline struct page *page_cache_al
 {
 	return alloc_pages(mapping_gfp_mask(x)|__GFP_COLD, 0);
 }
+#define page_cache_alloc_local((x)) page_cache_alloc((x))
+#else /* CONFIG_NUMA */
+
+struct mempolicy;
+extern struct mempolicy *default_policy[];
+extern struct page *
+alloc_pages_by_policy(unsigned gfp, unsigned order, unsigned policy);
+
+static inline struct page *page_cache_alloc_local(struct address_space *x)
+{
+	return alloc_pages(mapping_gfp_mask(x), 0);
+}
+
+static inline struct page *page_cache_alloc(struct address_space *x)
+{
+	return alloc_pages_by_policy(mapping_gfp_mask(x), 0, POLICY_PAGECACHE);
+}
+
+static inline struct page *page_cache_alloc_cold(struct address_space *x)
+{
+	return alloc_pages_by_policy(mapping_gfp_mask(x)|__GFP_COLD, 0, 
+		POLICY_PAGECACHE);
+}
+#endif
 
 typedef int filler_t(void *, struct page *);
 
Index: linux-2.6.9-rc2-mm1/include/linux/sched.h
===================================================================
--- linux-2.6.9-rc2-mm1.orig/include/linux/sched.h	2004-09-16 12:54:41.000000000 -0700
+++ linux-2.6.9-rc2-mm1/include/linux/sched.h	2004-09-22 08:48:45.000000000 -0700
@@ -31,6 +31,8 @@
 #include <linux/pid.h>
 #include <linux/percpu.h>
 
+#include <linux/mempolicy.h>
+
 struct exec_domain;
 
 /*
@@ -588,7 +590,6 @@ int set_current_groups(struct group_info
 
 
 struct audit_context;		/* See audit.c */
-struct mempolicy;
 
 struct task_struct {
 	volatile long state;	/* -1 unrunnable, 0 runnable, >0 stopped */
@@ -743,7 +744,7 @@ struct task_struct {
  */
 	wait_queue_t *io_wait;
 #ifdef CONFIG_NUMA
-  	struct mempolicy *mempolicy;
+  	struct mempolicy *mempolicy[NR_MEM_POLICIES];
   	short il_next;		/* could be shared with used_math */
 #endif
 #ifdef CONFIG_CPUSETS
Index: linux-2.6.9-rc2-mm1/kernel/exit.c
===================================================================
--- linux-2.6.9-rc2-mm1.orig/kernel/exit.c	2004-09-16 12:54:32.000000000 -0700
+++ linux-2.6.9-rc2-mm1/kernel/exit.c	2004-09-22 08:48:45.000000000 -0700
@@ -785,6 +785,7 @@ static void exit_notify(struct task_stru
 asmlinkage NORET_TYPE void do_exit(long code)
 {
 	struct task_struct *tsk = current;
+	int i;
 
 	profile_task_exit(tsk);
 
@@ -830,8 +831,10 @@ asmlinkage NORET_TYPE void do_exit(long 
 	tsk->exit_code = code;
 	exit_notify(tsk);
 #ifdef CONFIG_NUMA
-	mpol_free(tsk->mempolicy);
-	tsk->mempolicy = NULL;
+	for(i=0;i<NR_MEM_POLICIES;i++) {
+		mpol_free(tsk->mempolicy[i]);
+		tsk->mempolicy[i] = NULL;
+	}
 #endif
 	schedule();
 	BUG();
Index: linux-2.6.9-rc2-mm1/kernel/fork.c
===================================================================
--- linux-2.6.9-rc2-mm1.orig/kernel/fork.c	2004-09-22 08:08:18.000000000 -0700
+++ linux-2.6.9-rc2-mm1/kernel/fork.c	2004-09-22 08:48:45.000000000 -0700
@@ -776,7 +776,7 @@ static task_t *copy_process(unsigned lon
 				 int __user *child_tidptr,
 				 int pid)
 {
-	int retval;
+	int retval, i;
 	struct task_struct *p = NULL;
 
 	if ((clone_flags & (CLONE_NEWNS|CLONE_FS)) == (CLONE_NEWNS|CLONE_FS))
@@ -865,12 +865,14 @@ static task_t *copy_process(unsigned lon
 	p->io_wait = NULL;
 	p->audit_context = NULL;
 #ifdef CONFIG_NUMA
- 	p->mempolicy = mpol_copy(p->mempolicy);
- 	if (IS_ERR(p->mempolicy)) {
- 		retval = PTR_ERR(p->mempolicy);
- 		p->mempolicy = NULL;
- 		goto bad_fork_cleanup;
- 	}
+	for(i=0;i<NR_MEM_POLICIES;i++) {
+		p->mempolicy[i] = mpol_copy(p->mempolicy[i]);
+		if (IS_ERR(p->mempolicy[i])) {
+			retval = PTR_ERR(p->mempolicy[i]);
+			p->mempolicy[i] = NULL;
+			goto bad_fork_cleanup;
+		}
+	}
 #endif
 
 	p->tgid = p->pid;
@@ -1038,7 +1040,8 @@ bad_fork_cleanup_security:
 	security_task_free(p);
 bad_fork_cleanup_policy:
 #ifdef CONFIG_NUMA
-	mpol_free(p->mempolicy);
+	for(i=0;i<NR_MEM_POLICIES;i++)
+		mpol_free(p->mempolicy[i]);
 #endif
 bad_fork_cleanup:
 	if (p->binfmt)
Index: linux-2.6.9-rc2-mm1/mm/mempolicy.c
===================================================================
--- linux-2.6.9-rc2-mm1.orig/mm/mempolicy.c	2004-09-16 12:54:20.000000000 -0700
+++ linux-2.6.9-rc2-mm1/mm/mempolicy.c	2004-09-22 11:46:20.000000000 -0700
@@ -87,11 +87,27 @@ static kmem_cache_t *sn_cache;
    policied. */
 static int policy_zone;
 
-static struct mempolicy default_policy = {
+/*
+ * the default policies for page allocation, page cache allocation
+ */
+static struct mempolicy default_kernel_mempolicy = {
 	.refcnt = ATOMIC_INIT(1), /* never free it */
 	.policy = MPOL_DEFAULT,
 };
 
+struct mempolicy default_pagecache_mempolicy = {
+	.refcnt  = ATOMIC_INIT(1), /* never free it */
+	.policy  = MPOL_DEFAULT,
+};
+
+/*
+ * references to the default policies are via indexes into this array
+ */
+struct mempolicy *default_policy[NR_MEM_POLICIES] = {
+		&default_kernel_mempolicy, 
+		&default_pagecache_mempolicy,
+};
+
 /* Check if all specified nodes are online */
 static int nodes_online(unsigned long *nodes)
 {
@@ -389,23 +405,34 @@ asmlinkage long sys_mbind(unsigned long 
 }
 
 /* Set the process memory policy */
-asmlinkage long sys_set_mempolicy(int mode, unsigned long __user *nmask,
+asmlinkage long sys_set_mempolicy(int request, unsigned long __user *nmask,
 				   unsigned long maxnode)
 {
-	int err;
+	int err, mode, policy, request_policy_default;
 	struct mempolicy *new;
 	DECLARE_BITMAP(nodes, MAX_NUMNODES);
 
-	if (mode > MPOL_MAX)
+	mode = request & REQUEST_MODE_MASK;
+	policy = (request & REQUEST_POLICY_MASK) >> REQUEST_POLICY_SHIFT;
+	request_policy_default= request & REQUEST_POLICY_DEFAULT;
+
+	if ((mode > MPOL_MAX) || (policy >= NR_MEM_POLICIES))
 		return -EINVAL;
+	if (request_policy_default && !capable(CAP_SYS_ADMIN))
+		return -EPERM;
 	err = get_nodes(nodes, nmask, maxnode, mode);
 	if (err)
 		return err;
 	new = mpol_new(mode, nodes);
 	if (IS_ERR(new))
 		return PTR_ERR(new);
-	mpol_free(current->mempolicy);
-	current->mempolicy = new;
+	if (request_policy_default) {
+		mpol_free(default_policy[policy]);
+		default_policy[policy] = new;
+	} else {
+		mpol_free(current->mempolicy[policy]);
+		current->mempolicy[policy] = new;
+	}
 	if (new && new->policy == MPOL_INTERLEAVE)
 		current->il_next = find_first_bit(new->v.nodes, MAX_NUMNODES);
 	return 0;
@@ -477,12 +504,29 @@ asmlinkage long sys_get_mempolicy(int __
 	int err, pval;
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma = NULL;
-	struct mempolicy *pol = current->mempolicy;
+	struct mempolicy *pol = NULL;
+	int policy_type, request_policy_default;
 
 	if (flags & ~(unsigned long)(MPOL_F_NODE|MPOL_F_ADDR))
 		return -EINVAL;
 	if (nmask != NULL && maxnode < numnodes)
 		return -EINVAL;
+
+	policy_type = (flags & REQUEST_POLICY_MASK) > REQUEST_POLICY_SHIFT;
+	request_policy_default = (flags & REQUEST_POLICY_DEFAULT);
+	if (policy_type >= NR_MEM_POLICIES)
+		return -EINVAL;
+	if (request_policy_default) {
+		pol = default_policy[policy_type];
+		goto copy_policy_to_user;
+	}
+	if (policy_type>0) {
+		pol = current->mempolicy[policy_type];
+		if (!pol)
+			pol = default_policy[policy_type];
+		goto copy_policy_to_user;
+	}
+
 	if (flags & MPOL_F_ADDR) {
 		down_read(&mm->mmap_sem);
 		vma = find_vma_intersection(mm, addr, addr+1);
@@ -498,7 +542,7 @@ asmlinkage long sys_get_mempolicy(int __
 		return -EINVAL;
 
 	if (!pol)
-		pol = &default_policy;
+		pol = default_policy[policy_type];
 
 	if (flags & MPOL_F_NODE) {
 		if (flags & MPOL_F_ADDR) {
@@ -506,7 +550,7 @@ asmlinkage long sys_get_mempolicy(int __
 			if (err < 0)
 				goto out;
 			pval = err;
-		} else if (pol == current->mempolicy &&
+		} else if (pol == current->mempolicy[policy_type] &&
 				pol->policy == MPOL_INTERLEAVE) {
 			pval = current->il_next;
 		} else {
@@ -520,6 +564,7 @@ asmlinkage long sys_get_mempolicy(int __
 	if (policy && put_user(pval, policy))
 		goto out;
 
+copy_policy_to_user:
 	err = 0;
 	if (nmask) {
 		DECLARE_BITMAP(nodes, MAX_NUMNODES);
@@ -538,7 +583,8 @@ asmlinkage long sys_get_mempolicy(int __
 asmlinkage long compat_get_mempolicy(int __user *policy,
 				     compat_ulong_t __user *nmask,
 				     compat_ulong_t maxnode,
-				     compat_ulong_t addr, compat_ulong_t flags)
+				     compat_ulong_t addr, compat_ulong_t flags,
+				     compat_uint_t policy_index)
 {
 	long err;
 	unsigned long __user *nm = NULL;
@@ -616,7 +662,7 @@ asmlinkage long compat_mbind(compat_ulon
 static struct mempolicy *
 get_vma_policy(struct vm_area_struct *vma, unsigned long addr)
 {
-	struct mempolicy *pol = current->mempolicy;
+	struct mempolicy *pol = current->mempolicy[POLICY_PAGE];
 
 	if (vma) {
 		if (vma->vm_ops && vma->vm_ops->get_policy)
@@ -626,7 +672,7 @@ get_vma_policy(struct vm_area_struct *vm
 			pol = vma->vm_policy;
 	}
 	if (!pol)
-		pol = &default_policy;
+		pol = default_policy[POLICY_PAGE];
 	return pol;
 }
 
@@ -758,7 +804,7 @@ alloc_page_vma(unsigned gfp, struct vm_a
 }
 
 /**
- * 	alloc_pages_current - Allocate pages.
+ * 	alloc_pages_by_policy - Allocate pages using a given mempolicy
  *
  *	@gfp:
  *		%GFP_USER   user allocation,
@@ -767,24 +813,31 @@ alloc_page_vma(unsigned gfp, struct vm_a
  *      	%GFP_FS     don't call back into a file system.
  *      	%GFP_ATOMIC don't sleep.
  *	@order: Power of two of allocation size in pages. 0 is a single page.
+ *	@policy:Index of the mempolicy struct to use for this allocation
  *
  *	Allocate a page from the kernel page pool.  When not in
  *	interrupt context and apply the current process NUMA policy.
  *	Returns NULL when no page can be allocated.
  */
-struct page *alloc_pages_current(unsigned gfp, unsigned order)
+struct page *
+alloc_pages_by_policy(unsigned gfp, unsigned order, unsigned policy)
 {
-	struct mempolicy *pol = current->mempolicy;
-
+ 	struct mempolicy *pol;
+  
+ 	if (policy >= NR_MEM_POLICIES)
+ 		BUG();
+ 	pol = current->mempolicy[policy];
+ 	if (!pol)
+ 		pol = default_policy[policy];
 	if (!in_interrupt())
 		cpuset_update_current_mems_allowed();
 	if (!pol || in_interrupt())
-		pol = &default_policy;
+		pol = default_policy[policy];
 	if (pol->policy == MPOL_INTERLEAVE)
 		return alloc_page_interleave(gfp, order, interleave_nodes(pol));
 	return __alloc_pages(gfp, order, zonelist_policy(gfp, pol));
 }
-EXPORT_SYMBOL(alloc_pages_current);
+EXPORT_SYMBOL(alloc_pages_by_policy);
 
 /* Slow path of a mempolicy copy */
 struct mempolicy *__mpol_copy(struct mempolicy *old)
@@ -1093,8 +1146,8 @@ void __init numa_policy_init(void)
 	/* Set interleaving policy for system init. This way not all
 	   the data structures allocated at system boot end up in node zero. */
 
-	if (sys_set_mempolicy(MPOL_INTERLEAVE, nodes_addr(node_online_map),
-							MAX_NUMNODES) < 0)
+	if (sys_set_mempolicy(REQUEST_POLICY_PAGE | MPOL_INTERLEAVE, 
+		nodes_addr(node_online_map), MAX_NUMNODES) < 0)
 		printk("numa_policy_init: interleaving failed\n");
 }
 
@@ -1102,5 +1155,5 @@ void __init numa_policy_init(void)
  * Assumes fs == KERNEL_DS */
 void numa_default_policy(void)
 {
-	sys_set_mempolicy(MPOL_DEFAULT, NULL, 0);
+	sys_set_mempolicy(REQUEST_POLICY_PAGE | MPOL_DEFAULT, NULL, 0);
 }
