Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263213AbUKUHyv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263213AbUKUHyv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 02:54:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261927AbUKUHyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 02:54:08 -0500
Received: from [220.248.27.114] ([220.248.27.114]:1964 "HELO soulinfo.com")
	by vger.kernel.org with SMTP id S263214AbUKUHvc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 02:51:32 -0500
Date: Sun, 21 Nov 2004 15:48:01 +0800
From: hugang@soulinfo.com
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: swsusp bigdiff [was Re: [PATCH] Software Suspend split to two stage V2.]
Message-ID: <20041121074801.GA5626@hugang.soulinfo.com>
References: <20041119194007.GA1650@hugang.soulinfo.com> <20041120003010.GG1594@elf.ucw.cz> <20041120081219.GA2866@hugang.soulinfo.com> <20041120224937.GA979@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041120224937.GA979@elf.ucw.cz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 20, 2004 at 11:49:37PM +0100, Pavel Machek wrote:
> Hi!
> 
> > > >   This patch using pagemap for PageSet2 bitmap, It increase suspend
> > > >   speed, In my PowerPC suspend only need 5 secs, cool. 
> > > > 
> > > >   Test passed in my ppc and x86 laptop.
> > > > 
> > > >   ppc swsusp patch for 2.6.9
> > > >    http://honk.physik.uni-konstanz.de/~agx/linux-ppc/kernel/
> > > >   Have fun.
> > > 
> > > BTW here's my curent bigdiff. It already has some rather nice
> > > swsusp speedups. Please try it on your machine; if it works for you,
> > > try to send your patches relative to this one. I hope to merge these
> > > changes during 2.6.11.
> > > 
> > 
> > Here is the patch relative to your big diff. It tested pass with my x86
> > pc, But the sysfs interface can't works, I using reboot system call.
> 
> Without PREEMPT and HIGHMEM it worked okay on an idle system. When I
> started kernel compilation while trying to swsusp, it crashed on
> resume.
> 								Pavel

Good, Not only works for myself. Here is the update patch relative to
your diff, Now We not need continuous page to save pagecache pagedir.
have a look, please.

I don't wannt this patch can merge into mainline kernel, just have a
look thanks.

TODO:
 * I have to be sure the pagecache are not modified after saved to swap
   device until snaphot memory finished, This is the problem that why only
   system idle can worked, But how can i sure that? :)
 * Adding comments in source code, :)
 * Clean ppc part then send to Ben.

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
diff -ur linux-2.6.9-peval/kernel/power/swsusp.c linux-2.6.9-peval-hg/kernel/power/swsusp.c
--- linux-2.6.9-peval/kernel/power/swsusp.c	2004-11-20 14:14:45.000000000 +0800
+++ linux-2.6.9-peval-hg/kernel/power/swsusp.c	2004-11-20 23:52:26.000000000 +0800
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
@@ -504,6 +511,452 @@
 	return 0;
 }
 
