Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264265AbTCYWLr>; Tue, 25 Mar 2003 17:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262586AbTCYWLB>; Tue, 25 Mar 2003 17:11:01 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:60408 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id <S264265AbTCYWKi>; Tue, 25 Mar 2003 17:10:38 -0500
Date: Tue, 25 Mar 2003 22:23:43 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] swap 13/13 may_enter_fs?
In-Reply-To: <Pine.LNX.4.44.0303252209070.12636-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0303252222530.12636-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

shrink_list's may_enter_fs (may_write_page would be a better name)
currently reflects that swapcache page I/O won't suffer from FS
complications, so can be done if __GFP_IO without __GFP_FS; but
the same is true of a tmpfs page (which is just this stage away
from being a swapcache page), so check bdi->memory_backed instead.

--- swap12/mm/vmscan.c	Tue Mar 25 20:43:07 2003
+++ swap13/mm/vmscan.c	Tue Mar 25 20:45:08 2003
@@ -235,7 +235,6 @@
 	pagevec_init(&freed_pvec, 1);
 	while (!list_empty(page_list)) {
 		struct page *page;
-		int may_enter_fs;
 
 		page = list_entry(page_list->prev, struct page, lru);
 		list_del(&page->lru);
@@ -248,8 +247,6 @@
 			(*nr_mapped)++;
 
 		BUG_ON(PageActive(page));
-		may_enter_fs = (gfp_mask & __GFP_FS) ||
-				(PageSwapCache(page) && (gfp_mask & __GFP_IO));
 
 		if (PageWriteback(page))
 			goto keep_locked;
@@ -315,15 +312,19 @@
 		 * See swapfile.c:page_queue_congested().
 		 */
 		if (PageDirty(page)) {
+			struct backing_dev_info *bdi;
+
 			if (!is_page_cache_freeable(page))
 				goto keep_locked;
 			if (!mapping)
 				goto keep_locked;
 			if (mapping->a_ops->writepage == NULL)
 				goto activate_locked;
-			if (!may_enter_fs)
+			bdi = mapping->backing_dev_info;
+			if (!(gfp_mask & (bdi->memory_backed?
+					__GFP_IO: __GFP_FS)))
 				goto keep_locked;
-			if (!may_write_to_queue(mapping->backing_dev_info))
+			if (!may_write_to_queue(bdi))
 				goto keep_locked;
 			write_lock(&mapping->page_lock);
 			if (test_clear_page_dirty(page)) {

