Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261412AbSJAAbC>; Mon, 30 Sep 2002 20:31:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261413AbSJAAbC>; Mon, 30 Sep 2002 20:31:02 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:2822 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261412AbSJAAav>;
	Mon, 30 Sep 2002 20:30:51 -0400
Date: Mon, 30 Sep 2002 17:34:01 -0700
From: Greg KH <greg@kroah.com>
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] USB changes for 2.5.39
Message-ID: <20021001003401.GD3994@kroah.com>
References: <20021001003104.GA3994@kroah.com> <20021001003240.GB3994@kroah.com> <20021001003304.GC3994@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021001003304.GC3994@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.660.1.2 -> 1.660.1.3
#	drivers/base/hotplug.c	1.1     -> 1.2    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/30	greg@kroah.com	1.660.1.3
# driver core: added location of device in driverfs tree to /sbin/hotplug call.
# 
# /sbin/hotplug is now called when any device is added or removed from the
# system.
# --------------------------------------------
#
diff -Nru a/drivers/base/hotplug.c b/drivers/base/hotplug.c
--- a/drivers/base/hotplug.c	Mon Sep 30 17:25:55 2002
+++ b/drivers/base/hotplug.c	Mon Sep 30 17:25:55 2002
@@ -18,6 +18,7 @@
 #include <linux/kmod.h>
 #include <linux/interrupt.h>
 #include "base.h"
+#include "fs/fs.h"
 
 /*
  * hotplugging invokes what /proc/sys/kernel/hotplug says (normally
@@ -32,14 +33,16 @@
 int dev_hotplug (struct device *dev, const char *action)
 {
 	char *argv [3], **envp, *buffer, *scratch;
+	char *dev_path;
 	int retval;
 	int i = 0;
+	int dev_length;
 
 	pr_debug ("%s\n", __FUNCTION__);
 	if (!dev)
 		return -ENODEV;
 
-	if (!dev->bus || !dev->bus->hotplug)
+	if (!dev->bus)
 		return -ENODEV;
 
 	if (!hotplug_path [0])
@@ -66,6 +69,18 @@
 		return -ENOMEM;
 	}
 
+	dev_length = get_devpath_length (dev);
+	dev_length += strlen("root");
+	dev_path = kmalloc (dev_length, GFP_KERNEL);
+	if (!dev_path) {
+		kfree (buffer);
+		kfree (envp);
+		return -ENOMEM;
+	}
+	memset (dev_path, 0x00, dev_length);
+	strcpy (dev_path, "root");
+	fill_devpath (dev, dev_path, dev_length);
+
 	/* only one standardized param to hotplug command: the bus name */
 	argv [0] = hotplug_path;
 	argv [1] = dev->bus->name;
@@ -77,26 +92,33 @@
 
 	scratch = buffer;
 
-	/* action:  add, remove */
 	envp [i++] = scratch;
 	scratch += sprintf (scratch, "ACTION=%s", action) + 1;
 
-	/* have the bus specific function set up the rest of the environment */
-	retval = dev->bus->hotplug (dev, &envp[i], NUM_ENVP - i,
-				    scratch, BUFFER_SIZE - (scratch - buffer));
-	if (retval) {
-		pr_debug ("%s - hotplug() returned %d\n", __FUNCTION__, retval);
-		goto exit;
+	envp [i++] = scratch;
+	scratch += sprintf (scratch, "DEVICE=%s", dev_path) + 1;
+	
+	if (dev->bus->hotplug) {
+		/* have the bus specific function add its stuff */
+		retval = dev->bus->hotplug (dev, &envp[i], NUM_ENVP - i,
+					    scratch,
+					    BUFFER_SIZE - (scratch - buffer));
+		if (retval) {
+			pr_debug ("%s - hotplug() returned %d\n",
+				  __FUNCTION__, retval);
+			goto exit;
+		}
 	}
 
 	pr_debug ("%s: %s %s %s %s %s %s\n", __FUNCTION__, argv [0], argv[1],
-		  action, envp[0], envp[1], envp[2]);
+		  envp[0], envp[1], envp[2], envp[3]);
 	retval = call_usermodehelper (argv [0], argv, envp);
 	if (retval)
 		pr_debug ("%s - call_usermodehelper returned %d\n",
 			  __FUNCTION__, retval);
 
 exit:
+	kfree (dev_path);
 	kfree (buffer);
 	kfree (envp);
 	return retval;
