Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261650AbVFFT4f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261650AbVFFT4f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 15:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261639AbVFFTxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 15:53:10 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:51926 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261650AbVFFTvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 15:51:23 -0400
Date: Mon, 6 Jun 2005 20:52:22 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Nikita Danilov <nikita@clusterfs.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] bad_page: clear reclaim and slab
Message-ID: <Pine.LNX.4.61.0506062051100.5000@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-OriginalArrivalTime: 06 Jun 2005 19:51:21.0980 (UTC) 
    FILETIME=[1D280BC0:01C56AD1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since free_pages_check complains if PG_reclaim or PG_slab is set, bad_page
ought to clear them to avoid repetitive reports (Nikita noticed this too).
Let prep_new_page check page_count and PG_slab as free_pages_check does.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/page_alloc.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

--- 2.6.12-rc6/mm/page_alloc.c	2005-05-25 18:09:21.000000000 +0100
+++ linux/mm/page_alloc.c	2005-06-04 20:41:55.000000000 +0100
@@ -105,11 +105,13 @@ static void bad_page(const char *functio
 	printk(KERN_EMERG "Backtrace:\n");
 	dump_stack();
 	printk(KERN_EMERG "Trying to fix it up, but a reboot is needed\n");
-	page->flags &= ~(1 << PG_private	|
+	page->flags &= ~(1 << PG_lru	|
+			1 << PG_private |
 			1 << PG_locked	|
-			1 << PG_lru	|
 			1 << PG_active	|
 			1 << PG_dirty	|
+			1 << PG_reclaim |
+			1 << PG_slab    |
 			1 << PG_swapcache |
 			1 << PG_writeback);
 	set_page_count(page, 0);
@@ -440,14 +442,17 @@ void set_page_refs(struct page *page, in
  */
 static void prep_new_page(struct page *page, int order)
 {
-	if (page->mapping || page_mapcount(page) ||
-	    (page->flags & (
+	if (	page_mapcount(page) ||
+		page->mapping != NULL ||
+		page_count(page) != 0 ||
+		(page->flags & (
+			1 << PG_lru	|
 			1 << PG_private	|
 			1 << PG_locked	|
-			1 << PG_lru	|
 			1 << PG_active	|
 			1 << PG_dirty	|
 			1 << PG_reclaim	|
+			1 << PG_slab    |
 			1 << PG_swapcache |
 			1 << PG_writeback )))
 		bad_page(__FUNCTION__, page);
