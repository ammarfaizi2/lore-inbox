Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261249AbVD0NQe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbVD0NQe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 09:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261268AbVD0NQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 09:16:34 -0400
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:16468 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261249AbVD0NQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 09:16:04 -0400
Message-ID: <426F908C.2060804@yahoo.com.au>
Date: Wed, 27 Apr 2005 23:15:56 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
CC: Chris Mason <mason@suse.com>
Subject: [patch] fix the 2nd buffer race properly
Content-Type: multipart/mixed;
 boundary="------------090505000406010205060207"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090505000406010205060207
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

OK, so I found the exact cause of the 2nd buffer problem.

Surprisingly, the first patch I sent was exactly what is
needed. Surprising because I didn't have a full handle on
the problem so perhaps I got a bit lucky.

The bug (the reason I asked you to drop the patch just now)
was that the code previously did a get_bh on all bh's in a
page, but I changed it to only put_bh the ones to be written.

The minor fix for that was to only get_bh the buffer heads to
be written.

Exact problem is described in the patch changelog. Anyone who
is feeling brave please review because I'm tired and have a
headache from too much kernel debugging ;)

Tested and seems to work. Doesn't seem to leak memory.

Nick

-- 
SUSE Labs, Novell Inc.

--------------090505000406010205060207
Content-Type: text/plain;
 name="__block_write_full_page-bug.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="__block_write_full_page-bug.patch"

When running
	fsstress -v -d $DIR/tmp -n 1000 -p 1000 -l 2
on an ext2 filesystem with 1024 byte block size, on SMP i386 with 4096 byte
page size over loopback to an image file on a tmpfs filesystem, I would
very quickly hit
	BUG_ON(!buffer_async_write(bh));
in fs/buffer.c:end_buffer_async_write

It seems that more than one request would be submitted for a given bh
at a time.

What would happen is the following:
2 threads doing __mpage_writepages on the same page.
Thread 1 - lock the page first, and enter __block_write_full_page.
Thread 1 - (eg.) mark_buffer_async_write on the first 2 buffers.
Thread 1 - set page writeback, unlock page.
Thread 2 - lock page, wait on page writeback
Thread 1 - submit_bh on the first 2 buffers.
=> both requests complete, none of the page buffers are async_write,
   end_page_writeback is called.
Thread 2 - wakes up. enters __block_write_full_page.
Thread 2 - mark_buffer_async_write on (eg.) the last buffer
Thread 1 - finds the last buffer has async_write set, submit_bh on that.
Thread 2 - submit_bh on the last buffer.
=> oops.

So change __block_write_full_page to explicitly keep track of requests
rather than relying on testing all of them for buffer_async_write - because
by the time we submit the last buffer we have marked async_write, we no
longer own *any* of the buffers.

Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>

Index: linux-2.6/fs/buffer.c
===================================================================
--- linux-2.6.orig/fs/buffer.c	2005-04-27 22:43:05.000000000 +1000
+++ linux-2.6/fs/buffer.c	2005-04-27 22:45:03.000000000 +1000
@@ -1750,8 +1750,9 @@ static int __block_write_full_page(struc
 	int err;
 	sector_t block;
 	sector_t last_block;
-	struct buffer_head *bh, *head;
-	int nr_underway = 0;
+	struct buffer_head *bh, *head, *arr[MAX_BUF_PER_PAGE];
+	int idx = 0;
+	int nr_underway;
 
 	BUG_ON(!PageLocked(page));
 
@@ -1808,7 +1809,6 @@ static int __block_write_full_page(struc
 	} while (bh != head);
 
 	do {
-		get_bh(bh);
 		if (!buffer_mapped(bh))
 			continue;
 		/*
@@ -1826,6 +1826,8 @@ static int __block_write_full_page(struc
 		}
 		if (test_clear_buffer_dirty(bh)) {
 			mark_buffer_async_write(bh);
+			get_bh(bh);
+			arr[idx++] = bh;
 		} else {
 			unlock_buffer(bh);
 		}
@@ -1839,15 +1841,12 @@ static int __block_write_full_page(struc
 	set_page_writeback(page);
 	unlock_page(page);
 
-	do {
-		struct buffer_head *next = bh->b_this_page;
-		if (buffer_async_write(bh)) {
-			submit_bh(WRITE, bh);
-			nr_underway++;
-		}
+	for (nr_underway = 0; nr_underway < idx; nr_underway++) {
+		bh = arr[nr_underway];
+		BUG_ON(!buffer_async_write(bh));
+		submit_bh(WRITE, bh);
 		put_bh(bh);
-		bh = next;
-	} while (bh != head);
+	}
 
 	err = 0;
 done:
@@ -1886,10 +1885,11 @@ recover:
 	bh = head;
 	/* Recovery: lock and submit the mapped buffers */
 	do {
-		get_bh(bh);
 		if (buffer_mapped(bh) && buffer_dirty(bh)) {
 			lock_buffer(bh);
 			mark_buffer_async_write(bh);
+			get_bh(bh);
+			arr[idx++] = bh;
 		} else {
 			/*
 			 * The buffer may have been set dirty during
@@ -1902,16 +1902,13 @@ recover:
 	BUG_ON(PageWriteback(page));
 	set_page_writeback(page);
 	unlock_page(page);
-	do {
-		struct buffer_head *next = bh->b_this_page;
-		if (buffer_async_write(bh)) {
-			clear_buffer_dirty(bh);
-			submit_bh(WRITE, bh);
-			nr_underway++;
-		}
+	for (nr_underway = 0; nr_underway < idx; nr_underway++) {
+		bh = arr[nr_underway];
+		BUG_ON(!buffer_async_write(bh));
+		clear_buffer_dirty(bh);
+		submit_bh(WRITE, bh);
 		put_bh(bh);
-		bh = next;
-	} while (bh != head);
+	}
 	goto done;
 }
 
@@ -2741,6 +2738,7 @@ sector_t generic_block_bmap(struct addre
 static int end_bio_bh_io_sync(struct bio *bio, unsigned int bytes_done, int err)
 {
 	struct buffer_head *bh = bio->bi_private;
+	bh_end_io_t *end_fn;
 
 	if (bio->bi_size)
 		return 1;
@@ -2750,7 +2748,16 @@ static int end_bio_bh_io_sync(struct bio
 		set_bit(BH_Eopnotsupp, &bh->b_state);
 	}
 
-	bh->b_end_io(bh, test_bit(BIO_UPTODATE, &bio->bi_flags));
+	end_fn = bh->b_end_io;
+
+	/* 
+	 * These two lines are debugging only - make sure b_end_io
+	 * isn't run twice for the same io request.
+	 */
+	BUG_ON(!end_fn);
+	bh->b_end_io = NULL;
+	
+	end_fn(bh, test_bit(BIO_UPTODATE, &bio->bi_flags));
 	bio_put(bio);
 	return 0;
 }

--------------090505000406010205060207--

