Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030416AbWFITTe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030416AbWFITTe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 15:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030418AbWFITTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 15:19:34 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:45459 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030416AbWFITTd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 15:19:33 -0400
Date: Fri, 9 Jun 2006 12:19:21 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, npiggin@suse.de,
       ak@suse.de, hugh@veritas.com
Subject: Light weight counter 2/2 counter conversion
In-Reply-To: <Pine.LNX.4.64.0606091216320.1174@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.64.0606091218280.1192@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0606091216320.1174@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert inc/add page_state to count_event(s)

Convert the page_state operations to count_event() and count_zone_event()

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17-rc6-mm1/mm/page_alloc.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/mm/page_alloc.c	2006-06-09 12:07:56.895412700 -0700
+++ linux-2.6.17-rc6-mm1/mm/page_alloc.c	2006-06-09 12:09:10.642793011 -0700
@@ -471,7 +471,7 @@ static void __free_pages_ok(struct page 
 
 	kernel_map_pages(page, 1 << order, 0);
 	local_irq_save(flags);
-	__mod_page_state(pgfree, 1 << order);
+	count_vm_events(PGFREE, 1 << order);
 	free_one_page(page_zone(page), page, order);
 	local_irq_restore(flags);
 }
@@ -1042,7 +1042,7 @@ static void fastcall free_hot_cold_page(
 
 	pcp = &zone_pcp(zone, get_cpu())->pcp[cold];
 	local_irq_save(flags);
-	__inc_page_state(pgfree);
+	count_vm_event(PGFREE);
 	list_add(&page->lru, &pcp->list);
 	pcp->count++;
 	if (pcp->count >= pcp->high) {
@@ -1118,7 +1118,7 @@ again:
 			goto failed;
 	}
 
-	__mod_page_state_zone(zone, pgalloc, 1 << order);
+	count_zone_vm_events(PGALLOC, zone, 1 << order);
 	zone_statistics(zonelist, zone, cpu);
 	local_irq_restore(flags);
 	put_cpu();
Index: linux-2.6.17-rc6-mm1/mm/vmscan.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/mm/vmscan.c	2006-06-09 11:30:34.159368970 -0700
+++ linux-2.6.17-rc6-mm1/mm/vmscan.c	2006-06-09 12:09:10.644746015 -0700
@@ -215,7 +215,7 @@ unsigned long shrink_slab(unsigned long 
 					(nr_before - shrink_ret));
 			}
 			shrinker_stat_add(shrinker, nr_req, this_scan);
-			mod_page_state(slabs_scanned, this_scan);
+			count_vm_events(SLABS_SCANNED, this_scan);
 			total_scan -= this_scan;
 
 			cond_resched();
@@ -573,7 +573,7 @@ keep:
 	list_splice(&ret_pages, page_list);
 	if (pagevec_count(&freed_pvec))
 		__pagevec_release_nonlru(&freed_pvec);
-	mod_page_state(pgactivate, pgactivate);
+	count_vm_events(PGACTIVATE, pgactivate);
 	return nr_reclaimed;
 }
 
@@ -664,11 +664,11 @@ static unsigned long shrink_inactive_lis
 		nr_reclaimed += nr_freed;
 		local_irq_disable();
 		if (current_is_kswapd()) {
-			__mod_page_state_zone(zone, pgscan_kswapd, nr_scan);
-			__mod_page_state(kswapd_steal, nr_freed);
+			count_zone_vm_events(PGSCAN_KSWAPD, zone, nr_scan);
+			count_vm_events(KSWAPD_STEAL, nr_freed);
 		} else
-			__mod_page_state_zone(zone, pgscan_direct, nr_scan);
-		__mod_page_state_zone(zone, pgsteal, nr_freed);
+			count_zone_vm_events(PGSCAN_DIRECT, zone, nr_scan);
+		count_vm_events(PGACTIVATE, nr_freed);
 
 		if (nr_taken == 0)
 			goto done;
@@ -845,11 +845,10 @@ static void shrink_active_list(unsigned 
 		}
 	}
 	zone->nr_active += pgmoved;
-	spin_unlock(&zone->lru_lock);
+	spin_unlock_irq(&zone->lru_lock);
 
