Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129227AbRBBMaO>; Fri, 2 Feb 2001 07:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129380AbRBBM35>; Fri, 2 Feb 2001 07:29:57 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:61189 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129304AbRBBM3u>; Fri, 2 Feb 2001 07:29:50 -0500
Subject: Re: vaio doesn't boot with 2.4.1-ac1, stops at PCI: Probing PCI hardware
To: ookhoi@dds.nl
Date: Fri, 2 Feb 2001 12:30:19 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20010202122756.B3922@ookhoi.dds.nl> from "Ookhoi" at Feb 02, 2001 12:27:56 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14OfM4-0006PO-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Firstly however does 2.4.1 (Linus) boot ?
> 
> It does boot. :-)  Is there something I can do now? 

Ok that means its something in my patches. 

Time to do some patch searching. I see two probable candidates - the local apic
code and the pci changes.

Does 2.4.1 with the following patch applied still boot


diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla/drivers/pci/pci.c linux.ac/drivers/pci/pci.c
--- linux.vanilla/drivers/pci/pci.c	Mon Dec 11 21:46:26 2000
+++ linux.ac/drivers/pci/pci.c	Wed Jan 31 22:02:02 2001
@@ -40,10 +40,12 @@
 /**
  * pci_find_slot - locate PCI device from a given PCI slot
  * @bus: number of PCI bus on which desired PCI device resides
- * @devfn:  number of PCI slot in which desired PCI device resides
+ * @devfn: encodes number of PCI slot in which the desired PCI 
+ * device resides and the logical device number within that slot 
+ * in case of multi-function devices.
  *
- * Given a PCI bus and slot number, the desired PCI device is
- * located in system global list of PCI devices.  If the device
+ * Given a PCI bus and slot/function number, the desired PCI device 
+ * is located in system global list of PCI devices.  If the device
  * is found, a pointer to its data structure is returned.  If no 
  * device is found, %NULL is returned.
  */
@@ -59,7 +61,20 @@
 	return NULL;
 }
 
-
+/**
+ * pci_find_subsys - begin or continue searching for a PCI device by vendor/subvendor/device/subdevice id
+ * @vendor: PCI vendor id to match, or %PCI_ANY_ID to match all vendor ids
+ * @device: PCI device id to match, or %PCI_ANY_ID to match all vendor ids
+ * @ss_vendor: PCI subsystem vendor id to match, or %PCI_ANY_ID to match all vendor ids
+ * @ss_device: PCI subsystem device id to match, or %PCI_ANY_ID to match all vendor ids
+ * @from: Previous PCI device found in search, or %NULL for new search.
+ *
+ * Iterates through the list of known PCI devices.  If a PCI device is
+ * found with a matching @vendor, @device, @ss_vendor and @ss_device, a pointer to its
+ * device structure is returned.  Otherwise, %NULL is returned.
+ * A new search is initiated by passing %NULL to the @from argument.
+ * Otherwise if @from is not %NULL, searches continue from next device on the global list.
+ */
 struct pci_dev *
 pci_find_subsys(unsigned int vendor, unsigned int device,
 		unsigned int ss_vendor, unsigned int ss_device,
@@ -89,9 +104,8 @@
  * Iterates through the list of known PCI devices.  If a PCI device is
  * found with a matching @vendor and @device, a pointer to its device structure is
  * returned.  Otherwise, %NULL is returned.
- *
  * A new search is initiated by passing %NULL to the @from argument.
- * Otherwise if @from is not null, searches continue from that point.
+ * Otherwise if @from is not %NULL, searches continue from next device on the global list.
  */
 struct pci_dev *
 pci_find_device(unsigned int vendor, unsigned int device, const struct pci_dev *from)
@@ -108,9 +122,8 @@
  * Iterates through the list of known PCI devices.  If a PCI device is
  * found with a matching @class, a pointer to its device structure is
  * returned.  Otherwise, %NULL is returned.
- *
  * A new search is initiated by passing %NULL to the @from argument.
- * Otherwise if @from is not null, searches continue from that point.
+ * Otherwise if @from is not %NULL, searches continue from next device on the global list.
  */
 struct pci_dev *
 pci_find_class(unsigned int class, const struct pci_dev *from)
@@ -126,7 +139,28 @@
 	return NULL;
 }
 
