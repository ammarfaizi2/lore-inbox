Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932406AbVLENK6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406AbVLENK6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 08:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932411AbVLENKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 08:10:55 -0500
Received: from tim.rpsys.net ([194.106.48.114]:29879 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S932406AbVLENKb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 08:10:31 -0500
Subject: [RFC PATCH 4/8] LED: Add Sharp Charger Status LED Trigger
From: Richard Purdie <rpurdie@rpsys.net>
To: LKML <linux-kernel@vger.kernel.org>, Russell King <rmk@arm.linux.org.uk>,
       John Lenz <lenz@cs.wisc.edu>, Pavel Machek <pavel@suse.cz>
Content-Type: text/plain
Date: Mon, 05 Dec 2005 13:10:14 +0000
Message-Id: <1133788214.8101.131.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add an LED trigger for the charger status as found on the Sharp 
Zaurus series of devices.

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>
Acked-by: Pavel Machek <pavel@suse.cz>

Index: linux-2.6.15-rc2/arch/arm/common/sharpsl_pm.c
===================================================================
--- linux-2.6.15-rc2.orig/arch/arm/common/sharpsl_pm.c	2005-12-05 09:53:15.000000000 +0000
+++ linux-2.6.15-rc2/arch/arm/common/sharpsl_pm.c	2005-12-05 10:22:14.000000000 +0000
@@ -22,6 +22,7 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
+#include <linux/leds.h>
 
 #include <asm/hardware.h>
 #include <asm/mach-types.h>
@@ -75,6 +76,7 @@
 struct sharpsl_pm_status sharpsl_pm;
 DECLARE_WORK(toggle_charger, sharpsl_charge_toggle, NULL);
 DECLARE_WORK(sharpsl_bat, sharpsl_battery_thread, NULL);
+INIT_LED_TRIGGER(sharpsl_charge_led_trigger);
 

 static int get_percentage(int voltage)
@@ -190,10 +192,10 @@
 		dev_err(sharpsl_pm.dev, "Charging Error!\n");
 	} else if (val == SHARPSL_LED_ON) {
 		dev_dbg(sharpsl_pm.dev, "Charge LED On\n");
-		
+		led_trigger_event(sharpsl_charge_led_trigger, 100);
 	} else {
 		dev_dbg(sharpsl_pm.dev, "Charge LED Off\n");
-		
+		led_trigger_event(sharpsl_charge_led_trigger, 0);
 	}
 }
 
@@ -786,6 +788,8 @@
 	init_timer(&sharpsl_pm.chrg_full_timer);
 	sharpsl_pm.chrg_full_timer.function = sharpsl_chrg_full_timer;
 
+	led_trigger_register_simple("sharpsl-charge", &sharpsl_charge_led_trigger);
+
 	sharpsl_pm.machinfo->init();
 
 	device_create_file(&pdev->dev, &dev_attr_battery_percentage);
@@ -807,6 +811,8 @@
 	device_remove_file(&pdev->dev, &dev_attr_battery_percentage);
 	device_remove_file(&pdev->dev, &dev_attr_battery_voltage);
 
+	led_trigger_unregister_simple(sharpsl_charge_led_trigger);
+
 	sharpsl_pm.machinfo->exit();
 
 	del_timer_sync(&sharpsl_pm.chrg_full_timer);


