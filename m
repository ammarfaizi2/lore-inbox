Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319118AbSHWTdh>; Fri, 23 Aug 2002 15:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319154AbSHWTdg>; Fri, 23 Aug 2002 15:33:36 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:51209 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S319118AbSHWTdL>;
	Fri, 23 Aug 2002 15:33:11 -0400
Date: Fri, 23 Aug 2002 12:31:26 -0700
From: Greg KH <greg@kroah.com>
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: Patrick Mochel <mochel@osdl.org>
Subject: Re: [RFC] USB driver conversion to "struct device_driver" for 2.5.31
Message-ID: <20020823193125.GA13753@kroah.com>
References: <20020822204457.GA7532@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020822204457.GA7532@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As I got some complaints that the patch was difficult to apply, here it
is again, against 2.5.31-bk6.

Changes from the version yesterday include:
	- conversion of usbmouse.c driver by Pat Mochel
	- tried to fix up module locking issues in the new_probe() and
	  new_disco() calls.

I'm pretty sure I've messed up the disconnect and connect ability of
usbfs (the ioctl calls).  If anyone can test this out, I would
appreciate it.

thanks,

greg k-h


diff -Naur -X /home/greg/linux/dontdiff linux-2.5.31-bk6/drivers/usb/class/audio.c linux-2.5.31-bk6-greg/drivers/usb/class/audio.c
--- linux-2.5.31-bk6/drivers/usb/class/audio.c	Sat Aug 10 18:41:56 2002
+++ linux-2.5.31-bk6-greg/drivers/usb/class/audio.c	Fri Aug 23 12:13:26 2002
@@ -2756,7 +2756,6 @@
 	.name =		"audio",
 	.probe =	usb_audio_probe,
 	.disconnect =	usb_audio_disconnect,
-	.driver_list =	LIST_HEAD_INIT(usb_audio_driver.driver_list), 
 	.id_table =	usb_audio_ids,
 };
 
diff -Naur -X /home/greg/linux/dontdiff linux-2.5.31-bk6/drivers/usb/class/usb-midi.c linux-2.5.31-bk6-greg/drivers/usb/class/usb-midi.c
--- linux-2.5.31-bk6/drivers/usb/class/usb-midi.c	Sat Aug 10 18:41:18 2002
+++ linux-2.5.31-bk6-greg/drivers/usb/class/usb-midi.c	Fri Aug 23 12:13:26 2002
@@ -2099,7 +2099,6 @@
 	.probe = usb_midi_probe,
 	.disconnect = usb_midi_disconnect,
 	.id_table =	NULL, 			/* check all devices */
-	.driver_list = LIST_HEAD_INIT(usb_midi_driver.driver_list)
 };
 
 /* ------------------------------------------------------------------------- */
diff -Naur -X /home/greg/linux/dontdiff linux-2.5.31-bk6/drivers/usb/core/devices.c linux-2.5.31-bk6-greg/drivers/usb/core/devices.c
--- linux-2.5.31-bk6/drivers/usb/core/devices.c	Sat Aug 10 18:41:28 2002
+++ linux-2.5.31-bk6-greg/drivers/usb/core/devices.c	Fri Aug 23 12:13:26 2002
@@ -111,7 +111,6 @@
 
 /*
  * Need access to the driver and USB bus lists.
- * extern struct list_head usb_driver_list;
  * extern struct list_head usb_bus_list;
  * However, these will come from functions that return ptrs to each of them.
  */
diff -Naur -X /home/greg/linux/dontdiff linux-2.5.31-bk6/drivers/usb/core/devio.c linux-2.5.31-bk6-greg/drivers/usb/core/devio.c
--- linux-2.5.31-bk6/drivers/usb/core/devio.c	Fri Aug 23 11:53:49 2002
+++ linux-2.5.31-bk6-greg/drivers/usb/core/devio.c	Fri Aug 23 12:13:26 2002
@@ -427,30 +427,6 @@
 	return -ENOENT; 
 }
 
-extern struct list_head usb_driver_list;
-
-#if 0
-static int finddriver(struct usb_driver **driver, char *name)
-{
-	struct list_head *tmp;
-
-	tmp = usb_driver_list.next;
-	while (tmp != &usb_driver_list) {
-		struct usb_driver *d = list_entry(tmp, struct usb_driver,
-							driver_list);
-
-		if (!strcmp(d->name, name)) {
-			*driver = d;
-			return 0;
-		}
-
-		tmp = tmp->next;
-	}
-
-	return -EINVAL;
-}
-#endif
-
 static int check_ctrlrecip(struct dev_state *ps, unsigned int requesttype, unsigned int index)
 {
 	int ret;
@@ -723,11 +699,10 @@
 		if (test_bit(i, &ps->ifclaimed))
 			continue;
 
-		lock_kernel();
+		err ("%s - this function is broken", __FUNCTION__);
 		if (intf->driver && ps->dev) {
-			usb_bind_driver (intf->driver, intf);
+			usb_device_probe (&intf->dev);
 		}
-		unlock_kernel();
 	}
 
 	return 0;
@@ -1090,22 +1065,19 @@
 
        /* disconnect kernel driver from interface, leaving it unbound.  */
        case USBDEVFS_DISCONNECT:
-       	/* this function is voodoo. without locking it is a maybe thing */
-		lock_kernel();
-               driver = ifp->driver;
-               if (driver) {
-                       dbg ("disconnect '%s' from dev %d interface %d",
-                               driver->name, ps->dev->devnum, ctrl.ifno);
-		       usb_unbind_driver(ps->dev, ifp);
-                       usb_driver_release_interface (driver, ifp);
-               } else
+		/* this function is voodoo. */
+		driver = ifp->driver;
+		if (driver) {
+			dbg ("disconnect '%s' from dev %d interface %d",
+			     driver->name, ps->dev->devnum, ctrl.ifno);
+			usb_device_remove(&ifp->dev);
+		} else
 			retval = -EINVAL;
-		unlock_kernel();
-               break;
+		break;
 
 	/* let kernel drivers try to (re)bind to the interface */
 	case USBDEVFS_CONNECT:
-		usb_find_interface_driver (ps->dev, ifp);
+		retval = usb_device_probe (&ifp->dev);
 		break;
 
        /* talk directly to the interface's driver */
diff -Naur -X /home/greg/linux/dontdiff linux-2.5.31-bk6/drivers/usb/core/hcd.c linux-2.5.31-bk6-greg/drivers/usb/core/hcd.c
--- linux-2.5.31-bk6/drivers/usb/core/hcd.c	Fri Aug 23 11:53:49 2002
+++ linux-2.5.31-bk6-greg/drivers/usb/core/hcd.c	Fri Aug 23 12:13:26 2002
@@ -724,13 +724,15 @@
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
+		err("%s - usb_new_device failed with value %d", __FUNCTION__, retval);
+//		put_device (&usb_dev->dev);
 	return retval;
+//	return usb_new_device (usb_dev, parent_dev);
 }
 EXPORT_SYMBOL (usb_register_root_hub);
 
diff -Naur -X /home/greg/linux/dontdiff linux-2.5.31-bk6/drivers/usb/core/hcd.h linux-2.5.31-bk6-greg/drivers/usb/core/hcd.h
--- linux-2.5.31-bk6/drivers/usb/core/hcd.h	Fri Aug 23 11:53:49 2002
+++ linux-2.5.31-bk6-greg/drivers/usb/core/hcd.h	Fri Aug 23 12:14:33 2002
@@ -230,7 +230,7 @@
 /* -------------------------------------------------------------------------- */
 
 /* Enumeration is only for the hub driver, or HCD virtual root hubs */
-extern int usb_new_device(struct usb_device *dev);
+extern int usb_new_device(struct usb_device *dev, struct device *parent);
 extern void usb_connect(struct usb_device *dev);
 extern void usb_disconnect(struct usb_device **);
 
@@ -354,10 +354,6 @@
 extern int usb_find_interface_driver (struct usb_device *dev,
 	struct usb_interface *interface);
 
-/* for probe/disconnect with correct module usage counting */
-void *usb_bind_driver(struct usb_driver *driver, struct usb_interface *intf);
-void usb_unbind_driver(struct usb_device *device, struct usb_interface *intf);
-
 /*-------------------------------------------------------------------------*/
 
 /* hub.h ... DeviceRemovable in 2.4.2-ac11, gone in 2.4.10 */
diff -Naur -X /home/greg/linux/dontdiff linux-2.5.31-bk6/drivers/usb/core/hub.c linux-2.5.31-bk6-greg/drivers/usb/core/hub.c
--- linux-2.5.31-bk6/drivers/usb/core/hub.c	Sat Aug 10 18:41:28 2002
+++ linux-2.5.31-bk6-greg/drivers/usb/core/hub.c	Fri Aug 23 12:13:26 2002
@@ -175,6 +175,7 @@
 	while (!list_empty (&hub->tt.clear_list)) {
 		struct list_head	*temp;
 		struct usb_tt_clear	*clear;
+		struct usb_device	*dev;
 		int			status;
 
 		temp = hub->tt.clear_list.next;
@@ -183,13 +184,13 @@
 
 		/* drop lock so HCD can concurrently report other TT errors */
 		spin_unlock_irqrestore (&hub->tt.lock, flags);
-		status = hub_clear_tt_buffer (hub->dev,
-				clear->devinfo, clear->tt);
+		dev = interface_to_usbdev (hub->intf);
+		status = hub_clear_tt_buffer (dev, clear->devinfo, clear->tt);
 		spin_lock_irqsave (&hub->tt.lock, flags);
 
 		if (status)
 			err ("usb-%s-%s clear tt %d (%04x) error %d",
-				hub->dev->bus->bus_name, hub->dev->devpath,
+				dev->bus->bus_name, dev->devpath,
 				clear->tt, clear->devinfo, status);
 		kfree (clear);
 	}
