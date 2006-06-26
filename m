Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933147AbWFZXk7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933147AbWFZXk7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933138AbWFZWeH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:34:07 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:65258 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933115AbWFZWdY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:33:24 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 02/16] [Suspend2] Routines called when starting or finishing anything.
Date: Tue, 27 Jun 2006 08:33:22 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223320.3832.49385.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223314.3832.23435.stgit@nigel.suspend2.net>
References: <20060626223314.3832.23435.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Routines called when starting or completing any action.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend.c |   51 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 28bb91c..01c930a 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -180,3 +180,54 @@ extern int block_dump;
 
 int block_dump_save;
 
+/*
+ * Basic clean-up routine.
+ */
+void suspend_finish_anything(int finishing_cycle)
+{
+	if (atomic_dec_and_test(&actions_running)) {
+		suspend_cleanup_modules(finishing_cycle);
+		suspend_put_modules();
+		clear_suspend_state(SUSPEND_RUNNING);
+	}
+
+	set_fs(oldfs);
+
+	if (finishing_cycle)
+		block_dump = block_dump_save;
+}
+
+/*
+ * Basic set-up routine.
+ */
+int suspend_start_anything(int starting_cycle)
+{
+	oldfs = get_fs();
+
+	if (atomic_add_return(1, &actions_running) == 1) {
+       		set_fs(KERNEL_DS);
+
+		set_suspend_state(SUSPEND_RUNNING);
+
+		if (suspend_get_modules()) {
+			printk("Get modules failed!\n");
+			clear_suspend_state(SUSPEND_RUNNING);
+			set_fs(oldfs);
+			return -EBUSY;
+		}
+
+		if (suspend_initialise_modules(starting_cycle)) {
+			printk("Initialise modules failed!\n");
+			suspend_finish_anything(starting_cycle);
+			return -EBUSY;
+		}
+
+		if (starting_cycle) {
+			block_dump_save = block_dump;
+			block_dump = 0;
+		}
+	}
+
+	return 0;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
