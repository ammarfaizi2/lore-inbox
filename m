Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267945AbUHKFPy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267945AbUHKFPy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 01:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267943AbUHKFPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 01:15:54 -0400
Received: from fw.osdl.org ([65.172.181.6]:3457 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267945AbUHKFPm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 01:15:42 -0400
Date: Tue, 10 Aug 2004 22:15:34 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: Possible dcache BUG
In-Reply-To: <Pine.LNX.4.58.0408102201510.1839@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0408102213250.1839@ppc970.osdl.org>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org>
 <20040808113930.24ae0273.akpm@osdl.org> <200408100012.08945.gene.heskett@verizon.net>
 <200408102342.12792.gene.heskett@verizon.net> <Pine.LNX.4.58.0408102044220.1839@ppc970.osdl.org>
 <20040810211849.0d556af4@laptop.delusion.de> <Pine.LNX.4.58.0408102201510.1839@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 10 Aug 2004, Linus Torvalds wrote:
> 
> So I suspect it's a balancing issue. Possibly just the slight change in 
> slab balancing to fix the highmem problems. Maybe we shrink slab _too_ 
> aggressively or something. 

Udo, that's a simple thing to check. If it's the slab balancing changes, 
then you should be able to test it with just a

	bk cset -x1.1830.4.3

if you have the current BK and are a BK user, or by just revertign the 
patch here ("patch -R -p1" from inside your linux source tree) if you're 
not a BK user..

		Linus

-----
# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/07/31 14:47:41-07:00 akpm@osdl.org 
#   [PATCH] slab memory shrinking balancing fix
#   
#   The logic in shrink_slab tries to balance the proportion of slab which it
#   scans against the proportion of pagecache which the caller scanned.  Problem
#   is that with a large number of highmem LRU pages and a small number of lowmem
#   LRU pages, the amount of pagecache scanning appears to be very small, so we
#   don't push slab hard enough.
#   
#   The patch changes things so that for, say, a GFP_KERNEL allocation attempt we
#   only consider ZONE_NORMAL and ZONE_DMA when calculating "what proportion of
#   the LRU did the caller just scan".
#   
#   This will have the effect of shrinking slab harder in response to GFP_KERNEL
#   allocations than for GFP_HIGHMEM allocations.
#   
#   Signed-off-by: Andrew Morton <akpm@osdl.org>
#   Signed-off-by: Linus Torvalds <torvalds@osdl.org>
# 
# mm/vmscan.c
#   2004/07/31 14:35:31-07:00 akpm@osdl.org +23 -9
#   slab memory shrinking balancing fix
# 
# mm/page_alloc.c
#   2004/07/31 14:02:21-07:00 akpm@osdl.org +0 -11
#   slab memory shrinking balancing fix
# 
# include/linux/mm.h
#   2004/07/31 14:02:26-07:00 akpm@osdl.org +0 -2
#   slab memory shrinking balancing fix
# 
diff -Nru a/include/linux/mm.h b/include/linux/mm.h
--- a/include/linux/mm.h	2004-08-10 22:15:23 -07:00
+++ b/include/linux/mm.h	2004-08-10 22:15:23 -07:00
@@ -706,8 +706,6 @@
 
 extern struct vm_area_struct *find_extend_vma(struct mm_struct *mm, unsigned long addr);
 
-extern unsigned int nr_used_zone_pages(void);
-
 extern struct page * vmalloc_to_page(void *addr);
 extern struct page * follow_page(struct mm_struct *mm, unsigned long address,
 		int write);
diff -Nru a/mm/page_alloc.c b/mm/page_alloc.c
--- a/mm/page_alloc.c	2004-08-10 22:15:23 -07:00
+++ b/mm/page_alloc.c	2004-08-10 22:15:23 -07:00
@@ -825,17 +825,6 @@
 
 EXPORT_SYMBOL(nr_free_pages);
 
-unsigned int nr_used_zone_pages(void)
-{
-	unsigned int pages = 0;
-	struct zone *zone;
-
-	for_each_zone(zone)
-		pages += zone->nr_active + zone->nr_inactive;
-
-	return pages;
-}
-
 #ifdef CONFIG_NUMA
 unsigned int nr_free_pages_pgdat(pg_data_t *pgdat)
 {
diff -Nru a/mm/vmscan.c b/mm/vmscan.c
--- a/mm/vmscan.c	2004-08-10 22:15:23 -07:00
+++ b/mm/vmscan.c	2004-08-10 22:15:23 -07:00
@@ -169,22 +169,25 @@
  * slab to avoid swapping.
  *
  * We do weird things to avoid (scanned*seeks*entries) overflowing 32 bits.
+ *
+ * `lru_pages' represents the number of on-LRU pages in all the zones which
+ * are eligible for the caller's allocation attempt.  It is used for balancing
+ * slab reclaim versus page reclaim.
  */
-static int shrink_slab(unsigned long scanned, unsigned int gfp_mask)
+static int shrink_slab(unsigned long scanned, unsigned int gfp_mask,
+			unsigned long lru_pages)
 {
 	struct shrinker *shrinker;
-	long pages;
 
 	if (down_trylock(&shrinker_sem))
 		return 0;
 
-	pages = nr_used_zone_pages();
 	list_for_each_entry(shrinker, &shrinker_list, list) {
 		unsigned long long delta;
 
 		delta = (4 * scanned) / shrinker->seeks;
 		delta *= (*shrinker->shrinker)(0, gfp_mask);
-		do_div(delta, pages + 1);
+		do_div(delta, lru_pages + 1);
 		shrinker->nr += delta;
 		if (shrinker->nr < 0)
 			shrinker->nr = LONG_MAX;	/* It wrapped! */
@@ -896,6 +899,7 @@
 	int total_scanned = 0, total_reclaimed = 0;
 	struct reclaim_state *reclaim_state = current->reclaim_state;
 	struct scan_control sc;
+	unsigned long lru_pages = 0;
 	int i;
 
 	sc.gfp_mask = gfp_mask;
@@ -903,8 +907,12 @@
 
 	inc_page_state(allocstall);
 
-	for (i = 0; zones[i] != 0; i++)
-		zones[i]->temp_priority = DEF_PRIORITY;
+	for (i = 0; zones[i] != NULL; i++) {
+		struct zone *zone = zones[i];
+
+		zone->temp_priority = DEF_PRIORITY;
+		lru_pages += zone->nr_active + zone->nr_inactive;
+	}
 
 	for (priority = DEF_PRIORITY; priority >= 0; priority--) {
 		sc.nr_mapped = read_page_state(nr_mapped);
@@ -912,7 +920,7 @@
 		sc.nr_reclaimed = 0;
 		sc.priority = priority;
 		shrink_caches(zones, &sc);
-		shrink_slab(sc.nr_scanned, gfp_mask);
+		shrink_slab(sc.nr_scanned, gfp_mask, lru_pages);
 		if (reclaim_state) {
 			sc.nr_reclaimed += reclaim_state->reclaimed_slab;
 			reclaim_state->reclaimed_slab = 0;
@@ -997,7 +1005,7 @@
 	for (priority = DEF_PRIORITY; priority >= 0; priority--) {
 		int all_zones_ok = 1;
 		int end_zone = 0;	/* Inclusive.  0 = ZONE_DMA */
-
+		unsigned long lru_pages = 0;
 
 		if (nr_pages == 0) {
 			/*
@@ -1021,6 +1029,12 @@
 			end_zone = pgdat->nr_zones - 1;
 		}
 scan:
+		for (i = 0; i <= end_zone; i++) {
+			struct zone *zone = pgdat->node_zones + i;
+
+			lru_pages += zone->nr_active + zone->nr_inactive;
+		}
+
 		/*
 		 * Now scan the zone in the dma->highmem direction, stopping
 		 * at the last zone which needs scanning.
@@ -1048,7 +1062,7 @@
 			sc.priority = priority;
 			shrink_zone(zone, &sc);
 			reclaim_state->reclaimed_slab = 0;
-			shrink_slab(sc.nr_scanned, GFP_KERNEL);
+			shrink_slab(sc.nr_scanned, GFP_KERNEL, lru_pages);
 			sc.nr_reclaimed += reclaim_state->reclaimed_slab;
 			total_reclaimed += sc.nr_reclaimed;
 			if (zone->all_unreclaimable)
