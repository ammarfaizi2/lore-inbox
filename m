Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758160AbWK0Mql@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758160AbWK0Mql (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 07:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758158AbWK0Mql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 07:46:41 -0500
Received: from il.qumranet.com ([62.219.232.206]:32387 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1758161AbWK0Mqk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 07:46:40 -0500
Subject: [PATCH 36/38] KVM: Move vmcs accessors to vmx.c
From: Avi Kivity <avi@qumranet.com>
Date: Mon, 27 Nov 2006 12:46:38 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <456AD5C6.1090406@qumranet.com>
In-Reply-To: <456AD5C6.1090406@qumranet.com>
Message-Id: <20061127124638.F2BBC25015E@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm.h
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm.h
+++ linux-2.6/drivers/kvm/kvm.h
@@ -377,9 +377,6 @@ int kvm_write_guest(struct kvm_vcpu *vcp
 		unsigned long size,
 		void *data);
 
-void vmcs_writel(unsigned long field, unsigned long value);
-unsigned long vmcs_readl(unsigned long field);
-
 unsigned long segment_base(u16 selector);
 
 static inline struct page *_gfn_to_page(struct kvm *kvm, gfn_t gfn)
@@ -388,30 +385,6 @@ static inline struct page *_gfn_to_page(
 	return (slot) ? slot->phys_mem[gfn - slot->base_gfn] : 0;
 }
 
-static inline u16 vmcs_read16(unsigned long field)
-{
-	return vmcs_readl(field);
-}
-
-static inline u32 vmcs_read32(unsigned long field)
-{
-	return vmcs_readl(field);
-}
-
-static inline u64 vmcs_read64(unsigned long field)
-{
-#ifdef __x86_64__
-	return vmcs_readl(field);
-#else
-	return vmcs_readl(field) | ((u64)vmcs_readl(field+1) << 32);
-#endif
-}
-
-static inline void vmcs_write32(unsigned long field, u32 value)
-{
-	vmcs_writel(field, value);
-}
-
 static inline int is_pae(struct kvm_vcpu *vcpu)
 {
 	return vcpu->cr4 & CR4_PAE_MASK;
Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -310,28 +310,6 @@ static int kvm_dev_release(struct inode 
 	return 0;
 }
 
-unsigned long vmcs_readl(unsigned long field)
-{
-	unsigned long value;
-
-	asm volatile (ASM_VMX_VMREAD_RDX_RAX
-		      : "=a"(value) : "d"(field) : "cc");
-	return value;
-}
-EXPORT_SYMBOL_GPL(vmcs_readl);
-
-void vmcs_writel(unsigned long field, unsigned long value)
-{
-	u8 error;
-
-	asm volatile (ASM_VMX_VMWRITE_RAX_RDX "; setna %0"
-		       : "=q"(error) : "a"(value), "d"(field) : "cc" );
-	if (error)
-		printk(KERN_ERR "vmwrite error: reg %lx value %lx (err %d)\n",
-		       field, value, vmcs_read32(VM_INSTRUCTION_ERROR));
-}
-EXPORT_SYMBOL_GPL(vmcs_writel);
-
 static void inject_gp(struct kvm_vcpu *vcpu)
 {
 	kvm_arch_ops->inject_gp(vcpu, 0);
Index: linux-2.6/drivers/kvm/kvm_vmx.h
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_vmx.h
+++ linux-2.6/drivers/kvm/kvm_vmx.h
@@ -1,22 +1,6 @@
 #ifndef __KVM_VMX_H
 #define __KVM_VMX_H
 
-static inline void vmcs_write16(unsigned long field, u16 value)
-{
-	vmcs_writel(field, value);
-}
-
-static inline void vmcs_write64(unsigned long field, u64 value)
-{
-#ifdef __x86_64__
-	vmcs_writel(field, value);
-#else
-	vmcs_writel(field, value);
-	asm volatile ("");
-	vmcs_writel(field+1, value >> 32);
-#endif
-}
-
 #ifdef __x86_64__
 /*
  * avoid save/load MSR_SYSCALL_MASK and MSR_LSTAR by std vt
Index: linux-2.6/drivers/kvm/vmx.c
===================================================================
--- linux-2.6.orig/drivers/kvm/vmx.c
+++ linux-2.6/drivers/kvm/vmx.c
@@ -101,6 +101,66 @@ static void __vcpu_clear(void *arg)
 		per_cpu(current_vmcs, cpu) = 0;
 }
 
+static unsigned long vmcs_readl(unsigned long field)
+{
+	unsigned long value;
+
+	asm volatile (ASM_VMX_VMREAD_RDX_RAX
+		      : "=a"(value) : "d"(field) : "cc");
+	return value;
+}
+
+static u16 vmcs_read16(unsigned long field)
+{
+	return vmcs_readl(field);
+}
+
+static u32 vmcs_read32(unsigned long field)
+{
+	return vmcs_readl(field);
+}
+
+static u64 vmcs_read64(unsigned long field)
+{
+#ifdef __x86_64__
+	return vmcs_readl(field);
+#else
+	return vmcs_readl(field) | ((u64)vmcs_readl(field+1) << 32);
+#endif
+}
+
+static void vmcs_writel(unsigned long field, unsigned long value)
+{
+	u8 error;
+
+	asm volatile (ASM_VMX_VMWRITE_RAX_RDX "; setna %0"
+		       : "=q"(error) : "a"(value), "d"(field) : "cc" );
+	if (error)
+		printk(KERN_ERR "vmwrite error: reg %lx value %lx (err %d)\n",
+		       field, value, vmcs_read32(VM_INSTRUCTION_ERROR));
+}
+
+static void vmcs_write16(unsigned long field, u16 value)
+{
+	vmcs_writel(field, value);
+}
+
+static void vmcs_write32(unsigned long field, u32 value)
+{
+	vmcs_writel(field, value);
+}
+
+static void vmcs_write64(unsigned long field, u64 value)
+{
+#ifdef __x86_64__
+	vmcs_writel(field, value);
+#else
+	vmcs_writel(field, value);
+	asm volatile ("");
+	vmcs_writel(field+1, value >> 32);
+#endif
+}
+
 /*
  * Switches to specified vcpu, until a matching vcpu_put(), but assumes
  * vcpu mutex is already taken.
