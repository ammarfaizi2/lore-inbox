Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129357AbRBOWEf>; Thu, 15 Feb 2001 17:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129492AbRBOWE2>; Thu, 15 Feb 2001 17:04:28 -0500
Received: from alto.i-cable.com ([210.80.60.4]:15568 "EHLO alto.i-cable.com")
	by vger.kernel.org with ESMTP id <S129357AbRBOWER>;
	Thu, 15 Feb 2001 17:04:17 -0500
Message-ID: <3A8C527B.8318B8D4@hkicable.com>
Date: Fri, 16 Feb 2001 06:04:44 +0800
From: Thomas Lau <lkthomas@hkicable.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-ac13 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ATA100 patch source code:
Content-Type: multipart/mixed;
 boundary="------------0D1CB87D07F9C4AA61580BB8"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------0D1CB87D07F9C4AA61580BB8
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

it's final version, but why it's not work ?

--------------0D1CB87D07F9C4AA61580BB8
Content-Type: text/plain; charset=us-ascii;
 name="ide.2.4.1-p8.01172001.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide.2.4.1-p8.01172001.patch"

diff -urN linux-2.4.1-p8-pristine/Documentation/Configure.help linux-2.4.1-p8/Documentation/Configure.help
--- linux-2.4.1-p8-pristine/Documentation/Configure.help	Thu Jan 18 01:20:48 2001
+++ linux-2.4.1-p8/Documentation/Configure.help	Thu Jan 18 02:42:37 2001
@@ -673,6 +673,25 @@
 
   If in doubt, say N.
 
