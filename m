Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263214AbTDGDJv (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 23:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263215AbTDGDJv (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 23:09:51 -0400
Received: from smtp1.clear.net.nz ([203.97.33.27]:62427 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP id S263214AbTDGDJc (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 23:09:32 -0400
Date: Mon, 07 Apr 2003 15:17:56 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: PATCH: 2.5.66 incremental (#4: Discontiguous patches & Dynamic
	PageFlag Bitmap)
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1049685473.13733.4.camel@laptop-linux.cunninghams>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

This is pretty much the same as the original discontiguous pagedirs
patch that you've already seen, except that instead of using real
pageflags, bitmaps are made on the fly and discarded (as previously
discussed). I've left the NoSave flag as a real pageflag so that drivers
etc can mark pages Nosave if need be (is this a real possibility?).

Regards,

Nigel

diff -ruN linux-2.5.66-inc03/arch/i386/kernel/swsusp.c linux-2.5.66-inc04/arch/i386/kernel/swsusp.c
--- linux-2.5.66-inc03/arch/i386/kernel/swsusp.c	2003-04-05 21:33:38.000000000 +1200
+++ linux-2.5.66-inc04/arch/i386/kernel/swsusp.c	2003-04-06 15:52:53.000000000 +1200
@@ -210,7 +210,7 @@
 /* Local variables for do_magic */
 static int loop __nosavedata = 0;
 static int loop2 __nosavedata = 0;
-extern suspend_pagedir_t *pagedir_nosave __nosavedata;
+extern suspend_pagedir_t **pagedir_nosave __nosavedata;
 
 /*
  * FIXME: This function should really be written in assembly. Actually
@@ -256,8 +256,8 @@
 	for (loop=0; loop < nr_copy_pages; loop++) {
 		/* You may not call something (like copy_page) here: see above */
 		for (loop2=0; loop2 < (PAGE_SIZE / sizeof(unsigned long)); loop2++) {
-			*(((unsigned long *)((pagedir_nosave+loop)->orig_address))+loop2) =
-				*(((unsigned long *)((pagedir_nosave+loop)->address))+loop2);
+			*(((unsigned long *)(PAGEDIR_ENTRY(pagedir_nosave, loop)->orig_address))+loop2) =
+				*(((unsigned long *)(PAGEDIR_ENTRY(pagedir_nosave, loop)->address))+loop2);
 			__flush_tlb();
 		}
 		
diff -ruN linux-2.5.66-inc03/include/linux/suspend.h linux-2.5.66-inc04/include/linux/suspend.h
--- linux-2.5.66-inc03/include/linux/suspend.h	2003-04-05 20:55:20.000000000 +1200
+++ linux-2.5.66-inc04/include/linux/suspend.h	2003-04-06 15:47:18.000000000 +1200
@@ -34,7 +34,7 @@
 	char version[20];
 	int num_cpus;
 	int page_size;
-	suspend_pagedir_t *suspend_pagedir;
+	suspend_pagedir_t **suspend_pagedir;
 	unsigned int num_pbes;
 	struct swap_location {
 		char filename[SWAP_FILENAME_MAXLENGTH];
@@ -42,6 +42,8 @@
 };
 
 #define SUSPEND_PD_PAGES(x)     (((x)*sizeof(struct pbe))/PAGE_SIZE+1)
+#define PAGEDIR_CAPACITY(x)     (((x)*PAGE_SIZE/sizeof(struct pbe)))
+#define PAGEDIR_ENTRY(pagedir, i) (pagedir[i/PAGEDIR_CAPACITY(1)] + (i%PAGEDIR_CAPACITY(1)))
    
 /* mm/vmscan.c */
 extern int shrink_mem(void);
@@ -61,7 +63,7 @@
 extern void thaw_processes(void);
 
 extern unsigned int nr_copy_pages __nosavedata;
-extern suspend_pagedir_t *pagedir_nosave __nosavedata;
+extern suspend_pagedir_t **pagedir_nosave __nosavedata;
 
 /* Communication between kernel/suspend.c and arch/i386/suspend.c */
 
diff -ruN linux-2.5.66-inc03/kernel/suspend.c linux-2.5.66-inc04/kernel/suspend.c
--- linux-2.5.66-inc03/kernel/suspend.c	2003-04-05 21:25:18.000000000 +1200
+++ linux-2.5.66-inc04/kernel/suspend.c	2003-04-07 15:08:21.000000000 +1200
@@ -96,7 +96,6 @@
 static int new_loglevel = 7;
 static int orig_loglevel = 0;
 static int orig_fgconsole, orig_kmsg;
-static int pagedir_order_check;
 static int nr_copy_pages_check;
 
 static int resume_status = 0;
@@ -116,9 +115,9 @@
    allocated at time of resume, that travels through memory not to
    collide with anything.
  */
-suspend_pagedir_t *pagedir_nosave __nosavedata = NULL;
-static suspend_pagedir_t *pagedir_save;
-static int pagedir_order __nosavedata = 0;
+suspend_pagedir_t **pagedir_nosave __nosavedata = NULL;
+static suspend_pagedir_t **pagedir_save = NULL;
+static int pagedir_size __nosavedata = 0;
 
 struct link {
 	char dummy[PAGE_SIZE - sizeof(swp_entry_t)];
@@ -160,6 +159,68 @@
 #define MDELAY(a)
 #endif
 
+#define BITS_PER_PAGE (PAGE_SIZE * 8)
+#define PAGES_PER_BITMAP ((max_mapnr + BITS_PER_PAGE - 1) / BITS_PER_PAGE)
+#define BITMAP_ORDER (get_bitmask_order(PAGES_PER_BITMAP))
+
+static unsigned long * inusemap = NULL;
+//Not yet used. Here so you can see this needs to be generic
+//static unsigned long * pageset2map = NULL;
+
+static void clear_map(unsigned long * pagemap)
+{
+	int i;
+	for(i=0; i < (max_mapnr / (8 * sizeof(unsigned long))); i++) {
+		pagemap[i]=0;
+	}
+}
+
+static int allocatemap(unsigned long ** pagemap)
+{
+	void * check;
+	if (*pagemap) {
+		printk("Error. Pagemap already allocated.\n");
+	} else {
+		check = (void *) __get_free_pages(__GFP_FAST, BITMAP_ORDER);
+		if (!check) {
+			return 1;
+		}
+		*pagemap = (unsigned long *) check;
+	}
+	clear_map(*pagemap);
+	return 0;
+}
+/* Not yet used
+static int freemap(unsigned long ** pagemap)
+{
+	if (!*pagemap) {
+		printk("Error. Pagemap not allocated.\n");
+		return 1;
+	} else {
+		free_pages((unsigned long) *pagemap, BITMAP_ORDER);
+		*pagemap = NULL;
+		return 0;
+	}
+}
+*/
+#define PAGENUMBER(page) (page-mem_map)
+#define PAGEINDEX(page) ((PAGENUMBER(page))/(8*sizeof(unsigned long)))
+#define PAGEBIT(page) ((int) ((PAGENUMBER(page))%(8 * sizeof(unsigned long))))
+
+/* 
+ * freepagesmap is used in two ways: 
+ * - During suspend, to tag pages which are not used (to speed up count_data_pages);
+ * - During resume, to tag pages which are is pagedir1. This does not tag pagedir2
+ *   pages, so !== first use.
+ */
+#define PageInUse(page)		test_bit(PAGEBIT(page), &inusemap[PAGEINDEX(page)])
+#define SetPageInUse(page)	set_bit(PAGEBIT(page), &inusemap[PAGEINDEX(page)])
+#define ClearPageInUse(page)	clear_bit(PAGEBIT(page), &inusemap[PAGEINDEX(page)])
+
+#define PagePageset2(page)	test_bit(PAGEBIT(page), &pageset2map[PAGEINDEX(page)])
+#define SetPagePageset2(page)	set_bit(PAGEBIT(page), &pageset2map[PAGEINDEX(page)])
+#define ClearPagePageset2(page)	clear_bit(PAGEBIT(page), &pageset2map[PAGEINDEX(page)])
+
 /*
  * Refrigerator and related stuff
  */
@@ -395,7 +456,7 @@
 {
 	int i;
 	swp_entry_t entry, prev = { 0 };
-	int nr_pgdir_pages = SUSPEND_PD_PAGES(nr_copy_pages);
+	int pagedir_size = SUSPEND_PD_PAGES(nr_copy_pages);
 	union diskpage *cur,  *buffer = (union diskpage *)get_zeroed_page(GFP_ATOMIC);
 	unsigned long address;
 	struct page *page;
@@ -410,16 +471,15 @@
 		if (swapfile_used[swp_type(entry)] != SWAPFILE_SUSPEND)
 			panic("\nPage %d: not enough swapspace on suspend device", i );
 	    
-		address = (pagedir_nosave+i)->address;
+		address = PAGEDIR_ENTRY(pagedir_nosave,i)->address;
 		page = virt_to_page(address);
 		rw_swap_page_sync(WRITE, entry, page);
-		(pagedir_nosave+i)->swap_address = entry;
+		PAGEDIR_ENTRY(pagedir_nosave,i)->swap_address = entry;
 	}
 	printk( "|\n" );
-	printk( "Writing pagedir (%d pages): ", nr_pgdir_pages);
-	for (i=0; i<nr_pgdir_pages; i++) {
-		cur = (union diskpage *)((char *) pagedir_nosave)+i;
-		BUG_ON ((char *) cur != (((char *) pagedir_nosave) + i*PAGE_SIZE));
+	printk( "Writing pagedir (%d pages): ", pagedir_size);
+	for (i=0; i<pagedir_size; i++) {
+		cur = (union diskpage *) pagedir_nosave[i];
 		printk( "." );
 		if (!(entry = get_swap_page()).val) {
 			printk(KERN_CRIT "Not enough swapspace when writing pgdir\n" );
@@ -467,7 +527,7 @@
 }
 
 /* if pagedir_p != NULL it also copies the counted pages */
-static int count_and_copy_data_pages(struct pbe *pagedir_p)
+static int count_and_copy_data_pages(struct pbe **pagedir_p)
 {
 	int chunk_size;
 	int nr_copy_pages = 0;
@@ -507,65 +567,88 @@
 			   critical bios data? */
 		} else	BUG();
 
-		nr_copy_pages++;
 		if (pagedir_p) {
-			pagedir_p->orig_address = ADDRESS(pfn);
-			copy_page((void *) pagedir_p->address, (void *) pagedir_p->orig_address);
-			pagedir_p++;
+			PAGEDIR_ENTRY(pagedir_p, nr_copy_pages)->orig_address = ADDRESS(pfn);
+			copy_page((void *) PAGEDIR_ENTRY(pagedir_p, nr_copy_pages)->address, (void *) PAGEDIR_ENTRY(pagedir_p, nr_copy_pages)->orig_address);
 		}
+		nr_copy_pages++;
 	}
 	return nr_copy_pages;
 }
 
-static void free_suspend_pagedir(unsigned long this_pagedir)
+static void free_suspend_pagedir(struct pbe ** this_pagedir)
 {
-	struct page *page;
-	int pfn;
-	unsigned long this_pagedir_end = this_pagedir +
-		(PAGE_SIZE << pagedir_order);
+	int i;
+	int rangestart = -1, rangeend = -1;
 
-	for(pfn = 0; pfn < num_physpages; pfn++) {
-		page = pfn_to_page(pfn);
-		if (!TestClearPageNosave(page))
-			continue;
+	if (pagedir_size == 0)
+		return;
 
-		if (ADDRESS(pfn) >= this_pagedir && ADDRESS(pfn) < this_pagedir_end)
-			continue; /* old pagedir gets freed in one */
-		
-		free_page(ADDRESS(pfn));
+	for(i = 0; i < nr_copy_pages; i++) {
+		if (PAGEDIR_ENTRY(this_pagedir,i)->address) {
+			if (rangestart > -1) {
+				printk("Pagedir entry %d-%d address2 not set!\n", rangestart, rangeend);
+				rangestart = -1;
+			}
+			ClearPageNosave(virt_to_page(PAGEDIR_ENTRY(this_pagedir,i)->address));
+			free_page(PAGEDIR_ENTRY(this_pagedir,i)->address);
+		} else {
+			if (rangestart == -1)
+				rangestart = i;
+			rangeend = i;
+		}
 	}
-	free_pages(this_pagedir, pagedir_order);
+		
+	if (rangestart > -1)
+		printk("Pagedir entry %d-%d address not set!\n", rangestart, nr_copy_pages - 1);
+
+	for(i = 0; i < pagedir_size; i++)
+		free_page((unsigned long) this_pagedir[i]);
+
+	free_page((unsigned long) this_pagedir);
+	this_pagedir = NULL;
+	nr_copy_pages = 0;
+	pagedir_size = 0;
 }
 
-static suspend_pagedir_t *create_suspend_pagedir(int nr_copy_pages)
+static suspend_pagedir_t **create_suspend_pagedir(int nr_copy_pages)
 {
+	suspend_pagedir_t **pagedir;
+	struct pbe **p;
 	int i;
-	suspend_pagedir_t *pagedir;
-	struct pbe *p;
-	struct page *page;
 
-	pagedir_order = get_bitmask_order(SUSPEND_PD_PAGES(nr_copy_pages));
+	pagedir_size = SUSPEND_PD_PAGES(nr_copy_pages);
 
-	p = pagedir = (suspend_pagedir_t *)__get_free_pages(GFP_ATOMIC | __GFP_COLD, pagedir_order);
-	if(!pagedir)
+	p = pagedir = (suspend_pagedir_t **)__get_free_pages(GFP_ATOMIC | __GFP_COLD, 0);
+	if(!p)
 		return NULL;
 
-	page = virt_to_page(pagedir);
-	for(i=0; i < 1<<pagedir_order; i++)
-		SetPageNosave(page++);
-		
+	/* We aren't setting the pagedir itself Nosave because we have to be able
+	 * to free it during resume, after restoring the image. This means nr_copy_pages
+	 * needs to be adjusted */
+	
+	for (i = 0; i < pagedir_size; i++) {
+		p[i] = (suspend_pagedir_t *)__get_free_pages(GFP_ATOMIC, 0);
+		if (!p[i]) {
+			int j;
+			for (j = 0; j < i; j++) {
+				free_page((unsigned long) p[j]);
+			}
+			free_page((unsigned long) p);
+			return NULL;
+		}
+	}
+
 	while(nr_copy_pages--) {
-		p->address = get_zeroed_page(GFP_ATOMIC | __GFP_COLD);
-		if(!p->address) {
-			free_suspend_pagedir((unsigned long) pagedir);
+		PAGEDIR_ENTRY(p, nr_copy_pages)->address = get_zeroed_page(GFP_ATOMIC | __GFP_COLD);
+		if(!PAGEDIR_ENTRY(p, nr_copy_pages)->address) {
+			free_suspend_pagedir(p);
 			return NULL;
 		}
-		printk(".");
-		SetPageNosave(virt_to_page(p->address));
-		p->orig_address = 0;
-		p++;
+		SetPageNosave(virt_to_page(PAGEDIR_ENTRY(p, nr_copy_pages)->address));
+		PAGEDIR_ENTRY(p, nr_copy_pages)->orig_address = 0;
 	}
-	return pagedir;
+	return p;
 }
 
 static int prepare_suspend_console(void)
@@ -684,6 +767,7 @@
 	pagedir_nosave = NULL;
 	printk( "/critical section: Counting pages to copy" );
 	nr_copy_pages = count_and_copy_data_pages(NULL);
+	nr_copy_pages += 1 + SUSPEND_PD_PAGES(nr_copy_pages);
 	nr_needed_pages = nr_copy_pages + PAGES_FOR_IO;
 	
 	printk(" (pages needed: %d+%d=%d free: %d)\n",nr_copy_pages,PAGES_FOR_IO,nr_needed_pages,nr_free_pages());
@@ -713,7 +797,6 @@
 		return 1;
 	}
 	nr_copy_pages_check = nr_copy_pages;
-	pagedir_order_check = pagedir_order;
 
 	drain_local_pages();	/* During allocating of suspend pagedir, new cold pages may appear. Kill them */
 	if (nr_copy_pages != count_and_copy_data_pages(pagedir_nosave))	/* copy */
@@ -789,12 +872,11 @@
 void do_magic_resume_2(void)
 {
 	BUG_ON (nr_copy_pages_check != nr_copy_pages);
-	BUG_ON (pagedir_order_check != pagedir_order);
 
 	__flush_tlb_global();		/* Even mappings of "global" things (vmalloc) need to be fixed */
 
 	PRINTK( "Freeing prev allocated pagedir\n" );
-	free_suspend_pagedir((unsigned long) pagedir_save);
+	free_suspend_pagedir(pagedir_save);
 	spin_unlock_irq(&suspend_pagedir_lock);
 	drivers_resume(RESUME_ALL_PHASES);
 
@@ -831,7 +913,7 @@
 	spin_lock_irq(&suspend_pagedir_lock);	/* Done to disable interrupts */ 
 	mdelay(1000);
 
-	free_pages((unsigned long) pagedir_nosave, pagedir_order);
+	free_suspend_pagedir(pagedir_nosave);
 	spin_unlock_irq(&suspend_pagedir_lock);
 	mark_swapfiles(((swp_entry_t) {0}), MARK_SWAP_RESUME);
 	PRINTK(KERN_WARNING "%sLeaving do_magic_suspend_2...\n", name_suspend);	
@@ -894,37 +976,29 @@
 
 /* More restore stuff */
 
-/* FIXME: Why not memcpy(to, from, 1<<pagedir_order*PAGE_SIZE)? */
-static void copy_pagedir(suspend_pagedir_t *to, suspend_pagedir_t *from)
-{
-	int i;
-	char *topointer=(char *)to, *frompointer=(char *)from;
-
-	for(i=0; i < 1 << pagedir_order; i++) {
-		copy_page(topointer, frompointer);
-		topointer += PAGE_SIZE;
-		frompointer += PAGE_SIZE;
-	}
-}
-
-#define does_collide(addr) does_collide_order(pagedir_nosave, addr, 0)
-
-/*
- * Returns true if given address/order collides with any orig_address 
- */
-static int does_collide_order(suspend_pagedir_t *pagedir, unsigned long addr,
-		int order)
-{
+static int warmup_collision_cache(suspend_pagedir_t **pagedir) {
 	int i;
-	unsigned long addre = addr + (PAGE_SIZE<<order);
 	
-	for(i=0; i < nr_copy_pages; i++)
-		if((pagedir+i)->orig_address >= addr &&
-			(pagedir+i)->orig_address < addre)
-			return 1;
+	if (!(allocatemap(&inusemap)))
+			return 1;	/* Doesn't get deallocated because forgotten
+					   when we copy PageDir1 back. Doesn't matter
+					   if collides because not used during copy back.
+					 */
+	PRINTK("Setting up pagedir cache");
+	for (i = 0; i < max_pfn; i++)
+		ClearPageInUse(pfn_to_page(i));
 
+	for(i=0; i < nr_copy_pages; i++) {
+		SetPageInUse(virt_to_page(PAGEDIR_ENTRY(pagedir, i)->orig_address));
+		if (!(i%800)) {
+			PRINTK(".");
+		}
+	}
+	PRINTK("%d", i);
+	PRINTK("|\n");
 	return 0;
 }
+#define does_collide(address) (PageInUse(virt_to_page(address)))
 
 /*
  * We check here that pagedir & pages it points to won't collide with pages
@@ -932,64 +1006,106 @@
  */
 static int check_pagedir(void)
 {
-	int i;
+	int i, nrdone = 0;
+	void **eaten_memory = NULL;
+	void **c = eaten_memory, *f, *addr;
 
 	for(i=0; i < nr_copy_pages; i++) {
-		unsigned long addr;
-
-		do {
-			addr = get_zeroed_page(GFP_ATOMIC);
-			if(!addr)
-				return -ENOMEM;
-		} while (does_collide(addr));
-
-		(pagedir_nosave+i)->address = addr;
+		while ((addr = (void *) get_zeroed_page(GFP_ATOMIC))) {
+			memset(addr, 0, PAGE_SIZE);
+			if (!does_collide((unsigned long) addr)) {
+				break;
+			}
+			eaten_memory = addr;
+			*eaten_memory = c;
+			c = eaten_memory;
+		}
+		PAGEDIR_ENTRY(pagedir_nosave,i)->address = (unsigned long) addr;
+		nrdone++;
 	}
+	
+	// Free unwanted memory
+	c = eaten_memory;
+	while(c) {
+		f = c;
+		c = *c;
+		if (f)
+			free_page((unsigned long) f);
+  	}
+	eaten_memory = NULL;
+	
 	return 0;
 }
 
 static int relocate_pagedir(void)
 {
+	void **eaten_memory = NULL;
+	void **c = eaten_memory, *m = NULL, *f;
+	int oom = 0, i, numeaten = 0;
+	int pagedir_size = SUSPEND_PD_PAGES(nr_copy_pages);
+
 	/*
 	 * We have to avoid recursion (not to overflow kernel stack),
 	 * and that's why code looks pretty cryptic 
 	 */
-	suspend_pagedir_t *new_pagedir, *old_pagedir = pagedir_nosave;
-	void **eaten_memory = NULL;
-	void **c = eaten_memory, *m, *f;
-
-	printk("Relocating pagedir");
-
-	if(!does_collide_order(old_pagedir, (unsigned long)old_pagedir, pagedir_order)) {
-		printk("not necessary\n");
-		return 0;
-	}
 
-	while ((m = (void *) __get_free_pages(GFP_ATOMIC, pagedir_order))) {
-		memset(m, 0, PAGE_SIZE);
-		if (!does_collide_order(old_pagedir, (unsigned long)m, pagedir_order))
-			break;
-		eaten_memory = m;
-		printk( "." ); 
-		*eaten_memory = c;
-		c = eaten_memory;
+	PRINTK("Relocating conflicting parts of pagedir.\n");
+  
+	for (i = -1; i < pagedir_size; i++) {
+		int this_collides = 0;
+  
+		if (i == -1)
+			this_collides = does_collide((unsigned long) pagedir_nosave);
+		else
+			this_collides = does_collide((unsigned long) pagedir_nosave[i]);
+		
+		if (this_collides) {
+			while ((m = (void *) __get_free_pages(GFP_ATOMIC, 0))) {
+				memset(m, 0, PAGE_SIZE);
+				if (!does_collide((unsigned long)m)) {
+					if (i == -1) {
+						copy_page(m, pagedir_nosave);
+						free_page((unsigned long) pagedir_nosave);
+						pagedir_nosave = m;
+					}
+					else {
+						copy_page(m, (void *) pagedir_nosave[i]);
+						free_page((unsigned long) pagedir_nosave[i]);
+						pagedir_nosave[i] = m;
+					}
+					break;
+				}
+				numeaten++;
+				eaten_memory = m;
+				PRINTK("Eaten: %d. Still to try:%d\r", numeaten, nr_free_pages()); 
+				*eaten_memory = c;
+				c = eaten_memory;
+			}
+			if (!m) {
+				printk("\nRan out of memory trying to relocate pagedir (tried %d pages).\n", numeaten);
+				oom = 1;
+				break;
+			}
+		}
+  
 	}
-
-	if (!m)
+		
+	PRINTK("\nFreeing rejected memory locations...");
+  	c = eaten_memory;
+  	while(c) {
+		f = c;
+  		c = *c;
+  		if (f)
+			free_pages((unsigned long) f, 0);
+  	}
+	eaten_memory = NULL;
+	
+	PRINTK("\n");
+	
+	if (oom) 
 		return -ENOMEM;
-
-	pagedir_nosave = new_pagedir = m;
-	copy_pagedir(new_pagedir, old_pagedir);
-
-	c = eaten_memory;
-	while(c) {
-		printk(":");
-		f = *c;
-		c = *c;
-		if (f)
-			free_pages((unsigned long)f, pagedir_order);
-	}
-	printk("|\n");
+	else
+		return 0;
 	return 0;
 }
 
@@ -1062,7 +1178,7 @@
 static int __read_suspend_image(struct block_device *bdev, union diskpage *cur, int noresume)
 {
 	swp_entry_t next;
-	int i, nr_pgdir_pages;
+	int i, pagedir_size;
 
 #define PREPARENEXT \
 	{	next = cur->link.next; \
@@ -1110,24 +1226,39 @@
 
 	pagedir_save = cur->sh.suspend_pagedir;
 	nr_copy_pages = cur->sh.num_pbes;
-	nr_pgdir_pages = SUSPEND_PD_PAGES(nr_copy_pages);
-	pagedir_order = get_bitmask_order(nr_pgdir_pages);
+	pagedir_size = SUSPEND_PD_PAGES(nr_copy_pages);
 
-	pagedir_nosave = (suspend_pagedir_t *)__get_free_pages(GFP_ATOMIC, pagedir_order);
+	pagedir_nosave = (suspend_pagedir_t **)__get_free_pages(GFP_ATOMIC, 0);
 	if (!pagedir_nosave)
 		return -ENOMEM;
 
+	{
+		int i;
+		for (i = 0; i < pagedir_size; i++) {
+			pagedir_nosave[i] = (suspend_pagedir_t *)__get_free_pages(GFP_ATOMIC, 0);
+			if (!pagedir_nosave[i]) {
+				int j;
+				for (j = 0; j < i; j++)
+					free_page((unsigned long) pagedir_nosave[j]);
+				free_page((unsigned long) pagedir_nosave);
+				spin_unlock_irq(&suspend_pagedir_lock);
+				return -ENOMEM;
+			}
+		}
+	}
 	PRINTK( "%sReading pagedir, ", name_resume );
 
 	/* We get pages in reverse order of saving! */
-	for (i=nr_pgdir_pages-1; i>=0; i--) {
+	for (i=pagedir_size-1; i>=0; i--) {
 		BUG_ON (!next.val);
-		cur = (union diskpage *)((char *) pagedir_nosave)+i;
+		cur = (union diskpage *) pagedir_nosave[i];
 		if (bdev_read_page(bdev, next.val, cur)) return -EIO;
 		PREPARENEXT;
 	}
 	BUG_ON (next.val);
 
+ 	warmup_collision_cache(pagedir_nosave);
+ 
 	if (relocate_pagedir())
 		return -ENOMEM;
 	if (check_pagedir())
@@ -1135,12 +1266,12 @@
 
 	printk( "Reading image data (%d pages): ", nr_copy_pages );
 	for(i=0; i < nr_copy_pages; i++) {
-		swp_entry_t swap_address = (pagedir_nosave+i)->swap_address;
+		swp_entry_t swap_address = PAGEDIR_ENTRY(pagedir_nosave,i)->swap_address;
 		if (!(i%100))
 			printk( "." );
 		/* You do not need to check for overlaps...
 		   ... check_pagedir already did this work */
-		if (bdev_read_page(bdev, swp_offset(swap_address) * PAGE_SIZE, (char *)((pagedir_nosave+i)->address)))
+		if (bdev_read_page(bdev, swp_offset(swap_address) * PAGE_SIZE, (char *)(PAGEDIR_ENTRY(pagedir_nosave,i)->address)))
 			return -EIO;
 	}
 	printk( "|\n" );



