Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267581AbRGNGvV>; Sat, 14 Jul 2001 02:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267585AbRGNGvM>; Sat, 14 Jul 2001 02:51:12 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:58376 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S267581AbRGNGvB>; Sat, 14 Jul 2001 02:51:01 -0400
Date: Sat, 14 Jul 2001 02:19:34 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Rik van Riel <riel@conectiva.com.br>, Dirk Wetter <dirkw@rentec.com>,
        Mike Galbraith <mikeg@wen-online.de>, linux-mm@kvack.org,
        "Stephen C. Tweedie" <sct@redhat.com>
Subject: [PATCH] Separate global/perzone inactive/free shortage 
Message-ID: <Pine.LNX.4.21.0107140204110.4153-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

As well known, the VM does not make a distiction between global and
per-zone shortages when trying to free memory. That means if only a given
memory zone is under shortage, the kernel will scan pages from all zones. 

The following patch (against 2.4.6-ac2), changes the kernel behaviour to
avoid freeing pages from zones which do not have an inactive and/or
free shortage.

Now I'm able to run memory hogs allocating 4GB of memory (on 4GB machine)
without getting real long hangs on my ssh session. (which used to happen
on stock -ac2 due to exhaustion of DMA pages for networking).

Comments ? 

Dirk, Can you please try the patch and tell us if it fixes your problem ? 


diff --exclude-from=/home/marcelo/exclude -Nur linux.orig/include/linux/swap.h linux/include/linux/swap.h
--- linux.orig/include/linux/swap.h	Sat Jul 14 02:47:14 2001
+++ linux/include/linux/swap.h	Sat Jul 14 03:27:13 2001
@@ -123,9 +123,14 @@
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
 
 /* linux/mm/page_io.c */
 extern void rw_swap_page(int, struct page *);
