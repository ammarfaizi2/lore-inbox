Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267971AbUJJBA3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267971AbUJJBA3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 21:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267984AbUJJBA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 21:00:29 -0400
Received: from port-212-202-157-208.static.qsc.de ([212.202.157.208]:62133
	"EHLO zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S267971AbUJJBAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 21:00:11 -0400
Message-ID: <41688985.7030607@ppp0.net>
Date: Sun, 10 Oct 2004 02:59:49 +0200
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040918)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Rolf Eike Beer <eike-kernel@sf-tec.de>, linux-kernel@vger.kernel.org,
       Hotplug List <pcihpd-discuss@lists.sourceforge.net>
Subject: Re: Is there a user space pci rescan method?
References: <E8F8DBCB0468204E856114A2CD20741F2C13E2@mail.local.ActualitySystems.com> <200409241412.45204@bilbo.math.uni-mannheim.de> <41541009.9080206@ppp0.net> <200409241432.06748@bilbo.math.uni-mannheim.de> <20040924145542.GA17147@kroah.com> <41687EBA.7050506@ppp0.net>
In-Reply-To: <41687EBA.7050506@ppp0.net>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------060309040502090203050503"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060309040502090203050503
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Jan Dittmer wrote:
> Greg KH wrote:
> 
>>Please just add the "rescan" support to fakephp, and everyone will be
>>happy...
> 
> 
> Well, I started to work on this for fun. What I currently have is a
> stand-alone module which rescans the pci bus on insert and enables
> previously disabled devices. This works (at least with my ieee1394 port).
> Problem is, that fakephp does not get notified about this new pci device
> and no new file is created in /sys/bus/pci/slots. So I'm going to add
> this rescan functionality directly to fakephp.
> Question is: where? My current idea is a fake hotplug slot "rescan" in
> /sys/bus/pci/slots , where you can write "1" into the "power" attribute.
> FWIW I've attached the standalone module and a kernel patch which rips
> out the pci_bus_add_device functionality from pci_bus_add_devices.

Well, here is a quick & dirty hack, which adds this function to
enable_slot in fakephp. So if you write "1" in the power attribute of
any slot, the whole bus gets rescanned (you still need the
pci_bus_add_device.patch from the previous mail).

Thanks,

Jan

--------------060309040502090203050503
Content-Type: text/x-patch;
 name="fakephp-rescan-on-enable.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fakephp-rescan-on-enable.patch"

diff -ur linus/drivers/pci/hotplug/fakephp.c pcirescan/drivers/pci/hotplug/fakephp.c
--- linus/drivers/pci/hotplug/fakephp.c	2004-01-09 07:59:45.000000000 +0100
+++ pcirescan/drivers/pci/hotplug/fakephp.c	2004-10-10 02:53:05.000000000 +0200
@@ -165,8 +165,111 @@
 		err("Problem unregistering a slot %s\n", dslot->slot->name);
 }
 
+/**
+ * Rescan slot.
+ * First, determine whether card in the slot has changed. It is
+ * done by compare of old and actual devices for function 0.
+ * If change detected, old device(s) removed, other functions
+ * scanned if it is multi-function dev, new devices inserted.
+ * 
+ * @param temp   Device template. Should be set: bus and devfn.
+ * @return Device for function 0
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
+				printk("Found new device on %s function %x:%x %x\n",
+						bus->name, temp->devfn >> 3,
+						temp->devfn & 7,
+						hdr_type);
+				pci_bus_add_device(dev);
+				add_slot(dev);
+			}
+		}
+		if (new_multi) { /* continue scanning for other functions */
+			for (func = 1, temp->devfn++; func < 8; func++, temp->devfn++) {
+				//	printk("%x\n", func);
+				if (pci_read_config_byte(temp, PCI_HEADER_TYPE, &hdr_type))
+					continue;
+				temp->hdr_type = hdr_type & 0x7f;
+
+				old_dev = pci_find_slot(bus->number, temp->devfn);
+				if (!old_dev) {
+					dev = pci_scan_single_device(bus, temp->devfn);
+					if (dev) {
+						printk("Found new device on %s function %x:%x %x\n",
+								bus->name, temp->devfn >> 3,
+								temp->devfn & 7,
+								hdr_type);
+						// from drivers/pci/bus.c, pci_bus_add_devices
+						pci_bus_add_device(dev);
+						// add fakephp slot
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
+ * Assumed, some slots may have changed its content.
+ * Find old information about each slot and the new one.
+ * If they match, do nothing. Otherwise,
+ * remove/insert proper devices.
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
+static void pci_rescan(void) {
+	pci_rescan_buses(&pci_root_buses);
+}
+
+
 static int enable_slot(struct hotplug_slot *hotplug_slot)
 {
+	/* mis-use enable_slot for rescanning of pci bus */
+	pci_rescan();
 	return -ENODEV;
 }
 

--------------060309040502090203050503--
