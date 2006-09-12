Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030245AbWILQGG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030245AbWILQGG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 12:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030254AbWILQGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 12:06:05 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:37832 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030245AbWILQGB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 12:06:01 -0400
Subject: [PATCH] quirks: Flag up and handle the AMD 8151 Errata #24
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: ak@suse.de, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 12 Sep 2006 17:29:00 +0100
Message-Id: <1158078540.6780.61.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

AMD states the following

"Some PCI cards generate peer-to-peer posted-write traffic targetting
the AGP bridge (from the PCI bus, through the graphics tunnel to the AGP
bus). The combination of such cards and some AGP cards can generate
traffic patters that result in a system deadlock."

As AMD don't say *which* video cards we need to flag this up to the
graphics capture devices that may be affected by this errata so that
they fall back to slower/safer methods. 

This only affects AGP although the rarity of PCI video cards on an AMD64
box means that the quick "treat like PCIPCI_FAIL" approach will be fine
for a starter in the capture card drivers.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc6-mm1/drivers/media/video/bt8xx/bttv-cards.c linux-2.6.18-rc6-mm1/drivers/media/video/bt8xx/bttv-cards.c
--- linux.vanilla-2.6.18-rc6-mm1/drivers/media/video/bt8xx/bttv-cards.c	2006-09-11 11:02:17.000000000 +0100
+++ linux-2.6.18-rc6-mm1/drivers/media/video/bt8xx/bttv-cards.c	2006-09-11 17:20:16.000000000 +0100
@@ -4993,6 +4993,8 @@
 
 	if (pci_pci_problems & PCIPCI_FAIL)
 		pcipci_fail = 1;
+	if (pci_pci_problems & PCIAGP_FAIL)
+		pcipci_fail = 1;	/* should check if target is AGP */
 	if (pci_pci_problems & (PCIPCI_TRITON|PCIPCI_NATOMA|PCIPCI_VIAETBF))
 		triton1 = 1;
 	if (pci_pci_problems & PCIPCI_VSFX)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc6-mm1/drivers/media/video/saa7134/saa7134-core.c linux-2.6.18-rc6-mm1/drivers/media/video/saa7134/saa7134-core.c
--- linux.vanilla-2.6.18-rc6-mm1/drivers/media/video/saa7134/saa7134-core.c	2006-09-11 11:02:17.000000000 +0100
+++ linux-2.6.18-rc6-mm1/drivers/media/video/saa7134/saa7134-core.c	2006-09-11 17:20:16.000000000 +0100
@@ -843,7 +843,7 @@
 			latency = 0x0A;
 		}
 #endif
-		if (pci_pci_problems & PCIPCI_FAIL) {
+		if (pci_pci_problems & (PCIPCI_FAIL|PCIAGP_FAIL)) {
 			printk(KERN_INFO "%s: quirk: this driver and your "
 					"chipset may not work together"
 					" in overlay mode.\n",dev->name);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc6-mm1/drivers/media/video/zoran_card.c linux-2.6.18-rc6-mm1/drivers/media/video/zoran_card.c
--- linux.vanilla-2.6.18-rc6-mm1/drivers/media/video/zoran_card.c	2006-09-11 17:00:12.000000000 +0100
+++ linux-2.6.18-rc6-mm1/drivers/media/video/zoran_card.c	2006-09-11 17:20:16.000000000 +0100
@@ -1620,7 +1620,7 @@
 	dprintk(5, KERN_DEBUG "Jotti is een held!\n");
 
 	/* some mainboards might not do PCI-PCI data transfer well */
-	if (pci_pci_problems & PCIPCI_FAIL) {
+	if (pci_pci_problems & (PCIPCI_FAIL|PCIAGP_FAIL)) {
 		dprintk(1,
 			KERN_WARNING
 			"%s: chipset may not support reliable PCI-PCI DMA\n",
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc6-mm1/drivers/pci/quirks.c linux-2.6.18-rc6-mm1/drivers/pci/quirks.c
--- linux.vanilla-2.6.18-rc6-mm1/drivers/pci/quirks.c	2006-09-11 17:00:17.000000000 +0100
+++ linux-2.6.18-rc6-mm1/drivers/pci/quirks.c	2006-09-11 17:20:16.000000000 +0100
@@ -93,8 +93,21 @@
 		pci_pci_problems |= PCIPCI_FAIL;
 	}
 }
+
+static void __devinit quirk_nopciamd(struct pci_dev *dev)
+{
+	u8 rev;
+	pci_read_config_byte(dev, 0x08, &rev);
+	if (rev == 0x13) {
+		/* Errata 24 */
+		printk(KERN_INFO "Disabling direct PCI/AGP transfers.\n");
+		pci_pci_problems |= PCIAGP_FAIL;
+	}
+}
+
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_5597,		quirk_nopcipci );
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_496,		quirk_nopcipci );
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_8151_0,	quirk_nopciamd );
 
 /*
  *	Triton requires workarounds to be used by the drivers
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc6-mm1/include/linux/pci.h linux-2.6.18-rc6-mm1/include/linux/pci.h
--- linux.vanilla-2.6.18-rc6-mm1/include/linux/pci.h	2006-09-11 17:00:24.000000000 +0100
+++ linux-2.6.18-rc6-mm1/include/linux/pci.h	2006-09-11 17:21:16.000000000 +0100
@@ -875,12 +875,13 @@
 void pci_fixup_device(enum pci_fixup_pass pass, struct pci_dev *dev);
 
 extern int pci_pci_problems;
-#define PCIPCI_FAIL		1
+#define PCIPCI_FAIL		1	/* No PCI PCI DMA */
 #define PCIPCI_TRITON		2
 #define PCIPCI_NATOMA		4
 #define PCIPCI_VIAETBF		8
 #define PCIPCI_VSFX		16
 #define PCIPCI_ALIMAGIK		32
+#define PCIAGP_FAIL		64	/* No PCI to AGP DMA */
 
 #endif /* __KERNEL__ */
 #endif /* LINUX_PCI_H */

