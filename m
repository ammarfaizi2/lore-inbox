Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbTFSVig (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 17:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbTFSVig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 17:38:36 -0400
Received: from smtp-104-thursday.noc.nerim.net ([62.4.17.104]:59660 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S261196AbTFSViT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 17:38:19 -0400
Message-ID: <3EF2308D.2010809@inet6.fr>
Date: Thu, 19 Jun 2003 23:52:13 +0200
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030425
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: [SIS IDE] Enhanced SiS96x support for 2.5.72-bk2
Content-Type: multipart/mixed;
 boundary="------------030705070505070702080804"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030705070505070702080804
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

you'll find attached a patch against 2.5.72-bk2 for the SiS IDE driver.

This is nearly the same patch as the one against 2.4.21-ac1 posted 
yesterday.

This is a 99% Vojtech work :
- Independant southbridge detection (no need to add current and future 
MuTIOL northbridge PCI ids knowledge to the driver),
- Lots of code cleanup,
- Debug code removed (unused for a while, I will maintain it in my tree 
if needed),

I changed 2 things :
- SiS745 was reported to me as a MuTIOL northbridge chip, it is treated 
as such by removing it from the integrated chip table,
- the new config_xfer_rate is commented out until ide_find_best_mode is 
patched for bad drive handling (until then I reverted to the old one 
using the config_drive_xfer_rate helper function).

Please apply,

LB.



--------------030705070505070702080804
Content-Type: text/plain;
 name="sis.patch.20030619_1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sis.patch.20030619_1"

diff -urN -X dontdiff --exclude=tmp_include_depends linux-2.5.72-bk2/drivers/ide/pci/sis5513.c linux-2.5.72-bk2-sis/drivers/ide/pci/sis5513.c
--- linux-2.5.72-bk2/drivers/ide/pci/sis5513.c	2003-06-19 23:13:14.000000000 +0200
+++ linux-2.5.72-bk2-sis/drivers/ide/pci/sis5513.c	2003-06-19 23:23:33.000000000 +0200
@@ -1,8 +1,9 @@
 /*
- * linux/drivers/ide/pci/sis5513.c		Version 0.14ac	Sept 11, 2002
+ * linux/drivers/ide/pci/sis5513.c	Version 0.16ac+vp	Jun 18, 2003
  *
  * Copyright (C) 1999-2000	Andre Hedrick <andre@linux-ide.org>
  * Copyright (C) 2002		Lionel Bouton <Lionel.Bouton@inet6.fr>, Maintainer
+ * Copyright (C) 2003		Vojtech Pavlik <vojtech@suse.cz>
  * May be copied or modified under the terms of the GNU General Public License
  *
  *
@@ -14,31 +15,33 @@
  *			  for checking code correctness, providing patches.
  *
  *
- * Original tests and design on the SiS620/5513 chipset.
- * ATA100 tests and design on the SiS735/5513 chipset.
+ * Original tests and design on the SiS620 chipset.
+ * ATA100 tests and design on the SiS735 chipset.
  * ATA16/33 support from specs
  * ATA133 support for SiS961/962 by L.C. Chang <lcchang@sis.com.tw>
+ * ATA133 961/962/963 fixes by Vojtech Pavlik <vojtech@suse.cz>
  *
  * Documentation:
- *	SiS chipset documentation available under NDA to companies not
- *	individuals only.
+ *	SiS chipset documentation available under NDA to companies only
+ *      (not to individuals).
  */
 
 /*
- * Notes/Special cases:
- * - SiS5513 derivatives usually have the same PCI IDE register layout when
- *  supporting the same UDMA modes.
- * - There are exceptions :
- *  . SiS730 and SiS550 use the same layout than ATA_66 chipsets but support
- *   ATA_100
- *  . ATA_133 capable chipsets mark a shift in SiS chipset designs : previously
- *   south and northbridge were integrated, making IDE (a southbridge function)
- *   capabilities easily deduced from the northbridge PCI id. With ATA_133,
- *   chipsets started to be split in the usual north/south bridges chips
- *   -> the driver needs to detect the correct southbridge when faced to newest
- *   northbridges.
- *  . On ATA133 capable chipsets when bit 30 of dword at 0x54 is 1 the
- *   configuration space is moved from 0x40 to 0x70.
+ * The original SiS5513 comes from a SiS5511/55112/5513 chipset. The original
+ * SiS5513 was also used in the SiS5596/5513 chipset. Thus if we see a SiS5511
+ * or SiS5596, we can assume we see the first MWDMA-16 capable SiS5513 chip.
+ *
+ * Later SiS chipsets integrated the 5513 functionality into the NorthBridge,
+ * starting with SiS5571 and up to SiS745. The PCI ID didn't change, though. We
+ * can figure out that we have a more modern and more capable 5513 by looking
+ * for the respective NorthBridge IDs.
+ *
+ * Even later (96x family) SiS chipsets use the MuTIOL link and place the 5513
+ * into the SouthBrige. Here we cannot rely on looking up the NorthBridge PCI
+ * ID, while the now ATA-133 capable 5513 still has the same PCI ID.
+ * Fortunately the 5513 can be 'unmasked' by fiddling with some config space
+ * bits, changing its device id to the true one - 5517 for 961 and 5518 for
+ * 962/963.
  */
 
 #include <linux/config.h>
@@ -57,94 +60,23 @@
 #include <linux/init.h>
 #include <linux/ide.h>
 
-#include <asm/io.h>
 #include <asm/irq.h>
 
+#include "ide-timing.h"
 #include "ide_modes.h"
 #include "sis5513.h"
 
-/* When DEBUG is defined it outputs initial PCI config register
-   values and changes made to them by the driver */
-// #define DEBUG
-/* When BROKEN_LEVEL is defined it limits the DMA mode
-   at boot time to its value */
-// #define BROKEN_LEVEL XFER_SW_DMA_0
-
-/* Miscellaneous flags */
-#define SIS5513_LATENCY		0x01
-
 /* registers layout and init values are chipset family dependant */
-/* 1/ define families */
-#define ATA_00		0x00
+
 #define ATA_16		0x01
 #define ATA_33		0x02
 #define ATA_66		0x03
-#define ATA_100a	0x04 // SiS730 is ATA100 with ATA66 layout
+#define ATA_100a	0x04 // SiS730/SiS550 is ATA100 with ATA66 layout
 #define ATA_100		0x05
 #define ATA_133a	0x06 // SiS961b with 133 support
-#define ATA_133		0x07 // SiS962
-/* 2/ variable holding the controller chipset family value */
-static u8 chipset_family;
-
-
-/*
- * Debug code: following IDE config registers' changes
- */
-#ifdef DEBUG
-/* Copy of IDE Config registers fewer will be used
- * Some odd chipsets hang if unused registers are accessed
- * -> We only access them in #DEBUG code (then we'll see if SiS did
- * it right from day one) */
-static u8 ide_regs_copy[0xff];
-
-/* Read config registers, print differences from previous read */
-static void sis5513_load_verify_registers(struct pci_dev* dev, char* info) {
-	int i;
-	u8 reg_val;
-	u8 changed=0;
-
-	printk("SIS5513: %s, changed registers:\n", info);
-	for(i=0; i<=0xff; i++) {
-		pci_read_config_byte(dev, i, &reg_val);
-		if (reg_val != ide_regs_copy[i]) {
-			printk("%02x: %02x -> %02x\n",
-			       i, ide_regs_copy[i], reg_val);
-			ide_regs_copy[i]=reg_val;
-			changed=1;
-		}
-	}
-
-	if (!changed) {
-		printk("none\n");
-	}
-}
-
-/* Load config registers, no printing */
-static void sis5513_load_registers(struct pci_dev* dev) {
-	int i;
-
-	for(i=0; i<=0xff; i++) {
-		pci_read_config_byte(dev, i, &(ide_regs_copy[i]));
-	}
-}
-
-/* Print config space registers a la "lspci -vxxx" */
-static void sis5513_print_registers(struct pci_dev* dev, char* marker) {
-	int i,j;
-
-	sis5513_load_registers(dev);
-	printk("SIS5513 %s\n", marker);
-
-	for(i=0; i<=0xf; i++) {
-		printk("SIS5513 dump: %d" "0:", i);
-		for(j=0; j<=0xf; j++) {
-			printk(" %02x", ide_regs_copy[(i<<16)+j]);
-		}
-		printk("\n");
-	}
-}
-#endif
+#define ATA_133		0x07 // SiS962/963
 
+static u8 chipset_family;
 
 /*
  * Devices supported
@@ -155,42 +87,37 @@
 	u8 chipset_family;
 	u8 flags;
 } SiSHostChipInfo[] = {
-	{ "SiS752",	PCI_DEVICE_ID_SI_752,	ATA_133,	0 },
-	{ "SiS751",	PCI_DEVICE_ID_SI_751,	ATA_133,	0 },
-	{ "SiS750",	PCI_DEVICE_ID_SI_750,	ATA_133,	0 },
-	{ "SiS748",	PCI_DEVICE_ID_SI_748,	ATA_133,	0 },
-	{ "SiS746",	PCI_DEVICE_ID_SI_746,	ATA_133,	0 },
-	{ "SiS745",	PCI_DEVICE_ID_SI_745,	ATA_133,	0 },
-	{ "SiS740",	PCI_DEVICE_ID_SI_740,	ATA_133,	0 },
-	{ "SiS735",	PCI_DEVICE_ID_SI_735,	ATA_100,	SIS5513_LATENCY },
-	{ "SiS730",	PCI_DEVICE_ID_SI_730,	ATA_100a,	SIS5513_LATENCY },
-	{ "SiS655",	PCI_DEVICE_ID_SI_655,	ATA_133,	0 },
-	{ "SiS652",	PCI_DEVICE_ID_SI_652,	ATA_133,	0 },
-	{ "SiS651",	PCI_DEVICE_ID_SI_651,	ATA_133,	0 },
-	{ "SiS650",	PCI_DEVICE_ID_SI_650,	ATA_133,	0 },
-	{ "SiS648",	PCI_DEVICE_ID_SI_648,	ATA_133,	0 },
-	{ "SiS646",	PCI_DEVICE_ID_SI_646,	ATA_133,	0 },
-	{ "SiS645",	PCI_DEVICE_ID_SI_645,	ATA_133,	0 },
-	{ "SiS635",	PCI_DEVICE_ID_SI_635,	ATA_100,	SIS5513_LATENCY },
-	{ "SiS640",	PCI_DEVICE_ID_SI_640,	ATA_66,		SIS5513_LATENCY },
-	{ "SiS630",	PCI_DEVICE_ID_SI_630,	ATA_66,		SIS5513_LATENCY },
-	{ "SiS620",	PCI_DEVICE_ID_SI_620,	ATA_66,		SIS5513_LATENCY },
-	{ "SiS550",	PCI_DEVICE_ID_SI_550,	ATA_100a,	0},
-	{ "SiS540",	PCI_DEVICE_ID_SI_540,	ATA_66,		0},
-	{ "SiS530",	PCI_DEVICE_ID_SI_530,	ATA_66,		0},
-	{ "SiS5600",	PCI_DEVICE_ID_SI_5600,	ATA_33,		0},
-	{ "SiS5598",	PCI_DEVICE_ID_SI_5598,	ATA_33,		0},
-	{ "SiS5597",	PCI_DEVICE_ID_SI_5597,	ATA_33,		0},
-	{ "SiS5591",	PCI_DEVICE_ID_SI_5591,	ATA_33,		0},
-	{ "SiS5513",	PCI_DEVICE_ID_SI_5513,	ATA_16,		0},
-	{ "SiS5511",	PCI_DEVICE_ID_SI_5511,	ATA_16,		0},
+	{ "SiS735",	PCI_DEVICE_ID_SI_735,	ATA_100  },
+	{ "SiS733",	PCI_DEVICE_ID_SI_733,	ATA_100  },
+	{ "SiS635",	PCI_DEVICE_ID_SI_635,	ATA_100  },
+	{ "SiS633",	PCI_DEVICE_ID_SI_633,	ATA_100  },
+
+	{ "SiS730",	PCI_DEVICE_ID_SI_730,	ATA_100a },
+	{ "SiS550",	PCI_DEVICE_ID_SI_550,	ATA_100a },
+
+	{ "SiS640",	PCI_DEVICE_ID_SI_640,	ATA_66   },
+	{ "SiS630",	PCI_DEVICE_ID_SI_630,	ATA_66   },
+	{ "SiS620",	PCI_DEVICE_ID_SI_620,	ATA_66   },
+	{ "SiS540",	PCI_DEVICE_ID_SI_540,	ATA_66   },
+	{ "SiS530",	PCI_DEVICE_ID_SI_530,	ATA_66   },
+
+	{ "SiS5600",	PCI_DEVICE_ID_SI_5600,	ATA_33   },
+	{ "SiS5598",	PCI_DEVICE_ID_SI_5598,	ATA_33   },
+	{ "SiS5597",	PCI_DEVICE_ID_SI_5597,	ATA_33   },
+	{ "SiS5591/2",	PCI_DEVICE_ID_SI_5591,	ATA_33   },
+	{ "SiS5582",	PCI_DEVICE_ID_SI_5582,	ATA_33   },
+	{ "SiS5581",	PCI_DEVICE_ID_SI_5581,	ATA_33   },
+
+	{ "SiS5596",	PCI_DEVICE_ID_SI_5596,	ATA_16   },
+	{ "SiS5571",	PCI_DEVICE_ID_SI_5571,	ATA_16   },
+	{ "SiS551x",	PCI_DEVICE_ID_SI_5511,	ATA_16   },
 };
 
 /* Cycle time bits and values vary across chip dma capabilities
    These three arrays hold the register layout and the values to set.
    Indexed by chipset_family and (dma_mode - XFER_UDMA_0) */
 
-/* {ATA_00, ATA_16, ATA_33, ATA_66, ATA_100a, ATA_100, ATA_133} */
+/* {0, ATA_16, ATA_33, ATA_66, ATA_100a, ATA_100, ATA_133} */
 static u8 cycle_time_offset[] = {0,0,5,4,4,0,0};
 static u8 cycle_time_range[] = {0,0,2,3,3,4,4};
 static u8 cycle_time_value[][XFER_UDMA_6 - XFER_UDMA_0 + 1] = {
@@ -249,8 +176,6 @@
 	{40,12,4,12,5,34,12,5},
 };
 
-static struct pci_dev *host_dev = NULL;
-
 /*
  * Printing configuration
  */
@@ -334,6 +259,7 @@
 		}
 		pci_read_config_dword(bmide_dev, (unsigned long)drive_pci+4*pos, &regdw0);
 		pci_read_config_dword(bmide_dev, (unsigned long)drive_pci+4*pos+8, &regdw1);
+
 		p += sprintf(p, "Drive %d:\n", pos);
 	}
 
