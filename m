Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267433AbUGNORP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267433AbUGNORP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 10:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267417AbUGNORD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 10:17:03 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:12988 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S267419AbUGNOGc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 10:06:32 -0400
Date: Wed, 14 Jul 2004 23:06:15 +0900 (JST)
Message-Id: <20040714.230615.38080607.taka@valinux.co.jp>
To: linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Cc: linux-mm@kvack.org
Subject: [PATCH] memory hotremoval for linux-2.6.7 [13/16]
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <20040714.224138.95803956.taka@valinux.co.jp>
References: <20040714.224138.95803956.taka@valinux.co.jp>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- linux-2.6.7.ORG/include/linux/hugetlb.h	Sun Jul 11 11:33:45 2032
+++ linux-2.6.7/include/linux/hugetlb.h	Sun Jul 11 11:34:11 2032
@@ -28,6 +28,7 @@ struct page *follow_huge_pmd(struct mm_s
 extern int hugetlb_fault(struct mm_struct *, struct vm_area_struct *,
 				int, unsigned long);
 int try_to_unmap_hugepage(struct page *page, struct vm_area_struct *vma, struct list_head *force);
+int mmigrate_hugetlb_pages(struct zone *);
 int is_aligned_hugepage_range(unsigned long addr, unsigned long len);
 int pmd_huge(pmd_t pmd);
 struct page *alloc_huge_page(void);
@@ -86,6 +87,7 @@ static inline unsigned long hugetlb_tota
 #define free_huge_page(p)			({ (void)(p); BUG(); })
 #define hugetlb_fault(mm, vma, write, addr)	0
 #define try_to_unmap_hugepage(page, vma, force)	0
+#define mmigrate_hugetlb_pages(zone)		0
 
 #ifndef HPAGE_MASK
 #define HPAGE_MASK	0		/* Keep the compiler happy */
--- linux-2.6.7.ORG/arch/i386/mm/hugetlbpage.c	Sun Jul 11 11:33:45 2032
+++ linux-2.6.7/arch/i386/mm/hugetlbpage.c	Sun Jul 11 11:34:11 2032
@@ -288,6 +288,15 @@ again:
 			goto again;
 		}
 	}
