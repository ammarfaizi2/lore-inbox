Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266001AbUFVU6i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266001AbUFVU6i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 16:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265932AbUFVUtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 16:49:23 -0400
Received: from sweetums.bluetronic.net ([24.199.150.42]:2554 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S266001AbUFVUfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 16:35:10 -0400
Date: Tue, 22 Jun 2004 16:29:08 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Jeff Garzik <jgarzik@pobox.com>
cc: <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix sata_sil quirk
In-Reply-To: <40D89509.6010502@pobox.com>
Message-ID: <Pine.GSO.4.33.0406221620300.25702-200000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: MULTIPART/Mixed; BOUNDARY=------------010603080104080507040708
Content-ID: <Pine.GSO.4.33.0406221620301.25702@sweetums.bluetronic.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--------------010603080104080507040708
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; FORMAT=flowed
Content-ID: <Pine.GSO.4.33.0406221620302.25702@sweetums.bluetronic.net>

On Tue, 22 Jun 2004, Jeff Garzik wrote:
>Here's my suggested fix...  good catch Ricky.

And I don't even know why I looked at max_sectors :-) (I need more Dew.)

>Yes, unfortunately performance will be dog slow.

Well, at least puppy slow...
Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sda            1811.65         0.00      9629.85          0     577887
sdb            1807.15         0.00      9629.60          0     577872
sdc            1807.25         0.00      9629.86          0     577888
sdd            1807.05         0.00      9629.86          0     577888
md_d0         14444.64         0.00     48148.84          0    2889412
md_d0p2        9629.78         0.00     38519.11          0    2311532
(over 60sec,  8M O_DIRECT accesses, 128 stripes * 16k RAID0)

Without the MOD15 hack, the numbers are 2x higher, but they stop after
a few minutes :-)

>I've got contacts at Silicon Image, and have been meaning to bug them
>for a "real fix" for a while.  It is rumored that there is a much better
>fix, which allows full performance while at the same time not killing
>your SATA drive due to odd-sized SATA frames on the wire.

Ask them what they do in their driver? (the linux one and the windows one)
Looking at the linux driver, the mod15 quirk is there, but there doesn't
appear to be any associated device list. (I've already post the single
Maxtor device listed.)  FreeBSD detects the stall, resets the chip and
hopes that clears the problem. (People are not happy about that.)

--Ricky


--------------010603080104080507040708
Content-Type: TEXT/PLAIN; NAME=patch
Content-ID: <Pine.GSO.4.33.0406221620303.25702@sweetums.bluetronic.net>
Content-Description: 
Content-Disposition: INLINE; FILENAME=patch

===== drivers/scsi/libata-scsi.c 1.39 vs edited =====
--- 1.39/drivers/scsi/libata-scsi.c	2004-05-12 11:46:21 -04:00
+++ edited/drivers/scsi/libata-scsi.c	2004-06-22 16:18:57 -04:00
@@ -182,7 +182,8 @@
 		 * 65534 when Jens Axboe's patch for dynamically
 		 * determining max_sectors is merged.
 		 */
-		if (dev->flags & ATA_DFLAG_LBA48) {
+		if ((dev->flags & ATA_DFLAG_LBA48) &&
+		    ((dev->flags & ATA_DFLAG_LOCK_SECTORS) == 0)) {
 			sdev->host->max_sectors = 2048;
 			blk_queue_max_sectors(sdev->request_queue, 2048);
 		}
===== drivers/scsi/sata_sil.c 1.26 vs edited =====
--- 1.26/drivers/scsi/sata_sil.c	2004-06-15 00:29:32 -04:00
+++ edited/drivers/scsi/sata_sil.c	2004-06-22 16:18:21 -04:00
@@ -302,6 +302,7 @@
 		       ap->id, dev->devno);
 		ap->host->max_sectors = 15;
 		ap->host->hostt->max_sectors = 15;
+		dev->flags |= ATA_DFLAG_LOCK_SECTORS;
 		return;
 	}
 
===== include/linux/libata.h 1.38 vs edited =====
--- 1.38/include/linux/libata.h	2004-06-22 00:54:44 -04:00
+++ edited/include/linux/libata.h	2004-06-22 16:17:44 -04:00
@@ -91,6 +91,7 @@
 	ATA_DFLAG_MASTER	= (1 << 2), /* is device 0? */
 	ATA_DFLAG_WCACHE	= (1 << 3), /* has write cache we can
 					     * (hopefully) flush? */
+	ATA_DFLAG_LOCK_SECTORS	= (1 << 4), /* don't adjust max_sectors */
 
 	ATA_DEV_UNKNOWN		= 0,	/* unknown device */
 	ATA_DEV_ATA		= 1,	/* ATA device */

--------------010603080104080507040708--
