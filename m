Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261508AbUKSRph@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261508AbUKSRph (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 12:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261514AbUKSRpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 12:45:36 -0500
Received: from [220.248.27.114] ([220.248.27.114]:62110 "HELO soulinfo.com")
	by vger.kernel.org with SMTP id S261508AbUKSRnX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 12:43:23 -0500
Date: Sat, 20 Nov 2004 01:42:27 +0800
From: hugang@soulinfo.com
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Software Suspend split to two stage.
Message-ID: <20041119174227.GA16964@hugang.soulinfo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel Machek:

  Here is a workable patch for kernel 2.6.9. It test passed in my
  computer, please give some comments.

- How it works.
  First calculate the PageCache pages count, and then allocate pagedir
  for it, then calculate the other pages (pageset1 in suspend2) , then 
  allocate it's pagedir.

  Second, Write PageCache to swap device.

  Final, Snapshot the whole memory, copy pageset1, then save to swap
  device.

- Why need it.
  Not need free PageCache before suspend.

- TODO:
  * Using ASYNC to write/read PageCache.

- This idea is from suspend2.

diff -ur linux-2.6.9/kernel/power/disk.c linux-2.6.9-hg/kernel/power/disk.c
--- linux-2.6.9/kernel/power/disk.c	2004-10-20 16:00:53.000000000 +0800
+++ linux-2.6.9-hg/kernel/power/disk.c	2004-11-20 01:07:09.000000000 +0800
@@ -17,7 +17,6 @@
 #include <linux/fs.h>
 #include "power.h"
 
-
 extern u32 pm_disk_mode;
 extern struct pm_ops * pm_ops;
 
@@ -26,7 +25,7 @@
 extern int swsusp_read(void);
 extern int swsusp_resume(void);
 extern int swsusp_free(void);
-
+extern int pcs_suspend(int resume);
 
 static int noresume = 0;
 char resume_file[256] = CONFIG_PM_STD_PARTITION;
@@ -73,7 +72,7 @@
 
 static int in_suspend __nosavedata = 0;
 
-
+#if 0
 /**
  *	free_some_memory -  Try to free as much memory as possible
  *
@@ -91,7 +90,7 @@
 	printk("|\n");
 }
 
-
+#endif
 static inline void platform_finish(void)
 {
 	if (pm_disk_mode == PM_DISK_PLATFORM) {
@@ -104,13 +103,14 @@
 {
 	device_resume();
 	platform_finish();
+	pcs_suspend(2);
 	enable_nonboot_cpus();
 	thaw_processes();
 	pm_restore_console();
 }
 
 
-static int prepare(void)
+static int prepare(int resume)
 {
 	int error;
 
@@ -130,9 +130,12 @@
 	}
 
 	/* Free memory before shutting down devices. */
-	free_some_memory();
+	//free_some_memory();
 
 	disable_nonboot_cpus();
+	if ((error = pcs_suspend(resume))) {
+		goto Finish;
+	}
 	if ((error = device_suspend(PM_SUSPEND_DISK)))
 		goto Finish;
 
@@ -160,7 +163,7 @@
 {
 	int error;
 
-	if ((error = prepare()))
+	if ((error = prepare(0)))
 		return error;
 
 	pr_debug("PM: Attempting to suspend to disk.\n");
@@ -226,7 +229,7 @@
 
 	pr_debug("PM: Preparing system for restore.\n");
 
-	if ((error = prepare()))
+	if ((error = prepare(1)))
 		goto Free;
 
 	barrier();
 #include <linux/smp_lock.h>
diff -ur linux-2.6.9/kernel/power/swsusp.c linux-2.6.9-hg/kernel/power/swsusp.c
--- linux-2.6.9/kernel/power/swsusp.c	2004-10-20 16:00:53.000000000 +0800
+++ linux-2.6.9-hg/kernel/power/swsusp.c	2004-11-20 01:14:01.000000000 +0800
@@ -301,6 +301,12 @@
 			printk( "." );
 		error = write_page((pagedir_nosave+i)->address,
 					  &((pagedir_nosave+i)->swap_address));
+#ifdef PCS_DEBUG
+		pr_debug("data_write: %p %p %u\n", 
+				(void *)(pagedir_nosave+i)->address, 
+				(void *)(pagedir_nosave+i)->orig_address,
+				(pagedir_nosave+i)->swap_address);
+#endif
 	}
 	printk(" %d Pages done.\n",i);
 	return error;
@@ -505,6 +511,269 @@
 	return 0;
 }
 
