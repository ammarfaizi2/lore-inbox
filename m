Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278163AbRJ1Ljh>; Sun, 28 Oct 2001 06:39:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278197AbRJ1Lj3>; Sun, 28 Oct 2001 06:39:29 -0500
Received: from medelec.uia.ac.be ([143.169.17.1]:33034 "EHLO medelec.uia.ac.be")
	by vger.kernel.org with ESMTP id <S278163AbRJ1LjN>;
	Sun, 28 Oct 2001 06:39:13 -0500
Date: Sun, 28 Oct 2001 12:39:41 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] linux-2.4.13 - i8xx series chipsets patches
Message-ID: <20011028123941.A24412@medelec.uia.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi linus,

included a patch for the i8xx series of chipsets.
All intel 8xx series chipsets are built around the same I/O Controller HUB family (The 82801 chipsets).
This patch adds code for the 82801CA and 82801CAM I/O Controller HUBs. This code is mainly for the IDE controller, the i810 watchdog (TCO) and the i810 random number generator.
Add the same time the patch adjusts the PCI_DEVICE_ID_INTEL_82801BA* defines (and usage) throughout the kernel, because they are not don like the 82801AB, 82801BA and 82801CA defines. This makes the code more comprehensible for all 82801 chipsets.

Greetings,
Wim.


diff -u --recursive --new-file linux-2.4.13/arch/i386/kernel/pci-irq.c linux-2.4.13-patched/arch/i386/kernel/pci-irq.c
--- linux-2.4.13/arch/i386/kernel/pci-irq.c	Tue Oct 16 04:30:33 2001
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
 
diff -u --recursive --new-file linux-2.4.13/drivers/acpi/ospm/processor/pr_osl.c linux-2.4.13-patched/drivers/acpi/ospm/processor/pr_osl.c
--- linux-2.4.13/drivers/acpi/ospm/processor/pr_osl.c	Sun Sep 23 18:42:32 2001
+++ linux-2.4.13-patched/drivers/acpi/ospm/processor/pr_osl.c	Sun Oct 28 11:44:09 2001
@@ -260,8 +260,10 @@
 	while ((dev = pci_find_subsys(PCI_VENDOR_ID_INTEL, PCI_ANY_ID, 
 		PCI_ANY_ID, PCI_ANY_ID, dev))) {
 		switch (dev->device) {
-		case PCI_DEVICE_ID_INTEL_82801BA_8:	/* PIIX4U4 */
-		case PCI_DEVICE_ID_INTEL_82801BA_9:	/* PIIX4U3 */
+		case PCI_DEVICE_ID_INTEL_82801CA_10:	/* PIIX4U6 */
+		case PCI_DEVICE_ID_INTEL_82801CA_11:	/* PIIX4U5 */
+		case PCI_DEVICE_ID_INTEL_82801BA_10:	/* PIIX4U4 */
+		case PCI_DEVICE_ID_INTEL_82801BA_11:	/* PIIX4U3 */
 		case PCI_DEVICE_ID_INTEL_82451NX:	/* PIIX4NX */
 		case PCI_DEVICE_ID_INTEL_82372FB_1:	/* PIIX4U2 */
 		case PCI_DEVICE_ID_INTEL_82801AA_1:	/* PIIX4U */
diff -u --recursive --new-file linux-2.4.13/drivers/char/i810-tco.c linux-2.4.13-patched/drivers/char/i810-tco.c
--- linux-2.4.13/drivers/char/i810-tco.c	Fri Sep 14 00:21:32 2001
+++ linux-2.4.13-patched/drivers/char/i810-tco.c	Sun Oct 28 11:11:58 2001
@@ -46,11 +46,6 @@
 #include "i810-tco.h"
 
 
-/* Just in case that the PCI vendor and device IDs are not yet defined */
-#ifndef PCI_DEVICE_ID_INTEL_82801AA_0
-#define PCI_DEVICE_ID_INTEL_82801AA_0	0x2410
-#endif
-
 /* Default expire timeout */
 #define TIMER_MARGIN	50	/* steps of 0.6sec, 2<n<64. Default is 30 seconds */
 
@@ -241,10 +236,12 @@
  * want to register another driver on the same PCI id.
  */
 static struct pci_device_id i810tco_pci_tbl[] __initdata = {
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AA_0,	PCI_ANY_ID, PCI_ANY_ID, },
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AB_0,	PCI_ANY_ID, PCI_ANY_ID, },
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_0,	PCI_ANY_ID, PCI_ANY_ID, },
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_10,	PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AA_0, PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AB_0, PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_0, PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_12, PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_0, PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_12, PCI_ANY_ID, PCI_ANY_ID, },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE (pci, i810tco_pci_tbl);
diff -u --recursive --new-file linux-2.4.13/drivers/char/i810_rng.c linux-2.4.13-patched/drivers/char/i810_rng.c
--- linux-2.4.13/drivers/char/i810_rng.c	Thu Oct 11 18:14:32 2001
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
diff -u --recursive --new-file linux-2.4.13/drivers/ide/ide-pci.c linux-2.4.13-patched/drivers/ide/ide-pci.c
--- linux-2.4.13/drivers/ide/ide-pci.c	Sun Sep 30 21:26:05 2001
+++ linux-2.4.13-patched/drivers/ide/ide-pci.c	Sun Oct 28 11:44:44 2001
@@ -35,8 +35,10 @@
 #define DEVID_PIIX4U	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82801AA_1})
 #define DEVID_PIIX4U2	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82372FB_1})
 #define DEVID_PIIX4NX	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82451NX})
