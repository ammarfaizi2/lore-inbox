Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262277AbSJNX1a>; Mon, 14 Oct 2002 19:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262250AbSJNX1a>; Mon, 14 Oct 2002 19:27:30 -0400
Received: from hera.cwi.nl ([192.16.191.8]:41398 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S262277AbSJNX10>;
	Mon, 14 Oct 2002 19:27:26 -0400
From: Andries.Brouwer@cwi.nl
Date: Tue, 15 Oct 2002 01:33:17 +0200 (MEST)
Message-Id: <UTC200210142333.g9ENXHP29457.aeb@smtp.cwi.nl>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] misc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A moment ago I wanted to get some photographs off some
CF cards. Under 2.5.42 lots of things failed.

First of all, no USB device worked because the hub things
were on was not recognized. It looks like the reason is that
drivers/base/core.c:found_match() returns nonzero now
while it returned 0 earlier (before 2.5.39).

Phenomenon:
An attempt to match 1-1:0 with usbscanner would return an
error, and then an attempt to match it with hub would
succeed. In the present code the first error causes
the loops in bus_for_each_dev and bus_for_each_drv to abort.

So, maybe found_match() must return the opposite of the
present return code, to continue scanning if something is
wrong, and to stop when the right match has been found.


diff -u --recursive --new-file -X /linux/dontdiff a/drivers/base/core.c b/drivers/base/core.c
--- a/drivers/base/core.c	Sat Oct 12 19:28:37 2002
+++ b/drivers/base/core.c	Mon Oct 14 22:59:45 2002
@@ -54,7 +54,7 @@
  */
 static int found_match(struct device * dev, struct device_driver * drv)
 {
-	int error = 0;
+	int error;
 
 	if (!(error = probe(dev,get_driver(drv)))) {
 		pr_debug("bound device '%s' to driver '%s'\n",
@@ -64,7 +64,7 @@
 		put_driver(drv);
 		dev->driver = NULL;
 	}
-	return error;
+	return !error;
 }
 
 /**


With such a change the USB devices were found, and I got photographs
off the first CF card. Then exchanged cards and wanted to use the second
one, of a different capacity.

But /proc/partitions continued to show the old capacity, also after a dd
and also after a mount. And also after a BLKRRPART ioctl.
Not only is media_change broken, also partition rereading is.
Repairing the ioctl is easy:

diff -u --recursive --new-file -X /linux/dontdiff a/fs/block_dev.c b/fs/block_dev.c
--- a/fs/block_dev.c	Tue Oct  8 21:57:34 2002
+++ b/fs/block_dev.c	Mon Oct 14 23:13:52 2002
@@ -808,6 +808,10 @@
 		return -EACCES;
 	if (down_trylock(&bdev->bd_sem))
 		return -EBUSY;
+
+	/* make sure rescan_partitions will actually do something */
+	bdev->bd_invalidated = 1;
+
 	res = rescan_partitions(disk, bdev);
 	up(&bdev->bd_sem);
 	return res;

Indeed, when bdev->bd_invalidated is zero, rescan_partitions() doesnt
do anything, so that is why the ioctl failed.
But why was media change broken? I looked at check_scsidisk_media_change.
It contains some silly code that has been there since 0.99, and recently
got the comment "what is this for??". It can be deleted.

diff -u --recursive --new-file -X /linux/dontdiff a/drivers/scsi/sd.c b/drivers/scsi/sd.c
--- a/drivers/scsi/sd.c	Sat Oct 12 19:28:46 2002
+++ b/drivers/scsi/sd.c	Mon Oct 14 23:18:36 2002
@@ -337,7 +337,9 @@
 		 * quietly refuse to do anything to a changed disc until 
 		 * the changed bit has been reset
 		 */
-		/* printk("SCSI disk has been changed. Prohibiting further I/O.\n"); */
+#if 0
+		printk("SCSI disk has been changed. Prohibiting further I/O.\n");
+#endif
 		return 0;
 	}
 	SCSI_LOG_HLQUEUE(2, sd_dskname(dsk_nr, nbuff));
