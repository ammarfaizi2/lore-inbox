Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030466AbWBHCqK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030466AbWBHCqK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 21:46:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965186AbWBHCqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 21:46:09 -0500
Received: from tim.rpsys.net ([194.106.48.114]:719 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S965185AbWBHCqH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 21:46:07 -0500
Subject: RE: [PATCH 4/12] LED: Add LED Timer Trigger
From: Richard Purdie <rpurdie@rpsys.net>
To: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Cc: jbowler@acm.org
In-Reply-To: <001001c62a90$35171440$1001a8c0@kalmiopsis>
References: <001001c62a90$35171440$1001a8c0@kalmiopsis>
Content-Type: text/plain
Date: Wed, 08 Feb 2006 02:45:51 +0000
Message-Id: <1139366751.6422.148.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As mentioned on LKML by John Bowler, using frequency and duty as
attributes is a bad idea as it restricts the potential usage of this
trigger. Therefore, instead export the two delay parameters directly.
Also remove unneeded locking and use class_get_devdata().

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>

Index: linux-2.6.15/drivers/leds/ledtrig-timer.c
===================================================================
--- linux-2.6.15.orig/drivers/leds/ledtrig-timer.c	2006-02-08 01:42:26.000000000 +0000
+++ linux-2.6.15/drivers/leds/ledtrig-timer.c	2006-02-08 02:03:20.000000000 +0000
@@ -24,8 +24,6 @@
 #include "leds.h"
 
 struct timer_trig_data {
-	unsigned long duty;		/* duty cycle, as a percentage */
-	unsigned long frequency;	/* frequency of blinking, in Hz */
 	unsigned long delay_on;		/* milliseconds on */
 	unsigned long delay_off;	/* milliseconds off */
 	struct timer_list timer;
@@ -38,9 +36,8 @@
 	unsigned long brightness = LED_OFF;
 	unsigned long delay = timer_data->delay_off;
 
-	write_lock(&led_cdev->lock);
-
-	if (!timer_data->frequency) {
+	if (!timer_data->delay_on || !timer_data->delay_off) {
+		write_lock(&led_cdev->lock);
 		led_set_brightness(led_cdev, LED_OFF);
 		write_unlock(&led_cdev->lock);
 		return;
@@ -51,107 +48,73 @@
 		delay = timer_data->delay_on;
 	}
 
+	write_lock(&led_cdev->lock);
 	led_set_brightness(led_cdev, brightness);
+	write_unlock(&led_cdev->lock);
 
 	mod_timer(&timer_data->timer, jiffies + msecs_to_jiffies(delay));
-	write_unlock(&led_cdev->lock);
 }
 
-/* led_cdev write lock needs to be held */
-static int led_timer_setdata(struct led_classdev *led_cdev, unsigned long duty,
-				unsigned long frequency)
+static ssize_t led_delay_on_show(struct class_device *dev, char *buf)
 {
+	struct led_classdev *led_cdev = class_get_devdata(dev);
 	struct timer_trig_data *timer_data = led_cdev->trigger_data;
 
-	if (frequency > 500)
-		return -EINVAL;
-
-	if (duty > 100)
-		return -EINVAL;
-
-	timer_data->duty = duty;
-	timer_data->frequency = frequency;
-	if (frequency != 0) {
-		timer_data->delay_on = duty * 1000 / 50 / frequency / 2;
-		timer_data->delay_off = (100 - duty)*1000 / 50 / frequency / 2;
-	}
-
-	mod_timer(&timer_data->timer, jiffies + 1);
-
-	return 0;
-}
-
-static ssize_t led_duty_show(struct class_device *dev, char *buf)
-{
-	struct led_classdev *led_cdev = dev->class_data;
-	struct timer_trig_data *timer_data;
-
-	read_lock(&led_cdev->lock);
-	timer_data = led_cdev->trigger_data;
-	sprintf(buf, "%lu\n", timer_data->duty);
-	read_unlock(&led_cdev->lock);
+	sprintf(buf, "%lu\n", timer_data->delay_on);
 
 	return strlen(buf) + 1;
 }
 
-static ssize_t led_duty_store(struct class_device *dev, const char *buf,
+static ssize_t led_delay_on_store(struct class_device *dev, const char *buf,
 				size_t size)
 {
-	struct led_classdev *led_cdev = dev->class_data;
-	struct timer_trig_data *timer_data;
+	struct led_classdev *led_cdev = class_get_devdata(dev);
+	struct timer_trig_data *timer_data = led_cdev->trigger_data;
 	int ret = -EINVAL;
 	char *after;
-
 	unsigned long state = simple_strtoul(buf, &after, 10);
+
 	if (after - buf > 0) {
-		write_lock(&led_cdev->lock);
-		timer_data = led_cdev->trigger_data;
-		ret = led_timer_setdata(led_cdev, state, timer_data->frequency);
-		if (!ret)
-			ret = after - buf;			
-		write_unlock(&led_cdev->lock);
+		timer_data->delay_on = state;
+		mod_timer(&timer_data->timer, jiffies + 1);
+		ret = after - buf;
 	}
 
 	return ret;
 }
 
-static ssize_t led_frequency_show(struct class_device *dev, char *buf)
+static ssize_t led_delay_off_show(struct class_device *dev, char *buf)
 {
-	struct led_classdev *led_cdev = dev->class_data;
-	struct timer_trig_data *timer_data;
+	struct led_classdev *led_cdev = class_get_devdata(dev);
+	struct timer_trig_data *timer_data = led_cdev->trigger_data;
 
-	read_lock(&led_cdev->lock);
-	timer_data = led_cdev->trigger_data;
-	sprintf(buf, "%lu\n", timer_data->frequency);
-	read_unlock(&led_cdev->lock);
+	sprintf(buf, "%lu\n", timer_data->delay_off);
 
 	return strlen(buf) + 1;
 }
 
-static ssize_t led_frequency_store(struct class_device *dev, const char *buf,
+static ssize_t led_delay_off_store(struct class_device *dev, const char *buf,
 				size_t size)
 {
-	struct led_classdev *led_cdev = dev->class_data;
-	struct timer_trig_data *timer_data;
+	struct led_classdev *led_cdev = class_get_devdata(dev);
+	struct timer_trig_data *timer_data = led_cdev->trigger_data;
 	int ret = -EINVAL;
 	char *after;
 	unsigned long state = simple_strtoul(buf, &after, 10);
 
 	if (after - buf > 0) {
-		write_lock(&led_cdev->lock);
-		timer_data = led_cdev->trigger_data;
-		ret = led_timer_setdata(led_cdev, timer_data->duty, state);
-		if (!ret)
-			ret = after - buf;			
-		write_unlock(&led_cdev->lock);
+		timer_data->delay_off = state;
+		mod_timer(&timer_data->timer, jiffies + 1);
+		ret = after - buf;
 	}
 
 	return ret;
 }
 
-static CLASS_DEVICE_ATTR(duty, 0644, led_duty_show, led_duty_store);
-static CLASS_DEVICE_ATTR(frequency, 0644, led_frequency_show,
-			led_frequency_store);
+static CLASS_DEVICE_ATTR(delay_on, 0644, led_delay_on_show, 
+			led_delay_on_store);
+static CLASS_DEVICE_ATTR(delay_off, 0644, led_delay_off_show,
+			led_delay_off_store);
 
 static void timer_trig_activate(struct led_classdev *led_cdev)
 {
@@ -167,11 +130,10 @@
 	timer_data->timer.function = led_timer_function;
 	timer_data->timer.data = (unsigned long) led_cdev;
 
-	timer_data->duty = 50;
-
-	class_device_create_file(led_cdev->class_dev, &class_device_attr_duty);
+	class_device_create_file(led_cdev->class_dev, 
+				&class_device_attr_delay_on);
 	class_device_create_file(led_cdev->class_dev,
-				&class_device_attr_frequency);
+				&class_device_attr_delay_off);
 }
 
 static void timer_trig_deactivate(struct led_classdev *led_cdev)
@@ -180,9 +142,9 @@
 
 	if (timer_data) {
 		class_device_remove_file(led_cdev->class_dev,
-					&class_device_attr_duty);
+					&class_device_attr_delay_on);
 		class_device_remove_file(led_cdev->class_dev,
-					&class_device_attr_frequency);
+					&class_device_attr_delay_off);
 		del_timer_sync(&timer_data->timer);
 		kfree(timer_data);
 	}
@@ -199,7 +161,7 @@
 	return led_trigger_register(&timer_led_trigger);
 }
 
-static void __exit timer_trig_exit (void)
+static void __exit timer_trig_exit(void)
 {
 	led_trigger_unregister(&timer_led_trigger);
 }


