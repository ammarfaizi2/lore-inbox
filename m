Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266968AbTCEA3Y>; Tue, 4 Mar 2003 19:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266987AbTCEA3X>; Tue, 4 Mar 2003 19:29:23 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:23570 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266968AbTCEA3N>; Tue, 4 Mar 2003 19:29:13 -0500
Date: Wed, 5 Mar 2003 00:39:40 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [CFT] PCI probing for cardbus (2/5)
Message-ID: <20030305003940.C25251@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20030305003635.A25251@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030305003635.A25251@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Wed, Mar 05, 2003 at 12:36:35AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ur orig/drivers/hotplug/acpiphp_glue.c linux/drivers/hotplug/acpiphp_glue.c
--- orig/drivers/hotplug/acpiphp_glue.c	Tue Feb 11 16:10:08 2003
+++ linux/drivers/hotplug/acpiphp_glue.c	Mon Feb 24 11:28:46 2003
@@ -879,7 +879,7 @@
 static int enable_device (struct acpiphp_slot *slot)
 {
 	u8 bus;
-	struct pci_dev dev0, *dev;
+	struct pci_dev *dev;
 	struct pci_bus *child;
 	struct list_head *l;
 	struct acpiphp_func *func;
@@ -902,16 +902,8 @@
 	if (retval)
 		goto err_exit;
 
-	memset(&dev0, 0, sizeof (struct pci_dev));
-
-	dev0.bus = slot->bridge->pci_bus;
-	dev0.devfn = PCI_DEVFN(slot->device, 0);
-	dev0.sysdata = dev0.bus->sysdata;
-	dev0.dev.parent = dev0.bus->dev;
-	dev0.dev.bus = &pci_bus_type;
-
 	/* returned `dev' is the *first function* only! */
-	dev = pci_scan_slot (&dev0);
+	dev = pci_scan_slot(slot->bridge->pci_bus, PCI_DEVFN(slot->device, 0));
 
 	if (!dev) {
 		err("No new device found\n");
diff -ur orig/drivers/hotplug/cpci_hotplug_pci.c linux/drivers/hotplug/cpci_hotplug_pci.c
--- orig/drivers/hotplug/cpci_hotplug_pci.c	Tue Feb 11 16:10:08 2003
+++ linux/drivers/hotplug/cpci_hotplug_pci.c	Mon Feb 24 11:29:36 2003
@@ -601,19 +601,13 @@
 
 	/* Still NULL? Well then scan for it! */
 	if(slot->dev == NULL) {
-		struct pci_dev dev0;
-
 		dbg("pci_dev still null");
-		memset(&dev0, 0, sizeof (struct pci_dev));
-		dev0.bus = slot->bus;
-		dev0.devfn = slot->devfn;
-		dev0.sysdata = slot->bus->self->sysdata;
 
 		/*
 		 * This will generate pci_dev structures for all functions, but
 		 * we will only call this case when lookup fails.
 		 */
-		slot->dev = pci_scan_slot(&dev0);
+		slot->dev = pci_scan_slot(slot->bus, slot->devfn);
 		if(slot->dev == NULL) {
 			err("Could not find PCI device for slot %02x", slot->number);
 			return 0;
diff -ur orig/drivers/hotplug/cpqphp_pci.c linux/drivers/hotplug/cpqphp_pci.c
--- orig/drivers/hotplug/cpqphp_pci.c	Tue Feb 11 16:10:09 2003
+++ linux/drivers/hotplug/cpqphp_pci.c	Mon Feb 24 11:31:07 2003
@@ -250,7 +250,6 @@
 int cpqhp_configure_device (struct controller* ctrl, struct pci_func* func)  
 {
 	unsigned char bus;
-	struct pci_dev dev0;
 	struct pci_bus *child;
 	struct pci_dev* temp;
 	int rc = 0;
@@ -260,20 +259,16 @@
 	memset(&wrapped_dev, 0, sizeof(struct pci_dev_wrapped));
 	memset(&wrapped_bus, 0, sizeof(struct pci_bus_wrapped));
 
-	memset(&dev0, 0, sizeof(struct pci_dev));
-
 	if (func->pci_dev == NULL)
 		func->pci_dev = pci_find_slot(func->bus, (func->device << 3) | (func->function & 0x7));
 
 	//Still NULL ? Well then scan for it !
 	if (func->pci_dev == NULL) {
 		dbg("INFO: pci_dev still null\n");
-		dev0.bus = ctrl->pci_dev->bus;
-		dev0.devfn = (func->device << 3) + (func->function & 0x7);
-		dev0.sysdata = ctrl->pci_dev->sysdata;
 
 		//this will generate pci_dev structures for all functions, but we will only call this case when lookup fails
-		func->pci_dev = pci_scan_slot(&dev0);
+		func->pci_dev = pci_scan_slot(ctrl->pci_dev->bus,
+				 (func->device << 3) + (func->function & 0x7));
 		if (func->pci_dev == NULL) {
 			dbg("ERROR: pci_dev still null\n");
 			return 0;
diff -ur orig/drivers/hotplug/ibmphp_core.c linux/drivers/hotplug/ibmphp_core.c
--- orig/drivers/hotplug/ibmphp_core.c	Tue Feb 11 16:10:09 2003
+++ linux/drivers/hotplug/ibmphp_core.c	Mon Feb 24 11:32:11 2003
@@ -1035,7 +1035,6 @@
 static int ibm_configure_device (struct pci_func *func)
 {
 	unsigned char bus;
-	struct pci_dev dev0;
 	struct pci_bus *child;
 	struct pci_dev *temp;
 	int rc = 0;
@@ -1046,7 +1045,6 @@
 
 	memset (&wrapped_dev, 0, sizeof (struct pci_dev_wrapped));
 	memset (&wrapped_bus, 0, sizeof (struct pci_bus_wrapped));
-	memset (&dev0, 0, sizeof (struct pci_dev));
 
 	if (!(bus_structure_fixup (func->busno)))
 		flag = 1;
@@ -1054,13 +1052,12 @@
 		func->dev = pci_find_slot (func->busno, (func->device << 3) | (func->function & 0x7));
 
 	if (func->dev == NULL) {
-		dev0.bus = ibmphp_find_bus (func->busno);
-		if (!dev0.bus)
+		struct pci_bus *bus = ibmphp_find_bus (func->busno);
+		if (!bus)
 			return 0;
-		dev0.devfn = ((func->device << 3) + (func->function & 0x7));
-		dev0.sysdata = dev0.bus->sysdata;
 
-		func->dev = pci_scan_slot (&dev0);
+		func->dev = pci_scan_slot(bus,
+				 (func->device << 3) + (func->function & 0x7));
 
 		if (func->dev == NULL) {
 			err ("ERROR... : pci_dev still NULL \n");
--- orig/drivers/pci/probe.c	Mon Jan 13 22:32:31 2003
+++ linux/drivers/pci/probe.c	Mon Feb 24 14:01:48 2003
@@ -374,7 +374,8 @@
 	dev->class = class;
 	class >>= 8;
 
-	DBG("Found %02x:%02x [%04x/%04x] %06x %02x\n", dev->bus->number, dev->devfn, dev->vendor, dev->device, class, dev->hdr_type);
+	DBG("Found %02x:%02x [%04x/%04x] %06x %02x\n", dev->bus->number, dev->devfn,
+		dev->vendor, dev->device, class, dev->hdr_type);
 
 	/* "Unknown power state" */
 	dev->current_state = 4;
@@ -427,23 +428,35 @@
  * Read the config data for a PCI device, sanity-check it
  * and fill in the dev structure...
  */
-struct pci_dev * __devinit pci_scan_device(struct pci_dev *temp)
+static struct pci_dev * __devinit
+pci_scan_device(struct pci_bus *bus, int devfn)
 {
 	struct pci_dev *dev;
 	u32 l;
+	u8 hdr_type;
+
+	if (pci_bus_read_config_byte(bus, devfn, PCI_HEADER_TYPE, &hdr_type))
+		return NULL;
 
-	if (pci_read_config_dword(temp, PCI_VENDOR_ID, &l))
+	if (pci_bus_read_config_dword(bus, devfn, PCI_VENDOR_ID, &l))
 		return NULL;
 
 	/* some broken boards return 0 or ~0 if a slot is empty: */
 	if (l == 0xffffffff || l == 0x00000000 || l == 0x0000ffff || l == 0xffff0000)
 		return NULL;
 
-	dev = kmalloc(sizeof(*dev), GFP_KERNEL);
+	dev = kmalloc(sizeof(struct pci_dev), GFP_KERNEL);
 	if (!dev)
 		return NULL;
 
-	memcpy(dev, temp, sizeof(*dev));
+	memset(dev, 0, sizeof(struct pci_dev));
+	dev->bus = bus;
+	dev->sysdata = bus->sysdata;
+	dev->dev.parent = bus->dev;
+	dev->dev.bus = &pci_bus_type;
+	dev->devfn = devfn;
+	dev->hdr_type = hdr_type & 0x7f;
+	dev->multifunction = !!(hdr_type & 0x80);
 	dev->vendor = l & 0xffff;
 	dev->device = (l >> 16) & 0xffff;
 
@@ -461,42 +474,44 @@
 	strcpy(dev->dev.bus_id,dev->slot_name);
 	dev->dev.dma_mask = &dev->dma_mask;
 
-	device_register(&dev->dev);
 	return dev;
 }
 
-struct pci_dev * __devinit pci_scan_slot(struct pci_dev *temp)
+struct pci_dev * __devinit pci_scan_slot(struct pci_bus *bus, int devfn)
 {
-	struct pci_bus *bus = temp->bus;
-	struct pci_dev *dev;
 	struct pci_dev *first_dev = NULL;
-	int func = 0;
-	int is_multi = 0;
-	u8 hdr_type;
+	int func;
 
-	for (func = 0; func < 8; func++, temp->devfn++) {
-		if (func && !is_multi)		/* not a multi-function device */
-			continue;
-		if (pci_read_config_byte(temp, PCI_HEADER_TYPE, &hdr_type))
-			continue;
-		temp->hdr_type = hdr_type & 0x7f;
+	for (func = 0; func < 8; func++, devfn++) {
+		struct pci_dev *dev;
 
-		dev = pci_scan_device(temp);
+		dev = pci_scan_device(bus, devfn);
 		if (!dev)
 			continue;
-		if (!func) {
-			is_multi = hdr_type & 0x80;
+
+		if (func == 0) {
 			first_dev = dev;
+		} else {
+			dev->multifunction = 1;
 		}
 
+		/* Fix up broken headers */
+		pci_fixup_device(PCI_FIXUP_HEADER, dev);
+
 		/*
 		 * Link the device to both the global PCI device chain and
 		 * the per-bus list of devices and add the /proc entry.
+		 * Note: this also runs the hotplug notifiers (bad!) --rmk
 		 */
+		device_register(&dev->dev);
 		pci_insert_device (dev, bus);
 
-		/* Fix up broken headers */
-		pci_fixup_device(PCI_FIXUP_HEADER, dev);
+		/*
+		 * If this is a single function device,
+		 * don't scan past the first function.
+		 */
+		if (!dev->multifunction)
+			break;
 	}
 	return first_dev;
 }
@@ -507,28 +522,12 @@
 	struct list_head *ln;
 	struct pci_dev *dev;
 
-	dev = kmalloc(sizeof(*dev), GFP_KERNEL);
-	if (!dev) {
-		printk(KERN_ERR "Out of memory in %s\n", __FUNCTION__);
-		return 0;
-	}
-
 	DBG("Scanning bus %02x\n", bus->number);
 	max = bus->secondary;
 
-	/* Create a device template */
-	memset(dev, 0, sizeof(*dev));
-	dev->bus = bus;
-	dev->sysdata = bus->sysdata;
-	dev->dev.parent = bus->dev;
-	dev->dev.bus = &pci_bus_type;
-
 	/* Go find them, Rover! */
-	for (devfn = 0; devfn < 0x100; devfn += 8) {
-		dev->devfn = devfn;
-		pci_scan_slot(dev);
-	}
-	kfree(dev);
+	for (devfn = 0; devfn < 0x100; devfn += 8)
+		pci_scan_slot(bus, devfn);
 
 	/*
 	 * After performing arch-dependent fixup of the bus, look behind
@@ -537,9 +536,9 @@
 	DBG("Fixups for bus %02x\n", bus->number);
 	pcibios_fixup_bus(bus);
 	for (pass=0; pass < 2; pass++)
-		for (ln=bus->devices.next; ln != &bus->devices; ln=ln->next) {
-			dev = pci_dev_b(ln);
-			if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE || dev->hdr_type == PCI_HEADER_TYPE_CARDBUS)
+		list_for_each_entry(dev, &bus->devices, bus_list) {
+			if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE ||
+			    dev->hdr_type == PCI_HEADER_TYPE_CARDBUS)
 				max = pci_scan_bridge(bus, dev, max, pass);
 		}
 
--- orig/include/linux/pci.h	Fri Feb 21 19:48:58 2003
+++ linux/include/linux/pci.h	Mon Feb 24 12:51:22 2003
@@ -413,6 +413,7 @@
 
 	/* These fields are used by common fixups */
 	unsigned int	transparent:1;	/* Transparent PCI bridge */
+	unsigned int	multifunction:1;/* Part of multi-function device */
 };
 
 #define pci_dev_g(n) list_entry(n, struct pci_dev, global_list)
@@ -548,7 +549,7 @@
 {
 	return pci_alloc_primary_bus_parented(NULL, bus);
 }
-struct pci_dev *pci_scan_slot(struct pci_dev *temp);
+struct pci_dev *pci_scan_slot(struct pci_bus *bus, int devfn);
 int pci_proc_attach_device(struct pci_dev *dev);
 int pci_proc_detach_device(struct pci_dev *dev);
 int pci_proc_attach_bus(struct pci_bus *bus);

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

