Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932177AbWAUMkz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbWAUMkz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 07:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbWAUMkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 07:40:55 -0500
Received: from ns1.suse.de ([195.135.220.2]:10462 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932177AbWAUMky (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 07:40:54 -0500
Date: Sat, 21 Jan 2006 13:40:53 +0100
From: Nick Piggin <npiggin@suse.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management List <linux-mm@kvack.org>
Subject: [rfc] split_page function to split higher order pages?
Message-ID: <20060121124053.GA911@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just wondering what people think of the idea of using a helper
function to split higher order pages instead of doing it manually?

The patch isn't actually for merging (because it relies on some
xtensa fixes which I'm waiting for the maintainer to comment on).

Nick

--
Have an explicit mm call to split higher order pages into individual
pages. Should help to avoid bugs and be more explicit about the code's
intention.

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/include/linux/mm.h
===================================================================
--- linux-2.6.orig/include/linux/mm.h
+++ linux-2.6/include/linux/mm.h
@@ -338,6 +338,8 @@ static inline void get_page(struct page 
 
 void put_page(struct page *page);
 
+void split_page(struct page *page, unsigned int order);
+
 /*
  * Multiple processes may "see" the same page. E.g. for untouched
  * mappings of /dev/null, all processes see the same page full of
Index: linux-2.6/mm/memory.c
===================================================================
--- linux-2.6.orig/mm/memory.c
+++ linux-2.6/mm/memory.c
@@ -1204,9 +1204,7 @@ out:
  * The page has to be a nice clean _individual_ kernel allocation.
  * If you allocate a compound page, you need to have marked it as
  * such (__GFP_COMP), or manually just split the page up yourself
- * (which is mainly an issue of doing "set_page_count(page, 1)" for
- * each sub-page, and then freeing them one by one when you free
- * them rather than freeing it as a compound page).
+ * (see split_page()).
  *
  * NOTE! Traditionally this was done with "remap_pfn_range()" which
  * took an arbitrary page protection parameter. This doesn't allow
Index: linux-2.6/mm/page_alloc.c
===================================================================
--- linux-2.6.orig/mm/page_alloc.c
+++ linux-2.6/mm/page_alloc.c
@@ -748,6 +748,23 @@ static inline void prep_zero_page(struct
 }
 
 /*
+ * split_page takes a non-compound higher-order page, and splits it into
+ * n (1<<order) sub-pages: page[0..n]
+ * Each sub-page must be freed individually.
+ */
+void split_page(struct page *page, unsigned int order)
+{
+	int i;
+
+	BUG_ON(PageCompound(page));
+	BUG_ON(!page_count(page));
+	for (i = 1; i < (1 << order); i++) {
+		BUG_ON(page_count(page + i));
+		set_page_count(page + i, 1);
+	}
+}
+
+/*
  * Really, prep_compound_page() should be called from __rmqueue_bulk().  But
  * we cheat by calling it from here, in the order > 0 path.  Saves a branch
  * or two.
Index: linux-2.6/arch/ppc/kernel/dma-mapping.c
===================================================================
--- linux-2.6.orig/arch/ppc/kernel/dma-mapping.c
+++ linux-2.6/arch/ppc/kernel/dma-mapping.c
@@ -223,6 +223,8 @@ __dma_alloc_coherent(size_t size, dma_ad
 		pte_t *pte = consistent_pte + CONSISTENT_OFFSET(vaddr);
 		struct page *end = page + (1 << order);
 
+		split_page(page, order);
+
 		/*
 		 * Set the "dma handle"
 		 */
@@ -231,7 +233,6 @@ __dma_alloc_coherent(size_t size, dma_ad
 		do {
 			BUG_ON(!pte_none(*pte));
 
-			set_page_count(page, 1);
 			SetPageReserved(page);
 			set_pte_at(&init_mm, vaddr,
 				   pte, mk_pte(page, pgprot_noncached(PAGE_KERNEL)));
@@ -244,7 +245,6 @@ __dma_alloc_coherent(size_t size, dma_ad
 		 * Free the otherwise unused pages.
 		 */
 		while (page < end) {
-			set_page_count(page, 1);
 			__free_page(page);
 			page++;
 		}
Index: linux-2.6/arch/xtensa/mm/pgtable.c
===================================================================
--- linux-2.6.orig/arch/xtensa/mm/pgtable.c
+++ linux-2.6/arch/xtensa/mm/pgtable.c
@@ -21,13 +21,9 @@ pte_t* pte_alloc_one_kernel(struct mm_st
 	p = (pte_t*) __get_free_pages(GFP_KERNEL|__GFP_REPEAT, COLOR_ORDER);
 
 	if (likely(p)) {
-		struct page *page;
+		split_page(virt_to_page(p), COLOR_ORDER);
 
 		for (i = 0; i < COLOR_SIZE; i++) {
-			page = virt_to_page(p);
-
-			set_page_count(page, 1);
-
 			if (ADDR_COLOR(p) == color)
 				pte = p;
 			else
@@ -55,9 +51,9 @@ struct page* pte_alloc_one(struct mm_str
 	p = alloc_pages(GFP_KERNEL | __GFP_REPEAT, PTE_ORDER);
 
 	if (likely(p)) {
-		for (i = 0; i < PAGE_ORDER; i++) {
-			set_page_count(p, 1);
+		split_page(p, COLOR_ORDER);
 
+		for (i = 0; i < PAGE_ORDER; i++) {
 			if (PADDR_COLOR(page_address(p)) == color)
 				page = p;
 			else
Index: linux-2.6/arch/arm/mm/consistent.c
===================================================================
--- linux-2.6.orig/arch/arm/mm/consistent.c
+++ linux-2.6/arch/arm/mm/consistent.c
@@ -223,6 +223,8 @@ __dma_alloc(struct device *dev, size_t s
 		pte = consistent_pte[idx] + off;
 		c->vm_pages = page;
 
+		split_page(page, order);
+
 		/*
 		 * Set the "dma handle"
 		 */
@@ -231,7 +233,6 @@ __dma_alloc(struct device *dev, size_t s
 		do {
 			BUG_ON(!pte_none(*pte));
 
-			set_page_count(page, 1);
 			/*
 			 * x86 does not mark the pages reserved...
 			 */
@@ -250,7 +251,6 @@ __dma_alloc(struct device *dev, size_t s
 		 * Free the otherwise unused pages.
 		 */
 		while (page < end) {
-			set_page_count(page, 1);
 			__free_page(page);
 			page++;
 		}
Index: linux-2.6/arch/frv/mm/dma-alloc.c
===================================================================
--- linux-2.6.orig/arch/frv/mm/dma-alloc.c
+++ linux-2.6/arch/frv/mm/dma-alloc.c
@@ -115,9 +115,7 @@ void *consistent_alloc(gfp_t gfp, size_t
 	 */
 	if (order > 0) {
 		struct page *rpage = virt_to_page(page);
-
-		for (i = 1; i < (1 << order); i++)
-			set_page_count(rpage + i, 1);
+		split_page(rpage, order);
 	}
 
 	err = 0;
Index: linux-2.6/arch/sh/mm/consistent.c
===================================================================
--- linux-2.6.orig/arch/sh/mm/consistent.c
+++ linux-2.6/arch/sh/mm/consistent.c
@@ -23,6 +23,7 @@ void *consistent_alloc(gfp_t gfp, size_t
 	page = alloc_pages(gfp, order);
 	if (!page)
 		return NULL;
+	split_page(page, order);
 
 	ret = page_address(page);
 	*handle = virt_to_phys(ret);
@@ -37,8 +38,6 @@ void *consistent_alloc(gfp_t gfp, size_t
 	end  = page + (1 << order);
 
 	while (++page < end) {
-		set_page_count(page, 1);
-
 		/* Free any unused pages */
 		if (page >= free) {
 			__free_page(page);
