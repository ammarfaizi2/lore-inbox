Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264574AbUBNCSM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 21:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264583AbUBNCSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 21:18:12 -0500
Received: from galileo.bork.org ([66.11.174.156]:31949 "HELO galileo.bork.org")
	by vger.kernel.org with SMTP id S264574AbUBNCRu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 21:17:50 -0500
Date: Fri, 13 Feb 2004 21:17:49 -0500
From: Martin Hicks <mort@wildopensource.com>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] __alloc_pages - NUMA and lower zone protection
Message-ID: <20040214021749.GP12142@localhost>
References: <20040213183243.GH12142@localhost> <402D6544.2080300@cyberone.com.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="h5TCuzcqTWZxfGfk"
Content-Disposition: inline
In-Reply-To: <402D6544.2080300@cyberone.com.au>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--h5TCuzcqTWZxfGfk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



On Sat, Feb 14, 2004 at 11:01:08AM +1100, Nick Piggin wrote:
> 
> 
> Martin Hicks wrote:
> >
> >The patch seems to do the right thing on my non-NUMA zx1 ia64 machine
> >(which has ZONE_DMA and ZONE_NORMAL) as well as the multi-node Altix.
> >
> >
> 
> Could you add a comment or two, please?

Okay.  Same patch, with a comment.

mh

-- 
Martin Hicks                Wild Open Source Inc.
mort@wildopensource.com     613-266-2296

--h5TCuzcqTWZxfGfk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="page_alloc-numa.patch"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1631  -> 1.1632 
#	     mm/page_alloc.c	1.185   -> 1.186  
#	include/linux/mmzone.h	1.52    -> 1.53   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/02/13	mort@green.i.bork.org	1.1632
# Change incremental min in __alloc_pages to ensure that min
# doesn't increase across nodes.
# --------------------------------------------
#
diff -Nru a/include/linux/mmzone.h b/include/linux/mmzone.h
--- a/include/linux/mmzone.h	Fri Feb 13 21:13:56 2004
+++ b/include/linux/mmzone.h	Fri Feb 13 21:13:56 2004
@@ -70,6 +70,7 @@
 	spinlock_t		lock;
 	unsigned long		free_pages;
 	unsigned long		pages_min, pages_low, pages_high;
+	unsigned long		zone_type;
 
 	ZONE_PADDING(_pad1_)
 
diff -Nru a/mm/page_alloc.c b/mm/page_alloc.c
--- a/mm/page_alloc.c	Fri Feb 13 21:13:56 2004
+++ b/mm/page_alloc.c	Fri Feb 13 21:13:56 2004
@@ -41,6 +41,7 @@
 int nr_swap_pages;
 int numnodes = 1;
 int sysctl_lower_zone_protection = 0;
+static int max_zone;	/* Highest zone number that contains pages */
 
 EXPORT_SYMBOL(totalram_pages);
 EXPORT_SYMBOL(nr_swap_pages);
@@ -559,27 +560,26 @@
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
+		/* Reset min on each iteration so we don't accumulate
+		 * the min across multiple nodes */
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
@@ -587,24 +587,25 @@
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
+		/* Reset min on each iteration so we don't accumulate
+		 * the min across multiple nodes */
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
@@ -636,18 +637,19 @@
 	p->flags &= ~PF_MEMALLOC;
 
 	/* go through the zonelist yet one more time */
-	min = 1UL << order;
 	for (i = 0; zones[i] != NULL; i++) {
 		struct zone *z = zones[i];
 
-		min += z->pages_min;
+		/* Reset min on each iteration so we don't accumulate
+		 * the min across multiple nodes */
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
@@ -1115,7 +1117,11 @@
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
@@ -1258,6 +1264,7 @@
 		spin_lock_init(&zone->lru_lock);
 		zone->zone_pgdat = pgdat;
 		zone->free_pages = 0;
+		zone->zone_type = j;
 
 		zone->temp_priority = zone->prev_priority = DEF_PRIORITY;
 

--h5TCuzcqTWZxfGfk--
