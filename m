Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030689AbWF0FIG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030689AbWF0FIG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 01:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030658AbWF0FHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 01:07:00 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:24539 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1030681AbWF0EjW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:39:22 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 10/10] [Suspend2] Atomic restore highlevel routine.
Date: Tue, 27 Jun 2006 14:39:20 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627043919.14546.92958.stgit@nigel.suspend2.net>
In-Reply-To: <20060627043846.14546.75810.stgit@nigel.suspend2.net>
References: <20060627043846.14546.75810.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This routine essentially duplicates the swsusp_resume routine, which does
high level steps of the atomic restore. Rather than modifying that routine
to include a number of if (suspend2) else clauses, it seemed better to put
a suspend2ised version here.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/atomic_copy.c |   55 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 55 insertions(+), 0 deletions(-)

diff --git a/kernel/power/atomic_copy.c b/kernel/power/atomic_copy.c
index bb5d74f..e4aa9f9 100644
--- a/kernel/power/atomic_copy.c
+++ b/kernel/power/atomic_copy.c
@@ -380,3 +380,58 @@ enable_irqs:
 	return error;
 }
 
+/*
+ * suspend_atomic_restore
+ *
+ * Get ready to do the atomic restore. This part gets us into the same
+ * state we are in prior to do calling do_suspend2_lowlevel while
+ * suspending: hotunplugging secondary cpus and freeze processes,
+ * before starting the thread that will do the restore.
+ */
+int suspend_atomic_restore(void)
+{
+	int error, loop;
+
+	disable_nonboot_cpus();
+
+	suspend_prepare_status(DONT_CLEAR_BAR,	"Atomic restore preparation");
+	prepare_suspend2_pbe_list();
+
+	suspend_cond_pause(1, "Device suspend next.\n");
+
+	if ((error = device_suspend(PMSG_FREEZE))) {
+		printk("Some devices failed to suspend\n");
+		BUG();
+	}
+
+#ifdef CONFIG_HIGHMEM
+	origmap = pageset1_map;
+	copymap = pageset1_copy_map;
+	suspend_init_nosave_zone_table();
+#endif
+
+	state1 = suspend_action;
+	state2 = suspend_debug_state;
+	state3 = console_loglevel;
+	
+	for (loop = 0; loop < 4; loop++)
+		io_speed_save[loop/2][loop%2] =
+			suspend_io_time[loop/2][loop%2];
+	memcpy(suspend_resume_commandline, saved_command_line, COMMAND_LINE_SIZE);
+
+	local_irq_disable();
+	if (device_power_down(PMSG_FREEZE))
+		printk(KERN_ERR "Some devices failed to power down. Very bad.\n");
+
+	local_irq_disable();
+
+	/* We'll ignore saved state, but this gets preempt count (etc) right */
+	save_processor_state();
+	error = swsusp_arch_resume();
+	/* Code below is only ever reached in case of failure. Otherwise
+	 * execution continues at place where swsusp_arch_suspend was called.
+         */
+	BUG();
+	return 1;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
