Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287578AbSASV7U>; Sat, 19 Jan 2002 16:59:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287573AbSASV7L>; Sat, 19 Jan 2002 16:59:11 -0500
Received: from ool-182d14cd.dyn.optonline.net ([24.45.20.205]:54788 "HELO
	osinvestor.com") by vger.kernel.org with SMTP id <S287539AbSASV66>;
	Sat, 19 Jan 2002 16:58:58 -0500
Date: Sat, 19 Jan 2002 16:58:55 -0500 (EST)
From: Rob Radez <rob@osinvestor.com>
X-X-Sender: <rob@pita.lan>
To: <linux-kernel@vger.kernel.org>
cc: Andre Hedrick <andre@linux-ide.org>
Subject: [PATCH] Andre's IDE Patch (3/7)
Message-ID: <Pine.LNX.4.33.0201191504000.14950-100000@pita.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the third of seven patches against 2.4.18-pre4, beginning the breakup
of Andre Hedrick's IDE patch into smaller chunks.

Description of patch 3:
This patch touches one file, drivers/ide/ide-pci.c and was compile and boot
tested.  It adds in definitions for more chipsets, and adds a fixup for the
PDC 20268R chipset.  Other than that there are no major functional changes.

Regards,
Rob Radez

diff -ruN linux-2.4.18-pre3/drivers/ide/ide-pci.c linux-2.4.18-pre3-ide-rr/drivers/ide/ide-pci.c
--- linux-2.4.18-pre3/drivers/ide/ide-pci.c	Thu Oct 25 16:53:47 2001
+++ linux-2.4.18-pre3-ide-rr/drivers/ide/ide-pci.c	Mon Jan 14 18:29:06 2002
@@ -12,6 +12,13 @@
  *  configuration of all PCI IDE interfaces present in a system.
  */

+/*
+ * Chipsets that are on the IDE_IGNORE list because of problems of not being
+ * set at compile time.
+ *
+ * CONFIG_BLK_DEV_PDC202XX
+ */
+
 #include <linux/config.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
@@ -47,6 +54,8 @@
 #define DEVID_PDC20267	((ide_pci_devid_t){PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20267})
 #define DEVID_PDC20268  ((ide_pci_devid_t){PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20268})
 #define DEVID_PDC20268R ((ide_pci_devid_t){PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20268R})
+#define DEVID_PDC20269	((ide_pci_devid_t){PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20269})
+#define DEVID_PDC20275	((ide_pci_devid_t){PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20275})
 #define DEVID_RZ1000	((ide_pci_devid_t){PCI_VENDOR_ID_PCTECH,  PCI_DEVICE_ID_PCTECH_RZ1000})
 #define DEVID_RZ1001	((ide_pci_devid_t){PCI_VENDOR_ID_PCTECH,  PCI_DEVICE_ID_PCTECH_RZ1001})
 #define DEVID_SAMURAI	((ide_pci_devid_t){PCI_VENDOR_ID_PCTECH,  PCI_DEVICE_ID_PCTECH_SAMURAI_IDE})
@@ -55,6 +64,7 @@
 #define DEVID_CMD646	((ide_pci_devid_t){PCI_VENDOR_ID_CMD,     PCI_DEVICE_ID_CMD_646})
 #define DEVID_CMD648	((ide_pci_devid_t){PCI_VENDOR_ID_CMD,     PCI_DEVICE_ID_CMD_648})
 #define DEVID_CMD649	((ide_pci_devid_t){PCI_VENDOR_ID_CMD,     PCI_DEVICE_ID_CMD_649})
+#define DEVID_CMD680	((ide_pci_devid_t){PCI_VENDOR_ID_CMD,     PCI_DEVICE_ID_CMD_680})
 #define DEVID_SIS5513	((ide_pci_devid_t){PCI_VENDOR_ID_SI,      PCI_DEVICE_ID_SI_5513})
 #define DEVID_OPTI621	((ide_pci_devid_t){PCI_VENDOR_ID_OPTI,    PCI_DEVICE_ID_OPTI_82C621})
 #define DEVID_OPTI621V	((ide_pci_devid_t){PCI_VENDOR_ID_OPTI,    PCI_DEVICE_ID_OPTI_82C558})
@@ -79,6 +89,7 @@
 #define DEVID_AMD7401	((ide_pci_devid_t){PCI_VENDOR_ID_AMD,     PCI_DEVICE_ID_AMD_COBRA_7401})
 #define DEVID_AMD7409	((ide_pci_devid_t){PCI_VENDOR_ID_AMD,     PCI_DEVICE_ID_AMD_VIPER_7409})
 #define DEVID_AMD7411	((ide_pci_devid_t){PCI_VENDOR_ID_AMD,     PCI_DEVICE_ID_AMD_VIPER_7411})
+#define DEVID_AMD7441	((ide_pci_devid_t){PCI_VENDOR_ID_AMD,     PCI_DEVICE_ID_AMD_VIPER_7441})
 #define DEVID_PDCADMA	((ide_pci_devid_t){PCI_VENDOR_ID_PDC,     PCI_DEVICE_ID_PDC_1841})
 #define DEVID_SLC90E66	((ide_pci_devid_t){PCI_VENDOR_ID_EFAR,    PCI_DEVICE_ID_EFAR_SLC90E66_1})
 #define DEVID_OSB4	((ide_pci_devid_t){PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_OSB4IDE})
@@ -86,6 +97,7 @@
 #define DEVID_ITE8172G	((ide_pci_devid_t){PCI_VENDOR_ID_ITE,     PCI_DEVICE_ID_ITE_IT8172G})

 #define	IDE_IGNORE	((void *)-1)
+#define IDE_NO_DRIVER	((void *)-2)

 #ifdef CONFIG_BLK_DEV_AEC62XX
 extern unsigned int pci_init_aec62xx(struct pci_dev *, const char *);
@@ -99,7 +111,7 @@
 #else
 #define PCI_AEC62XX	NULL
 #define ATA66_AEC62XX	NULL
-#define INIT_AEC62XX	NULL
+#define INIT_AEC62XX	IDE_NO_DRIVER
 #define DMA_AEC62XX	NULL
 #endif

@@ -115,7 +127,7 @@
 #else
 #define PCI_ALI15X3	NULL
 #define ATA66_ALI15X3	NULL
-#define INIT_ALI15X3	NULL
+#define INIT_ALI15X3	IDE_NO_DRIVER
 #define DMA_ALI15X3	NULL
 #endif

@@ -131,7 +143,7 @@
 #else
 #define PCI_AMD74XX	NULL
 #define ATA66_AMD74XX	NULL
-#define INIT_AMD74XX	NULL
+#define INIT_AMD74XX	IDE_NO_DRIVER
 #define DMA_AMD74XX	NULL
 #endif

@@ -149,7 +161,7 @@
 #ifdef __sparc_v9__
 #define INIT_CMD64X	IDE_IGNORE
 #else
-#define INIT_CMD64X	NULL
+#define INIT_CMD64X	IDE_NO_DRIVER
 #endif
 #endif

@@ -160,7 +172,7 @@
 #define INIT_CY82C693	&ide_init_cy82c693
 #else
 #define PCI_CY82C693	NULL
-#define INIT_CY82C693	NULL
+#define INIT_CY82C693	IDE_NO_DRIVER
 #endif

 #ifdef CONFIG_BLK_DEV_CS5530
@@ -170,7 +182,7 @@
 #define INIT_CS5530	&ide_init_cs5530
 #else
 #define PCI_CS5530	NULL
-#define INIT_CS5530	NULL
+#define INIT_CS5530	IDE_NO_DRIVER
 #endif

 #ifdef CONFIG_BLK_DEV_HPT34X
@@ -199,7 +211,7 @@
 static byte hpt363_shared_pin;
 #define PCI_HPT366	NULL
 #define ATA66_HPT366	NULL
-#define INIT_HPT366	NULL
+#define INIT_HPT366	IDE_NO_DRIVER
 #define DMA_HPT366	NULL
 #endif

@@ -214,7 +226,7 @@
 extern void ide_init_opti621(ide_hwif_t *);
 #define INIT_OPTI621	&ide_init_opti621
 #else
-#define INIT_OPTI621	NULL
+#define INIT_OPTI621	IDE_NO_DRIVER
 #endif

 #ifdef CONFIG_BLK_DEV_PDC_ADMA
@@ -241,9 +253,9 @@
 #define ATA66_PDC202XX	&ata66_pdc202xx
 #define INIT_PDC202XX	&ide_init_pdc202xx
 #else
-#define PCI_PDC202XX	NULL
-#define ATA66_PDC202XX	NULL
-#define INIT_PDC202XX	NULL
+#define PCI_PDC202XX	IDE_IGNORE
+#define ATA66_PDC202XX	IDE_IGNORE
+#define INIT_PDC202XX	IDE_IGNORE
 #endif

 #ifdef CONFIG_BLK_DEV_PIIX
@@ -256,7 +268,7 @@
 #else
 #define PCI_PIIX	NULL
 #define ATA66_PIIX	NULL
-#define INIT_PIIX	NULL
+#define INIT_PIIX	IDE_NO_DRIVER
 #endif

 #ifdef CONFIG_BLK_DEV_IT8172
@@ -268,7 +280,7 @@
 #else
 #define PCI_IT8172	NULL
 #define ATA66_IT8172	NULL
-#define INIT_IT8172	NULL
+#define INIT_IT8172	IDE_NO_DRIVER
 #endif

 #ifdef CONFIG_BLK_DEV_RZ1000
@@ -290,7 +302,7 @@
 #else
 #define PCI_SVWKS	NULL
 #define ATA66_SVWKS	NULL
-#define INIT_SVWKS	NULL
+#define INIT_SVWKS	IDE_NO_DRIVER
 #endif

 #ifdef CONFIG_BLK_DEV_SIS5513
@@ -303,7 +315,7 @@
 #else
 #define PCI_SIS5513	NULL
 #define ATA66_SIS5513	NULL
-#define INIT_SIS5513	NULL
+#define INIT_SIS5513	IDE_NO_DRIVER
 #endif

 #ifdef CONFIG_BLK_DEV_SLC90E66
@@ -316,7 +328,7 @@
 #else
 #define PCI_SLC90E66	NULL
 #define ATA66_SLC90E66	NULL
-#define INIT_SLC90E66	NULL
+#define INIT_SLC90E66	IDE_NO_DRIVER
 #endif

 #ifdef CONFIG_BLK_DEV_SL82C105
@@ -351,7 +363,7 @@
 #else
 #define PCI_VIA82CXXX	NULL
 #define ATA66_VIA82CXXX	NULL
-#define INIT_VIA82CXXX	NULL
+#define INIT_VIA82CXXX	IDE_NO_DRIVER
 #define DMA_VIA82CXXX	NULL
 #endif

@@ -393,7 +405,7 @@
 #ifdef CONFIG_PDC202XX_FORCE
         {DEVID_PDC20246,"PDC20246",	PCI_PDC202XX,	NULL,		INIT_PDC202XX,	NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	OFF_BOARD,	16 },
         {DEVID_PDC20262,"PDC20262",	PCI_PDC202XX,	ATA66_PDC202XX,	INIT_PDC202XX,	NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	OFF_BOARD,	48 },
-        {DEVID_PDC20265,"PDC20265",	PCI_PDC202XX,	ATA66_PDC202XX,	INIT_PDC202XX,	NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	OFF_BOARD,	48 },
+        {DEVID_PDC20265,"PDC20265",	PCI_PDC202XX,	ATA66_PDC202XX,	INIT_PDC202XX,	NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	ON_BOARD,	48 },
         {DEVID_PDC20267,"PDC20267",	PCI_PDC202XX,	ATA66_PDC202XX,	INIT_PDC202XX,	NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	OFF_BOARD,	48 },
 #else /* !CONFIG_PDC202XX_FORCE */
 	{DEVID_PDC20246,"PDC20246",	PCI_PDC202XX,	NULL,		INIT_PDC202XX,	NULL,		{{0x50,0x02,0x02}, {0x50,0x04,0x04}}, 	OFF_BOARD,	16 },
@@ -401,11 +413,13 @@
 	{DEVID_PDC20265,"PDC20265",	PCI_PDC202XX,	ATA66_PDC202XX,	INIT_PDC202XX,	NULL,		{{0x50,0x02,0x02}, {0x50,0x04,0x04}},	OFF_BOARD,	48 },
 	{DEVID_PDC20267,"PDC20267",	PCI_PDC202XX,	ATA66_PDC202XX,	INIT_PDC202XX,	NULL,		{{0x50,0x02,0x02}, {0x50,0x04,0x04}},	OFF_BOARD,	48 },
 #endif
-	{DEVID_PDC20268,"PDC20268",	PCI_PDC202XX,	ATA66_PDC202XX,	INIT_PDC202XX,	NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	OFF_BOARD,	16 },
+	{DEVID_PDC20268,"PDC20268",	PCI_PDC202XX,	ATA66_PDC202XX,	INIT_PDC202XX,	NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	OFF_BOARD,	0 },
 	/* Promise used a different PCI ident for the raid card apparently to try and
 	   prevent Linux detecting it and using our own raid code. We want to detect
 	   it for the ataraid drivers, so we have to list both here.. */
-	{DEVID_PDC20268R,"PDC20268",	PCI_PDC202XX,	ATA66_PDC202XX,	INIT_PDC202XX,	NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	OFF_BOARD,	16 },
+	{DEVID_PDC20268R,"PDC20270",	PCI_PDC202XX,	ATA66_PDC202XX,	INIT_PDC202XX,	NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	OFF_BOARD,	0 },
+	{DEVID_PDC20269,"PDC20269",	PCI_PDC202XX,	ATA66_PDC202XX,	 INIT_PDC202XX,	NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	OFF_BOARD,	0 },
+	{DEVID_PDC20275,"PDC20275",	PCI_PDC202XX,	ATA66_PDC202XX,	INIT_PDC202XX,	NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	OFF_BOARD,	0 },
 	{DEVID_RZ1000,	"RZ1000",	NULL,		NULL,		INIT_RZ1000,	NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}}, 	ON_BOARD,	0 },
 	{DEVID_RZ1001,	"RZ1001",	NULL,		NULL,		INIT_RZ1000,	NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}}, 	ON_BOARD,	0 },
 	{DEVID_SAMURAI,	"SAMURAI",	NULL,		NULL,		INIT_SAMURAI,	NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	ON_BOARD,	0 },
