Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261328AbSJCVIS>; Thu, 3 Oct 2002 17:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261333AbSJCVIR>; Thu, 3 Oct 2002 17:08:17 -0400
Received: from holomorphy.com ([66.224.33.161]:57034 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261328AbSJCVIR>;
	Thu, 3 Oct 2002 17:08:17 -0400
Date: Thu, 3 Oct 2002 14:13:13 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, akpm@zip.com.au, rohit.seth@intel.com
Subject: alloc_hugetlb_page() fails to kmap() memory while zeroing
Message-ID: <20021003211313.GB12432@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@zip.com.au,
	rohit.seth@intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes alloc_hugetlb_page() kmap() the memory it's zeroing,
and cleans up a tiny bit of list handling on the side. Without this
fix, it oopses every time it's called.


Bill

diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5/arch/i386/mm/hugetlbpage.c hugetlbfs/arch/i386/mm/hugetlbpage.c
--- linux-2.5/arch/i386/mm/hugetlbpage.c	Wed Oct  2 20:14:31 2002
+++ hugetlbfs/arch/i386/mm/hugetlbpage.c	Wed Oct  2 22:00:54 2002
@@ -44,24 +44,22 @@
 static struct page *
 alloc_hugetlb_page(void)
 {
-	struct list_head *curr, *head;
+	int i;
 	struct page *page;
 
 	spin_lock(&htlbpage_lock);
-
-	head = &htlbpage_freelist;
-	curr = head->next;
-
-	if (curr == head) {
+	if (list_empty(&htlbpage_freelist)) {
 		spin_unlock(&htlbpage_lock);
 		return NULL;
 	}
-	page = list_entry(curr, struct page, list);
-	list_del(curr);
+
+	page = list_entry(htlbpage_freelist.next, struct page, list);
+	list_del(&page->list);
 	htlbpagemem--;
 	spin_unlock(&htlbpage_lock);
 	set_page_count(page, 1);
-	memset(page_address(page), 0, HPAGE_SIZE);
+	for (i = 0; i < (HPAGE_SIZE/PAGE_SIZE); ++i)
+		clear_highpage(&page[i]);
 	return page;
 }
 
