Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267169AbUBMShW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 13:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267167AbUBMSee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 13:34:34 -0500
Received: from galileo.bork.org ([66.11.174.156]:43464 "HELO galileo.bork.org")
	by vger.kernel.org with SMTP id S267169AbUBMSco (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 13:32:44 -0500
Date: Fri, 13 Feb 2004 13:32:43 -0500
From: Martin Hicks <mort@wildopensource.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] __alloc_pages - NUMA and lower zone protection
Message-ID: <20040213183243.GH12142@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="IihjUyvzd0n5Ehsu"
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IihjUyvzd0n5Ehsu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi,

There is a problem with the current __alloc pages on a machine with many
nodes.  As we go down the zones[] list, we may move onto other nodes.
Each time we go to the next zone we protect these zones by doing
"min += local_low".

This is quite appropriate on a machine with one node, but wrong on
machines with other nodes.  To illustrate, here is an example.  On a
256 node Altix machine, a request on node 0 for 2MB requires just over
600MB of free memory on the 256th node in order to fullfil the "min"
requirements if all other nodes are low on memory.  This could leave
73GB of memory unallocated across all nodes.

This patch keeps the same semantics for lower_zone_protection, but only
provides protection for higher priority zones in the same node.

The patch seems to do the right thing on my non-NUMA zx1 ia64 machine
(which has ZONE_DMA and ZONE_NORMAL) as well as the multi-node Altix.

thanks
mh

-- 
Martin Hicks                Wild Open Source Inc.
mort@wildopensource.com     613-266-2296

--IihjUyvzd0n5Ehsu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="page_alloc-6.patch"

===== include/linux/mmzone.h 1.51 vs edited =====
--- 1.51/include/linux/mmzone.h	Wed Feb  4 00:35:17 2004
+++ edited/include/linux/mmzone.h	Wed Feb 11 15:17:40 2004
@@ -70,6 +70,7 @@
 	spinlock_t		lock;
 	unsigned long		free_pages;
 	unsigned long		pages_min, pages_low, pages_high;
+	unsigned long		zone_type;
 
 	ZONE_PADDING(_pad1_)
 
===== mm/page_alloc.c 1.184 vs edited =====
--- 1.184/mm/page_alloc.c	Wed Feb  4 00:35:18 2004
+++ edited/mm/page_alloc.c	Wed Feb 11 15:48:43 2004
@@ -41,6 +41,7 @@
 int nr_swap_pages;
 int numnodes = 1;
 int sysctl_lower_zone_protection = 0;
+static int max_zone;	/* Highest zone number that contains pages */
 
 EXPORT_SYMBOL(totalram_pages);
 EXPORT_SYMBOL(nr_swap_pages);
@@ -557,27 +558,24 @@
 		return NULL;
 
 	/* Go through the zonelist once, looking for a zone with enough free */
-	min = 1UL << order;
 	for (i = 0; zones[i] != NULL; i++) {
 		struct zone *z = zones[i];
-		unsigned long local_low;
+		unsigned long local_low = z->pages_low;
 
 		/*
 		 * This is the fabled 'incremental min'. We let real-time tasks
 		 * dip their real-time paws a little deeper into reserves.
 		 */
-		local_low = z->pages_low;
 		if (rt_task(p))
 			local_low >>= 1;
-		min += local_low;
-
+		min = (1UL << order) + local_low;
+		min += local_low * sysctl_lower_zone_protection * (max_zone - z->zone_type);
 		if (z->free_pages >= min ||
 				(!wait && z->free_pages >= z->pages_high)) {
 			page = buffered_rmqueue(z, order, cold);
 			if (page)
-		       		goto got_pg;
+				goto got_pg;
 		}
-		min += z->pages_low * sysctl_lower_zone_protection;
 	}
 
 	/* we're somewhat low on memory, failed to find what we needed */
@@ -585,24 +583,23 @@
 		wakeup_kswapd(zones[i]);
 
 	/* Go through the zonelist again, taking __GFP_HIGH into account */
-	min = 1UL << order;
 	for (i = 0; zones[i] != NULL; i++) {
-		unsigned long local_min;
 		struct zone *z = zones[i];
+		unsigned long local_min = z->pages_min;
 
-		local_min = z->pages_min;
 		if (gfp_mask & __GFP_HIGH)
 			local_min >>= 2;
 		if (rt_task(p))
 			local_min >>= 1;
-		min += local_min;
+		min = (1UL << order) + local_min;
+		min += local_min * sysctl_lower_zone_protection * (max_zone - z->zone_type);
+
 		if (z->free_pages >= min ||
 				(!wait && z->free_pages >= z->pages_high)) {
 			page = buffered_rmqueue(z, order, cold);
 			if (page)
 				goto got_pg;
 		}
-		min += local_min * sysctl_lower_zone_protection;
 	}
 
 	/* here we're in the low on memory slow path */
@@ -634,18 +631,17 @@
 	p->flags &= ~PF_MEMALLOC;
 
 	/* go through the zonelist yet one more time */
-	min = 1UL << order;
 	for (i = 0; zones[i] != NULL; i++) {
 		struct zone *z = zones[i];
 
-		min += z->pages_min;
+		min = (1UL << order) + z->pages_min;
+		min += z->pages_min * sysctl_lower_zone_protection * (max_zone - z->zone_type);
 		if (z->free_pages >= min ||
 				(!wait && z->free_pages >= z->pages_high)) {
 			page = buffered_rmqueue(z, order, cold);
 			if (page)
 				goto got_pg;
 		}
-		min += z->pages_low * sysctl_lower_zone_protection;
 	}
 
 	/*
@@ -1107,7 +1103,11 @@
  			j = build_zonelists_node(NODE_DATA(node), zonelist, j, k);
  
 		zonelist->zones[j++] = NULL;
-	} 
+
+		if (pgdat->node_zones[i].present_pages > 0)
+			if (i > max_zone)
+				max_zone = i;
+       }
 }
 
 void __init build_all_zonelists(void)
@@ -1246,6 +1246,7 @@
 		spin_lock_init(&zone->lru_lock);
 		zone->zone_pgdat = pgdat;
 		zone->free_pages = 0;
+		zone->zone_type = j;
 
 		zone->temp_priority = zone->prev_priority = DEF_PRIORITY;
 

--IihjUyvzd0n5Ehsu--
