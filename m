Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285790AbRLHJmZ>; Sat, 8 Dec 2001 04:42:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284314AbRLHJmJ>; Sat, 8 Dec 2001 04:42:09 -0500
Received: from d-dialin-2699.addcom.de ([213.61.81.59]:20718 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S282962AbRLHJlu>; Sat, 8 Dec 2001 04:41:50 -0500
Date: Sat, 8 Dec 2001 10:40:11 +0100 (CET)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: <kai@vaio>
To: "Grover, Andrew" <andrew.grover@intel.com>
cc: "Acpi-linux (E-mail 2)" <acpi-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, Cory Bell <cory.bell@usa.net>,
        John Clemens <john@deater.net>
Subject: ACPI IRQ routing (was [ACPI] ACPI source release updated (20011205))
In-Reply-To: <59885C5E3098D511AD690002A5072D3C42D7A6@orsmsx111.jf.intel.com>
Message-ID: <Pine.LNX.4.33.0112080919490.1300-100000@vaio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[CC'ed lkml because lately there's been reports of incorrect $PIRQ tables,
 maybe people want to try this (experimental) patch]

On Wed, 5 Dec 2001, Grover, Andrew wrote:

> 1) As mentioned below, we get _PRT information on IA32 (and print it if
> ACPI_DEBUG is set) but do not yet actually *use* it. If someone wanted to
> help out, changing pci-irq.c to use this information would be very much
> appreciated.

I changed pci-irq.c to use the ACPI interrupt routing, and also added 
dynamic routing table support. The appended patch is a bit preliminary, 
but it works here, even for assigning irqs.

If you want to test it out, apply the latest ACPI patch (20011205) first, 
then the appended patch and select the ACPI PCI IRQ config option.

Further comments/to do:
o The ACPI PCI in general needs further cleanup and integration with the 
  normal PCI layer. I believe that should wait until the new device 
  infrastructure is in place, though. E.g., I think one can
  get rid of the static table which is currently setup in acpi_pci.c. 

o I'm not exactly happy with the way ACPI does things currently, but I
  didn't change it to keep the patch small. It uses multiple functions
  to parse the IRQ resource descriptor into a linked list of 
  "acpi_resource" which I then again have to convert back into the
  mask which was in the IRQ resource desriptor in the first place.
  About the same holds for the other way, instead of just setting
  up a five byte IRQ descriptor, I need to setup two "acpi_resource" 
  structs, calculate lengths, etc. which will eventually be converted to
  just the five bytes. IMO the conversion routines are unnecessary 
  bloat...	

o Things need to be made dynamic, i.e. try ACPI and if it doesn't work,
  fall back to the normal method. Also, a command line flag to disable
  acpi irq routing is probably a good idea.

o it probably will not fix the problem mentioned on lkml. Interesting 
  would be to see if changing

	newirq = dev->irq;
	if (!newirq && assign) {

to

	newirq = dev->irq;
	if (!((1 << newirq) & mask))
 		newirq = 0;
	if (!newirq && assign) {

helps
	
--Kai

diff -X excl -urN linux-2.4.17-pre4.patches/arch/i386/kernel/pci-i386.h linux-2.4.17-pre4.work/arch/i386/kernel/pci-i386.h
--- linux-2.4.17-pre4.patches/arch/i386/kernel/pci-i386.h	Sun Nov 11 19:09:32 2001
+++ linux-2.4.17-pre4.work/arch/i386/kernel/pci-i386.h	Fri Dec  7 14:42:55 2001
@@ -4,7 +4,7 @@
  *	(c) 1999 Martin Mares <mj@ucw.cz>
  */
 
-#undef DEBUG
+#define DEBUG
 
 #ifdef DEBUG
 #define DBG(x...) printk(x)
diff -X excl -urN linux-2.4.17-pre4.patches/arch/i386/kernel/pci-irq.c linux-2.4.17-pre4.work/arch/i386/kernel/pci-irq.c
--- linux-2.4.17-pre4.patches/arch/i386/kernel/pci-irq.c	Sun Nov  4 18:31:58 2001
+++ linux-2.4.17-pre4.work/arch/i386/kernel/pci-irq.c	Sat Dec  8 09:41:23 2001
@@ -512,6 +512,78 @@
 		pirq_router_dev->slot_name);
 }
 
