Return-Path: <linux-kernel-owner+w=401wt.eu-S1751486AbXAHMM0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751486AbXAHMM0 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 07:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbXAHMM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 07:12:26 -0500
Received: from [81.2.110.250] ([81.2.110.250]:56502 "EHLO lxorguk.ukuu.org.uk"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751486AbXAHMMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 07:12:25 -0500
Date: Mon, 8 Jan 2007 12:23:13 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: [PATCH] extract duplicated constants out of PIIX like drivers
Message-ID: <20070108122313.73c08d2e@localhost.localdomain>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.10.4; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Each PIIX driver has two copies of a tiny 10 byte table. Jeff asked that
it was moved to a common place in each driver. Personally I think it
looked a lot better before but as Jeff is maintainer it's his call.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.20-rc3-mm1/drivers/ata/ata_piix.c linux-2.6.20-rc3-mm1/drivers/ata/ata_piix.c
--- linux.vanilla-2.6.20-rc3-mm1/drivers/ata/ata_piix.c	2007-01-05 13:09:36.000000000 +0000
+++ linux-2.6.20-rc3-mm1/drivers/ata/ata_piix.c	2007-01-05 14:07:33.000000000 +0000
@@ -440,6 +440,21 @@
 	[ich8_sata_ahci]	= &ich8_map_db,
 };
 
+/*
+ *	See Intel Document 298600-004 for the timing programing rules
+ *	for ICH controllers.
+ */
+
+static const u8 intel_timings[][2]	= {
+		 /* ISP  RTC */
+		    { 0, 0 },
+		    { 0, 0 },
+		    { 1, 0 },
+		    { 2, 1 },
+		    { 2, 3 }
+};
+
+
 static struct ata_port_info piix_port_info[] = {
 	/* piix_pata_33: 0:  PIIX3 or 4 at 33MHz */
 	{
@@ -702,18 +717,6 @@
 	u8 udma_enable;
 	int control = 0;
 
-	/*
-	 *	See Intel Document 298600-004 for the timing programing rules
-	 *	for ICH controllers.
-	 */
-
-	static const	 /* ISP  RTC */
-	u8 timings[][2]	= { { 0, 0 },
-			    { 0, 0 },
-			    { 1, 0 },
-			    { 2, 1 },
-			    { 2, 3 }, };
-
 	if (pio >= 2)
 		control |= 1;	/* TIME1 enable */
 	if (ata_pio_need_iordy(adev))
@@ -732,15 +735,15 @@
 		pci_read_config_byte(dev, slave_port, &slave_data);
 		slave_data &= (ap->port_no ? 0x0f : 0xf0);
 		/* Load the timing nibble for this slave */
-		slave_data |= ((timings[pio][0] << 2) | timings[pio][1]) << (ap->port_no ? 4 : 0);
+		slave_data |= ((intel_timings[pio][0] << 2) | intel_timings[pio][1]) << (ap->port_no ? 4 : 0);
 	} else {
 		/* Master keeps the bits in a different format */
 		master_data &= 0xccf8;
 		/* Enable PPE, IE and TIME as appropriate */
 		master_data |= control;
 		master_data |=
-			(timings[pio][0] << 12) |
-			(timings[pio][1] << 8);
+			(intel_timings[pio][0] << 12) |
+			(intel_timings[pio][1] << 8);
 	}
 	pci_write_config_word(dev, master_port, master_data);
 	if (is_slave)
@@ -778,13 +781,6 @@
 	int devid		= adev->devno + 2 * ap->port_no;
 	u8 udma_enable;
 
-	static const	 /* ISP  RTC */
-	u8 timings[][2]	= { { 0, 0 },
-			    { 0, 0 },
-			    { 1, 0 },
-			    { 2, 1 },
-			    { 2, 3 }, };
-
 	pci_read_config_word(dev, master_port, &master_data);
 	pci_read_config_byte(dev, 0x48, &udma_enable);
 
@@ -855,15 +851,15 @@
 			pci_read_config_byte(dev, 0x44, &slave_data);
 			slave_data &= (0x0F + 0xE1 * ap->port_no);
 			/* Load the matching timing */
-			slave_data |= ((timings[pio][0] << 2) | timings[pio][1]) << (ap->port_no ? 4 : 0);
+			slave_data |= ((intel_timings[pio][0] << 2) | intel_timings[pio][1]) << (ap->port_no ? 4 : 0);
 			pci_write_config_byte(dev, 0x44, slave_data);
 		} else { 	/* Master */
 			master_data &= 0xCCF4;	/* Mask out IORDY|TIME1|DMAONLY
 						   and master timing bits */
 			master_data |= control;
 			master_data |=
-				(timings[pio][0] << 12) |
-				(timings[pio][1] << 8);
+				(intel_timings[pio][0] << 12) |
+				(intel_timings[pio][1] << 8);
 		}
 		udma_enable &= ~(1 << devid);
 		pci_write_config_word(dev, master_port, master_data);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.20-rc3-mm1/drivers/ata/pata_efar.c linux-2.6.20-rc3-mm1/drivers/ata/pata_efar.c
