Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316342AbSHJAJq>; Fri, 9 Aug 2002 20:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316390AbSHJAJq>; Fri, 9 Aug 2002 20:09:46 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:15625 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S316342AbSHJAJj>;
	Fri, 9 Aug 2002 20:09:39 -0400
Date: Fri, 9 Aug 2002 17:10:05 -0700
From: Greg KH <greg@kroah.com>
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: Patrick Mochel <mochel@osdl.org>
Subject: [RFC] USB driver conversion to use "struct device_driver"
Message-ID: <20020810001005.GA29490@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Fri, 12 Jul 2002 22:58:24 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Here's a patch against 2.5.30 that is the start of converting the USB
code over to using the new core "struct device_driver" logic and
functionality.  Right now only the HUB and HID drivers are converted,
and so they are the only ones that will work properly (the others will
compile, but no devices are ever bound to them.)

The code is still quite rough in places, but the baic functions seem to
work well (driver callbacks, etc.)  There is some odd USB specific
tweaks that were needed to be done in order to get this working
properly.

The USB subsystem only binds drivers to USB "interfaces".  A USB device
may have many "interfaces", so a single device may have many drivers
attached to it, handling different portions of it (think of a USB
speaker, which has a audio driver for the audio stream, and a HID driver
for the speaker buttons.)  Because of this I had to create a "empty"
device driver that I attach to the USB device structure.  This ensures
it shows up properly in the driverfs tree, and that no USB drivers try
to bind to it.

Also, the driverfs representation of the USB devices has changed,
possibly for the worse.  Just try the patch to see what I mean :)

There is a known bug that happens in put_device() when a USB device is
removed from the system, but the proper person already knows about it.

Comments?

If I don't hear any objections, I'll work on converting all of the USB
drivers over to this model (the probe and disconnect function parameters
have changed) and send the patch to Linus.

Many thanks to Pat Mochel for the original version of this patch (way
back against 2.5.15) and for putting up with all of the USB device /
interface madness.

thanks,

greg k-h



diff -Nru a/drivers/usb/core/config.c b/drivers/usb/core/config.c
--- a/drivers/usb/core/config.c	Fri Aug  9 16:59:55 2002
+++ b/drivers/usb/core/config.c	Fri Aug  9 16:59:55 2002
@@ -89,7 +89,7 @@
 	return parsed;
 }
 
-static int usb_parse_interface(struct usb_interface *interface, unsigned char *buffer, int size)
+static int usb_parse_interface(struct usb_interface *interface, int ifnum, unsigned char *buffer, int size)
 {
 	int i, len, numskipped, retval, parsed = 0;
 	struct usb_descriptor_header *header;
@@ -99,6 +99,7 @@
 	interface->act_altsetting = 0;
 	interface->num_altsetting = 0;
 	interface->max_altsetting = USB_ALTSETTINGALLOC;
+	interface->ifnum = ifnum;
 
 	interface->altsetting = kmalloc(sizeof(struct usb_interface_descriptor) * interface->max_altsetting, GFP_KERNEL);
 	
@@ -323,7 +324,7 @@
 			}
 		}
 
-		retval = usb_parse_interface(config->interface + i, buffer, size);
+		retval = usb_parse_interface(config->interface + i, i, buffer, size);
 		if (retval < 0)
 			return retval;
 
diff -Nru a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
--- a/drivers/usb/core/hcd.c	Fri Aug  9 16:59:55 2002
+++ b/drivers/usb/core/hcd.c	Fri Aug  9 16:59:55 2002
@@ -723,13 +723,15 @@
 {
 	int retval;
 
-	usb_dev->dev.parent = parent_dev;
-	strcpy (&usb_dev->dev.name[0], "usb_name");
-	strcpy (&usb_dev->dev.bus_id[0], "usb_bus");
-	retval = usb_new_device (usb_dev);
+//	usb_dev->dev.parent = parent_dev;
+//	strcpy (&usb_dev->dev.name[0], "usb_name");
+//	strcpy (&usb_dev->dev.bus_id[0], "usb_bus");
+	retval = usb_new_device (usb_dev, parent_dev);
 	if (retval)
-		put_device (&usb_dev->dev);
+		dbg("%s - retval = %d", __FUNCTION__, retval);
+//		put_device (&usb_dev->dev);
 	return retval;
+//	return usb_new_device (usb_dev, parent_dev);
 }
 EXPORT_SYMBOL (usb_register_root_hub);
 
