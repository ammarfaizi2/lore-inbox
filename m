Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290495AbSAYCPR>; Thu, 24 Jan 2002 21:15:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290497AbSAYCPI>; Thu, 24 Jan 2002 21:15:08 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:48903 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S290495AbSAYCOu>;
	Thu, 24 Jan 2002 21:14:50 -0500
Date: Thu, 24 Jan 2002 18:14:35 -0800
From: Greg KH <greg@kroah.com>
To: mochel@osdl.org, linux-usb-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] driverfs support for USB
Message-ID: <20020125021435.GA22080@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's a first cut at adding driverfs support to the USB core code.
This patch is against 2.5.3-pre5.  I've tested this out with the
ehci-hcd and uhci drivers, and everything seems to work ok (it doesn't
oops for me anymore :)

Right now all devices show up under the pci usb controller directory,
just like usbfs works.  I'll be changing things so that hubs are iobus
structures too, which should allow us to show the topology of the trees
correctly (unless Pat changes all devices to be iobusses too :)

Pat,
You need to export the put_device and put_iobus functions.  The end of
this patch has that fix.  Also, put_iobus doesn't seem to remove the
directory that iobus_register created (but a later call to
iobus_register() seems to place everything in the same place again.)  Is
this the correct thing that should be happening?

Just to show what this looks like, here is what driverfs looks like on
my box right now (device pci0/pci1/usb/002 is a hub that device 003 is
hanging off of).

