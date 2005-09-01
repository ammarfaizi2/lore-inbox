Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750812AbVIAJJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbVIAJJs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 05:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750784AbVIAJJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 05:09:47 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:14742 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750812AbVIAJJq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 05:09:46 -0400
Date: Thu, 1 Sep 2005 02:09:18 -0700 (PDT)
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org,
       Dinakar Guniguntala <dino@in.ibm.com>,
       Joel Schopp <jschopp@austin.ibm.com>, Simon Derr <Simon.Derr@bull.net>,
       Linus Torvalds <torvalds@osdl.org>, Paul Jackson <pj@sgi.com>,
       Dave Hansen <haveblue@us.ibm.com>
Message-Id: <20050901090918.18441.15908.sendpatchset@jackhammer.engr.sgi.com>
In-Reply-To: <20050901090853.18441.24035.sendpatchset@jackhammer.engr.sgi.com>
References: <20050901090853.18441.24035.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH 4/4] cpusets confine oom_killer to mem_exclusive cpuset
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now the real motivation for this cpuset mem_exclusive patch series
seems trivial.  This patch depends on the previous cpuset_zone_allowed
patch and its prerequisites.

This patch keeps a task in or under one mem_exclusive cpuset from
provoking an oom kill of a task under a non-overlapping mem_exclusive
cpuset.  Since only interrupt and GFP_ATOMIC allocations are allowed
to escape mem_exclusive containment, there is little to gain from
oom killing a task under a non-overlapping mem_exclusive cpuset, as
almost all kernel and user memory allocation must come from disjoint
memory nodes.

This patch enables configuring a system so that a runaway job under
one mem_exclusive cpuset cannot cause the killing of a job in another
such cpuset that might be using very high compute and memory resources
for a prolonged time.

Signed-off-by: Paul Jackson <pj@sgi.com>

Index: linux-2.6.13-mem_exclusive_oom/include/linux/cpuset.h
===================================================================
--- linux-2.6.13-mem_exclusive_oom.orig/include/linux/cpuset.h
+++ linux-2.6.13-mem_exclusive_oom/include/linux/cpuset.h
@@ -24,6 +24,7 @@ void cpuset_update_current_mems_allowed(
 void cpuset_restrict_to_mems_allowed(unsigned long *nodes);
 int cpuset_zonelist_valid_mems_allowed(struct zonelist *zl);
 extern int cpuset_zone_allowed(struct zone *z, unsigned int __nocast gfp_mask);
+extern int cpuset_excl_nodes_overlap(const struct task_struct *p);
 extern struct file_operations proc_cpuset_operations;
 extern char *cpuset_task_status_allowed(struct task_struct *task, char *buffer);
 
@@ -54,6 +55,11 @@ static inline int cpuset_zone_allowed(st
 	return 1;
 }
 
+static inline int cpuset_excl_nodes_overlap(const struct task_struct *p)
+{
+	return 1;
+}
+
 static inline char *cpuset_task_status_allowed(struct task_struct *task,
 							char *buffer)
 {
Index: linux-2.6.13-mem_exclusive_oom/kernel/cpuset.c
===================================================================
--- linux-2.6.13-mem_exclusive_oom.orig/kernel/cpuset.c
+++ linux-2.6.13-mem_exclusive_oom/kernel/cpuset.c
@@ -1688,6 +1688,39 @@ done:
 	return allowed;
 }
 
+/**
+ * cpuset_excl_nodes_overlap - Do we overlap @p's mem_exclusive ancestors?
+ * @p: pointer to task_struct of some other task.
+ *
+ * Description: Return true if the nearest mem_exclusive ancestor
+ * cpusets of tasks @p and current overlap.  Used by oom killer to
+ * determine if task @p's memory usage might impact the memory
+ * available to the current task.
+ *
+ * Acquires cpuset_sem - not suitable for calling from a fast path.
+ **/
+
+int cpuset_excl_nodes_overlap(const struct task_struct *p)
+{
+	const struct cpuset *cs1, *cs2;	/* my and p's cpuset ancestors */
+	int overlap = 0;		/* do cpusets overlap? */
+
+	down(&cpuset_sem);
+	cs1 = current->cpuset;
+	if (!cs1)
+		goto done;		/* current task exiting */
+	cs2 = p->cpuset;
+	if (!cs2)
+		goto done;		/* task p is exiting */
+	cs1 = nearest_exclusive_ancestor(cs1);
+	cs2 = nearest_exclusive_ancestor(cs2);
+	overlap = nodes_intersects(cs1->mems_allowed, cs2->mems_allowed);
+done:
+	up(&cpuset_sem);
+
+	return overlap;
+}
+
 /*
  * proc_cpuset_show()
  *  - Print tasks cpuset path into seq_file.
Index: linux-2.6.13-mem_exclusive_oom/mm/oom_kill.c
===================================================================
--- linux-2.6.13-mem_exclusive_oom.orig/mm/oom_kill.c
+++ linux-2.6.13-mem_exclusive_oom/mm/oom_kill.c
@@ -20,6 +20,7 @@
 #include <linux/swap.h>
 #include <linux/timex.h>
 #include <linux/jiffies.h>
+#include <linux/cpuset.h>
 
 /* #define DEBUG */
 
@@ -152,6 +153,10 @@ static struct task_struct * select_bad_p
 			continue;
 		if (p->oomkilladj == OOM_DISABLE)
 			continue;
+		/* If p's nodes don't overlap ours, it won't help to kill p. */
+		if (!cpuset_excl_nodes_overlap(p))
+			continue;
+
 		/*
 		 * This is in the process of releasing memory so for wait it
 		 * to finish before killing some other task by mistake.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
