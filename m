Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262650AbVCDOUw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262650AbVCDOUw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 09:20:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262601AbVCDOUi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 09:20:38 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:26500 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262762AbVCDOUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 09:20:02 -0500
Subject: Re: BIOS overwritten during resume (was: Re: Asus L5D resume on
	battery power)
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@suse.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       paul.devriendt@amd.com
In-Reply-To: <20050304110408.GL1345@elf.ucw.cz>
References: <200502252237.04110.rjw@sisk.pl>
	 <200503030047.43625.rjw@sisk.pl> <20050302235456.GB1439@elf.ucw.cz>
	 <200503030902.48038.rjw@sisk.pl>  <20050304110408.GL1345@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1109946109.3772.267.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Sat, 05 Mar 2005 01:21:49 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2005-03-04 at 22:04, Pavel Machek wrote:
> Hi!
> 
> > > IIRC kernel code/data is marked as PageReserved(), that's why we need
> > > to save that :(. Not sure what to do with data e820 marked as
> > > reserved...
> > 
> > Perhaps we need another page flag, like PG_readonly, and mark the pages
> > reserved by the e820 as PG_reserved | PG_readonly (the same for the areas
> > that are not returned by e820 at all).  Would that be acceptable?
> 
> This flags are little in the short supply, but being able to tell
> kernel code from memory hole seems like "must have", so yes, that
> looks ok.
> 
> You could get subtle and reuse some other pageflag. I do not think
> PG_reserved can have PG_locked... So using for example PG_locked for
> this purpose should be okay.

Will something like this patch help?

Regards,

Nigel

diff -ruNp 208-e820-table-support-old/arch/i386/mm/init.c 208-e820-table-support-new/arch/i386/mm/init.c
--- 208-e820-table-support-old/arch/i386/mm/init.c	2005-01-12 17:06:58.481035848 +1100
+++ 208-e820-table-support-new/arch/i386/mm/init.c	2005-01-12 17:22:55.414559840 +1100
@@ -27,6 +27,7 @@
 #include <linux/slab.h>
 #include <linux/proc_fs.h>
 #include <linux/efi.h>
+#include <linux/suspend.h>
 
 #include <asm/processor.h>
 #include <asm/system.h>
@@ -272,12 +273,15 @@ void __init one_highpage_init(struct pag
 {
 	if (page_is_ram(pfn) && !(bad_ppro && page_kills_ppro(pfn))) {
 		ClearPageReserved(page);
+		ClearPageNosave(page);
 		set_bit(PG_highmem, &page->flags);
 		set_page_count(page, 1);
 		__free_page(page);
 		totalhigh_pages++;
-	} else
+	} else {
 		SetPageReserved(page);
+		SetPageNosave(page);
+	}
 }
 
 #ifndef CONFIG_DISCONTIGMEM
@@ -355,7 +359,7 @@ static void __init pagetable_init (void)
 #endif
 }
 
-#if defined(CONFIG_PM_DISK) || defined(CONFIG_SOFTWARE_SUSPEND)
+#ifdef CONFIG_PM
 /*
  * Swap suspend & friends need this for resume because things like the intel-agp
  * driver might have split up a kernel 4MB mapping.
@@ -571,6 +575,7 @@ void __init mem_init(void)
 	int codesize, reservedpages, datasize, initsize;
 	int tmp;
 	int bad_ppro;
+	void * addr;
 
 #ifndef CONFIG_DISCONTIGMEM
 	if (!mem_map)
@@ -601,12 +606,25 @@ void __init mem_init(void)
 	totalram_pages += __free_all_bootmem();
 
 	reservedpages = 0;
-	for (tmp = 0; tmp < max_low_pfn; tmp++)
-		/*
-		 * Only count reserved RAM pages
-		 */
-		if (page_is_ram(tmp) && PageReserved(pfn_to_page(tmp)))
-			reservedpages++;
+	addr = __va(0);
+	for (tmp = 0; tmp < max_low_pfn; tmp++, addr += PAGE_SIZE) {
+		if (page_is_ram(tmp)) {
+			/*
+			 * Only count reserved RAM pages
+			 */
+			if (PageReserved(mem_map+tmp))
+				reservedpages++;
+			/*
+			 * Mark nosave pages
+			 */
+			if (addr >= (void *)&__nosave_begin && addr < (void *)&__nosave_end)
+				SetPageNosave(mem_map+tmp);
+		} else
+			/*
+			 * Non-RAM pages are always nosave
+			 */
+			SetPageNosave(mem_map+tmp);
+	}
 
 	set_highmem_pages_init(bad_ppro);
 
@@ -705,6 +723,7 @@ void free_initmem(void)
 	addr = (unsigned long)(&__init_begin);
 	for (; addr < (unsigned long)(&__init_end); addr += PAGE_SIZE) {
 		ClearPageReserved(virt_to_page(addr));
+		ClearPageNosave(virt_to_page(addr));
 		set_page_count(virt_to_page(addr), 1);
 		memset((void *)addr, 0xcc, PAGE_SIZE);
 		free_page(addr);
@@ -720,6 +739,7 @@ void free_initrd_mem(unsigned long start
 		printk (KERN_INFO "Freeing initrd memory: %ldk freed\n", (end - start) >> 10);
 	for (; start < end; start += PAGE_SIZE) {
 		ClearPageReserved(virt_to_page(start));
+		ClearPageNosave(virt_to_page(start));
 		set_page_count(virt_to_page(start), 1);
 		free_page(start);
 		totalram_pages++;
diff -ruNp 208-e820-table-support-old/mm/bootmem.c 208-e820-table-support-new/mm/bootmem.c
--- 208-e820-table-support-old/mm/bootmem.c	2005-01-12 17:07:15.902387400 +1100
+++ 208-e820-table-support-new/mm/bootmem.c	2005-01-12 17:23:44.087160480 +1100
@@ -280,12 +280,14 @@ static unsigned long __init free_all_boo
 
 			count += BITS_PER_LONG;
 			__ClearPageReserved(page);
+			ClearPageNosave(page);
 			order = ffs(BITS_PER_LONG) - 1;
 			set_page_refs(page, order);
 			for (j = 1; j < BITS_PER_LONG; j++) {
 				if (j + 16 < BITS_PER_LONG)
 					prefetchw(page + j + 16);
 				__ClearPageReserved(page + j);
+				ClearPageNosave(page + j);
 			}
 			__free_pages(page, order);
 			i += BITS_PER_LONG;
@@ -296,6 +298,7 @@ static unsigned long __init free_all_boo
 				if (v & m) {
 					count++;
 					__ClearPageReserved(page);
+					ClearPageNosave(page);
 					set_page_refs(page, 0);
 					__free_page(page);
 				}
@@ -316,6 +319,7 @@ static unsigned long __init free_all_boo
 	for (i = 0; i < ((bdata->node_low_pfn-(bdata->node_boot_start >> PAGE_SHIFT))/8 + PAGE_SIZE-1)/PAGE_SIZE; i++,page++) {
 		count++;
 		__ClearPageReserved(page);
+		ClearPageNosave(page);
 		set_page_count(page, 1);
 		__free_page(page);
 	}

-- 
Nigel Cunningham
Software Engineer
Cyclades Corporation

http://cyclades.com

