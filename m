Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265065AbUFVSHO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265065AbUFVSHO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 14:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265043AbUFVSFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 14:05:41 -0400
Received: from mail.kroah.org ([65.200.24.183]:40117 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265058AbUFVRnY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 13:43:24 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.7
In-Reply-To: <10879261104131@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Tue, 22 Jun 2004 10:41:50 -0700
Message-Id: <1087926110895@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1722.89.56, 2004/06/08 16:26:12-07:00, hannal@us.ibm.com

[PATCH] Add cpu hotplug support to cpuid.c

Here is the patch that uses a cpu hotplug callback, to allow dynamic support
of cpu id for classes in sysfs.

This patch applies on top of the one I sent out earlier that Greg included.
I do not have access to hardware that supports cpu hotswapping (virtually or not)
so have not been able to test that aspect of the patch. However, the original
functionality of listing static cpu's still works.

Please consider for testing or inclusion.

Signed-off-by: Hanna Linder <hannal@us.ibm.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 arch/i386/kernel/cpuid.c |   59 ++++++++++++++++++++++++++++++++++++++---------
 1 files changed, 48 insertions(+), 11 deletions(-)


diff -Nru a/arch/i386/kernel/cpuid.c b/arch/i386/kernel/cpuid.c
--- a/arch/i386/kernel/cpuid.c	Tue Jun 22 09:47:45 2004
+++ b/arch/i386/kernel/cpuid.c	Tue Jun 22 09:47:45 2004
@@ -37,6 +37,8 @@
 #include <linux/smp_lock.h>
 #include <linux/fs.h>
 #include <linux/device.h>
+#include <linux/cpu.h>
+#include <linux/notifier.h>
 
 #include <asm/processor.h>
 #include <asm/msr.h>
@@ -156,10 +158,48 @@
 	.open = cpuid_open,
 };
 
+static void cpuid_class_simple_device_remove(void)
+{
+	int i = 0;
+	for_each_online_cpu(i)
+		class_simple_device_remove(MKDEV(CPUID_MAJOR, i));
+	return;
+}
+
+static int cpuid_class_simple_device_add(int i) 
+{
+	int err = 0;
+	struct class_device *class_err;
+
+	class_err = class_simple_device_add(cpuid_class, MKDEV(CPUID_MAJOR, i), NULL, "cpu%d",i);
+	if (IS_ERR(class_err)) {
+		err = PTR_ERR(class_err);
+	}
+	return err;
+}
+static int __devinit cpuid_class_cpu_callback(struct notifier_block *nfb, unsigned long action, void *hcpu)
+{
+	unsigned int cpu = (unsigned long)hcpu;
+
+	switch(action) {
+	case CPU_ONLINE:
+		cpuid_class_simple_device_add(cpu);
+		break;
+	case CPU_DEAD:
+		cpuid_class_simple_device_remove();
+		break;
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block cpuid_class_cpu_notifier =
+{
+	.notifier_call = cpuid_class_cpu_callback,
+};
+
 int __init cpuid_init(void)
 {
 	int i, err = 0;
-	struct class_device *class_err;
 	i = 0;
 
 	if (register_chrdev(CPUID_MAJOR, "cpu/cpuid", &cpuid_fops)) {
@@ -174,19 +214,17 @@
 		goto out_chrdev;
 	}
 	for_each_online_cpu(i) {
-		class_err = class_simple_device_add(cpuid_class, MKDEV(CPUID_MAJOR, i), NULL, "cpu%d",i);
-		if (IS_ERR(class_err)) {
-			err = PTR_ERR(class_err);
+		err = cpuid_class_simple_device_add(i);
+		if (err != 0) 
 			goto out_class;
-		}
 	}
+	register_cpu_notifier(&cpuid_class_cpu_notifier);
+
 	err = 0;
 	goto out;
 
 out_class:
-	i = 0;
-	for_each_online_cpu(i)
-		class_simple_device_remove(MKDEV(CPUID_MAJOR, i));
+	cpuid_class_simple_device_remove();
 	class_simple_destroy(cpuid_class);
 out_chrdev:
 	unregister_chrdev(CPUID_MAJOR, "cpu/cpuid");	
@@ -196,11 +234,10 @@
 
 void __exit cpuid_exit(void)
 {
-	int i = 0;
-	for_each_online_cpu(i)
-		class_simple_device_remove(MKDEV(CPUID_MAJOR, i));
+	cpuid_class_simple_device_remove();
 	class_simple_destroy(cpuid_class);
 	unregister_chrdev(CPUID_MAJOR, "cpu/cpuid");
+	unregister_cpu_notifier(&cpuid_class_cpu_notifier);
 }
 
 module_init(cpuid_init);

