Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265537AbTFRVKi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 17:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265538AbTFRVKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 17:10:38 -0400
Received: from holomorphy.com ([66.224.33.161]:45483 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S265537AbTFRVKf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 17:10:35 -0400
Date: Wed, 18 Jun 2003 14:24:25 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.72-mm1
Message-ID: <20030618212425.GL26348@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20030617014044.0446b19e.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030617014044.0446b19e.akpm@digeo.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 17, 2003 at 01:40:44AM -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.72/2.5.72-mm1/
> . A fairly large batch of changes in the block request allocation,
>   batching and throttling code.  To address worst-case latency, improve
>   throughput in benchmarky loads, etc.
> . The memory debugging patch which unmaps pages and large slab objects
>   from the kernel virtual address space is back.

The following patch implements node-local memory allocation support for
hugetlb. Successfully tested on NUMA-Q.


-- wli


diff -prauN linux-2.5.72/arch/i386/mm/hugetlbpage.c htlb-2.5.72-1/arch/i386/mm/hugetlbpage.c
--- linux-2.5.72/arch/i386/mm/hugetlbpage.c	2003-06-16 21:20:22.000000000 -0700
+++ htlb-2.5.72-1/arch/i386/mm/hugetlbpage.c	2003-06-17 14:04:05.000000000 -0700
@@ -24,9 +24,41 @@ static long    htlbpagemem;
 int     htlbpage_max;
 static long    htlbzone_pages;
 
-static LIST_HEAD(htlbpage_freelist);
+static struct list_head hugepage_freelists[MAX_NUMNODES];
 static spinlock_t htlbpage_lock = SPIN_LOCK_UNLOCKED;
 
+static void enqueue_huge_page(struct page *page)
+{
+	list_add(&page->list,
+		&hugepage_freelists[page_zone(page)->zone_pgdat->node_id]);
+}
+
+static struct page *dequeue_huge_page(void)
+{
+	int nid = numa_node_id();
+	struct page *page = NULL;
+
+	if (list_empty(&hugepage_freelists[nid])) {
+		for (nid = 0; nid < MAX_NUMNODES; ++nid)
+			if (!list_empty(&hugepage_freelists[nid]))
+				break;
+	}
+	if (nid >= 0 && nid < MAX_NUMNODES && !list_empty(&hugepage_freelists[nid])) {
+		page = list_entry(hugepage_freelists[nid].next, struct page, list);
+		list_del(&page->list);
+	}
+	return page;
+}
+
+static struct page *alloc_fresh_huge_page(void)
+{
+	static int nid = 0;
+	struct page *page;
+	page = alloc_pages_node(nid, GFP_HIGHUSER, HUGETLB_PAGE_ORDER);
+	nid = (nid + 1) % numnodes;
+	return page;
+}
+
 void free_huge_page(struct page *page);
 
 static struct page *alloc_hugetlb_page(void)
@@ -35,13 +67,11 @@ static struct page *alloc_hugetlb_page(v
 	struct page *page;
 
 	spin_lock(&htlbpage_lock);
-	if (list_empty(&htlbpage_freelist)) {
+	page = dequeue_huge_page();
+	if (!page) {
 		spin_unlock(&htlbpage_lock);
 		return NULL;
 	}
-
-	page = list_entry(htlbpage_freelist.next, struct page, list);
-	list_del(&page->list);
 	htlbpagemem--;
 	spin_unlock(&htlbpage_lock);
 	set_page_count(page, 1);
@@ -253,7 +283,7 @@ void free_huge_page(struct page *page)
 	INIT_LIST_HEAD(&page->list);
 
 	spin_lock(&htlbpage_lock);
-	list_add(&page->list, &htlbpage_freelist);
+	enqueue_huge_page(page);
 	htlbpagemem++;
 	spin_unlock(&htlbpage_lock);
 }
@@ -369,7 +399,8 @@ int try_to_free_low(int count)
 
 	map = NULL;
 	spin_lock(&htlbpage_lock);
-	list_for_each(p, &htlbpage_freelist) {
+	/* all lowmem is on node 0 */
+	list_for_each(p, &hugepage_freelists[0]) {
 		if (map) {
 			list_del(&map->list);
 			update_and_free_page(map);
@@ -406,11 +437,11 @@ int set_hugetlb_mem_size(int count)
 		return (int)htlbzone_pages;
 	if (lcount > 0) {	/* Increase the mem size. */
 		while (lcount--) {
-			page = alloc_pages(__GFP_HIGHMEM, HUGETLB_PAGE_ORDER);
+			page = alloc_fresh_huge_page();
 			if (page == NULL)
 				break;
 			spin_lock(&htlbpage_lock);
-			list_add(&page->list, &htlbpage_freelist);
+			enqueue_huge_page(page);
 			htlbpagemem++;
 			htlbzone_pages++;
 			spin_unlock(&htlbpage_lock);
@@ -451,12 +482,15 @@ static int __init hugetlb_init(void)
 	int i;
 	struct page *page;
 
+	for (i = 0; i < MAX_NUMNODES; ++i)
+		INIT_LIST_HEAD(&hugepage_freelists[i]);
+
 	for (i = 0; i < htlbpage_max; ++i) {
-		page = alloc_pages(__GFP_HIGHMEM, HUGETLB_PAGE_ORDER);
+		page = alloc_fresh_huge_page();
 		if (!page)
 			break;
 		spin_lock(&htlbpage_lock);
-		list_add(&page->list, &htlbpage_freelist);
+		enqueue_huge_page(page);
 		spin_unlock(&htlbpage_lock);
 	}
 	htlbpage_max = htlbpagemem = htlbzone_pages = i;
