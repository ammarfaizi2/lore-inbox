Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263003AbUG1Thz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263003AbUG1Thz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 15:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263019AbUG1Thz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 15:37:55 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:51597 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S263003AbUG1Thf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 15:37:35 -0400
Subject: [PATCH] reduce swsusp casting
From: Dave Hansen <haveblue@us.ibm.com>
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: Pavel Machek <pavel@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-tgwliorF58MZw+D1WPTT"
Message-Id: <1091043436.2871.320.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 28 Jul 2004 12:37:17 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-tgwliorF58MZw+D1WPTT
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I noticed that swsusp uses quite a few interesting casts for __pa() and
cousins.  This patch moves some types around to eliminate some of those
casts in the normal code.  The casts that it adds are around alloc's and
frees, which is a much more usual place to see them.  

Pavel also noticed that there's a superfluous PAGE_ALIGN() right before
a >>PAGE_SHIFT in pfn_is_nosave(), so that's been removed as well.

I haven't had a chance to do anything but test it, because that would
involve me setting up a swsusp rig, which I'm more prone to screw up
than the patch itself :)  I'd appreciate if anyone with a stable setup
could make sure I didn't do anything too stupid.  

-- Dave

--=-tgwliorF58MZw+D1WPTT
Content-Disposition: attachment; filename=swsusp-types-2.6.8-rc1-mm1-1.patch
Content-Type: text/x-patch; name=swsusp-types-2.6.8-rc1-mm1-1.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

--- ./linux-2.6.8-rc1-mm1-typefix/kernel/power/swsusp.c.orig	2004-07-27 15:46:20.000000000 -0700
+++ ./linux-2.6.8-rc1-mm1-typefix/kernel/power/swsusp.c	2004-07-28 12:18:48.000000000 -0700
@@ -307,7 +307,6 @@ static int write_suspend_image(void)
 	swp_entry_t entry, prev = { 0 };
 	int nr_pgdir_pages = SUSPEND_PD_PAGES(nr_copy_pages);
 	union diskpage *cur,  *buffer = (union diskpage *)get_zeroed_page(GFP_ATOMIC);
-	unsigned long address;
 	struct page *page;
 
 	if (!buffer)
@@ -324,8 +323,7 @@ static int write_suspend_image(void)
 		if (swapfile_used[swp_type(entry)] != SWAPFILE_SUSPEND)
 			panic("\nPage %d: not enough swapspace on suspend device", i );
 	    
-		address = (pagedir_nosave+i)->address;
-		page = virt_to_page(address);
+		page = virt_to_page((pagedir_nosave+i)->address);
 		rw_swap_page_sync(WRITE, entry, page);
 		(pagedir_nosave+i)->swap_address = entry;
 	}
@@ -350,7 +348,7 @@ static int write_suspend_image(void)
 		BUG_ON (PAGE_SIZE % sizeof(struct pbe));
 
 		cur->link.next = prev;				
-		page = virt_to_page((unsigned long)cur);
+		page = virt_to_page(cur);
 		rw_swap_page_sync(WRITE, entry, page);
 		prev = entry;
 	}
@@ -370,7 +368,7 @@ static int write_suspend_image(void)
 		
 	cur->link.next = prev;
 
-	page = virt_to_page((unsigned long)cur);
+	page = virt_to_page(cur);
 	rw_swap_page_sync(WRITE, entry, page);
 	prev = entry;
 
@@ -471,8 +469,8 @@ static int restore_highmem(void)
 
 static int pfn_is_nosave(unsigned long pfn)
 {
-	unsigned long nosave_begin_pfn = __pa(&__nosave_begin) >> PAGE_SHIFT;
-	unsigned long nosave_end_pfn = PAGE_ALIGN(__pa(&__nosave_end)) >> PAGE_SHIFT;
+	unsigned long nosave_begin_pfn = virt_to_phys(&__nosave_begin) >> PAGE_SHIFT;
+	unsigned long nosave_end_pfn = virt_to_phys(&__nosave_end) >> PAGE_SHIFT;
 	return (pfn >= nosave_begin_pfn) && (pfn < nosave_end_pfn);
 }
 
@@ -527,12 +525,13 @@ static int count_and_copy_data_pages(str
 	return nr_copy_pages;
 }
 
