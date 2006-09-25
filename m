Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbWIYIjn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbWIYIjn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 04:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750702AbWIYIjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 04:39:43 -0400
Received: from mail01.verismonetworks.com ([164.164.99.228]:1469 "EHLO
	mail01.verismonetworks.com") by vger.kernel.org with ESMTP
	id S1750701AbWIYIjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 04:39:42 -0400
Subject: [PATCH] misc_register error return handling
From: Amol Lad <amol@verismonetworks.com>
To: linux-kernel@vger.kernel.org,
       kernel Janitors <kernel-janitors@lists.osdl.org>
Content-Type: text/plain
Date: Mon, 25 Sep 2006 14:13:01 +0530
Message-Id: <1159173781.25016.34.camel@amol.verismonetworks.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sending to lkml also.

Some drivers do not handle failure of misc_register. 

Added return value checks appropriately in defaulting drivers

Tested with:
- allmodconfig
- Manually tweaking Kconfig/Makefiles to make sure that the changed
files compiles without any errors/warnings

Signed-off-by: Amol Lad <amol@verismonetworks.com>
---
 arch/i386/kernel/apm.c             |   23 +++++++++++++++++------
 arch/um/drivers/mmapper_kern.c     |    6 ++++--
 arch/x86_64/kernel/mce.c           |    6 +++++-
 drivers/char/watchdog/ep93xx_wdt.c |    4 ++++
 drivers/input/misc/hp_sdc_rtc.c    |    7 ++++++-
 drivers/macintosh/apm_emu.c        |    8 +++++++-
 drivers/macintosh/smu.c            |   11 ++++++++---
 drivers/macintosh/via-pmu.c        |   11 ++++++++---
 8 files changed, 59 insertions(+), 17 deletions(-)
---
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/arch/i386/kernel/apm.c linux-2.6.18/arch/i386/kernel/apm.c
--- linux-2.6.18-orig/arch/i386/kernel/apm.c	2006-09-21 10:15:25.000000000 +0530
+++ linux-2.6.18/arch/i386/kernel/apm.c	2006-09-25 13:59:53.000000000 +0530
@@ -2246,6 +2246,12 @@ static int __init apm_init(void)
 		return -ENODEV;
 	}
 
+	ret = misc_register(&apm_device);
+	if (ret != 0) {
+		printk(KERN_ERR "apm: cannot register misc device.\n");
+		return ret;
+	}
+
 	if (allow_ints)
 		apm_info.allow_ints = 1;
 	if (broken_psr)
@@ -2282,17 +2288,20 @@ static int __init apm_init(void)
 
 	if (apm_info.disabled) {
 		printk(KERN_NOTICE "apm: disabled on user request.\n");
-		return -ENODEV;
+		ret = -ENODEV;
+		goto out_misc;
 	}
 	if ((num_online_cpus() > 1) && !power_off && !smp) {
 		printk(KERN_NOTICE "apm: disabled - APM is not SMP safe.\n");
 		apm_info.disabled = 1;
-		return -ENODEV;
+		ret = -ENODEV;
+		goto out_misc;
 	}
 	if (PM_IS_ACTIVE()) {
 		printk(KERN_NOTICE "apm: overridden by ACPI.\n");
 		apm_info.disabled = 1;
-		return -ENODEV;
+		ret = -ENODEV;
+		goto out_misc;
 	}
 #ifdef CONFIG_PM_LEGACY
 	pm_active = 1;
@@ -2339,7 +2348,8 @@ static int __init apm_init(void)
 	ret = kernel_thread(apm, NULL, CLONE_KERNEL | SIGCHLD);
 	if (ret < 0) {
 		printk(KERN_ERR "apm: disabled - Unable to start kernel thread.\n");
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto out_misc;
 	}
 
 	if (num_online_cpus() > 1 && !smp ) {
@@ -2348,8 +2358,6 @@ static int __init apm_init(void)
 		return 0;
 	}
 
-	misc_register(&apm_device);
-
 	if (HZ != 100)
 		idle_period = (idle_period * HZ) / 100;
 	if (idle_threshold < 100) {
@@ -2359,6 +2367,9 @@ static int __init apm_init(void)
 	}
 
 	return 0;
+out_misc:
+	misc_deregister(&apm_device);
+	return ret;
 }
 
 static void __exit apm_exit(void)
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/arch/um/drivers/mmapper_kern.c linux-2.6.18/arch/um/drivers/mmapper_kern.c
--- linux-2.6.18-orig/arch/um/drivers/mmapper_kern.c	2006-08-24 02:46:33.000000000 +0530
+++ linux-2.6.18/arch/um/drivers/mmapper_kern.c	2006-09-25 13:23:46.000000000 +0530
@@ -103,7 +103,7 @@ static struct miscdevice mmapper_dev = {
 
 static int __init mmapper_init(void)
 {
-	int err;
+	int err = 0;
 
 	printk(KERN_INFO "Mapper v0.1\n");
 
@@ -121,8 +121,10 @@ static int __init mmapper_init(void)
 	}
 
 	p_buf = __pa(v_buf);
-out:
+    
 	return 0;
+out:
+	return err;
 }
 
 static void mmapper_exit(void)
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/arch/x86_64/kernel/mce.c linux-2.6.18/arch/x86_64/kernel/mce.c
--- linux-2.6.18-orig/arch/x86_64/kernel/mce.c	2006-09-21 10:15:31.000000000 +0530
+++ linux-2.6.18/arch/x86_64/kernel/mce.c	2006-09-25 14:00:39.000000000 +0530
@@ -663,7 +663,11 @@ static __init int mce_init_device(void)
 	}
 
 	register_hotcpu_notifier(&mce_cpu_notifier);
