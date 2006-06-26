Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933110AbWFZWgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933110AbWFZWgl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933194AbWFZWgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:36:39 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:48543 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933197AbWFZWge
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:36:34 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 10/19] [Suspend2] Read a portion of the image from storage.
Date: Tue, 27 Jun 2006 08:36:32 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223631.4219.24102.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223557.4219.53030.stgit@nigel.suspend2.net>
References: <20060626223557.4219.53030.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Read a set of pages from storage. The portion will normally be the same
size as was written, but may be smaller if suspending is being aborted or
the user suspended to ram instead of powering off.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/io.c |   57 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 57 insertions(+), 0 deletions(-)

diff --git a/kernel/power/io.c b/kernel/power/io.c
index fd20324..dade1fc 100644
--- a/kernel/power/io.c
+++ b/kernel/power/io.c
@@ -364,3 +364,60 @@ int write_pageset(struct pagedir *pagedi
 	return error;
 }
 
+/* read_pageset()
+ *
+ * Description:	Read a pageset from disk.
+ * Arguments:	pagedir:	Pointer to the pagedir to be saved.
+ * 		whichtowrite:	Controls what debugging output is printed.
+ * 		overwrittenpagesonly: Whether to read the whole pageset or
+ * 		only part.
+ * Returns:	Zero on success or -1 on failure.
+ */
+
+static int read_pageset(struct pagedir *pagedir, int whichtoread,
+		int overwrittenpagesonly)
+{
+	int result = 0, base = 0, start_time, end_time;
+	int finish_at = pagedir->pageset_size;
+	int barmax = pagedir1.pageset_size + pagedir2.pageset_size;
+	dyn_pageflags_t *pageflags;
+
+	if (whichtoread == 1) {
+		suspend_prepare_status(CLEAR_BAR,
+				"Reading kernel & process data...");
+		pageflags = &pageset1_copy_map;
+	} else {
+		suspend_prepare_status(DONT_CLEAR_BAR, "Reading caches...");
+		if (overwrittenpagesonly)
+			barmax = finish_at = min(pagedir1.pageset_size, 
+						 pagedir2.pageset_size);
+		else {
+			base = pagedir1.pageset_size;
+		}
+		pageflags = &pageset2_map;
+	}	
+	
+	start_time = jiffies;
+
+	if (rw_init_modules(0, whichtoread)) {
+		suspend_active_writer->invalidate_image();
+		result = 1;
+	} else
+		result = do_rw_loop(0, finish_at, pageflags, base, barmax);
+
+	if (rw_cleanup_modules(READ)) {
+		abort_suspend("Failed to cleanup after reading.");
+		result = 1;
+	}
+
+	/* Statistics */
+	end_time=jiffies;
+
+	if ((end_time - start_time) && (!test_result_state(SUSPEND_ABORTED))) {
+		suspend_io_time[1][0] += finish_at,
+		suspend_io_time[1][1] += (end_time - start_time);
+	}
+
+	return result;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
