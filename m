Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263611AbUCUFJH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 00:09:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263609AbUCUFJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 00:09:06 -0500
Received: from [202.57.183.95] ([202.57.183.95]:40832 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S263608AbUCUFIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 00:08:22 -0500
Message-ID: <40583F40.5040402@opentle.org>
Date: Wed, 17 Mar 2004 19:06:24 +0700
From: Supphachoke Suntiwichaya <mrchoke@opentle.org>
Organization: NECTEC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031224
X-Accept-Language: th,en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: B.Zolnierkiewicz@elka.pw.edu.pl
Subject: [PATCH] ATI IXP IDE support 2.6.5-rc1 (modify)
Content-Type: multipart/mixed;
 boundary="------------090200000200080504010901"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090200000200080504010901
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I modified patch from 
http://www.kernel.org/pub/linux/kernel/people/bart/atiixp_ide/atiixp_ide-2.6.3-2.patch
for kernel 2.6.5-rc1. It work well for my box ASUS P4R800-VM.

MrChoke

-- 

Name : Supphachoke Suntiwichaya
Email : MrChoke at opentle.org
Distribution : LinuxTLE 5.5 (Samila)
OS : Linux 2.4.22-6_1.2174.nptl_01tle #1 Mon Mar 1 21:40:48 ICT 2004 i686 GNU/Linux
Uptime :  19:00:01  up 2 days,  9:23,  1 user,  load average: 2.26, 1.62, 1.28


--------------090200000200080504010901
Content-Type: text/plain;
 name="atiixp_ide-2.6.5rc1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="atiixp_ide-2.6.5rc1.patch"

diff -aurN linux-2.6.4.orig/drivers/ide/Kconfig linux-2.6.4/drivers/ide/Kconfig
--- linux-2.6.4.orig/drivers/ide/Kconfig	2004-03-17 18:47:25.000000000 +0700
+++ linux-2.6.4/drivers/ide/Kconfig	2004-03-17 18:50:41.000000000 +0700
@@ -559,6 +559,16 @@
 	  change PIO, DMA and UDMA speeds and to configure the chip to
 	  optimum performance.
 
+config BLK_DEV_ATIIXP
+	tristate "ATI IXP chipset IDE support"
+	depends on X86
+	help
+	  This driver adds explicit support for ATI IXP chipset.
+	  This allows the kernel to change PIO, DMA and UDMA speeds
+	  and to configure the chip to optimum performance.
+
+	  Say Y here if you have an ATI IXP chipset IDE controller.
+
 config BLK_DEV_CMD64X
 	tristate "CMD64{3|6|8|9} chipset support"
 	help
diff -aurN linux-2.6.4.orig/drivers/ide/pci/atiixp.c linux-2.6.4/drivers/ide/pci/atiixp.c
--- linux-2.6.4.orig/drivers/ide/pci/atiixp.c	1970-01-01 07:00:00.000000000 +0700
+++ linux-2.6.4/drivers/ide/pci/atiixp.c	2004-03-17 18:53:07.000000000 +0700
@@ -0,0 +1,512 @@
+/*
+ *  linux/drivers/ide/pci/atiixp.c	Version 0.01-bart2	Feb. 26, 2004
+ *
+ *  Copyright (C) 2003 ATI Inc. <hyu@ati.com>
+ *  Copyright (C) 2004 Bartlomiej Zolnierkiewicz
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/ioport.h>
+#include <linux/pci.h>
+#include <linux/hdreg.h>
+#include <linux/ide.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+
+#include <asm/io.h>
+
+#define ATIIXP_IDE_PIO_TIMING		0x40
+#define ATIIXP_IDE_MDMA_TIMING		0x44
+#define ATIIXP_IDE_PIO_CONTROL		0x48
+#define ATIIXP_IDE_PIO_MODE		0x4a
+#define ATIIXP_IDE_UDMA_CONTROL		0x54
+#define ATIIXP_IDE_UDMA_MODE		0x56
+
+typedef struct {
+	u8 command_width;
+	u8 recover_width;
+} atiixp_ide_timing;
+
+static atiixp_ide_timing pio_timing[] = {
+	{ 0x05, 0x0d },
+	{ 0x04, 0x07 },
+	{ 0x03, 0x04 },
+	{ 0x02, 0x02 },
+	{ 0x02, 0x00 },
+};
+
+static atiixp_ide_timing mdma_timing[] = {
+	{ 0x07, 0x07 },
+	{ 0x02, 0x01 },
+	{ 0x02, 0x00 },
+};
+
+static int save_mdma_mode[4];
+
+#define DISPLAY_ATIIXP_TIMINGS
+
+#if defined(DISPLAY_ATIIXP_TIMINGS) && defined(CONFIG_PROC_FS)
+
+#include <linux/stat.h>
+#include <linux/proc_fs.h>
+
+static u8 atiixp_proc;
+static struct pci_dev *bmide_dev;
+
+/**
+ *	atiixp_get_info		-	fill in /proc for ATIIXP IDE
+ *	@buffer: buffer to fill
+ *	@addr: address of user start in buffer
+ *	@offset: offset into 'file'
+ *	@count: buffer count
+ *
+ *	Output summary data on the tuning.
+ */
+
+static int atiixp_get_info(char *buffer, char **addr, off_t offset, int count)
+{
+	char *p = buffer;
+	struct pci_dev *dev = bmide_dev;
+	unsigned long bibma = pci_resource_start(dev, 4);
+	u32 mdma_timing = 0;
+	u16 udma_mode = 0, pio_mode = 0;
+	u8 c0, c1, udma_control = 0;
+
+	p += sprintf(p, "\n                          ATI ");
+	p += sprintf(p, "ATIIXP Ultra100 IDE Chipset.\n");
+
+	pci_read_config_byte(dev, ATIIXP_IDE_UDMA_CONTROL, &udma_control);
+	pci_read_config_word(dev, ATIIXP_IDE_UDMA_MODE, &udma_mode);
+	pci_read_config_word(dev, ATIIXP_IDE_PIO_MODE, &pio_mode);
+	pci_read_config_dword(dev, ATIIXP_IDE_MDMA_TIMING, &mdma_timing);
+
+	/*
+	 * at that point bibma+0x2 et bibma+0xa are byte registers
+	 * to investigate:
+	 */
+	c0 = inb(bibma + 0x02);
+	c1 = inb(bibma + 0x0a);
+
+	p += sprintf(p, "--------------- Primary Channel "
+			"---------------- Secondary Channel "
+			"-------------\n");
+	p += sprintf(p, "                %sabled "
+			"                        %sabled\n",
+			(c0 & 0x80) ? "dis" : " en",
+			(c1 & 0x80) ? "dis" : " en");
+	p += sprintf(p, "--------------- drive0 --------- drive1 "
+			"-------- drive0 ---------- drive1 ------\n");
+	p += sprintf(p, "DMA enabled:    %s              %s "
+			"            %s               %s\n",
+			(c0 & 0x20) ? "yes" : "no ",
+			(c0 & 0x40) ? "yes" : "no ",
+			(c1 & 0x20) ? "yes" : "no ",
+			(c1 & 0x40) ? "yes" : "no " );
+	p += sprintf(p, "UDMA enabled:   %s              %s "
+			"            %s               %s\n",
+			(udma_control & 0x01) ? "yes" : "no ",
+			(udma_control & 0x02) ? "yes" : "no ",
+			(udma_control & 0x04) ? "yes" : "no ",
+			(udma_control & 0x08) ? "yes" : "no " );
+	p += sprintf(p, "UDMA mode:      %c                %c "
+			"              %c                 %c\n",
+			(udma_control & 0x01) ?
+			((udma_mode & 0x07) + 48) : 'X',
+			(udma_control & 0x02) ?
+			(((udma_mode >> 4) & 0x07) + 48) : 'X',
+			(udma_control & 0x04) ?
+			(((udma_mode >> 8) & 0x07) + 48) : 'X',
+			(udma_control & 0x08) ?
+			(((udma_mode >> 12) & 0x07) + 48) : 'X');
+	p += sprintf(p, "MDMA mode:      %c                %c "
+			"              %c                 %c\n",
+			(save_mdma_mode[0] && (c0 & 0x20)) ?
+			((save_mdma_mode[0] & 0xf) + 48) : 'X',
+			(save_mdma_mode[1] && (c0 & 0x40)) ?
+			((save_mdma_mode[1] & 0xf) + 48) : 'X',
+			(save_mdma_mode[2] && (c1 & 0x20)) ?
+			((save_mdma_mode[2] & 0xf) + 48) : 'X',
+			(save_mdma_mode[3] && (c1 & 0x40)) ?
+			((save_mdma_mode[3] & 0xf) + 48) : 'X');
+	p += sprintf(p, "PIO mode:       %c                %c "
+			"              %c                 %c\n",
+			(c0 & 0x20) ? 'X' : ((pio_mode & 0x07) + 48),
+			(c0 & 0x40) ? 'X' : (((pio_mode >> 4) & 0x07) + 48),
+			(c1 & 0x20) ? 'X' : (((pio_mode >> 8) & 0x07) + 48),
+			(c1 & 0x40) ? 'X' : (((pio_mode >> 12) & 0x07) + 48));
+
+	return p - buffer;	/* => must be less than 4k! */
+}
+
+#endif  /* defined(DISPLAY_ATIIXP_TIMINGS) && defined(CONFIG_PROC_FS) */
+
+/**
+ *	atiixp_ratemask		-	compute rate mask for ATIIXP IDE
+ *	@drive: IDE drive to compute for
+ *
+ *	Returns the available modes for the ATIIXP IDE controller.
+ */
+
+static u8 atiixp_ratemask(ide_drive_t *drive)
+{
+	u8 mode = 3;
+
+	if (!eighty_ninty_three(drive))
+		mode = min(mode, (u8)1);
+	return mode;
+}
+
+/**
+ *	atiixp_dma_2_pio		-	return the PIO mode matching DMA
+ *	@xfer_rate: transfer speed
+ *
+ *	Returns the nearest equivalent PIO timing for the PIO or DMA
+ *	mode requested by the controller.
+ */
+
+static u8 atiixp_dma_2_pio(u8 xfer_rate) {
+	switch(xfer_rate) {
+		case XFER_UDMA_6:
+		case XFER_UDMA_5:
+		case XFER_UDMA_4:
+		case XFER_UDMA_3:
+		case XFER_UDMA_2:
+		case XFER_UDMA_1:
+		case XFER_UDMA_0:
+		case XFER_MW_DMA_2:
+		case XFER_PIO_4:
+			return 4;
+		case XFER_MW_DMA_1:
+		case XFER_PIO_3:
+			return 3;
+		case XFER_SW_DMA_2:
+		case XFER_PIO_2:
+			return 2;
+		case XFER_MW_DMA_0:
+		case XFER_SW_DMA_1:
+		case XFER_SW_DMA_0:
+		case XFER_PIO_1:
+		case XFER_PIO_0:
+		case XFER_PIO_SLOW:
+		default:
+			return 0;
+	}
+}
+
+static int atiixp_ide_dma_host_on(ide_drive_t *drive)
+{
+	struct pci_dev *dev = drive->hwif->pci_dev;
+	unsigned long flags;
+	u16 tmp16;
+
+	spin_lock_irqsave(&ide_lock, flags);
+
+	pci_read_config_word(dev, ATIIXP_IDE_UDMA_CONTROL, &tmp16);
+	if (save_mdma_mode[drive->dn])
+		tmp16 &= ~(1 << drive->dn);
+	else
+		tmp16 |= (1 << drive->dn);
+	pci_write_config_word(dev, ATIIXP_IDE_UDMA_CONTROL, tmp16);
+
+	spin_unlock_irqrestore(&ide_lock, flags);
+
+	return __ide_dma_host_on(drive);
+}
+
+static int atiixp_ide_dma_host_off(ide_drive_t *drive)
+{
+	struct pci_dev *dev = drive->hwif->pci_dev;
+	unsigned long flags;
+	u16 tmp16;
+
+	spin_lock_irqsave(&ide_lock, flags);
+
+	pci_read_config_word(dev, ATIIXP_IDE_UDMA_CONTROL, &tmp16);
+	tmp16 &= ~(1 << drive->dn);
+	pci_write_config_word(dev, ATIIXP_IDE_UDMA_CONTROL, tmp16);
+
+	spin_unlock_irqrestore(&ide_lock, flags);
+
+	return __ide_dma_host_off(drive);
+}
+
+/**
+ *	atiixp_tune_drive		-	tune a drive attached to a ATIIXP
+ *	@drive: drive to tune
+ *	@pio: desired PIO mode
+ *
+ *	Set the interface PIO mode.
+ */
+
+static void atiixp_tuneproc(ide_drive_t *drive, u8 pio)
+{
+	struct pci_dev *dev = drive->hwif->pci_dev;
+	unsigned long flags;
+	int timing_shift = (drive->dn & 2) ? 16 : 0 + (drive->dn & 1) ? 0 : 8;
+	u32 pio_timing_data;
+	u16 pio_mode_data;
+
+	spin_lock_irqsave(&ide_lock, flags);
+
+	pci_read_config_word(dev, ATIIXP_IDE_PIO_MODE, &pio_mode_data);
+	pio_mode_data &= ~(0x07 << (drive->dn * 4));
+	pio_mode_data |= (pio << (drive->dn * 4));
+	pci_write_config_word(dev, ATIIXP_IDE_PIO_MODE, pio_mode_data);
+
+	pci_read_config_dword(dev, ATIIXP_IDE_PIO_TIMING, &pio_timing_data);
+	pio_timing_data &= ~(0xff << timing_shift);
+	pio_timing_data |= (pio_timing[pio].recover_width << timing_shift) |
+		 (pio_timing[pio].command_width << (timing_shift + 4));
+	pci_write_config_dword(dev, ATIIXP_IDE_PIO_TIMING, pio_timing_data);
+
+	spin_unlock_irqrestore(&ide_lock, flags);
+}
+
+/**
+ *	atiixp_tune_chipset	-	tune a ATIIXP interface
+ *	@drive: IDE drive to tune
+ *	@xferspeed: speed to configure
+ *
+ *	Set a ATIIXP interface channel to the desired speeds. This involves
+ *	requires the right timing data into the ATIIXP configuration space
+ *	then setting the drive parameters appropriately
+ */
+
+static int atiixp_speedproc(ide_drive_t *drive, u8 xferspeed)
+{
+	struct pci_dev *dev = drive->hwif->pci_dev;
+	unsigned long flags;
+	int timing_shift = (drive->dn & 2) ? 16 : 0 + (drive->dn & 1) ? 0 : 8;
+	u32 tmp32;
+	u16 tmp16;
+	u8 speed, pio;
+
+	speed = ide_rate_filter(atiixp_ratemask(drive), xferspeed);
+
+	spin_lock_irqsave(&ide_lock, flags);
+
+	save_mdma_mode[drive->dn] = 0;
+	if (speed >= XFER_UDMA_0) {
+		pci_read_config_word(dev, ATIIXP_IDE_UDMA_MODE, &tmp16);
+		tmp16 &= ~(0x07 << (drive->dn * 4));
+		tmp16 |= ((speed & 0x07) << (drive->dn * 4));
+		pci_write_config_word(dev, ATIIXP_IDE_UDMA_MODE, tmp16);
+	} else {
+		if ((speed >= XFER_MW_DMA_0) && (speed <= XFER_MW_DMA_2)) {
+			save_mdma_mode[drive->dn] = speed;
+			pci_read_config_dword(dev, ATIIXP_IDE_MDMA_TIMING, &tmp32);
+			tmp32 &= ~(0xff << timing_shift);
+			tmp32 |= (mdma_timing[speed & 0x03].recover_width << timing_shift) |
+				(mdma_timing[speed & 0x03].command_width << (timing_shift + 4));
+			pci_write_config_dword(dev, ATIIXP_IDE_MDMA_TIMING, tmp32);
+		}
+	}
+
+	spin_unlock_irqrestore(&ide_lock, flags);
+
+	if (speed >= XFER_SW_DMA_0)
+		pio = atiixp_dma_2_pio(speed);
+	else
+		pio = speed - XFER_PIO_0;
+
+	atiixp_tuneproc(drive, pio);
+
+	return ide_config_drive_speed(drive, speed);
+}
+
+/**
+ *	atiixp_config_drive_for_dma	-	configure drive for DMA
+ *	@drive: IDE drive to configure
+ *
+ *	Set up a ATIIXP interface channel for the best available speed.
+ *	We prefer UDMA if it is available and then MWDMA. If DMA is
+ *	not available we switch to PIO and return 0.
+ */
+
+static int atiixp_config_drive_for_dma(ide_drive_t *drive)
+{
+	u8 speed = ide_dma_speed(drive, atiixp_ratemask(drive));
+
+	/* If no DMA speed was available then disable DMA and use PIO. */
+	if (!speed) {
+		u8 tspeed = ide_get_best_pio_mode(drive, 255, 5, NULL);
+		speed = atiixp_dma_2_pio(XFER_PIO_0 + tspeed) + XFER_PIO_0;
+	}
+
+	(void) atiixp_speedproc(drive, speed);
+	return ide_dma_enable(drive);
+}
+
+/**
+ *	atiixp_dma_check	-	set up an IDE device
+ *	@drive: IDE drive to configure
+ *
+ *	Set up the ATIIXP interface for the best available speed on this
+ *	interface, preferring DMA to PIO.
+ */
+
+static int atiixp_dma_check(ide_drive_t *drive)
+{
+	ide_hwif_t *hwif	= HWIF(drive);
+	struct hd_driveid *id	= drive->id;
+	u8 tspeed, speed;
+
+	drive->init_speed = 0;
+
+	if ((id->capability & 1) && drive->autodma) {
+		/* Consult the list of known "bad" drives */
+		if (__ide_dma_bad_drive(drive))
+			goto fast_ata_pio;
+		if (id->field_valid & 4) {
+			if (id->dma_ultra & hwif->ultra_mask) {
+				/* Force if Capable UltraDMA */
+				if ((id->field_valid & 2) &&
+				    (!atiixp_config_drive_for_dma(drive)))
+					goto try_dma_modes;
+			}
+		} else if (id->field_valid & 2) {
+try_dma_modes:
+			if ((id->dma_mword & hwif->mwdma_mask) ||
+			    (id->dma_1word & hwif->swdma_mask)) {
+				/* Force if Capable regular DMA modes */
+				if (!atiixp_config_drive_for_dma(drive))
+					goto no_dma_set;
+			}
+		} else if (__ide_dma_good_drive(drive) &&
+			   (id->eide_dma_time < 150)) {
+			/* Consult the list of known "good" drives */
+			if (!atiixp_config_drive_for_dma(drive))
+				goto no_dma_set;
+		} else {
+			goto fast_ata_pio;
+		}
+		return hwif->ide_dma_on(drive);
+	} else if ((id->capability & 8) || (id->field_valid & 2)) {
+fast_ata_pio:
+no_dma_set:
+		tspeed = ide_get_best_pio_mode(drive, 255, 5, NULL);
+		speed = atiixp_dma_2_pio(XFER_PIO_0 + tspeed) + XFER_PIO_0;
+		hwif->speedproc(drive, speed);
+		return hwif->ide_dma_off_quietly(drive);
+	}
+	/* IORDY not supported */
+	return 0;
+}
+
+/**
+ *	init_chipset_atiixp	-	set up the ATIIXP chipset
+ *	@dev: PCI device to set up
+ *	@name: Name of the device
+ *
+ *	Initialize the PCI device as required. For the ATIIXP this turns
+ *	out to be nice and simple
+ */
+
+static unsigned int __devinit init_chipset_atiixp(struct pci_dev *dev, const char *name)
+{
+#if defined(DISPLAY_ATIIXP_TIMINGS) && defined(CONFIG_PROC_FS)
+	if (!atiixp_proc) {
+		atiixp_proc = 1;
+		bmide_dev = dev;
+		ide_pci_create_host_proc("atiixp", atiixp_get_info);
+	}
+#endif /* DISPLAY_ATIIXP_TIMINGS && CONFIG_PROC_FS */
+	return 0;
+}
+
+/**
+ *	init_hwif_atiixp		-	fill in the hwif for the ATIIXP
+ *	@hwif: IDE interface
+ *
+ *	Set up the ide_hwif_t for the ATIIXP interface according to the
+ *	capabilities of the hardware.
+ */
+
+static void __devinit init_hwif_atiixp(ide_hwif_t *hwif)
+{
+	if (!hwif->irq)
+		hwif->irq = hwif->channel ? 15 : 14;
+
+	hwif->autodma = 0;
+	hwif->tuneproc = &atiixp_tuneproc;
+	hwif->speedproc = &atiixp_speedproc;
+	hwif->drives[0].autotune = 1;
+	hwif->drives[1].autotune = 1;
+
+	if (!hwif->dma_base)
+		return;
+
+	hwif->atapi_dma = 1;
+	hwif->ultra_mask = 0x3f;
+	hwif->mwdma_mask = 0x06;
+	hwif->swdma_mask = 0x04;
+
+	hwif->udma_four = 1;
+	hwif->ide_dma_host_on = &atiixp_ide_dma_host_on;
+	hwif->ide_dma_host_off = &atiixp_ide_dma_host_off;
+	hwif->ide_dma_check = &atiixp_dma_check;
+	if (!noautodma)
+		hwif->autodma = 1;
+
+	hwif->drives[1].autodma = hwif->autodma;
+	hwif->drives[0].autodma = hwif->autodma;
+}
+
+static ide_pci_device_t atiixp_pci_info[] __devinitdata = {
+	{	/* 0 */
+		.vendor		= PCI_VENDOR_ID_ATI,
+		.device		= PCI_DEVICE_ID_ATI_IXP_IDE,
+		.name		= "ATIIXP",
+		.init_chipset	= init_chipset_atiixp,
+		.init_hwif	= init_hwif_atiixp,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x48,0x01,0x00}, {0x48,0x08,0x00}},
+		.bootable	= ON_BOARD,
+	}
+};
+
+/**
+ *	atiixp_init_one	-	called when a ATIIXP is found
+ *	@dev: the atiixp device
+ *	@id: the matching pci id
+ *
+ *	Called when the PCI registration layer (or the IDE initialization)
+ *	finds a device matching our IDE device tables.
+ */
+
+static int __devinit atiixp_init_one(struct pci_dev *dev, const struct pci_device_id *id)
+{
+	ide_pci_device_t *d = &atiixp_pci_info[id->driver_data];
+
+	if (dev->device != d->device)
+		BUG();
+	ide_setup_pci_device(dev, d);
+	return 0;
+}
+
+static struct pci_device_id atiixp_pci_tbl[] = {
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP_IDE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{ 0, },
+};
+
+static struct pci_driver driver = {
+	.name		= "ATIIXP IDE",
+	.id_table	= atiixp_pci_tbl,
+	.probe		= atiixp_init_one,
+};
+
+static int atiixp_ide_init(void)
+{
+	return ide_pci_register_driver(&driver);
+}
+
+module_init(atiixp_ide_init);
+
+MODULE_AUTHOR("HUI YU");
+MODULE_DESCRIPTION("PCI driver module for ATI IXP IDE");
+MODULE_LICENSE("GPL");
diff -aurN linux-2.6.4.orig/drivers/ide/pci/Makefile linux-2.6.4/drivers/ide/pci/Makefile
--- linux-2.6.4.orig/drivers/ide/pci/Makefile	2004-03-17 18:47:25.000000000 +0700
+++ linux-2.6.4/drivers/ide/pci/Makefile	2004-03-17 18:50:41.000000000 +0700
@@ -3,6 +3,7 @@
 obj-$(CONFIG_BLK_DEV_AEC62XX)		+= aec62xx.o
 obj-$(CONFIG_BLK_DEV_ALI15X3)		+= alim15x3.o
 obj-$(CONFIG_BLK_DEV_AMD74XX)		+= amd74xx.o
