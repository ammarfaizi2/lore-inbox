Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270326AbRHHFQI>; Wed, 8 Aug 2001 01:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270327AbRHHFP7>; Wed, 8 Aug 2001 01:15:59 -0400
Received: from [63.209.4.196] ([63.209.4.196]:54544 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S270326AbRHHFPr>; Wed, 8 Aug 2001 01:15:47 -0400
Date: Tue, 7 Aug 2001 22:12:40 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: lkml <linux-kernel@vger.kernel.org>, Rik van Riel <riel@conectiva.com.br>
Subject: Re: [PATCH] total_free_shortage() using zone_free_shortage()
In-Reply-To: <Pine.LNX.4.21.0108072342550.12561-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0108072158120.3428-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 8 Aug 2001, Marcelo Tosatti wrote:
>
> But there is a problem: In case we have a specific zone under critical
> shortage, we have to fix that shortage as fast as possible instead
> blocking on IO (IO for the page_launder case) for zones which are not
> under critical conditions.
>
> I'm thinking of a way to fix both (spikes on page writeout and zone
> critical shortages) problems, but IMO you're suggestion is going to
> hurt the latter.

Think about it.

Exactly because we will _always_ ignore zones that have "plenty" of
memory, you have the cases:

 - all zones have plenty of memory. Nothing to do. Great.
 - some zone(s) is really low, the others have plenty. We do the obvious
   thing: we only try to fix up the zone(s) that are low.
 - some zone(s) is really low, and some others are in danger of getting
   low too. Guess what the right thing to do is? Yeah, we probably
   _should_ make sure that while we're at it we don't make the others low
   too. That's what hysteresis avoidance is all about.
 - all zones are really low. We obviously do the right thing.

Basically, your approach has a very black-and-white definition of "low". A
difference in a single page can turn a zone from "enough" to "critical" by
your definition. And that is NOT a stable algorithm in my opinion.

Anyway, theory is theory, and testing rules. Here's my suggested patch
against pre6 (this has the other stuff that has accumulated too). Want to
give it a whirl?

(I also moved some functions to mm/vmscan.c as they were only used there
and could be turned static. And because I'm lazy I _still_ have this
broken version of pine that can corrupt whitespace and you should thus
apply with "patch -l", sorry).

		Linus

-----
diff -u --recursive --new-file pre6/linux/fs/buffer.c linux/fs/buffer.c
--- pre6/linux/fs/buffer.c	Tue Aug  7 16:16:02 2001
+++ linux/fs/buffer.c	Tue Aug  7 17:36:42 2001
@@ -231,6 +231,7 @@
 			return -EAGAIN;
 		}
 		unlock_buffer(bh);
+		__refile_buffer(bh);
 	}
 	spin_unlock(&lru_list_lock);

@@ -1116,15 +1117,17 @@
 	/* If we're getting into imbalance, start write-out */
 	spin_lock(&lru_list_lock);
 	write_some_buffers(dev);
-	wakeup_bdflush();

 	/*
 	 * And if we're _really_ out of balance, wait for
-	 * some of the dirty/locked buffers ourselves.
+	 * some of the dirty/locked buffers ourselves and
+	 * start bdflush.
 	 * This will throttle heavy writers.
 	 */
-	if (state > 0)
+	if (state > 0) {
 		wait_for_some_buffers(dev);
+		wakeup_bdflush();
+	}
 }

 static __inline__ void __mark_dirty(struct buffer_head *bh)
diff -u --recursive --new-file pre6/linux/include/linux/swap.h linux/include/linux/swap.h
--- pre6/linux/include/linux/swap.h	Tue Aug  7 16:16:02 2001
+++ linux/include/linux/swap.h	Tue Aug  7 21:57:39 2001
@@ -125,10 +125,6 @@
 extern void wakeup_kswapd(void);
 extern int try_to_free_pages(unsigned int gfp_mask);

