Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261196AbVAaN06@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbVAaN06 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 08:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261209AbVAaN06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 08:26:58 -0500
Received: from gprs215-54.eurotel.cz ([160.218.215.54]:2176 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261196AbVAaNYk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 08:24:40 -0500
Date: Mon, 31 Jan 2005 14:24:09 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>, rjw@sisk.pl
Subject: swsusp: do not use higher order memory allocations on suspend
Message-ID: <20050131132408.GA1413@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This is patch from Rafael, it eliminates order-5 (or worse)
allocations during suspend. I did few style/whitespace
modifications. It was tested by me, Rafael, and Stefan from
SuSE. Please apply,
								Pavel
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Pavel Machek <pavel@suse.cz>

--- clean/kernel/power/swsusp.c	2005-01-22 21:24:53.000000000 +0100
+++ linux/kernel/power/swsusp.c	2005-01-31 14:12:01.000000000 +0100
@@ -76,7 +76,6 @@
 extern const void __nosave_begin, __nosave_end;
 
 /* Variables to be preserved over suspend */
-static int pagedir_order_check;
 static int nr_copy_pages_check;
 
 extern char resume_file[];
@@ -225,8 +224,6 @@
 	swap_list_unlock();
 }
 
-
-
 /**
  *	write_swap_page - Write one page to a fresh swap location.
  *	@addr:	Address we're writing.
@@ -239,7 +236,6 @@
  *	This is a partial improvement, since we will at least return other
  *	errors, though we need to eventually fix the damn code.
  */
-
 static int write_page(unsigned long addr, swp_entry_t * loc)
 {
 	swp_entry_t entry;
@@ -259,14 +255,12 @@
 	return error;
 }
 
-
 /**
  *	data_free - Free the swap entries used by the saved image.
  *
  *	Walk the list of used swap entries and free each one. 
  *	This is only used for cleanup when suspend fails.
  */
-
 static void data_free(void)
 {
 	swp_entry_t entry;
@@ -282,28 +276,27 @@
 	}
 }
 
-
 /**
  *	data_write - Write saved image to swap.
  *
  *	Walk the list of pages in the image and sync each one to swap.
  */
