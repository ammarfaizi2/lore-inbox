Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932410AbWCFWaY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932410AbWCFWaY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 17:30:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932412AbWCFWaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 17:30:24 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:47052 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932410AbWCFWaX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 17:30:23 -0500
Subject: [PATCH] 2.6.16-rc5-mm2 mpage_readpages() cleanup
From: Badari Pulavarty <pbadari@us.ibm.com>
To: akpm@osdl.org
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-T4o9d/IV2oSviElE8MtI"
Date: Mon, 06 Mar 2006 14:31:52 -0800
Message-Id: <1141684312.17095.11.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-T4o9d/IV2oSviElE8MtI
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Andrew,

Here is the (-mm2) patch to mpage_readpages() to cleanup "map_valid".

Thanks,
Badari



--=-T4o9d/IV2oSviElE8MtI
Content-Disposition: attachment; filename=mpage-readpages-buffer-mapped.patch
Content-Type: text/x-patch; name=mpage-readpages-buffer-mapped.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Instead of passing validity of block mapping, do_mpage_readpage() 
can figure it out using buffer_mapped(). This will reduce one
un-needed argument passing.

Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>

Index: linux-2.6.16-rc5-mm2/fs/mpage.c
===================================================================
--- linux-2.6.16-rc5-mm2.orig/fs/mpage.c	2006-03-03 13:46:22.000000000 -0800
+++ linux-2.6.16-rc5-mm2/fs/mpage.c	2006-03-03 17:25:59.000000000 -0800
@@ -166,7 +166,7 @@ map_buffer_to_page(struct page *page, st
 static struct bio *
 do_mpage_readpage(struct bio *bio, struct page *page, unsigned nr_pages,
 			sector_t *last_block_in_bio, struct buffer_head *map_bh,
-			unsigned long *first_logical_block, int *map_valid,
+			unsigned long *first_logical_block,
 			get_block_t get_block)
 {
 	struct inode *inode = page->mapping->host;
@@ -199,14 +199,14 @@ do_mpage_readpage(struct bio *bio, struc
 	 * Map blocks using the result from the previous get_blocks call first.
 	 */
 	nblocks = map_bh->b_size >> blkbits;
-	if (*map_valid && block_in_file > *first_logical_block &&
+	if (buffer_mapped(map_bh) && block_in_file > *first_logical_block &&
 			block_in_file < (*first_logical_block + nblocks)) {
 		unsigned map_offset = block_in_file - *first_logical_block;
 		unsigned last = nblocks - map_offset;
 
 		for (relative_block = 0; ; relative_block++) {
 			if (relative_block == last) {
-				*map_valid = 0;
+				clear_buffer_mapped(map_bh);
 				break;
 			}
 			if (page_block == blocks_per_page)
@@ -232,7 +232,6 @@ do_mpage_readpage(struct bio *bio, struc
 			if (get_block(inode, block_in_file, map_bh, 0))
 				goto confused;
 			*first_logical_block = block_in_file;
-			*map_valid  = 1;
 		}
 
 		if (!buffer_mapped(map_bh)) {
@@ -241,7 +240,7 @@ do_mpage_readpage(struct bio *bio, struc
 				first_hole = page_block;
 			page_block++;
 			block_in_file++;
-			*map_valid = 0;
+			clear_buffer_mapped(map_bh);
 			continue;
 		}
 
@@ -265,7 +264,7 @@ do_mpage_readpage(struct bio *bio, struc
 		nblocks = map_bh->b_size >> blkbits;
 		for (relative_block = 0; ; relative_block++) {
 			if (relative_block == nblocks) {
-				*map_valid = 0;
+				clear_buffer_mapped(map_bh);
 				break;
 			} else if (page_block == blocks_per_page)
 				break;
@@ -385,8 +384,8 @@ mpage_readpages(struct address_space *ma
 	struct pagevec lru_pvec;
 	struct buffer_head map_bh;
 	unsigned long first_logical_block = 0;
-	int map_valid = 0;
 
+	clear_buffer_mapped(&map_bh);
 	pagevec_init(&lru_pvec, 0);
 	for (page_idx = 0; page_idx < nr_pages; page_idx++) {
 		struct page *page = list_entry(pages->prev, struct page, lru);
@@ -399,7 +398,7 @@ mpage_readpages(struct address_space *ma
 					nr_pages - page_idx,
 					&last_block_in_bio, &map_bh,
 					&first_logical_block,
-					&map_valid, get_block);
+					get_block);
 			if (!pagevec_add(&lru_pvec, page))
 				__pagevec_lru_add(&lru_pvec);
 		} else {
@@ -423,12 +422,10 @@ int mpage_readpage(struct page *page, ge
 	sector_t last_block_in_bio = 0;
 	struct buffer_head map_bh;
 	unsigned long first_logical_block = 0;
-	int map_valid = 0;
-
 
+	clear_buffer_mapped(&map_bh);
 	bio = do_mpage_readpage(bio, page, 1, &last_block_in_bio,
-			&map_bh, &first_logical_block, &map_valid,
-			get_block);
+			&map_bh, &first_logical_block, get_block);
 	if (bio)
 		mpage_bio_submit(READ, bio);
 	return 0;

--=-T4o9d/IV2oSviElE8MtI--

