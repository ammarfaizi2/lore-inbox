Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933133AbWFZWdu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933133AbWFZWdu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933132AbWFZWdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:33:49 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:23455 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933131AbWFZWdr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:33:47 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 09/16] [Suspend2] Top level routine for do_suspend.
Date: Tue, 27 Jun 2006 08:33:45 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223344.3832.83492.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223314.3832.23435.stgit@nigel.suspend2.net>
References: <20060626223314.3832.23435.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Our top level routine for suspending - activate storage, check if we can
suspend, check if a kept image is still to be used (powerdown if so), then
prepare and save the image (including powering down). When we return from
save_image, we've either aborted during saving, or resumed at a later time.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend.c |   41 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index bda4c2a..40f54f7 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -599,3 +599,44 @@ static int can_suspend(void)
 	return 1;
 }
 
+/*
+ * suspend_main
+ * Functionality   : First level of code for software suspend invocations.
+ *                   Stores and restores load averages (to avoid a spike),
+ *                   allocates bitmaps, freezes processes and eats memory
+ *                   as required before suspending drivers and invoking
+ *                   the 'low level' code to save the state to disk.
+ *                   By the time we return from do_suspend2_suspend, we
+ *                   have either failed to save the image or successfully
+ *                   suspended and reloaded the image. The difference can
+ *                   be discerned by checking SUSPEND_ABORTED.
+ * Called From     : 
+ */
+void suspend_main(void)
+{
+	if (suspend_activate_storage(0))
+		return;
+
+	if (!can_suspend())
+		goto cleanup;
+
+	/*
+	 * If kept image and still keeping image and suspending to RAM, we will 
+	 * return 1 after suspending and resuming (provided the power doesn't
+	 * run out.
+	 */
+	if (test_result_state(SUSPEND_KEPT_IMAGE) && check_still_keeping_image()) 
+		goto cleanup;
+
+
+	if (suspend_init() && !suspend_prepare_image() && !test_result_state(SUSPEND_ABORTED) &&
+		!test_action_state(SUSPEND_FREEZER_TEST)) {
+		suspend_prepare_status(DONT_CLEAR_BAR, "Starting to save the image..");
+		save_image();
+	}
+	
+cleanup:
+	suspend_cleanup();
+	suspend_deactivate_storage(0);
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
