Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264524AbUGYV72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264524AbUGYV72 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 17:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264530AbUGYV72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 17:59:28 -0400
Received: from home.powernetonline.com ([66.84.210.20]:20105 "EHLO
	Home.uspower.net") by vger.kernel.org with ESMTP id S264524AbUGYV7E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 17:59:04 -0400
Date: Sun, 25 Jul 2004 16:59:17 -0500
From: John Lenz <jelenz@students.wisc.edu>
To: Andrew Zabolotny <zap@homelink.ru>, Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Backlight and LCD module patches [2]
Message-ID: <20040725215917.GA7279@hydra.mshome.net>
References: <20040617223517.59a56c7e.zap@homelink.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040617223517.59a56c7e.zap@homelink.ru> (from zap@homelink.ru on Thu, Jun 17, 2004 at 13:35:17 -0500)
X-Mailer: Balsa 2.0.17
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; Format=Flowed; DelSp=Yes; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On 06/17/04 13:35:17, Andrew Zabolotny wrote:
> 
> This patch adds lcd and backlight driver classes so that the
> lowlevel lcd and backlight power controls can be separated from
> framebuffer drivers.
>

What about something like this patch?  It still needs a little work.

The problem I see is that we would like something like a bus to match  
together class devices.  What would be really nice is something like  
this.

struct class_match {
  struct class *class1;
  struct class *class2;

  int (*match)(struct class_device *dev1, struct class_device *dev2);
};

This class match structure would be very similar to a bus, in that it  
matches together two classes instead of matching a device to a driver.   
All the class code would have to do is call the match function for all  
possible combinations of class devices in class1 and in class2.  If  
match returned true, then it would create symbolic links between the  
two.

So for example, one class would be named fb and one class be named lcd.   
When we match two devices, they would symlink to each other like so.
/sys/class/lcd/foo/fb is a symlink to /sys/class/fb/bar and /sys/class/ 
fb/bar/lcd is a symlink to /sys/class/lcd/foo.

The provided match function would have to take care of actually linking  
the two devices together (that is, giving the fb_info device a pointer  
to the actual lcd_properties class or storing the pointer to the  
fb_info structure in the lcd_device structure or whatever).

If we had this class_match structure, we could elminate the matching  
code I added to this patch.

Lastly, wouldn't it be better to create a drivers/video/lcd directory  
so that all the lcd drivers can go in there and not clutter up the main  
drivers/video directory?

John
--2fHTh5uZTiUOsy+g
Content-Type: text/x-patch; charset=unknown-8bit
Content-Disposition: attachment; filename="lcd_device.patch"


#
# Patch managed by http://www.holgerschurig.de/patcher.html
#

--- /dev/null
+++ linux/include/linux/lcd.h
@@ -0,0 +1,52 @@
+/*
+ *  linux/include/lcd.h
+ *
+ *  Copyright (C) 2004 John Lenz <jelenz@wisc.edu>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * LCD Lowlevel Control Abstraction
+ *
+ * Based on a patch by Andrew Zabolotny <zap@homelink.ru> and Jamey Hicks <jamey.hicks@hp.com>
+ */
+
+#include <linux/device.h>
+
+struct lcd_class_device;
+
+enum lcd_power_status {
+	lcd_power_full_on = 0,
+	lcd_power_full_off,
+	lcd_power_controller_on,
+	lcd_power_flatpanel_off,
+};
+
+struct lcd_properties {
+	/* owner module */
+	struct module *owner;
+
+	/* device of this lcd */
+	struct device *lcd_dev;
+
+	/* get and set the current power state */
+	enum lcd_power_status	(*get_power)	(struct lcd_properties *props);
+	void			(*set_power)	(struct lcd_properties *props, enum lcd_power_status power);
+	
+	/* The maximum value for contrast (read-only) */
+	int max_contrast;
+
+	/* get and set the current contrast level. */
+	int	(*get_contrast)	(struct lcd_properties *props);
+	void	(*set_contrast)	(struct lcd_properties *props, int contrast);
+
+	/* match with a given framebuffer device */
+	int (*match) (struct lcd_properties *props, struct fb_info *fb_info);
+
+	/* private */
+	struct lcd_class_device *lcd_class_dev;
+};
+
+int lcd_device_register(struct lcd_properties *props, const char *name);
+void lcd_device_unregister(struct lcd_properties *props);
--- /dev/null
+++ linux/drivers/video/lcd.c
@@ -0,0 +1,312 @@
+/*
+ * linux/drivers/video/lcd.c
+ *
+ *   Copyright (C) 2004 John Lenz <jelenz@wisc.edu>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Based on a patch by Andrew Zabolotny <zap@homelink.ru> and Jamey Hicks <jamey.hicks@hp.com>
+ */
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <linux/device.h>
+#include <linux/fb.h>
+#include <linux/lcd.h>
+
+struct lcd_class_device {
+	/* This protects the props field.*/
+	spinlock_t lock;
+	/* If props is NULL, the driver that registered this device has been unloaded */
+	struct lcd_properties *props;
+	struct class_device class_dev;
+
+	struct list_head list;
+};
+#define to_lcd_device(d) container_of(d, struct lcd_class_device, class_dev)
+
+struct lcd_fb_list_node {
+	struct list_head list;
+	struct fb_info *fb_info;
+};
+static spinlock_t lcd_list_lock = SPIN_LOCK_UNLOCKED;
+static LIST_HEAD(lcd_fb_list);
+static LIST_HEAD(lcd_device_list);
+
+struct lcd_power_name {
+	const char *		name;
+	enum lcd_power_status	power;
+};
+static const struct lcd_power_name lcd_power_names[] = {
+	{ "full on",		lcd_power_full_on },
+	{ "full off",		lcd_power_full_off },
+	{ "controller on",	lcd_power_controller_on },
+	{ "flatpanel off",	lcd_power_flatpanel_off },
+};
+
+static void lcd_class_release(struct class_device *dev)
+{
+	struct lcd_class_device *d = to_lcd_device(dev);
+	kfree(d);
+}
+
+static struct class lcd_class = {
+	.name		= "lcd",
+	.release	= lcd_class_release,
+};
+
+static ssize_t lcd_show_power(struct class_device *dev, char *buf)
+{
+	struct lcd_class_device *lcd_dev = to_lcd_device(dev);
+	ssize_t ret = 0;
+
+	spin_lock(&lcd_dev->lock);
+	if (likely(lcd_dev->props)) {
+		if (lcd_dev->props->get_power) {
+			sprintf(buf, "%s\n", lcd_power_names[(int)lcd_dev->props->get_power(lcd_dev->props)].name);
+			ret = strlen(buf) + 1;
+		}
+	}
+	spin_unlock(&lcd_dev->lock);
+
+	return ret;
+}
+
+static ssize_t lcd_store_power(struct class_device *dev, const char *buf, size_t size)
+{
+	struct lcd_class_device *lcd_dev = to_lcd_device(dev);
+	int ret = -EINVAL;
+	int i;
+	
+	for (i = 0; i < ARRAY_SIZE(lcd_power_names); i++) {
+		if (strncmp(buf, lcd_power_names[i].name, strlen(lcd_power_names[i].name)) == 0) {
+			ret = size;
+			spin_lock(&lcd_dev->lock);
+			if (likely(lcd_dev->props)) {
+				if (lcd_dev->props->set_power) {
+					lcd_dev->props->set_power(lcd_dev->props, lcd_power_names[i].power);
+				}
+			}
+			spin_unlock(&lcd_dev->lock);
+			break;
+		}
+	}
+
+	return ret;
+}
+
+static CLASS_DEVICE_ATTR(power, 0644, lcd_show_power, lcd_store_power);
+
+static ssize_t lcd_show_maxcontrast(struct class_device *dev, char *buf)
+{
+	struct lcd_class_device *lcd_dev = to_lcd_device(dev);
+	ssize_t ret = 0;
+	
+	spin_lock(&lcd_dev->lock);
+	if (likely(lcd_dev->props)) {
+		sprintf(buf, "%i\n", lcd_dev->props->max_contrast);
+		ret = strlen(buf) + 1;
+	}
+	spin_unlock(&lcd_dev->lock);
+
+	return ret;
+}
+
+static CLASS_DEVICE_ATTR(max_contrast, 0444, lcd_show_maxcontrast, NULL);
+
+static ssize_t lcd_show_contrast(struct class_device *dev, char *buf)
+{
+	struct lcd_class_device *lcd_dev = to_lcd_device(dev);
+	ssize_t ret = 0;
+
+	spin_lock(&lcd_dev->lock);
+	if (likely(lcd_dev->props)) {
+		if (lcd_dev->props->get_contrast) {
+			sprintf(buf, "%i\n", lcd_dev->props->get_contrast(lcd_dev->props));
+			ret = strlen(buf) + 1;
+		}
+	}
+	spin_unlock(&lcd_dev->lock);
+
+	return ret;
+}
+
+static ssize_t lcd_store_contrast(struct class_device *dev, const char *buf, size_t size)
+{
+	struct lcd_class_device *lcd_dev = to_lcd_device(dev);
+	int ret = -EINVAL;
+	char *after;
+
+	unsigned long contrast = simple_strtoul(buf, &after, 0);
+	if (after - buf > 0) {
+		ret = after - buf;
+		spin_lock(&lcd_dev->lock);
+		if (likely(lcd_dev->props)) {
+			if (lcd_dev->props->set_contrast) {
+				lcd_dev->props->set_contrast(lcd_dev->props, contrast);
+			}
+		}
+		spin_unlock(&lcd_dev->lock);
+	}
+
+	return ret;
+}
+
+static CLASS_DEVICE_ATTR(contrast, 0644, lcd_show_contrast, lcd_store_contrast);
+
+/**
+ * lcd_device_register - register a new object of lcd_device class.
+ * @prop: the lcd properties structure for this device.
+ */
+int lcd_device_register(struct lcd_properties *props, const char *name)
+{
+	int rc;
+	struct lcd_class_device *new_lcd;
+	struct lcd_fb_list_node *node;
+
+	new_lcd = kmalloc (sizeof (struct lcd_class_device), GFP_KERNEL);
+	if (unlikely (!new_lcd))
+		return -ENOMEM;
+
+	spin_lock_init(&new_lcd->lock);
+	new_lcd->props = props;
+	props->lcd_class_dev = new_lcd;
+
+	memset (&new_lcd->class_dev, 0, sizeof (new_lcd->class_dev));
+	new_lcd->class_dev.class = &lcd_class;
+	new_lcd->class_dev.dev = props->lcd_dev;
+	strlcpy (new_lcd->class_dev.class_id, name, KOBJ_NAME_LEN);
+
+	rc = class_device_register (&new_lcd->class_dev);
+	if (unlikely (rc)) {
+		kfree (new_lcd);
+		return rc;
+	}
+
+	/* register the attributes */
+	class_device_create_file(&new_lcd->class_dev, &class_device_attr_power);
+	class_device_create_file(&new_lcd->class_dev, &class_device_attr_max_contrast);
+	class_device_create_file(&new_lcd->class_dev, &class_device_attr_contrast);
+
+	/* add to device list and attempt to match with fb devices */
+	spin_lock(&lcd_list_lock);
+	list_add_tail(&lcd_device_list, &new_lcd->list);
+
+	list_for_each_entry(node, &lcd_fb_list, list) {
+		if (props->match(props, node->fb_info)) {
+			/* node->fb->lcd_props = props 
+			 * get_device(props->lcd_deb) */
+		}
+	}
+	spin_unlock(&lcd_list_lock);
+
+	printk(KERN_INFO "Registered lcd device: name=%s\n", new_lcd->class_dev.class_id);
+
+	return 0;
+}
+EXPORT_SYMBOL(lcd_device_register);
+
+/**
+ * lcd_device_unregister - unregisters a object of lcd_properties class.
+ * @props: the property to unreigister
+ *
+ * Unregisters a previously registered via lcd_device_register object.
+ */
+void lcd_device_unregister(struct lcd_properties *props)
+{
+	struct lcd_class_device *lcd_dev;
+	if (!props)
+		return;
+
+	lcd_dev = props->lcd_class_dev;
+
+	pr_debug("lcd_device_unregister: name=%s\n", lcd_dev->class_dev.class_id);
+
+	class_device_remove_file (&lcd_dev->class_dev, &class_device_attr_contrast);
+	class_device_remove_file (&lcd_dev->class_dev, &class_device_attr_max_contrast);
+	class_device_remove_file (&lcd_dev->class_dev, &class_device_attr_power);
+
+	spin_lock(&lcd_dev->lock);
+	lcd_dev->props = NULL;
+	props->lcd_class_dev = NULL;
+	spin_unlock(&lcd_dev->lock);
+
+	/* remove from device list */
+	spin_lock(&lcd_list_lock);
+	list_del(&lcd_dev->list);
+	spin_unlock(&lcd_list_lock);
+
+	class_device_unregister(&lcd_dev->class_dev);
+}
+EXPORT_SYMBOL(lcd_device_unregister);
+
+int lcd_fb_info_register(struct fb_info *fb)
+{
+	struct lcd_fb_list_node *node;
+	struct lcd_class_device *lcd_dev;
+
+	node = kmalloc(sizeof(struct lcd_fb_list_node), GFP_KERNEL);
+	if (!node) {
+		return -ENOMEM;
+	}
+
+	node->fb_info = fb;
+	
+	/* add to fb list, and attempt to match with known lcd devices */
+	spin_lock(&lcd_list_lock);
+	list_add_tail(&lcd_fb_list, &node->list);
+	
+	list_for_each_entry(lcd_dev, &lcd_device_list, list) {
+		spin_lock(&lcd_dev->lock);
+		if (likely(lcd_dev->props)) {
+			if (lcd_dev->props->match(lcd_dev->props, fb)) {
+				/* fb->lcd_props = lcd_dev->props;
+				 * get_device(lcd_dev->props->lcd_dev); */
+			}
+		}
+		spin_unlock(&lcd_dev->lock);
+	}
+	spin_unlock(&lcd_list_lock);
+
+	return 0;
+}
+
+void lcd_fb_info_unregister(struct fb_info *fb)
+{
+	struct lcd_fb_list_node *node;
+	struct lcd_fb_list_node *tmp;
+
+	/* remove from fb list */
+	spin_lock(&lcd_list_lock);
+	list_for_each_entry_safe(node, tmp, &lcd_fb_list, list) {
+		if (node->fb_info == fb) {
+			list_del(&node->list);
+			kfree(node);
+		}
+	}
+
+	spin_unlock(&lcd_list_lock);
+}
+
+static int __init lcd_init(void)
+{
+	class_register(&lcd_class);
+	return 0;
+}
+subsys_initcall(lcd_init);
+
+static void __exit lcd_exit(void)
+{
+	class_unregister(&lcd_class);
+}
+module_exit(lcd_exit);
+
+MODULE_AUTHOR("John Lenz <jelenz@wisc.edu>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("LCD class interface");
+

--2fHTh5uZTiUOsy+g--
