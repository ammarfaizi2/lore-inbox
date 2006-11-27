Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758114AbWK0M1l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758114AbWK0M1l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 07:27:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758116AbWK0M1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 07:27:41 -0500
Received: from il.qumranet.com ([62.219.232.206]:25481 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1758114AbWK0M1k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 07:27:40 -0500
Subject: [PATCH 17/38] KVM: Make __set_cr0() (and dependencies) arch operations
From: Avi Kivity <avi@qumranet.com>
Date: Mon, 27 Nov 2006 12:27:37 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <456AD5C6.1090406@qumranet.com>
In-Reply-To: <456AD5C6.1090406@qumranet.com>
Message-Id: <20061127122737.DF83B25015E@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm.h
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm.h
+++ linux-2.6/drivers/kvm/kvm.h
@@ -269,6 +269,7 @@ struct kvm_arch_ops {
 			    struct kvm_segment *var, int seg);
 	void (*set_segment)(struct kvm_vcpu *vcpu,
 			    struct kvm_segment *var, int seg);
+	void (*set_cr0)(struct kvm_vcpu *vcpu, unsigned long cr0);
 	void (*get_idt)(struct kvm_vcpu *vcpu, struct descriptor_table *dt);
 	void (*set_idt)(struct kvm_vcpu *vcpu, struct descriptor_table *dt);
 	void (*get_gdt)(struct kvm_vcpu *vcpu, struct descriptor_table *dt);
@@ -279,6 +280,8 @@ struct kvm_arch_ops {
 	int (*run)(struct kvm_vcpu *vcpu, struct kvm_run *run);
 	int (*vcpu_setup)(struct kvm_vcpu *vcpu);
 	void (*skip_emulated_instruction)(struct kvm_vcpu *vcpu);
+
+	void (*update_exception_bitmap)(struct kvm_vcpu *vcpu); /* hack */
 };
 
 extern struct kvm_stat kvm_stat;
@@ -336,10 +339,8 @@ void set_cr8(struct kvm_vcpu *vcpu, unsi
 void lmsw(struct kvm_vcpu *vcpu, unsigned long msw);
 
 void __set_efer(struct kvm_vcpu *vcpu, u64 efer);
-void __set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0);
 void __set_cr4(struct kvm_vcpu *vcpu, unsigned long cr0);
 
-int rmode_tss_base(struct kvm* kvm); /* temporary hack */
 void inject_gp(struct kvm_vcpu *vcpu);
 
 #ifdef __x86_64__
Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -525,120 +525,6 @@ void guest_write_tsc(u64 guest_tsc)
 }
 EXPORT_SYMBOL_GPL(guest_write_tsc);
 
