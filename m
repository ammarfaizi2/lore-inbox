Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932880AbWF0EwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932880AbWF0EwQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933429AbWF0Evj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:51:39 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:47067 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933432AbWF0Els
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:41:48 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 10/21] [Suspend2] __suspend_message.
Date: Tue, 27 Jun 2006 14:41:46 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627044145.14883.63880.stgit@nigel.suspend2.net>
In-Reply-To: <20060627044112.14883.55823.stgit@nigel.suspend2.net>
References: <20060627044112.14883.55823.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The guts of the suspend_message routine. This is for highlevel descriptions
of what we're doing, which are also printk'd if we're logging everything.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/ui.c |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/kernel/power/ui.c b/kernel/power/ui.c
index b01c89b..3378766 100644
--- a/kernel/power/ui.c
+++ b/kernel/power/ui.c
@@ -283,3 +283,51 @@ unsigned long suspend_update_status(unsi
 	return next_update;
 }
 
+/* __suspend_message.
+ *
+ * Description:	This function is intended to do the same job as printk, but
+ * 		without normally logging what is printed. The point is to be
+ * 		able to get debugging info on screen without filling the logs
+ * 		with "1/534. ^M 2/534^M. 3/534^M"
+ *
+ * 		It may be called from an interrupt context - can't sleep!
+ *
+ * Arguments:	int mask: The debugging section(s) this message belongs to.
+ * 		int level: The level of verbosity of this message.
+ * 		int restartline: Whether to output a \r or \n with this line
+ * 			(\n if we're logging all output).
+ * 		const char *fmt, ...: Message to be displayed a la printk.
+ */
+void __suspend_message(unsigned long section, unsigned long level,
+		int normally_logged,
+		const char *fmt, ...)
+{
+	struct userui_msg_params msg;
+
+	if ((level) && (level > console_loglevel))
+		return;
+
+	memset(&msg, 0, sizeof(msg));
+
+	msg.a = section;
+	msg.b = level;
+	msg.c = normally_logged;
+
+	if (fmt) {
+		va_list args;
+		va_start(args, fmt);
+		vsnprintf(msg.text, sizeof(msg.text), fmt, args);
+		va_end(args);
+		msg.text[sizeof(msg.text)-1] = '\0';
+	}
+
+	if (test_action_state(SUSPEND_LOGALL))
+		printk("%s\n", msg.text);
+
+	if (ui_helper_data.pid == -1)
+		return;
+
+	suspend_send_netlink_message(&ui_helper_data, USERUI_MSG_MESSAGE,
+			&msg, sizeof(msg));
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
