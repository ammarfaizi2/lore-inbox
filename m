Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261500AbUFWVx4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbUFWVx4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 17:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261236AbUFWVxC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 17:53:02 -0400
Received: from fmr03.intel.com ([143.183.121.5]:2243 "EHLO hermes.sc.intel.com")
	by vger.kernel.org with ESMTP id S261763AbUFWVvJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 17:51:09 -0400
Message-Id: <200406232149.i5NLnDY11106@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'William Lee Irwin III'" <wli@holomorphy.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: More bug fix in mm/hugetlb.c - fix try_to_free_low()
Date: Wed, 23 Jun 2004 14:50:34 -0700
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcRZWkQ4nj2wV49UTzGZtW6Dp4SyUwAEOWSA
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
In-Reply-To: <20040623194243.GB1552@holomorphy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote on Wednesday, June 23, 2004 12:43 PM
> On Wed, Jun 23, 2004 at 12:33:00PM -0700, Chen, Kenneth W wrote:
> > The argument "count" passed to try_to_free_low() is the config parameter
> > for desired hugetlb page pool size.  But the implementation took that
> > input argument as number of pages to free. It also decrement the config
> > parameter as well.  All give random behavior depend on how many hugetlb
> > pages are in normal/highmem zone.
> > A two line fix in try_to_free_low() would be:
>
> Thanks for cleaning this up; there hasn't been much apparent interest
> here lately so I've not gotten much in the way of bugreports to work.
>
> I suspect a general hardening effort should go on here. I'll go about
> cleaning up other arches, too.

Great! would you also consider merge the following patch?  It adds per
node huge page stats in sysfs. Diff'ed relative to base 2.6.7 + 2 bug
fixes in try_to_free_low.

- Ken



diff -Nurp linux-2.6.7.orig/drivers/base/node.c linux-2.6.7/drivers/base/node.c
--- linux-2.6.7.orig/drivers/base/node.c	2004-06-15 22:18:59.000000000 -0700
+++ linux-2.6.7/drivers/base/node.c	2004-06-23 13:58:27.000000000 -0700
@@ -31,12 +31,6 @@ static ssize_t node_read_cpumap(struct s

 static SYSDEV_ATTR(cpumap,S_IRUGO,node_read_cpumap,NULL);

-/* Can be overwritten by architecture specific code. */
-int __attribute__((weak)) hugetlb_report_node_meminfo(int node, char *buf)
-{
-	return 0;
-}
-
 #define K(x) ((x) << (PAGE_SHIFT - 10))
 static ssize_t node_read_meminfo(struct sys_device * dev, char * buf)
 {
diff -Nurp linux-2.6.7.orig/include/linux/hugetlb.h linux-2.6.7/include/linux/hugetlb.h
--- linux-2.6.7.orig/include/linux/hugetlb.h	2004-06-15 22:19:23.000000000 -0700
+++ linux-2.6.7/include/linux/hugetlb.h	2004-06-23 14:00:08.000000000 -0700
@@ -19,6 +19,7 @@ void zap_hugepage_range(struct vm_area_s
 void unmap_hugepage_range(struct vm_area_struct *, unsigned long, unsigned long);
 int hugetlb_prefault(struct address_space *, struct vm_area_struct *);
 int hugetlb_report_meminfo(char *);
+int hugetlb_report_node_meminfo(int, char *);
 int is_hugepage_mem_enough(size_t);
 unsigned long hugetlb_total_pages(void);
 struct page *follow_huge_addr(struct mm_struct *mm, unsigned long address,
@@ -72,6 +73,7 @@ static inline unsigned long hugetlb_tota
 #define unmap_hugepage_range(vma, start, end)	BUG()
 #define is_hugepage_mem_enough(size)		0
 #define hugetlb_report_meminfo(buf)		0
+#define hugetlb_report_node_meminfo(n, buf)	0
 #define mark_mm_hugetlb(mm, vma)		do { } while (0)
 #define follow_huge_pmd(mm, addr, pmd, write)	0
 #define is_aligned_hugepage_range(addr, len)	0
diff -Nurp linux-2.6.7.orig/mm/hugetlb.c linux-2.6.7/mm/hugetlb.c
--- linux-2.6.7.orig/mm/hugetlb.c	2004-06-23 13:37:27.000000000 -0700
+++ linux-2.6.7/mm/hugetlb.c	2004-06-23 14:01:31.000000000 -0700
@@ -15,12 +15,16 @@ const unsigned long hugetlb_zero = 0, hu
 static unsigned long nr_huge_pages, free_huge_pages;
 unsigned long max_huge_pages;
 static struct list_head hugepage_freelists[MAX_NUMNODES];
+static unsigned int nr_huge_pages_node[MAX_NUMNODES];
+static unsigned int free_huge_pages_node[MAX_NUMNODES];
 static spinlock_t hugetlb_lock = SPIN_LOCK_UNLOCKED;

 static void enqueue_huge_page(struct page *page)
 {
-	list_add(&page->lru,
-		 &hugepage_freelists[page_zone(page)->zone_pgdat->node_id]);
+	int nid = page_zone(page)->zone_pgdat->node_id;
+	list_add(&page->lru, &hugepage_freelists[nid]);
+	free_huge_pages++;
+	free_huge_pages_node[nid]++;
 }

 static struct page *dequeue_huge_page(void)
@@ -38,6 +42,8 @@ static struct page *dequeue_huge_page(vo
 		page = list_entry(hugepage_freelists[nid].next,
 				  struct page, lru);
 		list_del(&page->lru);
+		free_huge_pages--;
+		free_huge_pages_node[nid]--;
 	}
 	return page;
 }
@@ -49,6 +55,10 @@ static struct page *alloc_fresh_huge_pag
 	page = alloc_pages_node(nid, GFP_HIGHUSER|__GFP_COMP,
 					HUGETLB_PAGE_ORDER);
 	nid = (nid + 1) % numnodes;
+	if (page) {
+		nr_huge_pages++;
+		nr_huge_pages_node[page_zone(page)->zone_pgdat->node_id]++;
+	}
 	return page;
 }

@@ -61,7 +71,6 @@ void free_huge_page(struct page *page)

 	spin_lock(&hugetlb_lock);
 	enqueue_huge_page(page);
-	free_huge_pages++;
 	spin_unlock(&hugetlb_lock);
 }

@@ -76,7 +85,6 @@ struct page *alloc_huge_page(void)
 		spin_unlock(&hugetlb_lock);
 		return NULL;
 	}
