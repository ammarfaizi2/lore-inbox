Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932126AbWKCU62@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbWKCU62 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 15:58:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbWKCU62
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 15:58:28 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:42707 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932126AbWKCU61 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 15:58:27 -0500
Date: Fri, 3 Nov 2006 12:58:24 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: Avoid allocating during interleave from almost full nodes
Message-ID: <Pine.LNX.4.64.0611031256190.15870@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Interleave allocation often go over large sets of nodes. Some nodes
may have tasks on them that heavily use memory and rely on node local
allocations to get optimium performance. Overallocating those nodes may
reduce performance of those tasks by forcing off node allocations and
additional reclaim passes. It is better if we try to avoid nodes
that have most of its memory used and focus on nodes that still have lots
of memory available.

The intend of interleave is to have allocations spread out over a set of
nodes because the data is likely to be used from any of those nodes. It is
not important that we keep the exact sequence of allocations at all times.

The exact node we choose during interleave does not matter much if we are
under memory pressure since the allocations will be redirected anyways
after we have overallocated a single node.

This patch checks for the amount of free pages on a node. If it is lower
than a predefined limit (in /proc/sys/kernel/min_interleave_ratio) then
we avoid allocating from that node. We keep a bitmap of full nodes
that is cleared every 2 seconds when draining the pagesets for
node 0.

Should we find that all nodes are marked as full then we disregard
the limit and continue allocate from the next node round robin
without any checks.

This is only effective for interleave pages that are placed without
regard to the address in a process (anonymous pages are typically
placed depending on an interleave node generated from the address).
It applies mainly to slab interleave and page cache interleave.

We operate on full_interleave_nodes without any locking which means
that the nodemask may take on an undefined value at times. That does
not matter though since we always can fall back to operating without
full_interleave_nodes. As a result of the racyness we may uselessly
skip a node or retest a node.

RFC: http://marc.theaimsgroup.com/?t=116200376700004&r=1&w=2

RFC->V2
- Rediff against 2.6.19-rc4-mm2
- Update description

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.19-rc4-mm2/Documentation/sysctl/vm.txt
===================================================================
--- linux-2.6.19-rc4-mm2.orig/Documentation/sysctl/vm.txt	2006-11-02 14:18:59.000000000 -0600
+++ linux-2.6.19-rc4-mm2/Documentation/sysctl/vm.txt	2006-11-03 13:12:04.006734590 -0600
@@ -198,6 +198,28 @@ and may not be fast.
 
 =============================================================
 
+min_interleave_ratio:
+
+This is available only on NUMA kernels.
+
+A percentage of the free pages in each zone.  If less than this
+percentage of pages are in use then interleave will attempt to
+leave this zone alone and allocate from other zones. This results
+in a balancing effect on the system if interleave and node local allocations
+are mixed throughout the system. Interleave pages will not cause zone
+reclaim and leave some memory on node to allow node local allocation to
+occur. Interleave allocations will allocate all over the system until global
+reclaim kicks in.
+
+The mininum does not apply to pages that are placed using interleave
+based on an address such as implemented for anonymous pages. It is
+effective for slab allocations, huge page allocations and page cache
+allocations.
+
+The default ratio is 10 percent.
+
+=============================================================
+
 panic_on_oom
 
 This enables or disables panic on out-of-memory feature.  If this is set to 1,
Index: linux-2.6.19-rc4-mm2/include/linux/mmzone.h
===================================================================
--- linux-2.6.19-rc4-mm2.orig/include/linux/mmzone.h	2006-11-02 14:19:34.000000000 -0600
+++ linux-2.6.19-rc4-mm2/include/linux/mmzone.h	2006-11-03 13:12:04.027244005 -0600
@@ -192,6 +192,12 @@ struct zone {
 	 */
 	unsigned long		min_unmapped_pages;
 	unsigned long		min_slab_pages;
+	/*
+	 * If a zone has less pages free then interleave will
+	 * attempt to bypass the zone
+	 */
+	unsigned long 		min_interleave_pages;
+
 	struct per_cpu_pageset	*pageset[NR_CPUS];
 #else
 	struct per_cpu_pageset	pageset[NR_CPUS];
@@ -564,6 +570,8 @@ int sysctl_min_unmapped_ratio_sysctl_han
 			struct file *, void __user *, size_t *, loff_t *);
 int sysctl_min_slab_ratio_sysctl_handler(struct ctl_table *, int,
 			struct file *, void __user *, size_t *, loff_t *);
+int sysctl_min_interleave_ratio_sysctl_handler(struct ctl_table *, int,
+			struct file *, void __user *, size_t *, loff_t *);
 
 #include <linux/topology.h>
 /* Returns the number of the current Node. */
