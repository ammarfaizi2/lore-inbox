Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266553AbSKLMeh>; Tue, 12 Nov 2002 07:34:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266546AbSKLMdg>; Tue, 12 Nov 2002 07:33:36 -0500
Received: from holomorphy.com ([66.224.33.161]:49082 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266548AbSKLMd0>;
	Tue, 12 Nov 2002 07:33:26 -0500
To: linux-kernel@vger.kernel.org
Subject: [2/4] NUMA-Q: fetch quad numbers from struct pci_bus
Message-Id: <E18BaIc-0006Zw-00@holomorphy>
From: William Lee Irwin III <wli@holomorphy.com>
Date: Tue, 12 Nov 2002 04:37:46 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This introduces bus2quad() and uses it for bus conversions where it's
possible to do so right away.

 numa.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)


diff -urpN pci-2.5.47-1/arch/i386/pci/numa.c pci-2.5.47-2/arch/i386/pci/numa.c
--- pci-2.5.47-1/arch/i386/pci/numa.c	2002-11-12 03:12:01.000000000 -0800
+++ pci-2.5.47-2/arch/i386/pci/numa.c	2002-11-12 03:22:17.000000000 -0800
@@ -13,6 +13,11 @@
 #define PCI_CONF1_MQ_ADDRESS(bus, dev, fn, reg) \
 	(0x80000000 | (BUS2LOCAL(bus) << 16) | (dev << 11) | (fn << 8) | (reg & ~3))
 
+static int bus2quad(struct pci_bus *bus)
+{
+	return (int)bus->sysdata;
+}
+
 static int __pci_conf1_mq_read (int seg, int bus, int dev, int fn, int reg, int len, u32 *value)
 {
 	unsigned long flags;
@@ -73,13 +78,13 @@ static int __pci_conf1_mq_write (int seg
 
 static int pci_conf1_mq_read(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *value)
 {
-	return __pci_conf1_mq_read(0, bus->number, PCI_SLOT(devfn), 
+	return __pci_conf1_mq_read(bus2quad(bus), bus->number, PCI_SLOT(devfn), 
 		PCI_FUNC(devfn), where, size, value);
 }
 
 static int pci_conf1_mq_write(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 value)
 {
-	return __pci_conf1_mq_write(0, bus->number, PCI_SLOT(devfn), 
+	return __pci_conf1_mq_write(bus2quad(bus), bus->number, PCI_SLOT(devfn), 
 		PCI_FUNC(devfn), where, size, value);
 }
 
@@ -96,7 +101,7 @@ static void __devinit pci_fixup_i450nx(s
 	 */
 	int pxb, reg;
 	u8 busno, suba, subb;
-	int quad = BUS2QUAD(d->bus->number);
+	int quad = bus2quad(d->bus);
 
 	printk("PCI: Searching for i450NX host bridges on %s\n", d->slot_name);
 	reg = 0xd0;
