Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311239AbSCLUAz>; Tue, 12 Mar 2002 15:00:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311243AbSCLUAv>; Tue, 12 Mar 2002 15:00:51 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:48391 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S311239AbSCLUAm>; Tue, 12 Mar 2002 15:00:42 -0500
Date: Tue, 12 Mar 2002 21:00:35 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Sebastian Droege <sebastian.droege@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [patch] PIIX driver rewrite
Message-ID: <20020312210035.A15175@ucw.cz>
In-Reply-To: <E16kYXz-0001z3-00@the-village.bc.nu> <Pine.LNX.4.33.0203111431340.15427-100000@penguin.transmeta.com> <20020311234553.A3490@ucw.cz> <3C8DDFC8.5080501@evision-ventures.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C8DDFC8.5080501@evision-ventures.com>; from dalecki@evision-ventures.com on Tue, Mar 12, 2002 at 12:00:24PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 12, 2002 at 12:00:24PM +0100, Martin Dalecki wrote:
> Hello Vojtech.
> 
> I have noticed that the ide-timings.h and ide_modules.h are running
> much in aprallel in the purpose they serve. Are the any
> chances you could dare to care about propagating the
> fairly nice ide-timings.h stuff in favour of
> ide_modules.h more.
> 
> BTW.> I think some stuff from ide-timings.h just belongs
> as generic functions intro ide.c, and right now there is
> nobody who you need to work from behind ;-).
> 
> So please feel free to do the changes you apparently desired
> to do a long time ago...

Oh, by the way, here goes the PIIX rewrite ... unlike the AMD one, this
is completely untested, and may not work at all - I only have the
datasheets at hand, no PIIX hardware.

Differences from the previous PIIX driver:

* 82451NX MIOC isn't supported anymore. It's not an ATA controller, anyway ;)
* 82371FB_0 PIIX ISA bridge isn't an ATA controller either.
* 82801CA ICH3 support added. Only ICH3-M is supported by the original driver.
* 82371MX MPIIX is not supported anymore. Too weird beast and doesn't do
  DMA anyway, better handled by the generic PCI ATA routines.

* Cleaner, converted to ide-timing.[ch]

* May not work. ;)

-- 
Vojtech Pavlik
SuSE Labs

--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ide-piix.diff"

diff -urN linux-2.5.6-timing/drivers/ide/ide-pci.c linux-2.5.6-piix/drivers/ide/ide-pci.c
--- linux-2.5.6-timing/drivers/ide/ide-pci.c	Tue Mar 12 16:05:37 2002
+++ linux-2.5.6-piix/drivers/ide/ide-pci.c	Tue Mar 12 20:33:23 2002
@@ -119,6 +119,7 @@
 extern unsigned int pci_init_piix(struct pci_dev *);
 extern unsigned int ata66_piix(ide_hwif_t *);
 extern void ide_init_piix(ide_hwif_t *);
+extern void ide_dmacapable_piix(ide_hwif_t *, unsigned long);
 #endif
 
 #ifdef CONFIG_BLK_DEV_IT8172
@@ -197,19 +198,17 @@
 
 static ide_pci_device_t pci_chipsets[] __initdata = {
 #ifdef CONFIG_BLK_DEV_PIIX
-	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371FB_0, NULL, NULL, ide_init_piix,	NULL, {{0x41,0x80,0x80}, {0x43,0x80,0x80}}, ON_BOARD, 0, 0 },
-	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371FB_1, NULL, NULL, ide_init_piix,	NULL, {{0x41,0x80,0x80}, {0x43,0x80,0x80}}, ON_BOARD, 0, 0 },
-	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371MX, NULL, NULL, ide_init_piix, NULL, {{0x6D,0x80,0x80}, {0x6F,0x80,0x80}}, ON_BOARD, 0, ATA_F_NODMA },
-	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371SB_1, pci_init_piix, NULL, ide_init_piix, NULL, {{0x41,0x80,0x80}, {0x43,0x80,0x80}}, ON_BOARD, 0, 0 },
-	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371AB, pci_init_piix, NULL,	ide_init_piix, NULL, {{0x41,0x80,0x80}, {0x43,0x80,0x80}}, ON_BOARD, 0, 0 },
-	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AB_1, pci_init_piix, NULL, ide_init_piix, NULL, {{0x41,0x80,0x80}, {0x43,0x80,0x80}}, ON_BOARD, 0, 0 },
-	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82443MX_1, pci_init_piix, NULL, ide_init_piix, NULL, {{0x41,0x80,0x80}, {0x43,0x80,0x80}}, ON_BOARD, 0, 0 },
-	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AA_1, pci_init_piix, ata66_piix, ide_init_piix, NULL, {{0x41,0x80,0x80}, {0x43,0x80,0x80}}, ON_BOARD, 0, 0 },
-	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82372FB_1, pci_init_piix, ata66_piix, ide_init_piix, NULL, {{0x41,0x80,0x80}, {0x43,0x80,0x80}}, ON_BOARD, 0, 0 },
-	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82451NX, pci_init_piix, NULL,	ide_init_piix, NULL, {{0x41,0x80,0x80}, {0x43,0x80,0x80}}, ON_BOARD, 0, ATA_F_NOADMA },
-	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_9, pci_init_piix, ata66_piix,	ide_init_piix, NULL, {{0x41,0x80,0x80}, {0x43,0x80,0x80}}, ON_BOARD, 0, 0 },
-	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_8, pci_init_piix, ata66_piix,	ide_init_piix, NULL, {{0x41,0x80,0x80}, {0x43,0x80,0x80}}, ON_BOARD, 0, 0 },
-	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_10, pci_init_piix, ata66_piix, ide_init_piix,	NULL, {{0x41,0x80,0x80}, {0x43,0x80,0x80}}, ON_BOARD, 0, 0 },
+	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371FB_1, pci_init_piix, ata66_piix, ide_init_piix, ide_dmacapable_piix, {{0x41,0x80,0x80}, {0x43,0x80,0x80}}, ON_BOARD, 0, 0 },
+	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371SB_1, pci_init_piix, ata66_piix, ide_init_piix, ide_dmacapable_piix, {{0x41,0x80,0x80}, {0x43,0x80,0x80}}, ON_BOARD, 0, 0 },
+	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371AB, pci_init_piix, ata66_piix, ide_init_piix, ide_dmacapable_piix, {{0x41,0x80,0x80}, {0x43,0x80,0x80}}, ON_BOARD, 0, 0 },
+	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82443MX_1, pci_init_piix, ata66_piix, ide_init_piix, ide_dmacapable_piix, {{0x41,0x80,0x80}, {0x43,0x80,0x80}}, ON_BOARD, 0, 0 },
+	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82372FB_1, pci_init_piix, ata66_piix, ide_init_piix, ide_dmacapable_piix, {{0x41,0x80,0x80}, {0x43,0x80,0x80}}, ON_BOARD, 0, 0 },
+	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AA_1, pci_init_piix, ata66_piix, ide_init_piix, ide_dmacapable_piix, {{0x41,0x80,0x80}, {0x43,0x80,0x80}}, ON_BOARD, 0, 0 },
+	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AB_1, pci_init_piix, ata66_piix, ide_init_piix, ide_dmacapable_piix, {{0x41,0x80,0x80}, {0x43,0x80,0x80}}, ON_BOARD, 0, 0 },
+	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_9, pci_init_piix, ata66_piix, ide_init_piix, ide_dmacapable_piix, {{0x41,0x80,0x80}, {0x43,0x80,0x80}}, ON_BOARD, 0, 0 },
+	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_8, pci_init_piix, ata66_piix, ide_init_piix, ide_dmacapable_piix, {{0x41,0x80,0x80}, {0x43,0x80,0x80}}, ON_BOARD, 0, 0 },
+	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_10, pci_init_piix, ata66_piix, ide_init_piix, ide_dmacapable_piix, {{0x41,0x80,0x80}, {0x43,0x80,0x80}}, ON_BOARD, 0, 0 },
+	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_11, pci_init_piix, ata66_piix, ide_init_piix, ide_dmacapable_piix, {{0x41,0x80,0x80}, {0x43,0x80,0x80}}, ON_BOARD, 0, 0 },
 #endif
 #ifdef CONFIG_BLK_DEV_VIA82CXXX
 	{PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C576_1,	pci_init_via82cxxx, ata66_via82cxxx, ide_init_via82cxxx, ide_dmacapable_via82cxxx, {{0x40,0x02,0x02}, {0x40,0x01,0x01}}, ON_BOARD, 0, ATA_F_NOADMA },