+PnP BIOS DMA Forced Enabled
+CONFIG_BLK_DEV_IDEDMA_FORCED
+  If you say Y here, and your DMA original Triton I/II, VIA, ALI
+  fail to setup the DMA address space and it used to work in 2.0.34
+  with the Jumbo Patch series or works in 2.0.39, then you should
+  consider enabling this option.
+
+  If in doubt, say N.
+
+Attempt to HACK around Chipsets that TIMEOUT (EXPERIMENTAL)
+CONFIG_BLK_DEV_IDEDMA_TIMEOUT
+  If you say Y here, this is a NASTY UGLY HACK!
+
+  We have to issue an abort and requeue the request DMA engine got
+  turned off by a goofy ASIC, and we have to clean up the mess, and
+  here is as good as any.  Do it globally for all chipsets.
+
+  If in doubt, say N.
+
 Boot off-board chipsets first support
 CONFIG_BLK_DEV_OFFBOARD
   Normally, IDE controllers built into the motherboard (on-board
@@ -780,18 +799,18 @@
 
   SAY NO!
 
-AMD7409 chipset support
-CONFIG_BLK_DEV_AMD7409
-  This driver ensures (U)DMA support for the AMD756 Viper chipset.
+AMD74XX chipset support
+CONFIG_BLK_DEV_AMD74XX
+  This driver ensures (U)DMA support for the AMD756/765 Viper chipset.
 
   If you say Y here, you also need to say Y to "Use DMA by default
   when available", above.
-  Please read the comments at the top of drivers/ide/amd7409.c
+  Please read the comments at the top of drivers/ide/amd74xx.c
 
   If unsure, say N.
 
 AMD Viper ATA-66 Override support (WIP)
-CONFIG_AMD7409_OVERRIDE
+CONFIG_AMD74XX_OVERRIDE
   This option auto-forces the ata66 flag.
   This effect can be also invoked by calling "idex=ata66"
   If unsure, say N.
diff -urN linux-2.4.1-p8-pristine/drivers/ide/Config.in linux-2.4.1-p8/drivers/ide/Config.in
--- linux-2.4.1-p8-pristine/drivers/ide/Config.in	Fri Dec 29 14:07:22 2000
+++ linux-2.4.1-p8/drivers/ide/Config.in	Thu Jan 18 02:42:37 2001
@@ -45,15 +45,18 @@
 	    bool '    Generic PCI bus-master DMA support' CONFIG_BLK_DEV_IDEDMA_PCI
 	    bool '    Boot off-board chipsets first support' CONFIG_BLK_DEV_OFFBOARD
 	    dep_bool '      Use PCI DMA by default when available' CONFIG_IDEDMA_PCI_AUTO $CONFIG_BLK_DEV_IDEDMA_PCI
+	    dep_bool '      PnP BIOS DMA Forced Enabled' CONFIG_BLK_DEV_IDEDMA_FORCED $CONFIG_BLK_DEV_IDEDMA_PCI
 	    define_bool CONFIG_BLK_DEV_IDEDMA $CONFIG_BLK_DEV_IDEDMA_PCI
 	    dep_bool '      ATA Work(s) In Progress (EXPERIMENTAL)' CONFIG_IDEDMA_PCI_WIP $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_EXPERIMENTAL
 	    dep_bool '      Good-Bad DMA Model-Firmware (WIP)' CONFIG_IDEDMA_NEW_DRIVE_LISTINGS $CONFIG_IDEDMA_PCI_WIP
+	    dep_bool '      Attempt to HACK around Chipsets that TIMEOUT (WIP)' CONFIG_BLK_DEV_IDEDMA_TIMEOUT $CONFIG_IDEDMA_PCI_WIP
+
 	    dep_bool '    AEC62XX chipset support' CONFIG_BLK_DEV_AEC62XX $CONFIG_BLK_DEV_IDEDMA_PCI
 	    dep_mbool '      AEC62XX Tuning support' CONFIG_AEC62XX_TUNING $CONFIG_BLK_DEV_AEC62XX
 	    dep_bool '    ALI M15x3 chipset support' CONFIG_BLK_DEV_ALI15X3 $CONFIG_BLK_DEV_IDEDMA_PCI
 	    dep_mbool '      ALI M15x3 WDC support (DANGEROUS)' CONFIG_WDC_ALI15X3 $CONFIG_BLK_DEV_ALI15X3
-	    dep_bool '    AMD Viper support' CONFIG_BLK_DEV_AMD7409 $CONFIG_BLK_DEV_IDEDMA_PCI
-	    dep_mbool '      AMD Viper ATA-66 Override (WIP)' CONFIG_AMD7409_OVERRIDE $CONFIG_BLK_DEV_AMD7409 $CONFIG_IDEDMA_PCI_WIP
+	    dep_bool '    AMD Viper support' CONFIG_BLK_DEV_AMD74XX $CONFIG_BLK_DEV_IDEDMA_PCI
+	    dep_mbool '      AMD Viper ATA-66 Override (WIP)' CONFIG_AMD74XX_OVERRIDE $CONFIG_BLK_DEV_AMD74XX $CONFIG_IDEDMA_PCI_WIP
 	    dep_bool '    CMD64X chipset support' CONFIG_BLK_DEV_CMD64X $CONFIG_BLK_DEV_IDEDMA_PCI
 	    dep_bool '    CY82C693 chipset support' CONFIG_BLK_DEV_CY82C693 $CONFIG_BLK_DEV_IDEDMA_PCI
 	    dep_bool '    Cyrix CS5530 MediaGX chipset support' CONFIG_BLK_DEV_CS5530 $CONFIG_BLK_DEV_IDEDMA_PCI
@@ -147,7 +150,7 @@
 if [ "$CONFIG_IDE_CHIPSETS" = "y" -o \
      "$CONFIG_BLK_DEV_AEC62XX" = "y" -o \
      "$CONFIG_BLK_DEV_ALI15X3" = "y" -o \
-     "$CONFIG_BLK_DEV_AMD7409" = "y" -o \
+     "$CONFIG_BLK_DEV_AMD74XX" = "y" -o \
      "$CONFIG_BLK_DEV_CMD640" = "y" -o \
      "$CONFIG_BLK_DEV_CMD64X" = "y" -o \
      "$CONFIG_BLK_DEV_CS5530" = "y" -o \
diff -urN linux-2.4.1-p8-pristine/drivers/ide/Makefile linux-2.4.1-p8/drivers/ide/Makefile
--- linux-2.4.1-p8-pristine/drivers/ide/Makefile	Fri Dec 29 14:07:22 2000
+++ linux-2.4.1-p8/drivers/ide/Makefile	Thu Jan 18 02:42:37 2001
@@ -28,7 +28,7 @@
 ide-obj-$(CONFIG_BLK_DEV_AEC62XX)	+= aec62xx.o
 ide-obj-$(CONFIG_BLK_DEV_ALI14XX)	+= ali14xx.o
 ide-obj-$(CONFIG_BLK_DEV_ALI15X3)	+= alim15x3.o
-ide-obj-$(CONFIG_BLK_DEV_AMD7409)	+= amd7409.o
+ide-obj-$(CONFIG_BLK_DEV_AMD74XX)	+= amd74xx.o
 ide-obj-$(CONFIG_BLK_DEV_BUDDHA)	+= buddha.o
 ide-obj-$(CONFIG_BLK_DEV_CMD640)	+= cmd640.o
 ide-obj-$(CONFIG_BLK_DEV_CMD64X)	+= cmd64x.o
diff -urN linux-2.4.1-p8-pristine/drivers/ide/amd7409.c linux-2.4.1-p8/drivers/ide/amd7409.c
--- linux-2.4.1-p8-pristine/drivers/ide/amd7409.c	Tue Nov  7 11:02:24 2000
+++ linux-2.4.1-p8/drivers/ide/amd7409.c	Wed Dec 31 16:00:00 1969
@@ -1,470 +0,0 @@
-/*
- * linux/drivers/ide/amd7409.c		Version 0.05	June 9, 2000
- *
- * Copyright (C) 1999-2000		Andre Hedrick <andre@linux-ide.org>
- * May be copied or modified under the terms of the GNU General Public License
- *
- */
-
-#include <linux/config.h>
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/delay.h>
-#include <linux/timer.h>
-#include <linux/mm.h>
-#include <linux/ioport.h>
-#include <linux/blkdev.h>
-#include <linux/hdreg.h>
-
-#include <linux/interrupt.h>
-#include <linux/init.h>
-#include <linux/pci.h>
-#include <linux/ide.h>
-
-#include <asm/io.h>
-#include <asm/irq.h>
-
-#include "ide_modes.h"
-
-#define DISPLAY_VIPER_TIMINGS
-
-#if defined(DISPLAY_VIPER_TIMINGS) && defined(CONFIG_PROC_FS)
-#include <linux/stat.h>
-#include <linux/proc_fs.h>
-
-static int amd7409_get_info(char *, char **, off_t, int);
-extern int (*amd7409_display_info)(char *, char **, off_t, int); /* ide-proc.c */
-extern char *ide_media_verbose(ide_drive_t *);
-static struct pci_dev *bmide_dev;
-
-static int amd7409_get_info (char *buffer, char **addr, off_t offset, int count)
-{
-	char *p = buffer;
-	u32 bibma = pci_resource_start(bmide_dev, 4);
-	u8 c0 = 0, c1 = 0;
-
-	/*
-	 * at that point bibma+0x2 et bibma+0xa are byte registers
-	 * to investigate:
-	 */
-	c0 = inb_p((unsigned short)bibma + 0x02);
-	c1 = inb_p((unsigned short)bibma + 0x0a);
-
-	p += sprintf(p, "\n                                AMD 7409 VIPER Chipset.\n");
-	p += sprintf(p, "--------------- Primary Channel ---------------- Secondary Channel -------------\n");
-	p += sprintf(p, "                %sabled                         %sabled\n",
-			(c0&0x80) ? "dis" : " en",
-			(c1&0x80) ? "dis" : " en");
-	p += sprintf(p, "--------------- drive0 --------- drive1 -------- drive0 ---------- drive1 ------\n");
-	p += sprintf(p, "DMA enabled:    %s              %s             %s               %s\n",
-			(c0&0x20) ? "yes" : "no ", (c0&0x40) ? "yes" : "no ",
-			(c1&0x20) ? "yes" : "no ", (c1&0x40) ? "yes" : "no " );
-	p += sprintf(p, "UDMA\n");
-	p += sprintf(p, "DMA\n");
-	p += sprintf(p, "PIO\n");
-
-	return p-buffer;	/* => must be less than 4k! */
-}
-#endif  /* defined(DISPLAY_VIPER_TIMINGS) && defined(CONFIG_PROC_FS) */
-
-byte amd7409_proc = 0;
-
-extern char *ide_xfer_verbose (byte xfer_rate);
-
-static unsigned int amd7409_swdma_check (struct pci_dev *dev)
-{
-	unsigned int class_rev;
-	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
-	class_rev &= 0xff;
-	return ((int) (class_rev >= 7) ? 1 : 0);
-}
-
-static int amd7409_swdma_error(ide_drive_t *drive)
-{
-	printk("%s: single-word DMA not support (revision < C4)\n", drive->name);
-	return 0;
-}
-
-/*
- * Here is where all the hard work goes to program the chipset.
- *
- */
-static int amd7409_tune_chipset (ide_drive_t *drive, byte speed)
-{
-	ide_hwif_t *hwif	= HWIF(drive);
-	struct pci_dev *dev	= hwif->pci_dev;
-	int err			= 0;
-	byte unit		= (drive->select.b.unit & 0x01);
-#ifdef CONFIG_BLK_DEV_IDEDMA
-	unsigned long dma_base	= hwif->dma_base;
-#endif /* CONFIG_BLK_DEV_IDEDMA */
-	byte drive_pci		= 0x00;
-	byte drive_pci2		= 0x00;
-	byte ultra_timing	= 0x00;
-	byte dma_pio_timing	= 0x00;
-	byte pio_timing		= 0x00;
-
-        switch (drive->dn) {
-		case 0: drive_pci = 0x53; drive_pci2 = 0x4b; break;
-		case 1: drive_pci = 0x52; drive_pci2 = 0x4a; break;
-		case 2: drive_pci = 0x51; drive_pci2 = 0x49; break;
-		case 3: drive_pci = 0x50; drive_pci2 = 0x48; break;
-		default:
-                        return -1;
-        }
-
-	pci_read_config_byte(dev, drive_pci, &ultra_timing);
-	pci_read_config_byte(dev, drive_pci2, &dma_pio_timing);
-	pci_read_config_byte(dev, 0x4c, &pio_timing);
-
-#ifdef DEBUG
-	printk("%s: UDMA 0x%02x DMAPIO 0x%02x PIO 0x%02x ",
-		drive->name, ultra_timing, dma_pio_timing, pio_timing);
-#endif
-
-	ultra_timing &= ~0xC7;
-	dma_pio_timing &= ~0xFF;
-	pio_timing &= ~(0x03 << drive->dn);
-
-#ifdef DEBUG
-	printk(":: UDMA 0x%02x DMAPIO 0x%02x PIO 0x%02x ",
-		ultra_timing, dma_pio_timing, pio_timing);
-#endif
-
-	switch(speed) {
-#ifdef CONFIG_BLK_DEV_IDEDMA
-		case XFER_UDMA_4:
-			ultra_timing |= 0x45;
-			dma_pio_timing |= 0x20;
-			break;
-		case XFER_UDMA_3:
-			ultra_timing |= 0x44;
-			dma_pio_timing |= 0x20;
-			break;
-		case XFER_UDMA_2:
-			ultra_timing |= 0x40;
-			dma_pio_timing |= 0x20;
-			break;
-		case XFER_UDMA_1:
-			ultra_timing |= 0x41;
-			dma_pio_timing |= 0x20;
-			break;
-		case XFER_UDMA_0:
-			ultra_timing |= 0x42;
-			dma_pio_timing |= 0x20;
-			break;
-		case XFER_MW_DMA_2:
-			dma_pio_timing |= 0x20;
-			break;
-		case XFER_MW_DMA_1:
-			dma_pio_timing |= 0x21;
-			break;
-		case XFER_MW_DMA_0:
-			dma_pio_timing |= 0x77;
-			break;
-		case XFER_SW_DMA_2:
-			if (!amd7409_swdma_check(dev))
-				return amd7409_swdma_error(drive);
-			dma_pio_timing |= 0x42;
-			break;
-		case XFER_SW_DMA_1:
-			if (!amd7409_swdma_check(dev))
-				return amd7409_swdma_error(drive);
-			dma_pio_timing |= 0x65;
-			break;
-		case XFER_SW_DMA_0:
-			if (!amd7409_swdma_check(dev))
-				return amd7409_swdma_error(drive);
-			dma_pio_timing |= 0xA8;
-			break;
-#endif /* CONFIG_BLK_DEV_IDEDMA */
-		case XFER_PIO_4:
-			dma_pio_timing |= 0x20;
-			break;
-		case XFER_PIO_3:
-			dma_pio_timing |= 0x22;
-			break;
-		case XFER_PIO_2:
-			dma_pio_timing |= 0x42;
-			break;
-		case XFER_PIO_1:
-			dma_pio_timing |= 0x65;
-			break;
-		case XFER_PIO_0:
-		default:
-			dma_pio_timing |= 0xA8;
-			break;
-        }
-
-	pio_timing |= (0x03 << drive->dn);
-
-	if (!drive->init_speed)
-		drive->init_speed = speed;
-
-#ifdef CONFIG_BLK_DEV_IDEDMA
-	pci_write_config_byte(dev, drive_pci, ultra_timing);
-#endif /* CONFIG_BLK_DEV_IDEDMA */
-	pci_write_config_byte(dev, drive_pci2, dma_pio_timing);
-	pci_write_config_byte(dev, 0x4c, pio_timing);
-
-#ifdef DEBUG
-	printk(":: UDMA 0x%02x DMAPIO 0x%02x PIO 0x%02x\n",
-		ultra_timing, dma_pio_timing, pio_timing);
-#endif
-
-#ifdef CONFIG_BLK_DEV_IDEDMA
-	if (speed > XFER_PIO_4) {
-		outb(inb(dma_base+2)|(1<<(5+unit)), dma_base+2);
-	} else {
-		outb(inb(dma_base+2) & ~(1<<(5+unit)), dma_base+2);
-	}
-#endif /* CONFIG_BLK_DEV_IDEDMA */
-
-	err = ide_config_drive_speed(drive, speed);
-	drive->current_speed = speed;
-	return (err);
-}
-
-static void config_chipset_for_pio (ide_drive_t *drive)
-{
-	unsigned short eide_pio_timing[6] = {960, 480, 240, 180, 120, 90};
-	unsigned short xfer_pio	= drive->id->eide_pio_modes;
-	byte			timing, speed, pio;
-
-	pio = ide_get_best_pio_mode(drive, 255, 5, NULL);
-
-	if (xfer_pio> 4)
-		xfer_pio = 0;
-
-	if (drive->id->eide_pio_iordy > 0) {
-		for (xfer_pio = 5;
-			xfer_pio>0 &&
-			drive->id->eide_pio_iordy>eide_pio_timing[xfer_pio];
-			xfer_pio--);
-	} else {
-		xfer_pio = (drive->id->eide_pio_modes & 4) ? 0x05 :
-			   (drive->id->eide_pio_modes & 2) ? 0x04 :
-			   (drive->id->eide_pio_modes & 1) ? 0x03 :
-			   (drive->id->tPIO & 2) ? 0x02 :
-			   (drive->id->tPIO & 1) ? 0x01 : xfer_pio;
-	}
-
-	timing = (xfer_pio >= pio) ? xfer_pio : pio;
-
-	switch(timing) {
-		case 4: speed = XFER_PIO_4;break;
-		case 3: speed = XFER_PIO_3;break;
-		case 2: speed = XFER_PIO_2;break;
-		case 1: speed = XFER_PIO_1;break;
-		default:
-			speed = (!drive->id->tPIO) ? XFER_PIO_0 : XFER_PIO_SLOW;
-			break;
-	}
-	(void) amd7409_tune_chipset(drive, speed);
-	drive->current_speed = speed;
-}
-
-static void amd7409_tune_drive (ide_drive_t *drive, byte pio)
-{
-	byte speed;
-	switch(pio) {
-		case 4:		speed = XFER_PIO_4;break;
-		case 3:		speed = XFER_PIO_3;break;
-		case 2:		speed = XFER_PIO_2;break;
-		case 1:		speed = XFER_PIO_1;break;
-		default:	speed = XFER_PIO_0;break;
-	}
-	(void) amd7409_tune_chipset(drive, speed);
-}
-
-#ifdef CONFIG_BLK_DEV_IDEDMA
-/*
- * This allows the configuration of ide_pci chipset registers
- * for cards that learn about the drive's UDMA, DMA, PIO capabilities
- * after the drive is reported by the OS.
- */
-static int config_chipset_for_dma (ide_drive_t *drive)
-{
-	struct hd_driveid *id	= drive->id;
-	byte udma_66		= eighty_ninty_three(drive);
-	byte udma_100		= 0;
-	byte speed		= 0x00;
-	int  rval;
-
-	if ((id->dma_ultra & 0x0020) && (udma_66)&& (udma_100)) {
-		speed = XFER_UDMA_5;
-	} else if ((id->dma_ultra & 0x0010) && (udma_66)) {
-		speed = XFER_UDMA_4;
-	} else if ((id->dma_ultra & 0x0008) && (udma_66)) {
-		speed = XFER_UDMA_3;
-	} else if (id->dma_ultra & 0x0004) {
-		speed = XFER_UDMA_2;
-	} else if (id->dma_ultra & 0x0002) {
-		speed = XFER_UDMA_1;
-	} else if (id->dma_ultra & 0x0001) {
-		speed = XFER_UDMA_0;
-	} else if (id->dma_mword & 0x0004) {
-		speed = XFER_MW_DMA_2;
-	} else if (id->dma_mword & 0x0002) {
-		speed = XFER_MW_DMA_1;
-	} else if (id->dma_mword & 0x0001) {
-		speed = XFER_MW_DMA_0;
-	} else {
-		return ((int) ide_dma_off_quietly);
-	}
-
-	(void) amd7409_tune_chipset(drive, speed);
-
-	rval = (int)(	((id->dma_ultra >> 11) & 3) ? ide_dma_on :
-			((id->dma_ultra >> 8) & 7) ? ide_dma_on :
-			((id->dma_mword >> 8) & 7) ? ide_dma_on :
-						     ide_dma_off_quietly);
-
-	return rval;
-}
-
-
-
-static int config_drive_xfer_rate (ide_drive_t *drive)
-{
-	struct hd_driveid *id = drive->id;
-	ide_dma_action_t dma_func = ide_dma_on;
-
-	if (id && (id->capability & 1) && HWIF(drive)->autodma) {
-		/* Consult the list of known "bad" drives */
-		if (ide_dmaproc(ide_dma_bad_drive, drive)) {
-			dma_func = ide_dma_off;
-			goto fast_ata_pio;
-		}
-		dma_func = ide_dma_off_quietly;
-		if (id->field_valid & 4) {
-			if (id->dma_ultra & 0x002F) {
-				/* Force if Capable UltraDMA */
-				dma_func = config_chipset_for_dma(drive);
-				if ((id->field_valid & 2) &&
-				    (dma_func != ide_dma_on))
-					goto try_dma_modes;
-			}
-		} else if (id->field_valid & 2) {
-try_dma_modes:
-			if ((id->dma_mword & 0x0007) ||
-			    ((id->dma_1word & 0x007) &&
-			     (amd7409_swdma_check(HWIF(drive)->pci_dev)))) {
-				/* Force if Capable regular DMA modes */
-				dma_func = config_chipset_for_dma(drive);
-				if (dma_func != ide_dma_on)
-					goto no_dma_set;
-			}
-			
-		} else if (ide_dmaproc(ide_dma_good_drive, drive)) {
-			if (id->eide_dma_time > 150) {
-				goto no_dma_set;
-			}
-			/* Consult the list of known "good" drives */
-			dma_func = config_chipset_for_dma(drive);
-			if (dma_func != ide_dma_on)
-				goto no_dma_set;
-		} else {
-			goto fast_ata_pio;
-		}
-	} else if ((id->capability & 8) || (id->field_valid & 2)) {
-fast_ata_pio:
-		dma_func = ide_dma_off_quietly;
-no_dma_set:
-
-		config_chipset_for_pio(drive);
-	}
-	return HWIF(drive)->dmaproc(dma_func, drive);
-}
-
-/*
- * amd7409_dmaproc() initiates/aborts (U)DMA read/write operations on a drive.
- */
-
-int amd7409_dmaproc (ide_dma_action_t func, ide_drive_t *drive)
-{
-	switch (func) {
-		case ide_dma_check:
-			return config_drive_xfer_rate(drive);
-		default:
-			break;
-	}
-	return ide_dmaproc(func, drive);	/* use standard DMA stuff */
-}
-#endif /* CONFIG_BLK_DEV_IDEDMA */
-
-unsigned int __init pci_init_amd7409 (struct pci_dev *dev, const char *name)
-{
-	unsigned long fixdma_base = pci_resource_start(dev, 4);
-
-#ifdef CONFIG_BLK_DEV_IDEDMA
-	if (!amd7409_swdma_check(dev))
-		printk("%s: disabling single-word DMA support (revision < C4)\n", name);
-#endif /* CONFIG_BLK_DEV_IDEDMA */
-
-	if (!fixdma_base) {
-		/*
-		 *
-		 */
-	} else {
-		/*
-		 * enable DMA capable bit, and "not" simplex only
-		 */
-		outb(inb(fixdma_base+2) & 0x60, fixdma_base+2);
-
-		if (inb(fixdma_base+2) & 0x80)
-			printk("%s: simplex device: DMA will fail!!\n", name);
-	}
-#if defined(DISPLAY_VIPER_TIMINGS) && defined(CONFIG_PROC_FS)
-	if (!amd7409_proc) {
-		amd7409_proc = 1;
-		bmide_dev = dev;
-		amd7409_display_info = &amd7409_get_info;
-	}
-#endif /* DISPLAY_VIPER_TIMINGS && CONFIG_PROC_FS */
-
-	return 0;
-}
-
-unsigned int __init ata66_amd7409 (ide_hwif_t *hwif)
-{
-#ifdef CONFIG_AMD7409_OVERRIDE
-	byte ata66 = 1;
-#else
-	byte ata66 = 0;
-#endif /* CONFIG_AMD7409_OVERRIDE */
-
-#if 0
-	pci_read_config_byte(hwif->pci_dev, 0x48, &ata66);
-	return ((ata66 & 0x02) ? 0 : 1);
-#endif
-	return ata66;
-}
-
-void __init ide_init_amd7409 (ide_hwif_t *hwif)
-{
-	hwif->tuneproc = &amd7409_tune_drive;
-	hwif->speedproc = &amd7409_tune_chipset;
-
-#ifndef CONFIG_BLK_DEV_IDEDMA
-	hwif->drives[0].autotune = 1;
-	hwif->drives[1].autotune = 1;
-	hwif->autodma = 0;
-	return;
-#else
-
-	if (hwif->dma_base) {
-		hwif->dmaproc = &amd7409_dmaproc;
-		hwif->autodma = 1;
-	} else {
-		hwif->autodma = 0;
-		hwif->drives[0].autotune = 1;
-		hwif->drives[1].autotune = 1;
-	}
-#endif /* CONFIG_BLK_DEV_IDEDMA */
-}
-
-void __init ide_dmacapable_amd7409 (ide_hwif_t *hwif, unsigned long dmabase)
-{
-	ide_setup_dma(hwif, dmabase, 8);
-}
diff -urN linux-2.4.1-p8-pristine/drivers/ide/amd74xx.c linux-2.4.1-p8/drivers/ide/amd74xx.c
--- linux-2.4.1-p8-pristine/drivers/ide/amd74xx.c	Wed Dec 31 16:00:00 1969
+++ linux-2.4.1-p8/drivers/ide/amd74xx.c	Thu Jan 18 02:42:37 2001
@@ -0,0 +1,478 @@
+/*
+ * linux/drivers/ide/amd74xx.c		Version 0.05	June 9, 2000
+ *
+ * Copyright (C) 1999-2000		Andre Hedrick <andre@linux-ide.org>
+ * May be copied or modified under the terms of the GNU General Public License
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/timer.h>
+#include <linux/mm.h>
+#include <linux/ioport.h>
+#include <linux/blkdev.h>
+#include <linux/hdreg.h>
+
+#include <linux/interrupt.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <linux/ide.h>
+
+#include <asm/io.h>
+#include <asm/irq.h>
+
+#include "ide_modes.h"
+
+#define DISPLAY_VIPER_TIMINGS
+
+#if defined(DISPLAY_VIPER_TIMINGS) && defined(CONFIG_PROC_FS)
+#include <linux/stat.h>
+#include <linux/proc_fs.h>
+
+static int amd74xx_get_info(char *, char **, off_t, int);
+extern int (*amd74xx_display_info)(char *, char **, off_t, int); /* ide-proc.c */
+extern char *ide_media_verbose(ide_drive_t *);
+static struct pci_dev *bmide_dev;
+
+static int amd74xx_get_info (char *buffer, char **addr, off_t offset, int count)
+{
+	char *p = buffer;
+	u32 bibma = pci_resource_start(bmide_dev, 4);
+	u8 c0 = 0, c1 = 0;
+
+	/*
+	 * at that point bibma+0x2 et bibma+0xa are byte registers
+	 * to investigate:
+	 */
+	c0 = inb_p((unsigned short)bibma + 0x02);
+	c1 = inb_p((unsigned short)bibma + 0x0a);
+
+	p += sprintf(p, "\n                                AMD %04X VIPER Chipset.\n", bmide_dev->device);
+	p += sprintf(p, "--------------- Primary Channel ---------------- Secondary Channel -------------\n");
+	p += sprintf(p, "                %sabled                         %sabled\n",
+			(c0&0x80) ? "dis" : " en",
+			(c1&0x80) ? "dis" : " en");
+	p += sprintf(p, "--------------- drive0 --------- drive1 -------- drive0 ---------- drive1 ------\n");
+	p += sprintf(p, "DMA enabled:    %s              %s             %s               %s\n",
+			(c0&0x20) ? "yes" : "no ", (c0&0x40) ? "yes" : "no ",
+			(c1&0x20) ? "yes" : "no ", (c1&0x40) ? "yes" : "no " );
+	p += sprintf(p, "UDMA\n");
+	p += sprintf(p, "DMA\n");
+	p += sprintf(p, "PIO\n");
+
+	return p-buffer;	/* => must be less than 4k! */
+}
+#endif  /* defined(DISPLAY_VIPER_TIMINGS) && defined(CONFIG_PROC_FS) */
+
+byte amd74xx_proc = 0;
+
+extern char *ide_xfer_verbose (byte xfer_rate);
+
+static unsigned int amd74xx_swdma_check (struct pci_dev *dev)
+{
+	unsigned int class_rev;
+
+	if (dev->device == PCI_DEVICE_ID_AMD_VIPER_7411)
+		return 0;
+
+	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
+	class_rev &= 0xff;
+	return ((int) (class_rev >= 7) ? 1 : 0);
+}
+
+static int amd74xx_swdma_error(ide_drive_t *drive)
+{
+	printk("%s: single-word DMA not support (revision < C4)\n", drive->name);
+	return 0;
+}
+
+/*
+ * Here is where all the hard work goes to program the chipset.
+ *
+ */
+static int amd74xx_tune_chipset (ide_drive_t *drive, byte speed)
+{
+	ide_hwif_t *hwif	= HWIF(drive);
+	struct pci_dev *dev	= hwif->pci_dev;
+	int err			= 0;
+	byte unit		= (drive->select.b.unit & 0x01);
+#ifdef CONFIG_BLK_DEV_IDEDMA
+	unsigned long dma_base	= hwif->dma_base;
+#endif /* CONFIG_BLK_DEV_IDEDMA */
+	byte drive_pci		= 0x00;
+	byte drive_pci2		= 0x00;
+	byte ultra_timing	= 0x00;
+	byte dma_pio_timing	= 0x00;
+	byte pio_timing		= 0x00;
+
+        switch (drive->dn) {
+		case 0: drive_pci = 0x53; drive_pci2 = 0x4b; break;
+		case 1: drive_pci = 0x52; drive_pci2 = 0x4a; break;
+		case 2: drive_pci = 0x51; drive_pci2 = 0x49; break;
+		case 3: drive_pci = 0x50; drive_pci2 = 0x48; break;
+		default:
+                        return -1;
+        }
+
+	pci_read_config_byte(dev, drive_pci, &ultra_timing);
+	pci_read_config_byte(dev, drive_pci2, &dma_pio_timing);
+	pci_read_config_byte(dev, 0x4c, &pio_timing);
+
+#ifdef DEBUG
+	printk("%s: UDMA 0x%02x DMAPIO 0x%02x PIO 0x%02x ",
+		drive->name, ultra_timing, dma_pio_timing, pio_timing);
+#endif
+
+	ultra_timing &= ~0xC7;
+	dma_pio_timing &= ~0xFF;
+	pio_timing &= ~(0x03 << drive->dn);
+
+#ifdef DEBUG
+	printk(":: UDMA 0x%02x DMAPIO 0x%02x PIO 0x%02x ",
+		ultra_timing, dma_pio_timing, pio_timing);
+#endif
+
+	switch(speed) {
+#ifdef CONFIG_BLK_DEV_IDEDMA
+		case XFER_UDMA_5:
+			ultra_timing |= 0x46;
+			dma_pio_timing |= 0x20;
+			break;
+		case XFER_UDMA_4:
+			ultra_timing |= 0x45;
+			dma_pio_timing |= 0x20;
+			break;
+		case XFER_UDMA_3:
+			ultra_timing |= 0x44;
+			dma_pio_timing |= 0x20;
+			break;
+		case XFER_UDMA_2:
+			ultra_timing |= 0x40;
+			dma_pio_timing |= 0x20;
+			break;
+		case XFER_UDMA_1:
+			ultra_timing |= 0x41;
+			dma_pio_timing |= 0x20;
+			break;
+		case XFER_UDMA_0:
+			ultra_timing |= 0x42;
+			dma_pio_timing |= 0x20;
+			break;
+		case XFER_MW_DMA_2:
+			dma_pio_timing |= 0x20;
+			break;
+		case XFER_MW_DMA_1:
+			dma_pio_timing |= 0x21;
+			break;
+		case XFER_MW_DMA_0:
+			dma_pio_timing |= 0x77;
+			break;
+		case XFER_SW_DMA_2:
+			if (!amd74xx_swdma_check(dev))
+				return amd74xx_swdma_error(drive);
+			dma_pio_timing |= 0x42;
+			break;
+		case XFER_SW_DMA_1:
+			if (!amd74xx_swdma_check(dev))
+				return amd74xx_swdma_error(drive);
+			dma_pio_timing |= 0x65;
+			break;
+		case XFER_SW_DMA_0:
+			if (!amd74xx_swdma_check(dev))
+				return amd74xx_swdma_error(drive);
+			dma_pio_timing |= 0xA8;
+			break;
+#endif /* CONFIG_BLK_DEV_IDEDMA */
+		case XFER_PIO_4:
+			dma_pio_timing |= 0x20;
+			break;
+		case XFER_PIO_3:
+			dma_pio_timing |= 0x22;
+			break;
+		case XFER_PIO_2:
+			dma_pio_timing |= 0x42;
+			break;
+		case XFER_PIO_1:
+			dma_pio_timing |= 0x65;
+			break;
+		case XFER_PIO_0:
+		default:
+			dma_pio_timing |= 0xA8;
+			break;
+        }
+
+	pio_timing |= (0x03 << drive->dn);
+
+	if (!drive->init_speed)
+		drive->init_speed = speed;
+
+#ifdef CONFIG_BLK_DEV_IDEDMA
+	pci_write_config_byte(dev, drive_pci, ultra_timing);
+#endif /* CONFIG_BLK_DEV_IDEDMA */
+	pci_write_config_byte(dev, drive_pci2, dma_pio_timing);
+	pci_write_config_byte(dev, 0x4c, pio_timing);
+
+#ifdef DEBUG
+	printk(":: UDMA 0x%02x DMAPIO 0x%02x PIO 0x%02x\n",
+		ultra_timing, dma_pio_timing, pio_timing);
+#endif
+
+#ifdef CONFIG_BLK_DEV_IDEDMA
+	if (speed > XFER_PIO_4) {
+		outb(inb(dma_base+2)|(1<<(5+unit)), dma_base+2);
+	} else {
+		outb(inb(dma_base+2) & ~(1<<(5+unit)), dma_base+2);
+	}
+#endif /* CONFIG_BLK_DEV_IDEDMA */
+
+	err = ide_config_drive_speed(drive, speed);
+	drive->current_speed = speed;
+	return (err);
+}
+
+static void config_chipset_for_pio (ide_drive_t *drive)
+{
+	unsigned short eide_pio_timing[6] = {960, 480, 240, 180, 120, 90};
+	unsigned short xfer_pio	= drive->id->eide_pio_modes;
+	byte			timing, speed, pio;
+
+	pio = ide_get_best_pio_mode(drive, 255, 5, NULL);
+
+	if (xfer_pio> 4)
+		xfer_pio = 0;
+
+	if (drive->id->eide_pio_iordy > 0) {
+		for (xfer_pio = 5;
+			xfer_pio>0 &&
+			drive->id->eide_pio_iordy>eide_pio_timing[xfer_pio];
+			xfer_pio--);
+	} else {
+		xfer_pio = (drive->id->eide_pio_modes & 4) ? 0x05 :
+			   (drive->id->eide_pio_modes & 2) ? 0x04 :
+			   (drive->id->eide_pio_modes & 1) ? 0x03 :
+			   (drive->id->tPIO & 2) ? 0x02 :
+			   (drive->id->tPIO & 1) ? 0x01 : xfer_pio;
+	}
+
+	timing = (xfer_pio >= pio) ? xfer_pio : pio;
+
+	switch(timing) {
+		case 4: speed = XFER_PIO_4;break;
+		case 3: speed = XFER_PIO_3;break;
+		case 2: speed = XFER_PIO_2;break;
+		case 1: speed = XFER_PIO_1;break;
+		default:
+			speed = (!drive->id->tPIO) ? XFER_PIO_0 : XFER_PIO_SLOW;
+			break;
+	}
+	(void) amd74xx_tune_chipset(drive, speed);
+	drive->current_speed = speed;
+}
+
+static void amd74xx_tune_drive (ide_drive_t *drive, byte pio)
+{
+	byte speed;
+	switch(pio) {
+		case 4:		speed = XFER_PIO_4;break;
+		case 3:		speed = XFER_PIO_3;break;
+		case 2:		speed = XFER_PIO_2;break;
+		case 1:		speed = XFER_PIO_1;break;
+		default:	speed = XFER_PIO_0;break;
+	}
+	(void) amd74xx_tune_chipset(drive, speed);
+}
+
+#ifdef CONFIG_BLK_DEV_IDEDMA
+/*
+ * This allows the configuration of ide_pci chipset registers
+ * for cards that learn about the drive's UDMA, DMA, PIO capabilities
+ * after the drive is reported by the OS.
+ */
+static int config_chipset_for_dma (ide_drive_t *drive)
+{
+	ide_hwif_t *hwif	= HWIF(drive);
+	struct pci_dev *dev	= hwif->pci_dev;
+	struct hd_driveid *id	= drive->id;
+	byte udma_66		= eighty_ninty_three(drive);
+	byte udma_100		= (dev->device==PCI_DEVICE_ID_AMD_VIPER_7411) ? 1 : 0;
+	byte speed		= 0x00;
+	int  rval;
+
+	if ((id->dma_ultra & 0x0020) && (udma_66)&& (udma_100)) {
+		speed = XFER_UDMA_5;
+	} else if ((id->dma_ultra & 0x0010) && (udma_66)) {
+		speed = XFER_UDMA_4;
+	} else if ((id->dma_ultra & 0x0008) && (udma_66)) {
+		speed = XFER_UDMA_3;
+	} else if (id->dma_ultra & 0x0004) {
+		speed = XFER_UDMA_2;
+	} else if (id->dma_ultra & 0x0002) {
+		speed = XFER_UDMA_1;
+	} else if (id->dma_ultra & 0x0001) {
+		speed = XFER_UDMA_0;
+	} else if (id->dma_mword & 0x0004) {
+		speed = XFER_MW_DMA_2;
+	} else if (id->dma_mword & 0x0002) {
+		speed = XFER_MW_DMA_1;
+	} else if (id->dma_mword & 0x0001) {
+		speed = XFER_MW_DMA_0;
+	} else {
+		return ((int) ide_dma_off_quietly);
+	}
+
+	(void) amd74xx_tune_chipset(drive, speed);
+
+	rval = (int)(	((id->dma_ultra >> 11) & 3) ? ide_dma_on :
+			((id->dma_ultra >> 8) & 7) ? ide_dma_on :
+			((id->dma_mword >> 8) & 7) ? ide_dma_on :
+						     ide_dma_off_quietly);
+
+	return rval;
+}
+
+static int config_drive_xfer_rate (ide_drive_t *drive)
+{
+	struct hd_driveid *id = drive->id;
+	ide_dma_action_t dma_func = ide_dma_on;
+
+	if (id && (id->capability & 1) && HWIF(drive)->autodma) {
+		/* Consult the list of known "bad" drives */
+		if (ide_dmaproc(ide_dma_bad_drive, drive)) {
+			dma_func = ide_dma_off;
+			goto fast_ata_pio;
+		}
+		dma_func = ide_dma_off_quietly;
+		if (id->field_valid & 4) {
+			if (id->dma_ultra & 0x002F) {
+				/* Force if Capable UltraDMA */
+				dma_func = config_chipset_for_dma(drive);
+				if ((id->field_valid & 2) &&
+				    (dma_func != ide_dma_on))
+					goto try_dma_modes;
+			}
+		} else if (id->field_valid & 2) {
+try_dma_modes:
+			if ((id->dma_mword & 0x0007) ||
+			    ((id->dma_1word & 0x007) &&
+			     (amd74xx_swdma_check(HWIF(drive)->pci_dev)))) {
+				/* Force if Capable regular DMA modes */
+				dma_func = config_chipset_for_dma(drive);
+				if (dma_func != ide_dma_on)
+					goto no_dma_set;
+			}
+			
+		} else if (ide_dmaproc(ide_dma_good_drive, drive)) {
+			if (id->eide_dma_time > 150) {
+				goto no_dma_set;
+			}
+			/* Consult the list of known "good" drives */
+			dma_func = config_chipset_for_dma(drive);
+			if (dma_func != ide_dma_on)
+				goto no_dma_set;
+		} else {
+			goto fast_ata_pio;
+		}
+	} else if ((id->capability & 8) || (id->field_valid & 2)) {
+fast_ata_pio:
+		dma_func = ide_dma_off_quietly;
+no_dma_set:
+
+		config_chipset_for_pio(drive);
+	}
+	return HWIF(drive)->dmaproc(dma_func, drive);
+}
+
+/*
+ * amd74xx_dmaproc() initiates/aborts (U)DMA read/write operations on a drive.
+ */
+
+int amd74xx_dmaproc (ide_dma_action_t func, ide_drive_t *drive)
+{
+	switch (func) {
+		case ide_dma_check:
+			return config_drive_xfer_rate(drive);
+		default:
+			break;
+	}
+	return ide_dmaproc(func, drive);	/* use standard DMA stuff */
+}
+#endif /* CONFIG_BLK_DEV_IDEDMA */
+
+unsigned int __init pci_init_amd74xx (struct pci_dev *dev, const char *name)
+{
+	unsigned long fixdma_base = pci_resource_start(dev, 4);
+
+#ifdef CONFIG_BLK_DEV_IDEDMA
+	if (!amd74xx_swdma_check(dev))
+		printk("%s: disabling single-word DMA support (revision < C4)\n", name);
+#endif /* CONFIG_BLK_DEV_IDEDMA */
+
+	if (!fixdma_base) {
+		/*
+		 *
+		 */
+	} else {
+		/*
+		 * enable DMA capable bit, and "not" simplex only
+		 */
+		outb(inb(fixdma_base+2) & 0x60, fixdma_base+2);
+
+		if (inb(fixdma_base+2) & 0x80)
+			printk("%s: simplex device: DMA will fail!!\n", name);
+	}
+#if defined(DISPLAY_VIPER_TIMINGS) && defined(CONFIG_PROC_FS)
+	if (!amd74xx_proc) {
+		amd74xx_proc = 1;
+		bmide_dev = dev;
+		amd74xx_display_info = &amd74xx_get_info;
+	}
+#endif /* DISPLAY_VIPER_TIMINGS && CONFIG_PROC_FS */
+
+	return 0;
+}
+
+unsigned int __init ata66_amd74xx (ide_hwif_t *hwif)
+{
+#ifdef CONFIG_AMD74XX_OVERRIDE
+	byte ata66 = 1;
+#else
+	byte ata66 = 0;
+#endif /* CONFIG_AMD74XX_OVERRIDE */
+
+#if 0
+	pci_read_config_byte(hwif->pci_dev, 0x48, &ata66);
+	return ((ata66 & 0x02) ? 0 : 1);
+#endif
+	return ata66;
+}
+
+void __init ide_init_amd74xx (ide_hwif_t *hwif)
+{
+	hwif->tuneproc = &amd74xx_tune_drive;
+	hwif->speedproc = &amd74xx_tune_chipset;
+
+#ifndef CONFIG_BLK_DEV_IDEDMA
+	hwif->drives[0].autotune = 1;
+	hwif->drives[1].autotune = 1;
+	hwif->autodma = 0;
+	return;
+#else
+
+	if (hwif->dma_base) {
+		hwif->dmaproc = &amd74xx_dmaproc;
+		hwif->autodma = 1;
+	} else {
+		hwif->autodma = 0;
+		hwif->drives[0].autotune = 1;
+		hwif->drives[1].autotune = 1;
+	}
+#endif /* CONFIG_BLK_DEV_IDEDMA */
+}
+
+void __init ide_dmacapable_amd74xx (ide_hwif_t *hwif, unsigned long dmabase)
+{
+	ide_setup_dma(hwif, dmabase, 8);
+}
diff -urN linux-2.4.1-p8-pristine/drivers/ide/hpt366.c linux-2.4.1-p8/drivers/ide/hpt366.c
--- linux-2.4.1-p8-pristine/drivers/ide/hpt366.c	Tue Jan  2 16:58:45 2001
+++ linux-2.4.1-p8/drivers/ide/hpt366.c	Thu Jan 18 02:42:37 2001
@@ -55,6 +55,9 @@
 };
 
 const char *bad_ata66_4[] = {
+	"IBM-DTLA-307075",
+	"IBM-DTLA-307045",
+	"IBM-DTLA-307030",
 	"WDC AC310200R",
 	NULL
 };
diff -urN linux-2.4.1-p8-pristine/drivers/ide/ide-dma.c linux-2.4.1-p8/drivers/ide/ide-dma.c
--- linux-2.4.1-p8-pristine/drivers/ide/ide-dma.c	Thu Jan 18 01:20:48 2001
+++ linux-2.4.1-p8/drivers/ide/ide-dma.c	Thu Jan 18 02:42:40 2001
@@ -90,7 +90,16 @@
 #include <asm/io.h>
 #include <asm/irq.h>
 
-#undef CONFIG_BLK_DEV_IDEDMA_TIMEOUT
+/*
+ * Long lost data from 2.0.34 that is now in 2.0.39
+ *
+ * This was used in ./drivers/block/triton.c to do DMA Base address setup
+ * when PnP failed.  Oh the things we forget.  I believe this was part
+ * of SFF-8038i that has been withdrawn from public access... :-((
+ */
+#define DEFAULT_BMIBA	0xe800	/* in case BIOS did not init it */
+#define DEFAULT_BMCRBA	0xcc00	/* VIA's default value */
+#define DEFAULT_BMALIBA	0xd400	/* ALI's default value */
 
 extern char *ide_dmafunc_verbose(ide_dma_action_t dmafunc);
 
@@ -426,6 +435,7 @@
 	return hwif->dmaproc(ide_dma_off_quietly, drive);
 }
 