@@ -372,11 +298,12 @@
 		p += sprintf(p, "\n");
 	}
 
-	if (chipset_family < ATA_133) { /* else case TODO */
+
+	if (chipset_family < ATA_133) {	/* else case TODO */
+
 /* Data Active */
 		p += sprintf(p, "                Data Active Time   ");
 		switch(chipset_family) {
-			case ATA_00:
 			case ATA_16: /* confirmed */
 			case ATA_33:
 			case ATA_66:
@@ -387,7 +314,6 @@
 		}
 		p += sprintf(p, " \t Data Active Time   ");
 		switch(chipset_family) {
-			case ATA_00:
 			case ATA_16:
 			case ATA_33:
 			case ATA_66:
@@ -493,39 +419,16 @@
 
 	len = (p - buffer) - offset;
 	*addr = buffer + offset;
-	
+
 	return len > count ? count : len;
 }
 #endif /* defined(DISPLAY_SIS_TIMINGS) && defined(CONFIG_PROC_FS) */
 
 static u8 sis5513_ratemask (ide_drive_t *drive)
 {
-#if 0
 	u8 rates[] = { 0, 0, 1, 2, 3, 3, 4, 4 };
 	u8 mode = rates[chipset_family];
-#else
-	u8 mode;
 
-	switch(chipset_family) {
-		case ATA_133:
-		case ATA_133a:
-			mode = 4;
-			break;
-		case ATA_100:
-		case ATA_100a:
-			mode = 3;
-			break;
-		case ATA_66:
-			mode = 2;
-			break;
-		case ATA_33:
-			return 1;
-		case ATA_16:
-                case ATA_00:	
-		default:
-			return 0;
-	}
-#endif
 	if (!eighty_ninty_three(drive))
 		mode = min(mode, (u8)1);
 	return mode;
@@ -543,20 +446,12 @@
 	u8 reg4bh		= 0;
 	u8 rw_prefetch		= (0x11 << drive->dn);
 
-#ifdef DEBUG
-	printk("SIS5513: config_drive_art_rwp, drive %d\n", drive->dn);
-	sis5513_load_verify_registers(dev, "config_drive_art_rwp start");
-#endif
-
 	if (drive->media != ide_disk)
 		return;
 	pci_read_config_byte(dev, 0x4b, &reg4bh);
 
 	if ((reg4bh & rw_prefetch) != rw_prefetch)
 		pci_write_config_byte(dev, 0x4b, reg4bh|rw_prefetch);
-#ifdef DEBUG
-	sis5513_load_verify_registers(dev, "config_drive_art_rwp end");
-#endif
 }
 
 
@@ -571,10 +466,6 @@
 	u16 eide_pio_timing[6] = {600, 390, 240, 180, 120, 90};
 	u16 xfer_pio = drive->id->eide_pio_modes;
 
-#ifdef DEBUG
-	sis5513_load_verify_registers(dev, "config_drive_art_rwp_pio start");
-#endif
-
 	config_drive_art_rwp(drive);
 	pio = ide_get_best_pio_mode(drive, 255, pio, NULL);
 
@@ -594,12 +485,6 @@
 
 	timing = (xfer_pio >= pio) ? xfer_pio : pio;
 
-#ifdef DEBUG
-	printk("SIS5513: config_drive_art_rwp_pio, "
-		"drive %d, pio %d, timing %d\n",
-	       drive->dn, pio, timing);
-#endif
-
 	/* In pre ATA_133 case, drives sit at 0x40 + 4*drive->dn */
 	drive_pci = 0x40;
 	/* In SiS962 case drives sit at (0x40 or 0x70) + 8*drive->dn) */
@@ -645,41 +530,24 @@
 		pci_read_config_dword(dev, drive_pci, &test3);
 		test3 &= 0xc0c00fff;
 		if (test3 & 0x08) {
-			test3 |= (unsigned long)ini_time_value[ATA_133-ATA_00][timing] << 12;
-			test3 |= (unsigned long)act_time_value[ATA_133-ATA_00][timing] << 16;
-			test3 |= (unsigned long)rco_time_value[ATA_133-ATA_00][timing] << 24;
+			test3 |= (unsigned long)ini_time_value[ATA_133][timing] << 12;
+			test3 |= (unsigned long)act_time_value[ATA_133][timing] << 16;
+			test3 |= (unsigned long)rco_time_value[ATA_133][timing] << 24;
 		} else {
-			test3 |= (unsigned long)ini_time_value[ATA_100-ATA_00][timing] << 12;
-			test3 |= (unsigned long)act_time_value[ATA_100-ATA_00][timing] << 16;
-			test3 |= (unsigned long)rco_time_value[ATA_100-ATA_00][timing] << 24;
+			test3 |= (unsigned long)ini_time_value[ATA_100][timing] << 12;
+			test3 |= (unsigned long)act_time_value[ATA_100][timing] << 16;
+			test3 |= (unsigned long)rco_time_value[ATA_100][timing] << 24;
 		}
 		pci_write_config_dword(dev, drive_pci, test3);
 	}
-
-#ifdef DEBUG
-	sis5513_load_verify_registers(dev, "config_drive_art_rwp_pio start");
-#endif
 }
 
 static int config_chipset_for_pio (ide_drive_t *drive, u8 pio)
 {
-#if 0
+	if (pio == 255)
+		pio = ide_find_best_mode(drive, XFER_PIO | XFER_EPIO) - XFER_PIO_0;
 	config_art_rwp_pio(drive, pio);
-	return ide_config_drive_speed(drive, (XFER_PIO_0 + pio));
-#else
-	u8 speed;
-
-	switch(pio) {
-		case 4:		speed = XFER_PIO_4; break;
-		case 3:		speed = XFER_PIO_3; break;
-		case 2:		speed = XFER_PIO_2; break;
-		case 1:		speed = XFER_PIO_1; break;
-		default:	speed = XFER_PIO_0; break;
-	}
-
-	config_art_rwp_pio(drive, pio);
-	return ide_config_drive_speed(drive, speed);
-#endif
+	return ide_config_drive_speed(drive, XFER_PIO_0 + min_t(u8, pio, 4));
 }
 
 static int sis5513_tune_chipset (ide_drive_t *drive, u8 xferspeed)
