Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262132AbUKDHuu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262132AbUKDHuu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 02:50:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262125AbUKDHtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 02:49:15 -0500
Received: from [211.58.254.17] ([211.58.254.17]:25512 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S262131AbUKDHqd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 02:46:33 -0500
Date: Thu, 4 Nov 2004 16:46:28 +0900
From: Tejun Heo <tj@home-tj.org>
To: rusty@rustcorp.com.au, mochel@osdl.org, greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.10-rc1 4/4] driver-model: attach/detach sysfs node implemented
Message-ID: <20041104074628.GK25567@home-tj.org>
References: <20041104074330.GG25567@home-tj.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041104074330.GG25567@home-tj.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 ma_04_manual_attach.patch

 This patch implements device interface nodes attach and detach.
Reading attach node shows the name of applicable drivers.  Writing a
driver name attaches the device to the driver.  Writing anything to
the write-only detach node detaches the driver from the currently
associated driver.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-export/drivers/base/interface.c
===================================================================
--- linux-export.orig/drivers/base/interface.c	2004-11-04 11:04:15.000000000 +0900
+++ linux-export/drivers/base/interface.c	2004-11-04 11:04:15.000000000 +0900
@@ -13,6 +13,7 @@
 #include <linux/err.h>
 #include <linux/stat.h>
 #include <linux/string.h>
+#include <linux/ctype.h>
 
 /**
  *	detach_state - control the default power state for the device.
@@ -46,7 +47,113 @@ static ssize_t detach_state_store(struct
 static DEVICE_ATTR(detach_state, 0644, detach_state_show, detach_state_store);
 
 
+/**
+ *	attach - manually attaches the device to the specified driver
+ *
+ *	When read, this node shows the list of the attachable drivers.
+ *	Writing the name of a driver attaches the device to the
+ *	driver.
+ */
+
+struct attach_show_arg {
+	struct device * dev;
+	char * buf;
+	size_t left;
+};
+
+static int attach_show_helper(struct device_driver * drv, void * void_arg)
+{
+	struct attach_show_arg * arg = void_arg;
+	int ret;
+
+	if (drv->bus->match(arg->dev, drv)) {
+		ret = snprintf(arg->buf, arg->left, "%s\n", drv->name);
+		if (ret >= arg->left)
+			return -ENOSPC;
+		arg->buf += ret;
+		arg->left -= ret;
+	}
+
+	return 0;
+}
+
+static ssize_t attach_show(struct device * dev, char * buf)
+{
+	struct attach_show_arg arg = { dev, buf, PAGE_SIZE };
+	int ret = 0;
+
+	if (dev->bus->match)
+		ret = bus_for_each_drv(dev->bus, NULL, &arg, attach_show_helper);
+
+	return ret ?: PAGE_SIZE - arg.left;
+}
+
+static int attach_store_helper(struct device_driver * drv, void * arg)
+{
+	const char * p = *(void **)arg;
+	int len;
+
+	len = strlen(drv->name);
+	if (!strncmp(drv->name, p, len) &&
+	    (p[len] == '\0' || isspace(p[len]))) {
+		*(void **)(arg) = get_driver(drv);
+		return 1;
+	}
+
+	return 0;
+}
+
+static ssize_t attach_store(struct device * dev, const char * buf, size_t n)
+{
+	void * arg = (void *)buf;
+	struct device_driver *drv;
+	int error;
+
+	if (bus_for_each_drv(dev->bus, NULL, &arg, attach_store_helper) == 0)
+		return -ENOENT;
+	drv = arg;
+
+	/* Skip driver name */
+	while (*buf != '\0' && !isspace(*buf))
+		buf++;
+
+	/* Attach */
+	error = -EBUSY;
+	down_write(&dev->bus->subsys.rwsem);
+	if (dev->driver == NULL)
+		error = driver_probe_device(drv, dev, buf);
+	up_write(&dev->bus->subsys.rwsem);
+
+	if (error)
+		printk(KERN_WARNING "%s: probe of %s failed with error %d\n",
+		       drv->name, dev->bus_id, error);
+
+	return error ?: n;
+}
+
+static DEVICE_ATTR(attach, 0644, attach_show, attach_store);
+
+
+/**
+ *	detach - manually detaches the device from its associated driver.
+ *
+ *	This is a write-only node.  When any value is written, it detaches
+ *	the device from its associated driver.
+ */
+static ssize_t detach_store(struct device * dev, const char * buf, size_t n)
+{
+	down_write(&dev->bus->subsys.rwsem);
+	device_release_driver(dev);
+	up_write(&dev->bus->subsys.rwsem);
+	return n;
+}
+
+static DEVICE_ATTR(detach, 0200, NULL, detach_store);
+
+
 struct attribute * dev_default_attrs[] = {
 	&dev_attr_detach_state.attr,
+	&dev_attr_attach.attr,
+	&dev_attr_detach.attr,
 	NULL,
 };
