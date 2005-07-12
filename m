Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261267AbVGLJMm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbVGLJMm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 05:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261279AbVGLJMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 05:12:42 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:50582 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261267AbVGLJKt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 05:10:49 -0400
Date: Tue, 12 Jul 2005 11:10:40 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: [swsusp] fix printks and cleanups
Message-ID: <20050712091040.GH1854@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix error printing in swsusp.c: add loglevels and add very usefull
error information. Trivial cleanup for disk.c.

Signed-off-by: Pavel Machek <pavel@suse.cz>

---
commit 79b675b6cc9268d178b3c0a2af2e4f944c5fdf9b
tree d55af4281a8a491d2dd505604f6dc96d94e74cf3
parent 8972d0ff145879e53416ac77c4cd096fd3cfe227
author <pavel@amd.(none)> Tue, 12 Jul 2005 11:09:44 +0200
committer <pavel@amd.(none)> Tue, 12 Jul 2005 11:09:44 +0200

 kernel/power/disk.c   |    8 ++------
 kernel/power/swsusp.c |    3 ++-
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/kernel/power/disk.c b/kernel/power/disk.c
--- a/kernel/power/disk.c
+++ b/kernel/power/disk.c
@@ -50,21 +50,17 @@ static void power_down(suspend_disk_meth
 	unsigned long flags;
 	int error = 0;
 
+	device_shutdown();
+	local_irq_save(flags);
 	switch(mode) {
 	case PM_DISK_PLATFORM:
-		device_shutdown();
-		local_irq_save(flags);
 		error = pm_ops->enter(PM_SUSPEND_DISK);
 		break;
 	case PM_DISK_SHUTDOWN:
 		printk("Powering off system\n");
-		device_shutdown();
-		local_irq_save(flags);
 		machine_power_off();
 		break;
 	case PM_DISK_REBOOT:
-		device_shutdown();
-		local_irq_save(flags);
 		machine_restart(NULL);
 		break;
 	}
diff --git a/kernel/power/swsusp.c b/kernel/power/swsusp.c
--- a/kernel/power/swsusp.c
+++ b/kernel/power/swsusp.c
@@ -991,6 +991,7 @@ int swsusp_suspend(void)
 	 * at resume time, and evil weirdness ensues.
 	 */
 	if ((error = device_power_down(PMSG_FREEZE))) {
+		printk(KERN_ERR "Some devices failed to power down, aborting suspend\n");
 		local_irq_enable();
 		return error;
 	}
@@ -1004,7 +1005,7 @@ int swsusp_suspend(void)
 
 	save_processor_state();
 	if ((error = swsusp_arch_suspend()))
-		printk("Error %d suspending\n", error);
+		printk(KERN_ERR "Error %d suspending\n", error);
 	/* Restore control flow magically appears here */
 	restore_processor_state();
 	BUG_ON (nr_copy_pages_check != nr_copy_pages);

