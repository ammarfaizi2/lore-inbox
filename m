Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964988AbVLJIT7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964988AbVLJIT7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 03:19:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964967AbVLJITj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 03:19:39 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:3009 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964971AbVLJITa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 03:19:30 -0500
Date: Sat, 10 Dec 2005 00:19:22 -0800 (PST)
From: Paul Jackson <pj@sgi.com>
To: akpm@osdl.org
Cc: Paul Jackson <pj@sgi.com>, Simon Derr <Simon.Derr@bull.net>,
       linux-kernel@vger.kernel.org, Christoph Lameter <clameter@sgi.com>
Message-Id: <20051210081922.12303.89583.sendpatchset@jackhammer.engr.sgi.com>
In-Reply-To: <20051210081843.12303.13344.sendpatchset@jackhammer.engr.sgi.com>
References: <20051210081843.12303.13344.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH 07/10] Cpuset: numa_policy_rebind cleanup
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup, reorganize and make more robust the mempolicy.c code
to rebind mempolicies relative to the containing cpuset after
a tasks memory placement changes.

The real motivator for this cleanup patch is to lay more
groundwork for the upcoming patch to correctly rebind NUMA
mempolicies that are attached to vma's after the containing
cpuset memory placement changes.

NUMA mempolicies are constrained by the cpuset their task is
a member of.  When either (1) a task is moved to a different
cpuset, or (2) the 'mems' mems_allowed of a cpuset is changed,
then the NUMA mempolicies have embedded node numbers (for
MPOL_BIND, MPOL_INTERLEAVE and MPOL_PREFERRED) that need to be
recalculated, relative to their new cpuset placement.

The old code used an unreliable method of determining what was
the old mems_allowed constraining the mempolicy.  It just looked
at the tasks mems_allowed value.  This sort of worked with the
present code, that just rebinds the -task- mempolicy, and leaves
any -vma- mempolicies broken, referring to the old nodes.  But in
an upcoming patch, the vma mempolicies will be rebound as well.
Then the order in which the various task and vma mempolicies
are updated will no longer be deterministic, and one can no
longer count on the task->mems_allowed holding the old value
for as long as needed.  It's not even clear if the current code
was guaranteed to work reliably for task mempolicies.

So I added a mems_allowed field to each mempolicy, stating
exactly what mems_allowed the policy is relative to, and updated
synchronously and reliably anytime that the mempolicy is rebound.

Also removed a useless wrapper routine, numa_policy_rebind(),
and had its caller, cpuset_update_task_memory_state(), call
directly to the rewritten policy_rebind() routine, and made that
rebind routine extern instead of static, and added a "mpol_"
prefix to its name, making it mpol_rebind_policy().

Signed-off-by: Paul Jackson <pj@sgi.com>

---

 include/linux/mempolicy.h |   12 ++++++++++--
 kernel/cpuset.c           |    2 +-
 mm/mempolicy.c            |   31 +++++++++++++++++++------------
 3 files changed, 30 insertions(+), 15 deletions(-)

--- 2.6.15-rc3-mm1.orig/include/linux/mempolicy.h	2005-12-08 19:37:37.906709408 -0800
+++ 2.6.15-rc3-mm1/include/linux/mempolicy.h	2005-12-08 19:42:05.996633138 -0800
@@ -68,6 +68,7 @@ struct mempolicy {
 		nodemask_t	 nodes;		/* interleave */
 		/* undefined for default */
 	} v;
+	nodemask_t cpuset_mems_allowed;	/* mempolicy relative to these nodes */
 };
 
 /*
@@ -146,7 +147,9 @@ struct mempolicy *mpol_shared_policy_loo
 
 extern void numa_default_policy(void);
 extern void numa_policy_init(void);
-extern void numa_policy_rebind(const nodemask_t *old, const nodemask_t *new);
+extern void mpol_rebind_policy(struct mempolicy *pol, const nodemask_t *new);
+extern void mpol_rebind_task(struct task_struct *tsk,
+					const nodemask_t *new);
 extern struct mempolicy default_policy;
 extern struct zonelist *huge_zonelist(struct vm_area_struct *vma,
 		unsigned long addr);
@@ -214,7 +217,12 @@ static inline void numa_default_policy(v
 {
 }
 
-static inline void numa_policy_rebind(const nodemask_t *old,
+static inline void mpol_rebind_policy(struct mempolicy *pol,
+					const nodemask_t *new)
+{
+}
+
+static inline void mpol_rebind_task(struct task_struct *tsk,
 					const nodemask_t *new)
 {
 }
--- 2.6.15-rc3-mm1.orig/mm/mempolicy.c	2005-12-08 19:39:31.277122633 -0800
+++ 2.6.15-rc3-mm1/mm/mempolicy.c	2005-12-08 19:43:22.825620845 -0800
@@ -185,6 +185,7 @@ static struct mempolicy *mpol_new(int mo
 		break;
 	}
 	policy->policy = mode;
+	policy->cpuset_mems_allowed = cpuset_mems_allowed(current);
 	return policy;
 }
 
@@ -1440,25 +1441,31 @@ void numa_default_policy(void)
 }
 
 /* Migrate a policy to a different set of nodes */
