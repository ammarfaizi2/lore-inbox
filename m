Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263855AbTDVUs1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 16:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263874AbTDVUrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 16:47:12 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:33714 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263855AbTDVUps (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 16:45:48 -0400
Date: Tue, 22 Apr 2003 13:59:49 -0700
From: Greg KH <greg@kroah.com>
To: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Cc: hannal@us.ibm.com, andmike@us.ibm.com
Subject: [RFC] Device class rework [5/5]
Message-ID: <20030422205949.GF4701@kroah.com>
References: <20030422205545.GA4701@kroah.com> <20030422205719.GB4701@kroah.com> <20030422205749.GC4701@kroah.com> <20030422205827.GD4701@kroah.com> <20030422205907.GE4701@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030422205907.GE4701@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 22, 2003 at 01:55:45PM -0700, Greg KH wrote:
>  - tty changes.  This converts the tty code to the new driver class
>    changes.  With this patch, we now show all tty devices, and their
>    device major/minor number in the /sys/class/tty/ directory.  Yes,
>    this is still a bit crude (all ptys are shown, and they should not
>    be), but it's an example of why these changes are needed, and how
>    to
>    add class support to a subsystem.  I'll rework this after
>    Christoph's
>    and Al Viro's tty changes are in the main tree, as we all are
>    touching the same part of code.



diff -Nru a/drivers/char/tty_io.c b/drivers/char/tty_io.c
--- a/drivers/char/tty_io.c	Tue Apr 22 13:07:51 2003
+++ b/drivers/char/tty_io.c	Tue Apr 22 13:07:51 2003
@@ -2133,18 +2133,94 @@
 # define tty_register_devfs(driver, minor)	do { } while (0)
 # define tty_unregister_devfs(driver, minor)	do { } while (0)
 #endif /* CONFIG_DEVFS_FS */
+static struct class tty_class = {
+	.name	= "tty",
+};
+
+struct tty_dev {
+	struct list_head node;
+	struct tty_driver *driver;
+	unsigned minor;
+	struct class_device class_dev;
+};
+#define to_tty_dev(d) container_of(d, struct tty_dev, class_dev)
+
+static LIST_HEAD(tty_dev_list);
+
+static ssize_t show_dev (struct class_device *class_dev, char *buf)
+{
+	struct tty_dev *tty_dev = to_tty_dev(class_dev);
+	dev_t base;
+
+	base = MKDEV(tty_dev->driver->major, tty_dev->minor);
+	return sprintf(buf, "%04x\n", base);
+}
+static CLASS_DEVICE_ATTR(dev, S_IRUGO, show_dev, NULL);
 
 /*
  * Register a tty device described by <driver>, with minor number <minor>.
  */
-void tty_register_device(struct tty_driver *driver, unsigned minor)
+void tty_register_device (struct tty_driver *driver, unsigned minor, struct device *dev)
 {
+	struct tty_dev *tty_dev = NULL;
+	char *name = NULL;
+	char *temp;
+	int retval;
+
 	tty_register_devfs(driver, minor);
+
+	tty_dev = kmalloc(sizeof(*tty_dev), GFP_KERNEL);
+	if (!tty_dev)
+		return;
+	memset(tty_dev, 0x00, sizeof(*tty_dev));
+	name = kmalloc(DEVICE_NAME_SIZE, GFP_KERNEL);
+	if (!name)
+		goto error;
+
+	/* stupid '%' in tty name strings... */
+	strncpy(name, driver->name, DEVICE_NAME_SIZE);
+	temp = strchr(name, '%');
+	if (temp)
+		*temp = 0x00;
+
+	tty_dev->class_dev.dev = dev;
+	tty_dev->class_dev.class = &tty_class;
+	snprintf(tty_dev->class_dev.class_id, BUS_ID_SIZE, "%s%d", name,
+		 minor - driver->minor_start);
+	retval = class_device_register(&tty_dev->class_dev);
+	if (retval)
+		goto error;
+	class_device_create_file (&tty_dev->class_dev, &class_device_attr_dev);
+	tty_dev->driver = driver;
+	tty_dev->minor = minor;
+	list_add(&tty_dev->node, &tty_dev_list);
+	return;
+error:
+	kfree(name);
+	kfree(tty_dev);
 }
 
 void tty_unregister_device(struct tty_driver *driver, unsigned minor)
 {
+	struct tty_dev *tty_dev = NULL;
+	struct list_head *tmp;
+	int found = 0;
+
 	tty_unregister_devfs(driver, minor);
+
+	list_for_each (tmp, &tty_dev_list) {
+		tty_dev = list_entry(tmp, struct tty_dev, node);
+		if ((tty_dev->driver == driver) &&
+		    (tty_dev->minor == minor)) {
+			found = 1;
+			break;
+		}
+	}
+	if (found) {
+		list_del(&tty_dev->node);
+		class_device_unregister(&tty_dev->class_dev);
+		kfree(tty_dev);
+	}
 }
 
 EXPORT_SYMBOL(tty_register_device);
@@ -2175,7 +2251,7 @@
 	
 	if ( !(driver->flags & TTY_DRIVER_NO_DEVFS) ) {
 		for(i = 0; i < driver->num; i++)
-		    tty_register_device(driver, driver->minor_start + i);
+		    tty_register_device(driver, driver->minor_start + i, NULL);
 	}
 	proc_tty_register_driver(driver);
 	return error;
@@ -2263,14 +2339,9 @@
 extern int vty_init(void);
 #endif
 
-struct device_class tty_devclass = {
-	.name	= "tty",
-};
-EXPORT_SYMBOL(tty_devclass);
-
 static int __init tty_devclass_init(void)
 {
-	return devclass_register(&tty_devclass);
+	return class_register(&tty_class);
 }
 
 postcore_initcall(tty_devclass_init);
diff -Nru a/drivers/char/vt.c b/drivers/char/vt.c
--- a/drivers/char/vt.c	Tue Apr 22 13:07:51 2003
+++ b/drivers/char/vt.c	Tue Apr 22 13:07:51 2003
@@ -2665,7 +2665,7 @@
 
 	for (i = 0; i < console_driver.num; i++)
 		tty_register_device (&console_driver,
-				    console_driver.minor_start + i);
+				    console_driver.minor_start + i, NULL);
 }
 
 /*
diff -Nru a/drivers/serial/8250_pci.c b/drivers/serial/8250_pci.c
--- a/drivers/serial/8250_pci.c	Tue Apr 22 13:08:02 2003
+++ b/drivers/serial/8250_pci.c	Tue Apr 22 13:08:02 2003
@@ -2043,9 +2043,6 @@
 	.suspend	= pciserial_suspend_one,
 	.resume		= pciserial_resume_one,
 	.id_table	= serial_pci_tbl,
-	.driver = {
-		.devclass = &tty_devclass,
-	},
 };
 
 static int __init serial8250_pci_init(void)
diff -Nru a/drivers/serial/core.c b/drivers/serial/core.c
--- a/drivers/serial/core.c	Tue Apr 22 13:07:50 2003
+++ b/drivers/serial/core.c	Tue Apr 22 13:07:50 2003
@@ -2231,7 +2231,7 @@
 	 * Register the port whether it's detected or not.  This allows
 	 * setserial to be used to alter this ports parameters.
 	 */
