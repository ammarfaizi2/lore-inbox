Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265024AbUFVRxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265024AbUFVRxX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 13:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265095AbUFVRwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 13:52:35 -0400
Received: from mail.kroah.org ([65.200.24.183]:54709 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265093AbUFVRnp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 13:43:45 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.7
In-Reply-To: <1087926110510@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Tue, 22 Jun 2004 10:41:51 -0700
Message-Id: <10879261111349@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1722.89.58, 2004/06/08 22:45:12-07:00, greg@kroah.com

cpuid: fix hotplug cpu remove bug for class device.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 arch/i386/kernel/cpuid.c |   26 ++++++++++++--------------
 1 files changed, 12 insertions(+), 14 deletions(-)


diff -Nru a/arch/i386/kernel/cpuid.c b/arch/i386/kernel/cpuid.c
--- a/arch/i386/kernel/cpuid.c	Tue Jun 22 09:47:34 2004
+++ b/arch/i386/kernel/cpuid.c	Tue Jun 22 09:47:34 2004
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