-static void rebind_policy(struct mempolicy *pol, const nodemask_t *old,
-							const nodemask_t *new)
+void mpol_rebind_policy(struct mempolicy *pol, const nodemask_t *newmask)
 {
+	nodemask_t *mpolmask;
 	nodemask_t tmp;
 
 	if (!pol)
 		return;
+	mpolmask = &pol->cpuset_mems_allowed;
+	if (nodes_equal(*mpolmask, *newmask))
+		return;
 
 	switch (pol->policy) {
 	case MPOL_DEFAULT:
 		break;
 	case MPOL_INTERLEAVE:
-		nodes_remap(tmp, pol->v.nodes, *old, *new);
+		nodes_remap(tmp, pol->v.nodes, *mpolmask, *newmask);
 		pol->v.nodes = tmp;
-		current->il_next = node_remap(current->il_next, *old, *new);
+		*mpolmask = *newmask;
+		current->il_next = node_remap(current->il_next,
+						*mpolmask, *newmask);
 		break;
 	case MPOL_PREFERRED:
 		pol->v.preferred_node = node_remap(pol->v.preferred_node,
-								*old, *new);
+						*mpolmask, *newmask);
+		*mpolmask = *newmask;
 		break;
 	case MPOL_BIND: {
 		nodemask_t nodes;
@@ -1468,7 +1475,7 @@ static void rebind_policy(struct mempoli
 		nodes_clear(nodes);
 		for (z = pol->v.zonelist->zones; *z; z++)
 			node_set((*z)->zone_pgdat->node_id, nodes);
-		nodes_remap(tmp, nodes, *old, *new);
+		nodes_remap(tmp, nodes, *mpolmask, *newmask);
 		nodes = tmp;
 
 		zonelist = bind_zonelist(&nodes);
@@ -1483,6 +1490,7 @@ static void rebind_policy(struct mempoli
 			kfree(pol->v.zonelist);
 			pol->v.zonelist = zonelist;
 		}
+		*mpolmask = *newmask;
 		break;
 	}
 	default:
@@ -1492,14 +1500,13 @@ static void rebind_policy(struct mempoli
 }
 
 /*
- * Someone moved this task to different nodes.  Fixup mempolicies.
- *
- * TODO - fixup current->mm->vma and shmfs/tmpfs/hugetlbfs policies as well,
- * once we have a cpuset mechanism to mark which cpuset subtree is migrating.
+ * Wrapper for mpol_rebind_policy() that just requires task
+ * pointer, and updates task mempolicy.
  */
-void numa_policy_rebind(const nodemask_t *old, const nodemask_t *new)
+
+void mpol_rebind_task(struct task_struct *tsk, const nodemask_t *new)
 {
-	rebind_policy(current->mempolicy, old, new);
+	mpol_rebind_policy(tsk->mempolicy, new);
 }
 
 /*
--- 2.6.15-rc3-mm1.orig/kernel/cpuset.c	2005-12-08 19:39:31.273216339 -0800
+++ 2.6.15-rc3-mm1/kernel/cpuset.c	2005-12-08 19:44:26.519692537 -0800
@@ -643,7 +643,7 @@ void cpuset_update_task_memory_state()
 		tsk->cpuset_mems_generation = cs->mems_generation;
 		task_unlock(tsk);
 		up(&callback_sem);
-		numa_policy_rebind(&oldmem, &tsk->mems_allowed);
+		mpol_rebind_task(tsk, &tsk->mems_allowed);
 		if (!nodes_equal(oldmem, tsk->mems_allowed)) {
 			if (migrate) {
 				do_migrate_pages(tsk->mm, &oldmem,

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
