Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261883AbTCTUBA>; Thu, 20 Mar 2003 15:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261885AbTCTUA7>; Thu, 20 Mar 2003 15:00:59 -0500
Received: from air-2.osdl.org ([65.172.181.6]:16820 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261883AbTCTUA6>;
	Thu, 20 Mar 2003 15:00:58 -0500
Date: Thu, 20 Mar 2003 12:08:33 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: linux-kernel@vger.kernel.org, linux-sh@m17n.org
Cc: gniibe@m17n.org, kkojima@rr.iij4u.or.jp
Subject: [PATCH] reduce stack usage in arch/sh/kernel/pci-sh7751
Message-Id: <20030320120833.2ddbfcc1.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This has already been done for arch/i386 and arch/x86_64 (same function
as is patched here).  Please apply to 2.5.65.

Thanks,
--
~Randy


patch_name:	sh-pci-dev-stack.patch
patch_version:	2003-03-20.11:47:35
author:		Randy.Dunlap <rddunlap@osdl.org>
description:	reduce stack usage in
		arch/sh/kernel/pci-sh7751::pcibios_fixup_peer_bridges()
product:	Linux
product_versions: 2.5.65
changelog:	change pci_dev and pci_bus data to pointers & kmalloc() them;
		same patch as already applied to i386 and x86_64;
maintainer:	Niibe Yutaka: gniibe@m17n.org,
		Kazumoto Kojima: kkojima@rr.iij4u.or.jp
		(list: linux-sh@m17n.org)
diffstat:	=
 arch/sh/kernel/pci-sh7751.c |   27 +++++++++++++++++++--------
 1 files changed, 19 insertions(+), 8 deletions(-)


diff -Naur ./arch/sh/kernel/pci-sh7751.c%SHSTK ./arch/sh/kernel/pci-sh7751.c
--- ./arch/sh/kernel/pci-sh7751.c%SHSTK	Mon Mar 17 13:44:19 2003
+++ ./arch/sh/kernel/pci-sh7751.c	Thu Mar 20 11:46:08 2003
@@ -199,28 +199,39 @@
 static void __init pcibios_fixup_peer_bridges(void)
 {
 	int n;
-	struct pci_bus bus;
-	struct pci_dev dev;
+	struct pci_bus *bus;
+	struct pci_dev *dev;
 	u16 l;
 
 	if (pcibios_last_bus <= 0 || pcibios_last_bus >= 0xff)
 		return;
 	PCIDBG(2,"PCI: Peer bridge fixup\n");
+
+	bus = kmalloc(sizeof(*bus), GFP_ATOMIC);
+	dev = kmalloc(sizeof(*dev), GFP_ATOMIC);
+	if (!bus || !dev) {
+		printk(KERN_ERR "Out of memory in %s\n", __FUNCTION__);
+		goto exit;
+	}
+
 	for (n=0; n <= pcibios_last_bus; n++) {
 		if (pci_bus_exists(&pci_root_buses, n))
 			continue;
-		bus.number = n;
-		bus.ops = pci_root_ops;
-		dev.bus = &bus;
-		for(dev.devfn=0; dev.devfn<256; dev.devfn += 8)
-			if (!pci_read_config_word(&dev, PCI_VENDOR_ID, &l) &&
+		bus->number = n;
+		bus->ops = pci_root_ops;
+		dev->bus = bus;
+		for(dev->devfn=0; dev->devfn<256; dev->devfn += 8)
+			if (!pci_read_config_word(dev, PCI_VENDOR_ID, &l) &&
 			    l != 0x0000 && l != 0xffff) {
-				PCIDBG(3,"Found device at %02x:%02x [%04x]\n", n, dev.devfn, l);
+				PCIDBG(3,"Found device at %02x:%02x [%04x]\n", n, dev->devfn, l);
 				printk(KERN_INFO "PCI: Discovered peer bus %02x\n", n);
 				pci_scan_bus(n, pci_root_ops, NULL);
 				break;
 			}
 	}
+exit:
+	kfree(dev);
+	kfree(bus);
 }
 
 
