Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269404AbRHLSgi>; Sun, 12 Aug 2001 14:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269405AbRHLSga>; Sun, 12 Aug 2001 14:36:30 -0400
Received: from [195.211.46.202] ([195.211.46.202]:18272 "EHLO serv02.lahn.de")
	by vger.kernel.org with ESMTP id <S269404AbRHLSgQ>;
	Sun, 12 Aug 2001 14:36:16 -0400
Date: Sun, 12 Aug 2001 10:33:28 +0200 (CEST)
From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
Reply-To: <pmhahn@titan.lahn.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: <rgooch@atnf.csiro.au>
Subject: [PATCH] cpuid/msr + devfs
Message-ID: <Pine.LNX.4.33.0108121020050.1068-100000@titan.lahn.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Richard, LKML!

Back in 2000 Philip Langdale posted a patch to make
arch/i386/kernel/{cpuid,msr}.c devfs aware. Richard Gooch had some
comments for him but I never saw an "improved" patch.

I tried to clean it up a little bit and it look's better, but here are the
things I don't like myself:
- Do we need to keep cpu_devfs_handle or should we re-find it on
  unregister?
- There is no devfs_unregister_series.
- Shouldn't we register_chrdev() "cpu/%d/cpuid"?
- "cpu/%d" directoried are never removed on unregister.

RFC

Philipp

--- linux-2.4.8/arch/i386/kernel/cpuid.c~	Sat Aug 11 20:38:59 2001
+++ linux-2.4.8/arch/i386/kernel/cpuid.c	Sat Aug 11 20:39:14 2001
@@ -2,6 +2,7 @@
 /* ----------------------------------------------------------------------- *
  *
  *   Copyright 2000 H. Peter Anvin - All Rights Reserved
+ *   Copyright 2000 Philip Langdale - All Rights Reserved
  *
  *   This program is free software; you can redistribute it and/or modify
  *   it under the terms of the GNU General Public License as published by
@@ -40,6 +41,11 @@
 #include <asm/msr.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
+#include <linux/devfs_fs_kernel.h>
+
+#ifdef CONFIG_DEVFS_FS
+static devfs_handle_t cpu_devfs_handle = NULL;
+#endif /* CONFIG_DEVFS_FS */

 #ifdef CONFIG_SMP

