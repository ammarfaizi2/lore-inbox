Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281726AbRKQLxY>; Sat, 17 Nov 2001 06:53:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281727AbRKQLxP>; Sat, 17 Nov 2001 06:53:15 -0500
Received: from medelec.uia.ac.be ([143.169.17.1]:49927 "EHLO medelec.uia.ac.be")
	by vger.kernel.org with ESMTP id <S281726AbRKQLxK>;
	Sat, 17 Nov 2001 06:53:10 -0500
Date: Sat, 17 Nov 2001 12:53:03 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] linux-2.4.15-pre5 - i8xx series chipsets patches (patch2)
Message-ID: <20011117125303.B18560@medelec.uia.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

a second patch against linux-2.4.15-pre5. The patch adds additional support for the 82801 I/O Controller Hub (ICH) that is being used by the intel 8xx series of chipsets. It mainly adds extra support of the 82801CA and 82801CAM chips.

Greetings,
Wim.


diff -u --recursive --new-file linux-2.4.15-pre5-patch1/arch/i386/kernel/pci-irq.c linux-2.4.15-pre5-patch2/arch/i386/kernel/pci-irq.c
--- linux-2.4.15-pre5-patch1/arch/i386/kernel/pci-irq.c	Sun Nov  4 18:31:58 2001
+++ linux-2.4.15-pre5-patch2/arch/i386/kernel/pci-irq.c	Sat Nov 17 12:07:41 2001
@@ -443,7 +443,12 @@
 	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371AB_0, pirq_piix_get, pirq_piix_set },
 	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371MX,   pirq_piix_get, pirq_piix_set },
 	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82443MX_0, pirq_piix_get, pirq_piix_set },
+	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AA_0, pirq_piix_get, pirq_piix_set },
+	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AB_0, pirq_piix_get, pirq_piix_set },
 	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_0, pirq_piix_get, pirq_piix_set },
+	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_10, pirq_piix_get, pirq_piix_set },
+	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_0, pirq_piix_get, pirq_piix_set },
+	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_12, pirq_piix_get, pirq_piix_set },
 
 	{ "ALI", PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1533, pirq_ali_get, pirq_ali_set },
 
