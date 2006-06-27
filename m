Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030668AbWF0FG6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030668AbWF0FG6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 01:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030669AbWF0EjW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:39:22 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:22491 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1030668AbWF0EjI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:39:08 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 06/10] [Suspend2] Post-atomic restore routine
Date: Tue, 27 Jun 2006 14:39:07 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627043905.14546.49973.stgit@nigel.suspend2.net>
In-Reply-To: <20060627043846.14546.75810.stgit@nigel.suspend2.net>
References: <20060627043846.14546.75810.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After doing the atomic restore, we need to restore the values of variables
that were saved at resume time and get the remainder of the image loaded.
At the end of this routine, the contents of memory are virtually the same
as prior to beginning the cycle.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/atomic_copy.c |   45 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/kernel/power/atomic_copy.c b/kernel/power/atomic_copy.c
index e565bf3..a834623 100644
--- a/kernel/power/atomic_copy.c
+++ b/kernel/power/atomic_copy.c
@@ -217,3 +217,48 @@ void prepare_suspend2_pbe_list(void)
 	} while (1);
 }
 
+/*
+ * copyback_post: Post atomic-restore actions.
+ *
+ * After doing the atomic restore, we have a few more things to do:
+ * 1) We want to retain some values across the restore, so we now copy
+ * these from the nosave variables to the normal ones.
+ * 2) Set the status flags.
+ * 3) Resume devices.
+ * 4) Get userui to redraw.
+ * 5) Reread the page cache.
+ */
+
+void copyback_post(void)
+{
+	int loop;
+
+	suspend_action = state1;
+	suspend_debug_state = state2;
+	console_loglevel = state3;
+
+	for (loop = 0; loop < 4; loop++)
+		suspend_io_time[loop/2][loop%2] =
+			io_speed_save[loop/2][loop%2];
+
+	set_suspend_state(SUSPEND_NOW_RESUMING);
+	set_suspend_state(SUSPEND_PAGESET2_NOT_LOADED);
+
+	if (pm_ops && pm_ops->finish && suspend_powerdown_method > 3)
+		pm_ops->finish(suspend_powerdown_method);
+
+	if (suspend_activate_storage(1))
+		panic("Failed to reactivate our storage.");
+
+	userui_redraw();
+
+	suspend_cond_pause(1, "About to reload secondary pagedir.");
+
+	if (read_pageset2(0))
+		panic("Unable to successfully reread the page cache.");
+
+	clear_suspend_state(SUSPEND_PAGESET2_NOT_LOADED);
+	
+	suspend_prepare_status(DONT_CLEAR_BAR, "Cleaning up...");
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
