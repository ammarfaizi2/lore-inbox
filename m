Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316512AbSHJA6g>; Fri, 9 Aug 2002 20:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316491AbSHJA6B>; Fri, 9 Aug 2002 20:58:01 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25874 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316465AbSHJA4b>;
	Fri, 9 Aug 2002 20:56:31 -0400
Message-ID: <3D546516.E60C7E4@zip.com.au>
Date: Fri, 09 Aug 2002 17:57:58 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 10/12] direct IO fixes
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Some direct IO fixes from Badari Pulavarty.

- off-by-one in the bounds checking in blkdev_get_blocks().

- When adding more blocks into a bio_vec, account for the current
  offset into that bio_vec.

- Fix a total ballsup in the code which calculates the total number
  of pages which are about to be put under IO.



 block_dev.c |    2 +-
 direct-io.c |    7 ++++---
 2 files changed, 5 insertions, 4 deletions

--- 2.5.30/fs/direct-io.c~direct_io-fixes	Fri Aug  9 17:36:47 2002
+++ 2.5.30-akpm/fs/direct-io.c	Fri Aug  9 17:36:47 2002
@@ -489,7 +489,7 @@ int do_direct_IO(struct dio *dio)
 
 			/* Work out how much disk we can add to this page */
 			this_chunk_blocks = dio->blocks_available;
-			u = (PAGE_SIZE - dio->bvec->bv_len) >> blkbits;
+			u = (PAGE_SIZE - (dio->bvec->bv_offset + dio->bvec->bv_len)) >> blkbits;
 			if (this_chunk_blocks > u)
 				this_chunk_blocks = u;
 			u = dio->final_block_in_request - dio->block_in_file;
@@ -567,10 +567,11 @@ generic_direct_IO(int rw, struct inode *
 	dio.curr_page = 0;
 	bytes = count;
 	dio.total_pages = 0;
-	if (offset & PAGE_SIZE) {
+	if (user_addr & (PAGE_SIZE - 1)) {
 		dio.total_pages++;
-		bytes -= PAGE_SIZE - (offset & ~(PAGE_SIZE - 1));
+		bytes -= PAGE_SIZE - (user_addr & (PAGE_SIZE - 1));
 	}
+
 	dio.total_pages += (bytes + PAGE_SIZE - 1) / PAGE_SIZE;
 	dio.curr_user_address = user_addr;
 
--- 2.5.30/fs/block_dev.c~direct_io-fixes	Fri Aug  9 17:36:47 2002
+++ 2.5.30-akpm/fs/block_dev.c	Fri Aug  9 17:36:47 2002
@@ -105,7 +105,7 @@ static int
 blkdev_get_blocks(struct inode *inode, sector_t iblock,
 		unsigned long max_blocks, struct buffer_head *bh, int create)
 {
-	if ((iblock + max_blocks) >= max_block(inode->i_bdev))
+	if ((iblock + max_blocks) > max_block(inode->i_bdev))
 		return -EIO;
 
 	bh->b_bdev = inode->i_bdev;

.
