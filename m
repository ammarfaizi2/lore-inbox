Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946333AbWBDHU2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946333AbWBDHU2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 02:20:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946329AbWBDHTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 02:19:54 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:17546 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1946327AbWBDHTd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 02:19:33 -0500
From: Paul Jackson <pj@sgi.com>
To: akpm@osdl.org
Cc: steiner@sgi.com, dgc@sgi.com, Simon.Derr@bull.net, ak@suse.de,
       linux-kernel@vger.kernel.org, Paul Jackson <pj@sgi.com>,
       clameter@sgi.com
Date: Fri, 03 Feb 2006 23:19:27 -0800
Message-Id: <20060204071927.10021.75308.sendpatchset@jackhammer.engr.sgi.com>
In-Reply-To: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH 4/5] cpuset memory spread slab cache optimizations
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Jackson <pj@sgi.com>

The hooks in the slab cache allocator code path for support
of NUMA mempolicies and cpuset memory spreading are in an
important code path.  Many systems will use neither feature.

This patch optimizes those hooks down to a single check of
some bits in the current tasks task_struct flags.  For non
NUMA systems, this hook and related code is already ifdef'd
out.

The optimization is done by using another task flag, set if
the task is using a non-default NUMA mempolicy.  Taking this
flag bit along with the PF_MEM_SPREAD flag bit added earlier
in this 'cpuset memory spreading' patch set, one can check
for the combination of either of these special case memory
placement mechanisms with a single test of the current tasks
task_struct flags.

This patch also tightens up the code, to save a few bytes
of kernel text space, and moves some of it out of line.
Due to the nested inlines called from multiple places,
we were ending up with three copies of this code, which
once we get off the main code path (for local node
allocation) seems a bit wasteful of instruction memory.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

 include/linux/mempolicy.h |    5 +++++
 include/linux/sched.h     |    1 +
 kernel/fork.c             |    1 +
 mm/mempolicy.c            |   18 ++++++++++++++++++
 mm/slab.c                 |   37 +++++++++++++++++++++++--------------
 5 files changed, 48 insertions(+), 14 deletions(-)

