Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318969AbSHFDOx>; Mon, 5 Aug 2002 23:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318971AbSHFDOx>; Mon, 5 Aug 2002 23:14:53 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:49103 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318969AbSHFDOs>;
	Mon, 5 Aug 2002 23:14:48 -0400
Message-Id: <200208060317.g763Hx825104@w-gaughen.beaverton.ibm.com>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
Reply-to: gone@us.ibm.com
From: Patricia Gaughen <gone@us.ibm.com>
To: marcelo@conectiva.com.br
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] modularization of mem_init() for 2.4.20pre1
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_-19820764880"
Date: Mon, 05 Aug 2002 20:17:59 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_-19820764880
Content-Type: text/plain; charset=us-ascii


Please consider this patch for inclusion into the 2.4.20pre tree.
It was accepted into the 2.4.19pre6aa1, with slight modifications 
by Andrea that I have incorporated those changes into my patch.  
This patch, along with the modularization of setup_arch, and the 
{node,zone}_start_paddr to {node,zone}_start_pfn change, are the
patches that my i386 discontigmem patch depends on.

This patch restructures mem_init() for i386 to make it easier to
include the i386 numa changes (for CONFIG_DISCONTIGMEM) I've been 
working on.  It also makes mem_init() easier to read.  

This patch does not depend on the other patches I'm submitting today, but 
my discontigmem patch does depend on this one. 

I've tested this patch on the following configurations: UP, SMP, SMP PAE, 
multiquad, multiquad PAE, multiquad DISCONTIGMEM, multiquad DISCONTIGMEM PAE.

Any and all feedback regarding this patch is greatly appreciated.

Thanks,
Pat

-- 
Patricia Gaughen (gone@us.ibm.com)
IBM Linux Technology Center
http://www.ibm.com/linux/ltc/



--==_Exmh_-19820764880
Content-Type: application/x-patch ; name="linux-2.4.20-pre1_meminit_A2.patch"
Content-Description: linux-2.4.20-pre1_meminit_A2.patch
Content-Disposition: attachment; filename="linux-2.4.20-pre1_meminit_A2.patch"

diff -Nru a/arch/i386/mm/init.c b/arch/i386/mm/init.c
--- a/arch/i386/mm/init.c	Mon Aug  5 18:17:32 2002
+++ b/arch/i386/mm/init.c	Mon Aug  5 18:17:32 2002
@@ -444,18 +444,58 @@
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
+	if (bad_ppro && page_kills_ppro(pfn)) {
+		SetPageReserved(page);
+		return;
+	}
+	
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
+	for (pfn = 0; pfn < max_low_pfn; pfn++) {
+		/*
+		 * Only count reserved RAM pages
+		 */
+		if (page_is_ram(pfn) && PageReserved(mem_map+pfn))
+			reservedpages++;
+	}
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
@@ -468,37 +508,8 @@
 	/* clear the zero-page */
 	memset(empty_zero_page, 0, PAGE_SIZE);
 
-	/* this will put all low memory onto the freelists */
-	totalram_pages += free_all_bootmem();
+	reservedpages = mem_init_free_pages();
 
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

--==_Exmh_-19820764880--


