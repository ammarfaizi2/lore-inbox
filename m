Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263544AbSLEQ3g>; Thu, 5 Dec 2002 11:29:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264638AbSLEQ3f>; Thu, 5 Dec 2002 11:29:35 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:14864 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S263544AbSLEQ2U>;
	Thu, 5 Dec 2002 11:28:20 -0500
Date: Thu, 5 Dec 2002 08:35:42 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [PATCH] LSM changes for 2.5.50
Message-ID: <20021205163541.GF2865@kroah.com>
References: <20021205163152.GA2865@kroah.com> <20021205163234.GB2865@kroah.com> <20021205163300.GC2865@kroah.com> <20021205163339.GD2865@kroah.com> <20021205163406.GE2865@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021205163406.GE2865@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.797.142.4, 2002/12/04 16:56:51-06:00, greg@kroah.com

LSM: add the example rootplug module


diff -Nru a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
--- a/drivers/usb/core/hcd.c	Thu Dec  5 01:19:10 2002
+++ b/drivers/usb/core/hcd.c	Thu Dec  5 01:19:10 2002
@@ -80,6 +80,7 @@
 
 /* host controllers we manage */
 LIST_HEAD (usb_bus_list);
+EXPORT_SYMBOL (usb_bus_list);
 
 /* used when allocating bus numbers */
 #define USB_MAXBUS		64
@@ -90,6 +91,7 @@
 
 /* used when updating list of hcds */
 DECLARE_MUTEX (usb_bus_list_lock);	/* exported only for usbfs */
+EXPORT_SYMBOL (usb_bus_list_lock);
 
 /* used when updating hcd data */
 static spinlock_t hcd_data_lock = SPIN_LOCK_UNLOCKED;
diff -Nru a/security/Kconfig b/security/Kconfig
--- a/security/Kconfig	Thu Dec  5 01:19:10 2002
+++ b/security/Kconfig	Thu Dec  5 01:19:10 2002
@@ -22,5 +22,15 @@
 	  This enables the "default" Linux capabilities functionality.
 	  If you are unsure how to answer this question, answer Y.
 
+config SECURITY_ROOTPLUG
+	tristate "Root Plug Support"
+	depends on SECURITY!=n
+	help
+	  This is a sample LSM module that should only be used as such.
+	  It enables control over processes being created by root users
+	  if a specific USB device is not present in the system.
+	  
+	  If you are unsure how to answer this question, answer N.
+
 endmenu
 
diff -Nru a/security/Makefile b/security/Makefile
--- a/security/Makefile	Thu Dec  5 01:19:10 2002
+++ b/security/Makefile	Thu Dec  5 01:19:10 2002
@@ -13,5 +13,6 @@
 # Object file lists
 obj-$(CONFIG_SECURITY)			+= security.o dummy.o
 obj-$(CONFIG_SECURITY_CAPABILITIES)	+= capability.o
+obj-$(CONFIG_SECURITY_ROOTPLUG)		+= root_plug.o
 
 include $(TOPDIR)/Rules.make
