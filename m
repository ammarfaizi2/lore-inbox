Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758098AbWK0MTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758098AbWK0MTk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 07:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758104AbWK0MTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 07:19:40 -0500
Received: from il.qumranet.com ([62.219.232.206]:34741 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1758098AbWK0MTj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 07:19:39 -0500
Subject: [PATCH 9/38] KVM: Cache guest cr4 in vcpu structure
From: Avi Kivity <avi@qumranet.com>
Date: Mon, 27 Nov 2006 12:19:37 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <456AD5C6.1090406@qumranet.com>
In-Reply-To: <456AD5C6.1090406@qumranet.com>
Message-Id: <20061127121937.601CC25015E@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This eliminates needing to have an arch operation to get cr4.

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm.h
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm.h
+++ linux-2.6/drivers/kvm/kvm.h
@@ -168,6 +168,7 @@ struct kvm_vcpu {
 
 	unsigned long cr2;
 	unsigned long cr3;
+	unsigned long cr4;
 	unsigned long cr8;
 	u64 shadow_efer;
 	u64 apic_base;
@@ -335,20 +336,14 @@ static inline int is_long_mode(void)
 	return vmcs_read32(VM_ENTRY_CONTROLS) & VM_ENTRY_CONTROLS_IA32E_MASK;
 }
 
-static inline unsigned long guest_cr4(void)
+static inline int is_pae(struct kvm_vcpu *vcpu)
 {
-	return (vmcs_readl(CR4_READ_SHADOW) & KVM_GUEST_CR4_MASK) |
-		(vmcs_readl(GUEST_CR4) & ~KVM_GUEST_CR4_MASK);
+	return vcpu->cr4 & CR4_PAE_MASK;
 }
 
-static inline int is_pae(void)
+static inline int is_pse(struct kvm_vcpu *vcpu)
 {
-	return guest_cr4() & CR4_PAE_MASK;
-}
-
-static inline int is_pse(void)
-{
-	return guest_cr4() & CR4_PSE_MASK;
+	return vcpu->cr4 & CR4_PSE_MASK;
 }
 
 static inline unsigned long guest_cr0(void)
Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -940,7 +940,7 @@ static void set_cr0(struct kvm_vcpu *vcp
 #ifdef __x86_64__
 		if ((vcpu->shadow_efer & EFER_LME)) {
 			u32 guest_cs_ar;
-			if (!is_pae()) {
+			if (!is_pae(vcpu)) {
 				printk(KERN_DEBUG "set_cr0: #GP, start paging "
 				       "in long mode while PAE is disabled\n");
 				inject_gp(vcpu);
@@ -956,7 +956,7 @@ static void set_cr0(struct kvm_vcpu *vcp
 			}
 		} else
 #endif
-		if (is_pae() &&
+		if (is_pae(vcpu) &&
 			    pdptrs_have_reserved_bits_set(vcpu, vcpu->cr3)) {
 			printk(KERN_DEBUG "set_cr0: #GP, pdptrs "
 			       "reserved bits\n");
@@ -993,6 +993,7 @@ static void __set_cr4(struct kvm_vcpu *v
 	vmcs_writel(CR4_READ_SHADOW, cr4);
 	vmcs_writel(GUEST_CR4, cr4 | (vcpu->rmode.active ?
 		    KVM_RMODE_VM_CR4_ALWAYS_ON : KVM_PMODE_VM_CR4_ALWAYS_ON));
+	vcpu->cr4 = cr4;
 }
 
 static void set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
@@ -1010,7 +1011,7 @@ static void set_cr4(struct kvm_vcpu *vcp
 			inject_gp(vcpu);
 			return;
 		}
-	} else if (is_paging() && !is_pae() && (cr4 & CR4_PAE_MASK)
+	} else if (is_paging() && !is_pae(vcpu) && (cr4 & CR4_PAE_MASK)
 		   && pdptrs_have_reserved_bits_set(vcpu, vcpu->cr3)) {
 		printk(KERN_DEBUG "set_cr4: #GP, pdptrs reserved bits\n");
 		inject_gp(vcpu);
@@ -1041,7 +1042,7 @@ static void set_cr3(struct kvm_vcpu *vcp
 			inject_gp(vcpu);
 			return;
 		}
-		if (is_paging() && is_pae() &&
+		if (is_paging() && is_pae(vcpu) &&
 		    pdptrs_have_reserved_bits_set(vcpu, cr3)) {
 			printk(KERN_DEBUG "set_cr3: #GP, pdptrs "
 			       "reserved bits\n");
@@ -1902,7 +1903,7 @@ unsigned long realmode_get_cr(struct kvm
 	case 3:
 		return vcpu->cr3;
 	case 4:
-		return guest_cr4();
+		return vcpu->cr4;
 	default:
 		vcpu_printf(vcpu, "%s: unexpected cr %u\n", __FUNCTION__, cr);
 		return 0;
@@ -1924,7 +1925,7 @@ void realmode_set_cr(struct kvm_vcpu *vc
 		set_cr3(vcpu, val);
 		break;
 	case 4:
-		set_cr4(vcpu, mk_cr_64(guest_cr4(), val));
+		set_cr4(vcpu, mk_cr_64(vcpu->cr4, val));
 		break;
 	default:
 		vcpu_printf(vcpu, "%s: unexpected cr %u\n", __FUNCTION__, cr);
@@ -2844,7 +2845,7 @@ static int kvm_dev_ioctl_get_sregs(struc
 	sregs->cr0 = guest_cr0();
 	sregs->cr2 = vcpu->cr2;
 	sregs->cr3 = vcpu->cr3;
-	sregs->cr4 = guest_cr4();
+	sregs->cr4 = vcpu->cr4;
 	sregs->cr8 = vcpu->cr8;
 	sregs->efer = vcpu->shadow_efer;
 	sregs->apic_base = vcpu->apic_base;
@@ -2912,7 +2913,7 @@ static int kvm_dev_ioctl_set_sregs(struc
 	vmcs_writel(GUEST_CR0,
 		    (sregs->cr0 & ~KVM_GUEST_CR0_MASK) | KVM_VM_CR0_ALWAYS_ON);
 
-	mmu_reset_needed |=  guest_cr4() != sregs->cr4;
+	mmu_reset_needed |= vcpu->cr4 != sregs->cr4;
 	__set_cr4(vcpu, sregs->cr4);
 
 	if (mmu_reset_needed)
Index: linux-2.6/drivers/kvm/mmu.c
===================================================================
--- linux-2.6.orig/drivers/kvm/mmu.c
+++ linux-2.6/drivers/kvm/mmu.c
@@ -564,7 +564,7 @@ static int paging64_init_context(struct 
 {
 	struct kvm_mmu *context = &vcpu->mmu;
 
-	ASSERT(is_pae());
+	ASSERT(is_pae(vcpu));
 	context->new_cr3 = paging_new_cr3;
 	context->page_fault = paging64_page_fault;
 	context->inval_page = paging_inval_page;
@@ -618,7 +618,7 @@ static int init_kvm_mmu(struct kvm_vcpu 
 		return nonpaging_init_context(vcpu);
 	else if (is_long_mode())
 		return paging64_init_context(vcpu);
-	else if (is_pae())
+	else if (is_pae(vcpu))
 		return paging32E_init_context(vcpu);
 	else
 		return paging32_init_context(vcpu);
Index: linux-2.6/drivers/kvm/paging_tmpl.h
===================================================================
--- linux-2.6.orig/drivers/kvm/paging_tmpl.h
+++ linux-2.6/drivers/kvm/paging_tmpl.h
@@ -70,7 +70,7 @@ static void FNAME(init_walker)(struct gu
 	hpa = safe_gpa_to_hpa(vcpu, vcpu->cr3 & PT64_BASE_ADDR_MASK);
 	walker->table = kmap_atomic(pfn_to_page(hpa >> PAGE_SHIFT), KM_USER0);
 
-	ASSERT((!is_long_mode() && is_pae()) ||
+	ASSERT((!is_long_mode() && is_pae(vcpu)) ||
 	       (vcpu->cr3 & ~(PAGE_MASK | CR3_FLAGS_MASK)) == 0);
 
 	walker->table = (pt_element_t *)( (unsigned long)walker->table |
@@ -133,7 +133,7 @@ static pt_element_t *FNAME(fetch_guest)(
 		    !is_present_pte(walker->table[index]) ||
 		    (walker->level == PT_DIRECTORY_LEVEL &&
 		     (walker->table[index] & PT_PAGE_SIZE_MASK) &&
-		     (PTTYPE == 64 || is_pse())))
+		     (PTTYPE == 64 || is_pse(vcpu))))
 			return &walker->table[index];
 		if (walker->level != 3 || is_long_mode())
 			walker->inherited_ar &= walker->table[index];
@@ -369,7 +369,7 @@ static gpa_t FNAME(gva_to_gpa)(struct kv
 
 	if (walker.level == PT_DIRECTORY_LEVEL) {
 		ASSERT((guest_pte & PT_PAGE_SIZE_MASK));
-		ASSERT(PTTYPE == 64 || is_pse());
+		ASSERT(PTTYPE == 64 || is_pse(vcpu));
 
 		gpa = (guest_pte & PT_DIR_BASE_ADDR_MASK) | (vaddr &
 			(PT_LEVEL_MASK(PT_PAGE_TABLE_LEVEL) | ~PAGE_MASK));
Index: linux-2.6/drivers/kvm/kvm_vmx.h
===================================================================
--- /dev/null
+++ linux-2.6/drivers/kvm/kvm_vmx.h
@@ -0,0 +1,20 @@
+#ifndef __KVM_VMX_H
+#define __KVM_VMX_H
+
+static inline void vmcs_write16(unsigned long field, u16 value)
+{
+	vmcs_writel(field, value);
+}
+
+static inline void vmcs_write64(unsigned long field, u64 value)
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
+#endif
