Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262079AbSJNRSZ>; Mon, 14 Oct 2002 13:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262080AbSJNRSZ>; Mon, 14 Oct 2002 13:18:25 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:62725 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262079AbSJNRSP>;
	Mon, 14 Oct 2002 13:18:15 -0400
Date: Mon, 14 Oct 2002 10:24:22 -0700
From: Greg KH <greg@kroah.com>
To: Patrick Mochel <mochel@osdl.org>
Cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: [RFC] device_initialize()
Message-ID: <20021014172422.GE6955@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In working to clean up the usb device reference counting logic, I moved
all of the calls to usb_get_dev() and usb_put_dev() to get_device() and
put_device() as it does not make sense to have two reference counts in
the same structure.  But when doing that, I realized that the USB core
accesses devices before it calls device_register().  And calling
get_device() and put_device() before device_register() is called is not
a good thing :)

So here's a patch that adds a device_initialize() call, that can be done
when the device structure is created.  At that point, get_device() and
put_device() can be successfully called, as the USB core needs, and at a
later time, device_register() can be called.  It also replaces the
present flag with a device state, allowing 3 valid states for a device
(initialized, registered, and gone).

I know Al needs much the same thing for his gendisk cleanup, and has
implemented almost the same patch as I have, but I think mine solves his
problem of having to manipulate the device refcount variable himself.

Anyway, here's a patch against 2.5.42 that adds device_initialize() and
fixes up the USB core to use it.  It works for me, but I haven't stress
tested it much (with lots of device removals.)  Any comments would be
appreciated.

thanks,

greg k-h


===== drivers/base/core.c 1.40 vs edited =====
--- 1.40/drivers/base/core.c	Fri Oct 11 23:08:56 2002
+++ edited/drivers/base/core.c	Mon Oct 14 09:36:58 2002
@@ -150,6 +150,27 @@
 }
 
 /**
+ * device_initialize - initialize a device
+ * @dev:	pointer to the device structure
+ */
+int device_initialize (struct device *dev)
+{
+	if (!dev)
+		return -EINVAL;
+
+	INIT_LIST_HEAD(&dev->node);
+	INIT_LIST_HEAD(&dev->children);
+	INIT_LIST_HEAD(&dev->g_list);
+	INIT_LIST_HEAD(&dev->driver_list);
+	INIT_LIST_HEAD(&dev->bus_list);
+	INIT_LIST_HEAD(&dev->intf_list);
+	spin_lock_init(&dev->lock);
+	atomic_set(&dev->refcount,1);
+	dev->state = DEVICE_INITIALIZED;
+	return 0;
+}
+
+/**
  * device_register - register a device
  * @dev:	pointer to the device structure
  *
@@ -167,15 +188,10 @@
 	if (!dev || !strlen(dev->bus_id))
 		return -EINVAL;
 
-	INIT_LIST_HEAD(&dev->node);
-	INIT_LIST_HEAD(&dev->children);
-	INIT_LIST_HEAD(&dev->g_list);
-	INIT_LIST_HEAD(&dev->driver_list);
-	INIT_LIST_HEAD(&dev->bus_list);
-	INIT_LIST_HEAD(&dev->intf_list);
-	spin_lock_init(&dev->lock);
-	atomic_set(&dev->refcount,2);
-	dev->present = 1;
+	if (dev->state != DEVICE_INITIALIZED)
+		return -EINVAL;
+
+	get_device(dev);
 	spin_lock(&device_lock);
 	if (dev->parent) {
 		get_device_locked(dev->parent);
@@ -212,6 +228,7 @@
 		if (dev->parent)
 			put_device(dev->parent);
 	}
+	dev->state = DEVICE_INITIALIZED;
 	put_device(dev);
 	return error;
 }
@@ -219,7 +236,9 @@
 struct device * get_device_locked(struct device * dev)
 {
 	struct device * ret = dev;
-	if (dev && dev->present && atomic_read(&dev->refcount) > 0)
+	if (dev && 
+	    dev->state != DEVICE_GONE && 
+	    atomic_read(&dev->refcount) > 0)
 		atomic_inc(&dev->refcount);
 	else
 		ret = NULL;
@@ -248,8 +267,6 @@
 	dev->parent = NULL;
 	spin_unlock(&device_lock);
 
-	BUG_ON(dev->present);
-
 	if (dev->release)
 		dev->release(dev);
 
@@ -263,13 +280,13 @@
  *
  * The device has been removed from the system, so we disavow knowledge
  * of it. It might not be the final reference to the device, so we mark
- * it as !present, so no more references to it can be acquired.
+ * it as gone, so no more references to it can be acquired.
  * In the end, we decrement the final reference count for it.
  */
 void device_unregister(struct device * dev)
 {
 	spin_lock(&device_lock);
-	dev->present = 0;
+	dev->state = DEVICE_GONE;
 	list_del_init(&dev->node);
 	list_del_init(&dev->g_list);
 	list_del_init(&dev->bus_list);
@@ -309,6 +326,7 @@
 
 core_initcall(device_init);
 
+EXPORT_SYMBOL(device_initialize);
 EXPORT_SYMBOL(device_register);
 EXPORT_SYMBOL(device_unregister);
 EXPORT_SYMBOL(get_device);
===== drivers/base/platform.c 1.2 vs edited =====
--- 1.2/drivers/base/platform.c	Fri Sep 27 07:51:03 2002
+++ edited/drivers/base/platform.c	Mon Oct 14 08:22:41 2002
@@ -33,6 +33,7 @@
 
 	pr_debug("Registering platform device '%s'. Parent at %s\n",
 		 pdev->dev.bus_id,pdev->dev.parent->bus_id);
+	device_initialize(&pdev->dev);
 	return device_register(&pdev->dev);
 }
 
