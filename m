Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751140AbVKTAM2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbVKTAM2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 19:12:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbVKTAM2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 19:12:28 -0500
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:63128 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S1751051AbVKTAM1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 19:12:27 -0500
Date: Sun, 20 Nov 2005 00:46:00 +0100 (CET)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] ide update
Message-ID: <Pine.GSO.4.62.0511200043170.23874@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


VT6410 and SiS965 support,
+ few trivial cleanups as a bonus.


Please pull from:

master.kernel.org:/pub/scm/linux/kernel/git/bart/ide-2.6.git/

to obtain following changes:

Aurelien Jarno:
   sis5513: enable ATA133 for the SiS965 southbridge

Bartlomiej Zolnierkiewicz:
   ide: remove duplicate documentation for ide_do_drive_cmd()
   ide: remove unused ide_action_t:ide_next
   ide: remove dead DEBUG_TASKFILE code
   ide: remove dead code from flagged_taskfile()
   ide: add missing __init tags to device drivers

Mathias Kretschmer:
   via82cxxx: add VIA VT6410 IDE support


  drivers/ide/ide-cd.c        |    4 ++--
  drivers/ide/ide-disk.c      |    2 +-
  drivers/ide/ide-floppy.c    |    5 +----
  drivers/ide/ide-io.c        |    6 ------
  drivers/ide/ide-tape.c      |    5 +----
  drivers/ide/ide-taskfile.c  |   27 +++------------------------
  drivers/ide/pci/sis5513.c   |    1 +
  drivers/ide/pci/via82cxxx.c |   30 +++++++++++++++++++++---------
  include/linux/hdreg.h       |    6 ++++--
  include/linux/ide.h         |   26 --------------------------
  include/linux/pci_ids.h     |    2 ++
  11 files changed, 36 insertions(+), 78 deletions(-)


diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -3510,8 +3510,8 @@ static void __exit ide_cdrom_exit(void)
  {
  	driver_unregister(&ide_cdrom_driver.gen_driver);
  }
- 
-static int ide_cdrom_init(void)
+
+static int __init ide_cdrom_init(void)
  {
  	return driver_register(&ide_cdrom_driver.gen_driver);
  }
diff --git a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -1266,7 +1266,7 @@ static void __exit idedisk_exit (void)
  	driver_unregister(&idedisk_driver.gen_driver);
  }

-static int idedisk_init (void)
+static int __init idedisk_init(void)
  {
  	return driver_register(&idedisk_driver.gen_driver);
  }
diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -2191,10 +2191,7 @@ static void __exit idefloppy_exit (void)
  	driver_unregister(&idefloppy_driver.gen_driver);
  }

-/*
- *	idefloppy_init will register the driver for each floppy.
- */
-static int idefloppy_init (void)
+static int __init idefloppy_init(void)
  {
  	printk("ide-floppy driver " IDEFLOPPY_VERSION "\n");
  	return driver_register(&idefloppy_driver.gen_driver);
diff --git a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -1629,12 +1629,6 @@ EXPORT_SYMBOL(ide_init_drive_cmd);
   *	for the new rq to be completed.  This is VERY DANGEROUS, and is
   *	intended for careful use by the ATAPI tape/cdrom driver code.
   *
- *	If action is ide_next, then the rq is queued immediately after
- *	the currently-being-processed-request (if any), and the function
- *	returns without waiting for the new rq to be completed.  As above,
- *	This is VERY DANGEROUS, and is intended for careful use by the
- *	ATAPI tape/cdrom driver code.
- *
   *	If action is ide_end, then the rq is queued at the end of the
   *	request queue, and the function returns immediately without waiting
   *	for the new rq to be completed. This is again intended for careful
diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -4916,10 +4916,7 @@ static void __exit idetape_exit (void)
  	unregister_chrdev(IDETAPE_MAJOR, "ht");
  }

