Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263045AbSJHNif>; Tue, 8 Oct 2002 09:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263046AbSJHNif>; Tue, 8 Oct 2002 09:38:35 -0400
Received: from holomorphy.com ([66.224.33.161]:25311 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S263045AbSJHNib>;
	Tue, 8 Oct 2002 09:38:31 -0400
Date: Tue, 8 Oct 2002 06:41:07 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Pavel Machek <pavel@ucw.cz>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.41
Message-ID: <20021008134107.GH12432@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Adrian Bunk <bunk@fs.tum.de>, Pavel Machek <pavel@ucw.cz>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.33.0210071157270.1917-100000@penguin.transmeta.com> <Pine.NEB.4.44.0210081359280.8340-100000@mimas.fachschaften.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.NEB.4.44.0210081359280.8340-100000@mimas.fachschaften.tu-muenchen.de>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Oct 2002, Linus Torvalds wrote:
>> Pavel Machek <pavel@ucw.cz>:
>>   o Swsusp updates, do not thrash ide disk on suspend

On Tue, Oct 08, 2002 at 02:02:50PM +0200, Adrian Bunk wrote:
> This change causes the following compile error with CONFIG_DISCONTIGMEM
> enabled:
> kernel/suspend.c: In function `count_and_copy_data_pages':
> kernel/suspend.c:479: `max_mapnr' undeclared (first use in this function)
> kernel/suspend.c:479: (Each undeclared identifier is reported only once
> kernel/suspend.c:479: for each function it appears in.)
> make[1]: *** [kernel/suspend.o] Error 1
> make: *** [kernel] Error 2

max_mapnr must die. It's mostly buggy largely because it's not what
people think it is. Most of the time people want max_pfn, and the rest
they don't want it at all.

Pavel, you might also want to make config options conflict instead of
panicking.

It's mostly an expression of opinion, but here's a patch.
Totally untested, ignoring all but x86's arch code, vs. 2.5.41:


diff -urN linux-2.5.41/arch/i386/config.in swsusp-2.5.41/arch/i386/config.in
--- linux-2.5.41/arch/i386/config.in	2002-10-07 11:24:02.000000000 -0700
+++ swsusp-2.5.41/arch/i386/config.in	2002-10-08 06:17:11.000000000 -0700
@@ -441,7 +441,7 @@
 
 mainmenu_option next_comment
 comment 'Kernel hacking'
-if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
+if [ "$CONFIG_EXPERIMENTAL" = "y" -a "$CONFIG_DISCONTIGMEM" != "y" ]; then
    dep_bool 'Software Suspend (EXPERIMENTAL)' CONFIG_SOFTWARE_SUSPEND $CONFIG_PM
 fi
 
diff -urN linux-2.5.41/arch/i386/mm/discontig.c swsusp-2.5.41/arch/i386/mm/discontig.c
--- linux-2.5.41/arch/i386/mm/discontig.c	2002-10-07 11:24:39.000000000 -0700
+++ swsusp-2.5.41/arch/i386/mm/discontig.c	2002-10-08 06:18:19.000000000 -0700
@@ -271,13 +271,3 @@
 	totalram_pages += totalhigh_pages;
 #endif
 }
-
-void __init set_max_mapnr_init(void)
-{
-#ifdef CONFIG_HIGHMEM
-	highmem_start_page = NODE_DATA(0)->node_zones[ZONE_HIGHMEM].zone_mem_map;
-	num_physpages = highend_pfn;
-#else
-	num_physpages = max_low_pfn;
-#endif
-}
diff -urN linux-2.5.41/arch/i386/mm/init.c swsusp-2.5.41/arch/i386/mm/init.c
--- linux-2.5.41/arch/i386/mm/init.c	2002-10-07 11:23:35.000000000 -0700
+++ swsusp-2.5.41/arch/i386/mm/init.c	2002-10-08 06:18:07.000000000 -0700
@@ -411,19 +411,9 @@
 }
 
 #ifndef CONFIG_DISCONTIGMEM
-static void __init set_max_mapnr_init(void)
-{
-#ifdef CONFIG_HIGHMEM
-	highmem_start_page = pfn_to_page(highstart_pfn);
-	max_mapnr = num_physpages = highend_pfn;
-#else
-	max_mapnr = num_physpages = max_low_pfn;
-#endif
-}
 #define __free_all_bootmem() free_all_bootmem()
 #else
 #define __free_all_bootmem() free_all_bootmem_node(NODE_DATA(0))
