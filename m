Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932165AbVJMTN3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbVJMTN3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 15:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbVJMTN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 15:13:29 -0400
Received: from fmr24.intel.com ([143.183.121.16]:27524 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S932165AbVJMTN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 15:13:28 -0400
Message-Id: <200510131913.j9DJDNg07632@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Jens Axboe" <axboe@suse.de>
Subject: [patch] remove gendisk->stamp_idle field
Date: Thu, 13 Oct 2005 12:13:00 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcXQKiDLhS7LjLIJTGGJu82BAV6AZg==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

struct gendisk has these two fields: stamp, stamp_idle.  Update to
stamp_idle is always in sync with stamp and they are always the same.
Therefore, it does not add any value in having two fields tracking
same timestamp.  Suggest to remove it.

Also, we should only update gendisk stats with non-zero value.
Advantage is that we don't have to needlessly calculate memory address,
and then add zero to the content.


Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>

--- ./drivers/block/ll_rw_blk.c.orig	2005-10-13 11:47:02.265928213 -0700
+++ ./drivers/block/ll_rw_blk.c	2005-10-13 11:50:22.289363262 -0700
@@ -2433,13 +2433,12 @@ void disk_round_stats(struct gendisk *di
 {
 	unsigned long now = jiffies;
 
-	__disk_stat_add(disk, time_in_queue,
-			disk->in_flight * (now - disk->stamp));
+	if (disk->in_flight) {
+		__disk_stat_add(disk, time_in_queue,
+				disk->in_flight * (now - disk->stamp));
+		__disk_stat_add(disk, io_ticks, (now - disk->stamp));
+	}
 	disk->stamp = now;
-
-	if (disk->in_flight)
-		__disk_stat_add(disk, io_ticks, (now - disk->stamp_idle));
-	disk->stamp_idle = now;
 }
 
 /*
--- ./fs/partitions/check.c.orig	2005-10-13 11:52:09.186822890 -0700
+++ ./fs/partitions/check.c	2005-10-13 11:52:41.332330309 -0700
@@ -430,7 +430,7 @@ void del_gendisk(struct gendisk *disk)
 	disk->flags &= ~GENHD_FL_UP;
 	unlink_gendisk(disk);
 	disk_stat_set_all(disk, 0);
-	disk->stamp = disk->stamp_idle = 0;
+	disk->stamp = 0;
 
 	devfs_remove_disk(disk);
 
--- ./include/linux/genhd.h.orig	2005-10-13 11:51:24.137995317 -0700
+++ ./include/linux/genhd.h	2005-10-13 11:51:43.293268520 -0700
@@ -119,7 +119,7 @@ struct gendisk {
 	int policy;
 
 	atomic_t sync_io;		/* RAID */
-	unsigned long stamp, stamp_idle;
+	unsigned long stamp;
 	int in_flight;
 #ifdef	CONFIG_SMP
 	struct disk_stats *dkstats;

