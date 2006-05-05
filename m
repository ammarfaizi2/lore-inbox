Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751128AbWEEPIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbWEEPIi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 11:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbWEEPIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 11:08:38 -0400
Received: from crystal.sipsolutions.net ([195.210.38.204]:42411 "EHLO
	sipsolutions.net") by vger.kernel.org with ESMTP id S1751128AbWEEPIi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 11:08:38 -0400
Subject: [patch] via-pmu: add input device
From: Johannes Berg <johannes@sipsolutions.net>
To: dtor_core@ameritech.net
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@suse.cz>,
       Richard Purdie <rpurdie@rpsys.net>,
       Matthew Garrett <mjg59@srcf.ucam.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-input@atrey.karlin.mff.cuni.cz,
       Benjamin Berg <benjamin@sipsolutions.net>
In-Reply-To: <d120d5000605020550y35518617u572b2e60f1eafff9@mail.gmail.com>
References: <20060501214537.031031000@sipsolutions.net>
	 <d120d5000605020550y35518617u572b2e60f1eafff9@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 05 May 2006 17:08:06 +0200
Message-Id: <1146841686.16487.6.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

New version of this patch.

Should I split it up into two, one for the change to input.h and one for
the change in via-pmu?

Ben, what about recognising the PMU here? What else can it report/what
else should I pick up? What about older versions?

---

This patch adds an input device for the button and lid switch
so that userspace gets notified about the user pressing them
via the standard input layer.

Cc: Pavel Machek <pavel@suse.cz>
Cc: Richard Purdie <rpurdie@rpsys.net>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-input@atrey.karlin.mff.cuni.cz
Cc: Dmitry Torokhov <dtor_core@ameritech.net>
Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

--- wireless-dev.orig/drivers/macintosh/Makefile	2006-05-02 13:42:26.992596627 +0200
+++ wireless-dev/drivers/macintosh/Makefile	2006-05-02 13:42:27.052596627 +0200
@@ -11,7 +11,7 @@ obj-$(CONFIG_MAC_EMUMOUSEBTN)	+= mac_hid
 obj-$(CONFIG_INPUT_ADBHID)	+= adbhid.o
 obj-$(CONFIG_ANSLCD)		+= ans-lcd.o
 
-obj-$(CONFIG_ADB_PMU)		+= via-pmu.o
+obj-$(CONFIG_ADB_PMU)		+= via-pmu.o via-pmu-event.o
 obj-$(CONFIG_ADB_PMU_LED)	+= via-pmu-led.o
 obj-$(CONFIG_ADB_CUDA)		+= via-cuda.o
 obj-$(CONFIG_PMAC_APM_EMU)	+= apm_emu.o
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ wireless-dev/drivers/macintosh/via-pmu-event.c	2006-05-05 17:00:24.718326302 +0200
@@ -0,0 +1,75 @@
+/*
+ * via-pmu event device for reporting some events that come through the PMU
+ *
+ * Copyright 2006 Johannes Berg <johannes@sipsolutions.net>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 USA
+ *
+ */
+
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
+	if (!pmu_input_dev)
+		return -ENODEV;
+
+	pmu_input_dev->name = "PMU";
+	pmu_input_dev->id.bustype = BUS_HOST;
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
+
+	if (unlikely(!pmu_input_dev))
+		return;
+
+	switch (key) {
+	case PMU_EVT_POWER:
+		input_report_key(pmu_input_dev, KEY_POWER, down);
+		break;
+	case PMU_EVT_LID:
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
+++ wireless-dev/drivers/macintosh/via-pmu-event.h	2006-05-02 13:42:27.052596627 +0200
@@ -0,0 +1,8 @@
+#ifndef __VIA_PMU_EVENT_H
+#define __VIA_PMU_EVENT_H
+
+#define PMU_EVT_POWER	0
+#define PMU_EVT_LID	1
+extern void pmu_event(int key, int down);
+
+#endif /* __VIA_PMU_EVENT_H */
--- wireless-dev.orig/include/linux/input.h	2006-05-02 13:42:23.842596627 +0200
+++ wireless-dev/include/linux/input.h	2006-05-04 13:08:39.821539002 +0200
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
--- wireless-dev.orig/drivers/macintosh/via-pmu.c	2006-05-02 13:42:23.782596627 +0200
+++ wireless-dev/drivers/macintosh/via-pmu.c	2006-05-02 13:42:27.122596627 +0200
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


