Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266552AbSKLMeh>; Tue, 12 Nov 2002 07:34:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266545AbSKLMde>; Tue, 12 Nov 2002 07:33:34 -0500
Received: from holomorphy.com ([66.224.33.161]:48826 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266546AbSKLMd0>;
	Tue, 12 Nov 2002 07:33:26 -0500
To: linux-kernel@vger.kernel.org
Subject: [4/4] NUMA-Q: remove last traces of bus number mangling
Message-Id: <E18BaIc-0006a0-00@holomorphy>
From: William Lee Irwin III <wli@holomorphy.com>
Date: Tue, 12 Nov 2002 04:37:46 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This removes the last vestiges of the bus number mangling and passes the
local bus numbers directly to the low-level PCI config cycle routines.

 numa.c |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)


diff -urpN pci-2.5.47-3/arch/i386/pci/numa.c pci-2.5.47-4/arch/i386/pci/numa.c
--- pci-2.5.47-3/arch/i386/pci/numa.c	2002-11-12 03:25:35.000000000 -0800
+++ pci-2.5.47-4/arch/i386/pci/numa.c	2002-11-12 03:32:13.000000000 -0800
@@ -10,8 +10,11 @@
 #define BUS2LOCAL(global) (mp_bus_id_to_local[global])
 #define QUADLOCAL2BUS(quad,local) (quad_local_to_mp_bus_id[quad][local])
 
+#define __PCI_CONF1_MQ_ADDRESS(bus, dev, fn, reg) \
+	(0x80000000 | (bus << 16) | (dev << 11) | (fn << 8) | (reg & ~3))
+
 #define PCI_CONF1_MQ_ADDRESS(bus, dev, fn, reg) \
-	(0x80000000 | (BUS2LOCAL(bus) << 16) | (dev << 11) | (fn << 8) | (reg & ~3))
+	__PCI_CONF1_MQ_ADDRESS(BUS2LOCAL(bus), dev, fn, reg)
 
 static int bus2quad(struct pci_bus *bus)
 {
@@ -27,7 +30,7 @@ static int __pci_conf1_mq_read (int seg,
 
 	spin_lock_irqsave(&pci_config_lock, flags);
 
-	outl_quad(PCI_CONF1_MQ_ADDRESS(bus, dev, fn, reg), 0xCF8, seg);
+	outl_quad(__PCI_CONF1_MQ_ADDRESS(bus, dev, fn, reg), 0xCF8, seg);
 
 	switch (len) {
 	case 1:
@@ -55,7 +58,7 @@ static int __pci_conf1_mq_write (int seg
 
 	spin_lock_irqsave(&pci_config_lock, flags);
 
-	outl_quad(PCI_CONF1_MQ_ADDRESS(bus, dev, fn, reg), 0xCF8, seg);
+	outl_quad(__PCI_CONF1_MQ_ADDRESS(bus, dev, fn, reg), 0xCF8, seg);
 
 	switch (len) {
 	case 1:
@@ -111,9 +114,9 @@ static void __devinit pci_fixup_i450nx(s
 		pci_read_config_byte(d, reg++, &subb);
 		DBG("i450NX PXB %d: %02x/%02x/%02x\n", pxb, busno, suba, subb);
 		if (busno)
-			pci_scan_bus(QUADLOCAL2BUS(quad,busno), pci_root_ops, (void *)quad);	/* Bus A */
+			pci_scan_bus(busno, pci_root_ops, (void *)quad);	/* Bus A */
 		if (suba < subb)
-			pci_scan_bus(QUADLOCAL2BUS(quad,suba+1), pci_root_ops, (void *)quad);	/* Bus B */
+			pci_scan_bus(suba+1, pci_root_ops, (void *)quad);	/* Bus B */
 	}
 	pcibios_last_bus = -1;
 }
@@ -134,10 +137,8 @@ static int __init pci_numa_init(void)
 	pci_root_bus = pcibios_scan_root(0);
 	if (clustered_apic_mode && (numnodes > 1)) {
 		for (quad = 1; quad < numnodes; ++quad) {
-			printk("Scanning PCI bus %d for quad %d\n", 
-				QUADLOCAL2BUS(quad,0), quad);
-			pci_scan_bus(QUADLOCAL2BUS(quad,0), 
-				pci_root_ops, (void *)quad);
+			printk("Scanning PCI bus %d for quad %d\n", 0, quad);
+			pci_scan_bus(0, pci_root_ops, (void *)quad);
 		}
 	}
 	return 0;
