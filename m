Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932146AbVLTX5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbVLTX5t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 18:57:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbVLTX5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 18:57:49 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:61096 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932146AbVLTX5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 18:57:48 -0500
Date: Tue, 20 Dec 2005 15:57:38 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       Andi Kleen <ak@suse.de>, Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Christoph Lameter <clameter@sgi.com>
Message-Id: <20051220235738.30925.68405.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20051220235733.30925.55642.sendpatchset@schroedinger.engr.sgi.com>
References: <20051220235733.30925.55642.sendpatchset@schroedinger.engr.sgi.com>
Subject: [RFC] Event counters [2/3]: Convert inc_page_state -> count_event
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert inc/add page_state to count_event(s)

Convert the page_state operations to count_event() and count_zone_event()

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.15-rc5-mm3/mm/page_alloc.c
===================================================================
--- linux-2.6.15-rc5-mm3.orig/mm/page_alloc.c	2005-12-20 14:30:49.000000000 -0800
+++ linux-2.6.15-rc5-mm3/mm/page_alloc.c	2005-12-20 14:36:36.000000000 -0800
@@ -443,7 +443,7 @@ static void __free_pages_ok(struct page 
 
 	kernel_map_pages(page, 1 << order, 0);
 	local_irq_save(flags);
-	__mod_page_state(pgfree, 1 << order);
+	count_events(PGFREE, 1 << order);
 	free_one_page(page_zone(page), page, order);
 	local_irq_restore(flags);
 }
@@ -473,7 +473,7 @@ void fastcall __init __free_pages_bootme
 
 		arch_free_page(page, order);
 
-		mod_page_state(pgfree, 1 << order);
+		count_events(PGFREE, 1 << order);
 
 		list_add(&page->lru, &list);
 		kernel_map_pages(page, 1 << order, 0);
@@ -1030,7 +1030,7 @@ static void fastcall free_hot_cold_page(
 
 	pcp = &zone_pcp(zone, get_cpu())->pcp[cold];
 	local_irq_save(flags);
-	__inc_page_state(pgfree);
+	count_event(PGFREE);
 	list_add(&page->lru, &pcp->list);
 	pcp->count++;
 	if (pcp->count >= pcp->high) {
@@ -1097,7 +1097,7 @@ again:
 			goto failed;
 	}
 
-	__mod_page_state_zone(zone, pgalloc, 1 << order);
+	count_zone_events(PGALLOC, zone, 1 << order);
 	zone_statistics(zonelist, zone, cpu);
 	local_irq_restore(flags);
 	put_cpu();
Index: linux-2.6.15-rc5-mm3/mm/vmscan.c
===================================================================
--- linux-2.6.15-rc5-mm3.orig/mm/vmscan.c	2005-12-20 12:57:42.000000000 -0800
+++ linux-2.6.15-rc5-mm3/mm/vmscan.c	2005-12-20 14:36:36.000000000 -0800
@@ -227,7 +227,7 @@ int shrink_slab(unsigned long scanned, g
 					(nr_before - shrink_ret));
 			}
 			shrinker_stat_add(shrinker, nr_req, this_scan);
-			mod_page_state(slabs_scanned, this_scan);
+			count_events(SLABS_SCANNED, this_scan);
 			total_scan -= this_scan;
 
 			cond_resched();
@@ -567,7 +567,7 @@ keep:
 	list_splice(&ret_pages, page_list);
 	if (pagevec_count(&freed_pvec))
 		__pagevec_release_nonlru(&freed_pvec);
-	mod_page_state(pgactivate, pgactivate);
+	count_events(PGACTIVATE, pgactivate);
 	sc->nr_reclaimed += reclaimed;
 	return reclaimed;
 }