+obj-$(CONFIG_BLK_DEV_ATIIXP)		+= atiixp.o
 obj-$(CONFIG_BLK_DEV_CMD64X)		+= cmd64x.o
 obj-$(CONFIG_BLK_DEV_CS5520)		+= cs5520.o
 obj-$(CONFIG_BLK_DEV_CS5530)		+= cs5530.o
diff -aurN linux-2.6.4.orig/include/linux/pci_ids.h linux-2.6.4/include/linux/pci_ids.h
--- linux-2.6.4.orig/include/linux/pci_ids.h	2004-03-17 18:47:35.000000000 +0700
+++ linux-2.6.4/include/linux/pci_ids.h	2004-03-17 18:50:41.000000000 +0700
@@ -342,6 +342,8 @@
 #define PCI_DEVICE_ID_ATI_RS300_133	0x5831
 #define PCI_DEVICE_ID_ATI_RS300_166	0x5832
 #define PCI_DEVICE_ID_ATI_RS300_200	0x5833
+/* ATI IXP Chipset */
+#define PCI_DEVICE_ID_ATI_IXP_IDE	0x4349
 
 #define PCI_VENDOR_ID_VLSI		0x1004
 #define PCI_DEVICE_ID_VLSI_82C592	0x0005

--------------090200000200080504010901--

