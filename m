Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317829AbSGKLW2>; Thu, 11 Jul 2002 07:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317833AbSGKLW1>; Thu, 11 Jul 2002 07:22:27 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:15112 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S317829AbSGKLWA>; Thu, 11 Jul 2002 07:22:00 -0400
Subject: Re: ATAPI + cdwriter problem
To: mistral@stev.org (James Stevenson)
Date: Thu, 11 Jul 2002 12:47:52 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <002d01c22882$f17436e0$0501a8c0@Stev.org> from "James Stevenson" at Jul 11, 2002 03:30:37 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17ScQK-0000ih-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> i also have now tried this under 2.4.19-rc1 which produces the same
> problems.

Apply the diff below then retry. Let people know if it fixes your atapi 
problem

diff -urN linux-2.4.19pre10/MAINTAINERS linux/MAINTAINERS
--- linux-2.4.19pre10/MAINTAINERS	Tue Jun 18 11:35:12 2002
+++ linux/MAINTAINERS	Thu Jun 27 19:50:57 2002
@@ -1291,6 +1291,17 @@
 W:	http://www.pnd-pc.demon.co.uk/promise/
 S:	Maintained
 
+PROMISE PDC202XX IDE CONTROLLER DRIVER
+P:	Hank Yang
+M:	support@promise.com.tw [TAIWAN]
+P:	Jordan Rhody
+M:	support@promise.com [U.S.A]
+P:	Jack Hu
+M:	support-china@promise.com [CHINA]
+W:	http://www.promise.com/support/linux_eng.asp
+W:	http://www.promise.com.tw/support/linux_eng.asp
+S:	Maintained
+
 QNX4 FILESYSTEM
 P:	Anders Larsen
 M:	al@alarsen.net