@@ -690,24 +558,8 @@
 	u8 drive_pci, reg, speed;
 	u32 regdw;
 
-#ifdef DEBUG
-	sis5513_load_verify_registers(dev, "sis5513_tune_chipset start");
-#endif
-
-#ifdef BROKEN_LEVEL
-#ifdef DEBUG
-	printk("SIS5513: BROKEN_LEVEL activated, speed=%d -> speed=%d\n", xferspeed, BROKEN_LEVEL);
-#endif
-	if (xferspeed > BROKEN_LEVEL) xferspeed = BROKEN_LEVEL;
-#endif
-
 	speed = ide_rate_filter(sis5513_ratemask(drive), xferspeed);
 
-#ifdef DEBUG
-	printk("SIS5513: sis5513_tune_chipset, drive %d, speed %d\n",
-	       drive->dn, xferspeed);
-#endif
-
 	/* See config_art_rwp_pio for drive pci config registers */
 	drive_pci = 0x40;
 	if (chipset_family >= ATA_133) {
@@ -746,14 +598,14 @@
 				regdw &= 0xfffff00f;
 				/* check if ATA133 enable */
 				if (regdw & 0x08) {
-					regdw |= (unsigned long)cycle_time_value[ATA_133-ATA_00][speed-XFER_UDMA_0] << 4;
-					regdw |= (unsigned long)cvs_time_value[ATA_133-ATA_00][speed-XFER_UDMA_0] << 8;
+					regdw |= (unsigned long)cycle_time_value[ATA_133][speed-XFER_UDMA_0] << 4;
+					regdw |= (unsigned long)cvs_time_value[ATA_133][speed-XFER_UDMA_0] << 8;
 				} else {
 				/* if ATA133 disable, we should not set speed above UDMA5 */
 					if (speed > XFER_UDMA_5)
 						speed = XFER_UDMA_5;
-					regdw |= (unsigned long)cycle_time_value[ATA_100-ATA_00][speed-XFER_UDMA_0] << 4;
-					regdw |= (unsigned long)cvs_time_value[ATA_100-ATA_00][speed-XFER_UDMA_0] << 8;
+					regdw |= (unsigned long)cycle_time_value[ATA_100][speed-XFER_UDMA_0] << 4;
+					regdw |= (unsigned long)cvs_time_value[ATA_100][speed-XFER_UDMA_0] << 8;
 				}
 				pci_write_config_dword(dev, (unsigned long)drive_pci, regdw);
 			} else {
@@ -763,7 +615,7 @@
 				reg &= ~((0xFF >> (8 - cycle_time_range[chipset_family]))
 					 << cycle_time_offset[chipset_family]);
 				/* set reg cycle time bits */
-				reg |= cycle_time_value[chipset_family-ATA_00][speed-XFER_UDMA_0]
+				reg |= cycle_time_value[chipset_family][speed-XFER_UDMA_0]
 					<< cycle_time_offset[chipset_family];
 				pci_write_config_byte(dev, drive_pci+1, reg);
 			}
