Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263798AbUDFMqA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 08:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263795AbUDFMp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 08:45:59 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:10411 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S263798AbUDFMpa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 08:45:30 -0400
Date: Tue, 06 Apr 2004 21:45:41 +0900 (JST)
Message-Id: <20040406.214541.16071889.taka@valinux.co.jp>
To: linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Subject: [patch 3/6] memory hotplug for hugetlbpages
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

This is a part 3 of memory hotplug patches for hugetlbpages.

$Id: va-hugepagelist.patch,v 1.5 2004/03/30 06:14:28 iwamoto Exp $

--- linux-2.6.1.ORG2/arch/i386/mm/hugetlbpage.c	Wed Mar 24 22:49:45 2032
+++ linux-2.6.1/arch/i386/mm/hugetlbpage.c	Wed Mar 24 22:59:40 2032
@@ -25,8 +25,20 @@ int     htlbpage_max;
 static long    htlbzone_pages;
 
 static struct list_head hugepage_freelists[MAX_NUMNODES];
+static struct list_head hugepage_alllists[MAX_NUMNODES];
 static spinlock_t htlbpage_lock = SPIN_LOCK_UNLOCKED;
 
+static void register_huge_page(struct page *page)
+{
+	list_add(&page[1].list,
+		&hugepage_alllists[page_zone(page)->zone_pgdat->node_id]);
+}
+
+static void unregister_huge_page(struct page *page)
+{
+	list_del(&page[1].list);
+}
+
 static void enqueue_huge_page(struct page *page)
 {
 	list_add(&page->list,
@@ -462,6 +474,7 @@ static int try_to_free_low(int count)
 	list_for_each(p, &hugepage_freelists[0]) {
 		if (map) {
 			list_del(&map->list);
+			unregister_huge_page(map);
 			update_and_free_page(map);
 			htlbpagemem--;
 			map = NULL;
@@ -474,6 +487,7 @@ static int try_to_free_low(int count)
 	}
 	if (map) {
 		list_del(&map->list);
+		unregister_huge_page(map);
 		update_and_free_page(map);
 		htlbpagemem--;
 		count++;
@@ -500,6 +514,7 @@ static int set_hugetlb_mem_size(int coun
 			if (page == NULL)
 				break;
 			spin_lock(&htlbpage_lock);
+			register_huge_page(page);
 			enqueue_huge_page(page);
 			htlbpagemem++;
 			htlbzone_pages++;
@@ -514,6 +529,7 @@ static int set_hugetlb_mem_size(int coun
 		if (page == NULL)
 			break;
 		spin_lock(&htlbpage_lock);
+		unregister_huge_page(page);
 		update_and_free_page(page);
 		spin_unlock(&htlbpage_lock);
 	}
@@ -546,14 +562,17 @@ static int __init hugetlb_init(void)
 	if (!cpu_has_pse)
 		return -ENODEV;
 
-	for (i = 0; i < MAX_NUMNODES; ++i)
+	for (i = 0; i < MAX_NUMNODES; ++i) {
 		INIT_LIST_HEAD(&hugepage_freelists[i]);
+		INIT_LIST_HEAD(&hugepage_alllists[i]);
+	}
 
 	for (i = 0; i < htlbpage_max; ++i) {
 		page = alloc_fresh_huge_page();
 		if (!page)
 			break;
 		spin_lock(&htlbpage_lock);
+		register_huge_page(page);
 		enqueue_huge_page(page);
 		spin_unlock(&htlbpage_lock);
 	}