diff -Nru a/drivers/usb/core/hcd.h b/drivers/usb/core/hcd.h
--- a/drivers/usb/core/hcd.h	Fri Aug  9 16:59:55 2002
+++ b/drivers/usb/core/hcd.h	Fri Aug  9 16:59:55 2002
@@ -230,7 +230,7 @@
 /* -------------------------------------------------------------------------- */
 
 /* Enumeration is only for the hub driver, or HCD virtual root hubs */
-extern int usb_new_device(struct usb_device *dev);
+extern int usb_new_device(struct usb_device *dev, struct device *parent);
 extern void usb_connect(struct usb_device *dev);
 extern void usb_disconnect(struct usb_device **);
 
diff -Nru a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
--- a/drivers/usb/core/hub.c	Fri Aug  9 16:59:55 2002
+++ b/drivers/usb/core/hub.c	Fri Aug  9 16:59:55 2002
@@ -183,13 +183,14 @@
 
 		/* drop lock so HCD can concurrently report other TT errors */
 		spin_unlock_irqrestore (&hub->tt.lock, flags);
-		status = hub_clear_tt_buffer (hub->dev,
+		status = hub_clear_tt_buffer (hub->intf->usb_device,
 				clear->devinfo, clear->tt);
 		spin_lock_irqsave (&hub->tt.lock, flags);
 
 		if (status)
 			err ("usb-%s-%s clear tt %d (%04x) error %d",
-				hub->dev->bus->bus_name, hub->dev->devpath,
+				hub->intf->usb_device->bus->bus_name,
+				hub->intf->usb_device->devpath,
 				clear->tt, clear->devinfo, status);
 		kfree (clear);
 	}
@@ -250,7 +251,7 @@
 	/* Enable power to the ports */
 	dbg("enabling power on all ports");
 	for (i = 0; i < hub->descriptor->bNbrPorts; i++)
-		usb_set_port_feature(hub->dev, i + 1, USB_PORT_FEAT_POWER);
+		usb_set_port_feature(hub->intf->usb_device, i + 1, USB_PORT_FEAT_POWER);
 
 	/* Wait for power to be enabled */
 	wait_ms(hub->descriptor->bPwrOn2PwrGood * 2);
@@ -259,7 +260,7 @@
 static int usb_hub_configure(struct usb_hub *hub,
 	struct usb_endpoint_descriptor *endpoint)
 {
-	struct usb_device *dev = hub->dev;
+	struct usb_device *dev = hub->intf->usb_device;
 	struct usb_hub_status hubstatus;
 	char portstr[USB_MAXCHILDREN + 1];
 	unsigned int pipe;
@@ -426,39 +427,78 @@
 	return 0;
 }
 
