Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264600AbUENXoK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264600AbUENXoK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 19:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264621AbUENXnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 19:43:23 -0400
Received: from mail.kroah.org ([65.200.24.183]:18917 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264600AbUENX3w convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 19:29:52 -0400
Subject: Re: [PATCH] I2C update for 2.6.6
In-Reply-To: <10845773582039@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 14 May 2004 16:29:18 -0700
Message-Id: <1084577358220@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1587.15.16, 2004/05/14 14:58:42-07:00, jdgaston@snoqualmie.dp.intel.com

[PATCH] I2C: ICH6/6300ESB i2c support

This patch adds DID support for ICH6 and 6300ESB to i2c-i801.c(SMBus).
In order to add this support I needed to patch pci_ids.h with the SMBus
DID's.  To keep things orginized I renumbered the ICH6 and ESB entries
in pci_ids.h.  I then patched the piix IDE and i810 audio drivers to
reflect the updated #define's.  I also removed an error from irq.c;
there was a reference to a 6300ESB DID that does not exist.


 arch/i386/pci/irq.c           |    3 ++-
 drivers/i2c/busses/Kconfig    |    2 ++
 drivers/i2c/busses/i2c-i801.c |   26 ++++++++++++++++++++------
 drivers/ide/pci/piix.c        |    8 ++++----
 drivers/ide/pci/piix.h        |    2 +-
 include/linux/pci_ids.h       |   21 ++++++++++++++++++---
 sound/oss/i810_audio.c        |   10 +++++-----
 7 files changed, 52 insertions(+), 20 deletions(-)


diff -Nru a/arch/i386/pci/irq.c b/arch/i386/pci/irq.c
--- a/arch/i386/pci/irq.c	Fri May 14 16:18:51 2004
+++ b/arch/i386/pci/irq.c	Fri May 14 16:18:51 2004
@@ -479,8 +479,9 @@
 		case PCI_DEVICE_ID_INTEL_82801DB_0:
 		case PCI_DEVICE_ID_INTEL_82801E_0:
 		case PCI_DEVICE_ID_INTEL_82801EB_0:
-		case PCI_DEVICE_ID_INTEL_ESB_0:
+		case PCI_DEVICE_ID_INTEL_ESB_1:
 		case PCI_DEVICE_ID_INTEL_ICH6_0:
+		case PCI_DEVICE_ID_INTEL_ICH6_1:
 			r->name = "PIIX/ICH";
 			r->get = pirq_piix_get;
 			r->set = pirq_piix_set;
diff -Nru a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
--- a/drivers/i2c/busses/Kconfig	Fri May 14 16:18:51 2004
+++ b/drivers/i2c/busses/Kconfig	Fri May 14 16:18:51 2004
@@ -95,6 +95,8 @@
 	    82801CA/CAM
 	    82801DB
 	    82801EB
+	    6300ESB
+	    ICH6
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-i801.
diff -Nru a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
--- a/drivers/i2c/busses/i2c-i801.c	Fri May 14 16:18:51 2004
+++ b/drivers/i2c/busses/i2c-i801.c	Fri May 14 16:18:51 2004
@@ -28,7 +28,8 @@
     82801CA/CAM		2483           
     82801DB		24C3   (HW PEC supported, 32 byte buffer not supported)
     82801EB		24D3   (HW PEC supported, 32 byte buffer not supported)
-
+    6300ESB		25A4
+    ICH6		266A
     This driver supports several versions of Intel's I/O Controller Hubs (ICH).
     For SMBus support, they are similar to the PIIX4 and are part
     of Intel's '810' and other chipsets.
@@ -121,7 +122,8 @@
 
 	I801_dev = dev;
 	if ((dev->device == PCI_DEVICE_ID_INTEL_82801DB_3) ||
-	    (dev->device == PCI_DEVICE_ID_INTEL_82801EB_3))
+	    (dev->device == PCI_DEVICE_ID_INTEL_82801EB_3) ||
+	    (dev->device == PCI_DEVICE_ID_INTEL_ESB_4))
 		isich4 = 1;
 	else
 		isich4 = 0;
@@ -576,10 +578,22 @@
 		.subdevice =	PCI_ANY_ID,
 	},
 	{
-		.vendor =   PCI_VENDOR_ID_INTEL,
-		.device =   PCI_DEVICE_ID_INTEL_82801EB_3,
-		.subvendor =    PCI_ANY_ID,
-		.subdevice =    PCI_ANY_ID,
+		.vendor =	PCI_VENDOR_ID_INTEL,
+		.device =	PCI_DEVICE_ID_INTEL_82801EB_3,
+		.subvendor =	PCI_ANY_ID,
+		.subdevice =	PCI_ANY_ID,
+	},
+	{
+		.vendor =	PCI_VENDOR_ID_INTEL,
+		.device =	PCI_DEVICE_ID_INTEL_ESB_4,
+		.subvendor =	PCI_ANY_ID,
+		.subdevice = 	PCI_ANY_ID,
+	},
+	{
+		.vendor =	PCI_VENDOR_ID_INTEL,
+		.device =	PCI_DEVICE_ID_INTEL_ICH6_16,
+		.subvendor =	PCI_ANY_ID,
+		.subdevice =	PCI_ANY_ID,
 	},
 	{ 0, }
 };
