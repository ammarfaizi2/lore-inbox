Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262098AbVGFCvC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262098AbVGFCvC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 22:51:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262096AbVGFCsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 22:48:17 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:9113 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262069AbVGFCTZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 22:19:25 -0400
Subject: [PATCH] [31/48] Suspend2 2.1.9.8 for 2.6.12: 608-compression.patch
In-Reply-To: <11206164393426@foobar.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 6 Jul 2005 12:20:42 +1000
Message-Id: <11206164423992@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Nigel Cunningham <nigel@suspend2.net>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Nigel Cunningham <nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruNp 609-driver-model.patch-old/kernel/power/suspend2_core/driver_model.c 609-driver-model.patch-new/kernel/power/suspend2_core/driver_model.c
--- 609-driver-model.patch-old/kernel/power/suspend2_core/driver_model.c	1970-01-01 10:00:00.000000000 +1000
+++ 609-driver-model.patch-new/kernel/power/suspend2_core/driver_model.c	2005-07-04 23:14:19.000000000 +1000
@@ -0,0 +1,95 @@
+/*
+ * kernel/power/suspend2_core/driver_model.c
+ *
+ * Copyright (C) 2004-2005 Nigel Cunningham <nigel@suspend2.net>
+ *
+ * This file is released under the GPLv2.
+ *
+ * Support for the driver model and ACPI sleep states.
+ */
+
+#include <linux/pm.h>
+#include "driver_model.h"
+#include "power_off.h"
+
+extern struct pm_ops * pm_ops;
+static u32 pm_disk_mode_save;
+
+#ifdef CONFIG_ACPI
+static int suspend_pm_state_used = 0;
+extern u32 acpi_leave_sleep_state (u8 sleep_state);
+#endif
+
+/* suspend_drivers_init
+ *
+ * Store the original pm ops settings.
+ */
+int suspend_drivers_init(void)
+{
+	if (pm_ops) {
+		pm_disk_mode_save = pm_ops->pm_disk_mode;
+		pm_ops->pm_disk_mode = PM_DISK_PLATFORM;
+	}
+			
+	return 0;
+}
+
+/* suspend_drivers_cleanup
+ *
+ * Restore the original pm disk mode.
+ */
+void suspend_drivers_cleanup(void)
+{
+	if (pm_ops)
+		pm_ops->pm_disk_mode = pm_disk_mode_save;
+}
+
+/* suspend_drivers_suspend
+ *
+ * Suspend the drivers after an atomic copy.
+ */
+int suspend_drivers_suspend(int stage)
+{
+	int result = 0;
+	const pm_message_t state = PMSG_FREEZE;
+
+	switch (stage) {
+		case SUSPEND_DRIVERS_IRQS_DISABLED:
+			BUG_ON(!irqs_disabled());
+			result = device_power_down(state);
+			BUG_ON(!irqs_disabled());
+			break;
+
+		case SUSPEND_DRIVERS_IRQS_ENABLED:
+			BUG_ON(irqs_disabled());
+			result = device_suspend(state);
+			BUG_ON(irqs_disabled());
+			break;
+	}
+	return result;
+}
+
+/* suspend_drivers_resume
+ *
+ * Resume the drivers after an atomic copy (save or restore)
+ */
+void suspend_drivers_resume(int stage)
+{
+	switch (stage) {
+		case SUSPEND_DRIVERS_IRQS_DISABLED:
+			BUG_ON(!irqs_disabled());
+			device_power_up();
+			BUG_ON(!irqs_disabled());
+			break;
+
+		case SUSPEND_DRIVERS_IRQS_ENABLED:
+			BUG_ON(irqs_disabled());
+#ifdef CONFIG_ACPI
+			if (suspend_pm_state_used)
+				acpi_leave_sleep_state(suspend_pm_state_used);
+#endif
+			suspend_pm_state_finish();
+			BUG_ON(irqs_disabled());
+			break;
+	}
+}
diff -ruNp 609-driver-model.patch-old/kernel/power/suspend2_core/driver_model.h 609-driver-model.patch-new/kernel/power/suspend2_core/driver_model.h
--- 609-driver-model.patch-old/kernel/power/suspend2_core/driver_model.h	1970-01-01 10:00:00.000000000 +1000
+++ 609-driver-model.patch-new/kernel/power/suspend2_core/driver_model.h	2005-07-04 23:14:19.000000000 +1000
@@ -0,0 +1,24 @@
+/*
+ * kernel/power/driver_model.h
+ *
+ * Copyright (C) 2004-2005 Nigel Cunningham <nigel@suspend2.net>
+ *
+ * This file is released under the GPLv2.
+ *
+ * Support for the driver model.
+ */
+
+/*	suspend_drivers_resume
+ *	@stage - One of...
+ */
+
+enum {
+	SUSPEND_DRIVERS_IRQS_DISABLED,
+	SUSPEND_DRIVERS_IRQS_ENABLED,
+};
+
+extern int suspend_drivers_init(void);
+extern void suspend_drivers_cleanup(void);
+
+extern int suspend_drivers_suspend(int stage);
+extern void suspend_drivers_resume(int stage);

