Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751390AbVKJBrT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbVKJBrT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 20:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751388AbVKJBrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 20:47:19 -0500
Received: from gold.veritas.com ([143.127.12.110]:20019 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1751385AbVKJBrQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 20:47:16 -0500
Date: Thu, 10 Nov 2005 01:46:04 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: reiserfs-dev@namesys.com, linux-kernel@vger.kernel.org
Subject: [PATCH 03/15] mm reiser4: revert page_private
In-Reply-To: <Pine.LNX.4.61.0511100139550.5814@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0511100144360.5814@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511100139550.5814@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 10 Nov 2005 01:47:15.0838 (UTC) FILETIME=[AD7D31E0:01C5E598]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Revert page_private: remove -mm tree's reiser4-page-private-fixes.patch

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 fs/reiser4/flush_queue.c                 |    2 +-
 fs/reiser4/jnode.c                       |   10 +++++-----
 fs/reiser4/page_cache.c                  |    2 +-
 fs/reiser4/page_cache.h                  |    2 +-
 fs/reiser4/plugin/file/tail_conversion.c |    2 +-
 fs/reiser4/txnmgr.c                      |    6 +++---
 6 files changed, 12 insertions(+), 12 deletions(-)

--- mm02/fs/reiser4/flush_queue.c	2005-11-07 07:39:46.000000000 +0000
+++ mm03/fs/reiser4/flush_queue.c	2005-11-09 14:38:18.000000000 +0000
@@ -427,7 +427,7 @@ end_io_handler(struct bio *bio, unsigned
 
 			assert("zam-736", pg != NULL);
 			assert("zam-736", PagePrivate(pg));
-			node = jprivate(pg);
+			node = (jnode *) (pg->private);
 
 			JF_CLR(node, JNODE_WRITEBACK);
 		}
--- mm02/fs/reiser4/jnode.c	2005-11-07 07:39:46.000000000 +0000
+++ mm03/fs/reiser4/jnode.c	2005-11-09 14:38:18.000000000 +0000
@@ -38,12 +38,12 @@
  *     page_address().
  *
  *     jnode and page are attached to each other by jnode_attach_page(). This
- *     function places pointer to jnode in page_private(), sets PG_private flag
+ *     function places pointer to jnode in page->private, sets PG_private flag
  *     and increments page counter.
  *
  *     Opposite operation is performed by page_clear_jnode().
  *
- *     jnode->pg is protected by jnode spin lock, and page_private() is
+ *     jnode->pg is protected by jnode spin lock, and page->private is
  *     protected by page lock. See comment at the top of page_cache.c for
  *     more.
  *
@@ -664,7 +664,7 @@ void jnode_attach_page(jnode * node, str
 	assert("nikita-2060", node != NULL);
 	assert("nikita-2061", pg != NULL);
 
-	assert("nikita-2050", page_private(pg) == 0ul);
+	assert("nikita-2050", pg->private == 0ul);
 	assert("nikita-2393", !PagePrivate(pg));
 	assert("vs-1741", node->pg == NULL);
 
@@ -672,7 +672,7 @@ void jnode_attach_page(jnode * node, str
 	assert("nikita-2397", spin_jnode_is_locked(node));
 
 	page_cache_get(pg);
-	set_page_private(pg, (unsigned long)node);
+	pg->private = (unsigned long)node;
 	node->pg = pg;
 	SetPagePrivate(pg);
 }
@@ -689,7 +689,7 @@ void page_clear_jnode(struct page *page,
 	assert("nikita-3551", !PageWriteback(page));
 
 	JF_CLR(node, JNODE_PARSED);
-	set_page_private(page, 0ul);
+	page->private = 0ul;
 	ClearPagePrivate(page);
 	node->pg = NULL;
 	page_cache_release(page);
--- mm02/fs/reiser4/page_cache.c	2005-11-07 07:39:46.000000000 +0000
+++ mm03/fs/reiser4/page_cache.c	2005-11-09 14:38:18.000000000 +0000
@@ -753,7 +753,7 @@ void print_page(const char *prefix, stru
 	}
 	printk("%s: page index: %lu mapping: %p count: %i private: %lx\n",
 	       prefix, page->index, page->mapping, page_count(page),
-	       page_private(page));
+	       page->private);
 	printk("\tflags: %s%s%s%s %s%s%s %s%s%s %s%s\n",
 	       page_flag_name(page, PG_locked), page_flag_name(page, PG_error),
 	       page_flag_name(page, PG_referenced), page_flag_name(page,
--- mm02/fs/reiser4/page_cache.h	2005-11-07 07:39:46.000000000 +0000
+++ mm03/fs/reiser4/page_cache.h	2005-11-09 14:38:18.000000000 +0000
@@ -30,7 +30,7 @@ static inline void lock_and_wait_page_wr
 		reiser4_wait_page_writeback(page);
 }
 
-#define jprivate(page) ((jnode *) page_private(page))
+#define jprivate(page) ((jnode *) (page)->private)
 
 extern int page_io(struct page *page, jnode * node, int rw, int gfp);
 extern void drop_page(struct page *page);
--- mm02/fs/reiser4/plugin/file/tail_conversion.c	2005-11-07 07:39:46.000000000 +0000
+++ mm03/fs/reiser4/plugin/file/tail_conversion.c	2005-11-09 14:38:18.000000000 +0000
@@ -670,7 +670,7 @@ int extent2tail(unix_file_info_t * uf_in
 		/* page is already detached from jnode and mapping. */
 		assert("vs-1086", page->mapping == NULL);
 		assert("nikita-2690",
-		       (!PagePrivate(page) && page_private(page) == 0));
+		       (!PagePrivate(page) && page->private == 0));
 		/* waiting for writeback completion with page lock held is
 		 * perfectly valid. */
 		wait_on_page_writeback(page);
--- mm02/fs/reiser4/txnmgr.c	2005-11-07 07:39:46.000000000 +0000
+++ mm03/fs/reiser4/txnmgr.c	2005-11-09 14:38:18.000000000 +0000
@@ -2331,7 +2331,7 @@ void uncapture_page(struct page *pg)
 
 	reiser4_wait_page_writeback(pg);
 
-	node = jprivate(pg);
+	node = (jnode *) (pg->private);
 	BUG_ON(node == NULL);
 
 	LOCK_JNODE(node);
@@ -3603,14 +3603,14 @@ static void swap_jnode_pages(jnode * nod
 	copy->pg = node->pg;
 	copy->data = page_address(copy->pg);
 	jnode_set_block(copy, jnode_get_block(node));
-	set_page_private(copy->pg, (unsigned long)copy);
+	copy->pg->private = (unsigned long)copy;
 
 	/* attach new page to jnode */
 	assert("vs-1412", !PagePrivate(new_page));
 	page_cache_get(new_page);
 	node->pg = new_page;
 	node->data = page_address(new_page);
-	set_page_private(new_page, (unsigned long)node);
+	new_page->private = (unsigned long)node;
 	SetPagePrivate(new_page);
 
 	{
