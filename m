Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312940AbSDBV0n>; Tue, 2 Apr 2002 16:26:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312942AbSDBV01>; Tue, 2 Apr 2002 16:26:27 -0500
Received: from APuteaux-101-2-1-180.abo.wanadoo.fr ([193.251.40.180]:60686
	"EHLO inet6.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S312939AbSDBV0F>; Tue, 2 Apr 2002 16:26:05 -0500
Date: Tue, 2 Apr 2002 23:25:04 +0200
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org, Andre Hedrick <andre@linux-ide.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [SiS IDE Patch] Against 2.4.19-pre5, Bugfixes
Message-ID: <20020402232504.A6538@bouton.inet6-interne.fr>
Mail-Followup-To: Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel@vger.kernel.org, Andre Hedrick <andre@linux-ide.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

the following patch (text/plain attachement) solves the problems people
keep reporting about 2.4.19-pre3 -> pre5 SiS IDE support. This is the
very same code as in latests AC kernels.

Please apply.

LB

--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sis.patch.20020402_1"

diff -urN -X dontdiff linux-2.4.19-pre5/MAINTAINERS linux-2.4.19-pre5-sis/MAINTAINERS
--- linux-2.4.19-pre5/MAINTAINERS	Tue Apr  2 22:48:26 2002
+++ linux-2.4.19-pre5-sis/MAINTAINERS	Tue Apr  2 22:59:32 2002
@@ -1395,6 +1395,13 @@
 M:	mingo@redhat.com
 S:	Maintained
 
+SIS 5513 IDE CONTROLLER DRIVER
+P:      Lionel Bouton
+M:      Lionel.Bouton@inet6.fr
+W:      http://inet6.dyn.dhs.org/sponsoring/sis5513/index.html
+W:      http://gyver.homeip.net/sis5513/index.html
+S:      Maintained
+
 SIS 900/7016 FAST ETHERNET DRIVER
 P:	Ollie Lho
 M:	ollie@sis.com.tw
diff -urN -X dontdiff linux-2.4.19-pre5/drivers/ide/sis5513.c linux-2.4.19-pre5-sis/drivers/ide/sis5513.c
--- linux-2.4.19-pre5/drivers/ide/sis5513.c	Tue Apr  2 22:48:34 2002
+++ linux-2.4.19-pre5-sis/drivers/ide/sis5513.c	Tue Apr  2 22:57:08 2002
@@ -1,12 +1,19 @@
 /*
- * linux/drivers/ide/sis5513.c		Version 0.13	February 14, 2002
+ * linux/drivers/ide/sis5513.c		Version 0.13	March 6, 2002
  *
  * Copyright (C) 1999-2000	Andre Hedrick <andre@linux-ide.org>
  * Copyright (C) 2002		Lionel Bouton <Lionel.Bouton@inet6.fr>, Maintainer
  * May be copied or modified under the terms of the GNU General Public License
  *
- * Thanks to SIS Taiwan for direct support and hardware.
- * Thanks to Daniela Engert for ATA100 support advice.
+ *
+ * Thanks :
+ *
+ * SiS Taiwan		: for direct support and hardware.
+ * Daniela Engert	: for initial ATA100 advices and numerous others.
+ * John Fremlin, Manfred Spraul :
+ *			  for checking code correctness, providing patches.
+ *
+ *
  * Original tests and design on the SiS620/5513 chipset.
  * ATA100 tests and design on the SiS735/5513 chipset.
  * ATA16/33 design from specs
@@ -14,11 +21,11 @@
 
 /*
  * TODO:
- *	- Are there pre-ATA_16 SiS chips ? -> tune init code for them
- *	  or remove ATA_00 defines
  *	- Get ridden of SisHostChipInfo[] completness dependancy.
  *	- Get ATA-133 datasheets, implement ATA-133 init code.
- *	- Check latency timer init correctness.
+ *	- Study drivers/ide/ide-timing.h.
+ *	- Are there pre-ATA_16 SiS5513 chips ? -> tune init code for them
+ *	  or remove ATA_00 define
  *	- More checks in the config registers (force values instead of
  *	  relying on the BIOS setting them correctly).
  *	- Further optimisations ?
@@ -45,62 +52,45 @@
 
 #include "ide_modes.h"
 
-#define DEBUG
-/* if BROKEN_LEVEL is defined it limits the DMA mode
+/* When DEBUG is defined it outputs initial PCI config register
+   values and changes made to them by the driver */   
+// #define DEBUG
+/* When BROKEN_LEVEL is defined it limits the DMA mode
    at boot time to its value */
 // #define BROKEN_LEVEL XFER_SW_DMA_0
 #define DISPLAY_SIS_TIMINGS
 
 /* Miscellaneaous flags */
 #define SIS5513_LATENCY		0x01
-/* ATA transfer mode capabilities */
+
+/* registers layout and init values are chipset family dependant */
+/* 1/ define families */
 #define ATA_00		0x00
 #define ATA_16		0x01
 #define ATA_33		0x02
 #define ATA_66		0x03
-#define ATA_100		0x04
-#define ATA_133		0x05
-
-static unsigned char dma_capability = 0x00;
+#define ATA_100a	0x04 // SiS730 is ATA100 with ATA66 layout
+#define ATA_100		0x05
+#define ATA_133		0x06
+/* 2/ variable holding the controller chipset family value */
+static unsigned char chipset_family;
 
 
 /*
  * Debug code: following IDE config registers' changes
  */
 #ifdef DEBUG
-/* Copy of IDE Config registers 0x00 -> 0x58
+/* Copy of IDE Config registers 0x00 -> 0x57
    Fewer might be used depending on the actual chipset */
-static unsigned char ide_regs_copy[] = {
-	0x0, 0x0, 0x0, 0x0,
-	0x0, 0x0, 0x0, 0x0,
-	0x0, 0x0, 0x0, 0x0,
-	0x0, 0x0, 0x0, 0x0,
-	0x0, 0x0, 0x0, 0x0,
-	0x0, 0x0, 0x0, 0x0,
-	0x0, 0x0, 0x0, 0x0,
-	0x0, 0x0, 0x0, 0x0,
-	0x0, 0x0, 0x0, 0x0,
-	0x0, 0x0, 0x0, 0x0,
-	0x0, 0x0, 0x0, 0x0,
-	0x0, 0x0, 0x0, 0x0,
-	0x0, 0x0, 0x0, 0x0,
-	0x0, 0x0, 0x0, 0x0,
-	0x0, 0x0, 0x0, 0x0,
-	0x0, 0x0, 0x0, 0x0,
-	0x0, 0x0, 0x0, 0x0,
-	0x0, 0x0, 0x0, 0x0,
-	0x0, 0x0, 0x0, 0x0,
-	0x0, 0x0, 0x0, 0x0,
-	0x0, 0x0, 0x0, 0x0,
-	0x0, 0x0, 0x0, 0x0
-};
+static unsigned char ide_regs_copy[0x58];
 
 static byte sis5513_max_config_register(void) {
-	switch(dma_capability) {
+	switch(chipset_family) {
 		case ATA_00:
 		case ATA_16:	return 0x4f;
 		case ATA_33:	return 0x52;
 		case ATA_66:
+		case ATA_100a:
 		case ATA_100:
 		case ATA_133:
 		default:	return 0x57;
@@ -145,7 +135,7 @@
 	printk(" %0#x:%0#x", reg, ide_regs_copy[reg]);
 }
 
-/* Print valuable registers (for ATA100) */
+/* Print valuable registers */
 static void sis5513_print_registers(struct pci_dev* dev, char* marker) {
 	int i;
 	byte max = sis5513_max_config_register();
@@ -176,14 +166,14 @@
 static const struct {
 	const char *name;
 	unsigned short host_id;
-	unsigned char dma_capability;
+	unsigned char chipset_family;
 	unsigned char flags;
 } SiSHostChipInfo[] = {
 	{ "SiS750",	PCI_DEVICE_ID_SI_750,	ATA_100,	SIS5513_LATENCY },
 	{ "SiS745",	PCI_DEVICE_ID_SI_745,	ATA_100,	SIS5513_LATENCY },
 	{ "SiS740",	PCI_DEVICE_ID_SI_740,	ATA_100,	SIS5513_LATENCY },
 	{ "SiS735",	PCI_DEVICE_ID_SI_735,	ATA_100,	SIS5513_LATENCY },
-	{ "SiS730",	PCI_DEVICE_ID_SI_730,	ATA_100,	SIS5513_LATENCY },
+	{ "SiS730",	PCI_DEVICE_ID_SI_730,	ATA_100a,	SIS5513_LATENCY },
 	{ "SiS650",	PCI_DEVICE_ID_SI_650,	ATA_100,	SIS5513_LATENCY },
 	{ "SiS645",	PCI_DEVICE_ID_SI_645,	ATA_100,	SIS5513_LATENCY },
 	{ "SiS635",	PCI_DEVICE_ID_SI_635,	ATA_100,	SIS5513_LATENCY },
@@ -202,14 +192,15 @@
 
 /* Cycle time bits and values vary accross chip dma capabilities
    These three arrays hold the register layout and the values to set.
-   Indexed by dma_capability and (dma_mode - XFER_UDMA_0) */
-static byte cycle_time_offset[] = {0,0,5,4,0,0};
-static byte cycle_time_range[] = {0,0,2,3,4,4};
+   Indexed by chipset_family and (dma_mode - XFER_UDMA_0) */
+static byte cycle_time_offset[] = {0,0,5,4,4,0,0};
+static byte cycle_time_range[] = {0,0,2,3,3,4,4};
 static byte cycle_time_value[][XFER_UDMA_5 - XFER_UDMA_0 + 1] = {
 	{0,0,0,0,0,0}, /* no udma */
 	{0,0,0,0,0,0}, /* no udma */
 	{3,2,1,0,0,0},
 	{7,5,3,2,1,0},
+	{7,5,3,2,1,0},
 	{11,7,5,4,2,1},
 	{0,0,0,0,0,0} /* not yet known, ask SiS */
 };
@@ -283,23 +274,25 @@
 	pci_read_config_byte(bmide_dev, 0x45+2*pos, &reg11);
 
 /* UDMA */
-	if (dma_capability >= ATA_33) {
+	if (chipset_family >= ATA_33) {
 		p += sprintf(p, "                UDMA %s \t \t \t UDMA %s\n",
 			     (reg01 & 0x80)  ? "Enabled" : "Disabled",
 			     (reg11 & 0x80) ? "Enabled" : "Disabled");
 
 		p += sprintf(p, "                UDMA Cycle Time    ");
-		switch(dma_capability) {
+		switch(chipset_family) {
 			case ATA_33:	p += sprintf(p, cycle_time[(reg01 & 0x60) >> 5]); break;
-			case ATA_66:	p += sprintf(p, cycle_time[(reg01 & 0x70) >> 4]); break;
+			case ATA_66:
+			case ATA_100a:	p += sprintf(p, cycle_time[(reg01 & 0x70) >> 4]); break;
 			case ATA_100:	p += sprintf(p, cycle_time[reg01 & 0x0F]); break;
 			case ATA_133:
 			default:	p += sprintf(p, "133+ ?"); break;
 		}
 		p += sprintf(p, " \t UDMA Cycle Time    ");
-		switch(dma_capability) {
+		switch(chipset_family) {
 			case ATA_33:	p += sprintf(p, cycle_time[(reg11 & 0x60) >> 5]); break;
-			case ATA_66:	p += sprintf(p, cycle_time[(reg11 & 0x70) >> 4]); break;
+			case ATA_66:
+			case ATA_100a:	p += sprintf(p, cycle_time[(reg11 & 0x70) >> 4]); break;
 			case ATA_100:	p += sprintf(p, cycle_time[reg11 & 0x0F]); break;
 			case ATA_133:
 			default:	p += sprintf(p, "133+ ?"); break;
@@ -309,21 +302,23 @@
 
 /* Data Active */
 	p += sprintf(p, "                Data Active Time   ");
-	switch(dma_capability) {
+	switch(chipset_family) {
 		case ATA_00:
 		case ATA_16: /* confirmed */
 		case ATA_33:
-		case ATA_66: p += sprintf(p, active_time[reg01 & 0x07]); break;
+		case ATA_66:
+		case ATA_100a: p += sprintf(p, active_time[reg01 & 0x07]); break;
 		case ATA_100: p += sprintf(p, active_time[(reg00 & 0x70) >> 4]); break;
 		case ATA_133:
 		default: p += sprintf(p, "133+ ?"); break;
 	}
 	p += sprintf(p, " \t Data Active Time   ");
-	switch(dma_capability) {
+	switch(chipset_family) {
 		case ATA_00:
 		case ATA_16:
 		case ATA_33:
-		case ATA_66: p += sprintf(p, active_time[reg11 & 0x07]); break;
+		case ATA_66:
+		case ATA_100a: p += sprintf(p, active_time[reg11 & 0x07]); break;
 		case ATA_100: p += sprintf(p, active_time[(reg10 & 0x70) >> 4]); break;
 		case ATA_133:
 		default: p += sprintf(p, "133+ ?"); break;
@@ -356,11 +351,12 @@
 	u16 reg2, reg3;
 
 	p += sprintf(p, "\nSiS 5513 ");
-	switch(dma_capability) {
+	switch(chipset_family) {
 		case ATA_00: p += sprintf(p, "Unknown???"); break;
 		case ATA_16: p += sprintf(p, "DMA 16"); break;
 		case ATA_33: p += sprintf(p, "Ultra 33"); break;
 		case ATA_66: p += sprintf(p, "Ultra 66"); break;
+		case ATA_100a:
 		case ATA_100: p += sprintf(p, "Ultra 100"); break;
 		case ATA_133:
 		default: p+= sprintf(p, "Ultra 133+"); break;
@@ -371,7 +367,7 @@
 /* Status */
 	pci_read_config_byte(bmide_dev, 0x4a, &reg);
 	p += sprintf(p, "Channel Status: ");
-	if (dma_capability < ATA_66) {
+	if (chipset_family < ATA_66) {
 		p += sprintf(p, "%s \t \t \t \t %s\n",
 			     (reg & 0x04) ? "On" : "Off",
 			     (reg & 0x02) ? "On" : "Off");
@@ -388,7 +384,7 @@
 		     (reg & 0x04) ? "Native" : "Compatible");
 
 /* 80-pin cable ? */
-	if (dma_capability > ATA_33) {
+	if (chipset_family > ATA_33) {
 		pci_read_config_byte(bmide_dev, 0x48, &reg);
 		p += sprintf(p, "Cable Type:     %s \t \t \t %s\n",
 			     (reg & 0x10) ? cable_type[1] : cable_type[0],
@@ -489,8 +485,8 @@
 		default:	return;
 	}
 
-	/* register layout changed with ATA100 chips */
-	if (dma_capability < ATA_100) {
+	/* register layout changed with newer ATA100 chips */
+	if (chipset_family < ATA_100) {
 		pci_read_config_byte(dev, drive_pci, &test1);
 		pci_read_config_byte(dev, drive_pci+1, &test2);
 
@@ -570,7 +566,7 @@
 
 	pci_read_config_byte(dev, drive_pci+1, &reg);
 	/* Disable UDMA bit for non UDMA modes on UDMA chips */
-	if ((speed < XFER_UDMA_0) && (dma_capability > ATA_16)) {
+	if ((speed < XFER_UDMA_0) && (chipset_family > ATA_16)) {
 		reg &= 0x7F;
 		pci_write_config_byte(dev, drive_pci+1, reg);
 	}
@@ -584,12 +580,14 @@
 		case XFER_UDMA_2:
 		case XFER_UDMA_1:
 		case XFER_UDMA_0:
+			/* Force the UDMA bit on if we want to use UDMA */
+			reg |= 0x80;
 			/* clean reg cycle time bits */
-			reg &= ~((0xFF >> (8 - cycle_time_range[dma_capability]))
-				 << cycle_time_offset[dma_capability]);
+			reg &= ~((0xFF >> (8 - cycle_time_range[chipset_family]))
+				 << cycle_time_offset[chipset_family]);
 			/* set reg cycle time bits */
-			reg |= cycle_time_value[dma_capability-ATA_00][speed-XFER_UDMA_0]
-				<< cycle_time_offset[dma_capability];
+			reg |= cycle_time_value[chipset_family-ATA_00][speed-XFER_UDMA_0]
+				<< cycle_time_offset[chipset_family];
 			pci_write_config_byte(dev, drive_pci+1, reg);
 			break;
 		case XFER_MW_DMA_2:
@@ -638,17 +636,17 @@
 	       drive->dn, ultra);
 #endif
 
-	if ((id->dma_ultra & 0x0020) && ultra && udma_66 && (dma_capability >= ATA_100))
+	if ((id->dma_ultra & 0x0020) && ultra && udma_66 && (chipset_family >= ATA_100a))
 		speed = XFER_UDMA_5;
-	else if ((id->dma_ultra & 0x0010) && ultra && udma_66 && (dma_capability >= ATA_66))
+	else if ((id->dma_ultra & 0x0010) && ultra && udma_66 && (chipset_family >= ATA_66))
 		speed = XFER_UDMA_4;
-	else if ((id->dma_ultra & 0x0008) && ultra && udma_66 && (dma_capability >= ATA_66))
+	else if ((id->dma_ultra & 0x0008) && ultra && udma_66 && (chipset_family >= ATA_66))
 		speed = XFER_UDMA_3;
-	else if ((id->dma_ultra & 0x0004) && ultra && (dma_capability >= ATA_33))
+	else if ((id->dma_ultra & 0x0004) && ultra && (chipset_family >= ATA_33))
 		speed = XFER_UDMA_2;
-	else if ((id->dma_ultra & 0x0002) && ultra && (dma_capability >= ATA_33))
+	else if ((id->dma_ultra & 0x0002) && ultra && (chipset_family >= ATA_33))
 		speed = XFER_UDMA_1;
-	else if ((id->dma_ultra & 0x0001) && ultra && (dma_capability >= ATA_33))
+	else if ((id->dma_ultra & 0x0001) && ultra && (chipset_family >= ATA_33))
 		speed = XFER_UDMA_0;
 	else if (id->dma_mword & 0x0004)
 		speed = XFER_MW_DMA_2;
@@ -681,6 +679,8 @@
 	struct hd_driveid *id		= drive->id;
 	ide_dma_action_t dma_func	= ide_dma_off_quietly;
 
+	(void) config_chipset_for_pio(drive, 5);
+
 	if (id && (id->capability & 1) && HWIF(drive)->autodma) {
 		/* Consult the list of known "bad" drives */
 		if (ide_dmaproc(ide_dma_bad_drive, drive)) {
@@ -745,10 +745,6 @@
 	struct pci_dev *host;
 	int i = 0;
 
-#ifdef DEBUG
-	sis5513_print_registers(dev, "pci_init_sis5513 start");
-#endif
-
 	/* Find the chip */
 	for (i = 0; i < ARRAY_SIZE(SiSHostChipInfo) && !host_dev; i++) {
 		host = pci_find_device (PCI_VENDOR_ID_SI,
@@ -758,12 +754,16 @@
 			continue;
 
 		host_dev = host;
-		dma_capability = SiSHostChipInfo[i].dma_capability;
+		chipset_family = SiSHostChipInfo[i].chipset_family;
 		printk(SiSHostChipInfo[i].name);
 		printk("\n");
 
+#ifdef DEBUG
+		sis5513_print_registers(dev, "pci_init_sis5513 start");
+#endif
+
 		if (SiSHostChipInfo[i].flags & SIS5513_LATENCY) {
-			byte latency = (dma_capability == ATA_100)? 0x80 : 0x10; /* Lacking specs */
+			byte latency = (chipset_family == ATA_100)? 0x80 : 0x10; /* Lacking specs */
 			pci_write_config_byte(dev, PCI_LATENCY_TIMER, latency);
 		}
 	}
@@ -773,7 +773,7 @@
 	   2/ tell old chips to allow per drive IDE timings */
 	if (host_dev) {
 		byte reg;
-		switch(dma_capability) {
+		switch(chipset_family) {
 			case ATA_133:
 			case ATA_100:
 				/* Set compatibility bit */
@@ -782,6 +782,7 @@
 					pci_write_config_byte(dev, 0x49, reg|0x01);
 				}
 				break;
+			case ATA_100a:
 			case ATA_66:
 				/* On ATA_66 chips the bit was elsewhere */
 				pci_read_config_byte(dev, 0x52, &reg);
@@ -827,7 +828,7 @@
 	byte mask = hwif->channel ? 0x20 : 0x10;
 	pci_read_config_byte(hwif->pci_dev, 0x48, &reg48h);
 
-	if (dma_capability >= ATA_66) {
+	if (chipset_family >= ATA_66) {
 		ata66 = (reg48h & mask) ? 0 : 1;
 	}
         return ata66;
@@ -846,7 +847,7 @@
 
 	if (host_dev) {
 #ifdef CONFIG_BLK_DEV_IDEDMA
-		if (dma_capability > ATA_16) {
+		if (chipset_family > ATA_16) {
 			hwif->autodma = noautodma ? 0 : 1;
 			hwif->dmaproc = &sis5513_dmaproc;
 		} else {

--GvXjxJ+pjyke8COw--