-
+/**
+ * pci_find_capability - query for devices' capabilities 
+ * @dev: PCI device to query
+ * @cap: capability code
+ *
+ * Tell if a device supports a given PCI capability.
+ * Returns the address of the requested capability structure within the device's PCI 
+ * configuration space or 0 in case the device does not support it.
+ * Possible values for @flags:
+ *
+ *  %PCI_CAP_ID_PM           Power Management 
+ *
+ *  %PCI_CAP_ID_AGP          Accelerated Graphics Port 
+ *
+ *  %PCI_CAP_ID_VPD          Vital Product Data 
+ *
+ *  %PCI_CAP_ID_SLOTID       Slot Identification 
+ *
+ *  %PCI_CAP_ID_MSI          Message Signalled Interrupts
+ *
+ *  %PCI_CAP_ID_CHSWP        CompactPCI HotSwap 
+ */
 int
 pci_find_capability(struct pci_dev *dev, int cap)
 {
@@ -281,6 +315,15 @@
 
 static LIST_HEAD(pci_drivers);
 
+/**
+ * pci_match_device - Tell if a PCI device structure has a matching PCI device id structure
+ * @ids: array of PCI device id structures to search in
+ * @dev: the PCI device structure to match against
+ * 
+ * Used by a driver to check whether a PCI device present in the
+ * system is in its list of supported devices.Returns the matching
+ * pci_device_id structure or %NULL if there is no match.
+ */
 const struct pci_device_id *
 pci_match_device(const struct pci_device_id *ids, const struct pci_dev *dev)
 {
@@ -295,7 +338,7 @@
 	}
 	return NULL;
 }
-
+ 
 static int
 pci_announce_device(struct pci_driver *drv, struct pci_dev *dev)
 {
@@ -311,16 +354,22 @@
 	} else
 		id = NULL;
 
-	dev_probe_lock();
 	if (drv->probe(dev, id) >= 0) {
 		dev->driver = drv;
 		ret = 1;
 	}
-	dev_probe_unlock();
 out:
 	return ret;
 }
 
+/**
+ * pci_register_driver - register a new pci driver
+ * @drv: the driver structure to register
+ * 
+ * Adds the driver structure to the list of registered drivers
+ * Returns the number of pci devices which were claimed by the driver
+ * during registration.
+ */
 int
 pci_register_driver(struct pci_driver *drv)
 {
@@ -335,6 +384,15 @@
 	return count;
 }
 
+/**
+ * pci_unregister_driver - unregister a pci driver
+ * @drv: the driver structure to unregister
+ * 
+ * Deletes the driver structure from the list of registered PCI drivers,
+ * gives it a chance to clean up and marks the devices for which it
+ * was responsible as driverless.
+ */
+
 void
 pci_unregister_driver(struct pci_driver *drv)
 {
@@ -396,6 +454,13 @@
 	call_usermodehelper (argv [0], argv, envp);
 }
 
+/**
+ * pci_insert_device - insert a hotplug device
+ * @dev: the device to insert
+ * @bus: where to insert it
+ *
+ * Add a new device to the device lists and notify userspace (/sbin/hotplug).
+ */
 void
 pci_insert_device(struct pci_dev *dev, struct pci_bus *bus)
 {
@@ -428,6 +493,13 @@
 	}
 }
 
+/**
+ * pci_remove_device - remove a hotplug device
+ * @dev: the device to remove
+ *
+ * Delete the device structure from the device lists and 
+ * notify userspace (/sbin/hotplug).
+ */
 void
 pci_remove_device(struct pci_dev *dev)
 {
@@ -453,6 +525,13 @@
 	name: "compat"
 };
 
