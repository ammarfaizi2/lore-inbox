Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264251AbUFBWgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264251AbUFBWgK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 18:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264922AbUFBWgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 18:36:10 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:32682 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S264251AbUFBWgB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 18:36:01 -0400
Date: Wed, 02 Jun 2004 15:32:24 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: linux-kernel@vger.kernel.org
cc: hannal@us.ibm.com, greg@kroah.com, hpa@zytor.com
Subject: [PATCH 2.6.6-rc2 RFT] Add's class support to cpuid.c
Message-ID: <98460000.1086215543@dyn318071bld.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds class support to arch/i386/kernel/cpuid.c. This enables udev
support. I have tested on a 2-way SMP system and on a 2-way built as UP.
Here are the results for the SMP:

[hlinder@w-hlinder2 hlinder]$ tree /sys/class/cpuid
/sys/class/cpuid
|-- cpu0
|   `-- dev
`-- cpu1
    `-- dev

2 directories, 2 files
[hlinder@w-hlinder2 hlinder]$ more /sys/class/cpuid/cpu0/dev
203:0
[hlinder@w-hlinder2 hlinder]$ more /sys/class/cpuid/cpu1/dev
203:1
[hlinder@w-hlinder2 hlinder]$

And for the UP:

[root@w-hlinder2 root]# tree /sys/class/cpuid
/sys/class/cpuid
`-- cpu0
    `-- dev

1 directory, 1 file

Please review and consider for inclusion for further testing.

Thanks.

Hanna Linder
IBM Linux Technology Center
----------------
diff -Nrup -Xdontdiff linux-2.6.7-rc2/arch/i386/kernel/cpuid.c linux-2.6.7-rc2p/arch/i386/kernel/cpuid.c
--- linux-2.6.7-rc2/arch/i386/kernel/cpuid.c	2004-06-01 16:40:10.000000000 -0700
+++ linux-2.6.7-rc2p/arch/i386/kernel/cpuid.c	2004-06-02 14:22:27.000000000 -0700
@@ -36,12 +36,15 @@
 #include <linux/fs.h>
 #include <linux/smp_lock.h>
 #include <linux/fs.h>
+#include <linux/device.h>
 
 #include <asm/processor.h>
 #include <asm/msr.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
 
+static struct class_simple *cpuid_class;
+
 #ifdef CONFIG_SMP
 
 struct cpuid_command {
@@ -155,17 +158,48 @@ static struct file_operations cpuid_fops
 
 int __init cpuid_init(void)
 {
+	int i, err = 0;
+	struct class_device *class_err;
+	i = 0;
+
 	if (register_chrdev(CPUID_MAJOR, "cpu/cpuid", &cpuid_fops)) {
 		printk(KERN_ERR "cpuid: unable to get major %d for cpuid\n",
 		       CPUID_MAJOR);
-		return -EBUSY;
+		err = -EBUSY;
+		goto out;
+	}
+	cpuid_class = class_simple_create(THIS_MODULE, "cpuid");
+	if (IS_ERR(cpuid_class)){
+		err = PTR_ERR(cpuid_class);
+		goto out_chrdev;
 	}
+	for_each_online_cpu(i){
+		class_err = class_simple_device_add(cpuid_class, MKDEV(CPUID_MAJOR, i), NULL, "cpu%d",i);
+		if (IS_ERR(class_err)){
+			err = PTR_ERR(class_err);
+			goto out_class;
+		}
+	}
+	err = 0;
+	goto out;
 
-	return 0;
+out_class:
+	i = 0;
+	for_each_online_cpu(i)
+		class_simple_device_remove(MKDEV(CPUID_MAJOR, i));
+	class_simple_destroy(cpuid_class);
+out_chrdev:
+	unregister_chrdev(CPUID_MAJOR, "cpu/cpuid");	
+out:
+	return err;
 }
 
 void __exit cpuid_exit(void)
 {
+	int i = 0;
+	for_each_online_cpu(i)
+		class_simple_device_remove(MKDEV(CPUID_MAJOR, i));
+	class_simple_destroy(cpuid_class);
 	unregister_chrdev(CPUID_MAJOR, "cpu/cpuid");
 }
 