--- linux.vanilla-2.6.20-rc3-mm1/drivers/ata/pata_efar.c	2007-01-05 13:08:50.000000000 +0000
+++ linux-2.6.20-rc3-mm1/drivers/ata/pata_efar.c	2007-01-05 14:03:26.000000000 +0000
@@ -24,6 +24,16 @@
 #define DRV_NAME	"pata_efar"
 #define DRV_VERSION	"0.4.3"
 
+static const u8 efar_timings[][2] = { 
+			 /* ISP  RTC */
+			    { 0, 0 },
+			    { 0, 0 },
+			    { 1, 0 },
+			    { 2, 1 },
+			    { 2, 3 },
+};
+
+
 /**
  *	efar_pre_reset	-	check for 40/80 pin
  *	@ap: Port
@@ -90,13 +100,6 @@
 	 *	for PIIX/ICH. The EFAR is a clone so very similar
 	 */
 
-	static const	 /* ISP  RTC */
-	u8 timings[][2]	= { { 0, 0 },
-			    { 0, 0 },
-			    { 1, 0 },
-			    { 2, 1 },
-			    { 2, 3 }, };
-
 	if (pio > 2)
 		control |= 1;	/* TIME1 enable */
 	if (ata_pio_need_iordy(adev))	/* PIO 3/4 require IORDY */
@@ -112,8 +115,8 @@
 	if (adev->devno == 0) {
 		idetm_data &= 0xCCF0;
 		idetm_data |= control;
-		idetm_data |= (timings[pio][0] << 12) |
-			(timings[pio][1] << 8);
+		idetm_data |= (efar_timings[pio][0] << 12) |
+			(efar_timings[pio][1] << 8);
 	} else {
 		int shift = 4 * ap->port_no;
 		u8 slave_data;
@@ -124,7 +127,7 @@
 		/* Slave timing in seperate register */
 		pci_read_config_byte(dev, 0x44, &slave_data);
 		slave_data &= 0x0F << shift;
-		slave_data |= ((timings[pio][0] << 2) | timings[pio][1]) << shift;
+		slave_data |= ((efar_timings[pio][0] << 2) | efar_timings[pio][1]) << shift;
 		pci_write_config_byte(dev, 0x44, slave_data);
 	}
 
@@ -152,13 +155,6 @@
 	int devid		= adev->devno + 2 * ap->port_no;
 	u8 udma_enable;
 
-	static const	 /* ISP  RTC */
-	u8 timings[][2]	= { { 0, 0 },
-			    { 0, 0 },
-			    { 1, 0 },
-			    { 2, 1 },
-			    { 2, 3 }, };
-
 	pci_read_config_word(dev, master_port, &master_data);
 	pci_read_config_byte(dev, 0x48, &udma_enable);
 
@@ -202,15 +198,15 @@
 			pci_read_config_byte(dev, 0x44, &slave_data);
 			slave_data &= (0x0F + 0xE1 * ap->port_no);
 			/* Load the matching timing */
-			slave_data |= ((timings[pio][0] << 2) | timings[pio][1]) << (ap->port_no ? 4 : 0);
+			slave_data |= ((efar_timings[pio][0] << 2) | efar_timings[pio][1]) << (ap->port_no ? 4 : 0);
 			pci_write_config_byte(dev, 0x44, slave_data);
 		} else { 	/* Master */
 			master_data &= 0xCCF4;	/* Mask out IORDY|TIME1|DMAONLY
 						   and master timing bits */
 			master_data |= control;
 			master_data |=
-				(timings[pio][0] << 12) |
-				(timings[pio][1] << 8);
+				(efar_timings[pio][0] << 12) |
+				(efar_timings[pio][1] << 8);
 		}
 		udma_enable &= ~(1 << devid);
 		pci_write_config_word(dev, master_port, master_data);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.20-rc3-mm1/drivers/ata/pata_it8213.c linux-2.6.20-rc3-mm1/drivers/ata/pata_it8213.c
