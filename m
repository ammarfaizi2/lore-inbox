Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262920AbVCWVKI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262920AbVCWVKI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 16:10:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262935AbVCWVIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 16:08:46 -0500
Received: from mailhub.lss.emc.com ([168.159.2.31]:27804 "EHLO
	mailhub.lss.emc.com") by vger.kernel.org with ESMTP id S261269AbVCWUmf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 15:42:35 -0500
From: Brett Russ <russb@emc.com>
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050323203514.D62A1893@lns1032.lss.emc.com>
In-Reply-To: <20050323203514.D62A1893@lns1032.lss.emc.com>
Subject: Re: [PATCH libata-dev-2.6 02/03] libata: create/use ata_dump_status()
Message-ID: <20050323203514.D82D888C@lns1032.lss.emc.com>
Date: Wed, 23 Mar 2005 15:42:29 -0500 (EST)
X-PMX-Version: 4.7.1.128075, Antispam-Engine: 2.0.3.0, Antispam-Data: 2005.3.23.12
X-PerlMx-Spam: Gauge=, SPAM=7%, Reasons='__CT 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __SANE_MSGID 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

02_libata_ata_dump_status.patch

	This patch introduces the ata_dump_status() function, which
	for now is called from ata_to_sense_error() only.

Signed-off-by: Brett Russ <russb@emc.com>

 libata-scsi.c |   76 +++++++++++++++++++++++++++++++++-------------------------
 1 files changed, 44 insertions(+), 32 deletions(-)

Index: libata-dev-2.6/drivers/scsi/libata-scsi.c
===================================================================
--- libata-dev-2.6.orig/drivers/scsi/libata-scsi.c	2005-03-23 15:35:09.000000000 -0500
+++ libata-dev-2.6/drivers/scsi/libata-scsi.c	2005-03-23 15:35:09.000000000 -0500
@@ -331,6 +331,49 @@ struct ata_queued_cmd *ata_scsi_qc_new(s
 }
 
 /**
+ *	ata_dump_status - user friendly display of error info
+ *	@id: id of the port in question
+ *	@tf: ptr to filled out taskfile
+ *
+ *	Decode and dump the ATA error/status registers for the user so
+ *	that they have some idea what really happened at the non
+ *	make-believe layer.
+ *
+ *	LOCKING:
+ *	inherited from caller
+ */
+void ata_dump_status(unsigned id, u8 stat, u8 err)
+{
+	printk(KERN_WARNING "ata%u: status=0x%02x { ", id, stat);
+	if (stat & ATA_BUSY) {
+		printk("Busy }\n");	/* Data is not valid in this case */
+	} else {
+		if (stat & 0x40)	printk("DriveReady ");
+		if (stat & 0x20)	printk("DeviceFault ");
+		if (stat & 0x10)	printk("SeekComplete ");
+		if (stat & 0x08)	printk("DataRequest ");
+		if (stat & 0x04)	printk("CorrectedError ");
+		if (stat & 0x02)	printk("Index ");
+		if (stat & 0x01)	printk("Error ");
+		printk("}\n");
+
+		if (err) {
+			printk(KERN_WARNING "ata%u: error=0x%02x { ", id, err);
+			if (err & 0x04)		printk("DriveStatusError ");
+			if (err & 0x80) {
+				if (err & 0x04)	printk("BadCRC ");
+				else		printk("Sector ");
+			}
+			if (err & 0x40)		printk("UncorrectableError ");
+			if (err & 0x10)		printk("SectorIdNotFound ");
+			if (err & 0x02)		printk("TrackZeroNotFound ");
+			if (err & 0x01)		printk("AddrMarkNotFound ");
+			printk("}\n");
+		}
+	}
+}
+
+/**
  *	ata_to_sense_error - convert ATA error to SCSI error
  *	@qc: Command that we are erroring out
  *	@drv_stat: value contained in ATA status register
@@ -400,38 +443,7 @@ void ata_to_sense_error(struct ata_queue
 	if (drv_stat & ATA_ERR)
 		err = ata_chk_err(qc->ap);	/* Read the err bits */
 
-	/* Display the ATA level error info */
-
-	printk(KERN_WARNING "ata%u: status=0x%02x { ", qc->ap->id, drv_stat);
-	if (drv_stat & 0x80) {
-		printk("Busy ");
-		err = 0;	/* Data is not valid in this case */
-	} else {
-		if (drv_stat & 0x40)	printk("DriveReady ");
-		if (drv_stat & 0x20)	printk("DeviceFault ");
-		if (drv_stat & 0x10)	printk("SeekComplete ");
-		if (drv_stat & 0x08)	printk("DataRequest ");
-		if (drv_stat & 0x04)	printk("CorrectedError ");
-		if (drv_stat & 0x02)	printk("Index ");
-		if (drv_stat & 0x01)	printk("Error ");
-	}
-	printk("}\n");
-
-	if (err) {
-		printk(KERN_WARNING "ata%u: error=0x%02x { ", qc->ap->id, err);
-		if (err & 0x04)		printk("DriveStatusError ");
-		if (err & 0x80) {
-			if (err & 0x04)	printk("BadCRC ");
-			else		printk("Sector ");
-		}
-		if (err & 0x40)		printk("UncorrectableError ");
-		if (err & 0x10)		printk("SectorIdNotFound ");
-		if (err & 0x02)		printk("TrackZeroNotFound ");
-		if (err & 0x01)		printk("AddrMarkNotFound ");
-		printk("}\n");
-
-		/* Should we dump sector info here too ?? */
-	}
+	ata_dump_status(qc->ap->id, drv_stat, err);
 
 	/* Look for err */
 	while (sense_table[i][0] != 0xFF) {

