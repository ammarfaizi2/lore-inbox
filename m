Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261982AbUC0Whg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 17:37:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261976AbUC0Whf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 17:37:35 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18354 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261966AbUC0Wh2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 17:37:28 -0500
Message-ID: <4066021A.20308@pobox.com>
Date: Sat, 27 Mar 2004 17:37:14 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-ide@vger.kernel.org
CC: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] speed up SATA
Content-Type: multipart/mixed;
 boundary="------------010307080906010908080803"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010307080906010908080803
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


The "lba48" feature in ATA allows for addressing of sectors > 137GB, and 
also allows for transfers of up to 64K sector, instead of the 
traditional 256 sectors in older ATA.

libata simply limited all transfers to a 200 sectors (just under the 256 
sector limit).  This was mainly being careful, and making sure I had a 
solution that worked everywhere.  I also wanted to see how the iommu S/G 
stuff would shake out.

Things seem to be looking pretty good, so it's now time to turn on 
lba48-sized transfers.  Most SATA disks will be lba48 anyway, even the 
ones smaller than 137GB, for this and other reasons.

With this simple patch, the max request size goes from 128K to 32MB... 
so you can imagine this will definitely help performance.  Throughput 
goes up.  Interrupts go down.  Fun for the whole family.

The attached patch is for 2.6.x kernels only.  It should apply to 
2.6.5-rc2 or later, including my latest 2.6-libata patch on kernel.org. 
This patch should be pretty harmless, but you never know what could 
happen when you throw the throttle wide open.  Testing in -mm would be a 
good thing, for example :)

Volunteers are welcome to post a 2.4 backport of this patch to 
linux-ide@vger.kernel.org, and I'll merge it into my 2.4 libata queue.

Here's what dmesg looks like on my workstation.  Look for the "max 
request 32MB" message just after SCSI prints out the disk information.

libata version 1.02 loaded.
ata_piix version 1.02
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0x24F0 ctl 0x280A bmdma 0x24D0 irq 169
ata2: SATA max UDMA/133 cmd 0x24F8 ctl 0x280E bmdma 0x24D8 irq 169
ata1: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69 86:3e01 87:4003 
88:207f
ata1: dev 0 ATA, max UDMA/133, 488281250 sectors (lba48)
ata1: dev 0 configured for UDMA/133
scsi0 : ata_piix
ata2: SATA port has no device.
ata2: thread exiting
scsi1 : ata_piix
   Vendor: ATA       Model: Maxtor 6Y250M0    Rev: 1.02
   Type:   Direct-Access                      ANSI SCSI revision: 05
ata1: dev 0 max request 32MB (lba48)
SCSI device sda: 488281250 512-byte hdwr sectors (250000 MB)
SCSI device sda: drive cache: write through
  sda: sda1
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0


--------------010307080906010908080803
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

===== drivers/scsi/libata-scsi.c 1.18 vs edited =====
--- 1.18/drivers/scsi/libata-scsi.c	Sat Mar 27 00:21:29 2004
+++ edited/drivers/scsi/libata-scsi.c	Sat Mar 27 16:04:39 2004
@@ -168,6 +168,23 @@
 	sdev->use_10_for_ms = 1;
 	blk_queue_max_phys_segments(sdev->request_queue, LIBATA_MAX_PRD);
 
+	if (sdev->id < ATA_MAX_DEVICES) {
+		struct ata_port *ap;
+		struct ata_device *dev;
+
+		ap = (struct ata_port *) &sdev->host->hostdata[0];
+		dev = &ap->device[sdev->id];
+
+		if (dev->flags & ATA_DFLAG_LBA48) {
+			sdev->host->max_sectors = 65534;
+			blk_queue_max_sectors(sdev->request_queue, 65534);
+			printk(KERN_INFO "ata%u: dev %u max request 32MB (lba48)\n",
+			       ap->id, sdev->id);
+		} else
+			printk(KERN_INFO "ata%u: dev %u max request 128K\n",
+			       ap->id, sdev->id);
+	}
+
 	return 0;	/* scsi layer doesn't check return value, sigh */
 }
 

--------------010307080906010908080803--

