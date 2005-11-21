Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932273AbVKUMAx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbVKUMAx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 07:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932274AbVKUMAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 07:00:53 -0500
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:36276 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932273AbVKUMAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 07:00:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:From:To:Cc:Message-Id:In-Reply-To:References:Subject;
  b=JQFjXkDUDKwSLINIUQJ43yt76aJ6HlRhOs6TLjZHe4UIq0mZ+cPOfmpaTEs10JASQ8uQknz2uOWnmSpEjv6UnVgw0OjwTNHFtvn/PheYyrhyxjR+kFEs0owk5IWrBH1KmDFBJjAhYOU5fRcSTC9LnbdqwzJJw0Iud6HVY96inEw=  ;
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: linux-kernel@vger.kernel.org
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>
Message-Id: <20051121124146.14370.98764.sendpatchset@didi.local0.net>
In-Reply-To: <20051121123906.14370.3039.sendpatchset@didi.local0.net>
References: <20051121123906.14370.3039.sendpatchset@didi.local0.net>
Subject: [patch 7/12] mm: bad_page opt
Date: Mon, 21 Nov 2005 07:00:52 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cut down size slightly by not passing bad_page the function name (it should
be able to be determined by dump_stack()). And cut down the number of printks
in bad_page.

Also, cut down some branching in the destroy_compound_page path.

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/mm/page_alloc.c
===================================================================
--- linux-2.6.orig/mm/page_alloc.c
+++ linux-2.6/mm/page_alloc.c
@@ -130,16 +130,15 @@ static inline int bad_range(struct zone 
 }
 #endif
 
-static void bad_page(const char *function, struct page *page)
+static void bad_page(struct page *page)
 {
-	printk(KERN_EMERG "Bad page state at %s (in process '%s', page %p)\n",
-		function, current->comm, page);
-	printk(KERN_EMERG "flags:0x%0*lx mapping:%p mapcount:%d count:%d\n",
-		(int)(2*sizeof(unsigned long)), (unsigned long)page->flags,
-		page->mapping, page_mapcount(page), page_count(page));
-	printk(KERN_EMERG "Backtrace:\n");
+	printk(KERN_EMERG "Bad page state in process '%s'\n"
+		"page:%p flags:0x%0*lx mapping:%p mapcount:%d count:%d\n"
+		"Trying to fix it up, but a reboot is needed\n",
+		current->comm, page, (int)(2*sizeof(unsigned long)),
+		(unsigned long)page->flags, page->mapping,
+		page_mapcount(page), page_count(page));
 	dump_stack();
-	printk(KERN_EMERG "Trying to fix it up, but a reboot is needed\n");
 	page->flags &= ~(1 << PG_lru	|
 			1 << PG_private |
 			1 << PG_locked	|
@@ -197,19 +196,15 @@ static void destroy_compound_page(struct
 	int i;
 	int nr_pages = 1 << order;
 
-	if (!PageCompound(page))
-		return;
-
-	if (page[1].index != order)
-		bad_page(__FUNCTION__, page);
+	if (unlikely(page[1].index != order))
+		bad_page(page);
 
 	for (i = 0; i < nr_pages; i++) {
 		struct page *p = page + i;
 
-		if (!PageCompound(p))
-			bad_page(__FUNCTION__, page);
-		if (page_private(p) != (unsigned long)page)
-			bad_page(__FUNCTION__, page);
+		if (unlikely(!PageCompound(p) |
+				(page_private(p) != (unsigned long)page)))
+			bad_page(page);
 		ClearPageCompound(p);
 	}
 }
@@ -320,7 +315,7 @@ static inline void __free_pages_bulk (st
 	unsigned long page_idx;
 	int order_size = 1 << order;
 
-	if (unlikely(order))
+	if (unlikely(PageCompound(page)))
 		destroy_compound_page(page, order);
 
 	page_idx = page_to_pfn(page) & ((1 << MAX_ORDER) - 1);
@@ -352,7 +347,7 @@ static inline void __free_pages_bulk (st
 	zone->free_area[order].nr_free++;
 }
 
-static inline void free_pages_check(const char *function, struct page *page)
+static inline void free_pages_check(struct page *page)
 {
 	if (unlikely(page_mapcount(page) |
 		(page->mapping != NULL)  |
@@ -367,7 +362,7 @@ static inline void free_pages_check(cons
 			1 << PG_swapcache |
 			1 << PG_writeback |
 			1 << PG_reserved ))))
-		bad_page(function, page);
+		bad_page(page);
 	if (PageDirty(page))
 		__ClearPageDirty(page);
 }
@@ -421,7 +416,7 @@ void __free_pages_ok(struct page *page, 
 #endif
 
 	for (i = 0 ; i < (1 << order) ; ++i)
-		free_pages_check(__FUNCTION__, page + i);
+		free_pages_check(page + i);
 	list_add(&page->lru, &list);
 	kernel_map_pages(page, 1<<order, 0);
 	local_irq_save(flags);
@@ -481,7 +476,7 @@ static void prep_new_page(struct page *p
 			1 << PG_swapcache |
 			1 << PG_writeback |
 			1 << PG_reserved ))))
-		bad_page(__FUNCTION__, page);
+		bad_page(page);
 
 	page->flags &= ~(1 << PG_uptodate | 1 << PG_error |
 			1 << PG_referenced | 1 << PG_arch_1 |
@@ -677,7 +672,7 @@ static void fastcall free_hot_cold_page(
 	inc_page_state(pgfree);
 	if (PageAnon(page))
 		page->mapping = NULL;
-	free_pages_check(__FUNCTION__, page);
+	free_pages_check(page);
 	pcp = &zone_pcp(zone, get_cpu())->pcp[cold];
 	local_irq_save(flags);
 	list_add(&page->lru, &pcp->list);
Send instant messages to your online friends http://au.messenger.yahoo.com 