@@ -54,6 +55,7 @@
 
 static int __init platform_bus_init(void)
 {
+	device_initialize(&legacy_bus);
 	device_register(&legacy_bus);
 	return bus_register(&platform_bus_type);
 }
===== drivers/base/sys.c 1.4 vs edited =====
--- 1.4/drivers/base/sys.c	Fri Sep 27 07:51:02 2002
+++ edited/drivers/base/sys.c	Mon Oct 14 08:19:38 2002
@@ -55,11 +55,13 @@
 
 	pr_debug("Registering system board %d\n",root->id);
 
+	device_initialize(&root->dev);
 	error = device_register(&root->dev);
 	if (!error) {
 		strncpy(root->sysdev.bus_id,"sys",BUS_ID_SIZE);
 		strncpy(root->sysdev.name,"System Bus",DEVICE_NAME_SIZE);
 		root->sysdev.parent = &root->dev;
+		device_initialize(&root->sysdev);
 		error = device_register(&root->sysdev);
 	};
 
@@ -119,6 +121,7 @@
 
 	pr_debug("Registering system device %s\n", sysdev->dev.bus_id);
 
+	device_initialize(&sysdev->dev);
 	return device_register(&sysdev->dev);
 }
 
@@ -135,6 +138,7 @@
 static int sys_bus_init(void)
 {
 	bus_register(&system_bus_type);
+	device_initialize(&system_bus);
 	return device_register(&system_bus);
 }
 
===== drivers/ide/ide-probe.c 1.10 vs edited =====
--- 1.10/drivers/ide/ide-probe.c	Fri Oct 11 14:23:00 2002
+++ edited/drivers/ide/ide-probe.c	Mon Oct 14 08:20:23 2002
@@ -583,6 +583,7 @@
 		hwif->gendev.parent = &hwif->pci_dev->dev;
 	else
 		hwif->gendev.parent = NULL; /* Would like to do = &device_legacy */
+	device_initialize(&hwif->gendev);
 	device_register(&hwif->gendev);
 
 	if (hwif->mmio == 2)
