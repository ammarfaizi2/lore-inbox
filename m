Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263594AbUDFMQE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 08:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263652AbUDFMQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 08:16:04 -0400
Received: from gprs214-195.eurotel.cz ([160.218.214.195]:56450 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S263594AbUDFMPl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 08:15:41 -0400
Date: Tue, 6 Apr 2004 14:15:22 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: swsusp update: supports discontingmem/highmem
Message-ID: <20040406121522.GH3693@elf.ucw.cz>
References: <20040405212354.GA3633@elf.ucw.cz> <20040405153507.69e3004d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040405153507.69e3004d.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > It makes swsusp behave correctly
> > w.r.t. discontingmem, and adds highmem handling 
> 
> Some of those ENOMEM panics in save_highmem_zone() look like they might
> need proper handling instead?

Done.

> The 256 byte automatic array in read_swapfiles() may bring you a visit from
> the stack space police, although I don't think it's really a problem.  256
> bytes for a pathname may be a bit excessive though.

Marked static, its only called once anyway.

> Please send me an update patch sometime which makes all the new code go
> away again if !CONFIG_HIGHMEM.

Done; plus I added some warnings to swsusp.S (based on discussion with
wli). Relative to previous diff, please apply.
								Pavel

--- tmp/linux/arch/i386/power/swsusp.S	2003-09-28 22:05:30.000000000 +0200
+++ linux/arch/i386/power/swsusp.S	2004-04-06 13:25:42.000000000 +0200
@@ -1,6 +1,13 @@
 .text
 
-/* Originally gcc generated, modified by hand */
+/* Originally gcc generated, modified by hand
+ *
+ * This may not use any stack, nor any variable that is not "NoSave":
+ *
+ * Its rewriting one kernel image with another. What is stack in "old"
+ * image could very well be data page in "new" image, and overwriting
+ * your own stack under you is bad idea.
+ */
 
 #include <linux/linkage.h>
 #include <asm/segment.h>
--- tmp/linux/kernel/power/swsusp.c	2004-04-06 13:26:39.000000000 +0200
+++ linux/kernel/power/swsusp.c	2004-04-06 13:07:46.000000000 +0200
@@ -225,7 +225,7 @@
 static void read_swapfiles(void) /* This is called before saving image */
 {
 	int i, len;
-	char buff[sizeof(resume_file)], *sname;
+	static char buff[sizeof(resume_file)], *sname;
 	
 	len=strlen(resume_file);
 	root_swap = 0xFFFF;
@@ -366,6 +366,7 @@
 	return 0;
 }
 
+#ifdef CONFIG_HIGHMEM
 struct highmem_page {
 	char *data;
 	struct page *page;
@@ -374,7 +375,7 @@
 
 struct highmem_page *highmem_copy = NULL;
 
-static void save_highmem_zone(struct zone *zone)
+static int save_highmem_zone(struct zone *zone)
 {
 	unsigned long zone_pfn;
 	for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn) {
@@ -384,7 +385,7 @@
 		unsigned long pfn = zone_pfn + zone->zone_start_pfn;
 		int chunk_size;
 
-		if (!(pfn%200))
+		if (!(pfn%1000))
 			printk(".");
 		if (!pfn_valid(pfn))
 			continue;
@@ -397,7 +398,7 @@
 		 */
 		if (PageReserved(page)) {
 			printk("highmem reserved page?!\n");
-			BUG();
+			continue;
 		}
 		if ((chunk_size = is_head_of_free_region(page))) {
 			pfn += chunk_size - 1;
@@ -406,26 +407,33 @@
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
@@ -443,6 +451,7 @@
 	}
 	return 0;
 }
+#endif
 
 static int pfn_is_nosave(unsigned long pfn)
 {
@@ -460,7 +469,7 @@
 		struct page *page;
 		unsigned long pfn = zone_pfn + zone->zone_start_pfn;
 
-		if (!(pfn%200))
+		if (!(pfn%1000))
 			printk(".");
 		if (!pfn_valid(pfn))
 			continue;
@@ -548,7 +557,7 @@
 		
 	while(nr_copy_pages--) {
 		p->address = get_zeroed_page(GFP_ATOMIC | __GFP_COLD);
-		if(!p->address) {
+		if (!p->address) {
 			free_suspend_pagedir((unsigned long) pagedir);
 			return NULL;
 		}
@@ -589,10 +598,17 @@
 	unsigned int nr_needed_pages = 0;
 
 	pagedir_nosave = NULL;
-	printk( "/critical section: Handling highmem" );
-	save_highmem();
+	printk( "/critical section: ");
+#ifdef CONFIG_HIGHMEM
+	printk( "handling highmem" );
+	if (save_highmem()) {
+		printk(KERN_CRIT "%sNot enough free pages for highmem\n", name_suspend);
+		return -ENOMEM;
+	}
+	printk(", ");
+#endif
 
-	printk(", counting pages to copy" );
+	printk("counting pages to copy" );
 	drain_local_pages();
 	nr_copy_pages = count_and_copy_data_pages(NULL);
 	nr_needed_pages = nr_copy_pages + PAGES_FOR_IO;
@@ -602,23 +618,22 @@
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
@@ -702,8 +717,10 @@
 	PRINTK( "Freeing prev allocated pagedir\n" );
 	free_suspend_pagedir((unsigned long) pagedir_save);
 
+#ifdef CONFIG_HIGHMEM
 	printk( "Restoring highmem\n" );
 	restore_highmem();
+#endif
 	printk("done, devices\n");
 
 	device_power_up();

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
