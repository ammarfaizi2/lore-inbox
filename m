Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285016AbRLKMkS>; Tue, 11 Dec 2001 07:40:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285017AbRLKMkC>; Tue, 11 Dec 2001 07:40:02 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:16401 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S285016AbRLKMjr>; Tue, 11 Dec 2001 07:39:47 -0500
Subject: Re: USB + PCI - IRQ = kernel bug??
To: jomast@mindspring.com (Jonathan Stanford)
Date: Tue, 11 Dec 2001 12:49:08 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C157D8A.4090200@mindspring.com> from "Jonathan Stanford" at Dec 10, 2001 10:29:14 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16DmLM-0005Js-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> this problem appears on everything from 2.4.7 (RH7.2 kern)  to the 
> latest and greatest (2.4.17-pre8) and probably earlier kernels as well....
> 
> the southbridge/usb controler is the VIA Technologies, Inc. VT82C686b chip as you can see in 

Seems to be a lot of stuff where the pci routing and Linux isnt getting on
when it comes to VIA and USB. Dunno if its wrong BIOS tables but the
following previous patch might help you

Let Manfred and co know if it does

Alan


>From manfred@colorfullife.com Sun Nov 04 22:07:34 2001
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: jgarzik@mandrakesoft.com
Subject: pci-irq.c
Status: RO

Hi Alan,

attached is my cleanup of pci-irq.c.
It works with all my mobos (piix, ali, via) and should fix the vaio
problem.

The main change is a code cleanup (do not scan first for a good irq,
and then discard the result and use what's currently installed in
the irq router, etc) and documentation.

Actual changes:
* if r->set exists, then always write our idea of the irq number
into the irq router, even if we use the bios supplied dev->irq number.
* ignore 'dev2->irq' mismatches - if they exist (e.g. Toms vaio),
then we must solve them by either using 'dev->irq' or 'dev2->irq'.
Just looking away means that one device won't work.
* bounds checking in pirq_via_set. I think I saw pirq=0x58 with my
ali board, I must check the docu if that can be right.

But I doubt that this solves your via sound problems.
via sound interrupts are handled with special code in via_quirks,
and that code is not pirq compatible. Do you have lspci -vxx /
dump_pirq output?

--
	Manfred


--- 2.4/arch/i386/kernel/pci-irq.c	Sat Nov  3 19:51:08 2001
+++ build-2.4/arch/i386/kernel/pci-irq.c	Sun Nov  4 22:47:22 2001
@@ -197,13 +197,24 @@
  */
 static int pirq_via_get(struct pci_dev *router, struct pci_dev *dev, int pirq)
 {
-	return read_config_nybble(router, 0x55, pirq);
+	/* the internal devices (APCI, MC97, AC97, USB port 1 and 2
+	 * are handled by quirk_via_acpi and quirk_via_irqpic
+	 */
+	if (pirq < 6)
+		return read_config_nybble(router, 0x55, pirq);
+	return 0;
 }
 
 static int pirq_via_set(struct pci_dev *router, struct pci_dev *dev, int pirq, int irq)
 {
-	write_config_nybble(router, 0x55, pirq, irq);
-	return 1;
+	/* the internal devices (APCI, MC97, AC97, USB port 1 and 2
+	 * are handled by quirk_via_acpi and quirk_via_irqpic
+	 */
+	if (pirq < 6) {
+		write_config_nybble(router, 0x55, pirq, irq);
+		return 1;
+	}
+	return 0;
 }
 
 /*
@@ -536,8 +547,8 @@
 {
 	u8 pin;
 	struct irq_info *info;
-	int i, pirq, newirq;
-	int irq = 0;
+	int i, pirq;
+	int irq;
 	u32 mask;
 	struct irq_router *r = pirq_router;
 	struct pci_dev *dev2;
@@ -570,48 +581,65 @@
 	mask &= pcibios_irq_mask;
 
 	/*
-	 * Find the best IRQ to assign: use the one
-	 * reported by the device if possible.
+	 * Find the best IRQ to assign:
+	 * 1) hardcoded into pirq 0xf?
+	 * 2) dev->irq.
+	 * 	There are 2 sources for dev->irq:
+	 * 	a) stored by the bios into PCI_INTERRUPT_LINE
+	 * 	b) multiple devices share one pirq, then the loop
+	 * 	   at the end of this function writes to dev->irq
+	 * 3) stored by the bios into the irq router
+	 * 4) only if assign is set: search for a low penalty irq
 	 */
