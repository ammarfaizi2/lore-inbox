Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265074AbUFVSC4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265074AbUFVSC4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 14:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265106AbUFVSCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 14:02:19 -0400
Received: from mail.kroah.org ([65.200.24.183]:46773 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265074AbUFVRnc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 13:43:32 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.7
In-Reply-To: <10879261092729@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Tue, 22 Jun 2004 10:41:49 -0700
Message-Id: <1087926109288@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1722.89.49, 2004/06/03 12:38:31-07:00, hannal@us.ibm.com

[PATCH] Add class support to cpuid.c

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


Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 arch/i386/kernel/cpuid.c |   38 ++++++++++++++++++++++++++++++++++++--
 1 files changed, 36 insertions(+), 2 deletions(-)


diff -Nru a/arch/i386/kernel/cpuid.c b/arch/i386/kernel/cpuid.c
--- a/arch/i386/kernel/cpuid.c	Tue Jun 22 09:48:45 2004
+++ b/arch/i386/kernel/cpuid.c	Tue Jun 22 09:48:45 2004
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
@@ -155,17 +158,48 @@
 
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
+	if (IS_ERR(cpuid_class)) {
+		err = PTR_ERR(cpuid_class);
+		goto out_chrdev;
 	}
+	for_each_online_cpu(i) {
+		class_err = class_simple_device_add(cpuid_class, MKDEV(CPUID_MAJOR, i), NULL, "cpu%d",i);
+		if (IS_ERR(class_err)) {
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
 

