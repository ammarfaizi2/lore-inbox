Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315259AbSGDXu0>; Thu, 4 Jul 2002 19:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315202AbSGDXsR>; Thu, 4 Jul 2002 19:48:17 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35085 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315167AbSGDXpu>;
	Thu, 4 Jul 2002 19:45:50 -0400
Message-ID: <3D24E026.796D9D0E@zip.com.au>
Date: Thu, 04 Jul 2002 16:54:14 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 9/27] remove swap_get_block()
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Patch from Christoph Hellwig removes swap_get_block().

I was sort-of hanging onto this function because it is a standard
get_block function, and maybe perhaps it could be used to make swap use
the regular filesystem I/O functions.  We don't want to do that, so
kill it.




 page_io.c |   33 +++++++++++----------------------
 1 files changed, 11 insertions(+), 22 deletions(-)

--- 2.5.24/mm/page_io.c~kill-swap_get_block	Thu Jul  4 16:17:15 2002
+++ 2.5.24-akpm/mm/page_io.c	Thu Jul  4 16:17:15 2002
@@ -15,37 +15,26 @@
 #include <linux/pagemap.h>
 #include <linux/swap.h>
 #include <linux/bio.h>
-#include <linux/buffer_head.h>
-#include <asm/pgtable.h>
 #include <linux/swapops.h>
-
-static int
-swap_get_block(struct inode *inode, sector_t iblock,
-		struct buffer_head *bh_result, int create)
-{
-	struct swap_info_struct *sis;
-	swp_entry_t entry;
-
-	entry.val = iblock;
-	sis = get_swap_info_struct(swp_type(entry));
-	bh_result->b_bdev = sis->bdev;
-	bh_result->b_blocknr = map_swap_page(sis, swp_offset(entry));
-	bh_result->b_size = PAGE_SIZE;
-	set_buffer_mapped(bh_result);
-	return 0;
-}
+#include <linux/buffer_head.h>	/* for block_sync_page() */
+#include <asm/pgtable.h>
 
 static struct bio *
 get_swap_bio(int gfp_flags, struct page *page, bio_end_io_t end_io)
 {
 	struct bio *bio;
-	struct buffer_head bh;
 
 	bio = bio_alloc(gfp_flags, 1);
 	if (bio) {
-		swap_get_block(NULL, page->index, &bh, 1);
-		bio->bi_sector = bh.b_blocknr * (PAGE_SIZE >> 9);
-		bio->bi_bdev = bh.b_bdev;
+		struct swap_info_struct *sis;
+		swp_entry_t entry;
+
+		entry.val = page->index;
+		sis = get_swap_info_struct(swp_type(entry));
+
+		bio->bi_sector = map_swap_page(sis, swp_offset(entry)) *
+					(PAGE_SIZE >> 9);
+		bio->bi_bdev = sis->bdev;
 		bio->bi_io_vec[0].bv_page = page;
 		bio->bi_io_vec[0].bv_len = PAGE_SIZE;
 		bio->bi_io_vec[0].bv_offset = 0;

-
