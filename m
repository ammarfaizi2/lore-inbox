Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758095AbWK0MUk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758095AbWK0MUk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 07:20:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758097AbWK0MUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 07:20:40 -0500
Received: from il.qumranet.com ([62.219.232.206]:35765 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1758095AbWK0MUj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 07:20:39 -0500
Subject: [PATCH 10/38] KVM: Cache guest cr0 in vcpu structure
From: Avi Kivity <avi@qumranet.com>
Date: Mon, 27 Nov 2006 12:20:37 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <456AD5C6.1090406@qumranet.com>
In-Reply-To: <456AD5C6.1090406@qumranet.com>
Message-Id: <20061127122037.78AA225015E@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This eliminates needing to have an arch operation to get cr0.

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm.h
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm.h
+++ linux-2.6/drivers/kvm/kvm.h
@@ -41,7 +41,6 @@
 	 | CR0_NW_MASK | CR0_CD_MASK)
 #define KVM_VM_CR0_ALWAYS_ON \
 	(CR0_PG_MASK | CR0_PE_MASK | CR0_WP_MASK | CR0_NE_MASK)
-
 #define KVM_GUEST_CR4_MASK \
 	(CR4_PSE_MASK | CR4_PAE_MASK | CR4_PGE_MASK | CR4_VMXE_MASK | CR4_VME_MASK)
 #define KVM_PMODE_VM_CR4_ALWAYS_ON (CR4_VMXE_MASK | CR4_PAE_MASK)