@@ -1021,8 +1022,10 @@
 			 "%s","IDE Drive");
 		drive->gendev.parent = &hwif->gendev;
 		drive->gendev.bus = &ide_bus_type;
-		if (drive->present)
+		if (drive->present) {
+			device_initialize(&drive->gendev);
 			device_register(&drive->gendev);
+		}
 	}
 
 	return;
===== drivers/pci/probe.c 1.10 vs edited =====
--- 1.10/drivers/pci/probe.c	Fri Sep 20 10:20:03 2002
+++ edited/drivers/pci/probe.c	Mon Oct 14 08:20:52 2002
@@ -450,6 +450,7 @@
 	strcpy(dev->dev.name,dev->name);
 	strcpy(dev->dev.bus_id,dev->slot_name);
 
+	device_initialize(&dev->dev);
 	device_register(&dev->dev);
 	return dev;
 }
@@ -568,6 +569,7 @@
 	memset(b->dev,0,sizeof(*(b->dev)));
 	sprintf(b->dev->bus_id,"pci%d",bus);
 	strcpy(b->dev->name,"Host/PCI Bridge");
+	device_initialize(b->dev);
 	device_register(b->dev);
 
 	b->number = b->secondary = bus;
===== drivers/usb/core/config.c 1.8 vs edited =====
--- 1.8/drivers/usb/core/config.c	Tue Oct  1 11:10:56 2002
+++ edited/drivers/usb/core/config.c	Sun Oct 13 23:09:50 2002
@@ -99,6 +99,7 @@
 	interface->act_altsetting = 0;
 	interface->num_altsetting = 0;
 	interface->max_altsetting = USB_ALTSETTINGALLOC;
+	device_initialize (&interface->dev);
 
 	interface->altsetting = kmalloc(sizeof(struct usb_interface_descriptor) * interface->max_altsetting, GFP_KERNEL);
 	
===== drivers/usb/core/hcd.c 1.66 vs edited =====
--- 1.66/drivers/usb/core/hcd.c	Tue Oct  1 09:54:04 2002
+++ edited/drivers/usb/core/hcd.c	Sun Oct 13 19:07:44 2002
@@ -968,7 +968,7 @@
 	list_del_init (&urb->urb_list);
 	dev = urb->dev;
 	urb->dev = NULL;
-	usb_put_dev (dev);
+	put_device (&dev->dev);
 	spin_unlock_irqrestore (&hcd_data_lock, flags);
 }
 