-	__mod_page_state_zone(zone, pgrefill, pgscanned);
-	__mod_page_state(pgdeactivate, pgdeactivate);
-	local_irq_enable();
+	count_zone_vm_events(PGREFILL, zone, pgscanned);
+	count_vm_events(PGDEACTIVATE, pgdeactivate);
 
 	pagevec_release(&pvec);
 }
@@ -983,7 +982,7 @@ unsigned long try_to_free_pages(struct z
 
 	delay_swap_prefetch();
 
-	inc_page_state(allocstall);
+	count_vm_event(ALLOCSTALL);
 
 	for (i = 0; zones[i] != NULL; i++) {
 		struct zone *zone = zones[i];
@@ -1081,7 +1080,7 @@ loop_again:
 	nr_reclaimed = 0;
 	sc.may_writepage = !laptop_mode,
 
-	inc_page_state(pageoutrun);
+	count_vm_event(PAGEOUTRUN);
 
 	for (i = 0; i < pgdat->nr_zones; i++) {
 		struct zone *zone = pgdat->node_zones + i;
Index: linux-2.6.17-rc6-mm1/block/ll_rw_blk.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/block/ll_rw_blk.c	2006-06-08 15:20:04.945125478 -0700
+++ linux-2.6.17-rc6-mm1/block/ll_rw_blk.c	2006-06-09 12:09:10.646699019 -0700
@@ -3168,9 +3168,9 @@ void submit_bio(int rw, struct bio *bio)
 	BIO_BUG_ON(!bio->bi_io_vec);
 	bio->bi_rw |= rw;
 	if (rw & WRITE)
-		mod_page_state(pgpgout, count);
+		count_vm_events(PGPGOUT, count);
 	else
-		mod_page_state(pgpgin, count);
+		count_vm_events(PGPGIN, count);
 
 	if (unlikely(block_dump)) {
 		char b[BDEVNAME_SIZE];
Index: linux-2.6.17-rc6-mm1/mm/page_io.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/mm/page_io.c	2006-06-05 17:57:02.000000000 -0700
+++ linux-2.6.17-rc6-mm1/mm/page_io.c	2006-06-09 12:09:10.646699019 -0700
@@ -101,7 +101,7 @@ int swap_writepage(struct page *page, st
 	}
 	if (wbc->sync_mode == WB_SYNC_ALL)
 		rw |= (1 << BIO_RW_SYNC);
-	inc_page_state(pswpout);
+	count_vm_event(PSWPOUT);
 	set_page_writeback(page);
 	unlock_page(page);
 	submit_bio(rw, bio);
@@ -123,7 +123,7 @@ int swap_readpage(struct file *file, str
 		ret = -ENOMEM;
 		goto out;
 	}
-	inc_page_state(pswpin);
+	count_vm_event(PSWPIN);
 	submit_bio(READ, bio);
 out:
 	return ret;
Index: linux-2.6.17-rc6-mm1/mm/memory.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/mm/memory.c	2006-06-09 10:30:52.091239575 -0700
+++ linux-2.6.17-rc6-mm1/mm/memory.c	2006-06-09 12:09:10.648652023 -0700
@@ -1953,7 +1953,7 @@ static int do_swap_page(struct mm_struct
 
 		/* Had to read the page from swap area: Major fault */
 		ret = VM_FAULT_MAJOR;
-		inc_page_state(pgmajfault);
+		count_vm_event(PGMAJFAULT);
 		grab_swap_token();
 	}
 
@@ -2327,7 +2327,7 @@ int __handle_mm_fault(struct mm_struct *
 
 	__set_current_state(TASK_RUNNING);
 
-	inc_page_state(pgfault);
+	count_vm_event(PGFAULT);
 
 	if (unlikely(is_vm_hugetlb_page(vma)))
 		return hugetlb_fault(mm, vma, address, write_access);
Index: linux-2.6.17-rc6-mm1/fs/inode.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/fs/inode.c	2006-06-08 15:20:08.147075759 -0700
+++ linux-2.6.17-rc6-mm1/fs/inode.c	2006-06-09 12:09:10.649628524 -0700
@@ -458,9 +458,9 @@ static void prune_icache(int nr_to_scan)
 	mutex_unlock(&iprune_mutex);
 
 	if (current_is_kswapd())
-		mod_page_state(kswapd_inodesteal, reap);
+		count_vm_events(KSWAPD_INODESTEAL, reap);
 	else
-		mod_page_state(pginodesteal, reap);
+		count_vm_events(PGINODESTEAL, reap);
 }
 
 /*
Index: linux-2.6.17-rc6-mm1/mm/shmem.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/mm/shmem.c	2006-06-08 15:20:11.581433533 -0700
+++ linux-2.6.17-rc6-mm1/mm/shmem.c	2006-06-09 12:09:10.650605026 -0700
@@ -1049,7 +1049,7 @@ repeat:
 			spin_unlock(&info->lock);
 			/* here we actually do the io */
 			if (type && *type == VM_FAULT_MINOR) {
-				inc_page_state(pgmajfault);
+				count_vm_event(PGMAJFAULT);
 				*type = VM_FAULT_MAJOR;
 			}
 			swappage = shmem_swapin(info, swap, idx);
Index: linux-2.6.17-rc6-mm1/mm/swap.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/mm/swap.c	2006-06-08 15:20:11.587292545 -0700
+++ linux-2.6.17-rc6-mm1/mm/swap.c	2006-06-09 12:09:10.651581528 -0700
@@ -88,7 +88,7 @@ int rotate_reclaimable_page(struct page 
 	spin_lock_irqsave(&zone->lru_lock, flags);
 	if (PageLRU(page) && !PageActive(page)) {
 		list_move_tail(&page->lru, &zone->inactive_list);
-		inc_page_state(pgrotated);
+		count_vm_event(PGROTATED);
 	}
 	if (!test_clear_page_writeback(page))
 		BUG();
@@ -108,7 +108,7 @@ void fastcall activate_page(struct page 
 		del_page_from_inactive_list(zone, page);
 		SetPageActive(page);
 		add_page_to_active_list(zone, page);
-		inc_page_state(pgactivate);
+		count_vm_event(PGACTIVATE);
 	}
 	spin_unlock_irq(&zone->lru_lock);
 }
Index: linux-2.6.17-rc6-mm1/mm/filemap.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/mm/filemap.c	2006-06-09 10:30:51.850043561 -0700
+++ linux-2.6.17-rc6-mm1/mm/filemap.c	2006-06-09 12:09:10.652558030 -0700
@@ -1411,7 +1411,7 @@ retry_find:
 		 */
 		if (!did_readaround) {
 			majmin = VM_FAULT_MAJOR;
-			inc_page_state(pgmajfault);
+			count_vm_event(PGMAJFAULT);
 		}
 		did_readaround = 1;
 		ra_pages = max_sane_readahead(file->f_ra.ra_pages);
@@ -1494,7 +1494,7 @@ no_cached_page:
 page_not_uptodate:
 	if (!did_readaround) {
 		majmin = VM_FAULT_MAJOR;
-		inc_page_state(pgmajfault);
+		count_vm_event(PGMAJFAULT);
 	}
 	lock_page(page);
 
Index: linux-2.6.17-rc6-mm1/fs/ncpfs/mmap.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/fs/ncpfs/mmap.c	2006-06-05 17:57:02.000000000 -0700
+++ linux-2.6.17-rc6-mm1/fs/ncpfs/mmap.c	2006-06-09 12:09:10.653534532 -0700
@@ -93,7 +93,7 @@ static struct page* ncp_file_mmap_nopage
 	 */
 	if (type)
 		*type = VM_FAULT_MAJOR;
-	inc_page_state(pgmajfault);
+	count_vm_event(PGMAJFAULT);
 	return page;
 }
 
Index: linux-2.6.17-rc6-mm1/drivers/parisc/led.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/drivers/parisc/led.c	2006-06-08 15:20:06.690134674 -0700
+++ linux-2.6.17-rc6-mm1/drivers/parisc/led.c	2006-06-09 12:09:10.653534532 -0700
@@ -411,14 +411,12 @@ static __inline__ int led_get_net_activi
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
 
