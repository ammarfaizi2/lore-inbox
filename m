Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262524AbVDYD4e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262524AbVDYD4e (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 23:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262525AbVDYD4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 23:56:34 -0400
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:13692 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262524AbVDYD40 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 23:56:26 -0400
Message-ID: <426C6A63.80408@yahoo.com.au>
Date: Mon, 25 Apr 2005 13:56:19 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [patch] __block_write_full_page bug
Content-Type: multipart/mixed;
 boundary="------------060008000400090203040009"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060008000400090203040009
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Another buffer bug :(

-- 
SUSE Labs, Novell Inc.

--------------060008000400090203040009
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
at a time. __block_write_full_page looks like the culprit - with the
following patch things are very stable.

Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>

Index: linux-2.6/fs/buffer.c
===================================================================
--- linux-2.6.orig/fs/buffer.c	2005-04-25 13:13:37.000000000 +1000
+++ linux-2.6/fs/buffer.c	2005-04-25 13:14:52.000000000 +1000
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
 
@@ -1826,6 +1827,7 @@ static int __block_write_full_page(struc
 		}
 		if (test_clear_buffer_dirty(bh)) {
 			mark_buffer_async_write(bh);
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
+	for (nr_underway = 0; nr_underway < idx; nr_underway++) {
+		bh = arr[nr_underway];
+		if (buffer_async_write(bh))
 			submit_bh(WRITE, bh);
-			nr_underway++;
-		}
 		put_bh(bh);
-		bh = next;
-	} while (bh != head);
+	}
 
 	err = 0;
 done:
@@ -1890,6 +1889,7 @@ recover:
 		if (buffer_mapped(bh) && buffer_dirty(bh)) {
 			lock_buffer(bh);
 			mark_buffer_async_write(bh);
+			arr[idx++] = bh;
 		} else {
 			/*
 			 * The buffer may have been set dirty during
@@ -1902,16 +1902,14 @@ recover:
 	BUG_ON(PageWriteback(page));
 	set_page_writeback(page);
 	unlock_page(page);
-	do {
-		struct buffer_head *next = bh->b_this_page;
+	for (nr_underway = 0; nr_underway < idx; nr_underway++) {
+		bh = arr[nr_underway];
 		if (buffer_async_write(bh)) {
 			clear_buffer_dirty(bh);
 			submit_bh(WRITE, bh);
-			nr_underway++;
 		}
 		put_bh(bh);
-		bh = next;
-	} while (bh != head);
+	}
 	goto done;
 }
 
@@ -2741,6 +2739,7 @@ sector_t generic_block_bmap(struct addre
 static int end_bio_bh_io_sync(struct bio *bio, unsigned int bytes_done, int err)
 {
 	struct buffer_head *bh = bio->bi_private;
+	bh_end_io_t *end_fn;
 
 	if (bio->bi_size)
 		return 1;
@@ -2750,7 +2749,16 @@ static int end_bio_bh_io_sync(struct bio
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

--------------060008000400090203040009--