diff -Nru a/drivers/ide/pci/piix.c b/drivers/ide/pci/piix.c
--- a/drivers/ide/pci/piix.c	Fri May 14 16:18:51 2004
+++ b/drivers/ide/pci/piix.c	Fri May 14 16:18:51 2004
@@ -153,7 +153,7 @@
 			case PCI_DEVICE_ID_INTEL_82801EB_11:
 			case PCI_DEVICE_ID_INTEL_82801E_11:
 			case PCI_DEVICE_ID_INTEL_ESB_2:
-			case PCI_DEVICE_ID_INTEL_ICH6_2:
+			case PCI_DEVICE_ID_INTEL_ICH6_19:
 				p += sprintf(p, "PIIX4 Ultra 100 ");
 				break;
 			case PCI_DEVICE_ID_INTEL_82372FB_1:
@@ -292,7 +292,7 @@
 		case PCI_DEVICE_ID_INTEL_82801DB_11:
 		case PCI_DEVICE_ID_INTEL_82801EB_11:
 		case PCI_DEVICE_ID_INTEL_ESB_2:
-		case PCI_DEVICE_ID_INTEL_ICH6_2:
+		case PCI_DEVICE_ID_INTEL_ICH6_19:
 			mode = 3;
 			break;
 		/* UDMA 66 capable */
@@ -627,7 +627,7 @@
 		case PCI_DEVICE_ID_INTEL_82801EB_11:
 		case PCI_DEVICE_ID_INTEL_82801E_11:
 		case PCI_DEVICE_ID_INTEL_ESB_2:
-		case PCI_DEVICE_ID_INTEL_ICH6_2:
+		case PCI_DEVICE_ID_INTEL_ICH6_19:
 		{
 			unsigned int extra = 0;
 			pci_read_config_dword(dev, 0x54, &extra);
@@ -804,7 +804,7 @@
  	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801EB_1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 18},
 #endif /* !CONFIG_SCSI_SATA */
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ESB_2, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 19},
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_2, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 20},
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_19, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 20},
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, piix_pci_tbl);
diff -Nru a/drivers/ide/pci/piix.h b/drivers/ide/pci/piix.h
--- a/drivers/ide/pci/piix.h	Fri May 14 16:18:51 2004
+++ b/drivers/ide/pci/piix.h	Fri May 14 16:18:51 2004
@@ -70,7 +70,7 @@
 	/* 17 */ DECLARE_PIIX_DEV(PCI_DEVICE_ID_INTEL_82801DB_10, "ICH4"),
 	/* 18 */ DECLARE_PIIX_DEV(PCI_DEVICE_ID_INTEL_82801EB_1,  "ICH5-SATA"),
 	/* 19 */ DECLARE_PIIX_DEV(PCI_DEVICE_ID_INTEL_ESB_2,      "ICH5"),
