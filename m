Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932247AbWBTVWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbWBTVWN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 16:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbWBTVWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 16:22:12 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:37764 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932232AbWBTVWB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 16:22:01 -0500
Subject: [PATCH 1/3] pass b_size to ->get_block()
From: Badari Pulavarty <pbadari@us.ibm.com>
To: christoph <hch@lst.de>
Cc: mcao@us.ibm.com, akpm@osdl.org, lkml <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>
In-Reply-To: <1140470487.22756.12.camel@dyn9047017100.beaverton.ibm.com>
References: <1140470487.22756.12.camel@dyn9047017100.beaverton.ibm.com>
Content-Type: multipart/mixed; boundary="=-SRmsICL3+jSSVbuhzvOp"
Date: Mon, 20 Feb 2006 13:23:10 -0800
Message-Id: <1140470590.22756.14.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-SRmsICL3+jSSVbuhzvOp
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

[PATCH 1/3] pass b_size to ->get_block()

Pass amount of disk needs to be mapped to get_block().
This way one can modify the fs ->get_block() functions
to map multiple blocks at the same time.

Thanks,
Badari



--=-SRmsICL3+jSSVbuhzvOp
Content-Disposition: attachment; filename=getblock-take-size.patch
Content-Type: text/x-patch; name=getblock-take-size.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Pass amount of disk needs to be mapped to get_block().
This way one can modify the fs ->get_block() functions 
to map multiple blocks at the same time.

Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>

 fs/buffer.c                 |    6 ++++++
 fs/mpage.c                  |    2 ++
 include/linux/buffer_head.h |    1 +
 3 files changed, 9 insertions(+)

Index: linux-2.6.16-rc4/fs/buffer.c
===================================================================
--- linux-2.6.16-rc4.orig/fs/buffer.c	2006-02-17 14:23:45.000000000 -0800
+++ linux-2.6.16-rc4/fs/buffer.c	2006-02-20 09:37:58.000000000 -0800
@@ -1785,6 +1785,7 @@ static int __block_write_full_page(struc
 			clear_buffer_dirty(bh);
 			set_buffer_uptodate(bh);
 		} else if (!buffer_mapped(bh) && buffer_dirty(bh)) {
+			bh->b_size = 1 << inode->i_blkbits;
 			err = get_block(inode, block, bh, 1);
 			if (err)
 				goto recover;
@@ -1938,6 +1939,7 @@ static int __block_prepare_write(struct 
 		if (buffer_new(bh))
 			clear_buffer_new(bh);
 		if (!buffer_mapped(bh)) {
+			bh->b_size = 1 << inode->i_blkbits;
 			err = get_block(inode, block, bh, 1);
 			if (err)
 				break;
@@ -2093,6 +2095,7 @@ int block_read_full_page(struct page *pa
 
 			fully_mapped = 0;
 			if (iblock < lblock) {
+				bh->b_size = 1 << inode->i_blkbits;
 				err = get_block(inode, iblock, bh, 0);
 				if (err)
 					SetPageError(page);
@@ -2414,6 +2417,7 @@ int nobh_prepare_write(struct page *page
 		create = 1;
 		if (block_start >= to)
 			create = 0;
+		map_bh.b_size = 1 << blkbits;
 		ret = get_block(inode, block_in_file + block_in_page,
 					&map_bh, create);
 		if (ret)
@@ -2674,6 +2678,7 @@ int block_truncate_page(struct address_s
 
 	err = 0;
 	if (!buffer_mapped(bh)) {
+		bh->b_size = 1 << inode->i_blkbits;
 		err = get_block(inode, iblock, bh, 0);
 		if (err)
 			goto unlock;
@@ -2760,6 +2765,7 @@ sector_t generic_block_bmap(struct addre
 	struct inode *inode = mapping->host;
 	tmp.b_state = 0;
 	tmp.b_blocknr = 0;
+	tmp.b_size = 1 << inode->i_blkbits;
 	get_block(inode, block, &tmp, 0);
 	return tmp.b_blocknr;
 }
Index: linux-2.6.16-rc4/include/linux/buffer_head.h
===================================================================
--- linux-2.6.16-rc4.orig/include/linux/buffer_head.h	2006-02-17 14:23:45.000000000 -0800
+++ linux-2.6.16-rc4/include/linux/buffer_head.h	2006-02-20 09:39:20.000000000 -0800
@@ -277,6 +277,7 @@ map_bh(struct buffer_head *bh, struct su
 	set_buffer_mapped(bh);
 	bh->b_bdev = sb->s_bdev;
 	bh->b_blocknr = block;
+	bh->b_size =  sb->s_blocksize;
 }
 
 /*
Index: linux-2.6.16-rc4/fs/mpage.c
===================================================================
--- linux-2.6.16-rc4.orig/fs/mpage.c	2006-02-17 14:23:45.000000000 -0800
+++ linux-2.6.16-rc4/fs/mpage.c	2006-02-20 09:45:37.000000000 -0800
@@ -192,6 +192,7 @@ do_mpage_readpage(struct bio *bio, struc
 				page_block++, block_in_file++) {
 		bh.b_state = 0;
 		if (block_in_file < last_block) {
+			bh.b_size = blocksize;
 			if (get_block(inode, block_in_file, &bh, 0))
 				goto confused;
 		}
@@ -472,6 +473,7 @@ __mpage_writepage(struct bio *bio, struc
 	for (page_block = 0; page_block < blocks_per_page; ) {
 
 		map_bh.b_state = 0;
+		map_bh.b_size = 1 << blkbits;
 		if (get_block(inode, block_in_file, &map_bh, 1))
 			goto confused;
 		if (buffer_new(&map_bh))

--=-SRmsICL3+jSSVbuhzvOp--

