Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263033AbUKTDN2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263033AbUKTDN2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 22:13:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263074AbUKTDLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 22:11:07 -0500
Received: from [220.248.27.114] ([220.248.27.114]:7072 "HELO soulinfo.com")
	by vger.kernel.org with SMTP id S263091AbUKTDFi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 22:05:38 -0500
Date: Sat, 20 Nov 2004 11:03:40 +0800
From: hugang@soulinfo.com
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: swsusp bigdiff [was Re: [PATCH] Software Suspend split to two stage V2.]
Message-ID: <20041120030340.GA4026@hugang.soulinfo.com>
References: <20041119194007.GA1650@hugang.soulinfo.com> <20041120003010.GG1594@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041120003010.GG1594@elf.ucw.cz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 20, 2004 at 01:30:10AM +0100, Pavel Machek wrote:
> Hi!
> 
> >   This patch using pagemap for PageSet2 bitmap, It increase suspend
> >   speed, In my PowerPC suspend only need 5 secs, cool. 
> > 
> >   Test passed in my ppc and x86 laptop.
> > 
> >   ppc swsusp patch for 2.6.9
> >    http://honk.physik.uni-konstanz.de/~agx/linux-ppc/kernel/
> >   Have fun.
> 
> BTW here's my curent bigdiff. It already has some rather nice
> swsusp speedups. Please try it on your machine; if it works for you,
> try to send your patches relative to this one. I hope to merge these
> changes during 2.6.11.

Really big diff, I'll trying.

Here is my diff.

Changes:
  * Change pcs_ to page_cachs_
  * Hold lru_lock to sure data not modified, I can't sure that full
   works, but tested passed.
  * Adding new page flags, I'll move to mm-flags when it doing right
   things.
  * If memory not enough, using shrink_all_memory to get more.

diff -ur linux-2.6.9/kernel/power/disk.c linux-2.6.9-hg/kernel/power/disk.c
--- linux-2.6.9/kernel/power/disk.c	2004-10-20 16:00:53.000000000 +0800
+++ linux-2.6.9-hg/kernel/power/disk.c	2004-11-20 09:37:17.000000000 +0800
@@ -17,7 +17,6 @@
 #include <linux/fs.h>
 #include "power.h"
 
-
 extern u32 pm_disk_mode;
 extern struct pm_ops * pm_ops;
 
@@ -27,6 +26,8 @@
 extern int swsusp_resume(void);
 extern int swsusp_free(void);
 
+extern int write_page_caches(void);
+extern int read_page_caches(void);
 
 static int noresume = 0;
 char resume_file[256] = CONFIG_PM_STD_PARTITION;
@@ -73,7 +74,7 @@
 
 static int in_suspend __nosavedata = 0;
 
-
+#if 0
 /**
  *	free_some_memory -  Try to free as much memory as possible
  *
@@ -91,7 +92,7 @@
 	printk("|\n");
 }
 
-
+#endif
 static inline void platform_finish(void)
 {
 	if (pm_disk_mode == PM_DISK_PLATFORM) {
@@ -104,13 +105,14 @@
 {
 	device_resume();
 	platform_finish();
+	read_page_caches();
 	enable_nonboot_cpus();
 	thaw_processes();
 	pm_restore_console();
 }
 
 
-static int prepare(void)
+static int prepare(int resume)
 {
 	int error;
 
@@ -130,9 +132,14 @@
 	}
 
 	/* Free memory before shutting down devices. */
-	free_some_memory();
+	//free_some_memory();
 
 	disable_nonboot_cpus();
+	if (!resume) {
+		if ((error = write_page_caches())) {
+			goto Finish;
+		}
+	}
 	if ((error = device_suspend(PM_SUSPEND_DISK)))
 		goto Finish;
 