diff -Nru a/security/root_plug.c b/security/root_plug.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/security/root_plug.c	Thu Dec  5 01:19:10 2002
@@ -0,0 +1,189 @@
+/*
+ * Root Plug sample LSM module
+ *
+ * Originally written for a Linux Journal.
+ *
+ * Copyright (C) 2002 Greg Kroah-Hartman <greg@kroah.com>
+ *
+ * Prevents any programs running with egid == 0 if a specific USB device
+ * is not present in the system.  Yes, it can be gotten around, but is a
+ * nice starting point for people to play with, and learn the LSM
+ * interface.
+ *
+ * If you want to turn this into something with a semblance of security,
+ * you need to hook the task_* functions also.
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License as
+ *	published by the Free Software Foundation, version 2 of the
+ *	License.
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/security.h>
+#include <linux/usb.h>
+
+/* flag to keep track of how we were registered */
+static int secondary;
+
+/* default is a generic type of usb to serial converter */
+static int vendor_id = 0x0557;
+static int product_id = 0x2008;
+
+MODULE_PARM(vendor_id, "h");
+MODULE_PARM_DESC(vendor_id, "USB Vendor ID of device to look for");
+
+MODULE_PARM(product_id, "h");
+MODULE_PARM_DESC(product_id, "USB Product ID of device to look for");
+
+/* should we print out debug messages */
+static int debug = 0;
+
+MODULE_PARM(debug, "i");
+MODULE_PARM_DESC(debug, "Debug enabled or not");
+
+#if defined(CONFIG_SECURITY_ROOTPLUG_MODULE)
+#define MY_NAME THIS_MODULE->name
+#else
+#define MY_NAME "root_plug"
+#endif
+
+#define dbg(fmt, arg...)					\
+	do {							\
+		if (debug)					\
+			printk(KERN_DEBUG "%s: %s: " fmt ,	\
+				MY_NAME , __FUNCTION__ , 	\
+				## arg);			\
+	} while (0)
+
+extern struct list_head usb_bus_list;
+extern struct semaphore usb_bus_list_lock;
+
+static int match_device (struct usb_device *dev)
+{
+	int retval = -ENODEV;
+	int child;
+
+	dbg ("looking at vendor %d, product %d\n",
+	     dev->descriptor.idVendor,
+	     dev->descriptor.idProduct);
+
+	/* see if this device matches */
+	if ((dev->descriptor.idVendor == vendor_id) &&
+	    (dev->descriptor.idProduct == product_id)) {
+		dbg ("found the device!\n");
+		retval = 0;
+		goto exit;
+	}
+
+	/* look through all of the children of this device */
+	for (child = 0; child < dev->maxchild; ++child) {
+		if (dev->children[child]) {
+			retval = match_device (dev->children[child]);
+			if (retval == 0)
+				goto exit;
+		}
+	}
+exit:
+	return retval;
+}
+
+static int find_usb_device (void)
+{
+	struct list_head *buslist;
+	struct usb_bus *bus;
+	int retval = -ENODEV;
+	
+	down (&usb_bus_list_lock);
+	for (buslist = usb_bus_list.next;
+	     buslist != &usb_bus_list; 
+	     buslist = buslist->next) {
+		bus = container_of (buslist, struct usb_bus, bus_list);
+		retval = match_device(bus->root_hub);
+		if (retval == 0)
+			goto exit;
+	}
+exit:
+	up (&usb_bus_list_lock);
+	return retval;
+}
+	
+
+static int rootplug_bprm_check_security (struct linux_binprm *bprm)
+{
+	dbg ("file %s, e_uid = %d, e_gid = %d\n",
+	     bprm->filename, bprm->e_uid, bprm->e_gid);
+
+	if (bprm->e_gid == 0) {
+		if (find_usb_device() != 0) {
+			dbg ("e_gid = 0, and device not found, "
+				"task not allowed to run...\n");
+			return -EPERM;
+		}
+	}
+
+	return 0;
+}
+
+static struct security_operations rootplug_security_ops = {
+	/* Use the capability functions for some of the hooks */
+	.ptrace =			cap_ptrace,
+	.capget =			cap_capget,
+	.capset_check =			cap_capset_check,
+	.capset_set =			cap_capset_set,
+	.capable =			cap_capable,
+
+	.bprm_compute_creds =		cap_bprm_compute_creds,
+	.bprm_set_security =		cap_bprm_set_security,
+
+	.task_post_setuid =		cap_task_post_setuid,
+	.task_kmod_set_label =		cap_task_kmod_set_label,
+	.task_reparent_to_init =	cap_task_reparent_to_init,
+
+	.bprm_check_security =		rootplug_bprm_check_security,
+};
+
+static int __init rootplug_init (void)
+{
+	/* register ourselves with the security framework */
+	if (register_security (&rootplug_security_ops)) {
+		printk (KERN_INFO 
+			"Failure registering Root Plug module with the kernel\n");
+		/* try registering with primary module */
+		if (mod_reg_security (MY_NAME, &rootplug_security_ops)) {
+			printk (KERN_INFO "Failure registering Root Plug "
+				" module with primary security module.\n");
+			return -EINVAL;
+		}
+		secondary = 1;
+	}
+	printk (KERN_INFO "Root Plug module initialized, "
+		"vendor_id = %4.4x, product id = %4.4x\n", vendor_id, product_id);
+	return 0;
+}
+
+static void __exit rootplug_exit (void)
+{
+	/* remove ourselves from the security framework */
+	if (secondary) {
+		if (mod_unreg_security (MY_NAME, &rootplug_security_ops))
+			printk (KERN_INFO "Failure unregistering Root Plug "
+				" module with primary module.\n");
+	} else { 
+		if (unregister_security (&rootplug_security_ops)) {
+			printk (KERN_INFO "Failure unregistering Root Plug "
+				"module with the kernel\n");
+		}
+	}
+	printk (KERN_INFO "Root Plug module removed\n");
+}
+
+module_init (rootplug_init);
+module_exit (rootplug_exit);
+
+MODULE_DESCRIPTION("Root Plug sample LSM module, written for Linux Journal article");
+MODULE_LICENSE("GPL");
+
