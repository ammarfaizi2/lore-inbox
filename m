Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264838AbSJOVGX>; Tue, 15 Oct 2002 17:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264851AbSJOVFs>; Tue, 15 Oct 2002 17:05:48 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:60395 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id <S264838AbSJOVFE>; Tue, 15 Oct 2002 17:05:04 -0400
Date: Tue, 15 Oct 2002 22:11:44 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: William Lee Irwin III <wli@holomorphy.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] fewer unlikely tests
Message-ID: <Pine.LNX.4.44.0210152210030.1521-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Occasionally I worry about all those BUG_ON tests we keep adding into
page_alloc.c.  This patch does one preliminary test of all the flags
before trying individually.  Maybe you consider this in bad taste,
or maybe you think it's worthwhile: as you wish.

--- 2.5.42-mm3/mm/page_alloc.c	Tue Oct 15 06:43:41 2002
+++ linux/mm/page_alloc.c	Tue Oct 15 13:14:35 2002
@@ -125,12 +125,19 @@
 
 static void free_pages_check(struct page *page)
 {
-	BUG_ON(PageLRU(page));
-	BUG_ON(PagePrivate(page));
-	BUG_ON(page->mapping != NULL);
-	BUG_ON(PageLocked(page));
-	BUG_ON(PageActive(page));
-	BUG_ON(PageWriteback(page));
+	BUG_ON(page->mapping);
+	if (unlikely(page->flags & (
+		1 << PG_lru	|
+		1 << PG_private |
+		1 << PG_locked	|
+		1 << PG_active	|
+		1 << PG_writeback ))) {
+		BUG_ON(PageLRU(page));
+		BUG_ON(PagePrivate(page));
+		BUG_ON(PageLocked(page));
+		BUG_ON(PageActive(page));
+		BUG_ON(PageWriteback(page));
+	}
 	BUG_ON(page->pte.direct != 0);
 	if (PageDirty(page))
 		ClearPageDirty(page);
@@ -204,12 +211,20 @@
 static struct page *prep_new_page(struct page *page)
 {
 	BUG_ON(page->mapping);
-	BUG_ON(PagePrivate(page));
-	BUG_ON(PageLocked(page));
-	BUG_ON(PageLRU(page));
-	BUG_ON(PageActive(page));
-	BUG_ON(PageDirty(page));
-	BUG_ON(PageWriteback(page));
+	if (unlikely(page->flags & (
+		1 << PG_private	|
+		1 << PG_locked	|
+		1 << PG_lru	|
+		1 << PG_active	|
+		1 << PG_dirty	|
+		1 << PG_writeback ))) {
+		BUG_ON(PagePrivate(page));
+		BUG_ON(PageLocked(page));
+		BUG_ON(PageLRU(page));
+		BUG_ON(PageActive(page));
+		BUG_ON(PageDirty(page));
+		BUG_ON(PageWriteback(page));
+	}
 	BUG_ON(page->pte.direct != 0);
 	page->flags &= ~(1 << PG_uptodate | 1 << PG_error |
 			1 << PG_referenced | 1 << PG_arch_1 |

