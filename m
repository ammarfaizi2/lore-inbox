Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750705AbWBISz6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbWBISz6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 13:55:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbWBISzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 13:55:16 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:38025 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750705AbWBISyy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 13:54:54 -0500
From: Paul Jackson <pj@sgi.com>
To: akpm@osdl.org
Cc: steiner@sgi.com, dgc@sgi.com, Simon.Derr@bull.net, ak@suse.de,
       linux-kernel@vger.kernel.org, Paul Jackson <pj@sgi.com>,
       clameter@sgi.com
Date: Thu, 09 Feb 2006 10:54:46 -0800
Message-Id: <20060209185446.8596.60652.sendpatchset@jackhammer.engr.sgi.com>
In-Reply-To: <20060209185418.8596.90838.sendpatchset@jackhammer.engr.sgi.com>
References: <20060209185418.8596.90838.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH v2 06/07] cpuset memory spread slab cache optimizations
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Jackson <pj@sgi.com>

The hooks in the slab cache allocator code path for support of
NUMA mempolicies and cpuset memory spreading are in an important
code path.  Many systems will use neither feature.

This patch optimizes those hooks down to a single check of
some bits in the current tasks task_struct flags.  For non NUMA
systems, this hook and related code is already ifdef'd out.

The optimization is done by using another task flag, set if the
task is using a non-default NUMA mempolicy.  Taking this flag
bit along with the PF_SPREAD_PAGE and PF_SPREAD_SLAB flag bits
added earlier in this 'cpuset memory spreading' patch set, one
can check for the combination of any of these special case
memory placement mechanisms with a single test of the current
tasks task_struct flags.

This patch also tightens up the code, to save a few bytes of
kernel text space, and moves some of it out of line.  Due to
the nested inlines called from multiple places, we were ending
up with three copies of this code, which once we get off the
main code path (for local node allocation) seems a bit wasteful
of instruction memory.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

 include/linux/mempolicy.h |    5 +++++
 include/linux/sched.h     |    1 +
 kernel/fork.c             |    1 +
 mm/mempolicy.c            |   32 ++++++++++++++++++++++++++++++++
 mm/slab.c                 |   41 ++++++++++++++++++++++++++++-------------
 5 files changed, 67 insertions(+), 13 deletions(-)

--- 2.6.16-rc2-mm1.orig/kernel/fork.c	2006-02-09 00:09:17.785558470 -0800
+++ 2.6.16-rc2-mm1/kernel/fork.c	2006-02-09 01:38:12.885936624 -0800
@@ -1018,6 +1018,7 @@ static task_t *copy_process(unsigned lon
  		p->mempolicy = NULL;
  		goto bad_fork_cleanup_cpuset;
  	}
+	mpol_fix_fork_child_flag(p);
 #endif
 
 #ifdef CONFIG_DEBUG_MUTEXES
--- 2.6.16-rc2-mm1.orig/mm/mempolicy.c	2006-02-09 00:09:17.785558470 -0800
+++ 2.6.16-rc2-mm1/mm/mempolicy.c	2006-02-09 00:29:45.204510838 -0800
@@ -411,6 +411,37 @@ static int contextualize_policy(int mode
 	return mpol_check_policy(mode, nodes);
 }
 
