Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311530AbSCTEC7>; Tue, 19 Mar 2002 23:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311520AbSCTECV>; Tue, 19 Mar 2002 23:02:21 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:30479 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S311509AbSCTEBl>; Tue, 19 Mar 2002 23:01:41 -0500
Message-ID: <3C98094D.6E39C790@zip.com.au>
Date: Tue, 19 Mar 2002 20:00:13 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: aa-140-misc_junk
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



misc junk!

- Some (no-op) changes to the page bit macros

- PF_MEMDIE is no longer used.

- Use some macros rather than open-coded page bit operations.

- Statically initialise the LRU list_heads.



=====================================

--- 2.4.19-pre3/include/linux/mm.h~aa-140-misc_junk	Tue Mar 19 19:49:01 2002
+++ 2.4.19-pre3-akpm/include/linux/mm.h	Tue Mar 19 19:49:01 2002
@@ -311,9 +311,10 @@ typedef struct page {
 #define TryLockPage(page)	test_and_set_bit(PG_locked, &(page)->flags)
 #define PageChecked(page)	test_bit(PG_checked, &(page)->flags)
 #define SetPageChecked(page)	set_bit(PG_checked, &(page)->flags)
+
 #define PageLaunder(page)	test_bit(PG_launder, &(page)->flags)
 #define SetPageLaunder(page)	set_bit(PG_launder, &(page)->flags)
-#define __SetPageReserved(page)	__set_bit(PG_reserved, &(page)->flags)
+#define ClearPageLaunder(page)	clear_bit(PG_launder, &(page)->flags)
 
 /*
  * The zone field is never updated after free_area_init_core()
@@ -404,6 +405,7 @@ extern void FASTCALL(set_page_dirty(stru
 #endif
 
 #define SetPageReserved(page)		set_bit(PG_reserved, &(page)->flags)
+#define __SetPageReserved(page)		__set_bit(PG_reserved, &(page)->flags) /* just for boot time very-micro-optimization */
 #define ClearPageReserved(page)		clear_bit(PG_reserved, &(page)->flags)
 
 /*
--- 2.4.19-pre3/include/linux/sched.h~aa-140-misc_junk	Tue Mar 19 19:49:01 2002
+++ 2.4.19-pre3-akpm/include/linux/sched.h	Tue Mar 19 19:49:01 2002
@@ -437,7 +437,6 @@ struct task_struct {
 #define PF_DUMPCORE	0x00000200	/* dumped core */
 #define PF_SIGNALED	0x00000400	/* killed by a signal */
 #define PF_MEMALLOC	0x00000800	/* Allocating memory */
-#define PF_MEMDIE	0x00001000	/* Killed for out-of-memory */
 #define PF_FREE_PAGES	0x00002000	/* per process page freeing */
 #define PF_NOIO		0x00004000	/* avoid generating further I/O */
 
--- 2.4.19-pre3/mm/filemap.c~aa-140-misc_junk	Tue Mar 19 19:49:01 2002
+++ 2.4.19-pre3-akpm/mm/filemap.c	Tue Mar 19 19:49:13 2002
@@ -837,7 +837,7 @@ void ___wait_on_page(struct page *page)
 void unlock_page(struct page *page)
 {
 	wait_queue_head_t *waitqueue = page_waitqueue(page);
-	clear_bit(PG_launder, &(page)->flags);
+	ClearPageLaunder(page);
 	smp_mb__before_clear_bit();
 	if (!test_and_clear_bit(PG_locked, &(page)->flags))
 		BUG();
--- 2.4.19-pre3/mm/oom_kill.c~aa-140-misc_junk	Tue Mar 19 19:49:01 2002
+++ 2.4.19-pre3-akpm/mm/oom_kill.c	Tue Mar 19 19:49:01 2002
@@ -152,7 +152,6 @@ void oom_kill_task(struct task_struct *p
 	 * exit() and clear out its resources quickly...
 	 */
 	p->counter = 5 * HZ;
-	p->flags |= PF_MEMALLOC | PF_MEMDIE;
 
 	/* This process has hardware access, be more careful. */
 	if (cap_t(p->cap_effective) & CAP_TO_MASK(CAP_SYS_RAWIO)) {
--- 2.4.19-pre3/mm/page_alloc.c~aa-140-misc_junk	Tue Mar 19 19:49:01 2002
+++ 2.4.19-pre3-akpm/mm/page_alloc.c	Tue Mar 19 19:49:12 2002
@@ -26,8 +26,8 @@
 int nr_swap_pages;
 int nr_active_pages;
 int nr_inactive_pages;
-struct list_head inactive_list;
-struct list_head active_list;
+LIST_HEAD(inactive_list);
+LIST_HEAD(active_list);
 pg_data_t *pgdat_list;
 
 /* Used to look up the address of the struct zone encoded in page->zone */
@@ -366,7 +366,7 @@ struct page * __alloc_pages(unsigned int
 	/* here we're in the low on memory slow path */
 
 rebalance:
-	if (current->flags & (PF_MEMALLOC | PF_MEMDIE)) {
+	if (current->flags & PF_MEMALLOC) {
 		zone = zonelist->zones;
 		for (;;) {
 			zone_t *z = *(zone++);
@@ -728,9 +728,6 @@ void __init free_area_init_core(int nid,
 			realtotalpages -= zholes_size[i];
 			
 	printk("On node %d totalpages: %lu\n", nid, realtotalpages);
-
-	INIT_LIST_HEAD(&active_list);
-	INIT_LIST_HEAD(&inactive_list);
 
 	/*
 	 * Some architectures (with lots of mem and discontinous memory
--- 2.4.19-pre3/mm/page_io.c~aa-140-misc_junk	Tue Mar 19 19:49:01 2002
+++ 2.4.19-pre3-akpm/mm/page_io.c	Tue Mar 19 19:49:01 2002
@@ -73,10 +73,6 @@ static int rw_swap_page_base(int rw, swp
  	/* block_size == PAGE_SIZE/zones_used */
  	brw_page(rw, page, dev, zones, block_size);
 
- 	/* Note! For consistency we do all of the logic,
- 	 * decrementing the page count, and unlocking the page in the
- 	 * swap lock map - in the IO completion handler.
- 	 */
 	return 1;
 }
 

-
