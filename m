Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267551AbUG3Atr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267551AbUG3Atr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 20:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267549AbUG3Atr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 20:49:47 -0400
Received: from home.powernetonline.com ([66.84.210.20]:19667 "EHLO
	home.uspower.net") by vger.kernel.org with ESMTP id S267548AbUG3AtZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 20:49:25 -0400
Date: Thu, 29 Jul 2004 19:49:50 -0500
From: John Lenz <jelenz@students.wisc.edu>
To: Andrew Zabolotny <zap@homelink.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Backlight and LCD module patches [2]
Message-ID: <20040730004950.GA11828@hydra.mshome.net>
References: <20040617223517.59a56c7e.zap@homelink.ru> <20040725215917.GA7279@hydra.mshome.net> <20040728221141.158d8f14.zap@homelink.ru> <20040729232547.GA4565@hydra.mshome.net> <20040730040645.169e4024.zap@homelink.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040730040645.169e4024.zap@homelink.ru> (from zap@homelink.ru on Thu, Jul 29, 2004 at 19:06:45 -0500)
X-Mailer: Balsa 2.0.17
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On 07/29/04 19:06:45, Andrew Zabolotny wrote:
> On Thu, 29 Jul 2004 18:25:47 -0500
> John Lenz <jelenz@students.wisc.edu> wrote:
> 
> > Actually, now that I think about it a bit more, I think the  
> > lcd_properties->match function should take a device * as a paramater  
> > instead of a fb_info *.  Insead of passing the fb_info pointer to the  
> > match function, we really should be passing the actual device  
> > structure.  For example, in the pxafb driver, it would register the  
> > platform_device that it creates with either the class code (if  
> > class_match is used) or with the lcdbase code.  This way the lcd driver  
> > could examine the device * and look at for example which resources it  
> > used, which memory region it was using, etc. and make its decision.

> If you look here: http://lkml.org/lkml/2004/6/26/84 you can see that this is
> exactly what I was proposing minus your proposal for a more generic
> class device match function. I was imagining that it would happen this way:
> the framebuffer device during initialization calls lcd_find_device() and
> passes his own 'struct device' to it; then lcd_find_device calls the match
> function of every previously registered LCD device with this parameter. The
> first one that says 'match' is returned. Same about backlight.

The only problem is that what happens if the fb device is registered before
the lcd device?  So that means you still need to keep around a list of fb
devices that have been registered so that when a new lcd device is registered
it can check if it matches an old fb device.

> 
> I don't see many reasons for a generic class match function. Last but not
> least the lcd_find_device() function is very small, so it will be a negligible
> gain but a lot of hassle (as you said, framebuffer drivers will have to be
> rewritten to not use the simple_class device class).
> 

The only advantage is we let the core class code take care of managing the 2 lists
of devices for us (which it is doing anyway).  Then the driver doesn't need to
keep the fb list around, doesn't need to keep the lcd list around, doesn't need
to write all that locking code to make sure the lists aren't updated all at the
same time, etc.  The class code already has these lists, already provides locking
for them, etc.

The fb stuff doesn't have to be rewritten to use normal classes, the class_match
could still work with simple classes.  The only change would be we would need some way
to pass the device pointer to the class_simple_device_add() function in fbmem.c,
a pretty trivial change.  Notice in fbmem it calls class_simple_device_add with a
paramater of NULL.  We would just like the individual driver to optionally pass a
device * there instead of NULL.

Perhaps a patch would better explain the situation.  I haven't even tried to compile
this patch, but it should give you an idea of what I am thinking here.  The only
thing I didn't add to this was the actual implementation of class_match_register,
but I can write that as well.

John
--5vNYLRcllDrimb99
Content-Type: text/x-patch; charset=unknown-8bit
Content-Disposition: attachment; filename="lcd_device.patch"


#
# Patch managed by http://www.holgerschurig.de/patcher.html
#

--- /dev/null
+++ linux/include/linux/lcd.h
@@ -0,0 +1,45 @@
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
+struct lcd_properties {
+	/* owner module */
+	struct module *owner;
+
+	/* device of this lcd */
+	struct device *lcd_dev;
+
+	/* get and set the current power state */
+	int	(*get_power)	(struct lcd_properties *props);
+	void	(*set_power)	(struct lcd_properties *props, int power);
+	
+	/* The maximum value for contrast (read-only) */
+	int max_contrast;
+
+	/* get and set the current contrast level. */
+	int	(*get_contrast)	(struct lcd_properties *props);
+	void	(*set_contrast)	(struct lcd_properties *props, int contrast);
+
+	/* match with a given framebuffer device */
+	int (*match) (struct lcd_properties *props, struct device *fb_dev);
+
+	/* private */
+	struct lcd_class_device *lcd_class_dev;
+};
+
+int lcd_device_register(struct lcd_properties *props, const char *name);
+void lcd_device_unregister(struct lcd_properties *props);
--- /dev/null
+++ linux/drivers/video/lcd/lcdbase.c
@@ -0,0 +1,251 @@
+/*
+ * linux/drivers/video/lcd/lcdbase.c
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
+};
+#define to_lcd_device(d) container_of(d, struct lcd_class_device, class_dev)
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
+			sprintf(buf, "%i\n", lcd_dev->props->get_power(lcd_dev->props));
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
+	char *after;
+
+	unsigned long power = simple_strtoul(buf, &after, 0);
+	if (after - buf > 0) {
+		ret = after - buf;
+		spin_lock(&lcd_dev->lock);
+		if (likely(lcd_dev->props)) {
+			if (lcd_dev->props->set_power) {
+				lcd_dev->props->set_power(lcd_dev->props, power);
+			}
+		}
+		spin_unlock(&lcd_dev->lock);
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
+	class_device_unregister(&lcd_dev->class_dev);
+}
+EXPORT_SYMBOL(lcd_device_unregister);
+
+static int lcd_class_match(struct class_device *dev1, struct class_device *dev2)
+{
+	struct lcd_class_device *lcd_dev = to_lcd_device(dev1);
+	int ret = 0;
+
+	spin_lock(&lcd_dev->lock);
+	if (likely(lcd_dev->props)) {
+		if (lcd_dev->props->match) {
+			ret = lcd_dev->props->match(lcd_dev->props, dev2->dev);
+		}
+	}
+	spin_unlock(&lcd_dev->lock);
+
+	return ret;
+}
+
+static struct class_match lcd_fb_class_match = {
+	.class1		= &lcd_class,
+
+	.match		= &lcd_class_match,
+};
+
+static int __init lcd_init(void)
+{
+	class_register(&lcd_class);
+
+	class_simple_set_match(fb_class, &lcd_fb_class_match, 2);
+
+	class_match_register(&lcd_fb_class_match);
+	return 0;
+}
+subsys_initcall(lcd_init);
+
+static void __exit lcd_exit(void)
+{
+	class_match_unregister(&lcd_fb_class_match);
+	class_unregister(&lcd_class);
+}
+module_exit(lcd_exit);
+
+MODULE_AUTHOR("John Lenz <jelenz@wisc.edu>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("LCD class interface");
+
--- linux/include/linux/device.h~lcd_device
+++ linux/include/linux/device.h
@@ -240,6 +240,16 @@
 extern int class_interface_register(struct class_interface *);
 extern void class_interface_unregister(struct class_interface *);
 
+struct class_match {
+	struct class*	class1;
+	struct class*	class2;
+
+	int (*match)(struct class_device *dev1, struct class_device *dev2);
+};
+
+extern int class_match_register(struct class_match *match);
+extern void class_match_unregister(struct class_match *match);
+
 /* interface for class simple stuff */
 extern struct class_simple *class_simple_create(struct module *owner, char *name);
 extern void class_simple_destroy(struct class_simple *cs);
@@ -248,6 +258,7 @@
 extern int class_simple_set_hotplug(struct class_simple *, 
 	int (*hotplug)(struct class_device *dev, char **envp, int num_envp, char *buffer, int buffer_size));
 extern void class_simple_device_remove(dev_t dev);
+extern void class_simple_set_match(struct class_simple *cs, struct class_match *match, int location);
 
 
 struct device {
--- linux/drivers/video/fbmem.c~lcd_device
+++ linux/drivers/video/fbmem.c
@@ -1314,7 +1314,7 @@
 #endif
 };
 
-static struct class_simple *fb_class;
+struct class_simple *fb_class;
 
 /**
  *	register_framebuffer - registers a frame buffer device
@@ -1327,7 +1327,7 @@
  */
 
 int
-register_framebuffer(struct fb_info *fb_info)
+register_framebuffer(struct fb_info *fb_info, struct device *fb_device)
 {
 	int i;
 	struct class_device *c;
@@ -1340,7 +1340,7 @@
 			break;
 	fb_info->node = i;
 
-	c = class_simple_device_add(fb_class, MKDEV(FB_MAJOR, i), NULL, "fb%d", i);
+	c = class_simple_device_add(fb_class, MKDEV(FB_MAJOR, i), fb_device, "fb%d", i);
 	if (IS_ERR(c)) {
 		/* Not fatal */
 		printk(KERN_WARNING "Unable to create class_device for framebuffer %d; errno = %ld\n", i, PTR_ERR(c));
@@ -1377,6 +1377,11 @@
 	return 0;
 }
 
+int register_framebuffer(struct fb_info *fb_info)
+{
+	register_framebuffer(fb_info, NULL);
+}
+
 
 /**
  *	unregister_framebuffer - releases a frame buffer device
--- linux/drivers/video/pxafb.c~lcd_device
+++ linux/drivers/video/pxafb.c
@@ -1318,7 +1318,7 @@
 
 	dev_set_drvdata(dev, fbi);
 
-	ret = register_framebuffer(&fbi->fb);
+	ret = register_framebuffer(&fbi->fb, dev);
 	if (ret < 0) {
 		dev_err(dev, "Failed to register framebuffer device: %d\n", ret);
 		goto failed;
--- linux/drivers/base/class_simple.c~lcd_device
+++ linux/drivers/base/class_simple.c
@@ -214,3 +214,13 @@
 	}
 }
 EXPORT_SYMBOL(class_simple_device_remove);
+
+extern void class_simple_set_match(struct class_simple *cs, struct class_match *match, int location)
+{
+	if (location == 1) {
+		match->class1 = &cs->class;
+	} else if (location == 2) {
+		match->class2 = &cs->class;
+	}
+}
+EXPORT_SYMBOL(class_simple_set_match);
--- linux/include/linux/fb.h~lcd_device
+++ linux/include/linux/fb.h
@@ -634,6 +634,7 @@
 extern void cfb_imageblit(struct fb_info *info, const struct fb_image *image);
 
 /* drivers/video/fbmem.c */
+extern struct class_simple *fb_class;
 extern int register_framebuffer(struct fb_info *fb_info);
 extern int unregister_framebuffer(struct fb_info *fb_info);
 extern int fb_prepare_logo(struct fb_info *fb_info);

--5vNYLRcllDrimb99--