@@ -166,6 +165,7 @@ struct kvm_vcpu {
 	unsigned long regs[NR_VCPU_REGS]; /* for rsp: vcpu_load_rsp_rip() */
 	unsigned long rip;      /* needs vcpu_load_rsp_rip() */
 
+	unsigned long cr0;
 	unsigned long cr2;
 	unsigned long cr3;
 	unsigned long cr4;
@@ -346,20 +346,14 @@ static inline int is_pse(struct kvm_vcpu
 	return vcpu->cr4 & CR4_PSE_MASK;
 }
 
-static inline unsigned long guest_cr0(void)
-{
-	return (vmcs_readl(CR0_READ_SHADOW) & KVM_GUEST_CR0_MASK) |
-		(vmcs_readl(GUEST_CR0) & ~KVM_GUEST_CR0_MASK);
-}
-
 static inline unsigned guest_cpl(void)
 {
 	return vmcs_read16(GUEST_CS_SELECTOR) & SELECTOR_RPL_MASK;
 }
 
-static inline int is_paging(void)
+static inline int is_paging(struct kvm_vcpu *vcpu)
 {
-	return guest_cr0() & CR0_PG_MASK;
+	return vcpu->cr0 & CR0_PG_MASK;
 }
 
 static inline int is_page_fault(u32 intr_info)
Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -875,9 +875,9 @@ static void __set_cr0(struct kvm_vcpu *v
 
 #ifdef __x86_64__
 	if (vcpu->shadow_efer & EFER_LME) {
-		if (!is_paging() && (cr0 & CR0_PG_MASK))
+		if (!is_paging(vcpu) && (cr0 & CR0_PG_MASK))
 			enter_lmode(vcpu);
-		if (is_paging() && !(cr0 & CR0_PG_MASK))
+		if (is_paging(vcpu) && !(cr0 & CR0_PG_MASK))
 			exit_lmode(vcpu);
 	}
 #endif
@@ -885,6 +885,7 @@ static void __set_cr0(struct kvm_vcpu *v
 	vmcs_writel(CR0_READ_SHADOW, cr0);
 	vmcs_writel(GUEST_CR0,
 		    (cr0 & ~KVM_GUEST_CR0_MASK) | KVM_VM_CR0_ALWAYS_ON);
+	vcpu->cr0 = cr0;
 }
 
 static int pdptrs_have_reserved_bits_set(struct kvm_vcpu *vcpu,
@@ -918,7 +919,7 @@ static void set_cr0(struct kvm_vcpu *vcp
 {
 	if (cr0 & CR0_RESEVED_BITS) {
 		printk(KERN_DEBUG "set_cr0: 0x%lx #GP, reserved bits 0x%lx\n",
-		       cr0, guest_cr0());
+		       cr0, vcpu->cr0);
 		inject_gp(vcpu);
 		return;
 	}
@@ -936,7 +937,7 @@ static void set_cr0(struct kvm_vcpu *vcp
 		return;
 	}
 
-	if (!is_paging() && (cr0 & CR0_PG_MASK)) {
+	if (!is_paging(vcpu) && (cr0 & CR0_PG_MASK)) {
 #ifdef __x86_64__
 		if ((vcpu->shadow_efer & EFER_LME)) {
 			u32 guest_cs_ar;
@@ -975,7 +976,7 @@ static void set_cr0(struct kvm_vcpu *vcp
 
 static void lmsw(struct kvm_vcpu *vcpu, unsigned long msw)
 {
-	unsigned long cr0 = guest_cr0();
+	unsigned long cr0 = vcpu->cr0;
 
 	if ((msw & CR0_PE_MASK) && !(cr0 & CR0_PE_MASK)) {
 		enter_pmode(vcpu);
@@ -986,6 +987,7 @@ static void lmsw(struct kvm_vcpu *vcpu, 
 
 	vmcs_writel(GUEST_CR0, (vmcs_readl(GUEST_CR0) & ~LMSW_GUEST_MASK)
 				| (msw & LMSW_GUEST_MASK));
+	vcpu->cr0 = (vcpu->cr0 & ~0xfffful) | msw;
 }
 
 static void __set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
@@ -1011,7 +1013,7 @@ static void set_cr4(struct kvm_vcpu *vcp
 			inject_gp(vcpu);
 			return;
 		}
-	} else if (is_paging() && !is_pae(vcpu) && (cr4 & CR4_PAE_MASK)
+	} else if (is_paging(vcpu) && !is_pae(vcpu) && (cr4 & CR4_PAE_MASK)
 		   && pdptrs_have_reserved_bits_set(vcpu, vcpu->cr3)) {
 		printk(KERN_DEBUG "set_cr4: #GP, pdptrs reserved bits\n");
 		inject_gp(vcpu);
@@ -1042,7 +1044,7 @@ static void set_cr3(struct kvm_vcpu *vcp
 			inject_gp(vcpu);
 			return;
 		}
-		if (is_paging() && is_pae(vcpu) &&
+		if (is_paging(vcpu) && is_pae(vcpu) &&
 		    pdptrs_have_reserved_bits_set(vcpu, cr3)) {
 			printk(KERN_DEBUG "set_cr3: #GP, pdptrs "
 			       "reserved bits\n");
@@ -1897,7 +1899,7 @@ unsigned long realmode_get_cr(struct kvm
 {
 	switch (cr) {
 	case 0:
-		return guest_cr0();
+		return vcpu->cr0;
 	case 2:
 		return vcpu->cr2;
 	case 3:
@@ -1915,7 +1917,7 @@ void realmode_set_cr(struct kvm_vcpu *vc
 {
 	switch (cr) {
 	case 0:
-		set_cr0(vcpu, mk_cr_64(guest_cr0(), val));
+		set_cr0(vcpu, mk_cr_64(vcpu->cr0, val));
 		*rflags = vmcs_readl(GUEST_RFLAGS);
 		break;
 	case 2:
@@ -2264,7 +2266,8 @@ void set_efer(struct kvm_vcpu *vcpu, u64
 		return;
 	}
 
-	if (is_paging() && (vcpu->shadow_efer & EFER_LME) != (efer & EFER_LME)) {
+	if (is_paging(vcpu)
+	    && (vcpu->shadow_efer & EFER_LME) != (efer & EFER_LME)) {
 		printk(KERN_DEBUG "set_efer: #GP, change LME while paging\n");
 		inject_gp(vcpu);
 		return;
@@ -2842,7 +2845,7 @@ static int kvm_dev_ioctl_get_sregs(struc
 	get_dtable(gdt, GDTR);
 #undef get_dtable
 
-	sregs->cr0 = guest_cr0();
+	sregs->cr0 = vcpu->cr0;
 	sregs->cr2 = vcpu->cr2;
 	sregs->cr3 = vcpu->cr3;
 	sregs->cr4 = vcpu->cr4;
@@ -2906,12 +2909,13 @@ static int kvm_dev_ioctl_set_sregs(struc
 #endif
 	vcpu->apic_base = sregs->apic_base;
 
-	mmu_reset_needed |= guest_cr0() != sregs->cr0;
+	mmu_reset_needed |= vcpu->cr0 != sregs->cr0;
 	vcpu->rmode.active = ((sregs->cr0 & CR0_PE_MASK) == 0);
 	update_exception_bitmap(vcpu);
 	vmcs_writel(CR0_READ_SHADOW, sregs->cr0);
 	vmcs_writel(GUEST_CR0,
 		    (sregs->cr0 & ~KVM_GUEST_CR0_MASK) | KVM_VM_CR0_ALWAYS_ON);
+	vcpu->cr0 = sregs->cr0;
 
 	mmu_reset_needed |= vcpu->cr4 != sregs->cr4;
 	__set_cr4(vcpu, sregs->cr4);
Index: linux-2.6/drivers/kvm/mmu.c
===================================================================
--- linux-2.6.orig/drivers/kvm/mmu.c
+++ linux-2.6/drivers/kvm/mmu.c
@@ -138,9 +138,9 @@
 #define PT_DIRECTORY_LEVEL 2
 #define PT_PAGE_TABLE_LEVEL 1
 
-static int is_write_protection(void)
+static int is_write_protection(struct kvm_vcpu *vcpu)
 {
-	return guest_cr0() & CR0_WP_MASK;
+	return vcpu->cr0 & CR0_WP_MASK;
 }
 
 static int is_cpuid_PSE36(void)
@@ -321,7 +321,7 @@ static void nonpaging_flush(struct kvm_v
 	root = kvm_mmu_alloc_page(vcpu, 0);
 	ASSERT(VALID_PAGE(root));
 	vcpu->mmu.root_hpa = root;
-	if (is_paging())
+	if (is_paging(vcpu))
 		root |= (vcpu->cr3 & (CR3_PCD_MASK | CR3_WPT_MASK));
 	vmcs_writel(GUEST_CR3, root);
 }
@@ -614,7 +614,7 @@ static int init_kvm_mmu(struct kvm_vcpu 
 	ASSERT(vcpu);
 	ASSERT(!VALID_PAGE(vcpu->mmu.root_hpa));
 
-	if (!is_paging())
+	if (!is_paging(vcpu))
 		return nonpaging_init_context(vcpu);
 	else if (is_long_mode())
 		return paging64_init_context(vcpu);
Index: linux-2.6/drivers/kvm/paging_tmpl.h
===================================================================
--- linux-2.6.orig/drivers/kvm/paging_tmpl.h
+++ linux-2.6/drivers/kvm/paging_tmpl.h
@@ -251,7 +251,7 @@ static int FNAME(fix_write_pf)(struct kv
 		 * supervisor write protection is enabled.
 		 */
 		if (!writable_shadow) {
-			if (is_write_protection())
+			if (is_write_protection(vcpu))
 				return 0;
 			*shadow_ent &= ~PT_USER_MASK;
 		}
