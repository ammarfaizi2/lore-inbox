Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315260AbSHFSf6>; Tue, 6 Aug 2002 14:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315267AbSHFSf6>; Tue, 6 Aug 2002 14:35:58 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:29628 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S315260AbSHFSfz>;
	Tue, 6 Aug 2002 14:35:55 -0400
Message-Id: <200208061838.g76IcX603152@w-gaughen.beaverton.ibm.com>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] modularization of mem_init() for 2.4.20pre1 
In-Reply-To: Message from Marcelo Tosatti <marcelo@conectiva.com.br> 
   of "Tue, 06 Aug 2002 12:58:57 -0300." <Pine.LNX.4.44.0208061258200.7534-100000@freak.distro.conectiva> 
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_-8135218880"
Date: Tue, 06 Aug 2002 11:38:33 -0700
From: Patricia Gaughen <gone@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_-8135218880
Content-Type: text/plain; charset=us-ascii


  > It looks ok but what about surrounding init_one_highpage with
  > CONFIG_HIGHMEM?
  > 

Here's the updated patch.

Thanks,
Pat

-- 
Patricia Gaughen (gone@us.ibm.com)
IBM Linux Technology Center
http://www.ibm.com/linux/ltc/


--==_Exmh_-8135218880
Content-Type: application/x-patch ; name="linux-2.4.20-pre1_meminit_A3.patch"
Content-Description: linux-2.4.20-pre1_meminit_A3.patch
Content-Disposition: attachment; filename="linux-2.4.20-pre1_meminit_A3.patch"

diff -Nru a/arch/i386/mm/init.c b/arch/i386/mm/init.c
--- a/arch/i386/mm/init.c	Tue Aug  6 11:14:22 2002
+++ b/arch/i386/mm/init.c	Tue Aug  6 11:14:22 2002
@@ -443,19 +443,61 @@
 		return 1;
 	return 0;
 }
+
+#ifdef CONFIG_HIGHMEM
+void __init init_one_highpage(struct page *page, int pfn, int bad_ppro)
+{
+	if (!page_is_ram(pfn)) {
+		SetPageReserved(page);
+		return;
+	}
 	
-void __init mem_init(void)
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
@@ -468,37 +510,8 @@
 	/* clear the zero-page */
 	memset(empty_zero_page, 0, PAGE_SIZE);
 
-	/* this will put all low memory onto the freelists */
-	totalram_pages += free_all_bootmem();
-
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
+	reservedpages = mem_init_free_pages();
 
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

--==_Exmh_-8135218880--


