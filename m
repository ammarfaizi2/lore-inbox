Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261453AbSJDDNf>; Thu, 3 Oct 2002 23:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261455AbSJDDNf>; Thu, 3 Oct 2002 23:13:35 -0400
Received: from 12-237-16-92.client.attbi.com ([12.237.16.92]:18826 "EHLO
	ledzep.dyndns.org") by vger.kernel.org with ESMTP
	id <S261453AbSJDDNc>; Thu, 3 Oct 2002 23:13:32 -0400
Message-ID: <3D9D088D.1010600@attbi.com>
Date: Thu, 03 Oct 2002 22:18:37 -0500
From: Jordan Breeding <jordan.breeding@attbi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH] add devfs support to cpuid and msr
Content-Type: multipart/mixed;
 boundary="------------050601070806060400010903"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050601070806060400010903
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

   This patch was originally floating around linux-kernel a while ago 
for 2.4.x, all I have done is update it to work with 2.5.x.  It will 
only create directories and device files for cpus present at boot, there 
was a seperate version of a patch similar to this which implemented 
devfs_per_cpu_{un,}register functions but the devfs code it was based is 
very different than todays devfs in 2.5.x.  This patch works well enough 
for me to simply gain access to /dev/cpu/%d/{cpuid,msr}.  Thanks.

Jordan

--------------050601070806060400010903
Content-Type: text/plain;
 name="patch-cpuid-msr-devfs-2.5.36-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-cpuid-msr-devfs-2.5.36-1"

diff -urN linux-2.5.36/arch/i386/kernel/cpuid.c linux-2.5.36-bk/arch/i386/kernel/cpuid.c
--- linux-2.5.36/arch/i386/kernel/cpuid.c	2002-08-27 23:21:23.000000000 -0500
+++ linux-2.5.36-bk/arch/i386/kernel/cpuid.c	2002-09-19 21:43:02.000000000 -0500
@@ -23,6 +23,8 @@
  *
  * This driver uses /dev/cpu/%d/cpuid where %d is the minor number, and on
  * an SMP box will direct the access to CPU %d.
+ *
+ * 20020812 - David McIlwraith (quack@bigpond.net.au) - Added devfs support
  */
 
 #include <linux/module.h>
@@ -36,14 +38,17 @@
 #include <linux/smp.h>
 #include <linux/major.h>
 #include <linux/fs.h>
+#include <linux/devfs_fs_kernel.h>
+#include <linux/slab.h>
 #include <linux/smp_lock.h>
-#include <linux/fs.h>
 
 #include <asm/processor.h>
 #include <asm/msr.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
 