+
+	if (page->mapping == NULL) {
+		 BUG_ON(! PageAgain(page));
+		/* This page will go back to freelists[] */
+		put_page(page);	/* XXX */
+		unlock_page(page);
+		goto again;
+	}
+
 	spin_lock(&mm->page_table_lock);
 	if (pte_none(*pte)) {
 		set_huge_pte(mm, vma, page, pte, vma->vm_flags & VM_WRITE);
--- linux-2.6.7.ORG/mm/memhotplug.c	Sun Jul 11 12:56:53 2032
+++ linux-2.6.7/mm/memhotplug.c	Sun Jul 11 12:56:17 2032
@@ -17,6 +17,7 @@
 #include <linux/buffer_head.h>
 #include <linux/mm_inline.h>
 #include <linux/rmap.h>
+#include <linux/hugetlb.h>
 #include <linux/memhotplug.h>
 
 #ifdef CONFIG_KDB
@@ -841,6 +842,10 @@ int mmigrated(void *p)
 	current->flags |= PF_KSWAPD;	/*  It's fake */
 	if (down_trylock(&mmigrated_sem)) {
 		printk("mmigrated already running\n");
+		return 0;
+	}
+	if (mmigrate_hugetlb_pages(zone)) {
+		up(&mmigrated_sem);
 		return 0;
 	}
 	on_each_cpu(lru_drain_schedule, NULL, 1, 1);
--- linux-2.6.7.ORG/mm/hugetlb.c	Sun Jul 11 11:30:50 2032
+++ linux-2.6.7/mm/hugetlb.c	Sun Jul 11 13:14:25 2032
@@ -1,6 +1,7 @@
 /*
  * Generic hugetlb support.
  * (C) William Irwin, April 2004
+ * Support of memory hotplug for hugetlbpages, Hirokazu Takahashi, Jul 2004
  */
 #include <linux/gfp.h>
 #include <linux/list.h>
@@ -8,6 +9,8 @@
 #include <linux/module.h>
 #include <linux/mm.h>
 #include <linux/hugetlb.h>
+#include <linux/pagemap.h>
+#include <linux/memhotplug.h>
 #include <linux/sysctl.h>
 #include <linux/highmem.h>
 
@@ -58,6 +61,9 @@ static struct page *alloc_fresh_huge_pag
 {
 	static int nid = 0;
 	struct page *page;
+	struct pglist_data *pgdat;
+	while ((pgdat = NODE_DATA(nid)) == NULL || !pgdat->enabled)
+		nid = (nid + 1) % numnodes;
 	page = alloc_pages_node(nid, GFP_HIGHUSER|__GFP_COMP,
 					HUGETLB_PAGE_ORDER);
 	nid = (nid + 1) % numnodes;
@@ -91,6 +97,8 @@ struct page *alloc_huge_page(void)
 	free_huge_pages--;
 	spin_unlock(&hugetlb_lock);
 	set_page_count(page, 1);
+	page->flags &= ~(1 << PG_uptodate | 1 << PG_error |
+			 1 << PG_referenced | 1 << PG_again);
 	page[1].mapping = (void *)free_huge_page;
 	for (i = 0; i < (HPAGE_SIZE/PAGE_SIZE); ++i)
 		clear_highpage(&page[i]);
@@ -144,25 +152,36 @@ static void update_and_free_page(struct 
 	__free_pages(page, HUGETLB_PAGE_ORDER);
 }
 
-#ifdef CONFIG_HIGHMEM
-static int try_to_free_low(unsigned long count)
+static int
+try_to_free_hugepages(int idx, unsigned long count, struct zone *zone)
 {
-	int i;
-	for (i = 0; i < MAX_NUMNODES; ++i) {
-		struct page *page, *page1;
-		list_for_each_entry_safe(page, page1, &hugepage_freelists[i], lru) {
+	struct page *page, *page1;
+	list_for_each_entry_safe(page, page1, &hugepage_freelists[idx], lru) {
+		if (zone) {
+			if (page_zone(page) != zone)
+				continue;
+		} else {
 			if (PageHighMem(page))
 				continue;
-			list_del(&page->lru);
-			unregister_huge_page(page);
-			update_and_free_page(page);
-			--free_huge_pages;
-			if (!--count)
-				return 0;
 		}
+		list_del(&page->lru);
+		unregister_huge_page(page);
+		update_and_free_page(page);
+		--free_huge_pages;
+		if (!--count)
+			return 0;
 	}
 	return count;
 }
+
+#ifdef CONFIG_HIGHMEM
+static int try_to_free_low(unsigned long count)
+{
+	int i;
+	for (i = 0; i < MAX_NUMNODES; ++i)
+		count = try_to_free_hugepages(i, count, NULL);
+	return count;
+}
 #else
 static inline int try_to_free_low(unsigned long count)
 {
@@ -250,10 +269,8 @@ unsigned long hugetlb_total_pages(void)
 EXPORT_SYMBOL(hugetlb_total_pages);
 
 /*
- * We cannot handle pagefaults against hugetlb pages at all.  They cause
- * handle_mm_fault() to try to instantiate regular-sized pages in the
- * hugegpage VMA.  do_page_fault() is supposed to trap this, so BUG is we get
- * this far.
+ * hugetlb_nopage() is never called since hugetlb_fault() has
+ * implemented.
  */
 static struct page *hugetlb_nopage(struct vm_area_struct *vma,
 				unsigned long address, int *unused)
@@ -275,3 +292,200 @@ void zap_hugepage_range(struct vm_area_s
 	unmap_hugepage_range(vma, start, start + length);
 	spin_unlock(&mm->page_table_lock);
 }
+
+#ifdef CONFIG_MEMHOTPLUG
+static int copy_hugepage(struct page *to, struct page *from)
+{
+	int size;
+	for (size = 0; size < HPAGE_SIZE; size += PAGE_SIZE) {
+		copy_highpage(to, from);
+		to++;
+		from++;
+	}
+	return 0;
+}
+
+/*
+ * Allocate a hugepage from Buddy allocator directly.
+ */
+static struct page *
+hugepage_mmigrate_alloc(int nid)
+{
+	struct page *page;
+	/* 
+	 * TODO:
+	 * - NUMA aware page allocation is required. we should allocate
+	 *   a hugepage from the node which the process depends on.
+	 * - New hugepages should be preallocated prior to migrating pages
+	 *   so that lack of memory can be found before them.
+	 * - New hugepages should be allocate from the node specified by nid.
+	 */
+	page = alloc_fresh_huge_page();
+	
+	if (page == NULL) {
+		printk(KERN_WARNING "remap: Failed to allocate new hugepage\n");
+	} else {
+		spin_lock(&hugetlb_lock);
+		register_huge_page(page);
+		enqueue_huge_page(page);
+		free_huge_pages++;
+		nr_huge_pages++;
+		spin_unlock(&hugetlb_lock);
+	}
+	page = alloc_huge_page();
+	unregister_huge_page(page);	/* XXXX */
+	return page;
+}
+
+/*
+ * Free a hugepage into Buddy allocator directly.
+ */
+static int
+hugepage_delete(struct page *page)
+{
+        BUG_ON(page_count(page) != 1);
+        BUG_ON(page->mapping);
+
+	spin_lock(&hugetlb_lock);
+	page[1].mapping = NULL;
+	update_and_free_page(page);
+	spin_unlock(&hugetlb_lock);
+        return 0;
+}
+
+static int
+hugepage_register(struct page *page, int active)
+{
+	spin_lock(&hugetlb_lock);
+	register_huge_page(page);
+	spin_unlock(&hugetlb_lock);
+        return 0;
+}
+
+static int
+hugepage_release_buffer(struct page *page)
+{
+	BUG();
+	return -1;
+}
+
+/*
+ * Hugetlbpage migration is harder than regular page migration
+ * for lack of swap related features on hugetlbpages. To do this
+ * new feature has been intoduced:
+ *  - rmap mechanism to unmap a hugetlbpage.
+ *  - a pagefault handler against hugetlbpages.
+ *  - a list on which all hugetlbpages to be put instead of the LRU
+ *    lists for regular pages. 
+ * With the feature, hugetlbpages can be handled in the same way
+ * for regular pages. 
+ * 
+ * The following is a flow to migrate hugetlbpages:
+ *  1. allocate a new hugetlbpage.
+ *    a. look for an appropriate section for a hugetlbpage.
+ *    b. make all pages in the section migrated to another zone.
+ *    c. allocate it as a new hugetlbpage.
+ *  2. lock the new hugetlbpage and don't set PG_uptodate flag on it.
+ *  3. modify the oldpage entry in the corresponding radix tree on
+ *     hugetlbfs with the new hugetlbpage.
+ *  4. clear all PTEs that refer to the old hugetlbpage.
+ *  5. wait until all references on the old hugetlbpage have gone.
+ *  6. copy from the old hugetlbpage to the new hugetlbpage.
+ *  7. set PG_uptodate flag of the new hugetlbpage.
+ *  8. release the old hugetlbpage into the Buddy allocator directly.
+ *  9. unlock the new hugetlbpage and wakeup all waiters.
+ *
+ * If a new access to a hugetlbpage migrating occurs, it will be blocked
+ * in a pagefaut handler until everything has done.
+ *
+ *
+ * disabled+------+---------------------------+------+------+---
+ * zone    |      |       old hugepage        |      |      |
+ *         +------+-------------|-------------+------+------+---
+ *                              +--migrate
+ *                                    |
+ *                                    V
+ *                        <-- reserve new hugepage -->
+ *           page   page   page   page   page   page   page  
+ *         +------+------+------+------+------+------+------+---
+ * zone    |      |      |Booked|Booked|Booked|Booked|      |   
+ *         +------+------+--|---+--|---+------+------+------+---
+ *                          |      |
+ *                 migrate--+      +--------------+
+ *                    |                           |
+ * other   +------+---V--+------+------+---    migrate
+ * zones   |      |      |      |      |          |
+ *         +------+------+------+------+--        |
+ *         +------+------+------+------+------+---V--+------+---
+ *         |      |      |      |      |      |      |      |
+ *         +------+------+------+------+------+------+------+---
+ */
+
+static struct mmigrate_operations hugepage_mmigrate_ops = {
+	.mmigrate_alloc_page       = hugepage_mmigrate_alloc,
+	.mmigrate_free_page        = hugepage_delete,
+	.mmigrate_copy_page        = copy_hugepage,
+	.mmigrate_lru_add_page     = hugepage_register,
+	.mmigrate_release_buffers  = hugepage_release_buffer,
+	.mmigrate_prepare          = NULL,
+	.mmigrate_stick_page       = NULL
+};
+
+int mmigrate_hugetlb_pages(struct zone *zone)
+{
+	struct page *page, *page1, *map;
+	int idx = zone->zone_pgdat->node_id;
+	LIST_HEAD(templist);
+	int rest = 0;
+
+	/*
+	 *  Release unused hugetlbpages coresponding to the specified zone.
+	 */
+	spin_lock(&hugetlb_lock);
+	try_to_free_hugepages(idx, free_huge_pages, zone);
+	spin_unlock(&hugetlb_lock);
+/* 	max_huge_pages = set_max_huge_pages(max_huge_pages); */
+
+	/*
+	 * Look for all hugetlbpages coresponding to the specified zone.
+	 */
+	spin_lock(&hugetlb_lock);
+	list_for_each_entry_safe(page, map, &hugepage_alllists[idx], lru) {
+		/*
+		 * looking for all hugetlbpages coresponding to the
+		 * specified zone.
+		 */
+		if (page_zone(page) != zone)
+			continue;
+		page_cache_get(page-1);
+		unregister_huge_page(page-1);
+		list_add(&page->lru, &templist);
+	}
+	spin_unlock(&hugetlb_lock);
+
+	/*
+	 * Try to migrate the pages one by one.
+	 */
+	list_for_each_entry_safe(page1, map, &templist, lru) {
+		list_del(&page1->lru);
+		INIT_LIST_HEAD(&page1->lru);
+		page = page1 - 1;
+
+		if (page_count(page) <= 1 || page->mapping == NULL ||
+		    mmigrate_onepage(page, MIGRATE_ANYNODE, 0, &hugepage_mmigrate_ops)) {
+			/* free the page later */
+			spin_lock(&hugetlb_lock);
+			register_huge_page(page);
+			spin_unlock(&hugetlb_lock);
+			page_cache_release(page);
+			rest++;
+		}
+	}
+
+	/*
+	 *  Reallocate unused hugetlbpages.
+	 */
+	max_huge_pages = set_max_huge_pages(max_huge_pages);
+	return rest;
+}
+#endif /* CONFIG_MEMHOTPLUG */
