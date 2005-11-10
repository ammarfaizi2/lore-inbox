Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751325AbVKJBEw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbVKJBEw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 20:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbVKJBEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 20:04:52 -0500
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:54978 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S1751139AbVKJBEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 20:04:50 -0500
Date: Thu, 10 Nov 2005 02:00:07 +0100 (CET)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] ide update
Message-ID: <Pine.GSO.4.62.0511100158050.19371@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Please pull from:

master.kernel.org:/pub/scm/linux/kernel/git/bart/ide-2.6.git/

to obtain following changes:

  drivers/ide/Kconfig         |    9 +
  drivers/ide/ide-floppy.c    |    6
  drivers/ide/ide-iops.c      |    6
  drivers/ide/ide-taskfile.c  |    2
  drivers/ide/ide.c           |    1
  drivers/ide/legacy/ide-cs.c |    7 -
  drivers/ide/pci/Makefile    |    1
  drivers/ide/pci/amd74xx.c   |    3
  drivers/ide/pci/cs5535.c    |  305 ++++++++++++++++++++++++++++++++++++++++++++
  drivers/ide/pci/cy82c693.c  |    2
  drivers/ide/pci/siimage.c   |    9 +
  drivers/scsi/ide-scsi.c     |    5
  include/asm-alpha/ide.h     |    4
  include/asm-i386/ide.h      |    6
  include/asm-sh/ide.h        |    4
  include/asm-sh64/ide.h      |    4
  include/linux/ide.h         |    5
  include/linux/pci_ids.h     |    3
  18 files changed, 352 insertions(+), 30 deletions(-)

Adrian Bunk:
   ide: possible cleanups

Alan Cox:
   ide: explain the PCI bus test we do in <asm-i386/ide.h>

Bjorn Helgaas:
   ide: move CONFIG_IDE_MAX_HWIFS into linux/ide.h

Hannes Reinecke:
   ide: incorrect device link for ide-cs

Jaya Kumar:
   ide: CS5535 driver

John W. Linville:
   siimage: enable interrupts on Adaptec SA-1210 card

Jordan Crouse:
   ide: AMD Geode GX/LX support

Ondrej Zary:
   ide-floppy: software eject not working with LS-120 drive

Willem Riede:
   ide: ide-scsi fails to call idescsi_check_condition for things like "Medium not present"

diff --git a/drivers/ide/Kconfig b/drivers/ide/Kconfig
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -539,6 +539,15 @@ config BLK_DEV_CS5530

  	  It is safe to say Y to this question.

+config BLK_DEV_CS5535
+	tristate "AMD CS5535 chipset support"
+	depends on X86 && !X86_64
+	help
+	  Include support for UDMA on the NSC/AMD CS5535 companion chipset.
+	  This will automatically be detected and configured if found.
+
+	  It is safe to say Y to this question.
+
  config BLK_DEV_HPT34X
  	tristate "HPT34X chipset support"
  	help
diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -2038,11 +2038,9 @@ static int idefloppy_ioctl(struct inode
  	struct ide_floppy_obj *floppy = ide_floppy_g(bdev->bd_disk);
  	ide_drive_t *drive = floppy->drive;
  	void __user *argp = (void __user *)arg;
-	int err = generic_ide_ioctl(drive, file, bdev, cmd, arg);
+	int err;
  	int prevent = (arg) ? 1 : 0;
  	idefloppy_pc_t pc;
-	if (err != -EINVAL)
-		return err;

  	switch (cmd) {
  	case CDROMEJECT:
@@ -2094,7 +2092,7 @@ static int idefloppy_ioctl(struct inode
  	case IDEFLOPPY_IOCTL_FORMAT_GET_PROGRESS:
  		return idefloppy_get_format_progress(drive, argp);
  	}
- 	return -EINVAL;
+	return generic_ide_ioctl(drive, file, bdev, cmd, arg);
  }

  static int idefloppy_media_changed(struct gendisk *disk)
diff --git a/drivers/ide/ide-iops.c b/drivers/ide/ide-iops.c
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -104,8 +104,6 @@ void default_hwif_iops (ide_hwif_t *hwif
  	hwif->INSL	= ide_insl;
  }

-EXPORT_SYMBOL(default_hwif_iops);
-
  /*
   *	MMIO operations, typically used for SATA controllers
   */
@@ -329,8 +327,6 @@ void default_hwif_transport(ide_hwif_t *
  	hwif->atapi_output_bytes	= atapi_output_bytes;
  }

-EXPORT_SYMBOL(default_hwif_transport);
-
  /*
   * Beginning of Taskfile OPCODE Library and feature sets.
   */
@@ -529,8 +525,6 @@ int wait_for_ready (ide_drive_t *drive,
  	return 0;
  }

-EXPORT_SYMBOL(wait_for_ready);
-
  /*
   * This routine busy-waits for the drive status to be not "busy".
   * It then checks the status for all of the "good" bits and none
diff --git a/drivers/ide/ide-taskfile.c b/drivers/ide/ide-taskfile.c
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -161,8 +161,6 @@ ide_startstop_t do_rw_taskfile (ide_driv
  	return ide_stopped;
  }

-EXPORT_SYMBOL(do_rw_taskfile);
-
  /*
   * set_multmode_intr() is invoked on completion of a WIN_SETMULT cmd.
   */
diff --git a/drivers/ide/ide.c b/drivers/ide/ide.c
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -803,6 +803,7 @@ found:
  	hwif->irq = hw->irq;
  	hwif->noprobe = 0;
  	hwif->chipset = hw->chipset;
+	hwif->gendev.parent = hw->dev;

  	if (!initializing) {
  		probe_hwif_init_with_fixup(hwif, fixup);
diff --git a/drivers/ide/legacy/ide-cs.c b/drivers/ide/legacy/ide-cs.c
--- a/drivers/ide/legacy/ide-cs.c
+++ b/drivers/ide/legacy/ide-cs.c
@@ -182,13 +182,14 @@ static void ide_detach(dev_link_t *link)

  } /* ide_detach */

-static int idecs_register(unsigned long io, unsigned long ctl, unsigned long irq)
+static int idecs_register(unsigned long io, unsigned long ctl, unsigned long irq, struct pcmcia_device *handle)
  {
      hw_regs_t hw;
      memset(&hw, 0, sizeof(hw));
      ide_init_hwif_ports(&hw, io, ctl, NULL);
      hw.irq = irq;
      hw.chipset = ide_pci;
+    hw.dev = &handle->dev;
      return ide_register_hw_with_fixup(&hw, NULL, ide_undecoded_slave);
  }

@@ -327,12 +328,12 @@ static void ide_config(dev_link_t *link)

      /* retry registration in case device is still spinning up */
      for (hd = -1, i = 0; i < 10; i++) {
-	hd = idecs_register(io_base, ctl_base, link->irq.AssignedIRQ);
+	hd = idecs_register(io_base, ctl_base, link->irq.AssignedIRQ, handle);
  	if (hd >= 0) break;
  	if (link->io.NumPorts1 == 0x20) {
  	    outb(0x02, ctl_base + 0x10);
  	    hd = idecs_register(io_base + 0x10, ctl_base + 0x10,
-				link->irq.AssignedIRQ);
+				link->irq.AssignedIRQ, handle);
  	    if (hd >= 0) {
  		io_base += 0x10;
  		ctl_base += 0x10;
diff --git a/drivers/ide/pci/Makefile b/drivers/ide/pci/Makefile
--- a/drivers/ide/pci/Makefile
+++ b/drivers/ide/pci/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_BLK_DEV_ATIIXP)		+= atiixp.
  obj-$(CONFIG_BLK_DEV_CMD64X)		+= cmd64x.o
  obj-$(CONFIG_BLK_DEV_CS5520)		+= cs5520.o
  obj-$(CONFIG_BLK_DEV_CS5530)		+= cs5530.o
+obj-$(CONFIG_BLK_DEV_CS5535)		+= cs5535.o
  obj-$(CONFIG_BLK_DEV_SC1200)		+= sc1200.o
  obj-$(CONFIG_BLK_DEV_CY82C693)		+= cy82c693.o
  obj-$(CONFIG_BLK_DEV_HPT34X)		+= hpt34x.o
diff --git a/drivers/ide/pci/amd74xx.c b/drivers/ide/pci/amd74xx.c
--- a/drivers/ide/pci/amd74xx.c
+++ b/drivers/ide/pci/amd74xx.c
@@ -74,6 +74,7 @@ static struct amd_ide_chip {
  	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_IDE,	0x50, AMD_UDMA_133 },
  	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_IDE,	0x50, AMD_UDMA_133 },
  	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_IDE,	0x50, AMD_UDMA_133 },