-	tty_register_device(drv->tty_driver, drv->minor + port->line);
+	tty_register_device(drv->tty_driver, drv->minor + port->line, NULL);
 
  out:
 	up(&port_sem);
diff -Nru a/drivers/usb/class/bluetty.c b/drivers/usb/class/bluetty.c
--- a/drivers/usb/class/bluetty.c	Tue Apr 22 13:07:53 2003
+++ b/drivers/usb/class/bluetty.c	Tue Apr 22 13:07:53 2003
@@ -1198,7 +1198,7 @@
 		     bluetooth, endpoint->bInterval);
 
 	/* initialize the devfs nodes for this device and let the user know what bluetooths we are bound to */
-	tty_register_device (&bluetooth_tty_driver, minor);
+	tty_register_device (&bluetooth_tty_driver, minor, &intf->dev);
 	info("Bluetooth converter now attached to ttyUB%d (or usb/ttub/%d for devfs)", minor, minor);
 
 	bluetooth_table[minor] = bluetooth;
diff -Nru a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
--- a/drivers/usb/class/cdc-acm.c	Tue Apr 22 13:08:03 2003
+++ b/drivers/usb/class/cdc-acm.c	Tue Apr 22 13:08:03 2003
@@ -649,7 +649,7 @@
 		usb_driver_claim_interface(&acm_driver, acm->iface + 0, acm);
 		usb_driver_claim_interface(&acm_driver, acm->iface + 1, acm);
 
