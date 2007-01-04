Return-Path: <linux-kernel-owner+w=401wt.eu-S964978AbXADQHM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964978AbXADQHM (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 11:07:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964981AbXADQHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 11:07:11 -0500
Received: from il.qumranet.com ([62.219.232.206]:47306 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964978AbXADQHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 11:07:09 -0500
Subject: [PATCH 18/33] KVM: MMU: Remove invlpg interception
From: Avi Kivity <avi@qumranet.com>
Date: Thu, 04 Jan 2007 16:07:07 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <459D21DD.5090506@qumranet.com>
In-Reply-To: <459D21DD.5090506@qumranet.com>
Message-Id: <20070104160707.161C5250048@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since we write protect shadowed guest page tables, there is no need to
trap page invalidations (the guest will always change the mapping before
issuing the invlpg instruction).

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/mmu.c
===================================================================
--- linux-2.6.orig/drivers/kvm/mmu.c
+++ linux-2.6/drivers/kvm/mmu.c
@@ -767,10 +767,6 @@ static int nonpaging_page_fault(struct k
 	return nonpaging_map(vcpu, addr & PAGE_MASK, paddr);
 }
 
-static void nonpaging_inval_page(struct kvm_vcpu *vcpu, gva_t addr)
-{
-}
-
 static void nonpaging_free(struct kvm_vcpu *vcpu)
 {
 	mmu_free_roots(vcpu);
@@ -782,7 +778,6 @@ static int nonpaging_init_context(struct
 
 	context->new_cr3 = nonpaging_new_cr3;
 	context->page_fault = nonpaging_page_fault;
-	context->inval_page = nonpaging_inval_page;
 	context->gva_to_gpa = nonpaging_gva_to_gpa;
 	context->free = nonpaging_free;
 	context->root_level = 0;
@@ -895,42 +890,6 @@ static int may_access(u64 pte, int write
 	return 1;
 }
 
-/*
- * Remove a shadow pte.
- */
-static void paging_inval_page(struct kvm_vcpu *vcpu, gva_t addr)
-{
-	hpa_t page_addr = vcpu->mmu.root_hpa;
-	int level = vcpu->mmu.shadow_root_level;
-
-	++kvm_stat.invlpg;
-
-	for (; ; level--) {
-		u32 index = PT64_INDEX(addr, level);
-		u64 *table = __va(page_addr);
-
-		if (level == PT_PAGE_TABLE_LEVEL ) {
-			rmap_remove(vcpu->kvm, &table[index]);
-			table[index] = 0;
-			return;
-		}
-
-		if (!is_present_pte(table[index]))
-			return;
-
-		page_addr = table[index] & PT64_BASE_ADDR_MASK;
-
-		if (level == PT_DIRECTORY_LEVEL &&
-			  (table[index] & PT_SHADOW_PS_MARK)) {
-			table[index] = 0;
-			release_pt_page_64(vcpu, page_addr, PT_PAGE_TABLE_LEVEL);
-
-			kvm_arch_ops->tlb_flush(vcpu);
-			return;
-		}
-	}
-}
-
 static void paging_free(struct kvm_vcpu *vcpu)
 {
 	nonpaging_free(vcpu);
@@ -951,7 +910,6 @@ static int paging64_init_context_common(
 	ASSERT(is_pae(vcpu));
 	context->new_cr3 = paging_new_cr3;
 	context->page_fault = paging64_page_fault;
-	context->inval_page = paging_inval_page;
 	context->gva_to_gpa = paging64_gva_to_gpa;
 	context->free = paging_free;
 	context->root_level = level;
@@ -974,7 +932,6 @@ static int paging32_init_context(struct 
 
 	context->new_cr3 = paging_new_cr3;
 	context->page_fault = paging32_page_fault;
-	context->inval_page = paging_inval_page;
 	context->gva_to_gpa = paging32_gva_to_gpa;
 	context->free = paging_free;
 	context->root_level = PT32_ROOT_LEVEL;
Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -943,10 +943,6 @@ static unsigned long get_segment_base(st
 
 int emulate_invlpg(struct kvm_vcpu *vcpu, gva_t address)
 {
-	spin_lock(&vcpu->kvm->lock);
-	vcpu->mmu.inval_page(vcpu, address);
-	spin_unlock(&vcpu->kvm->lock);
-	kvm_arch_ops->invlpg(vcpu, address);
 	return X86EMUL_CONTINUE;
 }
 
Index: linux-2.6/drivers/kvm/kvm.h
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm.h
+++ linux-2.6/drivers/kvm/kvm.h
@@ -158,7 +158,6 @@ struct kvm_vcpu;
 struct kvm_mmu {
 	void (*new_cr3)(struct kvm_vcpu *vcpu);
 	int (*page_fault)(struct kvm_vcpu *vcpu, gva_t gva, u32 err);
-	void (*inval_page)(struct kvm_vcpu *vcpu, gva_t gva);
 	void (*free)(struct kvm_vcpu *vcpu);
 	gpa_t (*gva_to_gpa)(struct kvm_vcpu *vcpu, gva_t gva);
 	hpa_t root_hpa;
Index: linux-2.6/drivers/kvm/svm.c
===================================================================
--- linux-2.6.orig/drivers/kvm/svm.c
+++ linux-2.6/drivers/kvm/svm.c
@@ -497,7 +497,6 @@ static void init_vmcb(struct vmcb *vmcb)
 		/*              (1ULL << INTERCEPT_SELECTIVE_CR0) | */
 				(1ULL << INTERCEPT_CPUID) |
 				(1ULL << INTERCEPT_HLT) |
-				(1ULL << INTERCEPT_INVLPG) |
 				(1ULL << INTERCEPT_INVLPGA) |
 				(1ULL << INTERCEPT_IOIO_PROT) |
 				(1ULL << INTERCEPT_MSR_PROT) |
Index: linux-2.6/drivers/kvm/vmx.c
===================================================================
--- linux-2.6.orig/drivers/kvm/vmx.c
+++ linux-2.6/drivers/kvm/vmx.c
@@ -1059,7 +1059,6 @@ static int vmx_vcpu_setup(struct kvm_vcp
 			       | CPU_BASED_CR8_LOAD_EXITING    /* 20.6.2 */
 			       | CPU_BASED_CR8_STORE_EXITING   /* 20.6.2 */
 			       | CPU_BASED_UNCOND_IO_EXITING   /* 20.6.2 */
-			       | CPU_BASED_INVDPG_EXITING
 			       | CPU_BASED_MOV_DR_EXITING
 			       | CPU_BASED_USE_TSC_OFFSETING   /* 21.3 */
 			);
@@ -1438,17 +1437,6 @@ static int handle_io(struct kvm_vcpu *vc
 	return 0;
 }
 
-static int handle_invlpg(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
-{
-	u64 address = vmcs_read64(EXIT_QUALIFICATION);
-	int instruction_length = vmcs_read32(VM_EXIT_INSTRUCTION_LEN);
-	spin_lock(&vcpu->kvm->lock);
-	vcpu->mmu.inval_page(vcpu, address);
-	spin_unlock(&vcpu->kvm->lock);
-	vmcs_writel(GUEST_RIP, vmcs_readl(GUEST_RIP) + instruction_length);
-	return 1;
-}
-
 static int handle_cr(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 {
 	u64 exit_qualification;
@@ -1636,7 +1624,6 @@ static int (*kvm_vmx_exit_handlers[])(st
 	[EXIT_REASON_EXCEPTION_NMI]           = handle_exception,
 	[EXIT_REASON_EXTERNAL_INTERRUPT]      = handle_external_interrupt,
 	[EXIT_REASON_IO_INSTRUCTION]          = handle_io,
-	[EXIT_REASON_INVLPG]                  = handle_invlpg,
 	[EXIT_REASON_CR_ACCESS]               = handle_cr,
 	[EXIT_REASON_DR_ACCESS]               = handle_dr,
 	[EXIT_REASON_CPUID]                   = handle_cpuid,