diff --exclude-from=/home/marcelo/exclude -Nur linux.orig/mm/page_alloc.c linux/mm/page_alloc.c
--- linux.orig/mm/page_alloc.c	Sat Jul 14 02:47:14 2001
+++ linux/mm/page_alloc.c	Sat Jul 14 02:50:50 2001
@@ -451,7 +451,7 @@
 		 * to give up than to deadlock the kernel looping here.
 		 */
 		if (gfp_mask & __GFP_WAIT) {
-			if (!order || free_shortage()) {
+			if (!order || total_free_shortage()) {
 				int progress = try_to_free_pages(gfp_mask);
 				if (progress || (gfp_mask & __GFP_FS))
 					goto try_again;
@@ -689,6 +689,39 @@
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
--- linux.orig/mm/vmscan.c	Sat Jul 14 02:47:14 2001
+++ linux/mm/vmscan.c	Sat Jul 14 03:22:19 2001
@@ -36,11 +36,19 @@
  */
 
 /* mm->page_table_lock is held. mmap_sem is not held */
-static void try_to_swap_out(struct mm_struct * mm, struct vm_area_struct* vma, unsigned long address, pte_t * page_table, struct page *page)
+static void try_to_swap_out(zone_t *zone, struct mm_struct * mm, struct vm_area_struct* vma, unsigned long address, pte_t * page_table, struct page *page)
 {
 	pte_t pte;
 	swp_entry_t entry;
 
+	/* 
+	 * If we are doing a zone-specific scan, do not
+	 * touch pages from zones which don't have a 
+	 * shortage.
+	 */
+	if (zone && !zone_inactive_shortage(page->zone))
+		return;
+
 	/* Don't look at this pte if it's been accessed recently. */
 	if (ptep_test_and_clear_young(page_table)) {
 		page->age += PAGE_AGE_ADV;
@@ -131,7 +139,7 @@
 }
 
 /* mm->page_table_lock is held. mmap_sem is not held */
-static int swap_out_pmd(struct mm_struct * mm, struct vm_area_struct * vma, pmd_t *dir, unsigned long address, unsigned long end, int count)
+static int swap_out_pmd(zone_t *zone, struct mm_struct * mm, struct vm_area_struct * vma, pmd_t *dir, unsigned long address, unsigned long end, int count)
 {
 	pte_t * pte;
 	unsigned long pmd_end;
@@ -155,7 +163,7 @@
 			struct page *page = pte_page(*pte);
 
 			if (VALID_PAGE(page) && !PageReserved(page)) {
-				try_to_swap_out(mm, vma, address, pte, page);
+				try_to_swap_out(zone, mm, vma, address, pte, page);
 				if (!--count)
 					break;
 			}
@@ -168,7 +176,7 @@
 }
 
 /* mm->page_table_lock is held. mmap_sem is not held */
-static inline int swap_out_pgd(struct mm_struct * mm, struct vm_area_struct * vma, pgd_t *dir, unsigned long address, unsigned long end, int count)
+static inline int swap_out_pgd(zone_t *zone, struct mm_struct * mm, struct vm_area_struct * vma, pgd_t *dir, unsigned long address, unsigned long end, int count)
 {
 	pmd_t * pmd;
 	unsigned long pgd_end;
@@ -188,7 +196,7 @@
 		end = pgd_end;
 	
 	do {
-		count = swap_out_pmd(mm, vma, pmd, address, end, count);
+		count = swap_out_pmd(zone, mm, vma, pmd, address, end, count);
 		if (!count)
 			break;
 		address = (address + PMD_SIZE) & PMD_MASK;
@@ -198,7 +206,7 @@
 }
 
 /* mm->page_table_lock is held. mmap_sem is not held */
-static int swap_out_vma(struct mm_struct * mm, struct vm_area_struct * vma, unsigned long address, int count)
+static int swap_out_vma(zone_t *zone, struct mm_struct * mm, struct vm_area_struct * vma, unsigned long address, int count)
 {
 	pgd_t *pgdir;
 	unsigned long end;
@@ -213,7 +221,7 @@
 	if (address >= end)
 		BUG();
 	do {
-		count = swap_out_pgd(mm, vma, pgdir, address, end, count);
+		count = swap_out_pgd(zone, mm, vma, pgdir, address, end, count);
 		if (!count)
 			break;
 		address = (address + PGDIR_SIZE) & PGDIR_MASK;
@@ -225,7 +233,7 @@
 /*
  * Returns non-zero if we scanned all `count' pages
  */
-static int swap_out_mm(struct mm_struct * mm, int count)
+static int swap_out_mm(zone_t *zone, struct mm_struct * mm, int count)
 {
 	unsigned long address;
 	struct vm_area_struct* vma;
@@ -248,7 +256,7 @@
 			address = vma->vm_start;
 
 		for (;;) {
-			count = swap_out_vma(mm, vma, address, count);
+			count = swap_out_vma(zone, mm, vma, address, count);
 			if (!count)
 				goto out_unlock;
 			vma = vma->vm_next;
@@ -280,7 +288,7 @@
 	return nr;
 }
 
-static void swap_out(unsigned int priority, int gfp_mask)
+static void swap_out(zone_t *zone, unsigned int priority, int gfp_mask)
 {
 	int counter;
 	int retval = 0;
@@ -288,7 +296,7 @@
 
 	/* Always start by trying to penalize the process that is allocating memory */
 	if (mm)
-		retval = swap_out_mm(mm, swap_amount(mm));
+		retval = swap_out_mm(zone, mm, swap_amount(mm));
 
 	/* Then, look at the other mm's */
 	counter = (mmlist_nr << SWAP_MM_SHIFT) >> priority;
@@ -310,7 +318,7 @@
 		spin_unlock(&mmlist_lock);
 
 		/* Walk about 6% of the address space each time */
-		retval |= swap_out_mm(mm, swap_amount(mm));
+		retval |= swap_out_mm(zone, mm, swap_amount(mm));
 		mmput(mm);
 	} while (--counter >= 0);
 	return;
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
+				} else if (free_shortage()) 
+					break;
+			}
 			continue;
 		} else if (page->mapping && !PageDirty(page)) {
 			/*
@@ -613,7 +637,8 @@
 	 * loads, flush out the dirty pages before we have to wait on
 	 * IO.
 	 */
-	if (CAN_DO_IO && !launder_loop && free_shortage()) {
+	if (CAN_DO_IO && !launder_loop && (free_shortage() 
+				|| (zone && zone_free_shortage(zone)))) {
 		launder_loop = 1;
 		/* If we cleaned pages, never do synchronous IO. */
 		if (cleaned_pages)
@@ -629,6 +654,34 @@
 	return cleaned_pages;
 }
 
+int page_launder(int gfp_mask, int sync)
+{
+	int type = 0;
+	int ret;
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
@@ -637,7 +690,7 @@
  * This function will scan a portion of the active list to find
  * unused pages, those pages will then be moved to the inactive list.
  */
-int refill_inactive_scan(unsigned int priority, int target)
+int refill_inactive_scan(zone_t *zone, unsigned int priority, int target)
 {
 	struct list_head * page_lru;
 	struct page * page;
@@ -665,6 +718,16 @@
 			continue;
 		}
 
+		/*
+		 * If we are doing zone-specific scanning, ignore
+		 * pages from zones without shortage.
+		 */
+
+		if (zone && !zone_inactive_shortage(page->zone)) {
+			page_active = 1;
+			goto skip_page;
+		}
+
 		/* Do aging on the pages. */
 		if (PageTestandClearReferenced(page)) {
 			age_page_up_nolock(page);
@@ -694,6 +757,7 @@
 		 * to the other end of the list. Otherwise we exit if
 		 * we have done enough work.
 		 */
+skip_page:
 		if (page_active || PageActive(page)) {
 			list_del(page_lru);
 			list_add(page_lru, &active_list);
@@ -709,12 +773,10 @@
 }
 
 /*
- * Check if there are zones with a severe shortage of free pages,
- * or if all zones have a minor shortage.
+ * Check if we have are low on free pages globally.
  */
 int free_shortage(void)
 {
-	pg_data_t *pgdat = pgdat_list;
 	int sum = 0;
 	int freeable = nr_free_pages() + nr_inactive_clean_pages();
 	int freetarget = freepages.high;
@@ -722,6 +784,22 @@
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
@@ -739,15 +817,15 @@
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
 
@@ -759,10 +837,20 @@
 
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
@@ -802,7 +890,7 @@
  * when called from a user process.
  */
 #define DEF_PRIORITY (6)
-static int refill_inactive(unsigned int gfp_mask, int user)
+static int refill_inactive_global(unsigned int gfp_mask, int user)
 {
 	int count, start_count, maxtry;
 
@@ -824,9 +912,9 @@
 		}
 
 		/* Walk the VM space for a bit.. */
-		swap_out(DEF_PRIORITY, gfp_mask);
+		swap_out(NULL, DEF_PRIORITY, gfp_mask);
 
-		count -= refill_inactive_scan(DEF_PRIORITY, count);
+		count -= refill_inactive_scan(NULL, DEF_PRIORITY, count);
 		if (count <= 0)
 			goto done;
 
@@ -839,6 +927,60 @@
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
+		swap_out(zone, DEF_PRIORITY, gfp_mask);
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
+	int type = 0;
+	int ret;
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
@@ -851,8 +993,10 @@
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
@@ -861,8 +1005,7 @@
 	 * If needed, we move pages from the active list
 	 * to the inactive list.
 	 */
-	if (inactive_shortage())
-		ret += refill_inactive(gfp_mask, user);
+	ret += refill_inactive(gfp_mask, user);
 
 	/* 	
 	 * Reclaim unused slab cache if memory is low.
@@ -917,7 +1060,7 @@
 		static long recalc = 0;
 
 		/* If needed, try to free some memory. */
-		if (inactive_shortage() || free_shortage()) 
+		if (total_inactive_shortage() || total_free_shortage()) 
 			do_try_to_free_pages(GFP_KSWAPD, 0);
 
 		/* Once a second ... */
@@ -928,7 +1071,7 @@
 			recalculate_vm_stats();
 
 			/* Do background page aging. */
-			refill_inactive_scan(DEF_PRIORITY, 0);
+			refill_inactive_scan(NULL, DEF_PRIORITY, 0);
 		}
 
 		run_task_queue(&tq_disk);
@@ -944,7 +1087,7 @@
 		 * We go to sleep for one second, but if it's needed
 		 * we'll be woken up earlier...
 		 */
-		if (!free_shortage() || !inactive_shortage()) {
+		if (!total_free_shortage() || !total_inactive_shortage()) {
 			interruptible_sleep_on_timeout(&kswapd_wait, HZ);
 		/*
 		 * If we couldn't free enough memory, we see if it was

