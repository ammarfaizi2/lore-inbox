Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262603AbSI0Tls>; Fri, 27 Sep 2002 15:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262605AbSI0Tkq>; Fri, 27 Sep 2002 15:40:46 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:5902 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262603AbSI0TkO>;
	Fri, 27 Sep 2002 15:40:14 -0400
Date: Fri, 27 Sep 2002 12:43:54 -0700
From: Greg KH <greg@kroah.com>
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] More USB changes for 2.5.38
Message-ID: <20020927194353.GI12909@kroah.com>
References: <20020927193723.GA12909@kroah.com> <20020927193855.GB12909@kroah.com> <20020927194025.GC12909@kroah.com> <20020927194054.GD12909@kroah.com> <20020927194240.GE12909@kroah.com> <20020927194258.GF12909@kroah.com> <20020927194314.GG12909@kroah.com> <20020927194330.GH12909@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020927194330.GH12909@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.611.1.7 -> 1.611.1.8
#	 drivers/base/core.c	1.39    -> 1.40   
#	drivers/base/Makefile	1.13    -> 1.14   
#	 drivers/base/base.h	1.12    -> 1.13   
#	include/linux/device.h	1.38    -> 1.39   
#	               (new)	        -> 1.1     drivers/base/hotplug.c
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/27	greg@kroah.com	1.611.1.8
# add hotplug support to the driver core for devices, if their bus type supports it.
# --------------------------------------------
#
diff -Nru a/drivers/base/Makefile b/drivers/base/Makefile
--- a/drivers/base/Makefile	Fri Sep 27 12:30:08 2002
+++ b/drivers/base/Makefile	Fri Sep 27 12:30:08 2002
@@ -6,6 +6,8 @@
 
 obj-y		+= fs/
 
+obj-$(CONFIG_HOTPLUG)	+= hotplug.o
+
 export-objs	:= core.o power.o sys.o bus.o driver.o \
 			class.o intf.o platform.o cpu.o 
 
diff -Nru a/drivers/base/base.h b/drivers/base/base.h
--- a/drivers/base/base.h	Fri Sep 27 12:30:08 2002
+++ b/drivers/base/base.h	Fri Sep 27 12:30:08 2002
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
--- a/drivers/base/core.c	Fri Sep 27 12:30:08 2002
+++ b/drivers/base/core.c	Fri Sep 27 12:30:08 2002
@@ -200,6 +200,9 @@
 	if (platform_notify)
 		platform_notify(dev);
 
+	/* notify userspace of device entry */
+	dev_hotplug(dev, "add");
+
  register_done:
 	if (error) {
 		spin_lock(&device_lock);
@@ -254,6 +257,9 @@
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
+++ b/drivers/base/hotplug.c	Fri Sep 27 12:30:08 2002
@@ -0,0 +1,103 @@
+/*
+ * drivers/base/hotplug.c - hotplug call code
+ * 
+ * Copyright (c) 2000-2001 David Brownell
+ * Copyright (c) 2002 Greg Kroah-Hartman
+ * Copyright (c) 2002 IBM Corp.
+ *
+ * Based off of drivers/usb/core/usb.c:call_agent(), which was 
+ * written by David Brownell.
+ *
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
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	Fri Sep 27 12:30:08 2002
+++ b/include/linux/device.h	Fri Sep 27 12:30:08 2002
@@ -67,6 +67,8 @@
 
 	int		(*match)(struct device * dev, struct device_driver * drv);
 	struct device * (*add)	(struct device * parent, char * bus_id);
+	int		(*hotplug) (struct device *dev, char **envp, 
+				    int num_envp, char *buffer, int buffer_size);
 };
 
 
