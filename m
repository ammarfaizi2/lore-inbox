Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263150AbTFJPVh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 11:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263183AbTFJPVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 11:21:19 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:17726 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id S263131AbTFJPSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 11:18:49 -0400
Date: Tue, 10 Jun 2003 16:34:52 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] loop 6/9 remove LO_FLAGS_BH_REMAP
In-Reply-To: <Pine.LNX.4.44.0306101606080.2285-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0306101633450.2285-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonah Sherman <jsherman@stuy.edu> pointed out back in February how
LO_FLAGS_BH_REMAP is never actually set, since loop_init_xfer only calls
the init for non-0 encryption type.  Fix that or scrap it?  Let's scrap
it for now, that path (hacking values in bio instead of copying data)
seems never to have been tested, and adds to the number of paths through
loop: leave that optimization to some other occasion.

--- loop5/drivers/block/loop.c	Tue Jun 10 12:54:36 2003
+++ loop6/drivers/block/loop.c	Tue Jun 10 12:56:34 2003
@@ -120,12 +120,6 @@
 	return 0;
 }
 
-static int none_status(struct loop_device *lo, const struct loop_info64 *info)
-{
-	lo->lo_flags |= LO_FLAGS_BH_REMAP;
-	return 0;
-}
-
 static int xor_status(struct loop_device *lo, const struct loop_info64 *info)
 {
 	if (info->lo_encrypt_key_size <= 0)
@@ -136,7 +130,6 @@
 struct loop_func_table none_funcs = { 
 	.number = LO_CRYPT_NONE,
 	.transfer = transfer_none,
-	.init = none_status,
 }; 	
 
 struct loop_func_table xor_funcs = { 
@@ -481,14 +474,6 @@
 	struct bio *bio;
 
 	/*
-	 * for xfer_funcs that can operate on the same bh, do that
-	 */
-	if (lo->lo_flags & LO_FLAGS_BH_REMAP) {
-		bio = rbh;
-		goto out_bh;
-	}
-
-	/*
 	 * When called on the page reclaim -> writepage path, this code can
 	 * trivially consume all memory.  So we drop PF_MEMALLOC to avoid
 	 * stealing all the page reserves and throttle to the writeout rate.
@@ -507,8 +492,6 @@
 
 	bio->bi_end_io = loop_end_io_transfer;
 	bio->bi_private = rbh;
-
-out_bh:
 	bio->bi_sector = rbh->bi_sector + (lo->lo_offset >> 9);
 	bio->bi_rw = rbh->bi_rw;
 	bio->bi_bdev = lo->lo_device;
--- loop5/include/linux/loop.h	Sun Apr 20 08:02:13 2003
+++ loop6/include/linux/loop.h	Tue Jun 10 12:56:08 2003
@@ -70,7 +70,6 @@
  */
 #define LO_FLAGS_DO_BMAP	1
 #define LO_FLAGS_READ_ONLY	2
-#define LO_FLAGS_BH_REMAP	4
 
 #include <asm/posix_types.h>	/* for __kernel_old_dev_t */
 #include <asm/types.h>		/* for __u64 */

