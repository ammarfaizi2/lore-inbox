Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751445AbWILPwB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbWILPwB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 11:52:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbWILPvj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 11:51:39 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:51404 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S1751439AbWILPvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 11:51:03 -0400
Message-Id: <20060912144903.411063000@chello.nl>
References: <20060912143049.278065000@chello.nl>
User-Agent: quilt/0.45-1
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       David Miller <davem@davemloft.net>, Rik van Riel <riel@redhat.com>,
       Daniel Phillips <phillips@google.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: [PATCH 04/20] mm: methods for teaching filesystems about PG_swapcache pages
Content-Disposition: inline; filename=page_file_methods.patch
Date: Tue, 12 Sep 2006 17:25:49 +0200
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In order to teach filesystems to handle swap cache pages, two new page
functions are introduced:

  pgoff_t page_file_index(struct page *);
  struct address_space *page_file_mapping(struct page *);

page_file_index - gives the offset of this page in the file in PAGE_CACHE_SIZE
blocks. Like page->index is for mapped pages, this function also gives the
correct index for PG_swapcache pages.

page_file_mapping - gives the mapping backing the actual page; that is for
swap cache pages it will give swap_file->f_mapping.

page_offset() is modified to use page_file_index(), so that it will give the
expected result, even for PG_swapcache pages.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
CC: Trond Myklebust <trond.myklebust@fys.uio.no>
---
 include/linux/mm.h      |   30 ++++++++++++++++++++++++++++++
 include/linux/pagemap.h |    2 +-
 include/linux/swap.h    |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/swapops.h |   44 --------------------------------------------
 4 files changed, 79 insertions(+), 45 deletions(-)

Index: linux-2.6/include/linux/mm.h
===================================================================
--- linux-2.6.orig/include/linux/mm.h
+++ linux-2.6/include/linux/mm.h
@@ -15,6 +15,7 @@
 #include <linux/fs.h>
 #include <linux/mutex.h>
 #include <linux/debug_locks.h>
+#include <linux/swap.h>
 
 struct mempolicy;
 struct anon_vma;
@@ -579,6 +580,22 @@ static inline struct address_space *page
 	return mapping;
 }
 
