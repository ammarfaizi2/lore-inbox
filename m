Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314906AbSESThG>; Sun, 19 May 2002 15:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315042AbSESTg6>; Sun, 19 May 2002 15:36:58 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7172 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S314906AbSESTgP>;
	Sun, 19 May 2002 15:36:15 -0400
Message-ID: <3CE7FF89.16AF9B93@zip.com.au>
Date: Sun, 19 May 2002 12:39:53 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 6/15] larger b_size, and misc fixlets
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Miscellany.

- make the printk in buffer_io_error() sector_t-aware.

- Some buffer.c cleanups from AntonA: remove a couple of !uptodate
  checks, and set a new buffer's b_blocknr to -1 in a more sensible
  place.

- Make buffer_head.b_size a 32-bit quantity.  Needed for 64k pagesize
  on ia64.  Does not increase sizeof(struct buffer_head).

=====================================

--- 2.5.16/fs/buffer.c~sector_t-printing	Sun May 19 11:49:47 2002
+++ 2.5.16-akpm/fs/buffer.c	Sun May 19 12:02:57 2002
@@ -179,8 +179,8 @@ __clear_page_buffers(struct page *page)
 
 static void buffer_io_error(struct buffer_head *bh)
 {
-	printk(KERN_ERR "Buffer I/O error on device %s, logical block %ld\n",
-			bdevname(bh->b_bdev), bh->b_blocknr);
+	printk(KERN_ERR "Buffer I/O error on device %s, logical block %Ld\n",
+			bdevname(bh->b_bdev), (u64)bh->b_blocknr);
 }
 
 /*
@@ -189,12 +189,12 @@ static void buffer_io_error(struct buffe
  */
 void end_buffer_io_sync(struct buffer_head *bh, int uptodate)
 {
-	if (!uptodate)
-		buffer_io_error(bh);
-	if (uptodate)
+	if (uptodate) {
 		set_buffer_uptodate(bh);
-	else
+	} else {
+		buffer_io_error(bh);
 		clear_buffer_uptodate(bh);
+	}
 	unlock_buffer(bh);
 	put_bh(bh);
 }
@@ -519,14 +519,12 @@ static void end_buffer_async_read(struct
 
 	BUG_ON(!buffer_async_read(bh));
 
-	if (!uptodate)
-		buffer_io_error(bh);
-
 	page = bh->b_page;
 	if (uptodate) {
 		set_buffer_uptodate(bh);
 	} else {
 		clear_buffer_uptodate(bh);
+		buffer_io_error(bh);
 		SetPageError(page);
 	}
 
@@ -579,13 +577,11 @@ static void end_buffer_async_write(struc
 
 	BUG_ON(!buffer_async_write(bh));
 
-	if (!uptodate)
-		buffer_io_error(bh);
-
 	page = bh->b_page;
 	if (uptodate) {
 		set_buffer_uptodate(bh);
 	} else {
+		buffer_io_error(bh);
 		clear_buffer_uptodate(bh);
 		SetPageError(page);
 	}
@@ -907,6 +903,7 @@ try_again:
 
 		bh->b_bdev = NULL;
 		bh->b_this_page = head;
+		bh->b_blocknr = -1;
 		head = bh;
 
 		bh->b_state = 0;
@@ -2442,7 +2439,6 @@ static void init_buffer_head(void *data,
 		struct buffer_head * bh = (struct buffer_head *)data;
 
 		memset(bh, 0, sizeof(*bh));
-		bh->b_blocknr = -1;
 		INIT_LIST_HEAD(&bh->b_assoc_buffers);
 	}
 }
--- 2.5.16/include/linux/buffer_head.h~sector_t-printing	Sun May 19 11:49:47 2002
+++ 2.5.16-akpm/include/linux/buffer_head.h	Sun May 19 12:02:57 2002
@@ -44,7 +44,7 @@ struct buffer_head {
 	struct page *b_page;		/* the page this bh is mapped to */
 
 	sector_t b_blocknr;		/* block number */
-	unsigned short b_size;		/* block size */
+	u32 b_size;			/* block size */
 	char *b_data;			/* pointer to data block */
 
 	struct block_device *b_bdev;


-
