Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273909AbRIRUnU>; Tue, 18 Sep 2001 16:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273911AbRIRUnO>; Tue, 18 Sep 2001 16:43:14 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:13346 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S273909AbRIRUm6> convert rfc822-to-8bit; Tue, 18 Sep 2001 16:42:58 -0400
Date: Tue, 18 Sep 2001 22:43:17 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br, akpm@zip.com.au
Subject: 2.4.10pre11 vm rewrite fixes for mainline inclusion and testing
Message-ID: <20010918224317.E720@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, can you merge this patch in the next pre-patch? Marcelo and
Andrew, can you test if this fixes your problems properly or if we need
further work on it for the oom problem?

Only in 2.4.10pre11aa1: 00_vm-aa-2

	description of the patch:

	-       fixed a race condition in rw_swap_page path: if we need
	        to wait synchronously on the page we must hold a reference
	        on the page or it could be freed by the VM under us
	        after it's been unlocked at I/O completion time (see
	        the page_io.c changes)
	-       don't hide anything (see the new parameter "this_max_scan" to
	        shrink_cache)
	-       don't skip work on the ptes but just don't stop until we
	        unmapped the "interesting" pages from the right classzone
	-       set the task to runnable to avoid lockups with copy_users
	        run within a wait_event interface with the task not runnable
	-       make sure not to pollute the active cache with referenced
	        swapcache
	-       allow deep allocations in case we succeed the balancing but we
	        haven't queued pages in the local freelist and kswapd+GFP_ATOMIC
	        put the number of free pages in the classzone below the atomic
	        watermark for legal reasons (for the record: the atomic
	        watermark is min/2)
	-       block kswapd during oom for 5 sec to allow more graceful
	        task killing
	-       don't fail memory_balancing unless we also failed in making
	        pages freeable (if we made pages freeable and we couldn't
	        find them it means kswapd freed them for us)
	-       refill the inactive list regularly to not left things hanging
		forever in the active list
	-       don't max_scan all over the active list, just stay at
	        MAX_PRIORITY to better preserve the working set during
	        heavy vm load
	-       make deactivate_page to unset the referenced bit so the
	        page can really be freed, and the other way around for
	        activate_page so it stays there for longer time
	-       initialize need_balance to zero at boot
	-	skip over physically referenced pages queued in the lru lists
	 	in swap_out (wait the physical aging to finish before kicking
		in freeing those pages)

	results of the patch:

	1)	better stability thanks to the race fix ;)
	2)      tasks should not be killed by mistake unless truly oom (oom
	        handling seems sane too)
	3)      swapout behaviour should be much better
	4)      the regular refill of the inactive list should provide better
		performance in the I/O loads. Infact even dbench runs even
		faster (but it wasn't really developed to improve dbench).

andrea@laser:/mnt > for i in  1 2 3 4 ; do dbench 40; done
40 clients started
..............................................................................................................................................................................................................................................................................................................................+..............+........................................+.................+................+....+.....+................................+......+.............................................................................................................................................+.................................................................................................................................................................................................................+...............................+.................................................................+...+.....................................+.+.+.....................................+.....+.........................+..+....+...............................+................................................+.........................................................+..........+..............................................................+.......+.............................+......+...............................+....+..............................................................................................................+...............................................+.........................++++++****************************************
Throughput 24.2406 MB/sec (NB0.3008 MB/sec  242.406 MBit/sec)
40 clients started
..........................................................................................................................................................+......................................................................+....+.......................+.....................................................................................................................................................................................................................................+.+...................................+........+.............................+..+.......+........................................................................................................+................+...................+.......................................................................................................+.................................................+..............................+...............................+....+....................................................................+...............................................................+................................................+.............................................+.....................................................................................+...................+......+................+......+..........................................................................................................+.........................+.........+++..+........................................+....+...+.................+++****************************************
Throughput 24.2276 MB/sec (NB0.2845 MB/sec  242.276 MBit/sec)
40 clients started
...........................................................................................................................+...............................+....................................................+...................................................................................................................................................................................................................................+.............+....+.....+.......+......................+................................+...+........................................................................+...........................................................................................................................................................................+.................+................+..................................................++...........................................................................................................................................................+...............................................................................+..............................++..+..............+..........+.........................+.+...........+.............+...+...........................................................+....+.....................................................................................................+.....+...............................................................................+...............................+............+.++++****************************************
Throughput 24.2455 MB/sec (NB0.3068 MB/sec  242.455 MBit/sec)
[..]

without this incremental patch I was constantly getting exactly
20mbyte/sec, not I get constantly 24mbyte/sec in all the runs with very
very very small deviation ;) (but of course dbench isn't the only
workload that we must get right, the below changes weren't really made
with dbench in mind) btw, 2.4.10pre10 with the old vm was returning
9mbyte/sec.