--- 2.6.16-rc1-mm5.orig/include/linux/sched.h	2006-02-03 22:17:26.705941251 -0800
+++ 2.6.16-rc1-mm5/include/linux/sched.h	2006-02-03 22:17:43.293042557 -0800
@@ -949,6 +949,7 @@ static inline void put_task_struct(struc
 #define PF_RANDOMIZE	0x00800000	/* randomize virtual address space */
 #define PF_SWAPWRITE	0x01000000	/* Allowed to write to swap */
 #define PF_MEM_SPREAD	0x04000000	/* Spread some memory over cpuset */
+#define PF_MEMPOLICY	0x08000000	/* Non-default NUMA mempolicy */
 
 /*
  * Only the _current_ task can read/write to tsk->flags, but other
--- 2.6.16-rc1-mm5.orig/kernel/fork.c	2006-02-03 22:17:26.707894398 -0800
+++ 2.6.16-rc1-mm5/kernel/fork.c	2006-02-03 22:17:43.304761439 -0800
@@ -1018,6 +1018,7 @@ static task_t *copy_process(unsigned lon
  		p->mempolicy = NULL;
  		goto bad_fork_cleanup_cpuset;
  	}
+	mpol_set_task_struct_flag(p);
 #endif
 
 #ifdef CONFIG_DEBUG_MUTEXES
--- 2.6.16-rc1-mm5.orig/mm/mempolicy.c	2006-02-03 22:17:26.707894398 -0800
+++ 2.6.16-rc1-mm5/mm/mempolicy.c	2006-02-03 22:17:43.323316336 -0800
@@ -423,6 +423,7 @@ long do_set_mempolicy(int mode, nodemask
 		return PTR_ERR(new);
 	mpol_free(current->mempolicy);
 	current->mempolicy = new;
+	mpol_set_task_struct_flag(current);
 	if (new && new->policy == MPOL_INTERLEAVE)
 		current->il_next = first_node(new->v.nodes);
 	return 0;
@@ -1666,6 +1667,23 @@ void mpol_rebind_mm(struct mm_struct *mm
 }
 
 /*
+ * Update task->flags PF_MEMPOLICY bit: set iff non-default mempolicy.
+ * Allows more rapid checking of this (combined perhaps with other
+ * PF_* flag bits) on memory allocation hot code paths.
+ *
+ * The task struct 'p' should either be current or a newly
+ * forked child that is not visible on the task list yet.
+ */
+
+void mpol_set_task_struct_flag(struct task_struct *p)
+{
+	if (p->mempolicy)
+		p->flags |= PF_MEMPOLICY;
+	else
+		p->flags &= ~PF_MEMPOLICY;
+}
+
+/*
  * Display pages allocated per node and memory policy via /proc.
  */
 
--- 2.6.16-rc1-mm5.orig/include/linux/mempolicy.h	2006-02-03 22:17:26.706917824 -0800
+++ 2.6.16-rc1-mm5/include/linux/mempolicy.h	2006-02-03 22:17:43.323316336 -0800
@@ -147,6 +147,7 @@ extern void mpol_rebind_policy(struct me
 extern void mpol_rebind_task(struct task_struct *tsk,
 					const nodemask_t *new);
 extern void mpol_rebind_mm(struct mm_struct *mm, nodemask_t *new);
+extern void mpol_set_task_struct_flag(struct task_struct *p);
 #define set_cpuset_being_rebound(x) (cpuset_being_rebound = (x))
 
 #ifdef CONFIG_CPUSET
@@ -248,6 +249,10 @@ static inline void mpol_rebind_mm(struct
 {
 }
 
+static inline void mpol_set_task_struct_flag(struct task_struct *p)
+{
+}
+
 #define set_cpuset_being_rebound(x) do {} while (0)
 
 static inline struct zonelist *huge_zonelist(struct vm_area_struct *vma,
--- 2.6.16-rc1-mm5.orig/mm/slab.c	2006-02-03 22:17:33.549768509 -0800
+++ 2.6.16-rc1-mm5/mm/slab.c	2006-02-03 22:17:43.327222630 -0800
@@ -850,6 +850,7 @@ static struct array_cache *alloc_arrayca
 
 #ifdef CONFIG_NUMA
 static void *__cache_alloc_node(struct kmem_cache *, gfp_t, int);
+static void *alternate_node_alloc(struct kmem_cache *, gfp_t);
 
 static struct array_cache **alloc_alien_cache(int node, int limit)
 {
@@ -2703,20 +2704,9 @@ static inline void *____cache_alloc(stru
 	struct array_cache *ac;
 
 #ifdef CONFIG_NUMA
-	if (unlikely(current->mempolicy && !in_interrupt())) {
-		int nid = slab_node(current->mempolicy);
-
-		if (nid != numa_node_id())
-			return __cache_alloc_node(cachep, flags, nid);
-	}
-	if (unlikely(cpuset_mem_spread_check() &&
-					(cachep->flags & SLAB_MEM_SPREAD) &&
-					!in_interrupt())) {
-		int nid = cpuset_mem_spread_node();
-
-		if (nid != numa_node_id())
-			return __cache_alloc_node(cachep, flags, nid);
-	}
+	if (unlikely(current->flags & (PF_MEM_SPREAD|PF_MEMPOLICY)))
+		if ((objp = alternate_node_alloc(cachep, flags)) != NULL)
+			return objp;
 #endif
 
 	check_irq_off();
@@ -2751,6 +2741,25 @@ __cache_alloc(struct kmem_cache *cachep,
 
 #ifdef CONFIG_NUMA
 /*
+ * Try allocating on another node if PF_MEM_SPREAD or PF_MEMPOLICY.
+ */
+static void *alternate_node_alloc(struct kmem_cache *cachep, gfp_t flags)
+{
+	int nid_alloc, nid_here;
+
+	if (in_interrupt())
+		return NULL;
+	nid_alloc = nid_here = numa_node_id();
+	if (cpuset_mem_spread_check() && (cachep->flags & SLAB_MEM_SPREAD))
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
 static void *__cache_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid)

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
