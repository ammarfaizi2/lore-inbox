Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316997AbSFAIld>; Sat, 1 Jun 2002 04:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315420AbSFAIkG>; Sat, 1 Jun 2002 04:40:06 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51466 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316995AbSFAIjy>;
	Sat, 1 Jun 2002 04:39:54 -0400
Message-ID: <3CF88924.6BB855E7@zip.com.au>
Date: Sat, 01 Jun 2002 01:43:16 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 11/16] swapcache bugfixes
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Fixes a few lock ranking bugs (and deadlocks) related to
swap_list_lock(), swap_device_lock(), mapping->page_lock and
mapping->private_lock.

- Cannot call block_flushpage->try_to_free_buffers() inside
  mapping->page_lock.  Because __set_page_dirty_buffers() takes
  ->page_lock inside ->private-lock.

- Cannot call swap_free->swap_list_lock/swap_device_lock inside
  mapping->page_lock because exclusive_swap_page() takes ->page_lock
  inside swap_info_get().


The patch also removes all the block_flushpage() calls from the swap
code in favour of a direct call to try_to_free_buffers().

The theory is that the page is locked, there is no I/O underway, nobody
else has access to the buffers so they MUST be freeable.  A bunch of
BUG() checks have been added, and unless someone manages to trigger
one, the "block_flushpage() inside spinlock" problem is fixed.


=====================================

--- 2.5.19/mm/swap_state.c~mfsc_deadlock	Sat Jun  1 01:18:11 2002
+++ 2.5.19-akpm/mm/swap_state.c	Sat Jun  1 01:18:11 2002
@@ -14,7 +14,7 @@
 #include <linux/init.h>
 #include <linux/pagemap.h>
 #include <linux/smp_lock.h>
-#include <linux/buffer_head.h>	/* for block_sync_page()/block_flushpage() */
+#include <linux/buffer_head.h>	/* block_sync_page()/try_to_free_buffers() */
 
 #include <asm/pgtable.h>
 
@@ -150,11 +150,15 @@ void delete_from_swap_cache(struct page 
 {
 	swp_entry_t entry;
 
-	if (!PageLocked(page))
+	/*
+	 * I/O should have completed and nobody can have a ref against the
+	 * page's buffers
+	 */
+	BUG_ON(!PageLocked(page));
+	BUG_ON(PageWriteback(page));
+	if (page_has_buffers(page) && !try_to_free_buffers(page))
 		BUG();
-
-	block_flushpage(page, 0);
-
+  
 	entry.val = page->index;
 
 	write_lock(&swapper_space.page_lock);
@@ -219,7 +223,15 @@ int move_from_swap_cache(struct page *pa
 	void **pslot;
 	int err;
 
-	if (!PageLocked(page))
+	/*
+	 * Drop the buffers now, before taking the page_lock.  Because
+	 * mapping->private_lock nests outside mapping->page_lock.
+	 * This "must" succeed.  The page is locked and all I/O has completed
+	 * and nobody else has a ref against its buffers.
+	 */
+	BUG_ON(!PageLocked(page));
+	BUG_ON(PageWriteback(page));
+	if (page_has_buffers(page) && !try_to_free_buffers(page))
 		BUG();
 
 	write_lock(&swapper_space.page_lock);
@@ -229,10 +241,8 @@ int move_from_swap_cache(struct page *pa
 	if (!err) {
 		swp_entry_t entry;
 
-		block_flushpage(page, 0);
 		entry.val = page->index;
 		__delete_from_swap_cache(page);
-		swap_free(entry);
 
 		*pslot = page;
 		page->flags &= ~(1 << PG_uptodate | 1 << PG_error |
@@ -248,11 +258,16 @@ int move_from_swap_cache(struct page *pa
 		/* fix that up */
 		list_del(&page->list);
 		list_add(&page->list, &mapping->dirty_pages);
+		write_unlock(&mapping->page_lock);
+		write_unlock(&swapper_space.page_lock);
+
+		/* Do this outside ->page_lock */
+		swap_free(entry);
+		return 0;
 	}
 
 	write_unlock(&mapping->page_lock);
 	write_unlock(&swapper_space.page_lock);
-
 	return err;
 }
 
--- 2.5.19/mm/swapfile.c~mfsc_deadlock	Sat Jun  1 01:18:11 2002
+++ 2.5.19-akpm/mm/swapfile.c	Sat Jun  1 01:18:12 2002
@@ -16,7 +16,7 @@
 #include <linux/namei.h>
 #include <linux/shm.h>
 #include <linux/blkdev.h>
-#include <linux/buffer_head.h>		/* for block_flushpage() */
+#include <linux/buffer_head.h>		/* for try_to_free_buffers() */
 
 #include <asm/pgtable.h>
 #include <linux/swapops.h>
@@ -326,7 +326,9 @@ int remove_exclusive_swap_page(struct pa
 	swap_info_put(p);
 
 	if (retval) {
-		block_flushpage(page, 0);
+		BUG_ON(PageWriteback(page));
+		if (page_has_buffers(page) && !try_to_free_buffers(page))
+			BUG();
 		swap_free(entry);
 		page_cache_release(page);
 	}
--- 2.5.19/mm/filemap.c~mfsc_deadlock	Sat Jun  1 01:18:11 2002
+++ 2.5.19-akpm/mm/filemap.c	Sat Jun  1 01:18:12 2002
@@ -53,7 +53,9 @@
  *  pagemap_lru_lock
  *  ->i_shared_lock		(vmtruncate)
  *    ->private_lock		(__free_pte->__set_page_dirty_buffers)
- *      ->mapping->page_lock
+ *      ->swap_list_lock
+ *        ->swap_device_lock	(exclusive_swap_page, others)
+ *          ->mapping->page_lock
  *      ->inode_lock		(__mark_inode_dirty)
  *        ->sb_lock		(fs/fs-writeback.c)
  */

-
