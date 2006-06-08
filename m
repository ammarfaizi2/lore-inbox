Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965059AbWFHXDS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965059AbWFHXDS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 19:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965058AbWFHXDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 19:03:18 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:48353 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S965060AbWFHXDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 19:03:15 -0400
Date: Thu, 8 Jun 2006 16:03:05 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Hugh Dickins <hugh@veritas.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       Andi Kleen <ak@suse.de>, Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Christoph Lameter <clameter@sgi.com>
Message-Id: <20060608230305.25121.97821.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060608230239.25121.83503.sendpatchset@schroedinger.engr.sgi.com>
References: <20060608230239.25121.83503.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 04/14] Use per zone counters to remove zone_reclaim_interval
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use zoned counters to remove zone_reclaim_interval

The zone_reclaim_interval was necessary because we were not able to determine
how many unmapped pages exist in a zone. Therefore we had to scan in intervals
to figure out if any additional unmapped pages are created.

With the zoned counters we know now the number of pagecache pages
and the number of mapped pages in a zone. So we are able to
establish the number of unmapped pages.

Caveat: The number of mapped pages includes anonymous pages.
The current check works but is a bit too cautious. We could perform
zone reclaim down to the last unmapped page if we would split NR_MAPPED
into NR_MAPPED_PAGECACHE and NR_MAPPED_ANON. Maybe later.

Drop all support for zone_reclaim_interval.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17-rc6-mm1/include/linux/swap.h
===================================================================
--- linux-2.6.17-rc6-mm1.orig/include/linux/swap.h	2006-06-07 22:11:37.574190076 -0700
+++ linux-2.6.17-rc6-mm1/include/linux/swap.h	2006-06-07 22:17:53.246235576 -0700
@@ -190,7 +190,6 @@ extern long vm_total_pages;
 
 #ifdef CONFIG_NUMA
 extern int zone_reclaim_mode;
-extern int zone_reclaim_interval;
 extern int zone_reclaim(struct zone *, gfp_t, unsigned int);
 #else
 #define zone_reclaim_mode 0
Index: linux-2.6.17-rc6-mm1/mm/vmscan.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/mm/vmscan.c	2006-06-07 22:11:57.798523443 -0700
+++ linux-2.6.17-rc6-mm1/mm/vmscan.c	2006-06-07 22:22:04.724800800 -0700
@@ -1534,11 +1534,6 @@ int zone_reclaim_mode __read_mostly;
 #define RECLAIM_SLAB (1<<3)	/* Do a global slab shrink if the zone is out of memory */
 
 /*
- * Mininum time between zone reclaim scans
- */
-int zone_reclaim_interval __read_mostly = 30*HZ;
-
-/*
  * Priority for ZONE_RECLAIM. This determines the fraction of pages
  * of a node considered for each zone_reclaim. 4 scans 1/16th of
  * a zone.
@@ -1604,16 +1599,6 @@ static int __zone_reclaim(struct zone *z
 
 	p->reclaim_state = NULL;
 	current->flags &= ~(PF_MEMALLOC | PF_SWAPWRITE);
-
-	if (nr_reclaimed == 0) {
-		/*
-		 * We were unable to reclaim enough pages to stay on node.  We
-		 * now allow off node accesses for a certain time period before
-		 * trying again to reclaim pages from the local zone.
-		 */
-		zone->last_unsuccessful_zone_reclaim = jiffies;
-	}
-
 	return nr_reclaimed >= nr_pages;
 }
 
@@ -1623,13 +1608,14 @@ int zone_reclaim(struct zone *zone, gfp_
 	int node_id;
 
 	/*
-	 * Do not reclaim if there was a recent unsuccessful attempt at zone
-	 * reclaim.  In that case we let allocations go off node for the
-	 * zone_reclaim_interval.  Otherwise we would scan for each off-node
-	 * page allocation.
+	 * Do not reclaim if there are not enough reclaimable pages in this
+	 * zone. We decide this based on the number of mapped pages
+	 * in relation to the number of page cache pages in this zone.
+	 * If there are more pagecache pages than mapped pages then we can
+	 * be certain that pages can be reclaimed.
 	 */
-	if (time_before(jiffies,
-		zone->last_unsuccessful_zone_reclaim + zone_reclaim_interval))
+	if (zone_page_state(zone, NR_PAGECACHE) <
+		zone_page_state(zone, NR_MAPPED))
 			return 0;
 
 	/*
Index: linux-2.6.17-rc6-mm1/kernel/sysctl.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/kernel/sysctl.c	2006-06-07 22:11:39.249867545 -0700
+++ linux-2.6.17-rc6-mm1/kernel/sysctl.c	2006-06-07 22:17:26.248884215 -0700
@@ -1027,15 +1027,6 @@ static ctl_table vm_table[] = {
 		.strategy	= &sysctl_intvec,
 		.extra1		= &zero,
 	},
-	{
-		.ctl_name	= VM_ZONE_RECLAIM_INTERVAL,
-		.procname	= "zone_reclaim_interval",
-		.data		= &zone_reclaim_interval,
-		.maxlen		= sizeof(zone_reclaim_interval),
-		.mode		= 0644,
-		.proc_handler	= &proc_dointvec_jiffies,
-		.strategy	= &sysctl_jiffies,
-	},
 #endif
 #ifdef CONFIG_X86_32
 	{
Index: linux-2.6.17-rc6-mm1/include/linux/sysctl.h
===================================================================
--- linux-2.6.17-rc6-mm1.orig/include/linux/sysctl.h	2006-06-07 22:11:37.606414643 -0700
+++ linux-2.6.17-rc6-mm1/include/linux/sysctl.h	2006-06-07 22:22:30.026944631 -0700
@@ -191,7 +191,6 @@ enum
 	VM_DROP_PAGECACHE=29,	/* int: nuke lots of pagecache */
 	VM_PERCPU_PAGELIST_FRACTION=30,/* int: fraction of pages in each percpu_pagelist */
 	VM_ZONE_RECLAIM_MODE=31, /* reclaim local zone memory before going off node */
-	VM_ZONE_RECLAIM_INTERVAL=32, /* time period to wait after reclaim failure */
 	VM_PANIC_ON_OOM=33,	/* panic at out-of-memory */
 	VM_VDSO_ENABLED=34,	/* map VDSO into new processes? */
 	VM_SWAP_PREFETCH=35,	/* swap prefetch */
Index: linux-2.6.17-rc6-mm1/include/linux/mmzone.h
===================================================================
--- linux-2.6.17-rc6-mm1.orig/include/linux/mmzone.h	2006-06-07 22:11:57.963552285 -0700
+++ linux-2.6.17-rc6-mm1/include/linux/mmzone.h	2006-06-07 22:16:48.392830386 -0700
@@ -192,12 +192,6 @@ struct zone {
 
 	/* Zone statistics */
 	vm_stat_t		vm_stat[NR_STAT_ITEMS];
-	/*
-	 * timestamp (in jiffies) of the last zone reclaim that did not
-	 * result in freeing of pages. This is used to avoid repeated scans
-	 * if all memory in the zone is in use.
-	 */
-	unsigned long		last_unsuccessful_zone_reclaim;
 
 	/*
 	 * prev_priority holds the scanning priority for this zone.  It is
