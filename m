Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261257AbUKEXQP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261257AbUKEXQP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 18:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbUKEXPH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 18:15:07 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:203 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261257AbUKEXNb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 18:13:31 -0500
Date: Fri, 5 Nov 2004 18:01:18 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andrew Morton <akpm@osdl.org>, Nick Piggin <piggin@cyberone.com.au>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH] Remove OOM killer from try_to_free_pages / all_unreclaimable braindamage
Message-ID: <20041105200118.GA20321@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

As you know the OOM is very problematic in 2.6 right now - so I went
to investigate it. 

Currently the oom killer is invoked from the task reclaim 
code (try_to_free_pages), which IMO is fundamentally broken, 
because its non deterministic - the chance the OOM killer 
will be triggered increases as the number of tasks inside 
reclaiming increases. And kswapd is freeing pages in parallel, 
which is completly ignored by this approach.

In my opinion the correct approach is to trigger the OOM killer 
when kswapd is unable to free pages. Once that is done, the number 
of tasks inside page reclaim is irrelevant. 

So the following patch moves the out_of_memory() call to 
balance_pgdat(), and makes it dependant on success reclaiming pages 
when work has actually been done, and on priority reaching zero.

It also removes the "If it's been a long time since last failure dont 
OOM kill" logic which for me just tries to paper over a bigger issue. 

Relying on this information (kswapd failure after DEF_PRIORITY passes) 
to trigger the OOM killer seems to be very reliable - it needs some 
more testing though.

With this in place I can't see spurious OOM kills - just need to guarantee
that it reliably OOM kills when we are really out of memory.

While doing this, I noticed that kswapd will happily go to sleep 
if all zones have all_unreclaimable set. I bet this is the reason 
for the page allocation failures we are seeing. So the patch 
also makes balance_pgdat() NOT return and go to "loop_again" 
instead in case of page shortage - even if all_unreclaimable is set.

Basically the "loop_again" logic IS NOT WORKING! 

Comments?

My wife is almost killing me, its Friday night and I've been telling her 
"just another minute" for hours. Have to run.

diff -Nur --show-c-function --exclude='*.orig' linux-2.6.10-rc1-mm2.orig/mm/oom_kill.c linux-2.6.10-rc1-mm2/mm/oom_kill.c
--- linux-2.6.10-rc1-mm2.orig/mm/oom_kill.c	2004-11-04 22:50:50.000000000 -0200
+++ linux-2.6.10-rc1-mm2/mm/oom_kill.c	2004-11-05 18:33:29.918459072 -0200
@@ -240,23 +240,23 @@ void out_of_memory(int gfp_mask)
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
diff -Nur --show-c-function --exclude='*.orig' linux-2.6.10-rc1-mm2.orig/mm/vmscan.c linux-2.6.10-rc1-mm2/mm/vmscan.c
--- linux-2.6.10-rc1-mm2.orig/mm/vmscan.c	2004-11-04 22:50:50.000000000 -0200
+++ linux-2.6.10-rc1-mm2/mm/vmscan.c	2004-11-05 19:53:35.915836416 -0200
@@ -952,8 +952,6 @@ int try_to_free_pages(struct zone **zone
 		if (sc.nr_scanned && priority < DEF_PRIORITY - 2)
 			blk_congestion_wait(WRITE, HZ/10);
 	}
-	if ((gfp_mask & __GFP_FS) && !(gfp_mask & __GFP_NORETRY))
-		out_of_memory(gfp_mask);
 out:
 	for (i = 0; zones[i] != 0; i++) {
 		struct zone *zone = zones[i];
@@ -997,13 +995,15 @@ static int balance_pgdat(pg_data_t *pgda
 	int all_zones_ok;
 	int priority;
 	int i;
-	int total_scanned, total_reclaimed;
+	int total_scanned, total_reclaimed, worked;
 	struct reclaim_state *reclaim_state = current->reclaim_state;
 	struct scan_control sc;
 
+
 loop_again:
 	total_scanned = 0;
 	total_reclaimed = 0;
+	worked = 0;
 	sc.gfp_mask = GFP_KERNEL;
 	sc.may_writepage = 0;
 	sc.nr_mapped = read_page_state(nr_mapped);
@@ -1033,6 +1033,10 @@ loop_again:
 				if (zone->present_pages == 0)
 					continue;
 
+				if (!zone_watermark_ok(zone, order, 
+						zone->pages_high, 0, 0, 0))
+					all_zones_ok = 0;
+
 				if (zone->all_unreclaimable &&
 						priority != DEF_PRIORITY)
 					continue;
@@ -1072,6 +1076,9 @@ scan:
 			if (zone->all_unreclaimable && priority != DEF_PRIORITY)
 				continue;
 
+			if (priority == 0)
+				worked = 1;
+
 			if (nr_pages == 0) {	/* Not software suspend */
 				if (!zone_watermark_ok(zone, order,
 						zone->pages_high, end_zone, 0, 0))
@@ -1129,6 +1136,9 @@ out:
 		zone->prev_priority = zone->temp_priority;
 	}
 	if (!all_zones_ok) {
+		if (priority == 0 && !total_reclaimed && worked)
+			out_of_memory(GFP_KERNEL);
+
 		cond_resched();
 		goto loop_again;
 	}
