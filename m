Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265810AbUFVU2B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265810AbUFVU2B (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 16:28:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265132AbUFVUYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 16:24:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31901 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265810AbUFVUWs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 16:22:48 -0400
Message-ID: <40D89509.6010502@pobox.com>
Date: Tue, 22 Jun 2004 16:22:33 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-ide@vger.kernel.org
CC: Ricky Beam <jfbeam@bluetronic.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix sata_sil quirk
Content-Type: multipart/mixed;
 boundary="------------010603080104080507040708"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010603080104080507040708
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Here's my suggested fix...  good catch Ricky.

Yes, unfortunately performance will be dog slow.

Silicon Image 311x is fully SATA compliant -- but it's the only 
controller that sends odd-sized packets to the SATA device.  That causes 
no end of problems, including the thing that SIL_QUIRK_MOD15WRITE 
attempts to work around.

I've got contacts at Silicon Image, and have been meaning to bug them 
for a "real fix" for a while.  It is rumored that there is a much better 
fix, which allows full performance while at the same time not killing 
your SATA drive due to odd-sized SATA frames on the wire.

Unfortunately, at this point in time, we must err on the side of caution 
and cripple performance, for stability.

	Jeff



--------------010603080104080507040708
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

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
