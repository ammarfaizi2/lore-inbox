Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313589AbSEEUzr>; Sun, 5 May 2002 16:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313571AbSEEUzp>; Sun, 5 May 2002 16:55:45 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46089 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S313589AbSEEUzd>;
	Sun, 5 May 2002 16:55:33 -0400
Message-ID: <3CD59CCE.D9979513@zip.com.au>
Date: Sun, 05 May 2002 13:57:50 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 7/10] handle concurrent block_write_full_page and set_page_dirty
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



set_page_dirty() runs without the page lock.  So
__block_write_full_page() needs to be able to cope with the page's
buffers being dirtied concurrently, on another CPU.

Do this with careful ordering and a test-and-set.



=====================================

--- 2.5.13/mm/page-writeback.c~writepage-versus-set_page_dirty	Sun May  5 13:32:01 2002
+++ 2.5.13-akpm/mm/page-writeback.c	Sun May  5 13:32:35 2002
@@ -480,6 +480,8 @@ int __set_page_dirty_buffers(struct page
 		do {
 			if (buffer_uptodate(bh))
 				set_buffer_dirty(bh);
+			else
+				buffer_error();
 			bh = bh->b_this_page;
 		} while (bh != head);
 	}
--- 2.5.13/fs/buffer.c~writepage-versus-set_page_dirty	Sun May  5 13:32:01 2002
+++ 2.5.13-akpm/fs/buffer.c	Sun May  5 13:32:35 2002
@@ -1288,6 +1288,16 @@ static int __block_write_full_page(struc
 					(1 << BH_Dirty)|(1 << BH_Uptodate));
 	}
 
+	/*
+	 * Be very careful.  We have no exclusion from __set_page_dirty_buffers
+	 * here, and the (potentially unmapped) buffers may become dirty at
+	 * any time.  If a buffer becomes dirty here after we've inspected it
+	 * then we just miss that fact, and the page stays dirty.
+	 *
+	 * Buffers outside i_size may be dirtied by __set_page_dirty_buffers;
+	 * handle that here by just cleaning them.
+	 */
+
 	block = page->index << (PAGE_CACHE_SHIFT - inode->i_blkbits);
 	head = page_buffers(page);
 	bh = head;
@@ -1298,15 +1308,11 @@ static int __block_write_full_page(struc
 	 */
 	do {
 		if (block > last_block) {
-			if (buffer_dirty(bh))
-				buffer_error();
+			clear_buffer_dirty(bh);
 			if (buffer_mapped(bh))
 				buffer_error();
 			/*
-			 * NOTE: this buffer can only be marked uptodate
-			 * because we know that block_write_full_page has
-			 * zeroed it out.  That seems unnecessary and may go
-			 * away.
+			 * The buffer was zeroed by block_write_full_page()
 			 */
 			set_buffer_uptodate(bh);
 		} else if (!buffer_mapped(bh) && buffer_dirty(bh)) {
@@ -1327,11 +1333,9 @@ static int __block_write_full_page(struc
 
 	do {
 		get_bh(bh);
-		if (buffer_dirty(bh)) {
+		if (buffer_mapped(bh) && buffer_dirty(bh)) {
 			lock_buffer(bh);
-			if (buffer_dirty(bh)) {
-				if (!buffer_mapped(bh))
-					buffer_error();
+			if (test_clear_buffer_dirty(bh)) {
 				if (!buffer_uptodate(bh))
 					buffer_error();
 				set_buffer_async_io(bh);
@@ -1353,7 +1357,6 @@ static int __block_write_full_page(struc
 	do {
 		struct buffer_head *next = bh->b_this_page;
 		if (buffer_async(bh)) {
-			clear_buffer_dirty(bh);
 			submit_bh(WRITE, bh);
 			nr_underway++;
 		}


-