-/*
- *	idetape_init will register the driver for each tape.
- */
-static int idetape_init (void)
+static int __init idetape_init(void)
  {
  	int error = 1;
  	idetape_sysfs_class = class_create(THIS_MODULE, "ide_tape");
diff --git a/drivers/ide/ide-taskfile.c b/drivers/ide/ide-taskfile.c
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -51,8 +51,6 @@
  #include <asm/uaccess.h>
  #include <asm/io.h>

-#define DEBUG_TASKFILE	0	/* unset when fixed */
-
  static void ata_bswap_data (void *buffer, int wcount)
  {
  	u16 *p = buffer;
@@ -765,9 +763,6 @@ ide_startstop_t flagged_taskfile (ide_dr
  	ide_hwif_t *hwif	= HWIF(drive);
  	task_struct_t *taskfile	= (task_struct_t *) task->tfRegister;
  	hob_struct_t *hobfile	= (hob_struct_t *) task->hobRegister;
-#if DEBUG_TASKFILE
-	u8 status;
-#endif

  	if (task->data_phase == TASKFILE_MULTI_IN ||
  	    task->data_phase == TASKFILE_MULTI_OUT) {
@@ -778,19 +773,13 @@ ide_startstop_t flagged_taskfile (ide_dr
  	}

  	/*
-	 * (ks) Check taskfile in/out flags.
+	 * (ks) Check taskfile in flags.
  	 * If set, then execute as it is defined.
  	 * If not set, then define default settings.
  	 * The default values are:
-	 *	write and read all taskfile registers (except data) 
-	 *	write and read the hob registers (sector,nsector,lcyl,hcyl)
+	 *	read all taskfile registers (except data)
+	 *	read the hob registers (sector, nsector, lcyl, hcyl)
  	 */
-	if (task->tf_out_flags.all == 0) {
-		task->tf_out_flags.all = IDE_TASKFILE_STD_OUT_FLAGS;
-		if (drive->addressing == 1)
-			task->tf_out_flags.all |= (IDE_HOB_STD_OUT_FLAGS << 8);
-        }
-
  	if (task->tf_in_flags.all == 0) {
  		task->tf_in_flags.all = IDE_TASKFILE_STD_IN_FLAGS;
  		if (drive->addressing == 1)
@@ -803,16 +792,6 @@ ide_startstop_t flagged_taskfile (ide_dr
  		hwif->OUTB(drive->ctl, IDE_CONTROL_REG);
  	SELECT_MASK(drive, 0);

-#if DEBUG_TASKFILE
-	status = hwif->INB(IDE_STATUS_REG);
-	if (status & 0x80) {
-		printk("flagged_taskfile -> Bad status. Status = %02x. wait 100 usec ...\n", status);
-		udelay(100);
-		status = hwif->INB(IDE_STATUS_REG);
-		printk("flagged_taskfile -> Status = %02x\n", status);
-	}
-#endif
-
  	if (task->tf_out_flags.b.data) {
  		u16 data =  taskfile->data + (hobfile->data << 8);
  		hwif->OUTW(data, IDE_DATA_REG);
diff --git a/drivers/ide/pci/sis5513.c b/drivers/ide/pci/sis5513.c
--- a/drivers/ide/pci/sis5513.c
+++ b/drivers/ide/pci/sis5513.c
@@ -87,6 +87,7 @@ static const struct {
  	u8 chipset_family;
  	u8 flags;
  } SiSHostChipInfo[] = {
+	{ "SiS965",	PCI_DEVICE_ID_SI_965,	ATA_133  },
  	{ "SiS745",	PCI_DEVICE_ID_SI_745,	ATA_100  },
  	{ "SiS735",	PCI_DEVICE_ID_SI_735,	ATA_100  },
  	{ "SiS733",	PCI_DEVICE_ID_SI_733,	ATA_100  },
diff --git a/drivers/ide/pci/via82cxxx.c b/drivers/ide/pci/via82cxxx.c
--- a/drivers/ide/pci/via82cxxx.c
+++ b/drivers/ide/pci/via82cxxx.c
@@ -79,6 +79,7 @@ static struct via_isa_bridge {
  	u8 rev_max;
  	u16 flags;
  } via_isa_bridges[] = {
+	{ "vt6410",	PCI_DEVICE_ID_VIA_6410,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
  	{ "vt8237",	PCI_DEVICE_ID_VIA_8237,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
  	{ "vt8235",	PCI_DEVICE_ID_VIA_8235,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
  	{ "vt8233a",	PCI_DEVICE_ID_VIA_8233A,    0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
@@ -467,24 +468,35 @@ static void __devinit init_hwif_via82cxx
  	hwif->drives[1].autodma = hwif->autodma;
  }

-static ide_pci_device_t via82cxxx_chipset __devinitdata = {
-	.name		= "VP_IDE",
-	.init_chipset	= init_chipset_via82cxxx,
-	.init_hwif	= init_hwif_via82cxxx,
-	.channels	= 2,
-	.autodma	= NOAUTODMA,
-	.enablebits	= {{0x40,0x02,0x02}, {0x40,0x01,0x01}},
-	.bootable	= ON_BOARD,
+static ide_pci_device_t via82cxxx_chipsets[] __devinitdata = {
+	{	/* 0 */
+		.name		= "VP_IDE",
+		.init_chipset	= init_chipset_via82cxxx,
+		.init_hwif	= init_hwif_via82cxxx,
+		.channels	= 2,
+		.autodma	= NOAUTODMA,
+		.enablebits	= {{0x40,0x02,0x02}, {0x40,0x01,0x01}},
+		.bootable	= ON_BOARD
+	},{	/* 1 */
+		.name		= "VP_IDE",
+		.init_chipset	= init_chipset_via82cxxx,
+		.init_hwif	= init_hwif_via82cxxx,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
+		.bootable	= ON_BOARD,
+	}
  };

  static int __devinit via_init_one(struct pci_dev *dev, const struct pci_device_id *id)
  {
-	return ide_setup_pci_device(dev, &via82cxxx_chipset);
+	return ide_setup_pci_device(dev, &via82cxxx_chipsets[id->driver_data]);
  }

  static struct pci_device_id via_pci_tbl[] = {
  	{ PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C576_1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
  	{ PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{ PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_6410,     PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
  	{ 0, },
  };
  MODULE_DEVICE_TABLE(pci, via_pci_tbl);
diff --git a/include/linux/hdreg.h b/include/linux/hdreg.h
--- a/include/linux/hdreg.h
+++ b/include/linux/hdreg.h
@@ -80,10 +80,12 @@
  /*
   * Define standard taskfile in/out register
   */
-#define IDE_TASKFILE_STD_OUT_FLAGS	0xFE
  #define IDE_TASKFILE_STD_IN_FLAGS	0xFE
-#define IDE_HOB_STD_OUT_FLAGS		0x3C
  #define IDE_HOB_STD_IN_FLAGS		0x3C
+#ifndef __KERNEL__
+#define IDE_TASKFILE_STD_OUT_FLAGS	0xFE
+#define IDE_HOB_STD_OUT_FLAGS		0x3C
+#endif

  typedef unsigned char task_ioreg_t;
  typedef unsigned long sata_ioreg_t;
diff --git a/include/linux/ide.h b/include/linux/ide.h
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1201,37 +1201,11 @@ extern u64 ide_get_error_location(ide_dr
   */
  typedef enum {
  	ide_wait,	/* insert rq at end of list, and wait for it */
-	ide_next,	/* insert rq immediately after current request */
  	ide_preempt,	/* insert rq in front of current request */
  	ide_head_wait,	/* insert rq in front of current request and wait for it */
  	ide_end		/* insert rq at end of list, but don't wait for it */
  } ide_action_t;

-/*
- * This function issues a special IDE device request
- * onto the request queue.
- *
- * If action is ide_wait, then the rq is queued at the end of the
- * request queue, and the function sleeps until it has been processed.
- * This is for use when invoked from an ioctl handler.
- *
- * If action is ide_preempt, then the rq is queued at the head of
- * the request queue, displacing the currently-being-processed
- * request and this function returns immediately without waiting
- * for the new rq to be completed.  This is VERY DANGEROUS, and is
- * intended for careful use by the ATAPI tape/cdrom driver code.
- *
- * If action is ide_next, then the rq is queued immediately after
- * the currently-being-processed-request (if any), and the function
- * returns without waiting for the new rq to be completed.  As above,
- * This is VERY DANGEROUS, and is intended for careful use by the
- * ATAPI tape/cdrom driver code.
- *
- * If action is ide_end, then the rq is queued at the end of the
- * request queue, and the function returns immediately without waiting
- * for the new rq to be completed. This is again intended for careful
- * use by the ATAPI tape/cdrom driver code.
- */
  extern int ide_do_drive_cmd(ide_drive_t *, struct request *, ide_action_t);

  /*
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -620,6 +620,7 @@
  #define PCI_DEVICE_ID_SI_961		0x0961
  #define PCI_DEVICE_ID_SI_962		0x0962
  #define PCI_DEVICE_ID_SI_963		0x0963
+#define PCI_DEVICE_ID_SI_965		0x0965
  #define PCI_DEVICE_ID_SI_5511		0x5511
  #define PCI_DEVICE_ID_SI_5513		0x5513
  #define PCI_DEVICE_ID_SI_5518		0x5518
@@ -1234,6 +1235,7 @@
  #define PCI_DEVICE_ID_VIA_8703_51_0	0x3148
  #define PCI_DEVICE_ID_VIA_8237_SATA	0x3149
  #define PCI_DEVICE_ID_VIA_XN266		0x3156
+#define PCI_DEVICE_ID_VIA_6410		0x3164
  #define PCI_DEVICE_ID_VIA_8754C_0	0x3168
  #define PCI_DEVICE_ID_VIA_8235		0x3177
  #define PCI_DEVICE_ID_VIA_8385_0	0x3188