+#ifndef CONFIG_BLK_DEV_IDEDMA_TIMEOUT
 /*
  * 1 dmaing, 2 error, 4 intr
  */
@@ -449,6 +459,30 @@
 		return WAIT_CMD;
 	return 0;
 }
+#else /* CONFIG_BLK_DEV_IDEDMA_TIMEOUT */
+static ide_startstop_t ide_dma_timeout_revovery (ide_drive_t *drive)
+{
+	ide_hwgroup_t *hwgroup	= HWGROUP(drive);
+	ide_hwif_t *hwif	= HWIF(drive);
+	int enable_dma		= drive->using_dma;
+	unsigned long flags;
+	ide_startstop_t startstop;
+
+	spin_lock_irqsave(&io_request_lock, flags);
+	hwgroup->handler = NULL;
+	del_timer(&hwgroup->timer);
+	spin_unlock_irqrestore(&io_request_lock, flags);
+
+	drive->waiting_for_dma = 0;
+
+	startstop = ide_do_reset(drive);
+
+	if ((enable_dma) && !(drive->using_dma))
+		(void) hwif->dmaproc(ide_dma_on, drive);
+
+	return startstop;
+}
+#endif /* CONFIG_BLK_DEV_IDEDMA_TIMEOUT */
 
 /*
  * ide_dmaproc() initiates/aborts DMA read/write operations on a drive.
@@ -468,10 +502,11 @@
  */
 int ide_dmaproc (ide_dma_action_t func, ide_drive_t *drive)
 {
-	ide_hwif_t *hwif = HWIF(drive);
-	unsigned long dma_base = hwif->dma_base;
-	byte unit = (drive->select.b.unit & 0x01);
-	unsigned int count, reading = 0;
+	ide_hwgroup_t *hwgroup		= HWGROUP(drive);
+	ide_hwif_t *hwif		= HWIF(drive);
+	unsigned long dma_base		= hwif->dma_base;
+	byte unit			= (drive->select.b.unit & 0x01);
+	unsigned int count, reading	= 0;
 	byte dma_stat;
 
 	switch (func) {
@@ -498,7 +533,11 @@
 			drive->waiting_for_dma = 1;
 			if (drive->media != ide_disk)
 				return 0;
+#ifdef CONFIG_BLK_DEV_IDEDMA_TIMEOUT
+			ide_set_handler(drive, &ide_dma_intr, WAIT_CMD, NULL);	/* issue cmd to drive */
+#else /* !CONFIG_BLK_DEV_IDEDMA_TIMEOUT */
 			ide_set_handler(drive, &ide_dma_intr, WAIT_CMD, dma_timer_expiry);	/* issue cmd to drive */
+#endif /* CONFIG_BLK_DEV_IDEDMA_TIMEOUT */
 			OUT_BYTE(reading ? WIN_READDMA : WIN_WRITEDMA, IDE_COMMAND_REG);
 		case ide_dma_begin:
 			/* Note that this is done *after* the cmd has
@@ -537,6 +576,23 @@
 			 * we have to clean up the mess, and here is as good
 			 * as any.  Do it globally for all chipsets.
 			 */
+			outb(0x00, dma_base);		/* stop DMA */
+			dma_stat = inb(dma_base+2);	/* get DMA status */
+			outb(dma_stat|6, dma_base+2);	/* clear the INTR & ERROR bits */
+			printk("%s: %s: Lets do it again!" \
+				"stat = 0x%02x, dma_stat = 0x%02x\n",
+				drive->name, ide_dmafunc_verbose(func),
+				GET_STAT(), dma_stat);
+
+			if (dma_stat & 0xF0)
+				return ide_dma_timeout_revovery(drive);
+
+			printk("%s: %s: (restart_request) Lets do it again!" \
+				"stat = 0x%02x, dma_stat = 0x%02x\n",
+				drive->name, ide_dmafunc_verbose(func),
+				GET_STAT(), dma_stat);
+
+			return restart_request(drive);
 #endif /* CONFIG_BLK_DEV_IDEDMA_TIMEOUT */
 		case ide_dma_retune:
 		case ide_dma_lostirq:
@@ -620,6 +676,12 @@
 	unsigned long	dma_base = 0;
 	struct pci_dev	*dev = hwif->pci_dev;
 
+#ifdef CONFIG_BLK_DEV_IDEDMA_FORCED
+	int second_chance = 0;
+
+second_chance_to_dma:
+#endif /* CONFIG_BLK_DEV_IDEDMA_FORCED */
+
 	if (hwif->mate && hwif->mate->dma_base) {
 		dma_base = hwif->mate->dma_base - (hwif->channel ? 0 : 8);
 	} else {
@@ -629,6 +691,26 @@
 			dma_base = 0;
 		}
 	}
+
+#ifdef CONFIG_BLK_DEV_IDEDMA_FORCED
+	if ((!dma_base) && (!second_chance)) {
+		unsigned long set_bmiba = 0;
+		second_chance++;
+		switch(dev->vender) {
+			PCI_VENDOR_ID_AL:
+				set_bmiba = DEFAULT_BMALIBA; break;
+			PCI_VENDOR_ID_VIA:
+				set_bmiba = DEFAULT_BMCRBA; break;
+			PCI_VENDOR_ID_INTEL:
+				set_bmiba = DEFAULT_BMIBA; break;
+			default:
+				return dma_base;
+		}
+		pci_write_config_dword(dev, 0x20, set_bmiba|1);
+		goto second_chance_to_dma;
+	}
+#endif /* CONFIG_BLK_DEV_IDEDMA_FORCED */
+
 	if (dma_base) {
 		if (extra) /* PDC20246, PDC20262, HPT343, & HPT366 */
 			request_region(dma_base+16, extra, name);
diff -urN linux-2.4.1-p8-pristine/drivers/ide/ide-pci.c linux-2.4.1-p8/drivers/ide/ide-pci.c
--- linux-2.4.1-p8-pristine/drivers/ide/ide-pci.c	Tue Jan  2 16:58:45 2001
+++ linux-2.4.1-p8/drivers/ide/ide-pci.c	Thu Jan 18 02:42:40 2001
@@ -70,8 +70,9 @@
 #define DEVID_CY82C693	((ide_pci_devid_t){PCI_VENDOR_ID_CONTAQ,  PCI_DEVICE_ID_CONTAQ_82C693})
 #define DEVID_HINT	((ide_pci_devid_t){0x3388,                0x8013})
 #define DEVID_CS5530	((ide_pci_devid_t){PCI_VENDOR_ID_CYRIX,   PCI_DEVICE_ID_CYRIX_5530_IDE})
-#define DEVID_AMD7403	((ide_pci_devid_t){PCI_VENDOR_ID_AMD,     PCI_DEVICE_ID_AMD_COBRA_7403})
+#define DEVID_AMD7401	((ide_pci_devid_t){PCI_VENDOR_ID_AMD,     PCI_DEVICE_ID_AMD_COBRA_7401})
 #define DEVID_AMD7409	((ide_pci_devid_t){PCI_VENDOR_ID_AMD,     PCI_DEVICE_ID_AMD_VIPER_7409})
+#define DEVID_AMD7411	((ide_pci_devid_t){PCI_VENDOR_ID_AMD,     PCI_DEVICE_ID_AMD_VIPER_7411})
 #define DEVID_SLC90E66	((ide_pci_devid_t){PCI_VENDOR_ID_EFAR,    PCI_DEVICE_ID_EFAR_SLC90E66_1})
 #define DEVID_OSB4	((ide_pci_devid_t){PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_OSB4IDE})
 
@@ -109,20 +110,20 @@
 #define DMA_ALI15X3	NULL
 #endif
 
-#ifdef CONFIG_BLK_DEV_AMD7409
-extern unsigned int pci_init_amd7409(struct pci_dev *, const char *);
-extern unsigned int ata66_amd7409(ide_hwif_t *);
-extern void ide_init_amd7409(ide_hwif_t *);
-extern void ide_dmacapable_amd7409(ide_hwif_t *, unsigned long);
-#define PCI_AMD7409	&pci_init_amd7409
-#define ATA66_AMD7409	&ata66_amd7409
-#define INIT_AMD7409	&ide_init_amd7409
-#define DMA_AMD7409	&ide_dmacapable_amd7409
-#else
-#define PCI_AMD7409	NULL
-#define ATA66_AMD7409	NULL
-#define INIT_AMD7409	NULL
-#define DMA_AMD7409	NULL
+#ifdef CONFIG_BLK_DEV_AMD74XX
+extern unsigned int pci_init_amd74xx(struct pci_dev *, const char *);
+extern unsigned int ata66_amd74xx(ide_hwif_t *);
+extern void ide_init_amd74xx(ide_hwif_t *);
+extern void ide_dmacapable_amd74xx(ide_hwif_t *, unsigned long);
+#define PCI_AMD74XX	&pci_init_amd74xx
+#define ATA66_AMD74XX	&ata66_amd74xx
+#define INIT_AMD74XX	&ide_init_amd74xx
+#define DMA_AMD74XX	&ide_dmacapable_amd74xx
+#else
+#define PCI_AMD74XX	NULL
+#define ATA66_AMD74XX	NULL
+#define INIT_AMD74XX	NULL
+#define DMA_AMD74XX	NULL
 #endif
 
 #ifdef CONFIG_BLK_DEV_CMD64X
@@ -377,8 +378,9 @@
 	{DEVID_CY82C693,"CY82C693",	PCI_CY82C693,	NULL,		INIT_CY82C693,	NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	ON_BOARD,	0 },
 	{DEVID_HINT,	"HINT_IDE",	NULL,		NULL,		NULL,		NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	ON_BOARD,	0 },
 	{DEVID_CS5530,	"CS5530",	PCI_CS5530,	NULL,		INIT_CS5530,	NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	ON_BOARD,	0 },
-	{DEVID_AMD7403,	"AMD7403",	NULL,		NULL,		NULL,		NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	ON_BOARD,	0 },
-	{DEVID_AMD7409,	"AMD7409",	PCI_AMD7409,	ATA66_AMD7409,	INIT_AMD7409,	DMA_AMD7409,	{{0x40,0x01,0x01}, {0x40,0x02,0x02}},	ON_BOARD,	0 },
+	{DEVID_AMD7401,	"AMD7401",	NULL,		NULL,		NULL,		NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	ON_BOARD,	0 },
+	{DEVID_AMD7409,	"AMD7409",	PCI_AMD74XX,	ATA66_AMD74XX,	INIT_AMD74XX,	DMA_AMD74XX,	{{0x40,0x01,0x01}, {0x40,0x02,0x02}},	ON_BOARD,	0 },
+	{DEVID_AMD7411,	"AMD7411",	PCI_AMD74XX,	ATA66_AMD74XX,	INIT_AMD74XX,	DMA_AMD74XX,	{{0x40,0x01,0x01}, {0x40,0x02,0x02}},	ON_BOARD,	0 },
 	{DEVID_SLC90E66,"SLC90E66",	PCI_SLC90E66,	ATA66_SLC90E66,	INIT_SLC90E66,	NULL,		{{0x41,0x80,0x80}, {0x43,0x80,0x80}},	ON_BOARD,	0 },
         {DEVID_OSB4,    "ServerWorks OSB4",     PCI_OSB4,       ATA66_OSB4,     INIT_OSB4,      NULL,   {{0x00,0x00,0x00}, {0x00,0x00,0x00}},   ON_BOARD,       0 },
 	{IDE_PCI_DEVID_NULL, "PCI_IDE",	NULL,		NULL,		NULL,		NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}}, 	ON_BOARD,	0 }};
