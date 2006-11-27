Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758133AbWK0Mbk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758133AbWK0Mbk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 07:31:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758104AbWK0Mbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 07:31:40 -0500
Received: from il.qumranet.com ([62.219.232.206]:28611 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1758133AbWK0Mbj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 07:31:39 -0500
Subject: [PATCH 21/38] KVM: Make inject_page_fault() an arch operation
From: Avi Kivity <avi@qumranet.com>
Date: Mon, 27 Nov 2006 12:31:38 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <456AD5C6.1090406@qumranet.com>
In-Reply-To: <456AD5C6.1090406@qumranet.com>
Message-Id: <20061127123138.22EE925015E@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm.h
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm.h
+++ linux-2.6/drivers/kvm/kvm.h
@@ -281,6 +281,8 @@ struct kvm_arch_ops {
 	void (*decache_regs)(struct kvm_vcpu *vcpu);
 
 	void (*flush_tlb)(struct kvm_vcpu *vcpu);
+	void (*inject_page_fault)(struct kvm_vcpu *vcpu,
+				  unsigned long addr, u32 err_code);
 
 	int (*run)(struct kvm_vcpu *vcpu, struct kvm_run *run);
 	int (*vcpu_setup)(struct kvm_vcpu *vcpu);
Index: linux-2.6/drivers/kvm/mmu.c
===================================================================
--- linux-2.6.orig/drivers/kvm/mmu.c
+++ linux-2.6/drivers/kvm/mmu.c
@@ -455,32 +455,7 @@ static void inject_page_fault(struct kvm
 			      u64 addr,
 			      u32 err_code)
 {
-	u32 vect_info = vmcs_read32(IDT_VECTORING_INFO_FIELD);
-
-	pgprintk("inject_page_fault: 0x%llx err 0x%x\n", addr, err_code);
-
-	++kvm_stat.pf_guest;
-
-	if (is_page_fault(vect_info)) {
-		printk(KERN_DEBUG "inject_page_fault: "
-		       "double fault 0x%llx @ 0x%lx\n",
-		       addr, vmcs_readl(GUEST_RIP));
-		vmcs_write32(VM_ENTRY_EXCEPTION_ERROR_CODE, 0);
-		vmcs_write32(VM_ENTRY_INTR_INFO_FIELD,
-			     DF_VECTOR |
-			     INTR_TYPE_EXCEPTION |
-			     INTR_INFO_DELIEVER_CODE_MASK |
-			     INTR_INFO_VALID_MASK);
-		return;
-	}
-	vcpu->cr2 = addr;
-	vmcs_write32(VM_ENTRY_EXCEPTION_ERROR_CODE, err_code);
-	vmcs_write32(VM_ENTRY_INTR_INFO_FIELD,
-		     PF_VECTOR |
-		     INTR_TYPE_EXCEPTION |
-		     INTR_INFO_DELIEVER_CODE_MASK |
-		     INTR_INFO_VALID_MASK);
-
+	kvm_arch_ops->inject_page_fault(vcpu, addr, err_code);
 }
 
 static inline int fix_read_pf(u64 *shadow_ent)
Index: linux-2.6/drivers/kvm/vmx.c
===================================================================
--- linux-2.6.orig/drivers/kvm/vmx.c
+++ linux-2.6/drivers/kvm/vmx.c
@@ -1624,6 +1624,36 @@ static void vmx_flush_tlb(struct kvm_vcp
 	vmcs_writel(GUEST_CR3, vmcs_readl(GUEST_CR3));
 }
 
+static void vmx_inject_page_fault(struct kvm_vcpu *vcpu,
+				  unsigned long addr,
+				  u32 err_code)
+{
+	u32 vect_info = vmcs_read32(IDT_VECTORING_INFO_FIELD);
+
+	++kvm_stat.pf_guest;
+
+	if (is_page_fault(vect_info)) {
+		printk(KERN_DEBUG "inject_page_fault: "
+		       "double fault 0x%lx @ 0x%lx\n",
+		       addr, vmcs_readl(GUEST_RIP));
+		vmcs_write32(VM_ENTRY_EXCEPTION_ERROR_CODE, 0);
+		vmcs_write32(VM_ENTRY_INTR_INFO_FIELD,
+			     DF_VECTOR |
+			     INTR_TYPE_EXCEPTION |
+			     INTR_INFO_DELIEVER_CODE_MASK |
+			     INTR_INFO_VALID_MASK);
+		return;
+	}
+	vcpu->cr2 = addr;
+	vmcs_write32(VM_ENTRY_EXCEPTION_ERROR_CODE, err_code);
+	vmcs_write32(VM_ENTRY_INTR_INFO_FIELD,
+		     PF_VECTOR |
+		     INTR_TYPE_EXCEPTION |
+		     INTR_INFO_DELIEVER_CODE_MASK |
+		     INTR_INFO_VALID_MASK);
+
+}
+
 static struct kvm_arch_ops vmx_arch_ops = {
 	.cpu_has_kvm_support = cpu_has_kvm_support,
 	.disabled_by_bios = vmx_disabled_by_bios,
@@ -1650,6 +1680,7 @@ static struct kvm_arch_ops vmx_arch_ops 
 	.decache_regs = vcpu_put_rsp_rip,
 
 	.flush_tlb = vmx_flush_tlb,
+	.inject_page_fault = vmx_inject_page_fault,
 
 	.run = vmx_vcpu_run,
 	.skip_emulated_instruction = skip_emulated_instruction,