-#define DEVID_PIIX4U3	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82801BA_9})
-#define DEVID_PIIX4U4	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82801BA_8})
+#define DEVID_PIIX4U3	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82801BA_11})
+#define DEVID_PIIX4U4	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82801BA_10})
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
diff -u --recursive --new-file linux-2.4.13/drivers/ide/piix.c linux-2.4.13-patched/drivers/ide/piix.c
--- linux-2.4.13/drivers/ide/piix.c	Mon Aug 13 23:56:19 2001
+++ linux-2.4.13-patched/drivers/ide/piix.c	Sun Oct 28 11:45:42 2001
@@ -89,8 +89,10 @@
 	u8  reg44 = 0, reg48 = 0, reg4a = 0, reg4b = 0, reg54 = 0, reg55 = 0;
 
 	switch(bmide_dev->device) {
-		case PCI_DEVICE_ID_INTEL_82801BA_8:
-		case PCI_DEVICE_ID_INTEL_82801BA_9:
+		case PCI_DEVICE_ID_INTEL_82801BA_11:
+		case PCI_DEVICE_ID_INTEL_82801BA_10:
+		case PCI_DEVICE_ID_INTEL_82801CA_11:
+		case PCI_DEVICE_ID_INTEL_82801CA_10:
 			p += sprintf(p, "\n                                Intel PIIX4 Ultra 100 Chipset.\n");
 			break;
 		case PCI_DEVICE_ID_INTEL_82372FB_1:
@@ -363,8 +365,10 @@
 	byte			speed;
 
 	byte udma_66		= eighty_ninty_three(drive);
-	int ultra100		= ((dev->device == PCI_DEVICE_ID_INTEL_82801BA_8) ||
-				   (dev->device == PCI_DEVICE_ID_INTEL_82801BA_9)) ? 1 : 0;
+	int ultra100		= ((dev->device == PCI_DEVICE_ID_INTEL_82801BA_11) ||
+				   (dev->device == PCI_DEVICE_ID_INTEL_82801BA_10) ||
+				   (dev->device == PCI_DEVICE_ID_INTEL_82801CA_11) ||
+				   (dev->device == PCI_DEVICE_ID_INTEL_82801CA_10)) ? 1 : 0;
 	int ultra66		= ((ultra100) ||
 				   (dev->device == PCI_DEVICE_ID_INTEL_82801AA_1) ||
 				   (dev->device == PCI_DEVICE_ID_INTEL_82372FB_1)) ? 1 : 0;
diff -u --recursive --new-file linux-2.4.13/drivers/net/eepro100.c linux-2.4.13-patched/drivers/net/eepro100.c
--- linux-2.4.13/drivers/net/eepro100.c	Sun Sep 30 21:26:08 2001
+++ linux-2.4.13-patched/drivers/net/eepro100.c	Sun Oct 28 11:11:58 2001
@@ -2230,7 +2230,7 @@
 		PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ID1030,
 		PCI_ANY_ID, PCI_ANY_ID, },
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_7,
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_9,
 		PCI_ANY_ID, PCI_ANY_ID, },
 	{ 0,}
 };
