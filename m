Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261778AbUCBVCz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 16:02:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261782AbUCBVCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 16:02:55 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:28311 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261778AbUCBVCc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 16:02:32 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org
Subject: [PATCH] update for siimage driver
Date: Tue, 2 Mar 2004 22:08:48 +0100
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403022208.48082.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[IDE] update for siimage driver

- fix brown paper bug introduced by my last patch,
  drive information was checked before drive was probed
  so Seagate errata fix was never applied
  (noticed by Bob Johnson <livewire@gentoo.org>)
- limit rqsize only on affected controller/drive combo
  (fix from sata_sil.c)
- limit mode to UDMA5 only on Maxtor 4D060H3
  (fix from sata_sil.c)

 linux-2.6.4-rc1-root/drivers/ide/ide-probe.c   |    8 ++-
 linux-2.6.4-rc1-root/drivers/ide/pci/siimage.c |   53 ++++++++++++++-----------
 linux-2.6.4-rc1-root/include/linux/ide.h       |    1 
 3 files changed, 38 insertions(+), 24 deletions(-)

diff -puN drivers/ide/pci/siimage.c~siimage_update drivers/ide/pci/siimage.c
--- linux-2.6.4-rc1/drivers/ide/pci/siimage.c~siimage_update	2004-03-02 22:03:41.683760472 +0100
+++ linux-2.6.4-rc1-root/drivers/ide/pci/siimage.c	2004-03-02 22:03:41.699758040 +0100
@@ -203,13 +203,12 @@ static byte siimage_ratemask (ide_drive_
 	else
 		pci_read_config_byte(hwif->pci_dev, 0x8A, &scsc);
 
-	if(is_sata(hwif))
-	{
-		if(strstr(drive->id->model, "Maxtor"))
+	if (is_sata(hwif)) {
+		if (strstr(drive->id->model, "Maxtor 4D060H3"))
 			return 3;
 		return 4;
 	}
-	
+
 	if ((scsc & 0x30) == 0x10)	/* 133 */
 		mode = 4;
 	else if ((scsc & 0x30) == 0x20)	/* 2xPCI */
@@ -1046,25 +1045,34 @@ static void __init init_mmio_iops_siimag
 	hwif->mmio			= 2;
 }
 
-static int is_dev_seagate_sata(ide_drive_t *drive)
+/* TODO firmware versions should be added - eric */
+static const char * sil_blacklist [] = {
+	"ST320012AS",
+	"ST330013AS",
+	"ST340017AS",
+	"ST360015AS",
+	"ST380023AS",
+	"ST3120023AS",
+	"ST340014ASL",
+	"ST360014ASL",
+	"ST380011ASL",
+	"ST3120022ASL",
+	"ST3160021ASL",
+};
+
+static unsigned int siimage_sata_max_rqsize(ide_drive_t *drive)
 {
 	const char *s = &drive->id->model[0];
-	unsigned len;
+	unsigned int n;
 
-	if (!drive->present)
-		return 0;
-
-	len = strnlen(s, sizeof(drive->id->model));
-
-	if ((len > 4) && (!memcmp(s, "ST", 2))) {
-		if ((!memcmp(s + len - 2, "AS", 2)) ||
-		    (!memcmp(s + len - 3, "ASL", 3))) {
-			printk(KERN_INFO "%s: applying pessimistic Seagate "
-					 "errata fix\n", drive->name);
-			return 1;
+	for (n = 0; n < ARRAY_SIZE(sil_blacklist); n++)
+		if (!memcmp(sil_blacklist[n], s, strlen(sil_blacklist[n]))) {
+			printk(KERN_INFO "%s: applying Seagate errata fix\n",
+					 drive->name);
+			return 15;
 		}
-	}
-	return 0;
+
+	return 128;
 }
 
 /**
@@ -1087,9 +1095,10 @@ static void __init init_iops_siimage (id
 	
 	hwif->hwif_data = 0;
 
-	hwif->rqsize = 128;
-	if (is_sata(hwif) && is_dev_seagate_sata(&hwif->drives[0]))
-		hwif->rqsize = 15;
+	if (is_sata(hwif) && (class_rev <= 0x01))
+		hwif->max_rqsize = siimage_sata_max_rqsize;
+	else
+		hwif->rqsize = 128;
 
 	if (pci_get_drvdata(dev) == NULL)
 		return;
diff -puN drivers/ide/ide-probe.c~siimage_update drivers/ide/ide-probe.c
--- linux-2.6.4-rc1/drivers/ide/ide-probe.c~siimage_update	2004-03-02 22:03:41.686760016 +0100
+++ linux-2.6.4-rc1-root/drivers/ide/ide-probe.c	2004-03-02 22:03:41.701757736 +0100
@@ -922,8 +922,12 @@ static int ide_init_queue(ide_drive_t *d
 	q->queuedata = HWGROUP(drive);
 	blk_queue_segment_boundary(q, 0xffff);
 
-	if (!hwif->rqsize)
-		hwif->rqsize = hwif->no_lba48 ? 256 : 65536;
+	if (!hwif->rqsize) {
+		if (hwif->max_rqsize)
+			hwif->rqsize = hwif->max_rqsize(drive);
+		else
+			hwif->rqsize = hwif->no_lba48 ? 256 : 65536;
+	}
 	if (hwif->rqsize < max_sectors)
 		max_sectors = hwif->rqsize;
 	blk_queue_max_sectors(q, max_sectors);
diff -puN include/linux/ide.h~siimage_update include/linux/ide.h
--- linux-2.6.4-rc1/include/linux/ide.h~siimage_update	2004-03-02 22:03:41.696758496 +0100
+++ linux-2.6.4-rc1-root/include/linux/ide.h	2004-03-02 22:03:41.702757584 +0100
@@ -991,6 +991,7 @@ typedef struct hwif_s {
 	unsigned dma;
 
 	void (*led_act)(void *data, int rw);
+	unsigned int (*max_rqsize)(ide_drive_t *);
 } ide_hwif_t;
 
 /*

_

