Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750826AbWAaNlr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbWAaNlr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 08:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbWAaNlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 08:41:47 -0500
Received: from tim.rpsys.net ([194.106.48.114]:65426 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1750826AbWAaNlp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 08:41:45 -0500
Subject: [PATCH 5/11] LED: Add Sharp Charger Status LED Trigger
From: Richard Purdie <rpurdie@rpsys.net>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 31 Jan 2006 13:41:40 +0000
Message-Id: <1138714900.6869.131.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add an LED trigger for the charger status as found on the Sharp 
Zaurus series of devices.

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>
Acked-by: Pavel Machek <pavel@suse.cz>

Index: linux-2.6.15/arch/arm/common/sharpsl_pm.c
===================================================================
--- linux-2.6.15.orig/arch/arm/common/sharpsl_pm.c	2006-01-29 14:37:21.000000000 +0000
+++ linux-2.6.15/arch/arm/common/sharpsl_pm.c	2006-01-29 15:04:01.000000000 +0000
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
+		led_trigger_event(sharpsl_charge_led_trigger, LED_FULL);
 	} else {
 		dev_dbg(sharpsl_pm.dev, "Charge LED Off\n");
-
+		led_trigger_event(sharpsl_charge_led_trigger, LED_OFF);
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


