Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933210AbWFZXoL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933210AbWFZXoL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933134AbWFZWd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:33:56 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:2283 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933128AbWFZWdl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:33:41 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 07/16] [Suspend2] Suspend2 init/cleanup.
Date: Tue, 27 Jun 2006 08:33:39 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223337.3832.93772.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223314.3832.23435.stgit@nigel.suspend2.net>
References: <20060626223314.3832.23435.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Basic initialisation and cleanup for a suspend cycle.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend.c |   73 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 73 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 6457d75..504eed7 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -502,3 +502,76 @@ static int check_still_keeping_image(voi
 	return 0;
 }
 
+static int suspend_init(void)
+{
+	suspend_result = 0;
+
+	printk(name_suspend "Initiating a software suspend cycle.\n");
+
+	nr_suspends++;
+	clear_suspend_state(SUSPEND_NOW_RESUMING);
+	
+	orig_system_state = system_state;
+	
+	suspend_io_time[0][0] = suspend_io_time[0][1] = 
+		suspend_io_time[1][0] =
+		suspend_io_time[1][1] = 0;
+
+	free_metadata();	/* We might have kept it */
+
+	if (!test_suspend_state(SUSPEND_CAN_SUSPEND))
+		return 0;
+	
+	if (allocate_bitmaps())
+		return 0;
+	
+	suspend_prepare_console();
+	disable_nonboot_cpus();
+
+	return 1;
+}
+
+void suspend_cleanup(void)
+{
+	int i;
+
+	i = get_suspend_debug_info();
+
+	suspend_free_extra_pagedir_memory();
+	
+	pagedir1.pageset_size = pagedir2.pageset_size = 0;
+
+	system_state = orig_system_state;
+
+	thaw_processes(FREEZER_KERNEL_THREADS);
+
+#ifdef CONFIG_SUSPEND2_KEEP_IMAGE
+	if (test_action_state(SUSPEND_KEEP_IMAGE) &&
+	    !test_result_state(SUSPEND_ABORTED)) {
+		suspend_message(SUSPEND_ANY_SECTION, SUSPEND_LOW, 1,
+			name_suspend "Not invalidating the image due "
+			"to Keep Image being enabled.\n");
+		set_result_state(SUSPEND_KEPT_IMAGE);
+	} else
+#endif
+		if (suspend_active_writer)
+			suspend_active_writer->invalidate_image();
+
+	free_metadata();
+
+	if (debug_info_buffer) {
+		/* Printk can only handle 1023 bytes, including
+		 * its level mangling. */
+		for (i = 0; i < 3; i++)
+			printk("%s", debug_info_buffer + (1023 * i));
+		free_page((unsigned long) debug_info_buffer);
+		debug_info_buffer = NULL;
+	}
+
+	thaw_processes(FREEZER_ALL_THREADS);
+	enable_nonboot_cpus();
+	suspend_cleanup_console();
+
+	up(&pm_sem);
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
