Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266970AbRHJLFS>; Fri, 10 Aug 2001 07:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266921AbRHJLFJ>; Fri, 10 Aug 2001 07:05:09 -0400
Received: from mail.zrz.TU-Berlin.DE ([130.149.4.15]:17047 "EHLO
	mail.zrz.tu-berlin.de") by vger.kernel.org with ESMTP
	id <S266917AbRHJLE7>; Fri, 10 Aug 2001 07:04:59 -0400
Date: Fri, 10 Aug 2001 13:05:00 +0200
From: Martin Krause <Martin.Krause@alumni.tu-berlin.de>
To: linux-kernel@vger.kernel.org
Subject: PDC20268 chipset support for kernel 2.4.7
Message-ID: <20010810130500.A1327@chrsch.chem.tu-berlin.de>
Reply-To: krause@pissedoff.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dear Linux IDE people,


recently I bought a U-DMA controller card and found that it was not
detected by the latest Linux kernel.

Though I'm a 100% newbie with kernel programming, I managed to make
the kernel detect my controller card. It was quite an easy task,
since the only problem was the chipset version number which could not
be recognised properly. I created a patch to fix the problem.

The patch provides support for the Promise Ultra100Tx2 controller card
(PDC20268 chipset) and works for kernel version 2.4.7.

But apparently there is still a problem with the 20268. The driver reports
an error message: "Mode MASTER Error"


# cat /proc/ide/pdc202xx 

			PDC20268 Chipset.
------------------------------- General Status ---------------------------------
Burst Mode                           : enabled
Host Mode                            : Tri-Stated
Bus Clocking                         : 100 External
IO pad select                        : 10 mA
Status Polling Period                : 15
Interrupt Check Status Polling Delay : 15
--------------- Primary Channel ---------------- Secondary Channel -------------
	enabled                          enabled 
66 Clocking     enabled                          enabled 
   Mode MASTER                      Mode MASTER
	Error                            Error       
--------------- drive0 --------- drive1 -------- drive0 ---------- drive1 ------
DMA enabled:    no               no              no                no 
DMA Mode:       PIO---           PIO---          PIO---            PIO---
PIO Mode:       PIO ?            PIO ?           PIO ?            PIO ?


Besides, DMA is disabled for all drives. What does that mean? In my system
there is a hard drive (Maxtor 4K080H4) attached as drive0 on the primary
channel. As far as I can see, the hard drive is accessible without problems.

I hope, some of you Linux gurus can tell me, what went wrong.


Below I enclosed my patch. It can be installed by the command:

(cd /usr/src/linux; patch -p1 < /somewhere/patchfile)


Best regards

   Martin Krause <krause@pissedoff.com>


P.S.: I'm not subscribed to the Linux-kernel mailing list. If you reply to this posting,
      please, send me a copy.




diff -urN 2.4.7/drivers/ide/ide-pci.c linux/drivers/ide/ide-pci.c
--- 2.4.7/drivers/ide/ide-pci.c	Thu Aug  9 21:39:12 2001
+++ linux/drivers/ide/ide-pci.c	Wed Jun 27 23:12:04 2001
@@ -42,7 +42,6 @@
#define DEVID_PDC20262	((ide_pci_devid_t){PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20262})
#define DEVID_PDC20265	((ide_pci_devid_t){PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20265})
#define DEVID_PDC20267	((ide_pci_devid_t){PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20267})
-#define DEVID_PDC20268	((ide_pci_devid_t){PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20268})
#define DEVID_RZ1000	((ide_pci_devid_t){PCI_VENDOR_ID_PCTECH,  PCI_DEVICE_ID_PCTECH_RZ1000})
#define DEVID_RZ1001	((ide_pci_devid_t){PCI_VENDOR_ID_PCTECH,  PCI_DEVICE_ID_PCTECH_RZ1001})
#define DEVID_SAMURAI	((ide_pci_devid_t){PCI_VENDOR_ID_PCTECH,  PCI_DEVICE_ID_PCTECH_SAMURAI_IDE})
@@ -355,7 +354,6 @@
{DEVID_PDC20262,"PDC20262",	PCI_PDC202XX,	ATA66_PDC202XX,	INIT_PDC202XX,	NULL,		{{0x50,0x02,0x02}, {0x50,0x04,0x04}},	OFF_BOARD,	48 },
{DEVID_PDC20265,"PDC20265",	PCI_PDC202XX,	ATA66_PDC202XX,	INIT_PDC202XX,	NULL,		{{0x50,0x02,0x02}, {0x50,0x04,0x04}},	OFF_BOARD,	48 },
{DEVID_PDC20267,"PDC20267",	PCI_PDC202XX,	ATA66_PDC202XX,	INIT_PDC202XX,	NULL,		{{0x50,0x02,0x02}, {0x50,0x04,0x04}},	OFF_BOARD,	48 },
-	{DEVID_PDC20268,"PDC20268",	PCI_PDC202XX,	ATA66_PDC202XX,	INIT_PDC202XX,	NULL,		{{0x50,0x02,0x02}, {0x50,0x04,0x04}},	OFF_BOARD,	48 },
{DEVID_RZ1000,	"RZ1000",	NULL,		NULL,		INIT_RZ1000,	NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}}, 	ON_BOARD,	0 },
{DEVID_RZ1001,	"RZ1001",	NULL,		NULL,		INIT_RZ1000,	NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}}, 	ON_BOARD,	0 },
{DEVID_SAMURAI,	"SAMURAI",	NULL,		NULL,		INIT_SAMURAI,	NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	ON_BOARD,	0 },
@@ -403,7 +401,6 @@
	case PCI_DEVICE_ID_PROMISE_20262:
	case PCI_DEVICE_ID_PROMISE_20265:
	case PCI_DEVICE_ID_PROMISE_20267:
-		case PCI_DEVICE_ID_PROMISE_20268:
	case PCI_DEVICE_ID_ARTOP_ATP850UF:
	case PCI_DEVICE_ID_ARTOP_ATP860:
	case PCI_DEVICE_ID_ARTOP_ATP860R:
@@ -699,7 +696,6 @@
	    IDE_PCI_DEVID_EQ(d->devid, DEVID_PDC20262) ||
	    IDE_PCI_DEVID_EQ(d->devid, DEVID_PDC20265) ||
 		    IDE_PCI_DEVID_EQ(d->devid, DEVID_PDC20267) ||
-		    IDE_PCI_DEVID_EQ(d->devid, DEVID_PDC20268) ||
 		    IDE_PCI_DEVID_EQ(d->devid, DEVID_AEC6210) ||
 		    IDE_PCI_DEVID_EQ(d->devid, DEVID_AEC6260) ||
 		    IDE_PCI_DEVID_EQ(d->devid, DEVID_AEC6260R) ||
@@ -731,7 +727,6 @@
 				} else {
 					ide_setup_dma(hwif, dma_base, 8);
 				}
-				printk("%s: %s Bus-Master DMA base: 0x%lx\n", hwif->name, d->name, dma_base);
 			} else {
 				printk("%s: %s Bus-Master DMA disabled (BIOS)\n", hwif->name, d->name);
 			}
diff -urN 2.4.7/drivers/ide/pdc202xx.c linux/drivers/ide/pdc202xx.c
--- 2.4.7/drivers/ide/pdc202xx.c	Thu Aug  9 21:39:12 2001
+++ linux/drivers/ide/pdc202xx.c	Wed May  2 01:05:00 2001
@@ -48,8 +48,8 @@
 
 #include "ide_modes.h"
 
-#define PDC202XX_DEBUG_DRIVE_INFO		1
-#define PDC202XX_DECODE_REGISTER_INFO		1
+#define PDC202XX_DEBUG_DRIVE_INFO		0
+#define PDC202XX_DECODE_REGISTER_INFO		0
 
 #define DISPLAY_PDC202XX_TIMINGS
 
