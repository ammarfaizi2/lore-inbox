Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267585AbRGUE0U>; Sat, 21 Jul 2001 00:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267586AbRGUE0L>; Sat, 21 Jul 2001 00:26:11 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:6667 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S267585AbRGUEZ7>; Sat, 21 Jul 2001 00:25:59 -0400
Date: Fri, 20 Jul 2001 23:55:03 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Rik van Riel <riel@conectiva.com.br>
Subject: Re: Inclusion of zoned inactive/free shortage patch 
In-Reply-To: <Pine.LNX.4.33.0107191008160.8055-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0107202344100.10885-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing



On Thu, 19 Jul 2001, Linus Torvalds wrote:

> 
> On Thu, 19 Jul 2001, Marcelo Tosatti wrote:
> >
> > Well, here is a patch on top of -ac5 (which already includes the first
> > zoned based approach patch).
> 
> Looks ok.
> 
> I'd like to see what the patch looks on top of a virgin tree, as it should
> now be noticeably smaller (no need to pas extra parameters etc).
> 
> > I changed inactive_plenty() to use "zone->size / 3" instead "zone->size /
> > 2".
> >
> > Under _my_ tests using half of the perzone total pages as the inactive
> > target was too high.
> 
> This is one of the reasons I'd like to see the virtgin patch - if the "/2"
> is too high, then that should mean that the behaviour is basically
> unchanged from before, right?

Under normal balance conditions (ie not zone specific shortage), yes, the
behaviour of swap_out() is the same.

But refill_inactive_scan() is not the same: Now we'll _never_ have any
zone with more than 1/3 of its "lruable" pages on the inactive lists due
to the "unlimited" background aging. That is a good thing, of course.

> Which would be a good sign that this kicks in gently - and I agree
> that "/3" sounds saner (or even "/4" - but we should double-check that
> the global inactive function is guaranteed to never trigger with all
> zones close to the "/4" target if so).

Well, under my heavy VM tests on highmem machines this test does trigger
quite often, which is expected.

Here it goes. (against pre9)

diff --exclude-from=/home/marcelo/exclude -Nur linux.orig/include/linux/swap.h linux/include/linux/swap.h
--- linux.orig/include/linux/swap.h	Sat Jul 21 01:06:53 2001
+++ linux/include/linux/swap.h	Sat Jul 21 01:16:59 2001
@@ -121,9 +121,15 @@
 extern wait_queue_head_t kreclaimd_wait;
 extern int page_launder(int, int);
 extern int free_shortage(void);
+extern int total_free_shortage(void);
 extern int inactive_shortage(void);
+extern int total_inactive_shortage(void);
 extern void wakeup_kswapd(void);
 extern int try_to_free_pages(unsigned int gfp_mask);
+
+extern unsigned int zone_free_shortage(zone_t *zone);
+extern unsigned int zone_inactive_shortage(zone_t *zone);
+extern unsigned int zone_inactive_plenty(zone_t *zone);
 
 /* linux/mm/page_io.c */
 extern void rw_swap_page(int, struct page *);
