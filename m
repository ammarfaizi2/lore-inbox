Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268517AbTBWRYg>; Sun, 23 Feb 2003 12:24:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268516AbTBWRYg>; Sun, 23 Feb 2003 12:24:36 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:17683 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268517AbTBWRYd>; Sun, 23 Feb 2003 12:24:33 -0500
Date: Sun, 23 Feb 2003 17:34:41 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Cc: Jeff Garzik <jgarzik@pobox.com>, Greg KH <greg@kroah.com>
Subject: [PATCH] Make hot unplugging of PCI buses work
Message-ID: <20030223173441.D20405@flint.arm.linux.org.uk>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Jeff Garzik <jgarzik@pobox.com>, Greg KH <greg@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Linus - this patch is for discussion, NOT for applying unless you have
zero problems with it since it actively breaks existing hotplug PCI.

PCI Split-bridge "docking station".  It's basically a PCI bus with VGA,
serial, keyboard, mouse, parport in a box, connected to a cardbus card.
Other models include a PC-type case with PCI slots connected to a
cardbus card.

To put it another way, hotplug PCI bus.  In my case, I have the following
bus structure:

---[00]-+-00.0  Digital Equipment Corporation StrongARM DC21285
        +-01.0  Cirrus Logic PD 6833 PCMCIA/CardBus Ctrlr
           \-[01]---00.0  MOBILITY Electronics: Unknown device 0120
                     \-[02]--+-00.0  MOBILITY Electronics: Unknown device 0121
                             +-00.1  MOBILITY Electronics: Unknown device 0122
                             +-00.2  MOBILITY Electronics: Unknown device 0123
                             +-00.3  MOBILITY Electronics: Unknown device 0124
                             +-04.0  ATI Technologies Inc Rage XL
                             +-08.0  Realtek Semiconductor Co., Ltd. RTL-8139
                             \-0c.0  OPTi Inc. 82C861
        +-01.1  Cirrus Logic PD 6833 PCMCIA/CardBus Ctrlr
        +-02.0  OPTi Inc. 82C861
        \-03.0  Advanced Micro Devices [AMD] 79c978 [HomePNA]

And without the device plugged in:

---[00]-+-00.0  Digital Equipment Corporation StrongARM DC21285
        +-01.0  Cirrus Logic PD 6833 PCMCIA/CardBus Ctrlr
        +-01.1  Cirrus Logic PD 6833 PCMCIA/CardBus Ctrlr
        +-02.0  OPTi Inc. 82C861
        \-03.0  Advanced Micro Devices [AMD] 79c978 [HomePNA]

Currently, we do not have a way to tell the PCI subsystem "this device
has gone, as have all its children" without manually walking the device
tree.  I suspect real docking stations will require this same
functionality.

The following patch adds support for this to the PCI layer - there are
two entry points:

- pci_remove_bus_device(dev)
  This removes one device from its parent bus, and any children.
- pci_remove_all_bus_devices(bus)
  This removes all devices from a bus, including any children.

The Cardbus layer will use pci_remove_all_bus_devices() when a cardbus
card is removed.  The drivers do not have an option whether to obey the
removal request or not - you've yanked the cardbus device from the
socket and the devices are gone.

pci_remove_bus_device() is intended where you have a set of hot-
pluggable devices on a bus and you can remove them individually.  It
is intended that the existing hotplug layer should use this if they
need to handle power issues associated with each PCI device socket
individually on their hotplugging bus(es).

Furthermore, I propose that pci_remove_device() shall disappear -
and this devices makes it so (thereby breaking existing hotplug
drivers.)

This patch does not contain any of the other changes to allow Linux
to deal with PCI buses hanging off a cardbus card.

--- orig/drivers/pci/hotplug.c	Tue Feb 11 16:10:23 2003
+++ linux/drivers/pci/hotplug.c	Sun Feb 23 17:19:38 2003
@@ -278,8 +278,7 @@
  * Delete the device structure from the device lists,
  * remove the /proc entry, and notify userspace (/sbin/hotplug).
  */
-void
-pci_remove_device(struct pci_dev *dev)
+static void pci_remove_device(struct pci_dev *dev)
 {
 	device_unregister(&dev->dev);
 	list_del(&dev->bus_list);
@@ -290,7 +289,69 @@
 #endif
 }
 
+/**
+ * pci_remove_bus_device - remove a PCI device and any children
+ * @dev: the device to remove
+ *
+ * Remove a PCI device from the device lists, informing the drivers
+ * that the device has been removed.  We also remove any subordinate
+ * buses and children in a depth-first manner.
+ */
+void pci_remove_bus_device(struct pci_dev *dev)
+{
+	if (dev->subordinate) {
+		struct pci_bus *b = dev->subordinate;
+
+		/*
+		 * Remove all devices on this bus.
+		 */
+		pci_remove_all_bus_devices(b);
+
+		/*
+		 * This bus must have now have no devices.
+		 */
+		BUG_ON(!list_empty(&b->children));
+		BUG_ON(!list_empty(&b->devices));
+
+		/*
+		 * Remove bus from parent bus list and free.
+		 */
+		list_del(&b->node);
+		kfree(b);
+		dev->subordinate = NULL;
+	}
+
+	/*
+	 * Now remove this device.  This tells drivers that
+	 * this device is going away, unlinks it from the
+	 * device chains and removes any sysfs or procfs files.
+	 */
+	pci_remove_device(dev);
+
+	kfree(dev);
+}
+
+/**
+ * pci_remove_all_bus_devices - remove all devices on a PCI bus
+ * @bus: parent bus of devices to remove
+ *
+ * Remove all devices on the bus, except for the parent bridge.
+ * This also removes any child buses, and any devices they may
+ * contain in a depth-first manner.
+ */
+void pci_remove_all_bus_devices(struct pci_bus *bus)
+{
+	struct list_head *l, *n;
+
+	list_for_each_safe(l, n, &bus->devices) {
+		struct pci_dev *dev = pci_dev_b(l);
+
+		pci_remove_bus_device(dev);
+	}
+}
+
 #ifdef CONFIG_HOTPLUG
 EXPORT_SYMBOL(pci_insert_device);
-EXPORT_SYMBOL(pci_remove_device);
+EXPORT_SYMBOL(pci_remove_bus_device);
+EXPORT_SYMBOL(pci_remove_all_bus_devices);
 #endif
--- orig/include/linux/pci.h	Fri Feb 21 19:48:58 2003
+++ linux/include/linux/pci.h	Sun Feb 23 16:12:14 2003
@@ -645,7 +645,8 @@
 int pci_register_driver(struct pci_driver *);
 void pci_unregister_driver(struct pci_driver *);
 void pci_insert_device(struct pci_dev *, struct pci_bus *);
-void pci_remove_device(struct pci_dev *);
+void pci_remove_bus_device(struct pci_dev *);
+void pci_remove_all_bus_devices(struct pci_bus *);
 struct pci_driver *pci_dev_driver(const struct pci_dev *);
 const struct pci_device_id *pci_match_device(const struct pci_device_id *ids, const struct pci_dev *dev);
 unsigned int pci_do_scan_bus(struct pci_bus *bus);

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