@@ -245,12 +246,14 @@
 
 static void usb_hub_power_on(struct usb_hub *hub)
 {
+	struct usb_device *dev;
 	int i;
 
 	/* Enable power to the ports */
 	dbg("enabling power on all ports");
+	dev = interface_to_usbdev(hub->intf);
 	for (i = 0; i < hub->descriptor->bNbrPorts; i++)
-		usb_set_port_feature(hub->dev, i + 1, USB_PORT_FEAT_POWER);
+		usb_set_port_feature(dev, i + 1, USB_PORT_FEAT_POWER);
 
 	/* Wait for power to be enabled */
 	wait_ms(hub->descriptor->bPwrOn2PwrGood * 2);
@@ -259,7 +262,7 @@
 static int usb_hub_configure(struct usb_hub *hub,
 	struct usb_endpoint_descriptor *endpoint)
 {
-	struct usb_device *dev = hub->dev;
+	struct usb_device *dev = interface_to_usbdev (hub->intf);
 	struct usb_hub_status hubstatus;
 	char portstr[USB_MAXCHILDREN + 1];
 	unsigned int pipe;
@@ -426,39 +429,81 @@
 	return 0;
 }
 
-static void *hub_probe(struct usb_device *dev, unsigned int i,
-		       const struct usb_device_id *id)
+static void hub_disconnect(struct usb_interface *intf)
+{
+	struct usb_hub *hub = (struct usb_hub *)intf->dev.driver_data;
+	unsigned long flags;
+
+	if (!hub)
+		return;
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
+static int hub_probe(struct usb_interface *intf, const struct usb_device_id *id)
 {
-	struct usb_interface_descriptor *interface;
+	struct usb_interface_descriptor *desc;
 	struct usb_endpoint_descriptor *endpoint;
+	struct usb_device *dev;
 	struct usb_hub *hub;
 	unsigned long flags;
 
-	interface = &dev->actconfig->interface[i].altsetting[0];
+	desc = intf->altsetting + intf->act_altsetting;
+	dev = interface_to_usbdev(intf);
 
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
@@ -466,7 +511,7 @@
 			!= USB_ENDPOINT_XFER_INT) {
 		err("Device #%d is hub class, but endpoint is not interrupt?",
 			dev->devnum);
-		return NULL;
+		return -EIO;
 	}
 
 	/* We found a hub */
@@ -475,13 +520,13 @@
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
@@ -490,14 +535,18 @@
 	list_add(&hub->hub_list, &hub_list);
 	spin_unlock_irqrestore(&hub_event_lock, flags);
 
+	intf->dev.driver_data = hub;
+
 	if (usb_hub_configure(hub, endpoint) >= 0) {
-		strcpy (dev->actconfig->interface[i].dev.name,
-			"Hub/Port Status Changes");
-		return hub;
+		strcpy (intf->dev.name, "Hub/Port Status Changes");
+		return 0;
 	}
 
 	err("hub configuration failed for device at %s", dev->devpath);
 
+	hub_disconnect (intf);
+	return -ENODEV;
+#if 0
 	/* free hub, but first clean up its list. */
 	spin_lock_irqsave(&hub_event_lock, flags);
 
@@ -512,43 +561,7 @@
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
@@ -585,7 +598,7 @@
 
 static int usb_hub_reset(struct usb_hub *hub)
 {
-	struct usb_device *dev = hub->dev;
+	struct usb_device *dev = interface_to_usbdev(hub->intf);
 	int i;
 
 	/* Disconnect any attached devices */
@@ -797,7 +810,7 @@
 static void usb_hub_port_connect_change(struct usb_hub *hubstate, int port,
 					u16 portstatus, u16 portchange)
 {
-	struct usb_device *hub = hubstate->dev;
+	struct usb_device *hub = interface_to_usbdev(hubstate->intf);
 	struct usb_device *dev;
 	unsigned int delay = HUB_SHORT_RESET_TIME;
 	int i;
@@ -892,11 +905,15 @@
 		/* put the device in the global device tree. the hub port
 		 * is the "bus_id"; hubs show in hierarchy like bridges
 		 */
-		dev->dev.parent = &dev->parent->dev;
+//		dev->dev.parent = &dev->parent->dev;
+//		if (dev->parent->dev.parent)
+			dev->dev.parent = dev->parent->dev.parent->parent;
+//		else
+//			dev->dev.parent = &dev->parent->dev;
 		sprintf (&dev->dev.bus_id[0], "%d", port + 1);
 
 		/* Run it through the hoops (find a driver, etc) */
-		if (!usb_new_device(dev))
+		if (!usb_new_device(dev, &hubstate->intf->dev))
 			goto done;
 
 		/* Free the configuration if there was an error */
@@ -941,7 +958,7 @@
 		tmp = hub_event_list.next;
 
 		hub = list_entry(tmp, struct usb_hub, event_list);
-		dev = hub->dev;
+		dev = interface_to_usbdev(hub->intf);
 
 		list_del(tmp);
 		INIT_LIST_HEAD(tmp);
@@ -1081,9 +1098,9 @@
 
 static struct usb_driver hub_driver = {
 	.name =		"hub",
-	.probe =	hub_probe,
+	.new_probe =	hub_probe,
 	.ioctl =	hub_ioctl,
-	.disconnect =	hub_disconnect,
+	.new_disco =	hub_disconnect,
 	.id_table =	hub_id_table,
 };
 
diff -Naur -X /home/greg/linux/dontdiff linux-2.5.31-bk6/drivers/usb/core/hub.h linux-2.5.31-bk6-greg/drivers/usb/core/hub.h
--- linux-2.5.31-bk6/drivers/usb/core/hub.h	Fri Aug 23 11:53:49 2002
+++ linux-2.5.31-bk6-greg/drivers/usb/core/hub.h	Fri Aug 23 12:13:26 2002
@@ -170,7 +170,8 @@
 extern void usb_hub_tt_clear_buffer (struct usb_device *dev, int pipe);
 
 struct usb_hub {
-	struct usb_device	*dev;		/* the "real" device */
+//	struct usb_device	*dev;		/* the "real" device */
+	struct usb_interface	*intf;		/* the "real" device */
 	struct urb		*urb;		/* for interrupt polling pipe */
 
 	/* buffer for urb ... 1 bit each for hub and children, rounded up */
diff -Naur -X /home/greg/linux/dontdiff linux-2.5.31-bk6/drivers/usb/core/usb.c linux-2.5.31-bk6-greg/drivers/usb/core/usb.c
--- linux-2.5.31-bk6/drivers/usb/core/usb.c	Fri Aug 23 11:53:49 2002
+++ linux-2.5.31-bk6-greg/drivers/usb/core/usb.c	Fri Aug 23 12:17:19 2002
@@ -48,17 +48,95 @@
 extern int usb_major_init(void);
 extern void usb_major_cleanup(void);
 
-/*
- * Prototypes for the device driver probing/loading functions
- */
-static void usb_find_drivers(struct usb_device *);
-static void usb_check_support(struct usb_device *);
 
-/*
- * We have a per-interface "registered driver" list.
- */
-LIST_HEAD(usb_driver_list);
 
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
+int usb_device_probe(struct device *dev)
+{
+	struct usb_interface * intf = to_usb_interface(dev);
+	struct usb_driver * driver = to_usb_driver(dev->driver);
+	const struct usb_device_id *id;
+	int error = -ENODEV;
+	int m;
+
+	dbg("%s", __FUNCTION__);
+
+	if (!driver->new_probe)
+		return error;
+
+	if (driver->owner) {
+		m = try_inc_mod_count(driver->owner);
+		if (m == 0)
+			return error;
+	}
+
+	id = usb_match_id (intf, driver->id_table);
+	if (id) {
+		dbg ("%s - got id", __FUNCTION__);
+		down (&driver->serialize);
+		error = driver->new_probe (intf, id);
+		up (&driver->serialize);
+	}
+	if (!error)
+		intf->driver = driver;
+
+	if (driver->owner)
+		__MOD_DEC_USE_COUNT(driver->owner);
+
+	return error;
+}
+
+int usb_device_remove(struct device *dev)
+{
+	struct usb_interface *intf = list_entry(dev,struct usb_interface,dev);
+	struct usb_driver *driver = to_usb_driver(dev->driver);
+	int m;
+
+	if (driver->owner) {
+		m = try_inc_mod_count(driver->owner);
+		if (m == 0) {
+			err("Dieing driver still bound to device.\n");
+			return -EIO;
+		}
+	}
+
+	/* if we sleep here on an umanaged driver 
+	 * the holder of the lock guards against 
+	 * module unload */
+	down(&driver->serialize);
+
+	if (intf->driver && intf->driver->new_disco)
+		intf->driver->new_disco(intf);
+
+	/* if driver->disconnect didn't release the interface */
+	if (intf->driver)
+		usb_driver_release_interface(driver, intf);
+
+	up(&driver->serialize);
+	if (driver->owner) {
+		__MOD_DEC_USE_COUNT(driver->owner);
+	}
+	return 0;
+}
 
 /**
  * usb_register - register a USB driver
@@ -77,61 +155,40 @@
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
+	retval = driver_register(&new_driver->driver);
 
-	usbfs_update_special();
+	if (!retval) {
+		info("registered new driver %s", new_driver->name);
+		usbfs_update_special();
+	} else {
+		err("problem %d when registering driver %s",
+			retval, new_driver->name);
+	}
 
 	return retval;
 }
 
-
+#if 0
 /**
- *	usb_scan_devices - scans all unclaimed USB interfaces
- *	Context: !in_interrupt ()
+ * usb_unbind_driver - disconnects a driver from a device (usbcore-internal)
+ * @device: usb device to be disconnected
+ * @intf: interface of the device to be disconnected
+ * Context: BKL held
  *
- *	Goes through all unclaimed USB interfaces, and offers them to all
- *	registered USB drivers through the 'probe' function.
- *	This will automatically be called after usb_register is called.
- *	It is called by some of the subsystems layered over USB
- *	after one of their subdrivers are registered.
+ * Handles module usage count correctly
  */
-void usb_scan_devices(void)
-{
-	struct list_head *tmp;
-
-	down (&usb_bus_list_lock);
-	tmp = usb_bus_list.next;
-	while (tmp != &usb_bus_list) {
-		struct usb_bus *bus = list_entry(tmp,struct usb_bus, bus_list);
-
-		tmp = tmp->next;
-		usb_check_support(bus->root_hub);
-	}
-	up (&usb_bus_list_lock);
-}
-
-/**
- *	usb_unbind_driver - disconnects a driver from a device (usbcore-internal)
- *	@device: usb device to be disconnected
- *	@intf: interface of the device to be disconnected
- *	Context: BKL held
- *
- *	Handles module usage count correctly
- */
-
-void usb_unbind_driver(struct usb_device *device, struct usb_interface *intf)
+static void usb_unbind_driver(struct usb_device *device, struct usb_interface *intf)
 {
 	struct usb_driver *driver;
 	void *priv;
 	int m;
-	
 
 	driver = intf->driver;
 	priv = intf->private_data;
@@ -176,7 +233,7 @@
  *	drivers and neither calls the driver's probe() entry nor does any
  *	locking to guard against removing driver modules.
  */
-void *
+static void *
 usb_bind_driver (struct usb_driver *driver, struct usb_interface *interface)
 {
 	int i,m;
@@ -231,43 +288,7 @@
 
 	return private;
 }
-
-/*
- * This function is part of a depth-first search down the device tree,
- * removing any instances of a device driver.
- */
-static void usb_drivers_purge(struct usb_driver *driver,struct usb_device *dev)
-{
-	int i;
-
-	if (!dev) {
-		err("null device being purged!!!");
-		return;
-	}
-
-	for (i=0; i<USB_MAXCHILDREN; i++)
-		if (dev->children[i])
-			usb_drivers_purge(driver, dev->children[i]);
-
-	if (!dev->actconfig)
-		return;
-
-	for (i = 0; i < dev->actconfig->bNumInterfaces; i++) {
-		struct usb_interface *interface = &dev->actconfig->interface[i];
-
-		if (interface->driver == driver) {
-			usb_unbind_driver(dev, interface);
-			/* if driver->disconnect didn't release the interface */
-			if (interface->driver)
-				usb_driver_release_interface(driver, interface);
-			/*
-			 * This will go through the list looking for another
-			 * driver that can handle the device
-			 */
-			usb_find_interface_driver(dev, interface);
-		}
-	}
-}
+#endif
 
 /**
  * usb_deregister - unregister a USB driver
@@ -282,25 +303,9 @@
  */
 void usb_deregister(struct usb_driver *driver)
 {
-	struct list_head *tmp;
-
 	info("deregistering driver %s", driver->name);
 
-	/*
-	 * first we remove the driver, to be sure it doesn't get used by
-	 * another thread while we are stepping through removing entries
-	 */
-	list_del(&driver->driver_list);
-
-	down (&usb_bus_list_lock);
-	tmp = usb_bus_list.next;
-	while (tmp != &usb_bus_list) {
-		struct usb_bus *bus = list_entry(tmp,struct usb_bus,bus_list);
-
-		tmp = tmp->next;
-		usb_drivers_purge(driver, bus->root_hub);
-	}
-	up (&usb_bus_list_lock);
+	remove_driver (&driver->driver);
 
 	usbfs_update_special();
 }
@@ -333,6 +338,32 @@
 }
 
 /**
+ * usb_if_to_ifnum - get the interface number for a given interface
+ * @iface: the interface to determine the ifnum of
+ *
+ * This walks the device descriptor for the currently active configuration
+ * and returns the interface number of this specific interface, or -ENODEV.
+ *
+ * Note that configuration descriptors are not required to assign interface
+ * numbers sequentially, so that it would be incorrect to assume that
+ * the first interface in that descriptor corresponds to interface zero.
+ * This routine helps device drivers avoid such mistakes.
+ * However, you should make sure that you do the right thing with any
+ * alternate settings available for this interfaces.
+ */
+int usb_if_to_ifnum(struct usb_interface *iface)
+{
+	struct usb_device *dev = interface_to_usbdev(iface);
+	int i;
+
+	for (i = 0; i < dev->actconfig->bNumInterfaces; i++)
+		if (iface == &dev->actconfig->interface[i])
+			return dev->actconfig->interface[i].altsetting[0].bInterfaceNumber;
+
+	return -ENODEV;
+}
+
+/**
  * usb_epnum_to_ep_desc - get the endpoint object with a given endpoint number
  * @dev: the device whose current configuration is considered
  * @epnum: the desired endpoint
@@ -359,34 +390,6 @@
 	return NULL;
 }
 
-/*
- * This function is for doing a depth-first search for devices which
- * have support, for dynamic loading of driver modules.
- */
-static void usb_check_support(struct usb_device *dev)
-{
-	int i;
-
-	if (!dev) {
-		err("null device being checked!!!");
-		return;
-	}
-
-	for (i=0; i<USB_MAXCHILDREN; i++)
-		if (dev->children[i])
-			usb_check_support(dev->children[i]);
-
-	if (!dev->actconfig)
-		return;
-
-	/* now we check this device */
-	if (dev->devnum > 0)
-		for (i = 0; i < dev->actconfig->bNumInterfaces; i++)
-			usb_find_interface_driver (dev,
-				dev->actconfig->interface + i);
-}
-
-
 /**
  * usb_driver_claim_interface - bind a driver to an interface
  * @driver: the driver to be bound
@@ -595,72 +598,25 @@
 	return NULL;
 }
 
-/*
- * This entrypoint gets called for unclaimed interfaces.
- *
- * We now walk the list of registered USB drivers,
- * looking for one that will accept this interface.
- *
- * "New Style" drivers use a table describing the devices and interfaces
- * they handle.  Those tables are available to user mode tools deciding
- * whether to load driver modules for a new device.
- *
- * The probe return value is changed to be a private pointer.  This way
- * the drivers don't have to dig around in our structures to set the
- * private pointer if they only need one interface. 
- *
- * Returns: 0 if a driver accepted the interface, -1 otherwise
- */
-int usb_find_interface_driver (
-	struct usb_device *dev,
-	struct usb_interface *interface
-)
+static int usb_device_match (struct device *dev, struct device_driver *drv)
 {
-	struct list_head *tmp;
-	void *private;
-	struct usb_driver *driver;
-	int ifnum;
-	
-	down(&dev->serialize);
-
-	/* FIXME It's just luck that for some devices with drivers that set
-	 * configuration in probe(), the interface numbers still make sense.
-	 * That's one of several unsafe assumptions involved in configuring
-	 * devices, and in binding drivers to their interfaces.
-	 */
-	for (ifnum = 0; ifnum < dev->actconfig->bNumInterfaces; ifnum++)
-		if (&dev->actconfig->interface [ifnum] == interface)
-			break;
-	BUG_ON (ifnum == dev->actconfig->bNumInterfaces);
+	struct usb_interface *intf;
+	struct usb_driver *usb_drv;
+	const struct usb_device_id *id;
 
-	if (usb_interface_claimed(interface))
-		goto out_err;
+	intf = to_usb_interface(dev);
 
-	private = NULL;
-	lock_kernel();
-	for (tmp = usb_driver_list.next; tmp != &usb_driver_list;) {
-		driver = list_entry(tmp, struct usb_driver, driver_list);
-		tmp = tmp->next;
-
-		private = usb_bind_driver(driver, interface);
-
-		/* probe() may have changed the config on us */
-		interface = dev->actconfig->interface + ifnum;
-
-		if (private) {
-			usb_driver_claim_interface(driver, interface, private);
-			up(&dev->serialize);
-			unlock_kernel();
-			return 0;
-		}
-	}
-	unlock_kernel();
+	usb_drv = to_usb_driver(drv);
+	id = usb_drv->id_table;
+	
+	id = usb_match_id (intf, usb_drv->id_table);
+	if (id)
+		return 1;
 
-out_err:
-	up(&dev->serialize);
-	return -1;
+	return 0;
 }
 
+
 #ifdef	CONFIG_HOTPLUG
 
 /*
@@ -890,71 +846,6 @@
 }
 static DEVICE_ATTR(serial,S_IRUGO,show_serial,NULL);
 
-/*
- * This entrypoint gets called for each new device.
- *
- * All interfaces are scanned for matching drivers.
- */
-static void usb_find_drivers(struct usb_device *dev)
-{
-	unsigned ifnum;
-	unsigned rejected = 0;
-	unsigned claimed = 0;
-
-	/* FIXME should get called for each new configuration not just the
-	 * first one for a device. switching configs (or altsettings) should
-	 * undo driverfs and HCD state for the previous interfaces.
-	 */
-	for (ifnum = 0; ifnum < dev->actconfig->bNumInterfaces; ifnum++) {
-		struct usb_interface *interface = &dev->actconfig->interface[ifnum];
-		struct usb_interface_descriptor *desc = interface->altsetting;
-
-		/* register this interface with driverfs */
-		interface->dev.parent = &dev->dev;
-		interface->dev.bus = &usb_bus_type;
-		sprintf (&interface->dev.bus_id[0], "%s-%s:%d",
-			 dev->bus->bus_name, dev->devpath,
-			 interface->altsetting->bInterfaceNumber);
-		if (!desc->iInterface
-				|| usb_string (dev, desc->iInterface,
-					interface->dev.name,
-					sizeof interface->dev.name) <= 0) {
-			/* typically devices won't bother with interface
-			 * descriptions; this is the normal case.  an
-			 * interface's driver might describe it better.
-			 * (also: iInterface is per-altsetting ...)
-			 */
-			sprintf (&interface->dev.name[0],
-				"usb-%s-%s interface %d",
-				dev->bus->bus_name, dev->devpath,
-				interface->altsetting->bInterfaceNumber);
-		}
-		device_register (&interface->dev);
-		device_create_file (&interface->dev, &dev_attr_altsetting);
-
-		/* if this interface hasn't already been claimed */
-		if (!usb_interface_claimed(interface)) {
-			if (usb_find_interface_driver(dev, interface))
-				rejected++;
-			else
-				claimed++;
-		}
-	}
- 
-	if (rejected)
-		dbg("unhandled interfaces on device");
-
-	if (!claimed) {
-		warn("USB device %d (vend/prod 0x%x/0x%x) is not claimed by any active driver.",
-			dev->devnum,
-			dev->descriptor.idVendor,
-			dev->descriptor.idProduct);
-#ifdef DEBUG
-		usb_show_device(dev);
-#endif
-	}
-}
-
 /**
  * usb_alloc_dev - allocate a usb device structure (usbcore-internal)
  * @parent: hub to which device is connected
@@ -1159,22 +1050,17 @@
 
 	info("USB disconnect on device %d", dev->devnum);
 
-	lock_kernel();
 	if (dev->actconfig) {
 		for (i = 0; i < dev->actconfig->bNumInterfaces; i++) {
 			struct usb_interface *interface = &dev->actconfig->interface[i];
-			struct usb_driver *driver = interface->driver;
-			if (driver) {
-				usb_unbind_driver(dev, interface);
-				/* if driver->disconnect didn't release the interface */
-				if (interface->driver)
-					usb_driver_release_interface(driver, interface);
-			}
+//			struct usb_driver *driver = interface->driver;
+//			if (driver) {
+//				usb_unbind_driver(dev, interface);
+//			}
 			/* remove our device node for this interface */
 			put_device(&interface->dev);
 		}
 	}
-	unlock_kernel();
 
 	/* Free up all the children.. */
 	for (i = 0; i < USB_MAXCHILDREN; i++) {
@@ -1324,11 +1210,12 @@
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
@@ -1414,10 +1301,22 @@
 		usb_show_string(dev, "SerialNumber", dev->descriptor.iSerialNumber);
 #endif
 
-	/* register this device in the driverfs tree */
+	/*
+	 * Set the driver for the usb device to point to the "generic" driver.
+	 * This prevents the main usb device from being sent to the usb bus
+	 * probe function.  Yes, it's a hack, but a nice one :)
+	 */
+	usb_generic_driver.bus = &usb_bus_type;
+	dev->dev.parent = parent;
+	dev->dev.driver = &usb_generic_driver;
+	dev->dev.bus = &usb_bus_type;
+	sprintf (&dev->dev.bus_id[0], "%s-%s",
+		 dev->bus->bus_name, dev->devpath);
 	err = device_register (&dev->dev);
 	if (err)
 		return err;
+ 
+	/* add the USB device specific driverfs files */
 	device_create_file (&dev->dev, &dev_attr_configuration);
 	if (dev->descriptor.iManufacturer)
 		device_create_file (&dev->dev, &dev_attr_manufacturer);
@@ -1426,11 +1325,38 @@
 	if (dev->descriptor.iSerialNumber)
 		device_create_file (&dev->dev, &dev_attr_serial);
 
-	/* now that the basic setup is over, add a /proc/bus/usb entry */
-	usbfs_add_device(dev);
+	/* Register all of the interfaces for this device with the driver core.
+	 * Remember, interfaces get bound to drivers, not devices. */
+	for (ifnum = 0; ifnum < dev->actconfig->bNumInterfaces; ifnum++) {
+		struct usb_interface *interface = &dev->actconfig->interface[ifnum];
+		struct usb_interface_descriptor *desc = interface->altsetting;
+
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
+		dbg ("%s - registering %s", __FUNCTION__, interface->dev.bus_id);
+		device_register (&interface->dev);
+		device_create_file (&interface->dev, &dev_attr_altsetting);
+	}
 
-	/* find drivers willing to handle this device */
-	usb_find_drivers(dev);
+	/* add a /proc/bus/usb entry */
+	usbfs_add_device(dev);
 
 	/* userspace may load modules and/or configure further */
 	call_policy ("add", dev);
@@ -1438,7 +1364,6 @@
 	return 0;
 }
 
-
 /**
  * usb_buffer_alloc - allocate dma-consistent buffer for URB_NO_DMA_MAP
  * @dev: device the buffer will be used with
@@ -1585,20 +1510,9 @@
 				: USB_DIR_OUT);
 }
 
-#ifdef CONFIG_PROC_FS
-struct list_head *usb_driver_get_list(void)
-{
-	return &usb_driver_list;
-}
-
-struct list_head *usb_bus_get_list(void)
-{
-	return &usb_bus_list;
-}
-#endif
-
 struct bus_type usb_bus_type = {
-	.name =	"usb",
+	.name =		"usb",
+	.match =	usb_device_match,
 };
 
 /*
@@ -1637,7 +1551,11 @@
 
 EXPORT_SYMBOL(usb_register);
 EXPORT_SYMBOL(usb_deregister);
-EXPORT_SYMBOL(usb_scan_devices);
+
+EXPORT_SYMBOL(usb_device_probe);
+EXPORT_SYMBOL(usb_device_remove);
+
+EXPORT_SYMBOL(usb_if_to_ifnum);
 
 EXPORT_SYMBOL(usb_alloc_dev);
 EXPORT_SYMBOL(usb_free_dev);
diff -Naur -X /home/greg/linux/dontdiff linux-2.5.31-bk6/drivers/usb/input/hid-core.c linux-2.5.31-bk6-greg/drivers/usb/input/hid-core.c
--- linux-2.5.31-bk6/drivers/usb/input/hid-core.c	Sat Aug 10 18:41:40 2002
+++ linux-2.5.31-bk6-greg/drivers/usb/input/hid-core.c	Fri Aug 23 12:13:26 2002
@@ -1338,9 +1338,10 @@
 	{ 0, 0 }
 };
 
-static struct hid_device *usb_hid_configure(struct usb_device *dev, int ifnum)
+static struct hid_device *usb_hid_configure(struct usb_interface *intf)
 {
-	struct usb_interface_descriptor *interface = dev->actconfig->interface[ifnum].altsetting + 0;
+	struct usb_interface_descriptor *interface = intf->altsetting + intf->act_altsetting;
+	struct usb_device *dev = interface_to_usbdev (intf);
 	struct hid_descriptor *hdesc;
 	struct hid_device *hid;
 	unsigned quirks = 0, rsize = 0;
@@ -1450,7 +1451,7 @@
 		snprintf(hid->name, 128, "%04x:%04x", dev->descriptor.idVendor, dev->descriptor.idProduct);
 
 	usb_make_path(dev, buf, 64);
-	snprintf(hid->phys, 64, "%s/input%d", buf, ifnum);
+	snprintf(hid->phys, 64, "%s/input%d", buf, intf->altsetting[0].bInterfaceNumber);
 
 	if (usb_string(dev, dev->descriptor.iSerialNumber, hid->uniq, 64) <= 0)
 		hid->uniq[0] = 0;
@@ -1472,9 +1473,12 @@
 	return NULL;
 }
 
-static void hid_disconnect(struct usb_device *dev, void *ptr)
+static void hid_disconnect(struct usb_interface *intf)
 {
-	struct hid_device *hid = ptr;
+	struct hid_device *hid = intf->dev.driver_data;
+
+	if (!hid)
+		return;
 
 	usb_unlink_urb(hid->urbin);
 	usb_unlink_urb(hid->urbout);
@@ -1491,20 +1495,20 @@
 		usb_free_urb(hid->urbout);
 
 	hid_free_device(hid);
+	intf->dev.driver_data = NULL;
 }
 
-static void* hid_probe(struct usb_device *dev, unsigned int ifnum,
-		       const struct usb_device_id *id)
+static int hid_probe (struct usb_interface *intf, const struct usb_device_id *id)
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
@@ -1516,9 +1520,11 @@
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
@@ -1540,12 +1546,12 @@
 		}
 	}
 
-	usb_make_path(dev, path, 63);
+	usb_make_path(interface_to_usbdev(intf), path, 63);
 
 	printk(": USB HID v%x.%02x %s [%s] on %s\n",
 		hid->version >> 8, hid->version & 0xff, c, hid->name, path);
 
-	return hid;
+	return 0;
 }
 
 static struct usb_device_id hid_usb_ids [] = {
@@ -1558,8 +1564,8 @@
 
 static struct usb_driver hid_driver = {
 	.name =		"hid",
-	.probe =	hid_probe,
-	.disconnect =	hid_disconnect,
+	.new_probe =	hid_probe,
+	.new_disco =	hid_disconnect,
 	.id_table =	hid_usb_ids,
 };
 
diff -Naur -X /home/greg/linux/dontdiff linux-2.5.31-bk6/drivers/usb/input/usbmouse.c linux-2.5.31-bk6-greg/drivers/usb/input/usbmouse.c
--- linux-2.5.31-bk6/drivers/usb/input/usbmouse.c	Sat Aug 10 18:41:55 2002
+++ linux-2.5.31-bk6-greg/drivers/usb/input/usbmouse.c	Fri Aug 23 12:13:26 2002
@@ -98,10 +98,9 @@
 		usb_unlink_urb(mouse->irq);
 }
 
-static void *usb_mouse_probe(struct usb_device *dev, unsigned int ifnum,
-			     const struct usb_device_id *id)
+static int usb_mouse_new_probe(struct usb_interface * intf, const struct usb_device_id * id)
 {
-	struct usb_interface *iface;
+	struct usb_device * dev = interface_to_usbdev(intf);
 	struct usb_interface_descriptor *interface;
 	struct usb_endpoint_descriptor *endpoint;
 	struct usb_mouse *mouse;
@@ -109,25 +108,28 @@
 	char path[64];
 	char *buf;
 
-	iface = &dev->actconfig->interface[ifnum];
-	interface = &iface->altsetting[iface->act_altsetting];
+	interface = &intf->altsetting[intf->act_altsetting];
 
-	if (interface->bNumEndpoints != 1) return NULL;
+	if (interface->bNumEndpoints != 1) 
+		return -ENODEV;
 
 	endpoint = interface->endpoint + 0;
-	if (!(endpoint->bEndpointAddress & 0x80)) return NULL;
-	if ((endpoint->bmAttributes & 3) != 3) return NULL;
+	if (!(endpoint->bEndpointAddress & 0x80)) 
+		return -ENODEV;
+	if ((endpoint->bmAttributes & 3) != 3) 
+		return -ENODEV;
 
 	pipe = usb_rcvintpipe(dev, endpoint->bEndpointAddress);
 	maxp = usb_maxpacket(dev, pipe, usb_pipeout(pipe));
 
-	if (!(mouse = kmalloc(sizeof(struct usb_mouse), GFP_KERNEL))) return NULL;
+	if (!(mouse = kmalloc(sizeof(struct usb_mouse), GFP_KERNEL))) 
+		return -ENOMEM;
 	memset(mouse, 0, sizeof(struct usb_mouse));
 
 	mouse->irq = usb_alloc_urb(0, GFP_KERNEL);
 	if (!mouse->irq) {
 		kfree(mouse);
-		return NULL;
+		return -ENODEV;
 	}
 
 	mouse->usbdev = dev;
@@ -154,7 +156,7 @@
 
 	if (!(buf = kmalloc(63, GFP_KERNEL))) {
 		kfree(mouse);
-		return NULL;
+		return -ENOMEM;
 	}
 
 	if (dev->descriptor.iManufacturer &&
@@ -174,19 +176,23 @@
 		usb_mouse_irq, mouse, endpoint->bInterval);
 
 	input_register_device(&mouse->dev);
-
 	printk(KERN_INFO "input: %s on %s\n", mouse->name, path);
 
-	return mouse;
+	intf->dev.driver_data = mouse;
+	return 0;
 }
 
-static void usb_mouse_disconnect(struct usb_device *dev, void *ptr)
+static void usb_mouse_new_disco(struct usb_interface * intf)
 {
-	struct usb_mouse *mouse = ptr;
-	usb_unlink_urb(mouse->irq);
-	input_unregister_device(&mouse->dev);
-	usb_free_urb(mouse->irq);
-	kfree(mouse);
+	struct usb_mouse *mouse = intf->dev.driver_data;
+	intf->dev.driver_data = NULL;
+
+	if (mouse) {
+		usb_unlink_urb(mouse->irq);
+		input_unregister_device(&mouse->dev);
+		usb_free_urb(mouse->irq);
+		kfree(mouse);
+	}
 }
 
 static struct usb_device_id usb_mouse_id_table [] = {
@@ -197,10 +203,10 @@
 MODULE_DEVICE_TABLE (usb, usb_mouse_id_table);
 
 static struct usb_driver usb_mouse_driver = {
-	.name =		"usb_mouse",
-	.probe =	usb_mouse_probe,
-	.disconnect =	usb_mouse_disconnect,
-	.id_table =	usb_mouse_id_table,
+	.name		= "usb_mouse",
+	.new_probe	= usb_mouse_new_probe,
+	.new_disco	= usb_mouse_new_disco,
+	.id_table	= usb_mouse_id_table,
 };
 
 static int __init usb_mouse_init(void)
diff -Naur -X /home/greg/linux/dontdiff linux-2.5.31-bk6/drivers/usb/serial/belkin_sa.c linux-2.5.31-bk6-greg/drivers/usb/serial/belkin_sa.c
--- linux-2.5.31-bk6/drivers/usb/serial/belkin_sa.c	Sat Aug 10 18:41:40 2002
+++ linux-2.5.31-bk6-greg/drivers/usb/serial/belkin_sa.c	Fri Aug 23 12:13:26 2002
@@ -114,6 +114,13 @@
 
 MODULE_DEVICE_TABLE (usb, id_table_combined);
 
+static struct usb_driver belkin_driver = {
+	.name =		"belkin",
+	.new_probe =	usb_serial_probe,
+	.new_disco =	usb_serial_disconnect,
+	.id_table =	id_table_combined,
+};
+
 /* All of the device info needed for the serial converters */
 static struct usb_serial_device_type belkin_device = {
 	.owner =		THIS_MODULE,
@@ -526,6 +533,7 @@
 static int __init belkin_sa_init (void)
 {
 	usb_serial_register (&belkin_device);
+	usb_register (&belkin_driver);
 	info(DRIVER_DESC " " DRIVER_VERSION);
 	return 0;
 }
@@ -533,6 +541,7 @@
 
 static void __exit belkin_sa_exit (void)
 {
+	usb_deregister (&belkin_driver);
 	usb_serial_deregister (&belkin_device);
 }
 
diff -Naur -X /home/greg/linux/dontdiff linux-2.5.31-bk6/drivers/usb/serial/cyberjack.c linux-2.5.31-bk6-greg/drivers/usb/serial/cyberjack.c
--- linux-2.5.31-bk6/drivers/usb/serial/cyberjack.c	Sat Aug 10 18:41:53 2002
+++ linux-2.5.31-bk6-greg/drivers/usb/serial/cyberjack.c	Fri Aug 23 12:13:26 2002
@@ -73,6 +73,13 @@
 
 MODULE_DEVICE_TABLE (usb, id_table);
 
+static struct usb_driver cyberjack_driver = {
+	.name =		"cyberjack",
+	.new_probe =	usb_serial_probe,
+	.new_disco =	usb_serial_disconnect,
+	.id_table =	id_table,
+};
+
 static struct usb_serial_device_type cyberjack_device = {
 	.owner =		THIS_MODULE,
 	.name =			"Reiner SCT Cyberjack USB card reader",
@@ -461,6 +468,7 @@
 static int __init cyberjack_init (void)
 {
 	usb_serial_register (&cyberjack_device);
+	usb_register (&cyberjack_driver);
 
 	info(DRIVER_VERSION " " DRIVER_AUTHOR);
 	info(DRIVER_DESC);
@@ -470,6 +478,7 @@
 
 static void __exit cyberjack_exit (void)
 {
+	usb_deregister (&cyberjack_driver);
 	usb_serial_deregister (&cyberjack_device);
 }
 
diff -Naur -X /home/greg/linux/dontdiff linux-2.5.31-bk6/drivers/usb/serial/digi_acceleport.c linux-2.5.31-bk6-greg/drivers/usb/serial/digi_acceleport.c
--- linux-2.5.31-bk6/drivers/usb/serial/digi_acceleport.c	Sat Aug 10 18:41:28 2002
+++ linux-2.5.31-bk6-greg/drivers/usb/serial/digi_acceleport.c	Fri Aug 23 12:13:26 2002
@@ -477,7 +477,7 @@
 
 /* Statics */
 
-static __devinitdata struct usb_device_id id_table_combined [] = {
+static struct usb_device_id id_table_combined [] = {
 	{ USB_DEVICE(DIGI_VENDOR_ID, DIGI_2_ID) },
 	{ USB_DEVICE(DIGI_VENDOR_ID, DIGI_4_ID) },
 	{ }						/* Terminating entry */
@@ -495,6 +495,14 @@
 
 MODULE_DEVICE_TABLE (usb, id_table_combined);
 
+static struct usb_driver digi_driver = {
+	.name =		"digi_acceleport",
+	.new_probe =	usb_serial_probe,
+	.new_disco =	usb_serial_disconnect,
+	.id_table =	id_table_combined,
+};
+
+
 /* device info needed for the Digi serial converter */
 
 static struct usb_serial_device_type digi_acceleport_2_device = {
@@ -2026,6 +2034,7 @@
 {
 	usb_serial_register (&digi_acceleport_2_device);
 	usb_serial_register (&digi_acceleport_4_device);
+	usb_register (&digi_driver);
 	info(DRIVER_VERSION ":" DRIVER_DESC);
 	return 0;
 }
@@ -2033,6 +2042,7 @@
 
 static void __exit digi_exit (void)
 {
+	usb_deregister (&digi_driver);
 	usb_serial_deregister (&digi_acceleport_2_device);
 	usb_serial_deregister (&digi_acceleport_4_device);
 }
diff -Naur -X /home/greg/linux/dontdiff linux-2.5.31-bk6/drivers/usb/serial/empeg.c linux-2.5.31-bk6-greg/drivers/usb/serial/empeg.c
--- linux-2.5.31-bk6/drivers/usb/serial/empeg.c	Sat Aug 10 18:41:28 2002
+++ linux-2.5.31-bk6-greg/drivers/usb/serial/empeg.c	Fri Aug 23 12:13:26 2002
@@ -110,6 +110,13 @@
 
 MODULE_DEVICE_TABLE (usb, id_table);
 
+static struct usb_driver empeg_driver = {
+	.name =		"empeg",
+	.new_probe =	usb_serial_probe,
+	.new_disco =	usb_serial_disconnect,
+	.id_table =	id_table,
+};
+
 static struct usb_serial_device_type empeg_device = {
 	.owner =		THIS_MODULE,
 	.name =			"Empeg",
@@ -550,8 +557,6 @@
 	struct urb *urb;
 	int i;
 
-	usb_serial_register (&empeg_device);
-
 	/* create our write urb pool and transfer buffers */ 
 	spin_lock_init (&write_urb_pool_lock);
 	for (i = 0; i < NUM_URBS; ++i) {
@@ -570,10 +575,12 @@
 		}
 	}
 
+	usb_serial_register (&empeg_device);
+	usb_register (&empeg_driver);
+
 	info(DRIVER_VERSION ":" DRIVER_DESC);
 
 	return 0;
-
 }
 
 
@@ -582,6 +589,7 @@
 	int i;
 	unsigned long flags;
 
+	usb_register (&empeg_driver);
 	usb_serial_deregister (&empeg_device);
 
 	spin_lock_irqsave (&write_urb_pool_lock, flags);
@@ -599,7 +607,6 @@
 	}
 
 	spin_unlock_irqrestore (&write_urb_pool_lock, flags);
-
 }
 
 
diff -Naur -X /home/greg/linux/dontdiff linux-2.5.31-bk6/drivers/usb/serial/ftdi_sio.c linux-2.5.31-bk6-greg/drivers/usb/serial/ftdi_sio.c
--- linux-2.5.31-bk6/drivers/usb/serial/ftdi_sio.c	Sat Aug 10 18:41:23 2002
+++ linux-2.5.31-bk6-greg/drivers/usb/serial/ftdi_sio.c	Fri Aug 23 12:13:26 2002
@@ -140,7 +140,7 @@
 };
 
 
-static __devinitdata struct usb_device_id id_table_combined [] = {
+static struct usb_device_id id_table_combined [] = {
 	{ USB_DEVICE(FTDI_VID, FTDI_SIO_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_8U232AM_PID) },
 	{ USB_DEVICE(FTDI_NF_RIC_VID, FTDI_NF_RIC_PID) },
@@ -149,6 +149,13 @@
 
 MODULE_DEVICE_TABLE (usb, id_table_combined);
 
+static struct usb_driver ftdi_driver = {
+	.name =		"ftdi_sio",
+	.new_probe =	usb_serial_probe,
+	.new_disco =	usb_serial_disconnect,
+	.id_table =	id_table_combined,
+};
+
 
 struct ftdi_private {
 	enum ftdi_type ftdi_type;
@@ -944,6 +951,7 @@
 	dbg(__FUNCTION__);
 	usb_serial_register (&ftdi_sio_device);
 	usb_serial_register (&ftdi_8U232AM_device);
+	usb_register (&ftdi_driver);
 	info(DRIVER_VERSION ":" DRIVER_DESC);
 	return 0;
 }
@@ -952,6 +960,7 @@
 static void __exit ftdi_sio_exit (void)
 {
 	dbg(__FUNCTION__);
+	usb_deregister (&ftdi_driver);
 	usb_serial_deregister (&ftdi_sio_device);
 	usb_serial_deregister (&ftdi_8U232AM_device);
 }
diff -Naur -X /home/greg/linux/dontdiff linux-2.5.31-bk6/drivers/usb/serial/io_edgeport.c linux-2.5.31-bk6-greg/drivers/usb/serial/io_edgeport.c
--- linux-2.5.31-bk6/drivers/usb/serial/io_edgeport.c	Sat Aug 10 18:41:19 2002
+++ linux-2.5.31-bk6-greg/drivers/usb/serial/io_edgeport.c	Fri Aug 23 12:13:26 2002
@@ -457,6 +457,12 @@
 
 #include "io_tables.h"	/* all of the devices that this driver supports */
 
+static struct usb_driver io_driver = {
+	.name =		"io_edgeport",
+	.new_probe =	usb_serial_probe,
+	.new_disco =	usb_serial_disconnect,
+	.id_table =	id_table_combined,
+};
 
 /* function prototypes for all of our local functions */
 static int  process_rcvd_data		(struct edgeport_serial *edge_serial, unsigned char *buffer, __u16 bufferLength);
@@ -3049,6 +3055,7 @@
 	usb_serial_register (&edgeport_2port_device);
 	usb_serial_register (&edgeport_4port_device);
 	usb_serial_register (&edgeport_8port_device);
+	usb_register (&io_driver);
 	info(DRIVER_DESC " " DRIVER_VERSION);
 	return 0;
 }
@@ -3061,6 +3068,7 @@
  ****************************************************************************/
 void __exit edgeport_exit (void)
 {
+	usb_deregister (&io_driver);
 	usb_serial_deregister (&edgeport_1port_device);
 	usb_serial_deregister (&edgeport_2port_device);
 	usb_serial_deregister (&edgeport_4port_device);
diff -Naur -X /home/greg/linux/dontdiff linux-2.5.31-bk6/drivers/usb/serial/io_tables.h linux-2.5.31-bk6-greg/drivers/usb/serial/io_tables.h
--- linux-2.5.31-bk6/drivers/usb/serial/io_tables.h	Sat Aug 10 18:41:19 2002
+++ linux-2.5.31-bk6-greg/drivers/usb/serial/io_tables.h	Fri Aug 23 12:13:26 2002
@@ -61,7 +61,7 @@
 };
 
 /* Devices that this driver supports */
-static __devinitdata struct usb_device_id id_table_combined [] = {
+static struct usb_device_id id_table_combined [] = {
 	{ USB_DEVICE(USB_VENDOR_ID_ION,	ION_DEVICE_ID_EDGEPORT_4) },
 	{ USB_DEVICE(USB_VENDOR_ID_ION,	ION_DEVICE_ID_RAPIDPORT_4) },
 	{ USB_DEVICE(USB_VENDOR_ID_ION,	ION_DEVICE_ID_EDGEPORT_4T) },
diff -Naur -X /home/greg/linux/dontdiff linux-2.5.31-bk6/drivers/usb/serial/io_ti.c linux-2.5.31-bk6-greg/drivers/usb/serial/io_ti.c
--- linux-2.5.31-bk6/drivers/usb/serial/io_ti.c	Sat Aug 10 18:41:27 2002
+++ linux-2.5.31-bk6-greg/drivers/usb/serial/io_ti.c	Fri Aug 23 12:13:26 2002
@@ -142,7 +142,7 @@
 };
 
 /* Devices that this driver supports */
-static __devinitdata struct usb_device_id id_table_combined [] = {
+static struct usb_device_id id_table_combined [] = {
 	{ USB_DEVICE(USB_VENDOR_ID_ION, ION_DEVICE_ID_TI_EDGEPORT_1) },
 	{ USB_DEVICE(USB_VENDOR_ID_ION, ION_DEVICE_ID_TI_EDGEPORT_2) },
 	{ USB_DEVICE(USB_VENDOR_ID_ION, ION_DEVICE_ID_TI_EDGEPORT_2I) },
@@ -161,6 +161,13 @@
 
 MODULE_DEVICE_TABLE (usb, id_table_combined);
 
+static struct usb_driver io_driver = {
+	.name =		"io_ti",
+	.new_probe =	usb_serial_probe,
+	.new_disco =	usb_serial_disconnect,
+	.id_table =	id_table_combined,
+};
+
 
 static struct EDGE_FIRMWARE_VERSION_INFO OperationalCodeImageVersion;
 
@@ -2658,12 +2665,14 @@
 {
 	usb_serial_register (&edgeport_1port_device);
 	usb_serial_register (&edgeport_2port_device);
+	usb_register (&io_driver);
 	info(DRIVER_DESC " " DRIVER_VERSION);
 	return 0;
 }
 
 static void __exit edgeport_exit (void)
 {
+	usb_deregister (&io_driver);
 	usb_serial_deregister (&edgeport_1port_device);
 	usb_serial_deregister (&edgeport_2port_device);
 }
diff -Naur -X /home/greg/linux/dontdiff linux-2.5.31-bk6/drivers/usb/serial/ipaq.c linux-2.5.31-bk6-greg/drivers/usb/serial/ipaq.c
--- linux-2.5.31-bk6/drivers/usb/serial/ipaq.c	Sat Aug 10 18:41:24 2002
+++ linux-2.5.31-bk6-greg/drivers/usb/serial/ipaq.c	Fri Aug 23 12:13:26 2002
@@ -94,6 +94,14 @@
 
 MODULE_DEVICE_TABLE (usb, ipaq_id_table);
 
+static struct usb_driver ipaq_driver = {
+	.name =		"ipaq",
+	.new_probe =	usb_serial_probe,
+	.new_disco =	usb_serial_disconnect,
+	.id_table =	ipaq_id_table,
+};
+
+
 /* All of the device info needed for the Compaq iPAQ */
 struct usb_serial_device_type ipaq_device = {
 	.owner =		THIS_MODULE,
@@ -516,6 +524,7 @@
 static int __init ipaq_init(void)
 {
 	usb_serial_register(&ipaq_device);
+	usb_register(&ipaq_driver);
 	info(DRIVER_DESC " " DRIVER_VERSION);
 
 	return 0;
@@ -524,6 +533,7 @@
 
 static void __exit ipaq_exit(void)
 {
+	usb_deregister(&ipaq_driver);
 	usb_serial_deregister(&ipaq_device);
 }
 
diff -Naur -X /home/greg/linux/dontdiff linux-2.5.31-bk6/drivers/usb/serial/ir-usb.c linux-2.5.31-bk6-greg/drivers/usb/serial/ir-usb.c
--- linux-2.5.31-bk6/drivers/usb/serial/ir-usb.c	Sat Aug 10 18:41:28 2002
+++ linux-2.5.31-bk6-greg/drivers/usb/serial/ir-usb.c	Fri Aug 23 12:13:26 2002
@@ -129,6 +129,13 @@
 
 MODULE_DEVICE_TABLE (usb, id_table);
 
+static struct usb_driver ir_driver = {
+	.name =		"ir-usb",
+	.new_probe =	usb_serial_probe,
+	.new_disco =	usb_serial_disconnect,
+	.id_table =	id_table,
+};
+
 
 struct usb_serial_device_type ir_device = {
 	.owner =		THIS_MODULE,
@@ -606,6 +613,7 @@
 static int __init ir_init (void)
 {
 	usb_serial_register (&ir_device);
+	usb_register (&ir_driver);
 	info(DRIVER_DESC " " DRIVER_VERSION);
 	return 0;
 }
@@ -613,6 +621,7 @@
 
 static void __exit ir_exit (void)
 {
+	usb_deregister (&ir_driver);
 	usb_serial_deregister (&ir_device);
 }
 
diff -Naur -X /home/greg/linux/dontdiff linux-2.5.31-bk6/drivers/usb/serial/keyspan.c linux-2.5.31-bk6-greg/drivers/usb/serial/keyspan.c
--- linux-2.5.31-bk6/drivers/usb/serial/keyspan.c	Sat Aug 10 18:41:20 2002
+++ linux-2.5.31-bk6-greg/drivers/usb/serial/keyspan.c	Fri Aug 23 12:13:26 2002
@@ -183,6 +183,7 @@
 	usb_serial_register (&keyspan_1port_device);
 	usb_serial_register (&keyspan_2port_device);
 	usb_serial_register (&keyspan_4port_device);
+	usb_register (&keyspan_driver);
 
 	info(DRIVER_VERSION ":" DRIVER_DESC);
 
@@ -191,6 +192,7 @@
 
 static void __exit keyspan_exit (void)
 {
+	usb_deregister (&keyspan_driver);
 	usb_serial_deregister (&keyspan_pre_device);
 	usb_serial_deregister (&keyspan_1port_device);
 	usb_serial_deregister (&keyspan_2port_device);
diff -Naur -X /home/greg/linux/dontdiff linux-2.5.31-bk6/drivers/usb/serial/keyspan.h linux-2.5.31-bk6-greg/drivers/usb/serial/keyspan.h
--- linux-2.5.31-bk6/drivers/usb/serial/keyspan.h	Sat Aug 10 18:41:42 2002
+++ linux-2.5.31-bk6-greg/drivers/usb/serial/keyspan.h	Fri Aug 23 12:13:26 2002
@@ -408,7 +408,7 @@
 	NULL,
 };
 
-static __devinitdata struct usb_device_id keyspan_ids_combined[] = {
+static struct usb_device_id keyspan_ids_combined[] = {
 	{ USB_DEVICE(KEYSPAN_VENDOR_ID, keyspan_usa18x_pre_product_id) },
 	{ USB_DEVICE(KEYSPAN_VENDOR_ID, keyspan_usa19_pre_product_id) },
 	{ USB_DEVICE(KEYSPAN_VENDOR_ID, keyspan_usa19w_pre_product_id) },
@@ -434,6 +434,13 @@
 
 MODULE_DEVICE_TABLE(usb, keyspan_ids_combined);
 
+static struct usb_driver keyspan_driver = {
+	.name =		"keyspan",                
+	.new_probe =	usb_serial_probe,
+	.new_disco =	usb_serial_disconnect,
+	.id_table =	keyspan_ids_combined,
+};
+
 /* usb_device_id table for the pre-firmware download keyspan devices */
 static struct usb_device_id keyspan_pre_ids[] = {
 	{ USB_DEVICE(KEYSPAN_VENDOR_ID, keyspan_usa18x_pre_product_id) },
diff -Naur -X /home/greg/linux/dontdiff linux-2.5.31-bk6/drivers/usb/serial/keyspan_pda.c linux-2.5.31-bk6-greg/drivers/usb/serial/keyspan_pda.c
--- linux-2.5.31-bk6/drivers/usb/serial/keyspan_pda.c	Sat Aug 10 18:41:42 2002
+++ linux-2.5.31-bk6-greg/drivers/usb/serial/keyspan_pda.c	Fri Aug 23 12:13:26 2002
@@ -140,7 +140,7 @@
 #define ENTREGRA_VENDOR_ID		0x1645
 #define ENTREGRA_FAKE_ID		0x8093
 
-static __devinitdata struct usb_device_id id_table_combined [] = {
+static struct usb_device_id id_table_combined [] = {
 #ifdef KEYSPAN
 	{ USB_DEVICE(KEYSPAN_VENDOR_ID, KEYSPAN_PDA_FAKE_ID) },
 #endif
@@ -154,6 +154,13 @@
 
 MODULE_DEVICE_TABLE (usb, id_table_combined);
 
+static struct usb_driver keyspan_pda_driver = {
+	.name =		"keyspan_pda",
+	.new_probe =	usb_serial_probe,
+	.new_disco =	usb_serial_disconnect,
+	.id_table =	id_table_combined,
+};
+
 static struct usb_device_id id_table_std [] = {
 	{ USB_DEVICE(KEYSPAN_VENDOR_ID, KEYSPAN_PDA_ID) },
 	{ }						/* Terminating entry */
@@ -862,6 +869,7 @@
 #ifdef XIRCOM
 	usb_serial_register (&xircom_pgs_fake_device);
 #endif
+	usb_register (&keyspan_pda_driver);
 	info(DRIVER_DESC " " DRIVER_VERSION);
 	return 0;
 }
@@ -869,6 +877,7 @@
 
 static void __exit keyspan_pda_exit (void)
 {
+	usb_deregister (&keyspan_pda_driver);
 	usb_serial_deregister (&keyspan_pda_device);
 #ifdef KEYSPAN
 	usb_serial_deregister (&keyspan_pda_fake_device);
diff -Naur -X /home/greg/linux/dontdiff linux-2.5.31-bk6/drivers/usb/serial/kl5kusb105.c linux-2.5.31-bk6-greg/drivers/usb/serial/kl5kusb105.c
--- linux-2.5.31-bk6/drivers/usb/serial/kl5kusb105.c	Sat Aug 10 18:41:36 2002
+++ linux-2.5.31-bk6-greg/drivers/usb/serial/kl5kusb105.c	Fri Aug 23 12:13:26 2002
@@ -117,6 +117,12 @@
 
 MODULE_DEVICE_TABLE (usb, id_table);
 
+static struct usb_driver kl5kusb105d_driver = {
+	.name =		"kl5kusb105d",
+	.new_probe =	usb_serial_probe,
+	.new_disco =	usb_serial_disconnect,
+	.id_table =	id_table,
+};
 
 static struct usb_serial_device_type kl5kusb105d_device = {
 	.owner =             THIS_MODULE,
@@ -1013,6 +1019,7 @@
 static int __init klsi_105_init (void)
 {
 	usb_serial_register (&kl5kusb105d_device);
+	usb_register (&kl5kusb105d_driver);
 
 	info(DRIVER_DESC " " DRIVER_VERSION);
 	return 0;
@@ -1021,6 +1028,7 @@
 
 static void __exit klsi_105_exit (void)
 {
+	usb_deregister (&kl5kusb105d_driver);
 	usb_serial_deregister (&kl5kusb105d_device);
 }
 
diff -Naur -X /home/greg/linux/dontdiff linux-2.5.31-bk6/drivers/usb/serial/mct_u232.c linux-2.5.31-bk6-greg/drivers/usb/serial/mct_u232.c
--- linux-2.5.31-bk6/drivers/usb/serial/mct_u232.c	Sat Aug 10 18:41:42 2002
+++ linux-2.5.31-bk6-greg/drivers/usb/serial/mct_u232.c	Fri Aug 23 12:13:26 2002
@@ -139,6 +139,12 @@
 
 MODULE_DEVICE_TABLE (usb, id_table_combined);
 
+static struct usb_driver mct_u232_driver = {
+	.name =		"mct_u232",
+	.new_probe =	usb_serial_probe,
+	.new_disco =	usb_serial_disconnect,
+	.id_table =	id_table_combined,
+};
 
 static struct usb_serial_device_type mct_u232_device = {
 	.owner =	     THIS_MODULE,
@@ -783,6 +789,7 @@
 static int __init mct_u232_init (void)
 {
 	usb_serial_register (&mct_u232_device);
+	usb_register (&mct_u232_driver);
 	info(DRIVER_DESC " " DRIVER_VERSION);
 	return 0;
 }
@@ -790,6 +797,7 @@
 
 static void __exit mct_u232_exit (void)
 {
+	usb_deregister (&mct_u232_driver);
 	usb_serial_deregister (&mct_u232_device);
 }
 
diff -Naur -X /home/greg/linux/dontdiff linux-2.5.31-bk6/drivers/usb/serial/omninet.c linux-2.5.31-bk6-greg/drivers/usb/serial/omninet.c
--- linux-2.5.31-bk6/drivers/usb/serial/omninet.c	Sat Aug 10 18:41:25 2002
+++ linux-2.5.31-bk6-greg/drivers/usb/serial/omninet.c	Fri Aug 23 12:13:26 2002
@@ -83,6 +83,13 @@
 
 MODULE_DEVICE_TABLE (usb, id_table);
 
+static struct usb_driver omninet_driver = {
+	.name =		"omninet",
+	.new_probe =	usb_serial_probe,
+	.new_disco =	usb_serial_disconnect,
+	.id_table =	id_table,
+};
+
 
 static struct usb_serial_device_type zyxel_omninet_device = {
 	.owner =		THIS_MODULE,
@@ -370,6 +377,7 @@
 static int __init omninet_init (void)
 {
 	usb_serial_register (&zyxel_omninet_device);
+	usb_register (&omninet_driver);
 	info(DRIVER_VERSION ":" DRIVER_DESC);
 	return 0;
 }
@@ -377,6 +385,7 @@
 
 static void __exit omninet_exit (void)
 {
+	usb_deregister (&omninet_driver);
 	usb_serial_deregister (&zyxel_omninet_device);
 }
 
diff -Naur -X /home/greg/linux/dontdiff linux-2.5.31-bk6/drivers/usb/serial/pl2303.c linux-2.5.31-bk6-greg/drivers/usb/serial/pl2303.c
--- linux-2.5.31-bk6/drivers/usb/serial/pl2303.c	Sat Aug 10 18:41:28 2002
+++ linux-2.5.31-bk6-greg/drivers/usb/serial/pl2303.c	Fri Aug 23 12:13:26 2002
@@ -77,6 +77,12 @@
 
 MODULE_DEVICE_TABLE (usb, id_table);
 
+static struct usb_driver pl2303_driver = {
+	.name =		"pl2303",
+	.new_probe =	usb_serial_probe,
+	.new_disco =	usb_serial_disconnect,
+	.id_table =	id_table,
+};
 
 #define SET_LINE_REQUEST_TYPE		0x21
 #define SET_LINE_REQUEST		0x20
@@ -708,6 +714,7 @@
 static int __init pl2303_init (void)
 {
 	usb_serial_register (&pl2303_device);
+	usb_register (&pl2303_driver);
 	info(DRIVER_DESC " " DRIVER_VERSION);
 	return 0;
 }
@@ -715,6 +722,7 @@
 
 static void __exit pl2303_exit (void)
 {
+	usb_deregister (&pl2303_driver);
 	usb_serial_deregister (&pl2303_device);
 }
 
diff -Naur -X /home/greg/linux/dontdiff linux-2.5.31-bk6/drivers/usb/serial/safe_serial.c linux-2.5.31-bk6-greg/drivers/usb/serial/safe_serial.c
--- linux-2.5.31-bk6/drivers/usb/serial/safe_serial.c	Sat Aug 10 18:41:23 2002
+++ linux-2.5.31-bk6-greg/drivers/usb/serial/safe_serial.c	Fri Aug 23 12:13:26 2002
@@ -161,6 +161,13 @@
 
 MODULE_DEVICE_TABLE (usb, id_table);
 
+static struct usb_driver safe_driver = {
+	.name =		"safe_serial",
+	.new_probe =	usb_serial_probe,
+	.new_disco =	usb_serial_disconnect,
+	.id_table =	id_table,
+};
+
 static __u16 crc10_table[256] = {
 	0x000, 0x233, 0x255, 0x066, 0x299, 0x0aa, 0x0cc, 0x2ff, 0x301, 0x132, 0x154, 0x367, 0x198, 0x3ab, 0x3cd, 0x1fe,
 	0x031, 0x202, 0x264, 0x057, 0x2a8, 0x09b, 0x0fd, 0x2ce, 0x330, 0x103, 0x165, 0x356, 0x1a9, 0x39a, 0x3fc, 0x1cf,
@@ -434,12 +441,14 @@
 	}
 
 	usb_serial_register (&safe_device);
+	usb_register (&safe_driver);
 
 	return 0;
 }
 
 static void __exit safe_exit (void)
 {
+	usb_deregister (&safe_driver);
 	usb_serial_deregister (&safe_device);
 }
 
diff -Naur -X /home/greg/linux/dontdiff linux-2.5.31-bk6/drivers/usb/serial/usb-serial.h linux-2.5.31-bk6-greg/drivers/usb/serial/usb-serial.h
--- linux-2.5.31-bk6/drivers/usb/serial/usb-serial.h	Sat Aug 10 18:41:30 2002
+++ linux-2.5.31-bk6-greg/drivers/usb/serial/usb-serial.h	Fri Aug 23 12:13:26 2002
@@ -233,6 +233,9 @@
 extern int  usb_serial_register(struct usb_serial_device_type *new_device);
 extern void usb_serial_deregister(struct usb_serial_device_type *device);
 
+extern int usb_serial_probe(struct usb_interface *iface, const struct usb_device_id *id);
+extern void usb_serial_disconnect(struct usb_interface *iface);
+
 /* determine if we should include the EzUSB loader functions */
 #undef USES_EZUSB_FUNCTIONS
 #if defined(CONFIG_USB_SERIAL_KEYSPAN_PDA) || defined(CONFIG_USB_SERIAL_KEYSPAN_PDA_MODULE)
diff -Naur -X /home/greg/linux/dontdiff linux-2.5.31-bk6/drivers/usb/serial/usbserial.c linux-2.5.31-bk6-greg/drivers/usb/serial/usbserial.c
--- linux-2.5.31-bk6/drivers/usb/serial/usbserial.c	Fri Aug 23 11:53:49 2002
+++ linux-2.5.31-bk6-greg/drivers/usb/serial/usbserial.c	Fri Aug 23 12:13:26 2002
@@ -380,30 +380,23 @@
 	.num_ports =		1,
 	.shutdown =		generic_shutdown,
 };
-#endif
-
 
-/* local function prototypes */
-static int  serial_open (struct tty_struct *tty, struct file * filp);
-static void serial_close (struct tty_struct *tty, struct file * filp);
-static int  serial_write (struct tty_struct * tty, int from_user, const unsigned char *buf, int count);
-static int  serial_write_room (struct tty_struct *tty);
-static int  serial_chars_in_buffer (struct tty_struct *tty);
-static void serial_throttle (struct tty_struct * tty);
-static void serial_unthrottle (struct tty_struct * tty);
-static int  serial_ioctl (struct tty_struct *tty, struct file * file, unsigned int cmd, unsigned long arg);
-static void serial_set_termios (struct tty_struct *tty, struct termios * old);
-static void serial_shutdown (struct usb_serial *serial);
-
-static void * usb_serial_probe(struct usb_device *dev, unsigned int ifnum,
-			       const struct usb_device_id *id);
-static void usb_serial_disconnect(struct usb_device *dev, void *ptr);
+/* we want to look at all devices, as the vendor/product id can change
+ * depending on the command line argument */
+static struct usb_device_id generic_serial_ids[] = {
+	{.driver_info = 42},
+	{}
+};
+#endif
 
+/* Driver structure we register with the USB core */
 static struct usb_driver usb_serial_driver = {
 	.name =		"serial",
-	.probe =	usb_serial_probe,
-	.disconnect =	usb_serial_disconnect,
-	.id_table =	NULL, 			/* check all devices */
+	.new_probe =	usb_serial_probe,
+	.new_disco =	usb_serial_disconnect,
+#ifdef CONFIG_USB_SERIAL_GENERIC
+	.id_table =	generic_serial_ids,
+#endif
 };
 
 /* There is no MODULE_DEVICE_TABLE for usbserial.c.  Instead
@@ -413,7 +406,6 @@
    drivers depend on it.
 */
 
-
 static int			serial_refcount;
 static struct tty_driver	serial_tty_driver;
 static struct tty_struct *	serial_tty[SERIAL_TTY_MINORS];
@@ -1162,12 +1154,12 @@
 	return serial;
 }
 
-static void * usb_serial_probe(struct usb_device *dev, unsigned int ifnum,
+int usb_serial_probe(struct usb_interface *interface,
 			       const struct usb_device_id *id)
 {
+	struct usb_device *dev = interface_to_usbdev (interface);
 	struct usb_serial *serial = NULL;
 	struct usb_serial_port *port;
-	struct usb_interface *interface;
 	struct usb_interface_descriptor *iface_desc;
 	struct usb_endpoint_descriptor *endpoint;
 	struct usb_endpoint_descriptor *interrupt_in_endpoint[MAX_NUM_PORTS];
@@ -1190,7 +1182,6 @@
 	/* loop through our list of known serial converters, and see if this
 	   device matches. */
 	found = 0;
-	interface = &dev->actconfig->interface[ifnum];
 	list_for_each (tmp, &usb_serial_driver_list) {
 		type = list_entry(tmp, struct usb_serial_device_type, driver_list);
 		id_pattern = usb_match_id(interface, type->id_table);
@@ -1203,13 +1194,13 @@
 	if (!found) {
 		/* no match */
 		dbg("none matched");
-		return(NULL);
+		return -ENODEV;
 	}
 
 	serial = create_serial (dev, interface, type);
 	if (!serial) {
 		err ("%s - out of memory", __FUNCTION__);
-		return NULL;
+		return -ENODEV;
 	}
 
 	/* if this device type has a probe function, call it */
@@ -1223,7 +1214,7 @@
 		if (retval < 0) {
 			dbg ("sub driver rejected device");
 			kfree (serial);
-			return NULL;
+			return -ENODEV;
 		}
 	}
 
@@ -1259,6 +1250,7 @@
 	}
 
 #if defined(CONFIG_USB_SERIAL_PL2303) || defined(CONFIG_USB_SERIAL_PL2303_MODULE)
+#if 0
 	/* BEGIN HORRIBLE HACK FOR PL2303 */ 
 	/* this is needed due to the looney way its endpoints are set up */
 	if (ifnum == 1) {
@@ -1283,6 +1275,7 @@
 	}
 	/* END HORRIBLE HACK FOR PL2303 */
 #endif
+#endif
 
 	/* found all that we need */
 	info("%s converter detected", type->name);
@@ -1293,7 +1286,7 @@
 		if (num_ports == 0) {
 			err("Generic device with no bulk out, not allowed.");
 			kfree (serial);
-			return NULL;
+			return -EIO;
 		}
 	}
 #endif
@@ -1313,7 +1306,7 @@
 	if (get_free_serial (serial, num_ports, &minor) == NULL) {
 		err("No more free serial devices");
 		kfree (serial);
-		return NULL;
+		return -ENOMEM;
 	}
 
 	serial->minor = minor;
@@ -1425,7 +1418,8 @@
 		if (retval > 0) {
 			/* quietly accept this device, but don't bind to a serial port
 			 * as it's about to disappear */
-			return serial;
+			interface->dev.driver_data = serial;
+			return 0;
 		}
 	}
 
@@ -1456,7 +1450,9 @@
 	}
 #endif
 
-	return serial; /* success */
+	/* success */
+	interface->dev.driver_data = serial;
+	return 0;
 
 
 probe_error:
@@ -1487,16 +1483,18 @@
 
 	/* free up any memory that we allocated */
 	kfree (serial);
-	return NULL;
+	return -EIO;
 }
 
-static void usb_serial_disconnect(struct usb_device *dev, void *ptr)
+void usb_serial_disconnect(struct usb_interface *interface)
 {
-	struct usb_serial *serial = (struct usb_serial *) ptr;
+	struct usb_serial *serial = (struct usb_serial *)interface->dev.driver_data;
 	struct usb_serial_port *port;
 	int i;
 
 	dbg(__FUNCTION__);
+
+	interface->dev.driver_data = NULL;
 	if (serial) {
 		/* fail all future close/read/write/ioctl/etc calls */
 		for (i = 0; i < serial->num_ports; ++i) {
@@ -1555,10 +1553,8 @@
 
 		/* free up any memory that we allocated */
 		kfree (serial);
-
-	} else {
-		info("device disconnected");
 	}
+	info("device disconnected");
 
 }
 
@@ -1660,8 +1656,6 @@
 
 	info ("USB Serial support registered for %s", new_device->name);
 
-	usb_scan_devices();
-
 	return 0;
 }
 
@@ -1678,7 +1672,7 @@
 		serial = serial_table[i];
 		if ((serial != NULL) && (serial->type == device)) {
 			usb_driver_release_interface (&usb_serial_driver, serial->interface);
-			usb_serial_disconnect (NULL, serial);
+			usb_serial_disconnect (serial->interface);
 		}
 	}
 
@@ -1691,6 +1685,8 @@
    need these symbols to load properly as modules. */
 EXPORT_SYMBOL(usb_serial_register);
 EXPORT_SYMBOL(usb_serial_deregister);
+EXPORT_SYMBOL(usb_serial_probe);
+EXPORT_SYMBOL(usb_serial_disconnect);
 #ifdef USES_EZUSB_FUNCTIONS
 	EXPORT_SYMBOL(ezusb_writememory);
 	EXPORT_SYMBOL(ezusb_set_reset);
diff -Naur -X /home/greg/linux/dontdiff linux-2.5.31-bk6/drivers/usb/serial/visor.c linux-2.5.31-bk6-greg/drivers/usb/serial/visor.c
--- linux-2.5.31-bk6/drivers/usb/serial/visor.c	Sat Aug 10 18:41:25 2002
+++ linux-2.5.31-bk6-greg/drivers/usb/serial/visor.c	Fri Aug 23 12:13:26 2002
@@ -197,7 +197,7 @@
 	{ }					/* Terminating entry */
 };
 
-static __devinitdata struct usb_device_id id_table_combined [] = {
+static struct usb_device_id id_table_combined [] = {
 	{ USB_DEVICE(HANDSPRING_VENDOR_ID, HANDSPRING_VISOR_ID) },
 	{ USB_DEVICE(PALM_VENDOR_ID, PALM_M500_ID) },
 	{ USB_DEVICE(PALM_VENDOR_ID, PALM_M505_ID) },
@@ -214,7 +214,12 @@
 
 MODULE_DEVICE_TABLE (usb, id_table_combined);
 
-
+static struct usb_driver visor_driver = {
+	.name =		"visor",
+	.new_probe =	usb_serial_probe,
+	.new_disco =	usb_serial_disconnect,
+	.id_table =	id_table_combined,
+};
 
 /* All of the device info needed for the Handspring Visor, and Palm 4.0 devices */
 static struct usb_serial_device_type handspring_device = {
@@ -761,6 +766,7 @@
 {
 	usb_serial_register (&handspring_device);
 	usb_serial_register (&clie_3_5_device);
+	usb_register (&visor_driver);
 	info(DRIVER_DESC " " DRIVER_VERSION);
 
 	return 0;
@@ -769,6 +775,7 @@
 
 static void __exit visor_exit (void)
 {
+	usb_deregister (&visor_driver);
 	usb_serial_deregister (&handspring_device);
 	usb_serial_deregister (&clie_3_5_device);
 }
diff -Naur -X /home/greg/linux/dontdiff linux-2.5.31-bk6/drivers/usb/serial/whiteheat.c linux-2.5.31-bk6-greg/drivers/usb/serial/whiteheat.c
--- linux-2.5.31-bk6/drivers/usb/serial/whiteheat.c	Sat Aug 10 18:41:26 2002
+++ linux-2.5.31-bk6-greg/drivers/usb/serial/whiteheat.c	Fri Aug 23 12:13:26 2002
@@ -110,7 +110,7 @@
 	{ }						/* Terminating entry */
 };
 
-static __devinitdata struct usb_device_id id_table_combined [] = {
+static struct usb_device_id id_table_combined [] = {
 	{ USB_DEVICE(CONNECT_TECH_VENDOR_ID, CONNECT_TECH_WHITE_HEAT_ID) },
 	{ USB_DEVICE(CONNECT_TECH_VENDOR_ID, CONNECT_TECH_FAKE_WHITE_HEAT_ID) },
 	{ }						/* Terminating entry */
@@ -118,6 +118,13 @@
 
 MODULE_DEVICE_TABLE (usb, id_table_combined);
 
+static struct usb_driver whiteheat_driver = {
+	.name =		"whiteheat",
+	.new_probe =	usb_serial_probe,
+	.new_disco =	usb_serial_disconnect,
+	.id_table =	id_table_combined,
+};
+
 /* function prototypes for the Connect Tech WhiteHEAT serial converter */
 static int  whiteheat_open		(struct usb_serial_port *port, struct file *filp);
 static void whiteheat_close		(struct usb_serial_port *port, struct file *filp);
@@ -676,6 +683,7 @@
 {
 	usb_serial_register (&whiteheat_fake_device);
 	usb_serial_register (&whiteheat_device);
+	usb_register (&whiteheat_driver);
 	info(DRIVER_DESC " " DRIVER_VERSION);
 	return 0;
 }
@@ -683,6 +691,7 @@
 
 static void __exit whiteheat_exit (void)
 {
+	usb_deregister (&whiteheat_driver);
 	usb_serial_deregister (&whiteheat_fake_device);
 	usb_serial_deregister (&whiteheat_device);
 }
diff -Naur -X /home/greg/linux/dontdiff linux-2.5.31-bk6/drivers/usb/storage/scsiglue.c linux-2.5.31-bk6-greg/drivers/usb/storage/scsiglue.c
--- linux-2.5.31-bk6/drivers/usb/storage/scsiglue.c	Fri Aug 23 11:53:49 2002
+++ linux-2.5.31-bk6-greg/drivers/usb/storage/scsiglue.c	Fri Aug 23 12:13:26 2002
@@ -252,7 +252,6 @@
 	for (i = 0; i < pusb_dev_save->actconfig->bNumInterfaces; i++) {
  		struct usb_interface *intf =
 			&pusb_dev_save->actconfig->interface[i];
-		const struct usb_device_id *id;
 
 		/* if this is an unclaimed interface, skip it */
 		if (!intf->driver) {
@@ -263,11 +262,8 @@
 
 		/* simulate a disconnect and reconnect for all interfaces */
 		US_DEBUGPX("simulating disconnect/reconnect.\n");
-		down(&intf->driver->serialize);
-		intf->driver->disconnect(pusb_dev_save, intf->private_data);
-		id = usb_match_id(intf, intf->driver->id_table);
-		intf->driver->probe(pusb_dev_save, i, id);
-		up(&intf->driver->serialize);
+		usb_device_remove (&intf->dev);
+		usb_device_probe (&intf->dev);
 	}
 	US_DEBUGP("bus_reset() complete\n");
 	scsi_lock(srb->host);
diff -Naur -X /home/greg/linux/dontdiff linux-2.5.31-bk6/drivers/usb/storage/usb.c linux-2.5.31-bk6-greg/drivers/usb/storage/usb.c
--- linux-2.5.31-bk6/drivers/usb/storage/usb.c	Sat Aug 10 18:41:24 2002
+++ linux-2.5.31-bk6-greg/drivers/usb/storage/usb.c	Fri Aug 23 12:13:26 2002
@@ -103,10 +103,10 @@
 struct us_data *us_list;
 struct semaphore us_list_semaphore;
 
-static void * storage_probe(struct usb_device *dev, unsigned int ifnum,
-			    const struct usb_device_id *id);
+static int storage_probe(struct usb_interface *iface,
+			 const struct usb_device_id *id);
 
-static void storage_disconnect(struct usb_device *dev, void *ptr);
+static void storage_disconnect(struct usb_interface *iface);
 
 /* The entries in this table, except for final ones here
  * (USB_MASS_STORAGE_CLASS and the empty entry), correspond,
@@ -229,8 +229,8 @@
 
 struct usb_driver usb_storage_driver = {
 	.name =		"usb-storage",
-	.probe =	storage_probe,
-	.disconnect =	storage_disconnect,
+	.new_probe =	storage_probe,
+	.new_disco =	storage_disconnect,
 	.id_table =	storage_usb_ids,
 };
 
@@ -583,9 +583,11 @@
 }
 
 /* Probe to see if a new device is actually a SCSI device */
-static void * storage_probe(struct usb_device *dev, unsigned int ifnum,
-			    const struct usb_device_id *id)
+static int storage_probe(struct usb_interface *intf,
+			 const struct usb_device_id *id)
 {
+	struct usb_device *dev = interface_to_usbdev(intf);
+	int ifnum = usb_if_to_ifnum(intf);
 	int i;
 	const int id_index = id - storage_usb_ids; 
 	char mf[USB_STOR_STRING_LEN];		     /* manufacturer */
@@ -610,7 +612,6 @@
 	/* the altsetting on the interface we're probing that matched our
 	 * usb_match_id table
 	 */
-	struct usb_interface *intf = dev->actconfig->interface;
 	struct usb_interface_descriptor *altsetting =
 		intf[ifnum].altsetting + intf[ifnum].act_altsetting;
 	US_DEBUGP("act_altsetting is %d\n", intf[ifnum].act_altsetting);
@@ -640,7 +641,7 @@
 			US_DEBUGP("Product: %s\n", unusual_dev->productName);
 	} else
 		/* no, we can't support it */
-		return NULL;
+		return -EIO;
 
 	/* At this point, we know we've got a live one */
 	US_DEBUGP("USB Mass Storage device detected\n");
@@ -689,7 +690,7 @@
 		} else if (result != 0) {
 			/* it's not a stall, but another error -- time to bail */
 			US_DEBUGP("-- Unknown error.  Rejecting device\n");
-			return NULL;
+			return -EIO;
 		}
 	}
 #endif
@@ -697,7 +698,7 @@
 	/* Do some basic sanity checks, and bail if we find a problem */
 	if (!ep_in || !ep_out || (protocol == US_PR_CBI && !ep_int)) {
 		US_DEBUGP("Endpoint sanity check failed! Rejecting dev.\n");
-		return NULL;
+		return -EIO;
 	}
 
 	/* At this point, we've decided to try to use the device */
@@ -776,7 +777,7 @@
 						    GFP_KERNEL)) == NULL) {
 			printk(KERN_WARNING USB_STORAGE "Out of memory\n");
 			usb_put_dev(dev);
-			return NULL;
+			return -ENOMEM;
 		}
 		memset(ss, 0, sizeof(struct us_data));
 		new_device = 1;
@@ -1053,8 +1054,9 @@
 	printk(KERN_DEBUG 
 	       "USB Mass Storage device found at %d\n", dev->devnum);
 
-	/* return a pointer for the disconnect function */
-	return ss;
+	/* save a pointer to our structure */
+	intf->dev.driver_data = ss;
+	return 0;
 
 	/* we come here if there are any problems */
 	/* ss->dev_semaphore must be locked */
@@ -1064,16 +1066,18 @@
 	up(&ss->dev_semaphore);
 	if (new_device)
 		kfree(ss);
-	return NULL;
+	return -EIO;
 }
 
 /* Handle a disconnect event from the USB core */
-static void storage_disconnect(struct usb_device *dev, void *ptr)
+static void storage_disconnect(struct usb_interface *intf)
 {
-	struct us_data *ss = ptr;
+	struct us_data *ss = intf->dev.driver_data;
 
 	US_DEBUGP("storage_disconnect() called\n");
 
+	intf->dev.driver_data = NULL;
+
 	/* this is the odd case -- we disconnected but weren't using it */
 	if (!ss) {
 		US_DEBUGP("-- device was not in use\n");
diff -Naur -X /home/greg/linux/dontdiff linux-2.5.31-bk6/include/linux/usb.h linux-2.5.31-bk6-greg/include/linux/usb.h
--- linux-2.5.31-bk6/include/linux/usb.h	Fri Aug 23 11:53:58 2002
+++ linux-2.5.31-bk6-greg/include/linux/usb.h	Fri Aug 23 12:13:26 2002
@@ -248,7 +248,7 @@
 	int act_altsetting;		/* active alternate setting */
 	int num_altsetting;		/* number of alternate settings */
 	int max_altsetting;		/* total memory allocated */
- 
+
 	struct usb_driver *driver;	/* driver */
 	struct device dev;		/* interface specific device info */
 	void *private_data;
@@ -312,6 +312,8 @@
 	__usb_get_extra_descriptor((ifpoint)->extra,(ifpoint)->extralen,\
 		type,(void**)ptr)
 
+extern int usb_if_to_ifnum(struct usb_interface *iface);
+	
 /* -------------------------------------------------------------------------- */
 
 /* Host Controller Driver (HCD) support */
@@ -428,9 +430,6 @@
 extern void usb_free_dev(struct usb_device *);
 #define usb_put_dev usb_free_dev
 
-/* for when layers above USB add new non-USB drivers */
-extern void usb_scan_devices(void);
-
 /* mostly for devices emulating SCSI over USB */
 extern int usb_reset_device(struct usb_device *dev);
 
@@ -674,6 +673,11 @@
 	struct module *owner;
 	const char *name;
 
+	int	(*new_probe)	(struct usb_interface *intf, const struct usb_device_id *id);
+	void	(*new_disco)	(struct usb_interface *intf);
+
+	struct device_driver driver;
+
 	void *(*probe)(
 	    struct usb_device *dev,		/* the device */
 	    unsigned intf,			/* what interface */
@@ -684,7 +688,6 @@
 	    void *handle			/* as returned by probe() */
 	    );
 
-	struct list_head driver_list;
 	struct semaphore serialize;
 
 	/* ioctl -- userspace apps can talk to drivers through usbfs */
@@ -698,6 +701,7 @@
 	/* void (*suspend)(struct usb_device *dev); */
 	/* void (*resume)(struct usb_device *dev); */
 };
+#define	to_usb_driver(d) container_of(d, struct usb_driver, driver)
 
 extern struct bus_type usb_bus_type;
 
@@ -711,6 +715,9 @@
 extern int usb_register_dev(struct file_operations *fops, int minor, int num_minors, int *start_minor);
 extern void usb_deregister_dev(int num_minors, int start_minor);
 
+extern int usb_device_probe(struct device *dev);
+extern int usb_device_remove(struct device *dev);
+
 /* -------------------------------------------------------------------------- */
 
 /*
