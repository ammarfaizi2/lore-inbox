Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312505AbSDSOHv>; Fri, 19 Apr 2002 10:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312511AbSDSOHu>; Fri, 19 Apr 2002 10:07:50 -0400
Received: from venus.ci.uw.edu.pl ([193.0.74.207]:18961 "EHLO
	venus.ci.uw.edu.pl") by vger.kernel.org with ESMTP
	id <S312505AbSDSOHs>; Fri, 19 Apr 2002 10:07:48 -0400
Date: Fri, 19 Apr 2002 16:02:18 +0200 (CEST)
From: Jan Slupski <jslupski@email.com>
To: linux-kernel@vger.kernel.org
cc: alan@redhat.com
Subject: [PATCH] Wrong IRQ for USB on Sony Vaio (dmi_scan.c, pci-irq.c)
Message-ID: <Pine.LNX.4.21.0204191553110.6667-100000@venus.ci.uw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I'm writing once more about problem with IRQ assignment 
for Sony Vaio Laptops.

Broken BIOS of these notebooks assigns IRQ 10 for USB,
even though it is actually wired to IRQ 9.

I use PCG-FX240 model of Sony Vaio, but I have proofs of other users, 
that exactly the same problem exists on models:
FX200, FX220, FX250, FX270, FX290, FX370, FX503, R505JS, R505JL
These models use Intel's 82801BA controller, and Phoenix bios.

I wrote the patch that fix this. It is written on example of
patch for HP Pavillion (taken from 2.4.19-pre7-ac1).

This patch was tested on FX240. 
It is build for 2.4.18-pre7-ac1.

Only problem is I don't have DMI Product names for all involved models.
That's why I left pretty general:
  MATCH(DMI_PRODUCT_NAME, "PCG-")

I can help find exact Product Names for all models listed above, but
still new models of Vaio laptops are released with this bug.
I think checking of PCI Vendor & Device number should be enough proof
of broken bios.

If you think it should be tested on all models listed above, I can ask
their owners to do this. (They are now using my previous, even more ugly hack)

Some more description, and logs can be found on my Sony Vaio site:
http://www.pm.waw.pl/~jslupski/vaio/
I can provide any additional data, if needed.

Jan


Patch is:


diff -ru linux/arch/i386/kernel/dmi_scan.c linux-2.4.19-pre7-ac1.2/arch/i386/kernel/dmi_scan.c
--- linux/arch/i386/kernel/dmi_scan.c	Fri Apr 19 15:15:19 2002
+++ linux-2.4.19-pre7-ac1.2/arch/i386/kernel/dmi_scan.c	Fri Apr 19 15:50:48 2002
@@ -392,6 +392,27 @@
 }
 
 /*
+ * Work around broken Sony Vaio which assign USB to
+ * IRQ 10 even though it is actually wired to IRQ 9
+ * Models involved (at least): FX200, FX220, FX240, 
+ * FX250, FX270, FX290, FX370, FX503, R505JS, R505JL
+ * Send comments to: Jan Slupski, jslupski@email.com
+ */
+static __init int fix_broken_sony_vaio_bios_irq10(struct dmi_blacklist *d)
+{
+#ifdef CONFIG_PCI
+	extern int broken_sony_vaio_bios_irq10;
+	if (broken_sony_vaio_bios_irq10 == 0)
+	{
+		broken_sony_vaio_bios_irq10 = 1;
+		printk(KERN_INFO "%s detected - fixing broken IRQ routing (if broken!)\n", d->ident);
+	}
+#endif
+	return 0;
+}
+
+
+/*
  * This bios swaps the APM minute reporting bytes over (Many sony laptops
  * have this problem).
  */
@@ -760,6 +781,12 @@
 			MATCH(DMI_PRODUCT_VERSION, "HP Pavilion Notebook Model GE"),
 			MATCH(DMI_BOARD_VERSION, "OmniBook N32N-736")
 			} },
+
+ 	{ fix_broken_sony_vaio_bios_irq10, "Sony Vaio Laptop", {
+			MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
+			MATCH(DMI_PRODUCT_NAME, "PCG-"),
+			NO_MATCH, NO_MATCH,
+			} },
  
 
 	/*
diff -ru linux/arch/i386/kernel/pci-irq.c linux-2.4.19-pre7-ac1.2/arch/i386/kernel/pci-irq.c
--- linux/arch/i386/kernel/pci-irq.c	Fri Apr 19 15:15:19 2002
+++ linux-2.4.19-pre7-ac1.2/arch/i386/kernel/pci-irq.c	Fri Apr 19 15:50:55 2002
@@ -24,6 +24,8 @@
 
 int broken_hp_bios_irq9;
 
+int broken_sony_vaio_bios_irq10;
+
 static struct irq_routing_table *pirq_table;
 
 /*
@@ -601,6 +603,18 @@
 		r->set(pirq_router_dev, dev, pirq, 11);
 	}
 
+	/* Work around broken Sony Vaio Notebooks which assign USB to
+	 * IRQ 10 even though it is actually wired to IRQ 9 
+	 * Send comments to: Jan Slupski, jslupski@email.com
+	 */
+
+	if (broken_sony_vaio_bios_irq10 && pirq == 0x63 && dev->irq == 9 &&
+			dev->vendor == 0x8086 && dev->device == 0x2442){
+		dev->irq = 9;
+		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, 9);
+		r->set(pirq_router_dev, dev, pirq, 9);
+	}
+
 	/*
 	 * Find the best IRQ to assign: use the one
 	 * reported by the device if possible.





   _  _  _  _  _____________________________________________
   | |_| |\ |  S L U P S K I              jslupski@email.com
 |_| | | | \|            http://www.pm.waw.pl/~jslupski/vaio