@@ -663,7 +665,9 @@
 		if (IDE_PCI_DEVID_EQ(d->devid, DEVID_SIS5513) ||
 		    IDE_PCI_DEVID_EQ(d->devid, DEVID_AEC6260) ||
 		    IDE_PCI_DEVID_EQ(d->devid, DEVID_PIIX4NX) ||
-		    IDE_PCI_DEVID_EQ(d->devid, DEVID_HPT34X))
+		    IDE_PCI_DEVID_EQ(d->devid, DEVID_HPT34X)  ||
+		    IDE_PCI_DEVID_EQ(d->devid, DEVID_VIA_IDE) ||
+		    IDE_PCI_DEVID_EQ(d->devid, DEVID_VP_IDE))
 			autodma = 0;
 		if (autodma)
 			hwif->autodma = 1;
diff -urN linux-2.4.1-p8-pristine/drivers/ide/ide-proc.c linux-2.4.1-p8/drivers/ide/ide-proc.c
--- linux-2.4.1-p8-pristine/drivers/ide/ide-proc.c	Thu Oct 26 14:11:39 2000
+++ linux-2.4.1-p8/drivers/ide/ide-proc.c	Thu Jan 18 02:42:40 2001
@@ -81,10 +81,10 @@
 extern byte ali_proc;
 int (*ali_display_info)(char *, char **, off_t, int) = NULL;
 #endif /* CONFIG_BLK_DEV_ALI15X3 */