+/**
+ * pci_dev_driver - get the pci_driver of a device
+ * @dev: the device to query
+ *
+ * Returns the appropriate pci_driver structure or %NULL if there is no 
+ * registered driver for the device.
+ */
 struct pci_driver *
 pci_dev_driver(const struct pci_dev *dev)
 {
@@ -504,7 +583,13 @@
 PCI_OP(write, word, u16)
 PCI_OP(write, dword, u32)
 
-
+/**
+ * pci_set_master - enables bus-mastering for device dev
+ * @dev: the PCI device to enable
+ *
+ * Enables bus-mastering on the device and calls pcibios_set_master()
+ * to do the needed arch specific settings.
+ */
 void
 pci_set_master(struct pci_dev *dev)
 {
@@ -547,9 +632,15 @@
 static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)
 {
 	unsigned int pos, reg, next;
-	u32 l, sz;
+	u32 l, sz, tmp;
+	u16 cmd;
 	struct resource *res;
 
+	/* Disable IO and memory while we fiddle */
+	pci_read_config_word(dev, PCI_COMMAND, &cmd);
+	tmp = cmd & ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY);
+	pci_write_config_word(dev, PCI_COMMAND, tmp);
+	
 	for(pos=0; pos<howmany; pos = next) {
 		next = pos+1;
 		res = &dev->resource[pos];
@@ -613,6 +704,7 @@
 		}
 		res->name = dev->name;
 	}
+	pci_write_config_word(dev, PCI_COMMAND, cmd);
 }
 
 void __init pci_read_bridge_bases(struct pci_bus *child)
@@ -838,8 +930,15 @@
 	dev->irq = irq;
 }
 
