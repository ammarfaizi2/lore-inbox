Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266793AbUHZAM2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266793AbUHZAM2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 20:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266845AbUHZAM2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 20:12:28 -0400
Received: from mail018.syd.optusnet.com.au ([211.29.132.72]:28389 "EHLO
	mail018.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S266793AbUHZALI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 20:11:08 -0400
Message-ID: <412D2A84.7010705@kolivas.org>
Date: Thu, 26 Aug 2004 10:10:44 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
Cc: ck kernel mailing list <ck@vds.kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.8.1-ck4
References: <Pine.LNX.4.44.0408251621160.5145-100000@chimarrao.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.44.0408251621160.5145-100000@chimarrao.boston.redhat.com>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB86E2F494FC5D74A262F1855"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB86E2F494FC5D74A262F1855
Content-Type: multipart/mixed;
 boundary="------------050904040309040008010403"

This is a multi-part message in MIME format.
--------------050904040309040008010403
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Rik van Riel wrote:
> On Sun, 22 Aug 2004, Con Kolivas wrote:
> 
> 
>>Added since 2.6.8.1-ck3:
>>+mapped_watermark.diff
> 
> 
> Sounds like a bad idea for file servers ;)
> 
> Wouldn't it be better to lazily move these cached pages to
> a "cached" list like the BSDs have, and reclaim it immediately
> when the memory is needed for something else ?
> 
> It should be easy enough to keep the cached data around and
> still have the cache pages easily reclaimable.

Sounds like a good idea. Would this leave us with large buddies though? 
Also with file caching it tends to do very little so the ram does indeed 
fill up still. Furthermore, setting mapped to 0 basically disables it 
anyway so that shouldn't be an issue. Currently file servers are 
recommended to tune the "swappiness" value to 100 in the same manner.

This is the buddy condition the machine looks like after it's been 
running for days with this patch in situ.

cat /proc/buddyinfo
Node 0, zone      DMA     15     14     10     11     13     11      9 
     5      3      1      0
Node 0, zone   Normal  15778  17800   6885    722     14      1      3 
     0      0      1      0

Just FYI here's the current version of the patch.

Cheers,
Con

  include/linux/mmzone.h |    3 +
  include/linux/swap.h   |    2 -
  include/linux/sysctl.h |    2 -
  kernel/sysctl.c        |    8 ++--
  mm/page_alloc.c        |    5 ++
  mm/vmscan.c            |   98 
+++++++++++++++++++++++--------------------------
  6 files changed, 59 insertions(+), 59 deletions(-)

--------------050904040309040008010403
Content-Type: text/x-patch;
 name="mapped_watermark2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mapped_watermark2.diff"

Index: linux-2.6.8.1/include/linux/mmzone.h
===================================================================
--- linux-2.6.8.1.orig/include/linux/mmzone.h	2004-08-15 14:08:19.000000000 +1000
+++ linux-2.6.8.1/include/linux/mmzone.h	2004-08-26 10:01:38.153695699 +1000
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
Index: linux-2.6.8.1/include/linux/swap.h
===================================================================
--- linux-2.6.8.1.orig/include/linux/swap.h	2004-08-15 14:08:19.000000000 +1000
+++ linux-2.6.8.1/include/linux/swap.h	2004-08-26 10:01:38.154695545 +1000
@@ -174,7 +174,7 @@ extern void swap_setup(void);
 /* linux/mm/vmscan.c */
 extern int try_to_free_pages(struct zone **, unsigned int, unsigned int);
 extern int shrink_all_memory(int);
-extern int vm_swappiness;
+extern int vm_mapped;
 
 #ifdef CONFIG_MMU
 /* linux/mm/shmem.c */
Index: linux-2.6.8.1/include/linux/sysctl.h
===================================================================
--- linux-2.6.8.1.orig/include/linux/sysctl.h	2004-08-15 14:08:19.000000000 +1000
+++ linux-2.6.8.1/include/linux/sysctl.h	2004-08-26 10:01:38.155695390 +1000
@@ -157,7 +157,7 @@ enum
 	VM_OVERCOMMIT_RATIO=16, /* percent of RAM to allow overcommit in */
 	VM_PAGEBUF=17,		/* struct: Control pagebuf parameters */
 	VM_HUGETLB_PAGES=18,	/* int: Number of available Huge Pages */
-	VM_SWAPPINESS=19,	/* Tendency to steal mapped memory */
+	VM_MAPPED=19,		/* percent mapped min while evicting cache */
 	VM_LOWER_ZONE_PROTECTION=20,/* Amount of protection of lower zones */
 	VM_MIN_FREE_KBYTES=21,	/* Minimum free kilobytes to maintain */
 	VM_MAX_MAP_COUNT=22,	/* int: Maximum number of mmaps/address-space */
