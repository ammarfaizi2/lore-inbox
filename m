Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932283AbVKUMIk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbVKUMIk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 07:08:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932276AbVKUMIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 07:08:39 -0500
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:1935 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932283AbVKUMIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 07:08:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:From:To:Cc:Message-Id:In-Reply-To:References:Subject;
  b=V8CQHZfPNEsGwS+VUUU/dRptEt88IoRZQfj6de6jMg4nP6edcODukbgwjyFONAMTtxTwqurvrFFJMmNIoEnuj1h9KS3WN6+XpTlmyjTEeYAA4AUKvtYG4MYHgCEdXCZkjYvsUWcBlECMx29v0bAiEScFrtd1m58eX/7nkSjklqw=  ;
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: linux-kernel@vger.kernel.org
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>
Message-Id: <20051121124421.14370.52413.sendpatchset@didi.local0.net>
In-Reply-To: <20051121123906.14370.3039.sendpatchset@didi.local0.net>
References: <20051121123906.14370.3039.sendpatchset@didi.local0.net>
Subject: [patch 12/12] mm: rmap opt
Date: Mon, 21 Nov 2005 07:08:38 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Optimise rmap functions by minimising atomic operations when
we know there will be no concurrent modifications.

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/include/linux/rmap.h
===================================================================
--- linux-2.6.orig/include/linux/rmap.h
+++ linux-2.6/include/linux/rmap.h
@@ -71,6 +71,7 @@ void __anon_vma_link(struct vm_area_stru
  * rmap interfaces called when adding or removing pte of page
  */
 void page_add_anon_rmap(struct page *, struct vm_area_struct *, unsigned long);
+void page_add_new_anon_rmap(struct page *, struct vm_area_struct *, unsigned long);
 void page_add_file_rmap(struct page *);
 void page_remove_rmap(struct page *);
 
Index: linux-2.6/mm/memory.c
===================================================================
--- linux-2.6.orig/mm/memory.c
+++ linux-2.6/mm/memory.c
@@ -1339,7 +1339,7 @@ static int do_wp_page(struct mm_struct *
 		update_mmu_cache(vma, address, entry);
 		lazy_mmu_prot_update(entry);
 		lru_cache_add_active(new_page);
-		page_add_anon_rmap(new_page, vma, address);
+		page_add_new_anon_rmap(new_page, vma, address);
 
 		/* Free the old page.. */
 		new_page = old_page;
@@ -1792,8 +1792,7 @@ static int do_anonymous_page(struct mm_s
 			goto release;
 		inc_mm_counter(mm, anon_rss);
 		lru_cache_add_active(page);
-		SetPageReferenced(page);
-		page_add_anon_rmap(page, vma, address);
+		page_add_new_anon_rmap(page, vma, address);
 	} else {
 		/* Map the ZERO_PAGE - vm_page_prot is readonly */
 		page = ZERO_PAGE(address);
@@ -1923,7 +1922,7 @@ retry:
 		if (anon) {
 			inc_mm_counter(mm, anon_rss);
 			lru_cache_add_active(new_page);
-			page_add_anon_rmap(new_page, vma, address);
+			page_add_new_anon_rmap(new_page, vma, address);
 		} else if (!(vma->vm_flags & VM_RESERVED)) {
 			inc_mm_counter(mm, file_rss);
 			page_add_file_rmap(new_page);
Index: linux-2.6/mm/rmap.c
===================================================================
--- linux-2.6.orig/mm/rmap.c
+++ linux-2.6/mm/rmap.c
@@ -440,6 +440,26 @@ int page_referenced(struct page *page, i
 }
 
 /**
+ * page_set_anon_rmap - setup new anonymous rmap
+ * @page:	the page to add the mapping to
+ * @vma:	the vm area in which the mapping is added
+ * @address:	the user virtual address mapped
+ */
+static void __page_set_anon_rmap(struct page *page,
+	struct vm_area_struct *vma, unsigned long address)
+{
+	struct anon_vma *anon_vma = vma->anon_vma;
+
+	BUG_ON(!anon_vma);
+	anon_vma = (void *) anon_vma + PAGE_MAPPING_ANON;
+	page->mapping = (struct address_space *) anon_vma;
+
+	page->index = linear_page_index(vma, address);
+
+	__inc_page_state(nr_mapped);
+}
+
+/**
  * page_add_anon_rmap - add pte mapping to an anonymous page
  * @page:	the page to add the mapping to
  * @vma:	the vm area in which the mapping is added
@@ -450,25 +470,28 @@ int page_referenced(struct page *page, i
 void page_add_anon_rmap(struct page *page,
 	struct vm_area_struct *vma, unsigned long address)
 {
-	if (atomic_inc_and_test(&page->_mapcount)) {
-		struct anon_vma *anon_vma = vma->anon_vma;
-
-		BUG_ON(!anon_vma);
-		anon_vma = (void *) anon_vma + PAGE_MAPPING_ANON;
-		page->mapping = (struct address_space *) anon_vma;
-
-		page->index = linear_page_index(vma, address);
-
-		/*
-		 * nr_mapped state can be updated without turning off
-		 * interrupts because it is not modified via interrupt.
-		 */
-		__inc_page_state(nr_mapped);
-	}
+	if (atomic_inc_and_test(&page->_mapcount))
+		__page_set_anon_rmap(page, vma, address);
 	/* else checking page index and mapping is racy */
 }
 
 /**
+ * page_add_new_anon_rmap - add pte mapping to a new anonymous page
+ * @page:	the page to add the mapping to
+ * @vma:	the vm area in which the mapping is added
+ * @address:	the user virtual address mapped
+ *
+ * same as page_add_anon_rmap but must only be called on *new* pages.
+ */
+void page_add_new_anon_rmap(struct page *page,
+	struct vm_area_struct *vma, unsigned long address)
+{
+	atomic_set(&page->_mapcount, 0); /* elevate count by 1 (starts at -1) */
+	__page_set_anon_rmap(page, vma, address);
+}
+
+
+/**
  * page_add_file_rmap - add pte mapping to a file page
  * @page: the page to add the mapping to
  *
@@ -491,21 +514,28 @@ void page_add_file_rmap(struct page *pag
  */
 void page_remove_rmap(struct page *page)
 {
-	if (atomic_add_negative(-1, &page->_mapcount)) {
+	int fast = (page_mapcount(page) == 1) &
+			PageAnon(page) & (!PageSwapCache(page));
+
+	/* fast page may become SwapCache here, but nothing new will map it. */
+	if (fast)
+		reset_page_mapcount(page);
+	else if (atomic_add_negative(-1, &page->_mapcount))
 		BUG_ON(page_mapcount(page) < 0);
-		/*
-		 * It would be tidy to reset the PageAnon mapping here,
-		 * but that might overwrite a racing page_add_anon_rmap
-		 * which increments mapcount after us but sets mapping
-		 * before us: so leave the reset to free_hot_cold_page,
-		 * and remember that it's only reliable while mapped.
-		 * Leaving it set also helps swapoff to reinstate ptes
-		 * faster for those pages still in swapcache.
-		 */
 		if (page_test_and_clear_dirty(page))
 			set_page_dirty(page);
-		__dec_page_state(nr_mapped);
-	}
+	else
+		return; /* non zero mapcount */
+	/*
+	 * It would be tidy to reset the PageAnon mapping here,
+	 * but that might overwrite a racing page_add_anon_rmap
+	 * which increments mapcount after us but sets mapping
+	 * before us: so leave the reset to free_hot_cold_page,
+	 * and remember that it's only reliable while mapped.
+	 * Leaving it set also helps swapoff to reinstate ptes
+	 * faster for those pages still in swapcache.
+	 */
+	__dec_page_state(nr_mapped);
 }
 
 /*
Index: linux-2.6/include/linux/page-flags.h
===================================================================
--- linux-2.6.orig/include/linux/page-flags.h
+++ linux-2.6/include/linux/page-flags.h
@@ -203,6 +203,7 @@ extern void __mod_page_state_offset(unsi
 
 #define PageReferenced(page)	test_bit(PG_referenced, &(page)->flags)
 #define SetPageReferenced(page)	set_bit(PG_referenced, &(page)->flags)
+#define __SetPageReferenced(page)	__set_bit(PG_referenced, &(page)->flags)
 #define ClearPageReferenced(page)	clear_bit(PG_referenced, &(page)->flags)
 #define TestClearPageReferenced(page) test_and_clear_bit(PG_referenced, &(page)->flags)
 
Send instant messages to your online friends http://au.messenger.yahoo.com 
