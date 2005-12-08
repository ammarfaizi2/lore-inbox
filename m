Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932365AbVLHUhq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbVLHUhq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 15:37:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbVLHUhp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 15:37:45 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:42634 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932350AbVLHUho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 15:37:44 -0500
Date: Thu, 8 Dec 2005 12:37:17 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: Christoph Hellwig <hch@infradead.org>, linux-ia64@vger.kernel.org,
       steiner@sgi.com, linux-kernel@vger.kernel.org, ak@suse.de,
       Wu Fengguang <wfg@mail.ustc.edu.cn>,
       Christoph Lameter <clameter@sgi.com>
Message-Id: <20051208203717.30456.17434.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20051208203707.30456.57439.sendpatchset@schroedinger.engr.sgi.com>
References: <20051208203707.30456.57439.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 3/3] Zone reclaim V3: Frequency of failed reclaim attempts
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce frequency of unsuccessful zone reclaim attempts

It is unlikely that zone reclaim is successful once it has failed. The
performance of the page allocator will sink signficantly for off-node
allocation if every page allocation attempt first requires a zone reclaim
scan to establish that no local memory is availale.

This patch limits the number of unsuccessful zone reclaim attempts to one
per tick by remembering the last time a zone reclaim failed on a zone.

Note that this approach may be avoided once we have per zone statistics
on the number of unmapped (==easily reclaimable) pages. I am working on
a statistics patch that may allow keeping track of unmapped pages per
zone. A check of that number may then allow an easy determination if it
makes sense to run zone reclaim.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.15-rc4/mm/vmscan.c
===================================================================
--- linux-2.6.15-rc4.orig/mm/vmscan.c	2005-12-08 11:10:14.000000000 -0800
+++ linux-2.6.15-rc4/mm/vmscan.c	2005-12-08 12:04:38.000000000 -0800
@@ -1379,6 +1379,16 @@ int zone_reclaim(struct zone *zone, gfp_
 	    atomic_read(&zone->reclaim_in_progress) > 0)
 		return 0;
 
+	/*
+	 * If an unsuccessful zone reclaim occurred in this tick then we
+	 * already needed to go off before. Our local purity is already
+	 * tainted and its likely that the scan for easily reclaimable pages
+	 * will be a waste of time. Continue off node allocations for the
+	 * duration of this tick.
+	 */
+	if (zone->last_unsuccessful_zone_reclaim == get_jiffies_64())
+		return 0;
+
 	sc.gfp_mask = gfp_mask;
 	sc.may_writepage = 0;
 	sc.may_swap = 0;
@@ -1397,6 +1407,8 @@ int zone_reclaim(struct zone *zone, gfp_
 	shrink_zone(zone, &sc);
 	p->reclaim_state = NULL;
 	current->flags &= ~PF_MEMALLOC;
+	if (sc.nr_reclaimed == 0)
+		zone->last_unsuccessful_zone_reclaim = get_jiffies_64();
 	cond_resched();
 	return sc.nr_reclaimed >= (1 << order);
 }
Index: linux-2.6.15-rc4/include/linux/mmzone.h
===================================================================
--- linux-2.6.15-rc4.orig/include/linux/mmzone.h	2005-12-08 11:10:14.000000000 -0800
+++ linux-2.6.15-rc4/include/linux/mmzone.h	2005-12-08 12:00:43.000000000 -0800
@@ -153,6 +153,8 @@ struct zone {
 	/* A count of how many reclaimers are scanning this zone */
 	atomic_t		reclaim_in_progress;
 
+	unsigned long		last_unsuccessful_zone_reclaim;
+
 	/*
 	 * prev_priority holds the scanning priority for this zone.  It is
 	 * defined as the scanning priority at which we achieved our reclaim
