Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291281AbSBSLiZ>; Tue, 19 Feb 2002 06:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291284AbSBSLiQ>; Tue, 19 Feb 2002 06:38:16 -0500
Received: from [195.63.194.11] ([195.63.194.11]:9999 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S291281AbSBSLiK>;
	Tue, 19 Feb 2002 06:38:10 -0500
Message-ID: <3C723904.4060903@evision-ventures.com>
Date: Tue, 19 Feb 2002 12:37:40 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.5-pre1 IDE cleanup
In-Reply-To: <Pine.LNX.4.33.0202131434350.21395-100000@home.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------080904080803000903020600"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080904080803000903020600
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The attached patch does:

1. Kill two exports which mankind will never know what they where good for

2. Kill duplicated comments.

3. Kill declarations of never defined functions

4. Some other minor tidups here and there.

It is created on top of the other patches I already send to you however 
it should
apply independantly.

--------------080904080803000903020600
Content-Type: text/plain;
 name="ide-clean-8.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-clean-8.diff"

diff -ur linux-2.5.4/drivers/ide/ide-probe.c linux/drivers/ide/ide-probe.c
--- linux-2.5.4/drivers/ide/ide-probe.c	Fri Feb 15 04:36:43 2002
+++ linux/drivers/ide/ide-probe.c	Mon Feb 18 01:46:29 2002
@@ -406,22 +406,19 @@
 }
 
 /*
- * probe_for_drive() tests for existence of a given drive using do_probe().
- *
- * Returns:	0  no device was found
- *		1  device was found (note: drive->present might still be 0)
+ * Tests for existence of a given drive using do_probe().
  */
-static inline byte probe_for_drive (ide_drive_t *drive)
+static inline void probe_for_drive (ide_drive_t *drive)
 {
 	if (drive->noprobe)			/* skip probing? */
-		return drive->present;
+		return;
 	if (do_probe(drive, WIN_IDENTIFY) >= 2) { /* if !(success||timed-out) */
-		(void) do_probe(drive, WIN_PIDENTIFY); /* look for ATAPI device */
+		do_probe(drive, WIN_PIDENTIFY); /* look for ATAPI device */
 	}
 	if (drive->id && strstr(drive->id->model, "E X A B Y T E N E S T"))
 		enable_nest(drive);
 	if (!drive->present)
-		return 0;			/* drive not found */
+		return;			/* drive not found */
 	if (drive->id == NULL) {		/* identification failed? */
 		if (drive->media == ide_disk) {
 			printk ("%s: non-IDE drive, CHS=%d/%d/%d\n",
@@ -432,7 +429,6 @@
 			drive->present = 0;	/* nuke it */
 		}
 	}
-	return 1;	/* drive was found */
 }
 
 /*
@@ -548,7 +544,7 @@
 	 */
 	for (unit = 0; unit < MAX_DRIVES; ++unit) {
 		ide_drive_t *drive = &hwif->drives[unit];
-		(void) probe_for_drive (drive);
+		probe_for_drive (drive);
 		if (drive->present && !hwif->present) {
 			hwif->present = 1;
 			if (hwif->chipset != ide_4drives || !hwif->mate->present) {
@@ -931,19 +927,6 @@
 	return hwif->present;
 }
 
-void export_ide_init_queue (ide_drive_t *drive)
-{
-	ide_init_queue(drive);
-}
-
-byte export_probe_for_drive (ide_drive_t *drive)
-{
-	return probe_for_drive(drive);
-}
-
-EXPORT_SYMBOL(export_ide_init_queue);
-EXPORT_SYMBOL(export_probe_for_drive);
-
 int ideprobe_init (void);
 static ide_module_t ideprobe_module = {
 	IDE_PROBE_MODULE,
diff -ur linux-2.5.4/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.4/drivers/ide/ide.c	Fri Feb 15 06:39:29 2002
+++ linux/drivers/ide/ide.c	Mon Feb 18 01:48:31 2002
@@ -1965,11 +1965,10 @@
 #endif
 
 /*
- * Note that we only release the standard ports,
- * and do not even try to handle any extra ports
- * allocated for weird IDE interface chipsets.
+ * Note that we only release the standard ports, and do not even try to handle
+ * any extra ports allocated for weird IDE interface chipsets.
  */
-void hwif_unregister (ide_hwif_t *hwif)
+static void hwif_unregister(ide_hwif_t *hwif)
 {
 	if (hwif->straight8) {
 		ide_release_region(hwif->io_ports[IDE_DATA_OFFSET], 8);
@@ -2063,11 +2062,6 @@
 	if (irq_count == 1)
 		free_irq(hwif->irq, hwgroup);
 
-	/*
-	 * Note that we only release the standard ports,
-	 * and do not even try to handle any extra ports
-	 * allocated for weird IDE interface chipsets.
-	 */
 	hwif_unregister(hwif);
 
 	/*
@@ -3718,7 +3712,6 @@
 EXPORT_SYMBOL(ide_register);
 EXPORT_SYMBOL(ide_unregister);
 EXPORT_SYMBOL(ide_setup_ports);
-EXPORT_SYMBOL(hwif_unregister);
 EXPORT_SYMBOL(get_info_ptr);
 EXPORT_SYMBOL(current_capacity);
 
diff -ur linux-2.5.4/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.5.4/include/linux/ide.h	Fri Feb 15 06:40:48 2002
+++ linux/include/linux/ide.h	Mon Feb 18 02:04:57 2002
@@ -1101,7 +1101,6 @@
 #  define OFF_BOARD		NEVER_BOARD
 #endif /* CONFIG_BLK_DEV_OFFBOARD */
 
-unsigned long ide_find_free_region (unsigned short size) __init;
 void ide_scan_pcibus (int scan_direction) __init;
 #endif
 #ifdef CONFIG_BLK_DEV_IDEDMA
@@ -1115,14 +1114,10 @@
 int ide_dmaproc (ide_dma_action_t func, ide_drive_t *drive);
 int ide_release_dma (ide_hwif_t *hwif);
 void ide_setup_dma (ide_hwif_t *hwif, unsigned long dmabase, unsigned int num_ports) __init;
-unsigned long ide_get_or_set_dma_base (ide_hwif_t *hwif, int extra, const char *name) __init;
+/* FIXME spilt this up into a get and set function */
+extern unsigned long ide_get_or_set_dma_base (ide_hwif_t *hwif, int extra, const char *name) __init;
 #endif
 
-void hwif_unregister (ide_hwif_t *hwif);
-
-void export_ide_init_queue (ide_drive_t *drive);
-byte export_probe_for_drive (ide_drive_t *drive);
-
 extern spinlock_t ide_lock;
 
 extern int drive_is_ready(ide_drive_t *drive);

--------------080904080803000903020600--

