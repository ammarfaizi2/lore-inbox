Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264479AbUGaVlY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264479AbUGaVlY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 17:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264519AbUGaVlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 17:41:23 -0400
Received: from fw.osdl.org ([65.172.181.6]:64748 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264479AbUGaVlP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 17:41:15 -0400
Date: Sat, 31 Jul 2004 14:39:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: marcelo.tosatti@cyclades.com, kladit@t-online.de,
       linux-kernel@vger.kernel.org
Subject: Re: dentry cache leak? Re: rsync out of memory 2.6.8-rc2
Message-Id: <20040731143925.014ce12a.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0407311003210.16847@ppc970.osdl.org>
References: <20040726150615.GA1119@xeon2.local.here>
	<20040729140743.170acb3e.akpm@osdl.org>
	<20040730163007.GA2931@logos.cnet>
	<20040730124744.0eb11f63.akpm@osdl.org>
	<Pine.LNX.4.58.0407311003210.16847@ppc970.osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
>  Something like this (totally untested, may not compile, you get the idea) 
>  might work. Or not. Since the _rest_ of "shrink_slab()" doesn't know about 
>  zonelists, just making the "how many pages does this zone have free" take 
>  the zonelist into account might cause other problems.

No, I think it'll be OK.  Problems in this area tend to be subtle, and take
time to appear.  But I think this one is pretty safe.




The logic in shrink_slab tries to balance the proportion of slab which it
scans against the proportion of pagecache which the caller scanned.  Problem
is that with a large number of highmem LRU pages and a small number of lowmem
LRU pages, the amount of pagecache scanning appears to be very small, so we
don't push slab hard enough.

THe patch changes things so that for, say, a GFP_KERNEL allocation attempt we
only consider ZONE_NORMAL and ZONE_DMA when calculating "what proportion of
the LRU did the caller just scan".

This will have the effect of shrinking slab harder in response to GFP_KERNEL
allocations than for GFP_HIGHMEM allocations.

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/include/linux/mm.h |    2 --
 25-akpm/mm/page_alloc.c    |   11 -----------
 25-akpm/mm/vmscan.c        |   32 +++++++++++++++++++++++---------
 3 files changed, 23 insertions(+), 22 deletions(-)

diff -puN include/linux/mm.h~slab-shrinking-fix include/linux/mm.h
--- 25/include/linux/mm.h~slab-shrinking-fix	2004-07-31 14:01:11.021081264 -0700
+++ 25-akpm/include/linux/mm.h	2004-07-31 14:02:25.500758632 -0700
@@ -706,8 +706,6 @@ static inline unsigned long vma_pages(st
 
 extern struct vm_area_struct *find_extend_vma(struct mm_struct *mm, unsigned long addr);
 
-extern unsigned int nr_used_zone_pages(void);
-
 extern struct page * vmalloc_to_page(void *addr);
 extern struct page * follow_page(struct mm_struct *mm, unsigned long address,
 		int write);
diff -puN mm/page_alloc.c~slab-shrinking-fix mm/page_alloc.c
--- 25/mm/page_alloc.c~slab-shrinking-fix	2004-07-31 14:01:11.022081112 -0700
+++ 25-akpm/mm/page_alloc.c	2004-07-31 14:02:21.469371496 -0700
@@ -829,17 +829,6 @@ unsigned int nr_free_pages(void)
 
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
diff -puN mm/vmscan.c~slab-shrinking-fix mm/vmscan.c
--- 25/mm/vmscan.c~slab-shrinking-fix	2004-07-31 14:01:11.024080808 -0700
+++ 25-akpm/mm/vmscan.c	2004-07-31 14:35:31.185888608 -0700
@@ -169,22 +169,25 @@ EXPORT_SYMBOL(remove_shrinker);
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
@@ -896,6 +899,7 @@ int try_to_free_pages(struct zone **zone
 	int total_scanned = 0, total_reclaimed = 0;
 	struct reclaim_state *reclaim_state = current->reclaim_state;
 	struct scan_control sc;
+	unsigned long lru_pages = 0;
 	int i;
 
 	sc.gfp_mask = gfp_mask;
@@ -903,8 +907,12 @@ int try_to_free_pages(struct zone **zone
 
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
@@ -912,7 +920,7 @@ int try_to_free_pages(struct zone **zone
 		sc.nr_reclaimed = 0;
 		sc.priority = priority;
 		shrink_caches(zones, &sc);
-		shrink_slab(sc.nr_scanned, gfp_mask);
+		shrink_slab(sc.nr_scanned, gfp_mask, lru_pages);
 		if (reclaim_state) {
 			sc.nr_reclaimed += reclaim_state->reclaimed_slab;
 			reclaim_state->reclaimed_slab = 0;
@@ -997,7 +1005,7 @@ static int balance_pgdat(pg_data_t *pgda
 	for (priority = DEF_PRIORITY; priority >= 0; priority--) {
 		int all_zones_ok = 1;
 		int end_zone = 0;	/* Inclusive.  0 = ZONE_DMA */
-
+		unsigned long lru_pages = 0;
 
 		if (nr_pages == 0) {
 			/*
@@ -1021,6 +1029,12 @@ static int balance_pgdat(pg_data_t *pgda
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
@@ -1048,7 +1062,7 @@ scan:
 			sc.priority = priority;
 			shrink_zone(zone, &sc);
 			reclaim_state->reclaimed_slab = 0;
-			shrink_slab(sc.nr_scanned, GFP_KERNEL);
+			shrink_slab(sc.nr_scanned, GFP_KERNEL, lru_pages);
 			sc.nr_reclaimed += reclaim_state->reclaimed_slab;
 			total_reclaimed += sc.nr_reclaimed;
 			if (zone->all_unreclaimable)
_