--- linux.vanilla-2.6.20-rc3-mm1/drivers/ata/pata_it8213.c	2007-01-05 13:09:36.000000000 +0000
+++ linux-2.6.20-rc3-mm1/drivers/ata/pata_it8213.c	2007-01-05 15:00:15.000000000 +0000
@@ -19,7 +19,7 @@
 #include <linux/ata.h>
 
 #define DRV_NAME	"pata_it8213"
-#define DRV_VERSION	"0.0.2"
+#define DRV_VERSION	"0.0.3"
 
 /**
  *	it8213_pre_reset	-	check for 40/80 pin
@@ -62,6 +62,21 @@
 	ata_bmdma_drive_eh(ap, it8213_pre_reset, ata_std_softreset, NULL, ata_std_postreset);
 }
 
+/*
+ *	See Intel Document 298600-004 for the timing programing rules
+ *	for PIIX/ICH. The 8213 is sort of a clone so very similar.
+ */
+
+static const u8 it8213_timings[][2]= {
+     /* ISP  RTC */
+	{ 0, 0 },
+	{ 0, 0 },
+	{ 1, 0 },
+	{ 2, 1 },
+	{ 2, 3 }
+};
+
+
 /**
  *	it8213_set_piomode - Initialize host controller PATA PIO timings
  *	@ap: Port whose timings we are configuring
@@ -81,18 +96,6 @@
 	u16 idetm_data;
 	int control = 0;
 
-	/*
-	 *	See Intel Document 298600-004 for the timing programing rules
-	 *	for PIIX/ICH. The 8213 is a clone so very similar
-	 */
-
-	static const	 /* ISP  RTC */
-	u8 timings[][2]	= { { 0, 0 },
-			    { 0, 0 },
-			    { 1, 0 },
-			    { 2, 1 },
-			    { 2, 3 }, };
-
 	if (pio > 2)
 		control |= 1;	/* TIME1 enable */
 	if (ata_pio_need_iordy(adev))	/* PIO 3/4 require IORDY */
@@ -108,8 +111,8 @@
 	if (adev->devno == 0) {
 		idetm_data &= 0xCCF0;
 		idetm_data |= control;
-		idetm_data |= (timings[pio][0] << 12) |
-			(timings[pio][1] << 8);
+		idetm_data |= (it8213_timings[pio][0] << 12) |
+			(it8213_timings[pio][1] << 8);
 	} else {
 		u8 slave_data;
 
@@ -119,7 +122,7 @@
 		/* Slave timing in seperate register */
 		pci_read_config_byte(dev, 0x44, &slave_data);
 		slave_data &= 0xF0;
-		slave_data |= ((timings[pio][0] << 2) | timings[pio][1]) << 4;
+		slave_data |= ((it8213_timings[pio][0] << 2) | it8213_timings[pio][1]) << 4;
 		pci_write_config_byte(dev, 0x44, slave_data);
 	}
 
@@ -148,7 +151,7 @@
 	u8 udma_enable;
 
 	static const	 /* ISP  RTC */
-	u8 timings[][2]	= { { 0, 0 },
+	u8 it8213_timings[][2]	= { { 0, 0 },
 			    { 0, 0 },
 			    { 1, 0 },
 			    { 2, 1 },
@@ -214,15 +217,15 @@
 			pci_read_config_byte(dev, 0x44, &slave_data);
 			slave_data &= (0x0F + 0xE1 * ap->port_no);
 			/* Load the matching timing */
-			slave_data |= ((timings[pio][0] << 2) | timings[pio][1]) << (ap->port_no ? 4 : 0);
+			slave_data |= ((it8213_timings[pio][0] << 2) | it8213_timings[pio][1]) << (ap->port_no ? 4 : 0);
 			pci_write_config_byte(dev, 0x44, slave_data);
 		} else { 	/* Master */
 			master_data &= 0xCCF4;	/* Mask out IORDY|TIME1|DMAONLY
 						   and master timing bits */
 			master_data |= control;
 			master_data |=
-				(timings[pio][0] << 12) |
-				(timings[pio][1] << 8);
+				(it8213_timings[pio][0] << 12) |
+				(it8213_timings[pio][1] << 8);
 		}
 		udma_enable &= ~(1 << devid);
 		pci_write_config_word(dev, 0x40, master_data);