@@ -888,11 +888,11 @@ static void shrink_cache(struct zone *zo
 
 		local_irq_disable();
 		if (current_is_kswapd()) {
-			__mod_page_state_zone(zone, pgscan_kswapd, nr_scan);
-			__mod_page_state(kswapd_steal, nr_freed);
+			count_zone_events(PGSCAN_KSWAPD, zone, nr_scan);
+			count_events(KSWAPD_STEAL, nr_freed);
 		} else
-			__mod_page_state_zone(zone, pgscan_direct, nr_scan);
-		__mod_page_state_zone(zone, pgsteal, nr_freed);
+			count_zone_events(PGSCAN_DIRECT, zone, nr_scan);
+		count_events(PGACTIVATE, nr_freed);
 
 		spin_lock(&zone->lru_lock);
 		/*
@@ -1056,11 +1056,10 @@ refill_inactive_zone(struct zone *zone, 
 		}
 	}
 	zone->nr_active += pgmoved;
-	spin_unlock(&zone->lru_lock);
+	spin_unlock_irq(&zone->lru_lock);
 
-	__mod_page_state_zone(zone, pgrefill, pgscanned);
-	__mod_page_state(pgdeactivate, pgdeactivate);
-	local_irq_enable();
+	count_zone_events(PGREFILL, zone, pgscanned);
+	count_events(PGDEACTIVATE, pgdeactivate);
 
 	pagevec_release(&pvec);
 }
@@ -1182,7 +1181,7 @@ int try_to_free_pages(struct zone **zone
 	sc.gfp_mask = gfp_mask;
 	sc.may_writepage = 0;
 
-	inc_page_state(allocstall);
+	count_event(ALLOCSTALL);
 
 	for (i = 0; zones[i] != NULL; i++) {
 		struct zone *zone = zones[i];
@@ -1285,7 +1284,7 @@ loop_again:
 	sc.may_writepage = 0;
 	sc.nr_mapped = global_page_state(NR_MAPPED);
 
-	inc_page_state(pageoutrun);
+	count_event(PAGEOUTRUN);
 
 	for (i = 0; i < pgdat->nr_zones; i++) {
 		struct zone *zone = pgdat->node_zones + i;
Index: linux-2.6.15-rc5-mm3/block/ll_rw_blk.c
===================================================================
--- linux-2.6.15-rc5-mm3.orig/block/ll_rw_blk.c	2005-12-16 11:44:06.000000000 -0800
+++ linux-2.6.15-rc5-mm3/block/ll_rw_blk.c	2005-12-20 14:36:36.000000000 -0800
@@ -3007,9 +3007,9 @@ void submit_bio(int rw, struct bio *bio)
 	BIO_BUG_ON(!bio->bi_io_vec);
 	bio->bi_rw |= rw;
 	if (rw & WRITE)
-		mod_page_state(pgpgout, count);
+		count_events(PGPGOUT, count);
 	else
-		mod_page_state(pgpgin, count);
+		count_events(PGPGIN, count);
 
 	if (unlikely(block_dump)) {
 		char b[BDEVNAME_SIZE];
Index: linux-2.6.15-rc5-mm3/mm/page_io.c
===================================================================
--- linux-2.6.15-rc5-mm3.orig/mm/page_io.c	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5-mm3/mm/page_io.c	2005-12-20 14:36:36.000000000 -0800
@@ -101,7 +101,7 @@ int swap_writepage(struct page *page, st
 	}
 	if (wbc->sync_mode == WB_SYNC_ALL)
 		rw |= (1 << BIO_RW_SYNC);
-	inc_page_state(pswpout);
+	count_event(PSWPOUT);
 	set_page_writeback(page);
 	unlock_page(page);
 	submit_bio(rw, bio);
@@ -123,7 +123,7 @@ int swap_readpage(struct file *file, str
 		ret = -ENOMEM;
 		goto out;
 	}
-	inc_page_state(pswpin);
+	count_event(PSWPIN);
 	submit_bio(READ, bio);
 out:
 	return ret;
Index: linux-2.6.15-rc5-mm3/mm/memory.c
===================================================================
--- linux-2.6.15-rc5-mm3.orig/mm/memory.c	2005-12-20 12:58:31.000000000 -0800
+++ linux-2.6.15-rc5-mm3/mm/memory.c	2005-12-20 14:36:36.000000000 -0800
@@ -1887,7 +1887,7 @@ static int do_swap_page(struct mm_struct
 
 		/* Had to read the page from swap area: Major fault */
 		ret = VM_FAULT_MAJOR;
-		inc_page_state(pgmajfault);
+		count_event(PGMAJFAULT);
 		grab_swap_token();
 	}
 
@@ -2247,7 +2247,7 @@ int __handle_mm_fault(struct mm_struct *
 
 	__set_current_state(TASK_RUNNING);
 
-	inc_page_state(pgfault);
+	count_event(PGFAULT);
 
 	if (unlikely(is_vm_hugetlb_page(vma)))
 		return hugetlb_fault(mm, vma, address, write_access);
Index: linux-2.6.15-rc5-mm3/fs/inode.c
===================================================================
--- linux-2.6.15-rc5-mm3.orig/fs/inode.c	2005-12-16 11:44:08.000000000 -0800
+++ linux-2.6.15-rc5-mm3/fs/inode.c	2005-12-20 14:36:36.000000000 -0800
@@ -462,9 +462,9 @@ static void prune_icache(int nr_to_scan)
 	up(&iprune_sem);
 
 	if (current_is_kswapd())
-		mod_page_state(kswapd_inodesteal, reap);
+		count_events(KSWAPD_INODESTEAL, reap);
 	else
-		mod_page_state(pginodesteal, reap);
+		count_events(PGINODESTEAL, reap);
 }
 
 /*
Index: linux-2.6.15-rc5-mm3/mm/shmem.c
===================================================================
--- linux-2.6.15-rc5-mm3.orig/mm/shmem.c	2005-12-16 11:44:09.000000000 -0800
+++ linux-2.6.15-rc5-mm3/mm/shmem.c	2005-12-20 14:36:36.000000000 -0800
@@ -996,7 +996,7 @@ repeat:
 			spin_unlock(&info->lock);
 			/* here we actually do the io */
 			if (type && *type == VM_FAULT_MINOR) {
-				inc_page_state(pgmajfault);
+				count_event(PGMAJFAULT);
 				*type = VM_FAULT_MAJOR;
 			}
 			swappage = shmem_swapin(info, swap, idx);