+typedef int (*do_page_t)(struct page *page, int p);
+
+static int foreach_zone_page(struct zone *zone, do_page_t fun, int p)
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
+/* #define PCS_DEBUG */
+
+static struct pbe *find_pbe_by_index(int index);
+
+static int nr_copy_pcs = 0;
+
+static int setup_pcs_pe(struct page *page, int setup)
+{
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
+	if (setup) {
+		struct pbe *p = find_pbe_by_index(nr_copy_pcs);
+		p->address = (long)page_address(page);
+#ifdef PCS_DEBUG
+		printk("setup_pcs: cur %p, addr %p, next %p, nr%d\n",
+				p, p->address, p->orig_address, nr_copy_pcs);
+#endif
+		nr_copy_pcs ++;
+	}
+	SetPagePcs(page);
+
+	return (1);
+}
+
+static int count_pcs(struct zone *zone, int p)
+{
+	return foreach_zone_page(zone, setup_pcs_pe, p);	
+}
+
+static suspend_pagedir_t *pagedir_cache = NULL;
+
+/*
+ * redefine in PageCahe pagdir.
+ *
+ * struct pbe {
+ * unsigned long address;      
+ * unsigned long orig_address; pointer of next struct pbe
+ * swp_entry_t swap_address;   
+ * swp_entry_t dummy;          current index
+ * }
+ *
+ */
+static suspend_pagedir_t * alloc_one_pagedir(suspend_pagedir_t *prev,
+		unsigned int nums)
+{
+	suspend_pagedir_t *pgdir;
+	int i;
+
+	pgdir = (suspend_pagedir_t *)
+		__get_free_pages(GFP_ATOMIC | __GFP_COLD, 0);
+	if (!pgdir) {
+		return NULL;
+	}
+#ifdef PCS_DEBUG
+	printk("pgdir: %p, %p, %d\n", pgdir, prev, sizeof(suspend_pagedir_t));
+#endif
+	memset(pgdir, 0, PAGE_SIZE);
+	for (i = 0; i < nums; i++) {
+		pgdir[i].dummy.val = i;
+		pgdir[i].orig_address = (unsigned long)NULL;
+		if (prev == NULL) continue;
+		prev[i].orig_address = (unsigned long)pgdir;
+	}
+
+	return (pgdir);
+}
+
+/* for each pagdir */
+typedef int (*susp_pgdir_t)(suspend_pagedir_t *cur, void *fun, void *arg);
+
+static int for_each_pgdir(susp_pgdir_t fun, void *subfun, void *arg)
+{
+	suspend_pagedir_t *pgdir = pagedir_cache;
+	int error = 0;
+
+	while (pgdir != NULL) {
+		suspend_pagedir_t *next = (suspend_pagedir_t *)pgdir->orig_address;
+#ifdef PCS_DEBUG
+		printk("next %p, cur %p\n", next, pgdir);
+#endif
+		error = fun(pgdir, subfun, arg);
+		if (error) return error;
+		pgdir = next;
+	}
+
+	return (0);
+}
+
+/* free one pagedir */
+static int free_one_pagedir(suspend_pagedir_t *pgdir, void *fun, void *arg)
+{
+	free_page((unsigned long)pgdir);
+	return (0);
+}
+
+typedef int (*swsup_pbe_t)(struct pbe *bpe, void *p);
+
+static int for_pbe_one_pgdir(suspend_pagedir_t *pgdir, void *_fun, void *arg)
+{
+	unsigned int num_pbes = PAGE_SIZE / sizeof(suspend_pagedir_t) - 1, nums;
+	swsup_pbe_t fun = _fun;
+	int error = 0;
+
+#ifdef PCS_DEBUG
+	printk("for_pbe_one_pgdir: %p, %p, %p\n", pgdir, _fun, arg);
+#endif
+	for (nums = 0; nums < num_pbes; nums++) {
+		error = fun(pgdir, arg);
+		pgdir ++;
+		if (error) return error;
+	}
+
+	return (0);
+}
+
+static int for_each_pbe(swsup_pbe_t fun, void *p)
+{
+	return for_each_pgdir(for_pbe_one_pgdir, fun, p);
+}
+
+static struct pbe *find_pbe_by_index(int index)
+{
+	unsigned int num_pbes = PAGE_SIZE / sizeof(suspend_pagedir_t) - 1, 
+	nums = num_pbes;
+	suspend_pagedir_t *pgdir = pagedir_cache, *next;
+	
+	while (pgdir != NULL) {
+		if (index < nums) 
+			return pgdir + (index % num_pbes);
+		next = (suspend_pagedir_t *)pgdir->orig_address;
+		nums += num_pbes;
+		pgdir = next;
+	}
+	
+	return (NULL);
+}
+
+static int alloc_pagedir_cache(void)
+{
+	unsigned int num_pbes = PAGE_SIZE / sizeof(suspend_pagedir_t) - 1, nums = 0;
+	suspend_pagedir_t *prev, *cur = NULL;
+
+	/* be sure suspend_pagedir_t can safed put into one page */
+	BUG_ON(PAGE_SIZE % sizeof(suspend_pagedir_t));
+
+	/* alloc pagedir head */
+	pagedir_cache = alloc_one_pagedir(NULL, num_pbes);
+	if (!pagedir_cache) {
+		return -ENOMEM;
+	}
+	prev = pagedir_cache;
+
+	for (nums = num_pbes; nums < nr_copy_pcs; nums += num_pbes) {
+		cur = alloc_one_pagedir(prev, num_pbes);
+		if (!cur) {
+			goto no_mem;
+		}
+		prev = cur;
+	}
+
+	pr_debug("swsusp: nums %d, nums_pbes %d \n", nums, num_pbes);
+	return 0;
+
+no_mem:
+	printk("swsusp: alloc_pages failed, %d\n", nr_copy_pcs);
+	for_each_pgdir(free_one_pagedir, NULL, NULL);
+
+	return (-ENOMEM);
+}
+
+/* pagedir lock and unlock function */
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
+
+int bio_read_page(pgoff_t page_off, void * page);
+
+static int mod = 1;
+
+static int pagecache_read_pbe(struct pbe *p, void *tmp)
+{
+	int error = 0, i = *(int*)tmp;
+	swp_entry_t entry;
+
+	if (!(i%100))
+		printk( "\b\b\b\b%3d%%", i / mod );
+
+	if (i == nr_copy_pcs) return -1;
+
+	(*(int*)tmp) ++;
+#ifdef PCS_DEBUG
+	printk("pagecache_read_pbe: %p %p %u\n", 
+			(void *)p->address, (void *)p->orig_address, 
+			swp_offset(p->swap_address));
+#endif
+
+	error = bio_read_page(swp_offset(p->swap_address), (void *)p->address);
+	if (error) return error;
+
+	entry = p->swap_address;
+	if (entry.val)
+		swap_free(entry);
+
+	return (0);
+}
+
+int read_page_caches(void)
+{
+	int error = 0, i = 0;
+	
+	mod = nr_copy_pcs / 100;
+
+	printk( "Reading PageCaches from swap (%d pages)...     ", nr_copy_pcs);
+	error = for_each_pbe(pagecache_read_pbe, &i);
+	printk("\b\b\b\bdone\n");
+
+	for_each_pgdir(free_one_pagedir, NULL, NULL);
+
+	page_cache_unlock();
+
+	if (i == nr_copy_pcs)  return (0);
+
+	return error;
+}
+
+static int pagecache_write_pbe(struct pbe *p, void *tmp)
+{
+	int error = 0, i = *(int*)tmp;
+
+	if (!(i%100))
+		printk( "\b\b\b\b%3d%%", i / mod );
+
+	if (i == nr_copy_pcs) return -1;
+
+	(*(int*)tmp) ++;
+	error = write_page(p->address, &p->swap_address);
+	if (error) return error;
+
+#ifdef PCS_DEBUG
+	printk("pagecache_write_pbe: %p, %p %p %u\n", 
+			p, (void *)p->address, (void *)p->orig_address, p->swap_address);
+#endif
+
+	return (0);
+}
+
+static int pcs_write(void)
+{
+	int i = 0, error;
+	
+	page_cache_lock();
+
+	mod = nr_copy_pcs / 100;
+
+	printk( "Writing PageCaches to swap (%d pages)...     ", nr_copy_pcs);
+	error = for_each_pbe(pagecache_write_pbe, &i);
+	printk("\b\b\b\bdone\n");
+
+	if (i == nr_copy_pcs)  return (0);
+
+	return error;
+}
+
+static int setup_pagedir_pbe(void)
+{
+	struct zone *zone;
+
+	nr_copy_pcs = 0;
+	for_each_zone(zone) {
+		if (!is_highmem(zone)) {
+			count_pcs(zone, 1);
+		}
+	}
+
+	return (0);
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
+			nr_copy_pcs += count_pcs(zone, 0);
+		}
+	}
+}
+
+int write_page_caches(void)
+{
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
+	setup_pagedir_pbe();
+
+	error = pcs_write();
+	if (error) 
+		return error;
+
+	return (0);
+}
 
 static int pfn_is_nosave(unsigned long pfn)
 {
@@ -539,7 +992,10 @@
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
 
@@ -549,10 +1005,12 @@
 	unsigned long zone_pfn;
 
 	nr_copy_pages = 0;
+	nr_copy_pcs = 0;
 
 	for_each_zone(zone) {
 		if (is_highmem(zone))
 			continue;
+		nr_copy_pcs += count_pcs(zone, 0);
 		mark_free_pages(zone);
 		for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn)
 			nr_copy_pages += saveable(zone, &zone_pfn);
@@ -646,7 +1104,9 @@
 	if (!pagedir_save)
 		return -ENOMEM;
 	memset(pagedir_save, 0, (1 << pagedir_order) * PAGE_SIZE);
+	
 	pagedir_nosave = pagedir_save;
+	pr_debug("pagedir %p, %d\n", pagedir_save, pagedir_order);
 	return 0;
 }
 
@@ -752,15 +1212,16 @@
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
@@ -768,7 +1229,6 @@
 int suspend_prepare_image(void)
 {
 	unsigned int nr_needed_pages;
-	int error;
 
 	pr_debug("swsusp: critical section: \n");
 	if (save_highmem()) {
@@ -777,15 +1237,8 @@
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
@@ -855,10 +1308,12 @@
 asmlinkage int swsusp_restore(void)
 {
 	BUG_ON (pagedir_order_check != pagedir_order);
-	
+	BUG_ON (nr_copy_pages_check != nr_copy_pages);
+#if defined(__i386__)
 	/* Even mappings of "global" things (vmalloc) need to be fixed */
 	__flush_tlb_global();
 	wbinvd();	/* Nigel says wbinvd here is good idea... */
+#endif
 	return 0;
 }
 
@@ -993,7 +1448,7 @@
 	return 0;
 }
 
-static struct block_device * resume_bdev;
+static struct block_device * resume_bdev __nosavedata;
 
 /**
  *	submit - submit BIO request.
@@ -1141,6 +1596,11 @@
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
@@ -1207,7 +1667,7 @@
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