-	/* 20 */ DECLARE_PIIX_DEV(PCI_DEVICE_ID_INTEL_ICH6_2,     "ICH6"),
+	/* 20 */ DECLARE_PIIX_DEV(PCI_DEVICE_ID_INTEL_ICH6_19,     "ICH6"),
 	{
 		.vendor		= 0,
 		.device		= 0,
diff -Nru a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h	Fri May 14 16:18:51 2004
+++ b/include/linux/pci_ids.h	Fri May 14 16:18:51 2004
@@ -2058,7 +2058,6 @@
 #define PCI_DEVICE_ID_INTEL_82801EB_7	0x24d7
 #define PCI_DEVICE_ID_INTEL_82801EB_11	0x24db
 #define PCI_DEVICE_ID_INTEL_82801EB_13	0x24dd
-#define PCI_DEVICE_ID_INTEL_ESB_0	0x25a0
 #define PCI_DEVICE_ID_INTEL_ESB_1	0x25a1
 #define PCI_DEVICE_ID_INTEL_ESB_2	0x25a2
 #define PCI_DEVICE_ID_INTEL_ESB_3	0x25a3
@@ -2084,8 +2083,24 @@
 #define PCI_DEVICE_ID_INTEL_82875_IG	0x257b
 #define PCI_DEVICE_ID_INTEL_ICH6_0	0x2640
 #define PCI_DEVICE_ID_INTEL_ICH6_1	0x2641
-#define PCI_DEVICE_ID_INTEL_ICH6_2	0x266f
-#define PCI_DEVICE_ID_INTEL_ICH6_3	0x266e
+#define PCI_DEVICE_ID_INTEL_ICH6_2	0x2642
+#define PCI_DEVICE_ID_INTEL_ICH6_3	0x2651
+#define PCI_DEVICE_ID_INTEL_ICH6_4	0x2652
+#define PCI_DEVICE_ID_INTEL_ICH6_5	0x2653
+#define PCI_DEVICE_ID_INTEL_ICH6_6	0x2658
+#define PCI_DEVICE_ID_INTEL_ICH6_7	0x2659
+#define PCI_DEVICE_ID_INTEL_ICH6_8	0x265a
+#define PCI_DEVICE_ID_INTEL_ICH6_9	0x265b
+#define PCI_DEVICE_ID_INTEL_ICH6_10	0x265c
+#define PCI_DEVICE_ID_INTEL_ICH6_11	0x2660
+#define PCI_DEVICE_ID_INTEL_ICH6_12	0x2662
+#define PCI_DEVICE_ID_INTEL_ICH6_13	0x2664
+#define PCI_DEVICE_ID_INTEL_ICH6_14	0x2666
+#define PCI_DEVICE_ID_INTEL_ICH6_15	0x2668
+#define PCI_DEVICE_ID_INTEL_ICH6_16	0x266a
+#define PCI_DEVICE_ID_INTEL_ICH6_17	0x266d
+#define PCI_DEVICE_ID_INTEL_ICH6_18	0x266e
+#define PCI_DEVICE_ID_INTEL_ICH6_19	0x266f
 #define PCI_DEVICE_ID_INTEL_82855PM_HB	0x3340
 #define PCI_DEVICE_ID_INTEL_82830_HB	0x3575
 #define PCI_DEVICE_ID_INTEL_82830_CGC	0x3577
diff -Nru a/sound/oss/i810_audio.c b/sound/oss/i810_audio.c
--- a/sound/oss/i810_audio.c	Fri May 14 16:18:51 2004
+++ b/sound/oss/i810_audio.c	Fri May 14 16:18:51 2004
@@ -120,8 +120,8 @@
 #ifndef PCI_DEVICE_ID_INTEL_ICH5
 #define PCI_DEVICE_ID_INTEL_ICH5	0x24d5
 #endif
-#ifndef PCI_DEVICE_ID_INTEL_ICH6_3
-#define PCI_DEVICE_ID_INTEL_ICH6_3	0x266e
+#ifndef PCI_DEVICE_ID_INTEL_ICH6_18
+#define PCI_DEVICE_ID_INTEL_ICH6_18	0x266e
 #endif
 #ifndef PCI_DEVICE_ID_INTEL_440MX
 #define PCI_DEVICE_ID_INTEL_440MX	0x7195
@@ -351,7 +351,7 @@
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, AMD8111},
 	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ESB_5,
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, INTELICH4},
-	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_3,
+	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_18,
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, INTELICH4},
 
 	{0,}
@@ -2797,7 +2797,7 @@
 	/* see i810_ac97_init for the next 7 lines (jsaw) */
 	inw(card->ac97base);
 	if ((card->pci_id == PCI_DEVICE_ID_INTEL_ICH4 || card->pci_id == PCI_DEVICE_ID_INTEL_ICH5 ||
-	     card->pci_id == PCI_DEVICE_ID_INTEL_ESB_5 || card->pci_id == PCI_DEVICE_ID_INTEL_ICH6_3)
+	     card->pci_id == PCI_DEVICE_ID_INTEL_ESB_5 || card->pci_id == PCI_DEVICE_ID_INTEL_ICH6_18)
 	    && (card->use_mmio)) {
 		primary_codec_id = (int) readl(card->iobase_mmio + SDM) & 0x3;
 		printk(KERN_INFO "i810_audio: Primary codec has ID %d\n",
@@ -2868,7 +2868,7 @@
 		   last codec ID spoken to. 
 		*/
 		if ((card->pci_id == PCI_DEVICE_ID_INTEL_ICH4 || card->pci_id == PCI_DEVICE_ID_INTEL_ICH5 ||
-		     card->pci_id == PCI_DEVICE_ID_INTEL_ESB_5 || card->pci_id == PCI_DEVICE_ID_INTEL_ICH6_3)
+		     card->pci_id == PCI_DEVICE_ID_INTEL_ESB_5 || card->pci_id == PCI_DEVICE_ID_INTEL_ICH6_18)
 		    && (card->use_mmio)) {
 			ac97_id = (int) readl(card->iobase_mmio + SDM) & 0x3;
 			printk(KERN_INFO "i810_audio: Connection %d with codec id %d\n",