+/**
+ *	calc_order - Determine the order of allocation needed for pagedir_save.
+ *
+ *	This looks tricky, but is just subtle. Please fix it some time.
+ *	Since there are %nr_copy_pages worth of pages in the snapshot, we need
+ *	to allocate enough contiguous space to hold 
+ *		(%nr_copy_pages * sizeof(struct pbe)), 
+ *	which has the saved/orig locations of the page.. 
+ *
+ *	SUSPEND_PD_PAGES() tells us how many pages we need to hold those 
+ *	structures, then we call get_bitmask_order(), which will tell us the
+ *	last bit set in the number, starting with 1. (If we need 30 pages, that
+ *	is 0x0000001e in hex. The last bit is the 5th, which is the order we 
+ *	would use to allocate 32 contiguous pages).
+ *
+ *	Since we also need to save those pages, we add the number of pages that
+ *	we need to nr_copy_pages, and in case of an overflow, do the 
+ *	calculation again to update the number of pages needed. 
+ *
+ *	With this model, we will tend to waste a lot of memory if we just cross
+ *	an order boundary. Plus, the higher the order of allocation that we try
+ *	to do, the more likely we are to fail in a low-memory situtation 
+ *	(though	we're unlikely to get this far in such a case, since swsusp 
+ *	requires half of memory to be free anyway).
+ */
+
+static void calc_order(int *po, int *nr)
+{
+	int diff = 0;
+	int order = 0;
+
+	do {
+		diff = get_bitmask_order(SUSPEND_PD_PAGES(*nr)) - order;
+		if (diff) {
+			order += diff;
+			*nr += 1 << diff;
+		}
+	} while(diff);
+	*po = order;
+}
+
+typedef int (*do_page_t)(struct page *page, void *p);
+
+static int foreach_zone_page(struct zone *zone, do_page_t fun, void *p)
+{
+	unsigned long flags;
+	int inactive = 0, active = 0;
+
+	spin_lock_irqsave(&zone->lru_lock, flags);
+	if (zone->nr_inactive) {
+		struct list_head * entry = zone->inactive_list.prev;
+		while (entry != &zone->inactive_list) {
+			if (fun) {
+				struct page * page = list_entry(entry, struct page, lru);
+				inactive += fun(page, p);
+			} else { 
+				inactive ++;
+			}
+			entry = entry->prev;
+		}
+	}
+	if (zone->nr_active) {
+		struct list_head * entry = zone->active_list.prev;
+		while (entry != &zone->active_list) {
+			if (fun) {
+				struct page * page = list_entry(entry, struct page, lru);
+				active += fun(page, p);
+			} else {
+				active ++;
+			}
+			entry = entry->prev;
+		}
+	}
+	spin_unlock_irqrestore(&zone->lru_lock, flags);
+
+	return (active + inactive);
+}
+
+static int setup_pcs_pe(struct page *page, void *p)
+{
+	suspend_pagedir_t **pe = p;
+	unsigned long pfn = page_to_pfn(page);
+
+	BUG_ON(PageReserved(page) && PageNosave(page));
+	if (!pfn_valid(pfn)) {
+		printk("not valid page\n");
+		return 0;
+	}
+	if (PageNosave(page)) {
+		printk("nosave\n");
+		return 0;
+	}
+	if (PageReserved(page) /*&& pfn_is_nosave(pfn)*/) {
+		printk("[nosave]\n");
+		return 0;
+	}
+	if (PageSlab(page)) {
+		printk("slab\n");
+		return (0);
+	}
+	if (pe && *pe) {
+		(*pe)->address = (long) page_address(page);
+		(*pe) ++;
+	}
+	return (1);
+}
+
+static int count_pcs(struct zone *zone, suspend_pagedir_t **pe)
+{
+	return foreach_zone_page(zone, setup_pcs_pe, pe);	
+}
+
+static int comp_pcs_page(struct page *page, void *p)
+{
+	struct page *pg = p;
+	
+	if (pg == page) return (1);
+	else return (0);
+}
+
+static int find_pcs(struct zone *zone, struct page *pg)
+{
+	return foreach_zone_page(zone, comp_pcs_page, pg);
+}
+
+static suspend_pagedir_t *pagedir_cache = NULL;
+static int nr_copy_pcs = 0;
+static int pcs_order = 0;
+
+static int alloc_pagedir_cache(void)
+{
+	int need_nr_copy_pcs = nr_copy_pcs;
+
+	calc_order(&pcs_order, &need_nr_copy_pcs);
+	pagedir_cache = (suspend_pagedir_t *)
+		__get_free_pages(GFP_ATOMIC | __GFP_COLD, pcs_order);
+	if (!pagedir_cache)
+		return -ENOMEM;
+	memset(pagedir_cache, 0, (1 << pcs_order) * PAGE_SIZE);
+
+	pr_debug("alloc pcs %p, %d\n", pagedir_cache, pcs_order);
+
+	return 0;
+}
+
+int bio_read_page(pgoff_t page_off, void * page);
+
+static int pcs_read(void)
+{
+	struct pbe * p;
+	int error = 0, i;
+	swp_entry_t entry;
+
+	printk( "Reading Page Caches (%d pages): ", nr_copy_pcs);
+	for(i = 0, p = pagedir_cache; i < nr_copy_pcs && !error; i++, p++) {
+		if (!(i%100))
+			printk( "." );
+		error = bio_read_page(swp_offset(p->swap_address),
+				(void *)p->address);
+#ifdef PCS_DEBUG
+		pr_debug("pcs_read: %p %p %u\n", 
+				(void *)p->address, (void *)p->orig_address, 
+				swp_offset(p->swap_address));
+#endif
+	}
+
+	for (i = 0; i < nr_copy_pcs; i++) {
+		entry = (pagedir_cache + i)->swap_address;
+		if (entry.val)
+			swap_free(entry);
+	}
+	free_pages((unsigned long)pagedir_cache, pcs_order);
+	printk(" %d done.\n",i);
+
+	return (0);
+}
+
+static int pcs_write(void)
+{
+	int error = 0;
+	int i;
+
+	printk( "Writing PageCaches to swap (%d pages): ", nr_copy_pcs);
+	for (i = 0; i < nr_copy_pcs && !error; i++) {
+		if (!(i%100))
+			printk( "." );
+		error = write_page((pagedir_cache+i)->address,
+					  &((pagedir_cache+i)->swap_address));
+#ifdef PCS_DEBUG
+		pr_debug("pcs_write: %p %p %u\n", 
+				(void *)(pagedir_cache+i)->address, 
+				(void *)(pagedir_cache+i)->orig_address,
+				(pagedir_cache+i)->swap_address);
+#endif
+	}
+	printk(" %d Pages done.\n",i);
+
+	return error;
+}
+
+static void count_data_pages(void);
+static int swsusp_alloc(void);
+
+int pcs_suspend(int resume)
+{
+	struct zone *zone;
+	suspend_pagedir_t *pe = NULL;
+	int error;
+
+	if (resume == 1) {
+		return (0);
+	}
+	if (resume == 2) {
+		pcs_read();
+		return (0);
+	}
+
+	nr_copy_pcs = 0;
+
+	drain_local_pages();
+	for_each_zone(zone) {
+		if (!is_highmem(zone)) {
+			nr_copy_pcs += count_pcs(zone, NULL);
+		}
+	}
+
+	printk("swsusp: Need to copy %u pcs\n", nr_copy_pcs);
+
+	if (nr_copy_pcs == 0) {
+		return (0);
+	}
+
+	if ((error = swsusp_swap_check()))
+		return error;
+
+	if ((error = alloc_pagedir_cache())) {
+		return error;
+	}
+
+	drain_local_pages();
+	count_data_pages();
+	printk("swsusp(1/2): Need to copy %u pages, %u pcs\n",
+			nr_copy_pages, nr_copy_pcs);
+
+	error = swsusp_alloc();
+	if (error)
+		return error;
+	
+	drain_local_pages();
+	count_data_pages();
+	printk("swsusp(2/2): Need to copy %u pages, %u pcs\n",
+			nr_copy_pages, nr_copy_pcs);
+
+	pe = pagedir_cache;
+
+	drain_local_pages();
+	for_each_zone(zone) {
+		if (!is_highmem(zone)) {
+			count_pcs(zone, &pe);
+		}
+	}
+	return pcs_write();
+}
 
 static int pfn_is_nosave(unsigned long pfn)
 {
@@ -547,7 +816,10 @@
 		*zone_pfn += chunk_size - 1;
 		return 0;
 	}