-extern unsigned int zone_free_shortage(zone_t *zone);
-extern unsigned int zone_inactive_shortage(zone_t *zone);
-extern unsigned int zone_inactive_plenty(zone_t *zone);
-
 /* linux/mm/page_io.c */
 extern void rw_swap_page(int, struct page *);
 extern void rw_swap_page_nolock(int, swp_entry_t, char *);
diff -u --recursive --new-file pre6/linux/mm/page_alloc.c linux/mm/page_alloc.c
--- pre6/linux/mm/page_alloc.c	Tue Aug  7 16:16:02 2001
+++ linux/mm/page_alloc.c	Tue Aug  7 21:51:14 2001
@@ -585,25 +585,23 @@
  */
 unsigned int nr_free_buffer_pages (void)
 {
-	unsigned int sum;
-
-	sum = nr_free_pages();
-	sum += nr_inactive_clean_pages();
-	sum += nr_inactive_dirty_pages;
-
-	/*
-	 * Keep our write behind queue filled, even if
-	 * kswapd lags a bit right now.
-	 */
-	if (sum < freepages.high + inactive_target)
-		sum = freepages.high + inactive_target;
-	/*
-	 * We don't want dirty page writebehind to put too
-	 * much pressure on the working set, but we want it
-	 * to be possible to have some dirty pages in the
-	 * working set without upsetting the writebehind logic.
-	 */
-	sum += nr_active_pages >> 4;
+	unsigned int sum = 0;
+	zonelist_t *zonelist;
+	zone_t **zonep, *zone;
+
+	zonelist = contig_page_data.node_zonelists + (GFP_KERNEL & GFP_ZONEMASK);
+	zonep = zonelist->zones;
+
+	for (zone = *zonep++; zone; zone = *zonep++) {
+		unsigned int pages = zone->free_pages +
+			zone->inactive_clean_pages +
+			zone->inactive_dirty_pages;
+
+		/* Allow the buffer cache to fill up at least "pages_high" pages */
+		if (pages < zone->pages_high)
+			pages = zone->pages_high;
+		sum += pages;
+	}

 	return sum;
 }
@@ -621,53 +619,6 @@
 	return pages;
 }
 #endif
-
-unsigned int zone_free_shortage(zone_t *zone)
-{
-	int sum = 0;
-
-	if (!zone->size)
-		goto ret;
-
-	if (zone->inactive_clean_pages + zone->free_pages
-			< zone->pages_high) {
-		sum += zone->pages_high;
-		sum -= zone->free_pages;
-		sum -= zone->inactive_clean_pages;
-	}
-ret:
-	return sum;
-}
-
-unsigned int zone_inactive_plenty(zone_t *zone)
-{
-	int inactive;
-
-	if (!zone->size)
-		return 0;
-
-	inactive = zone->inactive_dirty_pages;
-	inactive += zone->inactive_clean_pages;
-	inactive += zone->free_pages;
-
-	return (inactive > (zone->size / 3));
-
-}
-unsigned int zone_inactive_shortage(zone_t *zone)
-{
-	int sum = 0;
-
-	if (!zone->size)
-		goto ret;
-
-	sum = zone->pages_high;
-	sum -= zone->inactive_dirty_pages;
-	sum -= zone->inactive_clean_pages;
-	sum -= zone->free_pages;
-
-ret:
-     return (sum > 0 ? sum : 0);
-}

 /*
  * Show free area list (used inside shift_scroll-lock stuff)
diff -u --recursive --new-file pre6/linux/mm/vmscan.c linux/mm/vmscan.c
--- pre6/linux/mm/vmscan.c	Tue Aug  7 16:16:02 2001
+++ linux/mm/vmscan.c	Tue Aug  7 21:55:44 2001
@@ -35,6 +35,58 @@
  * doesn't count as having freed a page.
  */

