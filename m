Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289165AbSAQPXj>; Thu, 17 Jan 2002 10:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289168AbSAQPX1>; Thu, 17 Jan 2002 10:23:27 -0500
Received: from galba.tp1.ruhr-uni-bochum.de ([134.147.240.75]:57611 "EHLO
	galba.tp1.ruhr-uni-bochum.de") by vger.kernel.org with ESMTP
	id <S289165AbSAQPXG>; Thu, 17 Jan 2002 10:23:06 -0500
Date: Thu, 17 Jan 2002 16:22:48 +0100 (CET)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
To: Jes Sorensen <jes@wildopensource.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [patch] VAIO irq assignment fix
In-Reply-To: <15430.60214.968250.153045@trained-monkey.org>
Message-ID: <Pine.LNX.4.33.0201171620510.19753-100000@chaos.tp1.ruhr-uni-bochum.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jan 2002, Jes Sorensen wrote:

> I think it's in the ACPI table since a certain M$ OS finds the interrupt
> source. As I mentioned to Alan, I tried the latest ACPI patch but as you
> say, nothing is done with the information. I haven't tried enabling
> ACPI_DEBUG but that sounds to be a next step.

ACPI_DEBUG should print the table at least :)

My patch is appended, it applies on top of 2.4.17+acpi-20011218

--Kai

diff -X excl -urN linux-2.4.17.patches/arch/i386/kernel/pci-i386.h linux-2.4.17.work/arch/i386/kernel/pci-i386.h
--- linux-2.4.17.patches/arch/i386/kernel/pci-i386.h	Mon Jan 14 23:55:08 2002
+++ linux-2.4.17.work/arch/i386/kernel/pci-i386.h	Fri Dec 28 23:19:14 2001
@@ -21,6 +21,7 @@
 #define PCI_ASSIGN_ROMS		0x1000
 #define PCI_BIOS_IRQ_SCAN	0x2000
 #define PCI_ASSIGN_ALL_BUSSES	0x4000
+#define PCI_ACPI_IRQ		0x8000
 
 extern unsigned int pci_probe;
 
diff -X excl -urN linux-2.4.17.patches/arch/i386/kernel/pci-irq.c linux-2.4.17.work/arch/i386/kernel/pci-irq.c
--- linux-2.4.17.patches/arch/i386/kernel/pci-irq.c	Mon Jan 14 23:55:08 2002
+++ linux-2.4.17.work/arch/i386/kernel/pci-irq.c	Tue Jan  8 00:01:32 2002
@@ -512,6 +512,82 @@
 		pirq_router_dev->slot_name);
 }
 
