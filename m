Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262044AbTCZTiu>; Wed, 26 Mar 2003 14:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262047AbTCZTif>; Wed, 26 Mar 2003 14:38:35 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:26635 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262044AbTCZThR>; Wed, 26 Mar 2003 14:37:17 -0500
Date: Wed, 26 Mar 2003 19:48:27 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [BK PULL] (8/9) PCMCIA changes
Message-ID: <20030326194827.J8871@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20030326193427.B8871@flint.arm.linux.org.uk> <20030326193511.C8871@flint.arm.linux.org.uk> <20030326193537.D8871@flint.arm.linux.org.uk> <20030326193601.E8871@flint.arm.linux.org.uk> <20030326193625.F8871@flint.arm.linux.org.uk> <20030326194726.G8871@flint.arm.linux.org.uk> <20030326194747.H8871@flint.arm.linux.org.uk> <20030326194807.I8871@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030326194807.I8871@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Wed, Mar 26, 2003 at 07:48:07PM +0000
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.889.359.7 -> 1.889.359.8
#	drivers/pcmcia/cs_internal.h	1.8     -> 1.9    
#	drivers/pcmcia/cardbus.c	1.23.1.1 -> 1.23.1.2
#	drivers/pcmcia/cistpl.c	1.10    -> 1.11   
#	drivers/pci/Makefile	1.24    -> 1.25   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/03/23	rmk@flint.arm.linux.org.uk	1.889.359.8
# [PCMCIA] pcmcia-10: Make cardbus use the new PCI functionality.
# 
# Now that we have the critical PCI changes in place, we can convert
# cardbus to use this PCI functionality.  This allows us to scan
# behind PCI to PCI bridges on cardbus cards, and setup the bus
# resources using the generic PCI support code.
# 
# Note that drivers/pci/setup-bus.c needs to be built when hotplug
# (ie, cardbus) is enabled.
# --------------------------------------------
#
diff -Nru a/drivers/pci/Makefile b/drivers/pci/Makefile
--- a/drivers/pci/Makefile	Wed Mar 26 19:22:24 2003
+++ b/drivers/pci/Makefile	Wed Mar 26 19:22:24 2003
@@ -29,6 +29,9 @@
 obj-y += setup-bus.o
 endif
 
+# Hotplug (eg, cardbus) now requires setup-bus
+obj-$(CONFIG_HOTPLUG) += setup-bus.o
+
 ifndef CONFIG_X86
 obj-y += syscall.o
 endif
diff -Nru a/drivers/pcmcia/cardbus.c b/drivers/pcmcia/cardbus.c
--- a/drivers/pcmcia/cardbus.c	Wed Mar 26 19:22:24 2003
+++ b/drivers/pcmcia/cardbus.c	Wed Mar 26 19:22:24 2003
@@ -89,10 +89,6 @@
 #define PCDATA_CODE_TYPE	0x0014
 #define PCDATA_INDICATOR	0x0015
 
