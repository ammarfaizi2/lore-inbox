Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261540AbUJXQAc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261540AbUJXQAc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 12:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261548AbUJXP7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 11:59:31 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:14411 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261523AbUJXP41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 11:56:27 -0400
Date: Sun, 24 Oct 2004 16:56:04 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Hans Reiser <reiser@namesys.com>, David Howells <dhowells@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] reiser4 cachefs delete_from_page_cache
In-Reply-To: <Pine.LNX.4.44.0410241651540.12023-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0410241654360.12023-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace reiser4 and cachefs remove_from_page_cache,page_cache_release
by delete_from_page_cache.  Sorry, but this patch is incomplete:
reiser4-export-remove_from_page_cache.patch also needs updating (easiest
just to edit the patch itself), I'd better leave that part to you...

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---
 fs/cachefs/block.c      |    3 +--
 fs/reiser4/page_cache.c |   10 +++-------
 2 files changed, 4 insertions(+), 9 deletions(-)

--- 2.6.9-mm1/fs/cachefs/block.c	2004-10-22 13:07:38.000000000 +0100
+++ linux/fs/cachefs/block.c	2004-10-23 21:15:09.735234048 +0100
@@ -392,8 +392,7 @@ int cachefs_block_cow(struct cachefs_sup
 		page = xchg(&block->page, NULL);
 
 		mapping->a_ops->releasepage(page, GFP_NOFS);
-		remove_from_page_cache(page);
-		page_cache_release(page);
+		delete_from_page_cache(page);
 		page = NULL;
 
 		ret = add_to_page_cache_lru(newpage, mapping, block->bix,
--- 2.6.9-mm1/fs/reiser4/page_cache.c	2004-10-22 13:07:42.000000000 +0100
+++ linux/fs/reiser4/page_cache.c	2004-10-23 21:16:31.336828720 +0100
@@ -759,13 +759,9 @@ drop_page(struct page *page)
 #if defined(PG_skipped)
 	ClearPageSkipped(page);
 #endif
-	if (page->mapping != NULL) {
-		remove_from_page_cache(page);
-		unlock_page(page);
-		/* page removed from the mapping---decrement page counter */
-		page_cache_release(page);
-	} else
-		unlock_page(page);
+	if (page->mapping != NULL)
+		delete_from_page_cache(page);
+	unlock_page(page);
 }
 
 