@@ -416,6 +430,11 @@
 	{DEVID_CMD646,	"CMD646",	PCI_CMD64X,	NULL,		INIT_CMD64X,	NULL,		{{0x00,0x00,0x00}, {0x51,0x80,0x80}}, 	ON_BOARD,	0 },
 	{DEVID_CMD648,	"CMD648",	PCI_CMD64X,	ATA66_CMD64X,	INIT_CMD64X,	NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	ON_BOARD,	0 },
 	{DEVID_CMD649,	"CMD649",	PCI_CMD64X,	ATA66_CMD64X,	INIT_CMD64X,	NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	ON_BOARD,	0 },
+#ifndef CONFIG_BLK_DEV_CMD680
+	{DEVID_CMD680,	"CMD680",	NULL,		NULL,		NULL,		NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	ON_BOARD,	0 },
+#else /* CONFIG_BLK_DEV_CMD680 */
+	{DEVID_CMD680,	"CMD680",	PCI_CMD64X,	ATA66_CMD64X,	INIT_CMD64X,	NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	ON_BOARD,	0 },
+#endif /* !CONFIG_BLK_DEV_CMD680 */
 	{DEVID_HT6565,	"HT6565",	NULL,		NULL,		NULL,		NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}}, 	ON_BOARD,	0 },
 	{DEVID_OPTI621,	"OPTI621",	NULL,		NULL,		INIT_OPTI621,	NULL,		{{0x45,0x80,0x00}, {0x40,0x08,0x00}}, 	ON_BOARD,	0 },
 	{DEVID_OPTI621X,"OPTI621X",	NULL,		NULL,		INIT_OPTI621,	NULL,		{{0x45,0x80,0x00}, {0x40,0x08,0x00}}, 	ON_BOARD,	0 },
