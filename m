Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933204AbWFZXWw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933204AbWFZXWw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933216AbWFZXWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 19:22:35 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:51103 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933189AbWFZWgv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:36:51 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 15/19] [Suspend2] Core of code for reading pageset1.
Date: Tue, 27 Jun 2006 08:36:49 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223648.4219.80371.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223557.4219.53030.stgit@nigel.suspend2.net>
References: <20060626223557.4219.53030.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Core code for reading pageset1, which checks that an image exists, that we
haven't been told not to resume (noresume2) and that the user wants to try
again if we've tried before. Once these tests are passed, we start to read
the image header, checking that the sanity checks are passed, and then the
image proper.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/io.c |  183 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 183 insertions(+), 0 deletions(-)

diff --git a/kernel/power/io.c b/kernel/power/io.c
index 8c9c284..35fb081 100644
--- a/kernel/power/io.c
+++ b/kernel/power/io.c
@@ -715,3 +715,186 @@ static char *sanity_check(struct suspend
 	return 0;
 }
 
+/* __read_pageset1
+ *
+ * Description:	Test for the existence of an image and attempt to load it.
+ * Returns:	Int. Zero if image found and pageset1 successfully loaded.
+ * 		Error if no image found or loaded.
+ */
+static int __read_pageset1(void)
+{			
+	int i, result = 0;
+	char *header_buffer = (char *) get_zeroed_page(GFP_ATOMIC),
+	     *sanity_error = NULL;
+	struct suspend_header *suspend_header;
+
+	if (!header_buffer)
+		return -ENOMEM;
+	
+	/* Check for an image */
+	if (!(result = suspend_active_writer->image_exists())) {
+		result = -ENODATA;
+		noresume_reset_modules();
+		goto out;
+	}
+
+	/* Check for noresume command line option */
+	if (test_suspend_state(SUSPEND_NORESUME_SPECIFIED)) {
+		suspend_active_writer->invalidate_image();
+		result = -EINVAL;
+		noresume_reset_modules();
+		goto out;
+	}
+
+	/* Check whether we've resumed before */
+	if (test_suspend_state(SUSPEND_RESUMED_BEFORE)) {
+		int resumed_before_default = 0;
+		if (test_suspend_state(SUSPEND_RETRY_RESUME))
+			resumed_before_default = SUSPEND_CONTINUE_REQ;
+		suspend_early_boot_message(1, resumed_before_default, NULL);
+		clear_suspend_state(SUSPEND_RETRY_RESUME);
+		if (!(test_suspend_state(SUSPEND_CONTINUE_REQ))) {
+			suspend_active_writer->invalidate_image();
+			result = -EINVAL;
+			noresume_reset_modules();
+			goto out;
+		}
+	}
+
+	clear_suspend_state(SUSPEND_CONTINUE_REQ);
+
+	/* 
+	 * Prepare the active writer for reading the image header. The
+	 * activate writer might read its own configuration.
+	 * 
+	 * NB: This call may never return because there might be a signature
+	 * for a different image such that we warn the user and they choose
+	 * to reboot. (If the device ids look erroneous (2.4 vs 2.6) or the
+	 * location of the image might be unavailable if it was stored on a
+	 * network connection.
+	 */
+
+	if ((result = suspend_active_writer->read_header_init())) {
+		noresume_reset_modules();
+		goto out;
+	}
+	
+	/* Read suspend header */
+	if ((result = suspend_active_writer->rw_header_chunk(READ, NULL,
+			header_buffer, sizeof(struct suspend_header))) < 0) {
+		noresume_reset_modules();
+		goto out;
+	}
+	
+	suspend_header = (struct suspend_header *) header_buffer;
+
+	/*
+	 * NB: This call may also result in a reboot rather than returning.
+	 */
+
+	if ((sanity_error = sanity_check(suspend_header)) &&
+	    suspend_early_boot_message(1, SUSPEND_CONTINUE_REQ, sanity_error)) {
+		suspend_active_writer->invalidate_image();
+		result = -EINVAL;
+		noresume_reset_modules();
+		goto out;
+	}
+
+	/*
+	 * We have an image and it looks like it will load okay.
+	 */
+
+	/* Get metadata from header. Don't override commandline parameters.
+	 *
+	 * We don't need to save the image size limit because it's not used
+	 * during resume and will be restored with the image anyway.
+	 */
+	
+	suspend_orig_mem_free = suspend_header->orig_mem_free;
+	memcpy((char *) &pagedir1,
+		(char *) &suspend_header->pagedir, sizeof(pagedir1));
+	suspend_result = suspend_header->param0;
+	suspend_action = suspend_header->param1;
+	suspend_debug_state = suspend_header->param2;
+	console_loglevel = suspend_header->param3;
+	clear_suspend_state(SUSPEND_IGNORE_LOGLEVEL);
+	pagedir2.pageset_size = suspend_header->pageset_2_size;
+	for (i = 0; i < 4; i++)
+		suspend_io_time[i/2][i%2] =
+			suspend_header->io_time[i/2][i%2];
+
+	/* Read module configurations */
+	if ((result = read_module_configs())) {
+		noresume_reset_modules();
+		pagedir1.pageset_size =
+			pagedir2.pageset_size = 0;
+		goto out;
+	}
+
+	suspend_prepare_console();
+
+	suspend_cond_pause(1, "About to read original pageset1 locations.");
+
+	/*
+	 * Read original pageset1 locations. These are the addresses we can't
+	 * use for the data to be restored.
+	 */
+
+	allocate_dyn_pageflags(&pageset1_map);
+	load_dyn_pageflags(pageset1_map);
+
+	set_suspend_state(SUSPEND_NOW_RESUMING);
+
+	/* Relocate it so that it's not overwritten while we're using it to
+	 * copy the original contents back */
+	relocate_dyn_pageflags(&pageset1_map);
+	
+	allocate_dyn_pageflags(&pageset1_copy_map);
+	relocate_dyn_pageflags(&pageset1_copy_map);
+
+	/* Clean up after reading the header */
+	if ((result = suspend_active_writer->read_header_cleanup())) {
+		noresume_reset_modules();
+		goto out_reset_console;
+	}
+
+	suspend_cond_pause(1, "About to read pagedir.");
+
+	/* 
+	 * Get the addresses of pages into which we will load the kernel to
+	 * be copied back
+	 */
+	if (suspend_get_pageset1_load_addresses()) {
+		result = -ENOMEM;
+		noresume_reset_modules();
+		goto out_reset_console;
+	}
+
+	/* Read the original kernel back */
+	suspend_cond_pause(1, "About to read pageset 1.");
+
+	if (read_pageset(&pagedir1, 1, 0)) {
+		suspend_prepare_status(CLEAR_BAR, "Failed to read pageset 1.");
+		result = -EPERM;
+		noresume_reset_modules();
+		goto out_reset_console;
+	}
+
+	suspend_cond_pause(1, "About to restore original kernel.");
+	result = 0;
+
+	if (!test_action_state(SUSPEND_KEEP_IMAGE) &&
+	    suspend_active_writer->mark_resume_attempted)
+		suspend_active_writer->mark_resume_attempted();
+
+out:
+	free_page((unsigned long) header_buffer);
+	return result;
+
+out_reset_console:
+	free_dyn_pageflags(&pageset1_map);
+	free_dyn_pageflags(&pageset1_copy_map);
+	suspend_cleanup_console();
+	goto out;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
