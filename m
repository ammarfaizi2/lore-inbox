Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267409AbUGNOOk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267409AbUGNOOk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 10:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267415AbUGNOOU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 10:14:20 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:10428 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S267409AbUGNOFm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 10:05:42 -0400
Date: Wed, 14 Jul 2004 23:05:27 +0900 (JST)
Message-Id: <20040714.230527.00479989.taka@valinux.co.jp>
To: linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Cc: linux-mm@kvack.org
Subject: [PATCH] memory hotremoval for linux-2.6.7 [10/16]
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <20040714.224138.95803956.taka@valinux.co.jp>
References: <20040714.224138.95803956.taka@valinux.co.jp>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- linux-2.6.7.ORG/mm/hugetlb.c	Thu Jun 17 15:17:51 2032
+++ linux-2.6.7/mm/hugetlb.c	Thu Jun 17 15:21:18 2032
@@ -15,8 +15,20 @@ const unsigned long hugetlb_zero = 0, hu
 static unsigned long nr_huge_pages, free_huge_pages;
 unsigned long max_huge_pages;
 static struct list_head hugepage_freelists[MAX_NUMNODES];
+static struct list_head hugepage_alllists[MAX_NUMNODES];
 static spinlock_t hugetlb_lock = SPIN_LOCK_UNLOCKED;
 
+static void register_huge_page(struct page *page)
+{
+	list_add(&page[1].lru,
+		&hugepage_alllists[page_zone(page)->zone_pgdat->node_id]);
+}
+
+static void unregister_huge_page(struct page *page)
+{
+	list_del(&page[1].lru);
+}
+
 static void enqueue_huge_page(struct page *page)
 {
 	list_add(&page->lru,
@@ -90,14 +102,17 @@ static int __init hugetlb_init(void)
 	unsigned long i;
 	struct page *page;
 
-	for (i = 0; i < MAX_NUMNODES; ++i)
+	for (i = 0; i < MAX_NUMNODES; ++i) {
 		INIT_LIST_HEAD(&hugepage_freelists[i]);
+		INIT_LIST_HEAD(&hugepage_alllists[i]);
+	}
 
 	for (i = 0; i < max_huge_pages; ++i) {
 		page = alloc_fresh_huge_page();
 		if (!page)
 			break;
 		spin_lock(&hugetlb_lock);
+		register_huge_page(page);
 		enqueue_huge_page(page);
 		spin_unlock(&hugetlb_lock);
 	}
@@ -139,6 +154,7 @@ static int try_to_free_low(unsigned long
 			if (PageHighMem(page))
 				continue;
 			list_del(&page->lru);
+			unregister_huge_page(page);
 			update_and_free_page(page);
 			--free_huge_pages;
 			if (!--count)
@@ -161,6 +177,7 @@ static unsigned long set_max_huge_pages(
 		if (!page)
 			return nr_huge_pages;
 		spin_lock(&hugetlb_lock);
+		register_huge_page(page);
 		enqueue_huge_page(page);
 		free_huge_pages++;
 		nr_huge_pages++;
@@ -174,6 +191,7 @@ static unsigned long set_max_huge_pages(
 		struct page *page = dequeue_huge_page();
 		if (!page)
 			break;
+		unregister_huge_page(page);
 		update_and_free_page(page);
 	}
 	spin_unlock(&hugetlb_lock);
