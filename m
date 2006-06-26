Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933184AbWFZXWf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933184AbWFZXWf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933204AbWFZWgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:36:48 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:47519 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933184AbWFZWg1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:36:27 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 08/19] [Suspend2] I/O main loop.
Date: Tue, 27 Jun 2006 08:36:25 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223624.4219.85909.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223557.4219.53030.stgit@nigel.suspend2.net>
References: <20060626223557.4219.53030.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Main I/O loop in the core of Suspend2. Submits pages for I/O to the first
plugin in the pipeline and sends status updates to any userui component.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/io.c |   65 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 65 insertions(+), 0 deletions(-)

diff --git a/kernel/power/io.c b/kernel/power/io.c
index be13f42..f237231 100644
--- a/kernel/power/io.c
+++ b/kernel/power/io.c
@@ -241,3 +241,68 @@ static int rw_cleanup_modules(int rw)
 	return result;
 }
 
+/*
+ * do_rw_loop
+ *
+ * The main I/O loop for reading or writing pages.
+ */
+static int do_rw_loop(int write, int finish_at, dyn_pageflags_t *pageflags,
+		int base, int barmax)
+{
+	int current_page_index = -1, pc, step = 1, nextupdate = 0, i;
+	int result;
+	struct suspend_module_ops *first_filter = suspend_get_next_filter(NULL);
+
+	current_page_index = get_next_bit_on(*pageflags, -1);
+
+	pc = finish_at / 5;
+
+	/* Read the pages */
+	for (i=0; i< finish_at; i++) {
+		struct page *page = pfn_to_page(current_page_index);
+
+		/* Status */
+		if ((i+base) >= nextupdate)
+			nextupdate = suspend_update_status(i+base, barmax,
+				" %d/%d MB ", MB(base+i+1), MB(barmax));
+
+		if ((i + 1) == pc) {
+			printk("%d%%...", 20 * step);
+			step++;
+			pc = finish_at * step / 5;
+		}
+		
+		if (write)
+			result = first_filter->write_chunk(page);
+		else
+			result = first_filter->read_chunk(page, SUSPEND_ASYNC);
+
+		if (result) {
+			if (write) {
+				printk("Write chunk returned %d.\n", result);
+				abort_suspend("Failed to write a chunk of the "
+					"image.");
+				return result;
+			} else
+				panic("Failed to read chunk %d/%d of the image. (%d)",
+					i, finish_at, result);
+		}
+
+		/* Interactivity*/
+		suspend_cond_pause(0, NULL);
+
+		if (test_result_state(SUSPEND_ABORTED) && write)
+			return 1;
+
+		/* Prepare next */
+		current_page_index = get_next_bit_on(*pageflags,
+				current_page_index);
+	}
+
+	printk("done.\n");
+
+	suspend_update_status(base + finish_at, barmax, " %d/%d MB ",
+			MB(base + finish_at), MB(barmax));
+	return 0;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
