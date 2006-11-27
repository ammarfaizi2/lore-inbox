Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758129AbWK0Mak@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758129AbWK0Mak (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 07:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758130AbWK0Mak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 07:30:40 -0500
Received: from il.qumranet.com ([62.219.232.206]:32137 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1758129AbWK0Maj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 07:30:39 -0500
Subject: [PATCH 20/38] KVM: Make set_cr3() and tlb flushing arch operations
From: Avi Kivity <avi@qumranet.com>
Date: Mon, 27 Nov 2006 12:30:38 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <456AD5C6.1090406@qumranet.com>
In-Reply-To: <456AD5C6.1090406@qumranet.com>
Message-Id: <20061127123038.11F3A25015E@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm.h
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm.h
+++ linux-2.6/drivers/kvm/kvm.h
@@ -270,6 +270,7 @@ struct kvm_arch_ops {
 	void (*set_segment)(struct kvm_vcpu *vcpu,
 			    struct kvm_segment *var, int seg);
 	void (*set_cr0)(struct kvm_vcpu *vcpu, unsigned long cr0);
+	void (*set_cr3)(struct kvm_vcpu *vcpu, unsigned long cr3);
 	void (*set_cr4)(struct kvm_vcpu *vcpu, unsigned long cr4);
 	void (*set_efer)(struct kvm_vcpu *vcpu, u64 efer);
 	void (*get_idt)(struct kvm_vcpu *vcpu, struct descriptor_table *dt);
@@ -279,6 +280,8 @@ struct kvm_arch_ops {
 	void (*cache_regs)(struct kvm_vcpu *vcpu);
 	void (*decache_regs)(struct kvm_vcpu *vcpu);
 
+	void (*flush_tlb)(struct kvm_vcpu *vcpu);
+
 	int (*run)(struct kvm_vcpu *vcpu, struct kvm_run *run);
 	int (*vcpu_setup)(struct kvm_vcpu *vcpu);
 	void (*skip_emulated_instruction)(struct kvm_vcpu *vcpu);
Index: linux-2.6/drivers/kvm/mmu.c
===================================================================
--- linux-2.6.orig/drivers/kvm/mmu.c
+++ linux-2.6/drivers/kvm/mmu.c
@@ -323,7 +323,7 @@ static void nonpaging_flush(struct kvm_v
 	vcpu->mmu.root_hpa = root;
 	if (is_paging(vcpu))
 		root |= (vcpu->cr3 & (CR3_PCD_MASK | CR3_WPT_MASK));
-	vmcs_writel(GUEST_CR3, root);
+	kvm_arch_ops->set_cr3(vcpu, root);
 }
 
 static gpa_t nonpaging_gva_to_gpa(struct kvm_vcpu *vcpu, gva_t vaddr)
@@ -386,7 +386,7 @@ static int nonpaging_init_context(struct
 	context->shadow_root_level = PT32E_ROOT_LEVEL;
 	context->root_hpa = kvm_mmu_alloc_page(vcpu, 0);
 	ASSERT(VALID_PAGE(context->root_hpa));
-	vmcs_writel(GUEST_CR3, context->root_hpa);
+	kvm_arch_ops->set_cr3(vcpu, context->root_hpa);
 	return 0;
 }
 
@@ -539,9 +539,7 @@ static void paging_inval_page(struct kvm
 			table[index] = 0;
 			release_pt_page_64(vcpu, page_addr, PT_PAGE_TABLE_LEVEL);
 
-			//flush tlb
-			vmcs_writel(GUEST_CR3, vcpu->mmu.root_hpa |
-				    (vcpu->cr3 & (CR3_PCD_MASK | CR3_WPT_MASK)));
+			kvm_arch_ops->flush_tlb(vcpu);
 			return;
 		}
 	}
@@ -574,7 +572,7 @@ static int paging64_init_context(struct 
 	context->shadow_root_level = PT64_ROOT_LEVEL;
 	context->root_hpa = kvm_mmu_alloc_page(vcpu, 0);
 	ASSERT(VALID_PAGE(context->root_hpa));
-	vmcs_writel(GUEST_CR3, context->root_hpa |
+	kvm_arch_ops->set_cr3(vcpu, context->root_hpa |
 		    (vcpu->cr3 & (CR3_PCD_MASK | CR3_WPT_MASK)));
 	return 0;
 }
@@ -592,7 +590,7 @@ static int paging32_init_context(struct 
 	context->shadow_root_level = PT32E_ROOT_LEVEL;
 	context->root_hpa = kvm_mmu_alloc_page(vcpu, 0);
 	ASSERT(VALID_PAGE(context->root_hpa));
-	vmcs_writel(GUEST_CR3, context->root_hpa |
+	kvm_arch_ops->set_cr3(vcpu, context->root_hpa |
 		    (vcpu->cr3 & (CR3_PCD_MASK | CR3_WPT_MASK)));
 	return 0;
 }
Index: linux-2.6/drivers/kvm/vmx.c
===================================================================
--- linux-2.6.orig/drivers/kvm/vmx.c
+++ linux-2.6/drivers/kvm/vmx.c
@@ -545,6 +545,11 @@ static void vmx_set_cr0(struct kvm_vcpu 
 	vcpu->cr0 = cr0;
 }
 
+static void vmx_set_cr3(struct kvm_vcpu *vcpu, unsigned long cr3)
+{
+	vmcs_writel(GUEST_CR3, cr3);
+}
+
 static void vmx_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
 {
 	vmcs_writel(CR4_READ_SHADOW, cr4);
@@ -1614,6 +1619,11 @@ again:
 	return 0;
 }
 
+static void vmx_flush_tlb(struct kvm_vcpu *vcpu)
+{
+	vmcs_writel(GUEST_CR3, vmcs_readl(GUEST_CR3));
+}
+
 static struct kvm_arch_ops vmx_arch_ops = {
 	.cpu_has_kvm_support = cpu_has_kvm_support,
 	.disabled_by_bios = vmx_disabled_by_bios,
@@ -1629,6 +1639,7 @@ static struct kvm_arch_ops vmx_arch_ops 
 	.get_segment = vmx_get_segment,
 	.set_segment = vmx_set_segment,
 	.set_cr0 = vmx_set_cr0,
+	.set_cr3 = vmx_set_cr3,
 	.set_cr4 = vmx_set_cr4,
 	.set_efer = vmx_set_efer,
 	.get_idt = vmx_get_idt,
@@ -1638,6 +1649,8 @@ static struct kvm_arch_ops vmx_arch_ops 
 	.cache_regs = vcpu_load_rsp_rip,
 	.decache_regs = vcpu_put_rsp_rip,
 
+	.flush_tlb = vmx_flush_tlb,
+
 	.run = vmx_vcpu_run,
 	.skip_emulated_instruction = skip_emulated_instruction,
 	.vcpu_setup = vmx_vcpu_setup,
