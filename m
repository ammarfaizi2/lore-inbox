Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbVIAJJQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbVIAJJQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 05:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbVIAJJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 05:09:16 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:31676 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1750746AbVIAJJQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 05:09:16 -0400
Date: Thu, 1 Sep 2005 02:08:59 -0700 (PDT)
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org,
       Dinakar Guniguntala <dino@in.ibm.com>,
       Joel Schopp <jschopp@austin.ibm.com>, Simon Derr <Simon.Derr@bull.net>,
       Linus Torvalds <torvalds@osdl.org>, Paul Jackson <pj@sgi.com>,
       Dave Hansen <haveblue@us.ibm.com>
Message-Id: <20050901090859.18441.67380.sendpatchset@jackhammer.engr.sgi.com>
In-Reply-To: <20050901090853.18441.24035.sendpatchset@jackhammer.engr.sgi.com>
References: <20050901090853.18441.24035.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH 1/4] cpusets oom_kill tweaks
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch applies a few comment and code cleanups to mm/oom_kill.c
prior to applying a few small patches to improve cpuset management of
memory placement.

The comment changed in oom_kill.c was seriously misleading.  The code
layout change in select_bad_process() makes room for adding another
condition on which a process can be spared the oom killer (see the
subsequent cpuset_nodes_overlap patch for this addition).

Also a couple typos and spellos that bugged me, while I was here.

This patch should have no material affect.

Signed-off-by: Paul Jackson <pj@sgi.com>

Index: linux-2.6.13-mem_exclusive_oom/mm/oom_kill.c
===================================================================
--- linux-2.6.13-mem_exclusive_oom.orig/mm/oom_kill.c
+++ linux-2.6.13-mem_exclusive_oom/mm/oom_kill.c
@@ -6,8 +6,8 @@
  *	for goading me into coding this file...
  *
  *  The routines in this file are used to kill a process when
- *  we're seriously out of memory. This gets called from kswapd()
- *  in linux/mm/vmscan.c when we really run out of memory.
+ *  we're seriously out of memory. This gets called from __alloc_pages()
+ *  in mm/page_alloc.c when we really run out of memory.
  *
  *  Since we won't call these routines often (on a well-configured
  *  machine) this file will double as a 'coding guide' and a signpost
@@ -26,7 +26,7 @@
 /**
  * oom_badness - calculate a numeric value for how bad this task has been
  * @p: task struct of which task we should calculate
- * @p: current uptime in seconds
+ * @uptime: current uptime in seconds
  *
  * The formula used is relatively simple and documented inline in the
  * function. The main rationale is that we want to select a good task
@@ -57,9 +57,9 @@ unsigned long badness(struct task_struct
 
 	/*
 	 * Processes which fork a lot of child processes are likely
-	 * a good choice. We add the vmsize of the childs if they
+	 * a good choice. We add the vmsize of the children if they
 	 * have an own mm. This prevents forking servers to flood the
-	 * machine with an endless amount of childs
+	 * machine with an endless amount of children
 	 */
 	list_for_each(tsk, &p->children) {
 		struct task_struct *chld;
@@ -143,28 +143,32 @@ static struct task_struct * select_bad_p
 	struct timespec uptime;
 
 	do_posix_clock_monotonic_gettime(&uptime);
-	do_each_thread(g, p)
-		/* skip the init task with pid == 1 */
-		if (p->pid > 1 && p->oomkilladj != OOM_DISABLE) {
-			unsigned long points;
+	do_each_thread(g, p) {
+		unsigned long points;
+		int releasing;
 
-			/*
-			 * This is in the process of releasing memory so wait it
-			 * to finish before killing some other task by mistake.
-			 */
-			if ((unlikely(test_tsk_thread_flag(p, TIF_MEMDIE)) || (p->flags & PF_EXITING)) &&
-			    !(p->flags & PF_DEAD))
-				return ERR_PTR(-1UL);
-			if (p->flags & PF_SWAPOFF)
-				return p;
-
-			points = badness(p, uptime.tv_sec);
-			if (points > maxpoints || !chosen) {
-				chosen = p;
-				maxpoints = points;
-			}
+		/* skip the init task with pid == 1 */
+		if (p->pid == 1)
+			continue;
+		if (p->oomkilladj == OOM_DISABLE)
+			continue;
+		/*
+		 * This is in the process of releasing memory so for wait it
+		 * to finish before killing some other task by mistake.
+		 */
+		releasing = test_tsk_thread_flag(p, TIF_MEMDIE) ||
+						p->flags & PF_EXITING;
+		if (releasing && !(p->flags & PF_DEAD))
+			return ERR_PTR(-1UL);
+		if (p->flags & PF_SWAPOFF)
+			return p;
+
+		points = badness(p, uptime.tv_sec);
+		if (points > maxpoints || !chosen) {
+			chosen = p;
+			maxpoints = points;
 		}
-	while_each_thread(g, p);
+	} while_each_thread(g, p);
 	return chosen;
 }
 
@@ -189,7 +193,8 @@ static void __oom_kill_task(task_t *p)
 		return;
 	}
 	task_unlock(p);
-	printk(KERN_ERR "Out of Memory: Killed process %d (%s).\n", p->pid, p->comm);
+	printk(KERN_ERR "Out of Memory: Killed process %d (%s).\n",
+							p->pid, p->comm);
 
 	/*
 	 * We give our sacrificial lamb high priority and access to

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
