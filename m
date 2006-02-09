Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750745AbWBITyD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbWBITyD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 14:54:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbWBITyB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 14:54:01 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:39875 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750745AbWBITyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 14:54:01 -0500
Date: Thu, 9 Feb 2006 11:53:52 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: akpm@osdl.org
cc: ak@suse.de, pj@sgi.com, linux-kernel@vger.kernel.org
Subject: Terminate process that fails on a constrained allocation V3
Message-ID: <Pine.LNX.4.62.0602091152300.9941@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changes V2->V3:

- Do the killing of the current process following the execution
  procedure already established by the OOM killer.

- Do not return NULL and therefore do not change the return values of
  __alloc_pages.

- Identify the reason for the constraint so that something special may
  be done if a cpuset runs out of memory.


Some allocations are restricted to a limited set of nodes (due to memory
policies or cpuset constraints). If the page allocator is not able to find
enough memory then that does not mean that overall system memory is low.

In particular going postal and more or less randomly shooting at processes
is not likely going to help the situation but may just lead to suicide (the
whole system coming down).

It is better to signal to the process that no memory exists given the
constraints that the process (or the configuration of the process) has
placed on the allocation behavior. The process may be killed but then the
sysadmin or developer can investigate the situation. The solution is similar
to what we do when running out of hugepages.

This patch adds a check before we kill processes. At that
point performance considerations do not matter much so we just scan the zonelist
and reconstruct a list of nodes. If the list of nodes does not contain all
online nodes then this is a constrained allocation and we should kill the
currnet process.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.16-rc2/mm/oom_kill.c
===================================================================
--- linux-2.6.16-rc2.orig/mm/oom_kill.c	2006-02-02 22:03:08.000000000 -0800
+++ linux-2.6.16-rc2/mm/oom_kill.c	2006-02-09 11:52:05.000000000 -0800
@@ -131,6 +131,36 @@ unsigned long badness(struct task_struct
 }
 
 /*
+ * Types of limitations to the nodes from which allocations may occur
+ */
+#define CONSTRAINT_NONE 1
+#define CONSTRAINT_MEMORY_POLICY 2
+#define CONSTRAINT_CPUSET 3
+
+/*
+ * Determine the type of allocation constraint.
+ */
+static int constrained_alloc(struct zonelist *zonelist, gfp_t gfp_mask)
+{
+#ifdef CONFIG_NUMA
+	struct zone **z;
+	nodemask_t nodes = node_online_map;
+
+	for (z = zonelist->zones; *z; z++)
+		if (cpuset_zone_allowed(*z, gfp_mask))
+			node_clear((*z)->zone_pgdat->node_id,
+					nodes);
+		else
+			return CONSTRAINT_CPUSET;
+
+	if (!nodes_empty(nodes))
+		return CONSTRAINT_MEMORY_POLICY;
+#endif
+
+	return CONSTRAINT_NONE;
+}
+
+/*
  * Simple selection loop. We chose the process with the highest
  * number of 'points'. We expect the caller will lock the tasklist.
  *
@@ -182,7 +212,7 @@ static struct task_struct * select_bad_p
  * CAP_SYS_RAW_IO set, send SIGTERM instead (but it's unlikely that
  * we select a process with CAP_SYS_RAW_IO set).
  */
-static void __oom_kill_task(task_t *p)
+static void __oom_kill_task(task_t *p, const char *message)
 {
 	if (p->pid == 1) {
 		WARN_ON(1);
@@ -198,8 +228,8 @@ static void __oom_kill_task(task_t *p)
 		return;
 	}
 	task_unlock(p);
-	printk(KERN_ERR "Out of Memory: Killed process %d (%s).\n",
-							p->pid, p->comm);
+	printk(KERN_ERR "%s: Killed process %d (%s).\n",
+				message, p->pid, p->comm);
 
 	/*
 	 * We give our sacrificial lamb high priority and access to
@@ -212,7 +242,7 @@ static void __oom_kill_task(task_t *p)
 	force_sig(SIGKILL, p);
 }
 
-static struct mm_struct *oom_kill_task(task_t *p)
+static struct mm_struct *oom_kill_task(task_t *p, const char *message)
 {
 	struct mm_struct *mm = get_task_mm(p);
 	task_t * g, * q;
@@ -224,20 +254,20 @@ static struct mm_struct *oom_kill_task(t
 		return NULL;
 	}
 
-	__oom_kill_task(p);
+	__oom_kill_task(p, message);
 	/*
 	 * kill all processes that share the ->mm (i.e. all threads),
 	 * but are in a different thread group
 	 */
 	do_each_thread(g, q)
 		if (q->mm == mm && q->tgid != p->tgid)
-			__oom_kill_task(q);
+			__oom_kill_task(q, message);
 	while_each_thread(g, q);
 
 	return mm;
 }
 
