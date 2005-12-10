Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964964AbVLJIU1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964964AbVLJIU1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 03:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964971AbVLJIUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 03:20:05 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:26585 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S964966AbVLJITh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 03:19:37 -0500
Date: Sat, 10 Dec 2005 00:19:28 -0800 (PST)
From: Paul Jackson <pj@sgi.com>
To: akpm@osdl.org
Cc: Simon Derr <Simon.Derr@bull.net>, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org, Christoph Lameter <clameter@sgi.com>
Message-Id: <20051210081928.12303.34895.sendpatchset@jackhammer.engr.sgi.com>
In-Reply-To: <20051210081843.12303.13344.sendpatchset@jackhammer.engr.sgi.com>
References: <20051210081843.12303.13344.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH 08/10] Cpuset: number_of_cpusets optimization
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Easy little optimization hack to avoid actually having to call
cpuset_zone_allowed() and check mems_allowed, in the main page
allocation routine, __alloc_pages().  This saves several CPU
cycles per page allocation on systems not using cpusets.

A counter is updated each time a cpuset is created or removed,
and whenever there is only one cpuset in the system, it must be
the root cpuset, which contains all CPUs and all Memory Nodes.
In that case, when the counter is one, all allocations are
allowed.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

 include/linux/cpuset.h |   10 +++++++++-
 kernel/cpuset.c        |   12 +++++++++++-
 2 files changed, 20 insertions(+), 2 deletions(-)

--- 2.6.15-rc3-mm1.orig/include/linux/cpuset.h	2005-12-05 23:11:38.389769102 -0800
+++ 2.6.15-rc3-mm1/include/linux/cpuset.h	2005-12-05 23:11:51.876246895 -0800
@@ -14,6 +14,8 @@
 
 #ifdef CONFIG_CPUSETS
 
+extern int number_of_cpusets;	/* How many cpusets are defined in system? */
+
 extern int cpuset_init(void);
 extern void cpuset_init_smp(void);
 extern void cpuset_fork(struct task_struct *p);
@@ -25,7 +27,13 @@ void cpuset_update_task_memory_state(voi
 #define cpuset_nodes_subset_current_mems_allowed(nodes) \
 		nodes_subset((nodes), current->mems_allowed)
 int cpuset_zonelist_valid_mems_allowed(struct zonelist *zl);
-extern int cpuset_zone_allowed(struct zone *z, gfp_t gfp_mask);
+
+extern int __cpuset_zone_allowed(struct zone *z, gfp_t gfp_mask);
+static int inline cpuset_zone_allowed(struct zone *z, gfp_t gfp_mask)
+{
+	return number_of_cpusets <= 1 || __cpuset_zone_allowed(z, gfp_mask);
+}
+
 extern int cpuset_excl_nodes_overlap(const struct task_struct *p);
 
 #define cpuset_memory_pressure_bump() 				\
--- 2.6.15-rc3-mm1.orig/kernel/cpuset.c	2005-12-05 23:11:45.502152719 -0800
+++ 2.6.15-rc3-mm1/kernel/cpuset.c	2005-12-05 23:11:51.880153188 -0800
@@ -56,6 +56,13 @@
 
 #define CPUSET_SUPER_MAGIC		0x27e0eb
 
+/*
+ * Tracks how many cpusets are currently defined in system.
+ * When there is only one cpuset (the root cpuset) we can
+ * short circuit some hooks.
+ */
+int number_of_cpusets;
+
 /* See "Frequency meter" comments, below. */
 
 struct fmeter {
@@ -1664,6 +1671,7 @@ static long cpuset_create(struct cpuset 
 
 	down(&callback_sem);
 	list_add(&cs->sibling, &cs->parent->children);
+	number_of_cpusets++;
 	up(&callback_sem);
 
 	err = cpuset_create_dir(cs, name, mode);
@@ -1726,6 +1734,7 @@ static int cpuset_rmdir(struct inode *un
 	spin_unlock(&d->d_lock);
 	cpuset_d_remove_dir(d);
 	dput(d);
+	number_of_cpusets--;
 	up(&callback_sem);
 	if (list_empty(&parent->children))
 		check_for_release(parent, &pathbuf);
@@ -1769,6 +1778,7 @@ int __init cpuset_init(void)
 	root->d_inode->i_nlink++;
 	top_cpuset.dentry = root;
 	root->d_inode->i_op = &cpuset_dir_inode_operations;
+	number_of_cpusets = 1;
 	err = cpuset_populate_dir(root);
 	/* memory_pressure_enabled is in root cpuset only */
 	if (err == 0)
@@ -1982,7 +1992,7 @@ static const struct cpuset *nearest_excl
  *	GFP_USER     - only nodes in current tasks mems allowed ok.
  **/
 
-int cpuset_zone_allowed(struct zone *z, gfp_t gfp_mask)
+int __cpuset_zone_allowed(struct zone *z, gfp_t gfp_mask)
 {
 	int node;			/* node that zone z is on */
 	const struct cpuset *cs;	/* current cpuset ancestors */

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
