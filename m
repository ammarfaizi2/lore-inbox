Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933129AbWFZXnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933129AbWFZXnP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933150AbWFZXmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 19:42:49 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:25503 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933140AbWFZWeB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:34:01 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 13/16] [Suspend2] do_resume routine.
Date: Tue, 27 Jun 2006 08:34:00 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223358.3832.74079.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223314.3832.23435.stgit@nigel.suspend2.net>
References: <20060626223314.3832.23435.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Main routine for seeing if we can resume - and doing it!

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend.c |   98 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 98 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index f7138c1..0f751d1 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -910,3 +910,101 @@ static __init int core_load(void)
 	return 0;
 }
 
+/*
+ * Called from init kernel_thread.
+ * We check if we have an image and if so we try to resume.
+ * We also start ksuspendd if configuration looks right.
+ */
+int suspend_resume(void)
+{
+	int read_image_result = 0;
+
+	if (sizeof(swp_entry_t) != sizeof(long)) {
+		printk(KERN_WARNING name_suspend
+			"The size of swp_entry_t != size of long. "
+			"Please report this!\n");
+		return 1;
+	}
+	
+	if (!resume2_file[0])
+		printk(KERN_WARNING name_suspend
+			"You need to use a resume2= command line parameter to "
+			"tell Suspend2 where to look for an image.\n");
+
+	suspend_activate_storage(0);
+
+	if (!(test_suspend_state(SUSPEND_RESUME_DEVICE_OK)) &&
+		!suspend_attempt_to_parse_resume_device()) {
+		/* 
+		 * Without a usable storage device we can do nothing - 
+		 * even if noresume is given
+		 */
+
+		if (!suspend_num_writers)
+			printk(KERN_ALERT name_suspend
+				"No writers have been registered.\n");
+		else
+			printk(KERN_ALERT name_suspend
+				"Missing or invalid storage location "
+				"(resume2= parameter). Please correct and "
+				"rerun lilo (or equivalent) before "
+				"suspending.\n");
+		suspend_deactivate_storage(0);
+		return 1;
+	}
+
+	suspend_orig_mem_free = real_nr_free_pages();
+
+	read_image_result = read_pageset1(); /* non fatal error ignored */
+
+	if (test_suspend_state(SUSPEND_NORESUME_SPECIFIED))
+		printk(KERN_WARNING name_suspend "Resuming disabled as requested.\n");
+
+	suspend_deactivate_storage(0);
+	
+	if (read_image_result)
+		return 1;
+
+	suspend2_running = 1;
+
+	suspend_atomic_restore();
+
+	BUG();
+
+	return 0;
+}
+
+/* -- Functions for kickstarting a suspend or resume --- */
+
+/*
+ * Check if we have an image and if so try to resume.
+ */
+void __suspend_try_resume(void)
+{
+	set_suspend_state(SUSPEND_TRYING_TO_RESUME);
+	
+	clear_suspend_state(SUSPEND_RESUME_NOT_DONE);
+
+	suspend_resume();
+
+	clear_suspend_state(SUSPEND_IGNORE_LOGLEVEL);
+	clear_suspend_state(SUSPEND_TRYING_TO_RESUME);
+}
+
+/* Wrapper for when called from init/do_mounts.c */
+void suspend2_try_resume(void)
+{
+	if (suspend_start_anything(0))
+		return;
+
+	__suspend_try_resume();
+
+	/* 
+	 * For initramfs, we have to clear the boot time
+	 * flag after trying to resume
+	 */
+	clear_suspend_state(SUSPEND_BOOT_TIME);
+
+	suspend_finish_anything(0);
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