@@ -1007,7 +1007,7 @@
 
 	spin_lock_irqsave (&hcd_data_lock, flags);
 	if (HCD_IS_RUNNING (hcd->state) && hcd->state != USB_STATE_QUIESCING) {
-		usb_get_dev (urb->dev);
+		get_device (&urb->dev->dev);
 		list_add (&urb->urb_list, &dev->urb_list);
 		status = 0;
 	} else {
===== drivers/usb/core/hub.c 1.65 vs edited =====
--- 1.65/drivers/usb/core/hub.c	Sat Oct 12 07:51:21 2002
+++ edited/drivers/usb/core/hub.c	Sun Oct 13 19:07:44 2002
@@ -848,7 +848,7 @@
 
 		/* Reset the device, and detect its speed */
 		if (usb_hub_port_reset(hub, port, dev, delay)) {
-			usb_free_dev(dev);
+			put_device(&dev->dev);
 			break;
 		}
 
@@ -898,7 +898,7 @@
 			goto done;
 
 		/* Free the configuration if there was an error */
-		usb_free_dev(dev);
+		put_device(&dev->dev);
 
 		/* Switch to a long reset time */
 		delay = HUB_LONG_RESET_TIME;
===== drivers/usb/core/usb.c 1.163 vs edited =====
--- 1.163/drivers/usb/core/usb.c	Fri Oct 11 23:09:01 2002
+++ edited/drivers/usb/core/usb.c	Sun Oct 13 19:59:50 2002
@@ -115,7 +115,7 @@
 	struct usb_driver *driver;
 	int m;
 
-	intf = list_entry(dev,struct usb_interface,dev);
+	intf = to_usb_interface (dev);
 	driver = to_usb_driver(dev->driver);
 
 	if (!driver) {
@@ -650,6 +650,8 @@
 
 	memset(dev, 0, sizeof(*dev));
 
+	device_initialize (&dev->dev);
+
 	usb_bus_get(bus);
 
 	if (!parent)
@@ -668,49 +670,27 @@
 }
 
 /**
- * usb_get_dev - increments the reference count of the device
- * @dev: the device being referenced
- *
- * Each live reference to a device should be refcounted.
- *
- * Drivers for USB interfaces should normally record such references in
- * their probe() methods, when they bind to an interface, and release
- * them by calling usb_put_dev(), in their disconnect() methods.
+ * usb_release_dev - free a usb device structure when all users of it are finished.
+ * @dev: device that's been disconnected
  *
- * A pointer to the device with the incremented reference counter is returned.
+ * Will be called by the device core when all users of this usb device are done.
  */
-struct usb_device *usb_get_dev (struct usb_device *dev)
+void usb_release_dev (struct device *dev)
 {
-	if (dev) {
-		atomic_inc (&dev->refcnt);
-		return dev;
-	}
-	return NULL;
-}
+	struct usb_device *udev;
 
-/**
- * usb_free_dev - free a usb device structure when all users of it are finished.
- * @dev: device that's been disconnected
- * Context: !in_interrupt ()
- *
- * Must be called when a user of a device is finished with it.  When the last
- * user of the device calls this function, the memory of the device is freed.
- *
- * Used by hub and virtual root hub drivers.  The device is completely
- * gone, everything is cleaned up, so it's time to get rid of these last
- * records of this device.
- */
-void usb_free_dev(struct usb_device *dev)
-{
-	if (atomic_dec_and_test(&dev->refcnt)) {
-		if (dev->bus->op->deallocate)
-			dev->bus->op->deallocate(dev);
-		usb_destroy_configuration (dev);
-		usb_bus_put (dev->bus);
-		kfree (dev);
-	}
-}
+	dbg ("%s - freeing up the %s device now", __FUNCTION__, dev->name);
+
+	udev = to_usb_device (dev);
+	if (!udev)
+		return;
 
+	if (udev->bus->op->deallocate)
+		udev->bus->op->deallocate (udev);
+	usb_destroy_configuration (udev);
+	usb_bus_put (udev->bus);
+	kfree (udev);
+}
 
 /**
  * usb_get_current_frame_number - return current bus frame number
@@ -802,13 +782,15 @@
 	/* Free the device number and remove the /proc/bus/usb entry */
 	if (dev->devnum > 0) {
 		clear_bit(dev->devnum, dev->bus->devmap.devicemap);
-		usbfs_remove_device(dev);
-		device_unregister(&dev->dev);
+//		usbfs_remove_device(dev);
+//		device_unregister(&dev->dev);
 	}
+	usbfs_remove_device(dev);
+	device_unregister(&dev->dev);
 
 	/* Decrement the reference count, it'll auto free everything when */
 	/* it hits 0 which could very well be now */
