Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261532AbUJXQqe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261532AbUJXQqe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 12:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261524AbUJXQqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 12:46:33 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:56643 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261546AbUJXPyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 11:54:47 -0400
Date: Sun, 24 Oct 2004 16:54:19 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Hans Reiser <reiser@namesys.com>, David Howells <dhowells@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] delete_from_page_cache
Message-ID: <Pine.LNX.4.44.0410241651540.12023-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Both reiser4 and cachefs want remove_from_page_cache to be exported.
Before that, could we please make it symmetric with add_to_page_cache,
add_to_swap_cache and delete_from_swap_cache? by doing its own
page_cache_release, instead of commenting that each time it's called.
But safer if we change the name too: delete_from_page_cache.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---
This patch is against 2.6.10-rc1, which doesn't include reiser4 and
cachefs.  The next patch is against 2.6.9-mm1 and patches those.
But I can understand if you ignore both patches as a waste of time.

 fs/hugetlbfs/inode.c    |    3 +--
 include/linux/pagemap.h |    2 +-
 mm/filemap.c            |    7 +++----
 mm/swap_state.c         |    3 +--
 mm/truncate.c           |    3 +--
 5 files changed, 7 insertions(+), 11 deletions(-)

--- 2.6.10-rc1/fs/hugetlbfs/inode.c	2004-10-18 22:57:03.000000000 +0100
+++ linux/fs/hugetlbfs/inode.c	2004-10-23 20:43:24.000000000 +0100
@@ -168,8 +168,7 @@ void truncate_huge_page(struct page *pag
 {
 	clear_page_dirty(page);
 	ClearPageUptodate(page);
-	remove_from_page_cache(page);
-	put_page(page);
+	delete_from_page_cache(page);
 }
 
 void truncate_hugepages(struct address_space *mapping, loff_t lstart)
--- 2.6.10-rc1/include/linux/pagemap.h	2004-10-18 22:55:54.000000000 +0100
+++ linux/include/linux/pagemap.h	2004-10-23 20:43:24.000000000 +0100
@@ -95,7 +95,7 @@ int add_to_page_cache(struct page *page,
 				unsigned long index, int gfp_mask);
 int add_to_page_cache_lru(struct page *page, struct address_space *mapping,
 				unsigned long index, int gfp_mask);
-extern void remove_from_page_cache(struct page *page);
+extern void delete_from_page_cache(struct page *page);
 extern void __remove_from_page_cache(struct page *page);
 
 extern atomic_t nr_pagecache;
--- 2.6.10-rc1/mm/filemap.c	2004-10-23 12:44:13.000000000 +0100
+++ linux/mm/filemap.c	2004-10-23 20:43:24.000000000 +0100
@@ -119,16 +119,15 @@ void __remove_from_page_cache(struct pag
 	pagecache_acct(-1);
 }
 
-void remove_from_page_cache(struct page *page)
+void delete_from_page_cache(struct page *page)
 {
 	struct address_space *mapping = page->mapping;
 
-	if (unlikely(!PageLocked(page)))
-		PAGE_BUG(page);
-
+	BUG_ON(!PageLocked(page));
 	spin_lock_irq(&mapping->tree_lock);
 	__remove_from_page_cache(page);
 	spin_unlock_irq(&mapping->tree_lock);
+	page_cache_release(page);	/* drop pagecache ref */
 }
 
 static int sync_page(void *word)
--- 2.6.10-rc1/mm/swap_state.c	2004-10-18 22:56:29.000000000 +0100
+++ linux/mm/swap_state.c	2004-10-23 20:43:24.000000000 +0100
@@ -227,8 +227,7 @@ int move_to_swap_cache(struct page *page
 {
 	int err = __add_to_swap_cache(page, entry, GFP_ATOMIC);
 	if (!err) {
-		remove_from_page_cache(page);
-		page_cache_release(page);	/* pagecache ref */
+		delete_from_page_cache(page);
 		if (!swap_duplicate(entry))
 			BUG();
 		SetPageDirty(page);
--- 2.6.10-rc1/mm/truncate.c	2004-10-23 12:44:13.000000000 +0100
+++ linux/mm/truncate.c	2004-10-23 20:43:24.000000000 +0100
@@ -54,8 +54,7 @@ truncate_complete_page(struct address_sp
 	clear_page_dirty(page);
 	ClearPageUptodate(page);
 	ClearPageMappedToDisk(page);
-	remove_from_page_cache(page);
-	page_cache_release(page);	/* pagecache ref */
+	delete_from_page_cache(page);
 }
 
 /*

