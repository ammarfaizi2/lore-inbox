Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262593AbVBCDaj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262593AbVBCDaj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 22:30:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262672AbVBCDaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 22:30:39 -0500
Received: from 207-105-1-25.zarak.com ([207.105.1.25]:58916 "HELO
	iceberg.Adtech-Inc.COM") by vger.kernel.org with SMTP
	id S262795AbVBCDaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 22:30:08 -0500
Message-ID: <42019A76.8050404@spirentcom.com>
Date: Wed, 02 Feb 2005 19:28:54 -0800
From: "Mark F. Haigh" <Mark.Haigh@spirentcom.com>
User-Agent: Mozilla Thunderbird  (X11/20041216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: marcelo.tosatti@cyclades.com
CC: linux-kernel@vger.kernel.org
Subject: [PATCH 2.4.29] arch/i386/kernel/pci-irq.c - Remove redundant check
Content-Type: multipart/mixed;
 boundary="------------000707080002090802030609"
X-OriginalArrivalTime: 03 Feb 2005 03:30:05.0430 (UTC) FILETIME=[A7303960:01C509A0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000707080002090802030609
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

In arch/i386/kernel/pci-irq.c:pcibios_enable_irq(), there is a redundant 
check:

     if (pin && !pcibios_lookup_irq(dev, 1) && !dev->irq) {

	/* ... */

         if (pin) {


We don't need the second 'if (pin)', as we already know it's nonzero 
from the first check.  Also note that this fixes the following warning 
(which happens because gcc's isn't always perfect with determining 
whether a variable is used uninitialized):

pci-irq.c: In function `pcibios_enable_irq':
pci-irq.c:1128: warning: 'msg' might be used uninitialized in this function

All the patch does is remove the duplicate check and shift everything 
else over.


Mark F. Haigh
Mark.Haigh@spirentcom.com

--------------000707080002090802030609
Content-Type: text/plain;
 name="patch-i386-pci-irq"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-i386-pci-irq"

--- arch/i386/kernel/pci-irq.c.orig	2005-02-02 18:33:56.694474944 -0800
+++ arch/i386/kernel/pci-irq.c	2005-02-02 18:58:18.828196832 -0800
@@ -1134,36 +1134,34 @@
 		if (io_apic_assign_pci_irqs) {
 			int irq;
 
-			if (pin) {
-				pin--;		/* interrupt pins are numbered starting from 1 */
-				irq = IO_APIC_get_PCI_irq_vector(dev->bus->number, PCI_SLOT(dev->devfn), pin);
-				/*
-				 * Busses behind bridges are typically not listed in the MP-table.
-				 * In this case we have to look up the IRQ based on the parent bus,
-				 * parent slot, and pin number. The SMP code detects such bridged
-				 * busses itself so we should get into this branch reliably.
-				 */
-				temp_dev = dev;
-				while (irq < 0 && dev->bus->parent) { /* go back to the bridge */
-					struct pci_dev * bridge = dev->bus->self;
+			pin--;		/* interrupt pins are numbered starting from 1 */
+			irq = IO_APIC_get_PCI_irq_vector(dev->bus->number, PCI_SLOT(dev->devfn), pin);
+			/*
+			 * Busses behind bridges are typically not listed in the MP-table.
+			 * In this case we have to look up the IRQ based on the parent bus,
+			 * parent slot, and pin number. The SMP code detects such bridged
+			 * busses itself so we should get into this branch reliably.
+			 */
+			temp_dev = dev;
+			while (irq < 0 && dev->bus->parent) { /* go back to the bridge */
+				struct pci_dev * bridge = dev->bus->self;
 
-					pin = (pin + PCI_SLOT(dev->devfn)) % 4;
-					irq = IO_APIC_get_PCI_irq_vector(bridge->bus->number, 
-							PCI_SLOT(bridge->devfn), pin);
-					if (irq >= 0)
-						printk(KERN_WARNING "PCI: using PPB(B%d,I%d,P%d) to get irq %d\n", 
-							bridge->bus->number, PCI_SLOT(bridge->devfn), pin, irq);
-					dev = bridge;
-				}
-				dev = temp_dev;
-				if (irq >= 0) {
-					printk(KERN_INFO "PCI->APIC IRQ transform: (B%d,I%d,P%d) -> %d\n",
-						dev->bus->number, PCI_SLOT(dev->devfn), pin, irq);
-					dev->irq = irq;
-					return;
-				} else
-					msg = " Probably buggy MP table.";
+				pin = (pin + PCI_SLOT(dev->devfn)) % 4;
+				irq = IO_APIC_get_PCI_irq_vector(bridge->bus->number, 
+						PCI_SLOT(bridge->devfn), pin);
+				if (irq >= 0)
+					printk(KERN_WARNING "PCI: using PPB(B%d,I%d,P%d) to get irq %d\n", 
+						bridge->bus->number, PCI_SLOT(bridge->devfn), pin, irq);
+				dev = bridge;
 			}
+			dev = temp_dev;
+			if (irq >= 0) {
+				printk(KERN_INFO "PCI->APIC IRQ transform: (B%d,I%d,P%d) -> %d\n",
+					dev->bus->number, PCI_SLOT(dev->devfn), pin, irq);
+				dev->irq = irq;
+				return;
+			} else
+				msg = " Probably buggy MP table.";
 		} else if (pci_probe & PCI_BIOS_IRQ_SCAN)
 			msg = "";
 		else

--------------000707080002090802030609--
