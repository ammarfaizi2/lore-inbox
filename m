Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932495AbWC2ARw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932495AbWC2ARw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 19:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932497AbWC2ARc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 19:17:32 -0500
Received: from tim.rpsys.net ([194.106.48.114]:14012 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S932495AbWC2AR3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 19:17:29 -0500
Subject: [PATCH -mm 3/4] LED: Add LED Timer Trigger
From: Richard Purdie <rpurdie@rpsys.net>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 29 Mar 2006 01:17:21 +0100
Message-Id: <1143591441.14682.59.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Richard Purdie <rpurdie@rpsys.net>

Add an example of a complex LED trigger in the form of a generic timer which
triggers the LED its attached to at a user specified frequency and duty cycle.

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>

Index: linux-2.6.16/drivers/leds/Kconfig
===================================================================
--- linux-2.6.16.orig/drivers/leds/Kconfig	2006-03-28 13:37:34.000000000 +0100
+++ linux-2.6.16/drivers/leds/Kconfig	2006-03-28 13:38:35.000000000 +0100
@@ -22,5 +22,12 @@
 	  These triggers allow kernel events to drive the LEDs and can
 	  be configured via sysfs. If unsure, say Y.
 
+config LEDS_TRIGGER_TIMER
+	tristate "LED Timer Trigger"
+	depends LEDS_TRIGGERS
+	help
+	  This allows LEDs to be controlled by a programmable timer
+	  via sysfs. If unsure, say Y.
+
 endmenu
 
Index: linux-2.6.16/drivers/leds/ledtrig-timer.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.16/drivers/leds/ledtrig-timer.c	2006-03-28 13:38:35.000000000 +0100
@@ -0,0 +1,170 @@
+/*
+ * LED Kernel Timer Trigger
+ *
+ * Copyright 2005-2006 Openedhand Ltd.
+ *
+ * Author: Richard Purdie <rpurdie@openedhand.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
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
+#include "leds.h"
+
+struct timer_trig_data {
+	unsigned long delay_on;		/* milliseconds on */
+	unsigned long delay_off;	/* milliseconds off */
+	struct timer_list timer;
+};
+
+static void led_timer_function(unsigned long data)
+{
+	struct led_classdev *led_cdev = (struct led_classdev *) data;
+	struct timer_trig_data *timer_data = led_cdev->trigger_data;
+	unsigned long brightness = LED_OFF;
+	unsigned long delay = timer_data->delay_off;
+
+	if (!timer_data->delay_on || !timer_data->delay_off) {
+		led_set_brightness(led_cdev, LED_OFF);
+		return;
+	}
+
+	if (!led_cdev->brightness) {
+		brightness = LED_FULL;
+		delay = timer_data->delay_on;
+	}
+
+	led_set_brightness(led_cdev, brightness);
+
+	mod_timer(&timer_data->timer, jiffies + msecs_to_jiffies(delay));
+}
+
+static ssize_t led_delay_on_show(struct class_device *dev, char *buf)
+{
+	struct led_classdev *led_cdev = class_get_devdata(dev);
+	struct timer_trig_data *timer_data = led_cdev->trigger_data;
+
+	sprintf(buf, "%lu\n", timer_data->delay_on);
+
+	return strlen(buf) + 1;
+}
+
+static ssize_t led_delay_on_store(struct class_device *dev, const char *buf,
+				size_t size)
+{
+	struct led_classdev *led_cdev = class_get_devdata(dev);
+	struct timer_trig_data *timer_data = led_cdev->trigger_data;
+	int ret = -EINVAL;
+	char *after;
+	unsigned long state = simple_strtoul(buf, &after, 10);
+
+	if (after - buf > 0) {
+		timer_data->delay_on = state;
+		mod_timer(&timer_data->timer, jiffies + 1);
+		ret = after - buf;
+	}
+
+	return ret;
+}
+
+static ssize_t led_delay_off_show(struct class_device *dev, char *buf)
+{
+	struct led_classdev *led_cdev = class_get_devdata(dev);
+	struct timer_trig_data *timer_data = led_cdev->trigger_data;
+
+	sprintf(buf, "%lu\n", timer_data->delay_off);
+
+	return strlen(buf) + 1;
+}
+
+static ssize_t led_delay_off_store(struct class_device *dev, const char *buf,
+				size_t size)
+{
+	struct led_classdev *led_cdev = class_get_devdata(dev);
+	struct timer_trig_data *timer_data = led_cdev->trigger_data;
+	int ret = -EINVAL;
+	char *after;
+	unsigned long state = simple_strtoul(buf, &after, 10);
+
+	if (after - buf > 0) {
+		timer_data->delay_off = state;
+		mod_timer(&timer_data->timer, jiffies + 1);
+		ret = after - buf;
+	}
+
+	return ret;
+}
+
+static CLASS_DEVICE_ATTR(delay_on, 0644, led_delay_on_show,
+			led_delay_on_store);
+static CLASS_DEVICE_ATTR(delay_off, 0644, led_delay_off_show,
+			led_delay_off_store);
+
+static void timer_trig_activate(struct led_classdev *led_cdev)
+{
+	struct timer_trig_data *timer_data;
+
+	timer_data = kzalloc(sizeof(struct timer_trig_data), GFP_KERNEL);
+	if (!timer_data)
+		return;
+
+	led_cdev->trigger_data = timer_data;
+
+	init_timer(&timer_data->timer);
+	timer_data->timer.function = led_timer_function;
+	timer_data->timer.data = (unsigned long) led_cdev;
+
+	class_device_create_file(led_cdev->class_dev,
+				&class_device_attr_delay_on);
+	class_device_create_file(led_cdev->class_dev,
+				&class_device_attr_delay_off);
+}
+
+static void timer_trig_deactivate(struct led_classdev *led_cdev)
+{
+	struct timer_trig_data *timer_data = led_cdev->trigger_data;
+
+	if (timer_data) {
+		class_device_remove_file(led_cdev->class_dev,
+					&class_device_attr_delay_on);
+		class_device_remove_file(led_cdev->class_dev,
+					&class_device_attr_delay_off);
+		del_timer_sync(&timer_data->timer);
+		kfree(timer_data);
+	}
+}
+
+static struct led_trigger timer_led_trigger = {
+	.name     = "timer",
+	.activate = timer_trig_activate,
+	.deactivate = timer_trig_deactivate,
+};
+
+static int __init timer_trig_init(void)
+{
+	return led_trigger_register(&timer_led_trigger);
+}
+
+static void __exit timer_trig_exit(void)
+{
+	led_trigger_unregister(&timer_led_trigger);
+}
+
+module_init(timer_trig_init);
+module_exit(timer_trig_exit);
+
+MODULE_AUTHOR("Richard Purdie <rpurdie@openedhand.com>");
+MODULE_DESCRIPTION("Timer LED trigger");
+MODULE_LICENSE("GPL");
Index: linux-2.6.16/drivers/leds/Makefile
===================================================================
--- linux-2.6.16.orig/drivers/leds/Makefile	2006-03-28 13:37:34.000000000 +0100
+++ linux-2.6.16/drivers/leds/Makefile	2006-03-28 13:38:35.000000000 +0100
@@ -3,3 +3,6 @@
 obj-$(CONFIG_NEW_LEDS)			+= led-core.o
 obj-$(CONFIG_LEDS_CLASS)		+= led-class.o
 obj-$(CONFIG_LEDS_TRIGGERS)		+= led-triggers.o
+
+# LED Triggers
+obj-$(CONFIG_LEDS_TRIGGER_TIMER)	+= ledtrig-timer.o


