Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262783AbSLPXpn>; Mon, 16 Dec 2002 18:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262792AbSLPXpn>; Mon, 16 Dec 2002 18:45:43 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:22284 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262783AbSLPXpg>;
	Mon, 16 Dec 2002 18:45:36 -0500
Date: Mon, 16 Dec 2002 15:51:11 -0800
From: Greg KH <greg@kroah.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [PATCH] PCI Hotplug changes for 2.4.21-pre1
Message-ID: <20021216235111.GF17214@kroah.com>
References: <20021216234817.GD17214@kroah.com> <20021216234953.GE17214@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021216234953.GE17214@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.886, 2002/12/16 11:47:08-08:00, willy@debian.org

[PATCH] Convert acpiphp to pci_bus_*() API [2/2]

Convert the acpiphp driver from the pci_*_nodev() API to the pci_bus_*() API.
This patch is relative to 2.4.21-bk.


diff -Nru a/drivers/hotplug/acpiphp.h b/drivers/hotplug/acpiphp.h
--- a/drivers/hotplug/acpiphp.h	Mon Dec 16 15:42:46 2002
+++ b/drivers/hotplug/acpiphp.h	Mon Dec 16 15:42:46 2002
@@ -173,8 +173,6 @@
 	/* PCI-to-PCI bridge device */
 	struct pci_dev *pci_dev;
 
-	struct pci_ops *pci_ops;
-
 	/* ACPI 2.0 _HPP parameters */
 	struct hpp_param hpp;
 
diff -Nru a/drivers/hotplug/acpiphp_glue.c b/drivers/hotplug/acpiphp_glue.c
--- a/drivers/hotplug/acpiphp_glue.c	Mon Dec 16 15:42:46 2002
+++ b/drivers/hotplug/acpiphp_glue.c	Mon Dec 16 15:42:46 2002
@@ -43,7 +43,6 @@
 
 static void handle_hotplug_event_bridge (acpi_handle, u32, void *);
 static void handle_hotplug_event_func (acpi_handle, u32, void *);
-static struct pci_ops *default_ops;
 
 /*
  * initialization & terminatation routines
@@ -515,7 +514,6 @@
 	bridge->bus = bus;
 
 	bridge->pci_bus = find_pci_bus(&pci_root_buses, bus);
-	bridge->pci_ops = bridge->pci_bus->ops;
 
 	bridge->res_lock = SPIN_LOCK_UNLOCKED;
 
@@ -592,7 +590,6 @@
 		kfree(bridge);
 		return;
 	}
-	bridge->pci_ops = bridge->pci_bus->ops;
 
 	bridge->res_lock = SPIN_LOCK_UNLOCKED;
 
@@ -1072,11 +1069,9 @@
 			if (ACPI_SUCCESS(status) && sta)
 				break;
 		} else {
-			pci_read_config_dword_nodev(default_ops,
-						    slot->bridge->bus,
-						    slot->device,
-						    func->function,
-						    PCI_VENDOR_ID, &dvid);
+			pci_bus_read_config_dword(slot->bridge->pci_bus,
+					PCI_DEVFN(slot->device, func->function),
+					PCI_VENDOR_ID, &dvid);
 			if (dvid != 0xffffffff) {
 				sta = ACPI_STA_ALL;
 				break;
@@ -1204,11 +1199,6 @@
 	acpi_status status;
 
 	if (list_empty(&pci_root_buses))
-		return -1;
-
-	/* set default pci_ops for configuration space operation */
-	default_ops = pci_bus_b(pci_root_buses.next)->ops;
-	if (!default_ops)
 		return -1;
 
 	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
diff -Nru a/drivers/hotplug/acpiphp_pci.c b/drivers/hotplug/acpiphp_pci.c
--- a/drivers/hotplug/acpiphp_pci.c	Mon Dec 16 15:42:46 2002
+++ b/drivers/hotplug/acpiphp_pci.c	Mon Dec 16 15:42:46 2002
@@ -58,23 +58,22 @@
 	int count;
 	struct acpiphp_bridge *bridge;
 	struct pci_resource *res;
-	struct pci_ops *ops;
-	int bus, device, function;
+	struct pci_bus *bus;
+	int devfn;
 
 	bridge = func->slot->bridge;
