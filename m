Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751759AbWBEPwu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751759AbWBEPwu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 10:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751770AbWBEPwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 10:52:50 -0500
Received: from tim.rpsys.net ([194.106.48.114]:35502 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1751759AbWBEPwt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 10:52:49 -0500
Subject: [PATCH 3/12] LED: Add LED Trigger Support
From: Richard Purdie <rpurdie@rpsys.net>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Sun, 05 Feb 2006 15:52:25 +0000
Message-Id: <1139154745.6438.82.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for LED triggers to the LED subsystem. "Triggers" are events 
which change the state of an LED. Two kinds of trigger are available,
simple ones which can be added to exising code with minimum disruption
and complex ones for implementing new or more complex functionality.

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>

Index: linux-2.6.15/drivers/leds/Kconfig
===================================================================
--- linux-2.6.15.orig/drivers/leds/Kconfig	2006-01-29 15:52:16.000000000 +0000
+++ linux-2.6.15/drivers/leds/Kconfig	2006-01-29 16:02:35.000000000 +0000
@@ -14,5 +14,13 @@
 	  This option enables the led sysfs class in /sys/class/leds.  You'll
 	  need this to do anything useful with LEDs.  If unsure, say N.
 
+config LEDS_TRIGGERS
+	bool "LED Trigger support"
+	depends NEW_LEDS
+	help
+	  This option enables trigger support for the leds class.
+	  These triggers allow kernel events to drive the LEDs and can
+	  be configured via sysfs. If unsure, say Y.
+
 endmenu
 
Index: linux-2.6.15/drivers/leds/Makefile
===================================================================
--- linux-2.6.15.orig/drivers/leds/Makefile	2006-01-29 15:52:16.000000000 +0000
+++ linux-2.6.15/drivers/leds/Makefile	2006-01-29 16:02:35.000000000 +0000
@@ -2,3 +2,4 @@
 # LED Core
 obj-$(CONFIG_NEW_LEDS)			+= led-core.o
 obj-$(CONFIG_LEDS_CLASS)		+= led-class.o
+obj-$(CONFIG_LEDS_TRIGGERS)		+= led-triggers.o
Index: linux-2.6.15/drivers/leds/leds.h
===================================================================
--- linux-2.6.15.orig/drivers/leds/leds.h	2006-01-29 15:54:46.000000000 +0000
+++ linux-2.6.15/drivers/leds/leds.h	2006-01-29 15:55:02.000000000 +0000
@@ -24,3 +24,13 @@
 extern rwlock_t leds_list_lock;
 extern struct list_head leds_list;
 
+#ifdef CONFIG_LEDS_TRIGGERS
+void led_trigger_set_default(struct led_classdev *led_cdev);
+void led_trigger_set(struct led_classdev *led_cdev, struct led_trigger *trigger);
+#else
+#define led_trigger_set_default(x) do {} while(0)
+#define led_trigger_set(x, y) do {} while(0)
+#endif
+
+ssize_t led_trigger_store(struct class_device *dev, const char *buf, size_t count);
+ssize_t led_trigger_show(struct class_device *dev, char *buf);
Index: linux-2.6.15/include/linux/leds.h
===================================================================
--- linux-2.6.15.orig/include/linux/leds.h	2006-01-29 15:52:16.000000000 +0000
+++ linux-2.6.15/include/linux/leds.h	2006-01-29 15:55:02.000000000 +0000
@@ -38,6 +38,11 @@
 
 	/* Trigger data */
 	char *default_trigger;
+#ifdef CONFIG_LEDS_TRIGGERS
+	struct led_trigger *trigger;
+	struct list_head trig_list;
+	void *trigger_data;
+#endif
 
 	/* This protects the data in this structure */
 	rwlock_t lock;
@@ -47,3 +52,47 @@
 extern void led_classdev_unregister(struct led_classdev *led_cdev);
 extern void led_classdev_suspend(struct led_classdev *led_cdev);
 extern void led_classdev_resume(struct led_classdev *led_cdev);
+
+
+/*
+ * LED Triggers
+ */
+#ifdef CONFIG_LEDS_TRIGGERS
+
+#define TRIG_NAME_MAX 50
+
+struct led_trigger {
+	/* Trigger Properties */
+	const char *name;
+	void (*activate)(struct led_classdev *led_cdev);
+	void (*deactivate)(struct led_classdev *led_cdev);
+
+	/* LEDs under control by this trigger (for simple triggers) */
+	rwlock_t leddev_list_lock;
+	struct list_head led_cdevs;
+
+	/* Link to next registered trigger */
+	struct list_head next_trig;
+};
+
+/* Registration functions for complex triggers */
+int led_trigger_register(struct led_trigger *trigger);
+void led_trigger_unregister(struct led_trigger *trigger);
+
+/* Registration functions for simple triggers */
+#define INIT_LED_TRIGGER(x)		static struct led_trigger *x;
+#define INIT_LED_TRIGGER_GLOBAL(x)	struct led_trigger *x;
+void led_trigger_register_simple(const char *name, struct led_trigger **trigger);
+void led_trigger_unregister_simple(struct led_trigger *trigger);
+void led_trigger_event(struct led_trigger *trigger, enum led_brightness event);
+
+#else
+
+/* Triggers aren't active - null macros */
+#define INIT_LED_TRIGGER(x)
+#define INIT_LED_TRIGGER_GLOBAL(x)
+#define led_trigger_register_simple(x, y) do {} while(0)
+#define led_trigger_unregister_simple(x) do {} while(0)
+#define led_trigger_event(x, y) do {} while(0)
+
+#endif
Index: linux-2.6.15/drivers/leds/led-class.c
===================================================================
--- linux-2.6.15.orig/drivers/leds/led-class.c	2006-01-29 15:54:02.000000000 +0000
+++ linux-2.6.15/drivers/leds/led-class.c	2006-01-29 15:55:02.000000000 +0000
@@ -55,6 +55,9 @@
 
 static CLASS_DEVICE_ATTR(brightness, 0644, led_brightness_show, led_brightness_store);
 
+#ifdef CONFIG_LEDS_TRIGGERS
+static CLASS_DEVICE_ATTR(trigger, 0644, led_trigger_show, led_trigger_store);
+#endif
 
 /**
  * led_classdev_suspend - suspend an led_classdev.
@@ -96,12 +99,17 @@
 
 	/* register the attributes */
 	class_device_create_file(led_cdev->class_dev, &class_device_attr_brightness);
+#ifdef CONFIG_LEDS_TRIGGERS
+	class_device_create_file(led_cdev->class_dev, &class_device_attr_trigger);
+#endif
 
 	/* add to the list of leds */
 	write_lock(&leds_list_lock);
 	list_add_tail(&led_cdev->node, &leds_list);
 	write_unlock(&leds_list_lock);
 
+	led_trigger_set_default(led_cdev);
+
 	printk(KERN_INFO "Registered led device: %s\n", led_cdev->class_dev->class_id);
 
 	return 0;
@@ -116,6 +124,12 @@
 void led_classdev_unregister(struct led_classdev *led_cdev)
 {
 	class_device_remove_file(led_cdev->class_dev, &class_device_attr_brightness);
+#ifdef CONFIG_LEDS_TRIGGERS
+	class_device_remove_file(led_cdev->class_dev, &class_device_attr_trigger);
+#endif
+
+	if (led_cdev->trigger)
+		led_trigger_set(led_cdev, NULL);
 
 	class_device_unregister(led_cdev->class_dev);
 
Index: linux-2.6.15/drivers/leds/led-triggers.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.15/drivers/leds/led-triggers.c	2006-01-29 15:56:15.000000000 +0000
@@ -0,0 +1,236 @@
+/*
+ * LED Triggers Core
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
+static rwlock_t triggers_list_lock = RW_LOCK_UNLOCKED;
+static LIST_HEAD(trigger_list);
+
+ssize_t led_trigger_store(struct class_device *dev, const char *buf, size_t count)
+{
+	struct led_classdev *led_cdev = dev->class_data;
+	char trigger_name[TRIG_NAME_MAX];
+	struct led_trigger *trig;
+	size_t len;
+
+	trigger_name[sizeof(trigger_name) - 1] = '\0';
+	strncpy(trigger_name, buf, sizeof(trigger_name) - 1);
+	len = strlen(trigger_name);
+
+	if (len && trigger_name[len - 1] == '\n')
+		trigger_name[len - 1] = '\0';
+
+	if (!strcmp(trigger_name, "none")) {
+		write_lock(&led_cdev->lock);
+		led_trigger_set(led_cdev, NULL);
+		write_unlock(&led_cdev->lock);
+		return count;
+	}
+
+	read_lock(&triggers_list_lock);
+	list_for_each_entry(trig, &trigger_list, next_trig) {
+		if (!strcmp(trigger_name, trig->name)) {
+			write_lock(&led_cdev->lock);
+			led_trigger_set(led_cdev, trig);
+			write_unlock(&led_cdev->lock);
+
+			read_unlock(&triggers_list_lock);
+			return count;
+		}
+	}
+	read_unlock(&triggers_list_lock);
+
+	return -EINVAL;
+}
+
+
+ssize_t led_trigger_show(struct class_device *dev, char *buf)
+{
+	struct led_classdev *led_cdev = dev->class_data;
+	struct led_trigger *trig;
+	int len = 0;
+
+	read_lock(&led_cdev->lock);
+
+	if (!led_cdev->trigger)
+		len += sprintf(buf+len, "[none] ");
+	else
+		len += sprintf(buf+len, "none ");
+
+	read_lock(&triggers_list_lock);
+	list_for_each_entry(trig, &trigger_list, next_trig) {
+		if (led_cdev->trigger && !strcmp(led_cdev->trigger->name,  trig->name))
+			len += sprintf(buf+len, "[%s] ", trig->name);
+		else
+			len += sprintf(buf+len, "%s ", trig->name);
+	}
+	read_unlock(&triggers_list_lock);
+	read_unlock(&led_cdev->lock);
+
+	len += sprintf(len+buf, "\n");
+	return len;
+}
+
+void led_trigger_event(struct led_trigger *trigger, enum led_brightness brightness)
+{
+	struct list_head *entry;
+
+	if (!trigger)
+		return;
+
+	read_lock(&trigger->leddev_list_lock);
+	list_for_each(entry, &trigger->led_cdevs) {
+		struct led_classdev *led_cdev;
+
+		led_cdev = list_entry(entry, struct led_classdev, trig_list);
+		write_lock(&led_cdev->lock);
+		led_set_brightness(led_cdev, brightness);
+		write_unlock(&led_cdev->lock);
+	}
+	read_unlock(&trigger->leddev_list_lock);
+}
+
+/* Caller must ensure led_cdev->lock held for write */
+void led_trigger_set(struct led_classdev *led_cdev, struct led_trigger *trigger)
+{
+	/* Remove any existing trigger */
+	if (led_cdev->trigger) {
+		write_lock(&led_cdev->trigger->leddev_list_lock);
+		list_del(&led_cdev->trig_list);
+		write_unlock(&led_cdev->trigger->leddev_list_lock);
+		if (led_cdev->trigger->deactivate)
+			led_cdev->trigger->deactivate(led_cdev);
+
+	}
+	if (trigger) {
+		write_lock(&trigger->leddev_list_lock);
+		list_add_tail(&led_cdev->trig_list, &trigger->led_cdevs);
+		write_unlock(&trigger->leddev_list_lock);
+		if (trigger->activate)
+			trigger->activate(led_cdev);
+	}
+	led_cdev->trigger = trigger;
+}
+
+void led_trigger_set_default(struct led_classdev *led_cdev)
+{
+	struct led_trigger *trig;
+
+	if (!led_cdev->default_trigger)
+		return;
+
+	write_lock(&led_cdev->lock);
+	read_lock(&triggers_list_lock);
+	list_for_each_entry(trig, &trigger_list, next_trig) {
+		if (!strcmp(led_cdev->default_trigger, trig->name))
+			led_trigger_set(led_cdev, trig);
+	}
+	read_unlock(&triggers_list_lock);
+	write_unlock(&led_cdev->lock);
+}
+
+int led_trigger_register(struct led_trigger *trigger)
+{
+	struct led_classdev *led_cdev;
+
+	rwlock_init(&trigger->leddev_list_lock);
+	INIT_LIST_HEAD(&trigger->led_cdevs);
+
+	/* Add to the list of led triggers */
+	write_lock(&triggers_list_lock);
+		list_add_tail(&trigger->next_trig, &trigger_list);
+	write_unlock(&triggers_list_lock);
+
+	/* Register with any LEDs that have this as a default trigger */
+	read_lock(&leds_list);
+	list_for_each_entry(led_cdev, &leds_list, node) {
+		write_lock(&led_cdev->lock);
+		if (!led_cdev->trigger && led_cdev->default_trigger &&
+				!strcmp(led_cdev->default_trigger, trigger->name))
+			led_trigger_set(led_cdev, trigger);
+		write_unlock(&led_cdev->lock);
+	}
+	read_unlock(&leds_list);
+
+	return 0;
+}
+
+void led_trigger_register_simple(const char *name, struct led_trigger **tp)
+{
+	struct led_trigger *trigger;
+
+	trigger = kzalloc(sizeof(struct led_trigger), GFP_KERNEL);
+
+	if (trigger) {
+		trigger->name = name;
+		led_trigger_register(trigger);
+	}
+	*tp = trigger;
+}
+
+
+void led_trigger_unregister(struct led_trigger *trigger)
+{
+	struct led_classdev *led_cdev;
+
+	/* Remove from the list of led triggers */
+	write_lock(&triggers_list_lock);
+		list_del(&trigger->next_trig);
+	write_unlock(&triggers_list_lock);
+
+	/* Remove anyone actively using this trigger */
+	read_lock(&leds_list);
+	list_for_each_entry(led_cdev, &leds_list, node) {
+		write_lock(&led_cdev->lock);
+		if (led_cdev->trigger == trigger)
+			led_trigger_set(led_cdev, NULL);
+		write_unlock(&led_cdev->lock);
+	}
+	read_unlock(&leds_list);
+}
+
+void led_trigger_unregister_simple(struct led_trigger *trigger)
+{
+	led_trigger_unregister(trigger);
+	kfree(trigger);
+}
+
+/* Used by LED Class */
+EXPORT_SYMBOL_GPL(led_trigger_set);
+EXPORT_SYMBOL_GPL(led_trigger_set_default);
+EXPORT_SYMBOL_GPL(led_trigger_show);
+EXPORT_SYMBOL_GPL(led_trigger_store);
+
+/* LED Trigger Interface */
+EXPORT_SYMBOL_GPL(led_trigger_register);
+EXPORT_SYMBOL_GPL(led_trigger_unregister);
+
+/* Simple LED Tigger Interface */
+EXPORT_SYMBOL_GPL(led_trigger_register_simple);
+EXPORT_SYMBOL_GPL(led_trigger_unregister_simple);
+EXPORT_SYMBOL_GPL(led_trigger_event);
+
+MODULE_AUTHOR("Richard Purdie");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("LED Triggers Core");
+