+/*
+ * Estimate whether a zone has enough inactive or free pages..
+ */
+static unsigned int zone_inactive_plenty(zone_t *zone)
+{
+	unsigned int inactive;
+
+	if (!zone->size)
+		return 0;
+
+	inactive = zone->inactive_dirty_pages;
+	inactive += zone->inactive_clean_pages;
+	inactive += zone->free_pages;
+
+	return (inactive > (zone->size / 3));
+}
+
+static unsigned int zone_inactive_shortage(zone_t *zone)
+{
+	unsigned int inactive;
+
+	if (!zone->size)
+		return 0;
+
+	inactive = zone->inactive_dirty_pages;
+	inactive += zone->inactive_clean_pages;
+	inactive += zone->free_pages;
+
+	return inactive < zone->pages_high;
+}
+
+static unsigned int zone_free_plenty(zone_t *zone)
+{
+	unsigned int free;
+
+	free = zone->free_pages;
+	free += zone->inactive_clean_pages;
+
+	return free > zone->pages_high;
+}
+
+static unsigned int zone_free_shortage(zone_t *zone)
+{
+	unsigned int free;
+
+	free = zone->free_pages;
+	free += zone->inactive_clean_pages;
+
+	return zone->size && free < zone->pages_low;
+}
+
+
 /* mm->page_table_lock is held. mmap_sem is not held */
 static void try_to_swap_out(struct mm_struct * mm, struct vm_area_struct* vma, unsigned long address, pte_t * page_table, struct page *page)
 {
@@ -434,7 +486,7 @@
 #define MAX_LAUNDER 		(4 * (1 << page_cluster))
 #define CAN_DO_FS		(gfp_mask & __GFP_FS)
 #define CAN_DO_IO		(gfp_mask & __GFP_IO)
-int do_page_launder(zone_t *zone, int gfp_mask, int sync)
+int page_launder(int gfp_mask, int sync)
 {
 	int launder_loop, maxscan, cleaned_pages, maxlaunder;
 	struct list_head * page_lru;
@@ -470,11 +522,10 @@
 		}

 		/*
-		 * If we are doing zone-specific laundering,
-		 * avoid touching pages from zones which do
-		 * not have a free shortage.
+		 * If this zone has plenty of pages free,
+		 * don't spend time on cleaning it.
 		 */
-		if (zone && !zone_free_shortage(page->zone)) {
+		if (zone_free_plenty(page->zone)) {
 			list_del(page_lru);
 			list_add(page_lru, &inactive_dirty_list);
 			continue;
@@ -649,31 +700,6 @@
 	return cleaned_pages;
 }

-int page_launder(int gfp_mask, int sync)
-{
-	int type = 0, ret = 0;
-	pg_data_t *pgdat = pgdat_list;
-	/*
-	 * First do a global scan if there is a
-	 * global shortage.
-	 */
-	if (free_shortage())
-		ret += do_page_launder(NULL, gfp_mask, sync);
-
-	/*
-	 * Then check if there is any specific zone
-	 * needs laundering.
-	 */
-	for (type = 0; type < MAX_NR_ZONES; type++) {
-		zone_t *zone = pgdat->node_zones + type;
-
-		if (zone_free_shortage(zone))
-			ret += do_page_launder(zone, gfp_mask, sync);
-	}
-
-	return ret;
-}
-
 static inline void age_page_up(struct page *page)
 {
 	unsigned age = page->age + PAGE_AGE_ADV;
@@ -807,12 +833,8 @@
 		int i;
 		for(i = 0; i < MAX_NR_ZONES; i++) {
 			zone_t *zone = pgdat->node_zones+ i;
-			if (zone->size && (zone->inactive_clean_pages +
-					zone->free_pages < zone->pages_min)) {
-				sum += zone->pages_min;
-				sum -= zone->free_pages;
-				sum -= zone->inactive_clean_pages;
-			}
+
+			sum += zone_free_shortage(zone);
 		}
 		pgdat = pgdat->node_next;
 	} while (pgdat);

