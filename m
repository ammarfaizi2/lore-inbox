Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933245AbWFZXZ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933245AbWFZXZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933200AbWFZWgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:36:43 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:48031 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933193AbWFZWga
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:36:30 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 09/19] [Suspend2] Write a pageset.
Date: Tue, 27 Jun 2006 08:36:28 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223628.4219.54360.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223557.4219.53030.stgit@nigel.suspend2.net>
References: <20060626223557.4219.53030.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Write a set of pages to storage, also recording the time taken.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/io.c |   58 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 58 insertions(+), 0 deletions(-)

diff --git a/kernel/power/io.c b/kernel/power/io.c
index f237231..fd20324 100644
--- a/kernel/power/io.c
+++ b/kernel/power/io.c
@@ -306,3 +306,61 @@ static int do_rw_loop(int write, int fin
 	return 0;
 }
 
+/* write_pageset()
+ *
+ * Description:	Write a pageset to disk.
+ * Arguments:	pagedir:	Pointer to the pagedir to be saved.
+ * 		whichtowrite:	Controls what debugging output is printed.
+ * Returns:	Zero on success or -1 on failure.
+ */
+
+int write_pageset(struct pagedir *pagedir, int whichtowrite)
+{
+	int finish_at, base = 0, start_time, end_time;
+	int barmax = pagedir1.pageset_size + pagedir2.pageset_size;
+	long error = 0;
+	dyn_pageflags_t *pageflags;
+
+	/* 
+	 * Even if there is nothing to read or write, the writer
+	 * may need the init/cleanup for it's housekeeping.  (eg:
+	 * Pageset1 may start where pageset2 ends when writing).
+	 */
+	finish_at = pagedir->pageset_size;
+
+	if (whichtowrite == 1) {
+		suspend_prepare_status(DONT_CLEAR_BAR,
+				"Writing kernel & process data...");
+		base = pagedir2.pageset_size;
+		if (test_action_state(SUSPEND_TEST_FILTER_SPEED) ||
+		    test_action_state(SUSPEND_TEST_BIO))
+			pageflags = &pageset1_map;
+		else
+			pageflags = &pageset1_copy_map;
+	} else {
+		suspend_prepare_status(CLEAR_BAR, "Writing caches...");
+		pageflags = &pageset2_map;
+		bytes_in = bytes_out = 0;
+	}	
+	
+	start_time = jiffies;
+
+	if (!rw_init_modules(1, whichtowrite))
+		error = do_rw_loop(1, finish_at, pageflags, base, barmax);
+
+	if (rw_cleanup_modules(WRITE)) {
+		abort_suspend("Failed to cleanup after writing.");
+		error = 1;
+	}
+
+	/* Statistics */
+	end_time = jiffies;
+	
+	if ((end_time - start_time) && (!test_result_state(SUSPEND_ABORTED))) {
+		suspend_io_time[0][0] += finish_at,
+		suspend_io_time[0][1] += (end_time - start_time);
+	}
+
+	return error;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