-static void update_exception_bitmap(struct kvm_vcpu *vcpu)
-{
-	if (vcpu->rmode.active)
-		vmcs_write32(EXCEPTION_BITMAP, ~0);
-	else
-		vmcs_write32(EXCEPTION_BITMAP, 1 << PF_VECTOR);
-}
-
-static void fix_pmode_dataseg(int seg, struct kvm_save_segment *save)
-{
-	struct kvm_vmx_segment_field *sf = &kvm_vmx_segment_fields[seg];
-
-	if (vmcs_readl(sf->base) == save->base) {
-		vmcs_write16(sf->selector, save->selector);
-		vmcs_writel(sf->base, save->base);
-		vmcs_write32(sf->limit, save->limit);
-		vmcs_write32(sf->ar_bytes, save->ar);
-	} else {
-		u32 dpl = (vmcs_read16(sf->selector) & SELECTOR_RPL_MASK)
-			<< AR_DPL_SHIFT;
-		vmcs_write32(sf->ar_bytes, 0x93 | dpl);
-	}
-}
-
-static void enter_pmode(struct kvm_vcpu *vcpu)
-{
-	unsigned long flags;
-
-	vcpu->rmode.active = 0;
-
-	vmcs_writel(GUEST_TR_BASE, vcpu->rmode.tr.base);
-	vmcs_write32(GUEST_TR_LIMIT, vcpu->rmode.tr.limit);
-	vmcs_write32(GUEST_TR_AR_BYTES, vcpu->rmode.tr.ar);
-
-	flags = vmcs_readl(GUEST_RFLAGS);
-	flags &= ~(IOPL_MASK | X86_EFLAGS_VM);
-	flags |= (vcpu->rmode.save_iopl << IOPL_SHIFT);
-	vmcs_writel(GUEST_RFLAGS, flags);
-
-	vmcs_writel(GUEST_CR4, (vmcs_readl(GUEST_CR4) & ~CR4_VME_MASK) |
-			(vmcs_readl(CR4_READ_SHADOW) & CR4_VME_MASK));
-
-	update_exception_bitmap(vcpu);
-
-	fix_pmode_dataseg(VCPU_SREG_ES, &vcpu->rmode.es);
-	fix_pmode_dataseg(VCPU_SREG_DS, &vcpu->rmode.ds);
-	fix_pmode_dataseg(VCPU_SREG_GS, &vcpu->rmode.gs);
-	fix_pmode_dataseg(VCPU_SREG_FS, &vcpu->rmode.fs);
-
-	vmcs_write16(GUEST_SS_SELECTOR, 0);
-	vmcs_write32(GUEST_SS_AR_BYTES, 0x93);
-
-	vmcs_write16(GUEST_CS_SELECTOR,
-		     vmcs_read16(GUEST_CS_SELECTOR) & ~SELECTOR_RPL_MASK);
-	vmcs_write32(GUEST_CS_AR_BYTES, 0x9b);
-}
-
-int rmode_tss_base(struct kvm* kvm)
-{
-	gfn_t base_gfn = kvm->memslots[0].base_gfn + kvm->memslots[0].npages - 3;
-	return base_gfn << PAGE_SHIFT;
-}
-EXPORT_SYMBOL_GPL(rmode_tss_base);
-
-static void fix_rmode_seg(int seg, struct kvm_save_segment *save)
-{
-	struct kvm_vmx_segment_field *sf = &kvm_vmx_segment_fields[seg];
-
-	save->selector = vmcs_read16(sf->selector);
-	save->base = vmcs_readl(sf->base);
-	save->limit = vmcs_read32(sf->limit);
-	save->ar = vmcs_read32(sf->ar_bytes);
-	vmcs_write16(sf->selector, vmcs_readl(sf->base) >> 4);
-	vmcs_write32(sf->limit, 0xffff);
-	vmcs_write32(sf->ar_bytes, 0xf3);
-}
-
-static void enter_rmode(struct kvm_vcpu *vcpu)
-{
-	unsigned long flags;
-
-	vcpu->rmode.active = 1;
-
-	vcpu->rmode.tr.base = vmcs_readl(GUEST_TR_BASE);
-	vmcs_writel(GUEST_TR_BASE, rmode_tss_base(vcpu->kvm));
-
-	vcpu->rmode.tr.limit = vmcs_read32(GUEST_TR_LIMIT);
-	vmcs_write32(GUEST_TR_LIMIT, RMODE_TSS_SIZE - 1);
-
-	vcpu->rmode.tr.ar = vmcs_read32(GUEST_TR_AR_BYTES);
-	vmcs_write32(GUEST_TR_AR_BYTES, 0x008b);
-
-	flags = vmcs_readl(GUEST_RFLAGS);
-	vcpu->rmode.save_iopl = (flags & IOPL_MASK) >> IOPL_SHIFT;
-
-	flags |= IOPL_MASK | X86_EFLAGS_VM;
-
-	vmcs_writel(GUEST_RFLAGS, flags);
-	vmcs_writel(GUEST_CR4, vmcs_readl(GUEST_CR4) | CR4_VME_MASK);
-	update_exception_bitmap(vcpu);
-
-	vmcs_write16(GUEST_SS_SELECTOR, vmcs_readl(GUEST_SS_BASE) >> 4);
-	vmcs_write32(GUEST_SS_LIMIT, 0xffff);
-	vmcs_write32(GUEST_SS_AR_BYTES, 0xf3);
-
-	vmcs_write32(GUEST_CS_AR_BYTES, 0xf3);
-	vmcs_write16(GUEST_CS_SELECTOR, vmcs_readl(GUEST_CS_BASE) >> 4);
-
-	fix_rmode_seg(VCPU_SREG_ES, &vcpu->rmode.es);
-	fix_rmode_seg(VCPU_SREG_DS, &vcpu->rmode.ds);
-	fix_rmode_seg(VCPU_SREG_GS, &vcpu->rmode.gs);
-	fix_rmode_seg(VCPU_SREG_FS, &vcpu->rmode.fs);
-}
-
 #ifdef __x86_64__
 
 void __set_efer(struct kvm_vcpu *vcpu, u64 efer)
