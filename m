Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964795AbWDUVfT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964795AbWDUVfT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 17:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964797AbWDUVfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 17:35:19 -0400
Received: from cust8446.nsw01.dataco.com.au ([203.171.93.254]:19949 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S964793AbWDUVfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 17:35:17 -0400
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: Rafael Wysoki <rjw@sisk.pl>, Con Kolivas <kernel@kolivas.org>
Subject: Updated version of shrink_all_memory tweaks.
Date: Fri, 21 Apr 2006 20:39:14 +1000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2588561.bQfvHWbHUj";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200604212039.19676.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2588561.bQfvHWbHUj
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

I give the shrink_all_memory tweaks a try today, and fixed a couple of
mistakes that meant too much memory was still freed. With this version of t=
he
patch, you get at most exactly what you ask for.

This version is for 2.6.17-rc2. Just in case they're not obvious, the chang=
es=20
are limited to taking account of what has already been freed in subsequent=
=20
calls to shrink_all_zones (swap_cluster_max is updated, and nr_to_scan is=20
modified similarly).

Regards,

Nigel

 kernel/power/swsusp.c |   10 +-
 mm/vmscan.c           |  216=20
+++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 168 insertions(+), 58 deletions(-)
diff -ruNp 9930-shrink-less-memory.patch-old/kernel/power/swsusp.c=20
9930-shrink-less-memory.patch-new/kernel/power/swsusp.c
=2D-- 9930-shrink-less-memory.patch-old/kernel/power/swsusp.c	2006-04-21=20
19:53:52.000000000 +1000
+++ 9930-shrink-less-memory.patch-new/kernel/power/swsusp.c	2006-04-20=20
08:39:47.000000000 +1000
@@ -178,6 +178,12 @@ void free_all_swap_pages(int swap, struc
  */
=20
 #define SHRINK_BITE	10000
+static inline unsigned long __shrink_memory(long tmp)
+{
+	if (tmp > SHRINK_BITE)
+		tmp =3D SHRINK_BITE;
+	return shrink_all_memory(tmp);
+}
=20
 int swsusp_shrink_memory(void)
 {
@@ -200,12 +206,12 @@ int swsusp_shrink_memory(void)
 			if (!is_highmem(zone))
 				tmp -=3D zone->free_pages;
 		if (tmp > 0) {
=2D			tmp =3D shrink_all_memory(SHRINK_BITE);
+			tmp =3D __shrink_memory(tmp);
 			if (!tmp)
 				return -ENOMEM;
 			pages +=3D tmp;
 		} else if (size > image_size / PAGE_SIZE) {
=2D			tmp =3D shrink_all_memory(SHRINK_BITE);
+			tmp =3D __shrink_memory(size - (image_size / PAGE_SIZE));
 			pages +=3D tmp;
 		}
 		printk("\b%c", p[i++%4]);
diff -ruNp 9930-shrink-less-memory.patch-old/mm/vmscan.c=20
9930-shrink-less-memory.patch-new/mm/vmscan.c
=2D-- 9930-shrink-less-memory.patch-old/mm/vmscan.c	2006-04-21=20
19:53:52.000000000 +1000
+++ 9930-shrink-less-memory.patch-new/mm/vmscan.c	2006-04-21=20
19:54:02.000000000 +1000
@@ -203,7 +203,7 @@ unsigned long shrink_slab(unsigned long=20
 		total_scan =3D shrinker->nr;
 		shrinker->nr =3D 0;
=20
=2D		while (total_scan >=3D SHRINK_BATCH) {
+		while (total_scan >=3D SHRINK_BATCH && ret < scanned) {
 			long this_scan =3D SHRINK_BATCH;
 			int shrink_ret;
 			int nr_before;
@@ -1021,10 +1021,6 @@ out:
  * For kswapd, balance_pgdat() will work across all this node's zones until
  * they are all at pages_high.
  *
=2D * If `nr_pages' is non-zero then it is the number of pages which are to=
 be
=2D * reclaimed, regardless of the zone occupancies.  This is a software su=
spend
=2D * special.
=2D *
  * Returns the number of pages which were actually freed.
  *
  * There is special handling here for zones which are full of pinned pages.
@@ -1042,10 +1038,8 @@ out:
  * the page allocator fallback scheme to ensure that aging of pages is=20
balanced
  * across the zones.
  */
=2Dstatic unsigned long balance_pgdat(pg_data_t *pgdat, unsigned long nr_pa=
ges,
=2D				int order)
+static unsigned long balance_pgdat(pg_data_t *pgdat, int order)
 {
=2D	unsigned long to_free =3D nr_pages;
 	int all_zones_ok;
 	int priority;
 	int i;
@@ -1055,7 +1049,7 @@ static unsigned long balance_pgdat(pg_da
 	struct scan_control sc =3D {
 		.gfp_mask =3D GFP_KERNEL,
 		.may_swap =3D 1,
=2D		.swap_cluster_max =3D nr_pages ? nr_pages : SWAP_CLUSTER_MAX,
+		.swap_cluster_max =3D SWAP_CLUSTER_MAX,
 	};
=20
 loop_again:
@@ -1082,31 +1076,27 @@ loop_again:
=20
 		all_zones_ok =3D 1;
=20
=2D		if (nr_pages =3D=3D 0) {
=2D			/*
=2D			 * Scan in the highmem->dma direction for the highest
=2D			 * zone which needs scanning
=2D			 */
=2D			for (i =3D pgdat->nr_zones - 1; i >=3D 0; i--) {
=2D				struct zone *zone =3D pgdat->node_zones + i;
+		/*
+		 * Scan in the highmem->dma direction for the highest
+		 * zone which needs scanning
+		 */
+		for (i =3D pgdat->nr_zones - 1; i >=3D 0; i--) {
+			struct zone *zone =3D pgdat->node_zones + i;
+
+			if (!populated_zone(zone))
+				continue;
=20
=2D				if (!populated_zone(zone))
=2D					continue;
+			if (zone->all_unreclaimable &&
+					priority !=3D DEF_PRIORITY)
+				continue;
=20
=2D				if (zone->all_unreclaimable &&
=2D						priority !=3D DEF_PRIORITY)
=2D					continue;
=2D
=2D				if (!zone_watermark_ok(zone, order,
=2D						zone->pages_high, 0, 0)) {
=2D					end_zone =3D i;
=2D					goto scan;
=2D				}
+			if (!zone_watermark_ok(zone, order, zone->pages_high,
+					       0, 0)) {
+				end_zone =3D i;
+				goto scan;
 			}
=2D			goto out;
=2D		} else {
=2D			end_zone =3D pgdat->nr_zones - 1;
 		}
+		goto out;
 scan:
 		for (i =3D 0; i <=3D end_zone; i++) {
 			struct zone *zone =3D pgdat->node_zones + i;
@@ -1133,11 +1123,9 @@ scan:
 			if (zone->all_unreclaimable && priority !=3D DEF_PRIORITY)
 				continue;
=20
=2D			if (nr_pages =3D=3D 0) {	/* Not software suspend */
=2D				if (!zone_watermark_ok(zone, order,
=2D						zone->pages_high, end_zone, 0))
=2D					all_zones_ok =3D 0;
=2D			}
+			if (!zone_watermark_ok(zone, order, zone->pages_high,
+					       end_zone, 0))
+				all_zones_ok =3D 0;
 			zone->temp_priority =3D priority;
 			if (zone->prev_priority > priority)
 				zone->prev_priority =3D priority;
@@ -1162,8 +1150,6 @@ scan:
 			    total_scanned > nr_reclaimed + nr_reclaimed / 2)
 				sc.may_writepage =3D 1;
 		}
=2D		if (nr_pages && to_free > nr_reclaimed)
=2D			continue;	/* swsusp: need to do more work */
 		if (all_zones_ok)
 			break;		/* kswapd: all done */
 		/*
@@ -1179,7 +1165,7 @@ scan:
 		 * matches the direct reclaim path behaviour in terms of impact
 		 * on zone->*_priority.
 		 */
=2D		if ((nr_reclaimed >=3D SWAP_CLUSTER_MAX) && !nr_pages)
+		if (nr_reclaimed >=3D SWAP_CLUSTER_MAX)
 			break;
 	}
 out:
@@ -1262,7 +1248,7 @@ static int kswapd(void *p)
 		}
 		finish_wait(&pgdat->kswapd_wait, &wait);
=20
=2D		balance_pgdat(pgdat, 0, order);
+		balance_pgdat(pgdat, order);
 	}
 	return 0;
 }
@@ -1291,35 +1277,153 @@ void wakeup_kswapd(struct zone *zone, in
=20
 #ifdef CONFIG_PM
 /*
=2D * Try to free `nr_pages' of memory, system-wide.  Returns the number of=
=20
freed
=2D * pages.
+ * Helper function for shrink_all_memory().  Tries to reclaim 'nr_pages'=20
pages
+ * from LRU lists system-wide, for given pass and priority, and returns the
+ * number of reclaimed pages
+ *
+ * For pass > 3 we also try to shrink the LRU lists that contain a few pag=
es
+ */
+unsigned long shrink_all_zones(unsigned long nr_pages, int pass, int prio,
+				struct scan_control *sc)
+{
+	struct zone *zone;
+	unsigned long nr_to_scan, ret =3D 0;
+
+	for_each_zone(zone) {
+
+		if (!populated_zone(zone))
+			continue;
+
+		if (zone->all_unreclaimable && prio !=3D DEF_PRIORITY)
+			continue;
+
+		/* For pass =3D 0 we don't shrink the active list */
+		if (pass > 0) {
+			zone->nr_scan_active +=3D (zone->nr_active >> prio) + 1;
+			if (zone->nr_scan_active >=3D nr_pages || pass > 3) {
+				zone->nr_scan_active =3D 0;
+				nr_to_scan =3D min(nr_pages, zone->nr_active);
+				shrink_active_list(nr_to_scan, zone, sc);
+			}
+		}
+
+		zone->nr_scan_inactive +=3D (zone->nr_inactive >> prio) + 1;
+		if (zone->nr_scan_inactive >=3D (nr_pages - ret) || pass > 3) {
+			zone->nr_scan_inactive =3D 0;
+			nr_to_scan =3D min(nr_pages - ret, zone->nr_inactive);
+			ret +=3D shrink_inactive_list(nr_to_scan, zone, sc);
+			if (ret >=3D nr_pages)
+				return ret;
+		}
+	}
+
+	return ret;
+}
+
+/*
+ * Try to free `nr_pages' of memory, system-wide, and return the number of
+ * freed pages.
+ *
+ * Rather than trying to age LRUs the aim is to preserve the overall
+ * LRU order by reclaiming preferentially
+ * inactive > active > active referenced > active mapped
  */
 unsigned long shrink_all_memory(unsigned long nr_pages)
 {
=2D	pg_data_t *pgdat;
=2D	unsigned long nr_to_free =3D nr_pages;
+	unsigned long lru_pages, nr_slab;
 	unsigned long ret =3D 0;
=2D	unsigned retry =3D 2;
=2D	struct reclaim_state reclaim_state =3D {
=2D		.reclaimed_slab =3D 0,
+	int swappiness =3D vm_swappiness, pass;
+	struct reclaim_state reclaim_state;
+	struct zone *zone;
+	struct scan_control sc =3D {
+		.gfp_mask =3D GFP_KERNEL,
+		.may_swap =3D 1,
+		.swap_cluster_max =3D nr_pages,
+		.may_writepage =3D 1,
 	};
=20
 	current->reclaim_state =3D &reclaim_state;
=2Drepeat:
=2D	for_each_online_pgdat(pgdat) {
=2D		unsigned long freed;
=20
=2D		freed =3D balance_pgdat(pgdat, nr_to_free, 0);
=2D		ret +=3D freed;
=2D		nr_to_free -=3D freed;
=2D		if ((long)nr_to_free <=3D 0)
+	lru_pages =3D 0;
+	for_each_zone(zone)
+		lru_pages +=3D zone->nr_active + zone->nr_inactive;
+	nr_slab =3D read_page_state(nr_slab);
+	/* If slab caches are huge, it's better to hit them first */
+	while (nr_slab >=3D lru_pages) {
+		reclaim_state.reclaimed_slab =3D 0;
+		shrink_slab(nr_pages, sc.gfp_mask, lru_pages);
+		if (!reclaim_state.reclaimed_slab)
 			break;
+
+		ret +=3D reclaim_state.reclaimed_slab;
+		if (ret >=3D nr_pages)
+			goto out;
+
+		nr_slab -=3D reclaim_state.reclaimed_slab;
 	}
=2D	if (retry-- && ret < nr_pages) {
=2D		blk_congestion_wait(WRITE, HZ/5);
=2D		goto repeat;
+
+	/*
+	 * We try to shrink LRUs in 5 passes:
+	 * 0 =3D Reclaim from inactive_list only
+	 * 1 =3D Reclaim from active list but don't reclaim mapped
+	 * 2 =3D 2nd pass of type 1
+	 * 3 =3D Reclaim mapped (normal reclaim)
+	 * 4 =3D 2nd pass of type 3
+	 */
+	for (pass =3D 0; pass < 5; pass++) {
+		int prio;
+
+		/* Needed for shrinking slab caches later on */
+		if (!lru_pages)
+			for_each_zone(zone) {
+				lru_pages +=3D zone->nr_active;
+				lru_pages +=3D zone->nr_inactive;
+			}
+
+		/* Force reclaiming mapped pages in the passes #3 and #4 */
+		if (pass > 2)
+			vm_swappiness =3D 100;
+
+		for (prio =3D DEF_PRIORITY; prio >=3D 0; prio--) {
+			unsigned long nr_to_scan =3D nr_pages - ret;
+
+			sc.nr_mapped =3D read_page_state(nr_mapped);
+			sc.nr_scanned =3D 0;
+			sc.swap_cluster_max =3D nr_pages - ret;
+
+			ret +=3D shrink_all_zones(nr_to_scan, prio, pass, &sc);
+			if (ret >=3D nr_pages)
+				goto out;
+
+			reclaim_state.reclaimed_slab =3D 0;
+			shrink_slab(sc.nr_scanned, sc.gfp_mask, lru_pages);
+			ret +=3D reclaim_state.reclaimed_slab;
+			if (ret >=3D nr_pages)
+				goto out;
+
+			if (sc.nr_scanned && prio < DEF_PRIORITY - 2)
+				blk_congestion_wait(WRITE, HZ / 10);
+		}
+
+		lru_pages =3D 0;
 	}
+
+
+	/*
+	 * If ret =3D 0, we could not shrink LRUs, but there may be something
+	 * in slab caches
+	 */
+	if (!ret)
+		do {
+			reclaim_state.reclaimed_slab =3D 0;
+			shrink_slab(nr_pages, sc.gfp_mask, lru_pages);
+			ret +=3D reclaim_state.reclaimed_slab;
+		} while (ret < nr_pages && reclaim_state.reclaimed_slab > 0);
+
+out:
 	current->reclaim_state =3D NULL;
+	vm_swappiness =3D swappiness;
+
 	return ret;
 }
 #endif

--nextPart2588561.bQfvHWbHUj
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBESLZXN0y+n1M3mo0RAopVAKC9sJ5wzK3YbxDjQ0M3c+3589Z4LwCdHnmU
LDPEy/GAUdLLYrkRsU39DNU=
=rzp1
-----END PGP SIGNATURE-----

--nextPart2588561.bQfvHWbHUj--