-typedef struct cb_config_t {
-	struct pci_dev *dev[8];
-} cb_config_t;
-
 /*=====================================================================
 
     Expansion ROM's have a special layout, and pointers specify an
@@ -175,11 +171,10 @@
 
 	DEBUG(3, "cs: read_cb_mem(%d, %#x, %u)\n", space, addr, len);
 
-	if (!s->cb_config)
+	dev = pci_find_slot(s->cap.cb_dev->subordinate->number, 0);
+	if (!dev)
 		goto fail;
 
-	dev = s->cb_config->dev[0];
-
 	/* Config space? */
 	if (space == 0) {
 		if (addr + len > 0x100)
@@ -221,109 +216,61 @@
     
 =====================================================================*/
 
-int cb_alloc(socket_info_t * s)
+/*
+ * Since there is only one interrupt available to CardBus
+ * devices, all devices downstream of this device must
+ * be using this IRQ.
+ */
+static void cardbus_assign_irqs(struct pci_bus *bus, int irq)
 {
-	struct pci_bus *bus;
-	u_short vend, v, dev;
-	u_char i, hdr, fn;
-	cb_config_t *c;
-	int irq;
-
-	bus = s->cap.cb_dev->subordinate;
-
-	pci_bus_read_config_word(bus, 0, PCI_VENDOR_ID, &vend);
-	pci_bus_read_config_word(bus, 0, PCI_DEVICE_ID, &dev);
-	printk(KERN_INFO "cs: cb_alloc(bus %d): vendor 0x%04x, "
-	       "device 0x%04x\n", bus->number, vend, dev);
-
-	pci_bus_read_config_byte(bus, 0, PCI_HEADER_TYPE, &hdr);
-	fn = 1;
-	if (hdr & 0x80) {
-		do {
-			if (pci_bus_read_config_word(bus, fn, PCI_VENDOR_ID, &v) ||
-			    !v || v == 0xffff)
-				break;
-			fn++;
-		} while (fn < 8);
-	}
-	s->functions = fn;
-
-	c = kmalloc(sizeof(struct cb_config_t), GFP_ATOMIC);
-	if (!c)
-		return CS_OUT_OF_RESOURCE;
- 	memset(c, 0, sizeof(struct cb_config_t));
-
-	for (i = 0; i < fn; i++) {
-		c->dev[i] = kmalloc(sizeof(struct pci_dev), GFP_ATOMIC);
-		if (!c->dev[i]) {
-			for (; i--; )
-				kfree(c->dev[i]);
-			kfree(c);
-			return CS_OUT_OF_RESOURCE;
-		}
-		memset(c->dev[i], 0, sizeof(struct pci_dev));
-	}
+	struct pci_dev *dev;
 
-	irq = s->cap.pci_irq;
-	for (i = 0; i < fn; i++) {
-		struct pci_dev *dev = c->dev[i];
+	list_for_each_entry(dev, &bus->devices, bus_list) {
 		u8 irq_pin;
-		int r;
 
-		dev->bus = bus;
-		dev->sysdata = bus->sysdata;
-		dev->dev.parent = bus->dev;
-		dev->dev.bus = &pci_bus_type;
-		dev->devfn = i;
-
-		pci_read_config_word(dev, PCI_VENDOR_ID, &dev->vendor);
-		pci_read_config_word(dev, PCI_DEVICE_ID, &dev->device);
-		dev->hdr_type = hdr & 0x7f;
-		dev->dma_mask = 0xffffffff;
-		dev->dev.dma_mask = &dev->dma_mask;
-
-		pci_setup_device(dev);
-
-		strcpy(dev->dev.bus_id, dev->slot_name);
-
-		/* We need to assign resources for expansion ROM. */
-		for (r = 0; r < 7; r++) {
-			struct resource *res = dev->resource + r;
-			if (res->flags)
-				pci_assign_resource(dev, r);
-		}
-
-		/* Does this function have an interrupt at all? */
 		pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &irq_pin);
-		if (irq_pin)
+		if (irq_pin) {
 			dev->irq = irq;
-		
-		/* pci_enable_device needs to be called after pci_assign_resource */
-		/* because it returns an error if (!res->start && res->end).      */
-		if (pci_enable_device(dev))
-			continue;
-
-		if (irq_pin)
-			pci_write_config_byte(dev, PCI_INTERRUPT_LINE, irq);
-		
-		device_register(&dev->dev);
-		pci_insert_device(dev, bus);
+			pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
+		}
+
+		if (dev->subordinate)
+			cardbus_assign_irqs(dev->subordinate, irq);
 	}
+}
+
+int cb_alloc(socket_info_t * s)
+{
+	struct pci_bus *bus = s->cap.cb_dev->subordinate;
+	struct pci_dev *dev;
+	unsigned int max, pass;
+
+	s->functions = pci_scan_slot(bus, PCI_DEVFN(0, 0));
+//	pcibios_fixup_bus(bus);
+
+	max = bus->secondary;
+	for (pass = 0; pass < 2; pass++)
+		list_for_each_entry(dev, &bus->devices, bus_list)
+			if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE ||
+			    dev->hdr_type == PCI_HEADER_TYPE_CARDBUS)
+				max = pci_scan_bridge(bus, dev, max, pass);
+
+	/*
+	 * Size all resources below the CardBus controller.
+	 */
+	pci_bus_size_bridges(bus);
+	pci_bus_assign_resources(bus);
+	cardbus_assign_irqs(bus, s->cap.pci_irq);
+	pci_enable_bridges(bus);
+	pci_bus_add_devices(bus);
 
-	s->cb_config = c;
-	s->irq.AssignedIRQ = irq;
+	s->irq.AssignedIRQ = s->cap.pci_irq;
 	return CS_SUCCESS;
 }
 
 void cb_free(socket_info_t * s)
 {
-	cb_config_t *c = s->cb_config;
+	struct pci_dev *bridge = s->cap.cb_dev;
 
-	if (c) {
-		s->cb_config = NULL;
-		pci_remove_behind_bridge(s->cap.cb_dev);
-
-		kfree(c);
-		printk(KERN_INFO "cs: cb_free(bus %d)\n", s->cap.cb_dev->subordinate->number);
-	}
+	pci_remove_behind_bridge(bridge);
 }
diff -Nru a/drivers/pcmcia/cistpl.c b/drivers/pcmcia/cistpl.c
--- a/drivers/pcmcia/cistpl.c	Wed Mar 26 19:22:24 2003
+++ b/drivers/pcmcia/cistpl.c	Wed Mar 26 19:22:24 2003
@@ -396,11 +396,9 @@
     tuple->TupleLink = tuple->Flags = 0;
 #ifdef CONFIG_CARDBUS
     if (s->state & SOCKET_CARDBUS) {
+	struct pci_dev *dev = s->cap.cb_dev;
 	u_int ptr;
-	struct pci_dev *dev = pci_find_slot (s->cap.cb_dev->subordinate->number, 0);
-	if (!dev)
-	    return CS_BAD_HANDLE;
-	pci_read_config_dword(dev, 0x28, &ptr);
+	pci_bus_read_config_dword(dev->subordinate, 0, PCI_CARDBUS_CIS, &ptr);
 	tuple->CISOffset = ptr & ~7;
 	SPACE(tuple->Flags) = (ptr & 7);
     } else
diff -Nru a/drivers/pcmcia/cs_internal.h b/drivers/pcmcia/cs_internal.h
--- a/drivers/pcmcia/cs_internal.h	Wed Mar 26 19:22:24 2003
+++ b/drivers/pcmcia/cs_internal.h	Wed Mar 26 19:22:24 2003
@@ -136,7 +136,6 @@
 #ifdef CONFIG_CARDBUS
     struct resource *		cb_cis_res;
     u_char			*cb_cis_virt;
-    struct cb_config_t		*cb_config;
 #endif
     struct {
 	u_int			AssignedIRQ;

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