@@ -311,6 +310,7 @@
 	{PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_87410, NULL, NULL, NULL, NULL, {{0x43,0x08,0x08}, {0x47,0x08,0x08}}, ON_BOARD, 0, 0 },
 	{PCI_VENDOR_ID_HINT, PCI_DEVICE_ID_HINT, NULL, NULL, NULL, NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, ON_BOARD, 0, 0 },
 	{PCI_VENDOR_ID_HOLTEK, PCI_DEVICE_ID_HOLTEK_6565, NULL, NULL, NULL, NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, ON_BOARD, 0, 0 },
+	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371MX, NULL, NULL, NULL, NULL, {{0x6D,0x80,0x80}, {0x00,0x00,0x00}}, ON_BOARD, 0, ATA_F_NODMA },
 	{PCI_VENDOR_ID_UMC, PCI_DEVICE_ID_UMC_UM8673F, NULL, NULL, NULL, NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, ON_BOARD, 0, ATA_F_FIXIRQ },
 	{PCI_VENDOR_ID_UMC, PCI_DEVICE_ID_UMC_UM8886A, NULL, NULL, NULL, NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, ON_BOARD, 0, ATA_F_FIXIRQ },
 	{PCI_VENDOR_ID_UMC, PCI_DEVICE_ID_UMC_UM8886BF, NULL, NULL, NULL, NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, ON_BOARD, 0, ATA_F_FIXIRQ },
diff -urN linux-2.5.6-timing/drivers/ide/piix.c linux-2.5.6-piix/drivers/ide/piix.c
--- linux-2.5.6-timing/drivers/ide/piix.c	Tue Mar 12 16:26:03 2002
+++ linux-2.5.6-piix/drivers/ide/piix.c	Tue Mar 12 20:35:40 2002
@@ -1,499 +1,510 @@
 /*
- *  linux/drivers/ide/piix.c		Version 0.32	June 9, 2000
+ * $Id: piix.c,v 1.1 2002/10/10 22:58:60 vojtech Exp $
  *
- *  Copyright (C) 1998-1999 Andrzej Krzysztofowicz, Author and Maintainer
- *  Copyright (C) 1998-2000 Andre Hedrick <andre@linux-ide.org>
- *  May be copied or modified under the terms of the GNU General Public License
+ *  Copyright (c) 2000-2002 Vojtech Pavlik
  *
- *  PIO mode setting function for Intel chipsets.  
- *  For use instead of BIOS settings.
- *
- * 40-41
- * 42-43
- * 
- *                 41
- *                 43
- *
- * | PIO 0       | c0 | 80 | 0 | 	piix_tune_drive(drive, 0);
- * | PIO 2 | SW2 | d0 | 90 | 4 | 	piix_tune_drive(drive, 2);
- * | PIO 3 | MW1 | e1 | a1 | 9 | 	piix_tune_drive(drive, 3);
- * | PIO 4 | MW2 | e3 | a3 | b | 	piix_tune_drive(drive, 4);
- * 
- * sitre = word40 & 0x4000; primary
- * sitre = word42 & 0x4000; secondary
- *
- * 44 8421|8421    hdd|hdb
- * 
- * 48 8421         hdd|hdc|hdb|hda udma enabled
- *
- *    0001         hda
- *    0010         hdb
- *    0100         hdc
- *    1000         hdd
- *
- * 4a 84|21        hdb|hda
- * 4b 84|21        hdd|hdc
- *
- *    ata-33/82371AB
- *    ata-33/82371EB
- *    ata-33/82801AB            ata-66/82801AA
- *    00|00 udma 0              00|00 reserved
- *    01|01 udma 1              01|01 udma 3
- *    10|10 udma 2              10|10 udma 4
- *    11|11 reserved            11|11 reserved
- *
- * 54 8421|8421    ata66 drive|ata66 enable
- *
- * pci_read_config_word(HWIF(drive)->pci_dev, 0x40, &reg40);
- * pci_read_config_word(HWIF(drive)->pci_dev, 0x42, &reg42);
- * pci_read_config_word(HWIF(drive)->pci_dev, 0x44, &reg44);
- * pci_read_config_word(HWIF(drive)->pci_dev, 0x48, &reg48);
- * pci_read_config_word(HWIF(drive)->pci_dev, 0x4a, &reg4a);
- * pci_read_config_word(HWIF(drive)->pci_dev, 0x54, &reg54);
+ *  Based on the work of:
+ *	Andrzej Krzysztofowicz
+ *      Andre Hedrick
+ */
+
+/*
+ * Intel PIIX/ICH IDE driver for Linux.
  *
+ * UDMA66 and higher modes are autoenabled only in case the BIOS has detected a
+ * 80 wire cable. To ignore the BIOS data and assume the cable is present, use
+ * 'ide0=ata66' or 'ide1=ata66' on the kernel command line.
+ */
+
+/*
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
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ *
+ * Should you need to contact me, the author, you can do so either by
+ * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
+ * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
  */
 
 #include <linux/config.h>
