Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030704AbWF0Eyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030704AbWF0Eyl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030700AbWF0EyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:54:18 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:33243 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S932737AbWF0EkR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:40:17 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 2/4] [Suspend2] Try to powerdown using ACPI.
Date: Tue, 27 Jun 2006 14:40:16 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627044015.14736.67954.stgit@nigel.suspend2.net>
In-Reply-To: <20060627044010.14736.18813.stgit@nigel.suspend2.net>
References: <20060627044010.14736.18813.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Try to powerdown by entering ACPI S3, S4 or S5.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/power_off.c |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/kernel/power/power_off.c b/kernel/power/power_off.c
index 8f9f425..7f7c565 100644
--- a/kernel/power/power_off.c
+++ b/kernel/power/power_off.c
@@ -24,3 +24,29 @@ extern struct pm_ops *pm_ops;
 /* Use suspend_enter from main.c */
 extern int suspend_enter(suspend_state_t state);
 
+int try_pm_state_powerdown(void)
+{
+	if (pm_ops && pm_ops->prepare && suspend_powerdown_method &&
+	    pm_ops->prepare(suspend_powerdown_method))
+			return 0;
+
+	if (suspend_powerdown_method > 3)
+		kernel_shutdown_prepare(SYSTEM_SUSPEND_DISK);
+	else {
+		if (device_suspend(PMSG_SUSPEND)) {
+			printk(KERN_ERR "Some devices failed to suspend\n");
+			return 0;
+		}
+	}
+
+	if (suspend_enter(suspend_powerdown_method))
+		return 0;
+
+	device_resume();
+
+	if (pm_ops && pm_ops->finish && suspend_powerdown_method)
+		pm_ops->finish(suspend_powerdown_method);
+
+	return 1;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
