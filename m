Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265633AbUFIHU0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265633AbUFIHU0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 03:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265661AbUFIHUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 03:20:25 -0400
Received: from mail.kroah.org ([65.200.24.183]:11471 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265633AbUFIHUU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 03:20:20 -0400
Date: Tue, 8 Jun 2004 22:45:41 -0700
From: Greg KH <greg@kroah.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Hanna Linder <hannal@us.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.6-rc2 RFT] Add's class support to cpuid.c
Message-ID: <20040609054541.GA9483@kroah.com>
References: <98460000.1086215543@dyn318071bld.beaverton.ibm.com> <40BE6CA9.9030403@zytor.com> <20040603193256.GD23564@kroah.com> <7430000.1086729016@dyn318071bld.beaverton.ibm.com> <10660000.1086732946@dyn318071bld.beaverton.ibm.com> <Pine.LNX.4.58.0406082248360.23469@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0406082248360.23469@montezuma.fsmlabs.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2004 at 10:52:09PM -0400, Zwane Mwaikambo wrote:
> My understanding is that the above removes the class for each online cpu.

Ick, good catch.  This change should fix this.  Thanks for letting me
know.

greg k-h

# cpuid: fix hotplug cpu remove bug for class device.
#
# Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>
#
diff -Nru a/arch/i386/kernel/cpuid.c b/arch/i386/kernel/cpuid.c
--- a/arch/i386/kernel/cpuid.c	2004-06-08 22:44:26 -07:00
+++ b/arch/i386/kernel/cpuid.c	2004-06-08 22:44:26 -07:00
@@ -158,35 +158,27 @@
 	.open = cpuid_open,
 };
 
-static void cpuid_class_simple_device_remove(void)
-{
-	int i = 0;
-	for_each_online_cpu(i)
-		class_simple_device_remove(MKDEV(CPUID_MAJOR, i));
-	return;
-}
-
 static int cpuid_class_simple_device_add(int i) 
 {
 	int err = 0;
 	struct class_device *class_err;
 
 	class_err = class_simple_device_add(cpuid_class, MKDEV(CPUID_MAJOR, i), NULL, "cpu%d",i);
-	if (IS_ERR(class_err)) {
+	if (IS_ERR(class_err))
 		err = PTR_ERR(class_err);
-	}
 	return err;
 }
+
 static int __devinit cpuid_class_cpu_callback(struct notifier_block *nfb, unsigned long action, void *hcpu)
 {
 	unsigned int cpu = (unsigned long)hcpu;
 
-	switch(action) {
+	switch (action) {
 	case CPU_ONLINE:
 		cpuid_class_simple_device_add(cpu);
 		break;
 	case CPU_DEAD:
-		cpuid_class_simple_device_remove();
+		class_simple_device_remove(MKDEV(CPUID_MAJOR, cpu));
 		break;
 	}
 	return NOTIFY_OK;
@@ -224,7 +216,10 @@
 	goto out;
 
 out_class:
-	cpuid_class_simple_device_remove();
+	i = 0;
+	for_each_online_cpu(i) {
+		class_simple_device_remove(MKDEV(CPUID_MAJOR, i));
+	}
 	class_simple_destroy(cpuid_class);
 out_chrdev:
 	unregister_chrdev(CPUID_MAJOR, "cpu/cpuid");	
@@ -234,7 +229,10 @@
 
 void __exit cpuid_exit(void)
 {
-	cpuid_class_simple_device_remove();
+	int cpu = 0;
+
+	for_each_online_cpu(cpu)
+		class_simple_device_remove(MKDEV(CPUID_MAJOR, cpu));
 	class_simple_destroy(cpuid_class);
 	unregister_chrdev(CPUID_MAJOR, "cpu/cpuid");
 	unregister_cpu_notifier(&cpuid_class_cpu_notifier);
