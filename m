Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261486AbVBHGJ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261486AbVBHGJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 01:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbVBHGJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 01:09:29 -0500
Received: from 207-105-1-25.zarak.com ([207.105.1.25]:22074 "HELO
	iceberg.Adtech-Inc.COM") by vger.kernel.org with SMTP
	id S261486AbVBHGJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 01:09:15 -0500
Message-ID: <4208573A.9020605@spirentcom.com>
Date: Mon, 07 Feb 2005 22:07:54 -0800
From: "Mark F. Haigh" <Mark.Haigh@spirentcom.com>
User-Agent: Mozilla Thunderbird  (X11/20041216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc3-bk4] arch/i386/kernel/pci/irq.c:  Wrong message
 output
References: <20050208055244.GA31392@kroah.com>
In-Reply-To: <20050208055244.GA31392@kroah.com>
Content-Type: multipart/mixed;
 boundary="------------020603010104070601060207"
X-OriginalArrivalTime: 08 Feb 2005 06:09:15.0012 (UTC) FILETIME=[B73F8C40:01C50DA4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020603010104070601060207
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Greg KH wrote:
<snip>
> 
> Oops, this time you forgot the whole description of the patch :(
> 
> Third time's the charm...

The following has been reported in the wild for kernel 2.6.8-24:

PCI: Enabling device 0000:00:05.0 (0000 -> 0002)
PCI: No IRQ known for interrupt pin @ of device 0000:00:05.0. Probably 
buggy MP table.

It should read "No IRQ known for interrupt pin A", but the 'pin' 
variable has already been decremented (from 1 to 0), so the line:

printk(KERN_WARNING "PCI: No IRQ known for interrupt pin %c of device 
%s.%s\n", 'A' + pin - 1, dev->slot_name, msg);

causes "pin @" to be output, because 'A' + 0 - 1 == '@'.

The supplied patch should fix it.  It also removes a redundant check for 
a nonzero pin.


Mark F. Haigh
Mark.Haigh@spirentcom.com

Signed-off-by: Mark F. Haigh  <Mark.Haigh@spirentcom.com>


--------------020603010104070601060207
Content-Type: text/plain;
 name="pci-irq-patch3"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pci-irq-patch3"

--- linux-2.6.11-rc3-bk4/arch/i386/pci/irq.c.orig	2005-02-07 20:40:58.000000000 -0800
+++ linux-2.6.11-rc3-bk4/arch/i386/pci/irq.c	2005-02-07 21:39:15.091239272 -0800
@@ -1031,56 +1031,55 @@
 
 	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
 	if (pin && !pcibios_lookup_irq(dev, 1) && !dev->irq) {
-		char *msg;
-		msg = "";
+		char *msg = "";
+
+		pin--;		/* interrupt pins are numbered starting from 1 */
+
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
-
-					pin = (pin + PCI_SLOT(dev->devfn)) % 4;
-					irq = IO_APIC_get_PCI_irq_vector(bridge->bus->number, 
-							PCI_SLOT(bridge->devfn), pin);
-					if (irq >= 0)
-						printk(KERN_WARNING "PCI: using PPB %s[%c] to get irq %d\n",
-							pci_name(bridge), 'A' + pin, irq);
-					dev = bridge;
-				}
-				dev = temp_dev;
-				if (irq >= 0) {
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
+
+				pin = (pin + PCI_SLOT(dev->devfn)) % 4;
+				irq = IO_APIC_get_PCI_irq_vector(bridge->bus->number, 
+						PCI_SLOT(bridge->devfn), pin);
+				if (irq >= 0)
+					printk(KERN_WARNING "PCI: using PPB %s[%c] to get irq %d\n",
+						pci_name(bridge), 'A' + pin, irq);
+				dev = bridge;
+			}
+			dev = temp_dev;
+			if (irq >= 0) {
 #ifdef CONFIG_PCI_MSI
-					if (!platform_legacy_irq(irq))
-						irq = IO_APIC_VECTOR(irq);
+				if (!platform_legacy_irq(irq))
+					irq = IO_APIC_VECTOR(irq);
 #endif
-					printk(KERN_INFO "PCI->APIC IRQ transform: %s[%c] -> IRQ %d\n",
-						pci_name(dev), 'A' + pin, irq);
-					dev->irq = irq;
-					return 0;
-				} else
-					msg = " Probably buggy MP table.";
-			}
+				printk(KERN_INFO "PCI->APIC IRQ transform: %s[%c] -> IRQ %d\n",
+					pci_name(dev), 'A' + pin, irq);
+				dev->irq = irq;
+				return 0;
+			} else
+				msg = " Probably buggy MP table.";
 		} else if (pci_probe & PCI_BIOS_IRQ_SCAN)
 			msg = "";
 		else
 			msg = " Please try using pci=biosirq.";
-			
+
 		/* With IDE legacy devices the IRQ lookup failure is not a problem.. */
 		if (dev->class >> 8 == PCI_CLASS_STORAGE_IDE && !(dev->class & 0x5))
 			return 0;
-			
+
 		printk(KERN_WARNING "PCI: No IRQ known for interrupt pin %c of device %s.%s\n",
-		       'A' + pin - 1, pci_name(dev), msg);
+		       'A' + pin, pci_name(dev), msg);
 	}
 	/* VIA bridges use interrupt line for apic/pci steering across
 	   the V-Link */

--------------020603010104070601060207--
