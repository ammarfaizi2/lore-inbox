Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261584AbSJYUyX>; Fri, 25 Oct 2002 16:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261590AbSJYUyX>; Fri, 25 Oct 2002 16:54:23 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:58010 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id <S261584AbSJYUyW>; Fri, 25 Oct 2002 16:54:22 -0400
Date: Fri, 25 Oct 2002 22:01:30 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Alexander Viro <viro@math.psu.edu>
cc: Andrew Morton <akpm@digeo.com>, "Adam J. Richter" <adam@yggdrasil.com>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH] i_blkbits inconsistency
Message-ID: <Pine.LNX.4.44.0210252158020.1213-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix premature -EIO from blkdev_get_block: bdget initialize bd_block_size
consistent with bd_inode->i_blkbits (assigned by new_inode).  Otherwise,
subsequent set_blocksize can find bd_block_size doesn't need updating,
and skip updating i_blkbits, leaving them inconsistent.

--- 2.5.44/fs/block_dev.c	Sat Oct 19 07:14:45 2002
+++ linux/fs/block_dev.c	Fri Oct 25 21:30:41 2002
@@ -310,6 +310,7 @@
 			new_bdev->bd_queue = NULL;
 			new_bdev->bd_contains = NULL;
 			new_bdev->bd_inode = inode;
+			new_bdev->bd_block_size = (1 << inode->i_blkbits);
 			new_bdev->bd_part_count = 0;
 			new_bdev->bd_invalidated = 0;
 			inode->i_mode = S_IFBLK;

