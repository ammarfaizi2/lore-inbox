Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263358AbUDEVef (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 17:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263346AbUDEVbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 17:31:36 -0400
Received: from gprs214-195.eurotel.cz ([160.218.214.195]:39296 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S263358AbUDEVYW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 17:24:22 -0400
Date: Mon, 5 Apr 2004 23:23:54 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: swsusp update: supports discontingmem/highmem
Message-ID: <20040405212354.GA3633@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

wli did some work on this... It makes swsusp behave correctly
w.r.t. discontingmem, and adds highmem handling (very simple-minded,
but should work ok with 1GB). It now should behave correctly
w.r.t. more than one swap device, and fixes double restoring of
console. Please apply,

								Pavel

[okay, this probably should receive some -mm testing before going
mainline.]

Index: linux/include/linux/suspend.h
===================================================================
--- linux.orig/include/linux/suspend.h	2004-04-05 22:47:34.000000000 +0200
+++ linux/include/linux/suspend.h	2004-03-11 18:18:31.000000000 +0100
@@ -24,7 +24,7 @@
 #define SWAP_FILENAME_MAXLENGTH	32
 
 struct suspend_header {
-	__u32 version_code;
+	u32 version_code;
 	unsigned long num_physpages;
 	char machine[8];
 	char version[20];
Index: linux/kernel/power/swsusp.c
===================================================================
--- linux.orig/kernel/power/swsusp.c	2004-04-05 22:47:34.000000000 +0200
+++ linux/kernel/power/swsusp.c	2004-04-05 22:31:10.000000000 +0200
@@ -1,11 +1,11 @@
 /*
- * linux/kernel/suspend.c
+ * linux/kernel/power/swsusp.c
  *
  * This file is to realize architecture-independent
  * machine suspend feature using pretty near only high-level routines
  *
  * Copyright (C) 1998-2001 Gabor Kuti <seasons@fornax.hu>
- * Copyright (C) 1998,2001-2003 Pavel Machek <pavel@suse.cz>
+ * Copyright (C) 1998,2001-2004 Pavel Machek <pavel@suse.cz>
  *
  * This file is released under the GPLv2.
  *
@@ -61,6 +61,7 @@
 #include <linux/bootmem.h>
 #include <linux/syscalls.h>
 #include <linux/console.h>
+#include <linux/highmem.h>
 
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
@@ -74,11 +75,6 @@
 #define NORESUME		1
 #define RESUME_SPECIFIED	2
 
-
-#define __ADDRESS(x)  ((unsigned long) phys_to_virt(x))
-#define ADDRESS(x) __ADDRESS((x) << PAGE_SHIFT)
-#define ADDRESS2(x) __ADDRESS(__pa(x))		/* Needed for x86-64 where some pages are in memory twice */
-
 /* References to section boundaries */
 extern char __nosave_begin, __nosave_end;
 
@@ -105,6 +101,10 @@
    time of suspend, that must be freed. Second is "pagedir_nosave", 
    allocated at time of resume, that travels through memory not to
    collide with anything.
+
+   Warning: this is even more evil than it seems. Pagedirs this file
+   talks about are completely different from page directories used by
+   MMU hardware.
  */
 suspend_pagedir_t *pagedir_nosave __nosavedata = NULL;
 static suspend_pagedir_t *pagedir_save;
@@ -139,15 +139,15 @@
 #define TEST_SWSUSP 0		/* Set to 1 to reboot instead of halt machine after suspension */
 
 #ifdef DEBUG_DEFAULT
-# define PRINTK(f, a...)       printk(f, ## a)
+# define PRINTK(f, a...)	printk(f, ## a)
 #else
-# define PRINTK(f, a...)
+# define PRINTK(f, a...)       	do { } while(0)
 #endif
 
 #ifdef DEBUG_SLOW
 #define MDELAY(a) mdelay(a)
 #else
-#define MDELAY(a)
+#define MDELAY(a) do { } while(0)
 #endif
 
 /*
@@ -225,6 +225,7 @@
 static void read_swapfiles(void) /* This is called before saving image */
 {
 	int i, len;
+	char buff[sizeof(resume_file)], *sname;
 	
 	len=strlen(resume_file);
 	root_swap = 0xFFFF;
@@ -243,8 +244,11 @@
 					swapfile_used[i] = SWAPFILE_IGNORED;				  
 			} else {
 	  			/* we ignore all swap devices that are not the resume_file */
-				if (1) {
-// FIXME				if(resume_device == swap_info[i].swap_device) {
+				sname = d_path(swap_info[i].swap_file->f_dentry,
+					       swap_info[i].swap_file->f_vfsmnt,
+					       buff,
+					       sizeof(buff));
+				if (!strcmp(sname, resume_file)) {
 					swapfile_used[i] = SWAPFILE_SUSPEND;
 					root_swap = i;
 				} else {
@@ -346,7 +350,7 @@
 
 	cur = (void *) buffer;
 	if (fill_suspend_header(&cur->sh))
-		panic("\nOut of memory while writing header");
+		BUG();		/* Not a BUG_ON(): we want fill_suspend_header to be called, always */
 		
 	cur->link.next = prev;
 
@@ -362,73 +366,165 @@
 	return 0;
 }
 
-/* if pagedir_p != NULL it also copies the counted pages */
-static int count_and_copy_data_pages(struct pbe *pagedir_p)
-{
-	int chunk_size;
-	int nr_copy_pages = 0;
-	int pfn;
+struct highmem_page {
+	char *data;
 	struct page *page;
-	
-#ifdef CONFIG_DISCONTIGMEM
-	panic("Discontingmem not supported");
-#else
-	BUG_ON (max_pfn != num_physpages);
-#endif
-	for (pfn = 0; pfn < max_pfn; pfn++) {
+	struct highmem_page *next;
+};
+
+struct highmem_page *highmem_copy = NULL;
+
+static void save_highmem_zone(struct zone *zone)
+{
+	unsigned long zone_pfn;
+	for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn) {
+		struct page *page;
+		struct highmem_page *save;
+		void *kaddr;
+		unsigned long pfn = zone_pfn + zone->zone_start_pfn;
+		int chunk_size;
+
+		if (!(pfn%200))
+			printk(".");
+		if (!pfn_valid(pfn))
+			continue;
 		page = pfn_to_page(pfn);
-		if (PageHighMem(page))
-			panic("Swsusp not supported on highmem boxes. Send 1GB of RAM to <pavel@ucw.cz> and try again ;-).");
+		/*
+		 * This condition results from rvmalloc() sans vmalloc_32()
+		 * and architectural memory reservations. This should be
+		 * corrected eventually when the cases giving rise to this
+		 * are better understood.
+		 */
+		if (PageReserved(page)) {
+			printk("highmem reserved page?!\n");
+			BUG();
+		}
+		if ((chunk_size = is_head_of_free_region(page))) {
+			pfn += chunk_size - 1;
+			zone_pfn += chunk_size - 1;
+			continue;
+		}
+		save = kmalloc(sizeof(struct highmem_page), GFP_ATOMIC);
+		if (!save)
+			panic("Not enough memory");
+		save->next = highmem_copy;
+		save->page = page;
+		save->data = (void *) get_zeroed_page(GFP_ATOMIC);
+		if (!save->data)
+			panic("Not enough memory");
+		kaddr = kmap_atomic(page, KM_USER0);
+		memcpy(save->data, kaddr, PAGE_SIZE);
+		kunmap_atomic(kaddr, KM_USER0);
+		highmem_copy = save;
+	}
+}
 
-		if (!PageReserved(page)) {
-			if (PageNosave(page))
-				continue;
-
-			if ((chunk_size=is_head_of_free_region(page))!=0) {
-				pfn += chunk_size - 1;
-				continue;
-			}
-		} else if (PageReserved(page)) {
-			BUG_ON (PageNosave(page));
+static void save_highmem(void)
+{
+	struct zone *zone;
+	for_each_zone(zone) {
+		if (is_highmem(zone))
+			save_highmem_zone(zone);
+	}
+}
 
-			/*
-			 * Just copy whole code segment. Hopefully it is not that big.
-			 */
-			if ((ADDRESS(pfn) >= (unsigned long) ADDRESS2(&__nosave_begin)) && 
-			    (ADDRESS(pfn) <  (unsigned long) ADDRESS2(&__nosave_end))) {
-				PRINTK("[nosave %lx]", ADDRESS(pfn));
-				continue;
-			}
-			/* Hmm, perhaps copying all reserved pages is not too healthy as they may contain 
-			   critical bios data? */
-		} else	BUG();
+static int restore_highmem(void)
+{
+	while (highmem_copy) {
+		struct highmem_page *save = highmem_copy;
+		void *kaddr;
+		highmem_copy = save->next;
+		
+		kaddr = kmap_atomic(save->page, KM_USER0);
+		memcpy(kaddr, save->data, PAGE_SIZE);
+		kunmap_atomic(kaddr, KM_USER0);
+		free_page((long) save->data);
+		kfree(save);
+	}
+	return 0;
+}
 
-		nr_copy_pages++;
-		if (pagedir_p) {
-			pagedir_p->orig_address = ADDRESS(pfn);
-			copy_page((void *) pagedir_p->address, (void *) pagedir_p->orig_address);
-			pagedir_p++;
+static int pfn_is_nosave(unsigned long pfn)
+{
+	unsigned long nosave_begin_pfn = __pa(&__nosave_begin) >> PAGE_SHIFT;
+	unsigned long nosave_end_pfn = PAGE_ALIGN(__pa(&__nosave_end)) >> PAGE_SHIFT;
+	return (pfn >= nosave_begin_pfn) && (pfn < nosave_end_pfn);
+}
+
+/* if *pagedir_p != NULL it also copies the counted pages */
+static int count_and_copy_zone(struct zone *zone, struct pbe **pagedir_p)
+{
+	unsigned long zone_pfn, chunk_size, nr_copy_pages = 0;
+	struct pbe *pbe = *pagedir_p;
+	for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn) {
+		struct page *page;
+		unsigned long pfn = zone_pfn + zone->zone_start_pfn;
+
+		if (!(pfn%200))
+			printk(".");
+		if (!pfn_valid(pfn))
+			continue;
+		page = pfn_to_page(pfn);
+		BUG_ON(PageReserved(page) && PageNosave(page));
+		if (PageNosave(page))
+			continue;
+		if (PageReserved(page) && pfn_is_nosave(pfn)) {
+			PRINTK("[nosave pfn 0x%lx]", pfn);
+			continue;
+		}
+		if ((chunk_size = is_head_of_free_region(page))) {
+			pfn += chunk_size - 1;
+			zone_pfn += chunk_size - 1;
+			continue;
 		}
+		nr_copy_pages++;
+		if (!pbe)
+			continue;
+		pbe->orig_address = (long) page_address(page);
+		copy_page((void *)pbe->address, (void *)pbe->orig_address);
+		pbe++;
 	}
+	*pagedir_p = pbe;
 	return nr_copy_pages;
 }
 
-static void free_suspend_pagedir(unsigned long this_pagedir)
+static int count_and_copy_data_pages(struct pbe *pagedir_p)
 {
-	struct page *page;
-	int pfn;
-	unsigned long this_pagedir_end = this_pagedir +
-		(PAGE_SIZE << pagedir_order);
+	int nr_copy_pages = 0;
+	struct zone *zone;
+	for_each_zone(zone) {
+		if (!is_highmem(zone))
+			nr_copy_pages += count_and_copy_zone(zone, &pagedir_p);
+	}
+	return nr_copy_pages;
+}
 
-	for(pfn = 0; pfn < num_physpages; pfn++) {
+static void free_suspend_pagedir_zone(struct zone *zone, unsigned long pagedir)
+{
+	unsigned long zone_pfn, pagedir_end, pagedir_pfn, pagedir_end_pfn;
+	pagedir_end = pagedir + (PAGE_SIZE << pagedir_order);
+	pagedir_pfn = __pa(pagedir) >> PAGE_SHIFT;
+	pagedir_end_pfn = __pa(pagedir_end) >> PAGE_SHIFT;
+	for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn) {
+		struct page *page;
+		unsigned long pfn = zone_pfn + zone->zone_start_pfn;
+		if (!pfn_valid(pfn))
+			continue;
 		page = pfn_to_page(pfn);
 		if (!TestClearPageNosave(page))
 			continue;
+		else if (pfn >= pagedir_pfn && pfn < pagedir_end_pfn)
+			continue;
+		__free_page(page);
+	}
+}
 
-		if (ADDRESS(pfn) >= this_pagedir && ADDRESS(pfn) < this_pagedir_end)
-			continue; /* old pagedir gets freed in one */
-		
-		free_page(ADDRESS(pfn));
+static void free_suspend_pagedir(unsigned long this_pagedir)
+{
+	struct zone *zone;
+	for_each_zone(zone) {
+		if (!is_highmem(zone))
+			free_suspend_pagedir_zone(zone, this_pagedir);
 	}
 	free_pages(this_pagedir, pagedir_order);
 }
@@ -443,7 +539,7 @@
 	pagedir_order = get_bitmask_order(SUSPEND_PD_PAGES(nr_copy_pages));
 
 	p = pagedir = (suspend_pagedir_t *)__get_free_pages(GFP_ATOMIC | __GFP_COLD, pagedir_order);
-	if(!pagedir)
+	if (!pagedir)
 		return NULL;
 
 	page = virt_to_page(pagedir);
@@ -492,10 +588,12 @@
 	struct sysinfo i;
 	unsigned int nr_needed_pages = 0;
 
-	drain_local_pages();
-
 	pagedir_nosave = NULL;
-	printk( "/critical section: Counting pages to copy" );
+	printk( "/critical section: Handling highmem" );
+	save_highmem();
+
+	printk(", counting pages to copy" );
+	drain_local_pages();
 	nr_copy_pages = count_and_copy_data_pages(NULL);
 	nr_needed_pages = nr_copy_pages + PAGES_FOR_IO;
 	
@@ -603,21 +701,23 @@
 
 	PRINTK( "Freeing prev allocated pagedir\n" );
 	free_suspend_pagedir((unsigned long) pagedir_save);
+
+	printk( "Restoring highmem\n" );
+	restore_highmem();
+	printk("done, devices\n");
+
 	device_power_up();
 	spin_unlock_irq(&suspend_pagedir_lock);
 	device_resume();
 
-	acquire_console_sem();
-	update_screen(fg_console);	/* Hmm, is this the problem? */
-	release_console_sem();
-
+	/* Fixme: this is too late; we should do this ASAP to avoid "infinite reboots" problem */
 	PRINTK( "Fixing swap signatures... " );
 	mark_swapfiles(((swp_entry_t) {0}), MARK_SWAP_RESUME);
 	PRINTK( "ok\n" );
 
 #ifdef SUSPEND_CONSOLE
 	acquire_console_sem();
-	update_screen(fg_console);	/* Hmm, is this the problem? */
+	update_screen(fg_console);
 	release_console_sem();
 #endif
 }

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
