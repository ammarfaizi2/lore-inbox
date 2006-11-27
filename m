Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758104AbWK0Mck@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758104AbWK0Mck (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 07:32:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758132AbWK0Mck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 07:32:40 -0500
Received: from il.qumranet.com ([62.219.232.206]:29635 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1758104AbWK0Mcj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 07:32:39 -0500
Subject: [PATCH 22/38] KVM: Make inject_gp() an arch operation
From: Avi Kivity <avi@qumranet.com>
Date: Mon, 27 Nov 2006 12:32:38 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <456AD5C6.1090406@qumranet.com>
In-Reply-To: <456AD5C6.1090406@qumranet.com>
Message-Id: <20061127123238.32A9C25015E@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm.h
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm.h
+++ linux-2.6/drivers/kvm/kvm.h
@@ -284,6 +284,8 @@ struct kvm_arch_ops {
 	void (*inject_page_fault)(struct kvm_vcpu *vcpu,
 				  unsigned long addr, u32 err_code);
 
+	void (*inject_gp)(struct kvm_vcpu *vcpu, unsigned err_code);
+
 	int (*run)(struct kvm_vcpu *vcpu, struct kvm_run *run);
 	int (*vcpu_setup)(struct kvm_vcpu *vcpu);
 	void (*skip_emulated_instruction)(struct kvm_vcpu *vcpu);
@@ -345,8 +347,6 @@ void set_cr4(struct kvm_vcpu *vcpu, unsi
 void set_cr8(struct kvm_vcpu *vcpu, unsigned long cr0);
 void lmsw(struct kvm_vcpu *vcpu, unsigned long msw);
 
-void inject_gp(struct kvm_vcpu *vcpu);
-
 #ifdef __x86_64__
 void set_efer(struct kvm_vcpu *vcpu, u64 efer);
 #endif
Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -485,18 +485,10 @@ void vmcs_writel(unsigned long field, un
 }
 EXPORT_SYMBOL_GPL(vmcs_writel);
 
-void inject_gp(struct kvm_vcpu *vcpu)
+static void inject_gp(struct kvm_vcpu *vcpu)
 {
-	printk(KERN_DEBUG "inject_general_protection: rip 0x%lx\n",
-	       vmcs_readl(GUEST_RIP));
-	vmcs_write32(VM_ENTRY_EXCEPTION_ERROR_CODE, 0);
-	vmcs_write32(VM_ENTRY_INTR_INFO_FIELD,
-		     GP_VECTOR |
-		     INTR_TYPE_EXCEPTION |
-		     INTR_INFO_DELIEVER_CODE_MASK |
-		     INTR_INFO_VALID_MASK);
+	kvm_arch_ops->inject_gp(vcpu, 0);
 }
-EXPORT_SYMBOL_GPL(inject_gp);
 
 /*
  * reads and returns guest's timestamp counter "register"
Index: linux-2.6/drivers/kvm/vmx.c
===================================================================
--- linux-2.6.orig/drivers/kvm/vmx.c
+++ linux-2.6/drivers/kvm/vmx.c
@@ -80,6 +80,18 @@ static void skip_emulated_instruction(st
 			     interruptibility & ~3);
 }
 
+static void vmx_inject_gp(struct kvm_vcpu *vcpu, unsigned error_code)
+{
+	printk(KERN_DEBUG "inject_general_protection: rip 0x%lx\n",
+	       vmcs_readl(GUEST_RIP));
+	vmcs_write32(VM_ENTRY_EXCEPTION_ERROR_CODE, error_code);
+	vmcs_write32(VM_ENTRY_INTR_INFO_FIELD,
+		     GP_VECTOR |
+		     INTR_TYPE_EXCEPTION |
+		     INTR_INFO_DELIEVER_CODE_MASK |
+		     INTR_INFO_VALID_MASK);
+}
+
 static void reload_tss(void)
 {
 #ifndef __x86_64__
@@ -1318,7 +1330,7 @@ static int handle_rdmsr(struct kvm_vcpu 
 	u64 data;
 
 	if (vmx_get_msr(vcpu, ecx, &data)) {
-		inject_gp(vcpu);
+		vmx_inject_gp(vcpu, 0);
 		return 1;
 	}
 
@@ -1336,7 +1348,7 @@ static int handle_wrmsr(struct kvm_vcpu 
 		| ((u64)(vcpu->regs[VCPU_REGS_RDX] & -1u) << 32);
 
 	if (vmx_set_msr(vcpu, ecx, data) != 0) {
-		inject_gp(vcpu);
+		vmx_inject_gp(vcpu, 0);
 		return 1;
 	}
 
@@ -1682,6 +1694,8 @@ static struct kvm_arch_ops vmx_arch_ops 
 	.flush_tlb = vmx_flush_tlb,
 	.inject_page_fault = vmx_inject_page_fault,
 
+	.inject_gp = vmx_inject_gp,
+
 	.run = vmx_vcpu_run,
 	.skip_emulated_instruction = skip_emulated_instruction,
 	.vcpu_setup = vmx_vcpu_setup,
