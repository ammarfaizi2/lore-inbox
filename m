Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750749AbVJXH2A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbVJXH2A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 03:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbVJXH2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 03:28:00 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:1465 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750749AbVJXH16 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 03:27:58 -0400
Date: Mon, 24 Oct 2005 00:27:50 -0700 (PDT)
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       Christoph Lameter <clameter@sgi.com>,
       Linus Torvalds <torvalds@osdl.org>, Paul Jackson <pj@sgi.com>,
       Andi Kleen <ak@suse.de>
Message-Id: <20051024072750.10390.32993.sendpatchset@jackhammer.engr.sgi.com>
In-Reply-To: <20051024072744.10390.35722.sendpatchset@jackhammer.engr.sgi.com>
References: <20051024072744.10390.35722.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH 02/02] cpuset automatic numa mempolicy rebinding
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch automatically updates a tasks NUMA mempolicy when its cpuset
memory placement changes.  It does so within the context of the task,
without any need to support low level external mempolicy manipulation.

If a system is not using cpusets, or if running on a system with
just the root (all-encompassing) cpuset, then this remap is a no-op.
Only when a task is moved between cpusets, or a cpusets memory
placement is changed does the following apply.  Otherwise, the main
routine below, rebind_policy() is not even called.

When mixing cpusets, scheduler affinity, and NUMA mempolicies, the
essential role of cpusets is to place jobs (several related tasks) on a
set of CPUs and Memory Nodes, the essential role of sched_setaffinity
is to manage a jobs processor placement within its allowed cpuset,
and the essential role of NUMA mempolicy (mbind, set_mempolicy)
is to manage a jobs memory placement within its allowed cpuset.

However, CPU affinity and NUMA memory placement are managed within
the kernel using absolute system wide numbering, not cpuset relative
numbering.

This is ok until a job is migrated to a different cpuset, or what's
the same, a jobs cpuset is moved to different CPUs and Memory Nodes.

Then the CPU affinity and NUMA memory placement of the tasks in the
job need to be updated, to preserve their cpuset-relative position.
This can be done for CPU affinity using sched_setaffinity() from user
code, as one task can modify anothers CPU affinity.  This cannot be
done from an external task for NUMA memory placement, as that can
only be modified in the context of the task using it.

However, it easy enough to remap a tasks NUMA mempolicy automatically
when a task is migrated, using the existing cpuset mechanism to trigger
a refresh of a tasks memory placement after its cpuset has changed.
All that is needed is the old and new nodemask, and notice to the
task that it needs to rebind its mempolicy.  The tasks mems_allowed
has the old mask, the tasks cpuset has the new mask, and the existing
cpuset_update_current_mems_allowed() mechanism provides the notice.
The bitmap/cpumask/nodemask remap operators provide the cpuset
relative calculations.

This patch leaves open a couple of issues:

 1) Updating vma and shmfs/tmpfs/hugetlbfs memory policies:
 
    These mempolicies may reference nodes outside of those allowed
    to the current task by its cpuset.  Tasks are migrated as part of
    jobs, which reside on what might be several cpusets in a subtree.
    When such a job is migrated, all NUMA memory policy references
    to nodes within that cpuset subtree should be translated, and
    references to any nodes outside that subtree should be left
    untouched.  A future patch will provide the cpuset mechanism
    needed to mark such subtrees.  With that patch, we will be able
    to correctly migrate these other memory policies across a job
    migration.

 2) Updating cpuset, affinity and memory policies in user space:
 
    This is harder.  Any placement state stored in user space
    using system-wide numbering will be invalidated across a
    migration.  More work will be required to provide user code
    with a migration-safe means to manage its cpuset relative
    placement, while preserving the current API's that pass
    system wide numbers, not cpuset relative numbers across the
    kernel-user boundary.

Signed-off-by: Paul Jackson

---

 include/linux/mempolicy.h |    6 ++++
 kernel/cpuset.c           |    4 ++
 mm/mempolicy.c            |   64 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 74 insertions(+)

