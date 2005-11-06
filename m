Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932309AbVKFIUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbVKFIUG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 03:20:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932311AbVKFIUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 03:20:06 -0500
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:9301 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932309AbVKFIUC (ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Sun, 6 Nov 2005 03:20:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:Subject:References:In-Reply-To:Content-Type;
  b=wb+Ck+8pAdjzFNrV5ZY6YSV66+Ue+p8tDrVvSPkUm5XhAxd3T5Pihg3o6Y5zEyppuzdPcE4RIzyvXSoEX1VV8k8n1W70sC+MQbGOvsUgW9OBK76LWdIgYJmdyI9rBFII4gdW09KDAQwMAFnebyj7yF3RyPVNU1SolrFmp8Ln81k=  ;
Message-ID: <436DBD31.8060801@yahoo.com.au>
Date: Sun, 06 Nov 2005 19:22:09 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: [patch 4/14] mm: rmap opt
References: <436DBAC3.7090902@yahoo.com.au> <436DBCBC.5000906@yahoo.com.au> <436DBCE2.4050502@yahoo.com.au> <436DBD11.8010600@yahoo.com.au>
In-Reply-To: <436DBD11.8010600@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------070206000009070904000902"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070206000009070904000902
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

4/14

-- 
SUSE Labs, Novell Inc.


--------------070206000009070904000902
Content-Type: text/plain;
 name="mm-rmap-opt.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mm-rmap-opt.patch"

Slightly optimise rmap functions by minimising atomic operations when
we know there will be no concurrent modifications.

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
@@ -1337,14 +1337,15 @@ static int do_wp_page(struct mm_struct *
 			inc_mm_counter(mm, anon_rss);
 			dec_mm_counter(mm, file_rss);
 		}
+
 		flush_cache_page(vma, address, pfn);
 		entry = mk_pte(new_page, vma->vm_page_prot);
 		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
 		ptep_establish(vma, address, page_table, entry);
 		update_mmu_cache(vma, address, entry);
 		lazy_mmu_prot_update(entry);
+		page_add_new_anon_rmap(new_page, vma, address);
 		lru_cache_add_active(new_page);
-		page_add_anon_rmap(new_page, vma, address);
 
 		/* Free the old page.. */
 		new_page = old_page;
@@ -1796,9 +1797,8 @@ static int do_anonymous_page(struct mm_s
 		if (!pte_none(*page_table))
 			goto release;
 		inc_mm_counter(mm, anon_rss);
+		page_add_new_anon_rmap(page, vma, address);
 		lru_cache_add_active(page);
-		SetPageReferenced(page);
-		page_add_anon_rmap(page, vma, address);
 	} else {
 		/* Map the ZERO_PAGE - vm_page_prot is readonly */
 		page = ZERO_PAGE(address);
@@ -1924,11 +1924,10 @@ retry:
 		entry = mk_pte(new_page, vma->vm_page_prot);
 		if (write_access)
 			entry = maybe_mkwrite(pte_mkdirty(entry), vma);
-		set_pte_at(mm, address, page_table, entry);
 		if (anon) {
 			inc_mm_counter(mm, anon_rss);
+			page_add_new_anon_rmap(new_page, vma, address);
 			lru_cache_add_active(new_page);
-			page_add_anon_rmap(new_page, vma, address);
 		} else if (!(vma->vm_flags & VM_RESERVED)) {
 			inc_mm_counter(mm, file_rss);
 			page_add_file_rmap(new_page);
@@ -1939,6 +1938,7 @@ retry:
 		goto unlock;
 	}
 
+	set_pte_at(mm, address, page_table, entry);
 	/* no need to invalidate: a not-present page shouldn't be cached */
 	update_mmu_cache(vma, address, entry);
 	lazy_mmu_prot_update(entry);
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
+	inc_page_state(nr_mapped);
+}
+
+/**
  * page_add_anon_rmap - add pte mapping to an anonymous page
  * @page:	the page to add the mapping to
  * @vma:	the vm area in which the mapping is added
@@ -450,21 +470,28 @@ int page_referenced(struct page *page, i
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
-		inc_page_state(nr_mapped);
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
@@ -487,21 +514,28 @@ void page_add_file_rmap(struct page *pag
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
-		dec_page_state(nr_mapped);
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
+	dec_page_state(nr_mapped);
 }
 
 /*
Index: linux-2.6/include/linux/page-flags.h
===================================================================
--- linux-2.6.orig/include/linux/page-flags.h
+++ linux-2.6/include/linux/page-flags.h
@@ -182,6 +182,7 @@ extern void __mod_page_state(unsigned lo
 
 #define PageReferenced(page)	test_bit(PG_referenced, &(page)->flags)
 #define SetPageReferenced(page)	set_bit(PG_referenced, &(page)->flags)
+#define __SetPageReferenced(page)	__set_bit(PG_referenced, &(page)->flags)
 #define ClearPageReferenced(page)	clear_bit(PG_referenced, &(page)->flags)
 #define TestClearPageReferenced(page) test_and_clear_bit(PG_referenced, &(page)->flags)
 

--------------070206000009070904000902--
Send instant messages to your online friends http://au.messenger.yahoo.com 
