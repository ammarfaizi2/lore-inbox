Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266754AbTGFVGB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 17:06:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266753AbTGFVGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 17:06:00 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:11271 "EHLO
	fenric.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263802AbTGFVFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 17:05:49 -0400
Message-ID: <3F089281.5BED1A25@SteelEye.com>
Date: Sun, 06 Jul 2003 17:20:01 -0400
From: Paul Clements <Paul.Clements@SteelEye.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: [PATCH 2.5.74-mm2] nbd: make nbd and block layer agree about device and 
 block sizes
References: <3F089177.1A58BFE0@SteelEye.com>
Content-Type: multipart/mixed;
 boundary="------------66749B18BC819F9043735563"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------66749B18BC819F9043735563
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Andrew,

here's the revised patch for block and device size changes, using
set_blocksize() as Jeff suggested

Thanks,
Paul
--------------66749B18BC819F9043735563
Content-Type: text/x-diff; charset=us-ascii;
 name="nbd-block_layer_compat-2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nbd-block_layer_compat-2.diff"

--- linux-2.5.74-mm2/drivers/block/nbd.c.MINUS_OPEN_RELEASE	2003-07-06 16:55:22.224389840 -0400
+++ linux-2.5.74-mm2/drivers/block/nbd.c	2003-07-06 16:50:46.287338648 -0400
@@ -588,18 +588,22 @@ static int nbd_ioctl(struct inode *inode
 		}
 		return error;
 	case NBD_SET_BLKSIZE:
-		if ((arg & (arg-1)) || (arg < 512) || (arg > PAGE_SIZE))
-			return -EINVAL;
 		lo->blksize = arg;
-		lo->bytesize &= ~(lo->blksize-1); 
+		lo->bytesize &= ~(lo->blksize-1);
+		inode->i_bdev->bd_inode->i_size = lo->bytesize;
+		set_blocksize(inode->i_bdev, lo->blksize);
 		set_capacity(lo->disk, lo->bytesize >> 9);
 		return 0;
 	case NBD_SET_SIZE:
-		lo->bytesize = arg & ~(lo->blksize-1); 
+		lo->bytesize = arg & ~(lo->blksize-1);
+		inode->i_bdev->bd_inode->i_size = lo->bytesize;
+		set_blocksize(inode->i_bdev, lo->blksize);
 		set_capacity(lo->disk, lo->bytesize >> 9);
 		return 0;
 	case NBD_SET_SIZE_BLOCKS:
 		lo->bytesize = ((u64) arg) * lo->blksize;
+		inode->i_bdev->bd_inode->i_size = lo->bytesize;
+		set_blocksize(inode->i_bdev, lo->blksize);
 		set_capacity(lo->disk, lo->bytesize >> 9);
 		return 0;
 	case NBD_DO_IT:

--------------66749B18BC819F9043735563--