-static void *hub_probe(struct usb_device *dev, unsigned int i,
-		       const struct usb_device_id *id)
+static void hub_disconnect(struct usb_interface *intf)
 {
-	struct usb_interface_descriptor *interface;
+	struct usb_hub *hub = (struct usb_hub *)intf->dev.driver_data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&hub_event_lock, flags);
+
+	/* Delete it and then reset it */
+	list_del(&hub->event_list);
+	INIT_LIST_HEAD(&hub->event_list);
+	list_del(&hub->hub_list);
+	INIT_LIST_HEAD(&hub->hub_list);
+
+	spin_unlock_irqrestore(&hub_event_lock, flags);
+
+	down(&hub->khubd_sem); /* Wait for khubd to leave this hub alone. */
+	up(&hub->khubd_sem);
+
+	/* assuming we used keventd, it must quiesce too */
+	if (hub->tt.hub)
+		flush_scheduled_tasks ();
+
+	if (hub->urb) {
+		usb_unlink_urb(hub->urb);
+		usb_free_urb(hub->urb);
+		hub->urb = NULL;
+	}
+
+	if (hub->descriptor) {
+		kfree(hub->descriptor);
+		hub->descriptor = NULL;
+	}
+
+	/* Free the memory */
+	kfree(hub);
+	intf->dev.driver_data = NULL;
+}
+
+static int hub_probe(struct usb_interface *intf)
+{
+	struct usb_interface_descriptor *desc;
 	struct usb_endpoint_descriptor *endpoint;
+	struct usb_device *dev;
 	struct usb_hub *hub;
 	unsigned long flags;
 
-	interface = &dev->actconfig->interface[i].altsetting[0];
+	desc = intf->altsetting + intf->act_altsetting;
+	dev = intf->usb_device;
 
 	/* Some hubs have a subclass of 1, which AFAICT according to the */
 	/*  specs is not defined, but it works */
-	if ((interface->bInterfaceSubClass != 0) &&
-	    (interface->bInterfaceSubClass != 1)) {
+	if ((desc->bInterfaceSubClass != 0) &&
+	    (desc->bInterfaceSubClass != 1)) {
 		err("invalid subclass (%d) for USB hub device #%d",
-			interface->bInterfaceSubClass, dev->devnum);
-		return NULL;
+			desc->bInterfaceSubClass, dev->devnum);
+		return -EIO;
 	}
 
 	/* Multiple endpoints? What kind of mutant ninja-hub is this? */
-	if (interface->bNumEndpoints != 1) {
+	if (desc->bNumEndpoints != 1) {
 		err("invalid bNumEndpoints (%d) for USB hub device #%d",
-			interface->bNumEndpoints, dev->devnum);
-		return NULL;
+			desc->bNumEndpoints, dev->devnum);
+		return -EIO;
 	}
 
-	endpoint = &interface->endpoint[0];
+	endpoint = &desc->endpoint[0];
 
 	/* Output endpoint? Curiousier and curiousier.. */
 	if (!(endpoint->bEndpointAddress & USB_DIR_IN)) {
 		err("Device #%d is hub class, but has output endpoint?",
 			dev->devnum);
-		return NULL;
+		return -EIO;
 	}
 
 	/* If it's not an interrupt endpoint, we'd better punt! */
@@ -466,7 +506,7 @@
 			!= USB_ENDPOINT_XFER_INT) {
 		err("Device #%d is hub class, but endpoint is not interrupt?",
 			dev->devnum);
-		return NULL;
+		return -EIO;
 	}
 
 	/* We found a hub */
@@ -475,13 +515,13 @@
 	hub = kmalloc(sizeof(*hub), GFP_KERNEL);
 	if (!hub) {
 		err("couldn't kmalloc hub struct");
-		return NULL;
+		return -ENOMEM;
 	}
 
 	memset(hub, 0, sizeof(*hub));
 
 	INIT_LIST_HEAD(&hub->event_list);
-	hub->dev = dev;
+	hub->intf = intf;
 	init_MUTEX(&hub->khubd_sem);
 
 	/* Record the new hub's existence */
@@ -490,14 +530,19 @@
 	list_add(&hub->hub_list, &hub_list);
 	spin_unlock_irqrestore(&hub_event_lock, flags);
 
+	intf->dev.driver_data = hub;
+
 	if (usb_hub_configure(hub, endpoint) >= 0) {
-		strcpy (dev->actconfig->interface[i].dev.name,
-			"Hub/Port Status Changes");
-		return hub;
+//		strcpy (dev->actconfig->interface[i].dev.name,
+//			"Hub/Port Status Changes");
+		return 0;
 	}
 
 	err("hub configuration failed for device at %s", dev->devpath);
 
+	hub_disconnect (intf);
+	return -ENODEV;
+#if 0
 	/* free hub, but first clean up its list. */
 	spin_lock_irqsave(&hub_event_lock, flags);
 
@@ -512,43 +557,7 @@
 	kfree(hub);
 
 	return NULL;
-}
-
-static void hub_disconnect(struct usb_device *dev, void *ptr)
-{
-	struct usb_hub *hub = (struct usb_hub *)ptr;
-	unsigned long flags;
-
-	spin_lock_irqsave(&hub_event_lock, flags);
-
-	/* Delete it and then reset it */
-	list_del(&hub->event_list);
-	INIT_LIST_HEAD(&hub->event_list);
-	list_del(&hub->hub_list);
-	INIT_LIST_HEAD(&hub->hub_list);
-
-	spin_unlock_irqrestore(&hub_event_lock, flags);
-
-	down(&hub->khubd_sem); /* Wait for khubd to leave this hub alone. */
-	up(&hub->khubd_sem);
-
-	/* assuming we used keventd, it must quiesce too */
-	if (hub->tt.hub)
-		flush_scheduled_tasks ();
-
-	if (hub->urb) {
-		usb_unlink_urb(hub->urb);
-		usb_free_urb(hub->urb);
-		hub->urb = NULL;
-	}
-
-	if (hub->descriptor) {
-		kfree(hub->descriptor);
-		hub->descriptor = NULL;
-	}
-
-	/* Free the memory */
-	kfree(hub);
+#endif
 }
 
 static int hub_ioctl(struct usb_device *hub, unsigned int code, void *user_data)
