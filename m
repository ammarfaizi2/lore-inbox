Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267199AbUITTGw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267199AbUITTGw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 15:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267251AbUITTGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 15:06:51 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:25007 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267199AbUITTCy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 15:02:54 -0400
Date: Mon, 20 Sep 2004 12:00:43 -0700 (PDT)
From: Ray Bryant <raybry@sgi.com>
To: William Lee Irwin III <wli@holomorphy.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, Ray Bryant <raybry@austin.rr.com>
Cc: linux-mm <linux-mm@kvack.org>, Jesse Barnes <jbarnes@sgi.com>,
       Dan Higgins <djh@sgi.com>, Dave Hansen <haveblue@us.ibm.com>,
       lse-tech <lse-tech@lists.sourceforge.net>,
       Brent Casavant <bcasavan@sgi.com>, Ray Bryant <raybry@austin.rr.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ray Bryant <raybry@sgi.com>, Paul Jackson <pj@sgi.com>,
       Nick Piggin <piggin@cyberone.com.au>
Message-Id: <20040920190043.26965.35899.26366@tomahawk.engr.sgi.com>
In-Reply-To: <20040920190033.26965.64678.54625@tomahawk.engr.sgi.com>
References: <20040920190033.26965.64678.54625@tomahawk.engr.sgi.com>
Subject: [PATCH 2.6.9-rc2-mm1 2/2] mm: memory policy for page cache allocation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch creates a separate mempolicy to control page cache allocation.

Index: linux-2.6.9-rc2-mmxx/include/linux/gfp.h
===================================================================
--- linux-2.6.9-rc2-mmxx.orig/include/linux/gfp.h	2004-09-16 20:17:28.000000000 -0700
+++ linux-2.6.9-rc2-mmxx/include/linux/gfp.h	2004-09-20 09:48:56.000000000 -0700
@@ -92,7 +92,22 @@
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
Index: linux-2.6.9-rc2-mmxx/include/linux/mempolicy.h
===================================================================
--- linux-2.6.9-rc2-mmxx.orig/include/linux/mempolicy.h	2004-09-20 09:21:09.000000000 -0700
+++ linux-2.6.9-rc2-mmxx/include/linux/mempolicy.h	2004-09-20 09:48:56.000000000 -0700
@@ -17,6 +17,19 @@
 
 #define MPOL_MAX MPOL_ROUNDROBIN
 
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
 /* Flags for get_mem_policy */
 #define MPOL_F_NODE	(1<<0)	/* return next IL mode instead of node mask */
 #define MPOL_F_ADDR	(1<<1)	/* look up vma using address */
@@ -32,6 +45,8 @@
 #include <linux/slab.h>
 #include <linux/rbtree.h>
 #include <asm/semaphore.h>
+#include <linux/sched.h>
+#include <asm/current.h>
 
 struct vm_area_struct;
 
@@ -69,6 +84,9 @@
 	} v;
 };
 
+extern struct page *
+alloc_pages_by_policy(unsigned gfp, unsigned order, unsigned int policy);
+
 /*
  * Support for managing mempolicy data objects (clone, copy, destroy)
  * The default fast path of a NULL MPOL_DEFAULT policy is always inlined.
Index: linux-2.6.9-rc2-mmxx/include/linux/pagemap.h
===================================================================
--- linux-2.6.9-rc2-mmxx.orig/include/linux/pagemap.h	2004-09-16 20:17:28.000000000 -0700
+++ linux-2.6.9-rc2-mmxx/include/linux/pagemap.h	2004-09-20 09:48:56.000000000 -0700
@@ -50,6 +50,7 @@
 #define page_cache_release(page)	put_page(page)
 void release_pages(struct page **pages, int nr, int cold);
 
+#ifndef CONFIG_NUMA
 static inline struct page *page_cache_alloc(struct address_space *x)
 {
 	return alloc_pages(mapping_gfp_mask(x), 0);
@@ -59,6 +60,30 @@
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
 
Index: linux-2.6.9-rc2-mmxx/include/linux/sched.h
===================================================================
--- linux-2.6.9-rc2-mmxx.orig/include/linux/sched.h	2004-09-20 09:21:09.000000000 -0700
+++ linux-2.6.9-rc2-mmxx/include/linux/sched.h	2004-09-20 09:48:56.000000000 -0700
@@ -31,6 +31,8 @@
 #include <linux/pid.h>
 #include <linux/percpu.h>
 
+#include <linux/mempolicy.h>
+
 struct exec_domain;
 
 /*
@@ -588,7 +590,6 @@
 
 
 struct audit_context;		/* See audit.c */