+static void pcibios_test_irq_handler(int irq, void *dev_id, struct pt_regs *regs)
+{
+}
+
+#ifdef CONFIG_ACPI_PCI
+
+extern int acpi_pci_get_current_irq(struct pci_dev *dev, u8 pin, int *irq);
+extern int acpi_pci_set_current_irq(struct pci_dev *dev, u8 pin, int irq);
+extern int acpi_pci_get_possible_irq_mask(struct pci_dev *dev, u8 pin, int *mask);
+
+static int acpi_lookup_irq(struct pci_dev *dev, u8 pin, int assign)
+{
+	int  newirq, i, irq, retval;
+	char *msg = NULL;
+	u32 mask;
+
+	DBG("IRQ for %s:%d (%d)", dev->slot_name, pin, dev->irq);
+
+	retval = acpi_pci_get_current_irq(dev, pin, &irq);
+	if (retval < 0) {
+		DBG(" -> failed\n");
+		return 0;
+	}
+	DBG(" -> irq %d", irq);
+
+	retval = acpi_pci_get_possible_irq_mask(dev, pin, &mask);
+	if (retval < 0) {
+		DBG(" -> failed\n");
+		return 0;
+	}
+	DBG(" -> mask %04x", mask);
+	mask &= pcibios_irq_mask;
+
+
+	if (assign) {
+		/* Find the best IRQ to assign */
+		newirq = 0;
+		for (i = 0; i < 16; i++) {
+			if (!(mask & (1 << i)))
+				continue;
+			if (pirq_penalty[i] < pirq_penalty[newirq] &&
+			    !request_irq(i, pcibios_test_irq_handler, SA_SHIRQ, "pci-test", dev)) {
+				free_irq(i, dev);
+				newirq = i;
+			}
+		}
+		/* Use the current IRQ if possible */
+		if (irq && ((1 << irq) & mask))
+			newirq = irq;
+
+		DBG(" -> newirq=%d", newirq);
+		if (newirq && (dev->class >> 8) != PCI_CLASS_DISPLAY_VGA) {
+			DBG(" -> assigning IRQ %d", newirq);
+			if (acpi_pci_set_current_irq(dev, pin, newirq) == 0) {
+				eisa_set_level_irq(newirq);
+				DBG(" ... OK\n");
+				msg = "Assigned";
+				irq = newirq;
+			}
+		}
+	} else {
+		msg = "Found";
+	}
+
+	if (irq) {
+		printk(KERN_INFO "PCI: %s IRQ %d for device %s\n", msg, irq, dev->slot_name);
+
+		dev->irq = irq;
+		pirq_penalty[irq]++;
+		return 1;
+	}
+	return 0;
+}
+
+#endif
+
 static struct irq_info *pirq_get_info(struct pci_dev *dev)
 {
 	struct irq_routing_table *rt = pirq_table;
@@ -524,38 +600,25 @@
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
@@ -636,26 +699,47 @@
 	return 1;
 }
 
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
+	if (pci_probe & PCI_ACPI_IRQ)
+		return acpi_lookup_irq(dev, pin, assign);
+#endif
+	return pirq_lookup_irq(dev, pin, assign);
+}
+
 void __init pcibios_irq_init(void)
 {
 	DBG("PCI: IRQ init\n");
-	pirq_table = pirq_find_routing_table();
+	if (!(pci_probe & PCI_ACPI_IRQ)) {
+		pirq_table = pirq_find_routing_table();
 #ifdef CONFIG_PCI_BIOS
-	if (!pirq_table && (pci_probe & PCI_BIOS_IRQ_SCAN))
-		pirq_table = pcibios_get_irq_routing_table();
+		if (!pirq_table && (pci_probe & PCI_BIOS_IRQ_SCAN))
+			pirq_table = pcibios_get_irq_routing_table();
 #endif
-	if (pirq_table) {
-		pirq_peer_trick();
-		pirq_find_router();
-		if (pirq_table->exclusive_irqs) {
-			int i;
-			for (i=0; i<16; i++)
-				if (!(pirq_table->exclusive_irqs & (1 << i)))
-					pirq_penalty[i] += 100;
-		}
-		/* If we're using the I/O APIC, avoid using the PCI IRQ routing table */
-		if (io_apic_assign_pci_irqs)
-			pirq_table = NULL;
+		if (pirq_table) {
+			pirq_peer_trick();
+			pirq_find_router();
+			if (pirq_table->exclusive_irqs) {
+				int i;
+				for (i=0; i<16; i++)
+					if (!(pirq_table->exclusive_irqs & (1 << i)))
+						pirq_penalty[i] += 100;
+			}
+			/* If we're using the I/O APIC, avoid using the PCI IRQ routing table */
+			if (io_apic_assign_pci_irqs)
+				pirq_table = NULL;
+		}
 	}
 }
 
diff -X excl -urN linux-2.4.17.patches/arch/i386/kernel/pci-pc.c linux-2.4.17.work/arch/i386/kernel/pci-pc.c
--- linux-2.4.17.patches/arch/i386/kernel/pci-pc.c	Mon Jan 14 23:55:08 2002
+++ linux-2.4.17.work/arch/i386/kernel/pci-pc.c	Fri Dec 28 23:18:54 2001
@@ -1253,6 +1253,12 @@
 		return NULL;
 	}
 #endif
+#ifdef CONFIG_ACPI_PCI
+	else if (!strcmp(str, "acpiirq")) {
+		pci_probe |= PCI_ACPI_IRQ;
+		return NULL;
+	}
+#endif
 #ifdef CONFIG_PCI_DIRECT
 	else if (!strcmp(str, "conf1")) {
 		pci_probe = PCI_PROBE_CONF1 | PCI_NO_CHECKS;
diff -X excl -urN linux-2.4.17.patches/drivers/acpi/acpi_pci.c linux-2.4.17.work/drivers/acpi/acpi_pci.c
--- linux-2.4.17.patches/drivers/acpi/acpi_pci.c	Mon Jan 14 23:55:08 2002
+++ linux-2.4.17.work/drivers/acpi/acpi_pci.c	Mon Jan  7 23:22:46 2002
@@ -119,9 +119,10 @@
 	if ((0 != acpi_pci_get_status(handle, &sta)) || !(sta & 0x01))
 		return -ENODEV;
 
-#ifdef CONFIG_ACPI_DEBUG
-	printk(KERN_INFO "  link device currently %s\n", (sta & 0x02)?"enabled":"disabled");
-#endif
+	/* If disabled, return */
+
+	if (!(sta & 0x02))
+		return 0;
 
 	/* Get the current (default) IRQ assignment */
 
@@ -146,41 +147,167 @@
 
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
-			(*irq) = resource->data.irq.interrupts[0];
+		{
+			acpi_resource_irq *p = &resource->data.irq;
+
+			if (p->number_of_interrupts > 0) {
+				(*irq) = p->interrupts[0];
+			}
 			break;
+		}
 		case ACPI_RSTYPE_EXT_IRQ:
-			(*irq) = resource->data.irq.interrupts[0];
+		{
+			acpi_resource_ext_irq *p = &resource->data.extended_irq;
+			if (p->number_of_interrupts > 0) {
+				(*irq) = p->interrupts[0];
+			}
 			break;
 		}
+		}
 
 		if (*irq)
 			break;
 
