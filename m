Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933124AbWFZX15@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933124AbWFZX15 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933189AbWFZX1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 19:27:30 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:44447 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933173AbWFZWgH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:36:07 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 02/19] [Suspend2] Attempt to parse resume device.
Date: Tue, 27 Jun 2006 08:36:05 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223603.4219.87033.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223557.4219.53030.stgit@nigel.suspend2.net>
References: <20060626223557.4219.53030.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add core routine that attempts to parse the resume2= parameter by asking
each enabled writer whether it considers the resume2= value to have
provided it with a usable configuration. If a driver returns success,
it is made the active writer and the 'we-can-try-to-resume' flag is set.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/io.c |   75 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 75 insertions(+), 0 deletions(-)

diff --git a/kernel/power/io.c b/kernel/power/io.c
index df0ec8d..52f538d 100644
--- a/kernel/power/io.c
+++ b/kernel/power/io.c
@@ -29,3 +29,78 @@
 #include "prepare_image.h"
 #include "extent.h"
 
+/* suspend_attempt_to_parse_resume_device
+ *
+ * Can we suspend, using the current resume2= parameter?
+ */
+int suspend_attempt_to_parse_resume_device(void)
+{
+	struct list_head *writer;
+	struct suspend_module_ops *this_writer;
+	int result, returning = 0;
+
+	if (suspend_activate_storage(0))
+		return 0;
+
+	suspend_active_writer = NULL;
+	clear_suspend_state(SUSPEND_RESUME_DEVICE_OK);
+	clear_suspend_state(SUSPEND_CAN_RESUME);
+	clear_result_state(SUSPEND_ABORTED);
+
+	if (!suspend_num_writers) {
+		printk(name_suspend "No writers have been registered. Suspending will be disabled.\n");
+		goto cleanup;
+	}
+	
+	if (!resume2_file[0]) {
+		printk(name_suspend "Resume2 parameter is empty. Suspending will be disabled.\n");
+		goto cleanup;
+	}
+
+	list_for_each(writer, &suspend_writers) {
+		this_writer = list_entry(writer, struct suspend_module_ops, type_list);
+
+		/* 
+		 * Not sure why you'd want to disable a writer, but
+		 * we should honour the flag if we're providing it
+		 */
+		if (this_writer->disabled) {
+			printk(name_suspend
+					"Writer '%s' is disabled. Ignoring it.\n",
+					this_writer->name);
+			continue;
+		}
+
+		result = this_writer->parse_sig_location(
+				resume2_file, (suspend_num_writers == 1));
+
+		switch (result) {
+			case -EINVAL:
+				/* 
+				 * For this writer, but not a valid 
+				 * configuration. Error already printed.
+				 */
+
+				goto cleanup;
+
+			case 0:
+				/*
+				 * For this writer and valid.
+				 */
+
+				suspend_active_writer = this_writer;
+
+				set_suspend_state(SUSPEND_RESUME_DEVICE_OK);
+				set_suspend_state(SUSPEND_CAN_RESUME);
+				printk(name_suspend "Resuming enabled.\n");
+
+				returning = 1;
+				goto cleanup;
+		}
+	}
+	printk(name_suspend "No matching enabled writer found. Resuming disabled.\n");
+cleanup:
+	suspend_deactivate_storage(0);
+	return returning;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
