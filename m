Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030338AbWBHSF6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030338AbWBHSF6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 13:05:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030350AbWBHSF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 13:05:58 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:46746 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030338AbWBHSF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 13:05:58 -0500
Date: Wed, 8 Feb 2006 10:05:51 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: akpm@osdl.org
cc: pj@sgi.com, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Terminate process that fails on a constrained allocation
Message-ID: <Pine.LNX.4.62.0602081004060.2648@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
to what we do when we run out of hugepages.

This patch adds a check before the out of memory killer is invoked. At that
point performance considerations do not matter much so we just scan the zonelist
and reconstruct a list of nodes. If the list of nodes does not contain all
online nodes then this is a constrained allocation and we should not call
the OOM killer.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.16-rc2/mm/page_alloc.c
===================================================================
--- linux-2.6.16-rc2.orig/mm/page_alloc.c	2006-02-02 22:03:08.000000000 -0800
+++ linux-2.6.16-rc2/mm/page_alloc.c	2006-02-08 09:55:21.000000000 -0800
@@ -1011,6 +1011,28 @@ rebalance:
 		if (page)
 			goto got_pg;
 
+#ifdef CONFIG_NUMA
+		/*
+		 * In the NUMA case we may have gotten here because the
+		 * memory policies or cpusets have restricted the allocation.
+		 */
+		{
+			nodemask_t nodes;
+
+			nodes_empty(nodes);
+			for (z = zonelist->zones; *z; z++)
+				if (cpuset_zone_allowed(*z, gfp_mask))
+					node_set((*z)->zone_pgdat->node_id,
+							nodes);
+			/*
+			 * If we were only allowed to allocate from
+			 * a subset of nodes then terminate the process.
+			 */
+			if (!nodes_subset(node_online_map, nodes))
+				return NULL;
+		}
+#endif
+
 		out_of_memory(gfp_mask, order);
 		goto restart;
 	}
