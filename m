Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135706AbRA2HmU>; Mon, 29 Jan 2001 02:42:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S145346AbRA2HmK>; Mon, 29 Jan 2001 02:42:10 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:65285 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S159768AbRA2Hlz>; Mon, 29 Jan 2001 02:41:55 -0500
Date: Sun, 28 Jan 2001 23:41:38 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Robert Siemer <siemer@panorama.hadiko.de>
cc: jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org
Subject: Re: PCI IRQ routing problem in 2.4.0
In-Reply-To: <20010129081132I.siemer@panorama.hadiko.de>
Message-ID: <Pine.LNX.4.10.10101282323570.5605-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 29 Jan 2001, Robert Siemer wrote:
> 
> Further I always see '09' in the Configuration Space at Interrupt_Line
> (0x3c) for the 00:01.2 USB Controller. But 2.4.0 says:
>   Interrupt: pin A routed to IRQ 12
> while 2.4.0-test9 states:
>   Interrupt: pin A routed to IRQ 9

Ahhah!

I bet it's the code that goes through all PCI devices, and tries to find
devices that have the same "pirq" (aka "link") value in the tables.

How about this patch? I bet that you'll get a message about pirq table
conflicts. Does USB end up working afterwards?

		Linus

----
--- v2.4.0/linux/arch/i386/kernel/pci-irq.c	Wed Jan  3 20:45:26 2001
+++ linux/arch/i386/kernel/pci-irq.c	Sun Jan 28 23:36:48 2001
@@ -462,18 +462,9 @@
 		irq = pirq & 0xf;
 		DBG(" -> hardcoded IRQ %d\n", irq);
 		msg = "Hardcoded";
-		if (dev->irq && dev->irq != irq) {
-			printk("IRQ routing conflict in pirq table! Try 'pci=autoirq'\n");
-			return 0;
-		}
 	} else if (r->get && (irq = r->get(pirq_router_dev, dev, pirq))) {
 		DBG(" -> got IRQ %d\n", irq);
 		msg = "Found";
-		/* We refuse to override the dev->irq information. Give a warning! */
-	    	if (dev->irq && dev->irq != irq) {
-	    		printk("IRQ routing conflict in pirq table! Try 'pci=autoirq'\n");
-	    		return 0;
-	    	}
 	} else if (newirq && r->set && (dev->class >> 8) != PCI_CLASS_DISPLAY_VGA) {
 		DBG(" -> assigning IRQ %d", newirq);
 		if (r->set(pirq_router_dev, dev, pirq, newirq)) {
@@ -504,6 +495,11 @@
 		if (!info)
 			continue;
 		if (info->irq[pin].link == pirq) {
+			/* We refuse to override the dev->irq information. Give a warning! */
+		    	if (dev2->irq && dev2->irq != irq) {
+		    		printk("IRQ routing conflict in pirq table for device %s\n", dev2->slot_name);
+		    		continue;
+		    	}
 			dev2->irq = irq;
 			pirq_penalty[irq]++;
 			if (dev != dev2)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
