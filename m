Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311786AbSDCVTb>; Wed, 3 Apr 2002 16:19:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312194AbSDCVTW>; Wed, 3 Apr 2002 16:19:22 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:31906 "EHLO e1.esmtp.ibm.com")
	by vger.kernel.org with ESMTP id <S311917AbSDCVTJ>;
	Wed, 3 Apr 2002 16:19:09 -0500
Message-Id: <200204032116.g33LG2c03013@w-gaughen.des.beaverton.ibm.com>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
Reply-to: gone@us.ibm.com
From: Patricia Gaughen <gone@us.ibm.com>
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] modularization of mem_init in 2.5.7
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 03 Apr 2002 13:16:02 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch reorganizes a section of code in mem_init().  This is in
preparation for a discontigmem patch for ia32 numa that I'm finishing
up and want to reusing the existing functionality where appropriate.
It also makes the code a bit more readable.

I've posted regarding this change a couple of times before as RFCs.
Here's pointers to them:

http://marc.theaimsgroup.com/?l=linux-kernel&m=101562204614563&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=101664599417808&w=2

I also posted a work in progress discontigmem patch, here's a pointer
to that email:

http://marc.theaimsgroup.com/?l=linux-kernel&m=101608052903151&w=2

Please consider this modularization of mem_init() patch for inclusion 
into the 2.5.7 tree.

Thanks,
Pat

-- 
Patricia Gaughen (gone@us.ibm.com)
IBM Linux Technology Center
http://www.ibm.com/linux/ltc/


--- virgin-2.5.7/arch/i386/mm/init.c	Mon Mar 18 12:37:08 2002
+++ linux-2.5.7-cleanup/arch/i386/mm/init.c	Wed Mar 20 13:40:31 2002
@@ -421,6 +421,49 @@
 	return 0;
 }
 	
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
+static int __init mem_init_free_pages(int bad_ppro)
+{
+	int reservedpages;
+	int tmp;
+
+	/* this will put all low memory onto the freelists */
+	totalram_pages += free_all_bootmem();
+
+	reservedpages = 0;
+	for (tmp = 0; tmp < max_low_pfn; tmp++)
+		/*
+		 * Only count reserved RAM pages
+		 */
+		if (page_is_ram(tmp) && PageReserved(mem_map+tmp))
+			reservedpages++;
+#ifdef CONFIG_HIGHMEM
+	for (tmp = highstart_pfn; tmp < highend_pfn; tmp++) {
+		init_one_highpage((struct page *) (mem_map + tmp), tmp, bad_ppro);
+	}
+	totalram_pages += totalhigh_pages;
+#endif
+	return reservedpages;
+}
+
 void __init mem_init(void)
 {
 	extern int ppro_with_ram_bug(void);
@@ -444,37 +487,8 @@
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
+	reservedpages = mem_init_free_pages(bad_ppro);
 
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


