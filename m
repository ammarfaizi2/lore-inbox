Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313529AbSEEUwN>; Sun, 5 May 2002 16:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313533AbSEEUwM>; Sun, 5 May 2002 16:52:12 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40969 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S313529AbSEEUwJ>;
	Sun, 5 May 2002 16:52:09 -0400
Message-ID: <3CD59C04.350E191B@zip.com.au>
Date: Sun, 05 May 2002 13:54:28 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 3/10] Allow truncate to discard unmapped buffers
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



The buffer state "uptodate, dirty, unmapped" is legal.  It occurs when
a mapped page with attached buffers which is over a hole is dirtied.

So discard_buffer() needs to be able to discard those buffers as well;
otherwise the page ends up clean, with dirty buffers and is unfreeable.


=====================================

--- 2.5.13/fs/buffer.c~truncate-leak	Sun May  5 13:32:00 2002
+++ 2.5.13-akpm/fs/buffer.c	Sun May  5 13:32:37 2002
@@ -1091,17 +1091,15 @@ EXPORT_SYMBOL(set_bh_page);
 /*
  * Called when truncating a buffer on a page completely.
  */
-static void discard_buffer(struct buffer_head * bh)
+static /* inline */ void discard_buffer(struct buffer_head * bh)
 {
-	if (buffer_mapped(bh)) {
-		clear_buffer_dirty(bh);
-		lock_buffer(bh);
-		bh->b_bdev = NULL;
-		clear_buffer_mapped(bh);
-		clear_buffer_req(bh);
-		clear_buffer_new(bh);
-		unlock_buffer(bh);
-	}
+	lock_buffer(bh);
+	clear_buffer_dirty(bh);
+	bh->b_bdev = NULL;
+	clear_buffer_mapped(bh);
+	clear_buffer_req(bh);
+	clear_buffer_new(bh);
+	unlock_buffer(bh);
 }
 
 /**
--- 2.5.13/fs/jbd/transaction.c~truncate-leak	Sun May  5 13:32:00 2002
+++ 2.5.13-akpm/fs/jbd/transaction.c	Sun May  5 13:32:37 2002
@@ -1587,7 +1587,7 @@ static int __journal_try_to_free_buffer(
 		goto out;
 	}
 
-	if (!buffer_uptodate(bh))
+	if (!buffer_uptodate(bh))	/* AKPM: why? */
 		goto out;
 
 	if (jh->b_next_transaction != 0)
@@ -1775,9 +1775,6 @@ static int journal_unmap_buffer(journal_
 
 	BUFFER_TRACE(bh, "entry");
 
-	if (!buffer_mapped(bh))
-		return 1;
-
 	/* It is safe to proceed here without the
 	 * journal_datalist_spinlock because the buffers cannot be
 	 * stolen by try_to_free_buffers as long as we are holding the
