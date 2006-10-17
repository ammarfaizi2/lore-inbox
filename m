Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751356AbWJQRfI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbWJQRfI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 13:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbWJQRfI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 13:35:08 -0400
Received: from smtp-out.google.com ([216.239.45.12]:43821 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751356AbWJQRfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 13:35:06 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:subject:content-type;
	b=YhJpVUf15x5fGMVGUA0b14a47VOgcTi57GP1tuzWsagBp4PI401JqwIFjnKE0br6k
	g4bJlzfY8DKK343ZkQVtg==
Message-ID: <45351423.70804@google.com>
Date: Tue, 17 Oct 2006 10:34:27 -0700
From: Martin Bligh <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Nick Piggin <npiggin@suse.de>
Subject: [RFC] Remove temp_priority
Content-Type: multipart/mixed;
 boundary="------------020603040006080409020505"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020603040006080409020505
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This is not tested yet. What do you think?

This patch removes temp_priority, as it is racy. We're setting
prev_priority from it, and yet temp_priority could have been
set back to DEF_PRIORITY by another reclaimer.




--------------020603040006080409020505
Content-Type: text/plain;
 name="2.6.18-prio_fix"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.6.18-prio_fix"

diff -aurpN -X /home/mbligh/.diff.exclude linux-2.6.18/include/linux/mmzone.h 2.6.18-prio_fix/include/linux/mmzone.h
--- linux-2.6.18/include/linux/mmzone.h	2006-09-20 12:24:41.000000000 -0700
+++ 2.6.18-prio_fix/include/linux/mmzone.h	2006-10-17 10:27:48.000000000 -0700
@@ -199,13 +199,9 @@ struct zone {
 	 * under - it drives the swappiness decision: whether to unmap mapped
 	 * pages.
 	 *
-	 * temp_priority is used to remember the scanning priority at which
-	 * this zone was successfully refilled to free_pages == pages_high.
-	 *
-	 * Access to both these fields is quite racy even on uniprocessor.  But
-	 * it is expected to average out OK.
+	 * Access to this field is quite racy even on uniprocessor. It needs
+	 * to be fixed.
 	 */
-	int temp_priority;
 	int prev_priority;
 
 
diff -aurpN -X /home/mbligh/.diff.exclude linux-2.6.18/mm/page_alloc.c 2.6.18-prio_fix/mm/page_alloc.c
--- linux-2.6.18/mm/page_alloc.c	2006-09-20 12:24:42.000000000 -0700
+++ 2.6.18-prio_fix/mm/page_alloc.c	2006-10-17 10:25:55.000000000 -0700
@@ -2016,7 +2016,7 @@ static void __meminit free_area_init_cor
 		zone->zone_pgdat = pgdat;
 		zone->free_pages = 0;
 
-		zone->temp_priority = zone->prev_priority = DEF_PRIORITY;
+		zone->prev_priority = DEF_PRIORITY;
 
 		zone_pcp_init(zone);
 		INIT_LIST_HEAD(&zone->active_list);
diff -aurpN -X /home/mbligh/.diff.exclude linux-2.6.18/mm/vmscan.c 2.6.18-prio_fix/mm/vmscan.c
--- linux-2.6.18/mm/vmscan.c	2006-09-20 12:24:42.000000000 -0700
+++ 2.6.18-prio_fix/mm/vmscan.c	2006-10-17 10:25:24.000000000 -0700
@@ -934,7 +934,6 @@ static unsigned long shrink_zones(int pr
 		if (!cpuset_zone_allowed(zone, __GFP_HARDWALL))
 			continue;
 
-		zone->temp_priority = priority;
 		if (zone->prev_priority > priority)
 			zone->prev_priority = priority;
 
@@ -984,7 +983,6 @@ unsigned long try_to_free_pages(struct z
 		if (!cpuset_zone_allowed(zone, __GFP_HARDWALL))
 			continue;
 
-		zone->temp_priority = DEF_PRIORITY;
 		lru_pages += zone->nr_active + zone->nr_inactive;
 	}
 
@@ -1021,6 +1019,8 @@ unsigned long try_to_free_pages(struct z
 		if (sc.nr_scanned && priority < DEF_PRIORITY - 2)
 			blk_congestion_wait(WRITE, HZ/10);
 	}
+	if (priority < 0)
+		priority = 0;
 out:
 	for (i = 0; zones[i] != 0; i++) {
 		struct zone *zone = zones[i];
@@ -1028,7 +1028,7 @@ out:
 		if (!cpuset_zone_allowed(zone, __GFP_HARDWALL))
 			continue;
 
-		zone->prev_priority = zone->temp_priority;
+		zone->prev_priority = priority;
 	}
 	return ret;
 }
@@ -1075,12 +1075,6 @@ loop_again:
 	sc.may_writepage = !laptop_mode;
 	count_vm_event(PAGEOUTRUN);
 
-	for (i = 0; i < pgdat->nr_zones; i++) {
-		struct zone *zone = pgdat->node_zones + i;
-
-		zone->temp_priority = DEF_PRIORITY;
-	}
-
 	for (priority = DEF_PRIORITY; priority >= 0; priority--) {
 		int end_zone = 0;	/* Inclusive.  0 = ZONE_DMA */
 		unsigned long lru_pages = 0;
@@ -1140,7 +1134,6 @@ scan:
 			if (!zone_watermark_ok(zone, order, zone->pages_high,
 					       end_zone, 0))
 				all_zones_ok = 0;
-			zone->temp_priority = priority;
 			if (zone->prev_priority > priority)
 				zone->prev_priority = priority;
 			sc.nr_scanned = 0;
@@ -1182,11 +1175,13 @@ scan:
 		if (nr_reclaimed >= SWAP_CLUSTER_MAX)
 			break;
 	}
+	if (priority < 0)
+		priority = 0;
 out:
 	for (i = 0; i < pgdat->nr_zones; i++) {
 		struct zone *zone = pgdat->node_zones + i;
 
-		zone->prev_priority = zone->temp_priority;
+		zone->prev_priority = priority;
 	}
 	if (!all_zones_ok) {
 		cond_resched();

--------------020603040006080409020505--
