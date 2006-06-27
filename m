Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932167AbWF0EpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbWF0EpE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933436AbWF0En4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:43:56 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:59867 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1030709AbWF0EnM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:43:12 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 13/13] [Suspend2] Suspend2 include file
Date: Tue, 27 Jun 2006 14:43:10 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627044309.15066.38496.stgit@nigel.suspend2.net>
In-Reply-To: <20060627044226.15066.7403.stgit@nigel.suspend2.net>
References: <20060627044226.15066.7403.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add suspend2 header file.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 include/linux/suspend2.h |  190 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 190 insertions(+), 0 deletions(-)

diff --git a/include/linux/suspend2.h b/include/linux/suspend2.h
new file mode 100644
index 0000000..4f8568b
--- /dev/null
+++ b/include/linux/suspend2.h
@@ -0,0 +1,190 @@
+#ifndef _LINUX_SUSPEND2_H
+#define _LINUX_SUSPEND2_H
+
+#include <linux/dyn_pageflags.h>
+
+/* arch/i386/mm/init.c */
+extern char __nosave_begin, __nosave_end;
+
+#define SECTOR_SIZE 512
+
+/* kernel/power/main.c */
+extern unsigned long suspend_result;
+
+/* kernel/power/process.c */
+extern unsigned long suspend_debug_state;
+
+/* arch/i386/power/suspend2.c */
+extern unsigned long suspend_action;
+extern int suspend_io_time[2][2];
+
+extern dyn_pageflags_t pageset1_map;
+extern dyn_pageflags_t pageset1_copy_map;
+
+#ifdef CONFIG_PM_DEBUG
+#define test_debug_state(bit) (test_bit(bit, &suspend_debug_state))
+#else
+#define test_debug_state(bit) (0)
+#endif
+
+#define test_result_state(bit) (test_bit(bit, &suspend_result))
+
+/* 
+ * First status register - this is suspend's return code.
+ *
+ * All the rest are in kernel/power/suspend2_common.h
+ */
+#define SUSPEND_ABORTED			0
+
+/* Second status register - ditto */
+#define SUSPEND_RETRY_RESUME		0
+
+/* Debug sections  - if debugging compiled in */
+enum {
+	SUSPEND_ANY_SECTION,
+	SUSPEND_EAT_MEMORY,
+	SUSPEND_IO,
+	SUSPEND_HEADER,
+	SUSPEND_WRITER,
+	SUSPEND_MEMORY,
+};
+
+/* debugging levels. */
+#define SUSPEND_STATUS		0
+#define SUSPEND_ERROR		2
+#define SUSPEND_LOW	 	3
+#define SUSPEND_MEDIUM	 	4
+#define SUSPEND_HIGH	  	5
+#define SUSPEND_VERBOSE		6
+
+/* Configuration flags */
+enum {
+	SUSPEND_REBOOT,
+	SUSPEND_PAUSE,
+	SUSPEND_SLOW,
+	SUSPEND_LOGALL,
+	SUSPEND_CAN_CANCEL,
+	SUSPEND_KEEP_IMAGE,
+	SUSPEND_FREEZER_TEST,
+	SUSPEND_SINGLESTEP,
+	SUSPEND_PAUSE_NEAR_PAGESET_END,
+	SUSPEND_TEST_FILTER_SPEED,
+	SUSPEND_TEST_BIO,
+	SUSPEND_NO_PAGESET2,
+};
+
+#ifdef CONFIG_SUSPEND2
+#define test_action_state(bit) (test_bit(bit, &suspend_action))
+#define set_action_state(bit) (test_and_set_bit(bit, &suspend_action))
+#define clear_action_state(bit) (test_and_clear_bit(bit, &suspend_action))
+#else
+#define test_action_state(bit) (0)
+#endif
+
+extern void __suspend_message(unsigned long section, unsigned long level, int log_normally,
+		const char *fmt, ...);
+
+#ifdef CONFIG_PM_DEBUG
+#define suspend_message(sn, lev, log, fmt, a...) \
+do { \
+	if (test_debug_state(sn)) \
+		__suspend_message(sn, lev, log, fmt, ##a); \
+} while(0)
+#else /* CONFIG_PM_DEBUG */
+#define suspend_message(sn, lev, log, fmt, a...) \
+do { \
+	if (lev == 0) \
+		__suspend_message(sn, lev, log, fmt, ##a); \
+} while(0)
+#endif /* CONFIG_PM_DEBUG */
+  
+/* Suspend 2 */
+
+enum {
+	SUSPEND_CAN_SUSPEND,
+	SUSPEND_CAN_RESUME,
+	SUSPEND_RUNNING,
+	SUSPEND_RESUME_DEVICE_OK,
+	SUSPEND_NORESUME_SPECIFIED,
+	SUSPEND_SANITY_CHECK_PROMPT,
+	SUSPEND_PAGESET2_NOT_LOADED,
+	SUSPEND_CONTINUE_REQ,
+	SUSPEND_RESUMED_BEFORE,
+	SUSPEND_RESUME_NOT_DONE,
+	SUSPEND_BOOT_TIME,
+	SUSPEND_NOW_RESUMING,
+	SUSPEND_IGNORE_LOGLEVEL,
+	SUSPEND_TRYING_TO_RESUME,
+	SUSPEND_TRY_RESUME_RD,
+	SUSPEND_IGNORE_ROOTFS,
+};
+
+/* --------------------------------------------------------------------- */
+#ifdef CONFIG_SUSPEND2
+
+/* Used in init dir files */
+extern unsigned long suspend_state;
+
+extern void suspend2_try_resume(void);
+extern int suspend_early_boot_message 
+	(int can_erase_image, int default_answer, char *warning_reason, ...);
+extern unsigned long suspend_update_status (unsigned long value, unsigned long maximum,
+		const char *fmt, ...);
+extern void suspend_prepare_status (int clearbar, const char *fmt, ...);
+
+#define test_suspend_state(bit) \
+	(test_bit(bit, &suspend_state))
+
+#define clear_suspend_state(bit) \
+	(clear_bit(bit, &suspend_state))
+
+#define set_suspend_state(bit) \
+	(set_bit(bit, &suspend_state))
+
+extern void suspend2_try_suspend(void);
+
+/* --------------------------------------------------------------------- */
+#else
+/* --------------------------------------------------------------------- */
+
+#define suspend_state		(0)
+#define clear_suspend_state(bit)	do { } while (0)
+#define test_suspend_state(bit) 	(0)
+#define set_suspend_state(bit)		do { } while(0)
+
+#define suspend2_try_resume()			do { } while(0)
+static inline int suspend_early_boot_message(int a, int b, char *c, ...)	{ return 0; }
+static inline unsigned long suspend_update_status(unsigned long value, unsigned long maximum,
+		const char *fmt, ...)
+{
+	return maximum;
+}
+#define suspend_prepare_status(a, ...)  do { } while(0)
+
+#endif /* CONFIG_SUSPEND2 */
+
+#define test_and_set_suspend_state(bit) \
+	(test_and_set_bit(bit, &suspend_state))
+
+#define get_suspend_state()  (suspend_state)
+
+#define restore_suspend_state(saved_state) \
+	do { suspend_state = saved_state; } while(0)
+	
+#if defined(CONFIG_SUSPEND2) && defined(CONFIG_ACPI)
+#include <acpi/acpi.h>
+static inline int may_try_suspend2(u32 state)
+{
+	if (state == ACPI_STATE_S4) {
+		suspend2_try_suspend();
+		return 1;
+	}
+	return 0;
+}
+#else
+static inline int may_try_suspend2(u32 state)
+{
+	return 0;
+}
+#endif
+#endif /* _LINUX_SUSPEND2_H */

--
Nigel Cunningham		nigel at suspend2 dot net