@@ -434,9 +453,10 @@
 	{DEVID_CY82C693,"CY82C693",	PCI_CY82C693,	NULL,		INIT_CY82C693,	NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	ON_BOARD,	0 },
 	{DEVID_HINT,	"HINT_IDE",	NULL,		NULL,		NULL,		NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	ON_BOARD,	0 },
 	{DEVID_CS5530,	"CS5530",	PCI_CS5530,	NULL,		INIT_CS5530,	NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	ON_BOARD,	0 },
-	{DEVID_AMD7401,	"AMD7401",	NULL,		NULL,		NULL,		NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	ON_BOARD,	0 },
+	{DEVID_AMD7401,	"AMD7401",	NULL,		NULL,		NULL,		DMA_AMD74XX,	{{0x40,0x01,0x01}, {0x40,0x02,0x02}},	ON_BOARD,	0 },
 	{DEVID_AMD7409,	"AMD7409",	PCI_AMD74XX,	ATA66_AMD74XX,	INIT_AMD74XX,	DMA_AMD74XX,	{{0x40,0x01,0x01}, {0x40,0x02,0x02}},	ON_BOARD,	0 },
 	{DEVID_AMD7411,	"AMD7411",	PCI_AMD74XX,	ATA66_AMD74XX,	INIT_AMD74XX,	DMA_AMD74XX,	{{0x40,0x01,0x01}, {0x40,0x02,0x02}},	ON_BOARD,	0 },
