Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266233AbUIVFIq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266233AbUIVFIq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 01:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266357AbUIVFIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 01:08:46 -0400
Received: from fafner.doit.wisc.edu ([144.92.197.155]:53952 "EHLO
	smtp6.wiscmail.wisc.edu") by vger.kernel.org with ESMTP
	id S266233AbUIVFHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 01:07:54 -0400
Date: Wed, 22 Sep 2004 05:07:21 +0000
From: John Lenz <lenz@cs.wisc.edu>
Subject: [PATCH] new class for led devices
To: linux-kernel@vger.kernel.org
Message-id: <1095829641l.11731l.0l@hydra>
MIME-version: 1.0
X-Mailer: Balsa 2.2.4
Content-type: multipart/mixed; boundary="Boundary_(ID_1IVxCuzE3SItSo48fBjJiw)"
X-Spam-Score: 
X-Spam-Report: IsSpam=no, Probability=7%, Hits=__CT 0, __CTYPE_HAS_BOUNDARY 0,
 __CTYPE_MULTIPART 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __MIME_VERSION 0,
 __SANE_MSGID 0
X-Spam-PmxInfo: Server=avs-3, Version=4.7.0.111621, Antispam-Engine: 2.0.0.0,
 Antispam-Data: 2004.9.21.6, SenderIP=146.151.41.63
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary_(ID_1IVxCuzE3SItSo48fBjJiw)
Content-type: text/plain; charset=ISO-8859-1; DelSp=Yes; Format=Flowed
Content-transfer-encoding: 7BIT
Content-disposition: inline

This is an attempt to provide an alternative to the current arm  
specific led interface that is generic for all arches and uses the "one  
value, one file" idea of sysfs.

I removed the function attribute that was in the previous patch, and  
added the ability for userspace to control the timer on each led  
individually.  Userspace can also set the delay in milliseconds for the  
blink.

John

--Boundary_(ID_1IVxCuzE3SItSo48fBjJiw)
Content-type: text/x-patch; charset=us-ascii; name=leds_sysfs.patch
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=leds_sysfs.patch

A new class that drivers can register a leds_properties structure.  
Each led that is registered is assigned a number, and three attributes 
are exported to sysfs in /sys/class/leds/1/, /sys/class/ leds/2, etc.

- color: a read only attribute which contains the color of this led.  
If this led is a multi color led, the possible colors will be seperated 
by a "/" (ex. "red/green").

- heartbeat: a read/write attribute that controls the heartbeat of this 
led.  If heartbeat=0, then this led is controlled by userspace.  
Otherwise, heartbeat gives the time in milliseconds to delay between 
light changes.

- light: a read/write attribute that controls the actual light.  If 
heartbeat <> 0, then writing to this attribute is ignored.  If 
heartbeat = 0, then writing an integer to this attribute will turn the 
led off or on.  0 means off, 1 means light the first color, 2 means 
light the second color, etc.  (2,3,etc only make sense if this is a 
multi color led, which you can tell from color="red/green").  Reading 
from this attribute will display the current status of the led, 
regardless of heartbeat.

Signed-off-by: John Lenz <lenz@cs.wisc.edu>

--- /dev/null
+++ linux/drivers/leds/ledscore.c
@@ -0,0 +1,293 @@
+/*
+ * linux/drivers/leds/ledscore.c
+ *
+ *   Copyright (C) 2004 John Lenz <lenz@cs.wisc.edu>
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
+	struct class_device class_dev;
+	struct timer_list *ktimer;
+	struct list_head list;
+};
+
+#define to_led_device(d) container_of(d, struct led_device, class_dev)
+
+static rwlock_t leds_list_lock = RW_LOCK_UNLOCKED;
+static LIST_HEAD(leds_list);
+static atomic_t leds_count = ATOMIC_INIT(0);
+
+static void leds_class_release(struct class_device *dev)
+{
+	struct led_device *d = to_led_device(dev);
+
+	write_lock(&leds_list_lock);
+		list_del(&d->list);
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
+	if (led_dev->props->heartbeat) {
+		delay = led_dev->props->heartbeat;
+		led_dev->props->light_state = !led_dev->props->light_state;
+		if (led_dev->props->light)
+			led_dev->props->light(led_dev->class_dev.dev, led_dev->props);
+	}
+	spin_unlock(&led_dev->lock);
+
+	if (delay)
+		mod_timer(led_dev->ktimer, jiffies + msecs_to_jiffies(delay));
+}
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
+static ssize_t leds_show_light(struct class_device *dev, char *buf)
+{
+	struct led_device *led_dev = to_led_device(dev);
+	ssize_t ret = 0;
+
+	spin_lock(&led_dev->lock);
+	if (likely(led_dev->props)) {
+		sprintf(buf, "%lu\n", led_dev->props->light_state);
+		ret = strlen(buf) + 1;
+	}
+	spin_unlock(&led_dev->lock);
+
+	return ret;
+}
+
+static ssize_t leds_store_light(struct class_device *dev, const char *buf, size_t size)
+{
+	struct led_device *led_dev = to_led_device(dev);
+	int ret = -EINVAL;
+	char *after;
+
+	unsigned long state = simple_strtoul(buf, &after, 10);
+	if (after - buf > 0) {
+		ret = after - buf;
+		spin_lock(&led_dev->lock);
+		if (likely(led_dev->props)) {
+			if (!led_dev->props->heartbeat) {
+				led_dev->props->light_state = state;
+				if (led_dev->props->light) 
+					led_dev->props->light(led_dev->class_dev.dev, led_dev->props);
+			}
+		}
+		spin_unlock(&led_dev->lock);
+	}
+
+	return ret;
+}
+
+static CLASS_DEVICE_ATTR(light, 0644, leds_show_light, leds_store_light);
+
+static ssize_t leds_show_heartbeat(struct class_device *dev, char *buf)
+{
+	struct led_device *led_dev = to_led_device(dev);
+	ssize_t ret = 0;
+
+	spin_lock(&led_dev->lock);
+	if (likely(led_dev->props)) {
+		sprintf(buf, "%lu\n", led_dev->props->heartbeat);
+		ret = strlen(buf) + 1;
+	}
+	spin_unlock(&led_dev->lock);
+
+	return ret;
+}
+
+static ssize_t leds_store_heartbeat(struct class_device *dev, const char *buf, size_t size)
+{
+	struct led_device *led_dev = to_led_device(dev);
+	int ret = -EINVAL;
+	char *after;
+
+	unsigned long state = simple_strtoul(buf, &after, 10);
+	if (after - buf > 0) {
+		ret = after - buf;
+		spin_lock(&led_dev->lock);
+		if (likely(led_dev->props)) {
+			led_dev->props->heartbeat = state;
+			if (led_dev->props->heartbeat && led_dev->ktimer) {
+				/* timer already created, just enable it */
+				mod_timer(led_dev->ktimer, jiffies + msecs_to_jiffies(led_dev->props->heartbeat));
+			} else if (led_dev->props->heartbeat && led_dev->ktimer == NULL) {
+				/* create a new timer */
+				led_dev->ktimer = kmalloc(sizeof(struct timer_list), GFP_KERNEL);
+				if (led_dev->ktimer) {
+					init_timer(led_dev->ktimer);
+					led_dev->ktimer->function = leds_timer_function;
+					led_dev->ktimer->data = (unsigned long) led_dev;
+					led_dev->ktimer->expires = jiffies + msecs_to_jiffies(led_dev->props->heartbeat);
+					add_timer(led_dev->ktimer);
+				} else {
+					led_dev->props->heartbeat = 0;
+					ret = -ENOMEM;
+				}
+			}
+		}
+		spin_unlock(&led_dev->lock);
+	}
+
+	return ret;
+}
+
+static CLASS_DEVICE_ATTR(heartbeat, 0644, leds_show_heartbeat, leds_store_heartbeat);
+
+/**
+ * leds_device_register - register a new object of led_device class.
+ * @dev: The device to register.
+ * @prop: the led properties structure for this device.
+ */
+int leds_device_register(struct device *dev, struct led_properties *props)
+{
+	int rc, num;
+	struct led_device *new_led;
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
+	/* assign this led a number */
+	num = atomic_add_return(1, &leds_count);
+	sprintf(new_led->class_dev.class_id, "%i", num);
+
+	if (props->heartbeat) {
+		/* create a new timer */
+		new_led->ktimer = kmalloc(sizeof(struct timer_list), GFP_KERNEL);
+		if (new_led->ktimer) {
+			init_timer(new_led->ktimer);
+			new_led->ktimer->function = leds_timer_function;
+			new_led->ktimer->data = (unsigned long) new_led;
+			new_led->ktimer->expires = jiffies + msecs_to_jiffies(props->heartbeat);
+			add_timer(new_led->ktimer);
+		}
+	}
+
+	rc = class_device_register (&new_led->class_dev);
+	if (unlikely (rc)) {
+		kfree (new_led);
+		return rc;
+	}
+
+	/* register the attributes */
+	class_device_create_file(&new_led->class_dev, &class_device_attr_color);
+	class_device_create_file(&new_led->class_dev, &class_device_attr_light);
+	class_device_create_file(&new_led->class_dev, &class_device_attr_heartbeat);
+
+	/* add to the list of leds */
+	write_lock(&leds_list_lock);
+		list_add_tail(&new_led->list, &leds_list);
+	write_unlock(&leds_list_lock);
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
+	if (!props || !props->led_dev)
+		return;
+
+	led_dev = props->led_dev;
+
+	class_device_remove_file (&led_dev->class_dev, &class_device_attr_heartbeat);
+	class_device_remove_file (&led_dev->class_dev, &class_device_attr_light);
+	class_device_remove_file (&led_dev->class_dev, &class_device_attr_color);
+
+	spin_lock(&led_dev->lock);
+	led_dev->props = NULL;
+	props->led_dev = NULL;
+	props->heartbeat = 0;
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
--- /dev/null
+++ linux/include/linux/leds.h
@@ -0,0 +1,46 @@
+/*
+ *  linux/include/leds.h
+ *
+ *  Copyright (C) 2004 John Lenz <lenz@cs.wisc.edu>
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
+	/* Color of the led.  For multiple color leds, the color names should
+	 * be seperated by a "/".  For example, "amber/green".
+	 */
+	char *color;
+	
+	/* current state of this led.
+	 * 0 = off, 1,2,3,... = on, where the number is the posision in the list
+	 * of colors given above.
+	 */
+	unsigned long light_state;
+
+	/* heartbeat time in milliseconds of this led */
+	unsigned long heartbeat;
+
+	/* This function is called after the light_state property is changed. */
+	void (*light)(struct device *, struct led_properties *props);
+	
+	/* private structure */
+	struct led_device *led_dev;
+};
+
+int leds_device_register(struct device *dev, struct led_properties *props);
+void leds_device_unregister(struct led_properties *props);
+
+#endif
--- /dev/null
+++ linux/drivers/leds/Kconfig
@@ -0,0 +1,11 @@
+
+menu "LED devices"
+
+config CLASS_LEDS
+	tristate "LED support"
+	help
+	  This option provides the generic support for the leds class.
+	  LEDs can be accessed from /sys/class/leds.  It will also allow you
+	  to select individual drivers for LED devices.  If unsure, say N.
+
+endmenu
--- /dev/null
+++ linux/drivers/leds/Makefile
@@ -0,0 +1,3 @@
+
+# Core functionality.
+obj-$(CONFIG_CLASS_LEDS)		+= ledscore.o
--- linux/drivers/Kconfig~leds_sysfs
+++ linux/drivers/Kconfig
@@ -48,6 +48,8 @@
 
 source "drivers/media/Kconfig"
 
+source "drivers/leds/Kconfig"
+
 source "drivers/video/Kconfig"
 
 source "sound/Kconfig"
--- linux/drivers/Makefile~leds_sysfs
+++ linux/drivers/Makefile
@@ -50,4 +50,5 @@
 obj-$(CONFIG_MCA)		+= mca/
 obj-$(CONFIG_EISA)		+= eisa/
 obj-$(CONFIG_CPU_FREQ)		+= cpufreq/
+obj-$(CONFIG_CLASS_LEDS)	+= leds/
 obj-y				+= firmware/


--Boundary_(ID_1IVxCuzE3SItSo48fBjJiw)--
