Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263797AbUDFMt6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 08:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263803AbUDFMt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 08:49:58 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:14763 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S263797AbUDFMtF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 08:49:05 -0400
Date: Tue, 06 Apr 2004 21:49:14 +0900 (JST)
Message-Id: <20040406.214914.132114497.taka@valinux.co.jp>
To: linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Subject: [patch 5/6] memory hotplug for hugetlbpages
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <20040406.214123.129013798.taka@valinux.co.jp>
References: <20040406105353.9BDE8705DE@sv1.valinux.co.jp>
	<20040406.214123.129013798.taka@valinux.co.jp>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a part 5 of memory hotplug patches for hugetlbpages.

--- linux-2.6.5.ORG/include/linux/hugetlb.h	Tue Apr  6 22:28:09 2032
+++ linux-2.6.5/include/linux/hugetlb.h	Tue Apr  6 15:00:59 2032
@@ -31,6 +31,7 @@ int pmd_huge(pmd_t pmd);
 extern int hugetlb_fault(struct mm_struct *, struct vm_area_struct *,
 				int, unsigned long);
 int try_to_unmap_hugepage(struct page *, pte_addr_t, struct list_head *);
+int remap_hugetlb_pages(struct zone *);
 
 extern int htlbpage_max;
 
@@ -83,6 +84,7 @@ static inline unsigned long hugetlb_tota
 #define hugetlb_free_pgtables(tlb, prev, start, end) do { } while (0)
 #define hugetlb_fault(mm, vma, write, addr)	0
 #define try_to_unmap_hugepage(page, paddr, force)	0
+#define remap_hugetlb_pages(zone)		0
 
 #ifndef HPAGE_MASK
 #define HPAGE_MASK	0		/* Keep the compiler happy */
--- linux-2.6.5.ORG/arch/i386/mm/hugetlbpage.c	Tue Apr  6 22:28:09 2032
+++ linux-2.6.5/arch/i386/mm/hugetlbpage.c	Tue Apr  6 22:30:59 2032
@@ -13,6 +13,7 @@
 #include <linux/smp_lock.h>
 #include <linux/slab.h>
 #include <linux/rmap-locking.h>
+#include <linux/memhotplug.h>
 #include <linux/module.h>
 #include <linux/err.h>
 #include <linux/sysctl.h>
