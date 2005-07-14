Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262829AbVGNApw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262829AbVGNApw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 20:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262858AbVGNApw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 20:45:52 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:53931 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262829AbVGNApu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 20:45:50 -0400
Date: Thu, 14 Jul 2005 02:45:41 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: [patch 01/04] swsusp: fix printks and cleanups
Message-ID: <20050714004541.GA7836@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Machek <pavel@ucw.cz>

Fix error printing in swsusp.c: add loglevels and add very usefull error
information.  Trivial cleanup for disk.c.

Signed-off-by: Pavel Machek <pavel@suse.cz>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 kernel/power/disk.c   |    8 ++------
 kernel/power/swsusp.c |    3 ++-
 2 files changed, 4 insertions(+), 7 deletions(-)

diff -puN kernel/power/disk.c~swsusp-fix-printks-and-cleanups kernel/power/disk.c
--- devel/kernel/power/disk.c~swsusp-fix-printks-and-cleanups	2005-07-12 02:14:51.000000000 -0700
+++ devel-akpm/kernel/power/disk.c	2005-07-12 02:14:51.000000000 -0700
@@ -52,21 +52,17 @@ static void power_down(suspend_disk_meth
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
diff -puN kernel/power/swsusp.c~swsusp-fix-printks-and-cleanups kernel/power/swsusp.c
--- devel/kernel/power/swsusp.c~swsusp-fix-printks-and-cleanups	2005-07-12 02:14:51.000000000 -0700
+++ devel-akpm/kernel/power/swsusp.c	2005-07-12 02:14:51.000000000 -0700
@@ -886,6 +886,7 @@ int swsusp_suspend(void)
 	 * at resume time, and evil weirdness ensues.
 	 */
 	if ((error = device_power_down(PMSG_FREEZE))) {
+		printk(KERN_ERR "Some devices failed to power down, aborting suspend\n");
 		local_irq_enable();
 		return error;
 	}
@@ -899,7 +900,7 @@ int swsusp_suspend(void)
 
 	save_processor_state();
 	if ((error = swsusp_arch_suspend()))
-		printk("Error %d suspending\n", error);
+		printk(KERN_ERR "Error %d suspending\n", error);
 	/* Restore control flow magically appears here */
 	restore_processor_state();
 	BUG_ON (nr_copy_pages_check != nr_copy_pages);
_

