Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261425AbSIZRpQ>; Thu, 26 Sep 2002 13:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261426AbSIZRpQ>; Thu, 26 Sep 2002 13:45:16 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:60426 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261425AbSIZRpI>;
	Thu, 26 Sep 2002 13:45:08 -0400
Date: Thu, 26 Sep 2002 10:48:58 -0700
From: Greg KH <greg@kroah.com>
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: Patrick Mochel <mochel@osdl.org>
Subject: [RFC] consolidate /sbin/hotplug call for pci and usb - take 2
Message-ID: <20020926174858.GA5988@kroah.com>
References: <20020925212955.GA32487@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020925212955.GA32487@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, here's an updated version of the previous patch I sent out, that
address all of the different comments that I received.  It also has the
previously mentioned bug fixed.  It is against a clean 2.5.38 kernel.

I changed the sprintf() calls to snprintf() and if people would check my
math, I would appreciate it :)

This works for me on both PCI Hotplug and USB systems.  If there are no
complaints about it, I'll send it on to Linus.

Again, comments appreciated.

thanks,

greg k-h


diff -Nru a/drivers/base/Makefile b/drivers/base/Makefile
--- a/drivers/base/Makefile	Thu Sep 26 10:41:08 2002
+++ b/drivers/base/Makefile	Thu Sep 26 10:41:08 2002
@@ -5,6 +5,8 @@
 
 obj-y		+= fs/
 
+obj-$(CONFIG_HOTPLUG)	+= hotplug.o
+
 export-objs	:= core.o power.o sys.o bus.o driver.o \
 			class.o intf.o
 
diff -Nru a/drivers/base/base.h b/drivers/base/base.h
--- a/drivers/base/base.h	Thu Sep 26 10:41:08 2002
+++ b/drivers/base/base.h	Thu Sep 26 10:41:08 2002
@@ -50,3 +50,13 @@
 
 extern int driver_attach(struct device_driver * drv);
 extern void driver_detach(struct device_driver * drv);
+
+#ifdef CONFIG_HOTPLUG
+extern int dev_hotplug(struct device *dev, const char *action);
+#else
+static inline int dev_hotplug(struct device *dev, const char *action)
+{
+	return 0;
+}
+#endif
+
diff -Nru a/drivers/base/core.c b/drivers/base/core.c
--- a/drivers/base/core.c	Thu Sep 26 10:41:08 2002
+++ b/drivers/base/core.c	Thu Sep 26 10:41:08 2002
@@ -198,6 +198,9 @@
 	if (platform_notify)
 		platform_notify(dev);
 
