Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267919AbTBRRvZ>; Tue, 18 Feb 2003 12:51:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267921AbTBRRvZ>; Tue, 18 Feb 2003 12:51:25 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:18185 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267919AbTBRRvW>; Tue, 18 Feb 2003 12:51:22 -0500
Subject: PATCH: remove old style and unused bad drive list
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 18 Feb 2003 18:01:32 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E18lC3h-00067E-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/drivers/ide/ide-dma.c linux-2.5.61-ac2/drivers/ide/ide-dma.c
--- linux-2.5.61/drivers/ide/ide-dma.c	2003-02-10 18:38:38.000000000 +0000
+++ linux-2.5.61-ac2/drivers/ide/ide-dma.c	2003-02-18 18:06:17.000000000 +0000
@@ -90,9 +90,6 @@
 #include <asm/io.h>
 #include <asm/irq.h>
 
-#define CONFIG_IDEDMA_NEW_DRIVE_LISTINGS
-#ifdef CONFIG_IDEDMA_NEW_DRIVE_LISTINGS
-
 struct drive_list_entry {
 	char * id_model;
 	char * id_firmware;
@@ -165,40 +162,6 @@
 	return 0;
 }
 
-#else /* !CONFIG_IDEDMA_NEW_DRIVE_LISTINGS */
-
-/*
- * good_dma_drives() lists the model names (from "hdparm -i")
- * of drives which do not support mode2 DMA but which are
- * known to work fine with this interface under Linux.
- */
-const char *good_dma_drives[] = {"Micropolis 2112A",
-				 "CONNER CTMA 4000",
-				 "CONNER CTT8000-A",
-				 "ST34342A",	/* for Sun Ultra */
-				 NULL};
-
-/*
- * bad_dma_drives() lists the model names (from "hdparm -i")
- * of drives which supposedly support (U)DMA but which are
- * known to corrupt data with this interface under Linux.
- *
- * This is an empirical list. Its generated from bug reports. That means
- * while it reflects actual problem distributions it doesn't answer whether
- * the drive or the controller, or cabling, or software, or some combination
- * thereof is the fault. If you don't happen to agree with the kernel's 
- * opinion of your drive - use hdparm to turn DMA on.
- */
-const char *bad_dma_drives[] = {"WDC AC11000H",
-				"WDC AC22100H",
-				"WDC AC32100H",
-				"WDC AC32500H",
-				"WDC AC33100H",
-				"WDC AC31600H",
- 				NULL};
-
-#endif /* CONFIG_IDEDMA_NEW_DRIVE_LISTINGS */
-
 /**
  *	ide_dma_intr	-	IDE DMA interrupt handler
  *	@drive: the drive the interrupt is for
@@ -282,6 +245,7 @@
 		hwif->sg_dma_direction = PCI_DMA_TODEVICE;
 	else
 		hwif->sg_dma_direction = PCI_DMA_FROMDEVICE;
+
 #if 1
 	if (sector_count > 256)
 		BUG();
@@ -832,24 +794,11 @@
 {
 	struct hd_driveid *id = drive->id;
 
-#ifdef CONFIG_IDEDMA_NEW_DRIVE_LISTINGS
 	int blacklist = in_drive_list(id, drive_blacklist);
 	if (blacklist) {
-		printk("%s: Disabling (U)DMA for %s\n", drive->name, id->model);
+		printk(KERN_WARNING "%s: Disabling (U)DMA for %s\n", drive->name, id->model);
 		return(blacklist);
 	}
-#else /* !CONFIG_IDEDMA_NEW_DRIVE_LISTINGS */
-	const char **list;
-	/* Consult the list of known "bad" drives */
-	list = bad_dma_drives;
-	while (*list) {
-		if (!strcmp(*list++,id->model)) {
-			printk("%s: Disabling (U)DMA for %s\n",
-				drive->name, id->model);
-			return 1;
-		}
-	}
-#endif /* CONFIG_IDEDMA_NEW_DRIVE_LISTINGS */
 	return 0;
 }
 
@@ -858,19 +807,7 @@
 int __ide_dma_good_drive (ide_drive_t *drive)
 {
 	struct hd_driveid *id = drive->id;
-
-#ifdef CONFIG_IDEDMA_NEW_DRIVE_LISTINGS
 	return in_drive_list(id, drive_whitelist);
-#else /* !CONFIG_IDEDMA_NEW_DRIVE_LISTINGS */
-	const char **list;
-	/* Consult the list of known "good" drives */
-	list = good_dma_drives;
-	while (*list) {
-		if (!strcmp(*list++,id->model))
-			return 1;
-	}
-#endif /* CONFIG_IDEDMA_NEW_DRIVE_LISTINGS */
-	return 0;
 }
 
 EXPORT_SYMBOL(__ide_dma_good_drive);
