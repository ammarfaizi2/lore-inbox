Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292857AbSCKPOE>; Mon, 11 Mar 2002 10:14:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292840AbSCKPNz>; Mon, 11 Mar 2002 10:13:55 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:43537 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S292857AbSCKPNh>; Mon, 11 Mar 2002 10:13:37 -0500
Date: Mon, 11 Mar 2002 16:13:34 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Martin Dalecki <martin@dalecki.de>,
        Linus Torvalds <torvalds@transmeta.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [patch] My AMD IDE driver, v2.7
Message-ID: <20020311161334.A1513@ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

This patch replaces the current AMD IDE driver (by Andre Hedrick) by
mine. Myself I think my implementation is much cleaner, but I'll leave
upon others to judge that. My driver also additionally supports the
AMD-8111 IDE.

It's well tested, and I'd like to have this in the kernel instead of
what's there now.

-- 
Vojtech Pavlik
SuSE Labs

--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="amdide-2.7.diff"

diff -urN linux-2.5.6/drivers/ide/amd74xx.c linux-2.5.6-amdide/drivers/ide/amd74xx.c
--- linux-2.5.6/drivers/ide/amd74xx.c	Mon Mar 11 08:46:22 2002
+++ linux-2.5.6-amdide/drivers/ide/amd74xx.c	Mon Mar 11 16:02:05 2002
@@ -1,485 +1,451 @@
 /*
- * linux/drivers/ide/amd74xx.c		Version 0.05	June 9, 2000
+ * $Id: amd74xx.c,v 2.7 2002/09/01 17:37:00 vojtech Exp $
  *
- * Copyright (C) 1999-2000		Andre Hedrick <andre@linux-ide.org>
- * May be copied or modified under the terms of the GNU General Public License
+ *  Copyright (c) 2000-2002 Vojtech Pavlik
  *
+ *  Based on the work of:
+ *	Andre Hedrick
+ */
+
+/*
+ * AMD 755/756/766/8111 IDE driver for Linux.
+ *
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
-#include <linux/delay.h>
-#include <linux/timer.h>
-#include <linux/mm.h>
 #include <linux/ioport.h>
 #include <linux/blkdev.h>
-#include <linux/hdreg.h>
-
-#include <linux/interrupt.h>
-#include <linux/init.h>
 #include <linux/pci.h>
+#include <linux/init.h>
 #include <linux/ide.h>
-
 #include <asm/io.h>
-#include <asm/irq.h>
 
-#include "ide_modes.h"
+#include "ide-timing.h"
+
+#define AMD_IDE_ENABLE		0x40
+#define AMD_IDE_CONFIG		0x41
+#define AMD_CABLE_DETECT	0x42
+#define AMD_DRIVE_TIMING	0x48
+#define AMD_8BIT_TIMING		0x4e
+#define AMD_ADDRESS_SETUP	0x4c
+#define AMD_UDMA_TIMING		0x50
+
+#define AMD_UDMA		0x07
+#define AMD_UDMA_33		0x01
+#define AMD_UDMA_66		0x02
+#define AMD_UDMA_100		0x03
+#define AMD_BAD_SWDMA		0x08
+#define AMD_BAD_FIFO		0x10
 
-#define DISPLAY_VIPER_TIMINGS
+/*
+ * AMD SouthBridge chips.
+ */
+
+static struct amd_ide_chip {
+	char *name;
+	unsigned short id;
+	unsigned char rev;
+	unsigned char flags;
+} amd_ide_chips[] = {
+	{ "8111",		PCI_DEVICE_ID_AMD_8111_IDE,  0x00, AMD_UDMA_100 },
+	{ "768 Opus",		PCI_DEVICE_ID_AMD_OPUS_7441, 0x00, AMD_UDMA_100 },
+	{ "766 Viper",		PCI_DEVICE_ID_AMD_VIPER_7411, 0x00, AMD_UDMA_100 | AMD_BAD_FIFO },
+	{ "756/c4+ Viper",	PCI_DEVICE_ID_AMD_VIPER_7409, 0x07, AMD_UDMA_66 },
+	{ "756 Viper",		PCI_DEVICE_ID_AMD_VIPER_7409, 0x00, AMD_UDMA_66 | AMD_BAD_SWDMA },
+	{ "755 Cobra",		PCI_DEVICE_ID_AMD_COBRA_7401, 0x00, AMD_UDMA_33 | AMD_BAD_SWDMA },
+	{ NULL }
+};
+
+static struct amd_ide_chip *amd_config;
+static unsigned char amd_enabled;
+static unsigned int amd_80w;
+static unsigned int amd_clock;
+
+static unsigned char amd_cyc2udma[] = { 6, 6, 5, 4, 0, 1, 1, 2, 2, 3, 3 };
+static unsigned char amd_udma2cyc[] = { 4, 6, 8, 10, 3, 2, 1, 1 };
+static char *amd_dma[] = { "MWDMA16", "UDMA33", "UDMA66", "UDMA100" };
+
+/*
+ * AMD /proc entry.
+ */
+
+#ifdef CONFIG_PROC_FS
 
