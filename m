Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315282AbSGDXuU>; Thu, 4 Jul 2002 19:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315277AbSGDXsz>; Thu, 4 Jul 2002 19:48:55 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48141 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315259AbSGDXrC>;
	Thu, 4 Jul 2002 19:47:02 -0400
Message-ID: <3D24E06D.8B7C1FCA@zip.com.au>
Date: Thu, 04 Jul 2002 16:55:25 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 26/27] reduce lock contention in try_to_free_buffers()
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



The blockdev mapping's private_lock is fairly contended.  The buffer
LRU cache fixed a lot of that, but under page replacement load,
try_to_free_buffers is still showing up.

Moving the freeing of buffer_heads outside the lock reduces contention
in there by 30%.


 buffer.c |   24 +++++++++++++++++++-----
 1 files changed, 19 insertions(+), 5 deletions(-)

--- 2.5.24/fs/buffer.c~ttfb_contention	Thu Jul  4 16:17:34 2002
+++ 2.5.24-akpm/fs/buffer.c	Thu Jul  4 16:17:34 2002
@@ -2472,7 +2472,8 @@ static inline int buffer_busy(struct buf
 		(bh->b_state & ((1 << BH_Dirty) | (1 << BH_Lock)));
 }
 
-static /*inline*/ int drop_buffers(struct page *page)
+static inline int
+drop_buffers(struct page *page, struct buffer_head **buffers_to_free)
 {
 	struct buffer_head *head = page_buffers(page);
 	struct buffer_head *bh;
@@ -2496,9 +2497,9 @@ static /*inline*/ int drop_buffers(struc
 
 		if (!list_empty(&bh->b_assoc_buffers))
 			__remove_assoc_queue(bh);
-		free_buffer_head(bh);
 		bh = next;
 	} while (bh != head);
+	*buffers_to_free = head;
 	__clear_page_buffers(page);
 	return 1;
 failed:
@@ -2508,17 +2509,20 @@ failed:
 int try_to_free_buffers(struct page *page)
 {
 	struct address_space * const mapping = page->mapping;
+	struct buffer_head *buffers_to_free = NULL;
 	int ret = 0;
 
 	BUG_ON(!PageLocked(page));
 	if (PageWriteback(page))
 		return 0;
 
-	if (mapping == NULL)		/* swapped-in anon page */
-		return drop_buffers(page);
+	if (mapping == NULL) {		/* swapped-in anon page */
+		ret = drop_buffers(page, &buffers_to_free);
+		goto out;
+	}
 
 	spin_lock(&mapping->private_lock);
-	ret = drop_buffers(page);
+	ret = drop_buffers(page, &buffers_to_free);
 	if (ret && !PageSwapCache(page)) {
 		/*
 		 * If the filesystem writes its buffers by hand (eg ext3)
@@ -2531,6 +2535,16 @@ int try_to_free_buffers(struct page *pag
 		ClearPageDirty(page);
 	}
 	spin_unlock(&mapping->private_lock);
+out:
+	if (buffers_to_free) {
+		struct buffer_head *bh = buffers_to_free;
+
+		do {
+			struct buffer_head *next = bh->b_this_page;
+			free_buffer_head(bh);
+			bh = next;
+		} while (bh != buffers_to_free);
+	}
 	return ret;
 }
 EXPORT_SYMBOL(try_to_free_buffers);

-
