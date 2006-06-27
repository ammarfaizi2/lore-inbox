Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933437AbWF0Eve@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933437AbWF0Eve (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932832AbWF0Euz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:50:55 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:48091 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1030619AbWF0Elz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:41:55 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 12/21] [Suspend2] Abort a cycle.
Date: Tue, 27 Jun 2006 14:41:53 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627044151.14883.70806.stgit@nigel.suspend2.net>
In-Reply-To: <20060627044112.14883.55823.stgit@nigel.suspend2.net>
References: <20060627044112.14883.55823.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Let the user know that we're aborting if they don't already know, possibly
also waiting for a keypress expressing acknowledgement.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/ui.c |   37 +++++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/kernel/power/ui.c b/kernel/power/ui.c
index 6271a24..6542f3f 100644
--- a/kernel/power/ui.c
+++ b/kernel/power/ui.c
@@ -402,3 +402,40 @@ out:
 	return key;
 }
 
+/* abort_suspend
+ *
+ * Description: Begin to abort a cycle. If this wasn't at the user's request
+ * 		(and we're displaying output), tell the user why and wait for
+ * 		them to acknowledge the message.
+ * Arguments:	A parameterised string (imagine this is printk) to display,
+ *	 	telling the user why we're aborting.
+ */
+
+void abort_suspend(const char *fmt, ...)
+{
+	va_list args;
+	int printed_len = 0;
+
+	if (!test_result_state(SUSPEND_ABORTED)) {
+		if (!test_result_state(SUSPEND_ABORT_REQUESTED)) {
+			va_start(args, fmt);
+			printed_len = vsnprintf(local_printf_buf, 
+					sizeof(local_printf_buf), fmt, args);
+			va_end(args);
+			if (ui_helper_data.pid != -1)
+				printed_len = sprintf(local_printf_buf + printed_len,
+					" (Press SPACE to continue)");
+			suspend_prepare_status(CLEAR_BAR, local_printf_buf);
+
+			/* 
+			 * Make sure message seen - wait for shift to be
+			 * released if being pressed 
+			 */
+			if (ui_helper_data.pid != -1)
+				suspend_wait_for_keypress(0);
+		}
+		/* Turn on aborting flag */
+		set_result_state(SUSPEND_ABORTED);
+	}
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
