Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266035AbUFIXrX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266035AbUFIXrX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 19:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266062AbUFIXqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 19:46:47 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:48035 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266035AbUFIXol (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 19:44:41 -0400
Date: Wed, 09 Jun 2004 16:40:37 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: linux-kernel@vger.kernel.org
cc: Hanna Linder <hannal@us.ibm.com>, greg@kroah.com, hpa@zytor.com
Subject: Re: [PATCH 2.6.7-rc3] Add's class support to msr.c
Message-ID: <147490000.1086824437@dyn318071bld.beaverton.ibm.com>
In-Reply-To: <146320000.1086823391@dyn318071bld.beaverton.ibm.com>
References: <146320000.1086823391@dyn318071bld.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Wednesday, June 09, 2004 04:23:11 PM -0700 Hanna Linder <hannal@us.ibm.com> wrote:
> 
> This patch enables class support in arch/i386/kernel/msr.c. Very simliar
> to cpuid (with the fixes Zwane/Greg made, thanks). 
> 
> [root@w-hlinder2 root]# tree /sys/class/msr
> /sys/class/msr
>| -- msr0
>|   `-- dev
> `-- msr1
>     `-- dev
> 
> 2 directories, 2 files
> 
> Please consider for testing/inclusion.
> 
> Signed-off-by Hanna Linder <hannal@us.ibm.com>
> 
> Thanks.
> 
> Hanna Linder
> IBM Linux Technology Center

Thanks to Randy Dunlap for pointing out the unnecessary tabs. Fixed.

------
diff -Nrup linux-2.6.7-rc3/arch/i386/kernel/msr.c linux-2.6.7-rc3p/arch/i386/kernel/msr.c
--- linux-2.6.7-rc3/arch/i386/kernel/msr.c	2004-06-08 16:49:29.000000000 -0700
+++ linux-2.6.7-rc3p/arch/i386/kernel/msr.c	2004-06-09 16:33:29.000000000 -0700
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
 
@@ -255,20 +260,82 @@ static struct file_operations msr_fops =
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



