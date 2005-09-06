Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750795AbVIFSyd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbVIFSyd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 14:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbVIFSyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 14:54:33 -0400
Received: from touchdown.wvpn.de ([212.227.64.97]:757 "EHLO mail.wvpn.de")
	by vger.kernel.org with ESMTP id S1750795AbVIFSyc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 14:54:32 -0400
Message-ID: <431DE5E8.8000703@maintech.de>
Date: Tue, 06 Sep 2005 20:54:32 +0200
From: Thomas Kleffel <tk@maintech.de>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: B.Zolnierkiewicz@elka.pw.edu.pl
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: [PATCH] fix kernel oops, when IDE-Device (CF-Card) is removed while
 mounted.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

when I physically remove a CF-Card while it is still mounted and 
accessed, the result is a kernel oops. I traced the problem down to the 
following situation:

1) Physical device is removed and the corresponding ide_trive_t gets 
deleted, reference to the contained *queue is given back and queue gets 
deleted.

2) struct block_device still exists, because the device is still 
mounted, and points to a struct gendisk, which contains the - now 
invalid - pointer to the queue that was destructed earlier.

3) As soon as a request is sent to the block device, the queue pointer 
is used and the kernel oopses.

To fix this matter, I've made the following changes:

1a) When a queue is attached to a struct gendisk by ide_disk_probe(), 
its reference counter shall be incremented by a blk_get_queue()-call.

1b) When a disk is released by disk_release(), its queue's reference 
count shall be decremented by calling blk_cleanup_queue().

2a) When a physical drive is released by drive_release_dev(), the 
corresponding queue is marked dead, so that no further calls to the 
physical device's queue-handler are made.

2b) When a request is submitted to a dead queue using 
generic_make_request(), the request shall be failed immedaiately with 
-ENXIO which causes the caller to recive a "Bus error". This is the same 
beaviour as when a USB-Storage device gets pulled while in use.


diff -uprN -X b/Documentation/dontdiff a/drivers/block/genhd.c 
b/drivers/block/genhd.c
--- a/drivers/block/genhd.c	2005-08-08 15:30:13.000000000 +0200
+++ b/drivers/block/genhd.c	2005-09-05 02:07:46.000000000 +0200
@@ -415,6 +415,9 @@ static struct attribute * default_attrs[
  static void disk_release(struct kobject * kobj)
  {
  	struct gendisk *disk = to_disk(kobj);
+	
+	blk_cleanup_queue(disk->queue);
+	
  	kfree(disk->random);
  	kfree(disk->part);
  	free_disk_stats(disk);
diff -uprN -X b/Documentation/dontdiff a/drivers/block/ll_rw_blk.c 
b/drivers/block/ll_rw_blk.c
--- a/drivers/block/ll_rw_blk.c	2005-08-13 15:54:15.000000000 +0200
+++ b/drivers/block/ll_rw_blk.c	2005-09-05 02:08:35.000000000 +0200
@@ -2877,15 +2877,26 @@ end_io:
  		}

  		if (unlikely(bio_sectors(bio) > q->max_hw_sectors)) {
-			printk("bio too big device %s (%u > %u)\n",
+			printk(KERN_ERR
+				"generic_make_request: "
+				"bio too big device %s (%u > %u)\n",
  				bdevname(bio->bi_bdev, b),
  				bio_sectors(bio),
  				q->max_hw_sectors);
  			goto end_io;
  		}

-		if (unlikely(test_bit(QUEUE_FLAG_DEAD, &q->queue_flags)))
-			goto end_io;
+		if (unlikely(test_bit(QUEUE_FLAG_DEAD, &q->queue_flags))) {
+			printk(KERN_ERR
+				"generic_make_request: access to "
+				"dead device %s (%Lu)\n",
+				bdevname(bio->bi_bdev, b),
+				(long long) bio->bi_sector);
+			bio_endio(bio, bio->bi_size, -ENXIO);
+			break;
+		}

  		block_wait_queue_running(q);

diff -uprN -X b/Documentation/dontdiff a/drivers/ide/ide-disk.c 
b/drivers/ide/ide-disk.c
--- a/drivers/ide/ide-disk.c	2005-08-24 17:58:02.000000000 +0200
+++ b/drivers/ide/ide-disk.c	2005-09-05 02:10:30.000000000 +0200
@@ -1224,6 +1221,9 @@ static int ide_disk_probe(struct device
  	if (!g)
  		goto out_free_idkp;

+	if(0 != blk_get_queue(drive->queue))
+		goto out_free_idkp;
+
  	ide_init_disk(g, drive);

  	ide_register_subdriver(drive, &idedisk_driver);
diff -uprN -X b/Documentation/dontdiff a/drivers/ide/ide-probe.c 
b/drivers/ide/ide-probe.c
--- a/drivers/ide/ide-probe.c	2005-08-24 17:58:02.000000000 +0200
+++ b/drivers/ide/ide-probe.c	2005-09-05 02:10:59.000000000 +0200
@@ -1321,6 +1321,13 @@ static void drive_release_dev (struct de
  		drive->id = NULL;
  	}
  	drive->present = 0;
+
+	/* Set the queue dead, so it won't call us anymore */
+	set_bit(QUEUE_FLAG_DEAD, &drive->queue->queue_flags);
+
+	/* remove pointer to ide drive as it will be gone, soon */
+	drive->queue->queuedata = NULL;
+
  	/* Messed up locking ... */
  	spin_unlock_irq(&ide_lock);
  	blk_cleanup_queue(drive->queue);


Signed-off-by: Thomas Kleffel <tk@maintech.de>

Best regards,
Thomas
