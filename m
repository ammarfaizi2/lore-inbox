Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268485AbTBWPOe>; Sun, 23 Feb 2003 10:14:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268486AbTBWPMk>; Sun, 23 Feb 2003 10:12:40 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:10769 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268485AbTBWPKT>; Sun, 23 Feb 2003 10:10:19 -0500
To: LKML <linux-kernel@vger.kernel.org>
CC: Linus Torvalds <torvalds@transmeta.com>
From: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH] [5/6] Remove stack allocation of struct pci_dev
Message-Id: <20020223151805@raistlin.arm.linux.org.uk>
References: <20020223151804@raistlin.arm.linux.org.uk>
In-Reply-To: <20020223151804@raistlin.arm.linux.org.uk>
Date: Sun, 23 Feb 2003 15:20:26 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch appears not to be in 2.5.62, but applies cleanly.

Subject: [5/6] Remove stack allocation of struct pci_dev
cb_alloc() allocated a pci_dev on the stack to access PCI space.  This
is unnecessary since we have pci_bus_*_config_* functions.  Use these
functions instead.

 drivers/pcmcia/cardbus.c |   14 ++++----------
 1 files changed, 4 insertions, 10 deletions

diff -ur -x sa11* -x Kconfig -x Makefile orig/drivers/pcmcia/cardbus.c linux/drivers/pcmcia/cardbus.c
--- orig/drivers/pcmcia/cardbus.c	Sun Feb 23 13:56:32 2003
+++ linux/drivers/pcmcia/cardbus.c	Sun Feb 23 14:04:29 2003
@@ -224,29 +224,23 @@
 int cb_alloc(socket_info_t * s)
 {
 	struct pci_bus *bus;
-	struct pci_dev tmp;
 	u_short vend, v, dev;
 	u_char i, hdr, fn;
 	cb_config_t *c;
 	int irq;
 
 	bus = s->cap.cb_dev->subordinate;
-	memset(&tmp, 0, sizeof(tmp));
-	tmp.bus = bus;
-	tmp.sysdata = bus->sysdata;
-	tmp.devfn = 0;
 
-	pci_read_config_word(&tmp, PCI_VENDOR_ID, &vend);
-	pci_read_config_word(&tmp, PCI_DEVICE_ID, &dev);
+	pci_bus_read_config_word(bus, 0, PCI_VENDOR_ID, &vend);
+	pci_bus_read_config_word(bus, 0, PCI_DEVICE_ID, &dev);
 	printk(KERN_INFO "cs: cb_alloc(bus %d): vendor 0x%04x, "
 	       "device 0x%04x\n", bus->number, vend, dev);
 
-	pci_read_config_byte(&tmp, PCI_HEADER_TYPE, &hdr);
+	pci_bus_read_config_byte(bus, 0, PCI_HEADER_TYPE, &hdr);
 	fn = 1;
 	if (hdr & 0x80) {
 		do {
-			tmp.devfn = fn;
-			if (pci_read_config_word(&tmp, PCI_VENDOR_ID, &v) ||
+			if (pci_bus_read_config_word(bus, fn, PCI_VENDOR_ID, &v) ||
 			    !v || v == 0xffff)
 				break;
 			fn++;