-#include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/ioport.h>
+#include <linux/blkdev.h>
 #include <linux/pci.h>
-#include <linux/hdreg.h>
-#include <linux/ide.h>
-#include <linux/delay.h>
 #include <linux/init.h>
-
+#include <linux/ide.h>
 #include <asm/io.h>
 
 #include "ide-timing.h"
 
-#define PIIX_DEBUG_DRIVE_INFO		0
+#define PIIX_IDETIM0		0x40
+#define PIIX_IDETIM1		0x42
+#define PIIX_SIDETIM		0x44
+#define PIIX_UDMACTL		0x48
+#define PIIX_UDMATIM		0x4a
+#define PIIX_IDECFG		0x54
+
+#define PIIX_UDMA		0x07
+#define PIIX_UDMA_33		0x01
+#define PIIX_UDMA_66		0x02
+#define PIIX_UDMA_100		0x03
+#define PIIX_NO_SITRE		0x08
+#define PIIX_PINGPONG		0x10
+#define PIIX_ISA		0x20
 
-#define DISPLAY_PIIX_TIMINGS
+/*
+ * Intel IDE chips
+ */
+
+static struct piix_ide_chip {
+	char *name;
+	unsigned short id;
+	unsigned char flags;
+} piix_ide_chips[] = {
+	{ "82801CA ICH3",		PCI_DEVICE_ID_INTEL_82801CA_11, PIIX_UDMA_100 | PIIX_PINGPONG },
+	{ "82801CAM ICH3-M",		PCI_DEVICE_ID_INTEL_82801CA_10, PIIX_UDMA_100 | PIIX_PINGPONG },
+	{ "82801BA ICH2",		PCI_DEVICE_ID_INTEL_82801BA_9,	PIIX_UDMA_100 | PIIX_PINGPONG },
+	{ "82801BAM ICH2-M",		PCI_DEVICE_ID_INTEL_82801BA_8,	PIIX_UDMA_100 | PIIX_PINGPONG },
+	{ "82801AB ICH0",		PCI_DEVICE_ID_INTEL_82801AB_1,	PIIX_UDMA_33  | PIIX_PINGPONG },
+	{ "82801AA ICH",		PCI_DEVICE_ID_INTEL_82801AA_1,	PIIX_UDMA_66  | PIIX_PINGPONG },
+	{ "82372FB PIIX5",		PCI_DEVICE_ID_INTEL_82372FB_1,	PIIX_UDMA_66 },	
+	{ "82443MX MPIIX4",		PCI_DEVICE_ID_INTEL_82443MX_1,	PIIX_UDMA_33 },
+	{ "82371AB/EB PIIX4/4E",	PCI_DEVICE_ID_INTEL_82371AB,	PIIX_UDMA_33 },
+	{ "82371SB PIIX3",		PCI_DEVICE_ID_INTEL_82371SB_1,	0 },
+	{ "82371FB PIIX",		PCI_DEVICE_ID_INTEL_82371FB_1,	PIIX_NO_SITRE },
+	{ NULL }
+};
+
+static struct piix_ide_chip *piix_config;
+static unsigned char piix_enabled;
+static unsigned int piix_80w;
+static unsigned int piix_clock;
+
+static char *piix_dma[] = { "MWDMA16", "UDMA33", "UDMA66", "UDMA100" };
+
+/*
+ * PIIX/ICH /proc entry.
+ */
+
+#ifdef CONFIG_PROC_FS
 
-#if defined(DISPLAY_PIIX_TIMINGS) && defined(CONFIG_PROC_FS)
 #include <linux/stat.h>
 #include <linux/proc_fs.h>
 
-static int piix_get_info(char *, char **, off_t, int);
-extern int (*piix_display_info)(char *, char **, off_t, int); /* ide-proc.c */
+byte piix_proc;
+int piix_base;
 static struct pci_dev *bmide_dev;