+
+/*
+ * Update task->flags PF_MEMPOLICY bit: set iff non-default
+ * mempolicy.  Allows more rapid checking of this (combined perhaps
+ * with other PF_* flag bits) on memory allocation hot code paths.
+ *
+ * If called from outside this file, the task 'p' should -only- be
+ * a newly forked child not yet visible on the task list, because
+ * manipulating the task flags of a visible task is not safe.
+ *
+ * The above limitation is why this routine has the funny name
+ * mpol_fix_fork_child_flag().
+ *
+ * It is also safe to call this with a task pointer of current,
+ * which the static wrapper mpol_set_task_struct_flag() does,
+ * for use within this file.
+ */
+
+void mpol_fix_fork_child_flag(struct task_struct *p)
+{
+	if (p->mempolicy)
+		p->flags |= PF_MEMPOLICY;
+	else
+		p->flags &= ~PF_MEMPOLICY;
+}
+
+static void mpol_set_task_struct_flag(void)
+{
+	mpol_fix_fork_child_flag(current);
+}
+
 /* Set the process memory policy */
 long do_set_mempolicy(int mode, nodemask_t *nodes)
 {
@@ -423,6 +454,7 @@ long do_set_mempolicy(int mode, nodemask
 		return PTR_ERR(new);
 	mpol_free(current->mempolicy);
 	current->mempolicy = new;
+	mpol_set_task_struct_flag();
 	if (new && new->policy == MPOL_INTERLEAVE)
 		current->il_next = first_node(new->v.nodes);
 	return 0;
--- 2.6.16-rc2-mm1.orig/include/linux/mempolicy.h	2006-02-09 00:09:17.699619995 -0800
+++ 2.6.16-rc2-mm1/include/linux/mempolicy.h	2006-02-09 00:14:01.868839884 -0800
@@ -147,6 +147,7 @@ extern void mpol_rebind_policy(struct me
 extern void mpol_rebind_task(struct task_struct *tsk,
 					const nodemask_t *new);
 extern void mpol_rebind_mm(struct mm_struct *mm, nodemask_t *new);
+extern void mpol_fix_fork_child_flag(struct task_struct *p);
 #define set_cpuset_being_rebound(x) (cpuset_being_rebound = (x))
 
 #ifdef CONFIG_CPUSET
@@ -248,6 +249,10 @@ static inline void mpol_rebind_mm(struct
 {
 }
 
+static inline void mpol_fix_fork_child_flag(struct task_struct *p)
+{
+}
+
 #define set_cpuset_being_rebound(x) do {} while (0)
 
 static inline struct zonelist *huge_zonelist(struct vm_area_struct *vma,
--- 2.6.16-rc2-mm1.orig/mm/slab.c	2006-02-09 00:14:01.833683242 -0800
+++ 2.6.16-rc2-mm1/mm/slab.c	2006-02-09 01:45:12.558625414 -0800
@@ -859,6 +859,7 @@ static struct array_cache *alloc_arrayca
 
 #ifdef CONFIG_NUMA
 static void *__cache_alloc_node(struct kmem_cache *, gfp_t, int);
+static void *alternate_node_alloc(struct kmem_cache *, gfp_t);
 
 static struct array_cache **alloc_alien_cache(int node, int limit)
 {
@@ -2754,19 +2755,11 @@ static inline void *____cache_alloc(stru
 	struct array_cache *ac;
 
 #ifdef CONFIG_NUMA
-	if (unlikely(current->mempolicy && !in_interrupt())) {
-		int nid = slab_node(current->mempolicy);
-
-		if (nid != numa_node_id())
-			return __cache_alloc_node(cachep, flags, nid);
-	}
-	if (unlikely(cpuset_do_slab_mem_spread() &&
-					(cachep->flags & SLAB_MEM_SPREAD) &&
-					!in_interrupt())) {
-		int nid = cpuset_mem_spread_node();
-
-		if (nid != numa_node_id())
-			return __cache_alloc_node(cachep, flags, nid);
+	if (unlikely(current->flags & (PF_SPREAD_PAGE | PF_SPREAD_SLAB |
+							PF_MEMPOLICY))) {
+		objp = alternate_node_alloc(cachep, flags);
+		if (objp != NULL)
+			return objp;
 	}
 #endif
 
@@ -2802,6 +2795,28 @@ static __always_inline void *__cache_all
 
 #ifdef CONFIG_NUMA
 /*
+ * Try allocating on another node if PF_SPREAD_PAGE|PF_SPREAD_SLAB|PF_MEMPOLICY.
+ *
+ * If we are in_interrupt, then process context, including cpusets and
+ * mempolicy, may not apply and should not be used for allocation policy.
+ */
+static void *alternate_node_alloc(struct kmem_cache *cachep, gfp_t flags)
+{
+	int nid_alloc, nid_here;
+
+	if (in_interrupt())
+		return NULL;
+	nid_alloc = nid_here = numa_node_id();
+	if (cpuset_do_slab_mem_spread() && (cachep->flags & SLAB_MEM_SPREAD))
+		nid_alloc = cpuset_mem_spread_node();
+	else if (current->mempolicy)
+		nid_alloc = slab_node(current->mempolicy);
+	if (nid_alloc != nid_here)
+		return __cache_alloc_node(cachep, flags, nid_alloc);
+	return NULL;
+}
+
+/*
  * A interface to enable slab creation on nodeid
  */
 static void *__cache_alloc_node(struct kmem_cache *cachep, gfp_t flags,
--- 2.6.16-rc2-mm1.orig/include/linux/sched.h	2006-02-09 00:14:01.739932197 -0800
+++ 2.6.16-rc2-mm1/include/linux/sched.h	2006-02-09 01:38:13.631062204 -0800
@@ -938,6 +938,7 @@ static inline void put_task_struct(struc
 #define PF_SWAPWRITE	0x01000000	/* Allowed to write to swap */
 #define PF_SPREAD_PAGE	0x04000000	/* Spread page cache over cpuset */
 #define PF_SPREAD_SLAB	0x08000000	/* Spread some slab caches over cpuset */
+#define PF_MEMPOLICY	0x10000000	/* Non-default NUMA mempolicy */
 
 /*
  * Only the _current_ task can read/write to tsk->flags, but other

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