diff -u --recursive --new-file linux-2.4.13/drivers/pci/pci.ids linux-2.4.13-patched/drivers/pci/pci.ids
--- linux-2.4.13/drivers/pci/pci.ids	Fri Oct 19 17:32:28 2001
+++ linux-2.4.13-patched/drivers/pci/pci.ids	Sun Oct 28 12:17:11 2001
@@ -4814,6 +4814,7 @@
 	1037  82801CAM (ICH3) Chipset Ethernet Controller
 	1038  82801CAM (ICH3) Chipset Ethernet Controller
 	1130  82815 815 Chipset Host Bridge and Memory Controller Hub
+	1131  82815 815 Chipset AGP Bridge
 	1132  82815 CGC [Chipset Graphics Controller] 
 	1161  82806AA PCI64 Hub Advanced Programmable Interrupt Controller
 	1209  82559ER
@@ -4897,11 +4898,11 @@
 		103c 10c7  MegaRaid T5
 		1111 1111  MegaRaid 466
 		113c 03a2  MegaRaid
-	1a21  82840 840 (Carmel) Chipset Host Bridge (Hub A)
-	1a23  82840 840 (Carmel) Chipset AGP Bridge
-	1a24  82840 840 (Carmel) Chipset PCI Bridge (Hub B)
-	1a30  82845 845 (Brookdale) Chipset Host Bridge
-	1a31  82845 845 (Brookdale) Chipset AGP Bridge
+	1a21  82840 840 [Carmel] Chipset Host Bridge (Hub A)
+	1a23  82840 840 [Carmel] Chipset AGP Bridge
+	1a24  82840 840 [Carmel] Chipset PCI Bridge (Hub B)
+	1a30  82845 845 [Brookdale] Chipset Host Bridge
+	1a31  82845 845 [Brookdale] Chipset AGP Bridge
 	2410  82801AA ISA Bridge (LPC)
 	2411  82801AA IDE
 	2412  82801AA USB
@@ -4921,30 +4922,44 @@
 		11d4 0048  SoundMAX Integrated Digital Audio
 	2426  82801AB AC'97 Modem
 	2428  82801AB PCI Bridge
