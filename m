Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278642AbRJ1QdQ>; Sun, 28 Oct 2001 11:33:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278574AbRJ1Qc5>; Sun, 28 Oct 2001 11:32:57 -0500
Received: from medelec.uia.ac.be ([143.169.17.1]:48650 "EHLO medelec.uia.ac.be")
	by vger.kernel.org with ESMTP id <S278592AbRJ1Qcq>;
	Sun, 28 Oct 2001 11:32:46 -0500
Date: Sun, 28 Oct 2001 17:33:15 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] linux-2.4.13 - i8xx series chipsets patches
Message-ID: <20011028173315.B25213@medelec.uia.ac.be>
In-Reply-To: <20011028153419.A24908@medelec.uia.ac.be> <E15xrf3-00084J-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15xrf3-00084J-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sun, Oct 28, 2001 at 03:15:41PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

> Secondly a patch which just adds the ones we are missing

And the new stuff for (mainly) the 82801CA and 82801CAM chipsets.
(Note: the patch has been diffed against my previous patch).

Greetings,
Wim.


diff -u --recursive --new-file linux-2.4.13-patch1/arch/i386/kernel/pci-irq.c linux-2.4.13-patched/arch/i386/kernel/pci-irq.c
--- linux-2.4.13-patch1/arch/i386/kernel/pci-irq.c	Tue Oct 16 04:30:33 2001
+++ linux-2.4.13-patched/arch/i386/kernel/pci-irq.c	Sun Oct 28 11:11:58 2001
@@ -443,7 +443,12 @@
 	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371AB_0, pirq_piix_get, pirq_piix_set },
 	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371MX,   pirq_piix_get, pirq_piix_set },
 	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82443MX_0, pirq_piix_get, pirq_piix_set },
+	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AA_0, pirq_piix_get, pirq_piix_set },
+	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AB_0, pirq_piix_get, pirq_piix_set },
 	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_0, pirq_piix_get, pirq_piix_set },
+	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_12, pirq_piix_get, pirq_piix_set },
+	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_0, pirq_piix_get, pirq_piix_set },
+	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_12, pirq_piix_get, pirq_piix_set },
 
 	{ "ALI", PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1533, pirq_ali_get, pirq_ali_set },
 
