Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263147AbVCXS0e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263147AbVCXS0e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 13:26:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263151AbVCXS0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 13:26:34 -0500
Received: from atlrel7.hp.com ([156.153.255.213]:50920 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S263147AbVCXSYf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 13:24:35 -0500
Subject: Re: [ACPI] Re: Fw: Anybody? 2.6.11 (stable and -rc) ACPI breaks USB
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Len Brown <len.brown@intel.com>
Cc: Shaohua Li <shaohua.li@intel.com>, Grzegorz Kulewski <kangur@polcom.net>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       ACPI List <acpi-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1111603235.17317.883.camel@d845pe>
References: <41062.15.99.19.46.1111525073.squirrel@mail.atl.hp.com>
	 <1111539249.18927.17.camel@sli10-desk.sh.intel.com>
	 <1110.65.74.231.82.1111550240.squirrel@mail.cce.hp.com>
	 <1111603235.17317.883.camel@d845pe>
Content-Type: text/plain
Date: Thu, 24 Mar 2005 11:24:22 -0700
Message-Id: <1111688662.24547.26.camel@eeyore>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-23 at 13:40 -0500, Len Brown wrote:
> But checking skip_ioapic_setup in the non-ACPI case
> isn't quite right.  This is set for "noapic".  But
> it is not set in the PIC-mode case where the kernel
> supports IOAPIC but the hardware does not -- in that
> case the quirk would erroneously exit.

Ah, right, thanks.  I changed it to:

	if (nr_ioapics && !skip_ioapic_setup)
		return;

Is that better?

> Also, the original quirk_via_irqpic()
> had a udelay(15) before the write -- I have no idea
> if that was significant or not -- maybe soembody else
> on the list does -- as none of us have VIA documentation...

Yes, I was worried about that, too.  I added it back.

> ps. we need to fix this on 2.4 also.

Here's yet another iteration for 2.6.  If this works OK,
I can back-port it to 2.4.


In PIC mode, some Via devices update IRQ routing when
PCI_INTERRUPT_LINE is written.  So if we've updated the
device's IRQ, we also need to update PCI_INTERRUPT_LINE.

This also restores the mysterious "udelay(15)" before the
update because we don't know whether it's necessary and
haven't seen an argument for its removal.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

===== arch/i386/pci/irq.c 1.55 vs edited =====
--- 1.55/arch/i386/pci/irq.c	2005-02-07 22:39:15 -07:00
+++ edited/arch/i386/pci/irq.c	2005-03-15 10:11:44 -07:00
@@ -1026,7 +1026,6 @@
 static int pirq_enable_irq(struct pci_dev *dev)
 {
 	u8 pin;
-	extern int via_interrupt_line_quirk;
 	struct pci_dev *temp_dev;
 
 	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
@@ -1081,10 +1080,6 @@
 		printk(KERN_WARNING "PCI: No IRQ known for interrupt pin %c of device %s.%s\n",
 		       'A' + pin, pci_name(dev), msg);
 	}
-	/* VIA bridges use interrupt line for apic/pci steering across
-	   the V-Link */
-	else if (via_interrupt_line_quirk)
-		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq & 15);
 	return 0;
 }
 
===== drivers/acpi/pci_irq.c 1.37 vs edited =====
--- 1.37/drivers/acpi/pci_irq.c	2005-03-01 09:57:29 -07:00
+++ edited/drivers/acpi/pci_irq.c	2005-03-15 10:10:57 -07:00
@@ -388,7 +388,6 @@
 	u8			pin = 0;
 	int			edge_level = ACPI_LEVEL_SENSITIVE;
 	int			active_high_low = ACPI_ACTIVE_LOW;
-	extern int		via_interrupt_line_quirk;
 
 	ACPI_FUNCTION_TRACE("acpi_pci_irq_enable");
 
@@ -437,9 +436,6 @@
 			return_VALUE(0);
 		}
  	}
-
-	if (via_interrupt_line_quirk)
-		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, irq & 15);
 
 	dev->irq = acpi_register_gsi(irq, edge_level, active_high_low);
 
===== drivers/pci/quirks.c 1.72 vs edited =====
--- 1.72/drivers/pci/quirks.c	2005-03-10 01:38:25 -07:00
+++ edited/drivers/pci/quirks.c	2005-03-24 11:07:19 -07:00
@@ -683,19 +683,41 @@
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82454NX,	quirk_disable_pxb );
 
-/*
- *	VIA northbridges care about PCI_INTERRUPT_LINE
- */
-int via_interrupt_line_quirk;
+#ifdef CONFIG_ACPI
+#include <linux/acpi.h>
+#endif
 
-static void __devinit quirk_via_bridge(struct pci_dev *pdev)
+static void __devinit quirk_via_irqpic(struct pci_dev *dev)
 {
-	if(pdev->devfn == 0) {
-		printk(KERN_INFO "PCI: Via IRQ fixup\n");
-		via_interrupt_line_quirk = 1;
+	u8 irq, new_irq;
+
+#ifdef CONFIG_X86_IO_APIC
+	if (nr_ioapics && !skip_ioapic_setup)
+		return;
+#endif
+#ifdef CONFIG_ACPI
+	if (acpi_irq_model != ACPI_IRQ_MODEL_PIC)
+		return;
+#endif
+	/*
+	 * Some Via devices make an internal connection to the PIC when the
+	 * PCI_INTERRUPT_LINE register is written.  If we've changed the
+	 * device's IRQ, we need to update this routing.
+	 *
+	 * I suspect this only happens for devices on the same chip as the
+	 * PIC, but I don't know how to identify those without listing them
+	 * all individually, which is a maintenance problem.
+	 */
+	new_irq = dev->irq & 0xf;
+	pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
+	if (new_irq != irq) {
+		printk(KERN_INFO "PCI: Via PIC IRQ fixup for %s, from %d to %d\n",
+			pci_name(dev), irq, new_irq);
+		udelay(15);
+		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, new_irq);
 	}
 }
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_ANY_ID,                     quirk_via_bridge );
+DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_ANY_ID, quirk_via_irqpic);
 
 /*
  *	Serverworks CSB5 IDE does not fully support native mode


