Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318361AbSHKUtb>; Sun, 11 Aug 2002 16:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318365AbSHKUtb>; Sun, 11 Aug 2002 16:49:31 -0400
Received: from dialup-250.11.220.203.acc08-dryb-mel.comindico.com.au ([203.220.11.250]:16644
	"HELO linux") by vger.kernel.org with SMTP id <S318361AbSHKUt3>;
	Sun, 11 Aug 2002 16:49:29 -0400
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>
From: "David McIlwraith" <quack@bigpond.net.au>
Subject: [PATCH] 2.4.19 CPUID, MSR: add devfs support
Message-Id: <20020811204929Z318361-685+28277@vger.kernel.org>
Date: Sun, 11 Aug 2002 16:49:29 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This set of patches adds devfs support for both cpuid and msr drivers in kernel 2.4.19.

diff -Naur linux/arch/i386/kernel/cpuid.c linux-2.4.19-dm1/arch/i386/kernel/cpuid.c
--- linux/arch/i386/kernel/cpuid.c	Mon Aug 12 04:32:08 2002
+++ linux-2.4.19-dm1/arch/i386/kernel/cpuid.c	Mon Aug 12 04:38:14 2002
@@ -23,6 +23,8 @@
  *
  * This driver uses /dev/cpu/%d/cpuid where %d is the minor number, and on
  * an SMP box will direct the access to CPU %d.
+ *
+ * 20020812 - David McIlwraith (quack@bigpond.net.au) - Added devfs support
  */
 
 #include <linux/module.h>
@@ -35,12 +37,16 @@
 #include <linux/poll.h>
 #include <linux/smp.h>
 #include <linux/major.h>
+#include <linux/devfs_fs_kernel.h>
+#include <linux/slab.h>
 
 #include <asm/processor.h>
 #include <asm/msr.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
 
