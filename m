Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264276AbUFKRly@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264276AbUFKRly (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 13:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264277AbUFKRjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 13:39:10 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:50161 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S264198AbUFKRdo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 13:33:44 -0400
Date: Fri, 11 Jun 2004 19:33:49 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390: xpram device driver.
Message-ID: <20040611173349.GF3279@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] s390: xpram device driver.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

xpram device driver changes:
 - Allocate request queue with blk_alloc_queue.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/block/xpram.c |   17 +++++++++++++----
 1 files changed, 13 insertions(+), 4 deletions(-)

diff -urN linux-2.6/drivers/s390/block/xpram.c linux-2.6-s390/drivers/s390/block/xpram.c
--- linux-2.6/drivers/s390/block/xpram.c	Fri Jun 11 19:09:24 2004
+++ linux-2.6-s390/drivers/s390/block/xpram.c	Fri Jun 11 19:09:58 2004
@@ -423,7 +423,7 @@
 	return 0;
 }
 
-static struct request_queue xpram_queue;
+static struct request_queue *xpram_queue;
 
 static int __init xpram_setup_blkdev(void)
 {
@@ -450,8 +450,13 @@
 	 * Assign the other needed values: make request function, sizes and
 	 * hardsect size. All the minor devices feature the same value.
 	 */
-	blk_queue_make_request(&xpram_queue, xpram_make_request);
-	blk_queue_hardsect_size(&xpram_queue, 4096);
+	xpram_queue = blk_alloc_queue(GFP_KERNEL);
+	if (!xpram_queue) {
+		rc = -ENOMEM;
+		goto out_unreg;
+	}
+	blk_queue_make_request(xpram_queue, xpram_make_request);
+	blk_queue_hardsect_size(xpram_queue, 4096);
 
 	/*
 	 * Setup device structures.
@@ -467,7 +472,7 @@
 		disk->first_minor = i;
 		disk->fops = &xpram_devops;
 		disk->private_data = &xpram_devices[i];
-		disk->queue = &xpram_queue;
+		disk->queue = xpram_queue;
 		sprintf(disk->disk_name, "slram%d", i);
 		sprintf(disk->devfs_name, "slram/%d", i);
 		set_capacity(disk, xpram_sizes[i] << 1);
@@ -475,6 +480,9 @@
 	}
 
 	return 0;
+out_unreg:
+	devfs_remove("slram");
+	unregister_blkdev(XPRAM_MAJOR, XPRAM_NAME);
 out:
 	while (i--)
 		put_disk(xpram_disks[i]);
@@ -493,6 +501,7 @@
 	}
 	unregister_blkdev(XPRAM_MAJOR, XPRAM_NAME);
 	devfs_remove("slram");
+	blk_cleanup_queue(xpram_queue);
 	sysdev_unregister(&xpram_sys_device);
 	sysdev_class_unregister(&xpram_sysclass);
 }
