Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262210AbUCIVRk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 16:17:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262209AbUCIVRk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 16:17:40 -0500
Received: from ns.suse.de ([195.135.220.2]:60587 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262218AbUCIVR3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 16:17:29 -0500
Subject: [PATCH] reading the last block on a bdev
From: Chris Mason <mason@suse.com>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Content-Type: multipart/mixed; boundary="=-3dP7NffZyaEM5y0NGP1m"
Message-Id: <1078867189.25064.1449.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 09 Mar 2004 16:19:49 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3dP7NffZyaEM5y0NGP1m
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello everyone,

This patch fixes a problem we're hitting on ia64 with page sizes > 4k.  

When the page size is greater than the block size, and parts of the page
fall past the end of the device, readpage will fail because
blkdev_get_block returns -EIO for blocks past i_size.

The attached patch changes blkdev_get_block to return holes when reading
past the end of the device, which allows us to read that last valid 4k
block and then fill the rest of the page with zeros.   Writes will still
fail with -EIO.

-chris

--=-3dP7NffZyaEM5y0NGP1m
Content-Disposition: attachment; filename=blkdev_get_block-partial
Content-Type: text/x-patch; name=blkdev_get_block-partial; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: linux.t/fs/block_dev.c
===================================================================
--- linux.t.orig/fs/block_dev.c	2004-03-08 09:56:06.000000000 -0500
+++ linux.t/fs/block_dev.c	2004-03-09 09:48:15.000000000 -0500
@@ -116,9 +116,18 @@ static int
 blkdev_get_block(struct inode *inode, sector_t iblock,
 		struct buffer_head *bh, int create)
 {
-	if (iblock >= max_block(I_BDEV(inode)))
-		return -EIO;
-
+	if (iblock >= max_block(I_BDEV(inode))) {
+		if (create)
+			return -EIO;
+
+		/* 
+		 * for reads, we're just trying to fill a partial page.
+		 * return a hole, they will have to call get_block again
+		 * before they can fill it, and they will get -EIO at that
+		 * time
+		 */
+		return 0;
+	}
 	bh->b_bdev = I_BDEV(inode);
 	bh->b_blocknr = iblock;
 	set_buffer_mapped(bh);

--=-3dP7NffZyaEM5y0NGP1m--

