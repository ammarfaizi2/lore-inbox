Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315946AbSEZUe5>; Sun, 26 May 2002 16:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316359AbSEZUez>; Sun, 26 May 2002 16:34:55 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37392 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315946AbSEZUeR>;
	Sun, 26 May 2002 16:34:17 -0400
Message-ID: <3CF14785.9A8A9D1A@zip.com.au>
Date: Sun, 26 May 2002 13:37:25 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 1/18] small fixes in buffer.c
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



- Fix the fix to the fix to the sector_t printing in buffer_io_error()

- A few microoptimisations in buffer.c.  Replace:

	set_buffer_foo(bh);

  with

	if (!buffer_foo(bh))
		set_buffer_foo(bh);

  when buffer_fooness is likely.  To avoid the buslocked rmw, and to
  avoid dirtying a cacheline.


- export write_mapping_buffers() - filesystems which put buffers on
  mapping->private_list need this function for I/O scheduling reasons.

=====================================

--- 2.5.18/fs/buffer.c~misc	Sat May 25 23:26:43 2002
+++ 2.5.18-akpm/fs/buffer.c	Sun May 26 02:20:16 2002
@@ -167,8 +167,9 @@ __clear_page_buffers(struct page *page)
 
 static void buffer_io_error(struct buffer_head *bh)
 {
-	printk(KERN_ERR "Buffer I/O error on device %s, logical block %Ld\n",
-			bdevname(bh->b_bdev), (u64)bh->b_blocknr);
+	printk(KERN_ERR "Buffer I/O error on device %s, logical block %Lu\n",
+			bdevname(bh->b_bdev),
+			(unsigned long long)bh->b_blocknr);
 }
 
 /*
@@ -835,6 +836,7 @@ int write_mapping_buffers(struct address
 out:
 	return ret;
 }
+EXPORT_SYMBOL(write_mapping_buffers);
 
 void mark_buffer_dirty_inode(struct buffer_head *bh, struct inode *inode)
 {
@@ -1400,7 +1402,6 @@ void create_empty_buffers(struct page *p
 	head = create_buffers(page, blocksize, 1);
 	bh = head;
 	do {
-		bh->b_end_io = NULL;
 		bh->b_state |= b_state;
 		tail = bh;
 		bh = bh->b_this_page;
@@ -1666,11 +1667,14 @@ static int __block_prepare_write(struct 
 	    block++, block_start=block_end, bh = bh->b_this_page) {
 		block_end = block_start + blocksize;
 		if (block_end <= from || block_start >= to) {
-			if (PageUptodate(page))
-				set_buffer_uptodate(bh);
+			if (PageUptodate(page)) {
+				if (!buffer_uptodate(bh))
+					set_buffer_uptodate(bh);
+			}
 			continue;
 		}
-		clear_buffer_new(bh);
+		if (buffer_new(bh))
+			clear_buffer_new(bh);
 		if (!buffer_mapped(bh)) {
 			err = get_block(inode, block, bh, 1);
 			if (err)
@@ -1695,7 +1699,8 @@ static int __block_prepare_write(struct 
 			}
 		}
 		if (PageUptodate(page)) {
-			set_buffer_uptodate(bh);
+			if (!buffer_uptodate(bh))
+				set_buffer_uptodate(bh);
 			continue; 
 		}
 		if (!buffer_uptodate(bh) &&
--- 2.5.18/mm/page-writeback.c~misc	Sat May 25 23:26:43 2002
+++ 2.5.18-akpm/mm/page-writeback.c	Sun May 26 00:50:19 2002
@@ -50,7 +50,7 @@ static int dirty_async_ratio = 50;
  */
 static int dirty_sync_ratio = 60;
 
-static void background_writeout(unsigned long unused);
+static void background_writeout(unsigned long _min_pages);
 
 /*
  * balance_dirty_pages() must be called by processes which are
@@ -492,6 +492,9 @@ int __set_page_dirty_buffers(struct page
 		goto out;
 	}
 
+	if (!PageUptodate(page))
+		buffer_error();
+
 	spin_lock(&mapping->private_lock);
 
 	if (page_has_buffers(page) && !PageSwapCache(page)) {


-
