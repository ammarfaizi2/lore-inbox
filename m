Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314339AbSEXNqq>; Fri, 24 May 2002 09:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314379AbSEXNqp>; Fri, 24 May 2002 09:46:45 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:12210 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S314339AbSEXNqi>;
	Fri, 24 May 2002 09:46:38 -0400
Date: Fri, 24 May 2002 15:46:35 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Martin Dalecki <dalecki@evision-ventures.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [patch] New driver for Artop [Acard] controllers.
Message-ID: <20020524154635.A10423@ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

After getting a couple reports that the Artop driver doesn't work, I
decided to take a look at it ... well and I decided that this is
impossible to debug, so I rewrote it from scratch instead. I have no
documentation nor the actual hardware, so it may be wrong somewhere,
but I think definitely less wrong than the original one.

I must say I also thought about preserving the original one for it's
humoristic value, consider what the following statements do:

1) #define SPLIT_BYTE(B,H,L)       ((H)=(B>>4), (L)=(B-((B>>4)<<4)))

... computation of L is just wonderful - first shift B down, then up
again, this clears the lower four bits, and then subtract that from B.
What a nice way to write ((B) & 0xf) ...

2) ((art&0x06)==0x06)?"5":((art&0x05)==0x05)?"4":((art&0x04)==0x04)?"3":((art&0x03)==0x03)?"2":((art&0x02)==0x02)?"1":((art&0x01)==0x01)?"0":"?"

... this is a real pearl - what a cool way to compute (art - 1).

2a)

switch(speed) {
         case 7: return "6";
         case 6: return "5";
         case 5: return "4";
         case 4: return "3";
         case 3: return "2";
         case 2: return "1";
         case 1: return "0";
         case 0: return "?";
}

... another one, for the same purpose with a different chip version.

