Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933256AbWFZX0J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933256AbWFZX0J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933206AbWFZXZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 19:25:33 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:50079 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933123AbWFZWgo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:36:44 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 13/19] [Suspend2] Write image header.
Date: Tue, 27 Jun 2006 08:36:43 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223641.4219.12586.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223557.4219.53030.stgit@nigel.suspend2.net>
References: <20060626223557.4219.53030.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Write the header of an image to storage.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/io.c |   62 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 62 insertions(+), 0 deletions(-)

diff --git a/kernel/power/io.c b/kernel/power/io.c
index b179c50..d7c48e0 100644
--- a/kernel/power/io.c
+++ b/kernel/power/io.c
@@ -614,3 +614,65 @@ static int read_module_configs(void)
 	return 0;
 }
 
+/* write_image_header()
+ *
+ * Description:	Write the image header after write the image proper.
+ * Returns:	Int. Zero on success or -1 on failure.
+ */
+
+int write_image_header(void)
+{
+	int ret;
+	int total = pagedir1.pageset_size + pagedir2.pageset_size+2;
+	char *header_buffer = NULL;
+
+	/* Now prepare to write the header */
+	if ((ret = suspend_active_writer->write_header_init())) {
+		abort_suspend("Active writer's write_header_init"
+				" function failed.");
+		goto write_image_header_abort;
+	}
+
+	/* Get a buffer */
+	header_buffer = (char *) get_zeroed_page(GFP_ATOMIC);
+	if (!header_buffer) {
+		abort_suspend("Out of memory when trying to get page "
+				"for header!");
+		goto write_image_header_abort;
+	}
+
+	/* Write suspend header */
+	fill_suspend_header((struct suspend_header *) header_buffer);
+	suspend_active_writer->rw_header_chunk(WRITE, NULL,
+			header_buffer, sizeof(struct suspend_header));
+
+	free_page((unsigned long) header_buffer);
+
+	/* Write module configurations */
+	if ((ret = write_module_configs())) {
+		abort_suspend("Failed to write module configs.");
+		goto write_image_header_abort;
+	}
+
+	save_dyn_pageflags(pageset1_map);
+
+	/* Flush data and let writer cleanup */
+	if (suspend_active_writer->write_header_cleanup()) {
+		abort_suspend("Failed to cleanup writing header.");
+		goto write_image_header_abort_no_cleanup;
+	}
+
+	if (test_result_state(SUSPEND_ABORTED))
+		goto write_image_header_abort_no_cleanup;
+
+	suspend_message(SUSPEND_IO, SUSPEND_VERBOSE, 1, "|\n");
+	suspend_update_status(total, total, NULL);
+
+	return 0;
+
+write_image_header_abort:
+	suspend_active_writer->write_header_cleanup();
+write_image_header_abort_no_cleanup:
+	return -1;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
