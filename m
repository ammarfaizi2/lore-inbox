Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262134AbUKDHss@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262134AbUKDHss (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 02:48:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262132AbUKDHsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 02:48:18 -0500
Received: from [211.58.254.17] ([211.58.254.17]:15784 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S262125AbUKDHpa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 02:45:30 -0500
Date: Thu, 4 Nov 2004 16:45:28 +0900
From: Tejun Heo <tj@home-tj.org>
To: rusty@rustcorp.com.au, mochel@osdl.org, greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.10-rc1 2/4] driver-model: devparam expanded to accept direct per-device parameters via @args argument
Message-ID: <20041104074528.GI25567@home-tj.org>
References: <20041104074330.GG25567@home-tj.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041104074330.GG25567@home-tj.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 ma_02_devparam_set_by_args.patch

 This patch implements set_devparams_by_args() and expands related
functions to accept an const char * @args argument.  This enables
setting per-device parameters directly from argument string rather
than from parameters stored while booting or loading modules.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-export/drivers/base/bus.c
===================================================================
--- linux-export.orig/drivers/base/bus.c	2004-11-04 14:40:01.000000000 +0900
+++ linux-export/drivers/base/bus.c	2004-11-04 14:40:01.000000000 +0900
@@ -287,7 +287,8 @@ void device_bind_driver(struct device * 
  *	If we find a match, we call @drv->probe(@dev) if it exists, and
  *	call device_bind_driver() above.
  */
-int driver_probe_device(struct device_driver * drv, struct device * dev)
+int driver_probe_device(struct device_driver * drv, struct device * dev,
+			const char *args)
 {
 	int error;
 
@@ -296,7 +297,7 @@ int driver_probe_device(struct device_dr
 
 	dev->driver = drv;
 
-	if ((error = devparam_set_params(dev)) != 0)
+	if ((error = devparam_set_params(dev, args)) != 0)
 		goto devparam_fail;
 
 	if (drv->probe) {
@@ -338,7 +339,7 @@ int device_attach(struct device * dev)
 	if (dev_autoattach && bus->match) {
 		list_for_each(entry, &bus->drivers.list) {
 			struct device_driver * drv = to_drv(entry);
-			error = driver_probe_device(drv, dev);
+			error = driver_probe_device(drv, dev, NULL);
 			if (!error)
 				/* success, driver matched */
 				return 1;
@@ -378,7 +379,7 @@ void driver_attach(struct device_driver 
 	list_for_each(entry, &bus->devices.list) {
 		struct device * dev = container_of(entry, struct device, bus_list);
 		if (!dev->driver) {
-			error = driver_probe_device(drv, dev);
+			error = driver_probe_device(drv, dev, NULL);
 			if (error && (error != -ENODEV))
 				/* driver matched but the probe failed */
 				printk(KERN_WARNING
Index: linux-export/drivers/base/deviceparam.c
===================================================================
--- linux-export.orig/drivers/base/deviceparam.c	2004-11-04 14:39:59.000000000 +0900
+++ linux-export/drivers/base/deviceparam.c	2004-11-04 14:40:01.000000000 +0900
@@ -9,6 +9,7 @@
 #include <linux/deviceparam.h>
 #include <linux/device.h>
 #include <linux/module.h>
+#include <linux/ctype.h>
 
 #if 0
 #define pdebug(fmt, args...) printk("[%-25s] " fmt, __FUNCTION__ , ##args)
@@ -800,27 +801,113 @@ static int set_devparams_by_storedparams
 	return 0;
 }
 
-int devparam_set_params(struct device *dev)
+static int set_devparams_by_args(struct device *dev, char *args)
 {
 	struct device_driver *drv = dev->driver;
+	int which, i, err;
+	long **bitmaps;
 	size_t size;
-	int which, ret;
 	struct device_paramset_def *setdef;
+	char *param, *val;
+
+	/* Allocate bitmaps */
+	err = -ENOMEM;
+
+	size = drv->nr_paramsets * sizeof(bitmaps[0]);
+	if (!(bitmaps = kmalloc(size, GFP_KERNEL)))
+		goto out;
+	memset(bitmaps, 0, size);
+
+	for_each_setdef(which, setdef, drv) {
+		size = ALIGN(setdef->nr_defs, 8) / 8;
+		if (!(bitmaps[which] = kmalloc(size, GFP_KERNEL)))
+			goto out;
+		memset(bitmaps[which], 0, size);
+	}
+
+	/* Okay, parse */
+	while (*args) {
+		int ret;
+		args = param_next_arg(args, &param, &val);
+		pdebug("param=\"%s\" val=\"%s\"\n", param, val);
+		ret = parse_one_devparam(param, param, val,
+					 drv, NULL, dev, bitmaps);
+		if (ret == -ENOENT)
+			printk(KERN_ERR "Device params: Unknown parameter "
+			       "`%s'\n", param);
+	}
+
+	/* Finalize */
+	for_each_setdef(which, setdef, drv) {
+		for (i = 0; i < setdef->nr_defs; i++) {
+			struct device_param_def *def = &setdef->defs[i];
+
+			if (test_bit(i, bitmaps[which]) || def->dfl == NULL)
+				continue;
+
+			err = call_set(def, NULL, dev->paramsets[which]);
+			if (err < 0)
+				goto out;
+		}
+	}
 
-	pdebug("invoked for %s\n", drv->name);
+	err = 0;
+
+ out:
+	if (bitmaps) {
+		for (i = 0; i < drv->nr_paramsets; i++)
+			kfree(bitmaps[i]);
+		kfree(bitmaps);
+	}
+	return err;
+}
+
+int devparam_set_params(struct device *dev, const char *args)
+{
+	struct device_driver *drv = dev->driver;
+	char *buf;
+	size_t size, args_len;
+	int which, ret;
+	struct device_paramset_def *setdef;
 
+	pdebug("invoked for %s args=\"%s\"\n", drv->name, args);
 	dev->paramsets = NULL;
 	dev->bus_paramset = NULL;
 	dev->paramset_idx = -1;
 
-	if (drv->nr_paramsets == 0)
+	/* Trim leading white spaces */
+	if (args) {
+		while (isspace(*args))
+			args++;
+	}
+
+	if (drv->nr_paramsets == 0) {
+		if (args && *args)
+			printk(KERN_ERR "Device params: %s does not take any "
+			       "device parameters\n", drv->name);
 		return 0;
+	}
 
 	size = drv->nr_paramsets * sizeof(void *);
-	if ((dev->paramsets = kmalloc(size, GFP_KERNEL)) == NULL)
+	args_len = args ? strlen(args) + 1 : 0;
+
+	dev->paramsets = kmalloc(size + args_len, GFP_KERNEL);
+	if (dev->paramsets == NULL)
 		return -ENOMEM;
+
 	memset(dev->paramsets, 0, size);
 
+	buf = NULL;
+	if (args) {
+		char *p;
+		buf = (char *)dev->paramsets + size;
+		memcpy(buf, args, args_len);
+		/* Trim tailing white spaces */
+		p = buf + args_len - 2;
+		while (p >= buf && isspace(*p))
+			*p-- = '\0';
+	}
+
 	for_each_setdef(which, setdef, drv) {
 		void *ps;
 		if ((ps = kmalloc(setdef->size, GFP_KERNEL)) == NULL) {
@@ -831,7 +918,12 @@ int devparam_set_params(struct device *d
 		dev->paramsets[which] = ps;
 	}
 
-	if ((ret = set_devparams_by_storedparams(dev)) < 0)
+	if (buf)
+		ret = set_devparams_by_args(dev, buf);
+	else
+		ret = set_devparams_by_storedparams(dev);
+
+	if (ret < 0)
 		goto free_out;
 	
 	if (drv->bus && drv->bus->paramset_def)
Index: linux-export/include/linux/device.h
===================================================================
--- linux-export.orig/include/linux/device.h	2004-11-04 14:40:01.000000000 +0900
+++ linux-export/include/linux/device.h	2004-11-04 14:40:01.000000000 +0900
@@ -342,7 +342,8 @@ extern int device_for_each_child(struct 
  * Manual binding of a device to driver. See drivers/base/bus.c
  * for information on use.
  */
-extern int  driver_probe_device(struct device_driver * drv, struct device * dev);
+extern int  driver_probe_device(struct device_driver * drv, struct device * dev,
+				const char *args);
 extern void device_bind_driver(struct device * dev);
 extern void device_release_driver(struct device * dev);
 extern int  device_attach(struct device * dev);
Index: linux-export/include/linux/deviceparam.h
===================================================================
--- linux-export.orig/include/linux/deviceparam.h	2004-11-04 14:39:59.000000000 +0900
+++ linux-export/include/linux/deviceparam.h	2004-11-04 14:40:01.000000000 +0900
@@ -220,7 +220,7 @@ int devparam_module_init(struct module *
 int devparam_unknown_modparam(char *name, char *val, void *arg);
 void devparam_module_done(struct module *module);
 
-int devparam_set_params(struct device *dev);
+int devparam_set_params(struct device *dev, const char *args);
 void devparam_release_params(struct device *dev);
 
 #endif /*__LINUX_DEVICEPARAM_H*/