-	usb_put_dev(dev);
+//	usb_put_dev(dev);
 }
 
 /**
@@ -1033,6 +1015,7 @@
 	dev->dev.parent = parent;
 	dev->dev.driver = &usb_generic_driver;
 	dev->dev.bus = &usb_bus_type;
+	dev->dev.release = usb_release_dev;
 	if (dev->dev.bus_id[0] == 0)
 		sprintf (&dev->dev.bus_id[0], "%d-%s",
 			 dev->bus->busnum, dev->devpath);
@@ -1419,8 +1402,6 @@
 EXPORT_SYMBOL(usb_device_remove);
 
 EXPORT_SYMBOL(usb_alloc_dev);
-EXPORT_SYMBOL(usb_free_dev);
-EXPORT_SYMBOL(usb_get_dev);
 EXPORT_SYMBOL(usb_hub_tt_clear_buffer);
 
 EXPORT_SYMBOL(usb_driver_claim_interface);
===== drivers/usb/host/ehci-hcd.c 1.50 vs edited =====
--- 1.50/drivers/usb/host/ehci-hcd.c	Thu Oct 10 15:39:20 2002
+++ edited/drivers/usb/host/ehci-hcd.c	Sun Oct 13 19:07:45 2002
@@ -456,7 +456,7 @@
 			ehci_ready (ehci);
 		ehci_reset (ehci);
 		bus->root_hub = 0;
-		usb_free_dev (udev); 
+		put_device (&udev->dev); 
 		retval = -ENODEV;
 		goto done2;
 	}
===== drivers/usb/host/hc_sl811_rh.c 1.3 vs edited =====
--- 1.3/drivers/usb/host/hc_sl811_rh.c	Tue Aug 27 13:08:49 2002
+++ edited/drivers/usb/host/hc_sl811_rh.c	Sun Oct 13 19:07:45 2002
@@ -566,7 +566,7 @@
 	hci->bus->root_hub = usb_dev;
 	usb_connect (usb_dev);
 	if (usb_new_device (usb_dev) != 0) {
-		usb_free_dev (usb_dev);
+		put_device (&usb_dev->dev);
 		return -ENODEV;
 	}
 
===== drivers/usb/host/ohci-hcd.c 1.45 vs edited =====
--- 1.45/drivers/usb/host/ohci-hcd.c	Tue Oct  1 09:54:05 2002
+++ edited/drivers/usb/host/ohci-hcd.c	Sun Oct 13 19:07:46 2002
@@ -509,7 +509,7 @@
 	usb_connect (udev);
 	udev->speed = USB_SPEED_FULL;
 	if (usb_register_root_hub (udev, ohci->parent_dev) != 0) {
-		usb_free_dev (udev);
+		put_device (&udev->dev);
 		ohci->hcd.self.root_hub = NULL;
 		disable (ohci);
 		ohci->hc_control &= ~OHCI_CTRL_HCFS;
===== drivers/usb/host/uhci-hcd.c 1.22 vs edited =====
--- 1.22/drivers/usb/host/uhci-hcd.c	Thu Oct 10 15:36:30 2002
+++ edited/drivers/usb/host/uhci-hcd.c	Sun Oct 13 19:07:46 2002
@@ -161,7 +161,7 @@
 	INIT_LIST_HEAD(&td->list);
 	INIT_LIST_HEAD(&td->fl_list);
 
-	usb_get_dev(dev);
+	get_device(&dev->dev);
 
 	return td;
 }
@@ -315,7 +315,7 @@
 		dbg("td %p is still in fl_list!", td);
 
 	if (td->dev)
-		usb_put_dev(td->dev);
+		put_device(&td->dev->dev);
 
 	pci_pool_free(uhci->td_pool, td, td->dma_handle);
 }
@@ -340,7 +340,7 @@
 	INIT_LIST_HEAD(&qh->list);
 	INIT_LIST_HEAD(&qh->remove_list);
 
-	usb_get_dev(dev);
+	get_device(&dev->dev);
 
 	return qh;
 }
@@ -353,7 +353,7 @@
 		dbg("qh %p still in remove_list!", qh);
 
 	if (qh->dev)
-		usb_put_dev(qh->dev);
+		put_device(&qh->dev->dev);
 
 	pci_pool_free(uhci->qh_pool, qh, qh->dma_handle);
 }
@@ -2328,7 +2328,7 @@
 		}
 
 err_alloc_skeltd:
-	usb_free_dev(udev);
+	put_device(&udev->dev);
 	hcd->self.root_hub = NULL;
 
 err_alloc_root_hub:
===== drivers/usb/media/usbvideo.c 1.34 vs edited =====
--- 1.34/drivers/usb/media/usbvideo.c	Tue Sep 17 21:54:34 2002
+++ edited/drivers/usb/media/usbvideo.c	Sun Oct 13 19:07:47 2002
@@ -991,7 +991,7 @@
 	for (i=0; i < USBVIDEO_NUMSBUF; i++)
 		usb_free_urb(uvd->sbuf[i].urb);
 
-	usb_put_dev(uvd->dev);
+	put_device(&uvd->dev->dev);
 	uvd->dev = NULL;    	    /* USB device is no more */
 
 	video_unregister_device(&uvd->vdev);