@@ -142,18 +148,42 @@

 int __init cpuid_init(void)
 {
-  if (register_chrdev(CPUID_MAJOR, "cpu/cpuid", &cpuid_fops)) {
-    printk(KERN_ERR "cpuid: unable to get major %d for cpuid\n",
+#ifdef CONFIG_DEVFS_FS
+  cpu_devfs_handle = devfs_find_handle(NULL,"cpu",0,0,0,0);
+  if ( !cpu_devfs_handle ) {
+    printk(KERN_ERR "cpuid: unable to find cpu/ directory\n");
+    return -EBUSY;
+  }
+  devfs_register_series(cpu_devfs_handle, "%d/cpuid", smp_num_cpus,
+	DEVFS_FL_DEFAULT, CPUID_MAJOR, 0, S_IFCHR | S_IRUGO | S_IWUSR,
+	&cpuid_fops, NULL);
+#endif /* CONFIG_DEVFS_FS */
+  if (devfs_register_chrdev(CPUID_MAJOR, "cpu/cpuid", &cpuid_fops)) {
+    printk(KERN_ERR "cpuid: unable to register char major %d\n",
 	   CPUID_MAJOR);
     return -EBUSY;
   }
-
   return 0;
 }

 void __exit cpuid_exit(void)
 {
-  unregister_chrdev(CPUID_MAJOR, "cpu/cpuid");
+#ifdef CONFIG_DEVFS_FS
+  int minor;
+  char minor_string[10];
+  static devfs_handle_t cpuid_node_devfs_handle;
+
+  for( minor=0 ; minor<smp_num_cpus ; minor++ ) {
+    sprintf(minor_string,"%d/cpuid",minor);
+    cpuid_node_devfs_handle = devfs_find_handle(cpu_devfs_handle,minor_string,
+	CPUID_MAJOR,minor,0,0);
+    if ( !cpuid_node_devfs_handle )
+      printk(KERN_ERR "cpuid: unable to find cpuid for cpu %d\n",minor);
+    devfs_unregister(cpuid_node_devfs_handle);
+  }
+#endif /* CONFIG_DEVFS_FS */
+  if (devfs_unregister_chrdev(CPUID_MAJOR,"cpu/cpuid"))
+    printk(KERN_ERR "cpuid: unable to unregister char major %d\n", CPUID_MAJOR);
 }

 module_init(cpuid_init);
--- linux-2.4.8/arch/i386/kernel/msr.c~	Sat Aug 11 20:38:59 2001
+++ linux-2.4.8/arch/i386/kernel/msr.c	Sat Aug 11 20:39:14 2001
@@ -2,6 +2,7 @@
 /* ----------------------------------------------------------------------- *
  *
  *   Copyright 2000 H. Peter Anvin - All Rights Reserved
+ *   Copyright 2000 Philip Langdale - All Rights Reserved
  *
  *   This program is free software; you can redistribute it and/or modify
  *   it under the terms of the GNU General Public License as published by
@@ -40,6 +41,11 @@
 #include <asm/uaccess.h>
 #include <asm/system.h>
 #include <asm/apic.h>
+#include <linux/devfs_fs_kernel.h>
+
+#ifdef CONFIG_DEVFS_FS
+static devfs_handle_t cpu_devfs_handle = NULL;
+#endif /* CONFIG_DEVFS_FS */

 #ifdef CONFIG_SMP

@@ -206,18 +212,42 @@

 int __init msr_init(void)
 {
-  if (register_chrdev(MSR_MAJOR, "cpu/msr", &msr_fops)) {
-    printk(KERN_ERR "msr: unable to get major %d for msr\n",
+#ifdef CONFIG_DEVFS_FS
+  cpu_devfs_handle = devfs_find_handle(NULL,"cpu",0,0,0,0);
+  if ( !cpu_devfs_handle ) {
+    printk(KERN_ERR "msr: unable to find cpu/ directory\n");
+    return -EBUSY;
+  }
+  devfs_register_series(cpu_devfs_handle, "%d/msr", smp_num_cpus,
+	DEVFS_FL_DEFAULT, MSR_MAJOR, 0, S_IFCHR | S_IRUSR | S_IWUSR,
+	&msr_fops, NULL);
+#endif /* CONFIG_DEVFS_FS */
+  if (devfs_register_chrdev(MSR_MAJOR, "cpu/msr", &msr_fops)) {
+    printk(KERN_ERR "msr: unable to register char major %d\n",
 	   MSR_MAJOR);
     return -EBUSY;
   }
-
   return 0;
 }

 void __exit msr_exit(void)
 {
-  unregister_chrdev(MSR_MAJOR, "cpu/msr");
+#ifdef CONFIG_DEVFS_FS
+  int minor;
+  char minor_string[8];
+  static devfs_handle_t msr_node_devfs_handle;
+
+  for( minor=0 ; minor<smp_num_cpus ; minor++ ) {
+    sprintf(minor_string,"%d/msr",minor);
+    msr_node_devfs_handle = devfs_find_handle(cpu_devfs_handle,minor_string,
+	CPUID_MAJOR,minor,0,0);
+    if ( !msr_node_devfs_handle )
+      printk(KERN_ERR "msr: unable to find msr for cpu %d\n",minor);
+    devfs_unregister(msr_node_devfs_handle);
+  }
+#endif /* CONFIG_DEVFS_FS */
+  if (devfs_unregister_chrdev(MSR_MAJOR,"cpu/msr"))
+    printk(KERN_ERR "msr: unable to unregister char major %d\n", MSR_MAJOR);
 }

 module_init(msr_init);

-- 
  / /  (_)__  __ ____  __ Philipp Hahn
 / /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn@titan.lahn.de

