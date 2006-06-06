Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932205AbWFFP0z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbWFFP0z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 11:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932209AbWFFP0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 11:26:55 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:3595 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932208AbWFFP0y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 11:26:54 -0400
Date: Tue, 6 Jun 2006 11:26:53 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
       James Bottomley <James.Bottomley@SteelEye.com>
cc: Kernel development list <linux-kernel@vger.kernel.org>,
       SCSI development list <linux-scsi@vger.kernel.org>
Subject: [PATCH 1/3] block layer: early detection of medium not present
Message-ID: <Pine.LNX.4.44L0.0606061113040.9182-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When the block layer checks for new media in a drive, it uses a two-step 
procedure: First it checks for media change and then it revalidates the 
disk.  When no medium is present the second step fails.

However some drivers (such as the SCSI disk driver) are capable of
detecting medium-not-present as part of the media-changed check.  Doing so
will reduce by a factor of 2 or more the amount of work done by tasks
which, like hald, constantly poll empty drives.

This patch (as694) changes the block layer core to make it recognize a 
-ENOMEDIUM error return from the media_changed method.  A follow-on patch 
makes the sd driver return this code when no medium is present.



Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

In fact, each sd poll by hald ends up sending 8 (!) SCSI commands: 4 pairs
of TEST UNIT READY plus REQUEST SENSE.  These patches will reduce it to
two commands.

As far as I can see, drivers don't return anything other than 0 or 1 for 
media_changed, so recognizing this error code shouldn't cause any new 
problems.

Index: usb-2.6/fs/block_dev.c
===================================================================
--- usb-2.6.orig/fs/block_dev.c
+++ usb-2.6/fs/block_dev.c
@@ -818,14 +818,18 @@ int check_disk_change(struct block_devic
 {
 	struct gendisk *disk = bdev->bd_disk;
 	struct block_device_operations * bdops = disk->fops;
+	int rc;
 
 	if (!bdops->media_changed)
 		return 0;
-	if (!bdops->media_changed(bdev->bd_disk))
+	rc = bdops->media_changed(bdev->bd_disk);
+	if (!rc)
 		return 0;
 
 	if (__invalidate_device(bdev))
 		printk("VFS: busy inodes on changed media.\n");
+	if (rc == -ENOMEDIUM)
+		return 1;
 
 	if (bdops->revalidate_disk)
 		bdops->revalidate_disk(bdev->bd_disk);