@@ -1195,7 +1195,7 @@
 	}
 #endif
 
-	usb_get_dev(uvd->dev);
+	get_device(&uvd->dev->dev);
 	return 0;
 }
 
===== drivers/usb/net/cdc-ether.c 1.24 vs edited =====
--- 1.24/drivers/usb/net/cdc-ether.c	Tue Sep 17 21:54:34 2002
+++ edited/drivers/usb/net/cdc-ether.c	Sun Oct 13 19:07:47 2002
@@ -1257,7 +1257,7 @@
 	                            ether_dev );
 
 	// Does this REALLY do anything???
-	usb_get_dev( usb );
+	get_device(&usb->dev);
 
 	// TODO - last minute HACK
 	ether_dev->comm_ep_in = 5;
@@ -1316,7 +1316,7 @@
 	ether_dev->net = NULL;
 
 	// I ask again, does this do anything???
-	usb_put_dev( usb );
+	put_device(&usb->dev);
 
 	// We are done with this interface
 	usb_driver_release_interface( &CDCEther_driver, 
===== drivers/usb/net/pegasus.c 1.48 vs edited =====
--- 1.48/drivers/usb/net/pegasus.c	Tue Sep 17 21:54:35 2002
+++ edited/drivers/usb/net/pegasus.c	Sun Oct 13 19:07:47 2002
@@ -1062,7 +1062,7 @@
 		return -ENOMEM;
 	}
 
-	usb_get_dev(dev);
+	get_device(&dev->dev);
 	memset(pegasus, 0, sizeof(struct pegasus));
 	pegasus->dev_index = dev_index;
 	init_waitqueue_head(&pegasus->ctrl_wait);
@@ -1142,7 +1142,7 @@
 
 	pegasus->flags |= PEGASUS_UNPLUG;
 	unregister_netdev(pegasus->net);
-	usb_put_dev(interface_to_usbdev(intf));
+	put_device(&interface_to_usbdev(intf)->dev);
 	unlink_all_urbs(pegasus);
 	free_all_urbs(pegasus);
 	free_skb_pool(pegasus);
===== drivers/usb/net/usbnet.c 1.49 vs edited =====
--- 1.49/drivers/usb/net/usbnet.c	Sat Oct 12 07:51:23 2002
+++ edited/drivers/usb/net/usbnet.c	Sun Oct 13 19:07:48 2002
@@ -1968,7 +1968,7 @@
 	flush_scheduled_work ();
 
 	kfree (dev);
-	usb_put_dev (xdev);
+	put_device (&xdev->dev);
 }
 
 
@@ -2006,7 +2006,7 @@
 	memset (dev, 0, sizeof *dev);
 
 	init_MUTEX_LOCKED (&dev->mutex);
-	usb_get_dev (xdev);
+	get_device (&xdev->dev);
 	dev->udev = xdev;
 	dev->driver_info = info;
 	dev->msg_level = msg_level;
===== drivers/usb/storage/usb.c 1.48 vs edited =====
--- 1.48/drivers/usb/storage/usb.c	Sat Oct 12 13:57:56 2002
+++ edited/drivers/usb/storage/usb.c	Sun Oct 13 19:07:48 2002
@@ -624,7 +624,7 @@
 
 	/* mark the device as gone */
 	ss->flags &= ~ US_FL_DEV_ATTACHED;
-	usb_put_dev(ss->pusb_dev);
+	put_device(&ss->pusb_dev->dev);
 	ss->pusb_dev = NULL;
 }
 
