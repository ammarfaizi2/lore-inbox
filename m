Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311877AbSCTRgZ>; Wed, 20 Mar 2002 12:36:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311838AbSCTRgM>; Wed, 20 Mar 2002 12:36:12 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:20177 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S311872AbSCTRfw>; Wed, 20 Mar 2002 12:35:52 -0500
Message-Id: <200203201731.g2KHVnX02678@w-gaughen.des.beaverton.ibm.com>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
Reply-to: gone@us.ibm.com
From: Patricia Gaughen <gone@us.ibm.com>
To: linux-kernel@vger.kernel.org
cc: lse-tech@lists.sourceforge.net
Subject: [RFC] modularization of i386 mem_init in 2.5.7
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 20 Mar 2002 09:31:49 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is an update to the patch I sent last week (see
http://marc.theaimsgroup.com/?l=linux-kernel&m=101562204614563&w=2 for
that post).  This patch is a port of my 2.4.17 patch.  The changes
that I've made from the 2.4.17 patch are the following:

	1) broke it into 2 patches - patch 1 (previous email) is the
setup_arch changes. patch 2 (this email) is the mem_init
changes.  These patches are can be applied independently.

Please let me know if you have any comments.

Thanks,
Pat

-- 
Patricia Gaughen (gone@us.ibm.com)
IBM Linux Technology Center

--- virgin-2.5.7/arch/i386/mm/init.c	Mon Mar 18 12:37:08 2002
+++ linux-2.5.7/arch/i386/mm/init.c	Tue Mar 19 17:49:18 2002
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




