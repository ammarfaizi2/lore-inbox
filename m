Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932407AbVLENKW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932407AbVLENKW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 08:10:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbVLENKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 08:10:22 -0500
Received: from tim.rpsys.net ([194.106.48.114]:27063 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S932407AbVLENKT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 08:10:19 -0500
Subject: [RFC PATCH 3/8] LED: Add LED Timer Trigger
From: Richard Purdie <rpurdie@rpsys.net>
To: LKML <linux-kernel@vger.kernel.org>, Russell King <rmk@arm.linux.org.uk>,
       John Lenz <lenz@cs.wisc.edu>, Pavel Machek <pavel@suse.cz>
Content-Type: text/plain
Date: Mon, 05 Dec 2005 13:10:03 +0000
Message-Id: <1133788203.8101.129.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add an example of a complex LED trigger in the form of a generic timer 
which triggers any LED its attached to at a user specified frequency.

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>
Acked-by: Pavel Machek <pavel@suse.cz>

Index: linux-2.6.15-rc2/drivers/leds/trig_timer.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.15-rc2/drivers/leds/trig_timer.c	2005-11-30 15:47:06.000000000 +0000
@@ -0,0 +1,133 @@
+/*
+ * LED Kernel Timer Trigger
+ *
+ * Copyright 2005 Openedhand Ltd.
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
+	unsigned long frequency; /* frequency of blinking, in milliseconds */
+	struct timer_list timer;
+};
+
+static void leds_timer_function(unsigned long data)
+{
+	struct led_device *led_dev = (struct led_device *) data;
+	struct timer_trig_data *timer_data = led_dev->trigger_data;
+	unsigned long value = 0;
+
+	write_lock(&led_dev->lock);
+
+	if (!timer_data->frequency) {
+		leds_set_brightness(led_dev, 0);
+		write_unlock(&led_dev->lock);
+		return;
+	}
+
+	if (!led_dev->brightness)
+		value = 100;
+
+	leds_set_brightness(led_dev, value);
+
+	mod_timer(&timer_data->timer, jiffies + msecs_to_jiffies(timer_data->frequency));
+	write_unlock(&led_dev->lock);
+}
+
+static ssize_t leds_show_frequency(struct class_device *dev, char *buf)
+{
+	struct led_device *led_dev = dev->class_data;
+	struct timer_trig_data *timer_data = led_dev->trigger_data;
+
+	read_lock(&led_dev->lock);
+	sprintf(buf, "%lu\n", timer_data->frequency);
+	read_unlock(&led_dev->lock);
+
+	return strlen(buf) + 1;
+}
+
+static ssize_t leds_store_frequency(struct class_device *dev, const char *buf, size_t size)
+{
+	struct led_device *led_dev = dev->class_data;
+	struct timer_trig_data *timer_data = led_dev->trigger_data;
+	int ret = -EINVAL;
+	char *after;
+
+	unsigned long state = simple_strtoul(buf, &after, 10);
+	if (after - buf > 0) {
+		ret = after - buf;
+		write_lock(&led_dev->lock);
+		timer_data->frequency = state;
+		mod_timer(&timer_data->timer, jiffies + msecs_to_jiffies(timer_data->frequency));
+		write_unlock(&led_dev->lock);
+	}
+
+	return ret;
+}
+
+static CLASS_DEVICE_ATTR(frequency, 0644, leds_show_frequency, leds_store_frequency);
+
+void timer_trig_activate(struct led_device *led_dev)
+{
+	struct timer_trig_data *timer_data;
+
+	timer_data = kmalloc(sizeof(struct timer_trig_data), GFP_KERNEL);
+	if (!timer_data)
+		return;
+
+	led_dev->trigger_data = timer_data;
+	timer_data->frequency = 0;
+
+	init_timer(&timer_data->timer);
+	timer_data->timer.function = leds_timer_function;
+	timer_data->timer.data = (unsigned long) led_dev;
+	timer_data->timer.expires = 0;
+
+	class_device_create_file(led_dev->class_dev, &class_device_attr_frequency);
+}
+
+void timer_trig_deactivate(struct led_device *led_dev)
+{
+	struct timer_trig_data *timer_data = led_dev->trigger_data;
+	if (timer_data) {
+		class_device_remove_file(led_dev->class_dev, &class_device_attr_frequency);
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
Index: linux-2.6.15-rc2/drivers/leds/Kconfig
===================================================================
--- linux-2.6.15-rc2.orig/drivers/leds/Kconfig	2005-11-30 15:46:48.000000000 +0000
+++ linux-2.6.15-rc2/drivers/leds/Kconfig	2005-11-30 15:47:37.000000000 +0000
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
 
Index: linux-2.6.15-rc2/drivers/leds/Makefile
===================================================================
--- linux-2.6.15-rc2.orig/drivers/leds/Makefile	2005-11-30 15:46:56.000000000 +0000
+++ linux-2.6.15-rc2/drivers/leds/Makefile	2005-11-30 15:47:29.000000000 +0000
@@ -3,3 +3,6 @@
 obj-$(CONFIG_NEW_LEDS)			+= led_core.o
 obj-$(CONFIG_LEDS_CLASS)		+= led_class.o
 obj-$(CONFIG_LEDS_TRIGGERS)		+= led_triggers.o
+
+# LED Triggers
+obj-$(CONFIG_LEDS_TRIGGER_TIMER)	+= trig_timer.o