+extern int (*piix_display_info)(char *, char **, off_t, int); /* ide-proc.c */
+
+#define piix_print(format, arg...) p += sprintf(p, format "\n" , ## arg)
+#define piix_print_drive(name, format, arg...)\
+	p += sprintf(p, name); for (i = 0; i < 4; i++) p += sprintf(p, format, ## arg); p += sprintf(p, "\n");
 
-static int piix_get_info (char *buffer, char **addr, off_t offset, int count)
+static int piix_get_info(char *buffer, char **addr, off_t offset, int count)
 {
+	short speed[4], cycle[4], active[4], recover[4], dmaen[4], uen[4], udma[4], umul;
+	struct pci_dev *dev = bmide_dev;
+	unsigned int i, u;
+	unsigned short c, d, e;
+	unsigned char t;
 	char *p = buffer;
-	u32 bibma = pci_resource_start(bmide_dev, 4);
-        u16 reg40 = 0, psitre = 0, reg42 = 0, ssitre = 0;
-	u8  c0 = 0, c1 = 0;
-	u8  reg44 = 0, reg48 = 0, reg4a = 0, reg4b = 0, reg54 = 0, reg55 = 0;
-
-	if (bmide_dev->device == PCI_DEVICE_ID_INTEL_82371MX) {
-		p += sprintf(p, "\n                                Intel MPIIX Chipset.\n");
-		return p-buffer;	/* => must be less than 4k! */
-	}
-
-	pci_read_config_word(bmide_dev, 0x40, &reg40);
-	pci_read_config_word(bmide_dev, 0x42, &reg42);
-	pci_read_config_byte(bmide_dev, 0x44, &reg44);
-	pci_read_config_byte(bmide_dev, 0x48, &reg48);
-	pci_read_config_byte(bmide_dev, 0x4a, &reg4a);
-	pci_read_config_byte(bmide_dev, 0x4b, &reg4b);
-	pci_read_config_byte(bmide_dev, 0x54, &reg54);
-	pci_read_config_byte(bmide_dev, 0x55, &reg55);
-
-	psitre = (reg40 & 0x4000) ? 1 : 0;
-	ssitre = (reg42 & 0x4000) ? 1 : 0;
-
-	/*
-	 * at that point bibma+0x2 et bibma+0xa are byte registers
-	 * to investigate:
-	 */
-	c0 = inb_p((unsigned short)bibma + 0x02);
-	c1 = inb_p((unsigned short)bibma + 0x0a);
-
-	p += sprintf(p, "\n                    %s Chipset.\n", bmide_dev->name);
-	p += sprintf(p, "--------------- Primary Channel ---------------- Secondary Channel -------------\n");
-	p += sprintf(p, "                %sabled                         %sabled\n",
-			(c0&0x80) ? "dis" : " en",
-			(c1&0x80) ? "dis" : " en");
-	p += sprintf(p, "--------------- drive0 --------- drive1 -------- drive0 ---------- drive1 ------\n");
-	p += sprintf(p, "DMA enabled:    %s              %s             %s               %s\n",
-			(c0&0x20) ? "yes" : "no ",
-			(c0&0x40) ? "yes" : "no ",
-			(c1&0x20) ? "yes" : "no ",
-			(c1&0x40) ? "yes" : "no " );
-	p += sprintf(p, "UDMA enabled:   %s              %s             %s               %s\n",
-			(reg48&0x01) ? "yes" : "no ",
-			(reg48&0x02) ? "yes" : "no ",
-			(reg48&0x04) ? "yes" : "no ",
-			(reg48&0x08) ? "yes" : "no " );
-	p += sprintf(p, "UDMA enabled:   %s                %s               %s                 %s\n",
-			((reg54&0x11) && (reg55&0x10) && (reg4a&0x01)) ? "5" :
-			((reg54&0x11) && (reg4a&0x02)) ? "4" :
-			((reg54&0x11) && (reg4a&0x01)) ? "3" :
-			(reg4a&0x02) ? "2" :
-			(reg4a&0x01) ? "1" :
-			(reg4a&0x00) ? "0" : "X",
-			((reg54&0x22) && (reg55&0x20) && (reg4a&0x10)) ? "5" :
-			((reg54&0x22) && (reg4a&0x20)) ? "4" :
-			((reg54&0x22) && (reg4a&0x10)) ? "3" :
-			(reg4a&0x20) ? "2" :
-			(reg4a&0x10) ? "1" :
-			(reg4a&0x00) ? "0" : "X",
-			((reg54&0x44) && (reg55&0x40) && (reg4b&0x03)) ? "5" :
-			((reg54&0x44) && (reg4b&0x02)) ? "4" :
-			((reg54&0x44) && (reg4b&0x01)) ? "3" :
-			(reg4b&0x02) ? "2" :
-			(reg4b&0x01) ? "1" :
-			(reg4b&0x00) ? "0" : "X",
-			((reg54&0x88) && (reg55&0x80) && (reg4b&0x30)) ? "5" :
-			((reg54&0x88) && (reg4b&0x20)) ? "4" :
-			((reg54&0x88) && (reg4b&0x10)) ? "3" :
-			(reg4b&0x20) ? "2" :
-			(reg4b&0x10) ? "1" :
-			(reg4b&0x00) ? "0" : "X");
-
-	p += sprintf(p, "UDMA\n");
-	p += sprintf(p, "DMA\n");
-	p += sprintf(p, "PIO\n");
 
-/*
- *	FIXME.... Add configuration junk data....blah blah......
- */
+	piix_print("----------PIIX BusMastering IDE Configuration---------------");
+
+	piix_print("Driver Version:                     1.1");
+	piix_print("South Bridge:                       Intel %s", piix_config->name);
+
+	pci_read_config_byte(dev, PCI_REVISION_ID, &t);
+	piix_print("Revision:                           IDE %#x", t);
+
+	piix_print("BM-DMA base:                        %#x", piix_base);
+	piix_print("PCI clock:                          %dMHz", piix_clock);
+
+	piix_print("-----------------------Primary IDE-------Secondary IDE------");
+
+	pci_read_config_word(dev, PIIX_IDETIM0, &d);
+	pci_read_config_word(dev, PIIX_IDETIM1, &e);
+	piix_print("Enabled:               %10s%20s", (d & 0x8000) ? "yes" : "no", (e & 0x8000) ? "yes" : "no");
+
+	c = inb(piix_base + 0x02) | (inb(piix_base + 0x0a) << 8);
+	piix_print("Simplex only:          %10s%20s", (c & 0x80) ? "yes" : "no", (c & 0x8000) ? "yes" : "no");
+
+	if ((piix_config->flags & PIIX_UDMA) >= PIIX_UDMA_66)
+		pci_read_config_dword(dev, PIIX_IDECFG, &u); else u = 0;
+	piix_print("Cable Type:            %10s%20s", (u & 0x30) ? "80w" : "40w", (u & 0xc0) ? "80w" : "40w");
+
+	piix_print("-------------------drive0----drive1----drive2----drive3-----");
+
+	piix_print_drive("Prefetch+Post: ", "%10s", (((i & 2) ? d : e) & (1 << (2 + ((i & 1) << 2)))) ? "yes" : "no");
+
+	if (~piix_config->flags & PIIX_NO_SITRE)
+		pci_read_config_byte(dev, PIIX_SIDETIM, &t);
+
+	for (i = 0; i < 4; i++) {
+
+		pci_read_config_word(dev, PIIX_IDETIM0 + (i & 2), &d);
+
+		umul = 4;
+		udma[i] = uen[i] = 0;
+		active[i] = 12;
+		recover[i] = 18;
 
-	return p-buffer;	 /* => must be less than 4k! */
+		switch (i & 1) {
+			case 1: if (~d & 0x10) break;
+				if ((~piix_config->flags & PIIX_NO_SITRE) && (d & 0x4000)) {
+					active[i]  = 5 - ((t >> ((i << 2) + 2)) & 3); 
+					recover[i] = 4 - ((t >> ((i << 2) + 0)) & 3); 
+					break;
+				}
+
+			case 0: if (~d & 0x01) break;
+				active[i] =  5 - ((d >> 12) & 3);
+				recover[i] = 4 - ((d >> 8) & 3);
+		}
+
+		dmaen[i] = (c & ((i & 1) ? 0x40 : 0x20) << ((i & 2) << 2));
+
+		if (~piix_config->flags & PIIX_UDMA)
+			continue;
+
+		pci_read_config_byte(dev, PIIX_UDMACTL, &t);
+		pci_read_config_word(dev, PIIX_UDMATIM, &e);
+
+		if ((piix_config->flags & PIIX_UDMA) >= PIIX_UDMA_66 && (u & (1 << i))) umul = 2;
+		if ((piix_config->flags & PIIX_UDMA) >= PIIX_UDMA_100 && (u & ((1 << i) + 12))) umul = 1;
+
+		uen[i]  = (t & (1 << i)) ? dmaen[i] : 0;
+		udma[i] = (4 - ((e >> (i << 4)) & 3)) * umul;
+
+		speed[i] = 8 * piix_clock / (uen[i] ? udma[i] : (active[i] + recover[i]) * 4);
+		cycle[i] = 1000000 / piix_clock * (uen[i] ? udma[i] : (active[i] + recover[i]) * 4) / 4;
+	}
+
+	piix_print_drive("Transfer Mode: ", "%10s", dmaen[i] ? (uen[i] ? "UDMA" : "DMA") : "PIO");
+
+	piix_print_drive("Address Setup: ", "%8dns", (1000000 / piix_clock) * 3);
+	piix_print_drive("Cmd Active:    ", "%8dns", (1000000 / piix_clock) * 12);
+	piix_print_drive("Cmd Recovery:  ", "%8dns", (1000000 / piix_clock) * 18);
+	piix_print_drive("Data Active:   ", "%8dns", (1000000 / piix_clock) * active[i]);
+	piix_print_drive("Data Recovery: ", "%8dns", (1000000 / piix_clock) * recover[i]);
+	piix_print_drive("Cycle Time:    ", "%8dns", cycle[i]);
+	piix_print_drive("Transfer Rate: ", "%4d.%dMB/s", speed[i] / 1000, speed[i] / 100 % 10);
+
+	return p - buffer;	/* hoping it is less than 4K... */
 }
-#endif  /* defined(DISPLAY_PIIX_TIMINGS) && defined(CONFIG_PROC_FS) */
+
+#endif
 
 /*
- *  Used to set Fifo configuration via kernel command line:
+ * piix_set_speed() writes timing values to the chipset registers
  */
 
-byte piix_proc = 0;
+static void piix_set_speed(struct pci_dev *dev, unsigned char dn, struct ide_timing *timing, int umul)
+{
+	unsigned short t;
+	unsigned char u;
+	unsigned int c;
+
+	pci_read_config_word(dev, PIIX_IDETIM0 + (dn & 2), &t);
+
+	switch (dn & 1) {
+
+		case 1: 
+			if (timing->cycle > 9) {
+				t &= ~0x30;
+				break;
+			}
 
-extern char *ide_xfer_verbose (byte xfer_rate);
+			if (~piix_config->flags & PIIX_NO_SITRE) {
+				pci_read_config_byte(dev, PIIX_SIDETIM, &u);
+				u &= ~(0xf << ((dn & 2) << 1));
+				t |= 0x30;
+				u |= (4 - FIT(timing->recover, 1, 4));
+				u |= (5 - FIT(timing->active, 2, 5)) << 2;
+				pci_write_config_byte(dev, PIIX_SIDETIM, u);
+				break;
+			}
 
-#if defined(CONFIG_BLK_DEV_IDEDMA) && defined(CONFIG_PIIX_TUNING)
-/*
- *
- */
-static byte piix_dma_2_pio (byte xfer_rate) {
-	switch(xfer_rate) {
-		case XFER_UDMA_5:
-		case XFER_UDMA_4:
-		case XFER_UDMA_3:
-		case XFER_UDMA_2:
-		case XFER_UDMA_1:
-		case XFER_UDMA_0:
-		case XFER_MW_DMA_2:
-		case XFER_PIO_4:
-			return 4;
-		case XFER_MW_DMA_1:
-		case XFER_PIO_3:
-			return 3;
-		case XFER_SW_DMA_2:
-		case XFER_PIO_2:
-			return 2;
-		case XFER_MW_DMA_0:
-		case XFER_SW_DMA_1:
-		case XFER_SW_DMA_0:
-		case XFER_PIO_1:
-		case XFER_PIO_0:
-		case XFER_PIO_SLOW:
-		default:
-			return 0;
+		case 0:
+			if (timing->cycle > 9) {
+				t &= ~0x03;
+				break;
+			}
+
+			t &= 0xccff;
+			t |= 0x03 << ((dn & 1) << 2);
+			t |= (4 - FIT(timing->recover, 1, 4)) << 8;
+			t |= (5 - FIT(timing->active, 2, 5)) << 12;
 	}
+
+	pci_write_config_word(dev, PIIX_IDETIM0 + (dn & 2), t);
+
+	if (!(piix_config->flags & PIIX_UDMA)) return;
+
+	pci_read_config_byte(dev, PIIX_UDMACTL, &u);
+	u &= ~(1 << dn);
+
+	if (timing->udma) {
+
+		u |= 1 << dn;
+
+		pci_read_config_word(dev, PIIX_UDMATIM, &t);
+		t &= ~(0x03 << (dn << 2));
+		t |= (4 - FIT(timing->udma, 2, 4)) << (dn << 2);
+		pci_write_config_word(dev, PIIX_UDMATIM, t);
+
+
+		if ((piix_config->flags & PIIX_UDMA) > PIIX_UDMA_33) {
+
+			pci_read_config_dword(dev, PIIX_IDECFG, &c);
+			
+			if ((piix_config->flags & PIIX_UDMA) > PIIX_UDMA_66)
+				c &= ~(1 << (dn + 12));
+			c &= ~(1 << dn);
+
+			switch (umul) {
+				case 2: c |= 1 << dn;		break;
+				case 4: c |= 1 << (dn + 12);	break;
+			}
+
+			pci_write_config_dword(dev, PIIX_IDECFG, c);
+		}
+	}
+
+	pci_write_config_byte(dev, PIIX_UDMACTL, u);
 }
-#endif /* defined(CONFIG_BLK_DEV_IDEDMA) && (CONFIG_PIIX_TUNING) */
 
 /*
- *  Based on settings done by AMI BIOS
- *  (might be useful if drive is not registered in CMOS for any reason).
+ * piix_set_drive() computes timing values configures the drive and
+ * the chipset to a desired transfer mode. It also can be called
+ * by upper layers.
  */
-static void piix_tune_drive (ide_drive_t *drive, byte pio)
-{
-	unsigned long flags;
-	u16 master_data;
-	u8 slave_data;
-	int is_slave		= (&HWIF(drive)->drives[1] == drive);
-	int master_port		= HWIF(drive)->index ? 0x42 : 0x40;
-	int slave_port		= 0x44;
-				 /* ISP  RTC */
-	byte timings[][2]	= { { 0, 0 },
-				    { 0, 0 },
-				    { 1, 0 },
-				    { 2, 1 },
-				    { 2, 3 }, };
-
-	if (pio == 255)
-		pio = ide_find_best_mode(drive, XFER_PIO | XFER_EPIO) - XFER_PIO_0;
-	else
-		pio = min_t(byte, pio, 4);
-
-	pci_read_config_word(HWIF(drive)->pci_dev, master_port, &master_data);
-	if (is_slave) {
-		master_data = master_data | 0x4000;
-		if (pio > 1)
-			/* enable PPE, IE and TIME */
-			master_data = master_data | 0x0070;
-		pci_read_config_byte(HWIF(drive)->pci_dev, slave_port, &slave_data);
-		slave_data = slave_data & (HWIF(drive)->index ? 0x0f : 0xf0);
-		slave_data = slave_data | (((timings[pio][0] << 2) | timings[pio][1])
-					   << (HWIF(drive)->index ? 4 : 0));
-	} else {
-		master_data = master_data & 0xccf8;
-		if (pio > 1)
-			/* enable PPE, IE and TIME */
-			master_data = master_data | 0x0007;
-		master_data = master_data | (timings[pio][0] << 12) |
-			      (timings[pio][1] << 8);
-	}
-	save_flags(flags);
-	cli();
-	pci_write_config_word(HWIF(drive)->pci_dev, master_port, master_data);
-	if (is_slave)
-		pci_write_config_byte(HWIF(drive)->pci_dev, slave_port, slave_data);
-	restore_flags(flags);
-}
 
-#if defined(CONFIG_BLK_DEV_IDEDMA) && defined(CONFIG_PIIX_TUNING)
-static int piix_tune_chipset (ide_drive_t *drive, byte speed)
+static int piix_set_drive(ide_drive_t *drive, unsigned char speed)
 {
-	ide_hwif_t *hwif	= HWIF(drive);
-	struct pci_dev *dev	= hwif->pci_dev;
-	byte maslave		= hwif->channel ? 0x42 : 0x40;
-	int a_speed		= 3 << (drive->dn * 4);
-	int u_flag		= 1 << drive->dn;
-	int v_flag		= 0x01 << drive->dn;
-	int w_flag		= 0x10 << drive->dn;
-	int u_speed		= 0;
-	int err			= 0;
-	int			sitre;
-	short			reg4042, reg44, reg48, reg4a, reg54;
-	byte			reg55;
-
-	pci_read_config_word(dev, maslave, &reg4042);
-	sitre = (reg4042 & 0x4000) ? 1 : 0;
-	pci_read_config_word(dev, 0x44, &reg44);
-	pci_read_config_word(dev, 0x48, &reg48);
-	pci_read_config_word(dev, 0x4a, &reg4a);
-	pci_read_config_word(dev, 0x54, &reg54);
-	pci_read_config_byte(dev, 0x55, &reg55);
-
-	switch(speed) {
-		case XFER_UDMA_4:
-		case XFER_UDMA_2:	u_speed = 2 << (drive->dn * 4); break;
-		case XFER_UDMA_5:
-		case XFER_UDMA_3:
-		case XFER_UDMA_1:	u_speed = 1 << (drive->dn * 4); break;
-		case XFER_UDMA_0:	u_speed = 0 << (drive->dn * 4); break;
-		case XFER_MW_DMA_2:
-		case XFER_MW_DMA_1:
-		case XFER_SW_DMA_2:	break;
-		default:		return -1;
-	}
-
-	if (speed >= XFER_UDMA_0) {
-		if (!(reg48 & u_flag))
-			pci_write_config_word(dev, 0x48, reg48|u_flag);
-		if (speed == XFER_UDMA_5) {
-			pci_write_config_byte(dev, 0x55, (byte) reg55|w_flag);
-		} else {
-			pci_write_config_byte(dev, 0x55, (byte) reg55 & ~w_flag);
-		}
-		if (!(reg4a & u_speed)) {
-			pci_write_config_word(dev, 0x4a, reg4a & ~a_speed);
-			pci_write_config_word(dev, 0x4a, reg4a|u_speed);
-		}
-		if (speed > XFER_UDMA_2) {
-			if (!(reg54 & v_flag)) {
-				pci_write_config_word(dev, 0x54, reg54|v_flag);
-			}
-		} else {
-			pci_write_config_word(dev, 0x54, reg54 & ~v_flag);
-		}
+	ide_drive_t *peer = HWIF(drive)->drives + (~drive->dn & 1);
+	struct ide_timing t, p;
+	int err, T, UT, umul;
+
+	if (speed != XFER_PIO_SLOW && speed != drive->current_speed)
+		if ((err = ide_config_drive_speed(drive, speed)))
+			return err;
+
+	umul =  min((speed > XFER_UDMA_4) ? 4 : ((speed > XFER_UDMA_2) ? 2 : 1),
+		piix_config->flags & PIIX_UDMA);
+
+	T = 1000000000 / piix_clock;
+	UT = T / umul;
+
+	ide_timing_compute(drive, speed, &t, T, UT);
+
+	if ((piix_config->flags & PIIX_NO_SITRE) && peer->present) {
+			ide_timing_compute(peer, peer->current_speed, &p, T, UT);
+			if (t.cycle <= 9 && p.cycle <= 9)
+				ide_timing_merge(&p, &t, &t, IDE_TIMING_ALL);
 	}
-	if (speed < XFER_UDMA_0) {
-		if (reg48 & u_flag)
-			pci_write_config_word(dev, 0x48, reg48 & ~u_flag);
-		if (reg4a & a_speed)
-			pci_write_config_word(dev, 0x4a, reg4a & ~a_speed);
-		if (reg54 & v_flag)
-			pci_write_config_word(dev, 0x54, reg54 & ~v_flag);
-		if (reg55 & w_flag)
-			pci_write_config_byte(dev, 0x55, (byte) reg55 & ~w_flag);
-	}
-
-	piix_tune_drive(drive, piix_dma_2_pio(speed));
-
-#if PIIX_DEBUG_DRIVE_INFO
-	printk("%s: %s drive%d\n", drive->name, ide_xfer_verbose(speed), drive->dn);
-#endif /* PIIX_DEBUG_DRIVE_INFO */
-	if (!drive->init_speed)
+
+	piix_set_speed(HWIF(drive)->pci_dev, drive->dn, &t, umul);
+
+	if (!drive->init_speed)	
 		drive->init_speed = speed;
-	err = ide_config_drive_speed(drive, speed);
 	drive->current_speed = speed;
-	return err;
-}
 
-static int piix_config_drive_for_dma (ide_drive_t *drive)
-{
-	struct hd_driveid *id	= drive->id;
-	ide_hwif_t *hwif	= HWIF(drive);
-	struct pci_dev *dev	= hwif->pci_dev;
-	byte			speed;
-
-	byte udma_66		= eighty_ninty_three(drive);
-	int ultra100		= ((dev->device == PCI_DEVICE_ID_INTEL_82801BA_8) ||
-				   (dev->device == PCI_DEVICE_ID_INTEL_82801BA_9) ||
-				   (dev->device == PCI_DEVICE_ID_INTEL_82801CA_10)) ? 1 : 0;
-	int ultra66		= ((ultra100) ||
-				   (dev->device == PCI_DEVICE_ID_INTEL_82801AA_1) ||
-				   (dev->device == PCI_DEVICE_ID_INTEL_82372FB_1)) ? 1 : 0;
-	int ultra		= ((ultra66) ||
-				   (dev->device == PCI_DEVICE_ID_INTEL_82371AB) ||
-				   (dev->device == PCI_DEVICE_ID_INTEL_82443MX_1) ||
-				   (dev->device == PCI_DEVICE_ID_INTEL_82451NX) ||
-				   (dev->device == PCI_DEVICE_ID_INTEL_82801AB_1)) ? 1 : 0;
-
-	speed = ide_find_best_mode(drive, XFER_PIO | XFER_EPIO | XFER_SWDMA | XFER_MWDMA
-					| (ultra ? XFER_UDMA : 0) | ((udma_66 & ultra66) ? XFER_UDMA_66 : 0)
-					| ((udma_66 & ultra100) ? XFER_UDMA_100 : 0));
-
-	(void) piix_tune_chipset(drive, speed);
-
-	return ((int)	((id->dma_ultra >> 11) & 7) ? ide_dma_on :
-			((id->dma_ultra >> 8) & 7) ? ide_dma_on :
-			((id->dma_mword >> 8) & 7) ? ide_dma_on :
-			((id->dma_1word >> 8) & 7) ? ide_dma_on :
-						     ide_dma_off_quietly);
+	return 0;
 }
 
-static void config_chipset_for_pio (ide_drive_t *drive)
-{
-	piix_tune_drive(drive, ide_find_best_mode(drive, XFER_PIO | XFER_EPIO) - XFER_PIO_0);
-}
+/*
+ * piix_tune_drive() is a callback from upper layers for
+ * PIO-only tuning.
+ */
 
-static int config_drive_xfer_rate (ide_drive_t *drive)
+static void piix_tune_drive(ide_drive_t *drive, unsigned char pio)
 {
-	struct hd_driveid *id = drive->id;
-	ide_dma_action_t dma_func = ide_dma_on;
+	if (!((piix_enabled >> HWIF(drive)->channel) & 1))
+		return;
 
-	if (id && (id->capability & 1) && HWIF(drive)->autodma) {
-		/* Consult the list of known "bad" drives */
-		if (ide_dmaproc(ide_dma_bad_drive, drive)) {
-			dma_func = ide_dma_off;
-			goto fast_ata_pio;
-		}
-		dma_func = ide_dma_off_quietly;
-		if (id->field_valid & 4) {
-			if (id->dma_ultra & 0x003F) {
-				/* Force if Capable UltraDMA */
-				dma_func = piix_config_drive_for_dma(drive);
-				if ((id->field_valid & 2) &&
-				    (dma_func != ide_dma_on))
-					goto try_dma_modes;
-			}
-		} else if (id->field_valid & 2) {
-try_dma_modes:
-			if ((id->dma_mword & 0x0007) ||
-			    (id->dma_1word & 0x007)) {
-				/* Force if Capable regular DMA modes */
-				dma_func = piix_config_drive_for_dma(drive);
-				if (dma_func != ide_dma_on)
-					goto no_dma_set;
-			}
-		} else if (ide_dmaproc(ide_dma_good_drive, drive)) {
-			if (id->eide_dma_time > 150) {
-				goto no_dma_set;
-			}
-			/* Consult the list of known "good" drives */
-			dma_func = piix_config_drive_for_dma(drive);
-			if (dma_func != ide_dma_on)
-				goto no_dma_set;
-		} else {
-			goto fast_ata_pio;
-		}
-	} else if ((id->capability & 8) || (id->field_valid & 2)) {
-fast_ata_pio:
-		dma_func = ide_dma_off_quietly;
-no_dma_set:
-		config_chipset_for_pio(drive);
+	if (pio == 255) {
+		piix_set_drive(drive, ide_find_best_mode(drive, XFER_PIO | XFER_EPIO));
+		return;
 	}
-	return HWIF(drive)->dmaproc(dma_func, drive);
+
+	piix_set_drive(drive, XFER_PIO_0 + min_t(byte, pio, 5));
 }
 
-static int piix_dmaproc(ide_dma_action_t func, ide_drive_t *drive)
+#ifdef CONFIG_BLK_DEV_IDEDMA
+
+/*
+ * piix_dmaproc() is a callback from upper layers that can do
+ * a lot, but we use it for DMA/PIO tuning only, delegating everything
+ * else to the default ide_dmaproc().
+ */
+
+int piix_dmaproc(ide_dma_action_t func, ide_drive_t *drive)
 {
-	switch (func) {
-		case ide_dma_check:
-			return config_drive_xfer_rate(drive);
-		default :
-			break;
+
+	if (func == ide_dma_check) {
+
+		short w80 = HWIF(drive)->udma_four;
+
+		short speed = ide_find_best_mode(drive,
+			XFER_PIO | XFER_EPIO | XFER_SWDMA | XFER_MWDMA |
+			(piix_config->flags & PIIX_UDMA ? XFER_UDMA : 0) |
+			(w80 && (piix_config->flags & PIIX_UDMA) >= PIIX_UDMA_66 ? XFER_UDMA_66 : 0) |
+			(w80 && (piix_config->flags & PIIX_UDMA) >= PIIX_UDMA_100 ? XFER_UDMA_100 : 0));
+
+		piix_set_drive(drive, speed);
+
+		func = (HWIF(drive)->autodma && (speed & XFER_MODE) != XFER_PIO)
+			? ide_dma_on : ide_dma_off_quietly;
+
 	}
-	/* Other cases are done by generic IDE-DMA code. */
+
 	return ide_dmaproc(func, drive);
 }
-#endif /* defined(CONFIG_BLK_DEV_IDEDMA) && (CONFIG_PIIX_TUNING) */
 
-unsigned int __init pci_init_piix(struct pci_dev *dev)
+#endif /* CONFIG_BLK_DEV_IDEDMA */
+
+/*
+ * The initialization callback. Here we determine the IDE chip type
+ * and initialize its drive independent registers.
+ */
+
+unsigned int __init pci_init_piix(struct pci_dev *dev, const char *name)
 {
-#if defined(DISPLAY_PIIX_TIMINGS) && defined(CONFIG_PROC_FS)
+	unsigned int u;
+	unsigned short w;
+	int i;
+
+/*
+ * Find out which Intel IDE this is.
+ */
+	
+	for (piix_config = piix_ide_chips; piix_config->id; piix_config++)
+		if (dev->device == piix_config->id)
+			break;
+
+	if (!piix_config->id) {
+		printk(KERN_WARNING "PIIX: Unknown PIIX/ICH chip %#x, contact Vojtech Pavlik <vojtech@ucw.cz>\n", dev->device);
+		return -ENODEV;
+	}
+
+/*
+ * Check 80-wire cable presence.
+ */
+
+	if ((piix_config->flags & PIIX_UDMA) >= PIIX_UDMA_66) {
+		pci_read_config_dword(dev, PIIX_IDECFG, &u);
+		piix_80w = ((u & 0x30) ? 1 : 0) | ((u & 0xc0) ? 2 : 0);
+
+		if (piix_config->flags & PIIX_PINGPONG) {
+			u |= 0x400; 
+			pci_write_config_dword(dev, PIIX_IDECFG, u);
+		}
+	}
+
+/*
+ * Detect enabled interfaces, enable slave separate timing if possible.
+ */
+
+
+	for (i = 0; i < 2; i++) {
+		pci_read_config_word(dev, PIIX_IDETIM0 + (i << 1), &w);
+		piix_enabled |= (w & 0x8000) ? (1 << i) : 0;
+		w &= 0x8c00;
+		if (~piix_config->flags & PIIX_NO_SITRE) w |= 0x4000;
+		w |= 0x44;
+		pci_write_config_word(dev, PIIX_IDETIM0 + (i << 1), w);
+	}
+
+/*
+ * Determine the system bus clock.
+ */
+
+	piix_clock = system_bus_speed * 1000;
+
+	switch (piix_clock) {
+		case 33000: piix_clock = 33333; break;
+		case 37000: piix_clock = 37500; break;
+		case 41000: piix_clock = 41666; break;
+	}
+
+	if (piix_clock < 20000 || piix_clock > 50000) {
+		printk(KERN_WARNING "PIIX: User given PCI clock speed impossible (%d), using 33 MHz instead.\n", piix_clock);
+		printk(KERN_WARNING "PIIX: Use ide0=ata66 if you want to assume 80-wire cable\n");
+		piix_clock = 33333;
+	}
+
+/*
+ * Print the boot message.
+ */
+
+	printk(KERN_INFO "PIIX: Intel %s IDE %s controller on pci%s\n",
+		piix_config->name, piix_dma[piix_config->flags & PIIX_UDMA], dev->slot_name);
+
+/*
+ * Register /proc/ide/piix entry
+ */
+
+#ifdef CONFIG_PROC_FS
 	if (!piix_proc) {
-		piix_proc = 1;
+		piix_base = pci_resource_start(dev, 4);
 		bmide_dev = dev;
 		piix_display_info = &piix_get_info;
+		piix_proc = 1;
 	}
-#endif /* DISPLAY_PIIX_TIMINGS && CONFIG_PROC_FS */
+#endif
+
 	return 0;
 }
 
-/*
- * Sheesh, someone at Intel needs to go read the ATA-4/5 T13 standards.
- * It does not specify device detection, but channel!!!
- * You determine later if bit 13 of word93 is set...
- */
-unsigned int __init ata66_piix (ide_hwif_t *hwif)
+unsigned int __init ata66_piix(ide_hwif_t *hwif)
 {
-	byte reg54h = 0, reg55h = 0, ata66 = 0;
-	byte mask = hwif->channel ? 0xc0 : 0x30;
-
-	pci_read_config_byte(hwif->pci_dev, 0x54, &reg54h);
-	pci_read_config_byte(hwif->pci_dev, 0x55, &reg55h);
-
-	ata66 = (reg54h & mask) ? 1 : 0;
-
-	return ata66;
+	return ((piix_enabled & piix_80w) >> hwif->channel) & 1;
 }
 
-void __init ide_init_piix (ide_hwif_t *hwif)
+void __init ide_init_piix(ide_hwif_t *hwif)
 {
-#ifndef CONFIG_IA64
-	if (!hwif->irq)
-		hwif->irq = hwif->channel ? 15 : 14;
-#endif /* CONFIG_IA64 */
+	int i;
 
-	if (hwif->pci_dev->device == PCI_DEVICE_ID_INTEL_82371MX) {
-		/* This is a painful system best to let it self tune for now */
-		return;
+	hwif->tuneproc = &piix_tune_drive;
+	hwif->speedproc = &piix_set_drive;
+	hwif->autodma = 0;
+
+	for (i = 0; i < 2; i++) {
+		hwif->drives[i].io_32bit = 1;
+		hwif->drives[i].unmask = 1;
+		hwif->drives[i].autotune = 1;
+		hwif->drives[i].dn = hwif->channel * 2 + i;
 	}
 
-	hwif->tuneproc = &piix_tune_drive;
-	hwif->drives[0].autotune = 1;
-	hwif->drives[1].autotune = 1;
+#ifdef CONFIG_BLK_DEV_IDEDMA
+	if (hwif->dma_base) {
+		hwif->highmem = 1;
+		hwif->dmaproc = &piix_dmaproc;
+#ifdef CONFIG_IDEDMA_AUTO
+		if (!noautodma)
+			hwif->autodma = 1;
+#endif
+	}
+#endif /* CONFIG_BLK_DEV_IDEDMA */
+}
 
-	if (!hwif->dma_base)
-		return;
+/*
+ * We allow the BM-DMA driver only work on enabled interfaces.
+ */
 
-	hwif->highmem = 1;
-#ifndef CONFIG_BLK_DEV_IDEDMA
-	hwif->autodma = 0;
-#else /* CONFIG_BLK_DEV_IDEDMA */
-#ifdef CONFIG_PIIX_TUNING
-	if (!noautodma)
-		hwif->autodma = 1;
-	hwif->dmaproc = &piix_dmaproc;
-	hwif->speedproc = &piix_tune_chipset;
-#endif /* CONFIG_PIIX_TUNING */
-#endif /* !CONFIG_BLK_DEV_IDEDMA */
+void __init ide_dmacapable_piix(ide_hwif_t *hwif, unsigned long dmabase)
+{
+	if ((piix_enabled >> hwif->channel) & 1)
+		ide_setup_dma(hwif, dmabase, 8);
 }

--6c2NcOVqGQ03X4Wi--
