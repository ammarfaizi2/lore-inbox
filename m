Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292373AbSBPOxi>; Sat, 16 Feb 2002 09:53:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292374AbSBPOxT>; Sat, 16 Feb 2002 09:53:19 -0500
Received: from medelec.uia.ac.be ([143.169.17.1]:51461 "EHLO medelec.uia.ac.be")
	by vger.kernel.org with ESMTP id <S292373AbSBPOxN>;
	Sat, 16 Feb 2002 09:53:13 -0500
Date: Sat, 16 Feb 2002 15:53:07 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] linux-2.4.18-rc1 - i8xx series chipsets patches
Message-ID: <20020216155307.A10078@medelec.uia.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

This patch against 2.4.18-rc1 adds additional support for the 82801 I/O Controller Hub family that is being used by the intel 8xx series of chipsets. The patch mainly adds extra support for the 82801CA and 82801CAM chips.

Greetings,
Wim.

diff -u --recursive --new-file linux-2.4.18-rc1/arch/i386/kernel/pci-irq.c linux-2.4.18-rc1-patched/arch/i386/kernel/pci-irq.c
--- linux-2.4.18-rc1/arch/i386/kernel/pci-irq.c	Sat Feb 16 14:49:47 2002
+++ linux-2.4.18-rc1-patched/arch/i386/kernel/pci-irq.c	Sat Feb 16 15:26:14 2002
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
 
diff -u --recursive --new-file linux-2.4.18-rc1/drivers/acpi/ospm/processor/pr_osl.c linux-2.4.18-rc1-patched/drivers/acpi/ospm/processor/pr_osl.c
--- linux-2.4.18-rc1/drivers/acpi/ospm/processor/pr_osl.c	Fri Dec 21 18:41:53 2001
+++ linux-2.4.18-rc1-patched/drivers/acpi/ospm/processor/pr_osl.c	Sat Feb 16 15:26:14 2002
@@ -259,6 +259,8 @@
 	while ((dev = pci_find_subsys(PCI_VENDOR_ID_INTEL, PCI_ANY_ID, 
 		PCI_ANY_ID, PCI_ANY_ID, dev))) {
 		switch (dev->device) {
+		case PCI_DEVICE_ID_INTEL_82801CA_11:	/* PIIX4U6 */
+		case PCI_DEVICE_ID_INTEL_82801CA_10:	/* PIIX4U5 */
 		case PCI_DEVICE_ID_INTEL_82801BA_8:	/* PIIX4U4 */
 		case PCI_DEVICE_ID_INTEL_82801BA_9:	/* PIIX4U3 */
 		case PCI_DEVICE_ID_INTEL_82451NX:	/* PIIX4NX */
diff -u --recursive --new-file linux-2.4.18-rc1/drivers/char/i810-tco.c linux-2.4.18-rc1-patched/drivers/char/i810-tco.c
--- linux-2.4.18-rc1/drivers/char/i810-tco.c	Sat Feb 16 14:49:48 2002
+++ linux-2.4.18-rc1-patched/drivers/char/i810-tco.c	Sat Feb 16 15:26:15 2002
@@ -46,11 +46,6 @@
 #include "i810-tco.h"
 
 
-/* Just in case that the PCI vendor and device IDs are not yet defined */
-#ifndef PCI_DEVICE_ID_INTEL_82801AA_0
-#define PCI_DEVICE_ID_INTEL_82801AA_0	0x2410
-#endif
-
 /* Default expire timeout */
 #define TIMER_MARGIN	50	/* steps of 0.6sec, 2<n<64. Default is 30 seconds */
 
@@ -260,6 +255,8 @@
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AB_0,	PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_0,	PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_10,	PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_0,	PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_12,	PCI_ANY_ID, PCI_ANY_ID, },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE (pci, i810tco_pci_tbl);
diff -u --recursive --new-file linux-2.4.18-rc1/drivers/char/i810_rng.c linux-2.4.18-rc1-patched/drivers/char/i810_rng.c
--- linux-2.4.18-rc1/drivers/char/i810_rng.c	Thu Oct 11 18:14:32 2001
+++ linux-2.4.18-rc1-patched/drivers/char/i810_rng.c	Sat Feb 16 15:39:19 2002
@@ -334,7 +334,8 @@
 static struct pci_device_id rng_pci_tbl[] __initdata = {
 	{ 0x8086, 0x2418, PCI_ANY_ID, PCI_ANY_ID, },
 	{ 0x8086, 0x2428, PCI_ANY_ID, PCI_ANY_ID, },
-	{ 0x8086, 0x1130, PCI_ANY_ID, PCI_ANY_ID, },
+	{ 0x8086, 0x2448, PCI_ANY_ID, PCI_ANY_ID, },
+	{ 0x8086, 0x244e, PCI_ANY_ID, PCI_ANY_ID, },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE (pci, rng_pci_tbl);
diff -u --recursive --new-file linux-2.4.18-rc1/drivers/ide/ide-pci.c linux-2.4.18-rc1-patched/drivers/ide/ide-pci.c
--- linux-2.4.18-rc1/drivers/ide/ide-pci.c	Thu Oct 25 22:53:47 2001
+++ linux-2.4.18-rc1-patched/drivers/ide/ide-pci.c	Sat Feb 16 15:26:15 2002
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
diff -u --recursive --new-file linux-2.4.18-rc1/drivers/ide/piix.c linux-2.4.18-rc1-patched/drivers/ide/piix.c
--- linux-2.4.18-rc1/drivers/ide/piix.c	Thu Oct 25 22:53:47 2001
+++ linux-2.4.18-rc1-patched/drivers/ide/piix.c	Sat Feb 16 15:26:15 2002
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
