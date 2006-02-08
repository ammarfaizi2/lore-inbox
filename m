Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965227AbWBHWsY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965227AbWBHWsY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 17:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965228AbWBHWsY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 17:48:24 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:38303 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965227AbWBHWsY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 17:48:24 -0500
Date: Wed, 8 Feb 2006 14:48:15 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: Andi Kleen <ak@suse.de>, pj@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: Terminate process that fails on a constrained allocation
In-Reply-To: <Pine.LNX.4.62.0602081402310.4735@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.62.0602081446120.4895@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0602081004060.2648@schroedinger.engr.sgi.com>
 <200602082201.12371.ak@suse.de> <20060208130351.fc1c759c.pj@sgi.com>
 <200602082221.35671.ak@suse.de> <20060208133909.183f19ea.akpm@osdl.org>
 <Pine.LNX.4.62.0602081402310.4735@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cleaned up and tested version. Better comments and I forgot to modify 
drivers/char/sysrq.c:


Terminate process that fails on a constrained allocation

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
online nodes then this is a constrained allocation and we should not kill
processes but fail the allocation.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.16-rc2/mm/page_alloc.c
===================================================================
--- linux-2.6.16-rc2.orig/mm/page_alloc.c	2006-02-02 22:03:08.000000000 -0800
+++ linux-2.6.16-rc2/mm/page_alloc.c	2006-02-08 14:28:50.000000000 -0800
@@ -1011,8 +1011,10 @@ rebalance:
 		if (page)
 			goto got_pg;
 
-		out_of_memory(gfp_mask, order);
-		goto restart;
+		if (out_of_memory(zonelist, gfp_mask, order))
+			goto restart;
+
+		return NULL;
 	}
 
 	/*
Index: linux-2.6.16-rc2/include/linux/swap.h
===================================================================
--- linux-2.6.16-rc2.orig/include/linux/swap.h	2006-02-02 22:03:08.000000000 -0800
+++ linux-2.6.16-rc2/include/linux/swap.h	2006-02-08 14:28:50.000000000 -0800
@@ -147,7 +147,7 @@ struct swap_list_t {
 #define vm_swap_full() (nr_swap_pages*2 < total_swap_pages)
 
 /* linux/mm/oom_kill.c */
-extern void out_of_memory(gfp_t gfp_mask, int order);
+extern int out_of_memory(struct zonelist *zl, gfp_t gfp_mask, int order);
 
 /* linux/mm/memory.c */
 extern void swapin_readahead(swp_entry_t, unsigned long, struct vm_area_struct *);
Index: linux-2.6.16-rc2/mm/oom_kill.c
===================================================================
--- linux-2.6.16-rc2.orig/mm/oom_kill.c	2006-02-02 22:03:08.000000000 -0800
+++ linux-2.6.16-rc2/mm/oom_kill.c	2006-02-08 14:36:27.000000000 -0800
@@ -131,6 +131,27 @@ unsigned long badness(struct task_struct
 }
 
 /*
+ * check if a given zonelist allows allocation over all the nodes
+ * in the system.
+ */
+static noinline int zonelist_incomplete(struct zonelist *zonelist, gfp_t gfp_mask)
+{
+#ifdef CONFIG_NUMA
+	struct zone **z;
+	nodemask_t nodes;
+
+	nodes = node_online_map;
+	for (z = zonelist->zones; *z; z++)
+		if (cpuset_zone_allowed(*z, gfp_mask))
+			node_clear((*z)->zone_pgdat->node_id,
+					nodes);
+	return !nodes_empty(nodes);
+#else
+	return 0;
+#endif
+}
+
+/*
  * Simple selection loop. We chose the process with the highest
  * number of 'points'. We expect the caller will lock the tasklist.
  *
@@ -256,18 +277,33 @@ static struct mm_struct *oom_kill_proces
 }
 
 /**
- * oom_kill - kill the "best" process when we run out of memory
+ * out_of_memory - deal with out of memory situations
+ *
+ * If we are out of memory then check if this was due to the allocation
+ * being restricted to only a part of system memory. If so then
+ * fail the allocation.
  *
  * If we run out of memory, we have the choice between either
  * killing a random task (bad), letting the system crash (worse)
  * OR try to be smart about which process to kill. Note that we
  * don't have to be perfect here, we just have to be good.
+ *
+ * Returns 1 if the allocation should be retried.
+ *         0 if the allocation should fail.
  */
-void out_of_memory(gfp_t gfp_mask, int order)
+int out_of_memory(struct zonelist *zonelist, gfp_t gfp_mask, int order)
 {
 	struct mm_struct *mm = NULL;
 	task_t * p;
 
+	/*
+	 * Simply fail an allocation that does not allow
+	 * allocation on all nodes. We may want to have
+	 * more sophisticated logic here in the future.
+	 */
+	if (zonelist_incomplete(zonelist, gfp_mask))
+		return 0;
+
 	if (printk_ratelimit()) {
 		printk("oom-killer: gfp_mask=0x%x, order=%d\n",
 			gfp_mask, order);
@@ -306,4 +342,5 @@ retry:
 	 */
 	if (!test_thread_flag(TIF_MEMDIE))
 		schedule_timeout_interruptible(1);
+	return 1;
 }
Index: linux-2.6.16-rc2/drivers/char/sysrq.c
===================================================================
--- linux-2.6.16-rc2.orig/drivers/char/sysrq.c	2006-02-02 22:03:08.000000000 -0800
+++ linux-2.6.16-rc2/drivers/char/sysrq.c	2006-02-08 14:29:17.000000000 -0800
@@ -243,7 +243,7 @@ static struct sysrq_key_op sysrq_term_op
 
 static void moom_callback(void *ignored)
 {
-	out_of_memory(GFP_KERNEL, 0);
+	out_of_memory(&NODE_DATA(0)->node_zonelists[ZONE_NORMAL], GFP_KERNEL, 0);
 }
 
 static DECLARE_WORK(moom_work, moom_callback, NULL);
