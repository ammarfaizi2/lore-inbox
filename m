Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751380AbVKJBo0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbVKJBo0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 20:44:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbVKJBo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 20:44:26 -0500
Received: from silver.veritas.com ([143.127.12.111]:42279 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1751380AbVKJBoZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 20:44:25 -0500
Date: Thu, 10 Nov 2005 01:43:14 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 01/15] mm: poison struct page for ptlock
In-Reply-To: <Pine.LNX.4.61.0511100139550.5814@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0511100142160.5814@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511100139550.5814@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 10 Nov 2005 01:44:25.0229 (UTC) FILETIME=[47CC53D0:01C5E598]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The split ptlock patch enlarged the default SMP PREEMPT struct page from
32 to 36 bytes on most 32-bit platforms, from 32 to 44 bytes on PA-RISC
7xxx (without PREEMPT).  That was not my intention, and I don't believe
that split ptlock deserves any such slice of the user's memory.

Could we please try this patch, or something like it?  Again to overlay
the spinlock_t from &page->private onwards, with corrected BUILD_BUG_ON
that we don't go too far; with poisoning of the fields overlaid, and
unsplit SMP config verifying that the split config is safe to use them.

The previous attempt at this patch broke ppc64, which uses slab for its
page tables - and slab saves vital info in page->lru: but no config of
spinlock_t needs to overwrite lru on 64-bit anyway; and the only 32-bit
user of slab for page tables is arm26, which is never SMP i.e. all the
problems came from the "safety" checks, not from what's actually needed.
So previous checks refined with #ifdefs, and a BUG_ON(PageSlab) added.

This overlaying is unlikely to be portable forever: but the added checks
should warn developers when it's going to break, long before any users.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 include/linux/mm.h |   78 +++++++++++++++++++++++++++++++++++++++++++----------
 1 files changed, 64 insertions(+), 14 deletions(-)

--- 2.6.14-mm1/include/linux/mm.h	2005-11-07 07:39:57.000000000 +0000
+++ mm01/include/linux/mm.h	2005-11-09 14:37:47.000000000 +0000
@@ -224,18 +224,19 @@ struct page {
 					 * to show when page is mapped
 					 * & limit reverse map searches.
 					 */
-	union {
-		unsigned long private;	/* Mapping-private opaque data:
+	unsigned long private;		/* Mapping-private opaque data:
 					 * usually used for buffer_heads
 					 * if PagePrivate set; used for
 					 * swp_entry_t if PageSwapCache
 					 * When page is free, this indicates
 					 * order in the buddy system.
 					 */
-#if NR_CPUS >= CONFIG_SPLIT_PTLOCK_CPUS
-		spinlock_t ptl;
-#endif
-	} u;
+	/*
+	 * Depending on config, along with private, subsequent fields of
+	 * a page table page's struct page may be overlaid by a spinlock
+	 * for pte locking: see comment on "split ptlock" below.  Please
+	 * do not rearrange these fields without considering that usage.
+	 */
 	struct address_space *mapping;	/* If low bit clear, points to
 					 * inode address_space, or NULL.
 					 * If page mapped as anonymous
@@ -268,8 +269,8 @@ struct page {
 #endif
 };
 
-#define page_private(page)		((page)->u.private)
-#define set_page_private(page, v)	((page)->u.private = (v))
+#define page_private(page)		((page)->private)
+#define set_page_private(page, v)	((page)->private = (v))
 
 /*
  * FIXME: take this include out, include page-flags.h in
@@ -827,25 +828,74 @@ static inline pmd_t *pmd_alloc(struct mm
 }
 #endif /* CONFIG_MMU && !__ARCH_HAS_4LEVEL_HACK */
 
+/*
+ * In the split ptlock case, we shall be overlaying the struct page
+ * of a page table page with a spinlock starting at &page->private:
+ * ending dependent on architecture and config, but never beyond lru.
+ *
+ * So poison page table struct page in all SMP cases (in part to assert
+ * our territory: that pte locking owns these fields of a page table's
+ * struct page); and verify it when freeing in the unsplit ptlock case,
+ * when none of these fields should have been touched.  So that now the
+ * common config checks also for the larger PREEMPT DEBUG_SPINLOCK lock.
+ *
+ * Poison lru only in the 32-bit configs, since no 64-bit spinlock_t
+ * extends that far - and ppc64 allocates from slab, which saves info in
+ * these lru fields (arm26 also allocates from slab, but is never SMP).
+ * Poison lru back-to-front, to make sure that list_del was not used.
+ */
+static inline void poison_struct_page(struct page *page)
+{
+#ifdef CONFIG_SMP
+	page->private = (unsigned long) page;
+	page->mapping = (struct address_space *) page;
+	page->index   = (pgoff_t) page;
+#if BITS_PER_LONG == 32
+	BUG_ON(PageSlab(page));
+	page->lru.next = LIST_POISON2;
+	page->lru.prev = LIST_POISON1;
+#endif
+#endif
+}
+
+static inline void verify_struct_page(struct page *page)
+{
+#ifdef CONFIG_SMP
+	BUG_ON(page->private != (unsigned long) page);
+	BUG_ON(page->mapping != (struct address_space *) page);
+	BUG_ON(page->index   != (pgoff_t) page);
+	page->mapping = NULL;
+#if BITS_PER_LONG == 32
+	BUG_ON(page->lru.next != LIST_POISON2);
+	BUG_ON(page->lru.prev != LIST_POISON1);
+#endif
+#endif
+}
+
 #if NR_CPUS >= CONFIG_SPLIT_PTLOCK_CPUS
 /*
  * We tuck a spinlock to guard each pagetable page into its struct page,
  * at page->private, with BUILD_BUG_ON to make sure that this will not
- * overflow into the next struct page (as it might with DEBUG_SPINLOCK).
- * When freeing, reset page->mapping so free_pages_check won't complain.
+ * extend further than expected.
  */
-#define __pte_lockptr(page)	&((page)->u.ptl)
+#define __pte_lockptr(page)	((spinlock_t *)&((page)->private))
 #define pte_lock_init(_page)	do {					\
+	BUILD_BUG_ON(__pte_lockptr((struct page *)0) + 1 > (spinlock_t*)\
+		(&((struct page *)0)->lru + (BITS_PER_LONG == 32)));	\
+	poison_struct_page(_page);					\
 	spin_lock_init(__pte_lockptr(_page));				\
 } while (0)
+/*
+ * When freeing, reset page->mapping so free_pages_check won't complain.
+ */
 #define pte_lock_deinit(page)	((page)->mapping = NULL)
 #define pte_lockptr(mm, pmd)	({(void)(mm); __pte_lockptr(pmd_page(*(pmd)));})
-#else
+#else  /* NR_CPUS < CONFIG_SPLIT_PTLOCK_CPUS */
 /*
  * We use mm->page_table_lock to guard all pagetable pages of the mm.
  */
-#define pte_lock_init(page)	do {} while (0)
-#define pte_lock_deinit(page)	do {} while (0)
+#define pte_lock_init(page)	poison_struct_page(page)
+#define pte_lock_deinit(page)	verify_struct_page(page)
 #define pte_lockptr(mm, pmd)	({(void)(pmd); &(mm)->page_table_lock;})
 #endif /* NR_CPUS < CONFIG_SPLIT_PTLOCK_CPUS */
 
