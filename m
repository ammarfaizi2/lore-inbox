Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030449AbWBHSyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030449AbWBHSyl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 13:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030463AbWBHSyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 13:54:41 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:2257 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030449AbWBHSyk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 13:54:40 -0500
Date: Wed, 8 Feb 2006 10:54:31 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Paul Jackson <pj@sgi.com>
cc: Andi Kleen <ak@suse.de>, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Terminate process that fails on a constrained allocation
In-Reply-To: <20060208103448.588fdfa7.pj@sgi.com>
Message-ID: <Pine.LNX.4.62.0602081053260.3590@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0602081004060.2648@schroedinger.engr.sgi.com>
 <200602081914.00231.ak@suse.de> <20060208103448.588fdfa7.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Feb 2006, Paul Jackson wrote:

> good idea.

Ok. Here is V2:

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
+++ linux-2.6.16-rc2/mm/page_alloc.c	2006-02-08 10:53:08.000000000 -0800
@@ -817,6 +818,27 @@ failed:
 #define ALLOC_CPUSET		0x40 /* check for correct cpuset */
 
 /*
+ * check if a given zonelist allows allocation over all the nodes
+ * in the system.
+ */
+int zonelist_incomplete(struct zonelist *zonelist, gfp_t gfp_mask)
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
@@ -1011,6 +1033,9 @@ rebalance:
 		if (page)
 			goto got_pg;
 
+		if (zonelist_incomplete(zonelist, gfp_mask))
+			return NULL;
+
 		out_of_memory(gfp_mask, order);
 		goto restart;
 	}