-struct mempolicy;
 
 struct task_struct {
 	volatile long state;	/* -1 unrunnable, 0 runnable, >0 stopped */
@@ -743,7 +744,7 @@
  */
 	wait_queue_t *io_wait;
 #ifdef CONFIG_NUMA
-  	struct mempolicy *mempolicy;
+  	struct mempolicy *mempolicy[NR_MEM_POLICIES];
   	short il_next;		/* could be shared with used_math */
 	short rr_next;
 #endif
Index: linux-2.6.9-rc2-mmxx/kernel/exit.c
===================================================================
--- linux-2.6.9-rc2-mmxx.orig/kernel/exit.c	2004-09-16 20:17:29.000000000 -0700
+++ linux-2.6.9-rc2-mmxx/kernel/exit.c	2004-09-20 09:48:56.000000000 -0700
@@ -785,6 +785,7 @@
 asmlinkage NORET_TYPE void do_exit(long code)
 {
 	struct task_struct *tsk = current;
+	int i;
 
 	profile_task_exit(tsk);
 
@@ -830,8 +831,10 @@
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
Index: linux-2.6.9-rc2-mmxx/kernel/fork.c
===================================================================
--- linux-2.6.9-rc2-mmxx.orig/kernel/fork.c	2004-09-16 20:17:29.000000000 -0700
+++ linux-2.6.9-rc2-mmxx/kernel/fork.c	2004-09-20 09:48:56.000000000 -0700
@@ -776,7 +776,7 @@
 				 int __user *child_tidptr,
 				 int pid)
 {
-	int retval;
+	int retval, i;
 	struct task_struct *p = NULL;
 
 	if ((clone_flags & (CLONE_NEWNS|CLONE_FS)) == (CLONE_NEWNS|CLONE_FS))
@@ -865,12 +865,14 @@
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
@@ -1038,7 +1040,8 @@
 	security_task_free(p);
 bad_fork_cleanup_policy:
 #ifdef CONFIG_NUMA
-	mpol_free(p->mempolicy);
+	for(i=0;i<NR_MEM_POLICIES;i++)
+		mpol_free(p->mempolicy[i]);
 #endif
 bad_fork_cleanup:
 	if (p->binfmt)
Index: linux-2.6.9-rc2-mmxx/mm/mempolicy.c
===================================================================
--- linux-2.6.9-rc2-mmxx.orig/mm/mempolicy.c	2004-09-20 09:21:09.000000000 -0700
+++ linux-2.6.9-rc2-mmxx/mm/mempolicy.c	2004-09-20 10:21:38.000000000 -0700
@@ -94,11 +94,27 @@
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
@@ -399,13 +415,13 @@
 
 /* Set the process memory policy */
 asmlinkage long sys_set_mempolicy(int mode, unsigned long __user *nmask,
-				   unsigned long maxnode)
+				   unsigned long maxnode, unsigned int policy)
 {
 	int err;
 	struct mempolicy *new;
 	DECLARE_BITMAP(nodes, MAX_NUMNODES);
 
-	if (mode > MPOL_MAX)
+	if ((mode > MPOL_MAX) || (policy >= NR_MEM_POLICIES))
 		return -EINVAL;
 	err = get_nodes(nodes, nmask, maxnode, mode);
 	if (err)
@@ -413,8 +429,8 @@
 	new = mpol_new(mode, nodes);
 	if (IS_ERR(new))
 		return PTR_ERR(new);
-	mpol_free(current->mempolicy);
-	current->mempolicy = new;
+	mpol_free(current->mempolicy[policy]);
+	current->mempolicy[policy] = new;
 	if (new && new->policy == MPOL_INTERLEAVE)
 		current->il_next = find_first_bit(new->v.nodes, MAX_NUMNODES);
 	if (new && new->policy == MPOL_ROUNDROBIN)
@@ -484,12 +500,13 @@
 asmlinkage long sys_get_mempolicy(int __user *policy,
 				  unsigned long __user *nmask,
 				  unsigned long maxnode,
-				  unsigned long addr, unsigned long flags)
+				  unsigned long addr, unsigned long flags,
+				  int policy_type)
 {
 	int err, pval;
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma = NULL;
-	struct mempolicy *pol = current->mempolicy;
+	struct mempolicy *pol = current->mempolicy[policy_type];
 
 	if (flags & ~(unsigned long)(MPOL_F_NODE|MPOL_F_ADDR))
 		return -EINVAL;
@@ -510,7 +527,7 @@
 		return -EINVAL;
 
 	if (!pol)
-		pol = &default_policy;
+		pol = default_policy[policy_type];
 
 	if (flags & MPOL_F_NODE) {
 		if (flags & MPOL_F_ADDR) {
@@ -518,10 +535,10 @@
 			if (err < 0)
 				goto out;
 			pval = err;
-		} else if (pol == current->mempolicy &&
+		} else if (pol == current->mempolicy[policy_type] &&
 				pol->policy == MPOL_INTERLEAVE) {
 			pval = current->il_next;
-		} else if (pol == current->mempolicy &&
+		} else if (pol == current->mempolicy[policy_type] &&
 				pol->policy == MPOL_ROUNDROBIN) {
 			pval = current->rr_next;
 		} else {
@@ -553,7 +570,8 @@
 asmlinkage long compat_get_mempolicy(int __user *policy,
 				     compat_ulong_t __user *nmask,
 				     compat_ulong_t maxnode,
-				     compat_ulong_t addr, compat_ulong_t flags)
+				     compat_ulong_t addr, compat_ulong_t flags,
+				     compat_uint_t policy_index)
 {
 	long err;
 	unsigned long __user *nm = NULL;
@@ -566,7 +584,8 @@
 	if (nmask)
 		nm = compat_alloc_user_space(alloc_size);
 
-	err = sys_get_mempolicy(policy, nm, nr_bits+1, addr, flags);
+	err = sys_get_mempolicy(policy, nm, nr_bits+1, addr, flags, 
+		policy_index);
 
 	if (!err && nmask) {
 		err = copy_from_user(bm, nm, alloc_size);
@@ -579,7 +598,8 @@
 }
 
 asmlinkage long compat_set_mempolicy(int mode, compat_ulong_t __user *nmask,
-				     compat_ulong_t maxnode)
+				     compat_ulong_t maxnode,
+				     compat_uint_t policy_index)
 {
 	long err = 0;
 	unsigned long __user *nm = NULL;
@@ -598,7 +618,7 @@
 	if (err)
 		return -EFAULT;
 
-	return sys_set_mempolicy(mode, nm, nr_bits+1);
+	return sys_set_mempolicy(mode, nm, nr_bits+1, policy_index);
 }
 
 asmlinkage long compat_mbind(compat_ulong_t start, compat_ulong_t len,
@@ -631,7 +651,7 @@
 static struct mempolicy *
 get_vma_policy(struct vm_area_struct *vma, unsigned long addr)
 {
-	struct mempolicy *pol = current->mempolicy;
+	struct mempolicy *pol = current->mempolicy[POLICY_PAGE];
 
 	if (vma) {
 		if (vma->vm_ops && vma->vm_ops->get_policy)
@@ -641,7 +661,7 @@
 			pol = vma->vm_policy;
 	}
 	if (!pol)
-		pol = &default_policy;
+		pol = default_policy[POLICY_PAGE];
 	return pol;
 }
 
@@ -814,7 +834,7 @@
 }
 
 /**
- * 	alloc_pages_current - Allocate pages.
+ * 	alloc_pages_by_policy - Allocate pages using a given mempolicy
  *
  *	@gfp:
  *		%GFP_USER   user allocation,
@@ -823,19 +843,26 @@
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
+	struct mempolicy *pol;
 
+	if (policy >= NR_MEM_POLICIES)
+		BUG();
+	pol = current->mempolicy[policy];
+	if (!pol)
+		pol = default_policy[policy];
 	if (!in_interrupt())
 		cpuset_update_current_mems_allowed();
 	if (!pol || in_interrupt())
-		pol = &default_policy;
+		pol = default_policy[POLICY_PAGE];
 	if (pol->policy == MPOL_INTERLEAVE) {
 		return alloc_page_interleave(gfp, order, interleave_nodes(pol));
 	} else if (pol->policy == MPOL_ROUNDROBIN) {
@@ -843,7 +870,7 @@
 	}
 	return __alloc_pages(gfp, order, zonelist_policy(gfp, pol));
 }
-EXPORT_SYMBOL(alloc_pages_current);
+EXPORT_SYMBOL(alloc_pages_by_policy);
 
 /* Slow path of a mempolicy copy */
 struct mempolicy *__mpol_copy(struct mempolicy *old)
@@ -1157,7 +1184,7 @@
 	   the data structures allocated at system boot end up in node zero. */
 
 	if (sys_set_mempolicy(MPOL_INTERLEAVE, nodes_addr(node_online_map),
-							MAX_NUMNODES) < 0)
+			      MAX_NUMNODES, POLICY_PAGE) < 0)
 		printk("numa_policy_init: interleaving failed\n");
 }
 
@@ -1165,5 +1192,5 @@
  * Assumes fs == KERNEL_DS */
 void numa_default_policy(void)
 {
-	sys_set_mempolicy(MPOL_DEFAULT, NULL, 0);
+	sys_set_mempolicy(MPOL_DEFAULT, NULL, 0, POLICY_PAGE);
 }

-- 
Best Regards,
Ray
-----------------------------------------------
Ray Bryant                       raybry@sgi.com
The box said: "Requires Windows 98 or better",
           so I installed Linux.
-----------------------------------------------