diff -u --recursive --new-file linux-2.4.13-patch1/drivers/acpi/ospm/processor/pr_osl.c linux-2.4.13-patched/drivers/acpi/ospm/processor/pr_osl.c
--- linux-2.4.13-patch1/drivers/acpi/ospm/processor/pr_osl.c	Sun Oct 28 17:03:15 2001
+++ linux-2.4.13-patched/drivers/acpi/ospm/processor/pr_osl.c	Sun Oct 28 11:44:09 2001
@@ -260,6 +260,8 @@
 	while ((dev = pci_find_subsys(PCI_VENDOR_ID_INTEL, PCI_ANY_ID, 
 		PCI_ANY_ID, PCI_ANY_ID, dev))) {
 		switch (dev->device) {
+		case PCI_DEVICE_ID_INTEL_82801CA_10:	/* PIIX4U6 */
+		case PCI_DEVICE_ID_INTEL_82801CA_11:	/* PIIX4U5 */
 		case PCI_DEVICE_ID_INTEL_82801BA_10:	/* PIIX4U4 */
 		case PCI_DEVICE_ID_INTEL_82801BA_11:	/* PIIX4U3 */
 		case PCI_DEVICE_ID_INTEL_82451NX:	/* PIIX4NX */
diff -u --recursive --new-file linux-2.4.13-patch1/drivers/char/i810-tco.c linux-2.4.13-patched/drivers/char/i810-tco.c
--- linux-2.4.13-patch1/drivers/char/i810-tco.c	Sun Oct 28 17:03:15 2001
+++ linux-2.4.13-patched/drivers/char/i810-tco.c	Sun Oct 28 16:36:01 2001
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
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_12,	PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_0,	PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_12,	PCI_ANY_ID, PCI_ANY_ID, },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE (pci, i810tco_pci_tbl);
diff -u --recursive --new-file linux-2.4.13-patch1/drivers/char/i810_rng.c linux-2.4.13-patched/drivers/char/i810_rng.c
--- linux-2.4.13-patch1/drivers/char/i810_rng.c	Thu Oct 11 18:14:32 2001
+++ linux-2.4.13-patched/drivers/char/i810_rng.c	Sun Oct 28 11:11:58 2001
@@ -332,9 +332,10 @@
  * want to register another driver on the same PCI id.
  */
 static struct pci_device_id rng_pci_tbl[] __initdata = {
-	{ 0x8086, 0x2418, PCI_ANY_ID, PCI_ANY_ID, },
-	{ 0x8086, 0x2428, PCI_ANY_ID, PCI_ANY_ID, },
-	{ 0x8086, 0x1130, PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AA_8, PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AB_8, PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_8, PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_14, PCI_ANY_ID, PCI_ANY_ID, },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE (pci, rng_pci_tbl);
diff -u --recursive --new-file linux-2.4.13-patch1/drivers/ide/ide-pci.c linux-2.4.13-patched/drivers/ide/ide-pci.c
--- linux-2.4.13-patch1/drivers/ide/ide-pci.c	Sun Oct 28 17:03:15 2001
+++ linux-2.4.13-patched/drivers/ide/ide-pci.c	Sun Oct 28 11:44:44 2001
@@ -37,6 +37,8 @@
 #define DEVID_PIIX4NX	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82451NX})
 #define DEVID_PIIX4U3	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82801BA_11})
 #define DEVID_PIIX4U4	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82801BA_10})
+#define DEVID_PIIX4U5	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82801CA_11})
+#define DEVID_PIIX4U6	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82801CA_10})
 #define DEVID_VIA_IDE	((ide_pci_devid_t){PCI_VENDOR_ID_VIA,     PCI_DEVICE_ID_VIA_82C561})
 #define DEVID_MR_IDE	((ide_pci_devid_t){PCI_VENDOR_ID_VIA,     PCI_DEVICE_ID_VIA_82C576_1})
 #define DEVID_VP_IDE	((ide_pci_devid_t){PCI_VENDOR_ID_VIA,     PCI_DEVICE_ID_VIA_82C586_1})
@@ -385,6 +387,8 @@
 	{DEVID_PIIX4NX,	"PIIX4",	PCI_PIIX,	NULL,		INIT_PIIX,	NULL,		{{0x41,0x80,0x80}, {0x43,0x80,0x80}},	ON_BOARD,	0 },
 	{DEVID_PIIX4U3,	"PIIX4",	PCI_PIIX,	ATA66_PIIX,	INIT_PIIX,	NULL,		{{0x41,0x80,0x80}, {0x43,0x80,0x80}},	ON_BOARD,	0 },
 	{DEVID_PIIX4U4, "PIIX4",	PCI_PIIX,	ATA66_PIIX,	INIT_PIIX,	NULL,		{{0x41,0x80,0x80}, {0x43,0x80,0x80}},	ON_BOARD,	0 },
+	{DEVID_PIIX4U5, "PIIX4",	PCI_PIIX,	ATA66_PIIX,	INIT_PIIX,	NULL,		{{0x41,0x80,0x80}, {0x43,0x80,0x80}},	ON_BOARD,	0 },
+	{DEVID_PIIX4U6, "PIIX4",	PCI_PIIX,	ATA66_PIIX,	INIT_PIIX,	NULL,		{{0x41,0x80,0x80}, {0x43,0x80,0x80}},	ON_BOARD,	0 },
 	{DEVID_VIA_IDE,	"VIA_IDE",	NULL,		NULL,		NULL,		NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	ON_BOARD,	0 },
 	{DEVID_MR_IDE,	"VP_IDE",	PCI_VIA82CXXX,	ATA66_VIA82CXXX,INIT_VIA82CXXX,	DMA_VIA82CXXX,	{{0x40,0x02,0x02}, {0x40,0x01,0x01}}, 	ON_BOARD,	0 },
 	{DEVID_VP_IDE,	"VP_IDE",	PCI_VIA82CXXX,	ATA66_VIA82CXXX,INIT_VIA82CXXX,	DMA_VIA82CXXX,	{{0x40,0x02,0x02}, {0x40,0x01,0x01}}, 	ON_BOARD,	0 },
diff -u --recursive --new-file linux-2.4.13-patch1/drivers/ide/piix.c linux-2.4.13-patched/drivers/ide/piix.c
--- linux-2.4.13-patch1/drivers/ide/piix.c	Sun Oct 28 17:05:18 2001
+++ linux-2.4.13-patched/drivers/ide/piix.c	Sun Oct 28 17:08:52 2001
@@ -91,6 +91,8 @@
 	switch(bmide_dev->device) {
 		case PCI_DEVICE_ID_INTEL_82801BA_10:
 		case PCI_DEVICE_ID_INTEL_82801BA_11:
+		case PCI_DEVICE_ID_INTEL_82801CA_10:
+		case PCI_DEVICE_ID_INTEL_82801CA_11:
 			p += sprintf(p, "\n                                Intel PIIX4 Ultra 100 Chipset.\n");
 			break;
 		case PCI_DEVICE_ID_INTEL_82372FB_1:
@@ -364,7 +366,9 @@
 
 	byte udma_66		= eighty_ninty_three(drive);
 	int ultra100		= ((dev->device == PCI_DEVICE_ID_INTEL_82801BA_10) ||
-				   (dev->device == PCI_DEVICE_ID_INTEL_82801BA_11)) ? 1 : 0;
+				   (dev->device == PCI_DEVICE_ID_INTEL_82801BA_11) ||
+				   (dev->device == PCI_DEVICE_ID_INTEL_82801CA_10) ||
+				   (dev->device == PCI_DEVICE_ID_INTEL_82801CA_11)) ? 1 : 0;
 	int ultra66		= ((ultra100) ||
 				   (dev->device == PCI_DEVICE_ID_INTEL_82801AA_1) ||
 				   (dev->device == PCI_DEVICE_ID_INTEL_82372FB_1)) ? 1 : 0;
diff -u --recursive --new-file linux-2.4.13-patch1/drivers/pci/pci.ids linux-2.4.13-patched/drivers/pci/pci.ids
--- linux-2.4.13-patch1/drivers/pci/pci.ids	Sun Oct 28 17:02:23 2001
+++ linux-2.4.13-patched/drivers/pci/pci.ids	Sun Oct 28 16:42:44 2001
@@ -4814,6 +4814,7 @@
 	1037  82801CAM (ICH3) Chipset Ethernet Controller
 	1038  82801CAM (ICH3) Chipset Ethernet Controller
 	1130  82815 815 Chipset Host Bridge and Memory Controller Hub
+	1131  82815 815 Chipset AGP Bridge
 	1132  82815 CGC [Chipset Graphics Controller] 
 	1161  82806AA PCI64 Hub Advanced Programmable Interrupt Controller
 	1209  82559ER
@@ -4933,6 +4934,16 @@
 	244b  82801BA IDE U100
 	244c  82801BAM ISA Bridge (LPC)
 	244e  82801BA/CA PCI Bridge
+	2480  82801CA ISA Bridge (LPC)
+	2482  82801CA/CAM USB (Hub #1)
+	2483  82801CA/CAM SMBus
+	2484  82801CA/CAM USB (Hub #2)
+	2485  82801CA/CAM AC'97 Audio
+	2486  82801CA/CAM AC'97 Modem
+	2487  82801CA/CAM USB (Hub #3)
+	248a  82801CAM IDE U100
+	248b  82801CA IDE U100
+	248c  82801CAM ISA Bridge (LPC)
 	2500  82820 820 (Camino) Chipset Host Bridge (MCH)
 		1043 801c  P3C-2000 system chipset
 	2501  82820 820 (Camino) Chipset Host Bridge (MCH)
@@ -4945,6 +4956,10 @@
 	2531  82850 860 (Wombat) Chipset Host Bridge (MCH)
 	2532  82850 850 (Tehama) Chipset AGP Bridge
 	2533  82860 860 (Wombat) Chipset AGP Bridge
+	2534  82860 860 (Wombat) Chipset PCI Bridge
+	3575  82830 830 Chipset Host Bridge
+	3576  82830 830 Chipset AGP Bridge
+	3578  82830 830 Chipset Host Bridge
 	5200  EtherExpress PRO/100 Intelligent Server
 	5201  EtherExpress PRO/100 Intelligent Server
 		8086 0001  EtherExpress PRO/100 Server Ethernet Adapter