-	newirq = dev->irq;
-	if (!newirq && assign) {
-		for (i = 0; i < 16; i++) {
-			if (!(mask & (1 << i)))
-				continue;
-			if (pirq_penalty[i] < pirq_penalty[newirq] &&
-			    !request_irq(i, pcibios_test_irq_handler, SA_SHIRQ, "pci-test", dev)) {
-				free_irq(i, dev);
-				newirq = i;
-			}
-		}
-	}
-	DBG(" -> newirq=%d", newirq);
-
-	/* Check if it is hardcoded */
 	if ((pirq & 0xf0) == 0xf0) {
 		irq = pirq & 0xf;
 		DBG(" -> hardcoded IRQ %d\n", irq);
 		msg = "Hardcoded";
+	} else if (dev->irq) {
+		irq = dev->irq;
+		DBG(" -> preselected IRQ %d\n", irq);
+		msg = "Preselected";
+		if (!(mask & (1<<irq)))
+			printk(KERN_INFO "PCI: pirq table doesn't match preselected IRQ for %s, using preselected irq.\n", dev->slot_name);
 	} else if (r->get && (irq = r->get(pirq_router_dev, dev, pirq))) {
 		DBG(" -> got IRQ %d\n", irq);
 		msg = "Found";
-	} else if (newirq && r->set && (dev->class >> 8) != PCI_CLASS_DISPLAY_VGA) {
-		DBG(" -> assigning IRQ %d", newirq);
-		if (r->set(pirq_router_dev, dev, pirq, newirq)) {
-			eisa_set_level_irq(newirq);
-			DBG(" ... OK\n");
-			msg = "Assigned";
-			irq = newirq;
+		if (!(mask & (1<<irq)))
+			printk(KERN_INFO "PCI: pirq table doesn't match IRQ router setting for %s, using irq router setting.\n", dev->slot_name);
+	} else if (assign) {
+		for (i = 0; i < 16; i++) {
+			if (!(mask & (1 << i)))
+				continue;
+			if (pirq_penalty[i] < pirq_penalty[irq] &&
+			    !request_irq(i, pcibios_test_irq_handler, SA_SHIRQ, "pci-test", dev)) {
+				free_irq(i, dev);
+				irq = i;
+			}
 		}
-	}
+		DBG(" -> assigning irq=%d\n", irq);
+		msg = "Assigned";
+	} else
+		return 0;
+	if (!irq)
+		return 0;
 
-	if (!irq) {
-		DBG(" ... failed\n");
-		if (newirq && mask == (1 << newirq)) {
-			msg = "Guessed";
-			irq = newirq;
-		} else
-			return 0;
+	if ((pirq & 0xf0) != 0xf0 && r->set && (dev->class >> 8) != PCI_CLASS_DISPLAY_VGA) {
+		/* always rewrite our idea of the interrupt routing back into
+		 * the irq router
+		 */
+		if (r->set(pirq_router_dev, dev, pirq, irq)) {
+			DBG("Set succeeded\n");
+			eisa_set_level_irq(irq);
+		} else {
+			DBG("Set failed\n");
+			/* We ignore this error unless there is no way 
+			 * the irq routing could work without a successful
+			 * r->set().
+			 */
+			if (!strcmp(msg, "Assigned") && mask != (1<<irq)) {
+				return 0;
+			}
+		}
 	}
 	printk(KERN_INFO "PCI: %s IRQ %d for device %s\n", msg, irq, dev->slot_name);
 
@@ -625,11 +653,13 @@
 		if (!info)
 			continue;
 		if (info->irq[pin].link == pirq) {
-			/* We refuse to override the dev->irq information. Give a warning! */
+			/* Give a warning if we have to overwrite dev->irq information.
+			 * This only happens when multiple devices share one pirq, and
+			 * the bios claims that it routes them to different irq numbers.
+			 */
 		    	if (dev2->irq && dev2->irq != irq) {
 		    		printk(KERN_INFO "IRQ routing conflict for %s, have irq %d, want irq %d\n",
 				       dev2->slot_name, dev2->irq, irq);
-		    		continue;
 		    	}
 			dev2->irq = irq;
 			pirq_penalty[irq]++;

