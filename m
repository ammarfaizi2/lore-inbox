Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267696AbUJJAOa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267696AbUJJAOa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 20:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267793AbUJJAOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 20:14:30 -0400
Received: from port-212-202-157-208.static.qsc.de ([212.202.157.208]:53938
	"EHLO zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S267696AbUJJAOP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 20:14:15 -0400
Message-ID: <41687EBA.7050506@ppp0.net>
Date: Sun, 10 Oct 2004 02:13:46 +0200
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040918)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Rolf Eike Beer <eike-kernel@sf-tec.de>, linux-kernel@vger.kernel.org,
       Hotplug List <pcihpd-discuss@lists.sourceforge.net>
Subject: Re: Is there a user space pci rescan method?
References: <E8F8DBCB0468204E856114A2CD20741F2C13E2@mail.local.ActualitySystems.com> <200409241412.45204@bilbo.math.uni-mannheim.de> <41541009.9080206@ppp0.net> <200409241432.06748@bilbo.math.uni-mannheim.de> <20040924145542.GA17147@kroah.com>
In-Reply-To: <20040924145542.GA17147@kroah.com>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------080007000300030700050403"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080007000300030700050403
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Greg KH wrote:
> Please just add the "rescan" support to fakephp, and everyone will be
> happy...

Well, I started to work on this for fun. What I currently have is a
stand-alone module which rescans the pci bus on insert and enables
previously disabled devices. This works (at least with my ieee1394 port).
Problem is, that fakephp does not get notified about this new pci device
and no new file is created in /sys/bus/pci/slots. So I'm going to add
this rescan functionality directly to fakephp.
Question is: where? My current idea is a fake hotplug slot "rescan" in
/sys/bus/pci/slots , where you can write "1" into the "power" attribute.
FWIW I've attached the standalone module and a kernel patch which rips
out the pci_bus_add_device functionality from pci_bus_add_devices.

Jan

--------------080007000300030700050403
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

--------------080007000300030700050403
Content-Type: text/plain;
 name="Makefile"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Makefile"

ifneq ($(KERNELRELEASE),)

obj-m	:= pcirescan.o

else

KDIR	:= /lib/modules/$(shell uname -r)/build
# KDIR := ../pcirescan
PWD	:= $(shell pwd)

default:
	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules
endif

--------------080007000300030700050403
Content-Type: text/x-csrc;
 name="pcirescan.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pcirescan.c"

/**
 * rescan the pci bus on insert
 * Jan Dittmer <jdittmer@ppp0.net>
 *
 * heavily based on a similar module from
 * Vladimir Kondratiev, vladimir.kondratiev@intel.com
 */
#include <linux/module.h>
#include <linux/pci.h>
#include <linux/init.h>
#include <linux/errno.h>

/**
 * Rescan slot.
 * First, determine whether card in the slot has changed. It is
 * done by compare of old and actual devices for function 0.
 * If change detected, old device(s) removed, other functions
 * scanned if it is multi-function dev, new devices inserted.
 * 
 * @param temp   Device template. Should be set: bus and devfn.
 * @return Device for function 0
 */
void pci_rescan_slot(struct pci_dev *temp)
{
	struct pci_bus *bus = temp->bus;
	struct pci_dev* old_dev = pci_find_slot(bus->number,temp->devfn);
	struct pci_dev *dev = NULL;
	int func = 0;
	int new_multi = 0;  /* new multifunction device */
	u8 hdr_type;
	/* function 0 */
	if (!pci_read_config_byte(temp, PCI_HEADER_TYPE, &hdr_type)) {
		temp->hdr_type = hdr_type & 0x7f;
		new_multi=hdr_type & 0x80;
		if (!old_dev) {
			dev = pci_scan_single_device(bus, temp->devfn);
			if (dev) {
				printk("Found new device on %s function %x:%x %x\n",
						bus->name, temp->devfn >> 3,
						temp->devfn & 7,
						hdr_type);
				pci_bus_add_device(dev);
			}
		}
		if (new_multi) { /* continue scanning for other functions */
/*			printk("Scanning subfunctions\n"); */
			for (func = 1, temp->devfn++; func < 8; func++, temp->devfn++) {
				//	printk("%x\n", func);
				if (pci_read_config_byte(temp, PCI_HEADER_TYPE, &hdr_type))
					continue;
				temp->hdr_type = hdr_type & 0x7f;

				old_dev = pci_find_slot(bus->number, temp->devfn);
				if (!old_dev) {
					dev = pci_scan_single_device(bus, temp->devfn);
					if (dev) {
						printk("Found new device on %s function %x:%x %x\n",
								bus->name, temp->devfn >> 3,
								temp->devfn & 7,
								hdr_type);
						printk("Prettyname %s\n", dev->pretty_name);
						// from drivers/pci/bus.c, pci_bus_add_devices
						pci_bus_add_device(dev);
					}
				} 
			}
		}
	}
}


/**
 * Rescan PCI bus.
 * Assumed, some slots may have changed its content.
 * Find old information about each slot and the new one.
 * If they match, do nothing. Otherwise,
 * remove/insert proper devices.
 * 
 * @param bus
 */
static void pci_rescan_bus(const struct pci_bus *bus)
{
	unsigned int devfn;
	struct pci_dev dev0;

	memset(&dev0, 0, sizeof(dev0));
	dev0.bus = (struct pci_bus*)bus;
	dev0.sysdata = bus->sysdata;
	for (devfn = 0; devfn < 0x100; devfn += 8) {
		dev0.devfn = devfn;
		pci_rescan_slot(&dev0);
	}
}

static void pci_rescan_buses(const struct list_head *list)
{
	const struct list_head *l;
	list_for_each(l,list) {
		const struct pci_bus *b = pci_bus_b(l);
		/*
		printk("Scanning Bus %d:%d:%d, %s\n", b->number,
				b->primary, b->secondary, b->name);
		*/
		pci_rescan_bus(b);
		pci_rescan_buses(&b->children);
	}
}



static int pci_rescan_init(void)
{
	pci_rescan_buses(&pci_root_buses);
	return -ENODEV;
}

static void pci_rescan_exit(void)
{}


module_init(pci_rescan_init);
module_exit(pci_rescan_exit);

MODULE_DESCRIPTION("Do PCI bus rescan");
MODULE_AUTHOR("jdi");


--------------080007000300030700050403--
