Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287467AbSA3A2y>; Tue, 29 Jan 2002 19:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287115AbSA3A1I>; Tue, 29 Jan 2002 19:27:08 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:30212 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S287478AbSA3AZb>;
	Tue, 29 Jan 2002 19:25:31 -0500
Date: Tue, 29 Jan 2002 16:24:18 -0800
From: Greg KH <greg@kroah.com>
To: mochel@osdl.org, linux-usb-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] driverfs support for USB - take 2
Message-ID: <20020130002418.GB21784@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Well after determining that the last version of this patch doesn't show
the USB tree properly, here's another patch against 2.5.3-pre6 that
fixes this issue.

With this patch (the driver core changes were from Pat Mochel, thanks
Pat for putting up with my endless questions) my machine now shows the
following tree:

[greg@soap x]$ tree
.
`-- root
    |-- pci0
    |   |-- 00:00.0
    |   |   |-- power
    |   |   `-- status
    |   |-- 00:01.0
    |   |   |-- 02:00.0
    |   |   |   |-- power
    |   |   |   `-- status
    |   |   |-- power
    |   |   `-- status
    |   |-- 00:1e.0
    |   |   |-- 01:08.0
    |   |   |   |-- power
    |   |   |   `-- status
    |   |   |-- 01:0d.0
    |   |   |   |-- power
    |   |   |   |-- status
    |   |   |   `-- usb_bus
    |   |   |       |-- power
    |   |   |       `-- status
    |   |   |-- 01:0d.1
    |   |   |   |-- power
    |   |   |   |-- status
    |   |   |   `-- usb_bus
    |   |   |       |-- 003
    |   |   |       |   |-- power
    |   |   |       |   `-- status
    |   |   |       |-- power
    |   |   |       `-- status
    |   |   |-- 01:0d.2
    |   |   |   |-- power
    |   |   |   |-- status
    |   |   |   `-- usb_bus
    |   |   |       |-- power
    |   |   |       `-- status
    |   |   |-- power
    |   |   `-- status
    |   |-- 00:1f.0
    |   |   |-- power
    |   |   `-- status
    |   |-- 00:1f.1
    |   |   |-- power
    |   |   `-- status
    |   |-- 00:1f.2
    |   |   |-- power
    |   |   |-- status
    |   |   `-- usb_bus
    |   |       |-- 002
    |   |       |   |-- 003
    |   |       |   |   |-- power
    |   |       |   |   `-- status
    |   |       |   |-- power
    |   |       |   `-- status
    |   |       |-- power
    |   |       `-- status
    |   |-- 00:1f.3
    |   |   |-- power
    |   |   `-- status
    |   |-- 00:1f.5
    |   |   |-- power
    |   |   `-- status
    |   |-- power
    |   `-- status
    |-- power
    `-- status


I have 2 USB controllers in this system, 1 UHCI controller on the
motherboard that shows up under PCI device 00:1f.2. There are two
devices plugged into this bus, a hub, and a trackball plugged into the
hub.  This topology is now shown properly.

The other controller is a USB 2.0 controller that shows up in 3 places
on the pci bus: 01:0d.0, 01:0d.1, and 01:0d.2.  The 01:0d.1 device is
controlled by the ohci-hcd driver, and a USB hub is plugged into it.
The ehci-hcd driver controls the other 2 pci devices on the card.

Yes, I need to have better names for the devices than just "usb_bus",
any suggestions?  These devices nodes are really the USB root hubs in
the USB controller, so they could just have the USB number as the name
like the other USB devices (001), but that's pretty boring :)

greg k-h



diff -Nru a/drivers/base/core.c b/drivers/base/core.c
--- a/drivers/base/core.c	Tue Jan 29 16:02:26 2002
+++ b/drivers/base/core.c	Tue Jan 29 16:02:26 2002
@@ -17,10 +17,7 @@
 # define DBG(x...)
 #endif
 
-static struct iobus device_root = {
-	bus_id: "root",
-	name:	"Logical System Root",
-};
+static struct device * device_root;
 
 int (*platform_notify)(struct device * dev) = NULL;
 int (*platform_notify_remove)(struct device * dev) = NULL;
@@ -28,9 +25,6 @@
 extern int device_make_dir(struct device * dev);
 extern void device_remove_dir(struct device * dev);
 
-extern int iobus_make_dir(struct iobus * iobus);
-extern void iobus_remove_dir(struct iobus * iobus);
-
 static spinlock_t device_lock;
 
 /**
@@ -47,19 +41,25 @@
 
 	if (!dev || !strlen(dev->bus_id))
 		return -EINVAL;
-	BUG_ON(!dev->parent);
 
 	spin_lock(&device_lock);
 	INIT_LIST_HEAD(&dev->node);
+	INIT_LIST_HEAD(&dev->children);
 	spin_lock_init(&dev->lock);
 	atomic_set(&dev->refcount,2);
 
-	get_iobus(dev->parent);
-	list_add_tail(&dev->node,&dev->parent->devices);
+	if (dev != device_root) {
+		struct device * parent;
+		if (!dev->parent)
+			dev->parent = device_root;
+		parent = dev->parent;
+		get_device(parent);
+		list_add_tail(&dev->node,&parent->children);
+	}
 	spin_unlock(&device_lock);
 
-	DBG("DEV: registering device: ID = '%s', name = %s, parent = %s\n",
-	    dev->bus_id, dev->name, parent->bus_id);
+	DBG("DEV: registering device: ID = '%s', name = %s\n",
+	    dev->bus_id, dev->name);
 
 	if ((error = device_make_dir(dev)))
 		goto register_done;
@@ -70,8 +70,8 @@
 
  register_done:
 	put_device(dev);
-	if (error)
-		put_iobus(dev->parent);
+	if (error && dev->parent)
+		put_device(dev->parent);
 	return error;
 }
 
@@ -100,9 +100,6 @@
 	/* remove the driverfs directory */
 	device_remove_dir(dev);
 
-	if (dev->subordinate)
-		iobus_remove_dir(dev->subordinate);
-
 	/* Notify the platform of the removal, in case they
 	 * need to do anything...
 	 */
@@ -116,70 +113,18 @@
 	if (dev->driver && dev->driver->remove)
 		dev->driver->remove(dev,REMOVE_FREE_RESOURCES);
 
-	put_iobus(dev->parent);
-}
-
-int iobus_register(struct iobus *bus)
-{
-	int error;
-
-	if (!bus || !strlen(bus->bus_id))
-		return -EINVAL;
-	
-	spin_lock(&device_lock);
-	atomic_set(&bus->refcount,2);
-	spin_lock_init(&bus->lock);
-	INIT_LIST_HEAD(&bus->node);
-	INIT_LIST_HEAD(&bus->devices);
-	INIT_LIST_HEAD(&bus->children);
-
-	if (bus != &device_root) {
-		if (!bus->parent)
-			bus->parent = &device_root;
-		get_iobus(bus->parent);
-		list_add_tail(&bus->node,&bus->parent->children);
-	}
-	spin_unlock(&device_lock);
-
-	DBG("DEV: registering bus. ID = '%s' name = '%s' parent = %p\n",
-	    bus->bus_id,bus->name,bus->parent);
-
-	error = iobus_make_dir(bus);
-
-	put_iobus(bus);
-	if (error && bus->parent)
-		put_iobus(bus->parent);
-	return error;
-}
-
-/**
- * iobus_unregister - remove bus and children from device tree
- * @bus:	pointer to bus structure
- *
- * Remove device from parent's list of children and decrement
- * reference count on controlling device. That should take care of
- * the rest of the cleanup.
- */
-void put_iobus(struct iobus * iobus)
-{
-	if (!atomic_dec_and_lock(&iobus->refcount,&device_lock))
-		return;
-	list_del_init(&iobus->node);
-	spin_unlock(&device_lock);
-
-	if (!list_empty(&iobus->devices) ||
-	    !list_empty(&iobus->children))
-		BUG();
-
-	put_iobus(iobus->parent);
-	/* unregister itself */
-	put_device(iobus->self);
+	put_device(dev->parent);
 }
 
 static int __init device_init_root(void)
 {
-	/* initialize parent bus lists */
-	return iobus_register(&device_root);
+	device_root = kmalloc(sizeof(*device_root),GFP_KERNEL);
+	if (!device_root)
+		return -ENOMEM;
+	memset(device_root,0,sizeof(*device_root));
+	strcpy(device_root->bus_id,"root");
+	strcpy(device_root->name,"System Root");
+	return device_register(device_root);
 }
 
 int __init device_driver_init(void)
@@ -208,5 +153,5 @@
 }
 
 EXPORT_SYMBOL(device_register);
-EXPORT_SYMBOL(iobus_register);
+EXPORT_SYMBOL(put_device);
 EXPORT_SYMBOL(device_driver_init);
diff -Nru a/drivers/base/fs.c b/drivers/base/fs.c
--- a/drivers/base/fs.c	Tue Jan 29 16:02:26 2002
+++ b/drivers/base/fs.c	Tue Jan 29 16:02:26 2002
@@ -102,28 +102,6 @@
 		}
 	}
 	return 0;
-}
-
-void iobus_remove_dir(struct iobus * iobus)
-{
-	if (iobus)
-		driverfs_remove_dir(&iobus->dir);
-}
-
-int iobus_make_dir(struct iobus * iobus)
-{
-	struct driver_dir_entry * parent = NULL;
-	int error;
-
-	INIT_LIST_HEAD(&iobus->dir.files);
-	iobus->dir.mode = (S_IFDIR| S_IRWXU | S_IRUGO | S_IXUGO);
-	iobus->dir.name = iobus->bus_id;
-
-	if (iobus->parent)
-		parent = &iobus->parent->dir;
-
-	error = driverfs_create_dir(&iobus->dir,parent);
-	return error;
 }
 
 EXPORT_SYMBOL(device_create_file);
diff -Nru a/drivers/pci/pci.c b/drivers/pci/pci.c
--- a/drivers/pci/pci.c	Tue Jan 29 16:02:26 2002
+++ b/drivers/pci/pci.c	Tue Jan 29 16:02:26 2002
@@ -1086,13 +1086,7 @@
 	child->parent = parent;
 	child->ops = parent->ops;
 	child->sysdata = parent->sysdata;
-
-	/* init generic fields */
-	child->iobus.self = &dev->dev;
-	child->iobus.parent = &parent->iobus;
-	dev->dev.subordinate = &child->iobus;
-
-	strcpy(child->iobus.name,dev->dev.name);
+	child->dev = &dev->dev;
 
 	/*
 	 * Set up the primary, secondary and subordinate
@@ -1361,16 +1355,11 @@
 	DBG("Scanning bus %02x\n", bus->number);
 	max = bus->secondary;
 
-	/* we should know for sure what the bus number is, so set the bus ID
-	 * for the bus and make sure it's registered in the device tree */
-	sprintf(bus->iobus.bus_id,"pci%d",bus->number);
-	iobus_register(&bus->iobus);
-
 	/* Create a device template */
 	memset(&dev0, 0, sizeof(dev0));
 	dev0.bus = bus;
 	dev0.sysdata = bus->sysdata;
-	dev0.dev.parent = &bus->iobus;
+	dev0.dev.parent = bus->dev;
 	dev0.dev.driver = &pci_device_driver;
 
 	/* Go find them, Rover! */
@@ -1430,9 +1419,11 @@
 		return NULL;
 	list_add_tail(&b->node, &pci_root_buses);
 
-	sprintf(b->iobus.bus_id,"pci%d",bus);
-	strcpy(b->iobus.name,"Host/PCI Bridge");
-	iobus_register(&b->iobus);
+	b->dev = kmalloc(sizeof(*(b->dev)),GFP_KERNEL);
+	memset(b->dev,0,sizeof(*(b->dev)));
+	sprintf(b->dev->bus_id,"pci%d",bus);
+	strcpy(b->dev->name,"Host/PCI Bridge");
+	device_register(b->dev);
 
 	b->number = b->secondary = bus;
 	b->resource[0] = &ioport_resource;
diff -Nru a/drivers/usb/hcd/ehci-hcd.c b/drivers/usb/hcd/ehci-hcd.c
--- a/drivers/usb/hcd/ehci-hcd.c	Tue Jan 29 16:02:26 2002
+++ b/drivers/usb/hcd/ehci-hcd.c	Tue Jan 29 16:02:26 2002
@@ -290,6 +290,12 @@
 		goto done2;
 	}
 
+	/* hook up the root hub to the pci controller in the device tree */
+	udev->dev.parent = &ehci->hcd.pdev->dev;
+	strcpy (udev->dev.name, "usb_name");
+	strcpy (udev->dev.bus_id, "usb_bus");
+	device_register (&udev->dev);
+
 	return 0;
 }
 
diff -Nru a/drivers/usb/hcd/ohci-hcd.c b/drivers/usb/hcd/ohci-hcd.c
--- a/drivers/usb/hcd/ohci-hcd.c	Tue Jan 29 16:02:26 2002
+++ b/drivers/usb/hcd/ohci-hcd.c	Tue Jan 29 16:02:26 2002
@@ -475,7 +475,13 @@
 // FIXME cleanup
 		return -ENODEV;
 	}
-	
+
+	/* hook up the root hub to the pci controller in the device tree */
+	udev->dev.parent = &ohci->hcd.pdev->dev;
+	strcpy (udev->dev.name, "usb_name");
+	strcpy (udev->dev.bus_id, "usb_bus");
+	device_register (&udev->dev);
+
 	return 0;
 }
 
diff -Nru a/drivers/usb/hub.c b/drivers/usb/hub.c
--- a/drivers/usb/hub.c	Tue Jan 29 16:02:27 2002
+++ b/drivers/usb/hub.c	Tue Jan 29 16:02:27 2002
@@ -722,8 +722,16 @@
 			dev->bus->busnum, dev->devpath, dev->devnum);
 
 		/* Run it through the hoops (find a driver, etc) */
-		if (!usb_new_device(dev))
+		if (!usb_new_device(dev)) {
+			/* put the device in the global device tree */
+			dev->dev.parent = &dev->parent->dev;
+			sprintf (&dev->dev.name[0], "USB device %04x:%04x",
+				 dev->descriptor.idVendor,
+				 dev->descriptor.idProduct);
+			sprintf (&dev->dev.bus_id[0], "%03d", dev->devnum);
+			device_register (&dev->dev);
 			goto done;
+		}
 
 		/* Free the configuration if there was an error */
 		usb_free_dev(dev);
diff -Nru a/drivers/usb/uhci.c b/drivers/usb/uhci.c
--- a/drivers/usb/uhci.c	Tue Jan 29 16:02:26 2002
+++ b/drivers/usb/uhci.c	Tue Jan 29 16:02:26 2002
@@ -2848,6 +2848,12 @@
 		goto err_start_root_hub;
 	}
 
+	/* hook the root hub up to the pci controller in the device tree */
+	uhci->rh.dev->dev.parent = &dev->dev;
+	strcpy (uhci->rh.dev->dev.name, "usb_name");
+	strcpy (uhci->rh.dev->dev.bus_id, "usb_bus");
+	device_register (&uhci->rh.dev->dev);
+
 	return 0;
 
 /*
diff -Nru a/drivers/usb/usb-ohci.c b/drivers/usb/usb-ohci.c
--- a/drivers/usb/usb-ohci.c	Tue Jan 29 16:02:26 2002
+++ b/drivers/usb/usb-ohci.c	Tue Jan 29 16:02:26 2002
@@ -2508,6 +2508,13 @@
 #ifdef	DEBUG
 	ohci_dump (ohci, 1);
 #endif
+
+	/* hook the root hub up to the pci controller in the device tree */
+	ohci->bus->root_hub->dev.parent = &dev->dev;
+	strcpy (ohci->bus->root_hub->dev.name, "usb_name");
+	strcpy (ohci->bus->root_hub->dev.bus_id, "usb_bus");
+	device_register (&ohci->bus->root_hub->dev);
+
 	return 0;
 }
 
diff -Nru a/drivers/usb/usb-uhci.c b/drivers/usb/usb-uhci.c
--- a/drivers/usb/usb-uhci.c	Tue Jan 29 16:02:26 2002
+++ b/drivers/usb/usb-uhci.c	Tue Jan 29 16:02:26 2002
@@ -3028,6 +3028,12 @@
 	pci_set_drvdata(dev, s);
 	devs=s;
 
+	/* hook the root hub up to the pci controller in the device tree */
+	s->bus->root_hub->dev.parent = &dev->dev;
+	strcpy (s->bus->root_hub->dev.name, "usb_name");
+	strcpy (s->bus->root_hub->dev.bus_id, "usb_bus");
+	device_register (&s->bus->root_hub->dev);
+
 	return 0;
 }
 
diff -Nru a/drivers/usb/usb.c b/drivers/usb/usb.c
--- a/drivers/usb/usb.c	Tue Jan 29 16:02:27 2002
+++ b/drivers/usb/usb.c	Tue Jan 29 16:02:27 2002
@@ -1925,6 +1951,7 @@
 	if (dev->devnum > 0) {
 		clear_bit(dev->devnum, &dev->bus->devmap.devicemap);
 		usbfs_remove_device(dev);
+		put_device(&dev->dev);
 	}
 
 	/* Free up the device itself */
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	Tue Jan 29 16:02:26 2002
+++ b/include/linux/device.h	Tue Jan 29 16:02:26 2002
@@ -66,10 +66,8 @@
 
 struct device {
 	struct list_head node;		/* node in sibling list */
-	struct iobus	*parent;	/* parent bus */
-
-	struct iobus	*subordinate;	/* only valid if this device is a
-					   bridge device */
+	struct list_head children;
+	struct device 	*parent;
 
 	char	name[DEVICE_NAME_SIZE];	/* descriptive ascii string */
 	char	bus_id[BUS_ID_SIZE];	/* position on parent bus */
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Tue Jan 29 16:02:26 2002
+++ b/include/linux/pci.h	Tue Jan 29 16:02:26 2002
@@ -432,8 +432,7 @@
 	unsigned char	productver;	/* product version */
 	unsigned char	checksum;	/* if zero - checksum passed */
 	unsigned char	pad1;
-
-	struct iobus	iobus;		/* Generic device interface */
+	struct	device	* dev;
 };
 
 #define pci_bus_b(n) list_entry(n, struct pci_bus, node)
diff -Nru a/include/linux/usb.h b/include/linux/usb.h
--- a/include/linux/usb.h	Tue Jan 29 16:02:26 2002
+++ b/include/linux/usb.h	Tue Jan 29 16:02:26 2002
@@ -1,6 +1,8 @@
 #ifndef __LINUX_USB_H
 #define __LINUX_USB_H
 
+#include <linux/device.h>
+
 /* USB constants */
 
 /*
@@ -1037,6 +1042,8 @@
 
 	struct usb_device *parent;
 	struct usb_bus *bus;		/* Bus we're part of */
+
+	struct device dev;		/* Generic device interface */
 
 	struct usb_device_descriptor descriptor;/* Descriptor */
 	struct usb_config_descriptor *config;	/* All of the configs */