@@ -782,9 +634,7 @@
 		case XFER_PIO_0:
 		default:	 return((int) config_chipset_for_pio(drive, 0));	
 	}
-#ifdef DEBUG
-	sis5513_load_verify_registers(dev, "sis5513_tune_chipset end");
-#endif
+
 	return ((int) ide_config_drive_speed(drive, speed));
 }
 
@@ -863,18 +713,34 @@
 	return sis5513_config_drive_xfer_rate(drive);
 }
 
-/* Helper function used at init time
- * returns a PCI device revision ID
- * (used to detect different IDE controller versions)
- */
-static u8 __init devfn_rev(int device, int function)
+/*
+  Future simpler config_xfer_rate :
+   When ide_find_best_mode is made bad-drive aware
+   - remove config_drive_xfer_rate and config_chipset_for_dma,
+   - replace config_xfer_rate with the following
+
+static int sis5513_config_xfer_rate (ide_drive_t *drive)
 {
-	u8 revision;
-	/* Find device */
-	struct pci_dev* dev = pci_find_slot(0,PCI_DEVFN(device,function));
-	pci_read_config_byte(dev, PCI_REVISION_ID, &revision);
-	return revision;
+	u16 w80 = HWIF(drive)->udma_four;
+	u16 speed;
+
+	config_drive_art_rwp(drive);
+	config_art_rwp_pio(drive, 5);
+
+	speed = ide_find_best_mode(drive,
+		XFER_PIO | XFER_EPIO | XFER_SWDMA | XFER_MWDMA |
+		(chipset_family >= ATA_33 ? XFER_UDMA : 0) |
+		(w80 && chipset_family >= ATA_66 ? XFER_UDMA_66 : 0) |
+		(w80 && chipset_family >= ATA_100a ? XFER_UDMA_100 : 0) |
+		(w80 && chipset_family >= ATA_133a ? XFER_UDMA_133 : 0));
+
+	sis5513_tune_chipset(drive, speed);
+
+	if (drive->autodma && (speed & XFER_MODE) != XFER_PIO)
+		return HWIF(drive)->ide_dma_on(drive);
+	return HWIF(drive)->ide_dma_off_quietly(drive);
 }