+static void pcibios_test_irq_handler(int irq, void *dev_id, struct pt_regs *regs)
+{
+}
+
+#ifdef CONFIG_ACPI_PCI
+
+extern int acpi_pci_get_current_irq(struct pci_dev *dev, u8 pin);
+extern int acpi_pci_set_current_irq(struct pci_dev *dev, u8 pin, int irq);
+extern int acpi_pci_get_possible_irq_mask(struct pci_dev *dev, u8 pin);
+
+static int acpi_lookup_irq(struct pci_dev *dev, u8 pin, int assign)
+{
+	int  newirq, i, irq = 0;
+	char *msg = NULL;
+	u32 mask;
+
+	DBG("IRQ for %s:%d (%d)", dev->slot_name, pin, dev->irq);
+
+	irq = acpi_pci_get_current_irq(dev, pin);
+	mask = acpi_pci_get_possible_irq_mask(dev, pin);
+	DBG(" -> mask %04x (%d)", mask, irq);
+	mask &= pcibios_irq_mask;
+
+	/*
+	 * Find the best IRQ to assign: use the one
+	 * reported by the device if possible.
+	 */
+	newirq = dev->irq;
+	if (!newirq && assign) {
+		for (i = 0; i < 16; i++) {
+			if (!(mask & (1 << i)))
+				continue;
+			if (pirq_penalty[i] < pirq_penalty[newirq] &&
+			    !request_irq(i, pcibios_test_irq_handler, SA_SHIRQ, "pci-test", dev)) {
+				free_irq(i, dev);
+				newirq = i;
+			}
+		}
+	}
+	DBG(" -> newirq=%d", newirq);
+
+	if (irq) {
+		DBG(" -> got IRQ %d\n", irq);
+		msg = "Found";
+	} else if (newirq && (dev->class >> 8) != PCI_CLASS_DISPLAY_VGA) {
+		DBG(" -> assigning IRQ %d", newirq);
+		if (acpi_pci_set_current_irq(dev, pin, newirq)) {
+			eisa_set_level_irq(newirq);
+			DBG(" ... OK\n");
+			msg = "Assigned";
+			irq = newirq;
+		}
+	}
+
+	if (!irq) {
+		DBG(" ... failed\n");
+		if (newirq && mask == (1 << newirq)) {
+			msg = "Guessed";
+			irq = newirq;
+		} else
+			return 0;
+	}
+	printk(KERN_INFO "PCI: %s IRQ %d for device %s\n", msg, irq, dev->slot_name);
+
+	dev->irq = irq;
+	pirq_penalty[irq]++;
+
+	return 1;
+}
+
+#else
+
 static struct irq_info *pirq_get_info(struct pci_dev *dev)
 {
 	struct irq_routing_table *rt = pirq_table;
@@ -524,38 +596,25 @@
 	return NULL;
 }
 
-static void pcibios_test_irq_handler(int irq, void *dev_id, struct pt_regs *regs)
-{
-}
-
-static int pcibios_lookup_irq(struct pci_dev *dev, int assign)
+static int pirq_lookup_irq(struct pci_dev *dev, u8 pin, int assign)
 {
-	u8 pin;
-	struct irq_info *info;
-	int i, pirq, newirq;
-	int irq = 0;
-	u32 mask;
 	struct irq_router *r = pirq_router;
+	struct irq_info *info;
+	int  newirq, pirq, i, irq = 0;
 	struct pci_dev *dev2;
 	char *msg = NULL;
+	u32 mask;
 
 	if (!pirq_table)
 		return 0;
 
-	/* Find IRQ routing entry */
-	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
-	if (!pin) {
-		DBG(" -> no interrupt pin\n");
-		return 0;
-	}
-	pin = pin - 1;
-	
 	DBG("IRQ for %s:%d", dev->slot_name, pin);
 	info = pirq_get_info(dev);
 	if (!info) {
 		DBG(" -> not found in routing table\n");
 		return 0;
 	}
+
 	pirq = info->irq[pin].link;
 	mask = info->irq[pin].bitmap;
 	if (!pirq) {
@@ -635,10 +694,31 @@
 	}
 	return 1;
 }
