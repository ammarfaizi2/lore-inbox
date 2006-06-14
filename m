Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964864AbWFNBId@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964864AbWFNBId (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 21:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964854AbWFNBIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 21:08:12 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:712 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964848AbWFNBDc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 21:03:32 -0400
Date: Tue, 13 Jun 2006 18:03:24 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Con Kolivas <kernel@kolivas.org>,
       Christoph Lameter <clameter@sgi.com>, Dave Chinner <dgc@sgi.com>
Message-Id: <20060614010324.859.23215.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060614010238.859.4228.sendpatchset@schroedinger.engr.sgi.com>
References: <20060614010238.859.4228.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 09/21] zone_reclaim: remove /proc/sys/vm/zone_reclaim_interval
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: zoned vm counters: use per zone counters to remove zone_reclaim_interval
From: Christoph Lameter <clameter@sgi.com>

The zone_reclaim_interval was necessary because we were not able to determine
how many unmapped pages exist in a zone.  Therefore we had to scan in
intervals to figure out if any pages were unmapped.

With the zoned counters and NR_ANON we now know the number of pagecache pages
and the number of mapped pages in a zone. So we can simply skip the reclaim
if there is an insufficient number of unmapped pages. We use SWAP_CLUSTER_MAX
as the boundary.

Drop all support for /proc/sys/vm/zone_reclaim_interval.

Signed-off-by: Christoph Lameter <clameter@sgi.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>

Index: linux-2.6.17-rc6-cl/include/linux/mmzone.h
===================================================================
--- linux-2.6.17-rc6-cl.orig/include/linux/mmzone.h	2006-06-13 10:17:44.987532146 -0700
+++ linux-2.6.17-rc6-cl/include/linux/mmzone.h	2006-06-13 10:17:47.544991113 -0700
@@ -183,12 +183,6 @@ struct zone {
 
 	/* Zone statistics */
 	atomic_long_t		vm_stat[NR_VM_ZONE_STAT_ITEMS];
-	/*
-	 * timestamp (in jiffies) of the last zone reclaim that did not
-	 * result in freeing of pages. This is used to avoid repeated scans
-	 * if all memory in the zone is in use.
-	 */
-	unsigned long		last_unsuccessful_zone_reclaim;
 
 	/*
 	 * prev_priority holds the scanning priority for this zone.  It is
Index: linux-2.6.17-rc6-cl/include/linux/swap.h
===================================================================
--- linux-2.6.17-rc6-cl.orig/include/linux/swap.h	2006-06-12 12:42:51.046775908 -0700
+++ linux-2.6.17-rc6-cl/include/linux/swap.h	2006-06-13 10:17:47.555732636 -0700
@@ -190,7 +190,6 @@ extern long vm_total_pages;
 
 #ifdef CONFIG_NUMA
 extern int zone_reclaim_mode;
-extern int zone_reclaim_interval;
 extern int zone_reclaim(struct zone *, gfp_t, unsigned int);
 #else
 #define zone_reclaim_mode 0
Index: linux-2.6.17-rc6-cl/include/linux/sysctl.h
===================================================================
--- linux-2.6.17-rc6-cl.orig/include/linux/sysctl.h	2006-06-12 12:42:51.074117966 -0700
+++ linux-2.6.17-rc6-cl/include/linux/sysctl.h	2006-06-13 10:17:47.566474159 -0700
@@ -191,7 +191,6 @@ enum
 	VM_DROP_PAGECACHE=29,	/* int: nuke lots of pagecache */
 	VM_PERCPU_PAGELIST_FRACTION=30,/* int: fraction of pages in each percpu_pagelist */
 	VM_ZONE_RECLAIM_MODE=31, /* reclaim local zone memory before going off node */
-	VM_ZONE_RECLAIM_INTERVAL=32, /* time period to wait after reclaim failure */
 	VM_PANIC_ON_OOM=33,	/* panic at out-of-memory */
 	VM_VDSO_ENABLED=34,	/* map VDSO into new processes? */
 	VM_SWAP_PREFETCH=35,	/* swap prefetch */
Index: linux-2.6.17-rc6-cl/kernel/sysctl.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/kernel/sysctl.c	2006-06-12 12:42:51.948087320 -0700
+++ linux-2.6.17-rc6-cl/kernel/sysctl.c	2006-06-13 10:17:47.586980703 -0700
@@ -1015,15 +1015,6 @@ static ctl_table vm_table[] = {
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
Index: linux-2.6.17-rc6-cl/mm/vmscan.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/mm/vmscan.c	2006-06-13 10:17:44.989485150 -0700
+++ linux-2.6.17-rc6-cl/mm/vmscan.c	2006-06-13 10:17:47.588933707 -0700
@@ -1529,11 +1529,6 @@ int zone_reclaim_mode __read_mostly;
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
@@ -1598,16 +1593,6 @@ static int __zone_reclaim(struct zone *z
 
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
 
@@ -1617,13 +1602,17 @@ int zone_reclaim(struct zone *zone, gfp_
 	int node_id;
 
 	/*
-	 * Do not reclaim if there was a recent unsuccessful attempt at zone
-	 * reclaim.  In that case we let allocations go off node for the
-	 * zone_reclaim_interval.  Otherwise we would scan for each off-node
-	 * page allocation.
+	 * Do not reclaim if there are not enough reclaimable pages in this
+	 * zone that would satify this allocations.
+	 *
+	 * All unmapped pagecache pages are reclaimable.
+	 *
+	 * Both counters may be temporarily off a bit so we use
+	 * SWAP_CLUSTER_MAX as the boundary. It may also be good to
+	 * leave a few frequently used unmapped pagecache pages around.
 	 */
-	if (time_before(jiffies,
-		zone->last_unsuccessful_zone_reclaim + zone_reclaim_interval))
+	if (zone_page_state(zone, NR_PAGECACHE) -
+		zone_page_state(zone, NR_MAPPED) < SWAP_CLUSTER_MAX)
 			return 0;
 
 	/*
Index: linux-2.6.17-rc6-cl/Documentation/sysctl/vm.txt
===================================================================
--- linux-2.6.17-rc6-cl.orig/Documentation/sysctl/vm.txt	2006-06-12 12:42:42.519959822 -0700
+++ linux-2.6.17-rc6-cl/Documentation/sysctl/vm.txt	2006-06-13 10:17:47.614322761 -0700
@@ -28,7 +28,6 @@ Currently, these files are in /proc/sys/
 - block_dump
 - drop-caches
 - zone_reclaim_mode
-- zone_reclaim_interval
 - panic_on_oom
 - swap_prefetch
 - readahead_ratio
@@ -172,18 +171,6 @@ in all nodes of the system.
 
 ================================================================
 
-zone_reclaim_interval:
-
-The time allowed for off node allocations after zone reclaim
-has failed to reclaim enough pages to allow a local allocation.
-
-Time is set in seconds and set by default to 30 seconds.
-
-Reduce the interval if undesired off node allocations occur. However, too
-frequent scans will have a negative impact onoff node allocation performance.
-
-=============================================================
-
 panic_on_oom
 
 This enables or disables panic on out-of-memory feature.  If this is set to 1,
