Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315687AbSEIK27>; Thu, 9 May 2002 06:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315689AbSEIK26>; Thu, 9 May 2002 06:28:58 -0400
Received: from imladris.infradead.org ([194.205.184.45]:35599 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S315687AbSEIK24>; Thu, 9 May 2002 06:28:56 -0400
Date: Thu, 9 May 2002 11:28:42 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Patricia Gaughen <gone@us.ibm.com>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] modularization of mem_init() for 2.4.19pre8
Message-ID: <20020509112842.A11456@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Patricia Gaughen <gone@us.ibm.com>, marcelo@conectiva.com.br,
	linux-kernel@vger.kernel.org
In-Reply-To: <200205090019.g490JRB17312@w-gaughen.des.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2002 at 05:19:27PM -0700, Patricia Gaughen wrote:
> 
> Please consider this patch for inclusion into the next 2.4 release.  
> It was accepted into the 2.4.19pre6aa1, with slight modifications
> by Andrea that I have incorporated into this version of my patch.
> 
> This patch restructures the mem_init() code to make it easier to 
> include the i386 numa changes (for CONFIG_DISCONTIGMEM) I've been 
> working on.

I think I still have some cleanups (cosmetic):

 - do only one if/else test in init_one_highpage so we don't need
   additional returns and the duplicate SetPageReserved.
 - use set_page_count in init_one_highpage
 - don't cast mem_map+pfn to struct page * - it already is of that type

I'd like to second Pat's vote for getting this in the tree ASAP, btw.

--- linux-2.4.19pre8/arch/i386/mm/init.c	Tue May  7 11:54:04 2002
+++ linux-2.4.19pre8-cleanup/arch/i386/mm/init.c	Tue May  7 15:39:04 2002
@@ -444,18 +444,52 @@
 	return 0;
 }
 	
-void __init mem_init(void)
+void __init init_one_highpage(struct page *page, int pfn, int bad_ppro)
+{
+	if (page_is_ram(pfn) && !(bad_ppro && page_kills_ppro(pfn))) {
+		ClearPageReserved(page);
+		set_bit(PG_highmem, &page->flags);
+		atomic_set(&page->count, 1);
+		__free_page(page);
+		totalhigh_pages++;
+	} else
+		SetPageReserved(page);
+}
+
+static int __init mem_init_free_pages(void)
 {
 	extern int ppro_with_ram_bug(void);
+	int bad_ppro, reservedpages = 0, pfn;
+
+	bad_ppro = ppro_with_ram_bug();
+
+	/* this will put all low memory onto the freelists */
+	totalram_pages += free_all_bootmem();
+
+	for (pfn = 0; pfn < max_low_pfn; pfn++) {
+		/*
+		 * Only count reserved RAM pages
+		 */
+		if (page_is_ram(pfn) && PageReserved(mem_map+pfn))
+			reservedpages++;
+	}
+
+#ifdef CONFIG_HIGHMEM
+	for (pfn = highend_pfn-1; pfn >= highstart_pfn; pfn--)
+		init_one_highpage(mem_map+pfn, pfn, bad_ppro);
+	totalram_pages += totalhigh_pages;
+#endif
+
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