--- 2.6.14-rc4-mm1-cpuset-patches.orig/include/linux/mempolicy.h	2005-10-23 21:33:27.371933009 -0700
+++ 2.6.14-rc4-mm1-cpuset-patches/include/linux/mempolicy.h	2005-10-23 21:34:42.485999678 -0700
@@ -155,6 +155,7 @@ struct mempolicy *get_vma_policy(struct 
 
 extern void numa_default_policy(void);
 extern void numa_policy_init(void);
+extern void numa_policy_rebind(const nodemask_t *old, const nodemask_t *new);
 extern struct mempolicy default_policy;
 
 #else
@@ -227,6 +228,11 @@ static inline void numa_default_policy(v
 {
 }
 
+static inline void numa_policy_rebind(const nodemask_t *old,
+					const nodemask_t *new)
+{
+}
+
 #endif /* CONFIG_NUMA */
 #endif /* __KERNEL__ */
 
--- 2.6.14-rc4-mm1-cpuset-patches.orig/kernel/cpuset.c	2005-10-23 21:33:27.494004597 -0700
+++ 2.6.14-rc4-mm1-cpuset-patches/kernel/cpuset.c	2005-10-23 21:34:42.490882542 -0700
@@ -32,6 +32,7 @@
 #include <linux/kernel.h>
 #include <linux/kmod.h>
 #include <linux/list.h>
+#include <linux/mempolicy.h>
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/mount.h>
@@ -600,6 +601,7 @@ static void refresh_mems(void)
 
 	if (current->cpuset_mems_generation != my_cpusets_mem_gen) {
 		struct cpuset *cs;
+		nodemask_t oldmem = current->mems_allowed;
 
 		down(&callback_sem);
 		task_lock(current);
@@ -608,6 +610,8 @@ static void refresh_mems(void)
 		current->cpuset_mems_generation = cs->mems_generation;
 		task_unlock(current);
 		up(&callback_sem);
+		if (!nodes_equal(oldmem, current->mems_allowed))
+			numa_policy_rebind(&oldmem, &current->mems_allowed);
 	}
 }
 
--- 2.6.14-rc4-mm1-cpuset-patches.orig/mm/mempolicy.c	2005-10-23 21:33:27.494981170 -0700
+++ 2.6.14-rc4-mm1-cpuset-patches/mm/mempolicy.c	2005-10-23 23:22:15.814826285 -0700
@@ -457,6 +457,7 @@ long do_get_mempolicy(int *policy, nodem
 	struct vm_area_struct *vma = NULL;
 	struct mempolicy *pol = current->mempolicy;
 
+	cpuset_update_current_mems_allowed();
 	if (flags & ~(unsigned long)(MPOL_F_NODE|MPOL_F_ADDR))
 		return -EINVAL;
 	if (flags & MPOL_F_ADDR) {
@@ -1205,3 +1206,66 @@ void numa_default_policy(void)
 {
 	do_set_mempolicy(MPOL_DEFAULT, NULL);
 }
+
+/* Migrate a policy to a different set of nodes */
+static void rebind_policy(struct mempolicy *pol, const nodemask_t *old,
+							const nodemask_t *new)
+{
+	nodemask_t tmp;
+
+	if (!pol)
+		return;
+
+	switch (pol->policy) {
+	case MPOL_DEFAULT:
+		break;
+	case MPOL_INTERLEAVE:
+		nodes_remap(tmp, pol->v.nodes, *old, *new);
+		pol->v.nodes = tmp;
+		current->il_next = node_remap(current->il_next, *old, *new);
+		break;
+	case MPOL_PREFERRED:
+		pol->v.preferred_node = node_remap(pol->v.preferred_node,
+								*old, *new);
+		break;
+	case MPOL_BIND: {
+		nodemask_t nodes;
+		struct zone **z;
+		struct zonelist *zonelist;
+
+		nodes_clear(nodes);
+		for (z = pol->v.zonelist->zones; *z; z++)
+			node_set((*z)->zone_pgdat->node_id, nodes);
+		nodes_remap(tmp, nodes, *old, *new);
+		nodes = tmp;
+
+		zonelist = bind_zonelist(&nodes);
+
+		/* If no mem, then zonelist is NULL and we keep old zonelist.
+		 * If that old zonelist has no remaining mems_allowed nodes,
+		 * then zonelist_policy() will "FALL THROUGH" to MPOL_DEFAULT.
+		 */
+
+		if (zonelist) {
+			/* Good - got mem - substitute new zonelist */
+			kfree(pol->v.zonelist);
+			pol->v.zonelist = zonelist;
+		}
+		break;
+	}
+	default:
+		BUG();
+		break;
+	}
+}
+
+/*
+ * Someone moved this task to different nodes.  Fixup mempolicies.
+ *
+ * TODO - fixup current->mm->vma and shmfs/tmpfs/hugetlbfs policies as well,
+ * once we have a cpuset mechanism to mark which cpuset subtree is migrating.
+ */
+void numa_policy_rebind(const nodemask_t *old, const nodemask_t *new)
+{
+	rebind_policy(current->mempolicy, old, new);
+}

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
