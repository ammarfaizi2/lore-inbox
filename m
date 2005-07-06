Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262076AbVGFDXo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262076AbVGFDXo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 23:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262121AbVGFDXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 23:23:12 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:11161 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262076AbVGFCT3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 22:19:29 -0400
Subject: [PATCH] [38/48] Suspend2 2.1.9.8 for 2.6.12: 614-plugins.patch
In-Reply-To: <11206164393426@foobar.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 6 Jul 2005 12:20:43 +1000
Message-Id: <11206164432753@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Nigel Cunningham <nigel@suspend2.net>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Nigel Cunningham <nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruNp 615-poweroff.patch-old/kernel/power/suspend2_core/power_off.c 615-poweroff.patch-new/kernel/power/suspend2_core/power_off.c
--- 615-poweroff.patch-old/kernel/power/suspend2_core/power_off.c	1970-01-01 10:00:00.000000000 +1000
+++ 615-poweroff.patch-new/kernel/power/suspend2_core/power_off.c	2005-07-04 23:14:19.000000000 +1000
@@ -0,0 +1,148 @@
+/*
+ * kernel/power/suspend2_core/power_off.c
+ *
+ * Copyright (C) 2005 Nigel Cunningham <nigel@suspend2.net>
+ *
+ * This file is released under the GPLv2.
+ *
+ * Support for powering down.
+ */
+
+#include <linux/device.h>
+#include <linux/suspend.h>
+#include <linux/mm.h>
+#include <linux/pm.h>
+#include <linux/reboot.h>
+#include "suspend2_common.h"
+#include "suspend.h"
+#include "ui.h"
+
+unsigned long suspend2_powerdown_method = 5; /* S5 = off */
+static int suspend_pm_state_used = 0;
+
+extern struct pm_ops * pm_ops;
+
+#ifdef CONFIG_ACPI
+extern u32 acpi_leave_sleep_state (u8 sleep_state);
+#endif
+
+/* suspend_power_off
+ *
+ * Power off the machine.
+ */
+static void suspend_power_off(void)
+{
+	machine_power_off();
+	suspend2_prepare_status(1, 0, "Probably not capable for powerdown.");
+	while (1)
+		cpu_relax();
+	/* NOTREACHED */
+}
+
+/* suspend_pm_state_prepare
+ *
+ * Prepare to enter the sleep state.
+ */
+static int suspend_pm_state_prepare(void)
+{
+	int ret = 0;
+	
+	if (suspend2_powerdown_method == 3 ||
+	    suspend2_powerdown_method == 4)
+		if (pm_ops && pm_ops->prepare)
+			ret = pm_ops->prepare(suspend2_powerdown_method);
+
+	return ret;
+}
+
+/* suspend_pm_sleep_state_enter
+ * 
+ * Enter the sleep state requested.
+ */
+static int suspend_pm_state_enter(u32 state)
+{
+	int ret = 0;
+	unsigned long flags;
+	suspend_pm_state_used = state;
+
+	local_irq_save(flags);
+	device_power_down(PMSG_SUSPEND);
+	if (pm_ops && pm_ops->enter)
+		ret = pm_ops->enter(state);
+	else 
+		printk("Failed to enter state.\n");
+
+	device_power_up();
+	local_irq_restore(flags);
+
+	return ret;
+}
+
+/* suspend_pm_state_finish
+ *
+ * Finish the sleep state.
+ */
+int suspend_pm_state_finish(void)
+{
+	int ret = 0;
+
+	if (suspend2_powerdown_method == 3 ||
+	    suspend2_powerdown_method == 4)
+		if (pm_ops && pm_ops->finish)
+			ret = pm_ops->finish(suspend2_powerdown_method);
+
+	device_resume();
+
+	return ret;
+}
+
+/*
+ * suspend_power_down
+ * Functionality   : Powers down or reboots the computer once the image
+ *                   has been written to disk.
+ * Key Assumptions : Able to reboot/power down via code called or that
+ *                   the warning emitted if the calls fail will be visible
+ *                   to the user (ie printk resumes devices).
+ * Called From     : do_suspend2_suspend_2
+ */
+
+void suspend_power_down(void)
+{
+	if (TEST_ACTION_STATE(SUSPEND_REBOOT)) {
+		suspend2_prepare_status(1, 0, "Ready to reboot.");
+		device_shutdown();
+		machine_restart(NULL);
+	}
+
+	if (suspend2_powerdown_method == 3 ||
+	    suspend2_powerdown_method == 4) {
+		suspend2_prepare_status(1, 0, "Seeking to enter ACPI state");
+		if (suspend_pm_state_prepare()) {
+			suspend2_prepare_status(1, 0, "Preparing to enter ACPI state failed. Using normal powerdown.");
+			goto abort_ACPI_sleep;
+		}
+		if (device_suspend(PMSG_SUSPEND)) {
+			suspend2_prepare_status(1, 0, "Suspending devices failed. Using normal powerdown.");
+			suspend_pm_state_finish();
+			goto abort_ACPI_sleep;
+		}
+		if (suspend_pm_state_enter(suspend2_powerdown_method)) {
+			suspend2_prepare_status(1, 0, "Entering ACPI state failed. Using normal powerdown.");
+			suspend_pm_state_finish();
+			goto abort_ACPI_sleep;
+		}
+		suspend_pm_state_finish();
+		return;
+	} else
+		suspend2_prepare_status(1, 0, "Powering down.");
+	
+abort_ACPI_sleep:
+	/* 
+	 * FIXME: At resume, we'll still think we used S4 if we tried it.
+	 * Does it matter?
+	 */
+	suspend_pm_state_used = 0;
+	device_shutdown();
+	suspend_power_off();
+}
+
diff -ruNp 615-poweroff.patch-old/kernel/power/suspend2_core/power_off.h 615-poweroff.patch-new/kernel/power/suspend2_core/power_off.h
--- 615-poweroff.patch-old/kernel/power/suspend2_core/power_off.h	1970-01-01 10:00:00.000000000 +1000
+++ 615-poweroff.patch-new/kernel/power/suspend2_core/power_off.h	2005-07-04 23:14:19.000000000 +1000
@@ -0,0 +1,13 @@
+/*
+ * kernel/power/suspend2_core/power_off.h
+ *
+ * Copyright (C) 2005 Nigel Cunningham <nigel@suspend2.net>
+ *
+ * This file is released under the GPLv2.
+ *
+ * Support for the powering down.
+ */
+
+int suspend_pm_state_finish(void);
+void suspend_power_down(void);
+extern unsigned long suspend2_powerdown_method;

