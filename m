Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269486AbUICTpr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269486AbUICTpr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 15:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269771AbUICTp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 15:45:27 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21420 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269769AbUICTdV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 15:33:21 -0400
Date: Fri, 3 Sep 2004 20:33:18 +0100
From: Matthew Wilcox <willy@debian.org>
To: Matthew Wilcox <willy@debian.org>
Cc: Greg KH <greg@kroah.com>, pcihpd-discuss@lists.sourceforge.net,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: [PATCH] acpiphp resource usage [4/5]
Message-ID: <20040903193318.GS642@parcelfarce.linux.theplanet.co.uk>
References: <20040903193027.GO642@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040903193027.GO642@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Reading the config size from a PCI BAR can only be done when the device
is quiesced.  With the current code, loading the acpiphp driver at
runtime can cause all kinds of interesting errors.

This patch makes acpiphp use the resources embedded in the pci_dev instead
where possible.  It uses the new pci_bus_address() function introduced
in patch 01 of this series.  By using the pci_dev resources instead of
reading the BARs directly, this also cures some of the problems found
with plugin cards that contain PCI-to-PCI bridges.

diff -urpNX build-tools/dontdiff linux-2.6/drivers/pci/hotplug/acpiphp_pci.c hotplug-2.6/drivers/pci/hotplug/acpiphp_pci.c
--- linux-2.6/drivers/pci/hotplug/acpiphp_pci.c	2004-04-28 13:12:37.000000000 -0600
+++ hotplug-2.6/drivers/pci/hotplug/acpiphp_pci.c	2004-09-02 13:34:23.000000000 -0600
@@ -45,44 +45,29 @@
 /* allocate mem/pmem/io resource to a new function */
 static int init_config_space (struct acpiphp_func *func)
 {
-	u32 bar, len;
-	u32 address[] = {
-		PCI_BASE_ADDRESS_0,
-		PCI_BASE_ADDRESS_1,
-		PCI_BASE_ADDRESS_2,
-		PCI_BASE_ADDRESS_3,
-		PCI_BASE_ADDRESS_4,
-		PCI_BASE_ADDRESS_5,
-		0
-	};
 	int count;
-	struct acpiphp_bridge *bridge;
-	struct pci_resource *res;
-	struct pci_bus *pbus;
-	int bus, device, function;
-	unsigned int devfn;
 	u16 tmp;
 
-	bridge = func->slot->bridge;
-	pbus = bridge->pci_bus;
-	bus = bridge->bus;
-	device = func->slot->device;
-	function = func->function;
-	devfn = PCI_DEVFN(device, function);
-
-	for (count = 0; address[count]; count++) {	/* for 6 BARs */
-		pci_bus_write_config_dword(pbus, devfn,
-					   address[count], 0xFFFFFFFF);
-		pci_bus_read_config_dword(pbus, devfn, address[count], &bar);
+	struct acpiphp_bridge *bridge = func->slot->bridge;
+	struct pci_bus *pbus = bridge->pci_bus;
+	int bus = pbus->number;
+	int device = func->slot->device;
+	int function = func->function;
+	int devfn = PCI_DEVFN(device, function);
+
+	for (count = 0; count < 6; count++) {
+		struct pci_resource *res;
+		u32 bar, len;
+		unsigned int address = PCI_BASE_ADDRESS_0 + (count << 2);
+		pci_bus_write_config_dword(pbus, devfn, address, 0xFFFFFFFF);
+		pci_bus_read_config_dword(pbus, devfn, address, &bar);
 
-		if (!bar)	/* This BAR is not implemented */
+		if (!bar || bar == 0xffffffff)
 			continue;
 
 		dbg("Device %02x.%02x BAR %d wants %x\n", device, function, count, bar);
 
-		if (bar & PCI_BASE_ADDRESS_SPACE_IO) {
-			/* This is IO */
-
+		if ((bar & PCI_BASE_ADDRESS_SPACE) == PCI_BASE_ADDRESS_SPACE_IO) {
 			len = bar & (PCI_BASE_ADDRESS_IO_MASK & 0xFFFF);
 			len = len & ~(len - 1);
 
@@ -97,82 +82,52 @@ static int init_config_space (struct acp
 				    bus, device, function, len);
 				return -1;
 			}
-			pci_bus_write_config_dword(pbus, devfn,
-						   address[count],
+			pci_bus_write_config_dword(pbus, devfn, address,
 						   (u32)res->base);
 			res->next = func->io_head;
 			func->io_head = res;
-
 		} else {
-			/* This is Memory */
-			if (bar & PCI_BASE_ADDRESS_MEM_PREFETCH) {
-				/* pfmem */
-
-				len = bar & 0xFFFFFFF0;
-				len = ~len + 1;
-
-				dbg("len in PFMEM %x, BAR %d\n", len, count);
-
-				spin_lock(&bridge->res_lock);
-				res = acpiphp_get_resource(&bridge->p_mem_head, len);
-				spin_unlock(&bridge->res_lock);
-
-				if (!res) {
-					err("cannot allocate requested pfmem for %02x:%02x.%d len %x\n",
-					    bus, device, function, len);
-					return -1;
-				}
-
-				pci_bus_write_config_dword(pbus, devfn,
-							   address[count],
-							   (u32)res->base);
-
-				if (bar & PCI_BASE_ADDRESS_MEM_TYPE_64) {	/* takes up another dword */
-					dbg("inside the pfmem 64 case, count %d\n", count);
-					count += 1;
-					pci_bus_write_config_dword(pbus, devfn,
-								   address[count],
-								   (u32)(res->base >> 32));
-				}
+			struct pci_resource **bridge_mem_head;
+			struct pci_resource **func_mem_head;
 
-				res->next = func->p_mem_head;
-				func->p_mem_head = res;
+			len = bar & PCI_BASE_ADDRESS_MEM_MASK;
+			len = ~len + 1;
+			dbg("len in MEM %x, BAR %d\n", len, count);
 
+			if (bar & PCI_BASE_ADDRESS_MEM_PREFETCH) {
+				bridge_mem_head = &bridge->p_mem_head;
+				func_mem_head = &func->p_mem_head;
 			} else {
-				/* regular memory */
+				bridge_mem_head = &bridge->mem_head;
+				func_mem_head = &func->mem_head;
+			}
 
-				len = bar & 0xFFFFFFF0;
-				len = ~len + 1;
+			spin_lock(&bridge->res_lock);
+			res = acpiphp_get_resource(bridge_mem_head, len);
+			spin_unlock(&bridge->res_lock);
 
-				dbg("len in MEM %x, BAR %d\n", len, count);
+			if (!res) {
+				err("cannot allocate requested mem for "
+						"%02x:%02x.%d len %x\n",
+						bus, device, function, len);
+				return -1;
+			}
+			dbg("received address 0x%lx\n", res->base);
 
-				spin_lock(&bridge->res_lock);
-				res = acpiphp_get_resource(&bridge->mem_head, len);
-				spin_unlock(&bridge->res_lock);
-
-				if (!res) {
-					err("cannot allocate requested pfmem for %02x:%02x.%d len %x\n",
-					    bus, device, function, len);
-					return -1;
-				}
+			pci_bus_write_config_dword(pbus, devfn, address,
+						   (u32)res->base);
 
+			if (bar & PCI_BASE_ADDRESS_MEM_TYPE_64) {
+				/* takes up another dword */
+				dbg("inside the mem 64 case, count %d\n", count);
+				count++;
 				pci_bus_write_config_dword(pbus, devfn,
-							   address[count],
-							   (u32)res->base);
-
-				if (bar & PCI_BASE_ADDRESS_MEM_TYPE_64) {
-					/* takes up another dword */
-					dbg("inside mem 64 case, reg. mem, count %d\n", count);
-					count += 1;
-					pci_bus_write_config_dword(pbus, devfn,
-								   address[count],
-								   (u32)(res->base >> 32));
-				}
-
-				res->next = func->mem_head;
-				func->mem_head = res;
-
+						address + 4,
+						(u32)(res->base >> 32));
 			}
+
+			res->next = *func_mem_head;
+			*func_mem_head = res;
 		}
 	}
 
@@ -214,6 +169,7 @@ static int detect_used_resource (struct 
 
 		dbg("BAR[%d] 0x%lx - 0x%lx (0x%lx)\n", count, base,
 				base + len - 1, flags);
+		base = pci_bus_address(dev, base, flags);
 
 		if (flags & IORESOURCE_IO) {
 			head = &bridge->io_head;
@@ -255,100 +211,43 @@ int acpiphp_detect_pci_resource (struct 
 
 
 /**
- * acpiphp_init_slot_resource - gather resource usage information of a slot
+ * acpiphp_init_func_resource - gather resource usage information of a slot
  * @slot: ACPI slot object to be checked, should have valid pci_dev member
- *
- * TBD: PCI-to-PCI bridge case
- *      use pci_dev->resource[]
  */
 int acpiphp_init_func_resource (struct acpiphp_func *func)
 {
-	u64 base;
-	u32 bar, len;
-	u32 address[] = {
-		PCI_BASE_ADDRESS_0,
-		PCI_BASE_ADDRESS_1,
-		PCI_BASE_ADDRESS_2,
-		PCI_BASE_ADDRESS_3,
-		PCI_BASE_ADDRESS_4,
-		PCI_BASE_ADDRESS_5,
-		0
-	};
 	int count;
-	struct pci_resource *res;
-	struct pci_dev *dev;
-
-	dev = func->pci_dev;
+	struct pci_dev *dev = func->pci_dev;
 	dbg("Hot-pluggable device %s\n", pci_name(dev));
 
-	for (count = 0; address[count]; count++) {	/* for 6 BARs */
-		pci_read_config_dword(dev, address[count], &bar);
-
-		if (!bar)	/* This BAR is not implemented */
-			continue;
+	for (count = 0; count < DEVICE_COUNT_RESOURCE; count++) {
+		struct pci_resource *res;
 
-		pci_write_config_dword(dev, address[count], 0xFFFFFFFF);
-		pci_read_config_dword(dev, address[count], &len);
+		unsigned long base = dev->resource[count].start;
+		unsigned long len = dev->resource[count].end - base + 1;
+		unsigned long flags = dev->resource[count].flags;
 
-		if (len & PCI_BASE_ADDRESS_SPACE_IO) {
-			/* This is IO */
-			base = bar & 0xFFFFFFFC;
-			len = len & (PCI_BASE_ADDRESS_IO_MASK & 0xFFFF);
-			len = len & ~(len - 1);
+		if (!flags)
+			continue;
 
-			dbg("BAR[%d] %08x - %08x (IO)\n", count, (u32)base, (u32)base + len - 1);
+		dbg("BAR[%d] 0x%lx - 0x%lx (0x%lx)\n", count, base,
+				base + len - 1, flags);
+		base = pci_bus_address(dev, base, flags);
 
-			res = acpiphp_make_resource(base, len);
-			if (!res)
-				goto no_memory;
+		res = acpiphp_make_resource(base, len);
+		if (!res)
+			goto no_memory;
 
+		if (flags & IORESOURCE_IO) {
 			res->next = func->io_head;
 			func->io_head = res;
-
+		} else if (flags & IORESOURCE_PREFETCH) {
+			res->next = func->p_mem_head;
+			func->p_mem_head = res;
 		} else {
-			/* This is Memory */
-			base = bar & 0xFFFFFFF0;
-			if (len & PCI_BASE_ADDRESS_MEM_PREFETCH) {
-				/* pfmem */
-
-				len &= 0xFFFFFFF0;
-				len = ~len + 1;
-
-				if (len & PCI_BASE_ADDRESS_MEM_TYPE_64) {	/* takes up another dword */
-					dbg("prefetch mem 64\n");
-					count += 1;
-				}
-				dbg("BAR[%d] %08x - %08x (PMEM)\n", count, (u32)base, (u32)base + len - 1);
-				res = acpiphp_make_resource(base, len);
-				if (!res)
-					goto no_memory;
-
-				res->next = func->p_mem_head;
-				func->p_mem_head = res;
-
-			} else {
-				/* regular memory */
-
-				len &= 0xFFFFFFF0;
-				len = ~len + 1;
-
-				if (len & PCI_BASE_ADDRESS_MEM_TYPE_64) {
-					/* takes up another dword */
-					dbg("mem 64\n");
-					count += 1;
-				}
-				dbg("BAR[%d] %08x - %08x (MEM)\n", count, (u32)base, (u32)base + len - 1);
-				res = acpiphp_make_resource(base, len);
-				if (!res)
-					goto no_memory;
-
-				res->next = func->mem_head;
-				func->mem_head = res;
-
-			}
+			res->next = func->mem_head;
+			func->mem_head = res;
 		}
-
-		pci_write_config_dword(dev, address[count], bar);
 	}
 #if 1
 	acpiphp_dump_func_resource(func);

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