diff -urN linux-2.4.19pre10/drivers/ide/ide-features.c linux/drivers/ide/ide-features.c
--- linux-2.4.19pre10/drivers/ide/ide-features.c	Tue Jun 18 11:35:15 2002
+++ linux/drivers/ide/ide-features.c	Thu Jul  4 00:48:30 2002
@@ -245,6 +245,9 @@
  */
 byte eighty_ninty_three (ide_drive_t *drive)
 {
+	if (HWIF(drive)->pci_devid.vid==0x105a)
+	    return(HWIF(drive)->udma_four);
+	/* PDC202XX: that's because some HDD will return wrong info */
 	return ((byte) ((HWIF(drive)->udma_four) &&
 #ifndef CONFIG_IDEDMA_IVB
 			(drive->id->hw_config & 0x4000) &&
diff -urN linux-2.4.19pre10/drivers/ide/ide-pci.c linux/drivers/ide/ide-pci.c
--- linux-2.4.19pre10/drivers/ide/ide-pci.c	Tue Jun 18 11:35:15 2002
+++ linux/drivers/ide/ide-pci.c	Fri Jul  5 02:25:04 2002
@@ -12,13 +12,6 @@
  *  configuration of all PCI IDE interfaces present in a system.  
  */
 
-/*
- * Chipsets that are on the IDE_IGNORE list because of problems of not being
- * set at compile time.
- *
- * CONFIG_BLK_DEV_PDC202XX
- */
-
 #include <linux/config.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
@@ -54,7 +47,7 @@
 #define DEVID_PDC20265	((ide_pci_devid_t){PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20265})
 #define DEVID_PDC20267	((ide_pci_devid_t){PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20267})
 #define DEVID_PDC20268  ((ide_pci_devid_t){PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20268})
-#define DEVID_PDC20268R ((ide_pci_devid_t){PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20268R})
+#define DEVID_PDC20270  ((ide_pci_devid_t){PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20270})
 #define DEVID_PDC20269	((ide_pci_devid_t){PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20269})
 #define DEVID_PDC20275	((ide_pci_devid_t){PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20275})
 #define DEVID_PDC20276	((ide_pci_devid_t){PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20276})
@@ -255,9 +248,9 @@
 #define ATA66_PDC202XX	&ata66_pdc202xx
 #define INIT_PDC202XX	&ide_init_pdc202xx
 #else
-#define PCI_PDC202XX	IDE_IGNORE
-#define ATA66_PDC202XX	IDE_IGNORE
-#define INIT_PDC202XX	IDE_IGNORE
+#define PCI_PDC202XX	NULL
+#define ATA66_PDC202XX	NULL
+#define INIT_PDC202XX	NULL
 #endif
 
 #ifdef CONFIG_BLK_DEV_PIIX
@@ -420,7 +413,7 @@
 	/* Promise used a different PCI ident for the raid card apparently to try and
 	   prevent Linux detecting it and using our own raid code. We want to detect
 	   it for the ataraid drivers, so we have to list both here.. */
-	{DEVID_PDC20268R,"PDC20270",	PCI_PDC202XX,	ATA66_PDC202XX,	INIT_PDC202XX,	NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	OFF_BOARD,	0 },
+	{DEVID_PDC20270,"PDC20270",	PCI_PDC202XX,	ATA66_PDC202XX,	INIT_PDC202XX,	NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	OFF_BOARD,	0 },
 	{DEVID_PDC20269,"PDC20269",	PCI_PDC202XX,	ATA66_PDC202XX,	 INIT_PDC202XX,	NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	OFF_BOARD,	0 },
 	{DEVID_PDC20275,"PDC20275",	PCI_PDC202XX,	ATA66_PDC202XX,	INIT_PDC202XX,	NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	OFF_BOARD,	0 },
 	{DEVID_PDC20276,"PDC20276",	PCI_PDC202XX,	ATA66_PDC202XX,	INIT_PDC202XX,	NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	OFF_BOARD,	0 },
@@ -482,7 +475,7 @@
 		case PCI_DEVICE_ID_PROMISE_20265:
 		case PCI_DEVICE_ID_PROMISE_20267:
 		case PCI_DEVICE_ID_PROMISE_20268:
-		case PCI_DEVICE_ID_PROMISE_20268R:
+		case PCI_DEVICE_ID_PROMISE_20270:
 		case PCI_DEVICE_ID_PROMISE_20269:
 		case PCI_DEVICE_ID_PROMISE_20275:
 		case PCI_DEVICE_ID_PROMISE_20276:
@@ -672,25 +665,18 @@
 	 */
 	pciirq = dev->irq;
 	
-	if (dev->class >> 8 == PCI_CLASS_STORAGE_RAID)
-	{
-		/* By rights we want to ignore these, but the Promise Fastrak
-		   people have some strange ideas about proprietary so we have
-		   to act otherwise on those. The supertrak however we need
-		   to skip */
-		if (IDE_PCI_DEVID_EQ(d->devid, DEVID_PDC20265))
-		{
-			printk(KERN_INFO "ide: Found promise 20265 in RAID mode.\n");
-			if(dev->bus->self && dev->bus->self->vendor == PCI_VENDOR_ID_INTEL &&
-				dev->bus->self->device == PCI_DEVICE_ID_INTEL_I960)
-			{
-				printk(KERN_INFO "ide: Skipping Promise PDC20265 attached to I2O RAID controller.\n");
-				return;
-			}
+#ifdef CONFIG_PDC202XX_FORCE
+	if (dev->class >> 8 == PCI_CLASS_STORAGE_RAID) {
+		/*
+		 * By rights we want to ignore Promise FastTrak and SuperTrak
+		 * series here, those use own driver.
+		 */
+		if (dev->vendor == PCI_VENDOR_ID_PROMISE) {
+			printk(KERN_INFO "ide: Skipping Promise RAID controller.\n");
+			return;
 		}
-		/* Its attached to something else, just a random bridge. 
-		   Suspect a fastrak and fall through */
 	}
+#endif /* CONFIG_PDC202XX_FORCE */
 	if ((dev->class & ~(0xfa)) != ((PCI_CLASS_STORAGE_IDE << 8) | 5)) {
 		printk("%s: not 100%% native mode: will probe irqs later\n", d->name);
 		/*
@@ -812,7 +798,7 @@
 		    IDE_PCI_DEVID_EQ(d->devid, DEVID_PDC20265) ||
 		    IDE_PCI_DEVID_EQ(d->devid, DEVID_PDC20267) ||
 		    IDE_PCI_DEVID_EQ(d->devid, DEVID_PDC20268) ||
-		    IDE_PCI_DEVID_EQ(d->devid, DEVID_PDC20268R) ||
+		    IDE_PCI_DEVID_EQ(d->devid, DEVID_PDC20270) ||
 		    IDE_PCI_DEVID_EQ(d->devid, DEVID_PDC20269) ||
 		    IDE_PCI_DEVID_EQ(d->devid, DEVID_PDC20275) ||
 		    IDE_PCI_DEVID_EQ(d->devid, DEVID_PDC20276) ||
@@ -985,7 +971,7 @@
 		return;	/* UM8886A/BF pair */
 	else if (IDE_PCI_DEVID_EQ(d->devid, DEVID_HPT366))
 		hpt366_device_order_fixup(dev, d);
-	else if (IDE_PCI_DEVID_EQ(d->devid, DEVID_PDC20268R))
+	else if (IDE_PCI_DEVID_EQ(d->devid, DEVID_PDC20270))
 		pdc20270_device_order_fixup(dev, d);
 	else if (!IDE_PCI_DEVID_EQ(d->devid, IDE_PCI_DEVID_NULL) || (dev->class >> 8) == PCI_CLASS_STORAGE_IDE) {
 		if (IDE_PCI_DEVID_EQ(d->devid, IDE_PCI_DEVID_NULL))
diff -urN linux-2.4.19pre10/drivers/ide/pdc202xx.c linux/drivers/ide/pdc202xx.c
--- linux-2.4.19pre10/drivers/ide/pdc202xx.c	Tue Jun 18 11:35:16 2002
+++ linux/drivers/ide/pdc202xx.c	Fri Jul  5 02:37:08 2002
@@ -1,34 +1,59 @@
 /*
- *  linux/drivers/ide/pdc202xx.c	Version 0.30	Mar. 18, 2000
+ *  linux/drivers/ide/pdc202xx.c	Version 0.32	Feb. 27, 2002
  *
  *  Copyright (C) 1998-2000	Andre Hedrick <andre@linux-ide.org>
  *  May be copied or modified under the terms of the GNU General Public License
  *
- *  Promise Ultra33 cards with BIOS v1.20 through 1.28 will need this
+ *  Promise Ultra66 cards with BIOS v1.11 this
  *  compiled into the kernel if you have more than one card installed.
- *  Note that BIOS v1.29 is reported to fix the problem.  Since this is
- *  safe chipset tuning, including this support is harmless
  *
- *  Promise Ultra66 cards with BIOS v1.11 this
+ *  Promise Ultra100 cards with BIOS v2.01 this
  *  compiled into the kernel if you have more than one card installed.
  *
- *  Promise Ultra100 cards.
+ *  Promise Ultra100TX2 with BIOS v2.10 & Ultra133TX2 with BIOS v2.20
+ *  support 8 hard drives on UDMA mode.
  *
- *  The latest chipset code will support the following ::
- *  Three Ultra33 controllers and 12 drives.
- *  8 are UDMA supported and 4 are limited to DMA mode 2 multi-word.
- *  The 8/4 ratio is a BIOS code limit by promise.
+ *  Linux kernel will misunderstand FastTrak ATA-RAID series as Ultra
+ *  IDE Controller, UNLESS you enable "CONFIG_PDC202XX_FORCE"
+ *  That's you can use FastTrak ATA-RAID controllers as IDE controllers.
  *
- *  UNLESS you enable "CONFIG_PDC202XX_BURST"
+ *  History :
+ *  05/22/01    v1.20 b1
+ *           (1) support PDC20268
+ *           (2) fix cable judge function
+ *  08/22/01    v1.20 b2
+ *           (1) support ATA-133 PDC20269/75
+ *           (2) support UDMA Mode 6
+ *           (3) fix proc report information
+ *           (4) set ATA133 timing
+ *           (5) fix ultra dma bit 14 selectable
+ *           (6) support 32bit LBA
+ *  09/11/01    v1.20 b3 
+ *           (1) fix eighty_ninty_three()
+ *           (2) fix offset address 0x1c~0x1f
+ *  10/30/01    v1.20 b4
+ *           (1) fix 48bit LBA HOB bit
+ *           (2) force rescan drive under PIO modes if need
+ *  11/02/01    v1.20.0.5
+ *           (1) could be patched with ext3 filesystem code
+ *  11/06/01    v1.20.0.6
+ *           (1) fix LBA48 drive running without Promise controllers
+ *           (2) fix LBA48 drive running under PIO modes
+ *  01/28/02    v1.20.0.6
+ *           (1) release for linux IDE Group kernel 2.4.18
+ *           (2) add version and controller info to proc
+ *  05/23/02    v1.20.0.7
+ *           (1) disable PDC20262 running with 48bit
+ *           (2) Add quirk drive lists for PDC20265/67
  *
- */
-
-/*
- *  Portions Copyright (C) 1999 Promise Technology, Inc.
- *  Author: Frank Tiernan (frankt@promise.com)
+ *  Copyright (C) 1999-2002 Promise Technology, Inc.
+ *  Author: Frank Tiernan <frankt@promise.com>
+ *          PROMISE pdc202xx IDE Controller driver MAINTAINERS
  *  Released under terms of General Public License
  */
-
+ 
+#define VERSION	"1.20.0.7"
+#define VERDATE "2002-05-23"
 #include <linux/config.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
@@ -65,41 +90,8 @@
 extern int (*pdc202xx_display_info)(char *, char **, off_t, int); /* ide-proc.c */
 extern char *ide_media_verbose(ide_drive_t *);
 static struct pci_dev *bmide_dev;
-
-char *pdc202xx_pio_verbose (u32 drive_pci)
-{
-	if ((drive_pci & 0x000ff000) == 0x000ff000) return("NOTSET");
-	if ((drive_pci & 0x00000401) == 0x00000401) return("PIO 4");
-	if ((drive_pci & 0x00000602) == 0x00000602) return("PIO 3");
-	if ((drive_pci & 0x00000803) == 0x00000803) return("PIO 2");
-	if ((drive_pci & 0x00000C05) == 0x00000C05) return("PIO 1");
-	if ((drive_pci & 0x00001309) == 0x00001309) return("PIO 0");
-	return("PIO ?");
-}
-
-char *pdc202xx_dma_verbose (u32 drive_pci)
-{
-	if ((drive_pci & 0x00036000) == 0x00036000) return("MWDMA 2");
-	if ((drive_pci & 0x00046000) == 0x00046000) return("MWDMA 1");
-	if ((drive_pci & 0x00056000) == 0x00056000) return("MWDMA 0");
-	if ((drive_pci & 0x00056000) == 0x00056000) return("SWDMA 2");
-	if ((drive_pci & 0x00068000) == 0x00068000) return("SWDMA 1");
-	if ((drive_pci & 0x000BC000) == 0x000BC000) return("SWDMA 0");
-	return("PIO---");
-}
-
-char *pdc202xx_ultra_verbose (u32 drive_pci, u16 slow_cable)
-{
-	if ((drive_pci & 0x000ff000) == 0x000ff000)
-		return("NOTSET");
-	if ((drive_pci & 0x00012000) == 0x00012000)
-		return((slow_cable) ? "UDMA 2" : "UDMA 4");
-	if ((drive_pci & 0x00024000) == 0x00024000)
-		return((slow_cable) ? "UDMA 1" : "UDMA 3");
-	if ((drive_pci & 0x00036000) == 0x00036000)
-		return("UDMA 0");
-	return(pdc202xx_dma_verbose(drive_pci));
-}
+static struct hd_driveid *id[4];
+static int speed_rate[4];
 
 static char * pdc202xx_info (char *buf, struct pci_dev *dev)
 {
@@ -107,8 +99,10 @@
 
 	u32 bibma  = pci_resource_start(dev, 4);
 	u32 reg60h = 0, reg64h = 0, reg68h = 0, reg6ch = 0;
-	u16 reg50h = 0, pmask = (1<<10), smask = (1<<11);
-	u8 hi = 0, lo = 0;
+	u16 reg50h = 0;
+	u16 word88 = 0;
+	int udmasel[4] = {0,0,0,0}, piosel[4] = {0,0,0,0};
+	int i = 0, hd = 0;
 
         /*
          * at that point bibma+0x2 et bibma+0xa are byte registers
@@ -120,10 +114,10 @@
 	u8 sc11	= inb_p((unsigned short)bibma + 0x11);
 	u8 sc1a	= inb_p((unsigned short)bibma + 0x1a);
 	u8 sc1b	= inb_p((unsigned short)bibma + 0x1b);
-	u8 sc1c	= inb_p((unsigned short)bibma + 0x1c); 
+	/* u8 sc1c	= inb_p((unsigned short)bibma + 0x1c); 
 	u8 sc1d	= inb_p((unsigned short)bibma + 0x1d);
 	u8 sc1e	= inb_p((unsigned short)bibma + 0x1e);
-	u8 sc1f	= inb_p((unsigned short)bibma + 0x1f);
+	u8 sc1f	= inb_p((unsigned short)bibma + 0x1f); */
 
 	pci_read_config_word(dev, 0x50, &reg50h);
 	pci_read_config_dword(dev, 0x60, &reg60h);
@@ -131,40 +125,35 @@
 	pci_read_config_dword(dev, 0x68, &reg68h);
 	pci_read_config_dword(dev, 0x6c, &reg6ch);
 
+	p+=sprintf(p, "\nPROMISE Ultra series driver Ver %s %s Adapter: ", VERSION, VERDATE);
 	switch(dev->device) {
+		case PCI_DEVICE_ID_PROMISE_20275:
+			p += sprintf(p, "MBUltra133\n");
+			break;
+		case PCI_DEVICE_ID_PROMISE_20269:
+			p += sprintf(p, "Ultra133 TX2\n");
+			break;
+		case PCI_DEVICE_ID_PROMISE_20268:
+			p += sprintf(p, "Ultra100 TX2\n");
+			break;
 		case PCI_DEVICE_ID_PROMISE_20267:
-			p += sprintf(p, "\n                                PDC20267 Chipset.\n");
+			p += sprintf(p, "Ultra100\n");
 			break;
 		case PCI_DEVICE_ID_PROMISE_20265:
-			p += sprintf(p, "\n                                PDC20265 Chipset.\n");
+			p += sprintf(p, "Ultra100 on M/B\n");
 			break;
 		case PCI_DEVICE_ID_PROMISE_20262:
-			p += sprintf(p, "\n                                PDC20262 Chipset.\n");
+			p += sprintf(p, "Ultra66\n");
 			break;
 		case PCI_DEVICE_ID_PROMISE_20246:
-			p += sprintf(p, "\n                                PDC20246 Chipset.\n");
+			p += sprintf(p, "Ultra33\n");
 			reg50h |= 0x0c00;
 			break;
 		default:
-			p += sprintf(p, "\n                                PDC202XX Chipset.\n");
+			p += sprintf(p, "Ultra Series\n");
 			break;
 	}
 
-	p += sprintf(p, "------------------------------- General Status ---------------------------------\n");
-	p += sprintf(p, "Burst Mode                           : %sabled\n", (sc1f & 0x01) ? "en" : "dis");
-	p += sprintf(p, "Host Mode                            : %s\n", (sc1f & 0x08) ? "Tri-Stated" : "Normal");
-	p += sprintf(p, "Bus Clocking                         : %s\n",
-		((sc1f & 0xC0) == 0xC0) ? "100 External" :
-		((sc1f & 0x80) == 0x80) ? "66 External" :
-		((sc1f & 0x40) == 0x40) ? "33 External" : "33 PCI Internal");
-	p += sprintf(p, "IO pad select                        : %s mA\n",
-		((sc1c & 0x03) == 0x03) ? "10" :
-		((sc1c & 0x02) == 0x02) ? "8" :
-		((sc1c & 0x01) == 0x01) ? "6" :
-		((sc1c & 0x00) == 0x00) ? "4" : "??");
-	SPLIT_BYTE(sc1e, hi, lo);
-	p += sprintf(p, "Status Polling Period                : %d\n", hi);
-	p += sprintf(p, "Interrupt Check Status Polling Delay : %d\n", lo);
 	p += sprintf(p, "--------------- Primary Channel ---------------- Secondary Channel -------------\n");
 	p += sprintf(p, "                %s                         %s\n",
 		(c0&0x80)?"disabled":"enabled ",
@@ -172,84 +161,39 @@
 	p += sprintf(p, "66 Clocking     %s                         %s\n",
 		(sc11&0x02)?"enabled ":"disabled",
 		(sc11&0x08)?"enabled ":"disabled");
-	p += sprintf(p, "           Mode %s                      Mode %s\n",
+	p += sprintf(p, "Mode            %s                           %s\n",
 		(sc1a & 0x01) ? "MASTER" : "PCI   ",
 		(sc1b & 0x01) ? "MASTER" : "PCI   ");
-	p += sprintf(p, "                %s                     %s\n",
-		(sc1d & 0x08) ? "Error       " :
-		((sc1d & 0x05) == 0x05) ? "Not My INTR " :
-		(sc1d & 0x04) ? "Interrupting" :
-		(sc1d & 0x02) ? "FIFO Full   " :
-		(sc1d & 0x01) ? "FIFO Empty  " : "????????????",
-		(sc1d & 0x80) ? "Error       " :
-		((sc1d & 0x50) == 0x50) ? "Not My INTR " :
-		(sc1d & 0x40) ? "Interrupting" :
-		(sc1d & 0x20) ? "FIFO Full   " :
-		(sc1d & 0x10) ? "FIFO Empty  " : "????????????");
 	p += sprintf(p, "--------------- drive0 --------- drive1 -------- drive0 ---------- drive1 ------\n");
 	p += sprintf(p, "DMA enabled:    %s              %s             %s               %s\n",
-		(c0&0x20)?"yes":"no ",(c0&0x40)?"yes":"no ",(c1&0x20)?"yes":"no ",(c1&0x40)?"yes":"no ");
-	p += sprintf(p, "DMA Mode:       %s           %s          %s            %s\n",
-		pdc202xx_ultra_verbose(reg60h, (reg50h & pmask)),
-		pdc202xx_ultra_verbose(reg64h, (reg50h & pmask)),
-		pdc202xx_ultra_verbose(reg68h, (reg50h & smask)),
-		pdc202xx_ultra_verbose(reg6ch, (reg50h & smask)));
-	p += sprintf(p, "PIO Mode:       %s            %s           %s            %s\n",
-		pdc202xx_pio_verbose(reg60h),
-		pdc202xx_pio_verbose(reg64h),
-		pdc202xx_pio_verbose(reg68h),
-		pdc202xx_pio_verbose(reg6ch));
+		(id[0]!=NULL && (c0&0x20))?"yes":"no ",(id[1]!=NULL && (c0&0x40))?"yes":"no ",
+		(id[2]!=NULL && (c1&0x20))?"yes":"no ",(id[3]!=NULL && (c1&0x40))?"yes":"no ");
+	for( hd = 0; hd < 4 ; hd++) {
+		if (id[hd] == NULL)
+			continue;
+		word88 = id[hd]->dma_ultra;
+		for ( i = 7 ; i >= 0 ; i--)
+			if (word88 >> (i+8)) {
+				udmasel[hd] = i;	/* get select UDMA mode */
+				break;
+			}
+		piosel[hd] = (id[hd]->eide_pio_modes >= 0x02) ? 4 : 3;
+        }
+	p += sprintf(p, "UDMA Mode:      %d                %d               %d                 %d\n",
+		udmasel[0], udmasel[1], udmasel[2], udmasel[3]);
+	p += sprintf(p, "PIO Mode:       %d                %d               %d                 %d\n",
+		piosel[0], piosel[1], piosel[2], piosel[3]);
 #if 0
 	p += sprintf(p, "--------------- Can ATAPI DMA ---------------\n");
 #endif
 	return (char *)p;
 }
 
-static char * pdc202xx_info_new (char *buf, struct pci_dev *dev)
-{
-	char *p = buf;
-//	u32 bibma = pci_resource_start(dev, 4);
-
-//	u32 reg60h = 0, reg64h = 0, reg68h = 0, reg6ch = 0;
-//	u16 reg50h = 0, word88 = 0;
-//	int udmasel[4]={0,0,0,0}, piosel[4]={0,0,0,0}, i=0, hd=0;
-
-	switch(dev->device) {
-		case PCI_DEVICE_ID_PROMISE_20276:
-			p += sprintf(p, "\n                                PDC20276 Chipset.\n");
-			break;
-		case PCI_DEVICE_ID_PROMISE_20275:
-			p += sprintf(p, "\n                                PDC20275 Chipset.\n");
-			break;
-		case PCI_DEVICE_ID_PROMISE_20269:
-			p += sprintf(p, "\n                                PDC20269 TX2 Chipset.\n");
-			break;
-		case PCI_DEVICE_ID_PROMISE_20268:
-		case PCI_DEVICE_ID_PROMISE_20268R:
-			p += sprintf(p, "\n                                PDC20268 TX2 Chipset.\n");
-			break;
-default:
-			p += sprintf(p, "\n                                PDC202XX Chipset.\n");
-			break;
-	}
-	return (char *)p;
-}
-
 static int pdc202xx_get_info (char *buffer, char **addr, off_t offset, int count)
 {
 	char *p = buffer;
-	switch(bmide_dev->device) {
-		case PCI_DEVICE_ID_PROMISE_20276:
-		case PCI_DEVICE_ID_PROMISE_20275:
-		case PCI_DEVICE_ID_PROMISE_20269:
-		case PCI_DEVICE_ID_PROMISE_20268:
-		case PCI_DEVICE_ID_PROMISE_20268R:
-			p = pdc202xx_info_new(buffer, bmide_dev);
-			break;
-		default:
-			p = pdc202xx_info(buffer, bmide_dev);
-			break;
-	}
+	
+	p = pdc202xx_info(buffer, bmide_dev);
 	return p-buffer;	/* => must be less than 4k! */
 }
 #endif  /* defined(DISPLAY_PDC202XX_TIMINGS) && defined(CONFIG_PROC_FS) */
@@ -259,7 +203,9 @@
 const char *pdc_quirk_drives[] = {
 	"QUANTUM FIREBALLlct08 08",
 	"QUANTUM FIREBALLP KA6.4",
+	"QUANTUM FIREBALLP KA9.1",
 	"QUANTUM FIREBALLP LM20.4",
+	"QUANTUM FIREBALLP KX13.6",
 	"QUANTUM FIREBALLP KX20.5",
 	"QUANTUM FIREBALLP KX27.3",
 	"QUANTUM FIREBALLP LM20.5",
@@ -404,7 +350,7 @@
 	struct pci_dev *dev	= hwif->pci_dev;
 
 	unsigned int		drive_conf;
-	int			err;
+	int			err = 0, i = 0, j = hwif->channel ? 2 : 0 ;
 	byte			drive_pci, AP, BP, CP, DP;
 	byte			TA = 0, TB = 0, TC = 0;
 
@@ -458,6 +404,10 @@
 	pci_read_config_byte(dev, (drive_pci)|0x01, &BP);
 	pci_read_config_byte(dev, (drive_pci)|0x02, &CP);
 
+	for ( i = 0; i < 2; i++)
+		if (hwif->drives[i].present)
+	  		id[i+j] = hwif->drives[i].id;	/* get identify structs */
+
 	switch(speed) {
 #ifdef CONFIG_BLK_DEV_IDEDMA
 		/* case XFER_UDMA_6: */
@@ -535,142 +485,157 @@
 #endif /* CONFIG_BLK_DEV_IDEDMA */
 	byte thold		= 0x10;
 	byte adj		= (drive->dn%2) ? 0x08 : 0x00;
-
+	int set_speed		= 0, i=0, j=hwif->channel ? 2:0;
 	int                     err;
 
-#ifdef CONFIG_BLK_DEV_IDEDMA
+	/* Setting tHOLD bit to 0 if using UDMA mode 2 */
 	if (speed == XFER_UDMA_2) {
 		OUT_BYTE((thold + adj), indexreg);
 		OUT_BYTE((IN_BYTE(datareg) & 0x7f), datareg);
 	}
-	switch (speed) {
-		case XFER_UDMA_7:
-			speed = XFER_UDMA_6;
-		case XFER_UDMA_6:
-			OUT_BYTE((0x10 + adj), indexreg);
-			OUT_BYTE(0x1a, datareg);
-			OUT_BYTE((0x11 + adj), indexreg);
-			OUT_BYTE(0x01, datareg);
-			OUT_BYTE((0x12 + adj), indexreg);
-			OUT_BYTE(0xcb, datareg);
-			break;
-		case XFER_UDMA_5:
-			OUT_BYTE((0x10 + adj), indexreg);
-			OUT_BYTE(0x1a, datareg);
-			OUT_BYTE((0x11 + adj), indexreg);
-			OUT_BYTE(0x02, datareg);
-			OUT_BYTE((0x12 + adj), indexreg);
-			OUT_BYTE(0xcb, datareg);
-			break;
-		case XFER_UDMA_4:
-			OUT_BYTE((0x10 + adj), indexreg);
-			OUT_BYTE(0x1a, datareg);
-			OUT_BYTE((0x11 + adj), indexreg);
-			OUT_BYTE(0x03, datareg);
-			OUT_BYTE((0x12 + adj), indexreg);
-			OUT_BYTE(0xcd, datareg);
-			break;
-		case XFER_UDMA_3:
-			OUT_BYTE((0x10 + adj), indexreg);
-			OUT_BYTE(0x1a, datareg);
-			OUT_BYTE((0x11 + adj), indexreg);
-			OUT_BYTE(0x05, datareg);
-			OUT_BYTE((0x12 + adj), indexreg);
-			OUT_BYTE(0xcd, datareg);
-			break;
-		case XFER_UDMA_2:
-			OUT_BYTE((0x10 + adj), indexreg);
-			OUT_BYTE(0x2a, datareg);
-			OUT_BYTE((0x11 + adj), indexreg);
-			OUT_BYTE(0x07, datareg);
-			OUT_BYTE((0x12 + adj), indexreg);
-			OUT_BYTE(0xcd, datareg);
-			break;
-		case XFER_UDMA_1:
-			OUT_BYTE((0x10 + adj), indexreg);
-			OUT_BYTE(0x3a, datareg);
-			OUT_BYTE((0x11 + adj), indexreg);
-			OUT_BYTE(0x0a, datareg);
-			OUT_BYTE((0x12 + adj), indexreg);
-			OUT_BYTE(0xd0, datareg);
-			break;
-		case XFER_UDMA_0:
-			OUT_BYTE((0x10 + adj), indexreg);
-			OUT_BYTE(0x4a, datareg);
-			OUT_BYTE((0x11 + adj), indexreg);
-			OUT_BYTE(0x0f, datareg);
-			OUT_BYTE((0x12 + adj), indexreg);
-			OUT_BYTE(0xd5, datareg);
-			break;
-		case XFER_MW_DMA_2:
-			OUT_BYTE((0x0e + adj), indexreg);
-			OUT_BYTE(0x69, datareg);
-			OUT_BYTE((0x0f + adj), indexreg);
-			OUT_BYTE(0x25, datareg);
-			break;
-		case XFER_MW_DMA_1:
-			OUT_BYTE((0x0e + adj), indexreg);
-			OUT_BYTE(0x6b, datareg);
-			OUT_BYTE((0x0f+ adj), indexreg);
-			OUT_BYTE(0x27, datareg);
-			break;
-		case XFER_MW_DMA_0:
-			OUT_BYTE((0x0e + adj), indexreg);
-			OUT_BYTE(0xdf, datareg);
-			OUT_BYTE((0x0f + adj), indexreg);
-			OUT_BYTE(0x5f, datareg);
-			break;
-#else
-	switch (speed) {
-#endif /* CONFIG_BLK_DEV_IDEDMA */
-		case XFER_PIO_4:
-			OUT_BYTE((0x0c + adj), indexreg);
-			OUT_BYTE(0x23, datareg);
-			OUT_BYTE((0x0d + adj), indexreg);
-			OUT_BYTE(0x09, datareg);
-			OUT_BYTE((0x13 + adj), indexreg);
-			OUT_BYTE(0x25, datareg);
-			break;
-		case XFER_PIO_3:
-			OUT_BYTE((0x0c + adj), indexreg);
-			OUT_BYTE(0x27, datareg);
-			OUT_BYTE((0x0d + adj), indexreg);
-			OUT_BYTE(0x0d, datareg);
-			OUT_BYTE((0x13 + adj), indexreg);
-			OUT_BYTE(0x35, datareg);
-			break;
-		case XFER_PIO_2:
-			OUT_BYTE((0x0c + adj), indexreg);
-			OUT_BYTE(0x23, datareg);
-			OUT_BYTE((0x0d + adj), indexreg);
-			OUT_BYTE(0x26, datareg);
-			OUT_BYTE((0x13 + adj), indexreg);
-			OUT_BYTE(0x64, datareg);
-			break;
-		case XFER_PIO_1:
-			OUT_BYTE((0x0c + adj), indexreg);
-			OUT_BYTE(0x46, datareg);
-			OUT_BYTE((0x0d + adj), indexreg);
-			OUT_BYTE(0x29, datareg);
-			OUT_BYTE((0x13 + adj), indexreg);
-			OUT_BYTE(0xa4, datareg);
-			break;
-		case XFER_PIO_0:
-			OUT_BYTE((0x0c + adj), indexreg);
-			OUT_BYTE(0xfb, datareg);
-			OUT_BYTE((0x0d + adj), indexreg);
-			OUT_BYTE(0x2b, datareg);
-			OUT_BYTE((0x13 + adj), indexreg);
-			OUT_BYTE(0xac, datareg);
-			break;
-		default:
-	}
+	
+	/* We need to set ATA133 timing if ATA133 drives exist */
+	if (speed>=XFER_UDMA_6)
+		set_speed=1;
 
 	if (!drive->init_speed)
 		drive->init_speed = speed;
+#if PDC202XX_DEBUG_DRIVE_INFO
+	printk("%s: Before set_feature = %s, word88 = %#x\n",
+		drive->name, ide_xfer_verbose(speed), drive->id->dma_ultra );
+#endif /* PDC202XX_DEBUG_DRIVE_INFO */
 	err = ide_config_drive_speed(drive, speed);
-	drive->current_speed = speed;
-
+	drive->current_speed = speed;	
+	for ( i = 0 ; i < 2 ; i++)
+		if (hwif->drives[i].present) {
+	  		id[i+j] = hwif->drives[i].id;	/* get identify structs */
+	 		speed_rate[i+j] = speed;	/* get current speed */
+	 	}
+	if (set_speed) {
+		for (i=0; i<4; i++) {
+			if (id[i]==NULL)
+				continue;
+			switch(speed_rate[i]) {
+#ifdef CONFIG_BLK_DEV_IDEDMA
+				case XFER_UDMA_6:
+					OUT_BYTE((0x10 + adj), indexreg);
+					OUT_BYTE(0x1a, datareg);
+					OUT_BYTE((0x11 + adj), indexreg);
+					OUT_BYTE(0x01, datareg);
+					OUT_BYTE((0x12 + adj), indexreg);
+					OUT_BYTE(0xcb, datareg);
+					break;
+				case XFER_UDMA_5:
+					OUT_BYTE((0x10 + adj), indexreg);
+					OUT_BYTE(0x1a, datareg);
+					OUT_BYTE((0x11 + adj), indexreg);
+					OUT_BYTE(0x02, datareg);
+					OUT_BYTE((0x12 + adj), indexreg);
+					OUT_BYTE(0xcb, datareg);
+					break;
+				case XFER_UDMA_4:
+					OUT_BYTE((0x10 + adj), indexreg);
+					OUT_BYTE(0x1a, datareg);
+					OUT_BYTE((0x11 + adj), indexreg);
+					OUT_BYTE(0x03, datareg);
+					OUT_BYTE((0x12 + adj), indexreg);
+					OUT_BYTE(0xcd, datareg);
+					break;
+				case XFER_UDMA_3:
+					OUT_BYTE((0x10 + adj), indexreg);
+					OUT_BYTE(0x1a, datareg);
+					OUT_BYTE((0x11 + adj), indexreg);
+					OUT_BYTE(0x05, datareg);
+					OUT_BYTE((0x12 + adj), indexreg);
+					OUT_BYTE(0xcd, datareg);
+					break;
+				case XFER_UDMA_2:
+					OUT_BYTE((0x10 + adj), indexreg);
+					OUT_BYTE(0x2a, datareg);
+					OUT_BYTE((0x11 + adj), indexreg);
+					OUT_BYTE(0x07, datareg);
+					OUT_BYTE((0x12 + adj), indexreg);
+					OUT_BYTE(0xcd, datareg);
+					break;
+				case XFER_UDMA_1:
+					OUT_BYTE((0x10 + adj), indexreg);
+					OUT_BYTE(0x3a, datareg);
+					OUT_BYTE((0x11 + adj), indexreg);
+					OUT_BYTE(0x0a, datareg);
+					OUT_BYTE((0x12 + adj), indexreg);
+					OUT_BYTE(0xd0, datareg);
+					break;
+				case XFER_UDMA_0:
+					OUT_BYTE((0x10 + adj), indexreg);
+					OUT_BYTE(0x4a, datareg);
+					OUT_BYTE((0x11 + adj), indexreg);
+					OUT_BYTE(0x0f, datareg);
+					OUT_BYTE((0x12 + adj), indexreg);
+					OUT_BYTE(0xd5, datareg);
+					break;
+				case XFER_MW_DMA_2:
+					OUT_BYTE((0x0e + adj), indexreg);
+					OUT_BYTE(0x69, datareg);
+					OUT_BYTE((0x0f + adj), indexreg);
+					OUT_BYTE(0x25, datareg);
+					break;
+				case XFER_MW_DMA_1:
+					OUT_BYTE((0x0e + adj), indexreg);
+					OUT_BYTE(0x6b, datareg);
+					OUT_BYTE((0x0f+ adj), indexreg);
+					OUT_BYTE(0x27, datareg);
+					break;
+				case XFER_MW_DMA_0:
+					OUT_BYTE((0x0e + adj), indexreg);
+					OUT_BYTE(0xdf, datareg);
+					OUT_BYTE((0x0f + adj), indexreg);
+					OUT_BYTE(0x5f, datareg);
+					break;
+#endif /* CONFIG_BLK_DEV_IDEDMA */
+				case XFER_PIO_4:
+					OUT_BYTE((0x0c + adj), indexreg);
+					OUT_BYTE(0x23, datareg);
+					OUT_BYTE((0x0d + adj), indexreg);
+					OUT_BYTE(0x09, datareg);
+					OUT_BYTE((0x13 + adj), indexreg);
+					OUT_BYTE(0x25, datareg);
+					break;
+				case XFER_PIO_3:
+					OUT_BYTE((0x0c + adj), indexreg);
+					OUT_BYTE(0x27, datareg);
+					OUT_BYTE((0x0d + adj), indexreg);
+					OUT_BYTE(0x0d, datareg);
+					OUT_BYTE((0x13 + adj), indexreg);
+					OUT_BYTE(0x35, datareg);
+					break;
+				case XFER_PIO_2:
+					OUT_BYTE((0x0c + adj), indexreg);
+					OUT_BYTE(0x23, datareg);
+					OUT_BYTE((0x0d + adj), indexreg);
+					OUT_BYTE(0x26, datareg);
+					OUT_BYTE((0x13 + adj), indexreg);
+					OUT_BYTE(0x64, datareg);
+					break;
+				case XFER_PIO_1:
+					OUT_BYTE((0x0c + adj), indexreg);
+					OUT_BYTE(0x46, datareg);
+					OUT_BYTE((0x0d + adj), indexreg);
+					OUT_BYTE(0x29, datareg);
+					OUT_BYTE((0x13 + adj), indexreg);
+					OUT_BYTE(0xa4, datareg);
+					break;
+				case XFER_PIO_0:
+					OUT_BYTE((0x0c + adj), indexreg);
+					OUT_BYTE(0xfb, datareg);
+					OUT_BYTE((0x0d + adj), indexreg);
+					OUT_BYTE(0x2b, datareg);
+					OUT_BYTE((0x13 + adj), indexreg);
+					OUT_BYTE(0xac, datareg);
+					break;
+				default:
+			}
+		}
+	}
 	return err;
 }
 
@@ -709,7 +674,7 @@
 	byte iordy		= 0x13;
 	byte adj		= (drive->dn%2) ? 0x08 : 0x00;
 	byte cable		= 0;
-	byte jumpbit		= 0;
+	byte new_chip		= 0;
 	byte unit		= (drive->select.b.unit & 0x01);
 	unsigned int		drive_conf;
 	byte			drive_pci = 0;
@@ -717,12 +682,12 @@
 	byte			AP;
 	unsigned short		EP;
 	byte CLKSPD		= 0;
+	byte clockreg		= high_16 + 0x11;
 	byte udma_33		= ultra;
-//	byte udma_33		= ultra ? (IN_BYTE(high_16 + 0x001f) & 1) : 0;
 	byte udma_66		= ((eighty_ninty_three(drive)) && udma_33) ? 1 : 0;
 	byte udma_100		= 0;
 	byte udma_133		= 0;
-	byte mask		= hwif->channel ? 0x08 : 0x02;
+	byte mask			= hwif->channel ? 0x08 : 0x02;
 	unsigned short c_mask	= hwif->channel ? (1<<11) : (1<<10);
 
 	byte ultra_66		= ((id->dma_ultra & 0x0010) ||
@@ -740,40 +705,34 @@
 			udma_100 = (udma_66) ? 1 : 0;
 			OUT_BYTE(0x0b, (hwif->dma_base + 1));
 			cable = ((IN_BYTE((hwif->dma_base + 3)) & 0x04));
-			jumpbit = 1;
-			break;
-		case PCI_DEVICE_ID_PROMISE_20268R:
-			udma_100 = 1;
-			udma_66 = 1;
-			OUT_BYTE(0x0b, (hwif->dma_base + 1));
-			cable = ((IN_BYTE((hwif->dma_base + 3)) & 0x04));
-			jumpbit = 1;
+			new_chip = 1;
 			break;
 		case PCI_DEVICE_ID_PROMISE_20268:
+		case PCI_DEVICE_ID_PROMISE_20270:
 			udma_100 = (udma_66) ? 1 : 0;
 			OUT_BYTE(0x0b, (hwif->dma_base + 1));
 			cable = ((IN_BYTE((hwif->dma_base + 3)) & 0x04));
-			jumpbit = 1;
+			new_chip = 1;
 			break;
 		case PCI_DEVICE_ID_PROMISE_20267:
 		case PCI_DEVICE_ID_PROMISE_20265:
 			udma_100 = (udma_66) ? 1 : 0;
 			pci_read_config_word(dev, 0x50, &EP);
 			cable = (EP & c_mask);
-			jumpbit = 0;
+			new_chip = 0;
+			CLKSPD = IN_BYTE(clockreg);
 			break;
 		case PCI_DEVICE_ID_PROMISE_20262:
 			pci_read_config_word(dev, 0x50, &EP);
 			cable = (EP & c_mask);
-			jumpbit = 0;
+			new_chip = 0;
+			CLKSPD = IN_BYTE(clockreg);
 			break;
 		default:
-			udma_100 = 0; udma_133 = 0; cable = 1; jumpbit = 0;
+			udma_100 = 0; udma_133 = 0; cable = 0; new_chip = 1;
 			break;
 	}
 
-	if (!jumpbit)
-		CLKSPD = IN_BYTE(high_16 + 0x11);
 	/*
 	 * Set the control register to use the 66Mhz system
 	 * clock for UDMA 3/4 mode operation. If one drive on
@@ -794,8 +753,8 @@
 #endif /* DEBUG */
 		/* Primary   : zero out second bit */
 		/* Secondary : zero out fourth bit */
-		if (!jumpbit)
-			OUT_BYTE(CLKSPD & ~mask, (high_16 + 0x11));
+		//if (!new_chip)
+		OUT_BYTE(CLKSPD & ~mask, clockreg);
 		printk("Warning: %s channel requires an 80-pin cable for operation.\n", hwif->channel ? "Secondary":"Primary");
 		printk("%s reduced to Ultra33 mode.\n", drive->name);
 		udma_66 = 0; udma_100 = 0; udma_133 = 0;
@@ -811,27 +770,17 @@
 & 0x0020) ||
 				    (hwif->drives[!(drive->dn%2)].id->dma_ultra & 0x0010) ||
 				    (hwif->drives[!(drive->dn%2)].id->dma_ultra & 0x0008)) {
-					if (!jumpbit)
-						OUT_BYTE(CLKSPD | mask, (high_16 + 0x11));
+					OUT_BYTE(CLKSPD | mask, clockreg);
 				} else {
-					if (!jumpbit)
-						OUT_BYTE(CLKSPD & ~mask, (high_16 + 0x11));
+					OUT_BYTE(CLKSPD & ~mask, clockreg);
 				}
 			} else { /* udma4 drive by itself */
-				if (!jumpbit)
-					OUT_BYTE(CLKSPD | mask, (high_16 + 0x11));
+				OUT_BYTE(CLKSPD | mask, clockreg);
 			}
 		}
 	}
 
-	if (jumpbit) {
-		if (drive->media != ide_disk)	return ide_dma_off_quietly;
-		if (id->capability & 4) {	/* IORDY_EN & PREFETCH_EN */
-			OUT_BYTE((iordy + adj), indexreg);
-			OUT_BYTE((IN_BYTE(datareg)|0x03), datareg);
-		}
-		goto jumpbit_is_set;
-	}
+	if (new_chip)	goto chipset_is_set;
 
 	switch(drive->dn) {
 		case 0:	drive_pci = 0x60;
@@ -874,16 +823,23 @@
 
 chipset_is_set:
 
-	if (drive->media != ide_disk)	return ide_dma_off_quietly;
-
-	pci_read_config_byte(dev, (drive_pci), &AP);
-	if (id->capability & 4)	/* IORDY_EN */
-		pci_write_config_byte(dev, (drive_pci), AP|IORDY_EN);
-	pci_read_config_byte(dev, (drive_pci), &AP);
-	if (drive->media == ide_disk)	/* PREFETCH_EN */
-		pci_write_config_byte(dev, (drive_pci), AP|PREFETCH_EN);
-
-jumpbit_is_set:
+	if (drive->media != ide_disk)
+		return ide_dma_off_quietly;
+	
+	if (new_chip) {
+		if (id->capability & 4) {	/* IORDY_EN & PREFETCH_EN */
+			OUT_BYTE((iordy + adj), indexreg);
+			OUT_BYTE((IN_BYTE(datareg)|0x03), datareg);
+		}
+	}
+	else {
+		pci_read_config_byte(dev, (drive_pci), &AP);
+		if (id->capability & 4)	/* IORDY_EN */
+			pci_write_config_byte(dev, (drive_pci), AP|IORDY_EN);
+		pci_read_config_byte(dev, (drive_pci), &AP);
+		if (drive->media == ide_disk)	/* PREFETCH_EN */
+			pci_write_config_byte(dev, (drive_pci), AP|PREFETCH_EN);
+	}
 
 	if ((id->dma_ultra & 0x0040)&&(udma_133))	speed = XFER_UDMA_6;
 	else if ((id->dma_ultra & 0x0020)&&(udma_100))	speed = XFER_UDMA_5;
@@ -895,12 +851,12 @@
 	else if (id->dma_mword & 0x0004)		speed = XFER_MW_DMA_2;
 	else if (id->dma_mword & 0x0002)		speed = XFER_MW_DMA_1;
 	else if (id->dma_mword & 0x0001)		speed = XFER_MW_DMA_0;
-	else if ((id->dma_1word & 0x0004)&&(!jumpbit))	speed = XFER_SW_DMA_2;
-	else if ((id->dma_1word & 0x0002)&&(!jumpbit))	speed = XFER_SW_DMA_1;
-	else if ((id->dma_1word & 0x0001)&&(!jumpbit))	speed = XFER_SW_DMA_0;
+	else if ((id->dma_1word & 0x0004)&&(!new_chip))	speed = XFER_SW_DMA_2;
+	else if ((id->dma_1word & 0x0002)&&(!new_chip))	speed = XFER_SW_DMA_1;
+	else if ((id->dma_1word & 0x0001)&&(!new_chip))	speed = XFER_SW_DMA_0;
 	else {
 		/* restore original pci-config space */
-		if (!jumpbit)
+		if (!new_chip)
 			pci_write_config_dword(dev, drive_pci, drive_conf);
 		return ide_dma_off_quietly;
 	}
@@ -981,25 +937,24 @@
 	byte sc1d		= 0;
 	byte newchip		= 0;
 	byte clock		= 0;
-	byte hardware48hack	= 0;
+	byte hardware48fix	= 0;
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev *dev	= hwif->pci_dev;
 	unsigned long high_16	= pci_resource_start(dev, 4);
-	unsigned long atapi_reg	= high_16 + (hwif->channel ? 0x24 : 0x00);
 	unsigned long dma_base	= hwif->dma_base;
+	unsigned long atapi_port= hwif->channel ? high_16+0x24 : high_16+0x20;
 
 	switch (dev->device) {
 		case PCI_DEVICE_ID_PROMISE_20276:
 		case PCI_DEVICE_ID_PROMISE_20275:
 		case PCI_DEVICE_ID_PROMISE_20269:
-		case PCI_DEVICE_ID_PROMISE_20268R:
 		case PCI_DEVICE_ID_PROMISE_20268:
+		case PCI_DEVICE_ID_PROMISE_20270:
 			newchip = 1;
 			break;
 		case PCI_DEVICE_ID_PROMISE_20267:
 		case PCI_DEVICE_ID_PROMISE_20265:
-		case PCI_DEVICE_ID_PROMISE_20262:
-			hardware48hack = 1;
+			hardware48fix = 1;
 			clock = IN_BYTE(high_16 + 0x11);
 		default:
 			break;
@@ -1014,21 +969,29 @@
 			 * The Promise Ultra33 doesn't work correctly when
 			 * we do this part before issuing the drive cmd.
 			 */
-			if ((drive->addressing) && (hardware48hack)) {
+			/* Enable ATAPI UDMA port for 48bit data on PDC20267 */
+			if ((drive->addressing) && (hardware48fix)) {
 				struct request *rq = HWGROUP(drive)->rq;
 				unsigned long word_count = 0;
-
-				outb(clock|(hwif->channel ? 0x08 : 0x02), high_16 + 0x11);
+				unsigned long hankval = 0;
+				byte	clockreg = high_16 + 0x11;
+				
+				OUT_BYTE(clock|(hwif->channel ? 0x08:0x02), clockreg);
 				word_count = (rq->nr_sectors << 8);
-				word_count = (rq->cmd == READ) ? word_count | 0x05000000 : word_count | 0x06000000;
-				outl(word_count, atapi_reg);
-			}
+				hankval = (rq->cmd == READ) ? 0x05<<24 : 0x06<<24;
+				hankval = hankval | word_count ;
+				outl(hankval, atapi_port);
+			}  
 			break;
 		case ide_dma_end:
-			if ((drive->addressing) && (hardware48hack)) {
-				outl(0, atapi_reg);	/* zero out extra */
-				clock = IN_BYTE(high_16 + 0x11);
-				OUT_BYTE(clock & ~(hwif->channel ? 0x08:0x02), high_16 + 0x11);
+			/* Disable ATAPI UDMA port for 48bit data on PDC20267 */
+			if ((drive->addressing) && (hardware48fix)) {
+				unsigned long hankval = 0;
+				byte	clockreg = high_16 + 0x11;
+				
+			    	outl(hankval, atapi_port);	/* zero out extra */
+				clock = IN_BYTE(clockreg);
+				OUT_BYTE(clock & ~(hwif->channel ? 0x08:0x02), clockreg);
 			}
 			break;
 		case ide_dma_test_irq:	/* returns 1 if dma irq issued, 0 otherwise */
@@ -1059,7 +1022,7 @@
 }
 #endif /* CONFIG_BLK_DEV_IDEDMA */
 
-void pdc202xx_new_reset (ide_drive_t *drive)
+void pdc202xx_reset (ide_drive_t *drive)
 {
 	OUT_BYTE(0x04,IDE_CONTROL_REG);
 	mdelay(1000);
@@ -1069,19 +1032,6 @@
 		HWIF(drive)->channel ? "Secondary" : "Primary");
 }
 
-void pdc202xx_reset (ide_drive_t *drive)
-{
-	unsigned long high_16	= pci_resource_start(HWIF(drive)->pci_dev, 4);
-	byte udma_speed_flag	= IN_BYTE(high_16 + 0x001f);
-
-	OUT_BYTE(udma_speed_flag | 0x10, high_16 + 0x001f);
-	mdelay(100);
-	OUT_BYTE(udma_speed_flag & ~0x10, high_16 + 0x001f);
-	mdelay(2000);		/* 2 seconds ?! */
-	printk("PDC202XX: %s channel reset.\n",
-		HWIF(drive)->channel ? "Secondary" : "Primary");
-}
-
 /*
  * Since SUN Cobalt is attempting to do this operation, I should disclose
  * this has been a long time ago Thu Jul 27 16:40:57 2000 was the patch date
@@ -1114,59 +1064,17 @@
 	byte udma_speed_flag	= IN_BYTE(high_16 + 0x001f);
 	byte primary_mode	= IN_BYTE(high_16 + 0x001a);
 	byte secondary_mode	= IN_BYTE(high_16 + 0x001b);
-	byte newchip		= 0;
+
+	OUT_BYTE(udma_speed_flag | 0x10, high_16 + 0x001f);
+	mdelay(100);
+	OUT_BYTE(udma_speed_flag & ~0x10, high_16 + 0x001f);
+	mdelay(2000);	/* 2 seconds ?! */
 
 	if (dev->resource[PCI_ROM_RESOURCE].start) {
 		pci_write_config_dword(dev, PCI_ROM_ADDRESS, dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
 		printk("%s: ROM enabled at 0x%08lx\n", name, dev->resource[PCI_ROM_RESOURCE].start);
 	}
-
-	switch (dev->device) {
-		case PCI_DEVICE_ID_PROMISE_20276:
-		case PCI_DEVICE_ID_PROMISE_20275:
-		case PCI_DEVICE_ID_PROMISE_20269:
-		case PCI_DEVICE_ID_PROMISE_20268R:
-		case PCI_DEVICE_ID_PROMISE_20268:
-			newchip = 1;
-			break;
-		case PCI_DEVICE_ID_PROMISE_20267:
-		case PCI_DEVICE_ID_PROMISE_20265:
-			OUT_BYTE(udma_speed_flag | 0x10, high_16 + 0x001f);
-			mdelay(100);
-			OUT_BYTE(udma_speed_flag & ~0x10, high_16 + 0x001f);
-			mdelay(2000);   /* 2 seconds ?! */
-			break;
-		case PCI_DEVICE_ID_PROMISE_20262:
-			/*
-			 * software reset -  this is required because the bios
-			 * will set UDMA timing on if the hdd supports it. The
-			 * user may want to turn udma off. A bug in the pdc20262
-			 * is that it cannot handle a downgrade in timing from
-			 * UDMA to DMA. Disk accesses after issuing a set
-			 * feature command will result in errors. A software
-			 * reset leaves the timing registers intact,
-			 * but resets the drives.
-			 */
-			OUT_BYTE(udma_speed_flag | 0x10, high_16 + 0x001f);
-			mdelay(100);
-			OUT_BYTE(udma_speed_flag & ~0x10, high_16 + 0x001f);
-			mdelay(2000);	/* 2 seconds ?! */
-		default:
-			if ((dev->class >> 8) != PCI_CLASS_STORAGE_IDE) {
-				byte irq = 0, irq2 = 0;
-				pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
-				pci_read_config_byte(dev, (PCI_INTERRUPT_LINE)|0x80, &irq2);	/* 0xbc */
-				if (irq != irq2) {
-					pci_write_config_byte(dev, (PCI_INTERRUPT_LINE)|0x80, irq);	/* 0xbc */
-					printk("%s: pci-config space interrupt mirror fixed.\n", name);
-				}
-			}
-			break;
-	}
-
-	if (newchip)
-		goto fttk_tx_series;
-
+	
 	printk("%s: (U)DMA Burst Bit %sABLED " \
 		"Primary %s Mode " \
 		"Secondary %s Mode.\n",
@@ -1199,8 +1107,6 @@
 	}
 #endif /* CONFIG_PDC202XX_MASTER */
 
-fttk_tx_series:
-
 #if defined(DISPLAY_PDC202XX_TIMINGS) && defined(CONFIG_PROC_FS)
 	if (!pdc202xx_proc) {
 		pdc202xx_proc = 1;
@@ -1216,17 +1122,19 @@
 	unsigned short mask = (hwif->channel) ? (1<<11) : (1<<10);
 	unsigned short CIS;
 
-        switch(hwif->pci_dev->device) {
+        	switch(hwif->pci_dev->device) {
 		case PCI_DEVICE_ID_PROMISE_20276:
 		case PCI_DEVICE_ID_PROMISE_20275:
 		case PCI_DEVICE_ID_PROMISE_20269:
 		case PCI_DEVICE_ID_PROMISE_20268:
-		case PCI_DEVICE_ID_PROMISE_20268R:
+		case PCI_DEVICE_ID_PROMISE_20270:
 			OUT_BYTE(0x0b, (hwif->dma_base + 1));
 			return (!(IN_BYTE((hwif->dma_base + 3)) & 0x04));
+			/* check 80pin cable */
 		default:
 			pci_read_config_word(hwif->pci_dev, 0x50, &CIS);
 			return (!(CIS & mask));
+			/* check 80pin cable */
 	}
 }
 
@@ -1234,21 +1142,20 @@
 {
 	hwif->tuneproc  = &pdc202xx_tune_drive;
 	hwif->quirkproc = &pdc202xx_quirkproc;
+	hwif->resetproc = &pdc202xx_reset;
 
         switch(hwif->pci_dev->device) {
 		case PCI_DEVICE_ID_PROMISE_20276:
 		case PCI_DEVICE_ID_PROMISE_20275:
 		case PCI_DEVICE_ID_PROMISE_20269:
 		case PCI_DEVICE_ID_PROMISE_20268:
-		case PCI_DEVICE_ID_PROMISE_20268R:
+		case PCI_DEVICE_ID_PROMISE_20270:
 			hwif->speedproc = &pdc202xx_new_tune_chipset;
-			hwif->resetproc = &pdc202xx_new_reset;
 			break;
 		case PCI_DEVICE_ID_PROMISE_20267:
 		case PCI_DEVICE_ID_PROMISE_20265:
 		case PCI_DEVICE_ID_PROMISE_20262:
 			hwif->busproc   = &pdc202xx_tristate;
-			hwif->resetproc	= &pdc202xx_reset;
 		case PCI_DEVICE_ID_PROMISE_20246:
 			hwif->speedproc = &pdc202xx_tune_chipset;
 		default:
diff -urN linux-2.4.19pre10/include/linux/pci_ids.h linux/include/linux/pci_ids.h
--- linux-2.4.19pre10/include/linux/pci_ids.h	Tue Jun 18 11:35:45 2002
+++ linux/include/linux/pci_ids.h	Fri Jul  5 01:30:07 2002
@@ -606,7 +606,7 @@
 #define PCI_DEVICE_ID_PROMISE_20246	0x4d33
 #define PCI_DEVICE_ID_PROMISE_20262	0x4d38
 #define PCI_DEVICE_ID_PROMISE_20268	0x4d68
-#define PCI_DEVICE_ID_PROMISE_20268R	0x6268
+#define PCI_DEVICE_ID_PROMISE_20270	0x6268
 #define PCI_DEVICE_ID_PROMISE_20269	0x4d69
 #define PCI_DEVICE_ID_PROMISE_20271	0x6269
 #define PCI_DEVICE_ID_PROMISE_20275	0x1275
