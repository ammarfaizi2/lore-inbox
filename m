Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129501AbQKSTwp>; Sun, 19 Nov 2000 14:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129689AbQKSTwf>; Sun, 19 Nov 2000 14:52:35 -0500
Received: from jabberwock.ucw.cz ([62.168.0.131]:27658 "EHLO jabberwock.ucw.cz")
	by vger.kernel.org with ESMTP id <S129501AbQKSTwS>;
	Sun, 19 Nov 2000 14:52:18 -0500
Date: Sun, 19 Nov 2000 20:22:10 +0100
From: Martin Mares <mj@suse.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: reordering pci interrupts?
Message-ID: <20001119202210.B272@albireo.ucw.cz>
In-Reply-To: <20001118163258.A1643@cerebro.laendle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001118163258.A1643@cerebro.laendle>; from pcg@goof.com on Sat, Nov 18, 2000 at 04:32:58PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> I have a motherboard with a broken bios that is unable to set interrupts
> correctly, i.e. it initializes the devices corerctly but swaps the
> interrupts for slot1/slot3 and slot2/slot4.
> 
> Now, is there a way to forcefully re-order the pci-interrupts? I do not
> have an io-apic (thus no pirq=xxx), and I tried to poke the interrupt
> values directly into /proc/bus/pic/*/*, but the kernel has it's own idea.
> 
> Thanks a lot for any info (I guess I'll just patch the kernel).

Please try this patch and boot with "pci=autoirq" on the kernel command line.

				Have a nice fortnight
-- 
Martin `MJ' Mares <mj@ucw.cz> <mj@suse.cz> http://atrey.karlin.mff.cuni.cz/~mj/
"veni, vidi, nuclei deceiri - I came, I saw, I core dumped"


--- arch/i386/kernel/pci-pc.c.mj	Sun Nov 19 20:18:14 2000
+++ arch/i386/kernel/pci-pc.c	Sun Nov 19 20:18:14 2000
@@ -1035,6 +1035,9 @@
 	} else if (!strncmp(str, "lastbus=", 8)) {
 		pcibios_last_bus = simple_strtol(str+8, NULL, 0);
 		return NULL;
+	} else if (!strcmp(str, "autoirq")) {
+		pci_probe |= PCI_AUTOIRQ;
+		return NULL;
 	}
 	return str;
 }
--- arch/i386/kernel/pci-i386.h.mj	Sun Nov 19 20:18:32 2000
+++ arch/i386/kernel/pci-i386.h	Sun Nov 19 20:18:32 2000
@@ -18,6 +18,7 @@
 #define PCI_NO_SORT 0x100
 #define PCI_BIOS_SORT 0x200
 #define PCI_NO_CHECKS 0x400
+#define PCI_AUTOIRQ 0x800
 #define PCI_ASSIGN_ROMS 0x1000
 #define PCI_BIOS_IRQ_SCAN 0x2000
 
--- arch/i386/kernel/pci-irq.c.mj	Sun Nov 19 20:18:50 2000
+++ arch/i386/kernel/pci-irq.c	Sun Nov 19 20:18:50 2000
@@ -487,7 +487,7 @@
 		 * If the BIOS has set an out of range IRQ number, just ignore it.
 		 * Also keep track of which IRQ's are already in use.
 		 */
-		if (dev->irq >= 16) {
+		if (dev->irq >= 16 || (pci_probe & PCI_AUTOIRQ)) {
 			DBG("%s: ignoring bogus IRQ %d\n", dev->slot_name, dev->irq);
 			dev->irq = 0;
 		}
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
