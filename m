Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261509AbVCRIuo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261509AbVCRIuo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 03:50:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261507AbVCRIuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 03:50:44 -0500
Received: from aun.it.uu.se ([130.238.12.36]:40184 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261515AbVCRIuI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 03:50:08 -0500
Date: Fri, 18 Mar 2005 09:49:58 +0100 (MET)
Message-Id: <200503180849.j2I8nwI5021579@alkaid.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2.6.11-mm4] perfctr cleanups 1/3: common
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Here's a collection of cleanups for perfctr.

Common-code cleanups for perfctr:
- init.c: remove unused <asm/uaccess.h>, don't
  initialise perfctr_info, don't show dummy cpu_type,
  show driver version directly from VERSION.
- <linux/perfctr.h>: remove types & constants not used
  in the kernel any more, make perfctr_info kernel-only
  and remove unused fields, use explicitly-sized integers
  in user-visible types.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

 drivers/perfctr/init.c    |   22 ++++---------------
 drivers/perfctr/version.h |    2 -
 include/linux/perfctr.h   |   51 ++++++++++------------------------------------
 3 files changed, 18 insertions(+), 57 deletions(-)

diff -rupN linux-2.6.11-mm4/drivers/perfctr/init.c linux-2.6.11-mm4.perfctr-2.7.12/drivers/perfctr/init.c
--- linux-2.6.11-mm4/drivers/perfctr/init.c	2005-03-17 19:39:42.000000000 +0100
+++ linux-2.6.11-mm4.perfctr-2.7.12/drivers/perfctr/init.c	2005-03-18 00:49:07.000000000 +0100
@@ -1,8 +1,8 @@
-/* $Id: init.c,v 1.76 2004/05/31 18:18:55 mikpe Exp $
+/* $Id: init.c,v 1.81 2005/03/17 23:49:07 mikpe Exp $
  * Performance-monitoring counters driver.
  * Top-level initialisation code.
  *
- * Copyright (C) 1999-2004  Mikael Pettersson
+ * Copyright (C) 1999-2005  Mikael Pettersson
  */
 #include <linux/config.h>
 #include <linux/fs.h>
@@ -11,27 +11,16 @@
 #include <linux/device.h>
 #include <linux/perfctr.h>
 
-#include <asm/uaccess.h>
-
 #include "cpumask.h"
 #include "virtual.h"
 #include "version.h"
 
-struct perfctr_info perfctr_info = {
-	.abi_version = PERFCTR_ABI_VERSION,
-	.driver_version = VERSION,
-};
+struct perfctr_info perfctr_info;
 
 static ssize_t
 driver_version_show(struct class *class, char *buf)
 {
-	return sprintf(buf, "%s\n", perfctr_info.driver_version);
-}
-
-static ssize_t
-cpu_type_show(struct class *class, char *buf)
-{
-	return sprintf(buf, "%#x\n", perfctr_info.cpu_type);
+	return sprintf(buf, "%s\n", VERSION);
 }
 
 static ssize_t
