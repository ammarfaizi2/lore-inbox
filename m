Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316828AbSFQGwk>; Mon, 17 Jun 2002 02:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316821AbSFQGw3>; Mon, 17 Jun 2002 02:52:29 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31758 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316780AbSFQGtu>;
	Mon, 17 Jun 2002 02:49:50 -0400
Message-ID: <3D0D877F.8996BD6B@zip.com.au>
Date: Sun, 16 Jun 2002 23:53:51 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 18/19] allow GFP_NOFS allocators to perform swapcache writeout
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Requires the direct-to-BIO-for-swap patch)

One weakness which was introduced when the buffer LRU went away was
that GFP_NOFS allocations became equivalent to GFP_NOIO.  Because all
writeback goes via writepage/writepages, which requires entry into the
filesystem.

However now that swapout no longer calls bmap(), we can honour
GFP_NOFS's intent for swapcache pages.  So if the allocation request
specifies __GFP_IO and !__GFP_FS, we can wait on swapcache pages and we
can perform swapcache writeout.

This should strengthen the VM somewhat.




--- 2.5.22/mm/vmscan.c~GFP_IO-swap	Sun Jun 16 23:12:53 2002
+++ 2.5.22-akpm/mm/vmscan.c	Sun Jun 16 23:12:53 2002
@@ -391,7 +391,8 @@ shrink_cache(int nr_pages, zone_t *class
 	spin_lock(&pagemap_lru_lock);
 	while (--max_scan >= 0 &&
 			(entry = inactive_list.prev) != &inactive_list) {
-		struct page * page;
+		struct page *page;
+		int may_enter_fs;
 
 		if (need_resched()) {
 			spin_unlock(&pagemap_lru_lock);
@@ -426,10 +427,17 @@ shrink_cache(int nr_pages, zone_t *class
 			goto page_mapped;
 
 		/*
+		 * swap activity never enters the filesystem and is safe
+		 * for GFP_NOFS allocations.
+		 */
+		may_enter_fs = (gfp_mask & __GFP_FS) ||
+				(PageSwapCache(page) && (gfp_mask & __GFP_IO));
+
+		/*
 		 * IO in progress? Leave it at the back of the list.
 		 */
 		if (unlikely(PageWriteback(page))) {
-			if (gfp_mask & __GFP_FS) {
+			if (may_enter_fs) {
 				page_cache_get(page);
 				spin_unlock(&pagemap_lru_lock);
 				wait_on_page_writeback(page);
@@ -450,7 +458,7 @@ shrink_cache(int nr_pages, zone_t *class
 		mapping = page->mapping;
 
 		if (PageDirty(page) && is_page_cache_freeable(page) &&
-				page->mapping && (gfp_mask & __GFP_FS)) {
+				page->mapping && may_enter_fs) {
 			/*
 			 * It is not critical here to write it only if
 			 * the page is unmapped beause any direct writer
@@ -479,6 +487,15 @@ shrink_cache(int nr_pages, zone_t *class
 		 * If the page has buffers, try to free the buffer mappings
 		 * associated with this page. If we succeed we try to free
 		 * the page as well.
+		 *
+		 * We do this even if the page is PageDirty().
+		 * try_to_release_page() does not perform I/O, but it is
+		 * possible for a page to have PageDirty set, but it is actually
+		 * clean (all its buffers are clean).  This happens if the
+		 * buffers were written out directly, with submit_bh(). ext3
+		 * will do this, as well as the blockdev mapping. 
+		 * try_to_release_page() will discover that cleanness and will
+		 * drop the buffers and mark the page clean - it can be freed.
 		 */
 		if (PagePrivate(page)) {
 			spin_unlock(&pagemap_lru_lock);

-
