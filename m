Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262286AbVA0G7f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262286AbVA0G7f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 01:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262509AbVA0G7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 01:59:35 -0500
Received: from embeddededge.com ([209.113.146.155]:779 "EHLO penguin.netx4.com")
	by vger.kernel.org with ESMTP id S262286AbVA0G6l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 01:58:41 -0500
Mime-Version: 1.0 (Apple Message framework v619)
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-Id: <DB539902-7030-11D9-A0FB-003065F9B7DC@embeddedalley.com>
Content-Type: multipart/mixed; boundary=Apple-Mail-7--347106362
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] add AMD NS 5535 support
From: Dan Malek <dan@embeddedalley.com>
Date: Wed, 26 Jan 2005 22:58:32 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-7--347106362
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed



Hi Marcelo.

This patch for 2.4 adds support for the AMD / National
Semiconductor CS5535 chip set.  Provided by AMD
as part of the Geode support.

Signed-off-by:  Dan Malek <dan@embeddedalley.com>



--Apple-Mail-7--347106362
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="amdns_5535.patch"
Content-Disposition: attachment;
	filename=amdns_5535.patch

diff -Naru a/drivers/ide/Config.in b/drivers/ide/Config.in
--- a/drivers/ide/Config.in	2004-11-17 03:54:21.000000000 -0800
+++ b/drivers/ide/Config.in	2005-01-26 17:36:16.000000000 -0800
@@ -56,6 +56,7 @@
 	    dep_tristate '    Compaq Triflex IDE support' CONFIG_BLK_DEV_TRIFLEX $CONFIG_BLK_DEV_IDEDMA_PCI
 	    dep_tristate '    CY82C693 chipset support' CONFIG_BLK_DEV_CY82C693 $CONFIG_BLK_DEV_IDEDMA_PCI
 	    dep_tristate '    Cyrix CS5530 MediaGX chipset support' CONFIG_BLK_DEV_CS5530 $CONFIG_BLK_DEV_IDEDMA_PCI
+            dep_tristate '    AMD CS5535 chipset support' CONFIG_BLK_DEV_CS5535 $CONFIG_BLK_DEV_IDEDMA_PCI   
   	    dep_tristate '    HPT34X chipset support' CONFIG_BLK_DEV_HPT34X $CONFIG_BLK_DEV_IDEDMA_PCI
 	    dep_mbool    '      HPT34X AUTODMA support (WIP)' CONFIG_HPT34X_AUTODMA $CONFIG_BLK_DEV_HPT34X $CONFIG_IDEDMA_PCI_WIP
 	    dep_tristate '    HPT36X/37X chipset support' CONFIG_BLK_DEV_HPT366 $CONFIG_BLK_DEV_IDEDMA_PCI