-#ifdef CONFIG_BLK_DEV_AMD7409
-extern byte amd7409_proc;
-int (*amd7409_display_info)(char *, char **, off_t, int) = NULL;
-#endif /* CONFIG_BLK_DEV_AMD7409 */
+#ifdef CONFIG_BLK_DEV_AMD74XX
+extern byte amd74xx_proc;
+int (*amd74xx_display_info)(char *, char **, off_t, int) = NULL;
+#endif /* CONFIG_BLK_DEV_AMD74XX */
 #ifdef CONFIG_BLK_DEV_CMD64X
 extern byte cmd64x_proc;
 int (*cmd64x_display_info)(char *, char **, off_t, int) = NULL;
@@ -817,10 +817,10 @@
 	if ((ali_display_info) && (ali_proc))
 		create_proc_info_entry("ali", 0, proc_ide_root, ali_display_info);
 #endif /* CONFIG_BLK_DEV_ALI15X3 */
-#ifdef CONFIG_BLK_DEV_AMD7409
-	if ((amd7409_display_info) && (amd7409_proc))
-		create_proc_info_entry("amd7409", 0, proc_ide_root, amd7409_display_info);
-#endif /* CONFIG_BLK_DEV_AMD7409 */
+#ifdef CONFIG_BLK_DEV_AMD74XX
+	if ((amd74xx_display_info) && (amd74xx_proc))
+		create_proc_info_entry("amd74xx", 0, proc_ide_root, amd74xx_display_info);
+#endif /* CONFIG_BLK_DEV_AMD74XX */
 #ifdef CONFIG_BLK_DEV_CMD64X
 	if ((cmd64x_display_info) && (cmd64x_proc))
 		create_proc_info_entry("cmd64x", 0, proc_ide_root, cmd64x_display_info);
