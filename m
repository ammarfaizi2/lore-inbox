Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751497AbVKJB7B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497AbVKJB7B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 20:59:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751498AbVKJB7B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 20:59:01 -0500
Received: from silver.veritas.com ([143.127.12.111]:42025 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1751497AbVKJB7A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 20:59:00 -0500
Date: Thu, 10 Nov 2005 01:57:47 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
Subject: [PATCH 10/15] mm: atomic64 page counts
In-Reply-To: <Pine.LNX.4.61.0511100139550.5814@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0511100156320.5814@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511100139550.5814@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 10 Nov 2005 01:59:00.0506 (UTC) FILETIME=[5180FFA0:01C5E59A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Page count and page mapcount might overflow their 31 bits on 64-bit
architectures, especially now we're refcounting the ZERO_PAGE.  We could
quite easily avoid counting it, but shared file pages may also overflow.

Prefer not to enlarge struct page: don't assign separate atomic64_ts to
count and mapcount, instead keep them both in one atomic64_t - the count
in the low 23 bits and the mapcount in the high 41 bits.  But of course
that can only work if we don't duplicate mapcount in count in this case.

The low 23 bits can accomodate 0x7fffff, that's 2 * PID_MAX_LIMIT - 1,
which seems adequate for tasks with a transient hold on pages; and the
high 41 bits would use 16TB of page table space to back max mapcount.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

I think Nick should have a veto on this patch if he wishes, it's not my
intention to make his lockless pagecache impossible.  But I doubt he'll
have to veto it, I expect it just needs more macros: whereas page_count
carefully assembles grabcount and mapcount into the familiar page count,
he'll probably want something giving the raw atomic32 or atomic64 value.

 include/linux/mm.h   |  163 +++++++++++++++++++++++++++++++++++++--------------
 include/linux/rmap.h |   12 ---
 mm/memory.c          |    3 
 mm/rmap.c            |    9 +-
 4 files changed, 124 insertions(+), 63 deletions(-)

--- mm09/include/linux/mm.h	2005-11-09 14:38:03.000000000 +0000
+++ mm10/include/linux/mm.h	2005-11-09 14:40:00.000000000 +0000
@@ -219,11 +219,15 @@ struct inode;
 struct page {
 	unsigned long flags;		/* Atomic flags, some possibly
 					 * updated asynchronously */
+#ifdef ATOMIC64_INIT
+	atomic64_t _pcount;		/* Both _count and _mapcount. */
+#else
 	atomic_t _count;		/* Usage count, see below. */
 	atomic_t _mapcount;		/* Count of ptes mapped in mms,
 					 * to show when page is mapped
 					 * & limit reverse map searches.
 					 */
+#endif
 	unsigned long private;		/* Mapping-private opaque data:
 					 * usually used for buffer_heads
 					 * if PagePrivate set; used for
@@ -297,30 +301,112 @@ struct page {
  * macros which retain the old rules: page_count(page) == 0 is a free page.
  */
 
+#ifdef ATOMIC64_INIT
+/*
+ * We squeeze _count and _mapcount into a single atomic64 _pcount:
+ * keeping the mapcount in the upper 41 bits, and the grabcount in
+ * the lower 23 bits: then page_count is the total of these two.
+ * When adding a mapping, get_page_mapped_testone transfers one from
+ * grabcount to mapcount; which put_page_mapped_testzero reverses.
+ * Each stored count is based from 0 in this case, not from -1.
+ */
+#define PCOUNT_SHIFT	23
+#define PCOUNT_MASK	((1UL << PCOUNT_SHIFT) - 1)
+
 /*
- * Drop a ref, return true if the logical refcount fell to zero (the page has
- * no users)
+ * Drop a ref, return true if the logical refcount fell to zero
+ * (the page has no users)
  */
-#define put_page_testzero(p)				\
-	({						\
-		BUG_ON(page_count(p) == 0);		\
-		atomic_add_negative(-1, &(p)->_count);	\
-	})
+static inline int put_page_testzero(struct page *page)
+{
+	BUILD_BUG_ON(PCOUNT_MASK+1 < 2*PID_MAX_LIMIT);
+	BUG_ON(!(atomic64_read(&page->_pcount) & PCOUNT_MASK));
+	return atomic64_dec_and_test(&page->_pcount);
+}
+
+static inline int put_page_mapped_testzero(struct page *page)
+{
+	return (unsigned long)atomic64_sub_return(PCOUNT_MASK, &page->_pcount)
+							<= PCOUNT_MASK;
+}
 
 /*
  * Grab a ref, return true if the page previously had a logical refcount of
  * zero.  ie: returns true if we just grabbed an already-deemed-to-be-free page
  */
-#define get_page_testone(p)	atomic_inc_and_test(&(p)->_count)
+#define get_page_testone(page) \
+	(atomic64_add_return(1, &(page)->_pcount) == 1)
+#define get_page_mapped_testone(page) \
+	((atomic64_add_return(PCOUNT_MASK,&(page)->_pcount)>>PCOUNT_SHIFT)==1)
+
+#define set_page_count(page, val)	atomic64_set(&(page)->_pcount, val)
+#define reset_page_mapcount(page)	do { } while (0)
+#define __put_page(page)		atomic64_dec(&(page)->_pcount)
 
-#define set_page_count(p,v) 	atomic_set(&(p)->_count, v - 1)
-#define __put_page(p)		atomic_dec(&(p)->_count)
+static inline long page_count(struct page *page)
+{
+	unsigned long pcount;
 
-extern void FASTCALL(__page_cache_release(struct page *));
+	if (PageCompound(page))
+		page = (struct page *)page->private;
+	pcount = (unsigned long)atomic64_read(&page->_pcount);
+	/* Return total of grabcount and mapcount */
+	return (pcount & PCOUNT_MASK) + (pcount >> PCOUNT_SHIFT);
+}
 
-#ifdef CONFIG_HUGETLB_PAGE
+static inline void get_page(struct page *page)
+{
+	if (unlikely(PageCompound(page)))
+		page = (struct page *)page->private;
+	atomic64_inc(&page->_pcount);
+}
+
+static inline void get_page_dup_rmap(struct page *page)
+{
+	/* copy_one_pte increment mapcount */
+	atomic64_add(PCOUNT_MASK + 1, &page->_pcount);
+}
+
+static inline long page_mapcount(struct page *page)
+{
+	return (unsigned long)atomic64_read(&page->_pcount) >> PCOUNT_SHIFT;
+}
+
+static inline int page_mapped(struct page *page)
+{
+	return (unsigned long)atomic64_read(&page->_pcount) > PCOUNT_MASK;
+}
+
+#else /* !ATOMIC64_INIT */
+
+/*
+ * Drop a ref, return true if the logical refcount fell to zero
+ * (the page has no users)
+ */
+static inline int put_page_testzero(struct page *page)
+{
+	BUG_ON(atomic_read(&page->_count) == -1);
+	return atomic_add_negative(-1, &page->_count);
+}
+
+static inline int put_page_mapped_testzero(struct page *page)
+{
+	return atomic_add_negative(-1, &page->_mapcount);
+}
+
+/*
+ * Grab a ref, return true if the page previously had a logical refcount of
+ * zero.  ie: returns true if we just grabbed an already-deemed-to-be-free page
+ */
+#define get_page_testone(page)	atomic_inc_and_test(&(page)->_count)
+#define get_page_mapped_testone(page) \
+				atomic_inc_and_test(&(page)->_mapcount)
+
+#define set_page_count(page, val) 	atomic_set(&(page)->_count, val - 1)
+#define reset_page_mapcount(page)	atomic_set(&(page)->_mapcount, -1)
+#define __put_page(page)		atomic_dec(&(page)->_count)
 
-static inline int page_count(struct page *page)
+static inline long page_count(struct page *page)
 {
 	if (PageCompound(page))
 		page = (struct page *)page->private;
@@ -334,24 +420,36 @@ static inline void get_page(struct page 
 	atomic_inc(&page->_count);
 }
 
-void put_page(struct page *page);
-
-#else		/* CONFIG_HUGETLB_PAGE */
+static inline void get_page_dup_rmap(struct page *page)
+{
+	/* copy_one_pte increment total count and mapcount */
+	atomic_inc(&page->_count);
+	atomic_inc(&page->_mapcount);
+}
 
-#define page_count(p)		(atomic_read(&(p)->_count) + 1)
+static inline long page_mapcount(struct page *page)
+{
+	return atomic_read(&page->_mapcount) + 1;
+}
 
-static inline void get_page(struct page *page)
+static inline int page_mapped(struct page *page)
 {
-	atomic_inc(&page->_count);
+	return atomic_read(&page->_mapcount) >= 0;
 }
 
+#endif /* !ATOMIC64_INIT */
+
+void FASTCALL(__page_cache_release(struct page *));
+
+#ifdef CONFIG_HUGETLB_PAGE
+void put_page(struct page *page);
+#else
 static inline void put_page(struct page *page)
 {
 	if (put_page_testzero(page))
 		__page_cache_release(page);
 }
-
-#endif		/* CONFIG_HUGETLB_PAGE */
+#endif	/* !CONFIG_HUGETLB_PAGE */
 
 /*
  * Multiple processes may "see" the same page. E.g. for untouched
@@ -601,29 +699,6 @@ static inline pgoff_t page_index(struct 
 }
 
 /*
- * The atomic page->_mapcount, like _count, starts from -1:
- * so that transitions both from it and to it can be tracked,
- * using atomic_inc_and_test and atomic_add_negative(-1).
- */
-static inline void reset_page_mapcount(struct page *page)
-{
-	atomic_set(&(page)->_mapcount, -1);
-}
-
-static inline int page_mapcount(struct page *page)
-{
-	return atomic_read(&(page)->_mapcount) + 1;
-}
-
-/*
- * Return true if this page is mapped into pagetables.
- */
-static inline int page_mapped(struct page *page)
-{
-	return atomic_read(&(page)->_mapcount) >= 0;
-}
-
-/*
  * Error return values for the *_nopage functions
  */
 #define NOPAGE_SIGBUS	(NULL)
--- mm09/include/linux/rmap.h	2005-11-07 07:39:58.000000000 +0000
+++ mm10/include/linux/rmap.h	2005-11-09 14:40:00.000000000 +0000
@@ -74,18 +74,6 @@ void page_add_anon_rmap(struct page *, s
 void page_add_file_rmap(struct page *);
 void page_remove_rmap(struct page *);
 
-/**
- * page_dup_rmap - duplicate pte mapping to a page
- * @page:	the page to add the mapping to
- *
- * For copy_page_range only: minimal extract from page_add_rmap,
- * avoiding unnecessary tests (already checked) so it's quicker.
- */
-static inline void page_dup_rmap(struct page *page)
-{
-	atomic_inc(&page->_mapcount);
-}
-
 /*
  * Called from mm/vmscan.c to handle paging out
  */
--- mm09/mm/memory.c	2005-11-07 07:39:59.000000000 +0000
+++ mm10/mm/memory.c	2005-11-09 14:40:00.000000000 +0000
@@ -414,8 +414,7 @@ copy_one_pte(struct mm_struct *dst_mm, s
 	if (vm_flags & VM_SHARED)
 		pte = pte_mkclean(pte);
 	pte = pte_mkold(pte);
-	get_page(page);
-	page_dup_rmap(page);
+	get_page_dup_rmap(page);
 	rss[!!PageAnon(page)]++;
 
 out_set_pte:
--- mm09/mm/rmap.c	2005-11-09 14:38:03.000000000 +0000
+++ mm10/mm/rmap.c	2005-11-09 14:40:00.000000000 +0000
@@ -450,7 +450,7 @@ int page_referenced(struct page *page, i
 void page_add_anon_rmap(struct page *page,
 	struct vm_area_struct *vma, unsigned long address)
 {
-	if (atomic_inc_and_test(&page->_mapcount)) {
+	if (get_page_mapped_testone(page)) {
 		struct anon_vma *anon_vma = vma->anon_vma;
 
 		BUG_ON(!anon_vma);
@@ -474,8 +474,7 @@ void page_add_file_rmap(struct page *pag
 {
 	BUG_ON(PageAnon(page));
 	BUG_ON(!pfn_valid(page_to_pfn(page)));
-
-	if (atomic_inc_and_test(&page->_mapcount))
+	if (get_page_mapped_testone(page))
 		inc_page_state(nr_mapped);
 }
 
@@ -487,8 +486,8 @@ void page_add_file_rmap(struct page *pag
  */
 void page_remove_rmap(struct page *page)
 {
-	if (atomic_add_negative(-1, &page->_mapcount)) {
-		BUG_ON(page_mapcount(page) < 0);
+	BUG_ON(!page_mapcount(page));
+	if (put_page_mapped_testzero(page)) {
 		/*
 		 * It would be tidy to reset the PageAnon mapping here,
 		 * but that might overwrite a racing page_add_anon_rmap