Index: linux-2.6.8.1/kernel/sysctl.c
===================================================================
--- linux-2.6.8.1.orig/kernel/sysctl.c	2004-08-15 14:08:19.000000000 +1000
+++ linux-2.6.8.1/kernel/sysctl.c	2004-08-26 10:01:38.156695236 +1000
@@ -701,10 +701,10 @@ static ctl_table vm_table[] = {
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
Index: linux-2.6.8.1/mm/page_alloc.c
===================================================================
--- linux-2.6.8.1.orig/mm/page_alloc.c	2004-08-15 14:08:19.000000000 +1000
+++ linux-2.6.8.1/mm/page_alloc.c	2004-08-26 10:01:42.205069628 +1000
@@ -628,6 +628,10 @@ __alloc_pages(unsigned int gfp_mask, uns
 		 */
 		if (rt_task(p))
 			min -= z->pages_low >> 1;
+		else if (vm_mapped && wait && 
+			z->free_pages < z->pages_unmapped &&
+			z->free_pages > z->pages_low)
+				wakeup_kswapd(z);
 
 		if (z->free_pages >= min ||
 				(!wait && z->free_pages >= z->pages_high)) {
@@ -1905,6 +1909,7 @@ static void setup_per_zone_pages_min(voi
 
 		zone->pages_low = zone->pages_min * 2;
 		zone->pages_high = zone->pages_min * 3;
+		zone->pages_unmapped = zone->present_pages / 3;
 		spin_unlock_irqrestore(&zone->lru_lock, flags);
 	}
 }
Index: linux-2.6.8.1/mm/vmscan.c
===================================================================
--- linux-2.6.8.1.orig/mm/vmscan.c	2004-08-15 14:08:19.000000000 +1000
+++ linux-2.6.8.1/mm/vmscan.c	2004-08-26 10:01:42.207069319 +1000
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
@@ -994,6 +961,20 @@ static int balance_pgdat(pg_data_t *pgda
 	sc.may_writepage = 0;
 	sc.nr_mapped = read_page_state(nr_mapped);
 
+	/*
+	 * Sanity check to ensure we don't have a stale maplimit set
+	 * and are calling balance_pgdat for a different reason.
+	 */
+	if (nr_pages)
+		maplimit = 0;
+	/*
+	 * kswapd does a light balance_pgdat() when there is less than 1/3
+	 * ram free provided there is less than vm_mapped % of that ram 
+	 * mapped.
+	 */
+	if (maplimit && sc.nr_mapped * 100 / total_memory > vm_mapped)
+		return 0;
+
 	inc_page_state(pageoutrun);
 
 	for (i = 0; i < pgdat->nr_zones; i++) {
@@ -1007,6 +988,12 @@ static int balance_pgdat(pg_data_t *pgda
 		int end_zone = 0;	/* Inclusive.  0 = ZONE_DMA */
 		unsigned long lru_pages = 0;
 
+		/*
+		 * Only do low priority scanning if we're here due to
+		 * mapped watermark.
+		 */
+		if (maplimit && priority < DEF_PRIORITY)
+			goto out;
 		if (nr_pages == 0) {
 			/*
 			 * Scan in the highmem->dma direction for the highest
@@ -1019,10 +1006,13 @@ static int balance_pgdat(pg_data_t *pgda
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
@@ -1148,7 +1138,7 @@ static int kswapd(void *p)
 		schedule();
 		finish_wait(&pgdat->kswapd_wait, &wait);
 
-		balance_pgdat(pgdat, 0);
+		balance_pgdat(pgdat, 0, pgdat->maplimit);
 	}
 	return 0;
 }
@@ -1158,11 +1148,15 @@ static int kswapd(void *p)
  */
 void wakeup_kswapd(struct zone *zone)
 {
+	if (zone->free_pages > zone->pages_unmapped)
+		goto out;
 	if (zone->free_pages > zone->pages_low)
-		return;
+		zone->zone_pgdat->maplimit = 1;
 	if (!waitqueue_active(&zone->zone_pgdat->kswapd_wait))
-		return;
+		goto out;
 	wake_up_interruptible(&zone->zone_pgdat->kswapd_wait);
+out:
+	zone->zone_pgdat->maplimit = 0;
 }
 
 #ifdef CONFIG_PM
@@ -1182,7 +1176,7 @@ int shrink_all_memory(int nr_pages)
 	current->reclaim_state = &reclaim_state;
 	for_each_pgdat(pgdat) {
 		int freed;
-		freed = balance_pgdat(pgdat, nr_to_free);
+		freed = balance_pgdat(pgdat, nr_to_free, 0);
 		ret += freed;
 		nr_to_free -= freed;
 		if (nr_to_free <= 0)

--------------050904040309040008010403--

--------------enigB86E2F494FC5D74A262F1855
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBLSqHZUg7+tp6mRURAt3iAJ903Bnebgnqq0DMH3zFD0cgBK1QLgCaAqFM
kKv03ML69C8TGd9xB+c64ag=
=qvGD
-----END PGP SIGNATURE-----

--------------enigB86E2F494FC5D74A262F1855--