+	/* notify userspace of device entry */
+	dev_hotplug(dev, "add");
+
  register_done:
 	if (error) {
 		spin_lock(&device_lock);
@@ -252,6 +255,9 @@
 	 */
 	if (platform_notify_remove)
 		platform_notify_remove(dev);
+
+	/* notify userspace that this device is about to disappear */
+	dev_hotplug (dev, "remove");
 
 	device_detach(dev);
 	bus_remove_device(dev);
diff -Nru a/drivers/base/hotplug.c b/drivers/base/hotplug.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/base/hotplug.c	Thu Sep 26 10:41:08 2002
@@ -0,0 +1,98 @@
+/*
+ * drivers/base/hotplug.c - hotplug call code
+ * 
+ * Copyright (c) 2002 Greg Kroah-Hartman <greg@kroah.com>
+ *		 2002 IBM Corp.
+ */
+
+#define DEBUG 0
+
+#include <linux/device.h>
+#include <linux/slab.h>
+#include <linux/err.h>
+#include <linux/kmod.h>
+#include <linux/interrupt.h>
+#include "base.h"
+
+/*
+ * hotplugging invokes what /proc/sys/kernel/hotplug says (normally
+ * /sbin/hotplug) when devices get added or removed.
+ *
+ * This invokes a user mode policy agent, typically helping to load driver
+ * or other modules, configure the device, and more.  Drivers can provide
+ * a MODULE_DEVICE_TABLE to help with module loading subtasks.
+ */
+#define BUFFER_SIZE	1024	/* should be enough memory for the env */
+#define NUM_ENVP	32	/* number of env pointers */
+int dev_hotplug (struct device *dev, const char *action)
+{
+	char *argv [3], **envp, *buffer, *scratch;
+	int retval;
+	int i = 0;
+
+	pr_debug ("%s\n", __FUNCTION__);
+	if (!dev)
+		return -ENODEV;
+
+	if (!dev->bus || !dev->bus->hotplug)
+		return -ENODEV;
+
+	if (!hotplug_path [0])
+		return -ENODEV;
+
+	if (in_interrupt ()) {
+		pr_debug ("%s - in_interrupt, not allowed!", __FUNCTION__);
+		return -EIO;
+	}
+
+	if (!current->fs->root) {
+		/* don't try to do anything unless we have a root partition */
+		pr_debug ("%s - %s -- no FS yet\n", __FUNCTION__, action);
+		return -EIO;
+	}
+
+	envp = (char **) kmalloc (NUM_ENVP * sizeof (char *), GFP_KERNEL);
+	if (!envp)
+		return -ENOMEM;
+
+	buffer = kmalloc (BUFFER_SIZE, GFP_KERNEL);
+	if (!buffer) {
+		kfree (envp);
+		return -ENOMEM;
+	}
+
+	/* only one standardized param to hotplug command: the bus name */
+	argv [0] = hotplug_path;
+	argv [1] = dev->bus->name;
+	argv [2] = 0;
+
+	/* minimal command environment */
+	envp [i++] = "HOME=/";
+	envp [i++] = "PATH=/sbin:/bin:/usr/sbin:/usr/bin";
+
+	scratch = buffer;
+
+	/* action:  add, remove */
+	envp [i++] = scratch;
+	scratch += sprintf (scratch, "ACTION=%s", action) + 1;
+
+	/* have the bus specific function set up the rest of the environment */
+	retval = dev->bus->hotplug (dev, &envp[i], NUM_ENVP - i,
+				    scratch, BUFFER_SIZE - (scratch - buffer));
+	if (retval) {
+		pr_debug ("%s - hotplug() returned %d\n", __FUNCTION__, retval);
+		goto exit;
+	}
+
+	pr_debug ("%s: %s %s %s %s %s %s\n", __FUNCTION__, argv [0], argv[1],
+		  action, envp[0], envp[1], envp[2]);
+	retval = call_usermodehelper (argv [0], argv, envp);
+	if (retval)
+		pr_debug ("%s - call_usermodehelper returned %d\n",
+			  __FUNCTION__, retval);
+
+exit:
+	kfree (buffer);
+	kfree (envp);
+	return retval;
+}
diff -Nru a/drivers/pci/hotplug.c b/drivers/pci/hotplug.c
--- a/drivers/pci/hotplug.c	Thu Sep 26 10:41:08 2002
+++ b/drivers/pci/hotplug.c	Thu Sep 26 10:41:08 2002
@@ -1,52 +1,68 @@
 #include <linux/pci.h>
 #include <linux/module.h>
-#include <linux/kmod.h>		/* for hotplug_path */
+#include "pci.h"
 
-#ifndef FALSE
-#define FALSE	(0)
-#define TRUE	(!FALSE)
-#endif
 
 #ifdef CONFIG_HOTPLUG
-static void run_sbin_hotplug(struct pci_dev *pdev, int insert)
+int pci_hotplug (struct device *dev, char **envp, int num_envp,
+		 char *buffer, int buffer_size)
 {
-	int i;
-	char *argv[3], *envp[8];
-	char id[20], sub_id[24], bus_id[24], class_id[20];
-
-	if (!hotplug_path[0])
-		return;
+	struct pci_dev *pdev;
+	char *scratch;
+	int i = 0;
+	int length = 0;
+
+	if (!dev)
+		return -ENODEV;
+
+	pdev = to_pci_dev(dev);
+	if (!pdev)
+		return -ENODEV;
+
+	scratch = buffer;
+
+	/* stuff we want to pass to /sbin/hotplug */
+	envp[i++] = scratch;
+	length += snprintf (scratch, buffer_size - length, "PCI_CLASS=%04X",
+			    pdev->class);
+	if ((buffer_size - length <= 0) || (i >= num_envp))
+		return -ENOMEM;
+	++length;
+	scratch += length;
+
+	envp[i++] = scratch;
+	length += snprintf (scratch, buffer_size - length, "PCI_ID=%04X:%04X",
+			    pdev->vendor, pdev->device);
+	if ((buffer_size - length <= 0) || (i >= num_envp))
+		return -ENOMEM;
+	++length;
+	scratch += length;
+
+	envp[i++] = scratch;
+	length += snprintf (scratch, buffer_size - length,
+			    "PCI_SUBSYS_ID=%04X:%04X", pdev->subsystem_vendor,
+			    pdev->subsystem_device);
+	if ((buffer_size - length <= 0) || (i >= num_envp))
+		return -ENOMEM;
+	++length;
+	scratch += length;
+
+	envp[i++] = scratch;
+	length += snprintf (scratch, buffer_size - length, "PCI_SLOT_NAME=%s",
+			    pdev->slot_name);
+	if ((buffer_size - length <= 0) || (i >= num_envp))
+		return -ENOMEM;
 
-	sprintf(class_id, "PCI_CLASS=%04X", pdev->class);
-	sprintf(id, "PCI_ID=%04X:%04X", pdev->vendor, pdev->device);
-	sprintf(sub_id, "PCI_SUBSYS_ID=%04X:%04X", pdev->subsystem_vendor, pdev->subsystem_device);
-	sprintf(bus_id, "PCI_SLOT_NAME=%s", pdev->slot_name);
-
-	i = 0;
-	argv[i++] = hotplug_path;
-	argv[i++] = "pci";
-	argv[i] = 0;
-
-	i = 0;
-	/* minimal command environment */
-	envp[i++] = "HOME=/";
-	envp[i++] = "PATH=/sbin:/bin:/usr/sbin:/usr/bin";
-	
-	/* other stuff we want to pass to /sbin/hotplug */
-	envp[i++] = class_id;
-	envp[i++] = id;
-	envp[i++] = sub_id;
-	envp[i++] = bus_id;
-	if (insert)
-		envp[i++] = "ACTION=add";
-	else
-		envp[i++] = "ACTION=remove";
 	envp[i] = 0;
 
-	call_usermodehelper (argv [0], argv, envp);
+	return 0;
 }
 #else
-static void run_sbin_hotplug(struct pci_dev *pdev, int insert) { }
+int pci_hotplug (struct device *dev, char **envp, int num_envp,
+		 char *buffer, int buffer_size)
+{
+	return -ENODEV;
+}
 #endif
 
 /**
@@ -66,8 +82,6 @@
 #ifdef CONFIG_PROC_FS
 	pci_proc_attach_device(dev);
 #endif
-	/* notify userspace of new hotplug device */
-	run_sbin_hotplug(dev, TRUE);
 }
 
 static void
