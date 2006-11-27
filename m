Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758084AbWK0MLj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758084AbWK0MLj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 07:11:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758083AbWK0MLj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 07:11:39 -0500
Received: from il.qumranet.com ([62.219.232.206]:5842 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1758084AbWK0MLi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 07:11:38 -0500
Subject: [PATCH 1/38] KVM: Create kvm-intel.ko module
From: Avi Kivity <avi@qumranet.com>
Date: Mon, 27 Nov 2006 12:11:36 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <456AD5C6.1090406@qumranet.com>
In-Reply-To: <456AD5C6.1090406@qumranet.com>
Message-Id: <20061127121136.DC69A25015E@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch lays the foundation for arch-independent kvm:  it creates the
kvm-intel.ko module and prepares an arch function vector for the arch-specific
implementation.

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm.h
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm.h
+++ linux-2.6/drivers/kvm/kvm.h
@@ -235,11 +235,18 @@ struct kvm_stat {
 	u32 irq_exits;
 };
 
+struct kvm_arch_ops {
+};
+
 extern struct kvm_stat kvm_stat;
+extern struct kvm_arch_ops *kvm_arch_ops;
 
 #define kvm_printf(kvm, fmt ...) printk(KERN_DEBUG fmt)
 #define vcpu_printf(vcpu, fmt...) kvm_printf(vcpu->kvm, fmt)
 
+void kvm_init_arch(struct kvm_arch_ops *ops);
+void kvm_exit_arch(void);
+
 void kvm_mmu_destroy(struct kvm_vcpu *vcpu);
 int kvm_mmu_init(struct kvm_vcpu *vcpu);
 
Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -41,6 +41,7 @@
 MODULE_AUTHOR("Qumranet");
 MODULE_LICENSE("GPL");
 
+struct kvm_arch_ops *kvm_arch_ops;
 struct kvm_stat kvm_stat;
 
 static struct kvm_stats_debugfs_item {
@@ -3611,6 +3612,15 @@ static void kvm_exit_debug(void)
 
 hpa_t bad_page_address;
 
+void kvm_init_arch(struct kvm_arch_ops *ops)
+{
+	kvm_arch_ops = ops;
+}
+
+void kvm_exit_arch(void)
+{
+}
+
 static __init int kvm_init(void)
 {
 	static struct page *bad_page;
@@ -3670,3 +3680,6 @@ static __exit void kvm_exit(void)
 
 module_init(kvm_init)
 module_exit(kvm_exit)
+
+EXPORT_SYMBOL_GPL(kvm_init_arch);
+EXPORT_SYMBOL_GPL(kvm_exit_arch);
Index: linux-2.6/drivers/kvm/vmx.c
===================================================================
--- /dev/null
+++ linux-2.6/drivers/kvm/vmx.c
@@ -0,0 +1,39 @@
+/*
+ * Kernel-based Virtual Machine driver for Linux
+ *
+ * This module enables machines with Intel VT-x extensions to run virtual
+ * machines without emulation or binary translation.
+ *
+ * Copyright (C) 2006 Qumranet, Inc.
+ *
+ * Authors:
+ *   Avi Kivity   <avi@qumranet.com>
+ *   Yaniv Kamay  <yaniv@qumranet.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ */
+
+#include "kvm.h"
+#include <linux/module.h>
+
+MODULE_AUTHOR("Qumranet");
+MODULE_LICENSE("GPL");
+
+static struct kvm_arch_ops vmx_arch_ops = {
+};
+
+static int __init vmx_init(void)
+{
+	kvm_init_arch(&vmx_arch_ops);
+	return 0;
+}
+
+static void __exit vmx_exit(void)
+{
+	kvm_exit_arch();
+}
+
+module_init(vmx_init)
+module_exit(vmx_exit)
Index: linux-2.6/drivers/kvm/Kconfig
===================================================================
--- linux-2.6.orig/drivers/kvm/Kconfig
+++ linux-2.6/drivers/kvm/Kconfig
@@ -6,8 +6,9 @@ config KVM
 	depends on X86 && EXPERIMENTAL
 	---help---
 	  Support hosting fully virtualized guest machines using hardware
-	  virtualization extensions.  You will need a fairly recent Intel
-	  processor equipped with VT extensions.
+	  virtualization extensions.  You will need a fairly recent
+	  processor equipped with virtualization extensions. You will also
+	  need to select one or more of the processor modules below.
 
 	  This module provides access to the hardware capabilities through
 	  a character device node named /dev/kvm.
@@ -16,3 +17,10 @@ config KVM
 	  will be called kvm.
 
 	  If unsure, say N.
+
+config KVM_INTEL
+	tristate "KVM for Intel processors support"
+	depends on KVM
+	---help---
+	  Provides support for KVM on Intel processors equipped with the VT
+	  extensions.
Index: linux-2.6/drivers/kvm/Makefile
===================================================================
--- linux-2.6.orig/drivers/kvm/Makefile
+++ linux-2.6/drivers/kvm/Makefile
@@ -4,3 +4,5 @@
 
 kvm-objs := kvm_main.o mmu.o x86_emulate.o
 obj-$(CONFIG_KVM) += kvm.o
+kvm-intel-objs = vmx.o
+obj-$(CONFIG_KVM_INTEL) += kvm-intel.o
