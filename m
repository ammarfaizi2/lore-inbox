Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964828AbWB0VWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964828AbWB0VWP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 16:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751836AbWB0VWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 16:22:13 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:60346 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751837AbWB0VWL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 16:22:11 -0500
Subject: [PATCH 2/4] pass b_size to ->get_block()
From: Badari Pulavarty <pbadari@us.ibm.com>
To: akpm@osdl.org
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1141075239.10542.19.camel@dyn9047017100.beaverton.ibm.com>
References: <1141075239.10542.19.camel@dyn9047017100.beaverton.ibm.com>
Content-Type: multipart/mixed; boundary="=-6by18o6wFZh92Mq8ep4d"
Date: Mon, 27 Feb 2006 13:23:33 -0800
Message-Id: <1141075413.10542.23.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6by18o6wFZh92Mq8ep4d
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Pass amount of disk needs to be mapped to get_block().
This way one can modify the fs ->get_block() functions
to map multiple blocks at the same time.



--=-6by18o6wFZh92Mq8ep4d
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

Index: linux-2.6.16-rc5/fs/buffer.c
===================================================================
--- linux-2.6.16-rc5.orig/fs/buffer.c	2006-02-27 08:22:37.000000000 -0800
+++ linux-2.6.16-rc5/fs/buffer.c	2006-02-27 08:22:45.000000000 -0800
@@ -1786,6 +1786,7 @@ static int __block_write_full_page(struc
 			clear_buffer_dirty(bh);
 			set_buffer_uptodate(bh);
 		} else if (!buffer_mapped(bh) && buffer_dirty(bh)) {
+			bh->b_size = 1 << inode->i_blkbits;
 			err = get_block(inode, block, bh, 1);
 			if (err)
 				goto recover;
@@ -1939,6 +1940,7 @@ static int __block_prepare_write(struct 
 		if (buffer_new(bh))
 			clear_buffer_new(bh);
 		if (!buffer_mapped(bh)) {
+			bh->b_size = 1 << inode->i_blkbits;
 			err = get_block(inode, block, bh, 1);
 			if (err)
 				break;
@@ -2094,6 +2096,7 @@ int block_read_full_page(struct page *pa
 
 			fully_mapped = 0;
 			if (iblock < lblock) {
+				bh->b_size = 1 << inode->i_blkbits;
 				err = get_block(inode, iblock, bh, 0);
 				if (err)
 					SetPageError(page);
@@ -2415,6 +2418,7 @@ int nobh_prepare_write(struct page *page
 		create = 1;
 		if (block_start >= to)
 			create = 0;
+		map_bh.b_size = 1 << blkbits;
 		ret = get_block(inode, block_in_file + block_in_page,
 					&map_bh, create);
 		if (ret)
@@ -2675,6 +2679,7 @@ int block_truncate_page(struct address_s
 
 	err = 0;
 	if (!buffer_mapped(bh)) {
+		bh->b_size = 1 << inode->i_blkbits;
 		err = get_block(inode, iblock, bh, 0);
 		if (err)
 			goto unlock;
@@ -2761,6 +2766,7 @@ sector_t generic_block_bmap(struct addre
 	struct inode *inode = mapping->host;
 	tmp.b_state = 0;
 	tmp.b_blocknr = 0;
+	tmp.b_size = 1 << inode->i_blkbits;
 	get_block(inode, block, &tmp, 0);
 	return tmp.b_blocknr;
 }
Index: linux-2.6.16-rc5/include/linux/buffer_head.h
===================================================================
--- linux-2.6.16-rc5.orig/include/linux/buffer_head.h	2006-02-27 08:22:37.000000000 -0800
+++ linux-2.6.16-rc5/include/linux/buffer_head.h	2006-02-27 08:22:45.000000000 -0800
@@ -280,6 +280,7 @@ map_bh(struct buffer_head *bh, struct su
 	set_buffer_mapped(bh);
 	bh->b_bdev = sb->s_bdev;
 	bh->b_blocknr = block;
+	bh->b_size =  sb->s_blocksize;
 }
 
 /*
Index: linux-2.6.16-rc5/fs/mpage.c
===================================================================
--- linux-2.6.16-rc5.orig/fs/mpage.c	2006-02-26 21:09:35.000000000 -0800
+++ linux-2.6.16-rc5/fs/mpage.c	2006-02-27 08:22:45.000000000 -0800
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

--=-6by18o6wFZh92Mq8ep4d--

