Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161201AbWJDL3B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161201AbWJDL3B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 07:29:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030821AbWJDL3B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 07:29:01 -0400
Received: from havoc.gtf.org ([69.61.125.42]:63624 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1030788AbWJDL3A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 07:29:00 -0400
Date: Wed, 4 Oct 2006 07:28:59 -0400
From: Jeff Garzik <jeff@garzik.org>
To: ak@suse.de
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86 therm_throttle: handle sysfs errors
Message-ID: <20061004112859.GA20672@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Jeff Garzik <jeff@garzik.org>

---

Not sure if NOTIFY_BAD is the correct way to handle the error.
Please review.

 arch/i386/kernel/cpu/mcheck/therm_throt.c |   31 +++++++++++++++++++++---------
 1 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/arch/i386/kernel/cpu/mcheck/therm_throt.c b/arch/i386/kernel/cpu/mcheck/therm_throt.c
index 4f43047..86a47f7 100644
--- a/arch/i386/kernel/cpu/mcheck/therm_throt.c
+++ b/arch/i386/kernel/cpu/mcheck/therm_throt.c
@@ -112,15 +112,13 @@ #ifdef CONFIG_SYSFS
 /* Add/Remove thermal_throttle interface for CPU device */
 static __cpuinit int thermal_throttle_add_dev(struct sys_device * sys_dev)
 {
-	sysfs_create_group(&sys_dev->kobj, &thermal_throttle_attr_group);
-	return 0;
+	return sysfs_create_group(&sys_dev->kobj, &thermal_throttle_attr_group);
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
-static __cpuinit int thermal_throttle_remove_dev(struct sys_device * sys_dev)
+static __cpuinit void thermal_throttle_remove_dev(struct sys_device * sys_dev)
 {
 	sysfs_remove_group(&sys_dev->kobj, &thermal_throttle_attr_group);
-	return 0;
 }
 
 /* Mutex protecting device creation against CPU hotplug */
@@ -133,19 +131,21 @@ static __cpuinit int thermal_throttle_cp
 {
 	unsigned int cpu = (unsigned long)hcpu;
 	struct sys_device *sys_dev;
+	int rc = 0;
 
 	sys_dev = get_cpu_sysdev(cpu);
 	mutex_lock(&therm_cpu_lock);
 	switch (action) {
 	case CPU_ONLINE:
-		thermal_throttle_add_dev(sys_dev);
+		rc = thermal_throttle_add_dev(sys_dev);
 		break;
 	case CPU_DEAD:
 		thermal_throttle_remove_dev(sys_dev);
 		break;
 	}
 	mutex_unlock(&therm_cpu_lock);
-	return NOTIFY_OK;
+
+	return rc ? NOTIFY_BAD : NOTIFY_OK;
 }
 
 static struct notifier_block thermal_throttle_cpu_notifier =
@@ -156,7 +156,8 @@ #endif /* CONFIG_HOTPLUG_CPU */
 
 static __init int thermal_throttle_init_device(void)
 {
-	unsigned int cpu = 0;
+	unsigned int cpu = 0, cpu_err;
+	int err = 0;
 
 	if (!atomic_read(&therm_throt_en))
 		return 0;
@@ -167,13 +168,25 @@ #ifdef CONFIG_HOTPLUG_CPU
 	mutex_lock(&therm_cpu_lock);
 #endif
 	/* connect live CPUs to sysfs */
-	for_each_online_cpu(cpu)
-		thermal_throttle_add_dev(get_cpu_sysdev(cpu));
+	for_each_online_cpu(cpu) {
+		if (!err)
+			err = thermal_throttle_add_dev(get_cpu_sysdev(cpu));
+	}
+	if (err)
+		goto err_out;
+
 #ifdef CONFIG_HOTPLUG_CPU
 	mutex_unlock(&therm_cpu_lock);
 #endif
 
 	return 0;
+
+err_out:
+	for_each_online_cpu(cpu_err) {
+		if (cpu_err < cpu)
+			thermal_throttle_remove_dev(get_cpu_sysdev(cpu_err));
+	}
+	return err;
 }
 
 device_initcall(thermal_throttle_init_device);