+	{DEVID_AMD7441,	"AMD7441",	PCI_AMD74XX,	ATA66_AMD74XX,	INIT_AMD74XX,	DMA_AMD74XX,	{{0x40,0x01,0x01}, {0x40,0x02,0x02}},	ON_BOARD,	0 },
 	{DEVID_PDCADMA,	"PDCADMA",	PCI_PDCADMA,	ATA66_PDCADMA,	INIT_PDCADMA,	DMA_PDCADMA,	{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	OFF_BOARD,	0 },
 	{DEVID_SLC90E66,"SLC90E66",	PCI_SLC90E66,	ATA66_SLC90E66,	INIT_SLC90E66,	NULL,		{{0x41,0x80,0x80}, {0x43,0x80,0x80}},	ON_BOARD,	0 },
         {DEVID_OSB4,    "ServerWorks OSB4",		PCI_SVWKS,	ATA66_SVWKS,	INIT_SVWKS,	NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	ON_BOARD,	0 },
@@ -458,6 +478,9 @@
 		case PCI_DEVICE_ID_PROMISE_20265:
 		case PCI_DEVICE_ID_PROMISE_20267:
 		case PCI_DEVICE_ID_PROMISE_20268:
+		case PCI_DEVICE_ID_PROMISE_20268R:
+		case PCI_DEVICE_ID_PROMISE_20269:
+		case PCI_DEVICE_ID_PROMISE_20275:
 		case PCI_DEVICE_ID_ARTOP_ATP850UF:
 		case PCI_DEVICE_ID_ARTOP_ATP860:
 		case PCI_DEVICE_ID_ARTOP_ATP860R:
@@ -592,7 +615,15 @@
 		autodma = 1;
 #endif

-	pci_enable_device(dev);
+	if (d->init_hwif == IDE_NO_DRIVER) {
+		printk(KERN_WARNING "%s: detected chipset, but driver not compiled in!\n", d->name);
+		d->init_hwif = NULL;
+	}
+
+	if (pci_enable_device(dev)) {
+		printk(KERN_WARNING "%s: (ide_setup_pci_device:) Could not enable device.\n", d->name);
+		return;
+	}

 check_if_enabled:
 	if (pci_read_config_word(dev, PCI_COMMAND, &pcicmd)) {
@@ -752,7 +783,8 @@
 		}
 		if (IDE_PCI_DEVID_EQ(d->devid, DEVID_MPIIX))
 			goto bypass_piix_dma;
-
+		if (IDE_PCI_DEVID_EQ(d->devid, DEVID_PDCADMA))
+			goto bypass_legacy_dma;
 		if (hwif->udma_four) {
 			printk("%s: ATA-66/100 forced bit set (WARNING)!!\n", d->name);
 		} else {
@@ -769,12 +801,15 @@
 			autodma = 0;
 		if (autodma)
 			hwif->autodma = 1;
+
 		if (IDE_PCI_DEVID_EQ(d->devid, DEVID_PDC20246) ||
 		    IDE_PCI_DEVID_EQ(d->devid, DEVID_PDC20262) ||
 		    IDE_PCI_DEVID_EQ(d->devid, DEVID_PDC20265) ||
 		    IDE_PCI_DEVID_EQ(d->devid, DEVID_PDC20267) ||
 		    IDE_PCI_DEVID_EQ(d->devid, DEVID_PDC20268) ||
 		    IDE_PCI_DEVID_EQ(d->devid, DEVID_PDC20268R) ||
+		    IDE_PCI_DEVID_EQ(d->devid, DEVID_PDC20269) ||
+		    IDE_PCI_DEVID_EQ(d->devid, DEVID_PDC20275) ||
 		    IDE_PCI_DEVID_EQ(d->devid, DEVID_AEC6210) ||
 		    IDE_PCI_DEVID_EQ(d->devid, DEVID_AEC6260) ||
 		    IDE_PCI_DEVID_EQ(d->devid, DEVID_AEC6260R) ||
@@ -785,6 +820,7 @@
 		    IDE_PCI_DEVID_EQ(d->devid, DEVID_CMD646) ||
 		    IDE_PCI_DEVID_EQ(d->devid, DEVID_CMD648) ||
 		    IDE_PCI_DEVID_EQ(d->devid, DEVID_CMD649) ||
+		    IDE_PCI_DEVID_EQ(d->devid, DEVID_CMD680) ||
 		    IDE_PCI_DEVID_EQ(d->devid, DEVID_OSB4) ||
 		    ((dev->class >> 8) == PCI_CLASS_STORAGE_IDE && (dev->class & 0x80))) {
 			unsigned long dma_base = ide_get_or_set_dma_base(hwif, (!mate && d->extra) ? d->extra : 0, d->name);
@@ -811,6 +847,7 @@
 			}
 		}
 #endif	/* CONFIG_BLK_DEV_IDEDMA */
+bypass_legacy_dma:
 bypass_piix_dma:
 bypass_umc_dma:
 		if (d->init_hwif)  /* Call chipset-specific routine for each enabled hwif */
@@ -822,6 +859,44 @@
 		printk("%s: neither IDE port enabled (BIOS)\n", d->name);
 }

