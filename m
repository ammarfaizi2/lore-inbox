Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266303AbUHVVjT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266303AbUHVVjT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 17:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266469AbUHVVjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 17:39:19 -0400
Received: from mail013.syd.optusnet.com.au ([211.29.132.67]:15492 "EHLO
	mail013.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S266303AbUHVViS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 17:38:18 -0400
Message-ID: <4129122D.6090006@kolivas.org>
Date: Mon, 23 Aug 2004 07:37:49 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
Cc: ck kernel mailing list <ck@vds.kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.8.1-ck4
References: <412880BF.6050503@kolivas.org> <4128E2AE.4020300@namesys.com>
In-Reply-To: <4128E2AE.4020300@namesys.com>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig708B7F4ED23EA35EB28C0915"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig708B7F4ED23EA35EB28C0915
Content-Type: multipart/mixed;
 boundary="------------010504000608000002070608"

This is a multi-part message in MIME format.
--------------010504000608000002070608
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hans Reiser wrote:
> Con Kolivas wrote:
>> Added since 2.6.8.1-ck3:
>> +mapped_watermark.diff
>>
>> This readjusts the way memory is evicted by lightly 
> 
> 
> can you specify lightly with another sentence or two of detail?  Thanks,
> 
> Hans

Sure.

This adds another watermark to the logic used to wake up kswapd. kswapd 
is woken once there is less than 1/3 of physical ram free. The current 
watermark is used by kswapd to evict nr_pages to make room for whatever 
is trying to get ram. It does this by increasing the proportion of ram 
scanned each time it fails to allocate enough ram and will also start 
evicting mapped pages. With mapped_watermark, once awoken it will only 
ever scan at the lowest priority (DEF_PRIORITY) and never evict mapped 
pages. It only starts scanning if less than the tunable (mapped) percent 
of the in-use physical ram is mapped. If it does not manage to evict 
nr_pages it simply returns quietly allowing the physical ram to be 
consumed. As it is in the mainline vm, the watermark is always hit 
anyway, which means we're always scanning at potentially higher priority 
(and repeatedly) and always considering mapped pages.

The patch in it's entirety is small enough to review attached below.

Cheers,
Con

Signed-off-by: Con Kolivas <kernel@kolivas.org>

  include/linux/mmzone.h |    3 +
  include/linux/swap.h   |    2 -
  include/linux/sysctl.h |    2 -
  kernel/sysctl.c        |    8 ++--
  mm/page_alloc.c        |    4 ++
  mm/vmscan.c            |   83 
++++++++++++++++++-------------------------------
  6 files changed, 44 insertions(+), 58 deletions(-)

--------------010504000608000002070608
Content-Type: text/x-patch;
 name="mapped_watermark.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mapped_watermark.diff"

Index: linux-2.6.8.1-ck/include/linux/mmzone.h
===================================================================
--- linux-2.6.8.1-ck.orig/include/linux/mmzone.h	2004-08-15 14:08:19.000000000 +1000
+++ linux-2.6.8.1-ck/include/linux/mmzone.h	2004-08-22 14:32:23.000000000 +1000
@@ -125,7 +125,7 @@ struct zone {
 	 */
 	spinlock_t		lock;
 	unsigned long		free_pages;
-	unsigned long		pages_min, pages_low, pages_high;
+	unsigned long		pages_min, pages_low, pages_high, pages_unmapped;
 	/*
 	 * protection[] is a pre-calculated number of extra pages that must be
 	 * available in a zone in order for __alloc_pages() to allocate memory
@@ -276,6 +276,7 @@ typedef struct pglist_data {
 	struct pglist_data *pgdat_next;
 	wait_queue_head_t       kswapd_wait;
 	struct task_struct *kswapd;
+	int maplimit;
 } pg_data_t;
 
 #define node_present_pages(nid)	(NODE_DATA(nid)->node_present_pages)
Index: linux-2.6.8.1-ck/include/linux/swap.h
===================================================================
--- linux-2.6.8.1-ck.orig/include/linux/swap.h	2004-08-22 10:58:05.000000000 +1000
+++ linux-2.6.8.1-ck/include/linux/swap.h	2004-08-22 15:26:03.000000000 +1000
@@ -174,7 +174,7 @@ extern void swap_setup(void);
 /* linux/mm/vmscan.c */
 extern int try_to_free_pages(struct zone **, unsigned int, unsigned int);
 extern int shrink_all_memory(int);
-extern int vm_swappiness;
+extern int vm_mapped;
 
 #ifdef CONFIG_MMU
 /* linux/mm/shmem.c */
Index: linux-2.6.8.1-ck/include/linux/sysctl.h
===================================================================
--- linux-2.6.8.1-ck.orig/include/linux/sysctl.h	2004-08-22 10:58:05.000000000 +1000
+++ linux-2.6.8.1-ck/include/linux/sysctl.h	2004-08-22 17:46:08.687087009 +1000
@@ -159,7 +159,7 @@ enum
 	VM_OVERCOMMIT_RATIO=16, /* percent of RAM to allow overcommit in */
 	VM_PAGEBUF=17,		/* struct: Control pagebuf parameters */
 	VM_HUGETLB_PAGES=18,	/* int: Number of available Huge Pages */
-	VM_SWAPPINESS=19,	/* Tendency to steal mapped memory */
+	VM_MAPPED=19,		/* percent mapped min while evicting cache */
 	VM_LOWER_ZONE_PROTECTION=20,/* Amount of protection of lower zones */
 	VM_MIN_FREE_KBYTES=21,	/* Minimum free kilobytes to maintain */
 	VM_MAX_MAP_COUNT=22,	/* int: Maximum number of mmaps/address-space */
Index: linux-2.6.8.1-ck/kernel/sysctl.c
===================================================================
--- linux-2.6.8.1-ck.orig/kernel/sysctl.c	2004-08-22 10:58:05.000000000 +1000
+++ linux-2.6.8.1-ck/kernel/sysctl.c	2004-08-22 17:46:08.641094173 +1000
@@ -717,10 +717,10 @@ static ctl_table vm_table[] = {
 		.proc_handler	= &proc_dointvec,
 	},
 	{
-		.ctl_name	= VM_SWAPPINESS,
-		.procname	= "swappiness",
-		.data		= &vm_swappiness,
-		.maxlen		= sizeof(vm_swappiness),
+		.ctl_name	= VM_MAPPED,
+		.procname	= "mapped",
+		.data		= &vm_mapped,
+		.maxlen		= sizeof(vm_mapped),
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec_minmax,
 		.strategy	= &sysctl_intvec,
Index: linux-2.6.8.1-ck/mm/page_alloc.c
===================================================================
--- linux-2.6.8.1-ck.orig/mm/page_alloc.c	2004-08-22 10:58:00.000000000 +1000
+++ linux-2.6.8.1-ck/mm/page_alloc.c	2004-08-22 17:46:06.263464507 +1000
@@ -628,6 +628,9 @@ __alloc_pages(unsigned int gfp_mask, uns
 		 */
 		if (rt_task(p))
 			min -= z->pages_low >> 1;
+		else
+			if (wait && z->free_pages < z->pages_unmapped)
+				wakeup_kswapd(z);
 
 		if (z->free_pages >= min ||
 				(!wait && z->free_pages >= z->pages_high)) {
@@ -1905,6 +1908,7 @@ static void setup_per_zone_pages_min(voi
 
 		zone->pages_low = zone->pages_min * 2;
 		zone->pages_high = zone->pages_min * 3;
+		zone->pages_unmapped = zone->present_pages / 3;
 		spin_unlock_irqrestore(&zone->lru_lock, flags);
 	}
 }
Index: linux-2.6.8.1-ck/mm/vmscan.c
===================================================================
--- linux-2.6.8.1-ck.orig/mm/vmscan.c	2004-08-22 10:58:07.000000000 +1000
+++ linux-2.6.8.1-ck/mm/vmscan.c	2004-08-22 18:28:29.565723150 +1000
@@ -115,10 +115,7 @@ struct shrinker {
 #define prefetchw_prev_lru_page(_page, _base, _field) do { } while (0)
 #endif
 
-/*
- * From 0 .. 100.  Higher means more swappy.
- */
-int vm_swappiness = 60;
+int vm_mapped = 66;
 static long total_memory;
 
 static LIST_HEAD(shrinker_list);
@@ -338,7 +335,8 @@ static pageout_t pageout(struct page *pa
 /*
  * shrink_list adds the number of reclaimed pages to sc->nr_reclaimed
  */
-static int shrink_list(struct list_head *page_list, struct scan_control *sc)
+static int shrink_list(struct list_head *page_list, struct scan_control *sc,
+			int maplimit)
 {
 	LIST_HEAD(ret_pages);
 	struct pagevec freed_pvec;
@@ -366,6 +364,8 @@ static int shrink_list(struct list_head 
 			goto keep_locked;
 
 		sc->nr_scanned++;
+		if (maplimit && page_mapped(page))
+			goto keep_locked;
 		/* Double the slab pressure for mapped and swapcache pages */
 		if (page_mapped(page) || PageSwapCache(page))
 			sc->nr_scanned++;
@@ -543,6 +543,7 @@ static void shrink_cache(struct zone *zo
 	LIST_HEAD(page_list);
 	struct pagevec pvec;
 	int max_scan = sc->nr_to_scan;
+	int maplimit = 0;
 
 	pagevec_init(&pvec, 1);
 
@@ -584,11 +585,12 @@ static void shrink_cache(struct zone *zo
 			goto done;
 
 		max_scan -= nr_scan;
-		if (current_is_kswapd())
+		if (current_is_kswapd()) {
 			mod_page_state_zone(zone, pgscan_kswapd, nr_scan);
-		else
+			maplimit = zone->zone_pgdat->maplimit;
+		} else
 			mod_page_state_zone(zone, pgscan_direct, nr_scan);
-		nr_freed = shrink_list(&page_list, sc);
+		nr_freed = shrink_list(&page_list, sc, maplimit);
 		if (current_is_kswapd())
 			mod_page_state(kswapd_steal, nr_freed);
 		mod_page_state_zone(zone, pgsteal, nr_freed);
@@ -648,10 +650,6 @@ refill_inactive_zone(struct zone *zone, 
 	LIST_HEAD(l_active);	/* Pages to go onto the active_list */
 	struct page *page;
 	struct pagevec pvec;
-	int reclaim_mapped = 0;
-	long mapped_ratio;
-	long distress;
-	long swap_tendency;
 
 	lru_add_drain();
 	pgmoved = 0;
@@ -681,42 +679,11 @@ refill_inactive_zone(struct zone *zone, 
 	zone->nr_active -= pgmoved;
 	spin_unlock_irq(&zone->lru_lock);
 
-	/*
-	 * `distress' is a measure of how much trouble we're having reclaiming
-	 * pages.  0 -> no problems.  100 -> great trouble.
-	 */
-	distress = 100 >> zone->prev_priority;
-
-	/*
-	 * The point of this algorithm is to decide when to start reclaiming
-	 * mapped memory instead of just pagecache.  Work out how much memory
-	 * is mapped.
-	 */
-	mapped_ratio = (sc->nr_mapped * 100) / total_memory;
-
-	/*
-	 * Now decide how much we really want to unmap some pages.  The mapped
-	 * ratio is downgraded - just because there's a lot of mapped memory
-	 * doesn't necessarily mean that page reclaim isn't succeeding.
-	 *
-	 * The distress ratio is important - we don't want to start going oom.
-	 *
-	 * A 100% value of vm_swappiness overrides this algorithm altogether.
-	 */
-	swap_tendency = mapped_ratio / 2 + distress + vm_swappiness;
-
-	/*
-	 * Now use this metric to decide whether to start moving mapped memory
-	 * onto the inactive list.
-	 */
-	if (swap_tendency >= 100)
-		reclaim_mapped = 1;
-
 	while (!list_empty(&l_hold)) {
 		page = lru_to_page(&l_hold);
 		list_del(&page->lru);
 		if (page_mapped(page)) {
-			if (!reclaim_mapped) {
+			if (zone->zone_pgdat->maplimit) {
 				list_add(&page->lru, &l_active);
 				continue;
 			}
@@ -981,7 +948,7 @@ out:
  * the page allocator fallback scheme to ensure that aging of pages is balanced
  * across the zones.
  */
-static int balance_pgdat(pg_data_t *pgdat, int nr_pages)
+static int balance_pgdat(pg_data_t *pgdat, int nr_pages, int maplimit)
 {
 	int to_free = nr_pages;
 	int priority;
@@ -1006,7 +973,15 @@ static int balance_pgdat(pg_data_t *pgda
 		int all_zones_ok = 1;
 		int end_zone = 0;	/* Inclusive.  0 = ZONE_DMA */
 		unsigned long lru_pages = 0;
+		int mapped_ratio = sc.nr_mapped * 100 / total_memory;
 
+		if (maplimit && (mapped_ratio > vm_mapped ||
+			priority < DEF_PRIORITY))
+			/*
+			 * Evict pages only if mapped_ratio < vm_mapped and
+			 * only do low priority scanning.
+			 */
+				goto out;
 		if (nr_pages == 0) {
 			/*
 			 * Scan in the highmem->dma direction for the highest
@@ -1019,10 +994,13 @@ static int balance_pgdat(pg_data_t *pgda
 						priority != DEF_PRIORITY)
 					continue;
 
-				if (zone->free_pages <= zone->pages_high) {
-					end_zone = i;
-					goto scan;
+				if (zone->free_pages <= zone->pages_high ||
+					(maplimit && zone->free_pages <= 
+					zone->pages_unmapped)) {
+						end_zone = i;
+						goto scan;
 				}
+
 			}
 			goto out;
 		} else {
@@ -1148,7 +1126,7 @@ static int kswapd(void *p)
 		schedule();
 		finish_wait(&pgdat->kswapd_wait, &wait);
 
-		balance_pgdat(pgdat, 0);
+		balance_pgdat(pgdat, 0, pgdat->maplimit);
 	}
 	return 0;
 }
@@ -1158,11 +1136,14 @@ static int kswapd(void *p)
  */
 void wakeup_kswapd(struct zone *zone)
 {
-	if (zone->free_pages > zone->pages_low)
+	if (zone->free_pages > zone->pages_unmapped)
 		return;
+	if (zone->free_pages > zone->pages_low)
+		zone->zone_pgdat->maplimit = 1;
 	if (!waitqueue_active(&zone->zone_pgdat->kswapd_wait))
 		return;
 	wake_up_interruptible(&zone->zone_pgdat->kswapd_wait);
+	zone->zone_pgdat->maplimit = 0;
 }
 
 #ifdef CONFIG_PM
@@ -1182,7 +1163,7 @@ int shrink_all_memory(int nr_pages)
 	current->reclaim_state = &reclaim_state;
 	for_each_pgdat(pgdat) {
 		int freed;
-		freed = balance_pgdat(pgdat, nr_to_free);
+		freed = balance_pgdat(pgdat, nr_to_free, 0);
 		ret += freed;
 		nr_to_free -= freed;
 		if (nr_to_free <= 0)

--------------010504000608000002070608--

--------------enig708B7F4ED23EA35EB28C0915
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD4DBQFBKRIwZUg7+tp6mRURAqljAJ4kaFVB5LxFIZWdVnGORS3Ts25huQCWIlgE
h/Iovng7hfy6Y/NubJAzlQ==
=rSAY
-----END PGP SIGNATURE-----

--------------enig708B7F4ED23EA35EB28C0915--
