Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933431AbWF0Elw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933431AbWF0Elw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933435AbWF0Elv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:41:51 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:46555 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933431AbWF0Elo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:41:44 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 09/21] [Suspend2] Update progress bar.
Date: Tue, 27 Jun 2006 14:41:43 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627044141.14883.48602.stgit@nigel.suspend2.net>
In-Reply-To: <20060627044112.14883.55823.stgit@nigel.suspend2.net>
References: <20060627044112.14883.55823.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update the progress bar (if userui is displaying one), and possbly display
some text in the bar itself (eg a/b MB written).

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/ui.c |   73 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 73 insertions(+), 0 deletions(-)

diff --git a/kernel/power/ui.c b/kernel/power/ui.c
index 2f779a5..b01c89b 100644
--- a/kernel/power/ui.c
+++ b/kernel/power/ui.c
@@ -210,3 +210,76 @@ static unsigned long userui_memory_neede
 	return (128 * PAGE_SIZE);
 }
 
+/* suspend_update_status
+ *
+ * Description: Update the progress bar and (if on) in-bar message.
+ * Arguments:	UL value, maximum: Current progress percentage (value/max).
+ * 		const char *fmt, ...: Message to be displayed in the middle
+ * 		of the progress bar.
+ * 		Note that a NULL message does not mean that any previous
+ * 		message is erased! For that, you need suspend_prepare_status with
+ * 		clearbar on.
+ * Returns:	Unsigned long: The next value where status needs to be updated.
+ * 		This is to reduce unnecessary calls to update_status.
+ */
+unsigned long suspend_update_status(unsigned long value, unsigned long maximum,
+		const char *fmt, ...)
+{
+	static int last_step = -1;
+	struct userui_msg_params msg;
+	int bitshift;
+	int this_step;
+	unsigned long next_update;
+
+	if (ui_helper_data.pid == -1)
+		return 0;
+
+	if ((!maximum) || (!progress_granularity))
+		return maximum;
+
+	if (value < 0)
+		value = 0;
+
+	if (value > maximum)
+		value = maximum;
+
+	/* Try to avoid math problems - we can't do 64 bit math here
+	 * (and shouldn't need it - anyone got screen resolution
+	 * of 65536 pixels or more?) */
+	bitshift = fls(maximum) - 16;
+	if (bitshift > 0) {
+		unsigned long temp_maximum = maximum >> bitshift;
+		unsigned long temp_value = value >> bitshift;
+		this_step = (int)
+			(temp_value * progress_granularity / temp_maximum);
+		next_update = (((this_step + 1) * temp_maximum /
+					progress_granularity) + 1) << bitshift;
+	} else {
+		this_step = (int) (value * progress_granularity / maximum);
+		next_update = ((this_step + 1) * maximum /
+				progress_granularity) + 1;
+	}
+
+	if (this_step == last_step)
+		return next_update;
+
+	memset(&msg, 0, sizeof(msg));
+
+	msg.a = this_step;
+	msg.b = progress_granularity;
+
+	if (fmt) {
+		va_list args;
+		va_start(args, fmt);
+		vsnprintf(msg.text, sizeof(msg.text), fmt, args);
+		va_end(args);
+		msg.text[sizeof(msg.text)-1] = '\0';
+	}
+
+	suspend_send_netlink_message(&ui_helper_data, USERUI_MSG_PROGRESS,
+			&msg, sizeof(msg));
+	last_step = this_step;
+
+	return next_update;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