@@ -92,7 +93,10 @@ static struct page *dequeue_huge_page(vo
 static struct page *alloc_fresh_huge_page(void)
 {
 	static int nid = 0;
+	struct pglist_data *pgdat;
 	struct page *page;
+	while ((pgdat = NODE_DATA(nid)) == NULL || !pgdat->enabled)
+		nid = (nid + 1) % numnodes;
 	page = alloc_pages_node(nid, GFP_HIGHUSER, HUGETLB_PAGE_ORDER);
 	nid = (nid + 1) % numnodes;
 	return page;
@@ -114,6 +118,8 @@ static struct page *alloc_hugetlb_page(v
 	htlbpagemem--;
 	spin_unlock(&htlbpage_lock);
 	set_page_count(page, 1);
+	page->flags &= ~(1 << PG_uptodate | 1 << PG_error |
+			 1 << PG_referenced | 1 << PG_again);
 	page->lru.prev = (void *)free_huge_page;
 	for (i = 0; i < (HPAGE_SIZE/PAGE_SIZE); ++i)
 		clear_highpage(&page[i]);
@@ -468,6 +474,15 @@ again:
 			goto again;
 		}
 	}
+
+	if (page->mapping == NULL) {
+		 BUG_ON(! PageAgain(page));
+		/* This page will go back to freelists[] */
+		huge_page_release(page);	/* XXX */
+		unlock_page(page);
+		goto again;
+	}
+
 	spin_lock(&mm->page_table_lock);
 	if (pte_none(*pte)) {
 		set_huge_pte(mm, vma, page, pte, vma->vm_flags & VM_WRITE);
@@ -614,7 +629,7 @@ static void update_and_free_page(struct 
 	__free_pages(page, HUGETLB_PAGE_ORDER);
 }
 
-static int try_to_free_low(int count)
+int try_to_free_hugepages(int idx, int count, struct zone *zone)
 {
 	struct list_head *p;
 	struct page *page, *map;
@@ -622,7 +637,7 @@ static int try_to_free_low(int count)
 	map = NULL;
 	spin_lock(&htlbpage_lock);
 	/* all lowmem is on node 0 */
-	list_for_each(p, &hugepage_freelists[0]) {
+	list_for_each(p, &hugepage_freelists[idx]) {
 		if (map) {
 			list_del(&map->list);
 			unregister_huge_page(map);
@@ -633,7 +648,8 @@ static int try_to_free_low(int count)
 				break;
 		}
 		page = list_entry(p, struct page, list);
-		if (!PageHighMem(page))
+		if ((zone == NULL && !PageHighMem(page)) ||
+					(page_zone(page) == zone))
 			map = page;
 	}
 	if (map) {
@@ -647,6 +663,11 @@ static int try_to_free_low(int count)
 	return count;
 }
 
+int try_to_free_low(int count)
+{
+	return try_to_free_hugepages(0, count, NULL);
+}
+
 static int set_hugetlb_mem_size(int count)
 {
 	int lcount;
@@ -686,6 +707,146 @@ static int set_hugetlb_mem_size(int coun
 	}
 	return (int) htlbzone_pages;
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
+ * Allocate a hugepage from Buddy system directly.
+ */
+static struct page *
+hugepage_remap_alloc(int nid)
+{
+	struct page *page;
+	/* 
+	 * ToDo:
+	 * - NUMA aware page allocation is required. we should allocate
+	 *   a hugepage from the node which the process depends on.
+	 * - New hugepages should be preallocated prior to remapping pages
+	 *   so that lack of memory can be found before them.
+	 * - New hugepages should be allocate from the node specified by nid.
+	 */
+	page = alloc_fresh_huge_page();
+	
+	if (page == NULL) {
+		printk(KERN_WARNING "remap: Failed to allocate new hugepage\n");
+	} else {
+		spin_lock(&htlbpage_lock);
+		register_huge_page(page);
+		enqueue_huge_page(page);
+		htlbpagemem++;
+		htlbzone_pages++;
+		spin_unlock(&htlbpage_lock);
+	}
+	page = alloc_hugetlb_page();
+	unregister_huge_page(page);	/* XXXX */
+	return page;
+}
+
+/*
+ * Free a hugepage into Buddy system directly.
+ */
+static int
+hugepage_delete(struct page *page)
+{
+        BUG_ON(page_count(page) != 1);
+        BUG_ON(page->mapping);
+
+	spin_lock(&htlbpage_lock);
+	update_and_free_page(page);
+	spin_unlock(&htlbpage_lock);
+        return 0;
+}
+
+static int
+hugepage_register(struct page *page)
+{
+	spin_lock(&htlbpage_lock);
+	register_huge_page(page);
+	spin_unlock(&htlbpage_lock);
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
+static struct remap_operations hugepage_remap_ops = {
+	.remap_alloc_page       = hugepage_remap_alloc,
+	.remap_delete_page      = hugepage_delete,
+	.remap_copy_page        = copy_hugepage,
+	.remap_lru_add_page     = hugepage_register,
+	.remap_release_buffers  = hugepage_release_buffer,
+	.remap_prepare          = NULL,
+	.remap_stick_page       = NULL
+};
+
+int remap_hugetlb_pages(struct zone *zone)
+{
+	struct list_head *p;
+	struct page *page, *map;
+	int idx = zone->zone_pgdat->node_id;
+	LIST_HEAD(templist);
+	int ret = 0;
+
+	try_to_free_hugepages(idx, -htlbpagemem, zone);
+/* 	htlbpage_max = set_hugetlb_mem_size(htlbpage_max); */
+
+	map = NULL;
+	spin_lock(&htlbpage_lock);
+	list_for_each(p, &hugepage_alllists[idx]) {
+		page = list_entry(p, struct page, list);
+		if (map) {
+			page_cache_get(map-1);
+			unregister_huge_page(map-1);
+			list_add(&map->list, &templist);
+			map = NULL;
+		}
+		if (page_zone(page) == zone) {
+			map = page;
+		}
+	}
+	if (map) {
+		page_cache_get(map-1);
+		unregister_huge_page(map-1);
+		list_add(&map->list, &templist);
+		map = NULL;
+	}
+	spin_unlock(&htlbpage_lock);
+
+	while (!list_empty(&templist)) {
+		page = list_entry(templist.next, struct page, list);
+		list_del(&page->list);
+		INIT_LIST_HEAD(&page->list);
+		page--;
+
+		if (page_count(page) <= 1 || page->mapping == NULL ||
+				remap_onepage(page, REMAP_ANYNODE, 0, &hugepage_remap_ops)) {
+			/* free the page later */
+			spin_lock(&htlbpage_lock);
+			register_huge_page(page);
+			spin_unlock(&htlbpage_lock);
+			page_cache_release(page);
+			ret++;
+		}
+	}
+
+	htlbpage_max = set_hugetlb_mem_size(htlbpage_max);
+	return ret;
+}
+#endif /* CONFIG_MEMHOTPLUG */
 
 int hugetlb_sysctl_handler(ctl_table *table, int write,
 		struct file *file, void *buffer, size_t *length)
--- linux-2.6.5.ORG/mm/memhotplug.c	Tue Apr  6 22:28:09 2032
+++ linux-2.6.5/mm/memhotplug.c	Tue Apr  6 15:00:59 2032
@@ -15,6 +15,7 @@
 #include <linux/writeback.h>
 #include <linux/buffer_head.h>
 #include <linux/rmap-locking.h>
+#include <linux/hugetlb.h>
 #include <linux/memhotplug.h>
 
 #ifdef CONFIG_KDB
@@ -595,6 +596,8 @@ int remapd(void *p)
 		return 0;
 	}
 	atomic_inc(&remapd_count);
+	if (remap_hugetlb_pages(zone))
+		goto out;
 	on_each_cpu(lru_drain_schedule, NULL, 1, 1);
 	while(nr_failed < 100) {
 		spin_lock_irq(&zone->lru_lock);
