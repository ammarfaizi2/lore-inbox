Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267841AbUH2Nzf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267841AbUH2Nzf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 09:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267839AbUH2Nzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 09:55:35 -0400
Received: from [193.12.224.70] ([193.12.224.70]:9960 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267859AbUH2NyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 09:54:13 -0400
Date: Sun, 29 Aug 2004 15:54:03 +0200
From: Erik Rigtorp <erik@rigtorp.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make swsusp produce nicer screen output
Message-ID: <20040829135403.GA8182@linux.nu>
References: <20040820152317.GA7118@linux.nu> <20040823174217.GC603@openzaurus.ucw.cz> <20040823200858.GA4593@linux.nu> <20040824214929.GA490@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040824214929.GA490@openzaurus.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2004 at 11:49:30PM +0200, Pavel Machek wrote:
> Hi!
> 
> > > Well, it looks nice, be sure to submit smooth version :-).
> > I'm working on it :).
> 
> > > I'd leave dots here. Its usefull to see if it done something or not.
> > 
> > Well, it will display a spinning thingy that is updated every time
> > shrink_all_memory(10000) returns. Maybe you want to see how much memory was
> > freed?
> 
> Yes, it is quite important to see how many pages were freed even after
> freeing stopped. "done (1234 pages freed)" would solve it...
Added code for this in the new patch

> 
> > And do we need to handle the case when nr_copy_pages < 100?
> 
> It really should not crash. 100 pages is 4MB. Thats little low but
> seems possible.

Well it's probably best to handle this case, to be on the safe side.

Here's a new version of the patch.

diff -Nru linux-2.6.8.1-mm2/kernel/power/disk.c linux-2.6.8.1-mm2-erkki/kernel/power/disk.c
--- linux-2.6.8.1-mm2/kernel/power/disk.c	2004-08-20 17:10:58.000000000 +0200
+++ linux-2.6.8.1-mm2-erkki/kernel/power/disk.c	2004-08-29 14:16:53.000000000 +0200
@@ -85,10 +85,20 @@
 
 static void free_some_memory(void)
 {
-	printk("Freeing memory: ");
-	while (shrink_all_memory(10000))
-		printk(".");
-	printk("|\n");
+	unsigned int i = 0;
+	unsigned int tmp;
+	unsigned long pages = 0;
+	char *p = "-\\|/";
+	
+	printk("Freeing memory...  ");
+	while (tmp = shrink_all_memory(10000)) {
+		pages += tmp;
+		printk("\b%c", p[i]);
+		i++;
+		if (i > 3)
+			i = 0;
+	}
+	printk("\bdone (%li pages freed)\n", pages);
 }
 
 
diff -Nru linux-2.6.8.1-mm2/kernel/power/swsusp.c linux-2.6.8.1-mm2-erkki/kernel/power/swsusp.c
--- linux-2.6.8.1-mm2/kernel/power/swsusp.c	2004-08-20 17:10:58.000000000 +0200
+++ linux-2.6.8.1-mm2-erkki/kernel/power/swsusp.c	2004-08-29 13:51:55.000000000 +0200
@@ -296,15 +296,21 @@
 {
 	int error = 0;
 	int i;
-
-	printk( "Writing data to swap (%d pages): ", nr_copy_pages );
+	unsigned int mod;
+	
+	if (nr_copy_pages < 100)
+		mod = 1;
+	else
+		mod = nr_copy_pages / 100;
+	
+	printk( "Writing data to swap (%d pages)...     ", nr_copy_pages );
 	for (i = 0; i < nr_copy_pages && !error; i++) {
-		if (!(i%100))
-			printk( "." );
+		if (!(i%mod))
+			printk( "\b\b\b\b%3d%%", i / mod );
 		error = write_page((pagedir_nosave+i)->address,
 					  &((pagedir_nosave+i)->swap_address));
 	}
-	printk(" %d Pages done.\n",i);
+	printk("\b\b\b\bdone\n");
 	return error;
 }
 
@@ -534,8 +540,6 @@
 	if (!pfn_valid(pfn))
 		return 0;
 
-	if (!(pfn%1000))
-		printk(".");
 	page = pfn_to_page(pfn);
 	BUG_ON(PageReserved(page) && PageNosave(page));
 	if (PageNosave(page))
@@ -556,15 +560,28 @@
 {
 	struct zone *zone;
 	unsigned long zone_pfn;
+	unsigned long mod;
+	
+	printk("Counting pages...     ");
 
 	nr_copy_pages = 0;
 
 	for_each_zone(zone) {
 		if (!is_highmem(zone)) {
-			for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn)
+			if (zone->spanned_pages < 100)
+				mod = 1;
+			else
+				mod = zone->spanned_pages / 100;
+			
+			for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn) {
 				nr_copy_pages += saveable(zone, &zone_pfn);
+				if (!(zone_pfn % mod))
+					printk("\b\b\b\b%3ld%%", zone_pfn / mod);
+			}
 		}
 	}
+	
+	printk("\b\b\b\bdone\n");
 }
 
 
@@ -573,9 +590,17 @@
 	struct zone *zone;
 	unsigned long zone_pfn;
 	struct pbe * pbe = pagedir_nosave;
+	unsigned long mod;
 	
+	printk("Copying pages...     ");
+
 	for_each_zone(zone) {
-		if (!is_highmem(zone))
+		if (!is_highmem(zone)) {
+			if (zone->spanned_pages < 100)
+				mod = 1;
+			else
+				mod = zone->spanned_pages / 100;
+			
 			for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn) {
 				if (saveable(zone, &zone_pfn)) {
 					struct page * page;
@@ -584,9 +609,14 @@
 					/* copy_page is no usable for copying task structs. */
 					memcpy((void *)pbe->address, (void *)pbe->orig_address, PAGE_SIZE);
 					pbe++;
+					if (!(zone_pfn % mod))
+						printk("\b\b\b\b%3ld%%", zone_pfn / mod);
 				}
 			}
+		}
 	}
+	
+	printk("\b\b\b\bdone\n");
 }
 
 
@@ -1150,14 +1180,20 @@
 	struct pbe * p;
 	int error;
 	int i;
-
+	int mod;
+	
+	if (nr_copy_pages < 100)
+		mod = 1;
+	else
+		mod = nr_copy_pages / 100;
+	
 	if ((error = swsusp_pagedir_relocate()))
 		return error;
 
-	printk( "Reading image data (%d pages): ", nr_copy_pages );
+	printk( "Reading image data (%d pages):     ", nr_copy_pages );
 	for(i = 0, p = pagedir_nosave; i < nr_copy_pages && !error; i++, p++) {
-		if (!(i%100))
-			printk( "." );
+		if (!(i%mod))
+			printk( "\b\b\b\b%3d%%", i / mod );
 		error = bio_read_page(swp_offset(p->swap_address),
 				  (void *)p->address);
 	}