@@ -160,7 +167,7 @@
 {
 	int error;
 
-	if ((error = prepare()))
+	if ((error = prepare(0)))
 		return error;
 
 	pr_debug("PM: Attempting to suspend to disk.\n");
@@ -226,7 +233,7 @@
 
 	pr_debug("PM: Preparing system for restore.\n");
 
-	if ((error = prepare()))
+	if ((error = prepare(1)))
 		goto Free;
 
 	barrier();
diff -ur linux-2.6.9/kernel/power/process.c linux-2.6.9-hg/kernel/power/process.c
--- linux-2.6.9/kernel/power/process.c	2004-10-20 16:00:53.000000000 +0800
+++ linux-2.6.9-hg/kernel/power/process.c	2004-11-20 01:20:31.000000000 +0800
@@ -4,8 +4,6 @@
  *
  * Originally from swsusp.
  */
-
-
 #undef DEBUG
 
 #include <linux/smp_lock.h>
diff -ur linux-2.6.9/kernel/power/swsusp.c linux-2.6.9-hg/kernel/power/swsusp.c
--- linux-2.6.9/kernel/power/swsusp.c	2004-10-20 16:00:53.000000000 +0800
+++ linux-2.6.9-hg/kernel/power/swsusp.c	2004-11-20 10:45:13.000000000 +0800
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
@@ -505,6 +511,326 @@
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
+	int inactive = 0, active = 0;
+
+	/* spin_lock_irq(&zone->lru_lock); */
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
+	/* spin_unlock_irq(&zone->lru_lock); */
+
+	return (active + inactive);
+}
+
+/* I'll move this to include/linux/page-flags.h */
+#define PG_pcs (PG_reclaim + 1)
+
+#define SetPagePcs(page)    set_bit(PG_pcs, &(page)->flags)
+#define ClearPagePcs(page)  clear_bit(PG_pcs, &(page)->flags)
+#define PagePcs(page)   test_bit(PG_pcs, &(page)->flags)
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
+		BUG_ON(!PagePcs(page));
+		(*pe)->address = (long) page_address(page);
+		(*pe) ++;
+	} 
+	SetPagePcs(page);
+
+	return (1);
+}
+
+static int count_pcs(struct zone *zone, suspend_pagedir_t **pe)
+{
+	return foreach_zone_page(zone, setup_pcs_pe, pe);	
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
+static void page_cache_unlock(void)
+{
+	struct zone *zone;
+
+	for_each_zone(zone) {
+		if (!is_highmem(zone)) {
+			spin_unlock_irq(&zone->lru_lock);
+		}
+	}
+}
+
+static void page_cache_lock(void)
+{
+	struct zone *zone;
+
+	for_each_zone(zone) {
+		if (!is_highmem(zone)) {
+			spin_lock_irq(&zone->lru_lock);
+		}
+	}
+}
+int bio_read_page(pgoff_t page_off, void * page);
+
+int read_page_caches(void)
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
+
+	printk(" %d done.\n",i);
+
+	page_cache_unlock();
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
+static void page_caches_recal(void)
+{
+	struct zone *zone;
+	int i;
+
+	for (i = 0; i < max_mapnr; i++)
+		ClearPagePcs(mem_map+i);
+
+	nr_copy_pcs = 0;
+	drain_local_pages();
+	for_each_zone(zone) {
+		if (!is_highmem(zone)) {
+			nr_copy_pcs += count_pcs(zone, NULL);
+		}
+	}
+}
+
+int write_page_caches(void)
+{
+	struct zone *zone;
+	suspend_pagedir_t *pe = NULL;
+	int error;
+	int recal = 0;
+
+	page_cache_lock();
+	page_caches_recal();
+
+	if (nr_copy_pcs == 0) {
+		page_cache_unlock();
+		return (0);
+	}
+	printk("swsusp: Need to copy %u pcs\n", nr_copy_pcs);
+
+	if ((error = swsusp_swap_check())) {
+		page_cache_unlock();
+		return error;
+	}
+
+	if ((error = alloc_pagedir_cache())) {
+		page_cache_unlock();
+		return error;
+	}
+
+	drain_local_pages();
+	count_data_pages();
+	printk("swsusp(1/2): Need to copy %u pages, %u pcs\n",
+			nr_copy_pages, nr_copy_pcs);
+
+	while (nr_free_pages() < nr_copy_pages + PAGES_FOR_IO) {
+		if (recal == 0) {
+			page_cache_unlock();
+		}
+		printk("#");
+		shrink_all_memory(nr_copy_pages + PAGES_FOR_IO);
+		recal ++;
+	}
+
+	if (recal) {
+		page_cache_lock();
+		page_caches_recal();
+		drain_local_pages();
+		count_data_pages();
+		printk("swsusp(1/2): Need to copy %u pages, %u pcs\n",
+				nr_copy_pages, nr_copy_pcs);
+	}
+	
+	drain_local_pages();
+	count_data_pages();
+	printk("swsusp(2/2): Need to copy %u pages, %u pcs\n",
+			nr_copy_pages, nr_copy_pcs);
+
+	error = swsusp_alloc();
+	if (error) {
+		printk("swsusp_alloc failed, %d\n", error);
+		return error;
+	}
+
+	drain_local_pages();
+	count_data_pages();
+	printk("swsusp(final): Need to copy %u/%u pages, %u pcs\n",
+			nr_copy_pages, nr_copy_pages_check, nr_copy_pcs);
+	BUG_ON(nr_copy_pages_check != nr_copy_pages);
+
+	pe = pagedir_cache;
+
+	drain_local_pages();
+	for_each_zone(zone) {
+		if (!is_highmem(zone)) {
+			count_pcs(zone, &pe);
+		}
+	}
+	error = pcs_write();
+	if (error) 
+		return error;
+
+	return (0);
+}
 
 static int pfn_is_nosave(unsigned long pfn)
 {
@@ -543,11 +869,14 @@
 		pr_debug("[nosave pfn 0x%lx]", pfn);
 		return 0;
 	}
+	if (PagePcs(page)) {
+		BUG_ON(zone->nr_inactive == 0 && zone->nr_active == 0) ;
+		return (0);
+	}
 	if ((chunk_size = is_head_of_free_region(page))) {
 		*zone_pfn += chunk_size - 1;
 		return 0;
 	}
-
 	return 1;
 }
 
