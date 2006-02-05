Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751774AbWBEPyG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751774AbWBEPyG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 10:54:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751773AbWBEPyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 10:54:05 -0500
Received: from tim.rpsys.net ([194.106.48.114]:40878 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1751772AbWBEPyD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 10:54:03 -0500
Subject: [PATCH 4/12] LED: Add LED Timer Trigger
From: Richard Purdie <rpurdie@rpsys.net>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Sun, 05 Feb 2006 15:52:31 +0000
Message-Id: <1139154752.6438.83.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add an example of a complex LED trigger in the form of a generic timer 
which triggers the LED its attached to at a user specified frequency
and duty cycle.

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>

Index: linux-2.6.15/drivers/leds/Kconfig
===================================================================
--- linux-2.6.15.orig/drivers/leds/Kconfig	2006-01-29 16:13:48.000000000 +0000
+++ linux-2.6.15/drivers/leds/Kconfig	2006-01-29 20:32:16.000000000 +0000
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
 
Index: linux-2.6.15/drivers/leds/Makefile
===================================================================
--- linux-2.6.15.orig/drivers/leds/Makefile	2006-01-29 16:13:48.000000000 +0000
+++ linux-2.6.15/drivers/leds/Makefile	2006-01-29 20:32:16.000000000 +0000
@@ -3,3 +3,6 @@
 obj-$(CONFIG_NEW_LEDS)			+= led-core.o
 obj-$(CONFIG_LEDS_CLASS)		+= led-class.o
 obj-$(CONFIG_LEDS_TRIGGERS)		+= led-triggers.o
+
+# LED Triggers
+obj-$(CONFIG_LEDS_TRIGGER_TIMER)	+= ledtrig-timer.o
Index: linux-2.6.15/drivers/leds/ledtrig-timer.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.15/drivers/leds/ledtrig-timer.c	2006-01-29 17:40:11.000000000 +0000
@@ -0,0 +1,205 @@
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
+	unsigned long duty; /* duty cycle, as a percentage */
+	unsigned long frequency; /* frequency of blinking, in Hz */
+	unsigned long delay_on; /* milliseconds on */
+	unsigned long delay_off; /* milliseconds off */
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
+	write_lock(&led_cdev->lock);
+
+	if (!timer_data->frequency) {
+		led_set_brightness(led_cdev, LED_OFF);
+		write_unlock(&led_cdev->lock);
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
+	write_unlock(&led_cdev->lock);
+}
+
+/* led_cdev write lock needs to be held */
+static int led_timer_setdata(struct led_classdev *led_cdev, unsigned long duty, unsigned long frequency)
+{
+	struct timer_trig_data *timer_data = led_cdev->trigger_data;
+
+	if (frequency > 500)
+		return -EINVAL;
+
+	if (duty > 100)
+		return -EINVAL;
+
+	timer_data->duty = duty;
+	timer_data->frequency = frequency;
+	if (frequency != 0) {
+		timer_data->delay_on = duty * 1000 / 50 / frequency / 2;
+		timer_data->delay_off = (100 - duty) * 1000 / 50 / frequency / 2;
+	}
+
+	mod_timer(&timer_data->timer, jiffies + 1);
+
+	return 0;
+}
+
+static ssize_t led_duty_show(struct class_device *dev, char *buf)
+{
+	struct led_classdev *led_cdev = dev->class_data;
+	struct timer_trig_data *timer_data;
+
+	read_lock(&led_cdev->lock);
+	timer_data = led_cdev->trigger_data;
+	sprintf(buf, "%lu\n", timer_data->duty);
+	read_unlock(&led_cdev->lock);
+
+	return strlen(buf) + 1;
+}
+
+static ssize_t led_duty_store(struct class_device *dev, const char *buf, size_t size)
+{
+	struct led_classdev *led_cdev = dev->class_data;
+	struct timer_trig_data *timer_data;
+	int ret = -EINVAL;
+	char *after;
+
+	unsigned long state = simple_strtoul(buf, &after, 10);
+	if (after - buf > 0) {
+		write_lock(&led_cdev->lock);
+		timer_data = led_cdev->trigger_data;
+		ret = led_timer_setdata(led_cdev, state, timer_data->frequency);
+		if (!ret)
+			ret = after - buf;			
+		write_unlock(&led_cdev->lock);
+	}
+
+	return ret;
+}
+
+
+static ssize_t led_frequency_show(struct class_device *dev, char *buf)
+{
+	struct led_classdev *led_cdev = dev->class_data;
+	struct timer_trig_data *timer_data;
+
+	read_lock(&led_cdev->lock);
+	timer_data = led_cdev->trigger_data;
+	sprintf(buf, "%lu\n", timer_data->frequency);
+	read_unlock(&led_cdev->lock);
+
+	return strlen(buf) + 1;
+}
+
+static ssize_t led_frequency_store(struct class_device *dev, const char *buf, size_t size)
+{
+	struct led_classdev *led_cdev = dev->class_data;
+	struct timer_trig_data *timer_data;
+	int ret = -EINVAL;
+	char *after;
+
+	unsigned long state = simple_strtoul(buf, &after, 10);
+	if (after - buf > 0) {
+		write_lock(&led_cdev->lock);
+		timer_data = led_cdev->trigger_data;
+		ret = led_timer_setdata(led_cdev, timer_data->duty, state);
+		if (!ret)
+			ret = after - buf;			
+		write_unlock(&led_cdev->lock);
+	}
+
+	return ret;
+}
+
+static CLASS_DEVICE_ATTR(duty, 0644, led_duty_show, led_duty_store);
+static CLASS_DEVICE_ATTR(frequency, 0644, led_frequency_show, led_frequency_store);
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
+	timer_data->duty = 50;
+
+	class_device_create_file(led_cdev->class_dev, &class_device_attr_duty);
+	class_device_create_file(led_cdev->class_dev, &class_device_attr_frequency);
+}
+
+static void timer_trig_deactivate(struct led_classdev *led_cdev)
+{
+	struct timer_trig_data *timer_data = led_cdev->trigger_data;
+	if (timer_data) {
+		class_device_remove_file(led_cdev->class_dev, &class_device_attr_duty);
+		class_device_remove_file(led_cdev->class_dev, &class_device_attr_frequency);
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
+static void __exit timer_trig_exit (void)
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


