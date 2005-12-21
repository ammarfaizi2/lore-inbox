Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751216AbVLUVIq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbVLUVIq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 16:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbVLUVIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 16:08:46 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:49127 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751216AbVLUVIp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 16:08:45 -0500
Date: Wed, 21 Dec 2005 13:08:33 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: steiner@sgi.com, ak@suse.de, Wu Fengguang <wfg@mail.ustc.edu.cn>,
       Christoph Lameter <clameter@sgi.com>, linux-mm@vger.kernel.org,
       Martin Hicks <mort@bork.org>
Message-Id: <20051221210833.3354.50872.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20051221210823.3354.53223.sendpatchset@schroedinger.engr.sgi.com>
References: <20051221210823.3354.53223.sendpatchset@schroedinger.engr.sgi.com>
Subject: Zone reclaim V4 [3/3]: Alternate logic without zoned counters
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce frequency of unsuccessful zone reclaim attempts

This is a fallback patch if zoned vm counters are not available. In that
case no check for reclaimable pages can be made before starting the scan.

The scan may have to occur for every off node allocation once the node
is full. In order to deal with that situation we note the last time a
scan has failed and only retry once per tick.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.15-rc5-mm2/mm/vmscan.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/mm/vmscan.c	2005-12-12 16:50:20.000000000 -0800
+++ linux-2.6.15-rc5-mm2/mm/vmscan.c	2005-12-12 16:50:21.000000000 -0800
@@ -1842,6 +1842,16 @@ int zone_reclaim(struct zone *zone, gfp_
 	    atomic_read(&zone->reclaim_in_progress) > 0)
 		return 0;
 
+	/*
+	 * If an unsuccessful zone reclaim occurred in this tick then we
+	 * already needed to go off before. Our local purity is already
+	 * tainted and its likely that the scan for easily reclaimable pages
+	 * will be a waste of time. Continue off node allocations for the
+	 * duration of this tick.
+	 */
+	if (zone->last_unsuccessful_zone_reclaim == jiffies)
+		return 0;
+
 	sc.gfp_mask = gfp_mask;
 	sc.may_writepage = 0;
 	sc.nr_mapped = read_page_state(nr_mapped);
@@ -1859,6 +1869,8 @@ int zone_reclaim(struct zone *zone, gfp_
 	shrink_zone(zone, &sc);
 	p->reclaim_state = NULL;
 	current->flags &= ~PF_MEMALLOC;
+	if (sc.nr_reclaimed == 0)
+		zone->last_unsuccessful_zone_reclaim = jiffies;
 	cond_resched();
 	return sc.nr_reclaimed >= (1 << order);
 }
Index: linux-2.6.15-rc5-mm2/include/linux/mmzone.h
===================================================================
--- linux-2.6.15-rc5-mm2.orig/include/linux/mmzone.h	2005-12-12 09:10:34.000000000 -0800
+++ linux-2.6.15-rc5-mm2/include/linux/mmzone.h	2005-12-12 16:50:21.000000000 -0800
@@ -157,6 +157,8 @@ struct zone {
 	/* A count of how many reclaimers are scanning this zone */
 	atomic_t		reclaim_in_progress;
 
+	unsigned long		last_unsuccessful_zone_reclaim;
+
 	/*
 	 * prev_priority holds the scanning priority for this zone.  It is
 	 * defined as the scanning priority at which we achieved our reclaim
