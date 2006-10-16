Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932123AbWJPPWG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbWJPPWG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 11:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbWJPPWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 11:22:06 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:33155 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932123AbWJPPWD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 11:22:03 -0400
Subject: [PATCH] alpha - switch to pci_get API
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 16 Oct 2006 16:48:51 +0100
Message-Id: <1161013732.24237.95.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have pci_get_bus_and_slot we can do the job correctly. Note
that some of these calls intentionally leak a device - this is because
the device in question is always needed from boot to reboot.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc1-mm1/arch/alpha/kernel/pci.c linux-2.6.19-rc1-mm1/arch/alpha/kernel/pci.c
--- linux.vanilla-2.6.19-rc1-mm1/arch/alpha/kernel/pci.c	2006-10-13 15:06:13.000000000 +0100
+++ linux-2.6.19-rc1-mm1/arch/alpha/kernel/pci.c	2006-10-13 17:14:23.000000000 +0100
@@ -516,10 +516,11 @@
 		if (bus == 0 && dfn == 0) {
 			hose = pci_isa_hose;
 		} else {
-			dev = pci_find_slot(bus, dfn);
+			dev = pci_get_bus_and_slot(bus, dfn);
 			if (!dev)
 				return -ENODEV;
 			hose = dev->sysdata;
+			pci_dev_put(dev);
 		}
 	}
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc1-mm1/arch/alpha/kernel/sys_miata.c linux-2.6.19-rc1-mm1/arch/alpha/kernel/sys_miata.c
--- linux.vanilla-2.6.19-rc1-mm1/arch/alpha/kernel/sys_miata.c	2006-10-13 15:10:06.000000000 +0100
+++ linux-2.6.19-rc1-mm1/arch/alpha/kernel/sys_miata.c	2006-10-13 17:14:23.000000000 +0100
@@ -183,11 +183,15 @@
 
 	if((slot == 7) && (PCI_FUNC(dev->devfn) == 3)) {
 		u8 irq=0;
-
-		if(pci_read_config_byte(pci_find_slot(dev->bus->number, dev->devfn & ~(7)), 0x40,&irq)!=PCIBIOS_SUCCESSFUL)
+		struct pci_dev *pdev = pci_get_slot(dev->bus, dev->devfn & ~7);
+		if(pdev == NULL || pci_read_config_byte(pdev, 0x40,&irq) != PCIBIOS_SUCCESSFUL) {
+			pci_dev_put(pdev);
 			return -1;
-		else	
+		}
+		else	{
+			pci_dev_put(pdev);
 			return irq;
+		}
 	}
 
 	return COMMON_TABLE_LOOKUP;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc1-mm1/arch/alpha/kernel/sys_nautilus.c linux-2.6.19-rc1-mm1/arch/alpha/kernel/sys_nautilus.c
--- linux.vanilla-2.6.19-rc1-mm1/arch/alpha/kernel/sys_nautilus.c	2006-10-13 15:10:06.000000000 +0100
+++ linux-2.6.19-rc1-mm1/arch/alpha/kernel/sys_nautilus.c	2006-10-13 17:14:23.000000000 +0100
@@ -200,7 +200,7 @@
 	bus = pci_scan_bus(0, alpha_mv.pci_ops, hose);
 	hose->bus = bus;
 
-	irongate = pci_find_slot(0, 0);
+	irongate = pci_get_bus_and_slot(0, 0);
 	bus->self = irongate;
 	bus->resource[1] = &irongate_mem;
 

