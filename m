Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932648AbVIMOdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932648AbVIMOdG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 10:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932651AbVIMOdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 10:33:06 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:61351 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S932648AbVIMOdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 10:33:05 -0400
Date: Tue, 13 Sep 2005 16:34:44 +0200
From: Jan Kara <jack@suse.cz>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix unmapped buffers in transaction's lists
Message-ID: <20050913143443.GK30108@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hi,

  attached patch fixes the problem (BUG 4964) with unmapped buffers in
transaction's t_sync_data list. The problem is we need to call
filesystem's own invalidatepage() from block_write_full_page().
Please apply - the patch is against 2.6.13-mm1 so it should apply fine
against any recent kernel (both -mm and Linus's).

								Honza

--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="jbd-2.6.13-mm1-1-invalidatepage.diff"


  block_write_full_page() must call filesystem's invalidatepage().
Otherwise following nasty race can happen:

   proc 1                                        proc 2
   ------                                        ------
- write some new data to 'offset'
  => bh gets to the transactions data list
                                              - starts truncate
                                                => i_size set to new size
- mpage_writepages()
  - ext3_ordered_writepage() to 'offset'
    - block_write_full_page()
      - page->index > end_index+1
        - block_invalidatepage()
          - discard_buffer()
            - clear_buffer_mapped()

- commit triggers and finds unmapped buffer - BOOM!

Signed-off-by: Jan Kara <jack@suse.cz>

diff -rupX /home/jack/.kerndiffexclude linux-2.6.13-mm1/fs/buffer.c linux-2.6.13-mm1-1-invalidatepage/fs/buffer.c
--- linux-2.6.13-mm1/fs/buffer.c	2005-09-11 22:49:06.000000000 +0200
+++ linux-2.6.13-mm1-1-invalidatepage/fs/buffer.c	2005-09-16 22:06:34.000000000 +0200
@@ -1637,6 +1637,15 @@ out:
 }
 EXPORT_SYMBOL(block_invalidatepage);
 
+int do_invalidatepage(struct page *page, unsigned long offset)
+{
+	int (*invalidatepage)(struct page *, unsigned long);
+	invalidatepage = page->mapping->a_ops->invalidatepage;
+	if (invalidatepage == NULL)
+		invalidatepage = block_invalidatepage;
+	return (*invalidatepage)(page, offset);
+}
+
 /*
  * We attach and possibly dirty the buffers atomically wrt
  * __set_page_dirty_buffers() via private_lock.  try_to_free_buffers
@@ -2696,7 +2705,7 @@ int block_write_full_page(struct page *p
 		 * they may have been added in ext3_writepage().  Make them
 		 * freeable here, so the page does not leak.
 		 */
-		block_invalidatepage(page, 0);
+		do_invalidatepage(page, 0);
 		unlock_page(page);
 		return 0; /* don't care */
 	}
diff -rupX /home/jack/.kerndiffexclude linux-2.6.13-mm1/include/linux/buffer_head.h linux-2.6.13-mm1-1-invalidatepage/include/linux/buffer_head.h
--- linux-2.6.13-mm1/include/linux/buffer_head.h	2005-09-11 22:42:08.000000000 +0200
+++ linux-2.6.13-mm1-1-invalidatepage/include/linux/buffer_head.h	2005-09-16 22:01:44.000000000 +0200
@@ -190,6 +190,7 @@ extern int buffer_heads_over_limit;
  */
 int try_to_release_page(struct page * page, int gfp_mask);
 int block_invalidatepage(struct page *page, unsigned long offset);
+int do_invalidatepage(struct page *page, unsigned long offset);
 int block_write_full_page(struct page *page, get_block_t *get_block,
 				struct writeback_control *wbc);
 int block_read_full_page(struct page*, get_block_t*);
diff -rupX /home/jack/.kerndiffexclude linux-2.6.13-mm1/mm/truncate.c linux-2.6.13-mm1-1-invalidatepage/mm/truncate.c
--- linux-2.6.13-mm1/mm/truncate.c	2005-09-11 22:49:25.000000000 +0200
+++ linux-2.6.13-mm1-1-invalidatepage/mm/truncate.c	2005-09-16 22:06:19.000000000 +0200
@@ -13,18 +13,9 @@
 #include <linux/pagemap.h>
 #include <linux/pagevec.h>
 #include <linux/buffer_head.h>	/* grr. try_to_release_page,
-				   block_invalidatepage */
+				   do_invalidatepage */
 
 
-static int do_invalidatepage(struct page *page, unsigned long offset)
-{
-	int (*invalidatepage)(struct page *, unsigned long);
-	invalidatepage = page->mapping->a_ops->invalidatepage;
-	if (invalidatepage == NULL)
-		invalidatepage = block_invalidatepage;
-	return (*invalidatepage)(page, offset);
-}
-
 static inline void truncate_partial_page(struct page *page, unsigned partial)
 {
 	memclear_highpage_flush(page, partial, PAGE_CACHE_SIZE-partial);

--u3/rZRmxL6MmkK24--
