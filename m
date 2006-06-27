Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932589AbWF0EwU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932589AbWF0EwU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932529AbWF0EwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:52:18 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:43995 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S932094AbWF0El1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:41:27 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 04/21] [Suspend2] Process abort request.
Date: Tue, 27 Jun 2006 14:41:26 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627044124.14883.54789.stgit@nigel.suspend2.net>
In-Reply-To: <20060627044112.14883.55823.stgit@nigel.suspend2.net>
References: <20060627044112.14883.55823.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Handle a request via the userui that we abort a cycle. This is ignored at
resume time or if we're already aborting.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/ui.c |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/kernel/power/ui.c b/kernel/power/ui.c
index 0441be5..365c033 100644
--- a/kernel/power/ui.c
+++ b/kernel/power/ui.c
@@ -92,3 +92,29 @@ void userui_redraw(void)
 			USERUI_MSG_REDRAW, NULL, 0);
 }
 
+/* request_abort_suspend
+ *
+ * Description:	Handle the user requesting the cancellation of a suspend by
+ * 		pressing escape.
+ * Callers:	Invoked from a netlink packet from userspace when the user presses
+ * 	 	escape.
+ */
+void request_abort_suspend(void)
+{
+	if (test_result_state(SUSPEND_ABORT_REQUESTED))
+		return;
+
+	if (test_suspend_state(SUSPEND_NOW_RESUMING)) {
+		suspend_prepare_status(CLEAR_BAR, "Escape pressed. "
+					"Powering down again.");
+		suspend_power_down();
+	} else {
+		suspend_prepare_status(CLEAR_BAR, "--- ESCAPE PRESSED :"
+					" ABORTING PROCESS ---");
+		set_result_state(SUSPEND_ABORTED);
+		set_result_state(SUSPEND_ABORT_REQUESTED);
+	
+		wake_up_interruptible(&userui_wait_for_key);
+	}
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