+static inline
+struct swap_info_struct * page_swap_info(struct page *page)
+{
+	swp_entry_t swap = { .val = page_private(page) };
+	BUG_ON(!PageSwapCache(page));
+	return get_swap_info_struct(swp_type(swap));
+}
+
+static inline
+struct address_space *page_file_mapping(struct page *page)
+{
+	if (unlikely(PageSwapCache(page)))
+		return page_swap_info(page)->swap_file->f_mapping;
+	return page->mapping;
+}
+
 static inline int PageAnon(struct page *page)
 {
 	return ((unsigned long)page->mapping & PAGE_MAPPING_ANON) != 0;
@@ -596,6 +613,19 @@ static inline pgoff_t page_index(struct 
 }
 
 /*
+ * Return the file index of the page. Regular pagecache pages use ->index
+ * whereas swapcache pages use swp_offset(->private)
+ */
+static inline pgoff_t page_file_index(struct page *page)
+{
+	if (unlikely(PageSwapCache(page))) {
+		swp_entry_t swap = { .val = page_private(page) };
+		return swp_offset(swap);
+	}
+	return page->index;
+}
+
+/*
  * The atomic page->_mapcount, like _count, starts from -1:
  * so that transitions both from it and to it can be tracked,
  * using atomic_inc_and_test and atomic_add_negative(-1).
Index: linux-2.6/include/linux/pagemap.h
===================================================================
--- linux-2.6.orig/include/linux/pagemap.h
+++ linux-2.6/include/linux/pagemap.h
@@ -118,7 +118,7 @@ extern void __remove_from_page_cache(str
  */
 static inline loff_t page_offset(struct page *page)
 {
-	return ((loff_t)page->index) << PAGE_CACHE_SHIFT;
+	return ((loff_t)page_file_index(page)) << PAGE_CACHE_SHIFT;
 }
 
 static inline pgoff_t linear_page_index(struct vm_area_struct *vma,
Index: linux-2.6/include/linux/swap.h
===================================================================
--- linux-2.6.orig/include/linux/swap.h
+++ linux-2.6/include/linux/swap.h
@@ -75,6 +75,50 @@ typedef struct {
 } swp_entry_t;
 
 /*
+ * swapcache pages are stored in the swapper_space radix tree.  We want to
+ * get good packing density in that tree, so the index should be dense in
+ * the low-order bits.
+ *
+ * We arrange the `type' and `offset' fields so that `type' is at the five
+ * high-order bits of the swp_entry_t and `offset' is right-aligned in the
+ * remaining bits.
+ *
+ * swp_entry_t's are *never* stored anywhere in their arch-dependent format.
+ */
+#define SWP_TYPE_SHIFT(e)	(sizeof(e.val) * 8 - MAX_SWAPFILES_SHIFT)
+#define SWP_OFFSET_MASK(e)	((1UL << SWP_TYPE_SHIFT(e)) - 1)
+
+/*
+ * Store a type+offset into a swp_entry_t in an arch-independent format
+ */
+static inline swp_entry_t swp_entry(unsigned long type, pgoff_t offset)
+{
+	swp_entry_t ret;
+
+	ret.val = (type << SWP_TYPE_SHIFT(ret)) |
+			(offset & SWP_OFFSET_MASK(ret));
+	return ret;
+}
+
+/*
+ * Extract the `type' field from a swp_entry_t.  The swp_entry_t is in
+ * arch-independent format
+ */
+static inline unsigned swp_type(swp_entry_t entry)
+{
+	return (entry.val >> SWP_TYPE_SHIFT(entry));
+}
+
+/*
+ * Extract the `offset' field from a swp_entry_t.  The swp_entry_t is in
+ * arch-independent format
+ */
+static inline pgoff_t swp_offset(swp_entry_t entry)
+{
+	return entry.val & SWP_OFFSET_MASK(entry);
+}
+
+/*
  * current->reclaim_state points to one of these when a task is running
  * memory reclaim
  */
@@ -322,6 +366,10 @@ static inline int valid_swaphandles(swp_
 	return 0;
 }
 
+static inline struct swap_info_struct *get_swap_info_struct(unsigned type)
+{
+	return NULL;
+}
 #define can_share_swap_page(p)			(page_mapcount(p) == 1)
 
 static inline int move_to_swap_cache(struct page *page, swp_entry_t entry)
Index: linux-2.6/include/linux/swapops.h
===================================================================
--- linux-2.6.orig/include/linux/swapops.h
+++ linux-2.6/include/linux/swapops.h
@@ -1,48 +1,4 @@
 /*
- * swapcache pages are stored in the swapper_space radix tree.  We want to
- * get good packing density in that tree, so the index should be dense in
- * the low-order bits.
- *
- * We arrange the `type' and `offset' fields so that `type' is at the five
- * high-order bits of the swp_entry_t and `offset' is right-aligned in the
- * remaining bits.
- *
- * swp_entry_t's are *never* stored anywhere in their arch-dependent format.
- */
-#define SWP_TYPE_SHIFT(e)	(sizeof(e.val) * 8 - MAX_SWAPFILES_SHIFT)
-#define SWP_OFFSET_MASK(e)	((1UL << SWP_TYPE_SHIFT(e)) - 1)
-
-/*
- * Store a type+offset into a swp_entry_t in an arch-independent format
- */
-static inline swp_entry_t swp_entry(unsigned long type, pgoff_t offset)
-{
-	swp_entry_t ret;
-
-	ret.val = (type << SWP_TYPE_SHIFT(ret)) |
-			(offset & SWP_OFFSET_MASK(ret));
-	return ret;
-}
-
-/*
- * Extract the `type' field from a swp_entry_t.  The swp_entry_t is in
- * arch-independent format
- */
-static inline unsigned swp_type(swp_entry_t entry)
-{
-	return (entry.val >> SWP_TYPE_SHIFT(entry));
-}
-
-/*
- * Extract the `offset' field from a swp_entry_t.  The swp_entry_t is in
- * arch-independent format
- */
-static inline pgoff_t swp_offset(swp_entry_t entry)
-{
-	return entry.val & SWP_OFFSET_MASK(entry);
-}
-
-/*
  * Convert the arch-dependent pte representation of a swp_entry_t into an
  * arch-independent swp_entry_t.
  */

--

