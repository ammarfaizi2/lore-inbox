Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261631AbUFQSie@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbUFQSie (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 14:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbUFQSid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 14:38:33 -0400
Received: from mail.homelink.ru ([81.9.33.123]:28893 "EHLO eltel.net")
	by vger.kernel.org with ESMTP id S261631AbUFQSfT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 14:35:19 -0400
Date: Thu, 17 Jun 2004 22:35:17 +0400
From: Andrew Zabolotny <zap@homelink.ru>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Backlight and LCD module patches [2]
Message-Id: <20040617223517.59a56c7e.zap@homelink.ru>
Organization: home
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: #%`a@cSvZ:n@M%n/to$C^!{JE%'%7_0xb("Hr%7Z0LDKO7?w=m~CU#d@-.2yO<l^giDz{>9
 epB|2@pe{%4[Q3pw""FeqiT6rOc>+8|ED/6=Eh/4l3Ru>qRC]ef%ojRz;GQb=uqI<yb'yaIIzq^NlL
 rf<gnIz)JE/7:KmSsR[wN`b\l8:z%^[gNq#d1\QSuya1(
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds lcd and backlight driver classes so that the
lowlevel lcd and backlight power controls can be separated from
framebuffer drivers.

Signed-off-by: Jamey Hicks <jamey.hicks@hp.com>
Signed-off-by: Andrew Zabolotny <zap@homelink.ru>

--- linux-2.6.7-rc3/include/linux/lcd.h	1970-01-01 03:00:00.000000000 +0300
+++ linux/include/linux/lcd.h	2004-06-08 01:59:42.000000000 +0400
@@ -0,0 +1,58 @@
+/*
+ * LCD Lowlevel Control Abstraction
+ * 
+ * Copyright (C) 2003,2004 Hewlett-Packard Company
+ * 
+ */
+
+#ifndef _LINUX_LCD_H
+#define _LINUX_LCD_H
+
+#include <linux/device.h>
+
+struct lcd_device;
+
+/* This structure defines all the properties of a LCD flat panel. */
+struct lcd_properties {
+	/* Owner module */
+	struct module *owner;
+	/* Get the LCD panel power status (0: full on, 1..3: controller
+	   power on, flat panel power off, 4: full off) */
+	int (*get_power) (struct lcd_device *);
+	/* Enable or disable power to the LCD (0: on; 4: off) */
+	int (*set_power) (struct lcd_device *, int power);
+	/* The maximum value for contrast (read-only) */
+	int max_contrast;
+	/* Get the current contrast setting (0-max_contrast) */
+	int (*get_contrast) (struct lcd_device *);
+	/* Set LCD panel contrast */
+	int (*set_contrast) (struct lcd_device *, int contrast);
+};
+
+struct lcd_device {
+	/* This protects the 'props' field. If 'props' is NULL, the driver that
+	   registered this device has been unloaded, and if class_get_devdata()
+	   points to something in the body of that driver, it is also invalid. */
+	struct semaphore sem;
+	/* If this is NULL, the backing module is unloaded */
+	struct lcd_properties *props;
+	/* The class device structure */
+	struct class_device class_dev;
+};
+
+extern int lcd_device_register(const char *name, void *devdata,
+			       struct lcd_properties *lp,
+			       struct lcd_device **alloc_ld);
+extern void lcd_device_unregister(struct lcd_device *ld);
+
+extern struct lcd_device *lcd_device_find(const char *name);
+extern struct lcd_device *lcd_device_get(struct lcd_device *ld);
+extern void lcd_device_put(struct lcd_device *ld);
+
+#define to_lcd_device(obj) container_of(obj, struct lcd_device, class_dev)
+
+/* The registered clients of this notifier chain will be called every time
+   a new lcd class_device is registered */
+extern struct notifier_block *lcd_device_chain;
+
+#endif
--- linux-2.6.7-rc3/include/linux/backlight.h	1970-01-01 03:00:00.000000000 +0300
+++ linux/include/linux/backlight.h	2004-06-08 01:46:09.000000000 +0400
@@ -0,0 +1,58 @@
+/*
+ * Backlight Lowlevel Control Abstraction
+ * 
+ * Copyright (C) 2003,2004 Hewlett-Packard Company
+ * 
+ */
+
+#ifndef _LINUX_BACKLIGHT_H
+#define _LINUX_BACKLIGHT_H
+
+#include <linux/device.h>
+
+struct backlight_device;
+
+/* This structure defines all the properties of a backlight
+   (usually attached to a LCD). */
+struct backlight_properties {
+	/* Owner module */
+	struct module *owner;
+	/* Get the power status (0: on, 1..3: power saving modes; 4: off) */
+	int (*get_power) (struct backlight_device *);
+	/* Enable or disable power to the LCD (0: on; 4: off) */
+	int (*set_power) (struct backlight_device *, int power);
+	/* Maximal value for brightness (read-only) */
+	int max_brightness;
+	/* Get current backlight brightness */
+	int (*get_brightness) (struct backlight_device *);
+	/* Set backlight brightness (0..max_brightness) */
+	int (*set_brightness) (struct backlight_device *, int brightness);
+};
+
+struct backlight_device {
+	/* This protects the 'props' field. If 'props' is NULL, the driver that
+	   registered this device has been unloaded, and if class_get_devdata()
+	   points to something in the body of that driver, it is also invalid. */
+	struct semaphore sem;
+	/* If this is NULL, the backing module is unloaded */
+	struct backlight_properties *props;
+	/* The class device structure */
+	struct class_device class_dev;
+};
+
+extern int backlight_device_register(const char *name, void *devdata,
+				     struct backlight_properties *bp,
+				     struct backlight_device **alloc_bd);
+extern void backlight_device_unregister(struct backlight_device *bd);
+
+extern struct backlight_device *backlight_device_find(const char *name);
+extern struct backlight_device *backlight_device_get(struct backlight_device *bd);
+extern void backlight_device_put(struct backlight_device *bd);
+
+#define to_backlight_device(obj) container_of(obj, struct backlight_device, class_dev)
+
+/* The registered clients of this notifier chain will be called every time
+   a new backlight class_device is registered */
+extern struct notifier_block *backlight_device_chain;
+
+#endif
--- linux-2.6.7-rc3/drivers/video/lcd.c	1970-01-01 03:00:00.000000000 +0300
+++ linux/drivers/video/lcd.c	2004-06-08 02:15:11.000000000 +0400
@@ -0,0 +1,306 @@
+/*
+ * LCD Lowlevel Control Abstraction
+ *
+ * Copyright (C) 2003,2004 Hewlett-Packard Company
+ *
+ */
+
+#include <linux/version.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/lcd.h>
+#include <linux/notifier.h>
+#include <linux/ctype.h>
+#include <asm/bug.h>
+
+struct notifier_block *lcd_device_chain;
+EXPORT_SYMBOL (lcd_device_chain);
+
+static ssize_t lcd_show_power(struct class_device *cdev, char *buf)
+{
+	int rc;
+	struct lcd_device *ld = to_lcd_device(cdev);
+
+	down (&ld->sem);
+	if (likely (ld->props && ld->props->get_power))
+		rc = sprintf (buf, "%d\n", ld->props->get_power (ld));
+	else
+		rc = -ENXIO;
+	up (&ld->sem);
+
+	return rc;
+}
+
+static ssize_t lcd_store_power(struct class_device *cdev, const char *buf, size_t count)
+{
+	int rc, power;
+	char *endp;
+	struct lcd_device *ld = to_lcd_device(cdev);
+
+	power = simple_strtoul(buf, &endp, 0);
+	if (*endp && !isspace (*endp))
+		return -EINVAL;
+
+	down (&ld->sem);
+	if (likely (ld->props && ld->props->set_power)) {
+		pr_debug("lcd: set power to %d\n", power);
+		ld->props->set_power(ld, power);
+		rc = count;
+	} else
+		rc = -ENXIO;
+	up (&ld->sem);
+
+	return rc;
+}
+
+static ssize_t lcd_show_contrast(struct class_device *cdev, char *buf)
+{
+	int rc;
+	struct lcd_device *ld = to_lcd_device(cdev);
+
+	down (&ld->sem);
+	if (likely (ld->props && ld->props->get_contrast))
+		rc = sprintf (buf, "%d\n", ld->props->get_contrast(ld));
+	else
+		rc = -ENXIO;
+	up (&ld->sem);
+
+	return rc;
+}
+
+static ssize_t lcd_store_contrast(struct class_device *cdev, const char *buf, size_t count)
+{
+	int rc, contrast;
+	char *endp;
+	struct lcd_device *ld = to_lcd_device(cdev);
+
+	contrast = simple_strtoul(buf, &endp, 0);
+	if (*endp && !isspace (*endp))
+		return -EINVAL;
+
+	down (&ld->sem);
+	if (likely (ld->props && ld->props->set_contrast)) {
+		pr_debug("lcd: set contrast to %d\n", contrast);
+		ld->props->set_contrast(ld, contrast);
+		rc = count;
+	} else
+		rc = -ENXIO;
+	up (&ld->sem);
+
+	return rc;
+}
+
+static ssize_t lcd_show_max_contrast(struct class_device *cdev, char *buf)
+{
+	int rc;
+	struct lcd_device *ld = to_lcd_device(cdev);
+
+	down (&ld->sem);
+	if (likely (ld->props))
+		rc = sprintf (buf, "%d\n", ld->props->max_contrast);
+	else
+		rc = -ENXIO;
+	up (&ld->sem);
+
+	return rc;
+}
+
+static void lcd_class_release(struct class_device *dev)
+{
+	struct lcd_device *ld = to_lcd_device (dev);
+	kfree (ld);
+}
+
+struct class lcd_class = {
+	.name = "lcd",
+	.release = lcd_class_release,
+};
+
+#define DECLARE_ATTR(_name,_mode,_show,_store)			\
+	{							 	\
+	.attr	= { .name = __stringify(_name), .mode = _mode, .owner = THIS_MODULE },	\
+	.show	= _show,					\
+	.store	= _store,					\
+	}
+
+static struct class_device_attribute lcd_class_device_attributes[] = {
+	DECLARE_ATTR (power, 0644, lcd_show_power, lcd_store_power),
+	DECLARE_ATTR (contrast, 0644, lcd_show_contrast, lcd_store_contrast),
+	DECLARE_ATTR (max_contrast, 0444, lcd_show_max_contrast, NULL),
+};
+
+/**
+ * lcd_device_register - register a new object of lcd_device class.
+ * @name: the name of the new object (must be the same as the name of the
+ *   respective framebuffer device).
+ * @devdata: an optional pointer to be stored in the class_device. The
+ *   methods may retrieve it by using class_get_devdata (ld->class_dev).
+ * @lp: the lcd properties structure.
+ * @alloc_ld: (returned) the newly allocated device. Must be used when
+ *   deregistering the device. Not relevant if the procedure does not
+ *   return 0 (success).
+ *
+ * Creates a new lcd class_device and copies data from the received ld
+ * structure into the new object. Returns after registering the new object.
+ */
+int lcd_device_register (const char *name, void *devdata,
+			 struct lcd_properties *lp,
+			 struct lcd_device **alloc_ld)
+{
+	int i, rc;
+	struct lcd_device *new_ld;
+
+	pr_debug("lcd_device_register: name=%s\n", name);
+
+	new_ld = kmalloc (sizeof (struct lcd_device), GFP_KERNEL);
+	if (unlikely (!new_ld))
+		return -ENOMEM;
+
+	init_MUTEX (&new_ld->sem);
+	new_ld->props = lp;
+	memset (&new_ld->class_dev, 0, sizeof (new_ld->class_dev));
+	new_ld->class_dev.class = &lcd_class;
+	strlcpy (new_ld->class_dev.class_id, name, KOBJ_NAME_LEN);
+	class_set_devdata (&new_ld->class_dev, devdata);
+
+	rc = class_device_register (&new_ld->class_dev);
+	if (unlikely (rc)) {
+		kfree (new_ld);
+		return rc;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(lcd_class_device_attributes); i++) {
+		rc = class_device_create_file(&new_ld->class_dev,
+					      &lcd_class_device_attributes[i]);
+		if (unlikely (rc)) {
+			while (--i >= 0)
+				class_device_remove_file(&new_ld->class_dev,
+							 &lcd_class_device_attributes[i]);
+			class_device_unregister(&new_ld->class_dev);
+			/* No need to kfree(new_ld) since release() method was called */
+			return rc;
+		}
+	}
+
+	*alloc_ld = new_ld;
+	notifier_call_chain (&lcd_device_chain, 0, new_ld);
+
+	return 0;
+}
+EXPORT_SYMBOL(lcd_device_register);
+
+/**
+ * lcd_device_unregister - unregisters a object of lcd_device class.
+ * @ld: the lcd device object to be unregistered and freed.
+ *
+ * Unregisters a previously registered via lcd_device_register object.
+ */
+void lcd_device_unregister(struct lcd_device *ld)
+{
+	int i;
+
+	if (!ld)
+		return;
+
+	pr_debug("lcd_device_unregister: name=%s\n", ld->class_dev.class_id);
+
+	for (i = 0; i < ARRAY_SIZE (lcd_class_device_attributes); i++)
+		class_device_remove_file (&ld->class_dev,
+					  &lcd_class_device_attributes[i]);
+
+	down (&ld->sem);
+	ld->props = NULL;
+	up (&ld->sem);
+
+	class_device_unregister(&ld->class_dev);
+}
+EXPORT_SYMBOL(lcd_device_unregister);
+
+/**
+ * lcd_device_find - find a LCD device by name.
+ * @name: the name of the LCD object to find.
+ *
+ * The reference counter of the returned object as well as on the module
+ * that implements the backlight functions are incremented.
+ */
+struct lcd_device *lcd_device_find(const char *name)
+{
+	struct lcd_device *ld;
+	struct class_device *class_dev =
+		class_device_find (&lcd_class, name);
+
+	if (unlikely (!class_dev))
+		return NULL;
+
+	ld = lcd_device_get (to_lcd_device (class_dev));
+	class_device_put (class_dev);
+	return ld;
+}
+EXPORT_SYMBOL(lcd_device_find);
+
+/**
+ * lcd_device_get - increment reference counter of a LCD device
+ *   and on the module that implements the LCD device methods.
+ * @ld: the LCD device object.
+ *
+ * Increments the reference counter on both the LCD device and on the
+ * module that implements this LCD device.
+ */
+struct lcd_device *lcd_device_get(struct lcd_device *ld)
+{
+	struct class_device *class_dev = class_device_get (&ld->class_dev);
+
+	if (likely (class_dev)) {
+		down (&ld->sem);
+		if (likely (ld->props && try_module_get (ld->props->owner))) {
+			up (&ld->sem);
+			return ld;
+		}
+		up (&ld->sem);
+
+		class_device_put(class_dev);
+	}
+	return NULL;
+}
+EXPORT_SYMBOL(lcd_device_get);
+
+/**
+ * lcd_device_put - decrement reference counter of a LCD device.
+ * @ld: the LCD device object.
+ *
+ * Decrements the reference counter on both the LCD device and on the
+ * module that implements this LCD device.
+ */
+void lcd_device_put(struct lcd_device *ld)
+{
+	if (ld) {
+		down (&ld->sem);
+		if (ld->props)
+			module_put(ld->props->owner);
+		up (&ld->sem);
+		class_device_put (&ld->class_dev);
+	}
+}
+EXPORT_SYMBOL(lcd_device_put);
+
+static void __exit lcd_class_exit(void)
+{
+	class_unregister(&lcd_class);
+}
+
+static int __init lcd_class_init(void)
+{
+	return class_register(&lcd_class);
+}
+
+/*
+ * if this is compiled into the kernel, we need to ensure that the
+ * class is registered before users of the class try to register lcd's
+ */
+postcore_initcall(lcd_class_init);
+module_exit(lcd_class_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Jamey Hicks <jamey.hicks@hp.com>, Andrew Zabolotny <zap@homelink.ru>");
+MODULE_DESCRIPTION("LCD Lowlevel Control Abstraction");
--- linux-2.6.7-rc3/drivers/video/backlight.c	1970-01-01 03:00:00.000000000 +0300
+++ linux/drivers/video/backlight.c	2004-06-08 02:15:45.000000000 +0400
@@ -0,0 +1,307 @@
+/*
+ * Backlight Lowlevel Control Abstraction
+ *
+ * Copyright (C) 2003,2004 Hewlett-Packard Company
+ *
+ */
+
+#include <linux/version.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/backlight.h>
+#include <linux/notifier.h>
+#include <linux/ctype.h>
+#include <asm/bug.h>
+
+struct notifier_block *backlight_device_chain;
+EXPORT_SYMBOL (backlight_device_chain);
+
+static ssize_t backlight_show_power (struct class_device *cdev, char *buf)
+{
+	int rc;
+	struct backlight_device *bd = to_backlight_device (cdev);
+
+	down (&bd->sem);
+	if (likely (bd->props && bd->props->get_power))
+		rc = sprintf (buf, "%d\n", bd->props->get_power (bd));
+	else
+		rc = -ENXIO;
+	up (&bd->sem);
+
+	return rc;
+}
+
+static ssize_t backlight_store_power(struct class_device *cdev, const char *buf, size_t count)
+{
+	int rc, power;
+	char *endp;
+	struct backlight_device *bd = to_backlight_device (cdev);
+
+	power = simple_strtoul (buf, &endp, 0);
+	if (*endp && !isspace (*endp))
+		return -EINVAL;
+
+	down (&bd->sem);
+	if (likely (bd->props && bd->props->set_power)) {
+		pr_debug("backlight: set power to %d\n", power);
+		bd->props->set_power(bd, power);
+		rc = count;
+	} else
+		rc = -ENXIO;
+	up (&bd->sem);
+
+	return rc;
+}
+
+static ssize_t backlight_show_brightness(struct class_device *cdev, char *buf)
+{
+	int rc;
+	struct backlight_device *bd = to_backlight_device (cdev);
+
+	down (&bd->sem);
+	if (likely (bd->props && bd->props->get_brightness))
+		rc = sprintf (buf, "%d\n", bd->props->get_brightness (bd));
+	else
+		rc = -ENXIO;
+	up (&bd->sem);
+
+	return rc;
+}
+
+static ssize_t backlight_store_brightness(struct class_device *cdev, const char *buf, size_t count)
+{
+	int rc, brightness;
+	char *endp;
+	struct backlight_device *bd = to_backlight_device (cdev);
+
+	brightness = simple_strtoul (buf, &endp, 0);
+	if (*endp && !isspace (*endp))
+		return -EINVAL;
+
+	down (&bd->sem);
+	if (likely (bd->props && bd->props->set_brightness)) {
+		pr_debug("backlight: set brightness to %d\n", brightness);
+		bd->props->set_brightness(bd, brightness);
+		rc = count;
+	} else
+		rc = -ENXIO;
+	up (&bd->sem);
+
+	return rc;
+}
+
+static ssize_t backlight_show_max_brightness(struct class_device *cdev, char *buf)
+{
+	int rc;
+	struct backlight_device *bd = to_backlight_device (cdev);
+
+	down (&bd->sem);
+	if (likely (bd->props))
+		rc = sprintf(buf, "%d\n", bd->props->max_brightness);
+	else
+		rc = -ENXIO;
+	up (&bd->sem);
+
+	return rc;
+}
+
+static void backlight_class_release(struct class_device *dev)
+{
+	struct backlight_device *bd = to_backlight_device (dev);
+	kfree (bd);
+}
+
+struct class backlight_class = {
+	.name = "backlight",
+	.release = backlight_class_release,
+};
+
+#define DECLARE_ATTR(_name,_mode,_show,_store)			\
+	{							 	\
+	.attr	= { .name = __stringify(_name), .mode = _mode, .owner = THIS_MODULE },	\
+	.show	= _show,					\
+	.store	= _store,					\
+	}
+
+static struct class_device_attribute bl_class_device_attributes[] = {
+	DECLARE_ATTR (power, 0644, backlight_show_power, backlight_store_power),
+	DECLARE_ATTR (brightness, 0644, backlight_show_brightness, backlight_store_brightness),
+	DECLARE_ATTR (max_brightness, 0444, backlight_show_max_brightness, NULL),
+};
+
+/**
+ * backlight_device_register - create and register a new object of
+ *   backlight_device class.
+ * @name: the name of the new object (must be the same as the name of the
+ *   respective framebuffer device).
+ * @devdata: an optional pointer to be stored in the class_device. The
+ *   methods may retrieve it by using class_get_devdata (&bd->class_dev).
+ * @bp: the backlight properties structure.
+ * @alloc_bd: (returned) the newly allocated device. Must be used when
+ *   deregistering the device. Not relevant if the procedure does not
+ *   return 0 (success).
+ *
+ * Creates and registers new backlight class_device. Returns either 0 or
+ * the negative errno.
+ */
+int backlight_device_register(const char *name, void *devdata,
+			      struct backlight_properties *bp,
+			      struct backlight_device **alloc_bd)
+{
+	int i, rc;
+	struct backlight_device *new_bd;
+
+	pr_debug("backlight_device_alloc: name=%s\n", name);
+
+	new_bd = kmalloc (sizeof (struct backlight_device), GFP_KERNEL);
+	if (unlikely (!new_bd))
+		return -ENOMEM;
+
+	init_MUTEX (&new_bd->sem);
+	new_bd->props = bp;
+	memset (&new_bd->class_dev, 0, sizeof (new_bd->class_dev));
+	new_bd->class_dev.class = &backlight_class;
+	strlcpy (new_bd->class_dev.class_id, name, KOBJ_NAME_LEN);
+	class_set_devdata (&new_bd->class_dev, devdata);
+
+	rc = class_device_register (&new_bd->class_dev);
+	if (unlikely (rc)) {
+		kfree (new_bd);
+		return rc;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(bl_class_device_attributes); i++) {
+		rc = class_device_create_file(&new_bd->class_dev,
+					      &bl_class_device_attributes[i]);
+		if (unlikely (rc)) {
+			while (--i >= 0)
+				class_device_remove_file(&new_bd->class_dev,
+							 &bl_class_device_attributes[i]);
+			class_device_unregister(&new_bd->class_dev);
+			/* No need to kfree(new_bd) since release() method was called */
+			return rc;
+		}
+	}
+
+	*alloc_bd = new_bd;
+	notifier_call_chain (&backlight_device_chain, 0, new_bd);
+
+	return 0;
+}
+EXPORT_SYMBOL(backlight_device_register);
+
+/**
+ * backlight_device_unregister - unregisters a backlight device object.
+ * @bd: the backlight device object to be unregistered and freed.
+ *
+ * Unregisters a previously registered via backlight_device_register object.
+ */
+void backlight_device_unregister(struct backlight_device *bd)
+{
+	int i;
+
+	if (!bd)
+		return;
+
+	pr_debug("backlight_device_unregister: name=%s\n", bd->class_dev.class_id);
+
+	for (i = 0; i < ARRAY_SIZE(bl_class_device_attributes); i++)
+		class_device_remove_file (&bd->class_dev,
+					  &bl_class_device_attributes[i]);
+
+	down (&bd->sem);
+	bd->props = NULL;
+	up (&bd->sem);
+
+	class_device_unregister(&bd->class_dev);
+}
+EXPORT_SYMBOL(backlight_device_unregister);
+
+/**
+ * backlight_device_find - find a backlight device by name.
+ * @name: the name of the backlight object to find.
+ *
+ * The reference counter of the returned object as well as on the module
+ * that implements the backlight functions are incremented.
+ */
+struct backlight_device *backlight_device_find(const char *name)
+{
+	struct backlight_device *bd;
+	struct class_device *class_dev =
+		class_device_find (&backlight_class, name);
+
+	if (unlikely (!class_dev))
+		return NULL;
+
+	bd = backlight_device_get (to_backlight_device (class_dev));
+	class_device_put (class_dev);
+	return bd;
+}
+EXPORT_SYMBOL(backlight_device_find);
+
+/**
+ * backlight_device_get - increment reference counter of a backlight device
+ *   and on the module that implements the backlight device methods.
+ * @bd: the backlight device object.
+ *
+ * Increments the reference counter on both the backlight device and on the
+ * module that implements this backlight device.
+ */
+struct backlight_device *backlight_device_get(struct backlight_device *bd)
+{
+	struct class_device *class_dev = class_device_get (&bd->class_dev);
+
+	if (likely (class_dev)) {
+		down (&bd->sem);
+		if (likely (bd->props && try_module_get (bd->props->owner))) {
+			up (&bd->sem);
+			return bd;
+		}
+		up (&bd->sem);
+
+		class_device_put(class_dev);
+	}
+	return NULL;
+}
+EXPORT_SYMBOL(backlight_device_get);
+
+/**
+ * backlight_device_put - decrement reference counter of a backlight device.
+ * @ld: the backlight device object.
+ *
+ * Decrements the reference counter on both the backlight device and on the
+ * module that implements this backlight device.
+ */
+void backlight_device_put(struct backlight_device *bd)
+{
+	if (bd) {
+		down (&bd->sem);
+		if (bd->props)
+			module_put(bd->props->owner);
+		up (&bd->sem);
+		class_device_put (&bd->class_dev);
+	}
+}
+EXPORT_SYMBOL(backlight_device_put);
+
+static void __exit backlight_class_exit(void)
+{
+	class_unregister(&backlight_class);
+}
+
+static int __init backlight_class_init(void)
+{
+	return class_register(&backlight_class);
+}
+
+/*
+ * if this is compiled into the kernel, we need to ensure that the
+ * class is registered before users of the class try to register lcd's
+ */
+postcore_initcall(backlight_class_init);
+module_exit(backlight_class_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Jamey Hicks <jamey.hicks@hp.com>, Andrew Zabolotny <zap@homelink.ru>");
+MODULE_DESCRIPTION("Backlight Lowlevel Control Abstraction");
--- linux-2.6.7-rc3/drivers/video/Kconfig	2004-06-11 02:39:30.000000000 +0400
+++ linux/drivers/video/Kconfig	2004-05-29 01:26:15.000000000 +0400
@@ -38,6 +38,38 @@
 	  (e.g. an accelerated X server) and that are not frame buffer
 	  device-aware may cause unexpected results. If unsure, say N.
 
+config LCD_CLASS_DEVICE
+	tristate "Lowlevel LCD controls"
+	depends on FB
+	help
+	  This framework adds support for low-level control of LCD.
+	  Some framebuffer devices connect to platform-specific LCD modules
+	  in order to have a platform-specific way to control the flat panel
+	  (contrast and applying power to the LCD (not to the backlight!)).
+
+	  To have support for your specific LCD panel you will have to
+	  select the proper drivers which depend on this option.
+
+config LCD_DEVICE
+	bool
+	depends on LCD_CLASS_DEVICE
+	default y
+
+config BACKLIGHT_CLASS_DEVICE
+	tristate "Lowlevel Backlight controls"
+	depends on FB
+	help
+	  This framework adds support for low-level control of the LCD
+          backlight. This includes support for brightness and power.
+
+	  To have support for your specific LCD panel you will have to
+	  select the proper drivers which depend on this option.
+
+config BACKLIGHT_DEVICE
+	bool
+	depends on BACKLIGHT_CLASS_DEVICE
+	default y
+
 config FB_CIRRUS
 	tristate "Cirrus Logic support"
 	depends on FB && (AMIGA || PCI) && BROKEN
--- linux-2.6.7-rc3/drivers/video/Makefile	2004-06-11 02:39:30.000000000 +0400
+++ linux/drivers/video/Makefile	2004-05-29 01:23:42.000000000 +0400
@@ -13,6 +13,9 @@
 obj-$(CONFIG_PPC)                 += macmodes.o
 endif
 
+obj-$(CONFIG_LCD_CLASS_DEVICE)    += lcd.o
+obj-$(CONFIG_BACKLIGHT_CLASS_DEVICE) += backlight.o
+
 obj-$(CONFIG_FB_ACORN)            += acornfb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
 obj-$(CONFIG_FB_AMIGA)            += amifb.o c2p.o
 obj-$(CONFIG_FB_PM2)              += pm2fb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
