Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030669AbWF0FG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030669AbWF0FG7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 01:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030680AbWF0EjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:39:21 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:23003 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1030669AbWF0EjL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:39:11 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 07/10] [Suspend2] Post suspend context-save routine
Date: Tue, 27 Jun 2006 14:39:10 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627043909.14546.87298.stgit@nigel.suspend2.net>
In-Reply-To: <20060627043846.14546.75810.stgit@nigel.suspend2.net>
References: <20060627043846.14546.75810.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At suspend-time, after saving the cpu context using the swsusp code, this
routine is invoked to save the atomic copy, enter the chosen state
(possibly suspend to ram), and cleanup if we come back from that state.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/atomic_copy.c |   40 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/kernel/power/atomic_copy.c b/kernel/power/atomic_copy.c
index a834623..cb3663c 100644
--- a/kernel/power/atomic_copy.c
+++ b/kernel/power/atomic_copy.c
@@ -262,3 +262,43 @@ void copyback_post(void)
 	suspend_prepare_status(DONT_CLEAR_BAR, "Cleaning up...");
 }
 
+/*
+ * suspend_post_context_save: Steps after saving the cpu context.
+ *
+ * Steps taken after saving the CPU state to make the actual
+ * atomic copy.
+ *
+ * Called from swsusp_save in snapshot.c.
+ */
+
+int suspend_post_context_save(void)
+{
+	int old_ps1_size = pagedir1.pageset_size;
+	int old_ps2_size = pagedir2.pageset_size;
+	
+	BUG_ON(!irqs_disabled());
+
+	suspend_recalculate_image_contents(1);
+
+	extra_pd1_pages_used = pagedir1.pageset_size - old_ps1_size;
+
+	if ((pagedir1.pageset_size - old_ps1_size) > extra_pd1_pages_allowance) {
+		abort_suspend("Pageset1 has grown by %d pages."
+			" Only %d growth is allowed for!\n",
+			pagedir1.pageset_size - old_ps1_size,
+			extra_pd1_pages_allowance);
+		return -1;
+	}
+
+	BUG_ON(old_ps2_size != pagedir2.pageset_size);
+
+	BUG_ON(!irqs_disabled());
+
+	if (!test_action_state(SUSPEND_TEST_FILTER_SPEED) &&
+	    !test_action_state(SUSPEND_TEST_BIO))
+		suspend_copy_pageset1();
+
+
+	return 0;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