@@ -99,8 +113,6 @@
 #ifdef CONFIG_PROC_FS
 	pci_proc_detach_device(dev);
 #endif
-	/* notify userspace of hotplug device removal */
-	run_sbin_hotplug(dev, FALSE);
 }
 
 #ifdef CONFIG_HOTPLUG
diff -Nru a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
--- a/drivers/pci/pci-driver.c	Thu Sep 26 10:41:08 2002
+++ b/drivers/pci/pci-driver.c	Thu Sep 26 10:41:08 2002
@@ -6,6 +6,7 @@
 #include <linux/pci.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include "pci.h"
 
 /*
  *  Registration of PCI drivers and handling of hot-pluggable devices.
@@ -199,8 +200,9 @@
 }
 
 struct bus_type pci_bus_type = {
-	name:	"pci",
-	match:	pci_bus_match,
+	name:		"pci",
+	match:		pci_bus_match,
+	hotplug:	pci_hotplug,
 };
 
 static int __init pci_driver_init(void)
diff -Nru a/drivers/pci/pci.h b/drivers/pci/pci.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/pci/pci.h	Thu Sep 26 10:41:08 2002
@@ -0,0 +1,5 @@
+/* Functions internal to the PCI core code */
+
+extern int pci_hotplug (struct device *dev, char **envp, int num_envp,
+			 char *buffer, int buffer_size);
+
diff -Nru a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
--- a/drivers/usb/core/usb.c	Thu Sep 26 10:41:08 2002
+++ b/drivers/usb/core/usb.c	Thu Sep 26 10:41:08 2002
@@ -505,57 +505,42 @@
  * cases, we know no other thread can recycle our address, since we must
  * already have been serialized enough to prevent that.
  */
