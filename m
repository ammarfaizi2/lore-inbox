Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266902AbUHOVfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266902AbUHOVfU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 17:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266910AbUHOVfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 17:35:20 -0400
Received: from ozlabs.org ([203.10.76.45]:3269 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266902AbUHOVfN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 17:35:13 -0400
Date: Mon, 16 Aug 2004 07:30:13 +1000
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, jrsantos@austin.ibm.com
Subject: [PATCH] reduce size of struct buffer_head on 64bit
Message-ID: <20040815213013.GI5637@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Reduce size of buffer_head from 96 to 88 bytes on 64bit architectures by
putting b_count and b_size together. b_count will still be in the first
16 bytes on 32bit architectures, so 16 byte cacheline machines shouldnt
be affected.

With this change the number of objects per 4kB slab goes up from
40 to 44 on ppc64.

Signed-off-by: Anton Blanchard <anton@samba.org>

diff -puN include/linux/buffer_head.h~optimize_structs include/linux/buffer_head.h
--- gr_work/include/linux/buffer_head.h~optimize_structs	2004-08-14 10:51:08.695492352 -0500
+++ gr_work-anton/include/linux/buffer_head.h	2004-08-14 10:51:08.716489022 -0500
@@ -47,12 +47,12 @@ typedef void (bh_end_io_t)(struct buffer
 struct buffer_head {
 	/* First cache line: */
 	unsigned long b_state;		/* buffer state bitmap (see above) */
-	atomic_t b_count;		/* users using this block */
 	struct buffer_head *b_this_page;/* circular list of page's buffers */
 	struct page *b_page;		/* the page this bh is mapped to */
+	atomic_t b_count;		/* users using this block */
+	u32 b_size;			/* block size */
 
 	sector_t b_blocknr;		/* block number */
-	u32 b_size;			/* block size */
 	char *b_data;			/* pointer to data block */
 
 	struct block_device *b_bdev;

