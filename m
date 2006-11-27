Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758085AbWK0MNj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758085AbWK0MNj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 07:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758087AbWK0MNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 07:13:39 -0500
Received: from il.qumranet.com ([62.219.232.206]:9170 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1758085AbWK0MNi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 07:13:38 -0500
Subject: [PATCH 3/38] KV: Make hardware detection an arch operation
From: Avi Kivity <avi@qumranet.com>
Date: Mon, 27 Nov 2006 12:13:37 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <456AD5C6.1090406@qumranet.com>
In-Reply-To: <456AD5C6.1090406@qumranet.com>
Message-Id: <20061127121337.0C9AF25017B@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm.h
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm.h
+++ linux-2.6/drivers/kvm/kvm.h
@@ -236,6 +236,8 @@ struct kvm_stat {
 };
 
 struct kvm_arch_ops {
+	int (*cpu_has_kvm_support)(void);          /* __init */
+	int (*disabled_by_bios)(void);             /* __init */
 };
 
 extern struct kvm_stat kvm_stat;
Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -527,12 +527,6 @@ static void free_vmcs(struct vmcs *vmcs)
 	free_pages((unsigned long)vmcs, vmcs_descriptor.order);
 }
 
-static __init int cpu_has_kvm_support(void)
-{
-	unsigned long ecx = cpuid_ecx(1);
-	return test_bit(5, &ecx); /* CPUID.1:ECX.VMX[bit 5] -> VT */
-}
-
 static __exit void free_kvm_area(void)
 {
 	int cpu;
@@ -559,14 +553,6 @@ static __init int alloc_kvm_area(void)
 	return 0;
 }
 
-static __init int vmx_disabled_by_bios(void)
-{
-	u64 msr;
-
-	rdmsrl(MSR_IA32_FEATURE_CONTROL, msr);
-	return (msr & 5) == 1; /* locked but not enabled */
-}
-
 static __init void kvm_enable(void *garbage)
 {
 	int cpu = raw_smp_processor_id();
@@ -3616,6 +3602,16 @@ int kvm_init_arch(struct kvm_arch_ops *o
 	int r;
 
 	kvm_arch_ops = ops;
+
+	if (!kvm_arch_ops->cpu_has_kvm_support()) {
+		printk(KERN_ERR "kvm: no hardware support\n");
+		return -EOPNOTSUPP;
+	}
+	if (kvm_arch_ops->disabled_by_bios()) {
+		printk(KERN_ERR "kvm: disabled by bios\n");
+		return -EOPNOTSUPP;
+	}
+
 	kvm_chardev_ops.owner = module;
 
 	r = misc_register(&kvm_dev);
@@ -3638,15 +3634,6 @@ static __init int kvm_init(void)
 	static struct page *bad_page;
 	int r = 0;
 
-	if (!cpu_has_kvm_support()) {
-		printk(KERN_ERR "kvm: no hardware support\n");
-		return -EOPNOTSUPP;
-	}
-	if (vmx_disabled_by_bios()) {
-		printk(KERN_ERR "kvm: disabled by bios\n");
-		return -EOPNOTSUPP;
-	}
-
 	kvm_init_debug();
 
 	setup_vmcs_descriptor();
Index: linux-2.6/drivers/kvm/vmx.c
===================================================================
--- linux-2.6.orig/drivers/kvm/vmx.c
+++ linux-2.6/drivers/kvm/vmx.c
@@ -18,10 +18,28 @@
 #include "kvm.h"
 #include <linux/module.h>
 
+#define MSR_IA32_FEATURE_CONTROL 		0x03a
+
 MODULE_AUTHOR("Qumranet");
 MODULE_LICENSE("GPL");
 
+static __init int cpu_has_kvm_support(void)
+{
+	unsigned long ecx = cpuid_ecx(1);
+	return test_bit(5, &ecx); /* CPUID.1:ECX.VMX[bit 5] -> VT */
+}
+
+static __init int vmx_disabled_by_bios(void)
+{
+	u64 msr;
+
+	rdmsrl(MSR_IA32_FEATURE_CONTROL, msr);
+	return (msr & 5) == 1; /* locked but not enabled */
+}
+
 static struct kvm_arch_ops vmx_arch_ops = {
+	.cpu_has_kvm_support = cpu_has_kvm_support,
+	.disabled_by_bios = vmx_disabled_by_bios,
 };
 
 static int __init vmx_init(void)
