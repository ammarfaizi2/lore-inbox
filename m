Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269031AbUICDB6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269031AbUICDB6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 23:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269036AbUIBUiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 16:38:14 -0400
Received: from hagen.doit.wisc.edu ([144.92.197.163]:39929 "EHLO
	smtp7.wiscmail.wisc.edu") by vger.kernel.org with ESMTP
	id S269050AbUIBUfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 16:35:12 -0400
Date: Thu, 02 Sep 2004 20:34:36 +0000
From: John Lenz <lenz@cs.wisc.edu>
Subject: Re: [PATCH 2.6.8.1 1/2] leds: new class for led devices
In-reply-to: <1094157190l.4235l.2l@hydra>
To: linux-kernel@vger.kernel.org
Message-id: <1094157276l.4235l.3l@hydra>
MIME-version: 1.0
X-Mailer: Balsa 2.2.4
Content-type: multipart/mixed; boundary="Boundary_(ID_yfj1Qw4fzBMqTYSDaFPRKA)"
X-Spam-Score: 
X-Spam-Report: IsSpam=no, Probability=7%, Hits=__CT 0, __CTYPE_HAS_BOUNDARY 0,
 __CTYPE_MULTIPART 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __MIME_VERSION 0,
 __SANE_MSGID 0
X-Spam-PmxInfo: Server=avs-6, Version=4.7.0.111621, Antispam-Engine: 2.0.0.0,
 Antispam-Data: 2004.9.2.0, SenderIP=146.151.41.63
References: <1094157190l.4235l.2l@hydra>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary_(ID_yfj1Qw4fzBMqTYSDaFPRKA)
Content-type: text/plain; charset=ISO-8859-1; DelSp=Yes; Format=Flowed
Content-transfer-encoding: 7BIT
Content-disposition: inline

This provides the base ledscore.c support.

Signed-off-by: John Lenz <lenz@cs.wisc.edu>

--Boundary_(ID_yfj1Qw4fzBMqTYSDaFPRKA)
Content-type: text/x-patch; charset=us-ascii; name=leds_sysfs.patch
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=leds_sysfs.patch


#
# Patch managed by http://www.holgerschurig.de/patcher.html
#

--- /dev/null
+++ linux/drivers/leds/ledscore.c
@@ -0,0 +1,314 @@
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
+#define LEDS_TIMER_INTERVAL (HZ * 5)
+
+struct led_device {
+	/* This protects the props field.*/
+	spinlock_t lock;
+	/* If props is NULL, the driver that registered this device has been unloaded */
+	struct led_properties *props;
+	struct class_device class_dev;
+	struct list_head list;
+};
+
+#define to_led_device(d) container_of(d, struct led_device, class_dev)
+
+static rwlock_t leds_list_lock = RW_LOCK_UNLOCKED;
+static LIST_HEAD(leds_list);
+static atomic_t leds_count = ATOMIC_INIT(0);
+
+struct leds_function_name {
+	const char *		name;
+	enum led_functions	function;
+};
+static const struct leds_function_name leds_function_names[] = {
+	{ "user",	leds_user },
+	{ "timer",	leds_timer },
+	{ "idle",	leds_idle },
+	{ "power",	leds_power },
+};
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
+			if (led_dev->props->function == leds_user) {
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
+static ssize_t leds_show_function(struct class_device *dev, char *buf)
+{
+	struct led_device *led_dev = to_led_device(dev);
+	ssize_t ret = 0;
+
+	spin_lock(&led_dev->lock);
+	if (likely(led_dev->props)) {
+		sprintf(buf, "%s\n", leds_function_names[(int)led_dev->props->function].name);
+		ret = strlen(buf) + 1;
+	}
+	spin_unlock(&led_dev->lock);
+
+	return ret;
+}
+
+static ssize_t leds_store_function(struct class_device *dev, const char *buf, size_t size)
+{
+	struct led_device *led_dev = to_led_device(dev);
+	int ret = -EINVAL;
+	int i;
+	
+	for (i = 0; i < ARRAY_SIZE(leds_function_names); i++) {
+		if (strncmp(buf, leds_function_names[i].name, strlen(leds_function_names[i].name)) == 0) {
+			ret = size;
+			spin_lock(&led_dev->lock);
+			if (likely(led_dev->props)) {
+				led_dev->props->function = leds_function_names[i].function;
+			}
+			spin_unlock(&led_dev->lock);
+		}
+	}
+
+	return ret;
+}
+
+static CLASS_DEVICE_ATTR(function, 0644, leds_show_function, leds_store_function);
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
+	spin_lock_init(&new_led->lock);
+	new_led->props = props;
+	props->led_dev = new_led;
+
+	memset (&new_led->class_dev, 0, sizeof (new_led->class_dev));
+	new_led->class_dev.class = &leds_class;
+	new_led->class_dev.dev = dev;
+
+	/* assign this led a number */
+	num = atomic_add_return(1, &leds_count);
+	sprintf(new_led->class_dev.class_id, "%i", num);
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
+	class_device_create_file(&new_led->class_dev, &class_device_attr_function);
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
+ * led_device_unregister - unregisters a object of led_properties class.
+ * @props: the property to unreigister
+ *
+ * Unregisters a previously registered via led_device_register object.
+ */
+void leds_device_unregister(struct led_properties *props)
+{
+	struct led_device *led_dev;
+	if (!props)
+		return;
+
+	pr_debug("led_device_unregister: color=%s\n", props->color);
+
+	led_dev = props->led_dev;
+
+	class_device_remove_file (&led_dev->class_dev, &class_device_attr_function);
+	class_device_remove_file (&led_dev->class_dev, &class_device_attr_light);
+	class_device_remove_file (&led_dev->class_dev, &class_device_attr_color);
+
+	spin_lock(&led_dev->lock);
+	led_dev->props = NULL;
+	props->led_dev = NULL;
+	spin_unlock(&led_dev->lock);
+
+	class_device_unregister(&led_dev->class_dev);
+}
+EXPORT_SYMBOL(leds_device_unregister);
+
+/* set up a kernel timer */
+static struct timer_list	leds_ktimer;
+static atomic_t 		leds_stop_timer = ATOMIC_INIT(0);
+
+static void leds_timer_function(unsigned long data)
+{
+	struct led_device *led_dev;
+
+	read_lock(&leds_list_lock);
+	list_for_each_entry(led_dev, &leds_list, list) {
+		spin_lock(&led_dev->lock);
+		if (likely(led_dev->props)) {
+			if (led_dev->props->function == leds_timer) {
+				led_dev->props->light_state = !led_dev->props->light_state;
+				if (led_dev->props->light) 
+					led_dev->props->light(led_dev->class_dev.dev, led_dev->props);
+			}
+		}
+		spin_unlock(&led_dev->lock);
+	}
+	read_unlock(&leds_list_lock);
+
+	if (!atomic_read(&leds_stop_timer))
+		mod_timer(&leds_ktimer, jiffies + LEDS_TIMER_INTERVAL);
+}
+
+/* arch code should call this function from the idle thread */
+void leds_idle_function(int state)
+{
+	struct led_device *led_dev;
+
+	read_lock(&leds_list_lock);
+	list_for_each_entry(led_dev, &leds_list, list) {
+		spin_lock(&led_dev->lock);
+		if (likely(led_dev->props)) {
+			if (led_dev->props->function == leds_idle) {
+				led_dev->props->light_state = state;
+				if (led_dev->props->light) 
+					led_dev->props->light(led_dev->class_dev.dev, led_dev->props);
+			}
+		}
+		spin_unlock(&led_dev->lock);
+	}
+	read_unlock(&leds_list_lock);
+}
+
+static int __init leds_init(void)
+{
+	int ret = 0;
+
+	/* initialize the class device */
+	class_register(&leds_class);
+
+	/* register the timer */
+	init_timer(&leds_ktimer);
+	leds_ktimer.function = leds_timer_function;
+	leds_ktimer.data = 0;
+	leds_ktimer.expires = jiffies + LEDS_TIMER_INTERVAL;
+	add_timer(&leds_ktimer);
+	
+	return ret;
+}
+subsys_initcall(leds_init);
+
+static void __exit leds_exit(void)
+{
+	class_unregister(&leds_class);
+
+	atomic_set(&leds_stop_timer, 1);
+	
+	del_timer_sync(&leds_ktimer);
+}
+module_exit(leds_exit);
+
+MODULE_AUTHOR("John Lenz <lenz@cs.wisc.edu>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("LED core class interface");
+
--- /dev/null
+++ linux/include/linux/leds.h
@@ -0,0 +1,53 @@
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
+enum led_functions {
+	leds_user = 0,	/* user has control of this led through sysfs */
+	leds_timer,	/* led blinks on a timer */
+	leds_idle,	/* led is on when the system is not idle */
+	leds_power,
+};
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
+	/* current function of this led */
+	enum led_functions function;
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


--Boundary_(ID_yfj1Qw4fzBMqTYSDaFPRKA)--