+static devfs_handle_t *devfs_handles;
+
 #ifdef CONFIG_SMP
 
 struct cpuid_command {
@@ -101,7 +107,7 @@
   u32 data[4];
   size_t rv;
   u32 reg = *ppos;
-  int cpu = MINOR(file->f_dentry->d_inode->i_rdev);
+  int cpu = file->private_data ? (int) file->private_data - 1 : MINOR(file->f_dentry->d_inode->i_rdev);
   
   if ( count % 16 )
     return -EINVAL; /* Invalid chunk size */
@@ -119,7 +125,7 @@
 
 static int cpuid_open(struct inode *inode, struct file *file)
 {
-  int cpu = MINOR(file->f_dentry->d_inode->i_rdev);
+  int cpu = file->private_data ? (int) file->private_data - 1 : MINOR(file->f_dentry->d_inode->i_rdev);
   struct cpuinfo_x86 *c = &(cpu_data)[cpu];
 
   if ( !(cpu_online_map & (1UL << cpu)) )
@@ -142,18 +148,41 @@
 
 int __init cpuid_init(void)
 {
-  if (register_chrdev(CPUID_MAJOR, "cpu/cpuid", &cpuid_fops)) {
+  int i;
+  char devname[24];
+
+  if (devfs_register_chrdev(CPUID_MAJOR, "cpu/cpuid", &cpuid_fops)) {
     printk(KERN_ERR "cpuid: unable to get major %d for cpuid\n",
 	   CPUID_MAJOR);
     return -EBUSY;
   }
 
+  devfs_handles = (devfs_handle_t *) kmalloc(smp_num_cpus * sizeof(devfs_handle_t), GFP_KERNEL);
+  if (!devfs_handles) {
+    printk(KERN_ERR "cpuid: unable to allocate memory for devfs\n");
+    return -ENOMEM;
+  }
+
+  for (i = 0; i < smp_num_cpus; ++i)
+  {
+    snprintf(devname, 24, "cpu/%i/cpuid", i);
+    devfs_handles[i] = devfs_register(NULL, devname, DEVFS_FL_DEFAULT, CPUID_MAJOR, i,
+ 				      S_IFCHR | S_IRUGO, &cpuid_fops, (void *) i + 1);
+  }
+
   return 0;
 }
 
 void __exit cpuid_exit(void)
 {
-  unregister_chrdev(CPUID_MAJOR, "cpu/cpuid");
+  int i;
+
+  devfs_unregister_chrdev(CPUID_MAJOR, "cpu/cpuid");
+
+  for (i = 0; i < smp_num_cpus; ++i)
+    devfs_unregister(devfs_handles[i]);
+
+  kfree(devfs_handles);
 }
 
 module_init(cpuid_init);
diff -Naur linux/arch/i386/kernel/msr.c linux-2.4.19-dm1/arch/i386/kernel/msr.c
--- linux/arch/i386/kernel/msr.c	Mon Aug 12 04:32:13 2002
+++ linux-2.4.19-dm1/arch/i386/kernel/msr.c	Mon Aug 12 04:39:06 2002
@@ -22,6 +22,8 @@
  *
  * This driver uses /dev/cpu/%d/msr where %d is the minor number, and on
  * an SMP box will direct the access to CPU %d.
+ *
+ * 20020812 - David McIlwraith (quack@bigpond.net.au) - Added devfs support
  */
 
 #include <linux/module.h>
@@ -34,12 +36,16 @@
 #include <linux/poll.h>
 #include <linux/smp.h>
 #include <linux/major.h>
+#include <linux/devfs_fs_kernel.h>
+#include <linux/slab.h>
 
 #include <asm/processor.h>
 #include <asm/msr.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
 
+static devfs_handle_t *devfs_handles;
+
 /* Note: "err" is handled in a funny way below.  Otherwise one version
    of gcc or another breaks. */
 
@@ -181,7 +187,7 @@
   u32 data[2];
   size_t rv;
   u32 reg = *ppos;
-  int cpu = MINOR(file->f_dentry->d_inode->i_rdev);
+  int cpu = file->private_data ? (int) file->private_data - 1 : MINOR(file->f_dentry->d_inode->i_rdev);
   int err;
 
   if ( count % 8 )
@@ -206,7 +212,7 @@
   u32 data[2];
   size_t rv;
   u32 reg = *ppos;
-  int cpu = MINOR(file->f_dentry->d_inode->i_rdev);
+  int cpu = file->private_data ? (int) file->private_data - 1 : MINOR(file->f_dentry->d_inode->i_rdev);
   int err;
 
   if ( count % 8 )
@@ -226,7 +232,7 @@
 
 static int msr_open(struct inode *inode, struct file *file)
 {
-  int cpu = MINOR(file->f_dentry->d_inode->i_rdev);
+  int cpu = file->private_data ? (int) file->private_data - 1 : MINOR(file->f_dentry->d_inode->i_rdev);
   struct cpuinfo_x86 *c = &(cpu_data)[cpu];
   
   if ( !(cpu_online_map & (1UL << cpu)) )
@@ -250,18 +256,41 @@
 
 int __init msr_init(void)
 {
-  if (register_chrdev(MSR_MAJOR, "cpu/msr", &msr_fops)) {
+  int i;
+  char devname[24];
+
+  if (devfs_register_chrdev(MSR_MAJOR, "cpu/msr", &msr_fops)) {
     printk(KERN_ERR "msr: unable to get major %d for msr\n",
 	   MSR_MAJOR);
     return -EBUSY;
   }
-  
+
+  devfs_handles = (devfs_handle_t *) kmalloc(smp_num_cpus * sizeof(devfs_handle_t), GFP_KERNEL);
+  if (!devfs_handles) {
+    printk(KERN_ERR "msr: unable to allocate memory for devfs\n");
+    return -ENOMEM;
+  }
+
+  for (i = 0; i < smp_num_cpus; ++i)
+  {
+    snprintf(devname, 24, "cpu/%i/msr", i);
+    devfs_handles[i] = devfs_register(NULL, devname, DEVFS_FL_DEFAULT, MSR_MAJOR, i,
+				      S_IFCHR | S_IRUGO | S_IWUSR, &msr_fops, (void *) i + 1);
+  }
+
   return 0;
 }
 
 void __exit msr_exit(void)
 {
-  unregister_chrdev(MSR_MAJOR, "cpu/msr");
+  int i;
+
+  devfs_unregister_chrdev(MSR_MAJOR, "cpu/msr");
+
+  for (i = 0; i < smp_num_cpus; ++i)
+    devfs_unregister(devfs_handles[i]);
+
+  kfree(devfs_handles);
 }
 
 module_init(msr_init);
