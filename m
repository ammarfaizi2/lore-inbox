Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265246AbSKKSzI>; Mon, 11 Nov 2002 13:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265553AbSKKSzI>; Mon, 11 Nov 2002 13:55:08 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:3323 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id <S265246AbSKKSzH>; Mon, 11 Nov 2002 13:55:07 -0500
Date: Mon, 11 Nov 2002 19:02:55 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] swap writepages swizzled
Message-ID: <Pine.LNX.4.44.0211111826590.1278-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tmpfs failed fsx+swapout tests after many hours, a page found zeroed.
Not a truncate problem, but mirror image of earlier truncate problems:
swap goes through mpage_writepages, which must therefore allow for a
sudden swizzle back to file identity.

Second time this caught us, so I've audited the tree for other places
which might be surprised by such swizzling.  The only others I found
were (perhaps) in the parisc and sparc64 flush_dcache_page called
from do_generic_mapping_read on a looped tmpfs file which is also
mmapped; but that's a very marginal case, I wanted to understand it
better before making any edit, and now realize that hch's sendfile
in loop eliminates it (now go through do_shmem_file_read instead:
similar but crucially this locks the page when raising its count,
which is enough to keep vmscan from interfering).

Patch applies to 2.5.47, or 2.5.47-mm1 with offsets and fuzz.
Only the patch to mpage.c is required: I think it's worth adding
BUG_ON checks in __set_page_dirty_nobuffers and get_swap_bio,
just leave those out if you disagree; similarly, optional patch
to try_to_free_buffers, once upon a time swap came that way,
happily ever after it doesn't, so the test seems misleading.

Hugh

--- 2.5.47/fs/mpage.c	Mon Nov 11 08:26:55 2002
+++ linux/fs/mpage.c	Mon Nov 11 17:01:27 2002
@@ -587,12 +587,19 @@
 		page_cache_get(page);
 		write_unlock(&mapping->page_lock);
 
+		/*
+		 * At this point we hold neither mapping->page_lock nor
+		 * lock on the page itself: the page may be truncated or
+		 * invalidated (changing page->mapping to NULL), or even
+		 * swizzled back from swapper_space to tmpfs file mapping.
+		 */
+
 		lock_page(page);
 
 		if (sync)
 			wait_on_page_writeback(page);
 
-		if (page->mapping && !PageWriteback(page) &&
+		if (page->mapping == mapping && !PageWriteback(page) &&
 					test_clear_page_dirty(page)) {
 			if (writepage) {
 				ret = (*writepage)(page);
--- 2.5.47/mm/page-writeback.c	Thu Oct 31 05:40:06 2002
+++ linux/mm/page-writeback.c	Mon Nov 11 17:01:27 2002
@@ -613,6 +613,7 @@
 		if (mapping) {
 			write_lock(&mapping->page_lock);
 			if (page->mapping) {	/* Race with truncate? */
+				BUG_ON(page->mapping != mapping);
 				if (!mapping->backing_dev_info->memory_backed)
 					inc_page_state(nr_dirty);
 				list_del(&page->list);
--- 2.5.47/mm/page_io.c	Mon Oct  7 20:37:50 2002
+++ linux/mm/page_io.c	Mon Nov 11 17:01:27 2002
@@ -30,6 +30,7 @@
 		struct swap_info_struct *sis;
 		swp_entry_t entry;
 
+		BUG_ON(!PageSwapCache(page));
 		entry.val = page->index;
 		sis = get_swap_info_struct(swp_type(entry));
 
--- 2.5.47/fs/buffer.c	Mon Nov 11 08:26:55 2002
+++ linux/fs/buffer.c	Mon Nov 11 17:01:27 2002
@@ -2496,7 +2496,7 @@
 
 	spin_lock(&mapping->private_lock);
 	ret = drop_buffers(page, &buffers_to_free);
-	if (ret && !PageSwapCache(page)) {
+	if (ret) {
 		/*
 		 * If the filesystem writes its buffers by hand (eg ext3)
 		 * then we can have clean buffers against a dirty page.  We

