Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751235AbWCGQZH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbWCGQZH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 11:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbWCGQZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 11:25:07 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:28375 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751235AbWCGQZF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 11:25:05 -0500
Subject: Re: [PATCH] 2.6.16-rc5-mm2 mpage_readpages() cleanup
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20060306143718.50fc0d94.akpm@osdl.org>
References: <1141684312.17095.11.camel@dyn9047017100.beaverton.ibm.com>
	 <20060306143718.50fc0d94.akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-DYJP2wcdHb3A0i77Sk40"
Date: Tue, 07 Mar 2006 08:26:27 -0800
Message-Id: <1141748787.17095.17.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-DYJP2wcdHb3A0i77Sk40
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2006-03-06 at 14:37 -0800, Andrew Morton wrote:
> Badari Pulavarty <pbadari@us.ibm.com> wrote:
> >
> > Instead of passing validity of block mapping, do_mpage_readpage() 
> >  can figure it out using buffer_mapped(). This will reduce one
> >  un-needed argument passing.
> 
> Is buffer_mapped() the correct flag to use?  Remember that get_block() can
> validly return a !buffer_mapped() bh over a file hole.
> 
> Either way, there should be a comment in there explaining the protocol,
> please.
> 

Here is the version with comments.

Thanks,
Badari



--=-DYJP2wcdHb3A0i77Sk40
Content-Disposition: attachment; filename=mpage-readpages-buffer-mapped.patch
Content-Type: text/x-patch; name=mpage-readpages-buffer-mapped.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Instead of passing validity of block mapping, do_mpage_readpage() 
can figure it out using buffer_mapped(). This will reduce one
un-needed argument passing.

Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>

Index: linux-2.6.16-rc5-mm2/fs/mpage.c
===================================================================
--- linux-2.6.16-rc5-mm2.orig/fs/mpage.c	2006-03-03 13:46:22.000000000 -0800
+++ linux-2.6.16-rc5-mm2/fs/mpage.c	2006-03-06 17:13:02.000000000 -0800
@@ -163,10 +163,19 @@ map_buffer_to_page(struct page *page, st
 	} while (page_bh != head);
 }
 
+/*
+ * This is the worker routine which does all the work of mapping the
+ * disk blocks and constructs largest possible bios, submits them for
+ * IO if the blocks are not contiguous on the disk.
+ *
+ * Its important to note that, we pass buffer_head back and forth and
+ * use buffer_mapped() flag to represent the validity of disk mapping
+ * and to decide when to do next get_block() call.
+ */
 static struct bio *
 do_mpage_readpage(struct bio *bio, struct page *page, unsigned nr_pages,
 			sector_t *last_block_in_bio, struct buffer_head *map_bh,
-			unsigned long *first_logical_block, int *map_valid,
+			unsigned long *first_logical_block,
 			get_block_t get_block)
 {
 	struct inode *inode = page->mapping->host;
@@ -199,14 +208,14 @@ do_mpage_readpage(struct bio *bio, struc
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
@@ -232,7 +241,6 @@ do_mpage_readpage(struct bio *bio, struc
 			if (get_block(inode, block_in_file, map_bh, 0))
 				goto confused;
 			*first_logical_block = block_in_file;
-			*map_valid  = 1;
 		}
 
 		if (!buffer_mapped(map_bh)) {
@@ -241,7 +249,7 @@ do_mpage_readpage(struct bio *bio, struc
 				first_hole = page_block;
 			page_block++;
 			block_in_file++;
-			*map_valid = 0;
+			clear_buffer_mapped(map_bh);
 			continue;
 		}
 
@@ -265,7 +273,7 @@ do_mpage_readpage(struct bio *bio, struc
 		nblocks = map_bh->b_size >> blkbits;
 		for (relative_block = 0; ; relative_block++) {
 			if (relative_block == nblocks) {
-				*map_valid = 0;
+				clear_buffer_mapped(map_bh);
 				break;
 			} else if (page_block == blocks_per_page)
 				break;
@@ -385,8 +393,8 @@ mpage_readpages(struct address_space *ma
 	struct pagevec lru_pvec;
 	struct buffer_head map_bh;
 	unsigned long first_logical_block = 0;
-	int map_valid = 0;
 
+	clear_buffer_mapped(&map_bh);
 	pagevec_init(&lru_pvec, 0);
 	for (page_idx = 0; page_idx < nr_pages; page_idx++) {
 		struct page *page = list_entry(pages->prev, struct page, lru);
@@ -399,7 +407,7 @@ mpage_readpages(struct address_space *ma
 					nr_pages - page_idx,
 					&last_block_in_bio, &map_bh,
 					&first_logical_block,
-					&map_valid, get_block);
+					get_block);
 			if (!pagevec_add(&lru_pvec, page))
 				__pagevec_lru_add(&lru_pvec);
 		} else {
@@ -423,12 +431,10 @@ int mpage_readpage(struct page *page, ge
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

--=-DYJP2wcdHb3A0i77Sk40--

