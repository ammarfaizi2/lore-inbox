Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314420AbSDRSz5>; Thu, 18 Apr 2002 14:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314422AbSDRSz4>; Thu, 18 Apr 2002 14:55:56 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:3568 "EHLO e33.esmtp.ibm.com")
	by vger.kernel.org with ESMTP id <S314420AbSDRSzz>;
	Thu, 18 Apr 2002 14:55:55 -0400
Message-Id: <200204181851.g3IIp6O03097@w-gaughen.des.beaverton.ibm.com>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Christoph Hellwig <hch@infradead.org>, marcelo@conectiva.com.br,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] modularization of mem_init() for 2.4.19pre7 
In-Reply-To: Message from Christoph Hellwig <hch@infradead.org> 
   of "Thu, 18 Apr 2002 19:28:29 BST." <20020418192829.A14979@infradead.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 18 Apr 2002 11:51:06 -0700
From: Patricia Gaughen <gone@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  > On Thu, Apr 18, 2002 at 11:17:22AM -0700, Patricia Gaughen wrote:
  > > -void __init mem_init(void)
  > > +void __init init_one_highpage(struct page *page, int pfn, int bad_ppro)
  > > +{
  > > +	if (!page_is_ram(pfn)) {
  > > +		SetPageReserved(page);
  > > +		return;
  > > +	}
  > > +	
  > > +	if (bad_ppro && page_kills_ppro(pfn))
  > > +	{
  > > +		SetPageReserved(page);
  > > +		return;
  > > +	}
  > 
  > I'd suggest to stay with one coding style.  Prefferedly that would be
  > the one in Documentation/CodingStyle.

whoops!  thanks for catching that.

  > 
  > > +
  > > +	reservedpages = 0;
  > > +	for (pfn = 0; pfn < max_low_pfn; pfn++)
  > > +		/*
  > > +		 * Only count reserved RAM pages
  > > +		 */
  > > +		if (page_is_ram(pfn) && PageReserved(mem_map+pfn))
  > > +			reservedpages++;
  > 
  > Adding braces around this hughe loop body would make it a little
  > more readable..

I agree, new patch attached.

  > 
  > Besides these minor style nitpicks the pages look good to me.
  > 
  > BTW: Where is the NUMA code that builds ontop of this?

an out of date version of my patch is available at:

http://www-124.ibm.com/developer/opensource/linux/patches/?patch_id=320

I will be submitting the new and improved version soon.  :-) 

Thanks,
Pat


-- 
Patricia Gaughen (gone@us.ibm.com)
IBM Linux Technology Center
http://www.ibm.com/linux/ltc/

--- linux-2.4.19pre7/arch/i386/mm/init.c	Tue Apr 16 15:07:03 2002
+++ linux-2.4.19pre7-cleanup/arch/i386/mm/init.c	Thu Apr 18 11:41:10 2002
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