-		tty_register_device(&acm_tty_driver, minor);
+		tty_register_device(&acm_tty_driver, minor, &intf->dev);
 
 		acm_table[minor] = acm;
 		usb_set_intfdata (intf, acm);
diff -Nru a/drivers/usb/serial/bus.c b/drivers/usb/serial/bus.c
--- a/drivers/usb/serial/bus.c	Tue Apr 22 13:07:48 2003
+++ b/drivers/usb/serial/bus.c	Tue Apr 22 13:07:48 2003
@@ -23,18 +23,6 @@
 
 #include "usb-serial.h"
 
-static ssize_t show_dev (struct device *dev, char *buf)
-{
-	struct usb_serial_port *port= to_usb_serial_port(dev);
-	dev_t base;
-
-	port = to_usb_serial_port(dev);
-
-	base = MKDEV(SERIAL_TTY_MAJOR, port->number);
-	return sprintf(buf, "%04x\n", base);
-}
-static DEVICE_ATTR(dev, S_IRUGO, show_dev, NULL);
-
 static int usb_serial_device_match (struct device *dev, struct device_driver *drv)
 {
 	struct usb_serial_device_type *driver;
@@ -88,10 +76,7 @@
 	}
 
 	minor = port->number;
-
-	tty_register_device (&usb_serial_tty_driver, minor);
-	device_create_file (dev, &dev_attr_dev);
-
+	tty_register_device (&usb_serial_tty_driver, minor, dev);
 	dev_info(&port->serial->dev->dev, 
 		 "%s converter now attached to ttyUSB%d (or usb/tts/%d for devfs)\n",
 		 driver->name, minor, minor);
@@ -142,7 +127,6 @@
 	device->driver.bus = &usb_serial_bus_type;
 	device->driver.probe = usb_serial_device_probe;
 	device->driver.remove = usb_serial_device_remove;
-	device->driver.devclass = &tty_devclass;
 
 	retval = driver_register(&device->driver);
 
diff -Nru a/include/linux/tty.h b/include/linux/tty.h
--- a/include/linux/tty.h	Tue Apr 22 13:07:48 2003
+++ b/include/linux/tty.h	Tue Apr 22 13:07:48 2003
@@ -243,6 +243,7 @@
 #define L_PENDIN(tty)	_L_FLAG((tty),PENDIN)
 #define L_IEXTEN(tty)	_L_FLAG((tty),IEXTEN)
 
+struct device;
 /*
  * Where all of the state associated with a tty is kept while the tty
  * is open.  Since the termios state should be kept even if the tty
@@ -378,7 +379,7 @@
 extern int tty_register_ldisc(int disc, struct tty_ldisc *new_ldisc);
 extern int tty_register_driver(struct tty_driver *driver);
 extern int tty_unregister_driver(struct tty_driver *driver);
-extern void tty_register_device(struct tty_driver *driver, unsigned minor);
+extern void tty_register_device(struct tty_driver *driver, unsigned minor, struct device *dev);
 extern void tty_unregister_device(struct tty_driver *driver, unsigned minor);
 extern int tty_read_raw_data(struct tty_struct *tty, unsigned char *bufp,
 			     int buflen);
diff -Nru a/include/linux/tty_driver.h b/include/linux/tty_driver.h
--- a/include/linux/tty_driver.h	Tue Apr 22 13:07:53 2003
+++ b/include/linux/tty_driver.h	Tue Apr 22 13:07:53 2003
@@ -231,6 +231,4 @@
 #define SERIAL_TYPE_NORMAL	1
 #define SERIAL_TYPE_CALLOUT	2
 
-extern struct device_class tty_devclass;
-
 #endif /* #ifdef _LINUX_TTY_DRIVER_H */
