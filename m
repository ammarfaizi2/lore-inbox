Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932360AbVJCRly@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360AbVJCRly (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 13:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932315AbVJCRlx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 13:41:53 -0400
Received: from amdext3.amd.com ([139.95.251.6]:1499 "EHLO amdext3.amd.com")
	by vger.kernel.org with ESMTP id S932309AbVJCRlw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 13:41:52 -0400
X-Server-Uuid: 89466532-923C-4A88-82C1-66ACAA0041DF
Date: Mon, 3 Oct 2005 11:58:51 -0600
From: "Jordan Crouse" <jordan.crouse@amd.com>
To: linux-kernel@vger.kernel.org
cc: info-linux@ldcmail.amd.com, linux-ide@vger.kernel.org
Subject: [PATCH 5/7] AMD Geode GX/LX support
Message-ID: <20051003175851.GG29264@cosmic.amd.com>
MIME-Version: 1.0
User-Agent: Mutt/1.5.11
X-WSS-ID: 6F5FB2D02OC692978-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following is a patch enabling IDE DMA for the CS5535 companion chip.
linux-ide folks, this is an updated version of the patch that was submitted 
last night by Jaya Kumar.   Both patches share the same history, and probably
the same bugs too.  Please apply against linux-2.6.14-rc2-mm2.

Signed off by:  Jordan Crouse (jordan.crouse@amd.com)

Index: linux-2.6.14-rc2-mm2/drivers/ide/Kconfig
===================================================================
--- linux-2.6.14-rc2-mm2.orig/drivers/ide/Kconfig
+++ linux-2.6.14-rc2-mm2/drivers/ide/Kconfig
@@ -539,6 +539,14 @@ config BLK_DEV_CS5530
 
 	  It is safe to say Y to this question.
 
+config BLK_DEV_CS5535
+	tristate "AMD CS5535 chipset support"
+	help
+	  Include support for UDMA on the National Semiconductor/AMD 5535
+	  chipset. This will automatically be detected and configured if found.
+
+	  It is safe to say Y to this question.
+
 config BLK_DEV_HPT34X
 	tristate "HPT34X chipset support"
 	help
Index: linux-2.6.14-rc2-mm2/drivers/ide/pci/Makefile
===================================================================
--- linux-2.6.14-rc2-mm2.orig/drivers/ide/pci/Makefile
+++ linux-2.6.14-rc2-mm2/drivers/ide/pci/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_BLK_DEV_ATIIXP)		+= atiixp.
 obj-$(CONFIG_BLK_DEV_CMD64X)		+= cmd64x.o
 obj-$(CONFIG_BLK_DEV_CS5520)		+= cs5520.o
 obj-$(CONFIG_BLK_DEV_CS5530)		+= cs5530.o
+obj-$(CONFIG_BLK_DEV_CS5535)		+= cs5535.o
 obj-$(CONFIG_BLK_DEV_SC1200)		+= sc1200.o
 obj-$(CONFIG_BLK_DEV_CY82C693)		+= cy82c693.o
 obj-$(CONFIG_BLK_DEV_HPT34X)		+= hpt34x.o
