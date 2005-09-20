Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932769AbVITRXm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932769AbVITRXm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 13:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932772AbVITRXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 13:23:36 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:50641 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932769AbVITRXV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 13:23:21 -0400
Subject: [RFC][PATCH 4/4] unify both copies of build_zonelists()
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Tue, 20 Sep 2005 10:23:12 -0700
References: <20050920172303.8CD9190C@kernel.beaverton.ibm.com>
In-Reply-To: <20050920172303.8CD9190C@kernel.beaverton.ibm.com>
Message-Id: <20050920172312.24651DBA@kernel.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Once the last three patches are applied, find_next_best_node()
has three properties which make its behavior identical to the
way that the !NUMA build_zonelists() functions.

First, this code from build_zonelists():

	j = 0;
	k = zone_index_to_type(i);
	j = build_zonelists_node(pgdat, zonelist, j, k);
	
makes sure that the node for which we're building a zonelist is
first in that zone's list.  That is functionally equivalent to
this code in find_next_best_node():

	/* Use the local node if we haven't already */
	if (!node_isset(node, *used_node_mask)) {
		best_node = node;
		break;
	}

Next, the !NUMA build_zonelists() starts at the local node,
and searches all larger-numbered nodes, then searches all
nodes from 0 back up to the local node:

        for (node = local_node + 1; node < MAX_NUMNODES; node++) {
                if (!node_online(node))
          	     	continue;
        	j = build_zonelists_node(NODE_DATA(node), zonelist, j, k);
        }
        for (node = 0; node < local_node; node++) {
                if (!node_online(node))
                	continue;
                j = build_zonelists_node(NODE_DATA(node), zonelist, j, k);
        }

Instead of doing this explicitly, find_next_best_node()
uses a modulo but, again, the behavior is the same:

        /* Start from local node */
        n = (node+i) % num_online_nodes();

Lastly, "val" will be equivalent for each find_next_best_node() loop
iteration because:
1. node_distance() always return the same value (except when
   node == n, but that never happens because of the local node
   check above)
2. The 'if (!cpus_empty(tmp))' check will never succeed because
   the cpumask for !NUMA is cpu_online_map, which is never empty.
3. (MAX_NODE_LOAD*MAX_NUMNODES) == 1
4. get_node_load() == 0

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 memhotplug-dave/mm/page_alloc.c |   41 ----------------------------------------
 1 files changed, 41 deletions(-)

diff -puN mm/page_alloc.c~B1.3-build_zonelists_unification mm/page_alloc.c
--- memhotplug/mm/page_alloc.c~B1.3-build_zonelists_unification	2005-09-14 09:32:39.000000000 -0700
+++ memhotplug-dave/mm/page_alloc.c	2005-09-14 09:32:39.000000000 -0700
@@ -1577,47 +1577,6 @@ static void __init build_zonelists(pg_da
 	}
 }
 
-#else	/* CONFIG_NUMA */
-
-static void __init build_zonelists(pg_data_t *pgdat)
-{
-	int i, j, k, node, local_node;
-
-	local_node = pgdat->node_id;
-	for (i = 0; i < GFP_ZONETYPES; i++) {
-		struct zonelist *zonelist;
-
-		zonelist = pgdat->node_zonelists + i;
-
-		j = 0;
-		k = zone_index_to_type(i);
-
- 		j = build_zonelists_node(pgdat, zonelist, j, k);
- 		/*
- 		 * Now we build the zonelist so that it contains the zones
- 		 * of all the other nodes.
- 		 * We don't want to pressure a particular node, so when
- 		 * building the zones for node N, we make sure that the
- 		 * zones coming right after the local ones are those from
- 		 * node N+1 (modulo N)
- 		 */
-		for (node = local_node + 1; node < MAX_NUMNODES; node++) {
-			if (!node_online(node))
-				continue;
-			j = build_zonelists_node(NODE_DATA(node), zonelist, j, k);
-		}
-		for (node = 0; node < local_node; node++) {
-			if (!node_online(node))
-				continue;
-			j = build_zonelists_node(NODE_DATA(node), zonelist, j, k);
-		}
-
-		zonelist->zones[j] = NULL;
-	}
-}
-
-#endif	/* CONFIG_NUMA */
-
 void __init build_all_zonelists(void)
 {
 	int i;
diff -L b.txt -puN /dev/null /dev/null
_