+	{ PCI_DEVICE_ID_AMD_CS5536_IDE,			0x40, AMD_UDMA_100 },
  	{ 0 }
  };

@@ -491,6 +492,7 @@ static ide_pci_device_t amd74xx_chipsets
  	/* 14 */ DECLARE_NV_DEV("NFORCE-MCP04"),
  	/* 15 */ DECLARE_NV_DEV("NFORCE-MCP51"),
  	/* 16 */ DECLARE_NV_DEV("NFORCE-MCP55"),
+	/* 17 */ DECLARE_AMD_DEV("AMD5536"),
  };

  static int __devinit amd74xx_probe(struct pci_dev *dev, const struct pci_device_id *id)
@@ -527,6 +529,7 @@ static struct pci_device_id amd74xx_pci_
  	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 14 },
  	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 15 },
  	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 16 },
+	{ PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_CS5536_IDE,		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 17 },
  	{ 0, },
  };
  MODULE_DEVICE_TABLE(pci, amd74xx_pci_tbl);
diff --git a/drivers/ide/pci/cs5535.c b/drivers/ide/pci/cs5535.c
new file mode 100644
--- /dev/null
+++ b/drivers/ide/pci/cs5535.c
@@ -0,0 +1,305 @@
+/*
+ * linux/drivers/ide/pci/cs5535.c
+ *
+ * Copyright (C) 2004-2005 Advanced Micro Devices, Inc.
+ *
+ * History:
+ * 09/20/2005 - Jaya Kumar <jayakumar.ide@gmail.com>
+ * - Reworked tuneproc, set_drive, misc mods to prep for mainline
+ * - Work was sponsored by CIS (M) Sdn Bhd.
+ * Ported to Kernel 2.6.11 on June 26, 2005 by
+ *   Wolfgang Zuleger <wolfgang.zuleger@gmx.de>
+ *   Alexander Kiausch <alex.kiausch@t-online.de>
+ * Originally developed by AMD for 2.4/2.6
+ *
+ * Development of this chipset driver was funded
+ * by the nice folks at National Semiconductor/AMD.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * Documentation:
+ *  CS5535 documentation available from AMD
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/ide.h>
+
+#include "ide-timing.h"
+
+#define MSR_ATAC_BASE		0x51300000
+#define ATAC_GLD_MSR_CAP	(MSR_ATAC_BASE+0)
+#define ATAC_GLD_MSR_CONFIG	(MSR_ATAC_BASE+0x01)
+#define ATAC_GLD_MSR_SMI	(MSR_ATAC_BASE+0x02)
+#define ATAC_GLD_MSR_ERROR	(MSR_ATAC_BASE+0x03)
+#define ATAC_GLD_MSR_PM		(MSR_ATAC_BASE+0x04)
+#define ATAC_GLD_MSR_DIAG	(MSR_ATAC_BASE+0x05)
+#define ATAC_IO_BAR		(MSR_ATAC_BASE+0x08)
+#define ATAC_RESET		(MSR_ATAC_BASE+0x10)
+#define ATAC_CH0D0_PIO		(MSR_ATAC_BASE+0x20)
+#define ATAC_CH0D0_DMA		(MSR_ATAC_BASE+0x21)
+#define ATAC_CH0D1_PIO		(MSR_ATAC_BASE+0x22)
+#define ATAC_CH0D1_DMA		(MSR_ATAC_BASE+0x23)
+#define ATAC_PCI_ABRTERR	(MSR_ATAC_BASE+0x24)
+#define ATAC_BM0_CMD_PRIM	0x00
+#define ATAC_BM0_STS_PRIM	0x02
+#define ATAC_BM0_PRD		0x04
+#define CS5535_CABLE_DETECT	0x48
+
+/* Format I PIO settings. We seperate out cmd and data for safer timings */
+
+static unsigned int cs5535_pio_cmd_timings[5] =
+{ 0xF7F4, 0x53F3, 0x13F1, 0x5131, 0x1131 };
+static unsigned int cs5535_pio_dta_timings[5] =
+{ 0xF7F4, 0xF173, 0x8141, 0x5131, 0x1131 };
+
+static unsigned int cs5535_mwdma_timings[3] =
+{ 0x7F0FFFF3, 0x7F035352, 0x7f024241 };
+
+static unsigned int cs5535_udma_timings[5] =
+{ 0x7F7436A1, 0x7F733481, 0x7F723261, 0x7F713161, 0x7F703061 };
+
+/* Macros to check if the register is the reset value -  reset value is an
+   invalid timing and indicates the register has not been set previously */
+
+#define CS5535_BAD_PIO(timings) ( (timings&~0x80000000UL) == 0x00009172 )
+#define CS5535_BAD_DMA(timings) ( (timings & 0x000FFFFF) == 0x00077771 )
+
+/****
+ *	cs5535_set_speed         -     Configure the chipset to the new speed
+ *	@drive: Drive to set up
+ *	@speed: desired speed
+ *
+ *	cs5535_set_speed() configures the chipset to a new speed.
+ */
+static void cs5535_set_speed(ide_drive_t *drive, u8 speed)
+{
+
+	u32 reg = 0, dummy;
+	int unit = drive->select.b.unit;
+
+
+	/* Set the PIO timings */
+	if ((speed & XFER_MODE) == XFER_PIO) {
+		u8 pioa;
+		u8 piob;
+		u8 cmd;
+
+		pioa = speed - XFER_PIO_0;
+		piob = ide_get_best_pio_mode(&(drive->hwif->drives[!unit]),
+						255, 4, NULL);
+		cmd = pioa < piob ? pioa : piob;
+
+		/* Write the speed of the current drive */
+		reg = (cs5535_pio_cmd_timings[cmd] << 16) |
+			cs5535_pio_dta_timings[pioa];
+		wrmsr(unit ? ATAC_CH0D1_PIO : ATAC_CH0D0_PIO, reg, 0);
+
+		/* And if nessesary - change the speed of the other drive */
+		rdmsr(unit ?  ATAC_CH0D0_PIO : ATAC_CH0D1_PIO, reg, dummy);
+
+		if (((reg >> 16) & cs5535_pio_cmd_timings[cmd]) !=
+			cs5535_pio_cmd_timings[cmd]) {
+			reg &= 0x0000FFFF;
+			reg |= cs5535_pio_cmd_timings[cmd] << 16;
+			wrmsr(unit ? ATAC_CH0D0_PIO : ATAC_CH0D1_PIO, reg, 0);
+		}
+
+		/* Set bit 31 of the DMA register for PIO format 1 timings */
+		rdmsr(unit ?  ATAC_CH0D1_DMA : ATAC_CH0D0_DMA, reg, dummy);
+		wrmsr(unit ? ATAC_CH0D1_DMA : ATAC_CH0D0_DMA,
+					reg | 0x80000000UL, 0);
+	} else {
+		rdmsr(unit ? ATAC_CH0D1_DMA : ATAC_CH0D0_DMA, reg, dummy);
+
+		reg &= 0x80000000UL;  /* Preserve the PIO format bit */
+
+		if (speed >= XFER_UDMA_0 && speed <= XFER_UDMA_7)
+			reg |= cs5535_udma_timings[speed - XFER_UDMA_0];
+		else if (speed >= XFER_MW_DMA_0 && speed <= XFER_MW_DMA_2)
+			reg |= cs5535_mwdma_timings[speed - XFER_MW_DMA_0];
+		else
+			return;
+
+		wrmsr(unit ? ATAC_CH0D1_DMA : ATAC_CH0D0_DMA, reg, 0);
+	}
+}
+
+static u8 cs5535_ratemask(ide_drive_t *drive)
+{
+	/* eighty93 will return 1 if it's 80core and capable of
+	exceeding udma2, 0 otherwise. we need ratemask to set
+	the max speed and if we can > udma2 then we return 2
+	which selects speed_max as udma4 which is the 5535's max
+	speed, and 1 selects udma2 which is the max for 40c */
+	if (!eighty_ninty_three(drive))
+		return 1;
+
+	return 2;
+}
+
+
+/****
+ *	cs5535_set_drive         -     Configure the drive to the new speed
+ *	@drive: Drive to set up
+ *	@speed: desired speed
+ *
+ *	cs5535_set_drive() configures the drive and the chipset to a
+ *	new speed. It also can be called by upper layers.
+ */
+static int cs5535_set_drive(ide_drive_t *drive, u8 speed)
+{
+	speed = ide_rate_filter(cs5535_ratemask(drive), speed);
+	ide_config_drive_speed(drive, speed);
+	cs5535_set_speed(drive, speed);
+
+	return 0;
+}
+
+/****
+ *	cs5535_tuneproc    -       PIO setup
+ *	@drive: drive to set up
+ *	@pio: mode to use (255 for 'best possible')
+ *
+ *	A callback from the upper layers for PIO-only tuning.
+ */
+static void cs5535_tuneproc(ide_drive_t *drive, u8 xferspeed)
+{
+	u8 modes[] = {	XFER_PIO_0, XFER_PIO_1, XFER_PIO_2, XFER_PIO_3,
+			XFER_PIO_4 };
+
+	/* cs5535 max pio is pio 4, best_pio will check the blacklist.
+	i think we don't need to rate_filter the incoming xferspeed
+	since we know we're only going to choose pio */
+	xferspeed = ide_get_best_pio_mode(drive, xferspeed, 4, NULL);
+	ide_config_drive_speed(drive, modes[xferspeed]);
+	cs5535_set_speed(drive, xferspeed);
+}
+
+static int cs5535_config_drive_for_dma(ide_drive_t *drive)
+{
+	u8 speed;
+
+	speed = ide_dma_speed(drive, cs5535_ratemask(drive));
+
+	/* If no DMA speed was available then let dma_check hit pio */
+	if (!speed) {
+		return 0;
+	}
+
+	cs5535_set_drive(drive, speed);
+	return ide_dma_enable(drive);
+}
+
+static int cs5535_dma_check(ide_drive_t *drive)
+{
+	ide_hwif_t *hwif	= drive->hwif;
+	struct hd_driveid *id	= drive->id;
+	u8 speed;
+
+	drive->init_speed = 0;
+
+	if ((id->capability & 1) && drive->autodma) {
+		if (ide_use_dma(drive)) {
+			if (cs5535_config_drive_for_dma(drive))
+				return hwif->ide_dma_on(drive);
+		}
+
+		goto fast_ata_pio;
+
+	} else if ((id->capability & 8) || (id->field_valid & 2)) {
+fast_ata_pio:
+		speed = ide_get_best_pio_mode(drive, 255, 4, NULL);
+		cs5535_set_drive(drive, speed);
+		return hwif->ide_dma_off_quietly(drive);
+	}
+	/* IORDY not supported */
+	return 0;
+}
+
+static u8 __devinit cs5535_cable_detect(struct pci_dev *dev)
+{
+	u8 bit;
+
+	/* if a 80 wire cable was detected */
+	pci_read_config_byte(dev, CS5535_CABLE_DETECT, &bit);
+	return (bit & 1);
+}
+
+/****
+ *	init_hwif_cs5535        -       Initialize one ide cannel
+ *	@hwif: Channel descriptor
+ *
+ *	This gets invoked by the IDE driver once for each channel. It
+ *	performs channel-specific pre-initialization before drive probing.
+ *
+ */
+static void __devinit init_hwif_cs5535(ide_hwif_t *hwif)
+{
+	int i;
+
+	hwif->autodma = 0;
+
+	hwif->tuneproc = &cs5535_tuneproc;
+	hwif->speedproc = &cs5535_set_drive;
+	hwif->ide_dma_check = &cs5535_dma_check;
+
+	hwif->atapi_dma = 1;
+	hwif->ultra_mask = 0x1F;
+	hwif->mwdma_mask = 0x07;
+
+
+	hwif->udma_four = cs5535_cable_detect(hwif->pci_dev);
+
+	if (!noautodma)
+		hwif->autodma = 1;
+
+	/* just setting autotune and not worrying about bios timings */
+	for (i = 0; i < 2; i++) {
+		hwif->drives[i].autotune = 1;
+		hwif->drives[i].autodma = hwif->autodma;
+	}
+}
+
+static ide_pci_device_t cs5535_chipset __devinitdata = {
+	.name		= "CS5535",
+	.init_hwif	= init_hwif_cs5535,
+	.channels	= 1,
+	.autodma	= AUTODMA,
+	.bootable	= ON_BOARD,
+};
+
+static int __devinit cs5535_init_one(struct pci_dev *dev,
+					const struct pci_device_id *id)
+{
+	return ide_setup_pci_device(dev, &cs5535_chipset);
+}
+
+static struct pci_device_id cs5535_pci_tbl[] =
+{
+	{ PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_CS5535_IDE, PCI_ANY_ID,
+		PCI_ANY_ID, 0, 0, 0},
+	{ 0, },
+};
+
+MODULE_DEVICE_TABLE(pci, cs5535_pci_tbl);
+
+static struct pci_driver driver = {
+	.name       = "CS5535_IDE",
+	.id_table   = cs5535_pci_tbl,
+	.probe      = cs5535_init_one,
+};
+
+static int __init cs5535_ide_init(void)
+{
+	return ide_pci_register_driver(&driver);
+}
+
+module_init(cs5535_ide_init);
+
+MODULE_AUTHOR("AMD");
+MODULE_DESCRIPTION("PCI driver module for AMD/NS CS5535 IDE");
+MODULE_LICENSE("GPL");
diff --git a/drivers/ide/pci/cy82c693.c b/drivers/ide/pci/cy82c693.c
--- a/drivers/ide/pci/cy82c693.c
+++ b/drivers/ide/pci/cy82c693.c
@@ -469,7 +469,7 @@ static void __devinit init_hwif_cy82c693

  static __devinitdata ide_hwif_t *primary;

