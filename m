Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130361AbQLHBUf>; Thu, 7 Dec 2000 20:20:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129894AbQLHBUY>; Thu, 7 Dec 2000 20:20:24 -0500
Received: from r1795.muc.dial.surf-callino.de ([213.21.8.17]:2308 "EHLO
	notebook.diehl.home") by vger.kernel.org with ESMTP
	id <S129708AbQLHBUN>; Thu, 7 Dec 2000 20:20:13 -0500
Date: Fri, 8 Dec 2000 01:49:20 +0100 (CET)
From: Martin Diehl <mdiehlcs@compuserve.de>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kai Germaschewski <kai@thphy.uni-duesseldorf.de>,
        "Adam J. Richter" <adam@yggdrasil.com>, Martin Mares <mj@suse.cz>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PCI irq routing..
In-Reply-To: <Pine.LNX.4.10.10012071031300.2496-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0012072344110.571-100000@notebook.diehl.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2000, Linus Torvalds wrote:

> > btw, I'm thinking I could guess the routing from the VLSI config space,
> 
> Please do. You might leave them commented out right now, but this is
> actually how most of the pirq router entries have been created: by looking
> at various pirq tables and matching them up with other (non-pirq)
> documentation and testing. Th epirq "link" value is basically completely
> NDA'd, and is per-chipset-specific. Nobody documents it except in their
> bios writers guide, if even there.

Ok - will do it. Unfortunately the BIOS of this notebook has no
customizeable routing option which I could use to to play with.
So testing here will hardly cover orthogonal cases.

> > The reason for this is in drivers/pci.c where bridges are touched
> > twice: once as a device on a bus and once via ->self from the bus behind.
> 
> Not intended behaviour. The self case should be removed.

I was wondering whether there might be bridges which have to be awoken
from both sides because they have different config spaces there.
Is bus->children->self guarantied to be identical to bus->device for
all kinds of bridge devices?
Sure, dividing bridges wouldn't make too much sense - at least I don't see
what half a bridge might be good for, but ...

Removing self cases is straightforward - pci_pm-2.4.0-t9p3-patch below.

> Ok, definitely needs some more work. Thanks for testing - I have no
> hardware where this is needed.

Could do some more testing if a day or two for feedback is ok.

Two more things I've noticed:

- when all pcmcia/yenta stuff is in modules and doing suspend/resume
immediately after fresh cold reboot there is nothing our cardbus stuff
might have set up which was lost in suspend. Nevertheless, what happens is
the pcmcia_core/yenta_socket/ds modules get loaded without problem but the
"Socket status" printk from yenta_open_bh() is completely garbage. This is
not the case when the modules are loaded before the suspend.
Despite the garbage, subsequent cardmgr startup does not give any error
message - but the cards in the slots are not recognized (no beeps, no
status to retrieve from cardctl). Reboot is the only solution.
My conclusion is, the reason must be in the init-path doing or forgetting
something prohibited/required after suspend - or the TI1131 is broken.

- when, after yenta sockets became unusable due to pm suspend, I try to
eject/insert the cards from a slot, the box freezes. This turned out
to be a loop in yenta_interrupt being called endlessly. Apparently the
yenta_bh() -> pcmcia-handler path somehow triggers the next IRQ.
But this might be a consequence of the former issue.

According to the forecasts, next weekend will be rainy, so...

Thank you for the time!

Regards
Martin

-----
--- linux-2.4.0-t12p3/drivers/pci/pci.c.orig	Mon Dec  4 14:21:26 2000
+++ linux-2.4.0-t12p3/drivers/pci/pci.c	Fri Dec  8 00:17:50 2000
@@ -1089,6 +1089,9 @@
 	return 0;
 }
 
+
+/* take care to suspend/resume bridges only once */
+
 static int pci_pm_suspend_bus(struct pci_bus *bus)
 {
 	struct list_head *list;
@@ -1100,9 +1103,6 @@
 	/* Walk the device children list */
 	list_for_each(list, &bus->devices)
 		pci_pm_suspend_device(pci_dev_b(list));
-
-	/* Suspend the bus controller.. */
-	pci_pm_suspend_device(bus->self);
 	return 0;
 }
 
@@ -1110,8 +1110,6 @@
 {
 	struct list_head *list;
 
-	pci_pm_resume_device(bus->self);
-
 	/* Walk the device children list */
 	list_for_each(list, &bus->devices)
 		pci_pm_resume_device(pci_dev_b(list));
@@ -1125,18 +1123,26 @@
 static int pci_pm_suspend(void)
 {
 	struct list_head *list;
+	struct pci_bus *bus;
 
-	list_for_each(list, &pci_root_buses)
-		pci_pm_suspend_bus(pci_bus_b(list));
+	list_for_each(list, &pci_root_buses) {
+		bus = pci_bus_b(list);
+		pci_pm_suspend_bus(bus);
+		pci_pm_suspend_device(bus->self);
+	}
 	return 0;
 }
 
 static int pci_pm_resume(void)
 {
 	struct list_head *list;
+	struct pci_bus *bus;
 
-	list_for_each(list, &pci_root_buses)
-		pci_pm_resume_bus(pci_bus_b(list));
+	list_for_each(list, &pci_root_buses) {
+		bus = pci_bus_b(list);
+		pci_pm_resume_device(bus->self);
+		pci_pm_resume_bus(bus);
+	}
 	return 0;
 }



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