-	bus = bridge->bus;
-	device = func->slot->device;
-	function = func->function;
-	ops = bridge->pci_ops;
+	bus = bridge->pci_bus;
+	devfn = PCI_DEVFN(func->slot->device, func->function);
 
 	for (count = 0; address[count]; count++) {	/* for 6 BARs */
-		pci_write_config_dword_nodev(ops, bus, device, function, address[count], 0xFFFFFFFF);
-		pci_read_config_dword_nodev(ops, bus, device, function, address[count], &bar);
+		pci_bus_write_config_dword(bus, devfn, address[count], 0xFFFFFFFF);
+		pci_bus_read_config_dword(bus, devfn, address[count], &bar);
 
 		if (!bar)	/* This BAR is not implemented */
 			continue;
 
-		dbg("Device %02x.%02x BAR %d wants %x\n", device, function, count, bar);
+		dbg("Device %02x.%d BAR %d wants %x\n", PCI_SLOT(devfn),
+				PCI_FUNC(devfn), count, bar);
 
 		if (bar & PCI_BASE_ADDRESS_SPACE_IO) {
 			/* This is IO */
@@ -90,10 +89,10 @@
 
 			if (!res) {
 				err("cannot allocate requested io for %02x:%02x.%d len %x\n",
-				    bus, device, function, len);
+				    bus->number, PCI_SLOT(devfn), PCI_FUNC(devfn), len);
 				return -1;
 			}
-			pci_write_config_dword_nodev(ops, bus, device, function, address[count], (u32)res->base);
+			pci_bus_write_config_dword(bus, devfn, address[count], (u32)res->base);
 			res->next = func->io_head;
 			func->io_head = res;
 
@@ -113,16 +112,16 @@
 
 				if (!res) {
 					err("cannot allocate requested pfmem for %02x:%02x.%d len %x\n",
-					    bus, device, function, len);
+					    bus->number, PCI_SLOT(devfn), PCI_FUNC(devfn), len);
 					return -1;
 				}
 
-				pci_write_config_dword_nodev(ops, bus, device, function, address[count], (u32)res->base);
+				pci_bus_write_config_dword(bus, devfn, address[count], (u32)res->base);
 
 				if (bar & PCI_BASE_ADDRESS_MEM_TYPE_64) {	/* takes up another dword */
 					dbg("inside the pfmem 64 case, count %d\n", count);
 					count += 1;
-					pci_write_config_dword_nodev(ops, bus, device, function, address[count], (u32)(res->base >> 32));
+					pci_bus_write_config_dword(bus, devfn, address[count], (u32)(res->base >> 32));
 				}
 
 				res->next = func->p_mem_head;
@@ -142,17 +141,17 @@
 
 				if (!res) {
 					err("cannot allocate requested pfmem for %02x:%02x.%d len %x\n",
-					    bus, device, function, len);
+					    bus->number, PCI_SLOT(devfn), PCI_FUNC(devfn), len);
 					return -1;
 				}
 
-				pci_write_config_dword_nodev(ops, bus, device, function, address[count], (u32)res->base);
+				pci_bus_write_config_dword(bus, devfn, address[count], (u32)res->base);
 
 				if (bar & PCI_BASE_ADDRESS_MEM_TYPE_64) {
 					/* takes up another dword */
 					dbg("inside mem 64 case, reg. mem, count %d\n", count);
 					count += 1;
-					pci_write_config_dword_nodev(ops, bus, device, function, address[count], (u32)(res->base >> 32));
+					pci_bus_write_config_dword(bus, devfn, address[count], (u32)(res->base >> 32));
 				}
 
 				res->next = func->mem_head;
@@ -163,7 +162,7 @@
 	}
 
 	/* disable expansion rom */
-	pci_write_config_dword_nodev(ops, bus, device, function, PCI_ROM_ADDRESS, 0x00000000);
+	pci_bus_write_config_dword(bus, devfn, PCI_ROM_ADDRESS, 0x00000000);
 
 	return 0;
 }
@@ -556,9 +555,9 @@
 	int retval = 0;
 	int is_multi = 0;
 
-	pci_read_config_byte_nodev(slot->bridge->pci_ops,
-				   slot->bridge->bus, slot->device, 0,
-				   PCI_HEADER_TYPE, &hdr);
+	pci_bus_read_config_byte(slot->bridge->pci_bus,
+					PCI_DEVFN(slot->device, 0),
+					PCI_HEADER_TYPE, &hdr);
 
 	if (hdr & 0x80)
 		is_multi = 1;
@@ -566,10 +565,9 @@
 	list_for_each (l, &slot->funcs) {
 		func = list_entry(l, struct acpiphp_func, sibling);
 		if (is_multi || func->function == 0) {
-			pci_read_config_dword_nodev(slot->bridge->pci_ops,
-						    slot->bridge->bus,
-						    slot->device,
-						    func->function,
+			pci_bus_read_config_dword(slot->bridge->pci_bus,
+						    PCI_DEVFN(slot->device,
+								func->function),
 						    PCI_VENDOR_ID, &dvid);
 			if (dvid != 0xffffffff) {
 				retval = init_config_space(func);
