Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263767AbUDFLJR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 07:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263778AbUDFLIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 07:08:42 -0400
Received: from gprs214-195.eurotel.cz ([160.218.214.195]:53378 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S263767AbUDFLDc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 07:03:32 -0400
Date: Tue, 6 Apr 2004 13:03:08 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@users.sourceforge.net>
Cc: Andrew Morton <akpm@zip.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: swsusp update: supports discontingmem/highmem
Message-ID: <20040406110308.GD3693@elf.ucw.cz>
References: <20040405212354.GA3633@elf.ucw.cz> <1081203867.2577.11.camel@calvin.wpcb.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1081203867.2577.11.camel@calvin.wpcb.org.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> On Tue, 2004-04-06 at 07:23, Pavel Machek wrote:
> > +		if (PageReserved(page)) {
> > +			printk("highmem reserved page?!\n");
> > +			BUG();
> > +		}
> 
> We dealt with this recently in suspend2. It's perfectly valid to have a
> Reserved Highmem page. They need to be completely ignored, and whatever
> driver is responsible for the memory should handle any required state
> persistance. We're setting NoSave for such pages in the parsing of the
> e820 table at boot time.

Okay, I changed BUG() into continue. I still left printk, so that when
something goes wrong, we still know.

> > +		if (!save)
> > +			panic("Not enough memory");
> 
> Can't you back out nicely if you don't have enough memory for the image?
> 
> > +		if (!save->data)
> > +			panic("Not enough memory");
> 
> (Ditto)

Ugh. I had this in my tree, unfortunately in my other tree. Here's the
diff. (Do not apply it just yet, I'll add #ifdef CONFIG_HIGHMEMs).

									Pavel

--- clean/kernel/power/swsusp.c	2004-03-26 12:10:06.000000000 +0100
+++ linux/kernel/power/swsusp.c	2004-03-26 17:06:31.000000000 +0100
@@ -374,7 +374,7 @@
 
 struct highmem_page *highmem_copy = NULL;
 
-static void save_highmem_zone(struct zone *zone)
+static int save_highmem_zone(struct zone *zone)
 {
 	unsigned long zone_pfn;
 	for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn) {
@@ -384,7 +384,7 @@
 		unsigned long pfn = zone_pfn + zone->zone_start_pfn;
 		int chunk_size;
 
-		if (!(pfn%200))
+		if (!(pfn%1000))
 			printk(".");
 		if (!pfn_valid(pfn))
 			continue;
@@ -406,26 +406,33 @@
 		}
 		save = kmalloc(sizeof(struct highmem_page), GFP_ATOMIC);
 		if (!save)
-			panic("Not enough memory");
+			return -ENOMEM;
 		save->next = highmem_copy;
 		save->page = page;
 		save->data = (void *) get_zeroed_page(GFP_ATOMIC);
-		if (!save->data)
-			panic("Not enough memory");
+		if (!save->data) {
+			kfree(save);
+			return -ENOMEM;
+		}
 		kaddr = kmap_atomic(page, KM_USER0);
 		memcpy(save->data, kaddr, PAGE_SIZE);
 		kunmap_atomic(kaddr, KM_USER0);
 		highmem_copy = save;
 	}
+	return 0;
 }
 
-static void save_highmem(void)
+static int save_highmem(void)
 {
 	struct zone *zone;
+	int res = 0;
 	for_each_zone(zone) {
 		if (is_highmem(zone))
-			save_highmem_zone(zone);
+			res = save_highmem_zone(zone);
+		if (res)
+			return res;
 	}
+	return 0;
 }
 
 static int restore_highmem(void)
@@ -460,7 +467,7 @@
 		struct page *page;
 		unsigned long pfn = zone_pfn + zone->zone_start_pfn;
 
-		if (!(pfn%200))
+		if (!(pfn%1000))
 			printk(".");
 		if (!pfn_valid(pfn))
 			continue;
@@ -539,7 +546,7 @@
 	pagedir_order = get_bitmask_order(SUSPEND_PD_PAGES(nr_copy_pages));
 
 	p = pagedir = (suspend_pagedir_t *)__get_free_pages(GFP_ATOMIC | __GFP_COLD, pagedir_order);
-	if(!pagedir)
+	if (!pagedir)
 		return NULL;
 
 	page = virt_to_page(pagedir);
@@ -548,7 +555,7 @@
 		
 	while(nr_copy_pages--) {
 		p->address = get_zeroed_page(GFP_ATOMIC | __GFP_COLD);
-		if(!p->address) {
+		if (!p->address) {
 			free_suspend_pagedir((unsigned long) pagedir);
 			return NULL;
 		}
@@ -590,7 +597,10 @@
 
 	pagedir_nosave = NULL;
 	printk( "/critical section: Handling highmem" );
-	save_highmem();
+	if (save_highmem()) {
+		printk(KERN_CRIT "%sNot enough free pages for highmem\n", name_suspend);
+		return -ENOMEM;
+	}
 
 	printk(", counting pages to copy" );
 	drain_local_pages();
@@ -602,23 +612,22 @@
 		printk(KERN_CRIT "%sCouldn't get enough free pages, on %d pages short\n",
 		       name_suspend, nr_needed_pages-nr_free_pages());
 		root_swap = 0xFFFF;
-		return 1;
+		return -ENOMEM;
 	}
 	si_swapinfo(&i);	/* FIXME: si_swapinfo(&i) returns all swap devices information.
 				   We should only consider resume_device. */
 	if (i.freeswap < nr_needed_pages)  {
 		printk(KERN_CRIT "%sThere's not enough swap space available, on %ld pages short\n",
 		       name_suspend, nr_needed_pages-i.freeswap);
-		return 1;
+		return -ENOSPC;
 	}
 
 	PRINTK( "Alloc pagedir\n" ); 
 	pagedir_save = pagedir_nosave = create_suspend_pagedir(nr_copy_pages);
-	if(!pagedir_nosave) {
-		/* Shouldn't happen */
-		printk(KERN_CRIT "%sCouldn't allocate enough pages\n",name_suspend);
-		panic("Really should not happen");
-		return 1;
+	if (!pagedir_nosave) {
+		/* Pagedir is big, one-chunk allocation. It is easily possible for this allocation to fail */
+		printk(KERN_CRIT "%sCouldn't allocate continuous pagedir\n", name_suspend);
+		return -ENOMEM;
 	}
 	nr_copy_pages_check = nr_copy_pages;
 	pagedir_order_check = pagedir_order;

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