+*/
 
 /* Chip detection and general config */
 static unsigned int __init init_chipset_sis5513 (struct pci_dev *dev, const char *name)
@@ -882,71 +748,86 @@
 	struct pci_dev *host;
 	int i = 0;
 
-	/* Find the chip */
-	for (i = 0; i < ARRAY_SIZE(SiSHostChipInfo) && !host_dev; i++) {
-		host = pci_find_device (PCI_VENDOR_ID_SI,
-					SiSHostChipInfo[i].host_id,
-					NULL);
+	chipset_family = 0;
+
+	for (i = 0; i < ARRAY_SIZE(SiSHostChipInfo) && !chipset_family; i++) {
+
+		host = pci_find_device(PCI_VENDOR_ID_SI, SiSHostChipInfo[i].host_id, NULL);
+
 		if (!host)
 			continue;
 
-		host_dev = host;
 		chipset_family = SiSHostChipInfo[i].chipset_family;
+
+		/* Special case for SiS630 : 630S/ET is ATA_100a */
+		if (SiSHostChipInfo[i].host_id == PCI_DEVICE_ID_SI_630) {
+			u8 hostrev;
+			pci_read_config_byte(host, PCI_REVISION_ID, &hostrev);
+			if (hostrev >= 0x30)
+				chipset_family = ATA_100a;
+		}
 	
-		/* check 100/133 chipset family */
-		if (chipset_family == ATA_133) {
-			u32 reg54h;
-			u16 devid;
-			pci_read_config_dword(dev, 0x54, &reg54h);
-			/* SiS962 and above report 0x5518 dev id if high bit is cleared */
-			pci_write_config_dword(dev, 0x54, (reg54h & 0x7fffffff));
-			pci_read_config_word(dev, 0x02, &devid);
-			/* restore register 0x54 */
-			pci_write_config_dword(dev, 0x54, reg54h);
-
-			/* devid 5518 here means SiS962 or later
-			   which supports ATA133.
-			   These are refered by chipset_family = ATA133
-			*/
-			if (devid != 0x5518) {
-				u8 reg49h;
-				/* SiS961 family */
-				pci_read_config_byte(dev, 0x49, &reg49h);
-				/* check isa bridge device rev id */
-				if (((devfn_rev(2,0) & 0xff) == 0x10) && (reg49h & 0x80))
-					chipset_family = ATA_133a;
-				else
-					chipset_family = ATA_100;
+		printk(KERN_INFO "SIS5513: %s %s controller\n",
+			 SiSHostChipInfo[i].name, chipset_capability[chipset_family]);
+	}
+
+	if (!chipset_family) { /* Belongs to pci-quirks */
+
+			u32 idemisc;
+			u16 trueid;
+
+			/* Disable ID masking and register remapping */
+			pci_read_config_dword(dev, 0x54, &idemisc);
+			pci_write_config_dword(dev, 0x54, (idemisc & 0x7fffffff));
+			pci_read_config_word(dev, PCI_DEVICE_ID, &trueid);
+			pci_write_config_dword(dev, 0x54, idemisc);
+
+			if (trueid == 0x5518) {
+				printk(KERN_INFO "SIS5513: SiS 962/963 MuTIOL IDE UDMA133 controller\n");
+				chipset_family = ATA_133;
 			}
-		}
-		printk(SiSHostChipInfo[i].name);
-		printk("    %s controller", chipset_capability[chipset_family]);
-		printk("\n");
+	}
 
-#ifdef DEBUG
-		sis5513_print_registers(dev, "pci_init_sis5513 start");
-#endif
+	if (!chipset_family) { /* Belongs to pci-quirks */
 
-		if (SiSHostChipInfo[i].flags & SIS5513_LATENCY) {
-			u8 latency = (chipset_family == ATA_100)? 0x80 : 0x10; /* Lacking specs */
-			pci_write_config_byte(dev, PCI_LATENCY_TIMER, latency);
-		}
+			struct pci_dev *lpc_bridge;
+			u16 trueid;
+			u8 prefctl;
+			u8 idecfg;
+			u8 sbrev;
+
+			pci_read_config_byte(dev, 0x4a, &idecfg);
+			pci_write_config_byte(dev, 0x4a, idecfg | 0x10);
+			pci_read_config_word(dev, PCI_DEVICE_ID, &trueid);
+			pci_write_config_byte(dev, 0x4a, idecfg);
+
+			if (trueid == 0x5517) { /* SiS 961/961B */
+
+				lpc_bridge = pci_find_slot(0x00, 0x10); /* Bus 0, Dev 2, Fn 0 */
+				pci_read_config_byte(lpc_bridge, PCI_REVISION_ID, &sbrev);
+				pci_read_config_byte(dev, 0x49, &prefctl);
 
-		/* Special case for SiS630 : 630S/ET is ATA_100a */
-		if (SiSHostChipInfo[i].host_id == PCI_DEVICE_ID_SI_630) {
-			/* check host device rev id */
-			if (devfn_rev(0,0) >= 0x30) {
-				chipset_family = ATA_100a;
+				if (sbrev == 0x10 && (prefctl & 0x80)) {
+					printk(KERN_INFO "SIS5513: SiS 961B MuTIOL IDE UDMA133 controller\n");
+					chipset_family = ATA_133a;
+				} else {
+					printk(KERN_INFO "SIS5513: SiS 961 MuTIOL IDE UDMA100 controller\n");
+					chipset_family = ATA_100;
+				}
 			}
-		}
 	}
 
+	if (!chipset_family)
+		return -1;
+
 	/* Make general config ops here
 	   1/ tell IDE channels to operate in Compatibility mode only
 	   2/ tell old chips to allow per drive IDE timings */
-	if (host_dev) {
+
+	{
 		u8 reg;
 		u16 regw;
+
 		switch(chipset_family) {
 			case ATA_133:
 				/* SiS962 operation mode */
@@ -959,6 +840,8 @@
 				break;
 			case ATA_133a:
 			case ATA_100:
+				/* Fixup latency */
+				pci_write_config_byte(dev, PCI_LATENCY_TIMER, 0x80);
 				/* Set compatibility bit */
 				pci_read_config_byte(dev, 0x49, &reg);
 				if (!(reg & 0x01)) {
@@ -967,6 +850,9 @@
 				break;
 			case ATA_100a:
 			case ATA_66:
+				/* Fixup latency */
+				pci_write_config_byte(dev, PCI_LATENCY_TIMER, 0x10);
+
 				/* On ATA_66 chips the bit was elsewhere */
 				pci_read_config_byte(dev, 0x52, &reg);
 				if (!(reg & 0x04)) {
@@ -987,8 +873,6 @@
 					pci_write_config_byte(dev, 0x52, reg|0x08);
 				}
 				break;
-			case ATA_00:
-			default: break;
 		}
 
 #if defined(DISPLAY_SIS_TIMINGS) && defined(CONFIG_PROC_FS)
@@ -999,9 +883,7 @@
 		}
 #endif
 	}
-#ifdef DEBUG
-	sis5513_load_verify_registers(dev, "pci_init_sis5513 end");
-#endif
+
 	return 0;
 }
 
@@ -1044,7 +926,7 @@
 	hwif->mwdma_mask = 0x07;
 	hwif->swdma_mask = 0x07;
 
-	if (!host_dev)
+	if (!chipset_family)
 		return;
 
 	if (!(hwif->udma_four))
@@ -1102,19 +984,16 @@
 module_init(sis5513_ide_init);
 module_exit(sis5513_ide_exit);
 
-MODULE_AUTHOR("Lionel Bouton, L C Chang, Andre Hedrick");
+MODULE_AUTHOR("Lionel Bouton, L C Chang, Andre Hedrick, Vojtech Pavlik");
 MODULE_DESCRIPTION("PCI driver module for SIS IDE");
 MODULE_LICENSE("GPL");
 
 /*
  * TODO:
- *	- Get ridden of SisHostChipInfo[] completness dependancy.
- *	- Study drivers/ide/ide-timing.h.
- *	- Are there pre-ATA_16 SiS5513 chips ? -> tune init code for them
- *	  or remove ATA_00 define
+ *	- CLEANUP
+ *	- Use drivers/ide/ide-timing.h !
  *	- More checks in the config registers (force values instead of
  *	  relying on the BIOS setting them correctly).
  *	- Further optimisations ?
  *	  . for example ATA66+ regs 0x48 & 0x4A
  */
-
diff -urN -X dontdiff --exclude=tmp_include_depends linux-2.5.72-bk2/include/linux/pci_ids.h linux-2.5.72-bk2-sis/include/linux/pci_ids.h
--- linux-2.5.72-bk2/include/linux/pci_ids.h	2003-06-19 23:13:14.000000000 +0200
+++ linux-2.5.72-bk2-sis/include/linux/pci_ids.h	2003-06-19 23:23:33.000000000 +0200
@@ -549,6 +549,7 @@
 #define PCI_DEVICE_ID_SI_601		0x0601
 #define PCI_DEVICE_ID_SI_620		0x0620
 #define PCI_DEVICE_ID_SI_630		0x0630
+#define PCI_DEVICE_ID_SI_633		0x0633
 #define PCI_DEVICE_ID_SI_635		0x0635
 #define PCI_DEVICE_ID_SI_640		0x0640
 #define PCI_DEVICE_ID_SI_645		0x0645
@@ -559,6 +560,7 @@
 #define PCI_DEVICE_ID_SI_652		0x0652
 #define PCI_DEVICE_ID_SI_655		0x0655
 #define PCI_DEVICE_ID_SI_730		0x0730
+#define PCI_DEVICE_ID_SI_733		0x0733
 #define PCI_DEVICE_ID_SI_630_VGA	0x6300
 #define PCI_DEVICE_ID_SI_730_VGA	0x7300
 #define PCI_DEVICE_ID_SI_735		0x0735
@@ -579,7 +581,10 @@
 #define PCI_DEVICE_ID_SI_5513		0x5513
 #define PCI_DEVICE_ID_SI_5518		0x5518
 #define PCI_DEVICE_ID_SI_5571		0x5571
+#define PCI_DEVICE_ID_SI_5581		0x5581
+#define PCI_DEVICE_ID_SI_5582		0x5582
 #define PCI_DEVICE_ID_SI_5591		0x5591
+#define PCI_DEVICE_ID_SI_5596		0x5596
 #define PCI_DEVICE_ID_SI_5597		0x5597
 #define PCI_DEVICE_ID_SI_5598		0x5598
 #define PCI_DEVICE_ID_SI_5600		0x5600

--------------030705070505070702080804--

