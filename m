Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261352AbVA1Nyt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbVA1Nyt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 08:54:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbVA1Nyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 08:54:49 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:2720 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261352AbVA1NyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 08:54:15 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH] swsusp: do not use higher order memory allocations on suspend
Date: Fri, 28 Jan 2005 14:54:22 +0100
User-Agent: KMail/1.7.1
Cc: hugang@soulinfo.com, Pavel Machek <pavel@suse.cz>,
       Nigel Cunningham <ncunningham@linuxmail.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200501281454.23167.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patch is (yet) an(other) attempt to eliminate the need for using higher
order memory allocations on suspend.  It accomplishes this by replacing the array
of page backup entries with a list, so it is only necessary to allocate individual
memory pages.

I have noticed that the suspend code in swsusp is actually independent of the
resume code and vice versa, so it is not necessary to change them both at once.
Therefore I have decided, for now, to only modify the suspend part which is more
straightforward.  The resume code is almost unaffected by this patch (the only
thing changed in this code is a BUG_ON() that is removed).

The patch is against 2.6.11-rc2.  It has been tested and quite thoroughly debugged
on x86-64.  Still, if anyone could test it on another architecture, I'd be grateful.
Of course comments, suggestions etc. are welcome.

Greets,
RJW


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

diff -Nru linux-2.6.11-rc2-orig/include/linux/suspend.h linux-2.6.11-rc2/include/linux/suspend.h
--- linux-2.6.11-rc2-orig/include/linux/suspend.h	2005-01-28 14:23:42.000000000 +0100
+++ linux-2.6.11-rc2/include/linux/suspend.h	2005-01-28 13:53:36.000000000 +0100
@@ -16,11 +16,20 @@
 	unsigned long address;		/* address of the copy */
 	unsigned long orig_address;	/* original address of page */
 	swp_entry_t swap_address;	
-	swp_entry_t dummy;		/* we need scratch space at 
-					 * end of page (see link, diskpage)
-					 */
+
+	struct pbe *next;
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
 
 
diff -Nru linux-2.6.11-rc2-orig/kernel/power/swsusp.c linux-2.6.11-rc2/kernel/power/swsusp.c
--- linux-2.6.11-rc2-orig/kernel/power/swsusp.c	2005-01-28 14:23:42.000000000 +0100
+++ linux-2.6.11-rc2/kernel/power/swsusp.c	2005-01-28 14:40:44.000000000 +0100
@@ -76,7 +76,6 @@
 extern const void __nosave_begin, __nosave_end;
 
 /* Variables to be preserved over suspend */
-static int pagedir_order_check;
 static int nr_copy_pages_check;
 
 extern char resume_file[];
@@ -292,20 +291,25 @@
 static int data_write(void)
 {
 	int error = 0;
-	int i;
+	int i = 0;
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
+		error = write_page(p->address, &(p->swap_address));
+		if (error)
+			goto Exit;
+
+		i++;
 	}
 	printk("\b\b\b\bdone\n");
+Exit:
 	return error;
 }
 
@@ -334,7 +338,6 @@
 	swsusp_info.suspend_pagedir = pagedir_nosave;
 	swsusp_info.cpus = num_online_cpus();
 	swsusp_info.image_pages = nr_copy_pages;
-	dump_info();
 }
 
 static int close_swap(void)
@@ -342,6 +345,7 @@
 	swp_entry_t entry;
 	int error;
 
