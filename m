Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751421AbVHVWbH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbVHVWbH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751388AbVHVWXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:23:50 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:54152 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751381AbVHVWXR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:23:17 -0400
Date: Mon, 22 Aug 2005 11:00:47 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: [patch] swsusp: fix error handling and cleanups
Message-ID: <20050822090047.GA8841@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Drop printing during normal boot (when no image exists in swap), print
message when drivers fail, fix error paths and consolidate
near-identical functions in disk.c (and functions with just one statement).

Signed-off-by: Pavel Machek <pavel@suse.cz>

---
commit 466db9819e9d1e6fdab90019a59ba4edae3f3540
tree 6b50a056f5fa180f1fbdbb7d1f183064cffed9ea
parent 5d655d6e10c2a7ab291ee24b467fb167828f508a
author <pavel@amd.(none)> Mon, 22 Aug 2005 10:59:32 +0200
committer <pavel@amd.(none)> Mon, 22 Aug 2005 10:59:32 +0200

 kernel/power/disk.c   |   45 ++++++++++++++++-----------------------------
 kernel/power/swsusp.c |   12 ++++++------
 2 files changed, 22 insertions(+), 35 deletions(-)

diff --git a/kernel/power/disk.c b/kernel/power/disk.c
--- a/kernel/power/disk.c
+++ b/kernel/power/disk.c
@@ -112,24 +112,12 @@ static inline void platform_finish(void)
 	}
 }
 
-static void finish(void)
-{
-	device_resume();
-	platform_finish();
-	thaw_processes();
-	enable_nonboot_cpus();
-	pm_restore_console();
-}
-
-
 static int prepare_processes(void)
 {
 	int error;
 
 	pm_prepare_console();
-
 	sys_sync();
-
 	disable_nonboot_cpus();
 
 	if (freeze_processes()) {
@@ -162,15 +150,6 @@ static void unprepare_processes(void)
 	pm_restore_console();
 }
 
-static int prepare_devices(void)
-{
-	int error;
-
-	if ((error = device_suspend(PMSG_FREEZE)))
-		printk("Some devices failed to suspend\n");
-	return error;
-}
-
 /**
  *	pm_suspend_disk - The granpappy of power management.
  *
@@ -187,17 +166,14 @@ int pm_suspend_disk(void)
 	error = prepare_processes();
 	if (error)
 		return error;
-	error = prepare_devices();
 
+	error = device_suspend(PMSG_FREEZE);
 	if (error) {
+		printk("Some devices failed to suspend\n");
 		unprepare_processes();
 		return error;
 	}
 
-	pr_debug("PM: Attempting to suspend to disk.\n");
-	if (pm_disk_mode == PM_DISK_FIRMWARE)
-		return pm_ops->enter(PM_SUSPEND_DISK);
-
 	pr_debug("PM: snapshotting memory.\n");
 	in_suspend = 1;
 	if ((error = swsusp_suspend()))
@@ -208,11 +184,20 @@ int pm_suspend_disk(void)
 		error = swsusp_write();
 		if (!error)
 			power_down(pm_disk_mode);
+		else {
+		/* swsusp_write can not fail in device_resume, 
+		   no need to do second device_resume */
+			swsusp_free();
+			unprepare_processes();
+			return error;
+		}
 	} else
 		pr_debug("PM: Image restored successfully.\n");
+
 	swsusp_free();
  Done:
-	finish();
+	device_resume();
+	unprepare_processes();
 	return error;
 }
 
@@ -274,15 +259,17 @@ static int software_resume(void)
 
 	pr_debug("PM: Preparing devices for restore.\n");
 
-	if ((error = prepare_devices()))
+	if ((error = device_suspend(PMSG_FREEZE))) {
+		printk("Some devices failed to suspend\n");
 		goto Free;
+	}
 
 	mb();
 
 	pr_debug("PM: Restoring saved image.\n");
 	swsusp_resume();
 	pr_debug("PM: Restore failed, recovering.n");
-	finish();
+	device_resume();
  Free:
 	swsusp_free();
  Cleanup:
diff --git a/kernel/power/swsusp.c b/kernel/power/swsusp.c
--- a/kernel/power/swsusp.c
+++ b/kernel/power/swsusp.c
@@ -385,7 +385,6 @@ static int write_pagedir(void)
  *	write_suspend_image - Write entire image and metadata.
  *
  */
-
 static int write_suspend_image(void)
 {
 	int error;
@@ -875,20 +874,21 @@ int swsusp_suspend(void)
 	 * at resume time, and evil weirdness ensues.
 	 */
 	if ((error = device_power_down(PMSG_FREEZE))) {
+		printk(KERN_ERR "Some devices failed to power down, aborting suspend\n");
 		local_irq_enable();
 		return error;
 	}
 
 	if ((error = swsusp_swap_check())) {
-		printk(KERN_ERR "swsusp: FATAL: cannot find swap device, try "
-				"swapon -a!\n");
+		printk(KERN_ERR "swsusp: cannot find swap device, try swapon -a.\n");
+		device_power_up();
 		local_irq_enable();
 		return error;
 	}
 
 	save_processor_state();
 	if ((error = swsusp_arch_suspend()))
-		printk("Error %d suspending\n", error);
+		printk(KERN_ERR "Error %d suspending\n", error);
 	/* Restore control flow magically appears here */
 	restore_processor_state();
 	BUG_ON (nr_copy_pages_check != nr_copy_pages);
@@ -1168,7 +1168,8 @@ static const char * sanity_check(void)
 	if (strcmp(swsusp_info.uts.machine,system_utsname.machine))
 		return "machine";
 #if 0
-	if(swsusp_info.cpus != num_online_cpus())
+	/* We can't use number of online CPUs when we use hotplug to remove them ;-))) */
+	if (swsusp_info.cpus != num_possible_cpus())
 		return "number of cpus";
 #endif
 	return NULL;
@@ -1207,7 +1208,6 @@ static int check_sig(void)
 		 */
 		error = bio_write_page(0, &swsusp_header);
 	} else { 
-		printk(KERN_ERR "swsusp: Suspend partition has wrong signature?\n");
 		return -EINVAL;
 	}
 	if (!error)

-- 
if you have sharp zaurus hardware you don't need... you know my address
