Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265331AbUFHVOb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265331AbUFHVOb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 17:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265325AbUFHVOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 17:14:30 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:937 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S265316AbUFHVOS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 17:14:18 -0400
Date: Tue, 08 Jun 2004 14:10:18 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: Greg KH <greg@kroah.com>, "H. Peter Anvin" <hpa@zytor.com>
cc: Hanna Linder <hannal@us.ibm.com>, linux-kernel@vger.kernel.org,
       haveblue@us.ibm.com
Subject: Re: [PATCH 2.6.6-rc2 RFT] Add's class support to cpuid.c
Message-ID: <7430000.1086729016@dyn318071bld.beaverton.ibm.com>
In-Reply-To: <20040603193256.GD23564@kroah.com>
References: <98460000.1086215543@dyn318071bld.beaverton.ibm.com> <40BE6CA9.9030403@zytor.com> <20040603193256.GD23564@kroah.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Thursday, June 03, 2004 12:32:56 PM -0700 Greg KH <greg@kroah.com> wrote:
> On Wed, Jun 02, 2004 at 05:11:21PM -0700, H. Peter Anvin wrote:
>> As it is, it also mishandles the hotswap CPU scenario.
> 
> I agree, but that can be easily added with a second patch on top of this
> one, right Hanna?  :)

Here is the patch that uses a cpu hotplug callback, to allow dynamic support 
of cpu id for classes in sysfs.

This patch applies on top of the one I sent out earlier that Greg included.
I do not have access to hardware that supports cpu hotswapping (virtually or not) 
so have not been able to test that aspect of the patch. However, the original
functionality of listing static cpu's still works.

Please consider for testing or inclusion. 

Signed-off-by Hanna Linder <hannal@us.ibm.com>

Thanks.

Hanna Linder
IBM Linux Technology Center
-------

diff -Nrup -Xdontdiff linux-2.6.7-rc2/arch/i386/kernel/cpuid.c linux-2.6.7-rc2p/arch/i386/kernel/cpuid.c
--- linux-2.6.7-rc2/arch/i386/kernel/cpuid.c	2004-06-03 15:51:37.000000000 -0700
+++ linux-2.6.7-rc2p/arch/i386/kernel/cpuid.c	2004-06-07 15:52:50.000000000 -0700
@@ -37,6 +37,8 @@
 #include <linux/smp_lock.h>
 #include <linux/fs.h>
 #include <linux/device.h>
+#include <linux/cpu.h>
+#include <linux/notifier.h>
 
 #include <asm/processor.h>
 #include <asm/msr.h>
@@ -156,10 +158,48 @@ static struct file_operations cpuid_fops
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
@@ -174,33 +214,31 @@ int __init cpuid_init(void)
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
+	unregister_cpu_notifier(&cpuid_class_cpu_notifier);
 out:
 	return err;
 }
 
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

