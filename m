Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316820AbSFQHVk>; Mon, 17 Jun 2002 03:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316798AbSFQHUL>; Mon, 17 Jun 2002 03:20:11 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29198 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316799AbSFQGtU>;
	Mon, 17 Jun 2002 02:49:20 -0400
Message-ID: <3D0D8763.B0DE6E98@zip.com.au>
Date: Sun, 16 Jun 2002 23:53:23 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 15/19] ext3: clean up journal_try_to_free_buffers()
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Clean up ext3's journal_try_to_free_buffers().  Now that the
releasepage() a_op is non-blocking and need not perform I/O, this
function becomes much simpler.



--- 2.5.22/fs/jbd/transaction.c~cleanup-journal_try_to_free_buffers	Sun Jun 16 23:12:52 2002
+++ 2.5.22-akpm/fs/jbd/transaction.c	Sun Jun 16 23:12:52 2002
@@ -1601,8 +1601,7 @@ void journal_unfile_buffer(struct journa
  *
  * Returns non-zero iff we were able to free the journal_head.
  */
-static int __journal_try_to_free_buffer(struct buffer_head *bh,
-					int *locked_or_dirty)
+static inline int __journal_try_to_free_buffer(struct buffer_head *bh)
 {
 	struct journal_head *jh;
 
@@ -1610,12 +1609,7 @@ static int __journal_try_to_free_buffer(
 
 	jh = bh2jh(bh);
 
-	if (buffer_locked(bh) || buffer_dirty(bh)) {
-		*locked_or_dirty = 1;
-		goto out;
-	}
-
-	if (!buffer_uptodate(bh))	/* AKPM: why? */
+	if (buffer_locked(bh) || buffer_dirty(bh))
 		goto out;
 
 	if (jh->b_next_transaction != 0)
@@ -1630,8 +1624,7 @@ static int __journal_try_to_free_buffer(
 			__journal_remove_journal_head(bh);
 			__brelse(bh);
 		}
-	}
-	else if (jh->b_cp_transaction != 0 && jh->b_transaction == 0) {
+	} else if (jh->b_cp_transaction != 0 && jh->b_transaction == 0) {
 		/* written-back checkpointed metadata buffer */
 		if (jh->b_jlist == BJ_None) {
 			JBUFFER_TRACE(jh, "remove from checkpoint list");
@@ -1647,10 +1640,8 @@ out:
 }
 
 /*
- * journal_try_to_free_buffers().  For all the buffers on this page,
- * if they are fully written out ordered data, move them onto BUF_CLEAN
- * so try_to_free_buffers() can reap them.  Called with lru_list_lock
- * not held.  Does its own locking.
+ * journal_try_to_free_buffers().  Try to remove all this page's buffers
+ * from the journal.
  *
  * This complicates JBD locking somewhat.  We aren't protected by the
  * BKL here.  We wish to remove the buffer from its committing or
@@ -1669,50 +1660,28 @@ out:
  * journal_try_to_free_buffer() is changing its state.  But that
  * cannot happen because we never reallocate freed data as metadata
  * while the data is part of a transaction.  Yes?
- *
- * This function returns non-zero if we wish try_to_free_buffers()
- * to be called. We do this is the page is releasable by try_to_free_buffers().
- * We also do it if the page has locked or dirty buffers and the caller wants
- * us to perform sync or async writeout.
  */
 int journal_try_to_free_buffers(journal_t *journal, 
-				struct page *page, int gfp_mask)
+				struct page *page, int unused_gfp_mask)
 {
+	struct buffer_head *head;
 	struct buffer_head *bh;
-	struct buffer_head *tmp;
-	int locked_or_dirty = 0;
-	int call_ttfb = 1;
-	int ret;
+	int ret = 0;
 
 	J_ASSERT(PageLocked(page));
 
-	bh = page_buffers(page);
-	tmp = bh;
+	head = page_buffers(page);
+	bh = head;
 	spin_lock(&journal_datalist_lock);
 	do {
-		struct buffer_head *p = tmp;
-
-		tmp = tmp->b_this_page;
-		if (buffer_jbd(p))
-			if (!__journal_try_to_free_buffer(p, &locked_or_dirty))
-				call_ttfb = 0;
-	} while (tmp != bh);
+		if (buffer_jbd(bh) && !__journal_try_to_free_buffer(bh)) {
+			spin_unlock(&journal_datalist_lock);
+			goto busy;
+		}
+	} while ((bh = bh->b_this_page) != head);
 	spin_unlock(&journal_datalist_lock);
-
-	if (!(gfp_mask & (__GFP_IO|__GFP_WAIT)))
-		goto out;
-	if (!locked_or_dirty)
-		goto out;
-	/*
-	 * The VM wants us to do writeout, or to block on IO, or both.
-	 * So we allow try_to_free_buffers to be called even if the page
-	 * still has journalled buffers.
-	 */
-	call_ttfb = 1;
-out:
-	ret = 0;
-	if (call_ttfb)
-		ret = try_to_free_buffers(page);
+	ret = try_to_free_buffers(page);
+busy:
 	return ret;
 }
 

-