diff --exclude-from=/home/marcelo/exclude -Nur linux.orig/mm/page_alloc.c linux/mm/page_alloc.c
--- linux.orig/mm/page_alloc.c	Sat Jul 21 01:06:53 2001
+++ linux/mm/page_alloc.c	Sat Jul 21 01:11:32 2001
@@ -448,7 +448,7 @@
 		 * to give up than to deadlock the kernel looping here.
 		 */
 		if (gfp_mask & __GFP_WAIT) {
-			if (!order || free_shortage()) {
+			if (!order || total_free_shortage()) {
 				int progress = try_to_free_pages(gfp_mask);
 				if (progress || (gfp_mask & __GFP_FS))
 					goto try_again;
@@ -621,6 +621,53 @@
 	return pages;
 }
 #endif
+
+unsigned int zone_free_shortage(zone_t *zone)
+{
+	int sum = 0;
+
+	if (!zone->size)
+		goto ret;
+
+	if (zone->inactive_clean_pages + zone->free_pages
+			< zone->pages_min) {
+		sum += zone->pages_min;
+		sum -= zone->free_pages;
+		sum -= zone->inactive_clean_pages;
+	}
+ret:
+	return sum;
+}
+
+unsigned int zone_inactive_plenty(zone_t *zone)
+{
+	int inactive;
+
+	if (!zone->size)
+		return 0;
+		
+	inactive = zone->inactive_dirty_pages;
+	inactive += zone->inactive_clean_pages;
+	inactive += zone->free_pages;
+
+	return (inactive > (zone->size / 3));
+
+}
+unsigned int zone_inactive_shortage(zone_t *zone) 
+{
+	int sum = 0;
+
+	if (!zone->size)
+		goto ret;
+
+	sum = zone->pages_high;
+	sum -= zone->inactive_dirty_pages;
+	sum -= zone->inactive_clean_pages;
+	sum -= zone->free_pages;
+
+ret:
+     return (sum > 0 ? sum : 0);
+}
 
 /*
  * Show free area list (used inside shift_scroll-lock stuff)
diff --exclude-from=/home/marcelo/exclude -Nur linux.orig/mm/vmscan.c linux/mm/vmscan.c
--- linux.orig/mm/vmscan.c	Sat Jul 21 01:06:53 2001
+++ linux/mm/vmscan.c	Sat Jul 21 01:24:33 2001
@@ -41,6 +41,14 @@
 	pte_t pte;
 	swp_entry_t entry;
 
+	/* 
+	 * If we are doing a zone-specific scan, do not
+	 * touch pages from zones which don't have a 
+	 * shortage.
+	 */
+	if (zone_inactive_plenty(page->zone))
+		return;
+
 	/* Don't look at this pte if it's been accessed recently. */
 	if (ptep_test_and_clear_young(page_table)) {
 		page->age += PAGE_AGE_ADV;
@@ -426,7 +434,7 @@
 #define MAX_LAUNDER 		(4 * (1 << page_cluster))
 #define CAN_DO_FS		(gfp_mask & __GFP_FS)
 #define CAN_DO_IO		(gfp_mask & __GFP_IO)
-int page_launder(int gfp_mask, int sync)
+int do_page_launder(zone_t *zone, int gfp_mask, int sync)
 {
 	int launder_loop, maxscan, cleaned_pages, maxlaunder;
 	struct list_head * page_lru;
@@ -461,6 +469,17 @@
 			continue;
 		}
 
+		/* 
+		 * If we are doing zone-specific laundering, 
+		 * avoid touching pages from zones which do 
+		 * not have a free shortage.
+		 */
+		if (zone && !zone_free_shortage(page->zone)) {
+			list_del(page_lru);
+			list_add(page_lru, &inactive_dirty_list);
+			continue;
+		}
+
 		/*
 		 * The page is locked. IO in progress?
 		 * Move it to the back of the list.
@@ -574,8 +593,13 @@
 			 * If we're freeing buffer cache pages, stop when
 			 * we've got enough free memory.
 			 */
-			if (freed_page && !free_shortage())
-				break;
+			if (freed_page) {
+				if (zone) {
+					if (!zone_free_shortage(zone))
+						break;
+				} else if (!free_shortage()) 
+					break;
+			}
 			continue;
 		} else if (page->mapping && !PageDirty(page)) {
 			/*
@@ -613,7 +637,7 @@
 	 * loads, flush out the dirty pages before we have to wait on
 	 * IO.
 	 */
-	if (CAN_DO_IO && !launder_loop && free_shortage()) {
+	if (CAN_DO_IO && !launder_loop && total_free_shortage()) {
 		launder_loop = 1;
 		/* If we cleaned pages, never do synchronous IO. */
 		if (cleaned_pages)
@@ -629,6 +653,33 @@
 	return cleaned_pages;
 }
 
+int page_launder(int gfp_mask, int sync)
+{
+	int type = 0, ret = 0;
+	pg_data_t *pgdat = pgdat_list;
+	/*
+	 * First do a global scan if there is a 
+	 * global shortage.
+	 */
+	if (free_shortage())
+		ret += do_page_launder(NULL, gfp_mask, sync);
+
+	/*
+	 * Then check if there is any specific zone 
+	 * needs laundering.
+	 */
+	for (type = 0; type < MAX_NR_ZONES; type++) {
+		zone_t *zone = pgdat->node_zones + type;
+		
+		if (zone_free_shortage(zone)) 
+			ret += do_page_launder(zone, gfp_mask, sync);
+	} 
+
+	return ret;
+}
+
+
+
 /**
  * refill_inactive_scan - scan the active list and find pages to deactivate
  * @priority: the priority at which to scan
@@ -637,7 +688,7 @@
  * This function will scan a portion of the active list to find
  * unused pages, those pages will then be moved to the inactive list.
  */
-int refill_inactive_scan(unsigned int priority, int target)
+int refill_inactive_scan(zone_t *zone, unsigned int priority, int target)
 {
 	struct list_head * page_lru;
 	struct page * page;
@@ -665,6 +716,16 @@
 			continue;
 		}
 
+		/*
+		 * Do not deactivate pages from zones which 
+		 * have plenty inactive pages.
+		 */
+
+		if (zone_inactive_plenty(page->zone)) {
+			page_active = 1;
+			goto skip_page;
+		}
+
 		/* Do aging on the pages. */
 		if (PageTestandClearReferenced(page)) {
 			age_page_up_nolock(page);
@@ -695,10 +756,12 @@
 		 * we have done enough work.
 		 */
 		if (page_active || PageActive(page)) {
+skip_page:
 			list_del(page_lru);
 			list_add(page_lru, &active_list);
 		} else {
-			nr_deactivated++;
+			if (!zone || (zone && (zone == page->zone)))
+				nr_deactivated++;
 			if (target && nr_deactivated >= target)
 				break;
 		}
@@ -709,19 +772,32 @@
 }
 
 /*
- * Check if there are zones with a severe shortage of free pages,
- * or if all zones have a minor shortage.
+ * Check if we have are low on free pages globally.
  */
 int free_shortage(void)
 {
-	pg_data_t *pgdat = pgdat_list;
-	int sum = 0;
 	int freeable = nr_free_pages() + nr_inactive_clean_pages();
 	int freetarget = freepages.high;
 
 	/* Are we low on free pages globally? */
 	if (freeable < freetarget)
 		return freetarget - freeable;
+	return 0;
+}
+
+/*
+ *
+ * Check if there are zones with a severe shortage of free pages,
+ * or if all zones have a minor shortage.
+ */
+int total_free_shortage(void)
+{
+	int sum = 0;
+	pg_data_t *pgdat = pgdat_list;
+
+	/* Do we have a global free shortage? */
+	if((sum = free_shortage()))
+		return sum;
 
 	/* If not, are we very low on any particular zone? */
 	do {
@@ -739,15 +815,15 @@
 	} while (pgdat);
 
 	return sum;
+
 }
 
 /*
- * How many inactive pages are we short?
+ * How many inactive pages are we short globally?
  */
 int inactive_shortage(void)
 {
 	int shortage = 0;
-	pg_data_t *pgdat = pgdat_list;
 
 	/* Is the inactive dirty list too small? */
 
@@ -759,10 +835,20 @@
 
 	if (shortage > 0)
 		return shortage;
+	return 0;
+}
+/*
+ * Are we low on inactive pages globally or in any zone?
+ */
+int total_inactive_shortage(void)
+{
+	int shortage = 0;
+	pg_data_t *pgdat = pgdat_list;
 
-	/* If not, do we have enough per-zone pages on the inactive list? */
+	if((shortage = inactive_shortage()))
+		return shortage;
 
-	shortage = 0;
+	shortage = 0;	
 
 	do {
 		int i;
@@ -802,7 +888,7 @@
  * when called from a user process.
  */
 #define DEF_PRIORITY (6)
-static int refill_inactive(unsigned int gfp_mask, int user)
+static int refill_inactive_global(unsigned int gfp_mask, int user)
 {
 	int count, start_count, maxtry;
 
@@ -826,7 +912,7 @@
 		/* Walk the VM space for a bit.. */
 		swap_out(DEF_PRIORITY, gfp_mask);
 
-		count -= refill_inactive_scan(DEF_PRIORITY, count);
+		count -= refill_inactive_scan(NULL, DEF_PRIORITY, count);
 		if (count <= 0)
 			goto done;
 
@@ -839,6 +925,59 @@
 	return (count < start_count);
 }
 
+static int refill_inactive_zone(zone_t *zone, unsigned int gfp_mask, int user) 
+{
+	int count, start_count, maxtry; 
+	
+	count = start_count = zone_inactive_shortage(zone);
+
+	maxtry = (1 << DEF_PRIORITY);
+
+	do {
+		swap_out(DEF_PRIORITY, gfp_mask);
+
+		count -= refill_inactive_scan(zone, DEF_PRIORITY, count);
+
+		if (count <= 0)
+			goto done;
+
+		if (--maxtry <= 0)
+			return 0;
+
+	} while(zone_inactive_shortage(zone));
+done:
+	return (count < start_count);
+}
+
+
+static int refill_inactive(unsigned int gfp_mask, int user) 
+{
+	int type = 0, ret = 0;
+	pg_data_t *pgdat = pgdat_list;
+	/*
+	 * First do a global scan if there is a 
+	 * global shortage.
+	 */
+	if (inactive_shortage())
+		ret += refill_inactive_global(gfp_mask, user);
+
+	/*
+	 * Then check if there is any specific zone 
+	 * with a shortage and try to refill it if
+	 * so.
+	 */
+	for (type = 0; type < MAX_NR_ZONES; type++) {
+		zone_t *zone = pgdat->node_zones + type;
+		
+		if (zone_inactive_shortage(zone)) 
+			ret += refill_inactive_zone(zone, gfp_mask, user);
+	} 
+
+	return ret;
+}
+
+#define DEF_PRIORITY (6)
+
 static int do_try_to_free_pages(unsigned int gfp_mask, int user)
 {
 	int ret = 0;
@@ -851,8 +990,10 @@
 	 * before we get around to moving them to the other
 	 * list, so this is a relatively cheap operation.
 	 */
-	if (free_shortage()) {
-		ret += page_launder(gfp_mask, user);
+
+	ret += page_launder(gfp_mask, user);
+
+	if (total_free_shortage()) {
 		shrink_dcache_memory(DEF_PRIORITY, gfp_mask);
 		shrink_icache_memory(DEF_PRIORITY, gfp_mask);
 	}
@@ -861,8 +1002,7 @@
 	 * If needed, we move pages from the active list
 	 * to the inactive list.
 	 */
-	if (inactive_shortage())
-		ret += refill_inactive(gfp_mask, user);
+	ret += refill_inactive(gfp_mask, user);
 
 	/* 	
 	 * Reclaim unused slab cache if memory is low.
@@ -917,7 +1057,7 @@
 		static long recalc = 0;
 
 		/* If needed, try to free some memory. */
-		if (inactive_shortage() || free_shortage()) 
+		if (total_inactive_shortage() || total_free_shortage()) 
 			do_try_to_free_pages(GFP_KSWAPD, 0);
 
 		/* Once a second ... */
@@ -928,7 +1068,7 @@
 			recalculate_vm_stats();
 
 			/* Do background page aging. */
-			refill_inactive_scan(DEF_PRIORITY, 0);
+			refill_inactive_scan(NULL, DEF_PRIORITY, 0);
 		}
 
 		run_task_queue(&tq_disk);
@@ -944,7 +1084,7 @@
 		 * We go to sleep for one second, but if it's needed
 		 * we'll be woken up earlier...
 		 */
-		if (!free_shortage() || !inactive_shortage()) {
+		if (!total_free_shortage() || !total_inactive_shortage()) {
 			interruptible_sleep_on_timeout(&kswapd_wait, HZ);
 		/*
 		 * If we couldn't free enough memory, we see if it was

