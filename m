Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318782AbSHRAl3>; Sat, 17 Aug 2002 20:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318786AbSHRAl2>; Sat, 17 Aug 2002 20:41:28 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:55027 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318782AbSHRAlU>;
	Sat, 17 Aug 2002 20:41:20 -0400
Message-Id: <200208180044.g7I0ilg02281@w-gaughen.beaverton.ibm.com>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
Reply-to: gone@us.ibm.com
From: Patricia Gaughen <gone@us.ibm.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] (2/4) discontigmem support for i386 against 2.4.20pre3
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_-11926932370"
Date: Sat, 17 Aug 2002 17:44:47 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_-11926932370
Content-Type: text/plain; charset=us-ascii


This patch restructures mem_init() for i386 to make it easier to
include the i386 numa changes (for CONFIG_DISCONTIGMEM) I've been 
working on.  A version of this patch is the in 2.4 aa tree.

The main thing patch does is moves the code from mem_init() that 
sets the max_mapnr and counts up and initializes the highpages, 
and counts free pages into seperate functions.  So that I can 
redefine the functions in my discontigmem patch.  Also, the code 
in paging_init() that figures out the size of the zones and calls 
free_area_init() is pulled into a separate function 
(zone_sizes_init() - this function exists in 2.5 and was written 
by someone other than me :-) so that I can redefine this function 
in the discontig case.

This patch does not depend on the other patches I'm submitting today, but 
my discontigmem patch does depend on this one.

I've tested this patch on the following configurations: UP, SMP, SMP PAE, 
multiquad, multiquad PAE.

Any and all feedback regarding this patch is greatly appreciated.

Thanks,
Pat

-- 
Patricia Gaughen (gone@us.ibm.com)
IBM Linux Technology Center
http://www.ibm.com/linux/ltc/



--==_Exmh_-11926932370
Content-Type: application/x-patch ; name="linux-2.4.20-pre3_meminit_A1.patch"
Content-Description: linux-2.4.20-pre3_meminit_A1.patch
Content-Disposition: attachment; filename="linux-2.4.20-pre3_meminit_A1.patch"

diff -Nru a/arch/i386/mm/init.c b/arch/i386/mm/init.c
--- a/arch/i386/mm/init.c	Sat Aug 17 13:35:47 2002
+++ b/arch/i386/mm/init.c	Sat Aug 17 13:35:47 2002
@@ -320,6 +320,27 @@
 	flush_tlb_all();
 }
 
+static void __init zone_sizes_init(void)
+{
+	unsigned long zones_size[MAX_NR_ZONES] = {0, 0, 0};
+	unsigned int max_dma, high, low;
+
+	max_dma = virt_to_phys((char *)MAX_DMA_ADDRESS) >> PAGE_SHIFT;
+	low = max_low_pfn;
+	high = highend_pfn;
+
+	if (low < max_dma)
+		zones_size[ZONE_DMA] = low;
+	else {
+		zones_size[ZONE_DMA] = max_dma;
+		zones_size[ZONE_NORMAL] = low - max_dma;
+#ifdef CONFIG_HIGHMEM
+		zones_size[ZONE_HIGHMEM] = high - low;
+#endif
+	}
+	free_area_init(zones_size);
+}
+
 /*
  * paging_init() sets up the page tables - note that the first 8MB are
  * already mapped by head.S.
@@ -347,26 +368,7 @@
 #ifdef CONFIG_HIGHMEM
 	kmap_init();
 #endif
-	{
-		unsigned long zones_size[MAX_NR_ZONES] = {0, 0, 0};
-		unsigned int max_dma, high, low;
-
-		max_dma = virt_to_phys((char *)MAX_DMA_ADDRESS) >> PAGE_SHIFT;
-		low = max_low_pfn;
-		high = highend_pfn;
-
-		if (low < max_dma)
-			zones_size[ZONE_DMA] = low;
-		else {
-			zones_size[ZONE_DMA] = max_dma;
-			zones_size[ZONE_NORMAL] = low - max_dma;
-#ifdef CONFIG_HIGHMEM
-			zones_size[ZONE_HIGHMEM] = high - low;
-#endif
-		}
-		free_area_init(zones_size);
-	}
-	return;
+	zone_sizes_init();
 }
 
 /*
@@ -443,62 +445,81 @@
 		return 1;
 	return 0;
 }
-	
-void __init mem_init(void)
-{
-	extern int ppro_with_ram_bug(void);
-	int codesize, reservedpages, datasize, initsize;
-	int tmp;
-	int bad_ppro;
 
-	if (!mem_map)
-		BUG();
+#ifdef CONFIG_HIGHMEM
+void __init one_highpage_init(struct page *page, int pfn, int bad_ppro)
+{
+	if (!page_is_ram(pfn)) {
+		SetPageReserved(page);
+		return;
+	}
 	
-	bad_ppro = ppro_with_ram_bug();
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
+#endif /* CONFIG_HIGHMEM */
 
+static void __init set_max_mapnr_init(void)
+{
 #ifdef CONFIG_HIGHMEM
-	highmem_start_page = mem_map + highstart_pfn;
-	max_mapnr = num_physpages = highend_pfn;
-	num_mappedpages = max_low_pfn;
+        highmem_start_page = mem_map + highstart_pfn;
+        max_mapnr = num_physpages = highend_pfn;
+        num_mappedpages = max_low_pfn;
 #else
-	max_mapnr = num_mappedpages = num_physpages = max_low_pfn;
+        max_mapnr = num_mappedpages = num_physpages = max_low_pfn;
 #endif
-	high_memory = (void *) __va(max_low_pfn * PAGE_SIZE);
+}
 
-	/* clear the zero-page */
-	memset(empty_zero_page, 0, PAGE_SIZE);
+static int __init free_pages_init(void)
+{
+	extern int ppro_with_ram_bug(void);
+	int bad_ppro, reservedpages, pfn;
+
+	bad_ppro = ppro_with_ram_bug();
 
 	/* this will put all low memory onto the freelists */
 	totalram_pages += free_all_bootmem();
 
 	reservedpages = 0;
-	for (tmp = 0; tmp < max_low_pfn; tmp++)
+	for (pfn = 0; pfn < max_low_pfn; pfn++) {
 		/*
 		 * Only count reserved RAM pages
 		 */
-		if (page_is_ram(tmp) && PageReserved(mem_map+tmp))
+		if (page_is_ram(pfn) && PageReserved(mem_map+pfn))
 			reservedpages++;
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
 	}
+#ifdef CONFIG_HIGHMEM
+	for (pfn = highend_pfn-1; pfn >= highstart_pfn; pfn--)
+		one_highpage_init((struct page *) (mem_map + pfn), pfn, bad_ppro);
 	totalram_pages += totalhigh_pages;
 #endif
+	return reservedpages;
+}
+
+void __init mem_init(void)
+{
+	int codesize, reservedpages, datasize, initsize;
+
+	if (!mem_map)
+		BUG();
+	
+	set_max_mapnr_init();
+
+	high_memory = (void *) __va(max_low_pfn * PAGE_SIZE);
+
+	/* clear the zero-page */
+	memset(empty_zero_page, 0, PAGE_SIZE);
+
+	reservedpages = free_pages_init();
+
 	codesize =  (unsigned long) &_etext - (unsigned long) &_text;
 	datasize =  (unsigned long) &_edata - (unsigned long) &_etext;
 	initsize =  (unsigned long) &__init_end - (unsigned long) &__init_begin;

--==_Exmh_-11926932370--


