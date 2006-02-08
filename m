Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030456AbWBHCh3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030456AbWBHCh3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 21:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030463AbWBHCh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 21:37:29 -0500
Received: from tim.rpsys.net ([194.106.48.114]:11465 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1030456AbWBHCh2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 21:37:28 -0500
Subject: Re: [PATCH 3/12] LED: Add LED Trigger Support
From: Richard Purdie <rpurdie@rpsys.net>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1139154745.6438.82.camel@localhost.localdomain>
References: <1139154745.6438.82.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 08 Feb 2006 02:37:21 +0000
Message-Id: <1139366241.6422.138.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

LED trigger support fixes.

Split the locking on struct led_classdev into LED and trigger sections
to prevent potential deadlock.
Fix a bug introduced in -mm where leds.h can be included more than 
once causing compile errors.
Make use of class_get_devdata()

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>

Index: linux-2.6.15/drivers/leds/led-class.c
===================================================================
--- linux-2.6.15.orig/drivers/leds/led-class.c	2006-02-08 01:20:41.000000000 +0000
+++ linux-2.6.15/drivers/leds/led-class.c	2006-02-08 01:20:51.000000000 +0000
@@ -106,18 +106,20 @@
 	class_device_create_file(led_cdev->class_dev,
 				&class_device_attr_brightness);
 
-#ifdef CONFIG_LEDS_TRIGGERS
-	class_device_create_file(led_cdev->class_dev,
-				&class_device_attr_trigger);
-#endif
-
 	/* add to the list of leds */
 	write_lock(&leds_list_lock);
 	list_add_tail(&led_cdev->node, &leds_list);
 	write_unlock(&leds_list_lock);
 
+#ifdef CONFIG_LEDS_TRIGGERS
+	rwlock_init(&led_cdev->trigger_lock);
+
 	led_trigger_set_default(led_cdev);
 
+	class_device_create_file(led_cdev->class_dev,
+				&class_device_attr_trigger);
+#endif
+
 	printk(KERN_INFO "Registered led device: %s\n",
 			led_cdev->class_dev->class_id);
 
@@ -138,10 +140,12 @@
 #ifdef CONFIG_LEDS_TRIGGERS
 	class_device_remove_file(led_cdev->class_dev,
 				&class_device_attr_trigger);
-#endif
 
+	write_lock(&led_cdev->trigger_lock);
 	if (led_cdev->trigger)
 		led_trigger_set(led_cdev, NULL);
+	write_unlock(&led_cdev->trigger_lock);
+#endif
 
 	class_device_unregister(led_cdev->class_dev);
 
Index: linux-2.6.15/drivers/leds/led-triggers.c
===================================================================
--- linux-2.6.15.orig/drivers/leds/led-triggers.c	2006-02-08 01:20:50.000000000 +0000
+++ linux-2.6.15/drivers/leds/led-triggers.c	2006-02-08 01:20:51.000000000 +0000
@@ -24,7 +24,7 @@
 #include "leds.h"
 
 /*
- * Nests outside led_cdev->lock
+ * Nests outside led_cdev->lock and led_cdev->trigger_lock
  */
 static rwlock_t triggers_list_lock = RW_LOCK_UNLOCKED;
 static LIST_HEAD(trigger_list);
@@ -32,7 +32,7 @@
 ssize_t led_trigger_store(struct class_device *dev, const char *buf,
 			size_t count)
 {
-	struct led_classdev *led_cdev = dev->class_data;
+	struct led_classdev *led_cdev = class_get_devdata(dev);
 	char trigger_name[TRIG_NAME_MAX];
 	struct led_trigger *trig;
 	size_t len;
@@ -45,18 +45,18 @@
 		trigger_name[len - 1] = '\0';
 
 	if (!strcmp(trigger_name, "none")) {
-		write_lock(&led_cdev->lock);
+		write_lock(&led_cdev->trigger_lock);
 		led_trigger_set(led_cdev, NULL);
-		write_unlock(&led_cdev->lock);
+		write_unlock(&led_cdev->trigger_lock);
 		return count;
 	}
 
 	read_lock(&triggers_list_lock);
 	list_for_each_entry(trig, &trigger_list, next_trig) {
 		if (!strcmp(trigger_name, trig->name)) {
-			write_lock(&led_cdev->lock);
+			write_lock(&led_cdev->trigger_lock);
 			led_trigger_set(led_cdev, trig);
-			write_unlock(&led_cdev->lock);
+			write_unlock(&led_cdev->trigger_lock);
 
 			read_unlock(&triggers_list_lock);
 			return count;
@@ -70,12 +70,12 @@
 
 ssize_t led_trigger_show(struct class_device *dev, char *buf)
 {
-	struct led_classdev *led_cdev = dev->class_data;
+	struct led_classdev *led_cdev = class_get_devdata(dev);
 	struct led_trigger *trig;
 	int len = 0;
 
 	read_lock(&triggers_list_lock);
-	read_lock(&led_cdev->lock);
+	read_lock(&led_cdev->trigger_lock);
 
 	if (!led_cdev->trigger)
 		len += sprintf(buf+len, "[none] ");
@@ -89,7 +89,7 @@
 		else
 			len += sprintf(buf+len, "%s ", trig->name);
 	}
-	read_unlock(&led_cdev->lock);
+	read_unlock(&led_cdev->trigger_lock);
 	read_unlock(&triggers_list_lock);
 
 	len += sprintf(len+buf, "\n");
@@ -116,7 +116,7 @@
 	read_unlock(&trigger->leddev_list_lock);
 }
 
-/* Caller must ensure led_cdev->lock held for write */
+/* Caller must ensure led_cdev->trigger_lock held */
 void led_trigger_set(struct led_classdev *led_cdev, struct led_trigger *trigger)
 {
 	/* Remove any existing trigger */
@@ -126,7 +126,6 @@
 		write_unlock(&led_cdev->trigger->leddev_list_lock);
 		if (led_cdev->trigger->deactivate)
 			led_cdev->trigger->deactivate(led_cdev);
-
 	}
 	if (trigger) {
 		write_lock(&trigger->leddev_list_lock);
@@ -146,12 +145,12 @@
 		return;
 
 	read_lock(&triggers_list_lock);
-	write_lock(&led_cdev->lock);
+	write_lock(&led_cdev->trigger_lock);
 	list_for_each_entry(trig, &trigger_list, next_trig) {
 		if (!strcmp(led_cdev->default_trigger, trig->name))
 			led_trigger_set(led_cdev, trig);
 	}
-	write_unlock(&led_cdev->lock);
+	write_unlock(&led_cdev->trigger_lock);
 	read_unlock(&triggers_list_lock);
 }
 
@@ -170,11 +169,11 @@
 	/* Register with any LEDs that have this as a default trigger */
 	read_lock(&leds_list_lock);
 	list_for_each_entry(led_cdev, &leds_list, node) {
-		write_lock(&led_cdev->lock);
+		write_lock(&led_cdev->trigger_lock);
 		if (!led_cdev->trigger && led_cdev->default_trigger &&
 			    !strcmp(led_cdev->default_trigger, trigger->name))
 			led_trigger_set(led_cdev, trigger);
-		write_unlock(&led_cdev->lock);
+		write_unlock(&led_cdev->trigger_lock);
 	}
 	read_unlock(&leds_list_lock);
 
@@ -206,10 +205,10 @@
 	/* Remove anyone actively using this trigger */
 	read_lock(&leds_list_lock);
 	list_for_each_entry(led_cdev, &leds_list, node) {
-		write_lock(&led_cdev->lock);
+		write_lock(&led_cdev->trigger_lock);
 		if (led_cdev->trigger == trigger)
 			led_trigger_set(led_cdev, NULL);
-		write_unlock(&led_cdev->lock);
+		write_unlock(&led_cdev->trigger_lock);
 	}
 	read_unlock(&leds_list_lock);
 }
Index: linux-2.6.15/include/linux/leds.h
===================================================================
--- linux-2.6.15.orig/include/linux/leds.h	2006-02-08 01:20:41.000000000 +0000
+++ linux-2.6.15/include/linux/leds.h	2006-02-08 01:21:54.000000000 +0000
@@ -10,6 +10,9 @@
  *
  */
 
+#ifndef _LINUX_LEDS
+#define _LINUX_LEDS
+
 struct device;
 struct class_device;
 /*
@@ -36,16 +39,19 @@
 	/* LED Device linked list */
 	struct list_head node;
 
+	/* Protects the LED properties data above */
+	rwlock_t lock;
+
 	/* Trigger data */
 	char *default_trigger;
 #ifdef CONFIG_LEDS_TRIGGERS
+	rwlock_t trigger_lock;
+	/* Protects the trigger data below */
+
 	struct led_trigger *trigger;
 	struct list_head trig_list;
 	void *trigger_data;
 #endif
-
-	/* This protects the data in this structure */
-	rwlock_t lock;
 };
 
 extern int led_classdev_register(struct device *parent,
@@ -98,3 +104,5 @@
 #define led_trigger_event(x, y) do {} while(0)
 
 #endif
+
+#endif /* _LINUX_LEDS */


