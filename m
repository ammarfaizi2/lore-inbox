Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317327AbSFLDLw>; Tue, 11 Jun 2002 23:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317329AbSFLDLv>; Tue, 11 Jun 2002 23:11:51 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:45489 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S317327AbSFLDLu>; Tue, 11 Jun 2002 23:11:50 -0400
Date: Wed, 12 Jun 2002 04:11:37 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: [PATCH] swap 4/4 redundant SwapCache checks
In-Reply-To: <Pine.LNX.4.21.0206120359270.1036-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.21.0206120409060.1036-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PageSwapCache tests whether mapping is &swapper_space, so it's just
a waste of time for __free_pages_ok, balance_classzone, rw_swap_page
and rw_swap_page_nolock to check both mapping and PageSwapCache.  And
__free_pages_ok just did lru_cache_del if PageLRU, so don't recheck it.

--- 2.4.19-pre10/mm/page_alloc.c	Tue Jun  4 13:54:19 2002
+++ linux/mm/page_alloc.c	Tue Jun 11 19:02:30 2002
@@ -88,12 +88,8 @@
 		BUG();
 	if (!VALID_PAGE(page))
 		BUG();
-	if (PageSwapCache(page))
-		BUG();
 	if (PageLocked(page))
 		BUG();
-	if (PageLRU(page))
-		BUG();
 	if (PageActive(page))
 		BUG();
 	page->flags &= ~((1<<PG_referenced) | (1<<PG_dirty));
@@ -280,8 +276,6 @@
 					if (page->mapping)
 						BUG();
 					if (!VALID_PAGE(page))
-						BUG();
-					if (PageSwapCache(page))
 						BUG();
 					if (PageLocked(page))
 						BUG();
--- 2.4.19-pre10/mm/page_io.c	Tue Jun 11 19:02:30 2002
+++ linux/mm/page_io.c	Tue Jun 11 19:02:30 2002
@@ -97,8 +97,6 @@
 		PAGE_BUG(page);
 	if (!PageSwapCache(page))
 		PAGE_BUG(page);
-	if (page->mapping != &swapper_space)
-		PAGE_BUG(page);
 	if (!rw_swap_page_base(rw, entry, page))
 		UnlockPage(page);
 }
@@ -113,8 +111,6 @@
 	struct page *page = virt_to_page(buf);
 	
 	if (!PageLocked(page))
-		PAGE_BUG(page);
-	if (PageSwapCache(page))
 		PAGE_BUG(page);
 	if (page->mapping)
 		PAGE_BUG(page);