Index: linux-2.6.15-rc5-mm3/mm/swap.c
===================================================================
--- linux-2.6.15-rc5-mm3.orig/mm/swap.c	2005-12-16 11:44:09.000000000 -0800
+++ linux-2.6.15-rc5-mm3/mm/swap.c	2005-12-20 14:36:36.000000000 -0800
@@ -85,7 +85,7 @@ int rotate_reclaimable_page(struct page 
 	if (PageLRU(page) && !PageActive(page)) {
 		list_del(&page->lru);
 		list_add_tail(&page->lru, &zone->inactive_list);
-		inc_page_state(pgrotated);
+		count_event(PGROTATED);
 	}
 	if (!test_clear_page_writeback(page))
 		BUG();
@@ -105,7 +105,7 @@ void fastcall activate_page(struct page 
 		del_page_from_inactive_list(zone, page);
 		SetPageActive(page);
 		add_page_to_active_list(zone, page);
-		inc_page_state(pgactivate);
+		count_event(PGACTIVATE);
 	}
 	spin_unlock_irq(&zone->lru_lock);
 }
Index: linux-2.6.15-rc5-mm3/mm/filemap.c
===================================================================
--- linux-2.6.15-rc5-mm3.orig/mm/filemap.c	2005-12-20 12:57:55.000000000 -0800
+++ linux-2.6.15-rc5-mm3/mm/filemap.c	2005-12-20 14:36:36.000000000 -0800
@@ -1283,7 +1283,7 @@ retry_find:
 		 */
 		if (!did_readaround) {
 			majmin = VM_FAULT_MAJOR;
-			inc_page_state(pgmajfault);
+			count_event(PGMAJFAULT);
 		}
 		did_readaround = 1;
 		ra_pages = max_sane_readahead(file->f_ra.ra_pages);
@@ -1354,7 +1354,7 @@ no_cached_page:
 page_not_uptodate:
 	if (!did_readaround) {
 		majmin = VM_FAULT_MAJOR;
-		inc_page_state(pgmajfault);
+		count_event(PGMAJFAULT);
 	}
 	lock_page(page);
 
Index: linux-2.6.15-rc5-mm3/fs/ncpfs/mmap.c
===================================================================
--- linux-2.6.15-rc5-mm3.orig/fs/ncpfs/mmap.c	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5-mm3/fs/ncpfs/mmap.c	2005-12-20 14:47:50.000000000 -0800
@@ -93,7 +93,7 @@ static struct page* ncp_file_mmap_nopage
 	 */
 	if (type)
 		*type = VM_FAULT_MAJOR;
-	inc_page_state(pgmajfault);
+	count_event(PGMAJFAULT);
 	return page;
 }
 
Index: linux-2.6.15-rc5-mm3/drivers/parisc/led.c
===================================================================
--- linux-2.6.15-rc5-mm3.orig/drivers/parisc/led.c	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5-mm3/drivers/parisc/led.c	2005-12-20 14:47:50.000000000 -0800
@@ -410,14 +410,12 @@ static __inline__ int led_get_net_activi
 static __inline__ int led_get_diskio_activity(void)
 {	
 	static unsigned long last_pgpgin, last_pgpgout;
-	struct page_state pgstat;
 	int changed;
 
-	get_full_page_state(&pgstat); /* get no of sectors in & out */
-
 	/* Just use a very simple calculation here. Do not care about overflow,
 	   since we only want to know if there was activity or not. */
-	changed = (pgstat.pgpgin != last_pgpgin) || (pgstat.pgpgout != last_pgpgout);
+	changed = (get_global_events(PGPGIN) != last_pgpgin) ||
+		  (get_global_events(PGPGOUT) != last_pgpgout);
 	last_pgpgin  = pgstat.pgpgin;
 	last_pgpgout = pgstat.pgpgout;
 