-
 static int data_write(void)
 {
-	int error = 0;
-	int i;
+	int error = 0, i = 0;
 	unsigned int mod = nr_copy_pages / 100;
+	struct pbe *p;
 
 	if (!mod)
 		mod = 1;
 
 	printk( "Writing data to swap (%d pages)...     ", nr_copy_pages );
-	for (i = 0; i < nr_copy_pages && !error; i++) {
+	for_each_pbe(p, pagedir_nosave) {
 		if (!(i%mod))
 			printk( "\b\b\b\b%3d%%", i / mod );
-		error = write_page((pagedir_nosave+i)->address,
-					  &((pagedir_nosave+i)->swap_address));
+		if ((error = write_page(p->address, &(p->swap_address))))
+			return error;
+		i++;
 	}
 	printk("\b\b\b\bdone\n");
 	return error;
@@ -326,15 +319,14 @@
 
 static void init_header(void)
 {
-	memset(&swsusp_info,0,sizeof(swsusp_info));
+	memset(&swsusp_info, 0, sizeof(swsusp_info));
 	swsusp_info.version_code = LINUX_VERSION_CODE;
 	swsusp_info.num_physpages = num_physpages;
-	memcpy(&swsusp_info.uts,&system_utsname,sizeof(system_utsname));
+	memcpy(&swsusp_info.uts, &system_utsname, sizeof(system_utsname));
 
 	swsusp_info.suspend_pagedir = pagedir_nosave;
 	swsusp_info.cpus = num_online_cpus();
 	swsusp_info.image_pages = nr_copy_pages;
-	dump_info();
 }
 
 static int close_swap(void)
@@ -342,7 +334,8 @@
 	swp_entry_t entry;
 	int error;
 
-	error = write_page((unsigned long)&swsusp_info,&entry);
+	dump_info();
+	error = write_page((unsigned long)&swsusp_info, &entry);
 	if (!error) { 
 		printk( "S" );
 		error = mark_swapfiles(entry);
@@ -373,15 +366,18 @@
 
 static int write_pagedir(void)
 {
-	unsigned long addr = (unsigned long)pagedir_nosave;
 	int error = 0;
-	int n = SUSPEND_PD_PAGES(nr_copy_pages);
-	int i;
+	unsigned n = 0;
+	struct pbe * pbe;
+
+	printk( "Writing pagedir...");
+	for_each_pb_page(pbe, pagedir_nosave) {
+		if ((error = write_page((unsigned long)pbe, &swsusp_info.pagedir[n++])))
+			return error;
+	}
 
 	swsusp_info.pagedir_pages = n;
-	printk( "Writing pagedir (%d pages)\n", n);
-	for (i = 0; i < n && !error; i++, addr += PAGE_SIZE)
-		error = write_page(addr, &swsusp_info.pagedir[i]);
+	printk("done (%u pages)\n", n);
 	return error;
 }
 
@@ -567,8 +563,8 @@
 	struct zone *zone;
 	unsigned long zone_pfn;
 	struct pbe * pbe = pagedir_nosave;
-	int to_copy = nr_copy_pages;
 	
+	pr_debug("copy_data_pages(): pages to copy: %d\n", nr_copy_pages);
 	for_each_zone(zone) {
 		if (is_highmem(zone))
 			continue;
@@ -577,78 +573,96 @@
 			if (saveable(zone, &zone_pfn)) {
 				struct page * page;
 				page = pfn_to_page(zone_pfn + zone->zone_start_pfn);
+				BUG_ON(!pbe);
 				pbe->orig_address = (long) page_address(page);
 				/* copy_page is not usable for copying task structs. */
 				memcpy((void *)pbe->address, (void *)pbe->orig_address, PAGE_SIZE);
-				pbe++;
-				to_copy--;
+				pbe = pbe->next;
 			}
 		}
 	}
-	BUG_ON(to_copy);
+	BUG_ON(pbe);
 }
 
 
 /**
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
+ *	calc_nr - Determine the number of pages needed for a pbe list.
  */
 
-
-static void calc_order(void)
+static int calc_nr(int nr_copy)
 {
-	int diff = 0;
-	int order = 0;
+	int extra = 0;
+	int mod = !!(nr_copy % PBES_PER_PAGE);
+	int diff = (nr_copy / PBES_PER_PAGE) + mod;
 
 	do {
-		diff = get_bitmask_order(SUSPEND_PD_PAGES(nr_copy_pages)) - order;
-		if (diff) {
-			order += diff;
-			nr_copy_pages += 1 << diff;
-		}
-	} while(diff);
-	pagedir_order = order;
+		extra += diff;
+		nr_copy += diff;
+		mod = !!(nr_copy % PBES_PER_PAGE);
+		diff = (nr_copy / PBES_PER_PAGE) + mod - extra;
+	} while (diff > 0);
+
+	return nr_copy;
 }
 
+static inline void free_pagedir(struct pbe *pblist);
 
 /**
  *	alloc_pagedir - Allocate the page directory.
  *
- *	First, determine exactly how many contiguous pages we need and
+ *	First, determine exactly how many pages we need and
  *	allocate them.
+ *
+ *	We arrange the pages in a chain: each page is an array of PBES_PER_PAGE
+ *	struct pbe elements (pbes) and the last element in the page points
+ *	to the next page.
+ *
+ *	On each page we set up a list of struct_pbe elements.
  */
 
