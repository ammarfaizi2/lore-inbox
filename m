Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268296AbUJJNrS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268296AbUJJNrS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 09:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268300AbUJJNrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 09:47:17 -0400
Received: from port-212-202-157-208.static.qsc.de ([212.202.157.208]:19420
	"EHLO zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S268296AbUJJNqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 09:46:54 -0400
Message-ID: <41693CF9.10905@ppp0.net>
Date: Sun, 10 Oct 2004 15:45:29 +0200
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.3) Gecko/20040918 Thunderbird/0.8 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Jan Dittmer <jdittmer@ppp0.net>, Greg KH <greg@kroah.com>,
       Rolf Eike Beer <eike-kernel@sf-tec.de>,
       Hotplug List <pcihpd-discuss@lists.sourceforge.net>
Subject: Re: Is there a user space pci rescan method?
References: <E8F8DBCB0468204E856114A2CD20741F2C13E2@mail.local.ActualitySystems.com> <200409241412.45204@bilbo.math.uni-mannheim.de> <41541009.9080206@ppp0.net> <200409241432.06748@bilbo.math.uni-mannheim.de> <20040924145542.GA17147@kroah.com> <41687EBA.7050506@ppp0.net> <41688985.7030607@ppp0.net>
In-Reply-To: <41688985.7030607@ppp0.net>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------000509060504050606000601"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000509060504050606000601
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Jan Dittmer wrote:
> Jan Dittmer wrote:
> 
>>Greg KH wrote:
>>
>>
>>>Please just add the "rescan" support to fakephp, and everyone will be
>>>happy...
>>
>>
>>Well, I started to work on this for fun. What I currently have is a
>>stand-alone module which rescans the pci bus on insert and enables
>>previously disabled devices. This works (at least with my ieee1394 port).
>>Problem is, that fakephp does not get notified about this new pci device
>>and no new file is created in /sys/bus/pci/slots. So I'm going to add
>>this rescan functionality directly to fakephp.
>>Question is: where? My current idea is a fake hotplug slot "rescan" in
>>/sys/bus/pci/slots , where you can write "1" into the "power" attribute.
>>FWIW I've attached the standalone module and a kernel patch which rips
>>out the pci_bus_add_device functionality from pci_bus_add_devices.
> 
> 
> Well, here is a quick & dirty hack, which adds this function to
> enable_slot in fakephp. So if you write "1" in the power attribute of
> any slot, the whole bus gets rescanned (you still need the
> pci_bus_add_device.patch from the previous mail).

Well one last update. This version also handles deactivation of
subfunctions correctly, ie. when the parent should be disabled, all
subfunctions will be disabled first.

Small demo:
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
 #lspci | grep "0000:04"
0000:04:02.0 Multimedia audio controller: Creative Labs SB Audigy (rev 03)
0000:04:02.1 Input device controller: Creative Labs SB Audigy MIDI/Game
port (rev 03)
0000:04:02.2 FireWire (IEEE 1394): Creative Labs SB Audigy FireWire Port
0000:04:03.0 SCSI storage controller: Adaptec AHA-3960D / AIC-7899A
U160/m (rev 01)
0000:04:03.1 SCSI storage controller: Adaptec AHA-3960D / AIC-7899A
U160/m (rev 01)

Sound plays fine afterwards.
Actually this only works only once or twice. At some point the removal
command will hang (but I suppose this is a problem with either
snd-emu10k1 or ieee1394).

Jan



--------------000509060504050606000601
Content-Type: text/x-patch;
 name="fakephp-rescan-on-enable-3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fakephp-rescan-on-enable-3.patch"

diff -X /home/jdittmer/stuff/diffignore -ur linus/drivers/pci/hotplug/fakephp.c pcirescan/drivers/pci/hotplug/fakephp.c
--- linus/drivers/pci/hotplug/fakephp.c	2004-01-09 07:59:45.000000000 +0100
+++ pcirescan/drivers/pci/hotplug/fakephp.c	2004-10-10 15:15:55.000000000 +0200
@@ -165,14 +165,126 @@
 		err("Problem unregistering a slot %s\n", dslot->slot->name);
 }
 
