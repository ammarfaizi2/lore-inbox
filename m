Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262604AbSI0Tm7>; Fri, 27 Sep 2002 15:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262605AbSI0TmL>; Fri, 27 Sep 2002 15:42:11 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:6926 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262604AbSI0Tkl>;
	Fri, 27 Sep 2002 15:40:41 -0400
Date: Fri, 27 Sep 2002 12:44:21 -0700
From: Greg KH <greg@kroah.com>
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] More USB changes for 2.5.38
Message-ID: <20020927194420.GJ12909@kroah.com>
References: <20020927193723.GA12909@kroah.com> <20020927193855.GB12909@kroah.com> <20020927194025.GC12909@kroah.com> <20020927194054.GD12909@kroah.com> <20020927194240.GE12909@kroah.com> <20020927194258.GF12909@kroah.com> <20020927194314.GG12909@kroah.com> <20020927194330.GH12909@kroah.com> <20020927194353.GI12909@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020927194353.GI12909@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.611.1.8 -> 1.611.1.9
#	drivers/usb/core/usb.c	1.87    -> 1.88   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/27	greg@kroah.com	1.611.1.9
# converted USB to use the driver core's hotplug call.
# --------------------------------------------
#
diff -Nru a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
--- a/drivers/usb/core/usb.c	Fri Sep 27 12:30:06 2002
+++ b/drivers/usb/core/usb.c	Fri Sep 27 12:30:06 2002
@@ -510,57 +510,42 @@
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
@@ -569,27 +554,48 @@
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
@@ -597,31 +603,29 @@
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
 
@@ -894,9 +898,6 @@
 		put_device(&dev->dev);
 	}
 
-	/* Let policy agent unload modules etc */
-	call_policy ("remove", dev);
-
 	/* Decrement the reference count, it'll auto free everything when */
 	/* it hits 0 which could very well be now */
 	usb_put_dev(dev);
@@ -1174,9 +1175,6 @@
 	/* add a /proc/bus/usb entry */
 	usbfs_add_device(dev);
 
-	/* userspace may load modules and/or configure further */
-	call_policy ("add", dev);
-
 	return 0;
 }
 
@@ -1439,6 +1437,7 @@
 struct bus_type usb_bus_type = {
 	.name =		"usb",
 	.match =	usb_device_match,
+	.hotplug =	usb_hotplug,
 };
 
 /*