+	next:
 		bytes_unparsed = bytes_unparsed - resource->length;
 		if (bytes_unparsed > 0)
 			resource = (acpi_resource*)((u8*)resource + resource->length);
 	}
 
-	if (!(*irq))
+	return 0;
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
 		return -ENODEV;
 
-	/* If disabled, enable by evaluating _SRS using default IRQ */
+	buffer.pointer = kmalloc(buffer.length, GFP_KERNEL);
+	if (!buffer.pointer)
+		return -ENOMEM;
+	memset(buffer.pointer, 0, buffer.length);
 
-	if (!(sta & 0x02)) {
-		acpi_buffer buffer = {resource->length, resource};
-		printk(KERN_INFO PREFIX "Enabling _PRT entry\n");
-		status = acpi_set_current_resources(handle, &buffer);
-		if (ACPI_FAILURE(status)) {
-			printk(KERN_WARNING PREFIX "Error evaluating _SRS, %s\n",
-				acpi_format_exception(status));
-			return -ENODEV;
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
+			break;
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
 		}
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
+		}
+
+	next:
+		bytes_unparsed = bytes_unparsed - resource->length;
+		if (bytes_unparsed > 0)
+			resource = (acpi_resource *)((u8 *)resource + resource->length);
 	}
+	
+	return -ENODEV;
+}
+  
+  
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
 
 	return 0;
 }
@@ -243,17 +370,15 @@
 
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
@@ -266,6 +391,92 @@
 }
 
 
+static acpi_pci_routing_table *
+acpi_pci_find_routing_table_entry(struct pci_dev *dev, u8 pin)
+{
+	int                     busnr = dev->bus->number;
+	acpi_pci_routing_table	*prt = NULL;
+
+	if (busnr >= ACPI_PCI_MAX_BUS)
+		return 0;
+
+	prt = (acpi_pci_routing_table *) acpi_prt.entry[busnr];
+	while (prt && prt->length > 0) {
+		if ((prt->address >> 16) == PCI_SLOT(dev->devfn) && prt->pin == pin)
+			return prt;
+		prt = (acpi_pci_routing_table *)
+			((u8 *) prt + prt->length);
+	}
+	return prt;
+}
+
+
+int
+acpi_pci_get_current_irq(struct pci_dev *dev, u8 pin, int *irq)
+{
+	acpi_pci_routing_table	*prt;
+
+	*irq = 0;
+
+	prt = acpi_pci_find_routing_table_entry(dev, pin);
+	if (!prt)
+		return -ENODEV;
+
+	/* Type 1 (dynamic)? */
+	if (prt->source) {
+		return acpi_pci_get_link_irq(prt->link_handle, 
+					     prt->source_index, irq);
+	} else {
+		*irq = prt->source_index;
+		return 0;
+	}
+}
+
+
+int
+acpi_pci_get_possible_irq_mask(struct pci_dev *dev, u8 pin, int *mask)
+{
+	acpi_pci_routing_table	*prt;
+
+	*mask = 0;
+
+	prt = acpi_pci_find_routing_table_entry(dev, pin);
+	if (!prt)
+		return -ENODEV;
+
+	/* Type 1 (dynamic)? */
+	if (prt->source) {
+		return acpi_pci_get_link_irq_mask(prt->link_handle,
+						  prt->source_index, mask);
+	} else {
+		*mask = 1 << prt->source_index;
+		return 0;
+	}
+}
+
+
+int
+acpi_pci_set_current_irq(struct pci_dev *dev, u8 pin, int irq)
+{
+	acpi_pci_routing_table	*prt;
+
+	prt = acpi_pci_find_routing_table_entry(dev, pin);
+	if (!prt)
+		return -ENODEV;
+
+	/* Type 1 (dynamic)? */
+	if (prt->source) {
+		return acpi_pci_set_link_irq(prt->link_handle,
+					     prt->source_index, irq);
+	} else {
+		if (irq != prt->source_index)
+			return -ENODEV;
+
+		return 0;
+	}
+}
+
+
 static acpi_status __init
 acpi_pci_resolve_bus (
 	acpi_handle		handle,
@@ -432,5 +643,3 @@
 	return 0;
 }
 
-
-
diff -X excl -urN linux-2.4.17.patches/drivers/acpi/include/actypes.h linux-2.4.17.work/drivers/acpi/include/actypes.h
--- linux-2.4.17.patches/drivers/acpi/include/actypes.h	Mon Jan 14 23:55:08 2002
+++ linux-2.4.17.work/drivers/acpi/include/actypes.h	Fri Dec 28 23:16:25 2001
@@ -1125,6 +1125,7 @@
 	u32                         pin;
 	acpi_integer                address;        /* here for 64-bit alignment */
 	u32                         source_index;
+	void                        *link_handle;
 	NATIVE_CHAR                 source[4];      /* pad to 64 bits so sizeof() works in all cases */
 
 } acpi_pci_routing_table;