-#if defined(DISPLAY_VIPER_TIMINGS) && defined(CONFIG_PROC_FS)
 #include <linux/stat.h>
 #include <linux/proc_fs.h>
 
-static int amd74xx_get_info(char *, char **, off_t, int);
-extern int (*amd74xx_display_info)(char *, char **, off_t, int); /* ide-proc.c */
+byte amd74xx_proc;
+int amd_base;
 static struct pci_dev *bmide_dev;
+extern int (*amd74xx_display_info)(char *, char **, off_t, int); /* ide-proc.c */
 
-static int amd74xx_get_info (char *buffer, char **addr, off_t offset, int count)
-{
+#define amd_print(format, arg...) p += sprintf(p, format "\n" , ## arg)
+#define amd_print_drive(name, format, arg...)\
+	p += sprintf(p, name); for (i = 0; i < 4; i++) p += sprintf(p, format, ## arg); p += sprintf(p, "\n");
+
+static int amd_get_info(char *buffer, char **addr, off_t offset, int count)
+{
+	int speed[4], cycle[4], setup[4], active[4], recover[4], den[4],
+		 uen[4], udma[4], active8b[4], recover8b[4];
+	struct pci_dev *dev = bmide_dev;
+	unsigned int v, u, i;
+	unsigned short c, w;
+	unsigned char t;
 	char *p = buffer;
-	u32 bibma = pci_resource_start(bmide_dev, 4);
-	u8 c0 = 0, c1 = 0;
 
-	/*
-	 * at that point bibma+0x2 et bibma+0xa are byte registers
-	 * to investigate:
-	 */
-	c0 = inb_p((unsigned short)bibma + 0x02);
-	c1 = inb_p((unsigned short)bibma + 0x0a);
-
-	p += sprintf(p, "\n                                AMD %04X VIPER Chipset.\n", bmide_dev->device);
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
+	amd_print("----------AMD BusMastering IDE Configuration----------------");
 
-	return p-buffer;	/* => must be less than 4k! */
-}
-#endif  /* defined(DISPLAY_VIPER_TIMINGS) && defined(CONFIG_PROC_FS) */
+	amd_print("Driver Version:                     2.7");
+	amd_print("South Bridge:                       AMD-%s", amd_config->name);
 
-byte amd74xx_proc = 0;
+	pci_read_config_byte(dev, PCI_REVISION_ID, &t);
+	amd_print("Revision:                           IDE %#x", t);
+	amd_print("Highest DMA rate:                   %s", amd_dma[amd_config->flags & AMD_UDMA]);
 
-extern char *ide_xfer_verbose (byte xfer_rate);
+	amd_print("BM-DMA base:                        %#x", amd_base);
+	amd_print("PCI clock:                          %d.%dMHz", amd_clock / 1000, amd_clock / 100 % 10);
+	
+	amd_print("-----------------------Primary IDE-------Secondary IDE------");
 
-static unsigned int amd74xx_swdma_check (struct pci_dev *dev)
-{
-	unsigned int class_rev;
+	pci_read_config_byte(dev, AMD_IDE_CONFIG, &t);
+	amd_print("Prefetch Buffer:       %10s%20s", (t & 0x80) ? "yes" : "no", (t & 0x20) ? "yes" : "no");
+	amd_print("Post Write Buffer:     %10s%20s", (t & 0x40) ? "yes" : "no", (t & 0x10) ? "yes" : "no");
 
-	if ((dev->device == PCI_DEVICE_ID_AMD_VIPER_7411) ||
-	    (dev->device == PCI_DEVICE_ID_AMD_VIPER_7441))
-		return 0;
-
-	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
-	class_rev &= 0xff;
-	return ((int) (class_rev >= 7) ? 1 : 0);
-}
+	pci_read_config_byte(dev, AMD_IDE_ENABLE, &t);
+	amd_print("Enabled:               %10s%20s", (t & 0x02) ? "yes" : "no", (t & 0x01) ? "yes" : "no");
 
-static int amd74xx_swdma_error(ide_drive_t *drive)
-{
-	printk("%s: single-word DMA not support (revision < C4)\n", drive->name);
-	return 0;
-}
+	c = inb(amd_base + 0x02) | (inb(amd_base + 0x0a) << 8);
+	amd_print("Simplex only:          %10s%20s", (c & 0x80) ? "yes" : "no", (c & 0x8000) ? "yes" : "no");
 
-/*
- * Here is where all the hard work goes to program the chipset.
- *
- */
-static int amd74xx_tune_chipset (ide_drive_t *drive, byte speed)
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
-	printk("%s:%d: Speed 0x%02x UDMA 0x%02x DMAPIO 0x%02x PIO 0x%02x\n",
-		drive->name, drive->dn, speed, ultra_timing, dma_pio_timing, pio_timing);
-#endif
+	amd_print("Cable Type:            %10s%20s", (amd_80w & 1) ? "80w" : "40w", (amd_80w & 2) ? "80w" : "40w");
 
-	ultra_timing	&= ~0xC7;
-	dma_pio_timing	&= ~0xFF;
-	pio_timing	&= ~(0x03 << drive->dn);
-
-#ifdef DEBUG
-	printk("%s: UDMA 0x%02x DMAPIO 0x%02x PIO 0x%02x\n",
-		drive->name, ultra_timing, dma_pio_timing, pio_timing);
-#endif
+	if (!amd_clock)
+                return p - buffer;
 
-	switch(speed) {
-#ifdef CONFIG_BLK_DEV_IDEDMA
-		case XFER_UDMA_7:
-		case XFER_UDMA_6:
-			speed = XFER_UDMA_5;
-		case XFER_UDMA_5:
-			ultra_timing |= 0x46;
-			dma_pio_timing |= 0x20;
-			break;
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
-			if (!amd74xx_swdma_check(dev))
-				return amd74xx_swdma_error(drive);
-			dma_pio_timing |= 0x42;
-			break;
-		case XFER_SW_DMA_1:
-			if (!amd74xx_swdma_check(dev))
-				return amd74xx_swdma_error(drive);
-			dma_pio_timing |= 0x65;
-			break;
-		case XFER_SW_DMA_0:
-			if (!amd74xx_swdma_check(dev))
-				return amd74xx_swdma_error(drive);
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
+	amd_print("-------------------drive0----drive1----drive2----drive3-----");
 
-	pio_timing |= (0x03 << drive->dn);
+	pci_read_config_byte(dev, AMD_ADDRESS_SETUP, &t);
+	pci_read_config_dword(dev, AMD_DRIVE_TIMING, &v);
+	pci_read_config_word(dev, AMD_8BIT_TIMING, &w);
+	pci_read_config_dword(dev, AMD_UDMA_TIMING, &u);
 
-	if (!drive->init_speed)
-		drive->init_speed = speed;
+	for (i = 0; i < 4; i++) {
+		setup[i]     = ((t >> ((3 - i) << 1)) & 0x3) + 1;
+		recover8b[i] = ((w >> ((1 - (i >> 1)) << 3)) & 0xf) + 1;
+		active8b[i]  = ((w >> (((1 - (i >> 1)) << 3) + 4)) & 0xf) + 1;
+		active[i]    = ((v >> (((3 - i) << 3) + 4)) & 0xf) + 1;
+		recover[i]   = ((v >> ((3 - i) << 3)) & 0xf) + 1;
 
-#ifdef CONFIG_BLK_DEV_IDEDMA
-	pci_write_config_byte(dev, drive_pci, ultra_timing);
-#endif /* CONFIG_BLK_DEV_IDEDMA */
-	pci_write_config_byte(dev, drive_pci2, dma_pio_timing);
-	pci_write_config_byte(dev, 0x4c, pio_timing);
+		udma[i] = amd_udma2cyc[((u >> ((3 - i) << 3)) & 0x7)];
+		uen[i]  = ((u >> ((3 - i) << 3)) & 0x40) ? 1 : 0;
+		den[i]  = (c & ((i & 1) ? 0x40 : 0x20) << ((i & 2) << 2));
+
+		if (den[i] && uen[i] && udma[i] == 1) {
+			speed[i] = amd_clock * 3;
+			cycle[i] = 666666 / amd_clock;
+			continue;
+		}
+
+		speed[i] = 4 * amd_clock / ((den[i] && uen[i]) ? udma[i] : (active[i] + recover[i]) * 2);
+		cycle[i] = 1000000 * ((den[i] && uen[i]) ? udma[i] : (active[i] + recover[i]) * 2) / amd_clock / 2;
+	}
+
+	amd_print_drive("Transfer Mode: ", "%10s", den[i] ? (uen[i] ? "UDMA" : "DMA") : "PIO");
+
+	amd_print_drive("Address Setup: ", "%8dns", 1000000 * setup[i] / amd_clock);
+	amd_print_drive("Cmd Active:    ", "%8dns", 1000000 * active8b[i] / amd_clock);
+	amd_print_drive("Cmd Recovery:  ", "%8dns", 1000000 * recover8b[i] / amd_clock);
+	amd_print_drive("Data Active:   ", "%8dns", 1000000 * active[i] / amd_clock);
+	amd_print_drive("Data Recovery: ", "%8dns", 1000000 * recover[i] / amd_clock);
+	amd_print_drive("Cycle Time:    ", "%8dns", cycle[i]);
+	amd_print_drive("Transfer Rate: ", "%4d.%dMB/s", speed[i] / 1000, speed[i] / 100 % 10);
+
+	return p - buffer;	/* hoping it is less than 4K... */
+}
 
-#ifdef DEBUG
-	printk("%s: UDMA 0x%02x DMAPIO 0x%02x PIO 0x%02x\n",
-		drive->name, ultra_timing, dma_pio_timing, pio_timing);
 #endif
 
-#ifdef CONFIG_BLK_DEV_IDEDMA
-	if (speed > XFER_PIO_4) {
-		outb(inb(dma_base+2)|(1<<(5+unit)), dma_base+2);
-	} else {
-		outb(inb(dma_base+2) & ~(1<<(5+unit)), dma_base+2);
+/*
+ * amd_set_speed() writes timing values to the chipset registers
+ */
+
+static void amd_set_speed(struct pci_dev *dev, unsigned char dn, struct ide_timing *timing)
+{
+	unsigned char t;
+
+	pci_read_config_byte(dev, AMD_ADDRESS_SETUP, &t);
+	t = (t & ~(3 << ((3 - dn) << 1))) | ((FIT(timing->setup, 1, 4) - 1) << ((3 - dn) << 1));
+	pci_write_config_byte(dev, AMD_ADDRESS_SETUP, t);
+
+	pci_write_config_byte(dev, AMD_8BIT_TIMING + (1 - (dn >> 1)),
+		((FIT(timing->act8b, 1, 16) - 1) << 4) | (FIT(timing->rec8b, 1, 16) - 1));
+
+	pci_write_config_byte(dev, AMD_DRIVE_TIMING + (3 - dn),
+		((FIT(timing->active, 1, 16) - 1) << 4) | (FIT(timing->recover, 1, 16) - 1));
+
+	switch (amd_config->flags & AMD_UDMA) {
+		case AMD_UDMA_33:  t = timing->udma ? (0xc0 | (FIT(timing->udma, 2, 5) - 2)) : 0x03; break;
+		case AMD_UDMA_66:  t = timing->udma ? (0xc0 | amd_cyc2udma[FIT(timing->udma, 2, 10)]) : 0x03; break;
+		case AMD_UDMA_100: t = timing->udma ? (0xc0 | amd_cyc2udma[FIT(timing->udma, 1, 10)]) : 0x03; break;
+		default: return;
 	}
-#endif /* CONFIG_BLK_DEV_IDEDMA */
 
-	err = ide_config_drive_speed(drive, speed);
-	drive->current_speed = speed;
-	return (err);
+	pci_write_config_byte(dev, AMD_UDMA_TIMING + (3 - dn), t);
 }
 
-static void config_chipset_for_pio (ide_drive_t *drive)
+/*
+ * amd_set_drive() computes timing values configures the drive and
+ * the chipset to a desired transfer mode. It also can be called
+ * by upper layers.
+ */
+
+static int amd_set_drive(ide_drive_t *drive, unsigned char speed)
 {
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
+	ide_drive_t *peer = HWIF(drive)->drives + (~drive->dn & 1);
+	struct ide_timing t, p;
+	int T, UT;
+
+	if (speed != XFER_PIO_SLOW && speed != drive->current_speed)
+		if (ide_config_drive_speed(drive, speed))
+			printk(KERN_WARNING "ide%d: Drive %d didn't accept speed setting. Oh, well.\n",
+				drive->dn >> 1, drive->dn & 1);
+
+	T = 1000000000 / amd_clock;
+	UT = T / MIN(MAX(amd_config->flags & AMD_UDMA, 1), 2);
+
+	ide_timing_compute(drive, speed, &t, T, UT);
+
+	if (peer->present) {
+		ide_timing_compute(peer, peer->current_speed, &p, T, UT);
+		ide_timing_merge(&p, &t, &t, IDE_TIMING_8BIT);
 	}
-	(void) amd74xx_tune_chipset(drive, speed);
+
+	if (speed == XFER_UDMA_5 && amd_clock <= 33333) t.udma = 1;
+
+	amd_set_speed(HWIF(drive)->pci_dev, drive->dn, &t);
+
+	if (!drive->init_speed)	
+		drive->init_speed = speed;
 	drive->current_speed = speed;
+
+	return 0;
 }
 
-static void amd74xx_tune_drive (ide_drive_t *drive, byte pio)
+/*
+ * amd74xx_tune_drive() is a callback from upper layers for
+ * PIO-only tuning.
+ */
+
+static void amd74xx_tune_drive(ide_drive_t *drive, unsigned char pio)
 {
-	byte speed;
-	switch(pio) {
-		case 4:		speed = XFER_PIO_4;break;
-		case 3:		speed = XFER_PIO_3;break;
-		case 2:		speed = XFER_PIO_2;break;
-		case 1:		speed = XFER_PIO_1;break;
-		default:	speed = XFER_PIO_0;break;
+	if (!((amd_enabled >> HWIF(drive)->channel) & 1))
+		return;
+
+	if (pio == 255) {
+		amd_set_drive(drive, ide_find_best_mode(drive, XFER_PIO | XFER_EPIO));
+		return;
 	}
-	(void) amd74xx_tune_chipset(drive, speed);
+
+	amd_set_drive(drive, XFER_PIO_0 + MIN(pio, 5));
 }
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
+
 /*
- * This allows the configuration of ide_pci chipset registers
- * for cards that learn about the drive's UDMA, DMA, PIO capabilities
- * after the drive is reported by the OS.
+ * amd74xx_dmaproc() is a callback from upper layers that can do
+ * a lot, but we use it for DMA/PIO tuning only, delegating everything
+ * else to the default ide_dmaproc().
  */
-static int config_chipset_for_dma (ide_drive_t *drive)
+
+int amd74xx_dmaproc(ide_dma_action_t func, ide_drive_t *drive)
 {
-	ide_hwif_t *hwif	= HWIF(drive);
-	struct pci_dev *dev	= hwif->pci_dev;
-	struct hd_driveid *id	= drive->id;
-	byte udma_66		= eighty_ninty_three(drive);
-	byte udma_100		= ((dev->device==PCI_DEVICE_ID_AMD_VIPER_7411)||
-				   (dev->device==PCI_DEVICE_ID_AMD_VIPER_7441)) ? 1 : 0;
-	byte speed		= 0x00;
-	int  rval;
-
-	if ((id->dma_ultra & 0x0020) && (udma_66) && (udma_100)) {
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
-	(void) amd74xx_tune_chipset(drive, speed);
-
-	rval = (int)(	((id->dma_ultra >> 11) & 7) ? ide_dma_on :
-			((id->dma_ultra >> 8) & 7) ? ide_dma_on :
-			((id->dma_mword >> 8) & 7) ? ide_dma_on :
-						     ide_dma_off_quietly);
 
-	return rval;
+	if (func == ide_dma_check) {
+
+		short w80 = HWIF(drive)->udma_four;
+
+		short speed = ide_find_best_mode(drive,
+			XFER_PIO | XFER_EPIO | XFER_MWDMA | XFER_UDMA |
+			((amd_config->flags & AMD_BAD_SWDMA) ? 0 : XFER_SWDMA) |
+			(w80 && (amd_config->flags & AMD_UDMA) >= AMD_UDMA_66 ? XFER_UDMA_66 : 0) |
+			(w80 && (amd_config->flags & AMD_UDMA) >= AMD_UDMA_100 ? XFER_UDMA_100 : 0));
+
+		amd_set_drive(drive, speed);
+
+		func = (HWIF(drive)->autodma && (speed & XFER_MODE) != XFER_PIO)
+			? ide_dma_on : ide_dma_off_quietly;
+	}
+
+	return ide_dmaproc(func, drive);
 }
 
-static int config_drive_xfer_rate (ide_drive_t *drive)
+#endif /* CONFIG_BLK_DEV_IDEDMA */
+
+/*
+ * The initialization callback. Here we determine the IDE chip type
+ * and initialize its drive independent registers.
+ */
+
+unsigned int __init pci_init_amd74xx(struct pci_dev *dev, const char *name)
 {
-	struct hd_driveid *id = drive->id;
-	ide_dma_action_t dma_func = ide_dma_on;
+	unsigned char t;
+	unsigned int u;
+	int i;
 
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
-				dma_func = config_chipset_for_dma(drive);
-				if ((id->field_valid & 2) &&
-				    (dma_func != ide_dma_on))
-					goto try_dma_modes;
-			}
-		} else if (id->field_valid & 2) {
-try_dma_modes:
-			if ((id->dma_mword & 0x0007) ||
-			    ((id->dma_1word & 0x007) &&
-			     (amd74xx_swdma_check(HWIF(drive)->pci_dev)))) {
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
+/*
+ * Find out what AMD IDE is this.
+ */
+
+	for (amd_config = amd_ide_chips; amd_config->id; amd_config++) {
+			pci_read_config_byte(dev, PCI_REVISION_ID, &t);
+			if (dev->device == amd_config->id && t >= amd_config->rev)
+				break;
 		}
-	} else if ((id->capability & 8) || (id->field_valid & 2)) {
-fast_ata_pio:
-		dma_func = ide_dma_off_quietly;
-no_dma_set:
 
-		config_chipset_for_pio(drive);
+	if (!amd_config->id) {
+		printk(KERN_WARNING "AMD_IDE: Unknown AMD IDE Chip, contact Vojtech Pavlik <vojtech@ucw.cz>\n");
+		return -ENODEV;
 	}
-	return HWIF(drive)->dmaproc(dma_func, drive);
-}
 
 /*
- * amd74xx_dmaproc() initiates/aborts (U)DMA read/write operations on a drive.
+ * Check 80-wire cable presence.
  */
 
-int amd74xx_dmaproc (ide_dma_action_t func, ide_drive_t *drive)
-{
-	switch (func) {
-		case ide_dma_check:
-			return config_drive_xfer_rate(drive);
-		default:
+	switch (amd_config->flags & AMD_UDMA) {
+
+		case AMD_UDMA_100:
+			pci_read_config_byte(dev, AMD_CABLE_DETECT, &t);
+			amd_80w = ((u & 0x3) ? 1 : 0) | ((u & 0xc) ? 2 : 0);
+			for (i = 24; i >= 0; i -= 8)
+				if (((u >> i) & 4) && !(amd_80w & (1 << (1 - (i >> 4))))) {
+					printk(KERN_WARNING "AMD_IDE: Bios didn't set cable bits corectly. Enabling workaround.\n");
+					amd_80w |= (1 << (1 - (i >> 4)));
+				}
+			break;
+
+		case AMD_UDMA_66:
+			pci_read_config_dword(dev, AMD_UDMA_TIMING, &u);
+			for (i = 24; i >= 0; i -= 8)
+				if ((u >> i) & 4)
+					amd_80w |= (1 << (1 - (i >> 4)));
 			break;
 	}
-	return ide_dmaproc(func, drive);	/* use standard DMA stuff */
-}
-#endif /* CONFIG_BLK_DEV_IDEDMA */
 
-unsigned int __init pci_init_amd74xx(struct pci_dev *dev)
-{
-	unsigned long fixdma_base = pci_resource_start(dev, 4);
+	pci_read_config_dword(dev, AMD_IDE_ENABLE, &u);
+	amd_enabled = ((u & 1) ? 2 : 0) | ((u & 2) ? 1 : 0);
 
-#ifdef CONFIG_BLK_DEV_IDEDMA
-	if (!amd74xx_swdma_check(dev))
-		printk("%s: disabling single-word DMA support (revision < C4)\n", dev->name);
-#endif /* CONFIG_BLK_DEV_IDEDMA */
+/*
+ * Take care of prefetch & postwrite.
+ */
 
-	if (!fixdma_base) {
-		/*
-		 *
-		 */
-	} else {
-		/*
-		 * enable DMA capable bit, and "not" simplex only
-		 */
-		outb(inb(fixdma_base+2) & 0x60, fixdma_base+2);
+	pci_read_config_byte(dev, AMD_IDE_CONFIG, &t);
+	pci_write_config_byte(dev, AMD_IDE_CONFIG,
+		(amd_config->flags & AMD_BAD_FIFO) ? (t & 0x0f) : (t | 0xf0));
 
-		if (inb(fixdma_base+2) & 0x80)
-			printk("%s: simplex device: DMA will fail!!\n", dev->name);
+/*
+ * Determine the system bus clock.
+ */
+
+	amd_clock = system_bus_speed * 1000;
+
+	switch (amd_clock) {
+		case 33000: amd_clock = 33333; break;
+		case 37000: amd_clock = 37500; break;
+		case 41000: amd_clock = 41666; break;
 	}
-#if defined(DISPLAY_VIPER_TIMINGS) && defined(CONFIG_PROC_FS)
+
+	if (amd_clock < 20000 || amd_clock > 50000) {
+		printk(KERN_WARNING "AMD_IDE: User given PCI clock speed impossible (%d), using 33 MHz instead.\n", amd_clock);
+		printk(KERN_WARNING "AMD_IDE: Use ide0=ata66 if you want to assume 80-wire cable\n");
+		amd_clock = 33333;
+	}
+
+/*
+ * Print the boot message.
+ */
+
+	pci_read_config_byte(dev, PCI_REVISION_ID, &t);
+	printk(KERN_INFO "AMD_IDE: AMD-%s (rev %02x) IDE %s controller on pci%s\n",
+		amd_config->name, t, amd_dma[amd_config->flags & AMD_UDMA], dev->slot_name);
+
+/*
+ * Register /proc/ide/amd74xx entry
+ */
+
+#ifdef CONFIG_PROC_FS
 	if (!amd74xx_proc) {
-		amd74xx_proc = 1;
+		amd_base = pci_resource_start(dev, 4);
 		bmide_dev = dev;
-		amd74xx_display_info = &amd74xx_get_info;
+		amd74xx_display_info = &amd_get_info;
+		amd74xx_proc = 1;
 	}
-#endif /* DISPLAY_VIPER_TIMINGS && CONFIG_PROC_FS */
+#endif
 
 	return 0;
 }
 
-unsigned int __init ata66_amd74xx (ide_hwif_t *hwif)
+unsigned int __init ata66_amd74xx(ide_hwif_t *hwif)
 {
-#ifdef CONFIG_AMD74XX_OVERRIDE
-	byte ata66 = 1;
-#else
-	byte ata66 = 0;
-#endif /* CONFIG_AMD74XX_OVERRIDE */
-
-#if 0
-	pci_read_config_byte(hwif->pci_dev, 0x48, &ata66);
-	return ((ata66 & 0x02) ? 0 : 1);
-#endif
-	return ata66;
+	return ((amd_enabled & amd_80w) >> hwif->channel) & 1;
 }
 
-void __init ide_init_amd74xx (ide_hwif_t *hwif)
+void __init ide_init_amd74xx(ide_hwif_t *hwif)
 {
-	hwif->tuneproc = &amd74xx_tune_drive;
-	hwif->speedproc = &amd74xx_tune_chipset;
+	int i;
 
-	hwif->highmem = 1;
-
-#ifndef CONFIG_BLK_DEV_IDEDMA
-	hwif->drives[0].autotune = 1;
-	hwif->drives[1].autotune = 1;
+	hwif->tuneproc = &amd74xx_tune_drive;
+	hwif->speedproc = &amd_set_drive;
 	hwif->autodma = 0;
-	return;
-#else
 
+	for (i = 0; i < 2; i++) {
+		hwif->drives[i].io_32bit = 1;
+		hwif->drives[i].unmask = 1;
+		hwif->drives[i].autotune = 1;
+		hwif->drives[i].dn = hwif->channel * 2 + i;
+	}
+
+#ifdef CONFIG_BLK_DEV_IDEDMA
 	if (hwif->dma_base) {
+		hwif->highmem = 1;
 		hwif->dmaproc = &amd74xx_dmaproc;
+#ifdef CONFIG_IDEDMA_AUTO
 		if (!noautodma)
 			hwif->autodma = 1;
-	} else {
-		hwif->autodma = 0;
-		hwif->drives[0].autotune = 1;
-		hwif->drives[1].autotune = 1;
+#endif
 	}
 #endif /* CONFIG_BLK_DEV_IDEDMA */
 }
 
-void __init ide_dmacapable_amd74xx (ide_hwif_t *hwif, unsigned long dmabase)
+/*
+ * We allow the BM-DMA driver only work on enabled interfaces.
+ */
+
+void __init ide_dmacapable_amd74xx(ide_hwif_t *hwif, unsigned long dmabase)
 {
-	ide_setup_dma(hwif, dmabase, 8);
+	if ((amd_enabled >> hwif->channel) & 1)
+		ide_setup_dma(hwif, dmabase, 8);
 }
diff -urN linux-2.5.6/drivers/ide/ide-pci.c linux-2.5.6-amdide/drivers/ide/ide-pci.c
--- linux-2.5.6/drivers/ide/ide-pci.c	Mon Mar 11 08:46:22 2002
+++ linux-2.5.6-amdide/drivers/ide/ide-pci.c	Mon Mar 11 15:57:33 2002
@@ -284,10 +284,11 @@
 	{PCI_VENDOR_ID_CYRIX, PCI_DEVICE_ID_CYRIX_5530_IDE, pci_init_cs5530, NULL, ide_init_cs5530, NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, ON_BOARD, 0, ATA_F_DMA },
 #endif
 #ifdef CONFIG_BLK_DEV_AMD74XX
-	{PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_COBRA_7401, NULL, NULL, NULL, ide_dmacapable_amd74xx, {{0x40,0x01,0x01}, {0x40,0x02,0x02}}, ON_BOARD, 0, 0 },
+	{PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_COBRA_7401, pci_init_amd74xx, ata66_amd74xx, ide_init_amd74xx, ide_dmacapable_amd74xx, {{0x40,0x01,0x01}, {0x40,0x02,0x02}}, ON_BOARD, 0, 0 },
 	{PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_VIPER_7409, pci_init_amd74xx, ata66_amd74xx, ide_init_amd74xx, ide_dmacapable_amd74xx, {{0x40,0x01,0x01}, {0x40,0x02,0x02}}, ON_BOARD, 0, 0 },
 	{PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_VIPER_7411, pci_init_amd74xx, ata66_amd74xx, ide_init_amd74xx, ide_dmacapable_amd74xx, {{0x40,0x01,0x01}, {0x40,0x02,0x02}}, ON_BOARD, 0, 0 },
-	{PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_VIPER_7441, pci_init_amd74xx, ata66_amd74xx, ide_init_amd74xx, ide_dmacapable_amd74xx, {{0x40,0x01,0x01}, {0x40,0x02,0x02}}, ON_BOARD, 0, 0 },
+	{PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_OPUS_7441, pci_init_amd74xx, ata66_amd74xx, ide_init_amd74xx, ide_dmacapable_amd74xx, {{0x40,0x01,0x01}, {0x40,0x02,0x02}}, ON_BOARD, 0, 0 },
+	{PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_8111_IDE, pci_init_amd74xx, ata66_amd74xx, ide_init_amd74xx, ide_dmacapable_amd74xx, {{0x40,0x01,0x01}, {0x40,0x02,0x02}}, ON_BOARD, 0, 0 },
 #endif
 #ifdef CONFIG_BLK_DEV_PDC_ADMA
 	{PCI_VENDOR_ID_PDC, PCI_DEVICE_ID_PDC_1841, pci_init_pdcadma, ata66_pdcadma, ide_init_pdcadma, ide_dmacapable_pdcadma, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, OFF_BOARD, 0, ATA_F_NODMA },
diff -urN linux-2.5.6/include/linux/pci_ids.h linux-2.5.6-amdide/include/linux/pci_ids.h
--- linux-2.5.6/include/linux/pci_ids.h	Mon Mar 11 08:46:23 2002
+++ linux-2.5.6-amdide/include/linux/pci_ids.h	Mon Mar 11 15:48:59 2002
@@ -383,11 +383,14 @@
 #define PCI_DEVICE_ID_AMD_VIPER_7411	0x7411
 #define PCI_DEVICE_ID_AMD_VIPER_7413	0x7413
 #define PCI_DEVICE_ID_AMD_VIPER_7414	0x7414
-#define PCI_DEVICE_ID_AMD_VIPER_7440	0x7440
-#define PCI_DEVICE_ID_AMD_VIPER_7441	0x7441
-#define PCI_DEVICE_ID_AMD_VIPER_7443	0x7443
-#define PCI_DEVICE_ID_AMD_VIPER_7448	0x7448
-#define PCI_DEVICE_ID_AMD_VIPER_7449	0x7449
+#define PCI_DEVICE_ID_AMD_OPUS_7440	0x7440
+#define PCI_DEVICE_ID_AMD_OPUS_7441	0x7441
+#define PCI_DEVICE_ID_AMD_OPUS_7443	0x7443
+#define PCI_DEVICE_ID_AMD_OPUS_7448	0x7448
+#define PCI_DEVICE_ID_AMD_OPUS_7449	0x7449
+#define PCI_DEVICE_ID_AMD_8111_LAN	0x7462
+#define PCI_DEVICE_ID_AMD_8111_IDE	0x7469
+#define PCI_DEVICE_ID_AMD_8111_AUDIO	0x746d
 
 #define PCI_VENDOR_ID_TRIDENT		0x1023
 #define PCI_DEVICE_ID_TRIDENT_4DWAVE_DX	0x2000

--uAKRQypu60I7Lcqm--
