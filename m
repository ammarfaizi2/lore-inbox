Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265047AbUFVSLU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265047AbUFVSLU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 14:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265133AbUFVSKd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 14:10:33 -0400
Received: from mail.kroah.org ([65.200.24.183]:20917 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265047AbUFVRnO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 13:43:14 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.7
In-Reply-To: <10879261122448@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Tue, 22 Jun 2004 10:41:52 -0700
Message-Id: <10879261122006@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1722.111.24, 2004/06/11 17:22:14-07:00, hannal@us.ibm.com

[PATCH] Driver Model: Add class support to msr.c

This patch enables class support in arch/i386/kernel/msr.c. Very simliar
to cpuid (with the fixes Zwane/Greg made, thanks).

[root@w-hlinder2 root]# tree /sys/class/msr
/sys/class/msr
| -- msr0
|   `-- dev
`-- msr1
    `-- dev

2 directories, 2 files

Thanks to Randy Dunlap for pointing out the unnecessary tabs. Fixed.

Signed-off-by Hanna Linder <hannal@us.ibm.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 arch/i386/kernel/msr.c |   71 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 69 insertions(+), 2 deletions(-)


diff -Nru a/arch/i386/kernel/msr.c b/arch/i386/kernel/msr.c
--- a/arch/i386/kernel/msr.c	Tue Jun 22 09:46:58 2004
+++ b/arch/i386/kernel/msr.c	Tue Jun 22 09:46:58 2004
@@ -35,12 +35,17 @@
 #include <linux/smp_lock.h>
 #include <linux/major.h>
 #include <linux/fs.h>
+#include <linux/device.h>
+#include <linux/cpu.h>
+#include <linux/notifier.h>
 
 #include <asm/processor.h>
 #include <asm/msr.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
 
+static struct class_simple *msr_class;
+
 /* Note: "err" is handled in a funny way below.  Otherwise one version
    of gcc or another breaks. */
 
@@ -255,20 +260,82 @@
 	.open = msr_open,
 };
 
+static int msr_class_simple_device_add(int i)
+{
+	int err = 0;
+	struct class_device *class_err;
+
+	class_err = class_simple_device_add(msr_class, MKDEV(MSR_MAJOR, i), NULL, "msr%d",i);
+	if (IS_ERR(class_err)) 
+		err = PTR_ERR(class_err);
+	return err;
+}
+
+static int __devinit msr_class_cpu_callback(struct notifier_block *nfb, unsigned long action, void *hcpu)
+{
+	unsigned int cpu = (unsigned long)hcpu;
+
+	switch (action) {
+	case CPU_ONLINE:
+		msr_class_simple_device_add(cpu);
+		break;
+	case CPU_DEAD:
+		class_simple_device_remove(MKDEV(MSR_MAJOR, cpu));	
+		break;
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block msr_class_cpu_notifier =
+{
+	.notifier_call = msr_class_cpu_callback,
+};
+
 int __init msr_init(void)
 {
+	int i, err = 0;
+	i = 0;
+
 	if (register_chrdev(MSR_MAJOR, "cpu/msr", &msr_fops)) {
 		printk(KERN_ERR "msr: unable to get major %d for msr\n",
 		       MSR_MAJOR);
-		return -EBUSY;
+		err = -EBUSY;
+		goto out;
+	}
+	msr_class = class_simple_create(THIS_MODULE, "msr");
+	if (IS_ERR(msr_class)) {
+		err = PTR_ERR(msr_class);
+		goto out_chrdev;
 	}
+	for_each_online_cpu(i) {
+		err = msr_class_simple_device_add(i);
+		if (err != 0)
+			goto out_class;
+	}
+	register_cpu_notifier(&msr_class_cpu_notifier);
 
-	return 0;
+	err = 0;
+	goto out;
+
+out_class:
+	i = 0;
+	for_each_online_cpu(i)
+		class_simple_device_remove(MKDEV(MSR_MAJOR, i));
+	class_simple_destroy(msr_class);
+out_chrdev:
+	unregister_chrdev(MSR_MAJOR, "cpu/msr");
+out:
+	return err;
 }
 
 void __exit msr_exit(void)
 {
+	int cpu = 0;
+	for_each_online_cpu(cpu)
+		class_simple_device_remove(MKDEV(MSR_MAJOR, cpu));
+	class_simple_destroy(msr_class);
 	unregister_chrdev(MSR_MAJOR, "cpu/msr");
+	unregister_cpu_notifier(&msr_class_cpu_notifier);
 }
 
 module_init(msr_init);