-static struct mm_struct *oom_kill_process(struct task_struct *p)
+static struct mm_struct *oom_kill_process(struct task_struct *p, const char *message)
 {
  	struct mm_struct *mm;
 	struct task_struct *c;
@@ -248,11 +278,11 @@ static struct mm_struct *oom_kill_proces
 		c = list_entry(tsk, struct task_struct, sibling);
 		if (c->mm == p->mm)
 			continue;
-		mm = oom_kill_task(c);
+		mm = oom_kill_task(c, message);
 		if (mm)
 			return mm;
 	}
-	return oom_kill_task(p);
+	return oom_kill_task(p, message);
 }
 
 /**
@@ -263,7 +293,7 @@ static struct mm_struct *oom_kill_proces
  * OR try to be smart about which process to kill. Note that we
  * don't have to be perfect here, we just have to be good.
  */
-void out_of_memory(gfp_t gfp_mask, int order)
+void out_of_memory(struct zonelist *zonelist, gfp_t gfp_mask, int order)
 {
 	struct mm_struct *mm = NULL;
 	task_t * p;
@@ -277,24 +307,50 @@ void out_of_memory(gfp_t gfp_mask, int o
 
 	cpuset_lock();
 	read_lock(&tasklist_lock);
+
+	/*
+	 * Check if there were limitations on the allocation (only relevant for
+	 * NUMA) that may require different handling.
+	 */
+	switch (constrained_alloc(zonelist, gfp_mask)) {
+
+	case CONSTRAINT_MEMORY_POLICY :
+
+		mm = oom_kill_process(current, "No available memory (MPOL_BIND)");
+		break;
+
+	case CONSTRAINT_CPUSET :
+
+		mm = oom_kill_process(current, "No available memory in cpuset");
+		break;
+
+	case CONSTRAINT_NONE:
+
 retry:
-	p = select_bad_process();
+		/*
+		 * Rambo mode: Shoot down a process and hope it solves whatever
+		 * issues we may have.
+		 */
+		p = select_bad_process();
 
-	if (PTR_ERR(p) == -1UL)
-		goto out;
+		if (PTR_ERR(p) == -1UL)
+			goto out;
 
-	/* Found nothing?!?! Either we hang forever, or we panic. */
-	if (!p) {
-		read_unlock(&tasklist_lock);
-		cpuset_unlock();
-		panic("Out of memory and no killable processes...\n");
-	}
+		/* Found nothing?!?! Either we hang forever, or we panic. */
+		if (!p) {
+			read_unlock(&tasklist_lock);
+			cpuset_unlock();
+			panic("Out of memory and no killable processes...\n");
+		}
 
-	mm = oom_kill_process(p);
-	if (!mm)
-		goto retry;
+		mm = oom_kill_process(p, "Out of Memory");
+		if (!mm)
+			goto retry;
+
+		break;
+	}
 
- out:
+out:
 	read_unlock(&tasklist_lock);
 	cpuset_unlock();
 	if (mm)
Index: linux-2.6.16-rc2/include/linux/swap.h
===================================================================
--- linux-2.6.16-rc2.orig/include/linux/swap.h	2006-02-02 22:03:08.000000000 -0800
+++ linux-2.6.16-rc2/include/linux/swap.h	2006-02-09 10:40:33.000000000 -0800
@@ -147,7 +147,7 @@ struct swap_list_t {
 #define vm_swap_full() (nr_swap_pages*2 < total_swap_pages)
 
 /* linux/mm/oom_kill.c */
-extern void out_of_memory(gfp_t gfp_mask, int order);
+extern void out_of_memory(struct zonelist *zonelist, gfp_t gfp_mask, int order);
 
 /* linux/mm/memory.c */
 extern void swapin_readahead(swp_entry_t, unsigned long, struct vm_area_struct *);
Index: linux-2.6.16-rc2/mm/page_alloc.c
===================================================================
--- linux-2.6.16-rc2.orig/mm/page_alloc.c	2006-02-02 22:03:08.000000000 -0800
+++ linux-2.6.16-rc2/mm/page_alloc.c	2006-02-09 10:40:50.000000000 -0800
@@ -1011,7 +1011,7 @@ rebalance:
 		if (page)
 			goto got_pg;
 
-		out_of_memory(gfp_mask, order);
+		out_of_memory(zonelist, gfp_mask, order);
 		goto restart;
 	}
 
Index: linux-2.6.16-rc2/drivers/char/sysrq.c
===================================================================
--- linux-2.6.16-rc2.orig/drivers/char/sysrq.c	2006-02-02 22:03:08.000000000 -0800
+++ linux-2.6.16-rc2/drivers/char/sysrq.c	2006-02-09 11:34:42.000000000 -0800
@@ -243,7 +243,7 @@ static struct sysrq_key_op sysrq_term_op
 
 static void moom_callback(void *ignored)
 {
-	out_of_memory(GFP_KERNEL, 0);
+	out_of_memory(&NODE_DATA(0)->node_zonelists[ZONE_NORMAL], GFP_KERNEL, 0);
 }
 
 static DECLARE_WORK(moom_work, moom_callback, NULL);
