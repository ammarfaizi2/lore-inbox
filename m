Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316615AbSGGXB6>; Sun, 7 Jul 2002 19:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316621AbSGGXB5>; Sun, 7 Jul 2002 19:01:57 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54032 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316615AbSGGXB4>;
	Sun, 7 Jul 2002 19:01:56 -0400
Message-ID: <3D28CA7D.9930E9F7@zip.com.au>
Date: Sun, 07 Jul 2002 16:10:53 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch] fix O_DIRECT oops
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


inode->i_sb->s_bdev is NULL when the inode refers to a blockdev.
Use the get_block() result instead.


 buffer.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

--- 2.5.25/fs/buffer.c~direct_io-fix	Sun Jul  7 04:00:23 2002
+++ 2.5.25-akpm/fs/buffer.c	Sun Jul  7 04:01:38 2002
@@ -2302,8 +2302,9 @@ int generic_direct_IO(int rw, struct ino
 			struct kiobuf *iobuf, unsigned long blocknr,
 			int blocksize, get_block_t *get_block)
 {
-	int i, nr_blocks, retval;
+	int i, nr_blocks, retval = 0;
 	sector_t *blocks = iobuf->blocks;
+	struct block_device *bdev = NULL;
 
 	nr_blocks = iobuf->length / blocksize;
 	/* build the blocklist */
@@ -2333,11 +2334,12 @@ int generic_direct_IO(int rw, struct ino
 				BUG();
 		}
 		blocks[i] = bh.b_blocknr;
+		bdev = bh.b_bdev;
 	}
 
 	/* This does not understand multi-device filesystems currently */
-	retval = brw_kiovec(rw, 1, &iobuf,
-			inode->i_sb->s_bdev, blocks, blocksize);
+	if (bdev)
+		retval = brw_kiovec(rw, 1, &iobuf, bdev, blocks, blocksize);
 
  out:
 	return retval;

-
