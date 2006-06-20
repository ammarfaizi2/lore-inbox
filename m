Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751403AbWFTQfA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbWFTQfA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 12:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbWFTQfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 12:35:00 -0400
Received: from mba.ocn.ne.jp ([210.190.142.172]:22233 "EHLO smtp.mba.ocn.ne.jp")
	by vger.kernel.org with ESMTP id S1751403AbWFTQfA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 12:35:00 -0400
Date: Wed, 21 Jun 2006 01:36:03 +0900 (JST)
Message-Id: <20060621.013603.132759710.anemo@mba.ocn.ne.jp>
To: linux-kernel@vger.kernel.org
Cc: Richard Purdie <rpurdie@rpsys.net>, akpm@osdl.org
Subject: [PATCH] LED: add LED heartbeat trigger
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add an LED trigger acts like a heart beat.  This can be used as a
replacement of CONFIG_HEARTBEAT code exists in some arch's timer code.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 6265062..21bb7e8 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -87,5 +87,14 @@ config LEDS_TRIGGER_IDE_DISK
 	  This allows LEDs to be controlled by IDE disk activity.
 	  If unsure, say Y.
 
+config LEDS_TRIGGER_HEARTBEAT
+	tristate "LED Heartbeat Trigger"
+	depends LEDS_TRIGGERS
+	help
+	  This allows LEDs to be controlled by a CPU load average.
+	  The flash frequency is a hyperbolic function of the 5-minute
+	  load average.
+	  If unsure, say Y.
+
 endmenu
 
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index 40f0426..1dc79b5 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -15,3 +15,4 @@ obj-$(CONFIG_LEDS_S3C24XX)		+= leds-s3c2
 # LED Triggers
 obj-$(CONFIG_LEDS_TRIGGER_TIMER)	+= ledtrig-timer.o
 obj-$(CONFIG_LEDS_TRIGGER_IDE_DISK)	+= ledtrig-ide-disk.o
+obj-$(CONFIG_LEDS_TRIGGER_HEARTBEAT)	+= ledtrig-heartbeat.o
diff --git a/drivers/leds/ledtrig-heartbeat.c b/drivers/leds/ledtrig-heartbeat.c
new file mode 100644
index 0000000..07ac645
--- /dev/null
+++ b/drivers/leds/ledtrig-heartbeat.c
@@ -0,0 +1,118 @@
+/*
+ * LED Heartbeat Trigger
+ *
+ * Copyright (C) 2006 Atsushi Nemoto <anemo@mba.ocn.ne.jp>
+ *
+ * Based on Richard Purdie's ledtrig-timer.c and some arch's
+ * CONFIG_HEARTBEAT code.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/timer.h>
+#include <linux/sched.h>
+#include <linux/leds.h>
+#include "leds.h"
+
+struct heartbeat_trig_data {
+	unsigned int phase;
+	unsigned int period;
+	struct timer_list timer;
+};
+
+static void led_heartbeat_function(unsigned long data)
+{
+	struct led_classdev *led_cdev = (struct led_classdev *) data;
+	struct heartbeat_trig_data *heartbeat_data = led_cdev->trigger_data;
+	unsigned long brightness = LED_OFF;
+	unsigned long delay = 0;
+
+	/* acts like an actual heart beat -- ie thump-thump-pause... */
+	switch (heartbeat_data->phase) {
+	case 0:
+		/*
+		 * The hyperbolic function below modifies the
+		 * heartbeat period length in dependency of the
+		 * current (5min) load. It goes through the points
+		 * f(0)=126, f(1)=86, f(5)=51, f(inf)->30.
+		 */
+		heartbeat_data->period = 30 +
+			(672 << FSHIFT) / (5 * avenrun[0] + (7 << FSHIFT));
+		heartbeat_data->period = heartbeat_data->period * HZ / 100;
+		delay = 7 * HZ / 100;
+		heartbeat_data->phase++;
+		brightness = LED_FULL;
+		break;
+	case 1:
+		delay = heartbeat_data->period / 4 - 7 * HZ / 100;
+		heartbeat_data->phase++;
+		break;
+	case 2:
+		delay = 7 * HZ / 100;
+		heartbeat_data->phase++;
+		brightness = LED_FULL;
+		break;
+	default:
+		delay = heartbeat_data->period - heartbeat_data->period / 4 -
+			7 * HZ / 100;
+		heartbeat_data->phase = 0;
+		break;
+	}
+
+	led_set_brightness(led_cdev, brightness);
+	mod_timer(&heartbeat_data->timer, jiffies + delay);
+}
+
+static void heartbeat_trig_activate(struct led_classdev *led_cdev)
+{
+	struct heartbeat_trig_data *heartbeat_data;
+
+	heartbeat_data = kzalloc(sizeof(*heartbeat_data), GFP_KERNEL);
+	if (!heartbeat_data)
+		return;
+
+	led_cdev->trigger_data = heartbeat_data;
+	init_timer(&heartbeat_data->timer);
+	heartbeat_data->timer.function = led_heartbeat_function;
+	heartbeat_data->timer.data = (unsigned long) led_cdev;
+	heartbeat_data->phase = 0;
+	led_heartbeat_function(heartbeat_data->timer.data);
+}
+
+static void heartbeat_trig_deactivate(struct led_classdev *led_cdev)
+{
+	struct heartbeat_trig_data *heartbeat_data = led_cdev->trigger_data;
+
+	if (heartbeat_data) {
+		del_timer_sync(&heartbeat_data->timer);
+		kfree(heartbeat_data);
+	}
+}
+
+static struct led_trigger heartbeat_led_trigger = {
+	.name     = "heartbeat",
+	.activate = heartbeat_trig_activate,
+	.deactivate = heartbeat_trig_deactivate,
+};
+
+static int __init heartbeat_trig_init(void)
+{
+	return led_trigger_register(&heartbeat_led_trigger);
+}
+
+static void __exit heartbeat_trig_exit(void)
+{
+	led_trigger_unregister(&heartbeat_led_trigger);
+}
+
+module_init(heartbeat_trig_init);
+module_exit(heartbeat_trig_exit);
+
+MODULE_AUTHOR("Atsushi Nemoto <anemo@mba.ocn.ne.jp>");
+MODULE_DESCRIPTION("Heartbeat LED trigger");
+MODULE_LICENSE("GPL");