-	free_huge_pages--;
 	spin_unlock(&hugetlb_lock);
 	set_page_count(page, 1);
 	page[1].mapping = (void *)free_huge_page;
@@ -119,6 +127,7 @@ static void update_and_free_page(struct
 {
 	int i;
 	nr_huge_pages--;
+	nr_huge_pages_node[page_zone(page)->zone_pgdat->node_id]--;
 	for (i = 0; i < (HPAGE_SIZE / PAGE_SIZE); i++) {
 		page[i].flags &= ~(1 << PG_locked | 1 << PG_error | 1 << PG_referenced |
 				1 << PG_dirty | 1 << PG_active | 1 << PG_reserved |
@@ -132,7 +141,7 @@ static void update_and_free_page(struct
 #ifdef CONFIG_HIGHMEM
 static void try_to_free_low(unsigned long count)
 {
-	int i;
+	int i, nid;
 	for (i = 0; i < MAX_NUMNODES; ++i) {
 		struct page *page, *next;
 		list_for_each_entry(page, next, &hugepage_freelists[i], lru) {
@@ -140,7 +149,9 @@ static void try_to_free_low(unsigned lon
 				continue;
 			list_del(&page->lru);
 			update_and_free_page(page);
-			--free_huge_pages;
+			nid = page_zone(page)->zone_pgdat->node_id;
+			free_huge_pages--;
+			free_huge_pages_node[nid]--;
 			if (count >= nr_huge_pages)
 				return;
 		}
@@ -160,8 +171,6 @@ static unsigned long set_max_huge_pages(
 			return nr_huge_pages;
 		spin_lock(&hugetlb_lock);
 		enqueue_huge_page(page);
-		free_huge_pages++;
-		nr_huge_pages++;
 		spin_unlock(&hugetlb_lock);
 	}
 	if (count >= nr_huge_pages)
@@ -169,7 +178,7 @@ static unsigned long set_max_huge_pages(

 	spin_lock(&hugetlb_lock);
 	try_to_free_low(count);
-	for (; count < nr_huge_pages; --free_huge_pages) {
+	while (count < nr_huge_pages) {
 		struct page *page = dequeue_huge_page();
 		if (!page)
 			break;
@@ -201,6 +210,15 @@ int hugetlb_report_meminfo(char *buf)
 			HPAGE_SIZE/1024);
 }

+int hugetlb_report_node_meminfo(int nid, char *buf)
+{
+	return sprintf(buf,
+		"Node %d HugePages_Total: %5u\n"
+		"Node %d HugePages_Free:  %5u\n",
+		nid, nr_huge_pages_node[nid],
+		nid, free_huge_pages_node[nid]);
+}
+
 int is_hugepage_mem_enough(size_t size)
 {
 	return (size + ~HPAGE_MASK)/HPAGE_SIZE <= free_huge_pages;