+	dump_info();
 	error = write_page((unsigned long)&swsusp_info,&entry);
 	if (!error) { 
 		printk( "S" );
@@ -373,15 +377,22 @@
 
 static int write_pagedir(void)
 {
-	unsigned long addr = (unsigned long)pagedir_nosave;
 	int error = 0;
-	int n = SUSPEND_PD_PAGES(nr_copy_pages);
-	int i;
+	unsigned n = 0;
+	struct pbe * pbe;
+
+	printk( "Writing pagedir ...");
+
+	for_each_pb_page(pbe, pagedir_nosave) {
+		error = write_page((unsigned long)pbe, &swsusp_info.pagedir[n++]);
+		if (error)
+			goto Finish;
+	}
 
 	swsusp_info.pagedir_pages = n;
-	printk( "Writing pagedir (%d pages)\n", n);
-	for (i = 0; i < n && !error; i++, addr += PAGE_SIZE)
-		error = write_page(addr, &swsusp_info.pagedir[i]);
+
+	pr_debug("\b\b\bdone (%u pages)\n", n);
+Finish:
 	return error;
 }
 
@@ -536,7 +547,7 @@
 	if (PageNosave(page))
 		return 0;
 	if (PageReserved(page) && pfn_is_nosave(pfn)) {
-		pr_debug("[nosave pfn 0x%lx]", pfn);
+		pr_debug("[nosave pfn 0x%lx]\n", pfn);
 		return 0;
 	}
 	if (PageNosaveFree(page))
@@ -567,8 +578,8 @@
 	struct zone *zone;
 	unsigned long zone_pfn;
 	struct pbe * pbe = pagedir_nosave;
-	int to_copy = nr_copy_pages;
 	
+	pr_debug("copy_data_pages(): pages to copy: %d\n", nr_copy_pages);
 	for_each_zone(zone) {
 		if (is_highmem(zone))
 			continue;
@@ -577,78 +588,96 @@
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
+	int mod = (nr_copy % PBES_PER_PAGE) ? 1 : 0;
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
+		mod = (nr_copy % PBES_PER_PAGE) ? 1 : 0;
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
+	for (pbe = pblist, num = PBES_PER_PAGE ; pbe && num < nr_pages ;
+        		pbe = pbe->next, num += PBES_PER_PAGE) {
+		p = pbe;
+		pbe += PB_PAGE_SKIP;
+		do
+			p->next = p + 1;
+		while (p++ < pbe);
+		pbe->next = (struct pbe *)get_zeroed_page(GFP_ATOMIC | __GFP_COLD);
+	}
+	for (num -= PBES_PER_PAGE - 1, p = pbe ; num < nr_pages ; p++, num++)
+		p->next = p + 1;
+	if (!pbe) { /* get_zeroed_page() failed */
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
+		free_page((unsigned long)pbe);
+	}
+	pr_debug("free_pagedir(): done\n");
 }
 
 /**
@@ -658,10 +687,8 @@
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
@@ -672,15 +699,13 @@
 
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
@@ -694,7 +719,7 @@
 	BUG_ON(PageNosave(virt_to_page(pagedir_save)));
 	BUG_ON(PageNosaveFree(virt_to_page(pagedir_save)));
 	free_image_pages();
-	free_pages((unsigned long) pagedir_save, pagedir_order);
+	free_pagedir(pagedir_save);
 }
 
 
@@ -752,10 +777,15 @@
 	if (!enough_swap())
 		return -ENOSPC;
 
-	if ((error = alloc_pagedir())) {
+	nr_copy_pages = calc_nr(nr_copy_pages);
+
+	pr_debug("suspend: (pages to copy: %d)\n", nr_copy_pages);
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
@@ -763,7 +793,6 @@
 	}
 
 	nr_copy_pages_check = nr_copy_pages;
-	pagedir_order_check = pagedir_order;
 	return 0;
 }
 
@@ -867,7 +896,6 @@
 asmlinkage int swsusp_restore(void)
 {
 	BUG_ON (nr_copy_pages_check != nr_copy_pages);
-	BUG_ON (pagedir_order_check != pagedir_order);
 	
 	/* Even mappings of "global" things (vmalloc) need to be fixed */
 	__flush_tlb_global();
@@ -901,7 +929,7 @@
 static int __init does_collide_order(unsigned long addr, int order)
 {
 	int i;
-	
+
 	for (i=0; i < (1<<order); i++)
 		if (!PageNosaveFree(virt_to_page(addr + i * PAGE_SIZE)))
 			return 1;
@@ -1193,6 +1221,7 @@
 	}
 	if (error)
 		free_pages((unsigned long)pagedir_nosave, pagedir_order);
+
 	return error;
 }
 

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