@@ -557,9 +886,11 @@
 	unsigned long zone_pfn;
 
 	nr_copy_pages = 0;
+	nr_copy_pcs = 0;
 
 	for_each_zone(zone) {
 		if (!is_highmem(zone)) {
+			nr_copy_pcs += count_pcs(zone, NULL);
 			for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn)
 				nr_copy_pages += saveable(zone, &zone_pfn);
 		}
@@ -621,47 +952,6 @@
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
@@ -673,13 +963,15 @@
 
 static int alloc_pagedir(void)
 {
-	calc_order();
+	calc_order(&pagedir_order, &nr_copy_pages);
 	pagedir_save = (suspend_pagedir_t *)__get_free_pages(GFP_ATOMIC | __GFP_COLD,
 							     pagedir_order);
 	if (!pagedir_save)
 		return -ENOMEM;
 	memset(pagedir_save, 0, (1 << pagedir_order) * PAGE_SIZE);
+	
 	pagedir_nosave = pagedir_save;
+	pr_debug("pagedir %p, %d\n", pagedir_save, pagedir_order);
 	return 0;
 }
 
@@ -766,11 +1058,11 @@
 		return -ENOSPC;
 
 	if ((error = alloc_pagedir())) {
-		pr_debug("suspend: Allocating pagedir failed.\n");
+		printk("suspend: Allocating pagedir failed.\n");
 		return error;
 	}
 	if ((error = alloc_image_pages())) {
-		pr_debug("suspend: Allocating image pages failed.\n");
+		printk("suspend: Allocating image pages failed.\n");
 		swsusp_free();
 		return error;
 	}
@@ -783,7 +1075,6 @@
 int suspend_prepare_image(void)
 {
 	unsigned int nr_needed_pages = 0;
-	int error;
 
 	pr_debug("swsusp: critical section: \n");
 	if (save_highmem()) {
@@ -791,15 +1082,8 @@
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
@@ -1011,7 +1295,7 @@
 }
 
 
-static struct block_device * resume_bdev;
+static struct block_device * resume_bdev __nosavedata;
 
 /**
  *	submit - submit BIO request.
@@ -1151,6 +1435,11 @@
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
@@ -1219,7 +1508,7 @@
 	if (!IS_ERR(resume_bdev)) {
 		set_blocksize(resume_bdev, PAGE_SIZE);
 		error = read_suspend_image();
-		blkdev_put(resume_bdev);
+		/* blkdev_put(resume_bdev); */
 	} else
 		error = PTR_ERR(resume_bdev);
 
Only in linux-2.6.9-hg/mm: .vmscan.c.swp
-- 
--
Hu Gang / Steve
Linux Registered User 204016
GPG Public Key: http://soulinfo.com/~hugang/hugang.asc