-
+	if ((zone->nr_inactive || zone->nr_active) && 
+			find_pcs(zone, page)) {
+		return 0;
+	}
 	return 1;
 }
 
@@ -557,9 +829,12 @@
 	unsigned long zone_pfn;
 
 	nr_copy_pages = 0;
+	nr_copy_pcs = 0;
 
 	for_each_zone(zone) {
 		if (!is_highmem(zone)) {
+			if (zone->nr_inactive || zone->nr_active)
+				nr_copy_pcs += count_pcs(zone, NULL);
 			for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn)
 				nr_copy_pages += saveable(zone, &zone_pfn);
 		}
@@ -621,47 +896,6 @@
 }
 
 
-/**
- *	calc_order - Determine the order of allocation needed for pagedir_save.
- *
- *	This looks tricky, but is just subtle. Please fix it some time.
- *	Since there are %nr_copy_pages worth of pages in the snapshot, we need
- *	to allocate enough contiguous space to hold 
- *		(%nr_copy_pages * sizeof(struct pbe)), 
- *	which has the saved/orig locations of the page.. 
- *
- *	SUSPEND_PD_PAGES() tells us how many pages we need to hold those 
- *	structures, then we call get_bitmask_order(), which will tell us the
- *	last bit set in the number, starting with 1. (If we need 30 pages, that
- *	is 0x0000001e in hex. The last bit is the 5th, which is the order we 
- *	would use to allocate 32 contiguous pages).
- *
- *	Since we also need to save those pages, we add the number of pages that
- *	we need to nr_copy_pages, and in case of an overflow, do the 
- *	calculation again to update the number of pages needed. 
- *
- *	With this model, we will tend to waste a lot of memory if we just cross
- *	an order boundary. Plus, the higher the order of allocation that we try
- *	to do, the more likely we are to fail in a low-memory situtation 
- *	(though	we're unlikely to get this far in such a case, since swsusp 
- *	requires half of memory to be free anyway).
- */
-
-
-static void calc_order(void)
-{
-	int diff = 0;
-	int order = 0;
-
-	do {
-		diff = get_bitmask_order(SUSPEND_PD_PAGES(nr_copy_pages)) - order;
-		if (diff) {
-			order += diff;
-			nr_copy_pages += 1 << diff;
-		}
-	} while(diff);
-	pagedir_order = order;
-}
 
 
 /**
@@ -673,13 +907,14 @@
 
 static int alloc_pagedir(void)
 {
-	calc_order();
+	calc_order(&pagedir_order, &nr_copy_pages);
 	pagedir_save = (suspend_pagedir_t *)__get_free_pages(GFP_ATOMIC | __GFP_COLD,
 							     pagedir_order);
 	if (!pagedir_save)
 		return -ENOMEM;
 	memset(pagedir_save, 0, (1 << pagedir_order) * PAGE_SIZE);
 	pagedir_nosave = pagedir_save;
+	pr_debug("pagedir %p, %d\n", pagedir_save, pagedir_order);
 	return 0;
 }
 
@@ -783,7 +1018,6 @@
 int suspend_prepare_image(void)
 {
 	unsigned int nr_needed_pages = 0;
-	int error;
 
 	pr_debug("swsusp: critical section: \n");
 	if (save_highmem()) {
@@ -791,15 +1025,8 @@
 		return -ENOMEM;
 	}
 
-	drain_local_pages();
-	count_data_pages();
-	printk("swsusp: Need to copy %u pages\n",nr_copy_pages);
 	nr_needed_pages = nr_copy_pages + PAGES_FOR_IO;
 
-	error = swsusp_alloc();
-	if (error)
-		return error;
-	
 	/* During allocating of suspend pagedir, new cold pages may appear. 
 	 * Kill them.
 	 */
@@ -1011,7 +1238,7 @@
 }
 
 
-static struct block_device * resume_bdev;
+static struct block_device * resume_bdev __nosavedata;
 
 /**
  *	submit - submit BIO request.
@@ -1151,6 +1378,11 @@
 			printk( "." );
 		error = bio_read_page(swp_offset(p->swap_address),
 				  (void *)p->address);
+#ifdef PCS_DEBUG
+		pr_debug("data_read: %p %p %u\n", 
+				(void *)p->address, (void *)p->orig_address, 
+				swp_offset(p->swap_address));
+#endif
 	}
 	printk(" %d done.\n",i);
 	return error;
@@ -1219,7 +1451,7 @@
 	if (!IS_ERR(resume_bdev)) {
 		set_blocksize(resume_bdev, PAGE_SIZE);
 		error = read_suspend_image();
-		blkdev_put(resume_bdev);
+		/* blkdev_put(resume_bdev); */
 	} else
 		error = PTR_ERR(resume_bdev);
 
--
Hu Gang / Steve
Linux Registered User 204016
GPG Public Key: http://soulinfo.com/~hugang/hugang.asc
