Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422628AbWJPPYs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422628AbWJPPYs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 11:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422626AbWJPPYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 11:24:48 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:36227 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1422628AbWJPPYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 11:24:47 -0400
Subject: [PATCH] pci: x86-32/64 switch to pci_get API
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, linux-kernel@vger.kernel.org, ak@muc.de
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 16 Oct 2006 16:51:32 +0100
Message-Id: <1161013892.24237.100.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use pci_get_bus_and_slot to find the router (and lock it for the kernel
lifetime), also use pci_get_device_reverse() to walk the list finding
calgary IOMMUs

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc1-mm1/arch/i386/pci/irq.c linux-2.6.19-rc1-mm1/arch/i386/pci/irq.c
--- linux.vanilla-2.6.19-rc1-mm1/arch/i386/pci/irq.c	2006-10-13 15:10:06.000000000 +0100
+++ linux-2.6.19-rc1-mm1/arch/i386/pci/irq.c	2006-10-13 17:14:40.000000000 +0100
@@ -758,7 +758,7 @@
 	DBG(KERN_DEBUG "PCI: Attempting to find IRQ router for %04x:%04x\n",
 	    rt->rtr_vendor, rt->rtr_device);
 
-	pirq_router_dev = pci_find_slot(rt->rtr_bus, rt->rtr_devfn);
+	pirq_router_dev = pci_get_bus_and_slot(rt->rtr_bus, rt->rtr_devfn);
 	if (!pirq_router_dev) {
 		DBG(KERN_DEBUG "PCI: Interrupt router not found at "
 			"%02x:%02x\n", rt->rtr_bus, rt->rtr_devfn);
@@ -778,6 +778,8 @@
 		pirq_router_dev->vendor,
 		pirq_router_dev->device,
 		pci_name(pirq_router_dev));
+		
+	/* The device remains referenced for the kernel lifetime */
 }
 
 static struct irq_info *pirq_get_info(struct pci_dev *dev)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc1-mm1/arch/x86_64/kernel/pci-calgary.c linux-2.6.19-rc1-mm1/arch/x86_64/kernel/pci-calgary.c
--- linux.vanilla-2.6.19-rc1-mm1/arch/x86_64/kernel/pci-calgary.c	2006-10-13 15:10:06.000000000 +0100
+++ linux-2.6.19-rc1-mm1/arch/x86_64/kernel/pci-calgary.c	2006-10-13 17:14:40.000000000 +0100
@@ -879,7 +879,7 @@
 
 error:
 	do {
-		dev = pci_find_device_reverse(PCI_VENDOR_ID_IBM,
+		dev = pci_get_device_reverse(PCI_VENDOR_ID_IBM,
 					      PCI_DEVICE_ID_IBM_CALGARY,
 					      dev);
 		if (!dev)

