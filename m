Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275481AbTHJJQR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 05:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275487AbTHJJQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 05:16:17 -0400
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:13585 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S275481AbTHJJQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 05:16:04 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][2.6.0-test3] i386 cpuid.c devfs support 2/2
Date: Sun, 10 Aug 2003 12:52:26 +0400
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_KfgN/0qFjb/9De8"
Message-Id: <200308101252.26584.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_KfgN/0qFjb/9De8
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

the same question about default permissions as for msr.c; the same problem 
with module unload.

-andrey
--Boundary-00=_KfgN/0qFjb/9De8
Content-Type: text/x-diff;
  charset="us-ascii";
  name="2.6.0-test3-cpuid_devfs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="2.6.0-test3-cpuid_devfs.patch"

--- linux-2.6.0-test3-smp/arch/i386/kernel/cpuid.c.devfs	2003-05-05 03:52:48.000000000 +0400
+++ linux-2.6.0-test3-smp/arch/i386/kernel/cpuid.c	2003-08-09 22:30:39.000000000 +0400
@@ -39,6 +39,8 @@
 #include <linux/smp_lock.h>
 #include <linux/fs.h>
 
+#include <linux/devfs_fs_kernel.h>
+
 #include <asm/processor.h>
 #include <asm/msr.h>
 #include <asm/uaccess.h>
@@ -156,17 +158,27 @@ static struct file_operations cpuid_fops
 
 int __init cpuid_init(void)
 {
+  int i;
+
   if (register_chrdev(CPUID_MAJOR, "cpu/cpuid", &cpuid_fops)) {
     printk(KERN_ERR "cpuid: unable to get major %d for cpuid\n",
 	   CPUID_MAJOR);
     return -EBUSY;
   }
 
+  for (i = 0; i < NR_CPUS; i++)
+    devfs_mk_cdev(MKDEV(CPUID_MAJOR, i), S_IFCHR | S_IRUGO, "cpu/%d/cpuid", i);
+
   return 0;
 }
 
 void __exit cpuid_exit(void)
 {
+  int i;
+
+  for (i = 0; i < NR_CPUS; i++)
+    devfs_remove("cpu/%d/cpuid", i);
+
   unregister_chrdev(CPUID_MAJOR, "cpu/cpuid");
 }
 

--Boundary-00=_KfgN/0qFjb/9De8--

