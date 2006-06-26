Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933138AbWFZXlA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933138AbWFZXlA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933127AbWFZWeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:34:05 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:235 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933125AbWFZWd1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:33:27 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 03/16] [Suspend2] Save image.
Date: Tue, 27 Jun 2006 08:33:25 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223324.3832.71505.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223314.3832.23435.stgit@nigel.suspend2.net>
References: <20060626223314.3832.23435.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Save the image. The first function is the one called by the suspend_main
after the image is prepared, which saves pageset two (LRU pages) and then
sends us into the atomic copy routine. After resume (or the cycle is
cancelled), we return back to this routine. Save_image_part1, is called
after the atomic copy, to do the saving of that part of the image.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend.c |  138 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 138 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 01c930a..8ef1200 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -231,3 +231,141 @@ int suspend_start_anything(int starting_
 	return 0;
 }
 
+/*
+ * save_image
+ * Result code (int): Zero on success, non zero on failure.
+ * Functionality    : High level routine which performs the steps necessary
+ *                    to prepare and save the image after preparatory steps
+ *                    have been taken.
+ * Key Assumptions  : Processes frozen, sufficient memory available, drivers
+ *                    suspended.
+ * Called from      : suspend_suspend_2
+ */
+static int save_image(void)
+{
+	int temp_result;
+
+	suspend_message(SUSPEND_ANY_SECTION, SUSPEND_LOW, 1,
+		" - Final values: %d and %d.\n",
+		pagedir1.pageset_size, 
+		pagedir2.pageset_size);
+
+	suspend_cond_pause(1, "About to write pagedir2.");
+
+	temp_result = write_pageset(&pagedir2, 2);
+	
+	if (temp_result == -1 || test_result_state(SUSPEND_ABORTED))
+		return -1;
+
+	suspend_cond_pause(1, "About to copy pageset 1.");
+
+	if (test_result_state(SUSPEND_ABORTED))
+		return -1;
+
+	suspend_deactivate_storage(1);
+
+	suspend_prepare_status(DONT_CLEAR_BAR, "Doing atomic copy.");
+	
+	suspend2_running = 1; /* For the swsusp code we use :< */
+
+	suspend2_in_suspend = 1;
+	
+	if (device_suspend(PMSG_FREEZE))
+		return 1;
+	
+	suspend2_suspend();
+
+	suspend2_running = 0;
+
+	device_resume();
+	
+	/* Resume time? */
+	if (!suspend2_in_suspend) {
+		copyback_post();
+		return 0;
+	}
+
+	/* Nope. Suspending. So, see if we can save the image... */
+	if (!save_image_part1()) {
+		suspend_power_down();
+
+		if (read_pageset2(1))
+			panic("Attempt to reload pagedir 2 failed. Try rebooting.");
+
+		if (!test_result_state(SUSPEND_ABORT_REQUESTED) &&
+		    !test_action_state(SUSPEND_TEST_FILTER_SPEED) &&
+		    !test_action_state(SUSPEND_TEST_BIO) &&
+		    suspend_powerdown_method != PM_SUSPEND_MEM)
+			printk(KERN_EMERG name_suspend
+				"Suspend failed, trying to recover...\n");
+		barrier();
+		mb();
+	}
+
+	return 0;
+}
+
+/*
+ * Save the second part of the image.
+ */
+int save_image_part1(void)
+{
+	int temp_result;
+
+	if (suspend_activate_storage(1))
+		panic("Failed to reactivate our storage.");
+	
+	suspend_update_status(pagedir2.pageset_size,
+			pagedir1.pageset_size + pagedir2.pageset_size,
+			NULL);
+	
+	if (test_result_state(SUSPEND_ABORTED))
+		goto abort_reloading_pagedir_two;
+
+	suspend_cond_pause(1, "About to write pageset1.");
+
+	/*
+	 * End of critical section.
+	 */
+	
+	suspend_message(SUSPEND_ANY_SECTION, SUSPEND_LOW, 1,
+			"-- Writing pageset1\n");
+
+	temp_result = write_pageset(&pagedir1, 1);
+
+	/* We didn't overwrite any memory, so no reread needs to be done. */
+	if (test_action_state(SUSPEND_TEST_FILTER_SPEED))
+		return -1;
+
+	if (temp_result == -1 || test_result_state(SUSPEND_ABORTED))
+		goto abort_reloading_pagedir_two;
+
+	suspend_cond_pause(1, "About to write header.");
+
+	if (test_result_state(SUSPEND_ABORTED))
+		goto abort_reloading_pagedir_two;
+
+	temp_result = write_image_header();
+
+	if (test_action_state(SUSPEND_TEST_BIO))
+		return -1;
+
+	if (temp_result || (test_result_state(SUSPEND_ABORTED)))
+		goto abort_reloading_pagedir_two;
+
+	suspend_cond_pause(1, "About to power down or reboot.");
+
+	return 0;
+
+abort_reloading_pagedir_two:
+	temp_result = read_pageset2(1);
+
+	/* If that failed, we're sunk. Panic! */
+	if (temp_result)
+		panic("Attempt to reload pagedir 2 while aborting "
+				"a suspend failed.");
+
+	return -1;		
+
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
