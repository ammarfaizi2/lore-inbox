Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965027AbVKAFSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965027AbVKAFSb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 00:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965030AbVKAFSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 00:18:31 -0500
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:34448 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S965027AbVKAFSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 00:18:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:Subject:References:In-Reply-To:Content-Type;
  b=0h4TQaYp5DWO9dIXg5FglQHKkSpQwrcxdJwevWnUK5bKEXPAkdXHErPuiZqIvLebtV8Rn24wI9aFnQZeZqk6uSaxg9tCt2h+1/FD5ivqx2l0uLa/Yc8Pxkl729YB/HFBQorFNomMkS9SNOcbdaB4TMGMCjQXYBJHKtMrN3ytpOY=  ;
Message-ID: <4366FAF5.8020908@yahoo.com.au>
Date: Tue, 01 Nov 2005 16:19:49 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] vm: kswapd incmin
References: <4366FA9A.20402@yahoo.com.au>
In-Reply-To: <4366FA9A.20402@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------010504060602030600070706"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010504060602030600070706
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

1/3

-- 
SUSE Labs, Novell Inc.


--------------010504060602030600070706
Content-Type: text/plain;
 name="vm-kswapd-incmin.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vm-kswapd-incmin.patch"

Explicitly teach kswapd about the incremental min logic instead of just scanning
all zones under the first low zone. This should keep more even pressure applied
on the zones.

Signed-off-by: Nick Piggin <npiggin@suse.de>


Index: linux-2.6/mm/vmscan.c
===================================================================
--- linux-2.6.orig/mm/vmscan.c	2005-11-01 13:42:33.000000000 +1100
+++ linux-2.6/mm/vmscan.c	2005-11-01 14:27:16.000000000 +1100
@@ -1051,97 +1051,63 @@ loop_again:
 	}
 
 	for (priority = DEF_PRIORITY; priority >= 0; priority--) {
-		int end_zone = 0;	/* Inclusive.  0 = ZONE_DMA */
 		unsigned long lru_pages = 0;
+		int first_low_zone = 0;
 
 		all_zones_ok = 1;
+		sc.nr_scanned = 0;
+		sc.nr_reclaimed = 0;
+		sc.priority = priority;
+		sc.swap_cluster_max = nr_pages ? nr_pages : SWAP_CLUSTER_MAX;
 
-		if (nr_pages == 0) {
-			/*
-			 * Scan in the highmem->dma direction for the highest
-			 * zone which needs scanning
-			 */
-			for (i = pgdat->nr_zones - 1; i >= 0; i--) {
-				struct zone *zone = pgdat->node_zones + i;
+		/* Scan in the highmem->dma direction */
+		for (i = pgdat->nr_zones - 1; i >= 0; i--) {
+			struct zone *zone = pgdat->node_zones + i;
 
-				if (zone->present_pages == 0)
-					continue;
+			if (zone->present_pages == 0)
+				continue;
 
-				if (zone->all_unreclaimable &&
-						priority != DEF_PRIORITY)
+			if (nr_pages == 0) {	/* Not software suspend */
+				if (zone_watermark_ok(zone, order,
+					zone->pages_high, first_low_zone, 0, 0))
 					continue;
 
-				if (!zone_watermark_ok(zone, order,
-						zone->pages_high, 0, 0, 0)) {
-					end_zone = i;
-					goto scan;
-				}
+				all_zones_ok = 0;
+				if (first_low_zone < i)
+					first_low_zone = i;
 			}
-			goto out;
-		} else {
-			end_zone = pgdat->nr_zones - 1;
-		}
-scan:
-		for (i = 0; i <= end_zone; i++) {
-			struct zone *zone = pgdat->node_zones + i;
-
-			lru_pages += zone->nr_active + zone->nr_inactive;
-		}
-
-		/*
-		 * Now scan the zone in the dma->highmem direction, stopping
-		 * at the last zone which needs scanning.
-		 *
-		 * We do this because the page allocator works in the opposite
-		 * direction.  This prevents the page allocator from allocating
-		 * pages behind kswapd's direction of progress, which would
-		 * cause too much scanning of the lower zones.
-		 */
-		for (i = 0; i <= end_zone; i++) {
-			struct zone *zone = pgdat->node_zones + i;
-			int nr_slab;
-
-			if (zone->present_pages == 0)
-				continue;
 
 			if (zone->all_unreclaimable && priority != DEF_PRIORITY)
 				continue;
 
-			if (nr_pages == 0) {	/* Not software suspend */
-				if (!zone_watermark_ok(zone, order,
-						zone->pages_high, end_zone, 0, 0))
-					all_zones_ok = 0;
-			}
 			zone->temp_priority = priority;
 			if (zone->prev_priority > priority)
 				zone->prev_priority = priority;
-			sc.nr_scanned = 0;
-			sc.nr_reclaimed = 0;
-			sc.priority = priority;
-			sc.swap_cluster_max = nr_pages? nr_pages : SWAP_CLUSTER_MAX;
+			lru_pages += zone->nr_active + zone->nr_inactive;
+
 			atomic_inc(&zone->reclaim_in_progress);
 			shrink_zone(zone, &sc);
 			atomic_dec(&zone->reclaim_in_progress);
-			reclaim_state->reclaimed_slab = 0;
-			nr_slab = shrink_slab(sc.nr_scanned, GFP_KERNEL,
-						lru_pages);
-			sc.nr_reclaimed += reclaim_state->reclaimed_slab;
-			total_reclaimed += sc.nr_reclaimed;
-			total_scanned += sc.nr_scanned;
-			if (zone->all_unreclaimable)
-				continue;
-			if (nr_slab == 0 && zone->pages_scanned >=
+
+			if (zone->pages_scanned >=
 				    (zone->nr_active + zone->nr_inactive) * 4)
 				zone->all_unreclaimable = 1;
-			/*
-			 * If we've done a decent amount of scanning and
-			 * the reclaim ratio is low, start doing writepage
-			 * even in laptop mode
-			 */
-			if (total_scanned > SWAP_CLUSTER_MAX * 2 &&
-			    total_scanned > total_reclaimed+total_reclaimed/2)
-				sc.may_writepage = 1;
 		}
+		reclaim_state->reclaimed_slab = 0;
+		shrink_slab(sc.nr_scanned, GFP_KERNEL, lru_pages);
+		sc.nr_reclaimed += reclaim_state->reclaimed_slab;
+		total_reclaimed += sc.nr_reclaimed;
+		total_scanned += sc.nr_scanned;
+
+		/*
+		 * If we've done a decent amount of scanning and
+		 * the reclaim ratio is low, start doing writepage
+		 * even in laptop mode
+		 */
+		if (total_scanned > SWAP_CLUSTER_MAX * 2 &&
+		    total_scanned > total_reclaimed+total_reclaimed/2)
+			sc.may_writepage = 1;
+
 		if (nr_pages && to_free > total_reclaimed)
 			continue;	/* swsusp: need to do more work */
 		if (all_zones_ok)
@@ -1162,7 +1128,6 @@ scan:
 		if ((total_reclaimed >= SWAP_CLUSTER_MAX) && (!nr_pages))
 			break;
 	}
-out:
 	for (i = 0; i < pgdat->nr_zones; i++) {
 		struct zone *zone = pgdat->node_zones + i;
 

--------------010504060602030600070706--
Send instant messages to your online friends http://au.messenger.yahoo.com 