So here it is the vm patch (aka 00_vm-aa-2) ready for merging into
mainline:

diff -urN vm-ref/mm/page_alloc.c vm/mm/page_alloc.c
--- vm-ref/mm/page_alloc.c	Tue Sep 18 21:46:07 2001
+++ vm/mm/page_alloc.c	Tue Sep 18 15:39:50 2001
@@ -255,7 +255,7 @@
 
 		local_pages &current->local_pages;
 
-		if (__freed) {
+		if (__builtin_expect(__freed, 1)) {
 			/* pick from the last inserted so we're lifo */
 			entry local_pages->next;
 			do {
@@ -380,13 +380,15 @@
 			if (!z)
 				break;
 
-			if (zone_free_pages(z, order) > (gfp_mask & __GFP_HIGH ? z->pages_min / 2 : z->pages_min)) {
-				page rmqueue(z, order);
-				if (page)
-					return page;
-			}
+			page rmqueue(z, order);
+			if (page)
+				return page;
 		}
 	} else {
+		/* 
+		 * Check that no other task is been killed meanwhile,
+		 * in such a case we can succeed the allocation.
+		 */
 		for (;;) {
 			zone_t *z *(zone++);
 			if (!z)
@@ -733,6 +735,7 @@
 		zone->lock SPIN_LOCK_UNLOCKED;
 		zone->zone_pgdat pgdat;
 		zone->free_pages ;
+		zone->need_balance ;
 		if (!size)
 			continue;
 
diff -urN vm-ref/mm/page_io.c vm/mm/page_io.c
--- vm-ref/mm/page_io.c	Tue Sep 18 21:46:07 2001
+++ vm/mm/page_io.c	Tue Sep 18 18:04:21 2001
@@ -78,7 +78,15 @@
  	if (!wait) {
  		SetPageDecrAfter(page);
  		atomic_inc(&nr_async_pages);
- 	}
+ 	} else
+		/*
+		 * Must hold a reference until after wait_on_page()
+		 * returned or it could be freed by the VM after
+		 * I/O is completed and the page is been unlocked.
+		 * The asynchronous path is fine since it never
+		 * references the page after brw_page().
+		 */
+		page_cache_get(page);
 
  	/* block_size = PAGE_SIZE/zones_used */
  	brw_page(rw, page, dev, zones, block_size);
@@ -94,6 +102,7 @@
 	/* This shouldn't happen, but check to be sure. */
 	if (page_count(page) = 0)
 		printk(KERN_ERR "rw_swap_page: page unused while waiting!\n");
+	page_cache_release(page);
 
 	return 1;
 }
diff -urN vm-ref/mm/swap.c vm/mm/swap.c
--- vm-ref/mm/swap.c	Tue Sep 18 21:46:07 2001
+++ vm/mm/swap.c	Tue Sep 18 21:23:36 2001
@@ -54,6 +54,7 @@
 		del_page_from_active_list(page);
 		add_page_to_inactive_list(page);
 	}
+	ClearPageReferenced(page);
 }	
 
 void deactivate_page(struct page * page)
@@ -72,6 +73,7 @@
 		del_page_from_inactive_list(page);
 		add_page_to_active_list(page);
 	}
+	SetPageReferenced(page);
 }
 
 void activate_page(struct page * page)
