Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129908AbQLEJOb>; Tue, 5 Dec 2000 04:14:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130119AbQLEJOW>; Tue, 5 Dec 2000 04:14:22 -0500
Received: from freya.yggdrasil.com ([209.249.10.20]:58245 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S129908AbQLEJOO>; Tue, 5 Dec 2000 04:14:14 -0500
Date: Tue, 5 Dec 2000 00:43:46 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: Patch: x86 PCI IRQ's were not being routed in some cases (against 2.4.0-test11pre4)
Message-ID: <20001205004346.A677@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	I don't know if this is the fault of my notebook's BIOS
or Linux.  However, Linux should work around bad BIOS'es where
feasible.  So, here goes.

	I have a Kapok 1100M notebook computer, which has a Pentium II,
apparently with a 440BX chipset.  The BIOS fills in the PCI interrupt
routing tables (the thing that begins with "$PIR" in memory) with
information indicating that the USB controller is routed to IRQ 10,
and that that is the only IRQ that it can be routed to.

	Linux apparently looks at this data and takes that to mean
that the wiring has already been done.  However, this is not the case.
As far as I can tell, the BIOS is just suggesting that Linux configure
the 440BX chipset to that routing.  (This BIOS does not have a
"Plug & Play OS" option.)

	This has not always been a problem.  If I recall correctly, kernels
up to somewhere in early 2.3.x worked.

	To fix this problem, I have deleted a conditional in
pcibios_enable_irq, so that it will route the IRQ, even if it
thinks the work has already been done.  Now, USB and my PCMCIA
flash cards work in that notebook computer again.

	I do not have that solid of an understanding of PCI
initialization in Linux.  I am still rather confused about what
routines are supposed to set up an interrupt if one is needed
and has not yet been routed for the device and which ones are supposed
to punt in case.  For example, there is another problem that I
am trying to fix, where the motherboard BIOS on that other computer
sets the IRQ associated with the USB controller to zero, no matter
how I program the BIOS, and pcibios_lookup_irq takes this as reason
enough to refuse to allocate and route a new IRQ.

	Anyhow, I have attached the patch for the lack of PCI IRQ
initialization below.  The only change was to delete the first
"if" statement.  The rest of the diff lines are just the resulting
intentation and bracketing change.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="irq.diff"

--- linux-2.4.0-test12-pre4/arch/i386/kernel/pci-irq.c	Mon Dec  4 03:28:20 2000
+++ linux/arch/i386/kernel/pci-irq.c	Tue Dec  5 00:20:25 2000
@@ -576,19 +576,17 @@
 
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
+	if (pin && !pcibios_lookup_irq(dev, 1)) {
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

--bp/iNruPH9dso1Pn--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
