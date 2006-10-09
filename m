Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932405AbWJIIyX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932405AbWJIIyX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 04:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932412AbWJIIyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 04:54:23 -0400
Received: from yacht.ocn.ne.jp ([222.146.40.168]:46062 "EHLO
	smtp.yacht.ocn.ne.jp") by vger.kernel.org with ESMTP
	id S932405AbWJIIyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 04:54:22 -0400
Date: Mon, 9 Oct 2006 17:54:38 +0900
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [PATCH] rd: memory leak on rd_init() failure
Message-ID: <20061009085437.GA5853@localhost>
Mail-Followup-To: akinobu.mita@gmail.com, linux-kernel@vger.kernel.org,
	akpm@osdl.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: akinobu.mita@gmail.com (Akinobu Mita)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If RAM disk driver initialization fails due to blk_alloc_queue() faulure,
the gendisk structs stored in rd_disks[] will not be freed completely.

This patch resolves that memory leak case by doing alloc_disk() and
blk_alloc_queue() at the same time.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

 drivers/block/rd.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

Index: work-fault-inject/drivers/block/rd.c
===================================================================
--- work-fault-inject.orig/drivers/block/rd.c	2006-10-09 15:07:00.000000000 +0900
+++ work-fault-inject/drivers/block/rd.c	2006-10-09 15:08:21.000000000 +0900
@@ -432,6 +432,12 @@ static int __init rd_init(void)
 		rd_disks[i] = alloc_disk(1);
 		if (!rd_disks[i])
 			goto out;
+
+		rd_queue[i] = blk_alloc_queue(GFP_KERNEL);
+		if (!rd_queue[i]) {
+			put_disk(rd_disks[i]);
+			goto out;
+		}
 	}
 
 	if (register_blkdev(RAMDISK_MAJOR, "ramdisk")) {
@@ -442,10 +448,6 @@ static int __init rd_init(void)
 	for (i = 0; i < CONFIG_BLK_DEV_RAM_COUNT; i++) {
 		struct gendisk *disk = rd_disks[i];
 
-		rd_queue[i] = blk_alloc_queue(GFP_KERNEL);
-		if (!rd_queue[i])
-			goto out_queue;
-
 		blk_queue_make_request(rd_queue[i], &rd_make_request);
 		blk_queue_hardsect_size(rd_queue[i], rd_blocksize);
 
@@ -466,8 +468,6 @@ static int __init rd_init(void)
 		CONFIG_BLK_DEV_RAM_COUNT, rd_size, rd_blocksize);
 
 	return 0;
-out_queue:
-	unregister_blkdev(RAMDISK_MAJOR, "ramdisk");
 out:
 	while (i--) {
 		put_disk(rd_disks[i]);
