Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262245AbUKKPDk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262245AbUKKPDk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 10:03:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262243AbUKKPCs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 10:02:48 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63720 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262245AbUKKO7F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 09:59:05 -0500
Date: Thu, 11 Nov 2004 09:29:22 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: Nick Piggin <piggin@cyberone.com.au>, Rik van Riel <riel@redhat.com>,
       Andrea Arcangeli <andrea@novell.com>,
       Martin MOKREJ? <mmokrejs@ribosome.natur.cuni.cz>, tglx@linutronix.de
Subject: [PATCH] fix spurious OOM kills
Message-ID: <20041111112922.GA15948@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is an improved version of OOM-kill-from-kswapd patch.

I believe triggering the OOM killer from task reclaim context 
is broken because the chances that it happens increases as the amount
of tasks inside reclaim increases - and that approach ignores efforts 
being done by kswapd, who is the main entity responsible for
freeing pages.

There have been a few problems pointed out by others (Andrea, Nick) on the 
last patch - this one solves them.

First, Andrea noted that if progress had been made in the high zone, 
the OOM killer would not be triggered. Now it conditions the triggering 
on "DMA+Normal" reclaiming success.

Nick noted that the last patch would do wrong on the NUMA case (because
of per-node kswapd) - its not a problem now because we will only
kill if there is any task not being able to allocate and free pages.
The memory allocation fallback to other nodes will prevent that 
from happening. 

Another drawback from the last patch was that it disable the 
"all_unreclaimable" logic which attempts to avoid scanning storms - 
that way kswapd was able to detect OOM condition. 

What it does now is to disable the all_unreclaimable logic after 
5 seconds that its been set. This is enough time for the system 
to complete IO of (at least some) pages which have been written-out
for reclaiming purposes. 