[greg@soap x]$ tree
.
`-- root
    `-- pci0
        |-- 00:00.0
        |   |-- power
        |   `-- status
        |-- 00:01.0
        |   |-- power
        |   `-- status
        |-- 00:1e.0
        |   |-- power
        |   `-- status
        |-- 00:1f.0
        |   |-- power
        |   `-- status
        |-- 00:1f.1
        |   |-- power
        |   `-- status
        |-- 00:1f.2
        |   |-- power
        |   `-- status
        |-- 00:1f.3
        |   |-- power
        |   `-- status
        |-- 00:1f.5
        |   |-- power
        |   `-- status
        |-- pci1
        |   |-- 01:08.0
        |   |   |-- power
        |   |   `-- status
        |   |-- 01:0d.2
        |   |   |-- power
        |   |   `-- status
        |   `-- usb
        |       |-- 002
        |       |   |-- power
        |       |   `-- status
        |       `-- 003
        |           |-- power
        |           `-- status
        |-- pci2
        |   `-- 02:00.0
        |       |-- power
        |       `-- status
        `-- usb
            `-- 002
                |-- power
                `-- status


If anyone has any problems or fixes to this patch, please let me know.

thanks,

greg k-h


diff -Nru a/drivers/usb/hcd.c b/drivers/usb/hcd.c
--- a/drivers/usb/hcd.c	Thu Jan 24 17:26:21 2002
+++ b/drivers/usb/hcd.c	Thu Jan 24 17:26:21 2002
@@ -666,6 +666,12 @@
 	if ((retval = driver->start (hcd)) < 0)
 		usb_hcd_pci_remove (dev);
 
+	/* initialize the iobus info for this usb pci device */
+	bus->iobus.self = &dev->dev;
+	bus->iobus.parent = bus->iobus.self->parent;
+	strcpy (bus->iobus.bus_id, "usb");
+	iobus_register (&bus->iobus);
+
 	return retval;
 } 
 EXPORT_SYMBOL (usb_hcd_pci_probe);
diff -Nru a/drivers/usb/hub.c b/drivers/usb/hub.c
--- a/drivers/usb/hub.c	Thu Jan 24 17:26:21 2002
+++ b/drivers/usb/hub.c	Thu Jan 24 17:26:21 2002
@@ -722,8 +722,16 @@
 			dev->bus->busnum, dev->devpath, dev->devnum);
 
 		/* Run it through the hoops (find a driver, etc) */
-		if (!usb_new_device(dev))
+		if (!usb_new_device(dev)) {
+			/* put the device in the global device tree */
+			dev->dev.parent = &dev->bus->iobus;
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
--- a/drivers/usb/uhci.c	Thu Jan 24 17:26:21 2002
+++ b/drivers/usb/uhci.c	Thu Jan 24 17:26:21 2002
@@ -2843,6 +2847,12 @@
 		retval = -ENOMEM;
 		goto err_start_root_hub;
 	}
+
+	/* initialize the iobus info for this usb pci device */
+	bus->iobus.self = &dev->dev;
+	bus->iobus.parent = bus->iobus.self->parent;
+	strcpy (bus->iobus.bus_id, "usb");
+	iobus_register (&bus->iobus);
 
 	return 0;
 
diff -Nru a/drivers/usb/usb-ohci.c b/drivers/usb/usb-ohci.c
--- a/drivers/usb/usb-ohci.c	Thu Jan 24 17:26:21 2002
+++ b/drivers/usb/usb-ohci.c	Thu Jan 24 17:26:21 2002
@@ -2508,6 +2508,13 @@
 #ifdef	DEBUG
 	ohci_dump (ohci, 1);
 #endif
+
+	/* initialize the iobus info for this usb pci device */
+	ohci->bus->iobus.self = &dev->dev;
+	ohci->bus->iobus.parent = ohci->bus->iobus.self->parent;
+	strcpy (ohci->bus->iobus.bus_id, "usb");
+	iobus_register (&ohci->bus->iobus);
+
 	return 0;
 }
 
diff -Nru a/drivers/usb/usb-uhci.c b/drivers/usb/usb-uhci.c
--- a/drivers/usb/usb-uhci.c	Thu Jan 24 17:26:20 2002
+++ b/drivers/usb/usb-uhci.c	Thu Jan 24 17:26:20 2002
@@ -3015,6 +3027,12 @@
 	//chain new uhci device into global list
 	pci_set_drvdata(dev, s);
 	devs=s;
+
+	/* initialize the iobus info for this usb pci device */
+	bus->iobus.self = &dev->dev;
+	bus->iobus.parent = bus->iobus.self->parent;
+	strcpy (bus->iobus.bus_id, "usb");
+	iobus_register (&bus->iobus);
 
 	return 0;
 }
diff -Nru a/drivers/usb/usb.c b/drivers/usb/usb.c
--- a/drivers/usb/usb.c	Thu Jan 24 17:26:21 2002
+++ b/drivers/usb/usb.c	Thu Jan 24 17:26:21 2002
@@ -502,6 +503,7 @@
 	up (&usb_bus_list_lock);
 
 	usbfs_remove_bus(bus);
+	put_iobus(&bus->iobus);
 
 	clear_bit(bus->busnum, busmap.busmap);
 
@@ -1924,6 +1926,7 @@
 	if (dev->devnum > 0) {
 		clear_bit(dev->devnum, &dev->bus->devmap.devicemap);
 		usbfs_remove_device(dev);
+		put_device(&dev->dev);
 	}
 
 	/* Free up the device itself */
diff -Nru a/include/linux/usb.h b/include/linux/usb.h
--- a/include/linux/usb.h	Thu Jan 24 17:26:21 2002
+++ b/include/linux/usb.h	Thu Jan 24 17:26:21 2002
@@ -1,6 +1,8 @@
 #ifndef __LINUX_USB_H
 #define __LINUX_USB_H
 
+#include <linux/device.h>
+
 /* USB constants */
 
 /*
@@ -935,6 +938,8 @@
 	struct dentry *dentry;		/* usbfs dentry entry for the bus */
 
 	atomic_t refcnt;
+
+	struct iobus iobus;		/* Generic device interface */
 };
 
 extern struct usb_bus *usb_alloc_bus(struct usb_operations *);
@@ -1037,6 +1042,8 @@
 	struct usb_device *parent;
 	struct usb_bus *bus;		/* Bus we're part of */
 
+	struct device dev;		/* Generic device interface */
+
 	struct usb_device_descriptor descriptor;/* Descriptor */
 	struct usb_config_descriptor *config;	/* All of the configs */
 	struct usb_config_descriptor *actconfig;/* the active configuration */
diff -Nru a/kernel/device.c b/kernel/device.c
--- a/kernel/device.c	Thu Jan 24 17:26:21 2002
+++ b/kernel/device.c	Thu Jan 24 17:26:21 2002
@@ -308,7 +308,7 @@
 }
 
 /**
- * iobus_unregister - remove bus and children from device tree
+ * put_iobus - remove bus and children from device tree
  * @bus:	pointer to bus structure
  *
  * Remove device from parent's list of children and decrement
@@ -521,7 +521,9 @@
 __setup("device=",device_setup);
 
 EXPORT_SYMBOL(device_register);
+EXPORT_SYMBOL(put_device);
 EXPORT_SYMBOL(device_create_file);
 EXPORT_SYMBOL(device_remove_file);
 EXPORT_SYMBOL(iobus_register);
+EXPORT_SYMBOL(put_iobus);
 EXPORT_SYMBOL(device_driver_init);