3)  ((0x00 << (2*drive->dn))

... no comment

-- 
Vojtech Pavlik
SuSE Labs

--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="artop.diff"

ChangeSet@1.657, 2002-05-24 15:34:29+02:00, vojtech@twilight.ucw.cz
  This is a new driver for the Artop (Acard) controllers. It's completely
  untested, as I have never seen the hardware. However, I suspect it is
  much less broken than the previous one ...


 Config.help |   25 --
 Config.in   |    5 
 aec62xx.c   |  693 ++++++++++++++++++------------------------------------------
 3 files changed, 223 insertions(+), 500 deletions(-)


diff -Nru a/drivers/ide/Config.help b/drivers/ide/Config.help
--- a/drivers/ide/Config.help	Fri May 24 15:34:42 2002
+++ b/drivers/ide/Config.help	Fri May 24 15:34:42 2002
@@ -295,28 +295,13 @@
   It is normally safe to answer Y; however, the default is N.
 
 CONFIG_BLK_DEV_AEC62XX
-  This driver adds up to 4 more EIDE devices sharing a single
-  interrupt. This add-on card is a bootable PCI UDMA controller. In
-  order to get this card to initialize correctly in some cases, you
-  should say Y here, and preferably also to "Use DMA by default when
-  available".
-
-  The ATP850U/UF is an UltraDMA 33 chipset base.
-  The ATP860 is an UltraDMA 66 chipset base.
-  The ATP860M(acintosh) version is an UltraDMA 66 chipset base.
-  The ATP865 is an ATA100/133 chipset.
-
-  Please read the comments at the top of <file:drivers/ide/aec62xx.c>.
-  If you say Y here, then say Y to "Use DMA by default when available"
-  as well.
-
-CONFIG_AEC62XX_TUNING
-  Please read the comments at the top of <file:drivers/ide/aec62xx.c>.
-  If unsure, say N.
+  This driver adds explicit support for Acard AEC62xx (Artop ATP8xx)
+  IDE controllers. This allows the kernel to change PIO, DMA and UDMA
+  speeds and to configure the chip to optimum performance.
 
 CONFIG_AEC6280_BURST
-  Use burst mode for DMA transfers. Higher speed, but causes more load
-  on the bus.
+  Use burst mode for DMA transfers. This helps to achieve higher
+  transfer rates, but causes more load on the PCI bus.
 
   If unsure, say N.
 
diff -Nru a/drivers/ide/Config.in b/drivers/ide/Config.in
--- a/drivers/ide/Config.in	Fri May 24 15:34:42 2002
+++ b/drivers/ide/Config.in	Fri May 24 15:34:42 2002
@@ -40,9 +40,8 @@
          int '      Default queue depth' CONFIG_BLK_DEV_IDE_TCQ_DEPTH 32
       fi
       dep_bool '    Good-Bad DMA Model-Firmware (EXPERIMENTAL)' CONFIG_IDEDMA_NEW_DRIVE_LISTINGS $CONFIG_EXPERIMENTAL
-      dep_bool '    AEC62XX chip set support' CONFIG_BLK_DEV_AEC62XX $CONFIG_BLK_DEV_IDEDMA_PCI
-      dep_mbool '      AEC62XX Tuning support' CONFIG_AEC62XX_TUNING $CONFIG_BLK_DEV_AEC62XX
-      dep_mbool '      AEC6280 Burst mode' CONFIG_AEC6280_BURST $CONFIG_BLK_DEV_AEC62XX
+      dep_bool '    Acard (Artop) chipset support' CONFIG_BLK_DEV_AEC62XX $CONFIG_BLK_DEV_IDEDMA_PCI
+      dep_mbool '      ATP865 burst mode' CONFIG_AEC6280_BURST $CONFIG_BLK_DEV_AEC62XX
       dep_bool '    ALI M15x3 chipset support' CONFIG_BLK_DEV_ALI15X3 $CONFIG_BLK_DEV_IDEDMA_PCI
       dep_mbool '      ALI M15x3 WDC support (DANGEROUS)' CONFIG_WDC_ALI15X3 $CONFIG_BLK_DEV_ALI15X3 $CONFIG_EXPERIMENTAL
       dep_bool '    AMD and nVidia chipset support' CONFIG_BLK_DEV_AMD74XX $CONFIG_BLK_DEV_IDEDMA_PCI
diff -Nru a/drivers/ide/aec62xx.c b/drivers/ide/aec62xx.c
--- a/drivers/ide/aec62xx.c	Fri May 24 15:34:42 2002
+++ b/drivers/ide/aec62xx.c	Fri May 24 15:34:42 2002
@@ -1,559 +1,299 @@
-/**** vi:set ts=8 sts=8 sw=8:************************************************
+/*
+ *
+ * $Id: aec62xx.c,v 1.0 2002/05/24 14:37:19 vojtech Exp $
  *
- * Version 0.11	March 27, 2002
+ *  Copyright (c) 2002 Vojtech Pavlik
  *
- * Copyright (C) 1999-2000	Andre Hedrick (andre@linux-ide.org)
+ *  Based on the work of:
+ *	Andre Hedrick
+ */
+
+/*
+ * AEC 6210UF (ATP850UF), AEC6260 (ATP860) and AEC6280 (ATP865) IDE driver for Linux.
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
-#include <linux/delay.h>
-#include <linux/timer.h>
-#include <linux/mm.h>
 #include <linux/ioport.h>
 #include <linux/blkdev.h>
-#include <linux/hdreg.h>
-
-#include <linux/interrupt.h>
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/ide.h>
 
 #include <asm/io.h>
-#include <asm/irq.h>
 
 #include "ata-timing.h"
 #include "pcihost.h"
 
-#undef DISPLAY_AEC62XX_TIMINGS
+#define AEC_DRIVE_TIMING	0x40
+#define AEC_UDMA_NEW		0x44
+#define AEC_MISC		0x49
+#define AEC_IDE_ENABLE		0x4a
+#define AEC_UDMA_OLD		0x54
+
+#define AEC_UDMA		0x07
+#define AEC_UDMA_33		0x01
+#define AEC_UDMA_66		0x02
+#define AEC_UDMA_133		0x04
+#define AEC_OLD			0x10
+#define AEC_INIT		0x20
 
-#ifndef HIGH_4
-#define HIGH_4(H)		((H)=(H>>4))
-#endif
-#ifndef LOW_4
-#define LOW_4(L)		((L)=(L-((L>>4)<<4)))
-#endif
-#ifndef SPLIT_BYTE
-#define SPLIT_BYTE(B,H,L)	((H)=(B>>4), (L)=(B-((B>>4)<<4)))
-#endif
-#ifndef MAKE_WORD
-#define MAKE_WORD(W,HB,LB)	((W)=((HB<<8)+LB))
-#endif
+/*
+ * AEC IDE chips.
+ */
 
+static struct aec_ide_chip {
+	unsigned short id;
+	unsigned char flags;
+} aec_ide_chips[] = {
+	{ PCI_DEVICE_ID_ARTOP_ATP865R, AEC_UDMA_133 | AEC_INIT },	/* AEC-6280 w/ROM */
+	{ PCI_DEVICE_ID_ARTOP_ATP865, AEC_UDMA_133 | AEC_INIT },	/* AEC-6280 */
+	{ PCI_DEVICE_ID_ARTOP_ATP860R, AEC_UDMA_66 },			/* AEC-6260 w/ ROM */
+	{ PCI_DEVICE_ID_ARTOP_ATP860, AEC_UDMA_66 },			/* AEC-6260 */
+	{ PCI_DEVICE_ID_ARTOP_ATP850UF, AEC_UDMA_33 | AEC_OLD},		/* AEC-6210 */
+	{ 0 }
+};
 
-#if defined(DISPLAY_AEC62XX_TIMINGS) && defined(CONFIG_PROC_FS)
-#include <linux/stat.h>
-#include <linux/proc_fs.h>
-
-static int aec62xx_get_info(char *, char **, off_t, int);
-extern int (*aec62xx_display_info)(char *, char **, off_t, int); /* ide-proc.c */
-static struct pci_dev *bmide_dev;
+static struct aec_ide_chip *aec_config;
 
-static const char *aec6280_get_speed(u8 speed)
-{
-	switch(speed) {
-		case 7: return "6";
-		case 6: return "5";
-		case 5: return "4";
-		case 4: return "3";
-		case 3: return "2";
-		case 2: return "1";
-		case 1: return "0";
-		case 0: return "?";
-	}
-	return "?";
-}
+static unsigned char aec_cyc2udma[17] =
+	{ 0, 0, 7, 6, 5, 4, 4, 3, 3, 2, 2, 2, 2, 1, 1, 1, 1 };
+static char *aec_dma[] = { "MWDMA16", "UDMA33", "UDMA66", "UDMA100", "UDMA133" };
 
-static int aec62xx_get_info (char *buffer, char **addr, off_t offset, int count)
-{
-	char *p = buffer;
+/*
+ * aec_set_speed_old() writes timing values to
+ * the chipset registers for ATP850UF
+ */
 
-	u32 bibma = pci_resource_start(bmide_dev, 4);
-	u8 c0 = 0, c1 = 0;
-	u8 art = 0, uart = 0;
-
-	switch(bmide_dev->device) {
-		case PCI_DEVICE_ID_ARTOP_ATP850UF:
-			p += sprintf(p, "\n                                AEC6210 Chipset.\n");
-			break;
-		case PCI_DEVICE_ID_ARTOP_ATP860:
-			p += sprintf(p, "\n                                AEC6260 No Bios Chipset.\n");
-			break;
-		case PCI_DEVICE_ID_ARTOP_ATP860R:
-			p += sprintf(p, "\n                                AEC6260 Chipset.\n");
-			break;
-		case PCI_DEVICE_ID_ARTOP_ATP865:
-			p += sprintf(p, "\n                                AEC6280 Chipset without ROM.\n");
-			break;
-		case PCI_DEVICE_ID_ARTOP_ATP865R:
-			p += sprintf(p, "\n                                AEC6280 Chipset with ROM.\n");
-			break;
-		default:
-			p += sprintf(p, "\n                                AEC62?? Chipset.\n");
-			break;
-	}
+static void aec_set_speed_old(struct pci_dev *dev, unsigned char dn, struct ata_timing *timing)
+{
+	unsigned char t;
 
-        /*
-         * at that point bibma+0x2 et bibma+0xa are byte registers
-         * to investigate:
-         */
-	c0 = inb_p((unsigned short)bibma + 0x02);
-	c1 = inb_p((unsigned short)bibma + 0x0a);
-
-	p += sprintf(p, "--------------- Primary Channel ---------------- Secondary Channel -------------\n");
-	(void) pci_read_config_byte(bmide_dev, 0x4a, &art);
-	p += sprintf(p, "                %sabled                         %sabled\n",
-		(art&0x02)?" en":"dis",(art&0x04)?" en":"dis");
-	p += sprintf(p, "--------------- drive0 --------- drive1 -------- drive0 ---------- drive1 ------\n");
-	p += sprintf(p, "DMA enabled:    %s              %s             %s               %s\n",
-		(c0&0x20)?"yes":"no ",(c0&0x40)?"yes":"no ",(c1&0x20)?"yes":"no ",(c1&0x40)?"yes":"no ");
-
-	switch(bmide_dev->device) {
-		case PCI_DEVICE_ID_ARTOP_ATP850UF:
-			(void) pci_read_config_byte(bmide_dev, 0x54, &art);
-			p += sprintf(p, "DMA Mode:       %s(%s)          %s(%s)         %s(%s)           %s(%s)\n",
-				(c0&0x20)?((art&0x03)?"UDMA":" DMA"):" PIO",
-				(art&0x02)?"2":(art&0x01)?"1":"0",
-				(c0&0x40)?((art&0x0c)?"UDMA":" DMA"):" PIO",
-				(art&0x08)?"2":(art&0x04)?"1":"0",
-				(c1&0x20)?((art&0x30)?"UDMA":" DMA"):" PIO",
-				(art&0x20)?"2":(art&0x10)?"1":"0",
-				(c1&0x40)?((art&0xc0)?"UDMA":" DMA"):" PIO",
-				(art&0x80)?"2":(art&0x40)?"1":"0");
-			(void) pci_read_config_byte(bmide_dev, 0x40, &art);
-			p += sprintf(p, "Active:         0x%02x", art);
-			(void) pci_read_config_byte(bmide_dev, 0x42, &art);
-			p += sprintf(p, "             0x%02x", art);
-			(void) pci_read_config_byte(bmide_dev, 0x44, &art);
-			p += sprintf(p, "            0x%02x", art);
-			(void) pci_read_config_byte(bmide_dev, 0x46, &art);
-			p += sprintf(p, "              0x%02x\n", art);
-			(void) pci_read_config_byte(bmide_dev, 0x41, &art);
-			p += sprintf(p, "Recovery:       0x%02x", art);
-			(void) pci_read_config_byte(bmide_dev, 0x43, &art);
-			p += sprintf(p, "             0x%02x", art);
-			(void) pci_read_config_byte(bmide_dev, 0x45, &art);
-			p += sprintf(p, "            0x%02x", art);
-			(void) pci_read_config_byte(bmide_dev, 0x47, &art);
-			p += sprintf(p, "              0x%02x\n", art);
-			break;
-		case PCI_DEVICE_ID_ARTOP_ATP860:
-		case PCI_DEVICE_ID_ARTOP_ATP860R:
-			(void) pci_read_config_byte(bmide_dev, 0x44, &art);
-			p += sprintf(p, "DMA Mode:       %s(%s)          %s(%s)",
-				(c0&0x20)?((art&0x07)?"UDMA":" DMA"):" PIO",
-				((art&0x06)==0x06)?"4":((art&0x05)==0x05)?"4":((art&0x04)==0x04)?"3":((art&0x03)==0x03)?"2":((art&0x02)==0x02)?"1":((art&0x01)==0x01)?"0":"?",
-				(c0&0x40)?((art&0x70)?"UDMA":" DMA"):" PIO",
-				((art&0x60)==0x60)?"4":((art&0x50)==0x50)?"4":((art&0x40)==0x40)?"3":((art&0x30)==0x30)?"2":((art&0x20)==0x20)?"1":((art&0x10)==0x10)?"0":"?");
-			(void) pci_read_config_byte(bmide_dev, 0x45, &art);
-			p += sprintf(p, "         %s(%s)           %s(%s)\n",
-				(c1&0x20)?((art&0x07)?"UDMA":" DMA"):" PIO",
-				((art&0x06)==0x06)?"4":((art&0x05)==0x05)?"4":((art&0x04)==0x04)?"3":((art&0x03)==0x03)?"2":((art&0x02)==0x02)?"1":((art&0x01)==0x01)?"0":"?",
-				(c1&0x40)?((art&0x70)?"UDMA":" DMA"):" PIO",
-				((art&0x60)==0x60)?"4":((art&0x50)==0x50)?"4":((art&0x40)==0x40)?"3":((art&0x30)==0x30)?"2":((art&0x20)==0x20)?"1":((art&0x10)==0x10)?"0":"?");
-			(void) pci_read_config_byte(bmide_dev, 0x40, &art);
-			p += sprintf(p, "Active:         0x%02x", HIGH_4(art));
-			(void) pci_read_config_byte(bmide_dev, 0x41, &art);
-			p += sprintf(p, "             0x%02x", HIGH_4(art));
-			(void) pci_read_config_byte(bmide_dev, 0x42, &art);
-			p += sprintf(p, "            0x%02x", HIGH_4(art));
-			(void) pci_read_config_byte(bmide_dev, 0x43, &art);
-			p += sprintf(p, "              0x%02x\n", HIGH_4(art));
-			(void) pci_read_config_byte(bmide_dev, 0x40, &art);
-			p += sprintf(p, "Recovery:       0x%02x", LOW_4(art));
-			(void) pci_read_config_byte(bmide_dev, 0x41, &art);
-			p += sprintf(p, "             0x%02x", LOW_4(art));
-			(void) pci_read_config_byte(bmide_dev, 0x42, &art);
-			p += sprintf(p, "            0x%02x", LOW_4(art));
-			(void) pci_read_config_byte(bmide_dev, 0x43, &art);
-			p += sprintf(p, "              0x%02x\n", LOW_4(art));
-			(void) pci_read_config_byte(bmide_dev, 0x49, &uart);
-			p += sprintf(p, "reg49h = 0x%02x ", uart);
-			(void) pci_read_config_byte(bmide_dev, 0x4a, &uart);
-			p += sprintf(p, "reg4ah = 0x%02x\n", uart);
-			break;
-		case PCI_DEVICE_ID_ARTOP_ATP865:
-		case PCI_DEVICE_ID_ARTOP_ATP865R:
-			(void) pci_read_config_byte(bmide_dev, 0x44, &art);
-			p += sprintf(p, "DMA Mode:       %s(%s)          %s(%s)",
-				(c0&0x20)?((art&0x0f)?"UDMA":" DMA"):" PIO",
-				aec6280_get_speed(art&0x0f),
-				(c0&0x40)?((art&0xf0)?"UDMA":" DMA"):" PIO",
-				aec6280_get_speed(art>>4));
-			(void) pci_read_config_byte(bmide_dev, 0x45, &art);
-			p += sprintf(p, "         %s(%s)          %s(%s)\n",
-				(c0&0x20)?((art&0x0f)?"UDMA":" DMA"):" PIO",
-				aec6280_get_speed(art&0x0f),
-				(c0&0x40)?((art&0xf0)?"UDMA":" DMA"):" PIO",
-				aec6280_get_speed(art>>4));
-			(void) pci_read_config_byte(bmide_dev, 0x40, &art);
-			p += sprintf(p, "Active:         0x%02x", HIGH_4(art));
-			(void) pci_read_config_byte(bmide_dev, 0x41, &art);
-			p += sprintf(p, "             0x%02x", HIGH_4(art));
-			(void) pci_read_config_byte(bmide_dev, 0x42, &art);
-			p += sprintf(p, "            0x%02x", HIGH_4(art));
-			(void) pci_read_config_byte(bmide_dev, 0x43, &art);
-			p += sprintf(p, "              0x%02x\n", HIGH_4(art));
-			(void) pci_read_config_byte(bmide_dev, 0x40, &art);
-			p += sprintf(p, "Recovery:       0x%02x", LOW_4(art));
-			(void) pci_read_config_byte(bmide_dev, 0x41, &art);
-			p += sprintf(p, "             0x%02x", LOW_4(art));
-			(void) pci_read_config_byte(bmide_dev, 0x42, &art);
-			p += sprintf(p, "            0x%02x", LOW_4(art));
-			(void) pci_read_config_byte(bmide_dev, 0x43, &art);
-			p += sprintf(p, "              0x%02x\n", LOW_4(art));
-			(void) pci_read_config_byte(bmide_dev, 0x49, &uart);
-			p += sprintf(p, "reg49h = 0x%02x ", uart);
-			(void) pci_read_config_byte(bmide_dev, 0x4a, &uart);
-			p += sprintf(p, "reg4ah = 0x%02x\n", uart);
-			break;
-		default:
-			break;
-	}
+	pci_write_config_byte(dev, AEC_DRIVE_TIMING + (dn << 1),     FIT(timing->active, 0, 15));
+	pci_write_config_byte(dev, AEC_DRIVE_TIMING + (dn << 1) + 1, FIT(timing->recover, 0, 15));
 
-	return p-buffer;/* => must be less than 4k! */
+	pci_read_config_byte(dev, AEC_UDMA_OLD, &t);
+	t &=  ~(3 << (dn << 1));
+	if (timing->udma)
+		t |= (5 - FIT(timing->udma, 2, 4)) << (dn << 1);
+	pci_write_config_byte(dev, AEC_UDMA_OLD, t);
 }
-#endif	/* defined(DISPLAY_AEC62xx_TIMINGS) && defined(CONFIG_PROC_FS) */
 
-byte aec62xx_proc = 0;
+/*
+ * aec_set_speed_new() writes timing values to the chipset registers for all
+ * other Artop chips
+ */
 
-struct chipset_bus_clock_list_entry {
-	byte		xfer_speed;
+static void aec_set_speed_new(struct pci_dev *dev, unsigned char dn, struct ata_timing *timing)
+{
+	unsigned char t;
 
-	byte		chipset_settings_34;
-	byte		ultra_settings_34;
+	pci_write_config_byte(dev, AEC_DRIVE_TIMING + dn,
+		(FIT(timing->active, 0, 15) << 4) | FIT(timing->recover, 0, 15));
 
-	byte		chipset_settings_33;
-	byte		ultra_settings_33;
-};
-
-struct chipset_bus_clock_list_entry aec62xx_base [] = {
-#ifdef CONFIG_BLK_DEV_IDEDMA
-	{	XFER_UDMA_6,	0x41,	0x06,	0x31,	0x07	},
-	{	XFER_UDMA_5,	0x41,	0x05,	0x31,	0x06	},
-	{	XFER_UDMA_4,	0x41,	0x04,	0x31,	0x05	},
-	{	XFER_UDMA_3,	0x41,	0x03,	0x31,	0x04	},
-	{	XFER_UDMA_2,	0x41,	0x02,	0x31,	0x03	},
-	{	XFER_UDMA_1,	0x41,	0x01,	0x31,	0x02	},
-	{	XFER_UDMA_0,	0x41,	0x01,	0x31,	0x01	},
-
-	{	XFER_MW_DMA_2,	0x41,	0x00,	0x31,	0x00	},
-	{	XFER_MW_DMA_1,	0x42,	0x00,	0x31,	0x00	},
-	{	XFER_MW_DMA_0,	0x7a,	0x00,	0x0a,	0x00	},
-#endif /* CONFIG_BLK_DEV_IDEDMA */
-	{	XFER_PIO_4,	0x41,	0x00,	0x31,	0x00	},
-	{	XFER_PIO_3,	0x43,	0x00,	0x33,	0x00	},
-	{	XFER_PIO_2,	0x78,	0x00,	0x08,	0x00	},
-	{	XFER_PIO_1,	0x7a,	0x00,	0x0a,	0x00	},
-	{	XFER_PIO_0,	0x70,	0x00,	0x00,	0x00	},
-	{	0,		0x00,	0x00,	0x00,	0x00	}
-};
+	pci_read_config_byte(dev, AEC_UDMA_NEW + (dn >> 1), &t);
+	t &= ~(0xf << ((dn & 1) << 2));
+	if (timing->udma)
+		t |= aec_cyc2udma[FIT(timing->udma, 2, 16)] << ((dn & 1) << 2);
+	pci_write_config_byte(dev, AEC_UDMA_NEW + (dn >> 1), t);
+}
 
 /*
- * TO DO: active tuning and correction of cards without a bios.
+ * aec_set_drive() computes timing values configures the drive and
+ * the chipset to a desired transfer mode. It also can be called
+ * by upper layers.
  */
 
-static byte pci_bus_clock_list (byte speed, struct chipset_bus_clock_list_entry * chipset_table)
+static int aec_set_drive(ide_drive_t *drive, unsigned char speed)
 {
-	for ( ; chipset_table->xfer_speed ; chipset_table++)
-		if (chipset_table->xfer_speed == speed) {
-			return ((byte) ((system_bus_speed <= 33333) ? chipset_table->chipset_settings_33 : chipset_table->chipset_settings_34));
-		}
-	return 0x00;
-}
+	ide_drive_t *peer = drive->channel->drives + (~drive->dn & 1);
+	struct ata_timing t, p;
+	int T, UT;
 
-static byte pci_bus_clock_list_ultra (byte speed, struct chipset_bus_clock_list_entry * chipset_table)
-{
-	for ( ; chipset_table->xfer_speed ; chipset_table++)
-		if (chipset_table->xfer_speed == speed) {
-			return ((byte) ((system_bus_speed <= 33333) ? chipset_table->ultra_settings_33 : chipset_table->ultra_settings_34));
-		}
-	return 0x00;
-}
-
-static int aec62xx_ratemask(struct ata_device *drive)
-{
-	struct pci_dev *dev = drive->channel->pci_dev;
-	u32 bmide = pci_resource_start(dev, 4);
-	int map = 0;
-
-	if (!eighty_ninty_three(drive))
-		return XFER_UDMA;
-
-	switch(dev->device) {
-		case PCI_DEVICE_ID_ARTOP_ATP865R:
-		case PCI_DEVICE_ID_ARTOP_ATP865:
-			if (IN_BYTE(bmide+2) & 0x10)
-				map |= XFER_UDMA_133;
-			else
-				map |= XFER_UDMA_100;
-		case PCI_DEVICE_ID_ARTOP_ATP860R:
-		case PCI_DEVICE_ID_ARTOP_ATP860:
-			map |= XFER_UDMA_66;
-		case PCI_DEVICE_ID_ARTOP_ATP850UF:
-			map |= XFER_UDMA;
-	}
-	return map;
-}
+	if (speed != XFER_PIO_SLOW && speed != drive->current_speed)
+		if (ide_config_drive_speed(drive, speed))
+			printk(KERN_WARNING "ide%d: Drive %d didn't accept speed setting. Oh, well.\n",
+				drive->dn >> 1, drive->dn & 1);
 
-static int aec6210_tune_chipset(struct ata_device *drive, byte speed)
-{
-	struct pci_dev *dev = drive->channel->pci_dev;
-	unsigned short d_conf	= 0x0000;
-	byte ultra		= 0x00;
-	byte ultra_conf		= 0x00;
-	byte tmp0		= 0x00;
-	byte tmp1		= 0x00;
-	byte tmp2		= 0x00;
-	unsigned long flags;
-
-	__save_flags(flags);	/* local CPU only */
-	__cli();		/* local CPU only */
-
-	pci_read_config_word(dev, 0x40|(2*drive->dn), &d_conf);
-	tmp0 = pci_bus_clock_list(speed, aec62xx_base);
-	SPLIT_BYTE(tmp0,tmp1,tmp2);
-	MAKE_WORD(d_conf,tmp1,tmp2);
-	pci_write_config_word(dev, 0x40|(2*drive->dn), d_conf);
-
-	tmp1 = 0x00;
-	tmp2 = 0x00;
-	pci_read_config_byte(dev, 0x54, &ultra);
-	tmp1 = ((0x00 << (2*drive->dn)) | (ultra & ~(3 << (2*drive->dn))));
-	ultra_conf = pci_bus_clock_list_ultra(speed, aec62xx_base);
-	tmp2 = ((ultra_conf << (2*drive->dn)) | (tmp1 & ~(3 << (2*drive->dn))));
-	pci_write_config_byte(dev, 0x54, tmp2);
+	T = 1000000000 / system_bus_speed;
+	UT = T / ((aec_config->flags & AEC_OLD) ? 1 : 4);
 
-	__restore_flags(flags);	/* local CPU only */
+	ata_timing_compute(drive, speed, &t, T, UT);
 
-	return ide_config_drive_speed(drive, speed);
-}
+	if (peer->present) {
+		ata_timing_compute(peer, peer->current_speed, &p, T, UT);
+		ata_timing_merge(&p, &t, &t, IDE_TIMING_8BIT);
+	}
 
-static int aec6260_tune_chipset(struct ata_device *drive, byte speed)
-{
-	struct pci_dev *dev = drive->channel->pci_dev;
-	byte unit		= (drive->select.b.unit & 0x01);
-	u8 ultra_pci = drive->channel->unit ? 0x45 : 0x44;
-	byte drive_conf		= 0x00;
-	byte ultra_conf		= 0x00;
-	byte ultra		= 0x00;
-	byte tmp1		= 0x00;
-	byte tmp2		= 0x00;
-	unsigned long flags;
-
-	__save_flags(flags);	/* local CPU only */
-	__cli();		/* local CPU only */
-
-	pci_read_config_byte(dev, 0x40|drive->dn, &drive_conf);
-	drive_conf = pci_bus_clock_list(speed, aec62xx_base);
-	pci_write_config_byte(dev, 0x40|drive->dn, drive_conf);
-
-	pci_read_config_byte(dev, ultra_pci, &ultra);
-	tmp1 = ((0x00 << (4*unit)) | (ultra & ~(7 << (4*unit))));
-	ultra_conf = pci_bus_clock_list_ultra(speed, aec62xx_base);
-	tmp2 = ((ultra_conf << (4*unit)) | (tmp1 & ~(7 << (4*unit))));
-	pci_write_config_byte(dev, ultra_pci, tmp2);
-	__restore_flags(flags);	/* local CPU only */
+	if (aec_config->flags & AEC_OLD)
+		aec_set_speed_old(drive->channel->pci_dev, drive->dn, &t);
+	else
+		aec_set_speed_new(drive->channel->pci_dev, drive->dn, &t);
 
-	if (!drive->init_speed)
+	if (!drive->init_speed)	
 		drive->init_speed = speed;
-
 	drive->current_speed = speed;
-	return ide_config_drive_speed(drive, speed);
+
+	return 0;
 }
 
+/*
+ * aec62xx_tune_drive() is a callback from upper layers for
+ * PIO-only tuning.
+ */
 
-static int aec62xx_tune_chipset(struct ata_device *drive, byte speed)
+static void aec62xx_tune_drive(ide_drive_t *drive, unsigned char pio)
 {
-	switch (drive->channel->pci_dev->device) {
-		case PCI_DEVICE_ID_ARTOP_ATP865:
-		case PCI_DEVICE_ID_ARTOP_ATP865R:
-		case PCI_DEVICE_ID_ARTOP_ATP860:
-		case PCI_DEVICE_ID_ARTOP_ATP860R:
-			return aec6260_tune_chipset(drive, speed);
-		case PCI_DEVICE_ID_ARTOP_ATP850UF:
-			return aec6210_tune_chipset(drive, speed);
-		default:
-			return -1;
+	if (pio == 255) {
+		aec_set_drive(drive, ata_timing_mode(drive, XFER_PIO | XFER_EPIO));
+		return;
 	}
+
+	aec_set_drive(drive, XFER_PIO_0 + min_t(byte, pio, 5));
 }
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
-static int config_chipset_for_dma(struct ata_device *drive, u8 udma)
+static int aec62xx_dmaproc(struct ata_device *drive)
 {
-	int map;
-	u8 mode;
-
-	if (drive->type != ATA_DISK)
-		return 0;
+	short w80 = drive->channel->udma_four;
 
-	if (udma)
-		map = aec62xx_ratemask(drive);
-	else
-		map = XFER_SWDMA | XFER_MWDMA;
+	short speed = ata_timing_mode(drive,
+			XFER_PIO | XFER_EPIO | XFER_MWDMA | XFER_UDMA | XFER_SWDMA |
+			(w80 && (aec_config->flags & AEC_UDMA) >= AEC_UDMA_66 ? XFER_UDMA_66 : 0) |
+			(w80 && (aec_config->flags & AEC_UDMA) >= AEC_UDMA_133 ? (XFER_UDMA_100 | XFER_UDMA_133) : 0));
 
-	mode = ata_timing_mode(drive, map);
+	aec_set_drive(drive, speed);
 
-	if (mode < XFER_SW_DMA_0)
-		return 0;
+	udma_enable(drive, drive->channel->autodma && (speed & XFER_MODE) != XFER_PIO, 0);
 
-	return !aec62xx_tune_chipset(drive, mode);
+	return 0;
 }
-#endif /* CONFIG_BLK_DEV_IDEDMA */
+#endif
 
-static void aec62xx_tune_drive(struct ata_device *drive, byte pio)
-{
-	byte speed;
+/*
+ * The initialization callback. Here we determine the IDE chip type
+ * and initialize its drive independent registers.
+ */
 
-	if (pio == 255)
-		speed = ata_timing_mode(drive, XFER_PIO | XFER_EPIO);
-	else
-		speed = XFER_PIO_0 + min_t(byte, pio, 4);
+static unsigned int __init aec62xx_init_chipset(struct pci_dev *dev)
+{
+	unsigned char t;
 
-	(void) aec62xx_tune_chipset(drive, speed);
-}
+/*
+ * Find out what AEC IDE is this.
+ */
 
-#ifdef CONFIG_BLK_DEV_IDEDMA
-static int config_drive_xfer_rate(struct ata_device *drive)
-{
-	struct hd_driveid *id = drive->id;
-	int on = 1;
-	int verbose = 1;
-
-	if (id && (id->capability & 1) && drive->channel->autodma) {
-		/* Consult the list of known "bad" drives */
-		if (udma_black_list(drive)) {
-			on = 0;
-			goto fast_ata_pio;
-		}
-		on = 0;
-		verbose = 0;
-		if (id->field_valid & 4) {
-			if (id->dma_ultra & 0x007F) {
-				/* Force if Capable UltraDMA */
-				on = config_chipset_for_dma(drive, 1);
-				if ((id->field_valid & 2) &&
-				    (!on))
-					goto try_dma_modes;
-			}
-		} else if (id->field_valid & 2) {
-try_dma_modes:
-			if ((id->dma_mword & 0x0007) ||
-			    (id->dma_1word & 0x0007)) {
-				/* Force if Capable regular DMA modes */
-				on = config_chipset_for_dma(drive, 0);
-				if (!on)
-					goto no_dma_set;
-			}
-		} else if (udma_white_list(drive)) {
-			if (id->eide_dma_time > 150) {
-				goto no_dma_set;
-			}
-			/* Consult the list of known "good" drives */
-			on = config_chipset_for_dma(drive, 0);
-			if (!on)
-				goto no_dma_set;
-		} else {
-			goto fast_ata_pio;
-		}
-	} else if ((id->capability & 8) || (id->field_valid & 2)) {
-fast_ata_pio:
-		on = 0;
-		verbose = 0;
-no_dma_set:
-		aec62xx_tune_drive(drive, 5);
-	}
-	udma_enable(drive, on, verbose);
-	return 0;
-}
+	for (aec_config = aec_ide_chips; aec_config->id; aec_config++)
+		if (dev->device == aec_config->id)
+			break;
+/*
+ * Initialize if needed.
+ */
 
-int aec62xx_dmaproc(struct ata_device *drive)
-{
-	return config_drive_xfer_rate(drive);
-}
-#endif
+	if (aec_config->flags & AEC_INIT) {
 
-static unsigned int __init aec62xx_init_chipset(struct pci_dev *dev)
-{
-	u8 reg49h = 0;
-	u8 reg4ah = 0;
+		/* Clear reset and test bits.  */
+		pci_read_config_byte(dev, AEC_MISC, &t);
+		pci_write_config_byte(dev, AEC_MISC, t & ~0x30);
+
+		/* Enable chip interrupt output.  */
+		pci_read_config_byte(dev, AEC_IDE_ENABLE, &t);
+		pci_write_config_byte(dev, AEC_IDE_ENABLE, t & ~0x01);
 
-	switch(dev->device) {
-		case PCI_DEVICE_ID_ARTOP_ATP865:
-		case PCI_DEVICE_ID_ARTOP_ATP865R:
-			/* Clear reset and test bits.  */
-			pci_read_config_byte(dev, 0x49, &reg49h);
-			pci_write_config_byte(dev, 0x49, reg49h & ~0x30);
-			/* Enable chip interrupt output.  */
-			pci_read_config_byte(dev, 0x4a, &reg4ah);
-			pci_write_config_byte(dev, 0x4a, reg4ah & ~0x01);
 #ifdef CONFIG_AEC6280_BURST
-			/* Must be greater than 0x80 for burst mode.  */
-			pci_write_config_byte(dev, PCI_LATENCY_TIMER, 0x90);
-			/* Enable burst mode.  */
-			pci_read_config_byte(dev, 0x4a, &reg4ah);
-			pci_write_config_byte(dev, 0x4a, reg4ah | 0x80);
+
+		/* Must be greater than 0x80 for burst mode. */
+		pci_write_config_byte(dev, PCI_LATENCY_TIMER, 0x90);
+
+		/* Enable burst mode.  */
+		pci_read_config_byte(dev, AEC_IDE_ENABLE, &t);
+		pci_write_config_byte(dev, AEC_IDE_ENABLE, t | 0x80);
+
 #endif
-			break;
-		default:
-			break;
 	}
 
-	if (dev->resource[PCI_ROM_RESOURCE].start) {
-		pci_write_config_dword(dev, PCI_ROM_ADDRESS, dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
-		printk("%s: ROM enabled at 0x%08lx\n", dev->name, dev->resource[PCI_ROM_RESOURCE].start);
-	}
+/*
+ * Print the boot message.
+ */
 
-#if defined(DISPLAY_AEC62XX_TIMINGS) && defined(CONFIG_PROC_FS)
-	if (!aec62xx_proc) {
-		aec62xx_proc = 1;
-		bmide_dev = dev;
-		aec62xx_display_info = &aec62xx_get_info;
-	}
-#endif
+	pci_read_config_byte(dev, PCI_REVISION_ID, &t);
+	printk(KERN_INFO "AEC_IDE: %s (rev %02x) %s controller on pci%s\n",
+		dev->name, t, aec_dma[aec_config->flags & AEC_UDMA], dev->slot_name);
 
-	return dev->irq;
+
+	return 0;
 }
 
 static unsigned int __init aec62xx_ata66_check(struct ata_channel *ch)
 {
-	u8 mask	= ch->unit ? 0x02 : 0x01;
-	u8 ata66 = 0;
-
-	pci_read_config_byte(ch->pci_dev, 0x49, &ata66);
+	unsigned char t;
 
-	return ((ata66 & mask) ? 0 : 1);
+        pci_read_config_byte(ch->pci_dev, AEC_MISC, &t);
+        return ((t & (1 << ch->unit)) ? 0 : 1);
 }
 
-static void __init aec62xx_init_channel(struct ata_channel *hwif)
+static void __init aec62xx_init_channel(struct ata_channel *ch)
 {
-	hwif->tuneproc = aec62xx_tune_drive;
-	hwif->speedproc = aec62xx_tune_chipset;
-	hwif->drives[0].autotune = 1;
-	hwif->drives[1].autotune = 1;
+	int i;
+
+	ch->tuneproc = &aec62xx_tune_drive;
+	ch->speedproc = &aec_set_drive;
+	ch->autodma = 0;
+
+	ch->io_32bit = 1;
+	ch->unmask = 1;
+
+	for (i = 0; i < 2; i++) {
+		ch->drives[i].autotune = 1;
+		ch->drives[i].dn = ch->unit * 2 + i;
+	}
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
-	if (hwif->dma_base) {
-		hwif->XXX_udma = aec62xx_dmaproc;
-		hwif->highmem = 1;
-# ifdef CONFIG_IDEDMA_AUTO
+	if (ch->dma_base) {
+		ch->highmem = 1;
+		ch->XXX_udma = aec62xx_dmaproc;
+#ifdef CONFIG_IDEDMA_AUTO
 		if (!noautodma)
-			hwif->autodma = 1;
-# endif
+			ch->autodma = 1;
+#endif
 	}
 #endif
 }
 
-static void __init aec62xx_init_dma(struct ata_channel *hwif, unsigned long dmabase)
+/*
+ * We allow the BM-DMA driver only work on enabled interfaces.
+ */
+static void __init aec62xx_init_dma(struct ata_channel *ch, unsigned long dmabase)
 {
-	u8 reg54h = 0;
+	unsigned char t;
 
-	/* FIXME: we need some locking here */
-	pci_read_config_byte(hwif->pci_dev, 0x54, &reg54h);
-	pci_write_config_byte(hwif->pci_dev, 0x54, reg54h & ~(hwif->unit ? 0xF0 : 0x0F));
-	ata_init_dma(hwif, dmabase);
+	pci_read_config_byte(ch->pci_dev, AEC_IDE_ENABLE, &t);
+	if (t & (1 << ((ch->unit << 1) + 2)))
+		ata_init_dma(ch, dmabase);
 }
 
 /* module data table */
@@ -574,7 +314,7 @@
 		init_chipset: aec62xx_init_chipset,
 		ata66_check: aec62xx_ata66_check,
 		init_channel: aec62xx_init_channel,
-		enablebits: { {0x00,0x00,0x00},	{0x00,0x00,0x00} },
+		enablebits: { {0x4a,0x02,0x02},	{0x4a,0x04,0x04} },
 		bootable: NEVER_BOARD,
 		flags: ATA_F_IRQ | ATA_F_NOADMA | ATA_F_DMA
 	},
@@ -594,7 +334,7 @@
 		init_chipset: aec62xx_init_chipset,
 		ata66_check: aec62xx_ata66_check,
 		init_channel: aec62xx_init_channel,
-		enablebits: { {0x00,0x00,0x00},	{0x00,0x00,0x00} },
+		enablebits: { {0x4a,0x02,0x02},	{0x4a,0x04,0x04} },
 		bootable: NEVER_BOARD,
 		flags: ATA_F_IRQ | ATA_F_DMA
 	},
@@ -604,7 +344,7 @@
 		init_chipset: aec62xx_init_chipset,
 		ata66_check: aec62xx_ata66_check,
 		init_channel: aec62xx_init_channel,
-		enablebits: { {0x00,0x00,0x00},	{0x00,0x00,0x00} },
+		enablebits: { {0x4a,0x02,0x02},	{0x4a,0x04,0x04} },
 		bootable: OFF_BOARD,
 		flags: ATA_F_IRQ | ATA_F_DMA
 	},
@@ -614,9 +354,9 @@
 		init_chipset: aec62xx_init_chipset,
 		ata66_check: aec62xx_ata66_check,
 		init_channel: aec62xx_init_channel,
-		enablebits: { {0x00,0x00,0x00},	{0x00,0x00,0x00} },
+		enablebits: { {0x4a,0x02,0x02},	{0x4a,0x04,0x04} },
 		bootable: NEVER_BOARD,
-		flags: ATA_F_IRQ | ATA_F_NOADMA | ATA_F_DMA
+		flags: ATA_F_IRQ | ATA_F_DMA
 	},
 	{
 		vendor: PCI_VENDOR_ID_ARTOP,
@@ -634,9 +374,8 @@
 {
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(chipsets); ++i) {
-		ata_register_chipset(&chipsets[i]);
-	}
+	for (i = 0; i < ARRAY_SIZE(chipsets); i++)
+		ata_register_chipset(chipsets + i);
 
-	return 0;
+        return 0;
 }

--bp/iNruPH9dso1Pn--
