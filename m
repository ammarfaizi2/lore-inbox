Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262068AbVGFDF6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262068AbVGFDF6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 23:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbVGFDE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 23:04:56 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:8857 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262068AbVGFCT0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 22:19:26 -0400
Subject: [PATCH] [25/48] Suspend2 2.1.9.8 for 2.6.12: 602-smp.patch
In-Reply-To: <11206164393426@foobar.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 6 Jul 2005 12:20:42 +1000
Message-Id: <11206164422727@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Nigel Cunningham <nigel@suspend2.net>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Nigel Cunningham <nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruNp 603-suspend2_common-headers.patch-old/kernel/power/suspend2_core/suspend2_common.h 603-suspend2_common-headers.patch-new/kernel/power/suspend2_core/suspend2_common.h
--- 603-suspend2_common-headers.patch-old/kernel/power/suspend2_core/suspend2_common.h	1970-01-01 10:00:00.000000000 +1000
+++ 603-suspend2_common-headers.patch-new/kernel/power/suspend2_core/suspend2_common.h	2005-07-04 23:14:19.000000000 +1000
@@ -0,0 +1,49 @@
+#ifdef CONFIG_PM_DEBUG
+#define SET_DEBUG_STATE(bit) (test_and_set_bit(bit, &suspend_debug_state))
+#define CLEAR_DEBUG_STATE(bit) (test_and_clear_bit(bit, &suspend_debug_state))
+#else
+#define SET_DEBUG_STATE(bit) (0)
+#define CLEAR_DEBUG_STATE(bit) (0)
+#endif
+
+#define SET_RESULT_STATE(bit) (test_and_set_bit(bit, &suspend_result))
+#define CLEAR_RESULT_STATE(bit) (test_and_clear_bit(bit, &suspend_result))
+
+#define SUSPEND_ABORT_REQUESTED		1
+#define SUSPEND_NOSTORAGE_AVAILABLE	2
+#define SUSPEND_INSUFFICIENT_STORAGE	3
+#define SUSPEND_FREEZING_FAILED		4
+#define SUSPEND_UNEXPECTED_ALLOC	5
+#define SUSPEND_KEPT_IMAGE		6
+#define SUSPEND_WOULD_EAT_MEMORY	7
+#define SUSPEND_UNABLE_TO_FREE_ENOUGH_MEMORY 8
+#define SUSPEND_ENCRYPTION_SETUP_FAILED	9
+
+/* second status register */
+#define SUSPEND_REBOOT			1
+#define SUSPEND_PAUSE			2
+#define SUSPEND_SLOW			3
+#define SUSPEND_NOPAGESET2		4
+#define SUSPEND_LOGALL			5
+#define SUSPEND_CAN_CANCEL		6
+#define SUSPEND_KEEP_IMAGE		7
+#define SUSPEND_FREEZER_TEST		8
+#define SUSPEND_FREEZER_TEST_SHOWALL	9
+#define SUSPEND_SINGLESTEP		10
+#define SUSPEND_PAUSE_NEAR_PAGESET_END	11
+#define SUSPEND_USE_ACPI_S4		12
+#define SUSPEND_KEEP_METADATA		13
+#define SUSPEND_TEST_FILTER_SPEED	14
+#define SUSPEND_FREEZE_TIMERS		15
+#define SUSPEND_DISABLE_SYSDEV_SUPPORT	16
+#define SUSPEND_VGA_POST		17
+
+#define TEST_ACTION_STATE(bit) (test_bit(bit, &suspend_action))
+#define SET_ACTION_STATE(bit) (test_and_set_bit(bit, &suspend_action))
+#define CLEAR_ACTION_STATE(bit) (test_and_clear_bit(bit, &suspend_action))
+
+extern int suspend_act_used;
+extern int suspend_lvl_used;
+extern int suspend_dbg_used;
+extern int suspend_default_console_level;
+extern unsigned int nr_suspends;
diff -ruNp 603-suspend2_common-headers.patch-old/kernel/power/suspend2_core/suspend.h 603-suspend2_common-headers.patch-new/kernel/power/suspend2_core/suspend.h
--- 603-suspend2_common-headers.patch-old/kernel/power/suspend2_core/suspend.h	1970-01-01 10:00:00.000000000 +1000
+++ 603-suspend2_common-headers.patch-new/kernel/power/suspend2_core/suspend.h	2005-07-05 23:48:59.000000000 +1000
@@ -0,0 +1,24 @@
+/*
+ * kernel/power/suspend2.h
+ *
+ * Copyright (C) 2004-2005 Nigel Cunningham <nigel@suspend2.net>
+ *
+ * This file is released under the GPLv2.
+ *
+ * It contains declarations used throughout swsusp and suspend2.
+ *
+ */
+#ifndef KERNEL_POWER_SUSPEND_CORE_H
+#define KERNEL_POWER_SUSPEND_CORE_H
+
+#include <linux/delay.h>
+#include <linux/bootmem.h>
+
+extern unsigned long suspend2_orig_mem_free;
+
+#define KB(x) ((x) << (PAGE_SHIFT - 10))
+#define MB(x) ((x) >> (20 - PAGE_SHIFT))
+
+extern int suspend_start_anything(int starting_cycle);
+extern void suspend_finish_anything(int finishing_cycle);
+#endif
diff -ruNp 603-suspend2_common-headers.patch-old/kernel/power/suspend2_core/version.h 603-suspend2_common-headers.patch-new/kernel/power/suspend2_core/version.h
--- 603-suspend2_common-headers.patch-old/kernel/power/suspend2_core/version.h	1970-01-01 10:00:00.000000000 +1000
+++ 603-suspend2_common-headers.patch-new/kernel/power/suspend2_core/version.h	2005-07-04 23:14:19.000000000 +1000
@@ -0,0 +1,5 @@
+#define SUSPEND_CORE_VERSION "2.1.9.8"
+#ifndef KERNEL_POWER_SWSUSP_C
+#define name_suspend "Software Suspend " SUSPEND_CORE_VERSION ": "
+#endif
+