-extern void set_max_mapnr_init(void);
 #endif /* !CONFIG_DISCONTIGMEM */
 
 #ifdef CONFIG_HUGETLB_PAGE
@@ -447,8 +437,6 @@
 	
 	bad_ppro = ppro_with_ram_bug();
 
-	set_max_mapnr_init();
-
 	high_memory = (void *) __va(max_low_pfn * PAGE_SIZE);
 
 	/* clear the zero-page */
diff -urN linux-2.5.41/include/asm-i386/page.h swsusp-2.5.41/include/asm-i386/page.h
--- linux-2.5.41/include/asm-i386/page.h	2002-10-07 11:23:32.000000000 -0700
+++ swsusp-2.5.41/include/asm-i386/page.h	2002-10-08 06:17:43.000000000 -0700
@@ -145,7 +145,7 @@
 #ifndef CONFIG_DISCONTIGMEM
 #define pfn_to_page(pfn)	(mem_map + (pfn))
 #define page_to_pfn(page)	((unsigned long)((page) - mem_map))
-#define pfn_valid(pfn)		((pfn) < max_mapnr)
+#define pfn_valid(pfn)		((pfn) < max_pfn)
 #endif /* !CONFIG_DISCONTIGMEM */
 #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
 
diff -urN linux-2.5.41/include/linux/mm.h swsusp-2.5.41/include/linux/mm.h
--- linux-2.5.41/include/linux/mm.h	2002-10-07 11:23:22.000000000 -0700
+++ swsusp-2.5.41/include/linux/mm.h	2002-10-08 06:17:31.000000000 -0700
@@ -15,10 +15,6 @@
 #include <linux/rbtree.h>
 #include <linux/fs.h>
 
-#ifndef CONFIG_DISCONTIGMEM          /* Don't use mapnrs, do it properly */
-extern unsigned long max_mapnr;
-#endif
-
 extern unsigned long num_physpages;
 extern void * high_memory;
 extern int page_cluster;
diff -urN linux-2.5.41/kernel/ksyms.c swsusp-2.5.41/kernel/ksyms.c
--- linux-2.5.41/kernel/ksyms.c	2002-10-07 11:22:56.000000000 -0700
+++ swsusp-2.5.41/kernel/ksyms.c	2002-10-08 06:16:37.000000000 -0700
@@ -117,7 +117,6 @@
 #ifndef CONFIG_DISCONTIGMEM
 EXPORT_SYMBOL(contig_page_data);
 EXPORT_SYMBOL(mem_map);
-EXPORT_SYMBOL(max_mapnr);
 #endif
 EXPORT_SYMBOL(high_memory);
 EXPORT_SYMBOL(vmtruncate);
diff -urN linux-2.5.41/kernel/suspend.c swsusp-2.5.41/kernel/suspend.c
--- linux-2.5.41/kernel/suspend.c	2002-10-07 11:23:37.000000000 -0700
+++ swsusp-2.5.41/kernel/suspend.c	2002-10-08 06:16:54.000000000 -0700
@@ -474,9 +474,9 @@
 #ifdef CONFIG_DISCONTIGMEM
 	panic("Discontingmem not supported");
 #else
-	BUG_ON (max_mapnr != num_physpages);
+	BUG_ON (max_pfn != num_physpages);
 #endif
-	for (pfn = 0; pfn < max_mapnr; pfn++) {
+	for (pfn = 0; pfn < max_pfn; pfn++) {
 		page = pfn_to_page(pfn);
 		if (PageHighMem(page))
 			panic("Swsusp not supported on highmem boxes. Send 1GB of RAM to <pavel@ucw.cz> and try again ;-).");
diff -urN linux-2.5.41/mm/memory.c swsusp-2.5.41/mm/memory.c
--- linux-2.5.41/mm/memory.c	2002-10-07 11:24:12.000000000 -0700
+++ swsusp-2.5.41/mm/memory.c	2002-10-08 06:17:18.000000000 -0700
@@ -55,7 +55,6 @@
 
 #ifndef CONFIG_DISCONTIGMEM
 /* use the per-pgdat data instead for discontigmem - mbligh */
-unsigned long max_mapnr;
 struct page *mem_map;
 #endif
 