+#endif
+
+static int pcibios_lookup_irq(struct pci_dev *dev, int assign)
+{
+	u8 pin;
+
+	/* Find IRQ routing entry */
+	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
+	if (!pin) {
+		DBG("PCI: %s: no interrupt pin\n", dev->slot_name);
+		return 0;
+	}
+	pin -= 1;
+
+#ifdef CONFIG_ACPI_PCI
+	return acpi_lookup_irq(dev, pin, assign);
+#else
+	return pirq_lookup_irq(dev, pin, assign);
+#endif
+}
 
 void __init pcibios_irq_init(void)
 {
 	DBG("PCI: IRQ init\n");
+#ifndef CONFIG_ACPI_PCI
 	pirq_table = pirq_find_routing_table();
 #ifdef CONFIG_PCI_BIOS
 	if (!pirq_table && (pci_probe & PCI_BIOS_IRQ_SCAN))
@@ -657,6 +737,7 @@
 		if (io_apic_assign_pci_irqs)
 			pirq_table = NULL;
 	}
+#endif
 }
 
 void __init pcibios_fixup_irqs(void)
diff -X excl -urN linux-2.4.17-pre4.patches/drivers/acpi/acpi_pci.c linux-2.4.17-pre4.work/drivers/acpi/acpi_pci.c
--- linux-2.4.17-pre4.patches/drivers/acpi/acpi_pci.c	Fri Dec  7 12:12:47 2001
+++ linux-2.4.17-pre4.work/drivers/acpi/acpi_pci.c	Sat Dec  8 09:52:49 2001
@@ -111,35 +111,173 @@
 
 	while (resource && (bytes_unparsed > 0)) {
 
-		if (index != i++)
-			continue;
+		switch (resource->id) {
+		case ACPI_RSTYPE_START_DPF:
+		case ACPI_RSTYPE_END_DPF:
+			break;
+		default:
+			i++;
+		}
+
+		if (i <= index)
+			goto next;
 
 		switch (resource->id) {
 		case ACPI_RSTYPE_IRQ:
 		{
 			acpi_resource_irq *p = &resource->data.irq;
-			(*irq) = p->interrupts[0];
+
+			if (p->number_of_interrupts > 0)
+				(*irq) = p->interrupts[0];
+			else
+				(*irq) = 0;
+
 			return 0;
 		}
-			break;
 		case ACPI_RSTYPE_EXT_IRQ:
 		{
 			acpi_resource_ext_irq *p = &resource->data.extended_irq;
-			(*irq) = p->interrupts[0];
+			if (p->number_of_interrupts > 0)
+				(*irq) = p->interrupts[0];
+			else
+				(*irq) = 0;
 			return 0;
 		}
+		}
+
+	next:
+		bytes_unparsed = bytes_unparsed - resource->length;
+		if (bytes_unparsed > 0)
+			resource = (acpi_resource *)
+				((u8 *)resource + resource->length);
+	}
+	
+	return -ENODEV;
+}
+
+
+static int
+acpi_pci_get_link_irq_mask (
+	acpi_handle		handle,
+	u32 			index,
+	u32			*mask)
+{
+	acpi_status		status = AE_OK;
+	acpi_buffer		buffer = {0, NULL};
+	acpi_resource		*resource = NULL;
+	int			bytes_unparsed = 0;
+	int			i = 0;
+
+	if (!handle || !mask)
+		return -EINVAL;
+
+	status = acpi_get_possible_resources(handle, &buffer);
+	if (status != AE_BUFFER_OVERFLOW)
+		return -ENODEV;
+
+	buffer.pointer = kmalloc(buffer.length, GFP_KERNEL);
+	if (!buffer.pointer)
+		return -ENOMEM;
+	memset(buffer.pointer, 0, buffer.length);
+
+	status = acpi_get_possible_resources(handle, &buffer);
+	if (ACPI_FAILURE(status)) {
+		kfree(buffer.pointer);
+		return -ENODEV;
+	}
+
+	resource = (acpi_resource *) buffer.pointer;
+
+	bytes_unparsed = buffer.length - 16;
+
+	while (resource && (bytes_unparsed > 0)) {
+
+		switch (resource->id) {
+		case ACPI_RSTYPE_START_DPF:
+		case ACPI_RSTYPE_END_DPF:
 			break;
+		default:
+			i++;
+		}
+
+		if (i <= index)
+			goto next;
+
+		switch (resource->id) {
+		case ACPI_RSTYPE_IRQ:
+		{
+			acpi_resource_irq *p = &resource->data.irq;
+			int j;
+			
+			*mask = 0;
+			for (j = 0; j < p->number_of_interrupts; j++) {
+				(*mask) |= (1 << p->interrupts[j]);
+			}
+			return 0;
+		}
+		case ACPI_RSTYPE_EXT_IRQ:
+		{
+			acpi_resource_ext_irq *p = &resource->data.extended_irq;
+			int j;
+			
+			*mask = 0;
+			for (j = 0; j < p->number_of_interrupts; j++) {
+				(*mask) |= (1 << p->interrupts[j]);
+			}
+			return 0;
+		}
 		}
 
+	next:
 		bytes_unparsed = bytes_unparsed - resource->length;
 		if (bytes_unparsed > 0)
-			resource = (acpi_resource*)((u8*)resource + resource->length);
+			resource = (acpi_resource *)((u8 *)resource + resource->length);
 	}
 	
 	return -ENODEV;
 }
 
 
