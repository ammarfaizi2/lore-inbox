Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbUBWApw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 19:45:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbUBWApw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 19:45:52 -0500
Received: from fw.osdl.org ([65.172.181.6]:42208 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261298AbUBWApq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 19:45:46 -0500
Date: Sun, 22 Feb 2004 16:46:17 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: cw@f00f.org, mfedyk@matchmail.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Large slab cache in 2.6.1
Message-Id: <20040222164617.7fba4321.akpm@osdl.org>
In-Reply-To: <40394A9F.1050606@cyberone.com.au>
References: <20040222033111.GA14197@dingdong.cryptoapps.com>
	<4038299E.9030907@cyberone.com.au>
	<40382BAA.1000802@cyberone.com.au>
	<4038307B.2090405@cyberone.com.au>
	<40383300.5010203@matchmail.com>
	<4038402A.4030708@cyberone.com.au>
	<40384325.1010802@matchmail.com>
	<403845CB.8040805@cyberone.com.au>
	<20040221221721.42e734d6.akpm@osdl.org>
	<40384D9D.6040604@cyberone.com.au>
	<20040222083637.GA15589@dingdong.cryptoapps.com>
	<20040222011350.58f756e8.akpm@osdl.org>
	<40394662.5060104@cyberone.com.au>
	<20040222162634.560c5306.akpm@osdl.org>
	<40394A9F.1050606@cyberone.com.au>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <piggin@cyberone.com.au> wrote:
>
> >We should be performing lowmem page reclaim, but we're not.  With some
> >highmem/lowmem size combinations the `incremental min' logic in the page
> >allocator will prevent __GFP_HIGHMEM allocations from taking ZONE_NORMAL
> >below pages_high and kswapd then does not perform page reclaim in the
> >lowmem zone at all.  I'm seeing some workloads where we reclaim 700 highmem
> >pages for each lowmem page.  This hugely exacerbated the slab problem on
> >1.5G machines.  I have that fixed up now.
> >
> >
> 
> This is the incremental min logic doing its work though. Maybe
> that should be fixed up to be less aggressive instead of putting
> more complexity in the scanner to work around it.

The scanner got simpler.

> Anyway could you post the patch you're using to fix it?

Sure.

> >Regardless of that, we do, logically, want to reclaim slab in response to
> >highmem reclaim pressure because any highmem allocation can be satisfied by
> >lowmem too.
> >
> >
> 
> The logical extension of that is: "we want to reclaim *lowmem* in
> response to highmem reclaim pressure because any ..."

yep.

> If this isn't what the scanner is doing then it should be fixed in
> a more generic way.


 include/linux/mmzone.h |    5 ++++-
 mm/page_alloc.c        |   13 ++++++++++++-
 mm/vmscan.c            |   22 +++++++++-------------
 3 files changed, 25 insertions(+), 15 deletions(-)

diff -puN mm/page_alloc.c~zone-balancing-batching mm/page_alloc.c
--- 25/mm/page_alloc.c~zone-balancing-batching	2004-02-22 15:15:52.000000000 -0800
+++ 25-akpm/mm/page_alloc.c	2004-02-22 15:15:52.000000000 -0800
@@ -1019,6 +1019,7 @@ void show_free_areas(void)
 			" min:%lukB"
 			" low:%lukB"
 			" high:%lukB"
+			" batch:%lukB"
 			" active:%lukB"
 			" inactive:%lukB"
 			"\n",
@@ -1027,6 +1028,7 @@ void show_free_areas(void)
 			K(zone->pages_min),
 			K(zone->pages_low),
 			K(zone->pages_high),
+			K(zone->reclaim_batch),
 			K(zone->nr_active),
 			K(zone->nr_inactive)
 			);
@@ -1618,6 +1620,8 @@ static void setup_per_zone_pages_min(voi
 			lowmem_pages += zone->present_pages;
 
 	for_each_zone(zone) {
+		unsigned long long reclaim_batch;
+
 		spin_lock_irqsave(&zone->lru_lock, flags);
 		if (is_highmem(zone)) {
 			/*
@@ -1642,8 +1646,15 @@ static void setup_per_zone_pages_min(voi
 			                   lowmem_pages;
 		}
 
-		zone-> pages_low = zone->pages_min * 2;
+		zone->pages_low = zone->pages_min * 2;
 		zone->pages_high = zone->pages_min * 3;
+
+		reclaim_batch = zone->present_pages * SWAP_CLUSTER_MAX;
+		do_div(reclaim_batch, lowmem_pages);
+		zone->reclaim_batch = reclaim_batch;
+		if (zone->reclaim_batch < 4)
+			zone->reclaim_batch = 4;
+
 		spin_unlock_irqrestore(&zone->lru_lock, flags);
 	}
 }
diff -puN mm/vmscan.c~zone-balancing-batching mm/vmscan.c
--- 25/mm/vmscan.c~zone-balancing-batching	2004-02-22 15:15:52.000000000 -0800
+++ 25-akpm/mm/vmscan.c	2004-02-22 15:15:52.000000000 -0800
@@ -859,13 +859,12 @@ shrink_zone(struct zone *zone, unsigned 
  */
 static int
 shrink_caches(struct zone **zones, int priority, int *total_scanned,
-		int gfp_mask, int nr_pages, struct page_state *ps)
+		int gfp_mask, struct page_state *ps)
 {
 	int ret = 0;
 	int i;
 
 	for (i = 0; zones[i] != NULL; i++) {
-		int to_reclaim = max(nr_pages, SWAP_CLUSTER_MAX);
 		struct zone *zone = zones[i];
 		int nr_scanned;
 
@@ -875,8 +874,8 @@ shrink_caches(struct zone **zones, int p
 		if (zone->all_unreclaimable && priority != DEF_PRIORITY)
 			continue;	/* Let kswapd poll it */
 
-		ret += shrink_zone(zone, gfp_mask,
-				to_reclaim, &nr_scanned, ps, priority);
+		ret += shrink_zone(zone, gfp_mask, zone->reclaim_batch,
+				&nr_scanned, ps, priority);
 		*total_scanned += nr_scanned;
 	}
 	return ret;
@@ -904,7 +903,6 @@ int try_to_free_pages(struct zone **zone
 {
 	int priority;
 	int ret = 0;
-	const int nr_pages = SWAP_CLUSTER_MAX;
 	int nr_reclaimed = 0;
 	struct reclaim_state *reclaim_state = current->reclaim_state;
 	int i;
@@ -920,7 +918,7 @@ int try_to_free_pages(struct zone **zone
 
 		get_page_state(&ps);
 		nr_reclaimed += shrink_caches(zones, priority, &total_scanned,
-						gfp_mask, nr_pages, &ps);
+						gfp_mask, &ps);
 
 		shrink_slab(total_scanned, gfp_mask);
 		if (reclaim_state) {
@@ -928,7 +926,7 @@ int try_to_free_pages(struct zone **zone
 			reclaim_state->reclaimed_slab = 0;
 		}
 
-		if (nr_reclaimed >= nr_pages) {
+		if (nr_reclaimed >= SWAP_CLUSTER_MAX) {
 			ret = 1;
 			if (gfp_mask & __GFP_FS)
 				wakeup_bdflush(total_scanned);
@@ -1008,13 +1006,11 @@ static int balance_pgdat(pg_data_t *pgda
 			if (zone->all_unreclaimable && priority != DEF_PRIORITY)
 				continue;
 
-			if (nr_pages) {		/* Software suspend */
+			if (nr_pages)		/* Software suspend */
 				to_reclaim = min(to_free, SWAP_CLUSTER_MAX*8);
-			} else {		/* Zone balancing */
-				to_reclaim = zone->pages_high-zone->free_pages;
-				if (to_reclaim <= 0)
-					continue;
-			}
+			else			/* Zone balancing */
+				to_reclaim = zone->reclaim_batch;
+
 			all_zones_ok = 0;
 			zone->temp_priority = priority;
 			reclaimed = shrink_zone(zone, GFP_KERNEL,
diff -puN include/linux/mmzone.h~zone-balancing-batching include/linux/mmzone.h
--- 25/include/linux/mmzone.h~zone-balancing-batching	2004-02-22 15:15:52.000000000 -0800
+++ 25-akpm/include/linux/mmzone.h	2004-02-22 15:15:52.000000000 -0800
@@ -69,7 +69,10 @@ struct zone {
 	 */
 	spinlock_t		lock;
 	unsigned long		free_pages;
-	unsigned long		pages_min, pages_low, pages_high;
+	unsigned long		pages_min;
+	unsigned long		pages_low;
+	unsigned long		pages_high;
+	unsigned long		reclaim_batch;
 
 	ZONE_PADDING(_pad1_)
 

_

