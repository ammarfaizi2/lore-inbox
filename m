Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932551AbVLFRZc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932551AbVLFRZc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 12:25:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932605AbVLFRZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 12:25:31 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:11496 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932529AbVLFRZD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 12:25:03 -0500
Date: Tue, 6 Dec 2005 09:24:49 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: Christoph Hellwig <hch@infradead.org>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, ak@suse.de, torvalds@osdl.org,
       Christoph Lameter <clameter@sgi.com>
Message-Id: <20051206172449.18786.31298.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20051206172444.18786.30131.sendpatchset@schroedinger.engr.sgi.com>
References: <20051206172444.18786.30131.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 2/2] Remove debris from old zone reclaim
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove debris of old zone reclaim

Removes the leftovers from prior attempts to implement Zone reclaim.

sys_set_zone_reclaim is not rechable in 2.6.14.

The reclaim_pages field in struct zone is only used by sys_set_zone_reclaim.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.15-rc4/include/linux/mmzone.h
===================================================================
--- linux-2.6.15-rc4.orig/include/linux/mmzone.h	2005-11-30 22:25:15.000000000 -0800
+++ linux-2.6.15-rc4/include/linux/mmzone.h	2005-12-06 09:17:58.000000000 -0800
@@ -150,11 +150,6 @@ struct zone {
 	unsigned long		pages_scanned;	   /* since last reclaim */
 	int			all_unreclaimable; /* All pages pinned */
 
-	/*
-	 * Does the allocator try to reclaim pages from the zone as soon
-	 * as it fails a watermark_ok() in __alloc_pages?
-	 */
-	int			reclaim_pages;
 	/* A count of how many reclaimers are scanning this zone */
 	atomic_t		reclaim_in_progress;
 
Index: linux-2.6.15-rc4/mm/vmscan.c
===================================================================
--- linux-2.6.15-rc4.orig/mm/vmscan.c	2005-12-06 09:10:00.000000000 -0800
+++ linux-2.6.15-rc4/mm/vmscan.c	2005-12-06 09:17:58.000000000 -0800
@@ -1400,33 +1400,3 @@ int zone_reclaim(struct zone *zone, gfp_
 	return sc.nr_reclaimed > (1 << order);
 }
 
-asmlinkage long sys_set_zone_reclaim(unsigned int node, unsigned int zone,
-				     unsigned int state)
-{
-	struct zone *z;
-	int i;
-
-	if (!capable(CAP_SYS_ADMIN))
-		return -EACCES;
-
-	if (node >= MAX_NUMNODES || !node_online(node))
-		return -EINVAL;
-
-	/* This will break if we ever add more zones */
-	if (!(zone & (1<<ZONE_DMA|1<<ZONE_NORMAL|1<<ZONE_HIGHMEM)))
-		return -EINVAL;
-
-	for (i = 0; i < MAX_NR_ZONES; i++) {
-		if (!(zone & 1<<i))
-			continue;
-
-		z = &NODE_DATA(node)->node_zones[i];
-
-		if (state)
-			z->reclaim_pages = 1;
-		else
-			z->reclaim_pages = 0;
-	}
-
-	return 0;
-}