-/*
- * Fill in class and map information of a device
+/**
+ * pci_setup_device - fill in class and map information of a device
+ * @dev: the device structure to fill
+ *
+ * Initialize the device structure with information about the device's 
+ * vendor,class,memory and IO-space addresses,IRQ lines etc.
+ * Called at initialisation of the PCI subsystem and by CardBus services.
+ * Returns 0 on success and -1 if unknown type of device (not normal, bridge
+ * or CardBus).
  */
 int pci_setup_device(struct pci_dev * dev)
 {
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla/drivers/pci/pci.ids linux.ac/drivers/pci/pci.ids
--- linux.vanilla/drivers/pci/pci.ids	Wed Jan  3 00:58:45 2001
+++ linux.ac/drivers/pci/pci.ids	Wed Jan 31 22:02:02 2001
@@ -2440,7 +2440,9 @@
 	1221  82C092G
 119c  Information Technology Inst.
 119d  Bug, Inc. Sapporo Japan
-119e  Fujitsu Microelectronics Ltd.
+119e  Fujitsu Microelectronics Europe GMBH
+	0001 FireStream 155
+	0003 FireStream 50
 119f  Bull HN Information Systems
 11a0  Convex Computer Corporation
 11a1  Hamamatsu Photonics K.K.
@@ -2987,13 +2989,14 @@
 		8086 5643  ES1371, ES1373 AudioPCI On Motherboard Vancouver
 		8086 5753  ES1371, ES1373 AudioPCI On Motherboard WS440BX
 	5000  ES1370 [AudioPCI]
-	5880  5880 AudioPCI
+		4942 4c4c  Creative Sound Blaster AudioPCI128
+	5880  CT5880 [AudioPCI]
 		1274 2000  Creative Sound Blaster AudioPCI128
 		1274 5880  Creative Sound Blaster AudioPCI128
-		1462 6880  5880 AudioPCI On Motherboard MS-6188 1.00
-		270f 2001  5880 AudioPCI On Motherboard 6CTR
-		270f 2200  5880 AudioPCI On Motherboard 6WTX
-		270f 7040  5880 AudioPCI On Motherboard 6ATA4
+		1462 6880  CT5880 AudioPCI On Motherboard MS-6188 1.00
+		270f 2001  CT5880 AudioPCI On Motherboard 6CTR
+		270f 2200  CT5880 AudioPCI On Motherboard 6WTX
+		270f 7040  CT5880 AudioPCI On Motherboard 6ATA4
 1275  Network Appliance Corporation
 1276  Switched Network Technologies, Inc.
 1277  Comstream
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla/drivers/pci/setup-bus.c linux.ac/drivers/pci/setup-bus.c
--- linux.vanilla/drivers/pci/setup-bus.c	Mon Dec 11 21:46:26 2000
+++ linux.ac/drivers/pci/setup-bus.c	Wed Jan 31 22:02:02 2001
@@ -45,28 +45,24 @@
 	head_io.next = head_mem.next = NULL;
 	for (ln=bus->devices.next; ln != &bus->devices; ln=ln->next) {
 		struct pci_dev *dev = pci_dev_b(ln);
-		u16 class = dev->class >> 8;
 		u16 cmd;
 
 		/* First, disable the device to avoid side
 		   effects of possibly overlapping I/O and
 		   memory ranges.
-		   Leave VGA enabled - for obvious reason. :-)
-		   Same with all sorts of bridges - they may
-		   have VGA behind them.  */
-		if (class == PCI_CLASS_DISPLAY_VGA
-				|| class == PCI_CLASS_NOT_DEFINED_VGA)
+		   Except the VGA - for obvious reason. :-)  */
+		if (dev->class >> 8 == PCI_CLASS_DISPLAY_VGA)
 			found_vga = 1;
-		else if (class >> 8 != PCI_BASE_CLASS_BRIDGE) {
+		else {
 			pci_read_config_word(dev, PCI_COMMAND, &cmd);
 			cmd &= ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY
 						| PCI_COMMAND_MASTER);
 			pci_write_config_word(dev, PCI_COMMAND, cmd);
 		}
-
+ 
 		/* Reserve some resources for CardBus.
 		   Are these values reasonable? */
-		if (class == PCI_CLASS_BRIDGE_CARDBUS) {
+		if (dev->class >> 8 == PCI_CLASS_BRIDGE_CARDBUS) {
 			io_reserved += 8*1024;
 			mem_reserved += 32*1024*1024;
 			continue;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla/drivers/pci/setup-res.c linux.ac/drivers/pci/setup-res.c
--- linux.vanilla/drivers/pci/setup-res.c	Mon Dec 11 21:46:26 2000
+++ linux.ac/drivers/pci/setup-res.c	Wed Jan 31 22:02:02 2001
@@ -163,6 +163,10 @@
 				size = ln->res->end - ln->res->start;
 			if (r_size > size) {
 				tmp = kmalloc(sizeof(*tmp), GFP_KERNEL);
+				if (!tmp) {
+					printk("pdev_sort_resources(): kmalloc() failed!\n");
+					continue;
+				}
 				tmp->next = ln;
 				tmp->res = r;
 				tmp->dev = dev;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla/include/linux/pci.h linux.ac/include/linux/pci.h
--- linux.vanilla/include/linux/pci.h	Thu Jan  4 22:51:32 2001
+++ linux.ac/include/linux/pci.h	Wed Jan 31 23:32:03 2001
@@ -596,6 +596,7 @@
 static inline void pci_unregister_driver(struct pci_driver *drv) { }
 static inline int scsi_to_pci_dma_dir(unsigned char scsi_dir) { return scsi_dir; }
 static inline int pci_find_capability (struct pci_dev *dev, int cap) {return 0; }
+const struct pci_device_id *pci_match_device(const struct pci_device_id *ids, const struct pci_dev *dev) { return NULL; }
 
 #else
 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
