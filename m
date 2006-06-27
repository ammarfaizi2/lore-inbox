Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933414AbWF0Es5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933414AbWF0Es5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030691AbWF0Esg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:48:36 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:49115 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1030692AbWF0EmB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:42:01 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 14/21] [Suspend2] Conditionally pause.
Date: Tue, 27 Jun 2006 14:42:00 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627044159.14883.5354.stgit@nigel.suspend2.net>
In-Reply-To: <20060627044112.14883.55823.stgit@nigel.suspend2.net>
References: <20060627044112.14883.55823.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pause until the user presses the space bar while we have a userui helper
and the abort flag isn't set and we're pausing or single stepping. Pausing
is also conditional on a parameter so that we can pause at some places when
singlestepping and not pause if not singlestepping.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/ui.c |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/kernel/power/ui.c b/kernel/power/ui.c
index b11edb8..a915a75 100644
--- a/kernel/power/ui.c
+++ b/kernel/power/ui.c
@@ -466,3 +466,36 @@ void suspend_prepare_status(int clearbar
 		printk(KERN_EMERG "%s\n", lastheader);
 }
 
+/* suspend_cond_pause
+ * 
+ * Description:	Potentially pause and wait for the user to tell us to continue.
+ * 		We normally only pause when @pause is set.
+ * Arguments:	int pause: Whether we normally pause.
+ * 		char *message: The message to display. Not parameterised
+ * 		 because it's normally a constant.
+ */
+
+void suspend_cond_pause(int pause, char *message)
+{
+#ifdef CONFIG_PM_DEBUG
+	int displayed_message = 0, last_key = 0;
+	
+	while (last_key != 32 &&
+		ui_helper_data.pid != -1 &&
+		(!test_result_state(SUSPEND_ABORTED)) &&
+		((test_action_state(SUSPEND_PAUSE) && pause) || 
+		 (test_action_state(SUSPEND_SINGLESTEP)))) {
+		if (!displayed_message) {
+			suspend_prepare_status(DONT_CLEAR_BAR, 
+			   "%s Press SPACE to continue.%s",
+			   message ? message : "",
+			   (test_action_state(SUSPEND_SINGLESTEP)) ? 
+			   " Single step on." : "");
+			displayed_message = 1;
+		}
+		last_key = suspend_wait_for_keypress(0);
+	}
+#endif
+	schedule();
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