Index: linux-2.6.19-rc4-mm2/include/linux/swap.h
===================================================================
--- linux-2.6.19-rc4-mm2.orig/include/linux/swap.h	2006-11-02 14:19:35.000000000 -0600
+++ linux-2.6.19-rc4-mm2/include/linux/swap.h	2006-11-03 13:12:04.049706697 -0600
@@ -197,6 +197,7 @@ extern long vm_total_pages;
 extern int zone_reclaim_mode;
 extern int sysctl_min_unmapped_ratio;
 extern int sysctl_min_slab_ratio;
+extern int sysctl_min_interleave_ratio;
 extern int zone_reclaim(struct zone *, gfp_t, unsigned int);
 #else
 #define zone_reclaim_mode 0
Index: linux-2.6.19-rc4-mm2/include/linux/sysctl.h
===================================================================
--- linux-2.6.19-rc4-mm2.orig/include/linux/sysctl.h	2006-11-02 14:19:35.000000000 -0600
+++ linux-2.6.19-rc4-mm2/include/linux/sysctl.h	2006-11-03 13:13:09.660305173 -0600
@@ -203,10 +203,11 @@ enum
 	VM_MIN_UNMAPPED=32,	/* Set min percent of unmapped pages */
 	VM_PANIC_ON_OOM=33,	/* panic at out-of-memory */
 	VM_VDSO_ENABLED=34,	/* map VDSO into new processes? */
-	VM_MIN_SLAB=35,		 /* Percent pages ignored by zone reclaim */
+	VM_MIN_SLAB=35,		/* Percent pages ignored by zone reclaim */
 	VM_SWAP_PREFETCH=36,	/* swap prefetch */
 	VM_READAHEAD_RATIO=37,	/* percent of read-ahead size to thrashing-threshold */
 	VM_READAHEAD_HIT_RATE=38, /* one accessed page legitimizes so many read-ahead pages */
+	VM_MIN_INTERLEAVE=39,	/* Limit for interleave */
 };
 
 
Index: linux-2.6.19-rc4-mm2/kernel/sysctl.c
===================================================================
--- linux-2.6.19-rc4-mm2.orig/kernel/sysctl.c	2006-11-02 14:19:36.000000000 -0600
+++ linux-2.6.19-rc4-mm2/kernel/sysctl.c	2006-11-03 13:12:04.102445192 -0600
@@ -1026,6 +1026,17 @@ static ctl_table vm_table[] = {
 		.extra1		= &zero,
 		.extra2		= &one_hundred,
 	},
+	{
+		.ctl_name	= VM_MIN_INTERLEAVE,
+		.procname	= "min_interleave_ratio",
+		.data		= &sysctl_min_interleave_ratio,
+		.maxlen		= sizeof(sysctl_min_interleave_ratio),
+		.mode		= 0644,
+		.proc_handler	= &sysctl_min_interleave_ratio_sysctl_handler,
+		.strategy	= &sysctl_intvec,
+		.extra1		= &zero,
+		.extra2		= &one_hundred,
+	},
 #endif
 #ifdef CONFIG_X86_32
 	{
Index: linux-2.6.19-rc4-mm2/mm/mempolicy.c
===================================================================
--- linux-2.6.19-rc4-mm2.orig/mm/mempolicy.c	2006-11-02 14:19:37.000000000 -0600
+++ linux-2.6.19-rc4-mm2/mm/mempolicy.c	2006-11-03 13:12:04.181552934 -0600
@@ -1118,16 +1118,60 @@ static struct zonelist *zonelist_policy(
 	return NODE_DATA(nd)->node_zonelists + gfp_zone(gfp);
 }
 
+/*
+ * Generic interleave function to be used by cpusets and memory policies.
+ */
+nodemask_t full_interleave_nodes = NODE_MASK_NONE;
+
+/*
+ * Called when draining the pagesets of node 0
+ */
+void clear_full_interleave_nodes(void) {
+	nodes_clear(full_interleave_nodes);
+}
+
+int __interleave(int current_node, nodemask_t *nodes)
+{
+	unsigned next;
+	struct zone *z;
+	nodemask_t nmask;
+
+redo:
+	nodes_andnot(nmask, *nodes, full_interleave_nodes);
+	if (unlikely(nodes_empty(nmask))) {
+		/*
+		 * All allowed nodes are overallocated.
+		 * Ignore interleave limit.
+		 */
+		next = next_node(current_node, *nodes);
+		if (next >= MAX_NUMNODES)
+			next = first_node(*nodes);
+		return next;
+	}
+
+	next = next_node(current_node, nmask);
+	if (next >= MAX_NUMNODES)
+		next = first_node(nmask);
+
+	/*
+	 * Check if node is overallocated. If so the set it to full.
+	 */
+	z = &NODE_DATA(next)->node_zones[policy_zone];
+	if (unlikely(z->free_pages <= z->min_interleave_pages)) {
+		node_set(next, full_interleave_nodes);
+		goto redo;
+	}
+	return next;
+}
+
 /* Do dynamic interleaving for a process */
-static unsigned interleave_nodes(struct mempolicy *policy)
+static int interleave_nodes(struct mempolicy *policy)
 {
 	unsigned nid, next;
 	struct task_struct *me = current;
 
 	nid = me->il_next;
-	next = next_node(nid, policy->v.nodes);
-	if (next >= MAX_NUMNODES)
-		next = first_node(policy->v.nodes);
+	next = __interleave(nid, &policy->v.nodes);
 	me->il_next = next;
 	return nid;
 }
Index: linux-2.6.19-rc4-mm2/mm/page_alloc.c
===================================================================
--- linux-2.6.19-rc4-mm2.orig/mm/page_alloc.c	2006-11-02 14:19:39.000000000 -0600
+++ linux-2.6.19-rc4-mm2/mm/page_alloc.c	2006-11-03 13:12:04.201085710 -0600
@@ -711,6 +711,8 @@ void drain_node_pages(int nodeid)
 			}
 		}
 	}