+static void __init pdc20270_device_order_fixup (struct pci_dev *dev, ide_pci_device_t *d)
+{
+	struct pci_dev *dev2 = NULL, *findev;
+	ide_pci_device_t *d2;
+
+	if ((dev->bus->self &&
+	     dev->bus->self->vendor == PCI_VENDOR_ID_DEC) &&
+	    (dev->bus->self->device == PCI_DEVICE_ID_DEC_21150)) {
+		if (PCI_SLOT(dev->devfn) & 2) {
+			return;
+		}
+		d->extra = 0;
+		pci_for_each_dev(findev) {
+			if ((findev->vendor == dev->vendor) &&
+			    (findev->device == dev->device) &&
+			    (PCI_SLOT(findev->devfn) & 2)) {
+				byte irq = 0, irq2 = 0;
+				dev2 = findev;
+				pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
+				pci_read_config_byte(dev2, PCI_INTERRUPT_LINE, &irq2);
+                                if (irq != irq2) {
+					dev2->irq = dev->irq;
+                                        pci_write_config_byte(dev2, PCI_INTERRUPT_LINE, irq);
+                                }
+
+			}
+		}
+	}
+
+	printk("%s: IDE controller on PCI bus %02x dev %02x\n", d->name, dev->bus->number, dev->devfn);
+	ide_setup_pci_device(dev, d);
+	if (!dev2)
+		return;
+	d2 = d;
+	printk("%s: IDE controller on PCI bus %02x dev %02x\n", d2->name, dev2->bus->number, dev2->devfn);
+	ide_setup_pci_device(dev2, d2);
+}
+
 static void __init hpt366_device_order_fixup (struct pci_dev *dev, ide_pci_device_t *d)
 {
 	struct pci_dev *dev2 = NULL, *findev;
@@ -902,6 +977,8 @@
 		return;	/* UM8886A/BF pair */
 	else if (IDE_PCI_DEVID_EQ(d->devid, DEVID_HPT366))
 		hpt366_device_order_fixup(dev, d);
+	else if (IDE_PCI_DEVID_EQ(d->devid, DEVID_PDC20268R))
+		pdc20270_device_order_fixup(dev, d);
 	else if (!IDE_PCI_DEVID_EQ(d->devid, IDE_PCI_DEVID_NULL) || (dev->class >> 8) == PCI_CLASS_STORAGE_IDE) {
 		if (IDE_PCI_DEVID_EQ(d->devid, IDE_PCI_DEVID_NULL))
 			printk("%s: unknown IDE controller on PCI bus %02x device %02x, VID=%04x, DID=%04x\n",