@@ -132,9 +132,6 @@
 	pci_read_config_dword(dev, 0x6c, &reg6ch);
 
 	switch(dev->device) {
-		case PCI_DEVICE_ID_PROMISE_20268:
-			p += sprintf(p, "\n                                PDC20268 Chipset.\n");
-			break;
 		case PCI_DEVICE_ID_PROMISE_20267:
 			p += sprintf(p, "\n                                PDC20267 Chipset.\n");
 			break;
@@ -222,7 +219,6 @@
 	"QUANTUM FIREBALLP LM20.4",
 	"QUANTUM FIREBALLP KX20.5",
 	"QUANTUM FIREBALLP LM20.5",
-	"MAXTOR 4K080H4",
 	NULL
 };
 
@@ -517,7 +513,7 @@
 	byte CLKSPD		= IN_BYTE(high_16 + 0x11);
 	byte udma_33		= ultra ? (inb(high_16 + 0x001f) & 1) : 0;
 	byte udma_66		= ((eighty_ninty_three(drive)) && udma_33) ? 1 : 0;
-	byte udma_100		= (((dev->device == PCI_DEVICE_ID_PROMISE_20265) || (dev->device == PCI_DEVICE_ID_PROMISE_20267) || (dev->device == PCI_DEVICE_ID_PROMISE_20268)) && udma_66) ? 1 : 0;
+	byte udma_100		= (((dev->device == PCI_DEVICE_ID_PROMISE_20265) || (dev->device == PCI_DEVICE_ID_PROMISE_20267)) && udma_66) ? 1 : 0;
 
 	/*
 	 * Set the control register to use the 66Mhz system
@@ -761,8 +757,7 @@
 
 	if ((dev->device == PCI_DEVICE_ID_PROMISE_20262) ||
 	    (dev->device == PCI_DEVICE_ID_PROMISE_20265) ||
-	    (dev->device == PCI_DEVICE_ID_PROMISE_20267) ||
-	    (dev->device == PCI_DEVICE_ID_PROMISE_20268)) {
+	    (dev->device == PCI_DEVICE_ID_PROMISE_20267)) {
 		/*
 		 * software reset -  this is required because the bios
 		 * will set UDMA timing on if the hdd supports it. The
@@ -788,7 +783,7 @@
 		byte irq = 0, irq2 = 0;
 		pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
 		pci_read_config_byte(dev, (PCI_INTERRUPT_LINE)|0x80, &irq2);	/* 0xbc */
-		if ((irq != irq2) && (dev->device != PCI_DEVICE_ID_PROMISE_20265) && (dev->device != PCI_DEVICE_ID_PROMISE_20267) && (dev->device != PCI_DEVICE_ID_PROMISE_20268)) {
+		if ((irq != irq2) && (dev->device != PCI_DEVICE_ID_PROMISE_20265) && (dev->device != PCI_DEVICE_ID_PROMISE_20267)) {
 			pci_write_config_byte(dev, (PCI_INTERRUPT_LINE)|0x80, irq);	/* 0xbc */
 			printk("%s: pci-config space interrupt mirror fixed.\n", name);
 		}
@@ -853,8 +848,7 @@
 
 	if ((hwif->pci_dev->device == PCI_DEVICE_ID_PROMISE_20262) ||
 	    (hwif->pci_dev->device == PCI_DEVICE_ID_PROMISE_20265) ||
-	    (hwif->pci_dev->device == PCI_DEVICE_ID_PROMISE_20267) ||
-	    (hwif->pci_dev->device == PCI_DEVICE_ID_PROMISE_20268)) {
+	    (hwif->pci_dev->device == PCI_DEVICE_ID_PROMISE_20267)) {
 		hwif->resetproc	= &pdc202xx_reset;
 	}
 
