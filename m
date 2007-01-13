Return-Path: <linux-kernel-owner+w=401wt.eu-S1422814AbXAMWlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422814AbXAMWlP (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 17:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422809AbXAMWlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 17:41:15 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:50934 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030521AbXAMWlN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 17:41:13 -0500
Date: Sat, 13 Jan 2007 22:40:55 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Dmitry Torokhov <dtor@insightbb.com>
cc: Miguel Ojeda <maxextreme@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       oLinux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Luming Yu <Luming.yu@intel.com>, Andrew Zabolotny <zap@homelink.ru>,
       linux-acpi@vger.kernel.org, kernel-discuss@handhelds.org,
       lcd4linux-devel@sf.net
Subject: Re: Display class
In-Reply-To: <200612292232.44122.dtor@insightbb.com>
Message-ID: <Pine.LNX.4.64.0701132225530.18652@pentafluge.infradead.org>
References: <Pine.LNX.4.64.0611141939050.6957@pentafluge.infradead.org>
 <Pine.LNX.4.64.0611150052180.13800@pentafluge.infradead.org>
 <Pine.LNX.4.64.0612051740250.2925@pentafluge.infradead.org>
 <200612292232.44122.dtor@insightbb.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1831524198-632567853-1168727380=:18652"
Content-ID: <Pine.LNX.4.64.0701132231300.19194@pentafluge.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1831524198-632567853-1168727380=:18652
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.LNX.4.64.0701132231301.19194@pentafluge.infradead.org>


> Hi,
> 
> On Tuesday 05 December 2006 13:03, James Simmons wrote:
> > +int probe_edid(struct display_device *dev, void *data)
> > +{
> > +       struct fb_monspecs spec;
> > +       ssize_t size = 45;

That code was only for testing. I do have new core code. Andrew could 
you merge this patch as it is against the -mm tree.

This new class provides a way common interface for various types of 
displays such as LCD, CRT, LVDS etc. It is a expansion of the lcd
class to include other types of displays.
  
diff -urN linux-2.6.20-rc3/drivers/video/display/display-sysfs.c linux-2.6.20-rc3-display/drivers/video/display/display-sysfs.c
--- linux-2.6.20-rc3/drivers/video/display/display-sysfs.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.20-rc3-display/drivers/video/display/display-sysfs.c	2007-01-13 16:22:54.000000000 -0500
@@ -0,0 +1,208 @@
+/*
+ *  display.c - Display output driver
+ *
+ *  Copyright (C) 2007 James Simmons <jsimmons@infradead.org>
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or (at
+ *  your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ */
+#include <linux/module.h>
+#include <linux/display.h>
+#include <linux/err.h>
+#include <linux/ctype.h>
+
+static ssize_t display_show_name(struct class_device *cdev, char *buf)
+{
+	struct display_device *dsp = to_display_device(cdev);
+	return snprintf(buf, PAGE_SIZE, "%s\n", dsp->name);
+}
+
+static ssize_t display_show_type(struct class_device *cdev, char *buf)
+{
+	struct display_device *dsp = to_display_device(cdev);
+	return snprintf(buf, PAGE_SIZE, "%s\n", dsp->driver->type);
+}
+
+static ssize_t display_show_power(struct class_device *cdev, char *buf)
+{
+	struct display_device *dsp = to_display_device(cdev);
+	ssize_t ret = -ENXIO;
+
+	mutex_lock(&dsp->lock);
+	if (likely(dsp->driver->get_power))
+		ret = sprintf(buf,"%.8x\n", dsp->driver->get_power(dsp));
+	mutex_unlock(&dsp->lock);
+	return ret;
+}
+
+static ssize_t display_store_power(struct class_device *cdev,
+	const char *buf, size_t count)
+{
+	struct display_device *dsp = to_display_device(cdev);
+	ssize_t size;
+	char *endp;
+	int power;
+
+	power = simple_strtoul(buf, &endp, 0);
+	size = endp - buf;
+	if (*endp && isspace(*endp))
+		size++;
+	if (size != count)
+		return -EINVAL;
+
+	mutex_lock(&dsp->lock);
+	if (likely(dsp->driver->set_power)) {
+		dsp->request_state = power;
+		dsp->driver->set_power(dsp);
+	}
+	mutex_unlock(&dsp->lock);
+	return count;
+}
+
+static ssize_t display_show_contrast(struct class_device *cdev, char *buf)
+{
+	struct display_device *dsp = to_display_device(cdev);
+	ssize_t rc = -ENXIO;
+
+	mutex_lock(&dsp->lock);
+	if (likely(dsp->driver) && dsp->driver->get_contrast)
+		rc = sprintf(buf, "%d\n", dsp->driver->get_contrast(dsp));
+	mutex_unlock(&dsp->lock);
+	return rc;
+}
+
+static ssize_t display_store_contrast(struct class_device *cdev, const char *buf, size_t count)
+{
+	
+	struct display_device *dsp = to_display_device(cdev);
+	ssize_t ret = -EINVAL, size;
+	int contrast;
+	char *endp;
+
+	contrast = simple_strtoul(buf, &endp, 0);
+	size = endp - buf;
+
+	if (*endp && isspace(*endp))
+		size++;
+
+	if (size != count)
+		return ret;
+
+	mutex_lock(&dsp->lock);
+	if (likely(dsp->driver && dsp->driver->set_contrast)) {
+		pr_debug("display: set contrast to %d\n", contrast);
+		dsp->driver->set_contrast(dsp, contrast);
+		ret = count;
+	}
+	mutex_unlock(&dsp->lock);
+	return ret;
+}
+
+static ssize_t display_show_max_contrast(struct class_device *cdev, char *buf)
+{
+	struct display_device *dsp = to_display_device(cdev);
+	ssize_t rc = -ENXIO;
+
+	mutex_lock(&dsp->lock);
+	if (likely(dsp->driver))
+		rc = sprintf(buf, "%d\n", dsp->driver->max_contrast);
+	mutex_unlock(&dsp->lock);
+	return rc;
+}
+
+static void display_class_release(struct class_device *dev)
+{
+	struct display_device *dsp = to_display_device(dev);
+	kfree(dsp);
+}
+
+static struct class_device_attribute display_attributes[] = {
+	__ATTR(name, S_IRUGO, display_show_name, NULL),
+	__ATTR(type, S_IRUGO, display_show_type, NULL),
+	__ATTR(power, S_IRUGO | S_IWUSR, display_show_power, display_store_power),
+	__ATTR(contrast, S_IRUGO | S_IWUSR, display_show_contrast, display_store_contrast),
+	__ATTR(max_contrast, S_IRUGO, display_show_max_contrast, NULL),
+};
+
+static struct class display_class = {
+	.name = "display",
+	.release = display_class_release,
+	.class_dev_attrs = display_attributes,
+};
+
+static int index;
+
+struct display_device *display_device_register(struct display_driver *driver,
+						struct device *dev, void *devdata)
+{
+	struct display_device *new_dev;
+	int ret = -ENOMEM;
+
+	if (unlikely(!driver))
+		return ERR_PTR(-EINVAL);
+
+	new_dev = kzalloc(sizeof(struct display_device), GFP_KERNEL);
+	if (likely(new_dev) && unlikely(driver->probe(new_dev, devdata))) {
+		mutex_init(&new_dev->lock);
+
+		new_dev->class_dev.groups = &driver->type_prop; 
+		new_dev->class_dev.class = &display_class;
+		new_dev->class_dev.dev = dev;
+		new_dev->driver = driver;
+
+		sprintf(new_dev->class_dev.class_id, "display%d", index++);
+		class_set_devdata(&new_dev->class_dev, devdata);
+		ret = class_device_register(&new_dev->class_dev);
+	}
+	if (unlikely(ret)) {
+		kfree(new_dev);
+		new_dev = ERR_PTR(ret);
+	}
+	return new_dev;
+}
+EXPORT_SYMBOL(display_device_register);
+
+void display_device_unregister(struct display_device *dev)
+{
+	if (!dev)
+		return;
+	mutex_lock(&dev->lock);
+	class_device_unregister(&dev->class_dev);
+	dev->driver = NULL;
+	index--;
+	mutex_unlock(&dev->lock);
+	kfree(dev);
+}
+EXPORT_SYMBOL(display_device_unregister);
+
+static void __exit display_class_exit(void)
+{
+	class_unregister(&display_class);
+}
+
+static int __init display_class_init(void)
+{
+	return class_register(&display_class);
+}
+
+postcore_initcall(display_class_init);
+module_exit(display_class_exit);
+
+MODULE_DESCRIPTION("Display Hardware handling");
+MODULE_AUTHOR("James Simmons <jsimmons@infradead.org>");
+MODULE_LICENSE("GPL");
diff -urN linux-2.6.20-rc3/drivers/video/display/Kconfig linux-2.6.20-rc3-display/drivers/video/display/Kconfig
--- linux-2.6.20-rc3/drivers/video/display/Kconfig	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.20-rc3-display/drivers/video/display/Kconfig	2007-01-13 16:00:51.000000000 -0500
@@ -0,0 +1,24 @@
+#
+# Display drivers configuration
+#
+
+menu "Display device support"
+
+config DISPLAY_SUPPORT
+	tristate "Display panel/monitor support"
+	---help---
+	  This framework adds support for low-level control of a display.
+	  This includes support for power.
+
+	  Enable this to be able to choose the drivers for controlling the
+	  physical display panel/monitor on some platforms. This not only
+	  covers LCD displays for PDAs but also other types of displays
+	  such as CRT, TVout etc.
+
+	  To have support for your specific display panel you will have to
+	  select the proper drivers which depend on this option.
+
+comment "Display hardware drivers"
+	depends on DISPLAY_SUPPORT
+
+endmenu
diff -urN linux-2.6.20-rc3/drivers/video/display/Makefile linux-2.6.20-rc3-display/drivers/video/display/Makefile
--- linux-2.6.20-rc3/drivers/video/display/Makefile	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.20-rc3-display/drivers/video/display/Makefile	2007-01-13 16:01:03.000000000 -0500
@@ -0,0 +1,6 @@
+# Display drivers
+
+display-objs				:= display-sysfs.o
+
+obj-$(CONFIG_DISPLAY_SUPPORT)		+= display.o
+
diff -urN linux-2.6.20-rc3/drivers/video/Kconfig linux-2.6.20-rc3-display/drivers/video/Kconfig
--- linux-2.6.20-rc3/drivers/video/Kconfig	2007-01-08 14:00:26.000000000 -0500
+++ linux-2.6.20-rc3-display/drivers/video/Kconfig	2007-01-13 09:23:03.000000000 -0500
@@ -6,6 +6,7 @@
 
 if SYSFS
 	source "drivers/video/backlight/Kconfig"
+	source "drivers/video/display/Kconfig"
 endif
 
 config FB
diff -urN linux-2.6.20-rc3/drivers/video/Makefile linux-2.6.20-rc3-display/drivers/video/Makefile
--- linux-2.6.20-rc3/drivers/video/Makefile	2007-01-08 14:00:26.000000000 -0500
+++ linux-2.6.20-rc3-display/drivers/video/Makefile	2007-01-13 09:22:40.000000000 -0500
@@ -12,7 +12,7 @@
 
 obj-$(CONFIG_VT)		  += console/
 obj-$(CONFIG_LOGO)		  += logo/
-obj-$(CONFIG_SYSFS)		  += backlight/
+obj-$(CONFIG_SYSFS)		  += backlight/ display/
 
 obj-$(CONFIG_FB_CFB_FILLRECT)  += cfbfillrect.o
 obj-$(CONFIG_FB_CFB_COPYAREA)  += cfbcopyarea.o
diff -urN linux-2.6.20-rc3/include/linux/display.h linux-2.6.20-rc3-display/include/linux/display.h
--- linux-2.6.20-rc3/include/linux/display.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.20-rc3-display/include/linux/display.h	2007-01-13 16:23:51.000000000 -0500
@@ -0,0 +1,60 @@
+/*
+ *  Copyright (C) 2006 James Simmons <jsimmons@infradead.org>
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or (at
+ *  your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ */
+
+#ifndef _LINUX_DISPLAY_H
+#define _LINUX_DISPLAY_H
+
+#include <linux/device.h>
+
+struct display_device;
+
+/* This structure defines all the properties of a Display. */
+struct display_driver {
+	int (*set_power)(struct display_device *);
+	int (*get_power)(struct display_device *);
+	int (*set_contrast)(struct display_device *, unsigned int);
+	int (*get_contrast)(struct display_device *);
+	int (*probe)(struct display_device *, void *);
+	int (*remove)(struct display_device *);
+	struct attribute_group *type_prop;
+	int max_contrast;
+	char type[16];
+};
+
+struct display_device {
+	struct module *owner;	/* Owner module */
+	char *name;
+	struct mutex lock;
+	int request_state;
+	struct display_driver *driver;
+	struct class_device class_dev;		/* The class device structure */
+};
+
+extern struct display_device *display_device_register(struct display_driver *driver,
+					struct device *dev, void *devdata);
+extern void display_device_unregister(struct display_device *dev);
+
+extern int display_probe_edid(struct display_device *dev, void *devdata);
+
+#define to_display_device(obj) container_of(obj, struct display_device, class_dev)
+
+#endif

---1831524198-632567853-1168727380=:18652--
