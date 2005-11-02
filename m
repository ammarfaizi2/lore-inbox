Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964963AbVKBNXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964963AbVKBNXI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 08:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964982AbVKBNXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 08:23:08 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:24724 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964963AbVKBNXG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 08:23:06 -0500
Date: Wed, 2 Nov 2005 14:21:45 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>, rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
Subject: [patch, rfc] LEDs support for collie
Message-ID: <20051102132145.GA14946@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for controlling LEDs on sharp zaurus sl-5500. It may
look a little bit complex, but it probably needs to be complex --
blinking is pretty much mandatory when you only have two leds, and we
want to support charging led (controlled by kernel).

From: John Lenz <lenz@cs.wisc.edu>
Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/drivers/Kconfig b/drivers/Kconfig
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -54,6 +54,8 @@ source "drivers/mfd/Kconfig"
 
 source "drivers/media/Kconfig"
 
+source "drivers/leds/Kconfig"
+
 source "drivers/video/Kconfig"
 
 source "sound/Kconfig"
diff --git a/drivers/Makefile b/drivers/Makefile
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -67,3 +67,4 @@ obj-$(CONFIG_INFINIBAND)	+= infiniband/
 obj-$(CONFIG_SGI_IOC4)		+= sn/
 obj-y				+= firmware/
 obj-$(CONFIG_CRYPTO)		+= crypto/
