Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130563AbQK3R4o>; Thu, 30 Nov 2000 12:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129912AbQK3R4X>; Thu, 30 Nov 2000 12:56:23 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:772 "EHLO
        jurassic.park.msu.ru") by vger.kernel.org with ESMTP
        id <S129985AbQK3R4P>; Thu, 30 Nov 2000 12:56:15 -0500
Date: Thu, 30 Nov 2000 20:24:39 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Richard Henderson <rth@twiddle.net>
Cc: Wakko Warner <wakko@animx.eu.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch] Re: test12-pre2
Message-ID: <20001130202439.A585@jurassic.park.msu.ru>
In-Reply-To: <Pine.LNX.4.10.10011271838080.15454-100000@penguin.transmeta.com> <20001128213003.A3720@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20001128213003.A3720@animx.eu.org>; from wakko@animx.eu.org on Tue, Nov 28, 2000 at 09:30:03PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2000 at 09:30:03PM -0500, Wakko Warner wrote:
> Doesn't boot on noritake alpha.
> 
> It gets to POSIX conformance testing by UNIFIX
> and hard locks.  the halt switch doesn't even work.

The video card on that system turned out to have pci class
PCI_CLASS_NOT_DEFINED_VGA instead of PCI_CLASS_DISPLAY_VGA.
So it was disabled, and I guess that any access to it (printk())
caused machine checks without anything displayed on the screen.

A tad more care in disabling devices should fix that.

Ivan.

--- 2.4.0t12p3/drivers/pci/setup-bus.c	Thu Nov 30 12:14:31 2000
+++ linux/drivers/pci/setup-bus.c	Thu Nov 30 12:31:35 2000
@@ -45,24 +45,28 @@ pbus_assign_resources_sorted(struct pci_
 	head_io.next = head_mem.next = NULL;
 	for (ln=bus->devices.next; ln != &bus->devices; ln=ln->next) {
 		struct pci_dev *dev = pci_dev_b(ln);
+		u16 class = dev->class >> 8;
 		u16 cmd;
 
 		/* First, disable the device to avoid side
 		   effects of possibly overlapping I/O and
 		   memory ranges.
-		   Except the VGA - for obvious reason. :-)  */
-		if (dev->class >> 8 == PCI_CLASS_DISPLAY_VGA)
+		   Leave VGA enabled - for obvious reason. :-)
+		   Same with all sorts of bridges - they may
+		   have VGA behind them.  */
+		if (class == PCI_CLASS_DISPLAY_VGA
+				|| class == PCI_CLASS_NOT_DEFINED_VGA)
 			found_vga = 1;
-		else {
+		else if (class >> 8 != PCI_BASE_CLASS_BRIDGE) {
 			pci_read_config_word(dev, PCI_COMMAND, &cmd);
 			cmd &= ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY
 						| PCI_COMMAND_MASTER);
 			pci_write_config_word(dev, PCI_COMMAND, cmd);
 		}
- 
+
 		/* Reserve some resources for CardBus.
 		   Are these values reasonable? */
-		if (dev->class >> 8 == PCI_CLASS_BRIDGE_CARDBUS) {
+		if (class == PCI_CLASS_BRIDGE_CARDBUS) {
 			io_reserved += 8*1024;
 			mem_reserved += 32*1024*1024;
 			continue;
--- 2.4.0t12p3/arch/alpha/kernel/pci.c	Thu Nov 30 12:17:36 2000
+++ linux/arch/alpha/kernel/pci.c	Thu Nov 30 12:15:58 2000
@@ -56,13 +56,13 @@ struct pci_controler *pci_isa_hose;
 static void __init
 quirk_eisa_bridge(struct pci_dev *dev)
 {
-	dev->class = PCI_CLASS_BRIDGE_EISA;
+	dev->class = PCI_CLASS_BRIDGE_EISA << 8;
 }
 
 static void __init
 quirk_isa_bridge(struct pci_dev *dev)
 {
-	dev->class = PCI_CLASS_BRIDGE_ISA;
+	dev->class = PCI_CLASS_BRIDGE_ISA << 8;
 }
 
 static void __init
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
