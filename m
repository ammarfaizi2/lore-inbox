Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261703AbUKAABG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261703AbUKAABG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 19:01:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbUKAABG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 19:01:06 -0500
Received: from port-212-202-157-208.static.qsc.de ([212.202.157.208]:34263
	"EHLO zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S261703AbUKAAAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 19:00:09 -0500
Message-ID: <41857C7B.3080304@ppp0.net>
Date: Mon, 01 Nov 2004 00:59:55 +0100
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.3) Gecko/20040926 Thunderbird/0.8 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org,
       Hotplug List <pcihpd-discuss@lists.sourceforge.net>
Subject: [patch 2/2] fakephp: add pci bus rescan ability
References: <E8F8DBCB0468204E856114A2CD20741F2C13E2@mail.local.ActualitySystems.com> <200409241412.45204@bilbo.math.uni-mannheim.de> <41541009.9080206@ppp0.net> <200409241432.06748@bilbo.math.uni-mannheim.de> <20040924145542.GA17147@kroah.com> <41687EBA.7050506@ppp0.net> <41688985.7030607@ppp0.net> <41693CF9.10905@ppp0.net> <20041030041615.GH1584@kroah.com>
In-Reply-To: <20041030041615.GH1584@kroah.com>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

===== drivers/pci/hotplug/fakephp.c 1.2 vs edited =====
--- 1.2/drivers/pci/hotplug/fakephp.c	2003-08-27 16:44:50 +02:00
+++ edited/drivers/pci/hotplug/fakephp.c	2004-11-01 00:15:26 +01:00
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
@@ -185,6 +294,23 @@
 		err("Can't remove PCI devices with other PCI devices behind it yet.\n");
 		return -ENODEV;
 	}
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
+	}

 	/* remove the device from the pci core */
 	pci_remove_bus_device(dslot->dev);
@@ -227,6 +353,6 @@
 MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
-MODULE_PARM(debug, "i");
+module_param(debug, int, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(debug, "Debugging mode enabled or not");


