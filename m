Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293521AbSCGGsI>; Thu, 7 Mar 2002 01:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293528AbSCGGsC>; Thu, 7 Mar 2002 01:48:02 -0500
Received: from maillog.promise.com.tw ([210.244.60.166]:42739 "EHLO
	maillog.promise.com.tw") by vger.kernel.org with ESMTP
	id <S293521AbSCGGrj>; Thu, 7 Mar 2002 01:47:39 -0500
Message-ID: <00f201c1c5a3$d27a8330$59cca8c0@hank>
From: "Hank Yang" <hanky@promise.com.tw>
To: <linux-kernel@vger.kernel.org>, <torvalds@transmeta.com>
Cc: "Crimson Hung" <crimsonh@promise.com.tw>,
        "Jenny Liang" <jennyl@promise.com.tw>,
        "Linus Chen" <linusc@promise.com.tw>
Subject: [PATCH] Submitting PROMISE IDE Controllers Driver Patch
Date: Thu, 7 Mar 2002 14:46:30 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear linux-kernel group and Linus Torvalds,

    We make some changes for support our product. The ATA-100/133
Controllers.
Hope you can reference following describe and patch code. If there has
anything
wrong, please feel free to tell us. Thank you.

Best Regards
Hank Yang
Promise Technology, Inc.
Tel:+886-3-5782395 ext 7357

Kernel Version: linux kernel 2.4.18
Vendor: PROMISE Technology, Inc.
Author: PROMISE Technologu, Inc.
Describe: Support PDC20268, PDC20269, PDC20275(ATA-100/133 Controllers)
                Support Ultra-DMA Mode 6. Maxtor 48-bit LBA spec.
Changes:
/usr/src/linux/drivers/ide/ide-disk.c
    ide_startstop_t do_rw_disk()
        * if drives support LBA48 and UDMA then prepare 48bit data for UDMA.
        * if drives support LBA48 then issue 48bit command for PIO.

    init_idedisk_capacity()
        * if drives support LBA48 then read current maximal capacity.

/usr/src/linux/drivers/ide/ide-dma.c
    report_drive_dmaing()
    config_drive_for_dma()
        * fix UltraDMA mode 6 selectable
    ide_dmaproc()
        * if drives support LBA48 and DMA then issue 48bit command  for DMA
        * if PDC20262/65/67 through ATAPI UDMA

/usr/src/linux/drivers/ide/ide-features.c
    eighty_ninty_three()
        * fix some hard drivers ATA-66 support response.

/usr/src/linux/drivers/ide/ide.c
    ide_dump_status()
        * return error 48bit LBA address if running 48bit LBA

/usr/src/linux/drivers/ide/ide-pci.c
        * add PDC20268/69/75 controllers structure

/usr/src/linux/drivers/ide/pdc202xx.c
    pdc202xx_info()
        * fix proc information report
    pdc202xx_tune_chipset()
        * fix set-speed from PDC20262/65/67 and PDC20268/69/75
           because the rule is different.
    config_chipset_for_dma()
        * support UDMA 6 selectable
        * check is 80pin cable, if no will down to UDMA 2.
        * fix some control rule for PDC20262/65/67 and PDC20268/69/75
    ata66_pdc202xx()
        * fix judge 80pin cable
    pdc202xx_reset()
    pci_init_pdc202xx()
        * add PDC20268/69/75 controllers routine.

/usr/src/linux/include/linux/pci_ids.h
        * add PROMISE IDE controllers device IDs


Patch code:

diff -urN linux-2.4.18.org/drivers/ide/ide-disk.c
linux/drivers/ide/ide-disk.c
--- linux-2.4.18.org/drivers/ide/ide-disk.c Sat Dec 22 01:41:54 2001
+++ linux/drivers/ide/ide-disk.c Wed Feb 27 23:54:46 2002
@@ -28,6 +28,11 @@
  *   added UDMA 3/4 reporting
  * Version 1.10  request queue changes, Ultra DMA 100
  */
+/*
+ * Support UltraDMA Mode 6 and 48 bit LBA Mode.
+ * Powered by PROMISE Technology, Inc. Portions Copyright (C)2001.
+ */
+#define PCI_VENDOR_ID_PROMISE 0x105a

 #define IDEDISK_VERSION "1.10"

@@ -371,10 +376,22 @@
   OUT_BYTE(drive->ctl,IDE_CONTROL_REG);
  OUT_BYTE(0x00, IDE_FEATURE_REG);
  OUT_BYTE(rq->nr_sectors,IDE_NSECTOR_REG);
+ if ((drive->id->command_set_2 & 0x0400) &&
HWIF(drive)->pci_devid.vid==PCI_VENDOR_ID_PROMISE) {
+  /* 48 bits data previous */
+  OUT_BYTE(rq->nr_sectors>>8, IDE_NSECTOR_REG);
+  OUT_BYTE(block>>24, IDE_SECTOR_REG);
+  OUT_BYTE(0x00, IDE_LCYL_REG); //block only 32 bits
+  OUT_BYTE(0x00, IDE_HCYL_REG);
+  /* 48 bits data current */
+  OUT_BYTE(rq->nr_sectors, IDE_NSECTOR_REG);
+  OUT_BYTE(block, IDE_SECTOR_REG);
+  OUT_BYTE(block>>8, IDE_LCYL_REG);
+  OUT_BYTE(block>>16, IDE_HCYL_REG);
+  OUT_BYTE(drive->select.all,IDE_SELECT_REG);
 #ifdef CONFIG_BLK_DEV_PDC4030
- if (drive->select.b.lba || IS_PDC4030_DRIVE) {
-#else /* !CONFIG_BLK_DEV_PDC4030 */
- if (drive->select.b.lba) {
+ } else if (drive->select.b.lba || IS_PDC4030_DRIVE) {
+#else /* !CONFIG_BLK_DEV_PDC4030 */
+ } else if (drive->select.b.lba) {
 #endif /* CONFIG_BLK_DEV_PDC4030 */
 #ifdef DEBUG
   printk("%s: %sing: LBAsect=%ld, sectors=%ld, buffer=0x%08lx\n",
@@ -413,7 +430,10 @@
    return ide_started;
 #endif /* CONFIG_BLK_DEV_IDEDMA */
   ide_set_handler(drive, &read_intr, WAIT_CMD, NULL);
-  OUT_BYTE(drive->mult_count ? WIN_MULTREAD : WIN_READ, IDE_COMMAND_REG);
+  if ((drive->id->command_set_2 & 0x0400) &&
HWIF(drive)->pci_devid.vid==PCI_VENDOR_ID_PROMISE)
+   OUT_BYTE(drive->mult_count ? MULTI_READ_EXT : READ_EXT,
IDE_COMMAND_REG);
+  else
+   OUT_BYTE(drive->mult_count ? WIN_MULTREAD : WIN_READ, IDE_COMMAND_REG);
   return ide_started;
  }
  if (rq->cmd == WRITE) {
@@ -422,7 +442,11 @@
   if (drive->using_dma && !(HWIF(drive)->dmaproc(ide_dma_write, drive)))
    return ide_started;
 #endif /* CONFIG_BLK_DEV_IDEDMA */
-  OUT_BYTE(drive->mult_count ? WIN_MULTWRITE : WIN_WRITE, IDE_COMMAND_REG);
+  /* out 48 bits R/W command here */
+  if ((drive->id->command_set_2 & 0x0400) &&
HWIF(drive)->pci_devid.vid==PCI_VENDOR_ID_PROMISE)
+   OUT_BYTE(drive->mult_count ? MULTI_WRITE_EXT : WRITE_EXT,
IDE_COMMAND_REG);
+  else
+   OUT_BYTE(drive->mult_count ? WIN_MULTWRITE : WIN_WRITE,
IDE_COMMAND_REG);
   if (ide_wait_stat(&startstop, drive, DATA_READY, drive->bad_wstat,
WAIT_DRQ)) {
    printk(KERN_ERR "%s: no DRQ after issuing %s\n", drive->name,
     drive->mult_count ? "MULTWRITE" : "WRITE");
@@ -481,7 +505,7 @@
 static void idedisk_release (struct inode *inode, struct file *filp,
ide_drive_t *drive)
 {
  if (drive->removable && !drive->usage) {
-  invalidate_bdev(inode->i_bdev, 0);
+  invalidate_buffers(inode->i_rdev);
   if (drive->doorlocking && ide_wait_cmd(drive, WIN_DOORUNLOCK, 0, 0, 0,
NULL))
    drive->doorlocking = 0;
  }
@@ -508,12 +532,22 @@
 {
  struct hd_driveid *id = drive->id;
  unsigned long capacity = drive->cyl * drive->head * drive->sect;
+ int lba48=drive->id->command_set_2 & 0x0400;
+ unsigned long temp=0;

  drive->select.b.lba = 0;

  /* Determine capacity, and use LBA if the drive properly supports it */
  if ((id->capability & 2) && lba_capacity_is_ok(id)) {
   capacity = id->lba_capacity;
+  /* get 48 bits disk capacity if support */
+  if (lba48 && HWIF(drive)->pci_devid.vid==PCI_VENDOR_ID_PROMISE)
+  {
+   temp=id->words94_125[7];
+   temp<<=16;
+   temp|=id->words94_125[6];
+   capacity=temp;
+  }
   drive->cyl = capacity / (drive->head * drive->sect);
   drive->select.b.lba = 1;
  }
@@ -769,7 +803,7 @@

  /* Give size in megabytes (MB), not mebibytes (MiB). */
  /* We compute the exact rounded value, avoiding overflow. */
- printk (" (%ld MB)", (capacity - capacity/625 + 974)/1950);
+ printk (" (%ld GB)", ((capacity - capacity/625 + 974)/1950)/1024);

  /* Only print cache size when it was specified */
  if (id->buf_size)
diff -urN linux-2.4.18.org/drivers/ide/ide-dma.c linux/drivers/ide/ide-dma.c
--- linux-2.4.18.org/drivers/ide/ide-dma.c Mon Sep 10 01:43:02 2001
+++ linux/drivers/ide/ide-dma.c Thu Feb 28 00:00:15 2002
@@ -75,6 +75,8 @@
  * ATA-66/100 and recovery functions, I forgot the rest......
  * SELECT_READ_WRITE(hwif,drive,func) for active tuning based on IO
direction.
  *
+ * Support UltraDMA Mode 6 and 48 bit LBA Mode.
+ * Powered by PROMISE Technology, Inc. Portions Copyright (C)2001.
  */

 #include <linux/config.h>
@@ -101,6 +103,8 @@
 #define DEFAULT_BMCRBA 0xcc00 /* VIA's default value */
 #define DEFAULT_BMALIBA 0xd400 /* ALI's default value */

+#define CONFIG_BLK_DEV_IDEDMA_TIMEOUT 1 // By Promise
+
 extern char *ide_dmafunc_verbose(ide_dma_action_t dmafunc);

 #ifdef CONFIG_IDEDMA_NEW_DRIVE_LISTINGS
@@ -429,18 +433,22 @@
  struct hd_driveid *id = drive->id;

  if ((id->field_valid & 4) && (eighty_ninty_three(drive)) &&
-     (id->dma_ultra & (id->dma_ultra >> 11) & 7)) {
-  if ((id->dma_ultra >> 13) & 1) {
-   printk(", UDMA(100)"); /* UDMA BIOS-enabled! */
+     (id->dma_ultra & (id->dma_ultra >> 14) & 3)) {
+      if ((id->dma_ultra >> 15) & 1) {
+   printk(", UDMA(166?)"); /* UDMA 7 BIOS-enabled! */
+      } else if ((id->dma_ultra >> 14) & 1) {
+   printk(", UDMA(133)"); /* UDMA 6 BIOS-enabled! */
+  } else if ((id->dma_ultra >> 13) & 1) {
+   printk(", UDMA(100)"); /* UDMA 5 BIOS-enabled! */
   } else if ((id->dma_ultra >> 12) & 1) {
-   printk(", UDMA(66)"); /* UDMA BIOS-enabled! */
+   printk(", UDMA(66)"); /* UDMA 4 BIOS-enabled! */
   } else {
    printk(", UDMA(44)"); /* UDMA BIOS-enabled! */
   }
  } else if ((id->field_valid & 4) &&
      (id->dma_ultra & (id->dma_ultra >> 8) & 7)) {
   if ((id->dma_ultra >> 10) & 1) {
-   printk(", UDMA(33)"); /* UDMA BIOS-enabled! */
+   printk(", UDMA(33)"); /* UDMA 2 BIOS-enabled! */
   } else if ((id->dma_ultra >> 9) & 1) {
    printk(", UDMA(25)"); /* UDMA BIOS-enabled! */
   } else {
@@ -463,7 +471,11 @@
   /* Consult the list of known "bad" drives */
   if (ide_dmaproc(ide_dma_bad_drive, drive))
    return hwif->dmaproc(ide_dma_off, drive);
-
+
+  /* Enable DMA on any drive that has UltraDMA (mode 6/7) enabled */
+  if ((id->field_valid & 4) && (eighty_ninty_three(drive)))
+   if ((id->dma_ultra & (id->dma_ultra >> 14) & 3))
+    return hwif->dmaproc(ide_dma_on, drive);
   /* Enable DMA on any drive that has UltraDMA (mode 3/4/5) enabled */
   if ((id->field_valid & 4) && (eighty_ninty_three(drive)))
    if ((id->dma_ultra & (id->dma_ultra >> 11) & 7))
@@ -550,13 +562,18 @@
  */
 int ide_dmaproc (ide_dma_action_t func, ide_drive_t *drive)
 {
-// ide_hwgroup_t *hwgroup  = HWGROUP(drive);
  ide_hwif_t *hwif  = HWIF(drive);
- unsigned long dma_base  = hwif->dma_base;
+ unsigned long dma_base = hwif->dma_base;
  byte unit   = (drive->select.b.unit & 0x01);
  unsigned int count, reading = 0;
  byte dma_stat;
-
+ int lba48   =drive->id->command_set_2 & 0x0400;
+ unsigned long high_16  = pci_resource_start(hwif->pci_dev, 4);
+ byte clock   =inb(high_16+0x11);
+ unsigned long atapi_port =high_16+ 0x20 + (hwif->channel ? 0x04 : 0x00);
+ struct request *rq   = HWGROUP(drive)->rq;
+ unsigned long word_count  = 0;
+
  switch (func) {
   case ide_dma_off:
    printk("%s: DMA disabled\n", drive->name);
@@ -586,18 +603,39 @@
 #else /* !CONFIG_BLK_DEV_IDEDMA_TIMEOUT */
    ide_set_handler(drive, &ide_dma_intr, WAIT_CMD, dma_timer_expiry); /*
issue cmd to drive */
 #endif /* CONFIG_BLK_DEV_IDEDMA_TIMEOUT */
-   OUT_BYTE(reading ? WIN_READDMA : WIN_WRITEDMA, IDE_COMMAND_REG);
+   if (lba48 && hwif->pci_devid.vid==PCI_VENDOR_ID_PROMISE)
+    OUT_BYTE(reading ? READ_DMA_EXT : WRITE_DMA_EXT, IDE_COMMAND_REG);
+   else
+    OUT_BYTE(reading ? WIN_READDMA : WIN_WRITEDMA, IDE_COMMAND_REG);
   case ide_dma_begin:
    /* Note that this is done *after* the cmd has
-    * been issued to the drive, as per the BM-IDE spec.
-    * The Promise Ultra33 doesn't work correctly when
-    * we do this part before issuing the drive cmd.
-    */
-   outb(inb(dma_base)|1, dma_base);  /* start DMA */
+    * been issued to the drive, as per the BM-IDE spec. */
+   /* Enable ATAPI UDMA port for 48bit data on PDC20267 */
+   if (lba48 && hwif->pci_devid.vid==PCI_VENDOR_ID_PROMISE &&
+      (hwif->pci_devid.did == PCI_DEVICE_ID_PROMISE_20267 ||
+       hwif->pci_devid.did == PCI_DEVICE_ID_PROMISE_20265 ||
+       hwif->pci_devid.did == PCI_DEVICE_ID_PROMISE_20262))
+   {
+    outb(clock|(hwif->channel ? 0x08:0x02), high_16 + 0x11);
+    word_count=(rq->nr_sectors << 8);
+    word_count=reading ? word_count | 0x05000000 : word_count | 0x06000000;
+    outl(word_count, atapi_port);
+   }
+   outb(inb(dma_base)|1, dma_base); /* start DMA */
    return 0;
   case ide_dma_end: /* returns 1 on error, 0 otherwise */
    drive->waiting_for_dma = 0;
    outb(inb(dma_base)&~1, dma_base); /* stop DMA */
+   /* Disable ATAPI UDMA port for 48bit data on PDC20267 */
+   if (lba48 && hwif->pci_devid.vid==PCI_VENDOR_ID_PROMISE &&
+       (hwif->pci_devid.did == PCI_DEVICE_ID_PROMISE_20267 ||
+        hwif->pci_devid.did == PCI_DEVICE_ID_PROMISE_20265 ||
+        hwif->pci_devid.did == PCI_DEVICE_ID_PROMISE_20262))
+   {
+        outl(0, atapi_port);
+    clock=inb(high_16+0x11);
+    outb(clock & ~(hwif->channel ? 0x08:0x02), high_16+0x11);
+   }
    dma_stat = inb(dma_base+2);  /* get DMA status */
    outb(dma_stat|6, dma_base+2); /* clear the INTR & ERROR bits */
    ide_destroy_dmatable(drive); /* purge DMA mappings */
diff -urN linux-2.4.18.org/drivers/ide/ide-features.c
linux/drivers/ide/ide-features.c
--- linux-2.4.18.org/drivers/ide/ide-features.c Sat Feb 10 03:40:02 2001
+++ linux/drivers/ide/ide-features.c Thu Feb 28 00:04:42 2002
@@ -261,6 +261,9 @@
  */
 byte eighty_ninty_three (ide_drive_t *drive)
 {
+ if (HWIF(drive)->pci_devid.vid==0x105a)
+     return(HWIF(drive)->udma_four);
+ /* PDC202XX: that's because some HDD will return wrong info */
  return ((byte) ((HWIF(drive)->udma_four) &&
 #ifndef CONFIG_IDEDMA_IVB
    (drive->id->hw_config & 0x4000) &&
diff -urN linux-2.4.18.org/drivers/ide/ide-pci.c linux/drivers/ide/ide-pci.c
--- linux-2.4.18.org/drivers/ide/ide-pci.c Fri Oct 26 04:53:47 2001
+++ linux/drivers/ide/ide-pci.c Wed Feb 27 19:26:40 2002
@@ -11,6 +11,10 @@
  *  This module provides support for automatic detection and
  *  configuration of all PCI IDE interfaces present in a system.
  */
+/*
+ * Support PROMISE PDC20268/20269/20275 IDE Controller.
+ * Powered by PROMISE Technology, Inc. Portions Copyright (C)2001.
+ */

 #include <linux/config.h>
 #include <linux/types.h>
@@ -45,8 +49,9 @@
 #define DEVID_PDC20262 ((ide_pci_devid_t){PCI_VENDOR_ID_PROMISE,
PCI_DEVICE_ID_PROMISE_20262})
 #define DEVID_PDC20265 ((ide_pci_devid_t){PCI_VENDOR_ID_PROMISE,
PCI_DEVICE_ID_PROMISE_20265})
 #define DEVID_PDC20267 ((ide_pci_devid_t){PCI_VENDOR_ID_PROMISE,
PCI_DEVICE_ID_PROMISE_20267})
-#define DEVID_PDC20268  ((ide_pci_devid_t){PCI_VENDOR_ID_PROMISE,
PCI_DEVICE_ID_PROMISE_20268})
-#define DEVID_PDC20268R ((ide_pci_devid_t){PCI_VENDOR_ID_PROMISE,
PCI_DEVICE_ID_PROMISE_20268R})
+#define DEVID_PDC20268 ((ide_pci_devid_t){PCI_VENDOR_ID_PROMISE,
PCI_DEVICE_ID_PROMISE_20268})
+#define DEVID_PDC20269 ((ide_pci_devid_t){PCI_VENDOR_ID_PROMISE,
PCI_DEVICE_ID_PROMISE_20269})
+#define DEVID_PDC20275 ((ide_pci_devid_t){PCI_VENDOR_ID_PROMISE,
PCI_DEVICE_ID_PROMISE_20275})
 #define DEVID_RZ1000 ((ide_pci_devid_t){PCI_VENDOR_ID_PCTECH,
