Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289030AbSAFUoj>; Sun, 6 Jan 2002 15:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289031AbSAFUoU>; Sun, 6 Jan 2002 15:44:20 -0500
Received: from mailgate.bodgit-n-scarper.com ([62.49.233.146]:23558 "HELO
	mould.bodgit-n-scarper.com") by vger.kernel.org with SMTP
	id <S289030AbSAFUoQ>; Sun, 6 Jan 2002 15:44:16 -0500
Date: Sun, 6 Jan 2002 20:43:11 +0000
From: Matt Dainty <matt@bodgit-n-scarper.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Richard Gooch <rgooch@ras.ucalgary.ca>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] DevFS support for /dev/cpu/X/(cpuid|msr)
Message-ID: <20020106204311.C2596@butterlicious.bodgit-n-scarper.com>
Mail-Followup-To: linux-kernel <linux-kernel@vger.kernel.org>,
	Richard Gooch <rgooch@ras.ucalgary.ca>,
	"H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20020106181749.A714@butterlicious.bodgit-n-scarper.com> <200201061934.g06JYnZ15633@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="bAmEntskrkuBymla"
Content-Disposition: inline
In-Reply-To: <200201061934.g06JYnZ15633@vindaloo.ras.ucalgary.ca>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.4.17 on i686 (butterlicious)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bAmEntskrkuBymla
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Okey dokey,

Please find attached a second, better patch to add devfs support to the i386
cpuid and msr drivers. Now it doesn't nuke the cpu/X directories on
unloading and only enumerates CPUs based on smp_num_cpus instead of NR_CPUS.

Cheers

Matt
-- 
"Phased plasma rifle in a forty-watt range?"
"Hey, just what you see, pal"

--bAmEntskrkuBymla
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch-2.4.17-cpuid-msr-devfs.patch"

diff -ur linux-2.4.17.orig/arch/i386/kernel/cpuid.c linux-2.4.17/arch/i386/kernel/cpuid.c
--- linux-2.4.17.orig/arch/i386/kernel/cpuid.c	Sat Jan  5 19:20:08 2002
+++ linux-2.4.17/arch/i386/kernel/cpuid.c	Sun Jan  6 20:29:07 2002
@@ -23,6 +23,11 @@
  *
  * This driver uses /dev/cpu/%d/cpuid where %d is the minor number, and on
  * an SMP box will direct the access to CPU %d.
+ *
+ * ChangeLog
+ *
+ * 2002-01-06	Matt Dainty <matt@bodgit-n-scarper.com>
+ *		Added support for devfs
  */
 
 #include <linux/module.h>
@@ -35,12 +40,16 @@
 #include <linux/poll.h>
 #include <linux/smp.h>
 #include <linux/major.h>
+#include <linux/threads.h>
+#include <linux/devfs_fs_kernel.h>
 
 #include <asm/processor.h>
 #include <asm/msr.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
 
+static devfs_handle_t devfs_handle[NR_CPUS];
+
 #ifdef CONFIG_SMP
 
 struct cpuid_command {
@@ -140,24 +149,40 @@
   open:		cpuid_open,
 };
 
-int __init cpuid_init(void)
+static int __init cpuid_init(void)
 {
-  if (register_chrdev(CPUID_MAJOR, "cpu/cpuid", &cpuid_fops)) {
+  int i;
+  char name[16];
+
+  if (devfs_register_chrdev(CPUID_MAJOR, "cpu/%d/cpuid", &cpuid_fops)) {
     printk(KERN_ERR "cpuid: unable to get major %d for cpuid\n",
 	   CPUID_MAJOR);
     return -EBUSY;
   }
+  for(i = 0; i < smp_num_cpus; i++) {
+    sprintf(name, "cpu/%d/cpuid", i);
+    if ((devfs_handle[i] = devfs_register(NULL, name, DEVFS_FL_DEFAULT,
+					  CPUID_MAJOR, i,
+					  S_IFCHR | S_IRUSR | S_IRGRP,
+					  &cpuid_fops, NULL)) == NULL) {
+      printk(KERN_ERR "cpuid: failed to devfs_register()\n");
+    }
+  }
 
   return 0;
 }
 
-void __exit cpuid_exit(void)
+static void __exit cpuid_exit(void)
 {
-  unregister_chrdev(CPUID_MAJOR, "cpu/cpuid");
+  int i;
+
+  for(i = 0; i < smp_num_cpus; i++)
+    devfs_unregister(devfs_handle[i]);
+  devfs_unregister_chrdev(CPUID_MAJOR, "cpu/%d/cpuid");
 }
 
 module_init(cpuid_init);
-module_exit(cpuid_exit)
+module_exit(cpuid_exit);
 
 EXPORT_NO_SYMBOLS;
 
diff -ur linux-2.4.17.orig/arch/i386/kernel/msr.c linux-2.4.17/arch/i386/kernel/msr.c
--- linux-2.4.17.orig/arch/i386/kernel/msr.c	Sat Jan  5 19:20:08 2002
+++ linux-2.4.17/arch/i386/kernel/msr.c	Sun Jan  6 20:29:19 2002
@@ -22,6 +22,11 @@
  *
  * This driver uses /dev/cpu/%d/msr where %d is the minor number, and on
  * an SMP box will direct the access to CPU %d.
+ *
+ * ChangeLog
+ *
+ * 2002-01-06   Matt Dainty <matt@bodgit-n-scarper.com>
+ *              Added support for devfs
  */
 
 #include <linux/module.h>
@@ -34,12 +39,16 @@
 #include <linux/poll.h>
 #include <linux/smp.h>
 #include <linux/major.h>
+#include <linux/threads.h>
+#include <linux/devfs_fs_kernel.h>
 
 #include <asm/processor.h>
 #include <asm/msr.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
 
+static devfs_handle_t devfs_handle[NR_CPUS];
+
 /* Note: "err" is handled in a funny way below.  Otherwise one version
    of gcc or another breaks. */
 
@@ -248,24 +257,40 @@
   open:		msr_open,
 };
 
-int __init msr_init(void)
+static int __init msr_init(void)
 {
-  if (register_chrdev(MSR_MAJOR, "cpu/msr", &msr_fops)) {
+  int i;
+  char name[16];
+
+  if (devfs_register_chrdev(MSR_MAJOR, "cpu/%d/msr", &msr_fops)) {
     printk(KERN_ERR "msr: unable to get major %d for msr\n",
 	   MSR_MAJOR);
     return -EBUSY;
   }
+  for(i = 0; i < smp_num_cpus; i++) {
+    sprintf(name, "cpu/%d/msr", i);
+    if ((devfs_handle[i] = devfs_register(NULL, name, DEVFS_FL_DEFAULT,
+					  MSR_MAJOR, i,
+					  S_IFCHR | S_IRUSR | S_IRGRP | S_IWUSR,
+					  &msr_fops, NULL)) == NULL) {
+      printk(KERN_ERR "msr: failed to devfs_register()\n");
+    }
+  }
   
   return 0;
 }
 
-void __exit msr_exit(void)
+static void __exit msr_exit(void)
 {
-  unregister_chrdev(MSR_MAJOR, "cpu/msr");
+  int i;
+
+  for(i = 0; i < smp_num_cpus; i++)
+    devfs_unregister(devfs_handle[i]);
+  devfs_unregister_chrdev(MSR_MAJOR, "cpu/%d/msr");
 }
 
 module_init(msr_init);
-module_exit(msr_exit)
+module_exit(msr_exit);
 
 EXPORT_NO_SYMBOLS;
 

--bAmEntskrkuBymla--