+static devfs_handle_t *devfs_handles;
+
 #ifdef CONFIG_SMP
 
 struct cpuid_command {
@@ -113,7 +118,7 @@
   u32 data[4];
   size_t rv;
   u32 reg = *ppos;
-  int cpu = minor(file->f_dentry->d_inode->i_rdev);
+  int cpu = file->private_data ? (int) file->private_data - 1 : minor(file->f_dentry->d_inode->i_rdev);
   
   if ( count % 16 )
     return -EINVAL; /* Invalid chunk size */
@@ -131,7 +136,7 @@
 
 static int cpuid_open(struct inode *inode, struct file *file)
 {
-  int cpu = minor(file->f_dentry->d_inode->i_rdev);
+  int cpu = file->private_data ? (int) file->private_data - 1 : minor(file->f_dentry->d_inode->i_rdev);
   struct cpuinfo_x86 *c = &(cpu_data)[cpu];
 
   if ( !(cpu_online_map & (1UL << cpu)) )
@@ -154,18 +159,41 @@
 
 int __init cpuid_init(void)
 {
-  if (register_chrdev(CPUID_MAJOR, "cpu/cpuid", &cpuid_fops)) {
+  int i;
+  char devname[24];
+
+  if (register_chrdev(CPUID_MAJOR, "cpu/%d/cpuid", &cpuid_fops)) {
     printk(KERN_ERR "cpuid: unable to get major %d for cpuid\n",
 	   CPUID_MAJOR);
     return -EBUSY;
   }
 
+  devfs_handles = (devfs_handle_t *) kmalloc(num_online_cpus() * sizeof(devfs_handle_t), GFP_KERNEL);
+  if (!devfs_handles) {
+    printk(KERN_ERR "cpuid: unable to allocate memory for devfs\n");
+    return -ENOMEM;
+  }
+
+  for (i = 0; i < num_online_cpus(); ++i)
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
+  unregister_chrdev(CPUID_MAJOR, "cpu/%d/cpuid");
+
+  for (i = 0; i < num_online_cpus(); ++i)
+    devfs_unregister(devfs_handles[i]);
+
+  kfree(devfs_handles);
 }
 
 module_init(cpuid_init);
diff -urN linux-2.5.36/arch/i386/kernel/msr.c linux-2.5.36-bk/arch/i386/kernel/msr.c
--- linux-2.5.36/arch/i386/kernel/msr.c	2002-08-27 23:21:23.000000000 -0500
+++ linux-2.5.36-bk/arch/i386/kernel/msr.c	2002-09-19 21:45:06.000000000 -0500
@@ -22,6 +22,8 @@
  *
  * This driver uses /dev/cpu/%d/msr where %d is the minor number, and on
  * an SMP box will direct the access to CPU %d.
+ *
+ * 20020812 - David McIlwraith (quack@bigpond.net.au) - Added devfs support
  */
 
 #include <linux/module.h>
@@ -35,6 +37,8 @@
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
 #include <linux/major.h>
+#include <linux/devfs_fs_kernel.h>
+#include <linux/slab.h>
 #include <linux/fs.h>
 
 #include <asm/processor.h>
@@ -42,6 +46,8 @@
 #include <asm/uaccess.h>
 #include <asm/system.h>
 
+static devfs_handle_t *devfs_handles;
+
 /* Note: "err" is handled in a funny way below.  Otherwise one version
    of gcc or another breaks. */
 
@@ -186,7 +192,7 @@
   u32 data[2];
   size_t rv;
   u32 reg = *ppos;
-  int cpu = minor(file->f_dentry->d_inode->i_rdev);
+  int cpu = file->private_data ? (int) file->private_data - 1 : minor(file->f_dentry->d_inode->i_rdev);
   int err;
 
   if ( count % 8 )
@@ -211,7 +217,7 @@
   u32 data[2];
   size_t rv;
   u32 reg = *ppos;
-  int cpu = minor(file->f_dentry->d_inode->i_rdev);
+  int cpu = file->private_data ? (int) file->private_data - 1 : minor(file->f_dentry->d_inode->i_rdev);
   int err;
 
   if ( count % 8 )
@@ -231,7 +237,7 @@
 
 static int msr_open(struct inode *inode, struct file *file)
 {
-  int cpu = minor(file->f_dentry->d_inode->i_rdev);
+  int cpu = file->private_data ? (int) file->private_data - 1 : minor(file->f_dentry->d_inode->i_rdev);
   struct cpuinfo_x86 *c = &(cpu_data)[cpu];
   
   if ( !(cpu_online_map & (1UL << cpu)) )
@@ -255,18 +261,41 @@
 
 int __init msr_init(void)
 {
-  if (register_chrdev(MSR_MAJOR, "cpu/msr", &msr_fops)) {
+  int i;
+  char devname[24];
+
+  if (register_chrdev(MSR_MAJOR, "cpu/%d/msr", &msr_fops)) {
     printk(KERN_ERR "msr: unable to get major %d for msr\n",
 	   MSR_MAJOR);
     return -EBUSY;
   }
-  
+
+  devfs_handles = (devfs_handle_t *) kmalloc(num_online_cpus() * sizeof(devfs_handle_t), GFP_KERNEL);
+  if (!devfs_handles) {
+    printk(KERN_ERR "msr: unable to allocate memory for devfs\n");
+    return -ENOMEM;
+  }
+
+  for (i = 0; i < num_online_cpus(); ++i)
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
+  unregister_chrdev(MSR_MAJOR, "cpu/%d/msr");
+
+  for (i = 0; i < num_online_cpus(); ++i)
+    devfs_unregister(devfs_handles[i]);
+
+  kfree(devfs_handles);
 }
 
 module_init(msr_init);

--------------050601070806060400010903--

