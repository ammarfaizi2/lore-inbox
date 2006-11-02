Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751004AbWKBKrG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbWKBKrG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 05:47:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752551AbWKBKrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 05:47:05 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:40343 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S1751004AbWKBKrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 05:47:03 -0500
Subject: [PATCH] bdev: fix ->bd_part_count leak
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Cc: Neil Brown <neilb@suse.de>
Content-Type: text/plain
Date: Thu, 02 Nov 2006 11:48:05 +0100
Message-Id: <1162464485.27131.13.camel@taijtu>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Don't leak a ->bd_part_count when the partition open fails with -ENXIO.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 fs/block_dev.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-2.6-mm/fs/block_dev.c
===================================================================
--- linux-2.6-mm.orig/fs/block_dev.c
+++ linux-2.6-mm/fs/block_dev.c
@@ -907,6 +907,7 @@ EXPORT_SYMBOL(bd_set_size);
 
 static int __blkdev_get(struct block_device *bdev, mode_t mode, unsigned flags,
 			int for_part);
+static int __blkdev_put(struct block_device *bdev, int for_part);
 
 static int do_open(struct block_device *bdev, struct file *file, int for_part)
 {
@@ -992,7 +993,7 @@ out_first:
 	bdev->bd_disk = NULL;
 	bdev->bd_inode->i_data.backing_dev_info = &default_backing_dev_info;
 	if (bdev != bdev->bd_contains)
-		blkdev_put(bdev->bd_contains);
+		__blkdev_put(bdev->bd_contains, 1);
 	bdev->bd_contains = NULL;
 	put_disk(disk);
 	module_put(owner);