-static void call_policy (char *verb, struct usb_device *dev)
+static int usb_hotplug (struct device *dev, char **envp, int num_envp,
+			char *buffer, int buffer_size)
 {
-	char *argv [3], **envp, *buf, *scratch;
-	int i = 0, value;
+	struct usb_interface *intf;
+	struct usb_device *usb_dev;
+	char *scratch;
+	int i = 0;
+	int length = 0;
 
-	if (!hotplug_path [0])
-		return;
-	if (in_interrupt ()) {
-		dbg ("In_interrupt");
-		return;
-	}
-	if (!current->fs->root) {
-		/* statically linked USB is initted rather early */
-		dbg ("call_policy %s, num %d -- no FS yet", verb, dev->devnum);
-		return;
-	}
-	if (dev->devnum < 0) {
+	dbg ("%s", __FUNCTION__);
+
+	if (!dev)
+		return -ENODEV;
+
+	/* check for generic driver, we do not call do hotplug calls for it */
+	if (dev->driver == &usb_generic_driver)
+		return -ENODEV;
+
+	intf = to_usb_interface(dev);
+	if (!intf)
+		return -ENODEV;
+
+	usb_dev = interface_to_usbdev (intf);
+	if (!usb_dev)
+		return -ENODEV;
+	
+	if (usb_dev->devnum < 0) {
 		dbg ("device already deleted ??");
-		return;
+		return -ENODEV;
 	}
-	if (!(envp = (char **) kmalloc (20 * sizeof (char *), GFP_KERNEL))) {
-		dbg ("enomem");
-		return;
-	}
-	if (!(buf = kmalloc (256, GFP_KERNEL))) {
-		kfree (envp);
-		dbg ("enomem2");
-		return;
+	if (!usb_dev->bus) {
+		dbg ("bus already removed?");
+		return -ENODEV;
 	}
 
-	/* only one standardized param to hotplug command: type */
-	argv [0] = hotplug_path;
-	argv [1] = "usb";
-	argv [2] = 0;
-
-	/* minimal command environment */
-	envp [i++] = "HOME=/";
-	envp [i++] = "PATH=/sbin:/bin:/usr/sbin:/usr/bin";
-
-#ifdef	DEBUG
-	/* hint that policy agent should enter no-stdout debug mode */
-	envp [i++] = "DEBUG=kernel";
-#endif
-	/* extensible set of named bus-specific parameters,
-	 * supporting multiple driver selection algorithms.
-	 */
-	scratch = buf;
-
-	/* action:  add, remove */
-	envp [i++] = scratch;
-	scratch += sprintf (scratch, "ACTION=%s", verb) + 1;
+	scratch = buffer;
 
 #ifdef	CONFIG_USB_DEVICEFS
 	/* If this is available, userspace programs can directly read
@@ -564,27 +549,48 @@
 	 *
 	 * FIXME reduce hardwired intelligence here
 	 */
-	envp [i++] = "DEVFS=/proc/bus/usb";
 	envp [i++] = scratch;
-	scratch += sprintf (scratch, "DEVICE=/proc/bus/usb/%03d/%03d",
-		dev->bus->busnum, dev->devnum) + 1;
+	length += snprintf (scratch, buffer_size - length,
+			    "%s", "DEVFS=/proc/bus/usb");
+	if ((buffer_size - length <= 0) || (i >= num_envp))
+		return -ENOMEM;
+	++length;
+	scratch += length;
+
+	envp [i++] = scratch;
+	length += snprintf (scratch, buffer_size - length,
+			    "DEVICE=/proc/bus/usb/%03d/%03d",
+			    usb_dev->bus->busnum, usb_dev->devnum);
+	if ((buffer_size - length <= 0) || (i >= num_envp))
+		return -ENOMEM;
+	++length;
+	scratch += length;
 #endif
 
 	/* per-device configuration hacks are common */
 	envp [i++] = scratch;
-	scratch += sprintf (scratch, "PRODUCT=%x/%x/%x",
-		dev->descriptor.idVendor,
-		dev->descriptor.idProduct,
-		dev->descriptor.bcdDevice) + 1;
+	length += snprintf (scratch, buffer_size - length, "PRODUCT=%x/%x/%x",
+			    usb_dev->descriptor.idVendor,
+			    usb_dev->descriptor.idProduct,
+			    usb_dev->descriptor.bcdDevice);
+	if ((buffer_size - length <= 0) || (i >= num_envp))
+		return -ENOMEM;
+	++length;
+	scratch += length;
 
 	/* class-based driver binding models */
 	envp [i++] = scratch;
-	scratch += sprintf (scratch, "TYPE=%d/%d/%d",
-			    dev->descriptor.bDeviceClass,
-			    dev->descriptor.bDeviceSubClass,
-			    dev->descriptor.bDeviceProtocol) + 1;
-	if (dev->descriptor.bDeviceClass == 0) {
-		int alt = dev->actconfig->interface [0].act_altsetting;
+	length += snprintf (scratch, buffer_size - length, "TYPE=%d/%d/%d",
+			    usb_dev->descriptor.bDeviceClass,
+			    usb_dev->descriptor.bDeviceSubClass,
+			    usb_dev->descriptor.bDeviceProtocol);
+	if ((buffer_size - length <= 0) || (i >= num_envp))
+		return -ENOMEM;
+	++length;
+	scratch += length;
+
+	if (usb_dev->descriptor.bDeviceClass == 0) {
+		int alt = intf->act_altsetting;
 
 		/* a simple/common case: one config, one interface, one driver
 		 * with current altsetting being a reasonable setting.
@@ -592,31 +598,29 @@
 		 * device-specific binding policies.
 		 */
 		envp [i++] = scratch;
-		scratch += sprintf (scratch, "INTERFACE=%d/%d/%d",
-			dev->actconfig->interface [0].altsetting [alt].bInterfaceClass,
-			dev->actconfig->interface [0].altsetting [alt].bInterfaceSubClass,
-			dev->actconfig->interface [0].altsetting [alt].bInterfaceProtocol)
-			+ 1;
-		/* INTERFACE-0, INTERFACE-1, ... ? */
+		length += snprintf (scratch, buffer_size - length,
+				    "INTERFACE=%d/%d/%d",
+				    intf->altsetting[alt].bInterfaceClass,
+				    intf->altsetting[alt].bInterfaceSubClass,
+				    intf->altsetting[alt].bInterfaceProtocol);
+		if ((buffer_size - length <= 0) || (i >= num_envp))
+			return -ENOMEM;
+		++length;
+		scratch += length;
+
 	}
 	envp [i++] = 0;
-	/* assert: (scratch - buf) < sizeof buf */
 
-	/* NOTE: user mode daemons can call the agents too */
-
-	dbg ("kusbd: %s %s %d", argv [0], verb, dev->devnum);
-	value = call_usermodehelper (argv [0], argv, envp);
-	kfree (buf);
-	kfree (envp);
-	if (value != 0)
-		dbg ("kusbd policy returned 0x%x", value);
+	return 0;
 }
 
 #else
 
-static inline void
-call_policy (char *verb, struct usb_device *dev)
-{ } 
+static int usb_hotplug (struct device *dev, char **envp,
+			char *buffer, int buffer_size)
+{
+	return -ENODEV;
+}
 
 #endif	/* CONFIG_HOTPLUG */
 
@@ -889,9 +893,6 @@
 		put_device(&dev->dev);
 	}
 
-	/* Let policy agent unload modules etc */
-	call_policy ("remove", dev);
-
 	/* Decrement the reference count, it'll auto free everything when */
 	/* it hits 0 which could very well be now */
 	usb_put_dev(dev);
@@ -1169,9 +1170,6 @@
 	/* add a /proc/bus/usb entry */
 	usbfs_add_device(dev);
 
-	/* userspace may load modules and/or configure further */
-	call_policy ("add", dev);
-
 	return 0;
 }
 
@@ -1434,6 +1432,7 @@
 struct bus_type usb_bus_type = {
 	.name =		"usb",
 	.match =	usb_device_match,
+	.hotplug =	usb_hotplug,
 };
 
 /*
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	Thu Sep 26 10:41:08 2002
+++ b/include/linux/device.h	Thu Sep 26 10:41:08 2002
@@ -67,6 +67,8 @@
 
 	int		(*match)(struct device * dev, struct device_driver * drv);
 	struct device * (*add)	(struct device * parent, char * bus_id);
+	int		(*hotplug) (struct device *dev, char **envp, 
+				    int num_envp, char *buffer, int buffer_size);
 };
 
 
