Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261473AbVBHF5a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261473AbVBHF5a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 00:57:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261475AbVBHF5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 00:57:30 -0500
Received: from 207-105-1-25.zarak.com ([207.105.1.25]:21562 "HELO
	iceberg.Adtech-Inc.COM") by vger.kernel.org with SMTP
	id S261473AbVBHF4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 00:56:43 -0500
Message-ID: <42085448.4010000@spirentcom.com>
Date: Mon, 07 Feb 2005 21:55:20 -0800
From: "Mark F. Haigh" <Mark.Haigh@spirentcom.com>
User-Agent: Mozilla Thunderbird  (X11/20041216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: marcelo.tosatti@cyclades.com
CC: "Mark F. Haigh" <Mark.Haigh@spirentcom.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4.19-bk8] arch/i386/kernel/pci-irq.c: Wrong message
 output
References: <42084219.80608@spirentcom.com>
In-Reply-To: <42084219.80608@spirentcom.com>
Content-Type: multipart/mixed;
 boundary="------------070708060106020808090106"
X-OriginalArrivalTime: 08 Feb 2005 05:56:40.0428 (UTC) FILETIME=[F57B2AC0:01C50DA2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070708060106020808090106
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Mark F. Haigh wrote:
> 
> --- arch/i386/kernel/pci-irq.c.orig	2005-02-07 19:55:23.852531544 -0800
> +++ arch/i386/kernel/pci-irq.c	2005-02-07 20:13:38.835068896 -0800

Apologies.  Patch now -p1-able.


Mark F. Haigh
Mark.Haigh@spirentcom.com

Signed-off-by: Mark F. Haigh  <Mark.Haigh@spirentcom.com>


--------------070708060106020808090106
Content-Type: text/plain;
 name="pci-irq-patch2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pci-irq-patch2"

--- linux-2.4.29-bk8/arch/i386/kernel/pci-irq.c.orig	2005-02-07 19:55:23.000000000 -0800
+++ linux-2.4.29-bk8/arch/i386/kernel/pci-irq.c	2005-02-07 20:13:38.000000000 -0800
@@ -1127,6 +1127,8 @@
 	if (pin && !pcibios_lookup_irq(dev, 1) && !dev->irq) {
 		char *msg;
 
+		pin--;		/* interrupt pins are numbered starting from 1 */
+
 		/* With IDE legacy devices the IRQ lookup failure is not a problem.. */
 		if (dev->class >> 8 == PCI_CLASS_STORAGE_IDE && !(dev->class & 0x5))
 			return;
@@ -1134,42 +1136,39 @@
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
 			msg = " Please try using pci=biosirq.";
 		printk(KERN_WARNING "PCI: No IRQ known for interrupt pin %c of device %s.%s\n",
-		       'A' + pin - 1, dev->slot_name, msg);
+		       'A' + pin, dev->slot_name, msg);
 	}
 	/* VIA bridges use interrupt line for apic/pci steering across
 	   the V-Link */

--------------070708060106020808090106--
