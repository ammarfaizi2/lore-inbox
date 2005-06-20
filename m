Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261869AbVFUA3v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261869AbVFUA3v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 20:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261778AbVFUA2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 20:28:50 -0400
Received: from mail.kroah.org ([69.55.234.183]:49124 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261777AbVFTW75 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:59:57 -0400
Cc: gregkh@suse.de
Subject: [PATCH] class: convert arch/* to use the new class api instead of class_simple
In-Reply-To: <11193083632112@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:23 -0700
Message-Id: <11193083633233@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] class: convert arch/* to use the new class api instead of class_simple

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 8874b414ffe037c39e73bb262ddf69653a13c0a4
tree d7a7b021ab3b4319cc65f1b4fd2f76eb757dfb69
parent d253878b3d9ae523c76118f5336a662780ad3757
author gregkh@suse.de <gregkh@suse.de> Wed, 23 Mar 2005 09:56:34 -0800
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:09 -0700

 arch/i386/kernel/cpuid.c |   22 +++++++++++-----------
 arch/i386/kernel/msr.c   |   22 +++++++++++-----------
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/i386/kernel/cpuid.c b/arch/i386/kernel/cpuid.c
--- a/arch/i386/kernel/cpuid.c
+++ b/arch/i386/kernel/cpuid.c
@@ -45,7 +45,7 @@
 #include <asm/uaccess.h>
 #include <asm/system.h>
 
-static struct class_simple *cpuid_class;
+static struct class *cpuid_class;
 
 #ifdef CONFIG_SMP
 
@@ -158,12 +158,12 @@ static struct file_operations cpuid_fops
 	.open = cpuid_open,
 };
 
-static int cpuid_class_simple_device_add(int i) 
+static int cpuid_class_device_create(int i)
 {
 	int err = 0;
 	struct class_device *class_err;
 
-	class_err = class_simple_device_add(cpuid_class, MKDEV(CPUID_MAJOR, i), NULL, "cpu%d",i);
+	class_err = class_device_create(cpuid_class, MKDEV(CPUID_MAJOR, i), NULL, "cpu%d",i);
 	if (IS_ERR(class_err))
 		err = PTR_ERR(class_err);
 	return err;
@@ -175,10 +175,10 @@ static int __devinit cpuid_class_cpu_cal
 
 	switch (action) {
 	case CPU_ONLINE:
-		cpuid_class_simple_device_add(cpu);
+		cpuid_class_device_create(cpu);
 		break;
 	case CPU_DEAD:
-		class_simple_device_remove(MKDEV(CPUID_MAJOR, cpu));
+		class_device_destroy(cpuid_class, MKDEV(CPUID_MAJOR, cpu));
 		break;
 	}
 	return NOTIFY_OK;
@@ -200,13 +200,13 @@ static int __init cpuid_init(void)
 		err = -EBUSY;
 		goto out;
 	}
-	cpuid_class = class_simple_create(THIS_MODULE, "cpuid");
+	cpuid_class = class_create(THIS_MODULE, "cpuid");
 	if (IS_ERR(cpuid_class)) {
 		err = PTR_ERR(cpuid_class);
 		goto out_chrdev;
 	}
 	for_each_online_cpu(i) {
-		err = cpuid_class_simple_device_add(i);
+		err = cpuid_class_device_create(i);
 		if (err != 0) 
 			goto out_class;
 	}
@@ -218,9 +218,9 @@ static int __init cpuid_init(void)
 out_class:
 	i = 0;
 	for_each_online_cpu(i) {
-		class_simple_device_remove(MKDEV(CPUID_MAJOR, i));
+		class_device_destroy(cpuid_class, MKDEV(CPUID_MAJOR, i));
 	}
-	class_simple_destroy(cpuid_class);
+	class_destroy(cpuid_class);
 out_chrdev:
 	unregister_chrdev(CPUID_MAJOR, "cpu/cpuid");	
 out:
@@ -232,8 +232,8 @@ static void __exit cpuid_exit(void)
 	int cpu = 0;
 
 	for_each_online_cpu(cpu)
-		class_simple_device_remove(MKDEV(CPUID_MAJOR, cpu));
-	class_simple_destroy(cpuid_class);
+		class_device_destroy(cpuid_class, MKDEV(CPUID_MAJOR, cpu));
+	class_destroy(cpuid_class);
 	unregister_chrdev(CPUID_MAJOR, "cpu/cpuid");
 	unregister_cpu_notifier(&cpuid_class_cpu_notifier);
 }
diff --git a/arch/i386/kernel/msr.c b/arch/i386/kernel/msr.c
--- a/arch/i386/kernel/msr.c
+++ b/arch/i386/kernel/msr.c
@@ -44,7 +44,7 @@
 #include <asm/uaccess.h>
 #include <asm/system.h>
 
-static struct class_simple *msr_class;
+static struct class *msr_class;
 
 /* Note: "err" is handled in a funny way below.  Otherwise one version
    of gcc or another breaks. */
@@ -260,12 +260,12 @@ static struct file_operations msr_fops =
 	.open = msr_open,
 };
 