-	misc_register(&mce_log_device);
+
+	err = misc_register(&mce_log_device);
+	if (err != 0)
+		printk(KERN_ERR "MCE: cannot register misc device.\n");
+
 	return err;
 }
 
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/drivers/char/watchdog/ep93xx_wdt.c linux-2.6.18/drivers/char/watchdog/ep93xx_wdt.c
--- linux-2.6.18-orig/drivers/char/watchdog/ep93xx_wdt.c	2006-09-21 10:15:32.000000000 +0530
+++ linux-2.6.18/drivers/char/watchdog/ep93xx_wdt.c	2006-09-25 13:23:46.000000000 +0530
@@ -215,6 +215,10 @@ static int __init ep93xx_wdt_init(void)
 	int err;
 
 	err = misc_register(&ep93xx_wdt_miscdev);
+	if (err != 0) {
+		printk(KERN_ERR PFX "cannot register misc device.\n");
+		return err;
+	}
 
 	boot_status = __raw_readl(EP93XX_WDT_WATCHDOG) & 0x01 ? 1 : 0;
 
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/drivers/input/misc/hp_sdc_rtc.c linux-2.6.18/drivers/input/misc/hp_sdc_rtc.c
--- linux-2.6.18-orig/drivers/input/misc/hp_sdc_rtc.c	2006-08-24 02:46:33.000000000 +0530
+++ linux-2.6.18/drivers/input/misc/hp_sdc_rtc.c	2006-09-25 14:01:36.000000000 +0530
@@ -695,7 +695,12 @@ static int __init hp_sdc_rtc_init(void)
 
 	if ((ret = hp_sdc_request_timer_irq(&hp_sdc_rtc_isr)))
 		return ret;
-	misc_register(&hp_sdc_rtc_dev);
+
+	ret = misc_register(&hp_sdc_rtc_dev);
+	if (ret != 0) {
+		printk(KERN_ERR "HP i8042 SDC + MSM-58321 RTC: cannot register misc device.\n");
+		return ret;
+	}
         create_proc_read_entry ("driver/rtc", 0, 0, 
 				hp_sdc_rtc_read_proc, NULL);
 
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/drivers/macintosh/apm_emu.c linux-2.6.18/drivers/macintosh/apm_emu.c
--- linux-2.6.18-orig/drivers/macintosh/apm_emu.c	2006-09-21 10:15:33.000000000 +0530
+++ linux-2.6.18/drivers/macintosh/apm_emu.c	2006-09-25 14:02:04.000000000 +0530
@@ -519,6 +519,7 @@ static struct miscdevice apm_device = {
 static int __init apm_emu_init(void)
 {
 	struct proc_dir_entry *apm_proc;
+	int ret;
 
 	if (sys_ctrler != SYS_CTRLER_PMU) {
 		printk(KERN_INFO "apm_emu: Requires a machine with a PMU.\n");
@@ -529,7 +530,12 @@ static int __init apm_emu_init(void)
 	if (apm_proc)
 		apm_proc->owner = THIS_MODULE;
 
-	misc_register(&apm_device);
+	ret = misc_register(&apm_device);
+	if (ret != 0) {
+		printk(KERN_ERR "apm_emu: cannot register misc device.\n");
+		remove_proc_entry("apm", NULL);
+		return ret;
+	}
 
 	pmu_register_sleep_notifier(&apm_sleep_notifier);
 
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/drivers/macintosh/smu.c linux-2.6.18/drivers/macintosh/smu.c
--- linux-2.6.18-orig/drivers/macintosh/smu.c	2006-09-21 10:15:33.000000000 +0530
+++ linux-2.6.18/drivers/macintosh/smu.c	2006-09-25 14:02:32.000000000 +0530
@@ -1292,10 +1292,15 @@ static struct miscdevice pmu_device = {
 
 static int smu_device_init(void)
 {
+	int ret = 0;
+    
 	if (!smu)
 		return -ENODEV;
-	if (misc_register(&pmu_device) < 0)
-		printk(KERN_ERR "via-pmu: cannot register misc device.\n");
-	return 0;
+    
+	ret = misc_register(&pmu_device);
+	if (ret != 0)
+		printk(KERN_ERR "SMU: cannot register misc device.\n");
+        
+	return ret;
 }
 device_initcall(smu_device_init);
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/drivers/macintosh/via-pmu.c linux-2.6.18/drivers/macintosh/via-pmu.c
--- linux-2.6.18-orig/drivers/macintosh/via-pmu.c	2006-09-21 10:15:33.000000000 +0530
+++ linux-2.6.18/drivers/macintosh/via-pmu.c	2006-09-25 14:03:02.000000000 +0530
@@ -2678,11 +2678,16 @@ static struct miscdevice pmu_device = {
 
 static int pmu_device_init(void)
 {
+	int ret = 0;
+
 	if (!via)
 		return 0;
-	if (misc_register(&pmu_device) < 0)
-		printk(KERN_ERR "via-pmu: cannot register misc device.\n");
-	return 0;
+
+	ret = misc_register(&pmu_device);
+	if (ret != 0)
+		printk(KERN_ERR "pmu: cannot register misc device.\n");
+
+	return ret;
 }
 device_initcall(pmu_device_init);


