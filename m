Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932134AbWHGQ4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbWHGQ4j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 12:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbWHGQ4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 12:56:39 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:28874 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932134AbWHGQ4i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 12:56:38 -0400
Date: Mon, 7 Aug 2006 11:56:16 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>, sfr@canb.auug.org.au,
       linux-laptop@vger.kernel.org
Subject: [PATCH 1/3] kthread: convert arch/i386/kernel/apm.c
Message-ID: <20060807165616.GA11208@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Convert i386 apm.c from kernel_thread(), whose export
is deprecated, to kthread API.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>
---
 arch/i386/kernel/apm.c |   33 ++++++++++++++++-----------------
 1 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/arch/i386/kernel/apm.c b/arch/i386/kernel/apm.c
index 8591f2f..e54a8d4 100644
--- a/arch/i386/kernel/apm.c
+++ b/arch/i386/kernel/apm.c
@@ -225,6 +225,7 @@ #include <linux/smp.h>
 #include <linux/smp_lock.h>
 #include <linux/dmi.h>
 #include <linux/suspend.h>
+#include <linux/kthread.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
@@ -402,8 +403,6 @@ static int			realmode_power_off = 1;
 #else
 static int			realmode_power_off;
 #endif
-static int			exit_kapmd __read_mostly;
-static int			kapmd_running __read_mostly;
 #ifdef CONFIG_APM_ALLOW_INTS
 static int			allow_ints = 1;
 #else
@@ -419,6 +418,8 @@ static const struct desc_struct	bad_bios
 
 static const char		driver_version[] = "1.16ac";	/* no spaces */
 
+static struct task_struct *kapmd_task;
+
 /*
  *	APM event names taken from the APM 1.2 specification. These are
  *	the message codes that the BIOS uses to tell us about events
@@ -1430,7 +1431,7 @@ static void apm_mainloop(void)
 	set_current_state(TASK_INTERRUPTIBLE);
 	for (;;) {
 		schedule_timeout(APM_CHECK_TIMEOUT);
-		if (exit_kapmd)
+		if (kthread_should_stop())
 			break;
 		/*
 		 * Ok, check all events, check for idle (and mark us sleeping
@@ -1713,12 +1714,6 @@ static int apm(void *unused)
 	char *		power_stat;
 	char *		bat_stat;
 
-	kapmd_running = 1;
-
-	daemonize("kapmd");
-
-	current->flags |= PF_NOFREEZE;
-
 #ifdef CONFIG_SMP
 	/* 2002/08/01 - WT
 	 * This is to avoid random crashes at boot time during initialization
@@ -1828,7 +1823,6 @@ #if defined(CONFIG_APM_DISPLAY_BLANK) &&
 		console_blank_hook = NULL;
 #endif
 	}
-	kapmd_running = 0;
 
 	return 0;
 }
@@ -2227,7 +2221,7 @@ static int __init apm_init(void)
 {
 	struct proc_dir_entry *apm_proc;
 	struct desc_struct *gdt;
-	int ret;
+	int err;
 
 	dmi_check_system(apm_dmi_table);
 
@@ -2336,11 +2330,15 @@ #endif
 	if (apm_proc)
 		apm_proc->owner = THIS_MODULE;
 
-	ret = kernel_thread(apm, NULL, CLONE_KERNEL | SIGCHLD);
-	if (ret < 0) {
+	kapmd_task = kthread_create(apm, NULL, "kapmd");
+	if (IS_ERR(kapmd_task)) {
 		printk(KERN_ERR "apm: disabled - Unable to start kernel thread.\n");
-		return -ENOMEM;
+		err = PTR_ERR(kapmd_task);
+		kapmd_task = NULL;
+		return err;
 	}
+	kapmd_task->flags |= PF_NOFREEZE;
+	wake_up_process(kapmd_task);
 
 	if (num_online_cpus() > 1 && !smp ) {
 		printk(KERN_NOTICE
@@ -2384,9 +2382,10 @@ static void __exit apm_exit(void)
 	remove_proc_entry("apm", NULL);
 	if (power_off)
 		pm_power_off = NULL;
-	exit_kapmd = 1;
-	while (kapmd_running)
-		schedule();
+	if (kapmd_task) {
+		kthread_stop(kapmd_task);
+		kapmd_task = NULL;
+	}
 #ifdef CONFIG_PM_LEGACY
 	pm_active = 0;
 #endif
-- 
1.4.1.1