+static int
+acpi_pci_set_link_irq (
+	acpi_handle		handle,
+	u32 			index,
+	u32			irq)
+{
+	acpi_status		status = AE_OK;
+	acpi_buffer		buffer = {0, NULL};
+	struct {
+		acpi_resource	res;
+		acpi_resource   end;
+	}                       resource;
+	int			bytes_unparsed = 0;
+	int			i = 0;
+
+
+	if (!handle)
+		return -EINVAL;
+
+	memset(&resource, 0, sizeof(resource));
+	resource.res.id = ACPI_RSTYPE_IRQ;
+	resource.res.length = sizeof(acpi_resource);
+	resource.res.data.irq.edge_level = 0; // FIXME?
+	resource.res.data.irq.active_high_low = 0;
+	resource.res.data.irq.shared_exclusive = 1;
+	resource.res.data.irq.number_of_interrupts = 1;
+	resource.res.data.irq.interrupts[0] = irq;
+	resource.end.id = ACPI_RSTYPE_END_TAG;
+
+	buffer.pointer = &resource;
+	buffer.length = resource.res.length + 1;
+	status = acpi_set_current_resources(handle, &buffer);
+
+	if (status != AE_OK)
+		return -ENODEV;
+
+	return 0;
+}
+
+
 static acpi_status __init
 acpi_pci_parse_prt (
 	acpi_handle		handle,
@@ -148,6 +286,7 @@
 	acpi_buffer		buffer = {0, NULL};
 	acpi_status		status = AE_OK;
 	pci_routing_table	*prt = NULL;
+	int tmp, retval;
 
 	if (bus > ACPI_PCI_MAX_BUS)
 		return -EINVAL;
@@ -197,17 +336,15 @@
 
 		/* Type 1 (dynamic)? */
 		if (prt->source) {
-			acpi_handle link_handle = NULL;
-			acpi_get_handle(handle, prt->source, &link_handle);
-			acpi_pci_get_link_irq(link_handle, prt->source_index, 
-				&prt->source_index);
-			prt->source[0] = 0;
+			prt->link_handle = NULL;
+			acpi_get_handle(handle, prt->source, &prt->link_handle);
+/* 			prt->source[0] = 0; */
 		}
 
 #ifdef CONFIG_ACPI_DEBUG
-		printk(KERN_INFO "  device=%02x pin=%02x irq=%d\n", 
+		printk(KERN_INFO "  device=%02x pin=%02x source=%s source_index=%d\n", 
 			(u32)(prt->address>>16), (u32)prt->pin, 
-			(u32)prt->source_index);
+			prt->source, (u32)prt->source_index);
 #endif /*CONFIG_ACPI_DEBUG*/
 
 		acpi_prt.count++;
@@ -220,6 +357,90 @@
 }
 
 