diff -u --recursive --new-file linux-2.4.15-pre5-patch1/drivers/acpi/ospm/processor/pr_osl.c linux-2.4.15-pre5-patch2/drivers/acpi/ospm/processor/pr_osl.c
--- linux-2.4.15-pre5-patch1/drivers/acpi/ospm/processor/pr_osl.c	Fri Nov 16 23:23:13 2001
+++ linux-2.4.15-pre5-patch2/drivers/acpi/ospm/processor/pr_osl.c	Sat Nov 17 12:17:09 2001
@@ -258,6 +258,8 @@
 	while ((dev = pci_find_subsys(PCI_VENDOR_ID_INTEL, PCI_ANY_ID, 
 		PCI_ANY_ID, PCI_ANY_ID, dev))) {
 		switch (dev->device) {
+		case PCI_DEVICE_ID_INTEL_82801CA_11:	/* PIIX4U6 */
+		case PCI_DEVICE_ID_INTEL_82801CA_10:	/* PIIX4U5 */
 		case PCI_DEVICE_ID_INTEL_82801BA_8:	/* PIIX4U4 */
 		case PCI_DEVICE_ID_INTEL_82801BA_9:	/* PIIX4U3 */
 		case PCI_DEVICE_ID_INTEL_82451NX:	/* PIIX4NX */
diff -u --recursive --new-file linux-2.4.15-pre5-patch1/drivers/char/i810-tco.c linux-2.4.15-pre5-patch2/drivers/char/i810-tco.c
--- linux-2.4.15-pre5-patch1/drivers/char/i810-tco.c	Fri Sep 14 00:21:32 2001
+++ linux-2.4.15-pre5-patch2/drivers/char/i810-tco.c	Sat Nov 17 12:11:13 2001
@@ -46,11 +46,6 @@
 #include "i810-tco.h"
 
 
-/* Just in case that the PCI vendor and device IDs are not yet defined */
-#ifndef PCI_DEVICE_ID_INTEL_82801AA_0
-#define PCI_DEVICE_ID_INTEL_82801AA_0	0x2410
-#endif
-
 /* Default expire timeout */
 #define TIMER_MARGIN	50	/* steps of 0.6sec, 2<n<64. Default is 30 seconds */
 
@@ -245,6 +240,8 @@
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AB_0,	PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_0,	PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_10,	PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_0,	PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_12,	PCI_ANY_ID, PCI_ANY_ID, },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE (pci, i810tco_pci_tbl);
diff -u --recursive --new-file linux-2.4.15-pre5-patch1/drivers/char/i810_rng.c linux-2.4.15-pre5-patch2/drivers/char/i810_rng.c
--- linux-2.4.15-pre5-patch1/drivers/char/i810_rng.c	Thu Oct 11 18:14:32 2001
+++ linux-2.4.15-pre5-patch2/drivers/char/i810_rng.c	Sat Nov 17 12:14:39 2001
@@ -332,9 +332,10 @@
  * want to register another driver on the same PCI id.
  */
 static struct pci_device_id rng_pci_tbl[] __initdata = {
-	{ 0x8086, 0x2418, PCI_ANY_ID, PCI_ANY_ID, },
-	{ 0x8086, 0x2428, PCI_ANY_ID, PCI_ANY_ID, },
-	{ 0x8086, 0x1130, PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AA_8, PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AB_8, PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_6, PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_14, PCI_ANY_ID, PCI_ANY_ID, },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE (pci, rng_pci_tbl);
diff -u --recursive --new-file linux-2.4.15-pre5-patch1/drivers/ide/ide-pci.c linux-2.4.15-pre5-patch2/drivers/ide/ide-pci.c
--- linux-2.4.15-pre5-patch1/drivers/ide/ide-pci.c	Thu Oct 25 22:53:47 2001
+++ linux-2.4.15-pre5-patch2/drivers/ide/ide-pci.c	Sat Nov 17 12:18:38 2001
@@ -38,6 +38,7 @@
 #define DEVID_PIIX4U3	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82801BA_9})
 #define DEVID_PIIX4U4	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82801BA_8})
 #define DEVID_PIIX4U5	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82801CA_10})
+#define DEVID_PIIX4U6	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82801CA_11})
 #define DEVID_VIA_IDE	((ide_pci_devid_t){PCI_VENDOR_ID_VIA,     PCI_DEVICE_ID_VIA_82C561})
 #define DEVID_MR_IDE	((ide_pci_devid_t){PCI_VENDOR_ID_VIA,     PCI_DEVICE_ID_VIA_82C576_1})
 #define DEVID_VP_IDE	((ide_pci_devid_t){PCI_VENDOR_ID_VIA,     PCI_DEVICE_ID_VIA_82C586_1})
@@ -387,6 +388,7 @@
 	{DEVID_PIIX4U3,	"PIIX4",	PCI_PIIX,	ATA66_PIIX,	INIT_PIIX,	NULL,		{{0x41,0x80,0x80}, {0x43,0x80,0x80}},	ON_BOARD,	0 },
 	{DEVID_PIIX4U4, "PIIX4",	PCI_PIIX,	ATA66_PIIX,	INIT_PIIX,	NULL,		{{0x41,0x80,0x80}, {0x43,0x80,0x80}},	ON_BOARD,	0 },
 	{DEVID_PIIX4U5, "PIIX4",	PCI_PIIX,	ATA66_PIIX,	INIT_PIIX,	NULL,		{{0x41,0x80,0x80}, {0x43,0x80,0x80}},	ON_BOARD,	0 },
+	{DEVID_PIIX4U6, "PIIX4",	PCI_PIIX,	ATA66_PIIX,	INIT_PIIX,	NULL,		{{0x41,0x80,0x80}, {0x43,0x80,0x80}},	ON_BOARD,	0 },
 	{DEVID_VIA_IDE,	"VIA_IDE",	NULL,		NULL,		NULL,		NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	ON_BOARD,	0 },
 	{DEVID_MR_IDE,	"VP_IDE",	PCI_VIA82CXXX,	ATA66_VIA82CXXX,INIT_VIA82CXXX,	DMA_VIA82CXXX,	{{0x40,0x02,0x02}, {0x40,0x01,0x01}}, 	ON_BOARD,	0 },
 	{DEVID_VP_IDE,	"VP_IDE",	PCI_VIA82CXXX,	ATA66_VIA82CXXX,INIT_VIA82CXXX,	DMA_VIA82CXXX,	{{0x40,0x02,0x02}, {0x40,0x01,0x01}}, 	ON_BOARD,	0 },
diff -u --recursive --new-file linux-2.4.15-pre5-patch1/drivers/ide/piix.c linux-2.4.15-pre5-patch2/drivers/ide/piix.c
--- linux-2.4.15-pre5-patch1/drivers/ide/piix.c	Thu Oct 25 22:53:47 2001
+++ linux-2.4.15-pre5-patch2/drivers/ide/piix.c	Sat Nov 17 12:19:57 2001
@@ -92,6 +92,7 @@
 		case PCI_DEVICE_ID_INTEL_82801BA_8:
 		case PCI_DEVICE_ID_INTEL_82801BA_9:
 	        case PCI_DEVICE_ID_INTEL_82801CA_10:
+	        case PCI_DEVICE_ID_INTEL_82801CA_11:
 			p += sprintf(p, "\n                                Intel PIIX4 Ultra 100 Chipset.\n");
 			break;
 		case PCI_DEVICE_ID_INTEL_82372FB_1:
@@ -366,7 +367,8 @@
 	byte udma_66		= eighty_ninty_three(drive);
 	int ultra100		= ((dev->device == PCI_DEVICE_ID_INTEL_82801BA_8) ||
 				   (dev->device == PCI_DEVICE_ID_INTEL_82801BA_9) ||
-				   (dev->device == PCI_DEVICE_ID_INTEL_82801CA_10)) ? 1 : 0;
+				   (dev->device == PCI_DEVICE_ID_INTEL_82801CA_10) ||
+				   (dev->device == PCI_DEVICE_ID_INTEL_82801CA_11)) ? 1 : 0;
 	int ultra66		= ((ultra100) ||
 				   (dev->device == PCI_DEVICE_ID_INTEL_82801AA_1) ||
 				   (dev->device == PCI_DEVICE_ID_INTEL_82372FB_1)) ? 1 : 0;
