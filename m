Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293447AbSBZB7n>; Mon, 25 Feb 2002 20:59:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293464AbSBZB7g>; Mon, 25 Feb 2002 20:59:36 -0500
Received: from acolyte.thorsen.se ([193.14.93.247]:39942 "HELO
	acolyte.hack.org") by vger.kernel.org with SMTP id <S293447AbSBZB70>;
	Mon, 25 Feb 2002 20:59:26 -0500
From: Christer Weinigel <wingel@acolyte.hack.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] NatSemi SCx200 IDE support needs testing
Message-Id: <20020226015924.3F9B9F5B@acolyte.hack.org>
Date: Tue, 26 Feb 2002 02:59:24 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The National Semiconductor SCx200 CPUs are a descendant of the Cyrix
MediaGX/National Geode CPU and CS5530 companion chip.  After reading
the datasheets I belive that the same driver that is used for the
CS5530 should work with the SCx200.  I have added the SCx200 PCI IDs
to the IDE driver so that the CS5530 support will be turned on.

This works fine for me, although I don't see all that much of a
performance difference.  I would very much like other people to test
this patch do see if it works fine or if there is a difference and the
patch will eat the disks.  So, if you feel adventurous, please apply
this patch and tell me if it works.

This patch requires the other SCx200 patch I posted a few minutes
ago.  If you can't find that patch, the only things needed are the PCI
ID definitions, so just add the following to include/linux/pci_ids.h
and it should work ok:

#define PCI_DEVICE_ID_NS_SCx200_BRIDGE	0x0500
#define PCI_DEVICE_ID_NS_SCx200_IDE	0x0502

  /Christer

diff -urN linux.orig/drivers/ide/cs5530.c linux/drivers/ide/cs5530.c
--- linux.orig/drivers/ide/cs5530.c	Tue Feb 26 01:16:58 2002
+++ linux/drivers/ide/cs5530.c	Tue Feb 26 01:16:58 2002
@@ -276,6 +276,13 @@
 					break;
 			}
 		}
+		if (dev->vendor == PCI_VENDOR_ID_NS) {
+			switch (dev->device) {
+				case PCI_DEVICE_ID_NS_SCx200_BRIDGE:
+					cs5530_0 = dev;
+					break;
+			}
+		}
 	}
 	if (!master_0) {
 		printk("%s: unable to locate PCI MASTER function\n", name);
diff -urN linux.orig/drivers/ide/ide-pci.c linux/drivers/ide/ide-pci.c
--- linux.orig/drivers/ide/ide-pci.c	Tue Feb 26 01:16:58 2002
+++ linux/drivers/ide/ide-pci.c	Tue Feb 26 01:16:58 2002
@@ -76,6 +76,7 @@
 #define DEVID_CY82C693	((ide_pci_devid_t){PCI_VENDOR_ID_CONTAQ,  PCI_DEVICE_ID_CONTAQ_82C693})
 #define DEVID_HINT	((ide_pci_devid_t){0x3388,                0x8013})
 #define DEVID_CS5530	((ide_pci_devid_t){PCI_VENDOR_ID_CYRIX,   PCI_DEVICE_ID_CYRIX_5530_IDE})
+#define DEVID_SCx200	((ide_pci_devid_t){PCI_VENDOR_ID_NS,      PCI_DEVICE_ID_NS_SCx200_IDE})
 #define DEVID_AMD7401	((ide_pci_devid_t){PCI_VENDOR_ID_AMD,     PCI_DEVICE_ID_AMD_COBRA_7401})
 #define DEVID_AMD7409	((ide_pci_devid_t){PCI_VENDOR_ID_AMD,     PCI_DEVICE_ID_AMD_VIPER_7409})
 #define DEVID_AMD7411	((ide_pci_devid_t){PCI_VENDOR_ID_AMD,     PCI_DEVICE_ID_AMD_VIPER_7411})
@@ -434,6 +435,7 @@
 	{DEVID_CY82C693,"CY82C693",	PCI_CY82C693,	NULL,		INIT_CY82C693,	NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	ON_BOARD,	0 },
 	{DEVID_HINT,	"HINT_IDE",	NULL,		NULL,		NULL,		NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	ON_BOARD,	0 },
 	{DEVID_CS5530,	"CS5530",	PCI_CS5530,	NULL,		INIT_CS5530,	NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	ON_BOARD,	0 },
+	{DEVID_SCx200,	"SCx200",	PCI_CS5530,	NULL,		INIT_CS5530,	NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	ON_BOARD,	0 },
 	{DEVID_AMD7401,	"AMD7401",	NULL,		NULL,		NULL,		NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	ON_BOARD,	0 },
 	{DEVID_AMD7409,	"AMD7409",	PCI_AMD74XX,	ATA66_AMD74XX,	INIT_AMD74XX,	DMA_AMD74XX,	{{0x40,0x01,0x01}, {0x40,0x02,0x02}},	ON_BOARD,	0 },
 	{DEVID_AMD7411,	"AMD7411",	PCI_AMD74XX,	ATA66_AMD74XX,	INIT_AMD74XX,	DMA_AMD74XX,	{{0x40,0x01,0x01}, {0x40,0x02,0x02}},	ON_BOARD,	0 },
@@ -781,6 +783,7 @@
 		    IDE_PCI_DEVID_EQ(d->devid, DEVID_HPT34X) ||
 		    IDE_PCI_DEVID_EQ(d->devid, DEVID_HPT366) ||
 		    IDE_PCI_DEVID_EQ(d->devid, DEVID_CS5530) ||
+		    IDE_PCI_DEVID_EQ(d->devid, DEVID_SCx200) ||
 		    IDE_PCI_DEVID_EQ(d->devid, DEVID_CY82C693) ||
 		    IDE_PCI_DEVID_EQ(d->devid, DEVID_CMD646) ||
 		    IDE_PCI_DEVID_EQ(d->devid, DEVID_CMD648) ||
@@ -792,7 +795,8 @@
 				/*
  	 			 * Set up BM-DMA capability (PnP BIOS should have done this)
  	 			 */
-		    		if (!IDE_PCI_DEVID_EQ(d->devid, DEVID_CS5530))
+		    		if (!IDE_PCI_DEVID_EQ(d->devid, DEVID_CS5530)
+				    && !IDE_PCI_DEVID_EQ(d->devid, DEVID_SCx200))
 					hwif->autodma = 0;	/* default DMA off if we had to configure it here */
 				(void) pci_write_config_word(dev, PCI_COMMAND, pcicmd | PCI_COMMAND_MASTER);
 				if (pci_read_config_word(dev, PCI_COMMAND, &pcicmd) || !(pcicmd & PCI_COMMAND_MASTER)) {
diff -urN linux.orig/drivers/mtd/maps/Config.in linux/drivers/mtd/maps/Config.in

-- 
"Just how much can I get away with and still go to heaven?"