-static int alloc_pagedir(void)
+static struct pbe * alloc_pagedir(unsigned nr_pages)
 {
-	calc_order();
-	pagedir_save = (suspend_pagedir_t *)__get_free_pages(GFP_ATOMIC | __GFP_COLD,
-							     pagedir_order);
-	if (!pagedir_save)
-		return -ENOMEM;
-	memset(pagedir_save, 0, (1 << pagedir_order) * PAGE_SIZE);
-	pagedir_nosave = pagedir_save;
-	return 0;
+	unsigned num;
+	struct pbe *pblist, *pbe, *p;
+
+	if (!nr_pages)
+		return NULL;
+
+	pr_debug("alloc_pagedir(): nr_pages = %d\n", nr_pages);
+	pblist = (struct pbe *)get_zeroed_page(GFP_ATOMIC | __GFP_COLD);
+	for (pbe = pblist, num = PBES_PER_PAGE; pbe && num < nr_pages;
+        		pbe = pbe->next, num += PBES_PER_PAGE) {
+		p = pbe;
+		pbe += PB_PAGE_SKIP;
+		do
+			p->next = p + 1;
+		while (p++ < pbe);
+		pbe->next = (struct pbe *)get_zeroed_page(GFP_ATOMIC | __GFP_COLD);
+	}
+	if (pbe) {
+		for (num -= PBES_PER_PAGE - 1, p = pbe; num < nr_pages; p++, num++)
+			p->next = p + 1;
+	} else { /* get_zeroed_page() failed */
+		free_pagedir(pblist);
+		pblist = NULL;
+        }
+	pr_debug("alloc_pagedir(): allocated %d PBEs\n", num);
+	return pblist;
+}
+
+/**
+ *	free_pagedir - free pages allocated with alloc_pagedir()
+ */
+
+static inline void free_pagedir(struct pbe *pblist)
+{
+	struct pbe *pbe;
+
+	while (pblist) {
+		pbe = pblist + PB_PAGE_SKIP;
+		pblist = pbe->next;
+		free_page((unsigned long)pblist);
+	}
 }
 
 /**
@@ -658,10 +672,8 @@
 static void free_image_pages(void)
 {
 	struct pbe * p;
-	int i;
 
-	p = pagedir_save;
-	for (i = 0, p = pagedir_save; i < nr_copy_pages; i++, p++) {
+	for_each_pbe(p, pagedir_save) {
 		if (p->address) {
 			ClearPageNosave(virt_to_page(p->address));
 			free_page(p->address);
@@ -672,15 +684,13 @@
 
 /**
  *	alloc_image_pages - Allocate pages for the snapshot.
- *
  */
 
 static int alloc_image_pages(void)
 {
 	struct pbe * p;
-	int i;
 
-	for (i = 0, p = pagedir_save; i < nr_copy_pages; i++, p++) {
+	for_each_pbe(p, pagedir_save) {
 		p->address = get_zeroed_page(GFP_ATOMIC | __GFP_COLD);
 		if (!p->address)
 			return -ENOMEM;
@@ -694,7 +704,7 @@
 	BUG_ON(PageNosave(virt_to_page(pagedir_save)));
 	BUG_ON(PageNosaveFree(virt_to_page(pagedir_save)));
 	free_image_pages();
-	free_pages((unsigned long) pagedir_save, pagedir_order);
+	free_pagedir(pagedir_save);
 }
 
 
@@ -752,10 +762,13 @@
 	if (!enough_swap())
 		return -ENOSPC;
 
-	if ((error = alloc_pagedir())) {
+	nr_copy_pages = calc_nr(nr_copy_pages);
+
+	if (!(pagedir_save = alloc_pagedir(nr_copy_pages))) {
 		printk(KERN_ERR "suspend: Allocating pagedir failed.\n");
-		return error;
+		return -ENOMEM;
 	}
+	pagedir_nosave = pagedir_save;
 	if ((error = alloc_image_pages())) {
 		printk(KERN_ERR "suspend: Allocating image pages failed.\n");
 		swsusp_free();
@@ -763,7 +776,6 @@
 	}
 
 	nr_copy_pages_check = nr_copy_pages;
-	pagedir_order_check = pagedir_order;
 	return 0;
 }
 
@@ -780,7 +792,7 @@
 
 	drain_local_pages();
 	count_data_pages();
-	printk("swsusp: Need to copy %u pages\n",nr_copy_pages);
+	printk("swsusp: Need to copy %u pages\n", nr_copy_pages);
 
 	error = swsusp_alloc();
 	if (error)
@@ -867,7 +879,6 @@
 asmlinkage int swsusp_restore(void)
 {
 	BUG_ON (nr_copy_pages_check != nr_copy_pages);
-	BUG_ON (pagedir_order_check != pagedir_order);
 	
 	/* Even mappings of "global" things (vmalloc) need to be fixed */
 	__flush_tlb_global();
--- clean/include/linux/suspend.h	2005-01-12 11:07:40.000000000 +0100
+++ linux/include/linux/suspend.h	2005-01-31 13:57:55.000000000 +0100
@@ -16,11 +16,22 @@
 	unsigned long address;		/* address of the copy */
 	unsigned long orig_address;	/* original address of page */
 	swp_entry_t swap_address;	
-	swp_entry_t dummy;		/* we need scratch space at 
-					 * end of page (see link, diskpage)
-					 */
+
+	struct pbe *next;	/* also used as scratch space at
+				 * end of page (see link, diskpage)
+				 */
 } suspend_pagedir_t;
 
+#define for_each_pbe(pbe, pblist) \
+	for (pbe = pblist ; pbe ; pbe = pbe->next)
+
+#define PBES_PER_PAGE      (PAGE_SIZE/sizeof(struct pbe))
+#define PB_PAGE_SKIP       (PBES_PER_PAGE-1)
+
+#define for_each_pb_page(pbe, pblist) \
+	for (pbe = pblist ; pbe ; pbe = (pbe+PB_PAGE_SKIP)->next)
+
+
 #define SWAP_FILENAME_MAXLENGTH	32
 
 


-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
