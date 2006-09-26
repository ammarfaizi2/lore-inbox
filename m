Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751406AbWIZFjZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406AbWIZFjZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 01:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbWIZFjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 01:39:20 -0400
Received: from ns2.suse.de ([195.135.220.15]:32469 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751294AbWIZFi4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 01:38:56 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: David Brownell <david-b@pacbell.net>,
       David Brownell <dbrownell@users.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 17/47] PM: issue PM_EVENT_PRETHAW
Date: Mon, 25 Sep 2006 22:37:37 -0700
Message-Id: <11592491371254-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.1
In-Reply-To: <11592491342421-git-send-email-greg@kroah.com>
References: <20060926053728.GA8970@kroah.com> <1159249087369-git-send-email-greg@kroah.com> <11592490903867-git-send-email-greg@kroah.com> <11592490933346-git-send-email-greg@kroah.com> <1159249096460-git-send-email-greg@kroah.com> <11592490993970-git-send-email-greg@kroah.com> <11592491023995-git-send-email-greg@kroah.com> <1159249104512-git-send-email-greg@kroah.com> <11592491082990-git-send-email-greg@kroah.com> <1159249111668-git-send-email-greg@kroah.com> <11592491152668-git-send-email-greg@kroah.com> <115924911859-git-send-email-greg@kroah.com> <11592491211162-git-send-email-greg@kroah.com> <1159249124371-git-send-email-greg@kroah.com> <11592491274168-git-send-email-greg@kroah.com> <11592491303012-git-send-email-greg@kroah.com> <11592491342421-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Brownell <david-b@pacbell.net>

This patch is the first of this series that should actually change any
behavior ...  by issuing the new event, now tha the rest of the kernel is
prepared to receive it.

This converts the PM core to issue the new PRETHAW message, which the rest of
the kernel is now ready to receive.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/base/power/suspend.c |    1 +
 kernel/power/disk.c          |    4 ++--
 kernel/power/swsusp.c        |    9 ++++++++-
 kernel/power/user.c          |    2 +-
 4 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/base/power/suspend.c b/drivers/base/power/suspend.c
index 0bda4a7..e86db83 100644
--- a/drivers/base/power/suspend.c
+++ b/drivers/base/power/suspend.c
@@ -34,6 +34,7 @@ static inline char *suspend_verb(u32 eve
 	switch (event) {
 	case PM_EVENT_SUSPEND:	return "suspend";
 	case PM_EVENT_FREEZE:	return "freeze";
+	case PM_EVENT_PRETHAW:	return "prethaw";
 	default:		return "(unknown suspend event)";
 	}
 }
diff --git a/kernel/power/disk.c b/kernel/power/disk.c
index e13e740..a3c34fb 100644
--- a/kernel/power/disk.c
+++ b/kernel/power/disk.c
@@ -98,7 +98,7 @@ static void unprepare_processes(void)
 }
 
 /**
- *	pm_suspend_disk - The granpappy of power management.
+ *	pm_suspend_disk - The granpappy of hibernation power management.
  *
  *	If we're going through the firmware, then get it over with quickly.
  *
@@ -207,7 +207,7 @@ static int software_resume(void)
 
 	pr_debug("PM: Preparing devices for restore.\n");
 
-	if ((error = device_suspend(PMSG_FREEZE))) {
+	if ((error = device_suspend(PMSG_PRETHAW))) {
 		printk("Some devices failed to suspend\n");
 		swsusp_free();
 		goto Thaw;
diff --git a/kernel/power/swsusp.c b/kernel/power/swsusp.c
index 17f669c..6275289 100644
--- a/kernel/power/swsusp.c
+++ b/kernel/power/swsusp.c
@@ -248,6 +248,9 @@ int swsusp_suspend(void)
 	restore_processor_state();
 Restore_highmem:
 	restore_highmem();
+	/* NOTE:  device_power_up() is just a resume() for devices
+	 * that suspended with irqs off ... no overall powerup.
+	 */
 	device_power_up();
 Enable_irqs:
 	local_irq_enable();
@@ -257,8 +260,12 @@ Enable_irqs:
 int swsusp_resume(void)
 {
 	int error;
+
 	local_irq_disable();
-	if (device_power_down(PMSG_FREEZE))
+	/* NOTE:  device_power_down() is just a suspend() with irqs off;
+	 * it has no special "power things down" semantics
+	 */
+	if (device_power_down(PMSG_PRETHAW))
 		printk(KERN_ERR "Some devices failed to power down, very bad\n");
 	/* We'll ignore saved state, but this gets preempt count (etc) right */
 	save_processor_state();
diff --git a/kernel/power/user.c b/kernel/power/user.c
index 3f1539f..5a8d060 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -191,7 +191,7 @@ static int snapshot_ioctl(struct inode *
 		}
 		down(&pm_sem);
 		pm_prepare_console();
-		error = device_suspend(PMSG_FREEZE);
+		error = device_suspend(PMSG_PRETHAW);
 		if (!error) {
 			error = swsusp_resume();
 			device_resume();
-- 
1.4.2.1

