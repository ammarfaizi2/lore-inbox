Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130669AbRAQRv3>; Wed, 17 Jan 2001 12:51:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131011AbRAQRvT>; Wed, 17 Jan 2001 12:51:19 -0500
Received: from aragorn.ics.muni.cz ([147.251.4.33]:12164 "EHLO
	aragorn.ics.muni.cz") by vger.kernel.org with ESMTP
	id <S130669AbRAQRvI>; Wed, 17 Jan 2001 12:51:08 -0500
Date: Wed, 17 Jan 2001 18:50:47 +0100
From: Petr Matula <pem@informatics.muni.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Dunlap, Randy" <randy.dunlap@intel.com>, pem@informatics.muni.cz,
        MOLNAR Ingo <mingo@chiara.elte.hu>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: int. assignment on SMP + ServerWorks chipset
Message-ID: <20010117185047.A13171968@aisa.fi.muni.cz>
In-Reply-To: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDF24@orsmsx31.jf.intel.com> <Pine.LNX.4.10.10101152031110.12667-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.10.10101152031110.12667-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Jan 15, 2001 at 08:49:56PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 15, 2001 at 08:49:56PM -0800, Linus Torvalds wrote:
> So what I _think_ is the correct change is to do roughly this in
> arch/i386/kernel/pci-irq.c:
> 
>  - in pcibios_fixup_irqs(), remove the
> 
> 	#idef CONFIG_X86_IO_APIC
> 		...
> 	#endif
> 
>    section entirely.
> 
>  - in pcibios_enable_irq(), at the _end_ (after having enabled the irq
>    with "pcibios_lookup_irq(dev, 1)", do something like
> 
> 	irq = IO_APIC_get_PCI_irq_vector(dev->bus->number, PCI_SLOT(dev->devfn), pin);
> 	if (irq > 0)
> 		dev->irq = irq;
> 
> and add a LOT of debug printk's, and enable DEBUG in pci-i386.h.

I did the changes above to 2.4.0 source. 
Kernel with these changes can't detect my SCSI drive. It prints these messages 
in cycle:
SCSI host 0 abort (pid 0) timed out - resetting
SCSI host is being reset for host 0 channel 0
SCSI host 0 channel 0 reset (pid 0) timed out - trying harder
SCSI host is being reset for host 0 channel 0

Same configuration without changes above detects SCSI drive without problem.
For completness, made changes are attached.

Could anybody help?

Petr

---------------------------------------------------------------
 Petr Matula                                    pem@fi.muni.cz
                                    http://www.fi.muni.cz/~pem
---------------------------------------------------------------

--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch

--- linux/arch/i386/kernel/pci-irq.c	Thu Jan  4 05:45:26 2001
+++ linux~/arch/i386/kernel/pci-irq.c	Wed Jan 17 17:30:53 2001
@@ -559,40 +559,6 @@
 
 	pci_for_each_dev(dev) {
 		pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
-#ifdef CONFIG_X86_IO_APIC
-		/*
-		 * Recalculate IRQ numbers if we use the I/O APIC.
-		 */
-		if (io_apic_assign_pci_irqs)
-		{
-			int irq;
-
-			if (pin) {
-				pin--;		/* interrupt pins are numbered starting from 1 */
-				irq = IO_APIC_get_PCI_irq_vector(dev->bus->number, PCI_SLOT(dev->devfn), pin);
-/*
- * Will be removed completely if things work out well with fuzzy parsing
- */
-#if 0
-				if (irq < 0 && dev->bus->parent) { /* go back to the bridge */
-					struct pci_dev * bridge = dev->bus->self;
-
-					pin = (pin + PCI_SLOT(dev->devfn)) % 4;
-					irq = IO_APIC_get_PCI_irq_vector(bridge->bus->number, 
-							PCI_SLOT(bridge->devfn), pin);
-					if (irq >= 0)
-						printk(KERN_WARNING "PCI: using PPB(B%d,I%d,P%d) to get irq %d\n", 
-							bridge->bus->number, PCI_SLOT(bridge->devfn), pin, irq);
-				}
-#endif
-				if (irq >= 0) {
-					printk("PCI->APIC IRQ transform: (B%d,I%d,P%d) -> %d\n",
-						dev->bus->number, PCI_SLOT(dev->devfn), pin, irq);
-					dev->irq = irq;
-				}
-			}
-		}
-#endif
 		/*
 		 * Still no IRQ? Try to lookup one...
 		 */
@@ -612,6 +578,7 @@
 
 void pcibios_enable_irq(struct pci_dev *dev)
 {
+  unsigned int irq;
 	u8 pin;
 	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
 	if (pin && !pcibios_lookup_irq(dev, 1) && !dev->irq) {
@@ -624,5 +591,14 @@
 			msg = " Please try using pci=biosirq.";
 		printk(KERN_WARNING "PCI: No IRQ known for interrupt pin %c of device %s.%s\n",
 		       'A' + pin - 1, dev->slot_name, msg);
+
+                printk("Doing: IO_APIC_get_PCI_irq_vector\n");
+                printk("dev->bus->number    : %c\n",dev->bus->number);
+                printk("PCI_SLOT(dev->devfn): %d\n",PCI_SLOT(dev->devfn));
+                printk("pin                 : %hhd\n",pin);
+                irq = IO_APIC_get_PCI_irq_vector(dev->bus->number, PCI_SLOT(dev->devfn), pin);
+                printk("assigned irq        : %u\n",irq);
+                if (irq > 0)
+                  dev->irq = irq;    
 	}
 }

--gKMricLos+KVdGMg--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
