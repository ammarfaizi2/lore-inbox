Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263205AbUBDPnv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 10:43:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263330AbUBDPnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 10:43:50 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:40581 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263205AbUBDPna
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 10:43:30 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org
Subject: [PATCH] [IDE] fix duplication of DMA {black,white}list in icside.c
Date: Wed, 4 Feb 2004 16:47:39 +0100
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402041647.39292.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Always compile ide-dma.c if CONFIG_BLK_DEV_IDEDMA=y, mark PCI specific code
with CONFIG_BLK_DEV_IDEDMA_PCI for now (it should migrate to ide_pcidma.c
over a time).  This fixes a small bug - in_drive_list() from icside.c used
!strstr() instead of strstr() so it was missing two entries from a blacklist.

 linux-2.6.2-root/drivers/ide/Makefile     |    2 
 linux-2.6.2-root/drivers/ide/arm/icside.c |   73 ------------------------------
 linux-2.6.2-root/drivers/ide/ide-dma.c    |   19 ++++---
 linux-2.6.2-root/include/linux/ide.h      |    8 ++-
 4 files changed, 21 insertions(+), 81 deletions(-)

diff -puN drivers/ide/arm/icside.c~ide_dma_drive_lists drivers/ide/arm/icside.c
--- linux-2.6.2/drivers/ide/arm/icside.c~ide_dma_drive_lists	2004-02-04 16:27:52.765871888 +0100
+++ linux-2.6.2-root/drivers/ide/arm/icside.c	2004-02-04 16:27:52.783869152 +0100
@@ -330,72 +330,6 @@ static int icside_set_speed(ide_drive_t 
 	return on;
 }
 
