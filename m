Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261253AbUKTIP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbUKTIP6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 03:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbUKTIP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 03:15:58 -0500
Received: from [220.248.27.114] ([220.248.27.114]:57509 "HELO soulinfo.com")
	by vger.kernel.org with SMTP id S261283AbUKTIOh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 03:14:37 -0500
Date: Sat, 20 Nov 2004 16:12:19 +0800
From: hugang@soulinfo.com
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: swsusp bigdiff [was Re: [PATCH] Software Suspend split to two stage V2.]
Message-ID: <20041120081219.GA2866@hugang.soulinfo.com>
References: <20041119194007.GA1650@hugang.soulinfo.com> <20041120003010.GG1594@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041120003010.GG1594@elf.ucw.cz>
User-Agent: Mutt/1.3.28i
X-Virus-Checked: Checked
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
> 

Here is the patch relative to your big diff. It tested pass with my x86
pc, But the sysfs interface can't works, I using reboot system call.

TODO:
  Using range struct replace with pagedir in PageCache links, Current
   pagedir can't works with large pages, it need many continuous phiscal
   pages

diff -ur linux-2.6.9-peval/kernel/power/disk.c linux-2.6.9-peval-hg/kernel/power/disk.c
--- linux-2.6.9-peval/kernel/power/disk.c	2004-11-20 14:14:45.000000000 +0800
+++ linux-2.6.9-peval-hg/kernel/power/disk.c	2004-11-20 14:51:21.000000000 +0800
@@ -29,6 +29,8 @@
 extern int swsusp_resume(void);
 extern int swsusp_free(void);
 
+extern int write_page_caches(void);
+extern int read_page_caches(void);
 
 static int noresume = 0;
 char resume_file[256] = CONFIG_PM_STD_PARTITION;
@@ -106,6 +108,7 @@
 	}
 }
 
