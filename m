Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932302AbWEAWTF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbWEAWTF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 18:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbWEAWTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 18:19:04 -0400
Received: from crystal.sipsolutions.net ([195.210.38.204]:14246 "EHLO
	sipsolutions.net") by vger.kernel.org with ESMTP id S932302AbWEAWTD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 18:19:03 -0400
Subject: [patch] via-pmu: add input device
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-kernel@vger.kernel.org
Cc: Pavel Machek <pavel@suse.cz>, Richard Purdie <rpurdie@rpsys.net>,
       Matthew Garrett <mjg59@srcf.ucam.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-input@atrey.karlin.mff.cuni.cz,
       Dmitry Torokhov <dtor_core@ameritech.net>
Content-Type: text/plain
Date: Tue, 02 May 2006 00:18:56 +0200
Message-Id: <1146521936.27351.66.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ouch ouch! I don't even know the right address for lkml any more. Sorry
about the duplicate, if you reply to the other please fix the lkml
address :/

-- 

This patch adds an input device for the button and lid switch
so that userspace gets notified about the user pressing them
via the standard input layer.

I know this is going to be quite controversial due to the
changes in the input layer. But I was reading
http://lkml.org/lkml/2006/4/24/172 and there seemed to be some consensus
about this...

Well, comments appreciated :)

Cc: Pavel Machek <pavel@suse.cz>
Cc: Richard Purdie <rpurdie@rpsys.net>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-input@atrey.karlin.mff.cuni.cz
Cc: Dmitry Torokhov <dtor_core@ameritech.net>
Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

--- wireless-dev.orig/drivers/macintosh/Makefile	2006-05-01 23:27:20.231534234 +0200
+++ wireless-dev/drivers/macintosh/Makefile	2006-05-01 23:27:24.361534234 +0200
@@ -11,7 +11,7 @@ obj-$(CONFIG_MAC_EMUMOUSEBTN)	+= mac_hid
 obj-$(CONFIG_INPUT_ADBHID)	+= adbhid.o
 obj-$(CONFIG_ANSLCD)		+= ans-lcd.o
 
-obj-$(CONFIG_ADB_PMU)		+= via-pmu.o
+obj-$(CONFIG_ADB_PMU)		+= via-pmu.o via-pmu-event.o
 obj-$(CONFIG_ADB_PMU_LED)	+= via-pmu-led.o
 obj-$(CONFIG_ADB_CUDA)		+= via-cuda.o
 obj-$(CONFIG_PMAC_APM_EMU)	+= apm_emu.o
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ wireless-dev/drivers/macintosh/via-pmu-event.c	2006-05-01 23:59:20.451534234 +0200
@@ -0,0 +1,61 @@
+#include <linux/input.h>
+#include <linux/adb.h>
+#include <linux/pmu.h>
+#include "via-pmu-event.h"
+
+static struct input_dev *pmu_input_dev;
+
+static int pmu_event_init(void)
+{
+	/* do other models report button/lid status? */
+	if (pmu_get_model() != PMU_KEYLARGO_BASED)
+		return -ENODEV;
+
+	pmu_input_dev = input_allocate_device();
+	if (unlikely(!pmu_input_dev))
+		return -ENODEV;
+
+	pmu_input_dev->name = "PMU";
+	pmu_input_dev->id.bustype = BUS_PMU;
+	pmu_input_dev->id.vendor = 0x0001;
+	pmu_input_dev->id.product = 0x0001;
+	pmu_input_dev->id.version = 0x0100;
+
+	set_bit(EV_KEY, pmu_input_dev->evbit);
+	set_bit(EV_SW, pmu_input_dev->evbit);
+	set_bit(KEY_POWER, pmu_input_dev->keybit);
+	set_bit(SW_LID, pmu_input_dev->swbit);
+
+	return input_register_device(pmu_input_dev);
+}
+
+void pmu_event(int key, int down)
+{
+	static int powerbutton_pressed;
+	static int lid_closed;
+
+	if (unlikely(!pmu_input_dev))
+		return;
+
+	switch (key) {
+	case PMU_EVT_POWER:
+		if (powerbutton_pressed == down)
+			return;
+		powerbutton_pressed = down;
+		input_report_key(pmu_input_dev, KEY_POWER, down);
+		break;
+	case PMU_EVT_LID:
+		if (lid_closed == down)
+			return;
+		lid_closed = down;
+		input_report_switch(pmu_input_dev, SW_LID, down);
+		break;
+	default:
+		/* no such key handled */
+		return;
+	}
+
+	input_sync(pmu_input_dev);
+}
+
+late_initcall(pmu_event_init);
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ wireless-dev/drivers/macintosh/via-pmu-event.h	2006-05-01 23:32:18.061534234 +0200
@@ -0,0 +1,8 @@
+#ifndef __VIA_PMU_EVENT_H
+#define __VIA_PMU_EVENT_H
+
+#define PMU_EVT_POWER	0
+#define PMU_EVT_LID	1
+extern void pmu_event(int key, int down);
+
+#endif /* __VIA_PMU_EVENT_H */
--- wireless-dev.orig/include/linux/input.h	2006-05-01 23:27:20.461534234 +0200
+++ wireless-dev/include/linux/input.h	2006-05-01 23:37:10.501534234 +0200
@@ -577,7 +577,9 @@ struct input_absinfo {
  * Switch events
  */
 
-#define SW_0		0x00
+#define SW_LID		0x00
+/* numeric ones should go away */
+#define SW_0		SW_LID
 #define SW_1		0x01
 #define SW_2		0x02
 #define SW_3		0x03
@@ -658,6 +660,7 @@ struct input_absinfo {
 #define BUS_I2C			0x18
 #define BUS_HOST		0x19
 #define BUS_GSC			0x1A
+#define BUS_PMU			0x20
 
 /*
  * Values describing the status of an effect
--- wireless-dev.orig/drivers/macintosh/via-pmu.c	2006-05-01 23:27:20.401534234 +0200
+++ wireless-dev/drivers/macintosh/via-pmu.c	2006-05-02 00:00:40.021534234 +0200
@@ -69,6 +69,8 @@
 #include <asm/open_pic.h>
 #endif
 
+#include "via-pmu-event.h"
+
 /* Some compile options */
 #undef SUSPEND_USES_PMU
 #define DEBUG_SLEEP
@@ -1441,6 +1443,12 @@ next:
 		if (pmu_battery_count)
 			query_battery_state();
 		pmu_pass_intr(data, len);
+		/* len == 6 is probably a bad check. But how do I
+		 * know what PMU versions send what events here? */
+		if (len == 6) {
+			pmu_event(PMU_EVT_POWER, !!(data[1]&8));
+			pmu_event(PMU_EVT_LID, data[1]&1);
+		}
 	} else {
 	       pmu_pass_intr(data, len);
 	}