diff -urN vm-ref/mm/vmscan.c vm/mm/vmscan.c
--- vm-ref/mm/vmscan.c	Tue Sep 18 21:46:07 2001
+++ vm/mm/vmscan.c	Tue Sep 18 21:23:49 2001
@@ -47,20 +47,24 @@
 {
 	pte_t pte;
 	swp_entry_t entry;
+	int right_classzone;
 
 	/* Don't look at this pte if it's been accessed recently. */
 	if (ptep_test_and_clear_young(page_table)) {
 		flush_tlb_page(vma, address);
-		SetPageReferenced(page);
+		activate_page(page);
 		return 0;
 	}
-
-	if (!memclass(page->zone, classzone))
+	if ((PageInactive(page) || PageActive(page)) && PageReferenced(page))
 		return 0;
 
 	if (TryLockPage(page))
 		return 0;
 
+	right_classzone ;
+	if (!memclass(page->zone, classzone))
+		right_classzone ;
+
 	/* From this point on, the odds are that we're going to
 	 * nuke this pte, so read and clear the pte.  This hook
 	 * is needed on CPUs which update the accessed and dirty
@@ -90,7 +94,7 @@
 			if (freeable)
 				deactivate_page(page);
 			page_cache_release(page);
-			return freeable;
+			return freeable & right_classzone;
 		}
 	}
 
@@ -293,8 +297,10 @@
 	/* Then, look at the other mm's */
 	counter mmlist_nr / priority;
 	do {
-		if (current->need_resched)
+		if (__builtin_expect(current->need_resched, 0)) {
+			__set_current_state(TASK_RUNNING);
 			schedule();
+		}
 
 		spin_lock(&mmlist_lock);
 		mm swap_mm;
@@ -324,20 +330,19 @@
 	return 0;
 }
 
-static int FASTCALL(shrink_cache(struct list_head * lru, int * max_scan, int nr_pages, zone_t * classzone, unsigned int gfp_mask));
-static int shrink_cache(struct list_head * lru, int * max_scan, int nr_pages, zone_t * classzone, unsigned int gfp_mask)
+static int FASTCALL(shrink_cache(struct list_head * lru, int * max_scan, int this_max_scan, int nr_pages, zone_t * classzone, unsigned int gfp_mask));
+static int shrink_cache(struct list_head * lru, int * max_scan, int this_max_scan, int nr_pages, zone_t * classzone, unsigned int gfp_mask)
 {
-	LIST_HEAD(active_local_lru);
-	LIST_HEAD(inactive_local_lru);
 	struct list_head * entry;
 	int __max_scan *max_scan;
 
 	spin_lock(&pagemap_lru_lock);
-	while (__max_scan && (entry lru->prev) !lru) {
+	while (__max_scan && this_max_scan && (entry lru->prev) !lru) {
 		struct page * page;
 
 		if (__builtin_expect(current->need_resched, 0)) {
 			spin_unlock(&pagemap_lru_lock);
+			__set_current_state(TASK_RUNNING);
 			schedule();
 			spin_lock(&pagemap_lru_lock);
 			continue;
@@ -348,21 +353,33 @@
 		if (__builtin_expect(!PageInactive(page) && !PageActive(page), 0))
 			BUG();
 
+		this_max_scan--;
+
 		if (PageTestandClearReferenced(page)) {
-			if (PageInactive(page)) {
-				del_page_from_inactive_list(page);
-				add_page_to_active_list(page);
-			} else if (PageActive(page)) {
+			if (!PageSwapCache(page)) {
+				if (PageInactive(page)) {
+					del_page_from_inactive_list(page);
+					add_page_to_active_list(page);
+				} else if (PageActive(page)) {
+					list_del(entry);
+					list_add(entry, &active_list);
+				} else
+					BUG();
+			} else {
 				list_del(entry);
-				list_add(entry, &active_list);
-			} else
-				BUG();
+				list_add(entry, lru);
+			}
 			continue;
 		}
 
-		deactivate_page_nolock(page);
-		list_del(entry);
-		list_add_tail(entry, &inactive_local_lru);
+		if (PageInactive(page)) {
+			/* just roll it over, no need to update any stat */
+			list_del(entry);
+			list_add(entry, &inactive_list);
+		} else {
+			del_page_from_active_list(page);
+			add_page_to_inactive_list(page);
+		}
 
 		if (__builtin_expect(!memclass(page->zone, classzone), 0))
 			continue;
@@ -372,8 +389,6 @@
 		/* Racy check to avoid trylocking when not worthwhile */
 		if (!page->buffers && page_count(page) !) {
 			activate_page_nolock(page);
-			list_del(entry);
-			list_add_tail(entry, &active_local_lru);
 			continue;
 		}
 
@@ -497,29 +512,48 @@
 			continue;
 		break;
 	}
-
-	list_splice(&inactive_local_lru, &inactive_list);
-	list_splice(&active_local_lru, &active_list);
 	spin_unlock(&pagemap_lru_lock);
 
 	*max_scan __max_scan;
 	return nr_pages;
 }
 
+static void refill_inactive(int nr_pages)
+{
+	struct list_head * entry;
+
+	spin_lock(&pagemap_lru_lock);
+	entry ¬tive_list.prev;
+	while (nr_pages-- && entry !&active_list) {
+		struct page * page;
+
+		page list_entry(entry, struct page, lru);
+		entry ntry->prev;
+
+		if (!page->buffers && page_count(page) !)
+			continue;
+
+		del_page_from_active_list(page);
+		add_page_to_inactive_list(page);
+	}
+	spin_unlock(&pagemap_lru_lock);
+}
+
 static int FASTCALL(shrink_caches(int priority, zone_t * classzone, unsigned int gfp_mask, int nr_pages));
 static int shrink_caches(int priority, zone_t * classzone, unsigned int gfp_mask, int nr_pages)
 {
-	int max_scan (nr_inactive_pages + nr_active_pages / priority) / priority;
+	int max_scan (nr_inactive_pages + nr_active_pages / DEF_PRIORITY) / priority;
 
 	nr_pages -kmem_cache_reap(gfp_mask);
 	if (nr_pages <)
 		return 0;
 
-	nr_pages shrink_cache(&inactive_list, &max_scan, nr_pages, classzone, gfp_mask);
+	refill_inactive(nr_pages / 2);
+	nr_pages shrink_cache(&inactive_list, &max_scan, nr_inactive_pages, nr_pages, classzone, gfp_mask);
 	if (nr_pages <)
 		return 0;
 
-	nr_pages shrink_cache(&active_list, &max_scan, nr_pages, classzone, gfp_mask);
+	nr_pages shrink_cache(&active_list, &max_scan, nr_active_pages / DEF_PRIORITY, nr_pages, classzone, gfp_mask);
 	if (nr_pages <)
 		return 0;
 
@@ -532,6 +566,7 @@
 int try_to_free_pages(zone_t * classzone, unsigned int gfp_mask, unsigned int order)
 {
 	int priority ÞF_PRIORITY;
+	int ret ;
 
 	do {
 		int nr_pages SWAP_CLUSTER_MAX;
@@ -539,10 +574,10 @@
 		if (nr_pages <)
 			return 1;
 
-		swap_out(priority, classzone, gfp_mask, SWAP_CLUSTER_MAX);
+		ret |swap_out(priority, classzone, gfp_mask, SWAP_CLUSTER_MAX << 2);
 	} while (--priority);
 
-	return 0;
+	return ret;
 }
 
 DECLARE_WAIT_QUEUE_HEAD(kswapd_wait);
@@ -567,12 +602,14 @@
 
 	for (i pgdat->nr_zones-1; i >; i--) {
 		zone pgdat->node_zones + i;
-		if (current->need_resched)
+		if (__builtin_expect(current->need_resched, 0))
 			schedule();
 		if (!zone->need_balance)
 			continue;
 		if (!try_to_free_pages(zone, GFP_KSWAPD, 0)) {
 			zone->need_balance ;
+			__set_current_state(TASK_INTERRUPTIBLE);
+			schedule_timeout(HZ*5);
 			continue;
 		}
 		if (check_classzone_need_balance(zone))


as usual any feedback is welcome, thanks! (if there is disagreement on
some part of the patch, please at least merge urgently the page_io.c
part that is a stability bugfix)

Andrea

PS. as usual I'm also releasing a 2.4.10pre11aa1 with the few remaining
    bits plus and the above patch included.