@@ -877,10 +877,10 @@
 	if ((ali_display_info) && (ali_proc))
 		remove_proc_entry("ide/ali",0);
 #endif /* CONFIG_BLK_DEV_ALI15X3 */
-#ifdef CONFIG_BLK_DEV_AMD7409
-	if ((amd7409_display_info) && (amd7409_proc))
-		remove_proc_entry("ide/amd7409",0);
-#endif /* CONFIG_BLK_DEV_AMD7409 */
+#ifdef CONFIG_BLK_DEV_AMD74XX
+	if ((amd74xx_display_info) && (amd74xx_proc))
+		remove_proc_entry("ide/amd74xx",0);
+#endif /* CONFIG_BLK_DEV_AMD74XX */
 #ifdef CONFIG_BLK_DEV_CMD64X
 	if ((cmd64x_display_info) && (cmd64x_proc))
 		remove_proc_entry("ide/cmd64x",0);
diff -urN linux-2.4.1-p8-pristine/drivers/ide/ide.c linux-2.4.1-p8/drivers/ide/ide.c
--- linux-2.4.1-p8-pristine/drivers/ide/ide.c	Wed Dec  6 12:06:19 2000
+++ linux-2.4.1-p8/drivers/ide/ide.c	Thu Jan 18 02:42:40 2001
@@ -1195,6 +1195,19 @@
 	return ide_stopped;
 }
 
