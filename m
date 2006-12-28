Return-Path: <linux-kernel-owner+w=401wt.eu-S932900AbWL1KJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932900AbWL1KJU (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 05:09:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932897AbWL1KJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 05:09:20 -0500
Received: from il.qumranet.com ([62.219.232.206]:44566 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932935AbWL1KJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 05:09:19 -0500
Subject: [PATCH 2/8] KVM: Simplify is_long_mode()
From: Avi Kivity <avi@qumranet.com>
Date: Thu, 28 Dec 2006 10:09:17 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <45939755.7010603@qumranet.com>
In-Reply-To: <45939755.7010603@qumranet.com>
Message-Id: <20061228100917.449102500F7@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of doing tricky stuff with the arch dependent virtualization registers,
take a peek at the guest's efer.

This simlifies some code, and fixes some confusion in the mmu branch.

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/mmu.c
===================================================================
--- linux-2.6.orig/drivers/kvm/mmu.c
+++ linux-2.6/drivers/kvm/mmu.c
@@ -578,7 +578,7 @@ static int init_kvm_mmu(struct kvm_vcpu 
 
 	if (!is_paging(vcpu))
 		return nonpaging_init_context(vcpu);
-	else if (kvm_arch_ops->is_long_mode(vcpu))
+	else if (is_long_mode(vcpu))
 		return paging64_init_context(vcpu);
 	else if (is_pae(vcpu))
 		return paging32E_init_context(vcpu);
Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -398,7 +398,7 @@ void set_cr4(struct kvm_vcpu *vcpu, unsi
 		return;
 	}
 
-	if (kvm_arch_ops->is_long_mode(vcpu)) {
+	if (is_long_mode(vcpu)) {
 		if (!(cr4 & CR4_PAE_MASK)) {
 			printk(KERN_DEBUG "set_cr4: #GP, clearing PAE while "
 			       "in long mode\n");
@@ -425,7 +425,7 @@ EXPORT_SYMBOL_GPL(set_cr4);
 
 void set_cr3(struct kvm_vcpu *vcpu, unsigned long cr3)
 {
-	if (kvm_arch_ops->is_long_mode(vcpu)) {
+	if (is_long_mode(vcpu)) {
 		if ( cr3 & CR3_L_MODE_RESEVED_BITS) {
 			printk(KERN_DEBUG "set_cr3: #GP, reserved bits\n");
 			inject_gp(vcpu);
Index: linux-2.6/drivers/kvm/kvm.h
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm.h
+++ linux-2.6/drivers/kvm/kvm.h
@@ -278,7 +278,6 @@ struct kvm_arch_ops {
 			    struct kvm_segment *var, int seg);
 	void (*set_segment)(struct kvm_vcpu *vcpu,
 			    struct kvm_segment *var, int seg);
-	int (*is_long_mode)(struct kvm_vcpu *vcpu);
 	void (*get_cs_db_l_bits)(struct kvm_vcpu *vcpu, int *db, int *l);
 	void (*set_cr0)(struct kvm_vcpu *vcpu, unsigned long cr0);
 	void (*set_cr0_no_modeswitch)(struct kvm_vcpu *vcpu,
@@ -403,6 +402,15 @@ static inline struct page *_gfn_to_page(
 	return (slot) ? slot->phys_mem[gfn - slot->base_gfn] : NULL;
 }
 
+static inline int is_long_mode(struct kvm_vcpu *vcpu)
+{
+#ifdef CONFIG_X86_64
+	return vcpu->shadow_efer & EFER_LME;
+#else
+	return 0;
+#endif
+}
+
 static inline int is_pae(struct kvm_vcpu *vcpu)
 {
 	return vcpu->cr4 & CR4_PAE_MASK;
Index: linux-2.6/drivers/kvm/svm.c
===================================================================
--- linux-2.6.orig/drivers/kvm/svm.c
+++ linux-2.6/drivers/kvm/svm.c
@@ -166,11 +166,6 @@ static inline void write_dr7(unsigned lo
 	asm volatile ("mov %0, %%dr7" :: "r" (val));
 }
 
-static inline int svm_is_long_mode(struct kvm_vcpu *vcpu)
-{
-	return vcpu->svm->vmcb->save.efer & KVM_EFER_LMA;
-}
-
 static inline void force_new_asid(struct kvm_vcpu *vcpu)
 {
 	vcpu->svm->asid_generation--;
@@ -1609,7 +1604,6 @@ static struct kvm_arch_ops svm_arch_ops 
 	.get_segment_base = svm_get_segment_base,
 	.get_segment = svm_get_segment,
 	.set_segment = svm_set_segment,
-	.is_long_mode = svm_is_long_mode,
 	.get_cs_db_l_bits = svm_get_cs_db_l_bits,
 	.set_cr0 = svm_set_cr0,
 	.set_cr0_no_modeswitch = svm_set_cr0,
Index: linux-2.6/drivers/kvm/paging_tmpl.h
===================================================================
--- linux-2.6.orig/drivers/kvm/paging_tmpl.h
+++ linux-2.6/drivers/kvm/paging_tmpl.h
@@ -68,7 +68,7 @@ static void FNAME(init_walker)(struct gu
 	hpa = safe_gpa_to_hpa(vcpu, vcpu->cr3 & PT64_BASE_ADDR_MASK);
 	walker->table = kmap_atomic(pfn_to_page(hpa >> PAGE_SHIFT), KM_USER0);
 
-	ASSERT((!kvm_arch_ops->is_long_mode(vcpu) && is_pae(vcpu)) ||
+	ASSERT((!is_long_mode(vcpu) && is_pae(vcpu)) ||
 	       (vcpu->cr3 & ~(PAGE_MASK | CR3_FLAGS_MASK)) == 0);
 
 	walker->table = (pt_element_t *)( (unsigned long)walker->table |
@@ -131,7 +131,7 @@ static pt_element_t *FNAME(fetch_guest)(
 		     (walker->table[index] & PT_PAGE_SIZE_MASK) &&
 		     (PTTYPE == 64 || is_pse(vcpu))))
 			return &walker->table[index];
-		if (walker->level != 3 || kvm_arch_ops->is_long_mode(vcpu))
+		if (walker->level != 3 || is_long_mode(vcpu))
 			walker->inherited_ar &= walker->table[index];
 		paddr = safe_gpa_to_hpa(vcpu, walker->table[index] & PT_BASE_ADDR_MASK);
 		kunmap_atomic(walker->table, KM_USER0);
Index: linux-2.6/drivers/kvm/vmx.c
===================================================================
--- linux-2.6.orig/drivers/kvm/vmx.c
+++ linux-2.6/drivers/kvm/vmx.c
@@ -900,11 +900,6 @@ static void vmx_set_segment(struct kvm_v
 	vmcs_write32(sf->ar_bytes, ar);
 }
 
-static int vmx_is_long_mode(struct kvm_vcpu *vcpu)
-{
-	return vmcs_read32(VM_ENTRY_CONTROLS) & VM_ENTRY_CONTROLS_IA32E_MASK;
-}
-
 static void vmx_get_cs_db_l_bits(struct kvm_vcpu *vcpu, int *db, int *l)
 {
 	u32 ar = vmcs_read32(GUEST_CS_AR_BYTES);
@@ -1975,7 +1970,6 @@ static struct kvm_arch_ops vmx_arch_ops 
 	.get_segment_base = vmx_get_segment_base,
 	.get_segment = vmx_get_segment,
 	.set_segment = vmx_set_segment,
-	.is_long_mode = vmx_is_long_mode,
 	.get_cs_db_l_bits = vmx_get_cs_db_l_bits,
 	.set_cr0 = vmx_set_cr0,
 	.set_cr0_no_modeswitch = vmx_set_cr0_no_modeswitch,