@@ -70,7 +59,6 @@ cpus_forbidden_show(struct class *class,
 
 static struct class_attribute perfctr_class_attrs[] = {
 	__ATTR_RO(driver_version),
-	__ATTR_RO(cpu_type),
 	__ATTR_RO(cpu_features),
 	__ATTR_RO(cpu_khz),
 	__ATTR_RO(tsc_to_cpu_mult),
@@ -104,7 +92,7 @@ static int __init perfctr_init(void)
 		return err;
 	}
 	printk(KERN_INFO "perfctr: driver %s, cpu type %s at %u kHz\n",
-	       perfctr_info.driver_version,
+	       VERSION,
 	       perfctr_cpu_name,
 	       perfctr_info.cpu_khz);
 	return 0;
diff -rupN linux-2.6.11-mm4/drivers/perfctr/version.h linux-2.6.11-mm4.perfctr-2.7.12/drivers/perfctr/version.h
--- linux-2.6.11-mm4/drivers/perfctr/version.h	2005-03-17 19:39:42.000000000 +0100
+++ linux-2.6.11-mm4.perfctr-2.7.12/drivers/perfctr/version.h	2005-03-18 01:11:49.000000000 +0100
@@ -1 +1 @@
-#define VERSION "2.7.10"
+#define VERSION "2.7.12"
diff -rupN linux-2.6.11-mm4/include/linux/perfctr.h linux-2.6.11-mm4.perfctr-2.7.12/include/linux/perfctr.h
--- linux-2.6.11-mm4/include/linux/perfctr.h	2005-03-17 19:39:45.000000000 +0100
+++ linux-2.6.11-mm4.perfctr-2.7.12/include/linux/perfctr.h	2005-03-18 01:10:53.000000000 +0100
@@ -1,4 +1,4 @@
-/* $Id: perfctr.h,v 1.88 2005/02/20 12:03:08 mikpe Exp $
+/* $Id: perfctr.h,v 1.91 2005/03/18 00:10:53 mikpe Exp $
  * Performance-Monitoring Counters driver
  *
  * Copyright (C) 1999-2005  Mikael Pettersson
@@ -10,43 +10,15 @@
 
 #include <asm/perfctr.h>
 
-struct perfctr_info {
-	unsigned int abi_version;
-	char driver_version[32];
-	unsigned int cpu_type;
-	unsigned int cpu_features;
-	unsigned int cpu_khz;
-	unsigned int tsc_to_cpu_mult;
-	unsigned int _reserved2;
-	unsigned int _reserved3;
-	unsigned int _reserved4;
-};
-
-struct perfctr_cpu_mask {
-	unsigned int nrwords;
-	unsigned int mask[1];	/* actually 'nrwords' */
-};
-
-/* abi_version values: Lower 16 bits contain the CPU data version, upper
-   16 bits contain the API version. Each half has a major version in its
-   upper 8 bits, and a minor version in its lower 8 bits. */
-#define PERFCTR_API_VERSION	0x0600	/* 6.0 */
-#define PERFCTR_ABI_VERSION	((PERFCTR_API_VERSION<<16)|PERFCTR_CPU_VERSION)
-
 /* cpu_features flag bits */
 #define PERFCTR_FEATURE_RDPMC	0x01
 #define PERFCTR_FEATURE_RDTSC	0x02
 #define PERFCTR_FEATURE_PCINT	0x04
 
-/* user's view of mmap:ed virtual perfctr */
-struct vperfctr_state {
-	struct perfctr_cpu_state cpu_state;
-};
-
 /* virtual perfctr control object */
 struct vperfctr_control {
-	int si_signo;
-	unsigned int preserve;
+	__s32 si_signo;
+	__u32 preserve;
 };
 
 /* commands for sys_vperfctr_control() */
@@ -57,8 +29,8 @@ struct vperfctr_control {
 
 /* common description of an arch-specific 32-bit control register */
 struct perfctr_cpu_reg {
-	unsigned int nr;
-	unsigned int value;
+	__u32 nr;
+	__u32 value;
 };
 
 /* state and control domain numbers
@@ -70,14 +42,9 @@ struct perfctr_cpu_reg {
 
 /* domain numbers for common arch-specific control data */
 #define PERFCTR_DOMAIN_CPU_CONTROL	128	/* struct perfctr_cpu_control_header */
-#define PERFCTR_DOMAIN_CPU_MAP		129	/* unsigned int[] */
+#define PERFCTR_DOMAIN_CPU_MAP		129	/* __u32[] */
 #define PERFCTR_DOMAIN_CPU_REGS		130	/* struct perfctr_cpu_reg[] */
 
-#else
-struct perfctr_info;
-struct perfctr_cpu_mask;
-struct perfctr_sum_ctrs;
-struct vperfctr_control;
 #endif	/* CONFIG_PERFCTR */
 
 #ifdef __KERNEL__
@@ -94,6 +61,12 @@ asmlinkage long sys_vperfctr_read(int fd
 				  void __user *argp,
 				  unsigned int argbytes);
 
+struct perfctr_info {
+	unsigned int cpu_features;
+	unsigned int cpu_khz;
+	unsigned int tsc_to_cpu_mult;
+};
+
 extern struct perfctr_info perfctr_info;
 
 #ifdef CONFIG_PERFCTR_VIRTUAL