-static int msr_class_simple_device_add(int i)
+static int msr_class_device_create(int i)
 {
 	int err = 0;
 	struct class_device *class_err;
 
-	class_err = class_simple_device_add(msr_class, MKDEV(MSR_MAJOR, i), NULL, "msr%d",i);
+	class_err = class_device_create(msr_class, MKDEV(MSR_MAJOR, i), NULL, "msr%d",i);
 	if (IS_ERR(class_err)) 
 		err = PTR_ERR(class_err);
 	return err;
@@ -277,10 +277,10 @@ static int __devinit msr_class_cpu_callb
 
 	switch (action) {
 	case CPU_ONLINE:
-		msr_class_simple_device_add(cpu);
+		msr_class_device_create(cpu);
 		break;
 	case CPU_DEAD:
-		class_simple_device_remove(MKDEV(MSR_MAJOR, cpu));	
+		class_device_destroy(msr_class, MKDEV(MSR_MAJOR, cpu));
 		break;
 	}
 	return NOTIFY_OK;
@@ -302,13 +302,13 @@ static int __init msr_init(void)
 		err = -EBUSY;
 		goto out;
 	}
-	msr_class = class_simple_create(THIS_MODULE, "msr");
+	msr_class = class_create(THIS_MODULE, "msr");
 	if (IS_ERR(msr_class)) {
 		err = PTR_ERR(msr_class);
 		goto out_chrdev;
 	}
 	for_each_online_cpu(i) {
-		err = msr_class_simple_device_add(i);
+		err = msr_class_device_create(i);
 		if (err != 0)
 			goto out_class;
 	}
@@ -320,8 +320,8 @@ static int __init msr_init(void)
 out_class:
 	i = 0;
 	for_each_online_cpu(i)
-		class_simple_device_remove(MKDEV(MSR_MAJOR, i));
-	class_simple_destroy(msr_class);
+		class_device_destroy(msr_class, MKDEV(MSR_MAJOR, i));
+	class_destroy(msr_class);
 out_chrdev:
 	unregister_chrdev(MSR_MAJOR, "cpu/msr");
 out:
@@ -332,8 +332,8 @@ static void __exit msr_exit(void)
 {
 	int cpu = 0;
 	for_each_online_cpu(cpu)
-		class_simple_device_remove(MKDEV(MSR_MAJOR, cpu));
-	class_simple_destroy(msr_class);
+		class_device_destroy(msr_class, MKDEV(MSR_MAJOR, cpu));
+	class_destroy(msr_class);
 	unregister_chrdev(MSR_MAJOR, "cpu/msr");
 	unregister_cpu_notifier(&msr_class_cpu_notifier);
 }

