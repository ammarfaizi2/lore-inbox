Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314402AbSDRSWp>; Thu, 18 Apr 2002 14:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314403AbSDRSWo>; Thu, 18 Apr 2002 14:22:44 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:62948 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S314402AbSDRSWl>; Thu, 18 Apr 2002 14:22:41 -0400
Message-Id: <200204181817.g3IIHMM02913@w-gaughen.des.beaverton.ibm.com>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
Reply-to: gone@us.ibm.com
From: Patricia Gaughen <gone@us.ibm.com>
To: marcelo@conectiva.com.br
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] modularization of mem_init() for 2.4.19pre7
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 18 Apr 2002 11:17:22 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please consider this patch for inclusion into the next 2.4 release.  
It was accepted into the 2.4.19pre6aa1, with slight modifications
by Andrea that I have incorporated into this version of my patch.

This patch restructures the mem_init() code to make it easier to 
include the i386 numa changes (for CONFIG_DISCONTIGMEM) I've been 
working on.

I'm also submitting a patch for setup_arch(), the two patches do not 
depend on each other, but my discontigmem patches (which I'll be 
sending out at the start of next week) do depend on both.

Previous postings regarding this patch are available at:

http://marc.theaimsgroup.com/?l=linux-kernel&m=101562204614563&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=101664599417808&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=101565828617899&w=2

I've booted with the patches on the following systems:

UP system
4 Proc SMP system
8 Proc NUMA system

Thanks,
Pat


-- 
Patricia Gaughen (gone@us.ibm.com)
IBM Linux Technology Center
http://www.ibm.com/linux/ltc/

--- linux-2.4.19pre7/arch/i386/mm/init.c	Tue Apr 16 15:07:03 2002
+++ linux-2.4.19pre7-cleanup/arch/i386/mm/init.c	Tue Apr 16 16:31:46 2002
@@ -444,18 +444,57 @@
 	return 0;
 }
 	
-void __init mem_init(void)
+void __init init_one_highpage(struct page *page, int pfn, int bad_ppro)
+{
+	if (!page_is_ram(pfn)) {
+		SetPageReserved(page);
+		return;
+	}
+	
+	if (bad_ppro && page_kills_ppro(pfn))
+	{
+		SetPageReserved(page);
+		return;
+	}
+	ClearPageReserved(page);
+	set_bit(PG_highmem, &page->flags);
+	atomic_set(&page->count, 1);
+	__free_page(page);
+	totalhigh_pages++;
+}
+
+static int __init mem_init_free_pages(void)
 {
 	extern int ppro_with_ram_bug(void);
+	int bad_ppro, reservedpages, pfn;
+
+	bad_ppro = ppro_with_ram_bug();
+
+	/* this will put all low memory onto the freelists */
+	totalram_pages += free_all_bootmem();
+
+	reservedpages = 0;
+	for (pfn = 0; pfn < max_low_pfn; pfn++)
+		/*
+		 * Only count reserved RAM pages
+		 */
+		if (page_is_ram(pfn) && PageReserved(mem_map+pfn))
+			reservedpages++;
+#ifdef CONFIG_HIGHMEM
+	for (pfn = highend_pfn-1; pfn >= highstart_pfn; pfn--)
+		init_one_highpage((struct page *) (mem_map + pfn), pfn, bad_ppro);
+	totalram_pages += totalhigh_pages;
+#endif
+	return reservedpages;
+}
+
+void __init mem_init(void)
+{
 	int codesize, reservedpages, datasize, initsize;
-	int tmp;
-	int bad_ppro;
 
 	if (!mem_map)
 		BUG();
 	
-	bad_ppro = ppro_with_ram_bug();
-
 #ifdef CONFIG_HIGHMEM
 	highmem_start_page = mem_map + highstart_pfn;
 	max_mapnr = num_physpages = highend_pfn;
@@ -468,37 +507,8 @@
 	/* clear the zero-page */
 	memset(empty_zero_page, 0, PAGE_SIZE);
 
-	/* this will put all low memory onto the freelists */
-	totalram_pages += free_all_bootmem();
+ 	reservedpages = mem_init_free_pages();
 
-	reservedpages = 0;
-	for (tmp = 0; tmp < max_low_pfn; tmp++)
-		/*
-		 * Only count reserved RAM pages
-		 */
-		if (page_is_ram(tmp) && PageReserved(mem_map+tmp))
-			reservedpages++;
-#ifdef CONFIG_HIGHMEM
-	for (tmp = highstart_pfn; tmp < highend_pfn; tmp++) {
-		struct page *page = mem_map + tmp;
-
-		if (!page_is_ram(tmp)) {
-			SetPageReserved(page);
-			continue;
-		}
-		if (bad_ppro && page_kills_ppro(tmp))
-		{
-			SetPageReserved(page);
-			continue;
-		}
-		ClearPageReserved(page);
-		set_bit(PG_highmem, &page->flags);
-		atomic_set(&page->count, 1);
-		__free_page(page);
-		totalhigh_pages++;
-	}
-	totalram_pages += totalhigh_pages;
-#endif
 	codesize =  (unsigned long) &_etext - (unsigned long) &_text;
 	datasize =  (unsigned long) &_edata - (unsigned long) &_etext;
 	initsize =  (unsigned long) &__init_end - (unsigned long) &__init_begin;