@@ -717,7 +719,6 @@
 static int check_scsidisk_media_change(kdev_t full_dev)
 {
 	int retval;
-	int flag = 0;	/* <<<< what is this for?? */
 	Scsi_Disk * sdkp;
 	Scsi_Device * sdp;
 	int dsk_nr = DEVICE_NR(full_dev);
@@ -775,8 +776,7 @@
 	sdkp->media_present = 1;
 
 	retval = sdp->changed;
-	if (!flag)
-		sdp->changed = 0;
+	sdp->changed = 0;
 	return retval;
 }
 
Concerning the media change:
US_FL_START_STOP no longer does anything in usb-storage.
The START_STOP command from sd.c is changed into a TEST_UNIT_READY
in usb.c, and the device reports that it is ready.
No media change is seen.

I removed the USB device and inserted it elsewhere.
It was recognized as the same device (it would be, also
if it had been a different one: only vendor+productid is checked,
the thing has no serial number, and the CF card inside does not
influence this GUID either.

[Thus, recognizing a device after removal+insertion is broken
and cannot be repaired, there is not enough information.]

Then I tried to force a detection of media change by removing
the device and doing a BLKRRPART. That caused a kernel crash.
BUG at drivers/base/core:251. (BUG_ON(dev->present)).

Another funny effect was caused by the fact that disk sizes
are now stored both in bdev->bd_inode->i_size and in gendisk.
During a partition table reread on a changed disk the value
in bdev->bd_inode->i_size was used, causing lots of I/O errors
since the new disk was smaller than the old one. Amusing
error messages:
      end_request: I/O error, dev 08:10, sector 63480
      Buffer I/O error on device sd(8,16), logical block 7935
as if the code was not clear what block it was reading.

(And getting the size right is important for efi.c -
it reads the last sector.)

Let me leave these last ones for Al.
Below a typo fix and removal of an annoying debugging message.      

diff -u --recursive --new-file -X /linux/dontdiff a/Documentation/block/biodoc.txt b/Documentation/block/biodoc.txt
--- a/Documentation/block/biodoc.txt	Sun Jun  9 07:27:48 2002
+++ b/Documentation/block/biodoc.txt	Fri Oct 11 02:25:23 2002
@@ -1175,7 +1175,7 @@
 8.12. Multiple block-size transfers for faster raw i/o (Shailabh Nagar,
       Badari)
 8.13  Priority based i/o scheduler - prepatches (Arjan van de Ven)
-8.14  IDE Taskfile i/o patch (Andre Hedrik)
+8.14  IDE Taskfile i/o patch (Andre Hedrick)
 8.15  Multi-page writeout and readahead patches (Andrew Morton)
 8.16  Direct i/o patches for 2.5 using kvec and bio (Badari Pulavarthy)
 
diff -u --recursive --new-file -X /linux/dontdiff a/fs/partitions/ldm.c b/fs/partitions/ldm.c
--- a/fs/partitions/ldm.c	Sat Oct 12 19:28:49 2002
+++ b/fs/partitions/ldm.c	Mon Oct 14 18:56:14 2002
@@ -561,7 +561,9 @@
 	}
 
 	if (*(u16*) (data + 0x01FE) != cpu_to_le16 (MSDOS_LABEL_MAGIC)) {
+#if 0
 		ldm_debug ("No MS-DOS partition table found.");
+#endif
 		goto out;
 	}
 
@@ -574,8 +576,10 @@
 
 	if (result)
 		ldm_debug ("Parsed partition table successfully.");
+#if 0
 	else
 		ldm_debug ("Found an MS-DOS partition table, not a dynamic disk.");
+#endif
 out:
 	put_dev_sector (sect);
 	return result;

Andries
