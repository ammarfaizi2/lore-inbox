Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268486AbTBWPOf>; Sun, 23 Feb 2003 10:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268490AbTBWPMa>; Sun, 23 Feb 2003 10:12:30 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:10001 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268486AbTBWPKR>; Sun, 23 Feb 2003 10:10:17 -0500
To: LKML <linux-kernel@vger.kernel.org>
CC: Linus Torvalds <torvalds@transmeta.com>
From: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH] [4/6] Remove pci_{read,write}[bwl]
Message-Id: <20020223151804@raistlin.arm.linux.org.uk>
References: <20020223151803@raistlin.arm.linux.org.uk>
In-Reply-To: <20020223151803@raistlin.arm.linux.org.uk>
Date: Sun, 23 Feb 2003 15:20:25 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch appears not to be in 2.5.62, but applies cleanly.

Subject: [4/6] Remove pci_{read,write}[bwl]
cardbus.c uses its own names for our PCI config space functions.
Make it use our names.

 drivers/pcmcia/cardbus.c |   34 +++++++++++++++-------------------
 1 files changed, 15 insertions, 19 deletions

diff -ur -x sa11* -x Kconfig -x Makefile orig/drivers/pcmcia/cardbus.c linux/drivers/pcmcia/cardbus.c
--- orig/drivers/pcmcia/cardbus.c	Sun Feb 23 12:47:15 2003
+++ linux/drivers/pcmcia/cardbus.c	Sun Feb 23 12:43:55 2003
@@ -75,13 +75,6 @@
 
 #define FIND_FIRST_BIT(n)	((n) - ((n) & ((n)-1)))
 
-#define pci_readb		pci_read_config_byte
-#define pci_writeb		pci_write_config_byte
-#define pci_readw		pci_read_config_word
-#define pci_writew		pci_write_config_word
-#define pci_readl		pci_read_config_dword
-#define pci_writel		pci_write_config_dword
-
 /* Offsets in the Expansion ROM Image Header */
 #define ROM_SIGNATURE		0x0000	/* 2 bytes */
 #define ROM_DATA_PTR		0x0018	/* 2 bytes */
@@ -192,7 +185,7 @@
 		if (addr + len > 0x100)
 			goto fail;
 		for (; len; addr++, ptr++, len--)
-			pci_readb(dev, addr, (u_char *) ptr);
+			pci_read_config_byte(dev, addr, ptr);
 		return 0;
 	}
 
@@ -243,17 +236,18 @@
 	tmp.sysdata = bus->sysdata;
 	tmp.devfn = 0;
 
-	pci_readw(&tmp, PCI_VENDOR_ID, &vend);
-	pci_readw(&tmp, PCI_DEVICE_ID, &dev);
+	pci_read_config_word(&tmp, PCI_VENDOR_ID, &vend);
+	pci_read_config_word(&tmp, PCI_DEVICE_ID, &dev);
 	printk(KERN_INFO "cs: cb_alloc(bus %d): vendor 0x%04x, "
 	       "device 0x%04x\n", bus->number, vend, dev);
 
-	pci_readb(&tmp, PCI_HEADER_TYPE, &hdr);
+	pci_read_config_byte(&tmp, PCI_HEADER_TYPE, &hdr);
 	fn = 1;
 	if (hdr & 0x80) {
 		do {
 			tmp.devfn = fn;
-			if (pci_readw(&tmp, PCI_VENDOR_ID, &v) || !v || v == 0xffff)
+			if (pci_read_config_word(&tmp, PCI_VENDOR_ID, &v) ||
+			    !v || v == 0xffff)
 				break;
 			fn++;
 		} while (fn < 8);
@@ -278,7 +272,7 @@
 
 		dev->devfn = i;
 		dev->vendor = vend;
-		pci_readw(dev, PCI_DEVICE_ID, &dev->device);
+		pci_read_config_word(dev, PCI_DEVICE_ID, &dev->device);
 		dev->hdr_type = hdr & 0x7f;
 		dev->dma_mask = 0xffffffff;
 		dev->dev.dma_mask = &dev->dma_mask;
@@ -295,7 +289,7 @@
 		}
 
 		/* Does this function have an interrupt at all? */
-		pci_readb(dev, PCI_INTERRUPT_PIN, &irq_pin);
+		pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &irq_pin);
 		if (irq_pin)
 			dev->irq = irq;
 		
@@ -305,7 +299,7 @@
 			continue;
 
 		if (irq_pin)
-			pci_writeb(dev, PCI_INTERRUPT_LINE, irq);
+			pci_write_config_byte(dev, PCI_INTERRUPT_LINE, irq);
 		
 		device_register(&dev->dev);
 		pci_insert_device(dev, bus);
@@ -360,15 +354,17 @@
 	/* Set up PCI interrupt and command registers */
 	for (i = 0; i < s->functions; i++) {
 		dev = &s->cb_config[i].dev;
-		pci_writeb(dev, PCI_COMMAND, PCI_COMMAND_MASTER |
-			   PCI_COMMAND_IO | PCI_COMMAND_MEMORY);
-		pci_writeb(dev, PCI_CACHE_LINE_SIZE, L1_CACHE_BYTES / 4);
+		pci_write_config_byte(dev, PCI_COMMAND, PCI_COMMAND_MASTER |
+				      PCI_COMMAND_IO | PCI_COMMAND_MEMORY);
+		pci_write_config_byte(dev, PCI_CACHE_LINE_SIZE,
+				      L1_CACHE_BYTES / 4);
 	}
 
 	if (s->irq.AssignedIRQ) {
 		for (i = 0; i < s->functions; i++) {
 			dev = &s->cb_config[i].dev;
-			pci_writeb(dev, PCI_INTERRUPT_LINE, s->irq.AssignedIRQ);
+			pci_write_config_byte(dev, PCI_INTERRUPT_LINE,
+					      s->irq.AssignedIRQ);
 		}
 		s->socket.io_irq = s->irq.AssignedIRQ;
 		s->ss_entry->set_socket(s->sock, &s->socket);
