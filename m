Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129388AbQKNDnV>; Mon, 13 Nov 2000 22:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129869AbQKNDnL>; Mon, 13 Nov 2000 22:43:11 -0500
Received: from linuxcare.com.au ([203.29.91.49]:19472 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S129388AbQKNDnJ>; Mon, 13 Nov 2000 22:43:09 -0500
Message-Id: <200011140313.eAE3D3s28869@wattle.linuxcare.com.au>
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] make SMP power off work when APM is a module
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <28866.974171583.1@linuxcare.com.au>
Date: Tue, 14 Nov 2000 14:13:03 +1100
From: Stephen Rothwell <sfr@linuxcare.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This patch corrects the return codes from apm's init routine
and in particular should allow SMP power off to work when APM
is compiled as a module.

Cheers,
Stephen
-- 
Stephen Rothwell, Open Source Researcher, Linuxcare, Inc.
+61-2-62628990 tel, +61-2-62628991 fax 
sfr@linuxcare.com, http://www.linuxcare.com/ 
Linuxcare. Support for the revolution.

diff -ruN 2.4.0-test11pre4/arch/i386/kernel/apm.c 2.4.0-test11pre4-APM.1/arch/i386/kernel/apm.c
--- 2.4.0-test11pre4/arch/i386/kernel/apm.c	Mon Nov 13 17:46:42 2000
+++ 2.4.0-test11pre4-APM.1/arch/i386/kernel/apm.c	Tue Nov 14 00:30:28 2000
@@ -1571,8 +1571,6 @@
 	&apm_bios_fops
 };
 
-#define APM_INIT_ERROR_RETURN	return -1
-
 /*
  * Just start the APM thread. We do NOT want to do APM BIOS
  * calls from anything but the APM thread, if for no other reason
@@ -1587,7 +1585,7 @@
 {
 	if (apm_bios_info.version == 0) {
 		printk(KERN_INFO "apm: BIOS not found.\n");
-		APM_INIT_ERROR_RETURN;
+		return -ENODEV;
 	}
 	printk(KERN_INFO
 		"apm: BIOS version %d.%d Flags 0x%02x (Driver version %s)\n",
@@ -1597,7 +1595,7 @@
 		driver_version);
 	if ((apm_bios_info.flags & APM_32_BIT_SUPPORT) == 0) {
 		printk(KERN_INFO "apm: no 32 bit BIOS support\n");
-		APM_INIT_ERROR_RETURN;
+		return -ENODEV;
 	}
 
 	/*
@@ -1626,15 +1624,15 @@
 
 	if (apm_disabled) {
 		printk(KERN_NOTICE "apm: disabled on user request.\n");
-		APM_INIT_ERROR_RETURN;
+		return -ENODEV;
 	}
 	if ((smp_num_cpus > 1) && !power_off) {
 		printk(KERN_NOTICE "apm: disabled - APM is not SMP safe.\n");
-		APM_INIT_ERROR_RETURN;
+		return -ENODEV;
 	}
 	if (PM_IS_ACTIVE()) {
 		printk(KERN_NOTICE "apm: overridden by ACPI.\n");
-		APM_INIT_ERROR_RETURN;
+		return -ENODEV;
 	}
 	pm_active = 1;
 
@@ -1683,7 +1681,7 @@
 	if (smp_num_cpus > 1) {
 		printk(KERN_NOTICE
 		   "apm: disabled - APM is not SMP safe (power off active).\n");
-		APM_INIT_ERROR_RETURN;
+		return 0;
 	}
 
 	misc_register(&apm_device);
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