+static pci_routing_table *
+acpi_pci_find_routing_table_entry(struct pci_dev *dev, u8 pin)
+{
+	int                     busnr = dev->bus->number;
+	pci_routing_table	*prt = NULL;
+
+	if (busnr >= ACPI_PCI_MAX_BUS)
+		return 0;
+
+	prt = (pci_routing_table *) acpi_prt.entry[busnr];
+	while (prt && prt->length > 0) {
+		if ((prt->address >> 16) == PCI_SLOT(dev->devfn) && prt->pin == pin)
+			return prt;
+		prt = (pci_routing_table *)
+			((u8 *) prt + prt->length);
+	}
+	return prt;
+}
+
+
+int
+acpi_pci_get_current_irq(struct pci_dev *dev, u8 pin)
+{
+	int                     irq;
+	pci_routing_table	*prt;
+
+	prt = acpi_pci_find_routing_table_entry(dev, pin);
+	if (!prt)
+		return 0;
+
+	/* Type 1 (dynamic)? */
+	if (prt->source) {
+		acpi_pci_get_link_irq(prt->link_handle, prt->source_index, 
+				      &irq);
+		return irq;
+	} else {
+		irq = prt->source_index;
+		return irq;
+	}
+}
+
+
+int
+acpi_pci_get_possible_irq_mask(struct pci_dev *dev, u8 pin)
+{
+	int                     mask = 0;
+	pci_routing_table	*prt;
+
+	prt = acpi_pci_find_routing_table_entry(dev, pin);
+	if (!prt)
+		return 0;
+
+	/* Type 1 (dynamic)? */
+	if (prt->source) {
+		acpi_pci_get_link_irq_mask(prt->link_handle,
+					   prt->source_index, &mask);
+		return mask;
+	} else {
+		mask = 1 << prt->source_index;
+		return mask;
+	}
+}
+
+
+int
+acpi_pci_set_current_irq(struct pci_dev *dev, u8 pin, int irq)
+{
+	pci_routing_table	*prt;
+
+	prt = acpi_pci_find_routing_table_entry(dev, pin);
+	if (!prt)
+		return 0;
+
+	/* Type 1 (dynamic)? */
+	if (prt->source) {
+		acpi_pci_set_link_irq(prt->link_handle, prt->source_index, 
+				      irq);
+		return 1;
+	}
+	
+	return 0;
+}
+
+
 static acpi_status __init
 acpi_pci_resolve_bus (
 	acpi_handle		handle,
@@ -356,8 +577,6 @@
 {
 	acpi_status		status = AE_OK;
 
-	memset(&acpi_prt, 0, sizeof(acpi_prt));
-
 	/* Find and parse all PCI root bridge devices */
 
 	status = acpi_get_devices("PNP0A03", acpi_pci_root_callback, NULL, NULL);
@@ -369,5 +588,3 @@
 	return 0;
 }
 
-
-
diff -X excl -urN linux-2.4.17-pre4.patches/drivers/acpi/include/actypes.h linux-2.4.17-pre4.work/drivers/acpi/include/actypes.h
--- linux-2.4.17-pre4.patches/drivers/acpi/include/actypes.h	Fri Dec  7 12:12:48 2001
+++ linux-2.4.17-pre4.work/drivers/acpi/include/actypes.h	Fri Dec  7 16:50:02 2001
@@ -1117,8 +1117,8 @@
 	u32                         pin;
 	acpi_integer                address;        /* here for 64-bit alignment */
 	u32                         source_index;
+	void                        *link_handle;
 	NATIVE_CHAR                 source[4];      /* pad to 64 bits so sizeof() works in all cases */
-
 } pci_routing_table;
 
 
diff -X excl -urN linux-2.4.17-pre4.patches/drivers/pci/pci.c linux-2.4.17-pre4.work/drivers/pci/pci.c
--- linux-2.4.17-pre4.patches/drivers/pci/pci.c	Wed Nov 21 06:53:29 2001
+++ linux-2.4.17-pre4.work/drivers/pci/pci.c	Fri Dec  7 14:42:44 2001
@@ -27,7 +27,7 @@
 #include <asm/page.h>
 #include <asm/dma.h>	/* isa_dma_bridge_buggy */
 
-#undef DEBUG
+#define DEBUG
 
 #ifdef DEBUG
 #define DBG(x...) printk(x)



