Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315690AbSECU4I>; Fri, 3 May 2002 16:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315705AbSECU4H>; Fri, 3 May 2002 16:56:07 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26635 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315690AbSECU4G>;
	Fri, 3 May 2002 16:56:06 -0400
Message-ID: <3CD2F92D.6B3C1648@zip.com.au>
Date: Fri, 03 May 2002 13:55:09 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Luigi Genoni <kernel@Expansa.sns.it>
CC: linux-kernel@vger.kernel.org
Subject: Re: ext2 related,two oops with 2.5.12 on ATA66 disk.
In-Reply-To: <Pine.LNX.4.44.0205031112060.6202-100000@Expansa.sns.it>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luigi Genoni wrote:
> 
> HI,
> 
> this morning, going at work, I found those two oops (repeated a lto of
> times), on the Pentium III 512MB ram, i810 chipset, Maxtor 32049H2 ATA66
> disk.
> 
> buffer layer error at buffer.c:1380
> 

Yup, thanks.  dirty, uptodate, unmapped buffer outside
i_size.  I have a few fixes in the works; the below
one should make this go away.


--- 2.5.13/mm/page-writeback.c~writepage-versus-set_page_dirty	Fri May  3 00:48:13 2002
+++ 2.5.13-akpm/mm/page-writeback.c	Fri May  3 00:48:13 2002
@@ -475,8 +475,13 @@ int __set_page_dirty_buffers(struct page
 		struct buffer_head *bh = head;
 
 		do {
-			if (buffer_uptodate(bh))
+			if (buffer_uptodate(bh)) {
+				if (!buffer_mapped(bh))
+					buffer_error();
 				set_buffer_dirty(bh);
+			} else {
+				buffer_error();
+			}
 			bh = bh->b_this_page;
 		} while (bh != head);
 	}
--- 2.5.13/fs/buffer.c~writepage-versus-set_page_dirty	Fri May  3 00:48:13 2002
+++ 2.5.13-akpm/fs/buffer.c	Fri May  3 00:48:43 2002
@@ -1290,6 +1290,16 @@ static int __block_write_full_page(struc
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
@@ -1300,8 +1310,7 @@ static int __block_write_full_page(struc
 	 */
 	do {
 		if (block > last_block) {
-			if (buffer_dirty(bh))
-				buffer_error();
+			clear_buffer_dirty(bh);
 			if (buffer_mapped(bh))
 				buffer_error();
 			/*
@@ -1329,11 +1338,9 @@ static int __block_write_full_page(struc
 
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
@@ -1355,7 +1362,6 @@ static int __block_write_full_page(struc
 	do {
 		struct buffer_head *next = bh->b_this_page;
 		if (buffer_async(bh)) {
-			clear_buffer_dirty(bh);
 			submit_bh(WRITE, bh);
 			nr_underway++;
 		}