@@ -585,7 +594,7 @@
 
 static int usb_hub_reset(struct usb_hub *hub)
 {
-	struct usb_device *dev = hub->dev;
+	struct usb_device *dev = hub->intf->usb_device;
 	int i;
 
 	/* Disconnect any attached devices */
@@ -797,7 +806,7 @@
 static void usb_hub_port_connect_change(struct usb_hub *hubstate, int port,
 					u16 portstatus, u16 portchange)
 {
-	struct usb_device *hub = hubstate->dev;
+	struct usb_device *hub = hubstate->intf->usb_device;
 	struct usb_device *dev;
 	unsigned int delay = HUB_SHORT_RESET_TIME;
 	int i;
@@ -896,7 +905,7 @@
 		sprintf (&dev->dev.bus_id[0], "%d", port + 1);
 
 		/* Run it through the hoops (find a driver, etc) */
-		if (!usb_new_device(dev))
+		if (!usb_new_device(dev, &hubstate->intf->dev))
 			goto done;
 
 		/* Free the configuration if there was an error */
@@ -941,7 +950,7 @@
 		tmp = hub_event_list.next;
 
 		hub = list_entry(tmp, struct usb_hub, event_list);
-		dev = hub->dev;
+		dev = hub->intf->usb_device;
 
 		list_del(tmp);
 		INIT_LIST_HEAD(tmp);
@@ -1081,9 +1090,9 @@
 
 static struct usb_driver hub_driver = {
 	.name =		"hub",
-	.probe =	hub_probe,
+	.new_probe =	hub_probe,
 	.ioctl =	hub_ioctl,
-	.disconnect =	hub_disconnect,
+	.new_disco =	hub_disconnect,
 	.id_table =	hub_id_table,
 };
 
diff -Nru a/drivers/usb/core/hub.h b/drivers/usb/core/hub.h
--- a/drivers/usb/core/hub.h	Fri Aug  9 16:59:55 2002
+++ b/drivers/usb/core/hub.h	Fri Aug  9 16:59:55 2002
@@ -166,7 +166,8 @@
 extern void usb_hub_tt_clear_buffer (struct usb_device *dev, int pipe);
 
 struct usb_hub {
-	struct usb_device	*dev;		/* the "real" device */
+//	struct usb_device	*dev;		/* the "real" device */
+	struct usb_interface	*intf;		/* the "real" device */
 	struct urb		*urb;		/* for interrupt polling pipe */
 
 	/* buffer for urb ... 1 bit each for hub and children, rounded up */
diff -Nru a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
--- a/drivers/usb/core/usb.c	Fri Aug  9 16:59:55 2002
+++ b/drivers/usb/core/usb.c	Fri Aug  9 16:59:55 2002
@@ -61,6 +61,50 @@
 LIST_HEAD(usb_driver_list);
 
 
+static int generic_probe (struct device *dev)
+{
+	return 0;
+}
+static int generic_remove (struct device *dev)
+{
+	return 0;
+}
+static void generic_release (struct device_driver * drv)
+{
+}
+
+static struct device_driver usb_generic_driver = {
+	.name =	"generic usb driver",
+	.probe = generic_probe,
+	.remove = generic_remove,
+	.release = generic_release,
+};
+	
+
+static int usb_device_probe(struct device * dev)
+{
+	struct usb_interface * intf = list_entry(dev,struct usb_interface,dev);
+	struct usb_driver * drv = list_entry(dev->driver,struct usb_driver,driver);
+	int error = -ENODEV;
+
+	dbg("%s", __FUNCTION__);
+
+	if (drv->new_probe)
+		error = drv->new_probe(intf);
+	if (!error)
+		intf->driver = drv;
+	return error;
+}
+
+static int usb_device_remove(struct device * dev)
+{
+	struct usb_interface * intf = list_entry(dev,struct usb_interface,dev);
+
+	if (intf->driver && intf->driver->new_disco)
+		intf->driver->new_disco(intf);
+	return 0;
+}
+
 /**
  * usb_register - register a USB driver
  * @new_driver: USB operations for the driver
@@ -78,16 +122,26 @@
 {
 	int retval = 0;
 
-	info("registered new driver %s", new_driver->name);
+	new_driver->driver.name = (char *)new_driver->name;
+	new_driver->driver.bus = &usb_bus_type;
+	new_driver->driver.probe = usb_device_probe;
+	new_driver->driver.remove = usb_device_remove;
 
 	init_MUTEX(&new_driver->serialize);
 
-	/* Add it to the list of known drivers */
-	list_add_tail(&new_driver->driver_list, &usb_driver_list);
-
-	usb_scan_devices();
-
-	usbfs_update_special();
+//	/* Add it to the list of known drivers */
+//	list_add_tail(&new_driver->driver_list, &usb_driver_list);
+//
+//	usb_scan_devices();
+	retval = driver_register(&new_driver->driver);
+
+	if (!retval) {
+		info("registered new driver %s", new_driver->name);
+		usbfs_update_special();
+	} else {
+		err("problem %d when registering driver %s",
+			retval, new_driver->name);
+	}
 
 	return retval;
 }
@@ -604,6 +658,75 @@
 	return NULL;
 }
 
+static int usb_device_bind (struct device *dev, struct device_driver *drv)
+{
+	struct usb_interface *intf = list_entry(dev, struct usb_interface, dev);
+	struct usb_interface_descriptor *desc;
+	struct usb_device *usb_dev;
+	struct usb_driver *usb_drv;
+	const struct usb_device_id *id;
+
+	desc = &intf->altsetting[intf->act_altsetting];
+	usb_dev = intf->usb_device;
+	usb_drv = list_entry(drv, struct usb_driver, driver);
+	id = usb_drv->id_table;
+	
+	/* It is important to check that id->driver_info is nonzero,
+	   since an entry that is all zeroes except for a nonzero
+	   id->driver_info is the way to create an entry that
+	   indicates that the driver want to examine every
+	   device and interface. */
+	for (; (id) && (id->idVendor || id->bDeviceClass || id->bInterfaceClass ||
+	       id->driver_info); id++) {
+
+		if ((id->match_flags & USB_DEVICE_ID_MATCH_VENDOR) &&
+		    id->idVendor != usb_dev->descriptor.idVendor)
+			continue;
+
+		if ((id->match_flags & USB_DEVICE_ID_MATCH_PRODUCT) &&
+		    id->idProduct != usb_dev->descriptor.idProduct)
+			continue;
+
+		/* No need to test id->bcdDevice_lo != 0, since 0 is never
+		   greater than any unsigned number. */
+		if ((id->match_flags & USB_DEVICE_ID_MATCH_DEV_LO) &&
+		    (id->bcdDevice_lo > usb_dev->descriptor.bcdDevice))
+			continue;
+
+		if ((id->match_flags & USB_DEVICE_ID_MATCH_DEV_HI) &&
+		    (id->bcdDevice_hi < usb_dev->descriptor.bcdDevice))
+			continue;
+
+		if ((id->match_flags & USB_DEVICE_ID_MATCH_DEV_CLASS) &&
+		    (id->bDeviceClass != usb_dev->descriptor.bDeviceClass))
+			continue;
+
+		if ((id->match_flags & USB_DEVICE_ID_MATCH_DEV_SUBCLASS) &&
+		    (id->bDeviceSubClass!= usb_dev->descriptor.bDeviceSubClass))
+			continue;
+
+		if ((id->match_flags & USB_DEVICE_ID_MATCH_DEV_PROTOCOL) &&
+		    (id->bDeviceProtocol != usb_dev->descriptor.bDeviceProtocol))
+			continue;
+
+		if ((id->match_flags & USB_DEVICE_ID_MATCH_INT_CLASS) &&
+		    (id->bInterfaceClass != desc->bInterfaceClass))
+			continue;
+
+		if ((id->match_flags & USB_DEVICE_ID_MATCH_INT_SUBCLASS) &&
+		    (id->bInterfaceSubClass != desc->bInterfaceSubClass))
+		    continue;
+
+		if ((id->match_flags & USB_DEVICE_ID_MATCH_INT_PROTOCOL) &&
+		    (id->bInterfaceProtocol != desc->bInterfaceProtocol))
+		    continue;
+
+		return 1;
+	}
+
+	return 0;
+}
+
 /*
  * This entrypoint gets called for each new device.
  *
@@ -1346,11 +1469,12 @@
  */
 #define NEW_DEVICE_RETRYS	2
 #define SET_ADDRESS_RETRYS	2
-int usb_new_device(struct usb_device *dev)
+int usb_new_device(struct usb_device *dev, struct device *parent)
 {
 	int err = 0;
 	int i;
 	int j;
+	int ifnum;
 
 	/* USB v1.1 5.5.3 */
 	/* We read the first 8 bytes from the device descriptor to get to */
@@ -1437,6 +1561,12 @@
 #endif
 
 	/* register this device in the driverfs tree */
+	usb_generic_driver.bus = &usb_bus_type;
+	dev->dev.parent = parent;
+	dev->dev.driver = &usb_generic_driver;
+	dev->dev.bus = &usb_bus_type;
+	sprintf (&dev->dev.bus_id[0], "%s-%s",
+		 dev->bus->bus_name, dev->devpath);
 	err = device_register (&dev->dev);
 	if (err)
 		return err;
@@ -1450,10 +1580,39 @@
 
 	/* now that the basic setup is over, add a /proc/bus/usb entry */
 	usbfs_add_device(dev);
-
 	/* find drivers willing to handle this device */
-	usb_find_drivers(dev);
+//	usb_find_drivers(dev);
+	for (ifnum = 0; ifnum < dev->actconfig->bNumInterfaces; ifnum++) {
+		struct usb_interface *interface = &dev->actconfig->interface[ifnum];
+		struct usb_interface_descriptor *desc = interface->altsetting;
 
+		/* register this interface with driverfs */
+		interface->usb_device = dev;
+		interface->dev.parent = &dev->dev;
+		interface->dev.bus = &usb_bus_type;
+		sprintf (&interface->dev.bus_id[0], "%s-%s:%d",
+			 dev->bus->bus_name, dev->devpath,
+			 interface->altsetting->bInterfaceNumber);
+		if (!desc->iInterface
+				|| usb_string (dev, desc->iInterface,
+					interface->dev.name,
+					sizeof interface->dev.name) <= 0) {
+			/* typically devices won't bother with interface
+			 * descriptions; this is the normal case.  an
+			 * interface's driver might describe it better.
+			 * (also: iInterface is per-altsetting ...)
+			 */
+			sprintf (&interface->dev.name[0],
+				"usb-%s-%s interface %d",
+				dev->bus->bus_name, dev->devpath,
+				interface->altsetting->bInterfaceNumber);
+		}
+		dbg("%s - registering %s", __FUNCTION__, interface->dev.bus_id);
+		device_register (&interface->dev);
+		device_create_file (&interface->dev, &dev_attr_altsetting);
+	}
+
+	
 	/* userspace may load modules and/or configure further */
 	call_policy ("add", dev);
 
@@ -1620,7 +1779,8 @@
 #endif
 
 struct bus_type usb_bus_type = {
-	.name =	"usb",
+	.name =		"usb",
+	.match =	usb_device_bind,
 };
 
 /*
diff -Nru a/drivers/usb/input/hid-core.c b/drivers/usb/input/hid-core.c
--- a/drivers/usb/input/hid-core.c	Fri Aug  9 16:59:55 2002
+++ b/drivers/usb/input/hid-core.c	Fri Aug  9 16:59:55 2002
@@ -1338,9 +1338,10 @@
 	{ 0, 0 }
 };
 
-static struct hid_device *usb_hid_configure(struct usb_device *dev, int ifnum)
+static struct hid_device *usb_hid_configure(struct usb_interface *intf)
 {
-	struct usb_interface_descriptor *interface = dev->actconfig->interface[ifnum].altsetting + 0;
+	struct usb_interface_descriptor *interface = intf->altsetting + intf->act_altsetting;
+	struct usb_device *dev = intf->usb_device;
 	struct hid_descriptor *hdesc;
 	struct hid_device *hid;
 	unsigned quirks = 0, rsize = 0;
@@ -1450,7 +1451,7 @@
 		snprintf(hid->name, 128, "%04x:%04x", dev->descriptor.idVendor, dev->descriptor.idProduct);
 
 	usb_make_path(dev, buf, 64);
-	snprintf(hid->phys, 64, "%s/input%d", buf, ifnum);
+	snprintf(hid->phys, 64, "%s/input%d", buf, intf->ifnum);
 
 	if (usb_string(dev, dev->descriptor.iSerialNumber, hid->uniq, 64) <= 0)
 		hid->uniq[0] = 0;
@@ -1472,9 +1473,9 @@
 	return NULL;
 }
 
-static void hid_disconnect(struct usb_device *dev, void *ptr)
+static void hid_disconnect(struct usb_interface *intf)
 {
-	struct hid_device *hid = ptr;
+	struct hid_device *hid = intf->dev.driver_data;
 
 	usb_unlink_urb(hid->urbin);
 	usb_unlink_urb(hid->urbout);
@@ -1491,20 +1492,20 @@
 		usb_free_urb(hid->urbout);
 
 	hid_free_device(hid);
+	intf->dev.driver_data = NULL;
 }
 
-static void* hid_probe(struct usb_device *dev, unsigned int ifnum,
-		       const struct usb_device_id *id)
+static int hid_probe (struct usb_interface *intf)
 {
 	struct hid_device *hid;
 	char path[64];
 	int i;
 	char *c;
 
-	dbg("HID probe called for ifnum %d", ifnum);
+	dbg("HID probe called for ifnum %d", intf->ifnum);
 
-	if (!(hid = usb_hid_configure(dev, ifnum)))
-		return NULL;
+	if (!(hid = usb_hid_configure(intf)))
+		return -EIO;
 
 	hid_init_reports(hid);
 	hid_dump_device(hid);
@@ -1516,9 +1517,11 @@
 	if (!hiddev_connect(hid))
 		hid->claimed |= HID_CLAIMED_HIDDEV;
 
+	intf->dev.driver_data = hid;
+
 	if (!hid->claimed) {
-		hid_disconnect(dev, hid);
-		return NULL;
+		hid_disconnect(intf);
+		return -EIO;
 	}
 
 	printk(KERN_INFO);
@@ -1540,12 +1543,12 @@
 		}
 	}
 
-	usb_make_path(dev, path, 63);
+	usb_make_path(intf->usb_device, path, 63);
 
 	printk(": USB HID v%x.%02x %s [%s] on %s\n",
 		hid->version >> 8, hid->version & 0xff, c, hid->name, path);
 
-	return hid;
+	return 0;
 }
 
 static struct usb_device_id hid_usb_ids [] = {
@@ -1558,8 +1561,8 @@
 
 static struct usb_driver hid_driver = {
 	.name =		"hid",
-	.probe =	hid_probe,
-	.disconnect =	hid_disconnect,
+	.new_probe =	hid_probe,
+	.new_disco =	hid_disconnect,
 	.id_table =	hid_usb_ids,
 };
 
diff -Nru a/include/linux/usb.h b/include/linux/usb.h
--- a/include/linux/usb.h	Fri Aug  9 16:59:55 2002
+++ b/include/linux/usb.h	Fri Aug  9 16:59:55 2002
@@ -252,8 +252,10 @@
 	int act_altsetting;		/* active alternate setting */
 	int num_altsetting;		/* number of alternate settings */
 	int max_altsetting;		/* total memory allocated */
- 
+	int ifnum;			/* number of this interface */
+
 	struct usb_driver *driver;	/* driver */
+	struct usb_device *usb_device;	/* device this interface is on */
 	struct device dev;		/* interface specific device info */
 	void *private_data;
 };
@@ -683,6 +685,12 @@
 struct usb_driver {
 	struct module *owner;
 	const char *name;
+
+	int	(*new_probe)	(struct usb_interface *intf);
+	int	(*init)		(struct usb_interface *intf);
+	void	(*new_disco)	(struct usb_interface *intf);
+
+	struct device_driver driver;
 
 	void *(*probe)(
 	    struct usb_device *dev,		/* the device */
