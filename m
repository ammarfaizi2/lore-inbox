Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262000AbVCRSH5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262000AbVCRSH5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 13:07:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262011AbVCRSH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 13:07:56 -0500
Received: from atlrel6.hp.com ([156.153.255.205]:9648 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S262000AbVCRSHc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 13:07:32 -0500
Subject: Re: [ACPI] Re: Fw: Anybody? 2.6.11 (stable and -rc) ACPI breaks USB
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Li Shaohua <shaohua.li@intel.com>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Grzegorz Kulewski <kangur@polcom.net>, Andrew Morton <akpm@osdl.org>,
       ACPI List <acpi-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>
In-Reply-To: <1111108150.22239.6.camel@sli10-desk.sh.intel.com>
References: <1110989436.8378.19.camel@eeyore>
	 <1111023217.15278.7.camel@sli10-desk.sh.intel.com>
	 <1111082914.11380.30.camel@eeyore>
	 <1111108150.22239.6.camel@sli10-desk.sh.intel.com>
Content-Type: text/plain
Date: Fri, 18 Mar 2005 11:07:19 -0700
Message-Id: <1111169239.13286.39.camel@eeyore>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-03-18 at 09:09 +0800, Li Shaohua wrote:
> On Fri, 2005-03-18 at 02:08, Bjorn Helgaas wrote:
> > On Thu, 2005-03-17 at 09:33 +0800, Li Shaohua wrote:
> > > The comments in previous quirk said it's required only in PIC mode.
> > ...
> > > I feel we concerned too much. Changing the interrupt line isn't harmful,
> > > right? Linux actually ignored interrupt line. Maybe just a
> > > PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_ANY_ID, quirk_via_irq) is
> > > sufficient.
> > 
> > I think it's good to limit the scope of the quirk as much as
> > possible because that makes it easier to do future restructuring,
> > such as device-specific interrupt routers.
> > 
> > The comment (before quirk_via_acpi(), nowhere near quirk_via_irqpic())
> > says *on-chip devices* have this unusual behavior when the interrupt
> > line is written.  That makes sense to me.
> > 
> > Writing the interrupt line on random plug-in Via PCI devices does
> > not make sense to me, because for that to have any effect, an
> > upstream bridge would have to be snooping the traffic going through
> > it.  That doesn't sound plausible to me.
> > 
> > What about this:
> Hmm, this looks like previous solution. We removed the specific via
> quirk is because we don't know how many devices have such issue. Every
> time we encounter an IRQ issue in a VIA PCI device, we will suspect it
> requires quirk and keep try. This is a big overhead. 

OK.  Try this one for size.  It differs from what's currently in
the tree in these ways:

    - It's a quirk, so we don't have to clutter acpi_pci_irq_enable()
      and pirq_enable_irq() with Via-specific code.

    - It doesn't do anything unless we're in PIC mode.  The comment
      suggests this issue only affects PIC routing.

    - We do this for ALL Via devices.  The current code in the tree
      does it for all devices in the system IF there is a Via device
      with devfn==0, which misses Grzegorz's case.

Does anybody have a pointer to a spec that talks about this?  It'd
be awfully nice to have a reference.

Grzegorz, can you check to make sure this still works after all the
tweaking?

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
+++ edited/drivers/pci/quirks.c	2005-03-18 10:55:01 -07:00
@@ -683,19 +683,40 @@
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
+	if (skip_ioapic_setup)
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
+		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, new_irq);
 	}
 }
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_ANY_ID,                     quirk_via_bridge );
+DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_ANY_ID, quirk_via_irqpic);
 
 /*
  *	Serverworks CSB5 IDE does not fully support native mode


