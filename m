Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268023AbTBRS0H>; Tue, 18 Feb 2003 13:26:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268018AbTBRSZU>; Tue, 18 Feb 2003 13:25:20 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:59145 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268017AbTBRSX5>; Tue, 18 Feb 2003 13:23:57 -0500
Subject: PATCH: update sis driver
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 18 Feb 2003 18:34:14 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E18lCZK-0006EU-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/drivers/ide/pci/sis5513.c linux-2.5.61-ac2/drivers/ide/pci/sis5513.c
--- linux-2.5.61/drivers/ide/pci/sis5513.c	2003-02-10 18:38:37.000000000 +0000
+++ linux-2.5.61-ac2/drivers/ide/pci/sis5513.c	2003-02-18 18:06:19.000000000 +0000
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/sis5513.c		Version 0.14ac	Sept 11, 2002
+ * linux/drivers/ide/pci/sis5513.c		Version 0.14ac	Sept 11, 2002
  *
  * Copyright (C) 1999-2000	Andre Hedrick <andre@linux-ide.org>
  * Copyright (C) 2002		Lionel Bouton <Lionel.Bouton@inet6.fr>, Maintainer
@@ -10,7 +10,7 @@
  *
  * SiS Taiwan		: for direct support and hardware.
  * Daniela Engert	: for initial ATA100 advices and numerous others.
- * John Fremlin, Manfred Spraul, Dave Morgan :
+ * John Fremlin, Manfred Spraul, Dave Morgan, Peter Kjellerstedt	:
  *			  for checking code correctness, providing patches.
  *
  *
@@ -18,18 +18,27 @@
  * ATA100 tests and design on the SiS735/5513 chipset.
  * ATA16/33 support from specs
  * ATA133 support for SiS961/962 by L.C. Chang <lcchang@sis.com.tw>
+ *
+ * Documentation:
+ *	SiS chipset documentation available under NDA to companies not
+ *	individuals only.
  */
 
 /*
- * TODO:
- *	- Get ridden of SisHostChipInfo[] completness dependency.
- *	- Study drivers/ide/ide-timing.h.
- *	- Are there pre-ATA_16 SiS5513 chips ? -> tune init code for them
- *	  or remove ATA_00 define
- *	- More checks in the config registers (force values instead of
- *	  relying on the BIOS setting them correctly).
- *	- Further optimisations ?
- *	  . for example ATA66+ regs 0x48 & 0x4A
+ * Notes/Special cases:
+ * - SiS5513 derivatives usually have the same PCI IDE register layout when
+ *  supporting the same UDMA modes.
+ * - There are exceptions :
+ *  . SiS730 and SiS550 use the same layout than ATA_66 chipsets but support
+ *   ATA_100
+ *  . ATA_133 capable chipsets mark a shift in SiS chipset designs : previously
+ *   south and northbridge were integrated, making IDE (a southbridge function)
+ *   capabilities easily deduced from the northbridge PCI id. With ATA_133,
+ *   chipsets started to be split in the usual north/south bridges chips
+ *   -> the driver needs to detect the correct southbridge when faced to newest
+ *   northbridges.
+ *  . On ATA133 capable chipsets when bit 30 of dword at 0x54 is 1 the
+ *   configuration space is moved from 0x40 to 0x70.
  */
 
 #include <linux/config.h>
@@ -64,7 +73,7 @@
 /* Miscellaneaous flags */
 #define SIS5513_LATENCY		0x01
 
-/* registers layout and init values are chipset family dependent */
+/* registers layout and init values are chipset family dependant */
 /* 1/ define families */
 #define ATA_00		0x00
 #define ATA_16		0x01