PCI_DEVICE_ID_PCTECH_RZ1000})
 #define DEVID_RZ1001 ((ide_pci_devid_t){PCI_VENDOR_ID_PCTECH,
PCI_DEVICE_ID_PCTECH_RZ1001})
 #define DEVID_SAMURAI ((ide_pci_devid_t){PCI_VENDOR_ID_PCTECH,
PCI_DEVICE_ID_PCTECH_SAMURAI_IDE})
@@ -402,10 +407,8 @@
  {DEVID_PDC20267,"PDC20267", PCI_PDC202XX, ATA66_PDC202XX, INIT_PDC202XX,
NULL,  {{0x50,0x02,0x02}, {0x50,0x04,0x04}}, OFF_BOARD, 48 },
 #endif
  {DEVID_PDC20268,"PDC20268", PCI_PDC202XX, ATA66_PDC202XX, INIT_PDC202XX,
NULL,  {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, OFF_BOARD, 16 },
- /* Promise used a different PCI ident for the raid card apparently to try
and
-    prevent Linux detecting it and using our own raid code. We want to
detect
-    it for the ataraid drivers, so we have to list both here.. */
- {DEVID_PDC20268R,"PDC20268", PCI_PDC202XX, ATA66_PDC202XX, INIT_PDC202XX,
NULL,  {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, OFF_BOARD, 16 },
+ {DEVID_PDC20269,"PDC20269", PCI_PDC202XX, ATA66_PDC202XX, INIT_PDC202XX,
NULL,  {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, OFF_BOARD, 16 },
+ {DEVID_PDC20275,"PDC20275", PCI_PDC202XX, ATA66_PDC202XX, INIT_PDC202XX,
NULL,  {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, OFF_BOARD, 16 },
  {DEVID_RZ1000, "RZ1000", NULL,  NULL,  INIT_RZ1000, NULL,
{{0x00,0x00,0x00}, {0x00,0x00,0x00}},  ON_BOARD, 0 },
  {DEVID_RZ1001, "RZ1001", NULL,  NULL,  INIT_RZ1000, NULL,
{{0x00,0x00,0x00}, {0x00,0x00,0x00}},  ON_BOARD, 0 },
  {DEVID_SAMURAI, "SAMURAI", NULL,  NULL,  INIT_SAMURAI, NULL,
{{0x00,0x00,0x00}, {0x00,0x00,0x00}}, ON_BOARD, 0 },
@@ -458,6 +461,8 @@
   case PCI_DEVICE_ID_PROMISE_20265:
   case PCI_DEVICE_ID_PROMISE_20267:
   case PCI_DEVICE_ID_PROMISE_20268:
+  case PCI_DEVICE_ID_PROMISE_20269:
+  case PCI_DEVICE_ID_PROMISE_20275:
   case PCI_DEVICE_ID_ARTOP_ATP850UF:
   case PCI_DEVICE_ID_ARTOP_ATP860:
   case PCI_DEVICE_ID_ARTOP_ATP860R:
@@ -586,6 +591,7 @@
  ide_hwif_t *hwif, *mate = NULL;
  unsigned int class_rev;
  static int secondpdc = 0;
+ int new_chip=0;

 #ifdef CONFIG_IDEDMA_AUTO
  if (!noautodma)
@@ -684,6 +690,10 @@
  /*
   * Set up the IDE ports
   */
+ if ((IDE_PCI_DEVID_EQ(d->devid,DEVID_PDC20268)) ||
+      (IDE_PCI_DEVID_EQ(d->devid,DEVID_PDC20269)) ||
+      (IDE_PCI_DEVID_EQ(d->devid,DEVID_PDC20275)))
+   new_chip=1;
  for (port = 0; port <= 1; ++port) {
   unsigned long base = 0, ctl = 0;
   ide_pci_enablebit_t *e = &(d->enablebits[port]);
@@ -697,9 +707,9 @@
    goto controller_ok;
   if ((IDE_PCI_DEVID_EQ(d->devid, DEVID_PDC20262)) && (secondpdc++==1) &&
(port==1)  )
    goto controller_ok;
-
-  if (e->reg && (pci_read_config_byte(dev, e->reg, &tmp) || (tmp & e->mask)
!= e->val))
-   continue; /* port not enabled */
+  if (!(new_chip))
+   if (e->reg && (pci_read_config_byte(dev, e->reg, &tmp) || (tmp &
e->mask) != e->val))
+    continue; /* port not enabled */
 controller_ok:
   if (IDE_PCI_DEVID_EQ(d->devid, DEVID_HPT366) && (port) && (class_rev <
0x03))
    return;
@@ -774,7 +784,8 @@
       IDE_PCI_DEVID_EQ(d->devid, DEVID_PDC20265) ||
       IDE_PCI_DEVID_EQ(d->devid, DEVID_PDC20267) ||
       IDE_PCI_DEVID_EQ(d->devid, DEVID_PDC20268) ||
-      IDE_PCI_DEVID_EQ(d->devid, DEVID_PDC20268R) ||
+      IDE_PCI_DEVID_EQ(d->devid, DEVID_PDC20269) ||
+      IDE_PCI_DEVID_EQ(d->devid, DEVID_PDC20275) ||
       IDE_PCI_DEVID_EQ(d->devid, DEVID_AEC6210) ||
       IDE_PCI_DEVID_EQ(d->devid, DEVID_AEC6260) ||
       IDE_PCI_DEVID_EQ(d->devid, DEVID_AEC6260R) ||
diff -urN linux-2.4.18.org/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.4.18.org/drivers/ide/ide.c Tue Feb 26 03:37:57 2002
+++ linux/drivers/ide/ide.c Wed Feb 27 19:27:51 2002
@@ -716,7 +716,6 @@
   }
  }
  hwgroup->poll_timeout = 0; /* done polling */
- return ide_stopped;
 }

 static void check_dma_crc (ide_drive_t *drive)
@@ -883,6 +882,7 @@
 {
  unsigned long flags;
  byte err = 0;
+ int lba48=(drive->id->command_set_2 & 0x0400);

  __save_flags (flags); /* local CPU only */
  ide__sti();  /* local CPU only */
@@ -918,7 +918,16 @@
    printk("}");
    if ((err & (BBD_ERR | ABRT_ERR)) == BBD_ERR || (err &
(ECC_ERR|ID_ERR|MARK_ERR))) {
     byte cur = IN_BYTE(IDE_SELECT_REG);
-    if (cur & 0x40) { /* using LBA? */
+    if ((lba48) && (HWIF(drive)->pci_devid.vid==0x105a)) { /* 48bit LBA? */
+     OUT_BYTE(0x88, IDE_CONTROL_REG);
+     cur = IN_BYTE(IDE_SECTOR_REG);
+     OUT_BYTE(0x08, IDE_CONTROL_REG);
+     printk(", LBAsect=%ld", (unsigned long)
+     (cur << 24)
+      |(IN_BYTE(IDE_HCYL_REG)<<16)
+      |(IN_BYTE(IDE_LCYL_REG)<<8)
+      | IN_BYTE(IDE_SECTOR_REG));
+    } else if (cur & 0x40) { /* using LBA? */
      printk(", LBAsect=%ld", (unsigned long)
       ((cur&0xf)<<24)
       |(IN_BYTE(IDE_HCYL_REG)<<16)
@@ -3746,7 +3755,6 @@
 char *options = NULL;
 MODULE_PARM(options,"s");
 MODULE_LICENSE("GPL");
-
 static void __init parse_options (char *line)
 {
  char *next = line;
diff -urN linux-2.4.18.org/drivers/ide/pdc202xx.c
linux/drivers/ide/pdc202xx.c
--- linux-2.4.18.org/drivers/ide/pdc202xx.c Thu Nov 15 03:44:03 2001
+++ linux/drivers/ide/pdc202xx.c Thu Feb 28 00:48:45 2002
@@ -1,5 +1,5 @@
 /*
- *  linux/drivers/ide/pdc202xx.c Version 0.30 Mar. 18, 2000
+ *  linux/drivers/ide/pdc202xx.c Version 0.32 Feb. 27, 2002
  *
  *  Copyright (C) 1998-2000 Andre Hedrick <andre@linux-ide.org>
  *  May be copied or modified under the terms of the GNU General Public
License
@@ -12,7 +12,8 @@
  *  Promise Ultra66 cards with BIOS v1.11 this
  *  compiled into the kernel if you have more than one card installed.
  *
- *  Promise Ultra100 cards.
+ *  Promise Ultra Series cards.
+ *  Promise Ultra100TX2 & Ultra133TX2 cards.
  *
  *  The latest chipset code will support the following ::
  *  Three Ultra33 controllers and 12 drives.
@@ -21,13 +22,29 @@
  *
  *  UNLESS you enable "CONFIG_PDC202XX_BURST"
  *
- */
-
-/*
- *  Portions Copyright (C) 1999 Promise Technology, Inc.
- *  Author: Frank Tiernan (frankt@promise.com)
+ *  Version 1.20.b1 support PDC20268
+ *                  fix cable judge function
+ *  Version 1.20.b2 support ATA-133 PDC20269/75
+ *                  support UDMA Mode 6
+ *                  fix proc report information
+ *                  set ATA133 timing
+ *                  fix ultra dma bit 14 selectable
+ *                  support 32bit LBA
+ *  Version 1.20 b3 fix eighty_ninty_three()
+ *                  fix offset address 0x1c~0x1f
+ *  Version 1.20 b4 fix 48bit LBA HOB bit
+ *                  force rescan drive under PIO modes if need
+ *  Version 1.20.0.5 could be patched with ext3 filesystem code
+ *  Version 1.20.0.6 fix LBA48 drive running without promise controller
+ *                   fix LBA48 drive running under PIO modes
+ *
+ *  Portions Copyright (C) 1999-2002 Promise Technology, Inc.
+ *  Author: Frank Tiernan <frankt@promise.com>
+ *          Hank Yang <hanky@promise.com.tw> August.13.2001
  *  Released under terms of General Public License
  */
+#define VERSION "1.20.0.6"
+#define VERDATE "2002-01-28"

 #include <linux/config.h>
 #include <linux/types.h>
@@ -65,41 +82,10 @@
 extern int (*pdc202xx_display_info)(char *, char **, off_t, int); /*
ide-proc.c */
 extern char *ide_media_verbose(ide_drive_t *);
 static struct pci_dev *bmide_dev;
-
-char *pdc202xx_pio_verbose (u32 drive_pci)
-{
- if ((drive_pci & 0x000ff000) == 0x000ff000) return("NOTSET");
- if ((drive_pci & 0x00000401) == 0x00000401) return("PIO 4");
- if ((drive_pci & 0x00000602) == 0x00000602) return("PIO 3");
- if ((drive_pci & 0x00000803) == 0x00000803) return("PIO 2");
- if ((drive_pci & 0x00000C05) == 0x00000C05) return("PIO 1");
- if ((drive_pci & 0x00001309) == 0x00001309) return("PIO 0");
- return("PIO ?");
-}
-
-char *pdc202xx_dma_verbose (u32 drive_pci)
-{
- if ((drive_pci & 0x00036000) == 0x00036000) return("MWDMA 2");
- if ((drive_pci & 0x00046000) == 0x00046000) return("MWDMA 1");
- if ((drive_pci & 0x00056000) == 0x00056000) return("MWDMA 0");
- if ((drive_pci & 0x00056000) == 0x00056000) return("SWDMA 2");
- if ((drive_pci & 0x00068000) == 0x00068000) return("SWDMA 1");
- if ((drive_pci & 0x000BC000) == 0x000BC000) return("SWDMA 0");
- return("PIO---");
-}
-
-char *pdc202xx_ultra_verbose (u32 drive_pci, u16 slow_cable)
-{
- if ((drive_pci & 0x000ff000) == 0x000ff000)
-  return("NOTSET");
- if ((drive_pci & 0x00012000) == 0x00012000)
-  return((slow_cable) ? "UDMA 2" : "UDMA 4");
- if ((drive_pci & 0x00024000) == 0x00024000)
-  return((slow_cable) ? "UDMA 1" : "UDMA 3");
- if ((drive_pci & 0x00036000) == 0x00036000)
-  return("UDMA 0");
- return(pdc202xx_dma_verbose(drive_pci));
-}
+static struct hd_driveid *id[4];
+static int speed_rate[4];
+static int set_speed=0;
+static int new_chip=0;

 static char * pdc202xx_info (char *buf, struct pci_dev *dev)
 {
@@ -107,8 +93,8 @@

  u32 bibma  = pci_resource_start(dev, 4);
  u32 reg60h = 0, reg64h = 0, reg68h = 0, reg6ch = 0;
- u16 reg50h = 0, pmask = (1<<10), smask = (1<<11);
- u8 hi = 0, lo = 0, invalid_data_set = 0;
+ u16 reg50h = 0, word88=0;
+ int udmasel[4]={0,0,0,0}, piosel[4]={0,0,0,0}, i=0, hd=0;

         /*
          * at that point bibma+0x2 et bibma+0xa are byte registers
@@ -120,10 +106,6 @@
  u8 sc11 = inb_p((unsigned short)bibma + 0x11);
  u8 sc1a = inb_p((unsigned short)bibma + 0x1a);
  u8 sc1b = inb_p((unsigned short)bibma + 0x1b);
- u8 sc1c = inb_p((unsigned short)bibma + 0x1c);
- u8 sc1d = inb_p((unsigned short)bibma + 0x1d);
- u8 sc1e = inb_p((unsigned short)bibma + 0x1e);
- u8 sc1f = inb_p((unsigned short)bibma + 0x1f);

  pci_read_config_word(dev, 0x50, &reg50h);
  pci_read_config_dword(dev, 0x60, &reg60h);
@@ -131,45 +113,35 @@
  pci_read_config_dword(dev, 0x68, &reg68h);
  pci_read_config_dword(dev, 0x6c, &reg6ch);

+ p+=sprintf(p, "\nPROMISE Ultra series linux driver Ver %s %s Adapter: ",
VERSION, VERDATE);
  switch(dev->device) {
+  case PCI_DEVICE_ID_PROMISE_20275:
+   p += sprintf(p, "MBUltra133\n");
+   break;
+  case PCI_DEVICE_ID_PROMISE_20269:
+   p += sprintf(p, "Ultra133 TX2\n");
+   break;
   case PCI_DEVICE_ID_PROMISE_20268:
-  case PCI_DEVICE_ID_PROMISE_20268R:
-   p += sprintf(p, "\n                                PDC20268 TX2
Chipset.\n");
-   invalid_data_set = 1;
+   p += sprintf(p, "Ultra100 TX2\n");
    break;
   case PCI_DEVICE_ID_PROMISE_20267:
-   p += sprintf(p, "\n                                PDC20267
Chipset.\n");
+   p += sprintf(p, "Ultra100\n");
    break;
   case PCI_DEVICE_ID_PROMISE_20265:
-   p += sprintf(p, "\n                                PDC20265
Chipset.\n");
+   p += sprintf(p, "Ultra100 on M/B\n");
    break;
   case PCI_DEVICE_ID_PROMISE_20262:
-   p += sprintf(p, "\n                                PDC20262
Chipset.\n");
+   p += sprintf(p, "Ultra66\n");
    break;
   case PCI_DEVICE_ID_PROMISE_20246:
-   p += sprintf(p, "\n                                PDC20246
Chipset.\n");
+   p += sprintf(p, "Ultra33\n");
    reg50h |= 0x0c00;
    break;
   default:
-   p += sprintf(p, "\n                                PDC202XX
Chipset.\n");
+   p += sprintf(p, "Ultra Series\n");
    break;
  }

- p += sprintf(p, "------------------------------- General
Status ---------------------------------\n");
- p += sprintf(p, "Burst Mode                           : %sabled\n", (sc1f
& 0x01) ? "en" : "dis");
- p += sprintf(p, "Host Mode                            : %s\n", (sc1f &
0x08) ? "Tri-Stated" : "Normal");
- p += sprintf(p, "Bus Clocking                         : %s\n",
-  ((sc1f & 0xC0) == 0xC0) ? "100 External" :
-  ((sc1f & 0x80) == 0x80) ? "66 External" :
-  ((sc1f & 0x40) == 0x40) ? "33 External" : "33 PCI Internal");
- p += sprintf(p, "IO pad select                        : %s mA\n",
-  ((sc1c & 0x03) == 0x03) ? "10" :
-  ((sc1c & 0x02) == 0x02) ? "8" :
-  ((sc1c & 0x01) == 0x01) ? "6" :
-  ((sc1c & 0x00) == 0x00) ? "4" : "??");
- SPLIT_BYTE(sc1e, hi, lo);
- p += sprintf(p, "Status Polling Period                : %d\n", hi);
- p += sprintf(p, "Interrupt Check Status Polling Delay : %d\n", lo);
  p += sprintf(p, "--------------- Primary Channel ----------------
Secondary Channel -------------\n");
  p += sprintf(p, "                %s                         %s\n",
   (c0&0x80)?"disabled":"enabled ",
@@ -177,41 +149,33 @@
  p += sprintf(p, "66 Clocking     %s                         %s\n",
   (sc11&0x02)?"enabled ":"disabled",
   (sc11&0x08)?"enabled ":"disabled");
- p += sprintf(p, "           Mode %s                      Mode %s\n",
+ p += sprintf(p, "Mode            %s                         %s\n",
   (sc1a & 0x01) ? "MASTER" : "PCI   ",
   (sc1b & 0x01) ? "MASTER" : "PCI   ");
- if (!(invalid_data_set))
-  p += sprintf(p, "                %s                     %s\n",
-   (sc1d & 0x08) ? "Error       " :
-   ((sc1d & 0x05) == 0x05) ? "Not My INTR " :
-   (sc1d & 0x04) ? "Interrupting" :
-   (sc1d & 0x02) ? "FIFO Full   " :
-   (sc1d & 0x01) ? "FIFO Empty  " : "????????????",
-   (sc1d & 0x80) ? "Error       " :
-   ((sc1d & 0x50) == 0x50) ? "Not My INTR " :
-   (sc1d & 0x40) ? "Interrupting" :
-   (sc1d & 0x20) ? "FIFO Full   " :
-   (sc1d & 0x10) ? "FIFO Empty  " : "????????????");
  p += sprintf(p, "--------------- drive0 --------- drive1 --------
drive0 ---------- drive1 ------\n");
  p += sprintf(p, "DMA enabled:    %s              %s             %s
%s\n",
-  (c0&0x20)?"yes":"no ",(c0&0x40)?"yes":"no ",(c1&0x20)?"yes":"no
",(c1&0x40)?"yes":"no ");
- if (!(invalid_data_set))
-  p += sprintf(p, "DMA Mode:       %s           %s          %s
%s\n",
-   pdc202xx_ultra_verbose(reg60h, (reg50h & pmask)),
-   pdc202xx_ultra_verbose(reg64h, (reg50h & pmask)),
-   pdc202xx_ultra_verbose(reg68h, (reg50h & smask)),
-   pdc202xx_ultra_verbose(reg6ch, (reg50h & smask)));
- if (!(invalid_data_set))
-  p += sprintf(p, "PIO Mode:       %s            %s           %s
%s\n",
-   pdc202xx_pio_verbose(reg60h),
-   pdc202xx_pio_verbose(reg64h),
-   pdc202xx_pio_verbose(reg68h),
-   pdc202xx_pio_verbose(reg6ch));
+  (id[0]!=NULL && (c0&0x20))?"yes":"no ",(id[1]!=NULL &&
(c0&0x40))?"yes":"no ",
+  (id[2]!=NULL && (c1&0x20))?"yes":"no ",(id[3]!=NULL &&
(c1&0x40))?"yes":"no ");
+ for(hd=0;hd<4;hd++)
+ {
+  if (id[hd]==NULL)
+   continue;
+  word88=id[hd]->dma_ultra;
+  for (i=7;i>=0;i--)
+   if (word88>>(i+8))
+   {
+    udmasel[hd]=i; /* get select UDMA mode */
+    break;
+   }
+  piosel[hd]=(id[hd]->eide_pio_modes >= 0x02) ? 4 : 3;
+        }
+ p += sprintf(p, "UDMA Mode:      %d                %d               %d
%d\n",
+  udmasel[0],udmasel[1],udmasel[2],udmasel[3]);
+ p += sprintf(p, "PIO Mode:       %d                %d               %d
%d\n",
+  piosel[0],piosel[1],piosel[2],piosel[3]);
 #if 0
  p += sprintf(p, "--------------- Can ATAPI DMA ---------------\n");
 #endif
- if (invalid_data_set)
-  p += sprintf(p, "--------------- Cannot Decode HOST ---------------\n");
  return (char *)p;
 }

@@ -376,7 +340,21 @@
  int   err;
  byte   drive_pci, AP, BP, CP, DP;
  byte   TA = 0, TB = 0, TC = 0;
+#ifdef CONFIG_BLK_DEV_IDEDMA
+ unsigned long indexreg = (hwif->dma_base + 1);
+ unsigned long datareg = (hwif->dma_base + 3);
+#else
+ struct pci_dev *dev = hwif->pci_dev;
+ unsigned long high_16 = pci_resource_start(dev, 4);
+ unsigned long indexreg = high_16 + (hwif->channel ? 0x09 : 0x01);
+ unsigned long datareg = (indexreg + 2);
+#endif /* CONFIG_BLK_DEV_IDEDMA */
+ byte thold  =0x10;
+ byte adj  =(drive->dn%2) ? 0x08 : 0x00;
+ int  i=0, j=hwif->channel ? 2:0;

+if (!(new_chip))
+{
  switch (drive->dn) {
   case 0: drive_pci = 0x60; break;
   case 1: drive_pci = 0x64; break;
@@ -387,9 +365,6 @@

  if ((drive->media != ide_disk) && (speed < XFER_SW_DMA_0)) return -1;

- if (dev->device == PCI_DEVICE_ID_PROMISE_20268)
-  goto skip_register_hell;
-
  pci_read_config_dword(dev, drive_pci, &drive_conf);
  pci_read_config_byte(dev, (drive_pci), &AP);
  pci_read_config_byte(dev, (drive_pci)|0x01, &BP);
@@ -476,14 +451,158 @@
  decode_registers(REG_C, CP);
  decode_registers(REG_D, DP);
 #endif /* PDC202XX_DECODE_REGISTER_INFO */
-
-skip_register_hell:
-
+}
+ if (speed>=XFER_UDMA_6)
+  set_speed=1; /* we need to set ATA133 timing */
  if (!drive->init_speed)
   drive->init_speed = speed;
+#if PDC202XX_DEBUG_DRIVE_INFO
+ printk("%s: Before set_feature = %s, word88 = %#x\n",
+  drive->name, ide_xfer_verbose(speed), drive->id->dma_ultra );
+#endif /* PDC202XX_DEBUG_DRIVE_INFO */
  err = ide_config_drive_speed(drive, speed);
  drive->current_speed = speed;
-
+#ifdef CONFIG_BLK_DEV_IDEDMA
+ /* Setting tHOLD bit to 0 if using UDMA mode 2 */
+ if ((speed==XFER_UDMA_2) && (new_chip))
+ {
+  outb(thold+adj,indexreg);
+  outb((inb(datareg)&0x7f),datareg);
+ }
+#endif /* CONFIG_BLK_DEV_IDEDMA */
+ for (i=0;i<2;i++)
+  if (hwif->drives[i].present)
+    {
+    id[i+j]=hwif->drives[i].id; /* get identify structs */
+    speed_rate[i+j]=speed;  /* get current speed */
+   }
+ if (new_chip && set_speed)
+ {
+  for (i=0; i<4; i++)
+  {
+   if (id[i]==NULL)
+    continue;
+   switch(speed_rate[i]){
+   case XFER_PIO_0:
+    outb(0x0c+adj, indexreg);
+    outb(0xfb, datareg);
+    outb(0x0d+adj, indexreg);
+    outb(0x2b, datareg);
+    outb(0x13+adj, indexreg);
+    outb(0xac, datareg);
+    break;
+   case XFER_PIO_1:
+    outb(0x0c+adj, indexreg);
+    outb(0x46, datareg);
+    outb(0x0d+adj, indexreg);
+    outb(0x29, datareg);
+    outb(0x13+adj, indexreg);
+    outb(0xa4, datareg);
+    break;
+   case XFER_PIO_2:
+    outb(0x0c+adj, indexreg);
+    outb(0x23, datareg);
+    outb(0x0d+adj, indexreg);
+    outb(0x26, datareg);
+    outb(0x13+adj, indexreg);
+    outb(0x64, datareg);
+    break;
+   case XFER_PIO_3:
+    outb(0x0c+adj, indexreg);
+    outb(0x27, datareg);
+    outb(0x0d+adj, indexreg);
+    outb(0x0d, datareg);
+    outb(0x13+adj, indexreg);
+    outb(0x35, datareg);
+    break;
+   case XFER_PIO_4:
+    outb(0x0c+adj, indexreg);
+    outb(0x23, datareg);
+    outb(0x0d+adj, indexreg);
+    outb(0x09, datareg);
+    outb(0x13+adj, indexreg);
+    outb(0x25, datareg);
+    break;
+#ifdef CONFIG_BLK_DEV_IDEDMA
+   case XFER_MW_DMA_0:
+    outb(0x0e +adj, indexreg);
+    outb(0xdf, datareg);
+    outb(0x0f+adj, indexreg);
+    outb(0x5f, datareg);
+    break;
+   case XFER_MW_DMA_1:
+    outb(0x0e +adj, indexreg);
+    outb(0x6b, datareg);
+    outb(0x0f+adj, indexreg);
+    outb(0x27, datareg);
+    break;
+   case XFER_MW_DMA_2:
+    outb(0x0e +adj, indexreg);
+    outb(0x69, datareg);
+    outb(0x0f+adj, indexreg);
+    outb(0x25, datareg);
+    break;
+   case XFER_UDMA_0:
+    outb(0x10+adj, indexreg);
+    outb(0x4a, datareg);
+    outb(0x11+adj, indexreg);
+    outb(0x0f, datareg);
+    outb(0x12+adj, indexreg);
+    outb(0xd5, datareg);
+    break;
+   case XFER_UDMA_1:
+    outb(0x10+adj, indexreg);
+    outb(0x3a, datareg);
+    outb(0x11+adj, indexreg);
+    outb(0x0a, datareg);
+    outb(0x12+adj, indexreg);
+    outb(0xd0, datareg);
+     break;
+   case XFER_UDMA_2:
+    outb(0x10+adj, indexreg);
+    outb(0x2a, datareg);
+    outb(0x11+adj, indexreg);
+    outb(0x07, datareg);
+    outb(0x12+adj, indexreg);
+    outb(0xcd, datareg);
+    break;
+   case XFER_UDMA_3:
+    outb(0x10+adj, indexreg);
+    outb(0x1a, datareg);
+    outb(0x11+adj, indexreg);
+    outb(0x05, datareg);
+    outb(0x12+adj, indexreg);
+    outb(0xcd, datareg);
+    break;
+   case XFER_UDMA_4:
+    outb(0x10+adj, indexreg);
+    outb(0x1a, datareg);
+    outb(0x11+adj, indexreg);
+    outb(0x03, datareg);
+    outb(0x12+adj, indexreg);
+    outb(0xcd, datareg);
+    break;
+   case XFER_UDMA_5:
+    outb(0x10+adj, indexreg);
+    outb(0x1a, datareg);
+    outb(0x11+adj, indexreg);
+    outb(0x02, datareg);
+    outb(0x12+adj, indexreg);
+    outb(0xcb, datareg);
+    break;
+   case XFER_UDMA_6:
+    outb(0x10+adj, indexreg);
+    outb(0x1a, datareg);
+    outb(0x11+adj, indexreg);
+    outb(0x01, datareg);
+    outb(0x12+adj, indexreg);
+    outb(0xcb, datareg);
+    break;
+#endif /* CONFIG_BLK_DEV_IDEDMA */
+   default: break;
+   }
+  }
+ }
 #if PDC202XX_DEBUG_DRIVE_INFO
  printk("%s: %s drive%d 0x%08x ",
   drive->name, ide_xfer_verbose(speed),
@@ -519,22 +638,38 @@
 #ifdef CONFIG_BLK_DEV_IDEDMA
 static int config_chipset_for_dma (ide_drive_t *drive, byte ultra)
 {
- struct hd_driveid *id = drive->id;
- ide_hwif_t *hwif = HWIF(drive);
- struct pci_dev *dev = hwif->pci_dev;
- unsigned long high_16   = pci_resource_start(dev, 4);
- unsigned long dma_base  = hwif->dma_base;
- byte unit  = (drive->select.b.unit & 0x01);
+ struct hd_driveid *id  = drive->id;
+ ide_hwif_t *hwif  = HWIF(drive);
+ struct pci_dev *dev  = hwif->pci_dev;
+ unsigned long high_16    = pci_resource_start(dev, 4);
+ unsigned long dma_base   = hwif->dma_base;
+ unsigned long indexreg  = dma_base+1;
+ unsigned long datareg  = indexreg+2;
+ byte unit   = (drive->select.b.unit & 0x01);
+ byte iordy   = 0x13;
+ byte adj   = (drive->dn%2) ? 0x08 : 0x00;
+ byte  cable   = 0;

  unsigned int  drive_conf;
- byte   drive_pci;
+ byte   drive_pci = 0;
  byte   test1, test2, speed = -1;
  byte   AP;
  unsigned short  EP;
  byte CLKSPD  = IN_BYTE(high_16 + 0x11);
- byte udma_33  = ultra ? (inb(high_16 + 0x001f) & 1) : 0;
+ byte udma_33  = ultra;
  byte udma_66  = ((eighty_ninty_three(drive)) && udma_33) ? 1 : 0;
- byte udma_100  = (((dev->device == PCI_DEVICE_ID_PROMISE_20265) ||
(dev->device == PCI_DEVICE_ID_PROMISE_20267) || (dev->device ==
PCI_DEVICE_ID_PROMISE_20268)) && udma_66) ? 1 : 0;
+ byte udma_100  = (((dev->device == PCI_DEVICE_ID_PROMISE_20265) ||
+        (dev->device == PCI_DEVICE_ID_PROMISE_20267) ||
+         new_chip) && udma_66) ? 1 : 0;
+ byte udma_133  = (((dev->device == PCI_DEVICE_ID_PROMISE_20269) ||
+        (dev->device == PCI_DEVICE_ID_PROMISE_20275))
+         && udma_100) ? 1 : 0;
+ byte mask  = hwif->channel ? 0x08 : 0x02;
+ unsigned short c_mask = hwif->channel ? (1<<11) : (1<<10);
+ byte ultra_66  = ((id->dma_ultra & 0x0010) ||
+              (id->dma_ultra & 0x0008)) ? 1 : 0;
+ byte ultra_100  = ((id->dma_ultra & 0x0020) || (ultra_66)) ? 1 : 0;
+ byte ultra_133  = ((id->dma_ultra & 0x0040) || (ultra_100)) ? 1 : 0;

  /*
   * Set the control register to use the 66Mhz system
@@ -548,21 +683,18 @@
   * leave the 66Mhz clock on and readjust the timing
   * parameters.
   */
-
- byte mask  = hwif->channel ? 0x08 : 0x02;
- unsigned short c_mask = hwif->channel ? (1<<11) : (1<<10);
- byte ultra_66  = ((id->dma_ultra & 0x0010) ||
-       (id->dma_ultra & 0x0008)) ? 1 : 0;
- byte ultra_100  = ((id->dma_ultra & 0x0020) ||
-       (id->dma_ultra & 0x0010) ||
-       (id->dma_ultra & 0x0008)) ? 1 : 0;
-
- if (dev->device == PCI_DEVICE_ID_PROMISE_20268)
-  goto jump_pci_mucking;
-
- pci_read_config_word(dev, 0x50, &EP);
-
- if (((ultra_66) || (ultra_100)) && (EP & c_mask)) {
+
+ if (new_chip)
+ {
+  outb(0x0b,indexreg);
+  cable=(inb(datareg)&0x04); /* check 80pin cable? */
+ }
+ else {
+  pci_read_config_word(dev, 0x50, &EP);
+  cable=(EP & c_mask);  /* check 80pin cable? */
+ }
+
+ if (((ultra_66) || (ultra_100) || (ultra_133)) && (cable)) {
 #ifdef DEBUG
   printk("ULTRA66: %s channel of Ultra 66 requires an 80-pin cable for
Ultra66 operation.\n", hwif->channel ? "Secondary" : "Primary");
   printk("         Switching to Ultra33 mode.\n");
@@ -570,14 +702,19 @@
   /* Primary   : zero out second bit */
   /* Secondary : zero out fourth bit */
   OUT_BYTE(CLKSPD & ~mask, (high_16 + 0x11));
+  printk("Warning: %s channel requires an 80-pin cable for operation.\n",
+   hwif->channel ? "Secondary":"Primary");
+  printk("%s reduced to Ultra33 mode.\n", drive->name);
+  udma_66=0; udma_100=0; udma_133=0;
  } else {
-  if ((ultra_66) || (ultra_100)) {
+  if ((ultra_66) || (ultra_100) || (ultra_133)) {
    /*
     * check to make sure drive on same channel
     * is u66 capable
     */
    if (hwif->drives[!(drive->dn%2)].id) {
-    if ((hwif->drives[!(drive->dn%2)].id->dma_ultra & 0x0020) ||
+    if ((hwif->drives[!(drive->dn%2)].id->dma_ultra & 0x0040) ||
+        (hwif->drives[!(drive->dn%2)].id->dma_ultra & 0x0020) ||
         (hwif->drives[!(drive->dn%2)].id->dma_ultra & 0x0010) ||
         (hwif->drives[!(drive->dn%2)].id->dma_ultra & 0x0008)) {
      OUT_BYTE(CLKSPD | mask, (high_16 + 0x11));
@@ -589,7 +726,8 @@
    }
   }
  }
-
+    if (!(new_chip))
+    {
  switch(drive->dn) {
   case 0: drive_pci = 0x60;
    pci_read_config_dword(dev, drive_pci, &drive_conf);
@@ -639,10 +777,18 @@
  pci_read_config_byte(dev, (drive_pci), &AP);
  if (drive->media == ide_disk) /* PREFETCH_EN */
   pci_write_config_byte(dev, (drive_pci), AP|PREFETCH_EN);
-
-jump_pci_mucking:
-
- if ((id->dma_ultra & 0x0020) && (udma_100)) speed = XFER_UDMA_5;
+    }
+    else
+    {
+     if (drive->media != ide_disk) return ide_dma_off_quietly;
+ if (id->capability & 4) /* IORDY_EN & PREFETCH_EN*/
+ {
+  outb(iordy+adj, indexreg);
+  outb((inb(datareg)|0x03), datareg);
+ }
+    }
+     if ((id->dma_ultra & 0x0040) && (udma_133)) speed = XFER_UDMA_6;
+ else if ((id->dma_ultra & 0x0020) && (udma_100)) speed = XFER_UDMA_5;
  else if ((id->dma_ultra & 0x0010) && (udma_66)) speed = XFER_UDMA_4;
  else if ((id->dma_ultra & 0x0008) && (udma_66)) speed = XFER_UDMA_3;
  else if ((id->dma_ultra & 0x0004) && (udma_33)) speed = XFER_UDMA_2;
@@ -656,7 +802,7 @@
  else if (id->dma_1word & 0x0001)  speed = XFER_SW_DMA_0;
  else {
   /* restore original pci-config space */
-  if (dev->device != PCI_DEVICE_ID_PROMISE_20268)
+  if (!(new_chip))
    pci_write_config_dword(dev, drive_pci, drive_conf);
   return ide_dma_off_quietly;
  }
@@ -664,11 +810,13 @@
  outb(inb(dma_base+2) & ~(1<<(5+unit)), dma_base+2);
  (void) pdc202xx_tune_chipset(drive, speed);

- return ((int) ((id->dma_ultra >> 11) & 7) ? ide_dma_on :
+
+ return ((int) ((id->dma_ultra >> 14) & 3) ? ide_dma_on :
+   ((id->dma_ultra >> 11) & 7) ? ide_dma_on :
    ((id->dma_ultra >> 8) & 7) ? ide_dma_on :
    ((id->dma_mword >> 8) & 7) ? ide_dma_on :
    ((id->dma_1word >> 8) & 7) ? ide_dma_on :
-           ide_dma_off_quietly);
+   ide_dma_off_quietly);
 }

 static int config_drive_xfer_rate (ide_drive_t *drive)
@@ -685,7 +833,7 @@
   }
   dma_func = ide_dma_off_quietly;
   if (id->field_valid & 4) {
-   if (id->dma_ultra & 0x002F) {
+   if (id->dma_ultra & 0x007F) {
     /* Force if Capable UltraDMA */
     dma_func = config_chipset_for_dma(drive, 1);
     if ((id->field_valid & 2) &&
@@ -757,6 +905,13 @@
   case ide_dma_timeout:
    if (HWIF(drive)->resetproc != NULL)
     HWIF(drive)->resetproc(drive);
+   break;
+  /*
+  case ide_dma_off:
+   printk("PDC202XX: Force DMA keep on.\n");
+   return (0);
+   //func=ide_dma_check; // Fix me!!
+  */
   default:
    break;
  }
@@ -766,13 +921,12 @@

 void pdc202xx_reset (ide_drive_t *drive)
 {
- unsigned long high_16 = pci_resource_start(HWIF(drive)->pci_dev, 4);
- byte udma_speed_flag = inb(high_16 + 0x001f);
-
- OUT_BYTE(udma_speed_flag | 0x10, high_16 + 0x001f);
- mdelay(100);
- OUT_BYTE(udma_speed_flag & ~0x10, high_16 + 0x001f);
- mdelay(2000);  /* 2 seconds ?! */
+ outb(0x04,IDE_CONTROL_REG);
+ mdelay(1000);
+ outb(0x00,IDE_CONTROL_REG);
+ mdelay(1000);
+ printk("PDC202XX: %s channel reset.\n",
+   HWIF(drive)->channel ? "Secondary":"Primary");
 }

 unsigned int __init pci_init_pdc202xx (struct pci_dev *dev, const char
*name)
@@ -784,6 +938,9 @@

  if ((dev->device == PCI_DEVICE_ID_PROMISE_20262) ||
      (dev->device == PCI_DEVICE_ID_PROMISE_20265) ||
+     (dev->device == PCI_DEVICE_ID_PROMISE_20268) ||
+     (dev->device == PCI_DEVICE_ID_PROMISE_20269) ||
+     (dev->device == PCI_DEVICE_ID_PROMISE_20275) ||
      (dev->device == PCI_DEVICE_ID_PROMISE_20267)) {
   /*
    * software reset -  this is required because the bios
@@ -800,6 +957,10 @@
   OUT_BYTE(udma_speed_flag & ~0x10, high_16 + 0x001f);
   mdelay(2000); /* 2 seconds ?! */
  }
+ if ((dev->device == PCI_DEVICE_ID_PROMISE_20268) ||
+     (dev->device == PCI_DEVICE_ID_PROMISE_20269) ||
+     (dev->device == PCI_DEVICE_ID_PROMISE_20275))
+          new_chip=1;

  if (dev->resource[PCI_ROM_RESOURCE].start) {
   pci_write_config_dword(dev, PCI_ROM_ADDRESS,
dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
@@ -813,7 +974,7 @@
   if ((irq != irq2) &&
       (dev->device != PCI_DEVICE_ID_PROMISE_20265) &&
       (dev->device != PCI_DEVICE_ID_PROMISE_20267) &&
-      (dev->device != PCI_DEVICE_ID_PROMISE_20268)) {
+      !(new_chip)) {
    pci_write_config_byte(dev, (PCI_INTERRUPT_LINE)|0x80, irq); /* 0xbc */
    printk("%s: pci-config space interrupt mirror fixed.\n", name);
   }
@@ -866,10 +1027,19 @@
  unsigned short mask = (hwif->channel) ? (1<<11) : (1<<10);
  unsigned short CIS;

- pci_read_config_word(hwif->pci_dev, 0x50, &CIS);
- return ((CIS & mask) ? 0 : 1);
+  switch(hwif->pci_dev->device) {
+  case PCI_DEVICE_ID_PROMISE_20275:
+  case PCI_DEVICE_ID_PROMISE_20269:
+  case PCI_DEVICE_ID_PROMISE_20268:
+   OUT_BYTE(0x0b, (hwif->dma_base + 1));
+   return (!(IN_BYTE((hwif->dma_base + 3)) & 0x04));
+   /* check 80pin cable */
+  default:
+   pci_read_config_word(hwif->pci_dev, 0x50, &CIS);
+   return (!(CIS & mask));
+   /* check 80pin cable */
+ }
 }
-
 void __init ide_init_pdc202xx (ide_hwif_t *hwif)
 {
  hwif->tuneproc = &pdc202xx_tune_drive;
@@ -878,6 +1048,9 @@

  if ((hwif->pci_dev->device == PCI_DEVICE_ID_PROMISE_20262) ||
      (hwif->pci_dev->device == PCI_DEVICE_ID_PROMISE_20265) ||
+     (hwif->pci_dev->device == PCI_DEVICE_ID_PROMISE_20268) ||
+     (hwif->pci_dev->device == PCI_DEVICE_ID_PROMISE_20269) ||
+     (hwif->pci_dev->device == PCI_DEVICE_ID_PROMISE_20275) ||
      (hwif->pci_dev->device == PCI_DEVICE_ID_PROMISE_20267)) {
   hwif->resetproc = &pdc202xx_reset;
  }
diff -urN linux-2.4.18.org/include/linux/hdreg.h linux/include/linux/hdreg.h
--- linux-2.4.18.org/include/linux/hdreg.h Fri Nov 23 03:46:18 2001
+++ linux/include/linux/hdreg.h Wed Feb 27 19:54:12 2002
@@ -81,6 +81,14 @@

 #define WIN_SMART  0xB0 /* self-monitoring and reporting */

+/* Additianal command for 48 Bit LBA */
+#define READ_EXT  0x24
+#define WRITE_EXT  0x34
+#define MULTI_READ_EXT  0x29
+#define MULTI_WRITE_EXT  0x39
+#define READ_DMA_EXT  0x25
+#define WRITE_DMA_EXT  0x35
+
 /* Additional drive command codes used by ATAPI devices. */
 #define WIN_PIDENTIFY  0xA1 /* identify ATAPI device */
 #define WIN_SRST  0x08 /* ATAPI soft reset command */
diff -urN linux-2.4.18.org/include/linux/pci_ids.h
linux/include/linux/pci_ids.h
--- linux-2.4.18.org/include/linux/pci_ids.h Tue Feb 26 03:38:13 2002
+++ linux/include/linux/pci_ids.h Wed Feb 27 19:45:18 2002
@@ -603,7 +603,6 @@
 #define PCI_DEVICE_ID_PROMISE_20246 0x4d33
 #define PCI_DEVICE_ID_PROMISE_20262 0x4d38
 #define PCI_DEVICE_ID_PROMISE_20268 0x4d68
-#define PCI_DEVICE_ID_PROMISE_20268R 0x6268
 #define PCI_DEVICE_ID_PROMISE_20269 0x4d69
 #define PCI_DEVICE_ID_PROMISE_20275 0x1275
 #define PCI_DEVICE_ID_PROMISE_5300 0x5300