-	2440  82820 820 (Camino 2) Chipset ISA Bridge (ICH2)
-	2442  82820 820 (Camino 2) Chipset USB (Hub A)
-	2443  82820 820 (Camino 2) Chipset SMBus
-	2444  82820 820 (Camino 2) Chipset USB (Hub B)
-	2445  82820 820 (Camino 2) Chipset AC'97 Audio Controller
-	2446  82820 820 (Camino 2) Chipset AC'97 Modem Controller
-	2448  82820 820 (Camino 2) Chipset PCI (-M)
-	2449  82820 (ICH2) Chipset Ethernet Controller
-	244a  82820 820 (Camino 2) Chipset IDE U100 (-M)
-	244b  82820 820 (Camino 2) Chipset IDE U100
-	244c  82820 820 (Camino 2) Chipset ISA Bridge (ICH2-M)
-	244e  82820 820 (Camino 2) Chipset PCI
-	2500  82820 820 (Camino) Chipset Host Bridge (MCH)
+	2440  82801BA ISA Bridge (LPC)
+	2442  82801BA/BAM USB (Hub #1)
+	2443  82801BA/BAM SMBus
+	2444  82801BA/BAM USB (Hub #2)
+	2445  82801BA/BAM AC'97 Audio
+	2446  82801BA/BAM AC'97 Modem
+	2448  82801BAM/CAM PCI Bridge
+	2449  82801BA/BAM/CA/CAM Ethernet Controller
+	244a  82801BAM IDE U100
+	244b  82801BA IDE U100
+	244c  82801BAM ISA Bridge (LPC)
+	244e  82801BA/CA PCI Bridge
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
+	2500  82820 820 [Camino] Chipset Host Bridge (MCH)
 		1043 801c  P3C-2000 system chipset
-	2501  82820 820 (Camino) Chipset Host Bridge (MCH)
+	2501  82820 820 [Camino] Chipset Host Bridge (MCH)
 		1043 801c  P3C-2000 system chipset
-	250b  82820 820 (Camino) Chipset Host Bridge
-	250f  82820 820 (Camino) Chipset PCI to AGP Bridge
+	250b  82820 820 [Camino] Chipset Host Bridge
+	250f  82820 820 [Camino] Chipset AGP Bridge
 	2520  82805AA MTH Memory Translator Hub
 	2521  82804AA MRH-S Memory Repeater Hub for SDRAM
-	2530  82850 850 (Tehama) Chipset Host Bridge (MCH)
-	2531  82850 860 (Wombat) Chipset Host Bridge (MCH)
-	2532  82850 850 (Tehama) Chipset AGP Bridge
-	2533  82860 860 (Wombat) Chipset AGP Bridge
+	2530  82850 850 [Tehama] Chipset Host Bridge (MCH)
+	2531  82850 860 [Wombat] Chipset Host Bridge (MCH)
+	2532  82850 850 [Tehama] Chipset AGP Bridge
+	2533  82860 860 [Wombat] Chipset AGP Bridge
+	2534  82860 860 [Wombat] Chipset PCI Bridge
+	3575  82830 830 Chipset Host Bridge
+	3576  82830 830 Chipset AGP Bridge
+	3578  82830 830 Chipset Host Bridge
 	5200  EtherExpress PRO/100 Intelligent Server
 	5201  EtherExpress PRO/100 Intelligent Server
 		8086 0001  EtherExpress PRO/100 Server Ethernet Adapter
@@ -4960,11 +4975,13 @@
 	7113  82371AB PIIX4 ACPI
 	7120  82810 GMCH [Graphics Memory Controller Hub]
 	7121  82810 CGC [Chipset Graphics Controller]
-	7122  82810-DC100 GMCH [Graphics Memory Controller Hub]
-	7123  82810-DC100 CGC [Chipset Graphics Controller]
-	7124  82810E GMCH [Graphics Memory Controller Hub]
-	7125  82810E CGC [Chipset Graphics Controller]
-	7126  82810 810 Chipset Host Bridge and Memory Controller Hub
+	7122  82810 DC-100 GMCH [Graphics Memory Controller Hub]
+	7123  82810 DC-100 CGC [Chipset Graphics Controller]
+	7124  82810E DC-133 GMCH [Graphics Memory Controller Hub]
+	7125  82810E DC-133 CGC [Chipset Graphics Controller]
+	7126  82810 DC-133 System and Graphics Controller
+	7128  82810-M DC-100 System and Graphics Controller
+	712A  82810-M DC-133 System and Graphics Controller
 	7180  440LX/EX - 82443LX/EX Host bridge
 	7181  440LX/EX - 82443LX/EX AGP bridge
 	7190  440BX/ZX - 82443BX/ZX Host bridge
diff -u --recursive --new-file linux-2.4.13/include/linux/pci_ids.h linux-2.4.13-patched/include/linux/pci_ids.h
--- linux-2.4.13/include/linux/pci_ids.h	Wed Oct 17 06:56:29 2001
+++ linux-2.4.13-patched/include/linux/pci_ids.h	Sun Oct 28 11:11:58 2001
@@ -1559,15 +1559,6 @@
 #define PCI_DEVICE_ID_INTEL_82380FB	0x124b
 #define PCI_DEVICE_ID_INTEL_82439	0x1250
 #define PCI_DEVICE_ID_INTEL_80960_RP	0x1960
-#define PCI_DEVICE_ID_INTEL_82371SB_0	0x7000
-#define PCI_DEVICE_ID_INTEL_82371SB_1	0x7010
-#define PCI_DEVICE_ID_INTEL_82371SB_2	0x7020
-#define PCI_DEVICE_ID_INTEL_82437VX	0x7030
-#define PCI_DEVICE_ID_INTEL_82439TX	0x7100
-#define PCI_DEVICE_ID_INTEL_82371AB_0	0x7110
-#define PCI_DEVICE_ID_INTEL_82371AB	0x7111
-#define PCI_DEVICE_ID_INTEL_82371AB_2	0x7112
-#define PCI_DEVICE_ID_INTEL_82371AB_3	0x7113
 #define PCI_DEVICE_ID_INTEL_82801AA_0	0x2410
 #define PCI_DEVICE_ID_INTEL_82801AA_1	0x2411
 #define PCI_DEVICE_ID_INTEL_82801AA_2	0x2412
@@ -1583,17 +1574,17 @@
 #define PCI_DEVICE_ID_INTEL_82801AB_6	0x2426
 #define PCI_DEVICE_ID_INTEL_82801AB_8	0x2428
 #define PCI_DEVICE_ID_INTEL_82801BA_0	0x2440
-#define PCI_DEVICE_ID_INTEL_82801BA_1	0x2442
-#define PCI_DEVICE_ID_INTEL_82801BA_2	0x2443
-#define PCI_DEVICE_ID_INTEL_82801BA_3	0x2444
-#define PCI_DEVICE_ID_INTEL_82801BA_4	0x2445
-#define PCI_DEVICE_ID_INTEL_82801BA_5	0x2446
-#define PCI_DEVICE_ID_INTEL_82801BA_6	0x2448
-#define PCI_DEVICE_ID_INTEL_82801BA_7	0x2449
-#define PCI_DEVICE_ID_INTEL_82801BA_8	0x244a
-#define PCI_DEVICE_ID_INTEL_82801BA_9	0x244b
-#define PCI_DEVICE_ID_INTEL_82801BA_10	0x244c
-#define PCI_DEVICE_ID_INTEL_82801BA_11	0x244e
+#define PCI_DEVICE_ID_INTEL_82801BA_2	0x2442
+#define PCI_DEVICE_ID_INTEL_82801BA_3	0x2443
+#define PCI_DEVICE_ID_INTEL_82801BA_4	0x2444
+#define PCI_DEVICE_ID_INTEL_82801BA_5	0x2445
+#define PCI_DEVICE_ID_INTEL_82801BA_6	0x2446
+#define PCI_DEVICE_ID_INTEL_82801BA_8	0x2448
+#define PCI_DEVICE_ID_INTEL_82801BA_9	0x2449
+#define PCI_DEVICE_ID_INTEL_82801BA_10	0x244a
+#define PCI_DEVICE_ID_INTEL_82801BA_11	0x244b
+#define PCI_DEVICE_ID_INTEL_82801BA_12	0x244c
+#define PCI_DEVICE_ID_INTEL_82801BA_14	0x244e
 #define PCI_DEVICE_ID_INTEL_82801CA_0	0x2480
 #define PCI_DEVICE_ID_INTEL_82801CA_2	0x2482
 #define PCI_DEVICE_ID_INTEL_82801CA_3	0x2483
@@ -1605,6 +1596,15 @@
 #define PCI_DEVICE_ID_INTEL_82801CA_11	0x248b
 #define PCI_DEVICE_ID_INTEL_82801CA_12	0x248c
 #define PCI_DEVICE_ID_INTEL_80310	0x530d
+#define PCI_DEVICE_ID_INTEL_82371SB_0	0x7000
+#define PCI_DEVICE_ID_INTEL_82371SB_1	0x7010
+#define PCI_DEVICE_ID_INTEL_82371SB_2	0x7020
+#define PCI_DEVICE_ID_INTEL_82437VX	0x7030
+#define PCI_DEVICE_ID_INTEL_82439TX	0x7100
+#define PCI_DEVICE_ID_INTEL_82371AB_0	0x7110
+#define PCI_DEVICE_ID_INTEL_82371AB	0x7111
+#define PCI_DEVICE_ID_INTEL_82371AB_2	0x7112
+#define PCI_DEVICE_ID_INTEL_82371AB_3	0x7113
 #define PCI_DEVICE_ID_INTEL_82810_MC1	0x7120
 #define PCI_DEVICE_ID_INTEL_82810_IG1	0x7121
 #define PCI_DEVICE_ID_INTEL_82810_MC3	0x7122