@@ -298,6 +307,7 @@
 static char* get_drives_info (char *buffer, u8 pos)
 {
 	u8 reg00, reg01, reg10, reg11; /* timing registers */
+	u32 regdw0, regdw1;
 	char* p = buffer;
 
 /* Postwrite/Prefetch */
@@ -313,13 +323,31 @@
 		pci_read_config_byte(bmide_dev, 0x41+2*pos, &reg01);
 		pci_read_config_byte(bmide_dev, 0x44+2*pos, &reg10);
 		pci_read_config_byte(bmide_dev, 0x45+2*pos, &reg11);
+	} else {
+		u32 reg54h;
+		u8 drive_pci = 0x40;
+		pci_read_config_dword(bmide_dev, 0x54, &reg54h);
+		if (reg54h & 0x40000000) {
+			// Configuration space remapped to 0x70
+			drive_pci = 0x70;
+		}
+		pci_read_config_dword(bmide_dev, (unsigned long)drive_pci+8*pos, &regdw0);
+		pci_read_config_dword(bmide_dev, (unsigned long)drive_pci+8*pos+4, &regdw1);
+		p += sprintf(p, "Drive %d:\n", pos);
 	}
 
 
 /* UDMA */
-	if (chipset_family >= ATA_33) {
+	if (chipset_family >= ATA_133) {
+		p += sprintf(p, "                UDMA %s \t \t \t UDMA %s\n",
+			     (regdw0 & 0x04) ? "Enabled" : "Disabled",
+			     (regdw1 & 0x04) ? "Enabled" : "Disabled");
+		p += sprintf(p, "                UDMA Cycle Time    %s \t UDMA Cycle Time    %s\n",
+			     cycle_time[(regdw0 & 0xF0) >> 4],
+			     cycle_time[(regdw1 & 0xF0) >> 4]);
+	} else if (chipset_family >= ATA_33) {
 		p += sprintf(p, "                UDMA %s \t \t \t UDMA %s\n",
-			     (reg01 & 0x80)  ? "Enabled" : "Disabled",
+			     (reg01 & 0x80) ? "Enabled" : "Disabled",
 			     (reg11 & 0x80) ? "Enabled" : "Disabled");
 
 		p += sprintf(p, "                UDMA Cycle Time    ");
@@ -659,13 +687,11 @@
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev *dev	= hwif->pci_dev;
 
-	u8 drive_pci, reg;
+	u8 drive_pci, reg, speed;
 	u32 regdw;
 
 #ifdef DEBUG
 	sis5513_load_verify_registers(dev, "sis5513_tune_chipset start");
-	printk("SIS5513: sis5513_tune_chipset, drive %d, speed %d\n",
-	       drive->dn, speed);
 #endif
 
 #ifdef BROKEN_LEVEL
@@ -675,7 +701,12 @@
 	if (xferspeed > BROKEN_LEVEL) xferspeed = BROKEN_LEVEL;
 #endif
 
-	u8 speed = ide_rate_filter(sis5513_ratemask(drive), xferspeed);
+	speed = ide_rate_filter(sis5513_ratemask(drive), xferspeed);
+
+#ifdef DEBUG
+	printk("SIS5513: sis5513_tune_chipset, drive %d, speed %d\n",
+	       drive->dn, xferspeed);
+#endif
 
 	/* See config_art_rwp_pio for drive pci config registers */
 	drive_pci = 0x40;
@@ -770,7 +801,7 @@
 	u8 speed	= ide_dma_speed(drive, sis5513_ratemask(drive));
 
 #ifdef DEBUG
-	printk("SIS5513: config_chipset_for_dma, drive %d, ultra %x, udma_66 %x\n",
+	printk("SIS5513: config_chipset_for_dma, drive %d, ultra %x\n",
 	       drive->dn, drive->id->dma_ultra);
 #endif
 
@@ -1057,3 +1088,16 @@
 MODULE_LICENSE("GPL");
 
 EXPORT_NO_SYMBOLS;
+
+/*
+ * TODO:
+ *	- Get ridden of SisHostChipInfo[] completness dependancy.
+ *	- Study drivers/ide/ide-timing.h.
+ *	- Are there pre-ATA_16 SiS5513 chips ? -> tune init code for them
+ *	  or remove ATA_00 define
+ *	- More checks in the config registers (force values instead of
+ *	  relying on the BIOS setting them correctly).
+ *	- Further optimisations ?
+ *	  . for example ATA66+ regs 0x48 & 0x4A
+ */
+
