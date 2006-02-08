Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932425AbWBHTP7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932425AbWBHTP7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 14:15:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbWBHTP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 14:15:58 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:26529 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932425AbWBHTP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 14:15:58 -0500
Date: Wed, 8 Feb 2006 11:15:45 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andi Kleen <ak@suse.de>
cc: Paul Jackson <pj@sgi.com>, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Terminate process that fails on a constrained allocation
In-Reply-To: <200602082001.36236.ak@suse.de>
Message-ID: <Pine.LNX.4.62.0602081114490.3721@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0602081004060.2648@schroedinger.engr.sgi.com>
 <20060208103448.588fdfa7.pj@sgi.com> <Pine.LNX.4.62.0602081053260.3590@schroedinger.engr.sgi.com>
 <200602082001.36236.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Feb 2006, Andi Kleen wrote:

> static noinline

Next rev:

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

This patch adds a check before the out of memory killer is invoked. At that
point performance considerations do not matter much so we just scan the zonelist
and reconstruct a list of nodes. If the list of nodes does not contain all
online nodes then this is a constrained allocation and we should not calle
the OOM killer.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.16-rc2/mm/page_alloc.c
===================================================================
--- linux-2.6.16-rc2.orig/mm/page_alloc.c	2006-02-02 22:03:08.000000000 -0800
+++ linux-2.6.16-rc2/mm/page_alloc.c	2006-02-08 11:14:32.000000000 -0800
@@ -612,6 +612,7 @@ void drain_remote_pages(void)
 	}
 	local_irq_restore(flags);
 }
+
 #endif
 
 #if defined(CONFIG_PM) || defined(CONFIG_HOTPLUG_CPU)
@@ -817,6 +818,27 @@ failed:
 #define ALLOC_CPUSET		0x40 /* check for correct cpuset */
 
 /*
+ * Check if a given zonelist is complete and allows allocation over all 
+ * the nodes in the system.
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
  * Return 1 if free pages are above 'mark'. This takes into account the order
  * of the allocation.
  */
@@ -1011,6 +1033,15 @@ rebalance:
 		if (page)
 			goto got_pg;
 
+		/*
+		 * If we allocated using a zonelist that does not include
+		 * all nodes in the system then the OOM situation may be
+		 * due to configured limitations. Just abort the application
+		 * instead of calling the OOM killer.
+		 */
+		if (zonelist_incomplete(zonelist, gfp_mask))
+			return NULL;
+
 		out_of_memory(gfp_mask, order);
 		goto restart;
 	}
