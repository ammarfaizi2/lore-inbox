Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262707AbUATWl1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 17:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265748AbUATWl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 17:41:27 -0500
Received: from email-out1.iomega.com ([147.178.1.82]:15597 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S262707AbUATWlY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 17:41:24 -0500
Subject: Re: [PATCH] fix blockdev --getro for sr, sd, ide-floppy devs (with
	patch this time)
From: John McKell <mckellj@iomega.com>
To: Paul Bristow <paul@paulbristow.net>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Iomega Corp.
Message-Id: <1074638483.3350.2.camel@lintest.iomegacorp.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 20 Jan 2004 15:41:23 -0700
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Jan 2004 22:41:23.0914 (UTC) FILETIME=[883362A0:01C3DFA6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This 2.6.1 patch works by setting gendisk->policy to the correct value
during initialization as the various drivers decide whether or not the
disk is writeable.  This patch persuades "blockdev --getro ..." to
correctly report the read-only state of a newly inserted disk.  This
patch applies to sr.c, sd.c and ide-floppy.c.  ide-cd.c already has
this functionality built into it.

Using an Iomega Zip drive as the test case...

Without the patch, I always see: 

$ sudo blockdev --getro /dev/sda 
0
$

That's only correct for writeable disks though.  Only when the patch
is applied do I see a write-protected disk described correctly:

$ sudo blockdev --getro /dev/sda 
1
$

--John McKell


diff -Nurp linux-2.6.1/drivers/ide/ide-floppy.c linux/drivers/ide/ide-floppy.c
--- linux-2.6.1/drivers/ide/ide-floppy.c	2004-01-08 23:59:33.000000000 -0700
+++ linux/drivers/ide/ide-floppy.c	2004-01-14 08:46:26.000000000 -0700
@@ -1317,6 +1317,7 @@ static int idefloppy_get_flexible_disk_p
 	}
 	header = (idefloppy_mode_parameter_header_t *) pc.buffer;
 	floppy->wp = header->wp;
+	set_disk_ro(drive->disk, floppy->wp);
 	page = (idefloppy_flexible_disk_page_t *) (header + 1);
 
 	page->transfer_rate = ntohs(page->transfer_rate);
diff -Nurp linux-2.6.1/drivers/scsi/sd.c linux/drivers/scsi/sd.c
--- linux-2.6.1/drivers/scsi/sd.c	2004-01-08 23:59:49.000000000 -0700
+++ linux/drivers/scsi/sd.c	2004-01-14 08:46:26.000000000 -0700
@@ -1089,6 +1089,7 @@ sd_read_write_protect_flag(struct scsi_d
 	int res;
 	struct scsi_mode_data data;
 
+	set_disk_ro(sdkp->disk, 0);
 	if (sdkp->device->skip_ms_page_3f) {
 		printk(KERN_NOTICE "%s: assuming Write Enabled\n", diskname);
 		return;
@@ -1120,6 +1121,7 @@ sd_read_write_protect_flag(struct scsi_d
 		       "%s: test WP failed, assume Write Enabled\n", diskname);
 	} else {
 		sdkp->write_prot = ((data.device_specific & 0x80) != 0);
+		set_disk_ro(sdkp->disk, sdkp->write_prot);
 		printk(KERN_NOTICE "%s: Write Protect is %s\n", diskname,
 		       sdkp->write_prot ? "on" : "off");
 		printk(KERN_DEBUG "%s: Mode Sense: %02x %02x %02x %02x\n",
diff -Nurp linux-2.6.1/drivers/scsi/sr.c linux/drivers/scsi/sr.c
--- linux-2.6.1/drivers/scsi/sr.c	2004-01-08 23:59:19.000000000 -0700
+++ linux/drivers/scsi/sr.c	2004-01-14 09:16:18.000000000 -0700
@@ -711,6 +711,9 @@ static void get_capabilities(struct scsi
 		""
 	};
 
+	/* Set read only initially */
+	set_disk_ro(cd->disk, 1);
+
 	/* allocate a request for the TEST_UNIT_READY */
 	SRpnt = scsi_allocate_request(cd->device, GFP_KERNEL);
 	if (!SRpnt) {
@@ -790,6 +793,7 @@ static void get_capabilities(struct scsi
 		cd->cdi.mask |= CDC_DVD_RAM;
 	} else {
 		cd->device->writeable = 1;
+		set_disk_ro(cd->disk, 0);
 	}
 	if ((buffer[n + 3] & 0x10) == 0)
 		/* can't write DVD-R media */