+
 static inline void platform_finish(void)
 {
 	if (pm_disk_mode == PM_DISK_PLATFORM) {
@@ -118,13 +121,14 @@
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
 
@@ -144,9 +148,13 @@
 	}
 
 	/* Free memory before shutting down devices. */
-	free_some_memory();
+	/* free_some_memory(); */
 
 	disable_nonboot_cpus();
+	if (!resume) 
+		if ((error = write_page_caches())) {
+			goto Finish;
+		}
 	if ((error = device_suspend(PMSG_FREEZE))) {
 		printk("Some devices failed to suspend\n");
 		goto Finish;
@@ -176,7 +184,7 @@
 {
 	int error;
 
-	if ((error = prepare()))
+	if ((error = prepare(0)))
 		return error;
 
 	pr_debug("PM: Attempting to suspend to disk.\n");
@@ -233,7 +241,7 @@
 
 	pr_debug("PM: Preparing system for restore.\n");
 
-	if ((error = prepare()))
+	if ((error = prepare(1)))
 		goto Free;
 
 	barrier();
Only in linux-2.6.9-peval-hg/kernel/power: disk.c~
diff -ur linux-2.6.9-peval/kernel/power/process.c linux-2.6.9-peval-hg/kernel/power/process.c
--- linux-2.6.9-peval/kernel/power/process.c	2004-10-20 16:00:53.000000000 +0800
+++ linux-2.6.9-peval-hg/kernel/power/process.c	2004-11-20 14:47:40.000000000 +0800
@@ -4,8 +4,6 @@
  *
  * Originally from swsusp.
  */
-
-
 #undef DEBUG
 
 #include <linux/smp_lock.h>
diff -ur linux-2.6.9-peval/kernel/power/swsusp.c linux-2.6.9-peval-hg/kernel/power/swsusp.c
--- linux-2.6.9-peval/kernel/power/swsusp.c	2004-11-20 14:14:45.000000000 +0800
+++ linux-2.6.9-peval-hg/kernel/power/swsusp.c	2004-11-20 16:04:27.000000000 +0800
@@ -76,6 +76,7 @@
 
 /* Variables to be preserved over suspend */
 static int pagedir_order_check;
+static int nr_copy_pages_check;
 
 extern char resume_file[];
 static dev_t resume_device;
@@ -302,6 +303,12 @@
 			printk( "\b\b\b\b%3d%%", i / mod );
 		error = write_page((pagedir_nosave+i)->address,
 					  &((pagedir_nosave+i)->swap_address));
+#ifdef PCS_DEBUG
+		pr_debug("data_write: %p %p %u\n", 
+				(void *)(pagedir_nosave+i)->address, 
+				(void *)(pagedir_nosave+i)->orig_address,
+				(pagedir_nosave+i)->swap_address);
+#endif
 	}
 	printk("\b\b\b\bdone\n");
 	return error;
@@ -504,6 +511,327 @@
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
+#define PG_pcs (PG_nosave_free + 1)
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
+	int mod = nr_copy_pcs / 100;
+
+	printk( "Reading PageCaches from swap (%d pages)...     ", nr_copy_pcs);
+	for(i = 0, p = pagedir_cache; i < nr_copy_pcs && !error; i++, p++) {
+		if (!(i%100))
+			printk( "\b\b\b\b%3d%%", i / mod );
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
+	printk("\b\b\b\bdone\n");
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
+	int mod = nr_copy_pcs / 100;
+
+	printk( "Writing PageCaches to swap (%d pages)...     ", nr_copy_pcs);
+	for (i = 0; i < nr_copy_pcs && !error; i++) {
+		if (!(i%100))
+			printk( "\b\b\b\b%3d%%", i / mod );
+		error = write_page((pagedir_cache+i)->address,
+					  &((pagedir_cache+i)->swap_address));
+#ifdef PCS_DEBUG
+		pr_debug("pcs_write: %p %p %u\n", 
+				(void *)(pagedir_cache+i)->address, 
+				(void *)(pagedir_cache+i)->orig_address,
+				(pagedir_cache+i)->swap_address);
+#endif
+	}
+	printk("\b\b\b\bdone\n");
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
@@ -539,7 +867,10 @@
 	}
 	if (PageNosaveFree(page))
 		return 0;
-
+	if (PagePcs(page)) {
+		BUG_ON(zone->nr_inactive == 0 && zone->nr_active == 0);
+		return 0;
+	}
 	return 1;
 }
 
@@ -549,10 +880,12 @@
 	unsigned long zone_pfn;
 
 	nr_copy_pages = 0;
+	nr_copy_pcs = 0;
 
 	for_each_zone(zone) {
 		if (is_highmem(zone))
 			continue;
+		nr_copy_pcs += count_pcs(zone, NULL);
 		mark_free_pages(zone);
 		for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn)
 			nr_copy_pages += saveable(zone, &zone_pfn);
@@ -588,47 +921,6 @@
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
@@ -640,13 +932,15 @@
 
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
 
@@ -752,15 +1046,16 @@
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
 
+	nr_copy_pages_check = nr_copy_pages;
 	pagedir_order_check = pagedir_order;
 	return 0;
 }
@@ -768,7 +1063,6 @@
 int suspend_prepare_image(void)
 {
 	unsigned int nr_needed_pages;
-	int error;
 
 	pr_debug("swsusp: critical section: \n");
 	if (save_highmem()) {
@@ -777,15 +1071,8 @@
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
@@ -855,7 +1142,8 @@
 asmlinkage int swsusp_restore(void)
 {
 	BUG_ON (pagedir_order_check != pagedir_order);
-	
+	BUG_ON (nr_copy_pages_check != nr_copy_pages);
+
 	/* Even mappings of "global" things (vmalloc) need to be fixed */
 	__flush_tlb_global();
 	wbinvd();	/* Nigel says wbinvd here is good idea... */
@@ -993,7 +1281,7 @@
 	return 0;
 }
 
-static struct block_device * resume_bdev;
+static struct block_device * resume_bdev __nosavedata;
 
 /**
  *	submit - submit BIO request.
@@ -1141,6 +1429,11 @@
 			printk( "\b\b\b\b%3d%%", i / mod );
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
@@ -1207,7 +1500,7 @@
 	if (!IS_ERR(resume_bdev)) {
 		set_blocksize(resume_bdev, PAGE_SIZE);
 		error = read_suspend_image();
-		blkdev_put(resume_bdev);
+		/* blkdev_put(resume_bdev); */
 	} else
 		error = PTR_ERR(resume_bdev);
 
Only in linux-2.6.9-peval-hg/kernel/power: swsusp.c~

--
Hu Gang / Steve
Linux Registered User 204016
GPG Public Key: http://soulinfo.com/~hugang/hugang.asc
