Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261919AbTFOGAb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 02:00:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbTFOGAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 02:00:31 -0400
Received: from dsl092-013-071.sfo1.dsl.speakeasy.net ([66.92.13.71]:59875 "EHLO
	pelerin.serpentine.com") by vger.kernel.org with ESMTP
	id S261919AbTFOGA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 02:00:26 -0400
Subject: [BK PATCH] Apply new sysfs API to x86_64 core
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@transmeta.com>
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-SQMFIWrzO3A9I/ebH6IF"
Message-Id: <1055657656.28852.27.camel@camp4.serpentine.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 14 Jun 2003 23:14:16 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-SQMFIWrzO3A9I/ebH6IF
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch is against 2.5.71, and brings x86_64 into line with the new
sysfs API.

	<b

--=-SQMFIWrzO3A9I/ebH6IF
Content-Disposition: attachment; filename=x86_64-sysfs-1.patch
Content-Type: text/plain; name=x86_64-sysfs-1.patch; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1314  -> 1.1315 
#	arch/x86_64/kernel/apic.c	1.23    -> 1.24   
#	arch/x86_64/kernel/nmi.c	1.12    -> 1.13   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/06/14	bos@serpentine.com	1.1315
# Bring x86_64 into line with new sysfs API.
# --------------------------------------------
#
diff -Nru a/arch/x86_64/kernel/apic.c b/arch/x86_64/kernel/apic.c
--- a/arch/x86_64/kernel/apic.c	Sat Jun 14 23:09:59 2003
+++ b/arch/x86_64/kernel/apic.c	Sat Jun 14 23:09:59 2003
@@ -25,6 +25,7 @@
 #include <linux/interrupt.h>
 #include <linux/mc146818rtc.h>
 #include <linux/kernel_stat.h>
+#include <linux/sysdev.h>
 
 #include <asm/atomic.h>
 #include <asm/smp.h>
@@ -464,13 +465,11 @@
 	unsigned int apic_thmr;
 } apic_pm_state;
 
-static int lapic_suspend(struct device *dev, u32 state, u32 level)
+static int lapic_suspend(struct sys_device *dev, u32 state)
 {
 	unsigned int l, h;
 	unsigned long flags;
 
-	if (level != SUSPEND_POWER_DOWN)
-		return 0;
 	if (!apic_pm_state.active)
 		return 0;
 
@@ -497,13 +496,11 @@
 	return 0;
 }
 
-static int lapic_resume(struct device *dev, u32 level)
+static int lapic_resume(struct sys_device *dev)
 {
 	unsigned int l, h;
 	unsigned long flags;
 
-	if (level != RESUME_POWER_ON)
-		return 0;
 	if (!apic_pm_state.active)
 		return 0;
 
@@ -537,38 +534,35 @@
 	return 0;
 }
 
-static struct device_driver lapic_driver = {
-	.name		= "lapic",
-	.bus		= &system_bus_type,
+static struct sysdev_class lapic_sysclass = {
+	set_kset_name("lapic"),
 	.resume		= lapic_resume,
 	.suspend	= lapic_suspend,
 };
 
-/* not static, needed by child devices */
-struct sys_device device_lapic = {
-	.name		= "lapic",
+static struct sys_device device_lapic = {
 	.id	= 0,
-	.dev		= {
-		.name	= "lapic",
-		.driver	= &lapic_driver,
-	},
+	.cls	= &lapic_sysclass,
 };
-EXPORT_SYMBOL(device_lapic);
 
 static void __init apic_pm_activate(void)
 {
 	apic_pm_state.active = 1;
 }
 
-static int __init init_lapic_devicefs(void)
+static int __init init_lapic_sysfs(void)
 {
+	int error;
+
 	if (!cpu_has_apic)
 		return 0;
 	/* XXX: remove suspend/resume procs if !apic_pm_state.active? */
-	driver_register(&lapic_driver);
-	return sys_device_register(&device_lapic);
+	error = sysdev_class_register(&lapic_sysclass);
+	if (!error)
+		error = sys_device_register(&device_lapic);
+	return error;
 }
-device_initcall(init_lapic_devicefs);
+device_initcall(init_lapic_sysfs);
 
 #else	/* CONFIG_PM */
 
diff -Nru a/arch/x86_64/kernel/nmi.c b/arch/x86_64/kernel/nmi.c
--- a/arch/x86_64/kernel/nmi.c	Sat Jun 14 23:09:59 2003
+++ b/arch/x86_64/kernel/nmi.c	Sat Jun 14 23:09:59 2003
@@ -22,6 +22,7 @@
 #include <linux/mc146818rtc.h>
 #include <linux/kernel_stat.h>
 #include <linux/module.h>
+#include <linux/sysdev.h>
 
 #include <asm/smp.h>
 #include <asm/mtrr.h>
@@ -152,50 +153,45 @@
 
 #include <linux/device.h>
 
-static int lapic_nmi_suspend(struct device *dev, u32 state, u32 level)
-  {
-	if (level != SUSPEND_POWER_DOWN)
-		return 0;
+static int lapic_nmi_suspend(struct sys_device *dev, u32 state)
+{
 	disable_lapic_nmi_watchdog();
 	return 0;
-  }
+}
 
-static int lapic_nmi_resume(struct device *dev, u32 level)
-  {
-	if (level != RESUME_POWER_ON)
-		return 0;
+static int lapic_nmi_resume(struct sys_device *dev)
+{
 #if 0
 	enable_lapic_nmi_watchdog();
 #endif
 	return 0;
-  }
+}
 
-static struct device_driver lapic_nmi_driver = {
-	.name		= "lapic_nmi",
-	.bus		= &system_bus_type,
+static struct sysdev_class nmi_sysclass = {
+	set_kset_name("lapic_nmi"),
 	.resume		= lapic_nmi_resume,
 	.suspend	= lapic_nmi_suspend,
 };
 
 static struct sys_device device_lapic_nmi = {
-	.name		= "lapic_nmi",
-	.id		= 0,
-	.dev		= {
-		.name	= "lapic_nmi",
-		.driver	= &lapic_nmi_driver,
-		.parent = &device_lapic.dev,
-	},
+	.id	= 0,
+	.cls	= &nmi_sysclass,
 };
 
-static int __init init_lapic_nmi_devicefs(void)
+static int __init init_lapic_nmi_sysfs(void)
 {
+	int error;
+
 	if (nmi_active == 0)
 		return 0;
-	driver_register(&lapic_nmi_driver);
-	return sys_device_register(&device_lapic_nmi);
+
+	error = sysdev_class_register(&nmi_sysclass);
+	if (!error)
+		error = sys_device_register(&device_lapic_nmi);
+	return error;
 }
 /* must come after the local APIC's device_initcall() */
-late_initcall(init_lapic_nmi_devicefs);
+late_initcall(init_lapic_nmi_sysfs);
 
 #endif	/* CONFIG_PM */
 

--=-SQMFIWrzO3A9I/ebH6IF--