diff -Naru a/drivers/ide/pci/cs5535.c b/drivers/ide/pci/cs5535.c
--- a/drivers/ide/pci/cs5535.c	1969-12-31 16:00:00.000000000 -0800
+++ b/drivers/ide/pci/cs5535.c	2005-01-26 17:36:16.000000000 -0800
@@ -0,0 +1,452 @@
+/*
+ * linux/drivers/ide/pci/cs5535.c       Version 0.1 Dec 10, 2003
+ *
+ * Copyright (C) 2003           Jens Altmann <jens.altmann@amd.com>
+ * Ditto of GNU General Public License.
+ *
+ *
+ * Development of this chipset driver was funded
+ * by the nice folks at National Semiconductor.
+ *
+ * Documentation:
+ *  CS5535 documentation available from National Semiconductor.
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/timer.h>
+#include <linux/mm.h>
+#include <linux/ioport.h>
+#include <linux/blkdev.h>
+#include <linux/hdreg.h>
+#include <linux/interrupt.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+#include <linux/ide.h>
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/msr.h>
+
+#include "ide-timing.h"
+#include "ide_modes.h"
+#include "cs5535.h"
+
+//#define DEBUG
+
+#ifdef DEBUG
+#define DPRINTK(fmt,args...) printk("cs5535-ide: " fmt, ##args)
+#else
+#define DPRINTK(fmt,args...)
+#endif
+
+#if defined(DISPLAY_CS5535_TIMINGS) && defined(CONFIG_PROC_FS)
+#include <linux/stat.h>
+#include <linux/proc_fs.h>
+
+static u8 cs5535_proc = 0;
+static struct pci_dev *bmide_dev;
+static u8 w80 = 0;
+
+/* FIXME:  rewrite this? */
+
+static int cs5535_get_info (char *buffer, char **addr, off_t offset, int count)
+{
+	char *p = buffer;
+	unsigned long bibma = pci_resource_start(bmide_dev, 4);
+
+	u8  c0 = 0;
+
+	/*
+	 * at that point bibma+0x2 et bibma+0xa are byte registers
+	 * to investigate:
+	 */
+
+	c0 = inb_p((u16)bibma + 0x02);
+
+	p += sprintf(p, "\n                                "
+		     "AMD/NS 5535 Chipset.\n");
+
+	p += sprintf(p, "--------------- drive0 --------- drive1 ------\n");
+	p += sprintf(p, "DMA enabled:    %s              %s\n",(c0&0x20) ? "yes" : "no ",
+		     (c0&0x40) ? "yes" : "no ");
+
+	pci_read_config_byte(bmide_dev, CS5535_CABLE_DETECT, &c0);
+
+	p += sprintf(p, "80 Wire Cable:  %s              %s\n", (c0 & 1) ? "yes" : "no", 
+		     (c0 & 2) ? "yes" :  "no");
+	
+	return p-buffer;
+}
+
+#endif /* DISPLAY_CS5535_TIMINGS && CONFIG_PROC_FS */
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
+#define CS5535_BAD_PIO(timings) ( (timings&~0x80000000)==0x00009172 )
+#define CS5535_BAD_DMA(timings) ( (timings & 0x000FFFFF) == 0x00077771 )
+  
+static void cs5535_set_speed(ide_drive_t *drive, u8 speed) {
+	
+	unsigned long reg = 0, dummy;
+	int unit = drive->select.b.unit;
+
+	DPRINTK("cs5535_set_speed speed %x\n", speed);
+
+	/* Set the PIO timings */
+	
+	if ((speed & XFER_MODE) == XFER_PIO) {
+		u8 pioa = speed - XFER_PIO_0;
+		u8 piob = ide_get_best_pio_mode(&(HWIF(drive)->drives[!unit]), 255, 4, NULL);
+		u8 cmd = pioa < piob ? pioa : piob;
+		
+		/* Write the speed of the current drive */
+		
+		reg = (cs5535_pio_cmd_timings[cmd] << 16) | cs5535_pio_dta_timings[pioa];	
+		wrmsr(unit ? ATAC_CH0D1_PIO : ATAC_CH0D0_PIO, reg, 0);
+		
+		/* And if nessesary - change the speed of the other drive */
+		rdmsr(unit ?  ATAC_CH0D0_PIO : ATAC_CH0D1_PIO, reg, dummy);    
+		
+		if (((reg >> 16) & cs5535_pio_cmd_timings[cmd]) != cs5535_pio_cmd_timings[cmd]) {
+			reg &= 0x0000FFFF;
+			reg |= cs5535_pio_cmd_timings[cmd] << 16;
+			wrmsr(unit ? ATAC_CH0D0_PIO : ATAC_CH0D1_PIO, reg, 0);
+		}
+
+		/* Set bit 31 of the DMA register for PIO format 1 timings */
+		rdmsr(unit ?  ATAC_CH0D1_DMA : ATAC_CH0D0_DMA, reg, dummy);    
+		wrmsr(unit ? ATAC_CH0D1_DMA : ATAC_CH0D0_DMA, reg | 0x80000000, 0);
+		
+	}
+	else {
+
+		rdmsr(unit ? ATAC_CH0D1_DMA : ATAC_CH0D0_DMA, reg, dummy);
+		
+		reg &= 0x80000000;  /* Preserve the PIO format bit */
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
+/* Configure the drive to the new speed */
+
+static int cs5535_set_drive(ide_drive_t *drive, u8 speed) {
+	
+	DPRINTK("cs5535_set_drive speed %x\n", speed);
+
+	if (speed != drive->current_speed)
+		ide_config_drive_speed(drive, speed);
+	
+	cs5535_set_speed(drive, speed);	
+
+	drive->current_speed = speed;
+	return 0;
+}
+
+static void cs5535_tuneproc (ide_drive_t *drive, u8 pio) 
+{ 	
+	u8 speed = 0;
+
+	DPRINTK("cs5535_tuneproc(%d) pio %x\n", drive->select.b.unit, pio);
+
+ 	if (pio == 255)
+		speed = ide_find_best_mode(drive, XFER_PIO | XFER_EPIO);
+	else if (pio < 100) 
+		speed = XFER_PIO_0 + min_t(byte, pio, 5);
+	else if (pio < 200)
+		speed = XFER_MW_DMA_0 + min_t(byte, (pio - 100), 2);
+	else 
+		speed = XFER_UDMA_0 + min_t(byte, (pio - 200), 7);
+			
+	cs5535_set_drive(drive, speed);
+}
+
+static int cs5535_config_dma(ide_drive_t *drive) {
+
+	u8 speed = 0;
+	unsigned long map = XFER_MWDMA | XFER_UDMA;
+	if (w80) map |= XFER_UDMA_66;
+
+	/* Get the best mode for this drive */
+	speed = ide_find_best_mode(drive, map);
+		
+	if ((speed & XFER_MODE) != XFER_PIO) {
+		cs5535_set_drive(drive, speed);
+		
+		if (drive->autodma)
+			return HWIF(drive)->ide_dma_on(drive);
+	}
+	
+	return 
+		HWIF(drive)->ide_dma_off_quietly(drive);
+}
+	
+static unsigned int __init init_chipset_cs5535 (struct pci_dev *dev, const char *name)
+{
+	unsigned long flags;
+	u8 bit;
+
+#if defined(DISPLAY_CS5535_TIMINGS) && defined(CONFIG_PROC_FS)
+	if (!cs5535_proc)
+	{
+		cs5535_proc = 1;
+		bmide_dev = dev;
+		ide_pci_register_host_proc(&cs5535_procs[0]);
+	}
+#endif /* DISPLAY_CS5535_TIMINGS && CONFIG_PROC_FS */
+
+	pci_read_config_byte(bmide_dev, CS5535_CABLE_DETECT, &bit);
+	w80 = bit & 1;  /* Remember if we have a 80 wire cable */
+
+	spin_lock_irqsave(&ide_lock, flags);
+	/* all CPUs (there should only be one CPU with this chipset) */
+
+#if defined(DISPLAY_CS5535_TIMINGS) && defined(DEBUG)
+	{
+	unsigned long val1, val2;
+	rdmsr(ATAC_GLD_MSR_CAP,val1,val2);
+	DPRINTK("ATAC_GLD_MSR_CAP=0x%.8X\n",(unsigned int)val1); 
+	rdmsr(ATAC_GLD_MSR_CONFIG,val1,val2);
+	DPRINTK("ATAC_GLD_MSR_CONFIG=0x%.8X\n",(unsigned int)val1);
+	rdmsr(ATAC_GLD_MSR_SMI   ,val1,val2);
+	DPRINTK("ATAC_GLD_MSR_SMI=0x%.8X\n",(unsigned int)val1);
+	rdmsr(ATAC_GLD_MSR_ERROR ,val1,val2);
+	DPRINTK("ATAC_GLD_MSR_ERROR=0x%.8X\n",(unsigned int)val1);
+	rdmsr(ATAC_GLD_MSR_PM    ,val1,val2);
+	DPRINTK("ATAC_GLD_MSR_PM=0x%.8X\n",(unsigned int)val1);
+	rdmsr(ATAC_GLD_MSR_DIAG  ,val1,val2);
+	DPRINTK("ATAC_GLD_MSR_DIAG=0x%.8X\n",(unsigned int)val1);
+	rdmsr(ATAC_IO_BAR        ,val1,val2);
+	DPRINTK("ATAC_IO_BAR=0x%.8X.%.8X\n",(unsigned int)val2,(unsigned int)val1);
+	rdmsr(ATAC_RESET         ,val1,val2);
+	DPRINTK("ATAC_RESET=0x%.8X\n",(unsigned int)val1);
+	rdmsr(ATAC_CH0D0_PIO     ,val1,val2);
+	DPRINTK("ATAC_CH0D0_PIO=0x%.8X\n",(unsigned int)val1);
+	rdmsr(ATAC_CH0D0_DMA     ,val1,val2);
+	DPRINTK("ATAC_CH0D0_DMA=0x%.8X\n",(unsigned int)val1);
+	rdmsr(ATAC_CH0D1_PIO     ,val1,val2);
+	DPRINTK("ATAC_CH0D1_PIO=0x%.8X\n",(unsigned int)val1);
+	rdmsr(ATAC_CH0D1_DMA     ,val1,val2);
+	DPRINTK("ATAC_CH0D1_DMA=0x%.8X\n",(unsigned int)val1);
+	rdmsr(ATAC_PCI_ABRTERR   ,val1,val2);
+	DPRINTK("ATAC_PCI_ABRTERR=0x%.8X\n",(unsigned int)val1);
+	}
+#endif /* DISPLAY_CS5535_TIMINGS*/
+
+	spin_unlock_irqrestore(&ide_lock, flags);
+
+	return 0;
+}
+
+
+/**
+ * \ingroup ide config
+ * \brief
+ *  This gets invoked by the IDE driver once for each channel. It
+ *  performs channel-specific pre-initialization before drive probing.
+ *
+ * \param  ide_hwif_t *hwif
+ *         
+ */
+static void __init init_hwif_cs5535 (ide_hwif_t *hwif)
+{
+	unsigned long dummy;
+	u32 timings;
+	hwif->autodma = 0;
+	unsigned long dfltpio = (cs5535_pio_cmd_timings[0] << 16) | 
+		cs5535_pio_dta_timings[0];
+
+	int dmastatus = 0;
+
+	if (!bmide_dev) 
+		DPRINTK("OOPS - bad timing\n");
+	else {
+		unsigned long bibma = pci_resource_start(bmide_dev, 4);
+		dmastatus = inb_p((u16) bibma + 0x02);		
+	}
+
+	if (hwif->mate)
+		hwif->serialized = hwif->mate->serialized = 1;
+
+	hwif->tuneproc = &cs5535_tuneproc;
+	hwif->speedproc = &cs5535_set_drive;
+
+	/* Check the registers, and set up the PIO registers if nessesary */
+	/* Note that this will default to whatever the BIOS set them to be */
+
+	/* Drive 0 */
+
+ 	rdmsr(ATAC_CH0D0_PIO,timings,dummy);
+	if (CS5535_BAD_PIO(timings)) 
+	{
+	 	/* PIO timings not initialized? */
+		wrmsr(ATAC_CH0D0_PIO, dfltpio, 0);
+
+		if(!hwif->drives[0].autotune)
+			hwif->drives[0].autotune = 1;
+	}
+
+	/* Drive 1 */
+
+	rdmsr(ATAC_CH0D1_PIO,timings,dummy);
+	if (CS5535_BAD_PIO(timings)) 
+	{
+		/* PIO timings not initialized? */
+		wrmsr(ATAC_CH0D1_PIO,dfltpio,0);
+		if(!hwif->drives[1].autotune)
+			hwif->drives[1].autotune = 1;
+
+	}
+
+	/* We want to take special care not to mess with the settings
+	   from the BIOS.  If the DMA registers are already set, just
+	   assume those are correct, and go from there */
+
+ 	rdmsr(ATAC_CH0D0_DMA, timings, dummy);
+
+	if (!CS5535_BAD_DMA(timings)) {
+		if (dmastatus & 0x20)
+			hwif->ide_dma_on(&(hwif->drives[0]));
+
+		hwif->drives[0].autotune = 2; 
+	}
+	
+	rdmsr(ATAC_CH0D1_DMA, timings, dummy);
+
+	if (!CS5535_BAD_DMA(timings)) {
+		if (dmastatus & 0x40)
+			hwif->ide_dma_on(&(hwif->drives[1]));
+
+		hwif->drives[1].autotune = 2;
+	}
+
+	hwif->atapi_dma = 1;
+    
+	hwif->ultra_mask = 0x1F;
+	hwif->mwdma_mask = 0x07;
+
+	/* w80 will be 1 if a 80 wire cable was detected */
+
+	hwif->udma_four = w80;
+
+	hwif->ide_dma_check = &cs5535_config_dma;
+	if (!noautodma) hwif->autodma = 1;
+		
+	hwif->drives[0].autodma = hwif->autodma;
+	hwif->drives[1].autodma = hwif->autodma;
+}
+
+/**
+ *  init_dma_cs5535     -   set up for DMA
+ *  @hwif: interface
+ *  @dmabase: DMA base address
+ *
+ *  FIXME: this can go away
+ */
+ 
+
+/**
+ * \ingroup ide config
+ * \brief
+ * wrapper for call of ide_setup_dma 
+ *  
+ * \param  ide_hwif_t *hwif
+ *         
+ */
+static void __init init_dma_cs5535 (ide_hwif_t *hwif, unsigned long dmabase)
+{
+	ide_setup_dma(hwif, dmabase, 8);
+}
+
+extern void ide_setup_pci_device(struct pci_dev *, ide_pci_device_t *);
+
+
+
+/**
+ * \ingroup ide config
+ * \brief
+ * wrapper for call of ide_setup_pci_device 
+ *  
+ * \param  struct pci_dev*              dev
+ *         const struct pci_device_id*  id
+ *         
+ * \return int always 0
+ */
+static int __devinit cs5535_init_one(struct pci_dev *dev, const struct pci_device_id *id)
+{
+	ide_pci_device_t *d = &cs5535_chipsets[id->driver_data];
+
+	if (dev->device != d->device) BUG();
+
+	ide_setup_pci_device(dev, d);
+	MOD_INC_USE_COUNT;
+	return 0;
+}
+
+static struct pci_device_id cs5535_pci_tbl[] __devinitdata = 
+{
+	{ PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_CS5535_IDE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{ 0, },
+};
+
+static struct pci_driver driver = {
+	.name       = "CS5535 IDE",
+	.id_table   = cs5535_pci_tbl,
+	.probe      = cs5535_init_one,
+};
+
+
+
+/**
+ * \ingroup ide config
+ * \brief
+ * register the driver 
+ *  
+ * \param  
+ *         
+ * \return int  errorcode from ide_pci_register_driver
+ */
+static int cs5535_ide_init(void)
+{
+	DPRINTK("cs5535_ide_init\n"); 
+	return ide_pci_register_driver(&driver);
+}
+
+static void cs5535_ide_exit(void)
+{
+	DPRINTK("cs5535_ide_exit\n"); 
+	ide_pci_unregister_driver(&driver);
+}
+
+module_init(cs5535_ide_init);
+module_exit(cs5535_ide_exit);
+
+MODULE_AUTHOR("Jens Altmann");
+MODULE_DESCRIPTION("PCI driver module for AMD/NS 5535 IDE");
+MODULE_LICENSE("GPL");
+
+EXPORT_NO_SYMBOLS;
diff -Naru a/drivers/ide/pci/cs5535.h b/drivers/ide/pci/cs5535.h
--- a/drivers/ide/pci/cs5535.h	1969-12-31 16:00:00.000000000 -0800
+++ b/drivers/ide/pci/cs5535.h	2005-01-26 17:36:16.000000000 -0800
@@ -0,0 +1,75 @@
+#ifndef CS5535_H
+#define CS5535_H
+
+#include <linux/config.h>
+#include <linux/pci.h>
+#include <linux/ide.h>
+
+#define DISPLAY_CS5535_TIMINGS
+
+#define MSR_ATAC_BASE    0x51300000
+#define ATAC_GLD_MSR_CAP (MSR_ATAC_BASE+0)
+#define ATAC_GLD_MSR_CONFIG    (MSR_ATAC_BASE+0x01)
+#define ATAC_GLD_MSR_SMI       (MSR_ATAC_BASE+0x02)
+#define ATAC_GLD_MSR_ERROR     (MSR_ATAC_BASE+0x03)
+#define ATAC_GLD_MSR_PM        (MSR_ATAC_BASE+0x04)
+#define ATAC_GLD_MSR_DIAG      (MSR_ATAC_BASE+0x05)
+#define ATAC_IO_BAR            (MSR_ATAC_BASE+0x08)
+#define ATAC_RESET             (MSR_ATAC_BASE+0x10)
+#define ATAC_CH0D0_PIO         (MSR_ATAC_BASE+0x20)
+#define ATAC_CH0D0_DMA         (MSR_ATAC_BASE+0x21)
+#define ATAC_CH0D1_PIO         (MSR_ATAC_BASE+0x22)
+#define ATAC_CH0D1_DMA         (MSR_ATAC_BASE+0x23) 
+#define ATAC_PCI_ABRTERR       (MSR_ATAC_BASE+0x24)
+#define ATAC_BM0_CMD_PRIM      0x00
+#define ATAC_BM0_STS_PRIM      0x02
+#define ATAC_BM0_PRD           0x04
+
+#define CS5535_CABLE_DETECT    0x48
+
+#if defined(DISPLAY_CS5535_TIMINGS) && defined(CONFIG_PROC_FS)
+#include <linux/stat.h>
+#include <linux/proc_fs.h>
+
+static u8 cs5535_proc;
+
+static int cs5535_get_info(char *, char **, off_t, int);
+
+static ide_pci_host_proc_t cs5535_procs[] __initdata = {
+	{
+		.name		= "cs5535",
+		.set		= 1,
+		.get_info	= cs5535_get_info,
+		.parent		= NULL,
+	},
+};
+
+#endif /* DISPLAY_CS5530_TIMINGS && CONFIG_PROC_FS */
+
+static unsigned int init_chipset_cs5535(struct pci_dev *, const char *);
+static void init_hwif_cs5535(ide_hwif_t *);
+static void init_dma_cs5535(ide_hwif_t *, unsigned long);
+
+static ide_pci_device_t cs5535_chipsets[] __devinitdata = {
+	{	/* 0 */
+		.vendor		= PCI_VENDOR_ID_NS,
+		.device		= PCI_DEVICE_ID_NS_CS5535_IDE,
+		.name		= "CS5535",
+		.init_chipset	= init_chipset_cs5535,
+		.init_iops	= NULL,
+		.init_hwif	= init_hwif_cs5535,
+		.init_dma	= init_dma_cs5535,
+		.channels	= 1,
+		.autodma	= AUTODMA,
+		.enablebits	= { {0x00,0x00,0x00} },  
+		.bootable	= ON_BOARD,
+		.extra		= 0,
+	},{
+		.vendor		= 0,
+		.device		= 0,
+		.channels	= 0,
+		.bootable	= EOL,
+	}
+};
+
+#endif /* CS5535_H */
diff -Naru a/drivers/ide/pci/Makefile b/drivers/ide/pci/Makefile
--- a/drivers/ide/pci/Makefile	2004-11-17 03:54:21.000000000 -0800
+++ b/drivers/ide/pci/Makefile	2005-01-26 17:36:16.000000000 -0800
@@ -12,6 +12,7 @@
 obj-$(CONFIG_BLK_DEV_CMD640)		+= cmd640.o
 obj-$(CONFIG_BLK_DEV_CMD64X)		+= cmd64x.o
 obj-$(CONFIG_BLK_DEV_CS5530)		+= cs5530.o
+obj-$(CONFIG_BLK_DEV_CS5535)        += cs5535.o
 obj-$(CONFIG_BLK_DEV_CY82C693)		+= cy82c693.o
 obj-$(CONFIG_BLK_DEV_HPT34X)		+= hpt34x.o
 obj-$(CONFIG_BLK_DEV_HPT366)		+= hpt366.o
diff -Naru a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h	2005-01-26 16:26:48.000000000 -0800
+++ b/include/linux/pci_ids.h	2005-01-26 17:36:16.000000000 -0800
@@ -350,6 +350,7 @@
 #define PCI_DEVICE_ID_NS_SCx200_VIDEO	0x0504
 #define PCI_DEVICE_ID_NS_SCx200_XBUS	0x0505
 #define PCI_DEVICE_ID_NS_87410		0xd001
+#define PCI_DEVICE_ID_NS_CS5535_IDE	0x002d
 
 #define PCI_VENDOR_ID_TSENG		0x100c
 #define PCI_DEVICE_ID_TSENG_W32P_2	0x3202

--Apple-Mail-7--347106362--

