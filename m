Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313537AbSEEUxK>; Sun, 5 May 2002 16:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313557AbSEEUxJ>; Sun, 5 May 2002 16:53:09 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42249 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S313537AbSEEUxD>;
	Sun, 5 May 2002 16:53:03 -0400
Message-ID: <3CD59C39.68FB7E3E@zip.com.au>
Date: Sun, 05 May 2002 13:55:21 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 4/10] decouple swapper_space treatment from other address_spaces
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



swapper_space is different.  Its pages are locked during writeout, it
uses PAGE_SIZE rather than PAGE_CACHE_SIZE.  Converting swap to look
more like the other address_spaces is a separate project.  This patch
fully restores the old swap behaviour.

- Don't dirty swapcache page buffers in set_page_dirty().

  Fixes a problem where __free_pte() runs set_page_dirty() and then
  immediately runs ClearPageDirty().  The pages ends up clean, with
  dirty buffers, and is unfreeable.

- Hence, don't mark the page clean if its buffers are clean - swap
  does not have page/buffers dirty state coherency.


=====================================

--- 2.5.13/mm/page-writeback.c~clean-swap-page	Sun May  5 13:32:00 2002
+++ 2.5.13-akpm/mm/page-writeback.c	Sun May  5 13:32:36 2002
@@ -454,6 +454,9 @@ EXPORT_SYMBOL(write_one_page);
  *
  * FIXME: may need to call ->reservepage here as well.  That's rather up to the
  * address_space though.
+ *
+ * For now, we treat swapper_space specially.  It doesn't use the normal
+ * block a_ops.
  */
 int __set_page_dirty_buffers(struct page *page)
 {
@@ -470,7 +473,7 @@ int __set_page_dirty_buffers(struct page
 
 	spin_lock(&inode->i_bufferlist_lock);
 
-	if (page_has_buffers(page)) {
+	if (page_has_buffers(page) && !PageSwapCache(page)) {
 		struct buffer_head *head = page_buffers(page);
 		struct buffer_head *bh = head;
 
--- 2.5.13/fs/buffer.c~clean-swap-page	Sun May  5 13:32:00 2002
+++ 2.5.13-akpm/fs/buffer.c	Sun May  5 13:32:36 2002
@@ -2159,14 +2159,6 @@ static void check_ttfb_buffer(struct pag
  * total exclusion from __set_page_dirty_buffers().  That is obtained with
  * i_bufferlist_lock.
  *
- * Nobody should be calling try_to_free_buffers against a page which is
- * eligible for set_page_dirty() treatment anyway - the page is clearly
- * not freeable.  So we could just test page_count(page) here and complain
- * then scram if it's wrong.
- *
- * If any buffer is not uptodate then the entire page is set not uptodate,
- * as the partial uptodateness information is about to be lost.
- *
  * try_to_free_buffers() is non-blocking.
  */
 static inline int buffer_busy(struct buffer_head *bh)
@@ -2222,8 +2214,17 @@ int try_to_free_buffers(struct page *pag
 	inode = page->mapping->host;
 	spin_lock(&inode->i_bufferlist_lock);
 	ret = drop_buffers(page);
-	if (ret)
+	if (ret && !PageSwapCache(page)) {
+		/*
+		 * If the filesystem writes its buffers by hand (eg ext3)
+		 * then we can have clean buffers against a dirty page.  We
+		 * clean the page here; otherwise later reattachment of buffers
+		 * could encounter a non-uptodate page, which is unresolvable.
+		 * This only applies in the rare case where try_to_free_buffers
+		 * succeeds but the page is not freed.
+		 */
 		ClearPageDirty(page);
+	}
 	spin_unlock(&inode->i_bufferlist_lock);
 	return ret;
 }


-