-static void free_suspend_pagedir_zone(struct zone *zone, unsigned long pagedir)
+static void free_suspend_pagedir_zone(struct zone *zone, suspend_pagedir_t *pagedir)
 {
-	unsigned long zone_pfn, pagedir_end, pagedir_pfn, pagedir_end_pfn;
-	pagedir_end = pagedir + (PAGE_SIZE << pagedir_order);
-	pagedir_pfn = __pa(pagedir) >> PAGE_SHIFT;
-	pagedir_end_pfn = __pa(pagedir_end) >> PAGE_SHIFT;
+	unsigned long zone_pfn, pagedir_pfn, pagedir_end, pagedir_end_pfn;
+	unsigned long pagedir_paddr = virt_to_phys(pagedir);
+	pagedir_end = pagedir_paddr + (PAGE_SIZE << pagedir_order);
+	pagedir_pfn = pagedir_paddr >> PAGE_SHIFT;
+	pagedir_end_pfn = pagedir_end >> PAGE_SHIFT;
 	for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn) {
 		struct page *page;
 		unsigned long pfn = zone_pfn + zone->zone_start_pfn;
@@ -547,14 +546,14 @@ static void free_suspend_pagedir_zone(st
 	}
 }
 
-static void free_suspend_pagedir(unsigned long this_pagedir)
+static void free_suspend_pagedir(suspend_pagedir_t *this_pagedir)
 {
 	struct zone *zone;
 	for_each_zone(zone) {
 		if (!is_highmem(zone))
 			free_suspend_pagedir_zone(zone, this_pagedir);
 	}
-	free_pages(this_pagedir, pagedir_order);
+	free_pages((unsigned long)this_pagedir, pagedir_order);
 }
 
 static suspend_pagedir_t *create_suspend_pagedir(int nr_copy_pages)
@@ -575,9 +574,9 @@ static suspend_pagedir_t *create_suspend
 		SetPageNosave(page++);
 		
 	while(nr_copy_pages--) {
-		p->address = get_zeroed_page(GFP_ATOMIC | __GFP_COLD);
+		p->address = (unsigned char *)get_zeroed_page(GFP_ATOMIC | __GFP_COLD);
 		if (!p->address) {
-			free_suspend_pagedir((unsigned long) pagedir);
+			free_suspend_pagedir(pagedir);
 			return NULL;
 		}
 		SetPageNosave(virt_to_page(p->address));
@@ -735,7 +734,7 @@ asmlinkage void do_magic_resume_2(void)
 	__flush_tlb_global();		/* Even mappings of "global" things (vmalloc) need to be fixed */
 
 	PRINTK( "Freeing prev allocated pagedir\n" );
-	free_suspend_pagedir((unsigned long) pagedir_save);
+	free_suspend_pagedir(pagedir_save);
 
 #ifdef CONFIG_HIGHMEM
 	printk( "Restoring highmem\n" );
@@ -874,10 +873,11 @@ int software_suspend(void)
 /*
  * Returns true if given address/order collides with any orig_address 
  */
-static int does_collide_order(suspend_pagedir_t *pagedir, unsigned long addr,
+static int does_collide_order(suspend_pagedir_t *pagedir, void *ptr,
 		int order)
 {
 	int i;
+	unsigned long addr = (unsigned long)ptr;
 	unsigned long addre = addr + (PAGE_SIZE<<order);
 	
 	for(i=0; i < nr_copy_pages; i++)
@@ -897,15 +897,15 @@ static int check_pagedir(void)
 	int i;
 
 	for(i=0; i < nr_copy_pages; i++) {
-		unsigned long addr;
+		void *newpage;
 
 		do {
-			addr = get_zeroed_page(GFP_ATOMIC);
-			if(!addr)
+			newpage = (void *)get_zeroed_page(GFP_ATOMIC);
+			if(!newpage)
 				return -ENOMEM;
-		} while (does_collide(addr));
+		} while (does_collide(newpage));
 
-		(pagedir_nosave+i)->address = addr;
+		(pagedir_nosave+i)->address = newpage;
 	}
 	return 0;
 }
@@ -923,13 +923,13 @@ static int relocate_pagedir(void)
 
 	printk("Relocating pagedir ");
 
-	if(!does_collide_order(old_pagedir, (unsigned long)old_pagedir, pagedir_order)) {
+	if(!does_collide_order(old_pagedir, old_pagedir, pagedir_order)) {
 		printk("not necessary\n");
 		return 0;
 	}
 
 	while ((m = (void *) __get_free_pages(GFP_ATOMIC, pagedir_order)) != NULL) {
-		if (!does_collide_order(old_pagedir, (unsigned long)m, pagedir_order))
+		if (!does_collide_order(old_pagedir, m, pagedir_order))
 			break;
 		eaten_memory = m;
 		printk( "." ); 

--=-tgwliorF58MZw+D1WPTT--