+	if (!nodeid)
+		clear_full_interleave_nodes();
 }
 #endif
 
@@ -2056,6 +2058,9 @@ static void setup_pagelist_highmark(stru
 
 
 #ifdef CONFIG_NUMA
+
+int sysctl_min_interleave_ratio = 10;
+
 /*
  * Boot pageset table. One per cpu which is going to be used for all
  * zones and all nodes. The parameters will be set in such a way
@@ -2651,6 +2656,7 @@ static void __meminit free_area_init_cor
 		zone->min_unmapped_pages = (realsize*sysctl_min_unmapped_ratio)
 						/ 100;
 		zone->min_slab_pages = (realsize * sysctl_min_slab_ratio) / 100;
+		zone->min_interleave_pages = (realsize + sysctl_min_interleave_ratio) / 100;
 #endif
 		zone->name = zone_names[j];
 		spin_lock_init(&zone->lock);
@@ -3226,6 +3232,21 @@ int sysctl_min_slab_ratio_sysctl_handler
 				sysctl_min_slab_ratio) / 100;
 	return 0;
 }
+int sysctl_min_interleave_ratio_sysctl_handler(ctl_table *table, int write,
+	struct file *file, void __user *buffer, size_t *length, loff_t *ppos)
+{
+	struct zone *zone;
+	int rc;
+
+	rc = proc_dointvec_minmax(table, write, file, buffer, length, ppos);
+	if (rc)
+		return rc;
+
+	for_each_zone(zone)
+		zone->min_interleave_pages = (zone->present_pages *
+				sysctl_min_interleave_ratio) / 100;
+	return 0;
+}
 #endif
 
 /*
Index: linux-2.6.19-rc4-mm2/include/linux/mempolicy.h
===================================================================
--- linux-2.6.19-rc4-mm2.orig/include/linux/mempolicy.h	2006-10-30 21:37:36.000000000 -0600
+++ linux-2.6.19-rc4-mm2/include/linux/mempolicy.h	2006-11-03 13:12:04.212805376 -0600
@@ -156,6 +156,8 @@ extern void mpol_fix_fork_child_flag(str
 #else
 #define current_cpuset_is_being_rebound() 0
 #endif
+extern int __interleave(int node, nodemask_t *nodes);
+extern void clear_full_interleave_nodes(void);
 
 extern struct mempolicy default_policy;
 extern struct zonelist *huge_zonelist(struct vm_area_struct *vma,
Index: linux-2.6.19-rc4-mm2/kernel/cpuset.c
===================================================================
--- linux-2.6.19-rc4-mm2.orig/kernel/cpuset.c	2006-11-02 14:19:36.000000000 -0600
+++ linux-2.6.19-rc4-mm2/kernel/cpuset.c	2006-11-03 13:12:04.228431596 -0600
@@ -2396,9 +2396,8 @@ int cpuset_mem_spread_node(void)
 {
 	int node;
 
-	node = next_node(current->cpuset_mem_spread_rotor, current->mems_allowed);
-	if (node == MAX_NUMNODES)
-		node = first_node(current->mems_allowed);
+	node = __interleave(current->cpuset_mem_spread_rotor,
+			&current->mems_allowed);
 	current->cpuset_mem_spread_rotor = node;
 	return node;
 }
