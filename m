Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129257AbQLEXff>; Tue, 5 Dec 2000 18:35:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129183AbQLEXfZ>; Tue, 5 Dec 2000 18:35:25 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:9478 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129348AbQLEXfJ>; Tue, 5 Dec 2000 18:35:09 -0500
Date: Tue, 5 Dec 2000 15:04:24 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kai Germaschewski <kai@thphy.uni-duesseldorf.de>,
        "Adam J. Richter" <adam@yggdrasil.com>, Martin Mares <mj@suse.cz>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: PCI irq routing..
In-Reply-To: <Pine.LNX.4.30.0012052110590.968-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.10.10012051442100.7318-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, I now have two confirmations from independent people (Adam Richter
and Kai Germaschewski) who have completely different hardware, but have
the same problem: irq routing seems to not work for them.

In both cases it is because the PCI device config space already has an
entry for the interrupt, but the interrupt is apparently not actually
routed on the irq router.

WHY this happens is unclear, but it could be several reasons:
 - undocumented "Plug'n'Play OS true behaviour"
 - BIOS bugs. 'nuff said.
 - warm-booting from an OS that _does_ set the interrupt routing,
   and also sets the PCI config space thing

The problem can be fairly easily fixed by just removing the test for
whether "pci->dev" has already got set. This, btw, is important for
another reason too - there is nothing that says that a sleep event
wouldn't turn off the irq routing, so we _have_ to have some way of
forcing the interrupt routing to take effect even if we already think we
have the correct irq.

However, Martin is certainly also right in claiming that there might be
bugs the "other" way, and just completely dismissing the irq we already
are claimed to have would be bad.

This is my current suggested patch for the problem.

Adam, Kai, can you verify that it fixes the issues on your systems?

Anybody else who has had problems with PCI interrupt routing (tends to be
"new" devices like CardBus, ACPI, USB etc), can you verify that this
either fixes things or at least doesn't break a setup that had started
working earlier..

Martin, what do you think? We definitely need something like this, but
maybe we could add a few more sanity-tests?

			Linus

----
--- v2.4.0-test11/linux/arch/i386/kernel/pci-irq.c	Sun Nov 19 18:44:03 2000
+++ linux/arch/i386/kernel/pci-irq.c	Tue Dec  5 14:38:13 2000
@@ -405,9 +424,12 @@
 	DBG(" -> PIRQ %02x, mask %04x, excl %04x", pirq, mask, pirq_table->exclusive_irqs);
 	mask &= pcibios_irq_mask;
 
-	/* Find the best IRQ to assign */
-	newirq = 0;
-	if (assign) {
+	/*
+	 * Find the best IRQ to assign: use the one
+	 * reported by the device if possible.
+	 */
+	newirq = dev->irq;
+	if (!newirq && assign) {
 		for (i = 0; i < 16; i++) {
 			if (!(mask & (1 << i)))
 				continue;
@@ -417,16 +439,22 @@
 				newirq = i;
 			}
 		}
-		DBG(" -> newirq=%d", newirq);
 	}
+	DBG(" -> newirq=%d", newirq);
 
 	/* Try to get current IRQ */
 	if (r->get && (irq = r->get(pirq_router_dev, d, pirq))) {
 		DBG(" -> got IRQ %d\n", irq);
 		msg = "Found";
+		/* We refuse to override the dev->irq information. Give a warning! */
+	    	if (dev->irq && dev->irq != irq) {
+	    		printk("IRQ routing conflict in pirq table! Try 'pci=autoirq'\n");
+	    		return 0;
+	    	}
 	} else if (newirq && r->set && (dev->class >> 8) != PCI_CLASS_DISPLAY_VGA) {
 		DBG(" -> assigning IRQ %d", newirq);
 		if (r->set(pirq_router_dev, d, pirq, newirq)) {
+			eisa_set_level_irq(newirq);
 			DBG(" ... OK\n");
 			msg = "Assigned";
 			irq = newirq;
@@ -556,19 +584,17 @@
 
 void pcibios_enable_irq(struct pci_dev *dev)
 {
-	if (!dev->irq) {
-		u8 pin;
-		pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
-		if (pin && !pcibios_lookup_irq(dev, 1)) {
-			char *msg;
-			if (io_apic_assign_pci_irqs)
-				msg = " Probably buggy MP table.";
-			else if (pci_probe & PCI_BIOS_IRQ_SCAN)
-				msg = "";
-			else
-				msg = " Please try using pci=biosirq.";
-			printk(KERN_WARNING "PCI: No IRQ known for interrupt pin %c of device %s.%s\n",
-			       'A' + pin - 1, dev->slot_name, msg);
-		}
+	u8 pin;
+	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
+	if (pin && !pcibios_lookup_irq(dev, 1) && !dev->irq) {
+		char *msg;
+		if (io_apic_assign_pci_irqs)
+			msg = " Probably buggy MP table.";
+		else if (pci_probe & PCI_BIOS_IRQ_SCAN)
+			msg = "";
+		else
+			msg = " Please try using pci=biosirq.";
+		printk(KERN_WARNING "PCI: No IRQ known for interrupt pin %c of device %s.%s\n",
+		       'A' + pin - 1, dev->slot_name, msg);
 	}
 }

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
