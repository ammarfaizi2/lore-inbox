Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030700AbWF0Eyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030700AbWF0Eyl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030698AbWF0EyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:54:15 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:33755 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933404AbWF0EkV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:40:21 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 3/4] [Suspend2] Power down general routine.
Date: Tue, 27 Jun 2006 14:40:20 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627044018.14736.91248.stgit@nigel.suspend2.net>
In-Reply-To: <20060627044010.14736.18813.stgit@nigel.suspend2.net>
References: <20060627044010.14736.18813.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Powerdown in whatever way the user specified - rebooting being the
overriding option, entering an ACPI state the second choice, doing a simple
power off the third and sitting around in cpu_relax the fallback.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/power_off.c |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/kernel/power/power_off.c b/kernel/power/power_off.c
index 7f7c565..624ab7b 100644
--- a/kernel/power/power_off.c
+++ b/kernel/power/power_off.c
@@ -50,3 +50,31 @@ int try_pm_state_powerdown(void)
 	return 1;
 }
 
+/*
+ * suspend_power_down
+ * Functionality   : Powers down or reboots the computer once the image
+ *                   has been written to disk.
+ * Key Assumptions : Able to reboot/power down via code called or that
+ *                   the warning emitted if the calls fail will be visible
+ *                   to the user (ie printk resumes devices).
+ * Called From     : do_suspend2_suspend_2
+ */
+
+void suspend_power_down(void)
+{
+	if (test_action_state(SUSPEND_REBOOT)) {
+		suspend_prepare_status(DONT_CLEAR_BAR, "Ready to reboot.");
+		kernel_restart(NULL);
+	}
+
+	suspend_prepare_status(DONT_CLEAR_BAR, "Powering down.");
+
+	if (pm_ops && pm_ops->enter && suspend_powerdown_method && try_pm_state_powerdown())
+		return;
+
+	kernel_power_off();
+	suspend_prepare_status(DONT_CLEAR_BAR, "Powerdown failed");
+	while (1)
+		cpu_relax();
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