@@ -747,7 +747,7 @@
 	}
 
 	/* At this point, we've decided to try to use the device */
-	usb_get_dev(dev);
+	get_device(&dev->dev);
 
 	/* clear the GUID and fetch the strings */
 	GUID_CLEAR(guid);
@@ -821,7 +821,7 @@
 		if ((ss = (struct us_data *)kmalloc(sizeof(struct us_data), 
 						    GFP_KERNEL)) == NULL) {
 			printk(KERN_WARNING USB_STORAGE "Out of memory\n");
-			usb_put_dev(dev);
+			put_device(&dev->dev);
 			return -ENOMEM;
 		}
 		memset(ss, 0, sizeof(struct us_data));
===== fs/partitions/check.c 1.29 vs edited =====
--- 1.29/fs/partitions/check.c	Fri Oct 11 23:09:04 2002
+++ edited/fs/partitions/check.c	Mon Oct 14 08:21:42 2002
@@ -168,6 +168,7 @@
 	dev->parent = parent;
 	if (parent)
 		dev->bus = parent->bus;
+	device_initialize(dev);
 	device_register(dev);
 	device_create_file(dev, &dev_attr_type);
 	device_create_file(dev, &dev_attr_kdev);
@@ -179,6 +180,7 @@
 			dev->bus = parent->bus;
 		if (!dev->driver_data)
 			continue;
+		device_initialize(dev);
 		device_register(dev);
 		device_create_file(dev, &dev_attr_type);
 		device_create_file(dev, &dev_attr_kdev);
@@ -441,6 +443,7 @@
 		return;
 	dev->driver_data =
 		(void *)(long)__mkdev(disk->major, disk->first_minor+part);
+	device_initialize(dev);
 	device_register(dev);
 	device_create_file(dev, &dev_attr_type);
 	device_create_file(dev, &dev_attr_kdev);
===== include/linux/device.h 1.34 vs edited =====
--- 1.34/include/linux/device.h	Fri Oct 11 23:09:04 2002
+++ edited/include/linux/device.h	Sun Oct 13 20:02:41 2002
@@ -256,7 +256,11 @@
 
 extern int interface_add_data(struct intf_data *);
 
-
+enum device_state {
+	DEVICE_INITIALIZED =	1,
+	DEVICE_REGISTERED =	2,
+	DEVICE_GONE =		3,
+};
 
 struct device {
 	struct list_head g_list;        /* node in depth-first order list */
@@ -289,7 +293,7 @@
 	void		*platform_data;	/* Platform specific data (e.g. ACPI,
 					   BIOS data relevant to device) */
 
-	u32		present;
+	enum device_state state;
 	u32		current_state;  /* Current operating state. In
 					   ACPI-speak, this is D0-D3, D0
 					   being fully functional, and D3
@@ -328,6 +332,7 @@
  * High level routines for use by the bus drivers
  */
 extern int device_register(struct device * dev);
+extern int device_initialize(struct device * dev);
 extern void device_unregister(struct device * dev);
 
 /* driverfs interface for exporting device attributes */
===== include/linux/usb.h 1.101 vs edited =====
--- 1.101/include/linux/usb.h	Sat Oct 12 22:42:23 2002
+++ edited/include/linux/usb.h	Sun Oct 13 19:07:49 2002
@@ -426,9 +426,9 @@
 #define	to_usb_device(d) container_of(d, struct usb_device, dev)
 
 extern struct usb_device *usb_alloc_dev(struct usb_device *parent, struct usb_bus *);
-extern struct usb_device *usb_get_dev(struct usb_device *dev);
-extern void usb_free_dev(struct usb_device *);
-#define usb_put_dev usb_free_dev
+//extern struct usb_device *usb_get_dev(struct usb_device *dev);
+//extern void usb_free_dev(struct usb_device *);
+//#define usb_put_dev usb_free_dev
 
 /* mostly for devices emulating SCSI over USB */
 extern int usb_reset_device(struct usb_device *dev);