+/**
+ * Rescan slot.
+ * Tries hard not to re-enable already existing devices
+ * also handle scanning of subfunctions
+ * 
+ * @param temp   Device template. Should be set: bus and devfn.
+ */
+static void pci_rescan_slot(struct pci_dev *temp)
+{
+	struct pci_bus *bus = temp->bus;
+	struct pci_dev* old_dev = pci_find_slot(bus->number, temp->devfn);
+	struct pci_dev *dev = NULL;
+	int func = 0;
+	int new_multi = 0;  /* new multifunction device */
+	u8 hdr_type;
+	if (!pci_read_config_byte(temp, PCI_HEADER_TYPE, &hdr_type)) {
+		temp->hdr_type = hdr_type & 0x7f;
+		new_multi=hdr_type & 0x80;
+		if (!old_dev) {
+			dev = pci_scan_single_device(bus, temp->devfn);
+			if (dev) {
+				dbg("Found new device on %s function %x:%x %x\n",
+						bus->name, temp->devfn >> 3,
+						temp->devfn & 7,
+						hdr_type);
+				pci_bus_add_device(dev);
+				add_slot(dev);
+			}
+		}
+		if (new_multi) { /* continue scanning for other functions */
+			for (func = 1, temp->devfn++; func < 8; func++, temp->devfn++) {
+				if (pci_read_config_byte(temp, PCI_HEADER_TYPE, &hdr_type))
+					continue;
+				temp->hdr_type = hdr_type & 0x7f;
+
+				old_dev = pci_find_slot(bus->number, temp->devfn);
+				if (!old_dev) {
+					dev = pci_scan_single_device(bus, temp->devfn);
+					if (dev) {
+						dbg("Found new device on %s function %x:%x %x\n",
+								bus->name, temp->devfn >> 3,
+								temp->devfn & 7,
+								hdr_type);
+						pci_bus_add_device(dev);
+						add_slot(dev);
+					}
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
+static void pci_rescan(void) {
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
@@ -185,6 +297,28 @@
 		err("Can't remove PCI devices with other PCI devices behind it yet.\n");
 		return -ENODEV;
 	}
+	/* search for subfunctions and disable them first */
+	if (!(dslot->dev->devfn & 7)) {
+		dbg("Searching for subfunctions\n");
+		for (func=1;func<8;func++) {
+			dbg("Considering %x %x+%x\n", 
+					dslot->dev->bus->number,
+					dslot->dev->devfn,
+					func);
+			dev = pci_find_slot(dslot->dev->bus->number, dslot->dev->devfn + func);
+			if (dev) {
+				dbg("Slot %s Removed <%s>\n", dslot->dev->slot_name, dslot->dev->pretty_name);
+				hslot = get_slot_from_dev(dev);
+				if (hslot)
+					disable_slot(hslot);
+				else {
+					err("Hotplug slot not found for subordinate pci-device\n");
+					return -ENODEV;
+				}
+			} else 
+				dbg("No device in slot found\n");
+		}
+	}
 
 	/* remove the device from the pci core */
 	pci_remove_bus_device(dslot->dev);


--------------000509060504050606000601
Content-Type: text/x-patch;
 name="pci_bus_add_device.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pci_bus_add_device.patch"

--- linus/include/linux/pci.h	2004-10-06 19:58:35.000000000 +0200
+++ pcirescan/include/linux/pci.h	2004-10-10 01:55:41.000000000 +0200
@@ -704,6 +704,7 @@
 int pci_scan_slot(struct pci_bus *bus, int devfn);
 struct pci_dev * pci_scan_single_device(struct pci_bus *bus, int devfn);
 unsigned int pci_scan_child_bus(struct pci_bus *bus);
+void pci_bus_add_device(struct pci_dev *dev);
 void pci_bus_add_devices(struct pci_bus *bus);
 void pci_name_device(struct pci_dev *dev);
 char *pci_class_name(u32 class);
diff -ur linus/drivers/pci/bus.c pcirescan/drivers/pci/bus.c
--- linus/drivers/pci/bus.c	2004-05-10 10:06:44.000000000 +0200
+++ pcirescan/drivers/pci/bus.c	2004-10-10 01:29:50.000000000 +0200
@@ -69,6 +69,20 @@
 }
 
 /**
+ * add a single device
+ */
+void __devinit pci_bus_add_device(struct pci_dev *dev) {
+	device_add(&dev->dev);
+
+	spin_lock(&pci_bus_lock);
+	list_add_tail(&dev->global_list, &pci_devices);
+	spin_unlock(&pci_bus_lock);
+
+	pci_proc_attach_device(dev);
+	pci_create_sysfs_dev_files(dev);
+}
+
+/**
  * pci_bus_add_devices - insert newly discovered PCI devices
  * @bus: bus to check for new devices
  *
@@ -91,16 +105,7 @@
 		 */
 		if (!list_empty(&dev->global_list))
 			continue;
-
-		device_add(&dev->dev);
-
-		spin_lock(&pci_bus_lock);
-		list_add_tail(&dev->global_list, &pci_devices);
-		spin_unlock(&pci_bus_lock);
-
-		pci_proc_attach_device(dev);
-		pci_create_sysfs_dev_files(dev);
-
+		pci_bus_add_device(dev);
 	}
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
@@ -136,5 +141,6 @@
 }
 
 EXPORT_SYMBOL(pci_bus_alloc_resource);
+EXPORT_SYMBOL(pci_bus_add_device);
 EXPORT_SYMBOL(pci_bus_add_devices);
 EXPORT_SYMBOL(pci_enable_bridges);


--------------000509060504050606000601--