Index: linux-2.6.14-rc2-mm2/drivers/ide/pci/cs5535.c
===================================================================
--- /dev/null
+++ linux-2.6.14-rc2-mm2/drivers/ide/pci/cs5535.c
@@ -0,0 +1,352 @@
+/* <LIC_AMD_STD>
+ * Copyright (c) 2004-2005 Advanced Micro Devices, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ * The full GNU General Public License is included in this distribution in the
+ * file called COPYING
+ * </LIC_AMD_STD>  */
+/* <CTL_AMD_STD>
+ * </CTL_AMD_STD>  */
+/* <DOC_AMD_STD>
+ *  CS5535 documentation available from AMD.
+ * </DOC_AMD_STD>  */
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
+#include "cs5535.h"
+
+#if defined(DISPLAY_CS5535_TIMINGS) && defined(CONFIG_PROC_FS)
+#include <linux/stat.h>
+#include <linux/proc_fs.h>
+
+static u8 cs5535_proc = 0;
+static struct pci_dev *bmide_dev;
+static u8 w80 = 0;
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
+#define DEFAULT_PIO   ( (cs5535_pio_cmd_timings[0] << 16) | cs5535_pio_dta_timings[0] )
+
+static u8 cs5535_get_bios_settings(int unit) {
+
+	u32 pio, dma, dummy;
+	int i;
+
+	rdmsr(unit ? ATAC_CH0D1_DMA : ATAC_CH0D0_DMA, dma, dummy);
+	rdmsr(unit ? ATAC_CH0D1_PIO : ATAC_CH0D0_PIO, pio, dummy);
+
+	if (!CS5535_BAD_DMA(dma)) {
+		for(i = 0; i < 5; i++)
+			if (cs5535_udma_timings[i] == (dma & 0x7FFFFFFF))
+				return XFER_UDMA_0 + i;
+
+		for(i = 0; i < 3; i++)
+			if (cs5535_mwdma_timings[i] == (dma & 0x7FFFFFFF))
+				return  XFER_MW_DMA_0 + i;
+	}
+
+	for(i = 0; i < 5; i++)
+		if ((pio & 0xFFFF) == cs5535_pio_dta_timings[i])
+			return XFER_PIO_0 + i;
+
+	return 0;
+}
+
+static u8 cs5535_get_pio_mode(int unit) {
+
+	u32 reg, dummy;
+	int i;
+
+	rdmsr(unit ? ATAC_CH0D1_PIO : ATAC_CH0D0_PIO, reg, dummy);
+
+	for(i = 0; i < 5; i++) {
+		if ((reg & 0xFFFF) == cs5535_pio_dta_timings[i])
+			return i;
+	}
+
+	BUG();
+	return 0;
+}
+
+static void cs5535_set_speed(ide_drive_t *drive, u8 speed)  {
+
+	u32 reg, dummy;
+	int unit = drive->select.b.unit;
+
+	if (speed >= XFER_PIO_0 && speed <= XFER_PIO_4) {
+		u8 data1 = speed - XFER_PIO_0;
+		u8 data2 = cs5535_get_pio_mode(!unit);
+
+		u8 cmd = (data1 < data2) ? data1 : data2;
+
+		/* Write the other drive timings */
+		reg = (cs5535_pio_cmd_timings[cmd] << 16) | cs5535_pio_dta_timings[data2];
+		wrmsr(!unit ? ATAC_CH0D1_PIO : ATAC_CH0D0_PIO, reg, 0);
+
+		/* Write our drive timings*/
+		reg = (cs5535_pio_cmd_timings[cmd] << 16) | cs5535_pio_dta_timings[data1];
+		wrmsr(unit ? ATAC_CH0D1_PIO : ATAC_CH0D0_PIO, reg, 0);
+
+		/* Write the Format 1 bit in the DMA register */
+		rdmsr(unit ? ATAC_CH0D1_DMA : ATAC_CH0D0_DMA, reg, dummy);
+		wrmsr(unit ? ATAC_CH0D1_DMA : ATAC_CH0D0_DMA, reg | 0x80000000, 0);
+	}
+	else {
+		rdmsr(unit ? ATAC_CH0D1_DMA : ATAC_CH0D0_DMA, reg, dummy);
+
+
+		if (speed >= XFER_UDMA_0 && speed <= XFER_UDMA_7)
+			reg = (reg & 0x80000000) | cs5535_udma_timings[speed - XFER_UDMA_0];
+		else if (speed >= XFER_MW_DMA_0 && speed <= XFER_MW_DMA_2)
+			reg = (reg & 0x80000000) | cs5535_mwdma_timings[speed - XFER_MW_DMA_0];
+		else {
+			printk(KERN_INFO "cs5535:  Invalid speed 0x%x requested.\n", speed);
+			return;
+		}
+		wrmsr(unit ? ATAC_CH0D1_DMA : ATAC_CH0D0_DMA, reg, 0);
+	}
+}
+
+static int cs5535_set_drive(ide_drive_t *drive, u8 speed)
+{
+	if (speed != drive->current_speed)
+		ide_config_drive_speed(drive, speed);
+
+	cs5535_set_speed(drive, speed);
+
+	return 0;
+}
+
+/* tuneproc tunes the PIO speed of the device.
+   It is only called during init when autotune = IDE_TUNE_AUTO,
+   so we can avoid doing any default checking.
+*/
+
+static void cs5535_tuneproc (ide_drive_t *drive,u8 pio)
+{
+	u8 speed = 0;
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
+	int unit = drive->select.b.unit;
+	u8 speed = 0;
+	unsigned long map = XFER_PIO | XFER_EPIO | XFER_MWDMA | XFER_UDMA | (w80) ? XFER_UDMA_66 : 0;
+
+	if (drive->autotune == IDE_TUNE_DEFAULT) {
+		drive->autotune = IDE_TUNE_NOAUTO;
+
+		speed = cs5535_get_bios_settings(unit);
+
+		if (speed != 0) {
+			if (!drive->init_speed)
+				drive->init_speed = speed;
+
+			drive->current_speed = speed;
+		}
+	}
+
+	if (!speed) {
+		speed = ide_find_best_mode(drive, map);
+		cs5535_set_drive(drive, speed);
+	}
+
+	if (drive->autodma && (speed & XFER_MODE) != XFER_PIO)
+                return HWIF(drive)->ide_dma_on(drive);
+
+        return HWIF(drive)->ide_dma_off_quietly(drive);
+}
+
+static unsigned int __init init_chipset_cs5535 (struct pci_dev *dev, const char *name)
+{
+	u8 bit;
+
+#if defined(DISPLAY_CS5535_TIMINGS) && defined(CONFIG_PROC_FS)
+	if (!cs5535_proc)
+	{
+		cs5535_proc = 1;
+		bmide_dev = dev;
+		ide_pci_create_host_proc("cs5535", cs5535_get_info);
+	}
+#endif
+
+	pci_read_config_byte(dev, CS5535_CABLE_DETECT, &bit);
+	w80 = bit & 1;  /* Remember if we have a 80 wire cable */
+
+	return 0;
+}
+
+static void __init init_hwif_cs5535 (ide_hwif_t *hwif)
+{
+	unsigned long dummy;
+	u32           timings;
+
+	hwif->autodma = 0;
+	hwif->tuneproc = &cs5535_tuneproc;
+	hwif->speedproc = &cs5535_set_drive;
+	hwif->ide_dma_check = &cs5535_config_dma;
+
+	hwif->atapi_dma = 1;
+
+	/* We always support UDMA 0, 1 and 2 */
+
+	hwif->ultra_mask = 0x07;
+	hwif->mwdma_mask = 0x07;
+
+	/* If a 80 wire adapter is attached, add in 3 and 4 */
+	if (w80) hwif->ultra_mask |= 0x18;
+
+	hwif->udma_four = w80;  /* w80 = 1 if a 80 conductor line is attached */
+
+	if (hwif->mate)
+		hwif->serialized = hwif->mate->serialized = 1;
+
+	hwif->drives[0].autotune = IDE_TUNE_DEFAULT;
+	hwif->drives[1].autotune = IDE_TUNE_DEFAULT;
+
+	rdmsr(ATAC_CH0D0_PIO,timings,dummy);
+
+	if (CS5535_BAD_PIO(timings)) {
+		wrmsr(ATAC_CH0D0_PIO, DEFAULT_PIO, 0);
+		hwif->drives[0].autotune = IDE_TUNE_AUTO;
+	}
+
+	rdmsr(ATAC_CH0D1_PIO,timings,dummy);
+
+	if (CS5535_BAD_PIO(timings))  {
+		wrmsr(ATAC_CH0D1_PIO,DEFAULT_PIO,0);
+		hwif->drives[1].autotune = IDE_TUNE_AUTO;
+	}
+
+	if (!noautodma) hwif->autodma = 1;
+
+	hwif->drives[0].autodma = hwif->autodma;
+	hwif->drives[1].autodma = hwif->autodma;
+}
+
+static int __devinit cs5535_init_one(struct pci_dev *dev, const struct pci_device_id *id)
+{
+	ide_setup_pci_device(dev, &cs5535_chipsets[id->driver_data]);
+	return 0;
+}
+
+static struct pci_device_id cs5535_pci_tbl[] __devinitdata =
+{
+	{ PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_CS5535_IDE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{ 0, },
+};
+MODULE_DEVICE_TABLE(pci, cs5535_pci_tbl);
+
+static struct pci_driver driver = {
+	.name       = "CS5535 IDE",
+	.id_table   = cs5535_pci_tbl,
+	.probe      = cs5535_init_one,
+};
+
+
+static int cs5535_ide_init(void)
+{
+	return ide_pci_register_driver(&driver);
+}
+
+static void cs5535_ide_exit(void)
+{
+	ide_pci_unregister_driver(&driver);
+}
+
+module_init(cs5535_ide_init);
+module_exit(cs5535_ide_exit);
+
+MODULE_AUTHOR("AMD");
+MODULE_DESCRIPTION("PCI driver module for AMD CS5535 IDE");
+MODULE_LICENSE("GPL");
+
Index: linux-2.6.14-rc2-mm2/drivers/ide/pci/cs5535.h
===================================================================
--- /dev/null
+++ linux-2.6.14-rc2-mm2/drivers/ide/pci/cs5535.h
@@ -0,0 +1,72 @@
+/* <LIC_AMD_STD>
+ * Copyright (c) 2004-2005 Advanced Micro Devices, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ * The full GNU General Public License is included in this distribution in the
+ * file called COPYING
+ * </LIC_AMD_STD>  */
+/* <CTL_AMD_STD>
+ * </CTL_AMD_STD>  */
+/* <DOC_AMD_STD>
+ * </DOC_AMD_STD>  */
+
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
+static unsigned int init_chipset_cs5535(struct pci_dev *, const char *);
+static void init_hwif_cs5535(ide_hwif_t *);
+
+static ide_pci_device_t cs5535_chipsets[] __devinitdata = {
+	{	/* 0 */
+		.name		= "CS5535",
+		.init_chipset	= init_chipset_cs5535,
+		.init_iops	= NULL,
+		.init_hwif	= init_hwif_cs5535,
+		.channels	= 1,
+		.autodma	= AUTODMA,
+		.enablebits	= { {0x00,0x00,0x00} },
+		.bootable	= ON_BOARD,
+		.extra		= 0,
+	}
+};
+
+#endif /* CS5535_H */

