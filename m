Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030553AbVKDFbv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030553AbVKDFbv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 00:31:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030597AbVKDFbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 00:31:51 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:29119 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030553AbVKDFbt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 00:31:49 -0500
Date: Thu, 3 Nov 2005 21:31:42 -0800 (PST)
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Jackson <pj@sgi.com>, Simon Derr <Simon.Derr@bull.net>,
       Andi Kleen <ak@suse.de>, Christoph Lameter <clameter@sgi.com>,
       linux-kernel@vger.kernel.org
Message-Id: <20051104053142.549.26590.sendpatchset@jackhammer.engr.sgi.com>
In-Reply-To: <20051104053109.549.76824.sendpatchset@jackhammer.engr.sgi.com>
References: <20051104053109.549.76824.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH 4/5] cpuset: mempolicy one more nodemask conversion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Finish converting mm/mempolicy.c from bitmaps to nodemasks.
The previous conversion had left one routine using bitmaps,
since it involved a corresponding change to kernel/cpuset.c

Fix that interface by replacing with a simple macro that
calls nodes_subset(), or if !CONFIG_CPUSET, returns (1).

Signed-off-by: Paul Jackson <pj@sgi.com>

---

 include/linux/cpuset.h |    5 +++--
 kernel/cpuset.c        |   10 ----------
 mm/mempolicy.c         |    5 ++---
 3 files changed, 5 insertions(+), 15 deletions(-)

--- 2.6.14-rc5-mm1-cpuset-patches.orig/include/linux/cpuset.h	2005-11-02 23:18:21.015972401 -0800
+++ 2.6.14-rc5-mm1-cpuset-patches/include/linux/cpuset.h	2005-11-02 23:18:22.437863143 -0800
@@ -21,7 +21,8 @@ extern void cpuset_exit(struct task_stru
 extern cpumask_t cpuset_cpus_allowed(const struct task_struct *p);
 void cpuset_init_current_mems_allowed(void);
 void cpuset_update_current_mems_allowed(void);
-void cpuset_restrict_to_mems_allowed(unsigned long *nodes);
+#define cpuset_nodes_subset_current_mems_allowed(nodes) \
+		nodes_subset((nodes), current->mems_allowed)
 int cpuset_zonelist_valid_mems_allowed(struct zonelist *zl);
 extern int cpuset_zone_allowed(struct zone *z, gfp_t gfp_mask);
 extern int cpuset_excl_nodes_overlap(const struct task_struct *p);
@@ -42,7 +43,7 @@ static inline cpumask_t cpuset_cpus_allo
 
 static inline void cpuset_init_current_mems_allowed(void) {}
 static inline void cpuset_update_current_mems_allowed(void) {}
-static inline void cpuset_restrict_to_mems_allowed(unsigned long *nodes) {}
+#define cpuset_nodes_subset_current_mems_allowed(nodes) (1)
 
 static inline int cpuset_zonelist_valid_mems_allowed(struct zonelist *zl)
 {
--- 2.6.14-rc5-mm1-cpuset-patches.orig/kernel/cpuset.c	2005-11-02 23:18:21.015972401 -0800
+++ 2.6.14-rc5-mm1-cpuset-patches/kernel/cpuset.c	2005-11-02 23:18:22.438839716 -0800
@@ -1790,16 +1790,6 @@ done:
 }
 
 /**
- * cpuset_restrict_to_mems_allowed - limit nodes to current mems_allowed
- * @nodes: pointer to a node bitmap that is and-ed with mems_allowed
- */
-void cpuset_restrict_to_mems_allowed(unsigned long *nodes)
-{
-	bitmap_and(nodes, nodes, nodes_addr(current->mems_allowed),
-							MAX_NUMNODES);
-}
-
-/**
  * cpuset_zonelist_valid_mems_allowed - check zonelist vs. curremt mems_allowed
  * @zl: the zonelist to be checked
  *
--- 2.6.14-rc5-mm1-cpuset-patches.orig/mm/mempolicy.c	2005-11-02 23:18:21.015972401 -0800
+++ 2.6.14-rc5-mm1-cpuset-patches/mm/mempolicy.c	2005-11-02 23:18:22.440792863 -0800
@@ -342,10 +342,9 @@ static int contextualize_policy(int mode
 	if (!nodes)
 		return 0;
 
-	/* Update current mems_allowed */
 	cpuset_update_current_mems_allowed();
-	/* Ignore nodes not set in current->mems_allowed */
-	cpuset_restrict_to_mems_allowed(nodes->bits);
+	if (!cpuset_nodes_subset_current_mems_allowed(*nodes))
+		return -EINVAL;
 	return mpol_check_policy(mode, nodes);
 }
 

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
