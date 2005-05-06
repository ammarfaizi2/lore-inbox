Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261794AbVEFAIT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261794AbVEFAIT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 20:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262196AbVEFAIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 20:08:18 -0400
Received: from fmr21.intel.com ([143.183.121.13]:6338 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S261794AbVEFAIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 20:08:00 -0400
Date: Thu, 5 May 2005 17:07:28 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, zwane@arm.linux.org.uk, shaohua.li@intel.com
Subject: make smp_prepare_cpu to a weak function
Message-ID: <20050505170727.A17919@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew

This is just a cleanup, the existing code seems to trigger
compile errors since smp_prepar_cpu() is defined with ARCH_HAS...
and its not easy to either introduce a arch call, or ideally remove it
finally. This is against 2.6.12-rc3-mm3

Cheers,
ashok
----

I really wish smp_prepare_cpu() would disappear eventually. 
In the interim this is ideally a weak function, so we dont end up 
changing several places to define this dummy in headers.

Today since the dummy declaration is done only in drivers/base/cpu.c
but the function is called in kernel/power/smp.c i get undefined
reference in my cpu hotplug code for x86_64 under development.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>

Index: linux-2.6.12-rc3-mm3/include/asm-i386/smp.h
===================================================================
--- linux-2.6.12-rc3-mm3.orig/include/asm-i386/smp.h	2005-05-05 09:56:47.000000000 -0700
+++ linux-2.6.12-rc3-mm3/include/asm-i386/smp.h	2005-05-05 16:20:59.544474384 -0700
@@ -51,9 +51,6 @@
 #ifdef CONFIG_HOTPLUG_CPU
 extern void cpu_exit_clear(void);
 extern void cpu_uninit(void);
-
-#define __HAVE_ARCH_SMP_PREPARE_CPU
-extern int smp_prepare_cpu(int cpu);
 #endif
 
 /*
Index: linux-2.6.12-rc3-mm3/drivers/base/cpu.c
===================================================================
--- linux-2.6.12-rc3-mm3.orig/drivers/base/cpu.c	2005-05-05 09:56:45.000000000 -0700
+++ linux-2.6.12-rc3-mm3/drivers/base/cpu.c	2005-05-05 17:01:26.533515968 -0700
@@ -16,9 +16,10 @@
 EXPORT_SYMBOL(cpu_sysdev_class);
 
 #ifdef CONFIG_HOTPLUG_CPU
-#ifndef __HAVE_ARCH_SMP_PREPARE_CPU
-#define smp_prepare_cpu(cpu) (0)
-#endif
+int __attribute__((weak)) smp_prepare_cpu (int cpu)
+{
+	return 0;
+}
 
 static ssize_t show_online(struct sys_device *dev, char *buf)
 {
@@ -41,7 +42,7 @@
 		break;
 	case '1':
 		ret = smp_prepare_cpu(cpu->sysdev.id);
-		if (ret == 0)
+		if (!ret)
 			ret = cpu_up(cpu->sysdev.id);
 		if (!ret)
 			kobject_hotplug(&dev->kobj, KOBJ_ONLINE);
Index: linux-2.6.12-rc3-mm3/include/linux/cpu.h
===================================================================
--- linux-2.6.12-rc3-mm3.orig/include/linux/cpu.h	2005-04-20 17:03:16.000000000 -0700
+++ linux-2.6.12-rc3-mm3/include/linux/cpu.h	2005-05-05 16:43:18.048990768 -0700
@@ -69,6 +69,7 @@
 	register_cpu_notifier(&fn##_nb);			\
 }
 int cpu_down(unsigned int cpu);
+extern int __attribute__((weak)) smp_prepare_cpu(int cpu);
 #define cpu_is_offline(cpu) unlikely(!cpu_online(cpu))
 #else
 #define lock_cpu_hotplug()	do { } while (0)
-- 
Cheers,
Ashok Raj
- Open Source Technology Center