+obj-$(CONFIG_CLASS_LEDS)	+= leds/
diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
new file mode 100644
--- /dev/null
+++ b/drivers/leds/Kconfig
@@ -0,0 +1,20 @@
+
+menu "LED devices"
+
+config CLASS_LEDS
+	tristate "LED support"
+	depends on EXPERIMENTAL
+	help
+	  This option provides the generic support for the leds class.
+	  LEDs can be accessed from /sys/class/leds.  It will also allow you
+	  to select individual drivers for LED devices.  If unsure, say N.
+
+config LEDS_LOCOMO
+	tristate "LED Support for Locomo device"
+	depends CLASS_LEDS && SHARP_LOCOMO
+	help
+	  This option enables support for the LEDs on Sharp Locomo.
+	  Zaurus models SL-5500 and SL-5600.
+
+endmenu
+
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
new file mode 100644
--- /dev/null
+++ b/drivers/leds/Makefile
@@ -0,0 +1,4 @@
+
+# Core functionality.
+obj-$(CONFIG_CLASS_LEDS)		+= ledscore.o
+obj-$(CONFIG_LEDS_LOCOMO)		+= locomo.o
diff --git a/drivers/leds/ledscore.c b/drivers/leds/ledscore.c
new file mode 100644
--- /dev/null
+++ b/drivers/leds/ledscore.c
@@ -0,0 +1,460 @@
+/*
+ * linux/drivers/leds/ledscore.c
+ *
+ *   Copyright (C) 2005 John Lenz <lenz@cs.wisc.edu>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <linux/device.h>
+#include <linux/sysdev.h>
+#include <linux/timer.h>
+#include <linux/leds.h>
+
+struct led_device {
+	/* This protects the props field.*/
+	spinlock_t lock;
+	/* If props is NULL, the driver that registered this device has been unloaded */
+	struct led_properties *props;
+
+	unsigned long frequency; /* frequency of blinking, in milliseconds */
+	int in_use; /* 1 if this device is in use by the kernel somewhere */
+	
+	struct class_device class_dev;
+	struct timer_list *ktimer;
+	struct list_head node;
+};
+
+#define to_led_device(d) container_of(d, struct led_device, class_dev)
+
+static rwlock_t leds_list_lock = RW_LOCK_UNLOCKED;
+static LIST_HEAD(leds_list);
+static rwlock_t leds_interface_list_lock = RW_LOCK_UNLOCKED;
+static LIST_HEAD(leds_interface_list);
+
+static void leds_class_release(struct class_device *dev)
+{
+	struct led_device *d = to_led_device(dev);
+
+	write_lock(&leds_list_lock);
+		list_del(&d->node);
+	write_unlock(&leds_list_lock);
+	
+	kfree(d);
+}
+
+static struct class leds_class = {
+	.name		= "leds",
+	.release	= leds_class_release,
+};
+
+static void leds_timer_function(unsigned long data)
+{
+	struct led_device *led_dev = (struct led_device *) data;
+	unsigned long delay = 0;
+	
+	spin_lock(&led_dev->lock);
+	if (led_dev->frequency) {
+		delay = led_dev->frequency;
+		if (likely(led_dev->props->brightness_get)) {
+			unsigned long value;
+			if (led_dev->props->brightness_get(led_dev->class_dev.dev, led_dev->props))
+				value = 0;
+			else
+				value = 100;
+			if (likely(led_dev->props->brightness_set))
+				led_dev->props->brightness_set(led_dev->class_dev.dev, led_dev->props, value);
+		}
+	}
+	spin_unlock(&led_dev->lock);
+
+	if (delay)
+		mod_timer(led_dev->ktimer, jiffies + msecs_to_jiffies(delay));
+}
+
+/* This function MUST be called with led_dev->lock held */
+static int leds_enable_timer(struct led_device *led_dev)
+{
+	if (led_dev->frequency && led_dev->ktimer) {
+		/* timer already created, just enable it */
+		mod_timer(led_dev->ktimer, jiffies + msecs_to_jiffies(led_dev->frequency));
+	} else if (led_dev->frequency && led_dev->ktimer == NULL) {
+		/* create a new timer */
+		led_dev->ktimer = kmalloc(sizeof(struct timer_list), GFP_KERNEL);
+		if (led_dev->ktimer) {
+			init_timer(led_dev->ktimer);
+			led_dev->ktimer->function = leds_timer_function;
+			led_dev->ktimer->data = (unsigned long) led_dev;
+			led_dev->ktimer->expires = jiffies + msecs_to_jiffies(led_dev->frequency);
+			add_timer(led_dev->ktimer);
+		} else {
+			led_dev->frequency = 0;
+			return -ENOMEM;
+		}
+	}
+
+	return 0;
+}
+
+
+static ssize_t leds_show_in_use(struct class_device *dev, char *buf)
+{
+	struct led_device *led_dev = to_led_device(dev);
+	ssize_t ret = 0;
+
+	spin_lock(&led_dev->lock);
+	sprintf(buf, "%i\n", led_dev->in_use);
+	ret = strlen(buf) + 1;
+	spin_unlock(&led_dev->lock);
+
+	return ret;
+}
+
+static CLASS_DEVICE_ATTR(in_use, 0444, leds_show_in_use, NULL);
+
+static ssize_t leds_show_color(struct class_device *dev, char *buf)
+{
+	struct led_device *led_dev = to_led_device(dev);
+	ssize_t ret = 0;
+	
+	spin_lock(&led_dev->lock);
+	if (likely(led_dev->props)) {
+		sprintf(buf, "%s\n", led_dev->props->color);
+		ret = strlen(buf) + 1;
+	}
+	spin_unlock(&led_dev->lock);
+
+	return ret;
+}
+
+static CLASS_DEVICE_ATTR(color, 0444, leds_show_color, NULL);
+
+static ssize_t leds_show_current_color(struct class_device *dev, char *buf)
+{
+	struct led_device *led_dev = to_led_device(dev);
+	ssize_t ret = 0;
+
+	spin_lock(&led_dev->lock);
+	if (likely(led_dev->props)) {
+		if (led_dev->props->color_get) {
+			sprintf(buf, "%u\n", led_dev->props->color_get(led_dev->class_dev.dev, led_dev->props));
+			ret = strlen(buf) + 1;
+		}
+	}
+	spin_unlock(&led_dev->lock);
+
+	return ret;
+}
+
+static ssize_t leds_store_current_color(struct class_device *dev, const char *buf, size_t size)
+{
+	struct led_device *led_dev = to_led_device(dev);
+	ssize_t ret = -EINVAL;
+	char *after;
+
+	unsigned long state = simple_strtoul(buf, &after, 10);
+	if (after - buf > 0) {
+		ret = after - buf;
+		spin_lock(&led_dev->lock);
+		if (led_dev->props && !led_dev->in_use) {
+			if (led_dev->props->color_set) 
+				led_dev->props->color_set(led_dev->class_dev.dev, led_dev->props, state);
+		}
+		spin_unlock(&led_dev->lock);
+	}
+
+	return ret;
+}
+
+static CLASS_DEVICE_ATTR(current_color, 0444, leds_show_current_color, leds_store_current_color);
+
+static ssize_t leds_show_brightness(struct class_device *dev, char *buf)
+{
+	struct led_device *led_dev = to_led_device(dev);
+	ssize_t ret = 0;
+
+	spin_lock(&led_dev->lock);
+	if (likely(led_dev->props)) {
+		if (likely(led_dev->props->brightness_get)) {
+			sprintf(buf, "%u\n", 
+				led_dev->props->brightness_get(led_dev->class_dev.dev, led_dev->props));
+			ret = strlen(buf) + 1;
+		}
+	}
+	spin_unlock(&led_dev->lock);
+
+	return ret;
+}
+
+static ssize_t leds_store_brightness(struct class_device *dev, const char *buf, size_t size)
+{
+	struct led_device *led_dev = to_led_device(dev);
+	ssize_t ret = -EINVAL;
+	char *after;
+
+	unsigned long state = simple_strtoul(buf, &after, 10);
+	if (after - buf > 0) {
+		ret = after - buf;
+		spin_lock(&led_dev->lock);
+		if (led_dev->props && !led_dev->in_use) {
+			if (state > 100) state = 100;
+			if (led_dev->props->brightness_set) 
+				led_dev->props->brightness_set(led_dev->class_dev.dev, led_dev->props, state);
+		}
+		spin_unlock(&led_dev->lock);
+	}
+
+	return ret;
+}
+
+static CLASS_DEVICE_ATTR(brightness, 0644, leds_show_brightness, leds_store_brightness);
+
+static ssize_t leds_show_frequency(struct class_device *dev, char *buf)
+{
+	struct led_device *led_dev = to_led_device(dev);
+	ssize_t ret = 0;
+
+	spin_lock(&led_dev->lock);
+	if (likely(led_dev->props)) {
+		sprintf(buf, "%lu\n", led_dev->frequency);
+		ret = strlen(buf) + 1;
+	}
+	spin_unlock(&led_dev->lock);
+
+	return ret;
+}
+
+static ssize_t leds_store_frequency(struct class_device *dev, const char *buf, size_t size)
+{
+	struct led_device *led_dev = to_led_device(dev);
+	int ret = -EINVAL, ret2;
+	char *after;
+
+	unsigned long state = simple_strtoul(buf, &after, 10);
+	if (after - buf > 0) {
+		ret = after - buf;
+		spin_lock(&led_dev->lock);
+		if (led_dev->props && !led_dev->in_use) {
+			led_dev->frequency = state;
+			ret2 = leds_enable_timer(led_dev);
+			if (ret2) ret = ret2;
+		}
+		spin_unlock(&led_dev->lock);
+	}
+
+	return ret;
+}
+
+static CLASS_DEVICE_ATTR(frequency, 0644, leds_show_frequency, leds_store_frequency);
+
+/**
+ * leds_device_register - register a new object of led_device class.
+ * @dev: The device to register.
+ * @prop: the led properties structure for this device.
+ */
+int leds_device_register(struct device *dev, struct led_properties *props)
+{
+	int rc;
+	struct led_device *new_led;
+	struct led_interface *interface;
+
+	new_led = kmalloc (sizeof (struct led_device), GFP_KERNEL);
+	if (unlikely (!new_led))
+		return -ENOMEM;
+
+	memset(new_led, 0, sizeof(struct led_device));
+
+	spin_lock_init(&new_led->lock);
+	new_led->props = props;
+	props->led_dev = new_led;
+
+	new_led->class_dev.class = &leds_class;
+	new_led->class_dev.dev = dev;
+
+	new_led->frequency = 0;
+	new_led->in_use = 0;
+
+	/* assign this led its name */
+	strncpy(new_led->class_dev.class_id, props->name, sizeof(new_led->class_dev.class_id));
+
+	rc = class_device_register (&new_led->class_dev);
+	if (unlikely (rc)) {
+		kfree (new_led);
+		return rc;
+	}
+
+	/* register the attributes */
+	class_device_create_file(&new_led->class_dev, &class_device_attr_in_use);
+	class_device_create_file(&new_led->class_dev, &class_device_attr_color);
+	class_device_create_file(&new_led->class_dev, &class_device_attr_current_color);
+	class_device_create_file(&new_led->class_dev, &class_device_attr_brightness);
+	class_device_create_file(&new_led->class_dev, &class_device_attr_frequency);
+
+	/* add to the list of leds */
+	write_lock(&leds_list_lock);
+		list_add_tail(&new_led->node, &leds_list);
+	write_unlock(&leds_list_lock);
+
+	/* notify any interfaces */
+	read_lock(&leds_interface_list_lock);
+	list_for_each_entry(interface, &leds_interface_list, node) {
+		if (interface->add)
+			interface->add(dev, props);
+	}
+	read_unlock(&leds_interface_list_lock);
+
+	printk(KERN_INFO "Registered led device: number=%s, color=%s\n", new_led->class_dev.class_id, props->color);
+
+	return 0;
+}
+EXPORT_SYMBOL(leds_device_register);
+
+/**
+ * leds_device_unregister - unregisters a object of led_properties class.
+ * @props: the property to unreigister
+ *
+ * Unregisters a previously registered via leds_device_register object.
+ */
+void leds_device_unregister(struct led_properties *props)
+{
+	struct led_device *led_dev;
+	struct led_interface *interface;
+
+	if (!props || !props->led_dev)
+		return;
+
+	led_dev = props->led_dev;
+
+	/* notify interfaces device is going away */
+	read_lock(&leds_interface_list_lock);
+	list_for_each_entry(interface, &leds_interface_list, node) {
+		if (interface->remove)
+			interface->remove(led_dev->class_dev.dev, props);
+	}
+	read_unlock(&leds_interface_list_lock);
+
+	class_device_remove_file (&led_dev->class_dev, &class_device_attr_frequency);
+	class_device_remove_file (&led_dev->class_dev, &class_device_attr_brightness);
+	class_device_remove_file (&led_dev->class_dev, &class_device_attr_current_color);
+	class_device_remove_file (&led_dev->class_dev, &class_device_attr_color);
+	class_device_remove_file (&led_dev->class_dev, &class_device_attr_in_use);
+
+	spin_lock(&led_dev->lock);
+	led_dev->props = NULL;
+	props->led_dev = NULL;
+	spin_unlock(&led_dev->lock);
+
+	if (led_dev->ktimer) {
+		del_timer_sync(led_dev->ktimer);
+		kfree(led_dev->ktimer);
+		led_dev->ktimer = NULL;
+	}
+
+	class_device_unregister(&led_dev->class_dev);
+}
+EXPORT_SYMBOL(leds_device_unregister);
+
+int leds_acquire(struct led_properties *led)
+{
+	int ret = -EBUSY;
+
+	spin_lock(&led->led_dev->lock);
+	if (!led->led_dev->in_use) {
+		led->led_dev->in_use = 1;
+		/* Disable the userspace blinking, if any */
+		led->led_dev->frequency = 0;
+		ret = 0;
+	}
+	spin_unlock(&led->led_dev->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL(leds_acquire);
+	
+void leds_release(struct led_properties *led)
+{
+	spin_lock(&led->led_dev->lock);
+	led->led_dev->in_use = 0;
+	/* Disable the kernel blinking, if any */
+	led->led_dev->frequency = 0;
+	spin_unlock(&led->led_dev->lock);
+}
+EXPORT_SYMBOL(leds_release);
+
+/* Sets the frequency of the led in milliseconds.
+ * Only call this function after leds_acquire returns true
+ */
+int leds_set_frequency(struct led_properties *led, unsigned long frequency)
+{
+	int ret = 0;
+	
+	spin_lock(&led->led_dev->lock);
+	
+	if (!led->led_dev->in_use)
+		return -EINVAL;
+	
+	led->led_dev->frequency = frequency;
+	ret = leds_enable_timer(led->led_dev);
+
+	spin_unlock(&led->led_dev->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL(leds_set_frequency);
+
+int leds_interface_register(struct led_interface *interface)
+{
+	struct led_device *led_dev;
+
+	write_lock(&leds_interface_list_lock);
+	list_add_tail(&interface->node, &leds_interface_list);
+
+	read_lock(&leds_list);
+	list_for_each_entry(led_dev, &leds_list, node) {
+		spin_lock(&led_dev->lock);
+		if (led_dev->props) {
+			interface->add(led_dev->class_dev.dev, led_dev->props);
+		}
+		spin_unlock(&led_dev->lock);
+	}
+	read_unlock(&leds_list);
+
+	write_unlock(&leds_interface_list_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL(leds_interface_register);
+
+void leds_interface_unregister(struct led_interface *interface)
+{
+	write_lock(&leds_interface_list_lock);
+	list_del(&interface->node);
+	write_unlock(&leds_interface_list_lock);
+}
+EXPORT_SYMBOL(leds_interface_unregister);
+
+static int __init leds_init(void)
+{
+	/* initialize the class device */
+	return class_register(&leds_class);
+}
+subsys_initcall(leds_init);
+
+static void __exit leds_exit(void)
+{
+	class_unregister(&leds_class);
+}
+module_exit(leds_exit);
+
+MODULE_AUTHOR("John Lenz");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("LED core class interface");
+
diff --git a/drivers/leds/locomo.c b/drivers/leds/locomo.c
new file mode 100644
--- /dev/null
+++ b/drivers/leds/locomo.c
@@ -0,0 +1,124 @@
+/*
+ * linux/drivers/leds/locomo.c
+ *
+ * Copyright (C) 2005 John Lenz <lenz@cs.wisc.edu>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/leds.h>
+
+#include <asm/hardware.h>
+#include <asm/hardware/locomo.h>
+
+struct locomoled_data {
+	unsigned long		offset;
+	int			registered;
+	int		brightness;
+	struct led_properties	props;
+};
+#define to_locomoled_data(d) container_of(d, struct locomoled_data, props)
+
+int locomoled_brightness_get(struct device *dev, struct led_properties *props)
+{
+	struct locomoled_data *data = to_locomoled_data(props);
+
+	return data->brightness;
+}
+
+void locomoled_brightness_set(struct device *dev, struct led_properties *props, int value)
+{
+	struct locomo_dev *locomo_dev = LOCOMO_DEV(dev);
+	struct locomoled_data *data = to_locomoled_data(props);
+	
+	unsigned long flags;
+
+	if (value < 0) value = 0;
+	data->brightness = value;
+	local_irq_save(flags);
+	if (data->brightness) {
+		data->brightness = 100;
+		locomo_writel(LOCOMO_LPT_TOFH, locomo_dev->mapbase + data->offset);
+	} else
+		locomo_writel(LOCOMO_LPT_TOFL, locomo_dev->mapbase + data->offset);
+	local_irq_restore(flags);
+}
+
+static struct locomoled_data leds[] = {
+	{
+		.offset	= LOCOMO_LPT0,
+		.props	= {
+			.owner		= THIS_MODULE,
+			.name		= "power",
+			.color		= "amber",
+			.brightness_get	= locomoled_brightness_get,
+			.brightness_set	= locomoled_brightness_set,
+			.color_get	= NULL,
+			.color_set	= NULL,
+		}
+	},
+	{
+		.offset	= LOCOMO_LPT1,
+		.props	= {
+			.owner		= THIS_MODULE,
+			.name		= "mail",
+			.color		= "green",
+			.brightness_get	= locomoled_brightness_get,
+			.brightness_set	= locomoled_brightness_set,
+			.color_get	= NULL,
+			.color_set	= NULL,
+		}
+	},
+};
+
+static int locomoled_probe(struct locomo_dev *dev)
+{
+	int i, ret = 0;
+	
+	for (i = 0; i < ARRAY_SIZE(leds); i++) {
+		ret = leds_device_register(&dev->dev, &leds[i].props);
+		leds[i].registered = 1;
+		if (unlikely(ret)) {
+			printk(KERN_WARNING "Unable to register locomo led %s\n", leds[i].props.color);
+			leds[i].registered = 0;
+		}
+	}
+	
+	return ret;
+}
+
+static int locomoled_remove(struct locomo_dev *dev)
+{
+	int i;
+	
+	for (i = 0; i < ARRAY_SIZE(leds); i++) {
+		if (leds[i].registered) {
+			leds_device_unregister(&leds[i].props);
+		}
+	}
+	return 0;
+}
+
+static struct locomo_driver locomoled_driver = {
+	.drv = {
+		.name = "locomoled"
+	},
+	.devid	= LOCOMO_DEVID_LED,
+	.probe	= locomoled_probe,
+	.remove	= locomoled_remove,
+};
+
+static int __init locomoled_init(void) {
+	return locomo_driver_register(&locomoled_driver);
+}
+module_init(locomoled_init);
+
+MODULE_AUTHOR("John Lenz <lenz@cs.wisc.edu>");
+MODULE_DESCRIPTION("Locomo LED driver");
+MODULE_LICENSE("GPL");
new file mode 100644
--- /dev/null
+++ b/include/linux/leds.h
@@ -0,0 +1,63 @@
+/*
+ *  linux/include/leds.h
+ *
+ *  Copyright (C) 2005 John Lenz <lenz@cs.wisc.edu>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Driver model for leds
+ */
+#ifndef ASM_ARM_LEDS_H
+#define ASM_ARM_LEDS_H
+
+#include <linux/device.h>
+
+struct led_device;
+
+struct led_properties {
+	struct module *owner;
+
+	/* Read-only name for this led */
+	char *name;
+	
+	/* Color of the led.  For multiple color leds, the color names should
+	 * be seperated by a "/".  For example, "amber/green".
+	 * This is read-only.
+	 */
+	char *color;
+	
+	/* For multi-colored leds, these function are called to manipulate the
+	 * current color. The integer value should be the position in the above
+	 * list of colors. For a single color led, set equal to NULL.
+	 */
+	int (*color_get)(struct device *, struct led_properties *props);
+	void (*color_set)(struct device *, struct led_properties *props, int value);
+
+	/* These functions manipulate the brightness of the led.
+	 * Values are between 0-100 */
+	int (*brightness_get)(struct device *, struct led_properties *props);
+	void (*brightness_set)(struct device *, struct led_properties *props, int value);
+	
+	/* private structure */
+	struct led_device *led_dev;
+};
+
+int leds_device_register(struct device *dev, struct led_properties *props);
+void leds_device_unregister(struct led_properties *props);
+
+int leds_acquire(struct led_properties *led);
+void leds_release(struct led_properties *led);
+int leds_set_frequency(struct led_properties *led, unsigned long frequency);
+
+struct led_interface {
+	int (*add)(struct device *dev, struct led_properties *led);
+	void (*remove)(struct device *dev, struct led_properties *led);
+
+	struct list_head node;
+};
+int leds_interface_register(struct led_interface *interface);
+void leds_interface_unregister(struct led_interface *interface);
+
+#endif

-- 
Thanks, Sharp!