@@ -662,62 +548,8 @@ void __set_efer(struct kvm_vcpu *vcpu, u
 }
 EXPORT_SYMBOL_GPL(__set_efer);
 
-static void enter_lmode(struct kvm_vcpu *vcpu)
-{
-	u32 guest_tr_ar;
-
-	guest_tr_ar = vmcs_read32(GUEST_TR_AR_BYTES);
-	if ((guest_tr_ar & AR_TYPE_MASK) != AR_TYPE_BUSY_64_TSS) {
-		printk(KERN_DEBUG "%s: tss fixup for long mode. \n",
-		       __FUNCTION__);
-		vmcs_write32(GUEST_TR_AR_BYTES,
-			     (guest_tr_ar & ~AR_TYPE_MASK)
-			     | AR_TYPE_BUSY_64_TSS);
-	}
-
-	vcpu->shadow_efer |= EFER_LMA;
-
-	find_msr_entry(vcpu, MSR_EFER)->data |= EFER_LMA | EFER_LME;
-	vmcs_write32(VM_ENTRY_CONTROLS,
-		     vmcs_read32(VM_ENTRY_CONTROLS)
-		     | VM_ENTRY_CONTROLS_IA32E_MASK);
-}
-
-static void exit_lmode(struct kvm_vcpu *vcpu)
-{
-	vcpu->shadow_efer &= ~EFER_LMA;
-
-	vmcs_write32(VM_ENTRY_CONTROLS,
-		     vmcs_read32(VM_ENTRY_CONTROLS)
-		     & ~VM_ENTRY_CONTROLS_IA32E_MASK);
-}
-
-#endif
-
-void __set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
-{
-	if (vcpu->rmode.active && (cr0 & CR0_PE_MASK))
-		enter_pmode(vcpu);
-
-	if (!vcpu->rmode.active && !(cr0 & CR0_PE_MASK))
-		enter_rmode(vcpu);
-
-#ifdef __x86_64__
-	if (vcpu->shadow_efer & EFER_LME) {
-		if (!is_paging(vcpu) && (cr0 & CR0_PG_MASK))
-			enter_lmode(vcpu);
-		if (is_paging(vcpu) && !(cr0 & CR0_PG_MASK))
-			exit_lmode(vcpu);
-	}
 #endif
 
-	vmcs_writel(CR0_READ_SHADOW, cr0);
-	vmcs_writel(GUEST_CR0,
-		    (cr0 & ~KVM_GUEST_CR0_MASK) | KVM_VM_CR0_ALWAYS_ON);
-	vcpu->cr0 = cr0;
-}
-EXPORT_SYMBOL_GPL(__set_cr0);
-
 static int pdptrs_have_reserved_bits_set(struct kvm_vcpu *vcpu,
 					 unsigned long cr3)
 {
@@ -797,7 +629,9 @@ void set_cr0(struct kvm_vcpu *vcpu, unsi
 
 	}
 
-	__set_cr0(vcpu, cr0);
+	kvm_arch_ops->set_cr0(vcpu, cr0);
+	vcpu->cr0 = cr0;
+
 	spin_lock(&vcpu->kvm->lock);
 	kvm_mmu_reset_context(vcpu);
 	spin_unlock(&vcpu->kvm->lock);
@@ -807,18 +641,7 @@ EXPORT_SYMBOL_GPL(set_cr0);
 
 void lmsw(struct kvm_vcpu *vcpu, unsigned long msw)
 {
-	unsigned long cr0 = vcpu->cr0;
-
-	if ((msw & CR0_PE_MASK) && !(cr0 & CR0_PE_MASK)) {
-		enter_pmode(vcpu);
-		vmcs_writel(CR0_READ_SHADOW, cr0 | CR0_PE_MASK);
-
-	} else
-		printk(KERN_DEBUG "lmsw: unexpected\n");
-
-	vmcs_writel(GUEST_CR0, (vmcs_readl(GUEST_CR0) & ~LMSW_GUEST_MASK)
-				| (msw & LMSW_GUEST_MASK));
-	vcpu->cr0 = (vcpu->cr0 & ~0xfffful) | msw;
+	set_cr0(vcpu, (vcpu->cr0 & ~0x0ful) | (msw & 0x0f));
 }
 EXPORT_SYMBOL_GPL(lmsw);
 
@@ -1794,7 +1617,7 @@ static int kvm_dev_ioctl_set_sregs(struc
 
 	mmu_reset_needed |= vcpu->cr0 != sregs->cr0;
 	vcpu->rmode.active = ((sregs->cr0 & CR0_PE_MASK) == 0);
-	update_exception_bitmap(vcpu);
+	kvm_arch_ops->update_exception_bitmap(vcpu);
 	vmcs_writel(CR0_READ_SHADOW, sregs->cr0);
 	vmcs_writel(GUEST_CR0,
 		    (sregs->cr0 & ~KVM_GUEST_CR0_MASK) | KVM_VM_CR0_ALWAYS_ON);
Index: linux-2.6/drivers/kvm/vmx.c
===================================================================
--- linux-2.6.orig/drivers/kvm/vmx.c
+++ linux-2.6/drivers/kvm/vmx.c
@@ -375,6 +375,176 @@ static __exit void hardware_unsetup(void
 	free_kvm_area();
 }
 
+static void update_exception_bitmap(struct kvm_vcpu *vcpu)
+{
+	if (vcpu->rmode.active)
+		vmcs_write32(EXCEPTION_BITMAP, ~0);
+	else
+		vmcs_write32(EXCEPTION_BITMAP, 1 << PF_VECTOR);
+}
+
+static void fix_pmode_dataseg(int seg, struct kvm_save_segment *save)
+{
+	struct kvm_vmx_segment_field *sf = &kvm_vmx_segment_fields[seg];
+
+	if (vmcs_readl(sf->base) == save->base) {
+		vmcs_write16(sf->selector, save->selector);
+		vmcs_writel(sf->base, save->base);
+		vmcs_write32(sf->limit, save->limit);
+		vmcs_write32(sf->ar_bytes, save->ar);
+	} else {
+		u32 dpl = (vmcs_read16(sf->selector) & SELECTOR_RPL_MASK)
+			<< AR_DPL_SHIFT;
+		vmcs_write32(sf->ar_bytes, 0x93 | dpl);
+	}
+}
+
+static void enter_pmode(struct kvm_vcpu *vcpu)
+{
+	unsigned long flags;
+
+	vcpu->rmode.active = 0;
+
+	vmcs_writel(GUEST_TR_BASE, vcpu->rmode.tr.base);
+	vmcs_write32(GUEST_TR_LIMIT, vcpu->rmode.tr.limit);
+	vmcs_write32(GUEST_TR_AR_BYTES, vcpu->rmode.tr.ar);
+
+	flags = vmcs_readl(GUEST_RFLAGS);
+	flags &= ~(IOPL_MASK | X86_EFLAGS_VM);
+	flags |= (vcpu->rmode.save_iopl << IOPL_SHIFT);
+	vmcs_writel(GUEST_RFLAGS, flags);
+
+	vmcs_writel(GUEST_CR4, (vmcs_readl(GUEST_CR4) & ~CR4_VME_MASK) |
+			(vmcs_readl(CR4_READ_SHADOW) & CR4_VME_MASK));
+
+	update_exception_bitmap(vcpu);
+
+	fix_pmode_dataseg(VCPU_SREG_ES, &vcpu->rmode.es);
+	fix_pmode_dataseg(VCPU_SREG_DS, &vcpu->rmode.ds);
+	fix_pmode_dataseg(VCPU_SREG_GS, &vcpu->rmode.gs);
+	fix_pmode_dataseg(VCPU_SREG_FS, &vcpu->rmode.fs);
+
+	vmcs_write16(GUEST_SS_SELECTOR, 0);
+	vmcs_write32(GUEST_SS_AR_BYTES, 0x93);
+
+	vmcs_write16(GUEST_CS_SELECTOR,
+		     vmcs_read16(GUEST_CS_SELECTOR) & ~SELECTOR_RPL_MASK);
+	vmcs_write32(GUEST_CS_AR_BYTES, 0x9b);
+}
+
+static int rmode_tss_base(struct kvm* kvm)
+{
+	gfn_t base_gfn = kvm->memslots[0].base_gfn + kvm->memslots[0].npages - 3;
+	return base_gfn << PAGE_SHIFT;
+}
+
+static void fix_rmode_seg(int seg, struct kvm_save_segment *save)
+{
+	struct kvm_vmx_segment_field *sf = &kvm_vmx_segment_fields[seg];
+
+	save->selector = vmcs_read16(sf->selector);
+	save->base = vmcs_readl(sf->base);
+	save->limit = vmcs_read32(sf->limit);
+	save->ar = vmcs_read32(sf->ar_bytes);
+	vmcs_write16(sf->selector, vmcs_readl(sf->base) >> 4);
+	vmcs_write32(sf->limit, 0xffff);
+	vmcs_write32(sf->ar_bytes, 0xf3);
+}
+
+static void enter_rmode(struct kvm_vcpu *vcpu)
+{
+	unsigned long flags;
+
+	vcpu->rmode.active = 1;
+
+	vcpu->rmode.tr.base = vmcs_readl(GUEST_TR_BASE);
+	vmcs_writel(GUEST_TR_BASE, rmode_tss_base(vcpu->kvm));
+
+	vcpu->rmode.tr.limit = vmcs_read32(GUEST_TR_LIMIT);
+	vmcs_write32(GUEST_TR_LIMIT, RMODE_TSS_SIZE - 1);
+
+	vcpu->rmode.tr.ar = vmcs_read32(GUEST_TR_AR_BYTES);
+	vmcs_write32(GUEST_TR_AR_BYTES, 0x008b);
+
+	flags = vmcs_readl(GUEST_RFLAGS);
+	vcpu->rmode.save_iopl = (flags & IOPL_MASK) >> IOPL_SHIFT;
+
+	flags |= IOPL_MASK | X86_EFLAGS_VM;
+
+	vmcs_writel(GUEST_RFLAGS, flags);
+	vmcs_writel(GUEST_CR4, vmcs_readl(GUEST_CR4) | CR4_VME_MASK);
+	update_exception_bitmap(vcpu);
+
+	vmcs_write16(GUEST_SS_SELECTOR, vmcs_readl(GUEST_SS_BASE) >> 4);
+	vmcs_write32(GUEST_SS_LIMIT, 0xffff);
+	vmcs_write32(GUEST_SS_AR_BYTES, 0xf3);
+
+	vmcs_write32(GUEST_CS_AR_BYTES, 0xf3);
+	vmcs_write16(GUEST_CS_SELECTOR, vmcs_readl(GUEST_CS_BASE) >> 4);
+
+	fix_rmode_seg(VCPU_SREG_ES, &vcpu->rmode.es);
+	fix_rmode_seg(VCPU_SREG_DS, &vcpu->rmode.ds);
+	fix_rmode_seg(VCPU_SREG_GS, &vcpu->rmode.gs);
+	fix_rmode_seg(VCPU_SREG_FS, &vcpu->rmode.fs);
+}
+
+#ifdef __x86_64__
+
+static void enter_lmode(struct kvm_vcpu *vcpu)
+{
+	u32 guest_tr_ar;
+
+	guest_tr_ar = vmcs_read32(GUEST_TR_AR_BYTES);
+	if ((guest_tr_ar & AR_TYPE_MASK) != AR_TYPE_BUSY_64_TSS) {
+		printk(KERN_DEBUG "%s: tss fixup for long mode. \n",
+		       __FUNCTION__);
+		vmcs_write32(GUEST_TR_AR_BYTES,
+			     (guest_tr_ar & ~AR_TYPE_MASK)
+			     | AR_TYPE_BUSY_64_TSS);
+	}
+
+	vcpu->shadow_efer |= EFER_LMA;
+
+	find_msr_entry(vcpu, MSR_EFER)->data |= EFER_LMA | EFER_LME;
+	vmcs_write32(VM_ENTRY_CONTROLS,
+		     vmcs_read32(VM_ENTRY_CONTROLS)
+		     | VM_ENTRY_CONTROLS_IA32E_MASK);
+}
+
+static void exit_lmode(struct kvm_vcpu *vcpu)
+{
+	vcpu->shadow_efer &= ~EFER_LMA;
+
+	vmcs_write32(VM_ENTRY_CONTROLS,
+		     vmcs_read32(VM_ENTRY_CONTROLS)
+		     & ~VM_ENTRY_CONTROLS_IA32E_MASK);
+}
+
+#endif
+
+static void vmx_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
+{
+	if (vcpu->rmode.active && (cr0 & CR0_PE_MASK))
+		enter_pmode(vcpu);
+
+	if (!vcpu->rmode.active && !(cr0 & CR0_PE_MASK))
+		enter_rmode(vcpu);
+
+#ifdef __x86_64__
+	if (vcpu->shadow_efer & EFER_LME) {
+		if (!is_paging(vcpu) && (cr0 & CR0_PG_MASK))
+			enter_lmode(vcpu);
+		if (is_paging(vcpu) && !(cr0 & CR0_PG_MASK))
+			exit_lmode(vcpu);
+	}
+#endif
+
+	vmcs_writel(CR0_READ_SHADOW, cr0);
+	vmcs_writel(GUEST_CR0,
+		    (cr0 & ~KVM_GUEST_CR0_MASK) | KVM_VM_CR0_ALWAYS_ON);
+	vcpu->cr0 = cr0;
+}
+
 static u64 vmx_get_segment_base(struct kvm_vcpu *vcpu, int seg)
 {
 	struct kvm_vmx_segment_field *sf = &kvm_vmx_segment_fields[seg];
@@ -700,7 +870,8 @@ static int vmx_vcpu_setup(struct kvm_vcp
 	vmcs_writel(CR0_GUEST_HOST_MASK, KVM_GUEST_CR0_MASK);
 	vmcs_writel(CR4_GUEST_HOST_MASK, KVM_GUEST_CR4_MASK);
 
-	__set_cr0(vcpu, 0x60000010); // enter rmode
+	vcpu->cr0 = 0x60000010;
+	vmx_set_cr0(vcpu, vcpu->cr0); // enter rmode
 	__set_cr4(vcpu, 0);
 #ifdef __x86_64__
 	__set_efer(vcpu, 0);
@@ -1425,6 +1596,7 @@ static struct kvm_arch_ops vmx_arch_ops 
 	.get_segment_base = vmx_get_segment_base,
 	.get_segment = vmx_get_segment,
 	.set_segment = vmx_set_segment,
+	.set_cr0 = vmx_set_cr0,
 	.get_idt = vmx_get_idt,
 	.set_idt = vmx_set_idt,
 	.get_gdt = vmx_get_gdt,
@@ -1435,6 +1607,8 @@ static struct kvm_arch_ops vmx_arch_ops 
 	.run = vmx_vcpu_run,
 	.skip_emulated_instruction = skip_emulated_instruction,
 	.vcpu_setup = vmx_vcpu_setup,
+
+	.update_exception_bitmap = update_exception_bitmap,
 };
 
 static int __init vmx_init(void)