-/*
- * The following is a sick duplication from ide-dma.c ;(
- *
- * This should be defined in one place only.
- */
-struct drive_list_entry {
-	const char * id_model;
-	const char * id_firmware;
-};
-
-static const struct drive_list_entry drive_whitelist [] = {
-	{ "Micropolis 2112A",			"ALL"		},
-	{ "CONNER CTMA 4000",			"ALL"		},
-	{ "CONNER CTT8000-A",			"ALL"		},
-	{ "ST34342A",				"ALL"		},
-	{ NULL,					NULL		}
-};
-
-static struct drive_list_entry drive_blacklist [] = {
-	{ "WDC AC11000H",			"ALL"		},
-	{ "WDC AC22100H",			"ALL"		},
-	{ "WDC AC32500H",			"ALL"		},
-	{ "WDC AC33100H",			"ALL"		},
-	{ "WDC AC31600H",			"ALL"		},
-	{ "WDC AC32100H",			"24.09P07"	},
-	{ "WDC AC23200L",			"21.10N21"	},
-	{ "Compaq CRD-8241B",			"ALL"		},
-	{ "CRD-8400B",				"ALL"		},
-	{ "CRD-8480B",				"ALL"		},
-	{ "CRD-8480C",				"ALL"		},
-	{ "CRD-8482B",				"ALL"		},
- 	{ "CRD-84",				"ALL"		},
-	{ "SanDisk SDP3B",			"ALL"		},
-	{ "SanDisk SDP3B-64",			"ALL"		},
-	{ "SANYO CD-ROM CRD",			"ALL"		},
-	{ "HITACHI CDR-8",			"ALL"		},
-	{ "HITACHI CDR-8335",			"ALL"		},
-	{ "HITACHI CDR-8435",			"ALL"		},
-	{ "Toshiba CD-ROM XM-6202B",		"ALL"		},
-	{ "CD-532E-A",				"ALL"		},
-	{ "E-IDE CD-ROM CR-840",		"ALL"		},
-	{ "CD-ROM Drive/F5A",			"ALL"		},
-	{ "RICOH CD-R/RW MP7083A",		"ALL"		},
-	{ "WPI CDD-820",			"ALL"		},
-	{ "SAMSUNG CD-ROM SC-148C",		"ALL"		},
-	{ "SAMSUNG CD-ROM SC-148F",		"ALL"		},
-	{ "SAMSUNG CD-ROM SC",			"ALL"		},
-	{ "SanDisk SDP3B-64",			"ALL"		},
-	{ "SAMSUNG CD-ROM SN-124",		"ALL"		},
-	{ "PLEXTOR CD-R PX-W8432T",		"ALL"		},
-	{ "ATAPI CD-ROM DRIVE 40X MAXIMUM",	"ALL"		},
-	{ "_NEC DV5800A",			"ALL"		},
-	{ NULL,					NULL		}
-};
-
-static int
-in_drive_list(struct hd_driveid *id, const struct drive_list_entry *drive_table)
-{
-	for ( ; drive_table->id_model ; drive_table++)
-		if ((!strcmp(drive_table->id_model, id->model)) &&
-		    ((!strstr(drive_table->id_firmware, id->fw_rev)) ||
-		     (!strcmp(drive_table->id_firmware, "ALL"))))
-			return 1;
-	return 0;
-}
-
 static int icside_dma_host_off(ide_drive_t *drive)
 {
 	return 0;
@@ -437,11 +371,8 @@ static int icside_dma_check(ide_drive_t 
 	/*
 	 * Consult the list of known "bad" drives
 	 */
-	if (in_drive_list(id, drive_blacklist)) {
-		printk("%s: Disabling DMA for %s (blacklisted)\n",
-			drive->name, id->model);
+	if (__ide_dma_bad_drive(drive))
 		goto out;
-	}
 
 	/*
 	 * Enable DMA on any drive that has multiword DMA
@@ -454,7 +385,7 @@ static int icside_dma_check(ide_drive_t 
 	/*
 	 * Consult the list of known "good" drives
 	 */
-	if (in_drive_list(id, drive_whitelist)) {
+	if (__ide_dma_good_drive(drive)) {
 		if (id->eide_dma_time > 150)
 			goto out;
 		xfer_mode = XFER_MW_DMA_1;
diff -puN drivers/ide/ide-dma.c~ide_dma_drive_lists drivers/ide/ide-dma.c
--- linux-2.6.2/drivers/ide/ide-dma.c~ide_dma_drive_lists	2004-02-04 16:27:52.771870976 +0100
+++ linux-2.6.2-root/drivers/ide/ide-dma.c	2004-02-04 16:27:52.785868848 +0100
@@ -90,11 +90,11 @@
 #include <asm/irq.h>
 
 struct drive_list_entry {
-	char * id_model;
-	char * id_firmware;
+	const char *id_model;
+	const char *id_firmware;
 };
 
-struct drive_list_entry drive_whitelist [] = {
+static const struct drive_list_entry drive_whitelist [] = {
 
 	{ "Micropolis 2112A"	,       "ALL"		},
 	{ "CONNER CTMA 4000"	,       "ALL"		},
@@ -103,7 +103,7 @@ struct drive_list_entry drive_whitelist 
 	{ 0			,	0		}
 };
 
-struct drive_list_entry drive_blacklist [] = {
+static const struct drive_list_entry drive_blacklist [] = {
 
 	{ "WDC AC11000H"	,	"ALL"		},
 	{ "WDC AC22100H"	,	"ALL"		},
@@ -151,7 +151,7 @@ struct drive_list_entry drive_blacklist 
  *	Returns 1 if the drive is found in the table.
  */
 
-static int in_drive_list(struct hd_driveid *id, struct drive_list_entry * drive_table)
+static int in_drive_list(struct hd_driveid *id, const struct drive_list_entry *drive_table)
 {
 	for ( ; drive_table->id_model ; drive_table++)
 		if ((!strcmp(drive_table->id_model, id->model)) &&
@@ -161,6 +161,7 @@ static int in_drive_list(struct hd_drive
 	return 0;
 }
 
+#ifdef CONFIG_BLK_DEV_IDEDMA_PCI
 /**
  *	ide_dma_intr	-	IDE DMA interrupt handler
  *	@drive: the drive the interrupt is for
@@ -764,6 +765,7 @@ int __ide_dma_test_irq (ide_drive_t *dri
 }
 
 EXPORT_SYMBOL(__ide_dma_test_irq);
+#endif /* CONFIG_BLK_DEV_IDEDMA_PCI */
 
 int __ide_dma_bad_drive (ide_drive_t *drive)
 {
@@ -771,8 +773,9 @@ int __ide_dma_bad_drive (ide_drive_t *dr
 
 	int blacklist = in_drive_list(id, drive_blacklist);
 	if (blacklist) {
-		printk(KERN_WARNING "%s: Disabling (U)DMA for %s\n", drive->name, id->model);
-		return(blacklist);
+		printk(KERN_WARNING "%s: Disabling (U)DMA for %s (blacklisted)\n",
+				    drive->name, id->model);
+		return blacklist;
 	}
 	return 0;
 }
@@ -787,6 +790,7 @@ int __ide_dma_good_drive (ide_drive_t *d
 
 EXPORT_SYMBOL(__ide_dma_good_drive);
 
+#ifdef CONFIG_BLK_DEV_IDEDMA_PCI
 /*
  * Used for HOST FIFO counters for VDMA
  * PIO over DMA, effective ATA-Bridge operator.
@@ -1139,3 +1143,4 @@ void ide_setup_dma (ide_hwif_t *hwif, un
 }
 
 EXPORT_SYMBOL_GPL(ide_setup_dma);
+#endif /* CONFIG_BLK_DEV_IDEDMA_PCI */
diff -puN drivers/ide/Makefile~ide_dma_drive_lists drivers/ide/Makefile
--- linux-2.6.2/drivers/ide/Makefile~ide_dma_drive_lists	2004-02-04 16:27:52.775870368 +0100
+++ linux-2.6.2-root/drivers/ide/Makefile	2004-02-04 16:27:52.786868696 +0100
@@ -20,7 +20,7 @@ ide-core-$(CONFIG_BLK_DEV_CMD640)	+= pci
 
 # Core IDE code - must come before legacy
 ide-core-$(CONFIG_BLK_DEV_IDEPCI)	+= setup-pci.o
-ide-core-$(CONFIG_BLK_DEV_IDEDMA_PCI)	+= ide-dma.o
+ide-core-$(CONFIG_BLK_DEV_IDEDMA)	+= ide-dma.o
 ide-core-$(CONFIG_BLK_DEV_IDE_TCQ)	+= ide-tcq.o
 ide-core-$(CONFIG_PROC_FS)		+= ide-proc.o
 ide-core-$(CONFIG_BLK_DEV_IDEPNP)	+= ide-pnp.o
diff -puN include/linux/ide.h~ide_dma_drive_lists include/linux/ide.h
--- linux-2.6.2/include/linux/ide.h~ide_dma_drive_lists	2004-02-04 16:27:52.778869912 +0100
+++ linux-2.6.2-root/include/linux/ide.h	2004-02-04 16:27:52.787868544 +0100
@@ -1626,6 +1626,10 @@ extern void ide_setup_pci_devices(struct
 #define BAD_DMA_DRIVE		0
 #define GOOD_DMA_DRIVE		1
 
+#ifdef CONFIG_BLK_DEV_IDEDMA
+int __ide_dma_bad_drive(ide_drive_t *);
+int __ide_dma_good_drive(ide_drive_t *);
+
 #ifdef CONFIG_BLK_DEV_IDEDMA_PCI
 extern int ide_build_sglist(ide_drive_t *, struct request *);
 extern int ide_raw_build_sglist(ide_drive_t *, struct request *);
@@ -1647,8 +1651,6 @@ extern int __ide_dma_write(ide_drive_t *
 extern int __ide_dma_begin(ide_drive_t *);
 extern int __ide_dma_end(ide_drive_t *);
 extern int __ide_dma_test_irq(ide_drive_t *);
-extern int __ide_dma_bad_drive(ide_drive_t *);
-extern int __ide_dma_good_drive(ide_drive_t *);
 extern int __ide_dma_count(ide_drive_t *);
 extern int __ide_dma_verbose(ide_drive_t *);
 extern int __ide_dma_retune(ide_drive_t *);
@@ -1677,6 +1679,8 @@ static inline int __ide_dma_queued_off(i
 static inline void ide_release_dma(ide_hwif_t *drive) {;}
 #endif
 
+#endif /* CONFIG_BLK_DEV_IDEDMA */
+
 extern int ide_hwif_request_regions(ide_hwif_t *hwif);
 extern void ide_hwif_release_regions(ide_hwif_t* hwif);
 extern void ide_unregister (unsigned int index);

_