+ide_startstop_t restart_request (ide_drive_t *drive)
+{
+	ide_hwgroup_t *hwgroup = HWGROUP(drive);
+	unsigned long flags;
+
+	spin_lock_irqsave(&io_request_lock, flags);
+	hwgroup->handler = NULL;
+	del_timer(&hwgroup->timer);
+	spin_unlock_irqrestore(&io_request_lock, flags);
+
+	return start_request(drive);
+}
+
 /*
  * ide_stall_queue() can be used by a drive to give excess bandwidth back
  * to the hwgroup by sleeping for timeout jiffies.
@@ -3533,6 +3546,7 @@
 EXPORT_SYMBOL(ide_fixstring);
 EXPORT_SYMBOL(ide_wait_stat);
 EXPORT_SYMBOL(ide_do_reset);
+EXPORT_SYMBOL(restart_request);
 EXPORT_SYMBOL(ide_init_drive_cmd);
 EXPORT_SYMBOL(ide_do_drive_cmd);
 EXPORT_SYMBOL(ide_end_drive_cmd);
diff -urN linux-2.4.1-p8-pristine/drivers/pci/pci.ids linux-2.4.1-p8/drivers/pci/pci.ids
--- linux-2.4.1-p8-pristine/drivers/pci/pci.ids	Tue Jan  2 16:58:45 2001
+++ linux-2.4.1-p8/drivers/pci/pci.ids	Thu Jan 18 02:42:40 2001
@@ -457,6 +457,8 @@
 	2040  79c974
 	7006  AMD-751 [Irongate] System Controller
 	7007  AMD-751 [Irongate] AGP Bridge
+	700E  AMD-760 [Irongate] System Controller
+	700F  AMD-760 [Irongate] AGP Bridge
 	7400  AMD-755 [Cobra] ISA
 	7401  AMD-755 [Cobra] IDE
 	7403  AMD-755 [Cobra] ACPI
@@ -465,6 +467,10 @@
 	7409  AMD-756 [Viper] IDE
 	740b  AMD-756 [Viper] ACPI
 	740c  AMD-756 [Viper] USB
+	7410  AMD-765 [Viper] ISA
+	7411  AMD-765 [Viper] IDE
+	7413  AMD-765 [Viper] ACPI
+	7414  AMD-765 [Viper] USB
 1023  Trident Microsystems
 	0194  82C194
 	2000  4DWave DX
diff -urN linux-2.4.1-p8-pristine/include/linux/ide.h linux-2.4.1-p8/include/linux/ide.h
--- linux-2.4.1-p8-pristine/include/linux/ide.h	Thu Jan  4 14:51:21 2001
+++ linux-2.4.1-p8/include/linux/ide.h	Thu Jan 18 02:42:40 2001
@@ -738,6 +738,12 @@
 ide_startstop_t ide_do_reset (ide_drive_t *);
 
 /*
+ * Re-Start an operation for an IDE interface.
+ * The caller should return immediately after invoking this.
+ */
+ide_startstop_t restart_request (ide_drive_t *);
+
+/*
  * This function is intended to be used prior to invoking ide_do_drive_cmd().
  */
 void ide_init_drive_cmd (struct request *rq);