-void __devinit init_iops_cy82c693(ide_hwif_t *hwif)
+static void __devinit init_iops_cy82c693(ide_hwif_t *hwif)
  {
  	if (PCI_FUNC(hwif->pci_dev->devfn) == 1)
  		primary = hwif;
diff --git a/drivers/ide/pci/siimage.c b/drivers/ide/pci/siimage.c
--- a/drivers/ide/pci/siimage.c
+++ b/drivers/ide/pci/siimage.c
@@ -701,6 +701,7 @@ static unsigned int setup_mmio_siimage (
  	unsigned long barsize	= pci_resource_len(dev, 5);
  	u8 tmpbyte	= 0;
  	void __iomem *ioaddr;
+	u32 tmp, irq_mask;

  	/*
  	 *	Drop back to PIO if we can't map the mmio. Some
@@ -726,6 +727,14 @@ static unsigned int setup_mmio_siimage (
  	pci_set_drvdata(dev, (void *) ioaddr);

  	if (pdev_is_sata(dev)) {
+		/* make sure IDE0/1 interrupts are not masked */
+		irq_mask = (1 << 22) | (1 << 23);
+		tmp = readl(ioaddr + 0x48);
+		if (tmp & irq_mask) {
+			tmp &= ~irq_mask;
+			writel(tmp, ioaddr + 0x48);
+			readl(ioaddr + 0x48); /* flush */
+		}
  		writel(0, ioaddr + 0x148);
  		writel(0, ioaddr + 0x1C8);
  	}
diff --git a/drivers/scsi/ide-scsi.c b/drivers/scsi/ide-scsi.c
--- a/drivers/scsi/ide-scsi.c
+++ b/drivers/scsi/ide-scsi.c
@@ -395,6 +395,7 @@ static int idescsi_end_request (ide_driv
  	int log = test_bit(IDESCSI_LOG_CMD, &scsi->log);
  	struct Scsi_Host *host;
  	u8 *scsi_buf;
+	int errors = rq->errors;
  	unsigned long flags;

  	if (!(rq->flags & (REQ_SPECIAL|REQ_SENSE))) {
@@ -421,11 +422,11 @@ static int idescsi_end_request (ide_driv
  			printk (KERN_WARNING "ide-scsi: %s: timed out for %lu\n",
  					drive->name, pc->scsi_cmd->serial_number);
  		pc->scsi_cmd->result = DID_TIME_OUT << 16;
-	} else if (rq->errors >= ERROR_MAX) {
+	} else if (errors >= ERROR_MAX) {
  		pc->scsi_cmd->result = DID_ERROR << 16;
  		if (log)
  			printk ("ide-scsi: %s: I/O error for %lu\n", drive->name, pc->scsi_cmd->serial_number);
-	} else if (rq->errors) {
+	} else if (errors) {
  		if (log)
  			printk ("ide-scsi: %s: check condition for %lu\n", drive->name, pc->scsi_cmd->serial_number);
  		if (!idescsi_check_condition(drive, rq))
diff --git a/include/asm-alpha/ide.h b/include/asm-alpha/ide.h
--- a/include/asm-alpha/ide.h
+++ b/include/asm-alpha/ide.h
@@ -15,10 +15,6 @@

  #include <linux/config.h>

-#ifndef MAX_HWIFS
-#define MAX_HWIFS	CONFIG_IDE_MAX_HWIFS
-#endif
-
  #define IDE_ARCH_OBSOLETE_DEFAULTS

  static inline int ide_default_irq(unsigned long base)
diff --git a/include/asm-i386/ide.h b/include/asm-i386/ide.h
--- a/include/asm-i386/ide.h
+++ b/include/asm-i386/ide.h
@@ -41,6 +41,12 @@ static __inline__ int ide_default_irq(un

  static __inline__ unsigned long ide_default_io_base(int index)
  {
+	/*
+	 *	If PCI is present then it is not safe to poke around
+	 *	the other legacy IDE ports. Only 0x1f0 and 0x170 are
+	 *	defined compatibility mode ports for PCI. A user can 
+	 *	override this using ide= but we must default safe.
+	 */
  	if (pci_find_device(PCI_ANY_ID, PCI_ANY_ID, NULL) == NULL) {
  		switch(index) {
  			case 2: return 0x1e8;
diff --git a/include/asm-sh/ide.h b/include/asm-sh/ide.h
--- a/include/asm-sh/ide.h
+++ b/include/asm-sh/ide.h
@@ -16,10 +16,6 @@

  #include <linux/config.h>

-#ifndef MAX_HWIFS
-#define MAX_HWIFS	CONFIG_IDE_MAX_HWIFS
-#endif
-
  #define ide_default_io_ctl(base)	(0)

  #include <asm-generic/ide_iops.h>
diff --git a/include/asm-sh64/ide.h b/include/asm-sh64/ide.h
--- a/include/asm-sh64/ide.h
+++ b/include/asm-sh64/ide.h
@@ -17,10 +17,6 @@

  #include <linux/config.h>

-#ifndef MAX_HWIFS
-#define MAX_HWIFS	CONFIG_IDE_MAX_HWIFS
-#endif
-
  /* Without this, the initialisation of PCI IDE cards end up calling
   * ide_init_hwif_ports, which won't work. */
  #ifdef CONFIG_BLK_DEV_IDEPCI
diff --git a/include/linux/ide.h b/include/linux/ide.h
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -230,6 +230,7 @@ typedef struct hw_regs_s {
  	int		dma;			/* our dma entry */
  	ide_ack_intr_t	*ack_intr;		/* acknowledge interrupt */
  	hwif_chipset_t  chipset;
+	struct device	*dev;
  } hw_regs_t;

  /*
@@ -266,6 +267,10 @@ static inline void ide_std_init_ports(hw

  #include <asm/ide.h>

+#ifndef MAX_HWIFS
+#define MAX_HWIFS	CONFIG_IDE_MAX_HWIFS
+#endif
+
  /* needed on alpha, x86/x86_64, ia64, mips, ppc32 and sh */
  #ifndef IDE_ARCH_OBSOLETE_DEFAULTS
  # define ide_default_io_base(index)	(0)
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -387,6 +387,7 @@
  #define PCI_DEVICE_ID_NS_SC1100_SMI	0x0511
  #define PCI_DEVICE_ID_NS_SC1100_XBUS	0x0515
  #define PCI_DEVICE_ID_NS_87410		0xd001
+#define PCI_DEVICE_ID_NS_CS5535_IDE	0x002d

  #define PCI_VENDOR_ID_TSENG		0x100c
  #define PCI_DEVICE_ID_TSENG_W32P_2	0x3202
@@ -487,6 +488,8 @@
  #define PCI_DEVICE_ID_AMD_8151_0	0x7454
  #define PCI_DEVICE_ID_AMD_8131_APIC     0x7450

+#define PCI_DEVICE_ID_AMD_CS5536_IDE	0x209A
+
  #define PCI_VENDOR_ID_TRIDENT		0x1023
  #define PCI_DEVICE_ID_TRIDENT_4DWAVE_DX	0x2000
  #define PCI_DEVICE_ID_TRIDENT_4DWAVE_NX	0x2001
