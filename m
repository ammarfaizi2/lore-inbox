Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265510AbUHSLgb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265510AbUHSLgb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 07:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265684AbUHSLgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 07:36:31 -0400
Received: from gprs214-117.eurotel.cz ([160.218.214.117]:16000 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S265510AbUHSLgU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 07:36:20 -0400
Date: Thu, 19 Aug 2004 13:36:00 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>,
       Andrew Morton <akpm@zip.com.au>, benh@kernel.crashing.org,
       david-b@pacbell.net
Subject: Use global system_state to avoid system-state confusion
Message-ID: <20040819113600.GA1317@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I started using system_state (already defined in kernel.h) to allow
drivers to do something different in response to swsusp. This at least
kills ide-disk.c hack.

Please apply,
								Pavel

--- linux-mm.middle/drivers/ide/ide-disk.c	2004-08-17 12:21:43.000000000 +0200
+++ linux-mm/drivers/ide/ide-disk.c	2004-08-19 13:12:28.000000000 +0200
@@ -1406,7 +1406,7 @@
 {
 	switch (rq->pm->pm_step) {
 	case idedisk_pm_flush_cache:	/* Suspend step 1 (flush cache) complete */
-		if (rq->pm->pm_state == 4)
+		if (system_state == SYSTEM_SWSUSP_SNAPSHOT)
 			rq->pm->pm_step = ide_pm_state_completed;
 		else
 			rq->pm->pm_step = idedisk_pm_standby;
@@ -1678,7 +1678,6 @@
 		return;
 	}
 
-	printk("Shutdown: %s\n", drive->name);
 	dev->bus->suspend(dev, PM_SUSPEND_STANDBY);
 }
 
--- linux-mm.middle/include/linux/kernel.h	2004-08-17 12:21:44.000000000 +0200
+++ linux-mm/include/linux/kernel.h	2004-08-19 13:12:08.000000000 +0200
@@ -136,6 +136,9 @@
 extern enum system_states {
 	SYSTEM_BOOTING,
 	SYSTEM_RUNNING,
+	SYSTEM_SWSUSP_SNAPSHOT,
+	SYSTEM_DISK_SUSPEND,
+	SYSTEM_RAM_SUSPEND,
 	SYSTEM_HALT,
 	SYSTEM_POWER_OFF,
 	SYSTEM_RESTART,
--- linux-mm.middle/include/linux/pm.h	2004-08-15 19:15:05.000000000 +0200
+++ linux-mm/include/linux/pm.h	2004-08-19 13:12:08.000000000 +0200
@@ -193,11 +193,11 @@
 extern void (*pm_idle)(void);
 extern void (*pm_power_off)(void);
 
-enum {
-	PM_SUSPEND_ON,
-	PM_SUSPEND_STANDBY,
-	PM_SUSPEND_MEM,
-	PM_SUSPEND_DISK,
+enum system_state {
+	PM_SUSPEND_ON = 0,
+	PM_SUSPEND_STANDBY = 1,
+	PM_SUSPEND_MEM = 2,
+	PM_SUSPEND_DISK = 3,
 	PM_SUSPEND_MAX,
 };
 
--- linux-mm.middle/kernel/power/disk.c	2004-08-17 12:21:44.000000000 +0200
+++ linux-mm/kernel/power/disk.c	2004-08-19 13:13:35.000000000 +0200
@@ -15,6 +15,7 @@
 #include <linux/device.h>
 #include <linux/delay.h>
 #include <linux/fs.h>
+#include <linux/device.h>
 #include "power.h"
 
 
@@ -49,15 +50,18 @@
 	local_irq_save(flags);
 	switch(mode) {
 	case PM_DISK_PLATFORM:
+		system_state = SYSTEM_DISK_SUSPEND;
 		device_power_down(PM_SUSPEND_DISK);
 		error = pm_ops->enter(PM_SUSPEND_DISK);
 		break;
 	case PM_DISK_SHUTDOWN:
+		system_state = SYSTEM_POWER_OFF;
 		printk("Powering off system\n");
 		device_shutdown();
 		machine_power_off();
 		break;
 	case PM_DISK_REBOOT:
+		system_state = SYSTEM_RESTART;
 		device_shutdown();
 		machine_restart(NULL);
 		break;
@@ -114,6 +118,7 @@
 {
 	int error;
 
+	system_state = SYSTEM_SWSUSP_SNAPSHOT;
 	pm_prepare_console();
 
 	sys_sync();
@@ -226,6 +231,7 @@
 
 	pr_debug("PM: Preparing system for restore.\n");
 
+	system_state = SYSTEM_SWSUSP_SNAPSHOT;
 	if ((error = prepare()))
 		goto Free;
 
--- linux-mm.middle/kernel/power/main.c	2004-08-17 12:22:47.000000000 +0200
+++ linux-mm/kernel/power/main.c	2004-08-19 13:12:08.000000000 +0200
@@ -151,6 +151,7 @@
 		goto Unlock;
 	}
 
+	system_state = SYSTEM_RAM_SUSPEND;
 	pr_debug("PM: Preparing system for suspend\n");
 	if ((error = suspend_prepare(state)))
 		goto Unlock;
@@ -162,6 +163,7 @@
 	suspend_finish(state);
  Unlock:
 	up(&pm_sem);
+	system_state = SYSTEM_RUNNING;
 	return error;
 }
 

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