diff -urN linux-2.4.1-p8-pristine/include/linux/pci_ids.h linux-2.4.1-p8/include/linux/pci_ids.h
--- linux-2.4.1-p8-pristine/include/linux/pci_ids.h	Tue Jan  2 16:58:45 2001
+++ linux-2.4.1-p8/include/linux/pci_ids.h	Thu Jan 18 02:42:40 2001
@@ -279,6 +279,9 @@
 #define PCI_DEVICE_ID_AMD_LANCE_HOME	0x2001
 #define PCI_DEVICE_ID_AMD_SCSI		0x2020
 #define PCI_DEVICE_ID_AMD_FE_GATE_7006	0x7006
+#define PCI_DEVICE_ID_AMD_FE_GATE_7007	0x7007
+#define PCI_DEVICE_ID_AMD_FE_GATE_700E	0x700E
+#define PCI_DEVICE_ID_AMD_FE_GATE_700F	0x700F
 #define PCI_DEVICE_ID_AMD_COBRA_7400	0x7400
 #define PCI_DEVICE_ID_AMD_COBRA_7401	0x7401
 #define PCI_DEVICE_ID_AMD_COBRA_7403	0x7403
@@ -287,6 +290,10 @@
 #define PCI_DEVICE_ID_AMD_VIPER_7409	0x7409
 #define PCI_DEVICE_ID_AMD_VIPER_740B	0x740B
 #define PCI_DEVICE_ID_AMD_VIPER_740C	0x740C
+#define PCI_DEVICE_ID_AMD_VIPER_7410	0x7410
+#define PCI_DEVICE_ID_AMD_VIPER_7411	0x7411
+#define PCI_DEVICE_ID_AMD_VIPER_7413	0x7413
+#define PCI_DEVICE_ID_AMD_VIPER_7414	0x7414
 
 #define PCI_VENDOR_ID_TRIDENT		0x1023
 #define PCI_DEVICE_ID_TRIDENT_4DWAVE_DX	0x2000

--------------0D1CB87D07F9C4AA61580BB8--

