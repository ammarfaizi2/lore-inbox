Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933206AbWFZXmr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933206AbWFZXmr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933141AbWFZWeD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:34:03 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:747 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933127AbWFZWdb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:33:31 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 04/16] [Suspend2] Get debug info.
Date: Tue, 27 Jun 2006 08:33:29 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223327.3832.70366.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223314.3832.23435.stgit@nigel.suspend2.net>
References: <20060626223314.3832.23435.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Routines that together provide the user with debugging info via
/proc/suspend2/debug_info.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend.c |  100 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 100 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 8ef1200..769ae96 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -369,3 +369,103 @@ abort_reloading_pagedir_two:
 
 }
 
+static int io_MB_per_second(int read_write)
+{
+	if (!suspend_io_time[read_write][1])
+		return 0;
+
+	return MB((unsigned long) suspend_io_time[read_write][0]) * HZ /
+		suspend_io_time[read_write][1];
+}
+
+/* get_debug_info
+ * Functionality:	Store debug info in a buffer.
+ * Called from:		suspend2_try_suspend.
+ */
+#define SNPRINTF(a...) 	len += snprintf_used(debug_info_buffer + len, \
+		PAGE_SIZE - len - 1, ## a)
+static int get_suspend_debug_info(void)
+{
+	int len = 0;
+	if (!debug_info_buffer) {
+		debug_info_buffer = (char *) get_zeroed_page(GFP_ATOMIC);
+		if (!debug_info_buffer) {
+			printk("Error! Unable to allocate buffer for"
+					"software suspend debug info.\n");
+			return 0;
+		}
+	}
+
+	SNPRINTF("Suspend2 debugging info:\n");
+	SNPRINTF("- SUSPEND core   : %s\n", SUSPEND_CORE_VERSION);
+	SNPRINTF("- Kernel Version : %s\n", UTS_RELEASE);
+	SNPRINTF("- Compiler vers. : %d.%d\n", __GNUC__, __GNUC_MINOR__);
+	SNPRINTF("- Attempt number : %d\n", nr_suspends);
+	SNPRINTF("- Parameters     : %ld %ld %ld %d %d %ld\n",
+			suspend_result,
+			suspend_action,
+			suspend_debug_state,
+			suspend_default_console_level,
+			image_size_limit,
+			suspend_powerdown_method);
+	SNPRINTF("- Overall expected compression percentage: %d.\n",
+			100 - suspend_expected_compression_ratio());
+	len+= suspend_print_module_debug_info(debug_info_buffer + len, 
+			PAGE_SIZE - len - 1);
+	if (suspend_io_time[0][1]) {
+		if ((io_MB_per_second(0) < 5) || (io_MB_per_second(1) < 5)) {
+			SNPRINTF("- I/O speed: Write %d KB/s",
+			  (KB((unsigned long) suspend_io_time[0][0]) * HZ /
+			  suspend_io_time[0][1]));
+			if (suspend_io_time[1][1])
+				SNPRINTF(", Read %d KB/s",
+				  (KB((unsigned long) suspend_io_time[1][0]) * HZ /
+				  suspend_io_time[1][1]));
+		} else {
+			SNPRINTF("- I/O speed: Write %d MB/s",
+			 (MB((unsigned long) suspend_io_time[0][0]) * HZ /
+			  suspend_io_time[0][1]));
+			if (suspend_io_time[1][1])
+				SNPRINTF(", Read %d MB/s",
+				 (MB((unsigned long) suspend_io_time[1][0]) * HZ /
+				  suspend_io_time[1][1]));
+		}
+		SNPRINTF(".\n");
+	}
+	else
+		SNPRINTF("- No I/O speed stats available.\n");
+	SNPRINTF("- Extra pages    : %d used/%d.\n",
+			extra_pd1_pages_used, extra_pd1_pages_allowance);
+
+	return len;
+}
+
+/*
+ * debuginfo_read_proc
+ * Functionality   : Displays information that may be helpful in debugging
+ *                   software suspend.
+ */
+int debuginfo_read_proc(char *page, char **start, off_t off, int count,
+		int *eof, void *data)
+{
+	int info_len, copy_len;
+
+	info_len = get_suspend_debug_info();
+
+	copy_len = min(info_len - (int) off, count);
+	if (copy_len < 0)
+		copy_len = 0;
+
+	if (copy_len) {
+		memcpy(page, debug_info_buffer + off, copy_len);
+		*start = page;
+	} 
+
+	if (copy_len + off == info_len)
+		*eof = 1;
+
+	free_page((unsigned long) debug_info_buffer);
+	debug_info_buffer = NULL;
+	return copy_len;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
