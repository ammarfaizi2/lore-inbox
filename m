Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262674AbUKLXlw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262674AbUKLXlw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 18:41:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262727AbUKLXlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:41:04 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:45965 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262700AbUKLXWu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:22:50 -0500
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.10-rc1
User-Agent: Mutt/1.5.6i
In-Reply-To: <11003017181402@kroah.com>
Date: Fri, 12 Nov 2004 15:21:58 -0800
Message-Id: <11003017181025@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2091.1.3, 2004/11/11 16:33:31-08:00, jdittmer@ppp0.net

[PATCH] fakephp: add pci bus rescan ability

This adds the ability to rescan the pci bus for newly inserted,
reprogrammed or previously disabled pci devices.
To initiate a rescan you need to write '1' to any of the
/sys/bus/pci/slots/*/power control files. No known pci devices
will be touched.
Additionally this fixes a bug, when someone tries to disable
a device with subfunctions. The subfunctions will be disabled first now.

Short demo:
 # modprobe fakephp
 # ls /sys/bus/pci/slots | grep "0000:04"
0000:04:02.0
0000:04:02.1
0000:04:02.2
0000:04:03.0
0000:04:03.1
 # echo -n 0 > /sys/bus/pci/slots/0000\:04\:02.0/power
 # ls /sys/bus/pci/slots | grep "0000:04"
0000:04:03.0
0000:04:03.1
 # echo -n 1 > /sys/bus/pci/slots/0000\:03\:01.0/power
 # ls /sys/bus/pci/slots | grep "0000:04"
0000:04:02.0
0000:04:02.1
0000:04:02.2
0000:04:03.0
0000:04:03.1
 # lspci | grep "0000:04"
0000:04:02.0 Multimedia audio controller: Creative Labs SB Audigy (rev 03)
0000:04:02.1 Input device controller: Creative Labs SB Audigy MIDI/Gameport (rev 03)
0000:04:02.2 FireWire (IEEE 1394): Creative Labs SB Audigy FireWire Port
0000:04:03.0 SCSI storage controller: Adaptec AHA-3960D / AIC-7899A U160/m (rev 01)
0000:04:03.1 SCSI storage controller: Adaptec AHA-3960D / AIC-7899A U160/m (rev 01)

Signed-off-by: Jan Dittmer <jdittmer@ppp0.net>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/hotplug/fakephp.c |  126 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 126 insertions(+)


diff -Nru a/drivers/pci/hotplug/fakephp.c b/drivers/pci/hotplug/fakephp.c
--- a/drivers/pci/hotplug/fakephp.c	2004-11-12 15:11:41 -08:00
+++ b/drivers/pci/hotplug/fakephp.c	2004-11-12 15:11:41 -08:00
@@ -165,14 +165,123 @@
 		err("Problem unregistering a slot %s\n", dslot->slot->name);
 }
 
+/**
+ * Rescan slot.
+ * Tries hard not to re-enable already existing devices
+ * also handles scanning of subfunctions
+ *
+ * @param temp   Device template. Should be set: bus and devfn.
+ */
+static void pci_rescan_slot(struct pci_dev *temp)
+{
+	struct pci_bus *bus = temp->bus;
+	struct pci_dev *dev;
+	int func;
+	u8 hdr_type;
+	if (!pci_read_config_byte(temp, PCI_HEADER_TYPE, &hdr_type)) {
+		temp->hdr_type = hdr_type & 0x7f;
+		if (!pci_find_slot(bus->number, temp->devfn)) {
+			dev = pci_scan_single_device(bus, temp->devfn);
+			if (dev) {
+				dbg("New device on %s function %x:%x\n",
+					bus->name, temp->devfn >> 3,
+					temp->devfn & 7);
+				pci_bus_add_device(dev);
+				add_slot(dev);
+			}
+		}
+		/* multifunction device? */
+		if (!(hdr_type & 0x80))
+			return;
+
+		/* continue scanning for other functions */
+		for (func = 1, temp->devfn++; func < 8; func++, temp->devfn++) {
+			if (pci_read_config_byte(temp, PCI_HEADER_TYPE, &hdr_type))
+				continue;
+			temp->hdr_type = hdr_type & 0x7f;
+
+			if (!pci_find_slot(bus->number, temp->devfn)) {
+				dev = pci_scan_single_device(bus, temp->devfn);
+				if (dev) {
+					dbg("New device on %s function %x:%x\n",
+						bus->name, temp->devfn >> 3,
+						temp->devfn & 7);
+					pci_bus_add_device(dev);
+					add_slot(dev);
+				}
+			}
+		}
+	}
+}
+
+
+/**
+ * Rescan PCI bus.
+ * call pci_rescan_slot for each possible function of the bus
+ *
+ * @param bus
+ */
+static void pci_rescan_bus(const struct pci_bus *bus)
+{
+	unsigned int devfn;
+	struct pci_dev *dev;
+	dev = kmalloc(sizeof(struct pci_dev), GFP_KERNEL);
+	if (!dev)
+		return;
+
+	memset(dev, 0, sizeof(dev));
+	dev->bus = (struct pci_bus*)bus;
+	dev->sysdata = bus->sysdata;
+	for (devfn = 0; devfn < 0x100; devfn += 8) {
+		dev->devfn = devfn;
+		pci_rescan_slot(dev);
+	}
+	kfree(dev);
+}
+
+/* recursively scan all buses */
+static void pci_rescan_buses(const struct list_head *list)
+{
+	const struct list_head *l;
+	list_for_each(l,list) {
+		const struct pci_bus *b = pci_bus_b(l);
+		pci_rescan_bus(b);
+		pci_rescan_buses(&b->children);
+	}
+}
+
+/* initiate rescan of all pci buses */
+static inline void pci_rescan(void) {
+	pci_rescan_buses(&pci_root_buses);
+}
+
+
 static int enable_slot(struct hotplug_slot *hotplug_slot)
 {
+	/* mis-use enable_slot for rescanning of the pci bus */
+	pci_rescan();
 	return -ENODEV;
 }
 
+/* find the hotplug_slot for the pci_dev */
+static struct hotplug_slot *get_slot_from_dev(struct pci_dev *dev)
+{
+	struct dummy_slot *dslot;
+
+	list_for_each_entry(dslot, &slot_list, node) {
+		if (dslot->dev == dev)
+			return dslot->slot;
+	}
+	return NULL;
+}
+
+
 static int disable_slot(struct hotplug_slot *slot)
 {
 	struct dummy_slot *dslot;
+	struct hotplug_slot *hslot;
+	struct pci_dev *dev;
+	int func;
 
 	if (!slot)
 		return -ENODEV;
@@ -184,6 +293,23 @@
 	if (dslot->dev->subordinate) {
 		err("Can't remove PCI devices with other PCI devices behind it yet.\n");
 		return -ENODEV;
+	}
+	/* search for subfunctions and disable them first */
+	if (!(dslot->dev->devfn & 7)) {
+		for (func = 1; func < 8; func++) {
+			dev = pci_find_slot(dslot->dev->bus->number,
+					dslot->dev->devfn + func);
+			if (dev) {
+				hslot = get_slot_from_dev(dev);
+				if (hslot)
+					disable_slot(hslot);
+				else {
+					err("Hotplug slot not found for subfunction of PCI device\n");
+					return -ENODEV;
+				}
+			} else
+				dbg("No device in slot found\n");
+		}
 	}
 
 	/* remove the device from the pci core */

