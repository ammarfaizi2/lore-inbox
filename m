Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269962AbUJHAt0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269962AbUJHAt0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 20:49:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269958AbUJHAr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 20:47:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:7094 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269965AbUJHAob (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 20:44:31 -0400
Date: Thu, 7 Oct 2004 17:42:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: chrisw@osdl.org, linux-kernel@vger.kernel.org, piggin@cyberone.com.au
Subject: Re: kswapd in tight loop 2.6.9-rc3-bk-recent
Message-Id: <20041007174242.3dd6facd.akpm@osdl.org>
In-Reply-To: <4165E0A7.7080305@yahoo.com.au>
References: <20041007142019.D2441@build.pdx.osdl.net>
	<20041007164044.23bac609.akpm@osdl.org>
	<4165E0A7.7080305@yahoo.com.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


OK, after backing out the `goto spaghetti;' patch and cleaning up a few
thing I'll test the below.  It'll make kswapd much less aggressive.



diff -puN mm/vmscan.c~no-wild-kswapd-2 mm/vmscan.c
--- 25/mm/vmscan.c~no-wild-kswapd-2	2004-10-07 17:38:20.342906376 -0700
+++ 25-akpm/mm/vmscan.c	2004-10-07 17:38:20.348905464 -0700
@@ -964,6 +964,17 @@ out:
  * of the number of free pages in the lower zones.  This interoperates with
  * the page allocator fallback scheme to ensure that aging of pages is balanced
  * across the zones.
+ *
+ * kswapd can be semi-livelocked if some other process is allocating pages
+ * while kswapd is simultaneously trying to balance the same zone.  That's OK,
+ * because we _want_ kswapd to work continuously in this situation.  But a
+ * side-effect of kswapd's ongoing work is that the pageout priority keeps on
+ * winding up so we bogusly start doing swapout.
+ *
+ * To fix this we take a snapshot of the number of pages which need to be
+ * reclaimed from each zone in zone->pages_to_reclaim and never reclaim more
+ * pages than that.  Once the required number of pages have been reclaimed from
+ * each zone, we're done.  kwsapd will go back to sleep until someone wakes it.
  */
 static int balance_pgdat(pg_data_t *pgdat, int nr_pages)
 {
@@ -984,6 +995,7 @@ static int balance_pgdat(pg_data_t *pgda
 		struct zone *zone = pgdat->node_zones + i;
 
 		zone->temp_priority = DEF_PRIORITY;
+		zone->pages_to_reclaim = zone->pages_high - zone->pages_free;
 	}
 
 	for (priority = DEF_PRIORITY; priority >= 0; priority--) {
@@ -1003,7 +1015,7 @@ static int balance_pgdat(pg_data_t *pgda
 						priority != DEF_PRIORITY)
 					continue;
 
-				if (zone->free_pages <= zone->pages_high) {
+				if (zone->pages_to_reclaim > 0) {
 					end_zone = i;
 					break;
 				}
@@ -1036,10 +1048,11 @@ static int balance_pgdat(pg_data_t *pgda
 			if (zone->all_unreclaimable && priority != DEF_PRIORITY)
 				continue;
 
-			if (nr_pages == 0) {	/* Not software suspend */
-				if (zone->free_pages <= zone->pages_high)
-					all_zones_ok = 0;
-			}
+			if (zone->pages_to_reclaim <= 0)
+				continue;
+
+			if (nr_pages == 0)	/* Not software suspend */
+				all_zones_ok = 0;
 			zone->temp_priority = priority;
 			if (zone->prev_priority > priority)
 				zone->prev_priority = priority;
@@ -1049,6 +1062,10 @@ static int balance_pgdat(pg_data_t *pgda
 			shrink_zone(zone, &sc);
 			reclaim_state->reclaimed_slab = 0;
 			shrink_slab(sc.nr_scanned, GFP_KERNEL, lru_pages);
+
+			/* This fails to account for slab reclaim */
+			zone->pages_to_reclaim -= sc.nr_reclaimed;
+
 			sc.nr_reclaimed += reclaim_state->reclaimed_slab;
 			total_reclaimed += sc.nr_reclaimed;
 			total_scanned += sc.nr_scanned;
diff -puN include/linux/mmzone.h~no-wild-kswapd-2 include/linux/mmzone.h
--- 25/include/linux/mmzone.h~no-wild-kswapd-2	2004-10-07 17:38:20.343906224 -0700
+++ 25-akpm/include/linux/mmzone.h	2004-10-07 17:40:20.847586880 -0700
@@ -137,8 +137,9 @@ struct zone {
 	unsigned long		nr_scan_inactive;
 	unsigned long		nr_active;
 	unsigned long		nr_inactive;
-	int			all_unreclaimable; /* All pages pinned */
-	unsigned long		pages_scanned;	   /* since last reclaim */
+	long			pages_to_reclaim;	/* kswapd usage */
+	int			all_unreclaimable;	/* All pages pinned */
+	unsigned long		pages_scanned;		/* since last reclaim */
 
 	ZONE_PADDING(_pad2_)
 
_