After that period (which can be sysctl'ed BTW), it then performs 
a full scan. In case no progress has been made, and both 
DMA and normal zones are below the pages_min watermark, the OOM 
killer is triggered.

It looks very reliable in my testing - but I need others to test 
it as well (Martin and Thomas especially who have good test cases).


diff -Nur --exclude='*.orig' linux-2.6.10-rc1-mm2.orig/include/linux/mmzone.h linux-2.6.10-rc1-mm2/include/linux/mmzone.h
--- linux-2.6.10-rc1-mm2.orig/include/linux/mmzone.h	2004-11-09 14:56:05.000000000 -0200
+++ linux-2.6.10-rc1-mm2/include/linux/mmzone.h	2004-11-11 09:36:10.512588568 -0200
@@ -146,6 +146,7 @@
 	unsigned long		nr_inactive;
 	unsigned long		pages_scanned;	   /* since last reclaim */
 	int			all_unreclaimable; /* All pages pinned */
+	unsigned long		all_unreclaimable_set; /* When it was set, jiffies */
 
 	/*
 	 * prev_priority holds the scanning priority for this zone.  It is
diff -Nur --exclude='*.orig' linux-2.6.10-rc1-mm2.orig/mm/oom_kill.c linux-2.6.10-rc1-mm2/mm/oom_kill.c
--- linux-2.6.10-rc1-mm2.orig/mm/oom_kill.c	2004-11-09 14:56:05.000000000 -0200
+++ linux-2.6.10-rc1-mm2/mm/oom_kill.c	2004-11-05 18:33:29.000000000 -0200
@@ -240,23 +240,23 @@
 	 * If it's been a long time since last failure,
 	 * we're not oom.
 	 */
-	if (since > 5*HZ)
-		goto reset;
+	//if (since > 5*HZ)
+	//	goto reset;
 
 	/*
 	 * If we haven't tried for at least one second,
 	 * we're not really oom.
 	 */
-	since = now - first;
-	if (since < HZ)
-		goto out_unlock;
+	//since = now - first;
+	//if (since < HZ)
+	//	goto out_unlock;
 
 	/*
 	 * If we have gotten only a few failures,
 	 * we're not really oom. 
 	 */
-	if (++count < 10)
-		goto out_unlock;
+//	if (++count < 10)
+//		goto out_unlock;
 
 	/*
 	 * If we just killed a process, wait a while
diff -Nur --exclude='*.orig' linux-2.6.10-rc1-mm2.orig/mm/page_alloc.c linux-2.6.10-rc1-mm2/mm/page_alloc.c
--- linux-2.6.10-rc1-mm2.orig/mm/page_alloc.c	2004-11-09 14:56:05.000000000 -0200
+++ linux-2.6.10-rc1-mm2/mm/page_alloc.c	2004-11-11 09:55:09.587422872 -0200
@@ -305,6 +305,7 @@
 	base = zone->zone_mem_map;
 	spin_lock_irqsave(&zone->lock, flags);
 	zone->all_unreclaimable = 0;
+	zone->all_unreclaimable_set = 0;
 	zone->pages_scanned = 0;
 	while (!list_empty(list) && count--) {
 		page = list_entry(list->prev, struct page, lru);
diff -Nur --exclude='*.orig' linux-2.6.10-rc1-mm2.orig/mm/vmscan.c linux-2.6.10-rc1-mm2/mm/vmscan.c
--- linux-2.6.10-rc1-mm2.orig/mm/vmscan.c	2004-11-09 14:56:05.000000000 -0200
+++ linux-2.6.10-rc1-mm2/mm/vmscan.c	2004-11-11 11:03:54.884282424 -0200
@@ -878,6 +878,8 @@
 		shrink_zone(zone, sc);
 	}
 }
+
+int task_looping_oom = 0;
  
 /*
  * This is the main entry point to direct page reclaim.
@@ -952,8 +954,8 @@
 		if (sc.nr_scanned && priority < DEF_PRIORITY - 2)
 			blk_congestion_wait(WRITE, HZ/10);
 	}
-	if ((gfp_mask & __GFP_FS) && !(gfp_mask & __GFP_NORETRY))
-		out_of_memory(gfp_mask);
+        if ((gfp_mask & __GFP_FS) && !(gfp_mask & __GFP_NORETRY))
+		task_looping_oom = 1;
 out:
 	for (i = 0; zones[i] != 0; i++) {
 		struct zone *zone = zones[i];
@@ -963,6 +965,8 @@
 
 		zone->prev_priority = zone->temp_priority;
 	}
+	if (ret || total_reclaimed)
+		task_looping_oom = 0;
 	return ret;
 }
 
@@ -997,13 +1001,17 @@
 	int all_zones_ok;
 	int priority;
 	int i;
-	int total_scanned, total_reclaimed;
+	int total_scanned, total_reclaimed, low_reclaimed;
+	int worked_norm, worked_dma;
 	struct reclaim_state *reclaim_state = current->reclaim_state;
 	struct scan_control sc;
 
+
 loop_again:
 	total_scanned = 0;
 	total_reclaimed = 0;
+	low_reclaimed = 0;
+	worked_norm = worked_dma = 0;
 	sc.gfp_mask = GFP_KERNEL;
 	sc.may_writepage = 0;
 	sc.nr_mapped = read_page_state(nr_mapped);
@@ -1072,6 +1080,17 @@
 			if (zone->all_unreclaimable && priority != DEF_PRIORITY)
 				continue;
 
+			/* if we're scanning dma or normal, and priority 
+			 * reached zero, set "worked_dma" or "worked_norm" 
+			 * accordingly.
+			 */
+			if (i <= 1 && priority == 0) {
+				if (!i) 
+					worked_dma = 1;
+				else
+					worked_norm = 1;
+			}
+
 			if (nr_pages == 0) {	/* Not software suspend */
 				if (!zone_watermark_ok(zone, order,
 						zone->pages_high, end_zone, 0, 0))
@@ -1088,11 +1107,17 @@
 			shrink_slab(sc.nr_scanned, GFP_KERNEL, lru_pages);
 			sc.nr_reclaimed += reclaim_state->reclaimed_slab;
 			total_reclaimed += sc.nr_reclaimed;
+
+			if (i <= 1)
+				low_reclaimed += sc.nr_reclaimed;
+
 			if (zone->all_unreclaimable)
 				continue;
 			if (zone->pages_scanned >= (zone->nr_active +
-							zone->nr_inactive) * 4)
+							zone->nr_inactive) * 4) {
 				zone->all_unreclaimable = 1;
+				zone->all_unreclaimable_set = jiffies;
+			}
 			/*
 			 * If we've done a decent amount of scanning and
 			 * the reclaim ratio is low, start doing writepage
@@ -1127,7 +1152,37 @@
 		struct zone *zone = pgdat->node_zones + i;
 
 		zone->prev_priority = zone->temp_priority;
+
+		/* if the zone has been all_unreclaimable for 
+		 * more than 5 seconds, clear it to proceed
+		 * with a full scan. 
+		 * This way kswapd can detect that the zone is OOM.
+    	         */
+		if (zone->all_unreclaimable) {
+			if (time_after(jiffies, 
+				zone->all_unreclaimable_set + (500*HZ)/100)) {
+				zone->all_unreclaimable = 0;
+				zone->all_unreclaimable_set = 0;
+				zone->pages_scanned = 0;
+			}
+		}
 	}
+
+	if (!low_reclaimed && worked_dma && worked_norm && task_looping_oom) {
+		/* 
+		 * Only kill if ZONE_NORMAL/ZONE_DMA are both below
+		 * pages_min
+		 */
+		for (i = pgdat->nr_zones - 2; i >= 0; i--) {
+			struct zone *zone = pgdat->node_zones + i;
+
+			if (zone->free_pages > zone->pages_min)
+				return 0;
+		}
+		out_of_memory(GFP_KERNEL);
+		task_looping_oom = 0;
+	}
+
 	if (!all_zones_ok) {
 		cond_resched();
 		goto loop_again;
@@ -1196,7 +1251,7 @@
 			 */
 			order = new_order;
 		} else {
-			schedule();
+			schedule_timeout((600*HZ)/100);
 			order = pgdat->kswapd_max_order;
 		}
 		finish_wait(&pgdat->kswapd_wait, &wait);
