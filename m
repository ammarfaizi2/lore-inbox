Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758110AbWK0MZm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758110AbWK0MZm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 07:25:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758112AbWK0MZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 07:25:42 -0500
Received: from il.qumranet.com ([62.219.232.206]:7346 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1758110AbWK0MZl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 07:25:41 -0500
Subject: [PATCH 15/38] KVM: Move the vmx exit handlers to vmx.c
From: Avi Kivity <avi@qumranet.com>
Date: Mon, 27 Nov 2006 12:25:37 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <456AD5C6.1090406@qumranet.com>
In-Reply-To: <456AD5C6.1090406@qumranet.com>
Message-Id: <20061127122537.BBC9525015E@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm.h
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm.h
+++ linux-2.6/drivers/kvm/kvm.h
@@ -266,6 +266,7 @@ struct kvm_arch_ops {
 	void (*decache_regs)(struct kvm_vcpu *vcpu);
 
 	int (*run)(struct kvm_vcpu *vcpu, struct kvm_run *run);
+	void (*skip_emulated_instruction)(struct kvm_vcpu *vcpu);
 	unsigned long vmx_return; /* temporary hack */
 };
 
@@ -300,6 +301,14 @@ static inline struct page *gfn_to_page(s
 struct kvm_memory_slot *gfn_to_memslot(struct kvm *kvm, gfn_t gfn);
 void mark_page_dirty(struct kvm *kvm, gfn_t gfn);
 
+enum emulation_result {
+	EMULATE_DONE,       /* no further processing */
+	EMULATE_DO_MMIO,      /* kvm_run filled with mmio request */
+	EMULATE_FAIL,         /* can't emulate this instruction */
+};
+
+int emulate_instruction(struct kvm_vcpu *vcpu, struct kvm_run *run,
+			unsigned long cr2, u16 error_code);
 void realmode_lgdt(struct kvm_vcpu *vcpu, u16 size, unsigned long address);
 void realmode_lidt(struct kvm_vcpu *vcpu, u16 size, unsigned long address);
 void realmode_lmsw(struct kvm_vcpu *vcpu, unsigned long msw,
@@ -309,10 +318,22 @@ unsigned long realmode_get_cr(struct kvm
 void realmode_set_cr(struct kvm_vcpu *vcpu, int cr, unsigned long value,
 		     unsigned long *rflags);
 
+void set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0);
+void set_cr3(struct kvm_vcpu *vcpu, unsigned long cr0);
+void set_cr4(struct kvm_vcpu *vcpu, unsigned long cr0);
+void set_cr8(struct kvm_vcpu *vcpu, unsigned long cr0);
+void lmsw(struct kvm_vcpu *vcpu, unsigned long msw);
+
+void inject_gp(struct kvm_vcpu *vcpu);
+
+#ifdef __x86_64__
+void set_efer(struct kvm_vcpu *vcpu, u64 efer);
+#endif
+
+
 void load_msrs(struct vmx_msr_entry *e, int n);
 void save_msrs(struct vmx_msr_entry *e, int n);
 void kvm_resched(struct kvm_vcpu *vcpu);
-int kvm_handle_exit(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu);
 
 int kvm_read_guest(struct kvm_vcpu *vcpu,
 	       gva_t addr,
Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -533,7 +533,7 @@ void vmcs_writel(unsigned long field, un
 }
 EXPORT_SYMBOL_GPL(vmcs_writel);
 
-static void inject_gp(struct kvm_vcpu *vcpu)
+void inject_gp(struct kvm_vcpu *vcpu)
 {
 	printk(KERN_DEBUG "inject_general_protection: rip 0x%lx\n",
 	       vmcs_readl(GUEST_RIP));
@@ -544,6 +544,7 @@ static void inject_gp(struct kvm_vcpu *v
 		     INTR_INFO_DELIEVER_CODE_MASK |
 		     INTR_INFO_VALID_MASK);
 }
+EXPORT_SYMBOL_GPL(inject_gp);
 
 /*
  * reads and returns guest's timestamp counter "register"
@@ -821,7 +822,7 @@ static int pdptrs_have_reserved_bits_set
 	return i != 4;
 }
 
-static void set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
+void set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
 {
 	if (cr0 & CR0_RESEVED_BITS) {
 		printk(KERN_DEBUG "set_cr0: 0x%lx #GP, reserved bits 0x%lx\n",
@@ -879,8 +880,9 @@ static void set_cr0(struct kvm_vcpu *vcp
 	spin_unlock(&vcpu->kvm->lock);
 	return;
 }
+EXPORT_SYMBOL_GPL(set_cr0);
 
-static void lmsw(struct kvm_vcpu *vcpu, unsigned long msw)
+void lmsw(struct kvm_vcpu *vcpu, unsigned long msw)
 {
 	unsigned long cr0 = vcpu->cr0;
 
@@ -895,6 +897,7 @@ static void lmsw(struct kvm_vcpu *vcpu, 
 				| (msw & LMSW_GUEST_MASK));
 	vcpu->cr0 = (vcpu->cr0 & ~0xfffful) | msw;
 }
+EXPORT_SYMBOL_GPL(lmsw);
 
 static void __set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
 {
@@ -904,7 +907,7 @@ static void __set_cr4(struct kvm_vcpu *v
 	vcpu->cr4 = cr4;
 }
 
-static void set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
+void set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
 {
 	if (cr4 & CR4_RESEVED_BITS) {
 		printk(KERN_DEBUG "set_cr4: #GP, reserved bits\n");
@@ -935,8 +938,9 @@ static void set_cr4(struct kvm_vcpu *vcp
 	kvm_mmu_reset_context(vcpu);
 	spin_unlock(&vcpu->kvm->lock);
 }
+EXPORT_SYMBOL_GPL(set_cr4);
 
-static void set_cr3(struct kvm_vcpu *vcpu, unsigned long cr3)
+void set_cr3(struct kvm_vcpu *vcpu, unsigned long cr3)
 {
 	if (is_long_mode()) {
 		if ( cr3 & CR3_L_MODE_RESEVED_BITS) {
@@ -964,8 +968,9 @@ static void set_cr3(struct kvm_vcpu *vcp
 	vcpu->mmu.new_cr3(vcpu);
 	spin_unlock(&vcpu->kvm->lock);
 }
+EXPORT_SYMBOL_GPL(set_cr3);
 
-static void set_cr8(struct kvm_vcpu *vcpu, unsigned long cr8)
+void set_cr8(struct kvm_vcpu *vcpu, unsigned long cr8)
 {
 	if ( cr8 & CR8_RESEVED_BITS) {
 		printk(KERN_DEBUG "set_cr8: #GP, reserved bits 0x%lx\n", cr8);
@@ -974,6 +979,7 @@ static void set_cr8(struct kvm_vcpu *vcp
 	}
 	vcpu->cr8 = cr8;
 }
+EXPORT_SYMBOL_GPL(set_cr8);
 
 static u32 get_rdx_init_val(void)
 {
@@ -1534,25 +1540,6 @@ void mark_page_dirty(struct kvm *kvm, gf
 	}
 }
 
-static void skip_emulated_instruction(struct kvm_vcpu *vcpu)
-{
-	unsigned long rip;
-	u32 interruptibility;
-
-	rip = vmcs_readl(GUEST_RIP);
-	rip += vmcs_read32(VM_EXIT_INSTRUCTION_LEN);
-	vmcs_writel(GUEST_RIP, rip);
-
-	/*
-	 * We emulated an instruction, so temporary interrupt blocking
-	 * should be removed, if set.
-	 */
-	interruptibility = vmcs_read32(GUEST_INTERRUPTIBILITY_INFO);
-	if (interruptibility & 3)
-		vmcs_write32(GUEST_INTERRUPTIBILITY_INFO,
-			     interruptibility & ~3);
-}
-
 static int emulator_read_std(unsigned long addr,
 			     unsigned long *val,
 			     unsigned int bytes,
@@ -1694,16 +1681,10 @@ struct x86_emulate_ops emulate_ops = {
 	.cmpxchg_emulated    = emulator_cmpxchg_emulated,
 };
 
-enum emulation_result {
-	EMULATE_DONE,       /* no further processing */
-	EMULATE_DO_MMIO,      /* kvm_run filled with mmio request */
-	EMULATE_FAIL,         /* can't emulate this instruction */
-};
-
-static int emulate_instruction(struct kvm_vcpu *vcpu,
-			       struct kvm_run *run,
-			       unsigned long cr2,
-			       u16 error_code)
+int emulate_instruction(struct kvm_vcpu *vcpu,
+			struct kvm_run *run,
+			unsigned long cr2,
+			u16 error_code)
 {
 	struct x86_emulate_ctxt emulate_ctxt;
 	int r;
@@ -1762,6 +1743,7 @@ static int emulate_instruction(struct kv
 
 	return EMULATE_DONE;
 }
+EXPORT_SYMBOL_GPL(emulate_instruction);
 
 static u64 mk_cr_64(u64 curr_cr, u32 new_val)
 {
@@ -1826,298 +1808,6 @@ void realmode_set_cr(struct kvm_vcpu *vc
 	}
 }
 
-static int handle_rmode_exception(struct kvm_vcpu *vcpu,
-				  int vec, u32 err_code)
-{
-	if (!vcpu->rmode.active)
-		return 0;
-
-	if (vec == GP_VECTOR && err_code == 0)
-		if (emulate_instruction(vcpu, 0, 0, 0) == EMULATE_DONE)
-			return 1;
-	return 0;
-}
-
-static int handle_exception(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
-{
-	u32 intr_info, error_code;
-	unsigned long cr2, rip;
-	u32 vect_info;
-	enum emulation_result er;
-
-	vect_info = vmcs_read32(IDT_VECTORING_INFO_FIELD);
-	intr_info = vmcs_read32(VM_EXIT_INTR_INFO);
-
-	if ((vect_info & VECTORING_INFO_VALID_MASK) &&
-						!is_page_fault(intr_info)) {
-		printk(KERN_ERR "%s: unexpected, vectoring info 0x%x "
-		       "intr info 0x%x\n", __FUNCTION__, vect_info, intr_info);
-	}
-
-	if (is_external_interrupt(vect_info)) {
-		int irq = vect_info & VECTORING_INFO_VECTOR_MASK;
-		set_bit(irq, vcpu->irq_pending);
-		set_bit(irq / BITS_PER_LONG, &vcpu->irq_summary);
-	}
-
-	if ((intr_info & INTR_INFO_INTR_TYPE_MASK) == 0x200) { /* nmi */
-		asm ("int $2");
-		return 1;
-	}
-	error_code = 0;
-	rip = vmcs_readl(GUEST_RIP);
-	if (intr_info & INTR_INFO_DELIEVER_CODE_MASK)
-		error_code = vmcs_read32(VM_EXIT_INTR_ERROR_CODE);
-	if (is_page_fault(intr_info)) {
-		cr2 = vmcs_readl(EXIT_QUALIFICATION);
-
-		spin_lock(&vcpu->kvm->lock);
-		if (!vcpu->mmu.page_fault(vcpu, cr2, error_code)) {
-			spin_unlock(&vcpu->kvm->lock);
-			return 1;
-		}
-
-		er = emulate_instruction(vcpu, kvm_run, cr2, error_code);
-		spin_unlock(&vcpu->kvm->lock);
-
-		switch (er) {
-		case EMULATE_DONE:
-			return 1;
-		case EMULATE_DO_MMIO:
-			++kvm_stat.mmio_exits;
-			kvm_run->exit_reason = KVM_EXIT_MMIO;
-			return 0;
-		 case EMULATE_FAIL:
-			vcpu_printf(vcpu, "%s: emulate fail\n", __FUNCTION__);
-			break;
-		default:
-			BUG();
-		}
-	}
-
-	if (vcpu->rmode.active &&
-	    handle_rmode_exception(vcpu, intr_info & INTR_INFO_VECTOR_MASK,
-								error_code))
-		return 1;
-
-	if ((intr_info & (INTR_INFO_INTR_TYPE_MASK | INTR_INFO_VECTOR_MASK)) == (INTR_TYPE_EXCEPTION | 1)) {
-		kvm_run->exit_reason = KVM_EXIT_DEBUG;
-		return 0;
-	}
-	kvm_run->exit_reason = KVM_EXIT_EXCEPTION;
-	kvm_run->ex.exception = intr_info & INTR_INFO_VECTOR_MASK;
-	kvm_run->ex.error_code = error_code;
-	return 0;
-}
-
-static int handle_external_interrupt(struct kvm_vcpu *vcpu,
-				     struct kvm_run *kvm_run)
-{
-	++kvm_stat.irq_exits;
-	return 1;
-}
-
-
-static int get_io_count(struct kvm_vcpu *vcpu, u64 *count)
-{
-	u64 inst;
-	gva_t rip;
-	int countr_size;
-	int i, n;
-
-	if ((vmcs_readl(GUEST_RFLAGS) & X86_EFLAGS_VM)) {
-		countr_size = 2;
-	} else {
-		u32 cs_ar = vmcs_read32(GUEST_CS_AR_BYTES);
-
-		countr_size = (cs_ar & AR_L_MASK) ? 8:
-			      (cs_ar & AR_DB_MASK) ? 4: 2;
-	}
-
-	rip =  vmcs_readl(GUEST_RIP);
-	if (countr_size != 8)
-		rip += vmcs_readl(GUEST_CS_BASE);
-
-	n = kvm_read_guest(vcpu, rip, sizeof(inst), &inst);
-
-	for (i = 0; i < n; i++) {
-		switch (((u8*)&inst)[i]) {
-		case 0xf0:
-		case 0xf2:
-		case 0xf3:
-		case 0x2e:
-		case 0x36:
-		case 0x3e:
-		case 0x26:
-		case 0x64:
-		case 0x65:
-		case 0x66:
-			break;
-		case 0x67:
-			countr_size = (countr_size == 2) ? 4: (countr_size >> 1);
-		default:
-			goto done;
-		}
-	}
-	return 0;
-done:
-	countr_size *= 8;
-	*count = vcpu->regs[VCPU_REGS_RCX] & (~0ULL >> (64 - countr_size));
-	return 1;
-}
-
-static int handle_io(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
-{
-	u64 exit_qualification;
-
-	++kvm_stat.io_exits;
-	exit_qualification = vmcs_read64(EXIT_QUALIFICATION);
-	kvm_run->exit_reason = KVM_EXIT_IO;
-	if (exit_qualification & 8)
-		kvm_run->io.direction = KVM_EXIT_IO_IN;
-	else
-		kvm_run->io.direction = KVM_EXIT_IO_OUT;
-	kvm_run->io.size = (exit_qualification & 7) + 1;
-	kvm_run->io.string = (exit_qualification & 16) != 0;
-	kvm_run->io.string_down
-		= (vmcs_readl(GUEST_RFLAGS) & X86_EFLAGS_DF) != 0;
-	kvm_run->io.rep = (exit_qualification & 32) != 0;
-	kvm_run->io.port = exit_qualification >> 16;
-	if (kvm_run->io.string) {
-		if (!get_io_count(vcpu, &kvm_run->io.count))
-			return 1;
-		kvm_run->io.address = vmcs_readl(GUEST_LINEAR_ADDRESS);
-	} else
-		kvm_run->io.value = vcpu->regs[VCPU_REGS_RAX]; /* rax */
-	return 0;
-}
-
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
-static int handle_cr(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
-{
-	u64 exit_qualification;
-	int cr;
-	int reg;
-
-#ifdef KVM_DEBUG
-	if (guest_cpl() != 0) {
-		vcpu_printf(vcpu, "%s: not supervisor\n", __FUNCTION__);
-		inject_gp(vcpu);
-		return 1;
-	}
-#endif
-
-	exit_qualification = vmcs_read64(EXIT_QUALIFICATION);
-	cr = exit_qualification & 15;
-	reg = (exit_qualification >> 8) & 15;
-	switch ((exit_qualification >> 4) & 3) {
-	case 0: /* mov to cr */
-		switch (cr) {
-		case 0:
-			kvm_arch_ops->cache_regs(vcpu);
-			set_cr0(vcpu, vcpu->regs[reg]);
-			skip_emulated_instruction(vcpu);
-			return 1;
-		case 3:
-			kvm_arch_ops->cache_regs(vcpu);
-			set_cr3(vcpu, vcpu->regs[reg]);
-			skip_emulated_instruction(vcpu);
-			return 1;
-		case 4:
-			kvm_arch_ops->cache_regs(vcpu);
-			set_cr4(vcpu, vcpu->regs[reg]);
-			skip_emulated_instruction(vcpu);
-			return 1;
-		case 8:
-			kvm_arch_ops->cache_regs(vcpu);
-			set_cr8(vcpu, vcpu->regs[reg]);
-			skip_emulated_instruction(vcpu);
-			return 1;
-		};
-		break;
-	case 1: /*mov from cr*/
-		switch (cr) {
-		case 3:
-			kvm_arch_ops->cache_regs(vcpu);
-			vcpu->regs[reg] = vcpu->cr3;
-			kvm_arch_ops->decache_regs(vcpu);
-			skip_emulated_instruction(vcpu);
-			return 1;
-		case 8:
-			printk(KERN_DEBUG "handle_cr: read CR8 "
-			       "cpu erratum AA15\n");
-			kvm_arch_ops->cache_regs(vcpu);
-			vcpu->regs[reg] = vcpu->cr8;
-			kvm_arch_ops->decache_regs(vcpu);
-			skip_emulated_instruction(vcpu);
-			return 1;
-		}
-		break;
-	case 3: /* lmsw */
-		lmsw(vcpu, (exit_qualification >> LMSW_SOURCE_DATA_SHIFT) & 0x0f);
-
-		skip_emulated_instruction(vcpu);
-		return 1;
-	default:
-		break;
-	}
-	kvm_run->exit_reason = 0;
-	printk(KERN_ERR "kvm: unhandled control register: op %d cr %d\n",
-	       (int)(exit_qualification >> 4) & 3, cr);
-	return 0;
-}
-
-static int handle_dr(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
-{
-	u64 exit_qualification;
-	unsigned long val;
-	int dr, reg;
-
-	/*
-	 * FIXME: this code assumes the host is debugging the guest.
-	 *        need to deal with guest debugging itself too.
-	 */
-	exit_qualification = vmcs_read64(EXIT_QUALIFICATION);
-	dr = exit_qualification & 7;
-	reg = (exit_qualification >> 8) & 15;
-	kvm_arch_ops->cache_regs(vcpu);
-	if (exit_qualification & 16) {
-		/* mov from dr */
-		switch (dr) {
-		case 6:
-			val = 0xffff0ff0;
-			break;
-		case 7:
-			val = 0x400;
-			break;
-		default:
-			val = 0;
-		}
-		vcpu->regs[reg] = val;
-	} else {
-		/* mov to dr */
-	}
-	kvm_arch_ops->decache_regs(vcpu);
-	skip_emulated_instruction(vcpu);
-	return 1;
-}
-
-static int handle_cpuid(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
-{
-	kvm_run->exit_reason = KVM_EXIT_CPUID;
-	return 0;
-}
-
 /*
  * Reads an msr value (of 'msr_index') into 'pdata'.
  * Returns 0 on success, non-0 otherwise.
@@ -2128,23 +1818,6 @@ static int get_msr(struct kvm_vcpu *vcpu
 	return kvm_arch_ops->get_msr(vcpu, msr_index, pdata);
 }
 
-static int handle_rdmsr(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
-{
-	u32 ecx = vcpu->regs[VCPU_REGS_RCX];
-	u64 data;
-
-	if (get_msr(vcpu, ecx, &data)) {
-		inject_gp(vcpu);
-		return 1;
-	}
-
-	/* FIXME: handling of bits 32:63 of rax, rdx */
-	vcpu->regs[VCPU_REGS_RAX] = data & -1u;
-	vcpu->regs[VCPU_REGS_RDX] = (data >> 32) & -1u;
-	skip_emulated_instruction(vcpu);
-	return 1;
-}
-
 #ifdef __x86_64__
 
 void set_efer(struct kvm_vcpu *vcpu, u64 efer)
@@ -2175,7 +1848,6 @@ void set_efer(struct kvm_vcpu *vcpu, u64
 	if (!(efer & EFER_LMA))
 	    efer &= ~EFER_LME;
 	msr->data = efer;
-	skip_emulated_instruction(vcpu);
 }
 EXPORT_SYMBOL_GPL(set_efer);
 
@@ -2191,90 +1863,6 @@ static int set_msr(struct kvm_vcpu *vcpu
 	return kvm_arch_ops->set_msr(vcpu, msr_index, data);
 }
 
-static int handle_wrmsr(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
-{
-	u32 ecx = vcpu->regs[VCPU_REGS_RCX];
-	u64 data = (vcpu->regs[VCPU_REGS_RAX] & -1u)
-		| ((u64)(vcpu->regs[VCPU_REGS_RDX] & -1u) << 32);
-
-	if (set_msr(vcpu, ecx, data) != 0) {
-		inject_gp(vcpu);
-		return 1;
-	}
-
-	if (ecx != MSR_EFER)
-		skip_emulated_instruction(vcpu);
-	return 1;
-}
-
-static int handle_interrupt_window(struct kvm_vcpu *vcpu,
-				   struct kvm_run *kvm_run)
-{
-	/* Turn off interrupt window reporting. */
-	vmcs_write32(CPU_BASED_VM_EXEC_CONTROL,
-		     vmcs_read32(CPU_BASED_VM_EXEC_CONTROL)
-		     & ~CPU_BASED_VIRTUAL_INTR_PENDING);
-	return 1;
-}
-
-static int handle_halt(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
-{
-	skip_emulated_instruction(vcpu);
-	if (vcpu->irq_summary && (vmcs_readl(GUEST_RFLAGS) & X86_EFLAGS_IF))
-		return 1;
-
-	kvm_run->exit_reason = KVM_EXIT_HLT;
-	return 0;
-}
-
-/*
- * The exit handlers return 1 if the exit was handled fully and guest execution
- * may resume.  Otherwise they set the kvm_run parameter to indicate what needs
- * to be done to userspace and return 0.
- */
-static int (*kvm_vmx_exit_handlers[])(struct kvm_vcpu *vcpu,
-				      struct kvm_run *kvm_run) = {
-	[EXIT_REASON_EXCEPTION_NMI]           = handle_exception,
-	[EXIT_REASON_EXTERNAL_INTERRUPT]      = handle_external_interrupt,
-	[EXIT_REASON_IO_INSTRUCTION]          = handle_io,
-	[EXIT_REASON_INVLPG]                  = handle_invlpg,
-	[EXIT_REASON_CR_ACCESS]               = handle_cr,
-	[EXIT_REASON_DR_ACCESS]               = handle_dr,
-	[EXIT_REASON_CPUID]                   = handle_cpuid,
-	[EXIT_REASON_MSR_READ]                = handle_rdmsr,
-	[EXIT_REASON_MSR_WRITE]               = handle_wrmsr,
-	[EXIT_REASON_PENDING_INTERRUPT]       = handle_interrupt_window,
-	[EXIT_REASON_HLT]                     = handle_halt,
-};
-
-static const int kvm_vmx_max_exit_handlers =
-	sizeof(kvm_vmx_exit_handlers) / sizeof(*kvm_vmx_exit_handlers);
-
-/*
- * The guest has exited.  See if we can fix it or if we need userspace
- * assistance.
- */
-int kvm_handle_exit(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
-{
-	u32 vectoring_info = vmcs_read32(IDT_VECTORING_INFO_FIELD);
-	u32 exit_reason = vmcs_read32(VM_EXIT_REASON);
-
-	if ( (vectoring_info & VECTORING_INFO_VALID_MASK) &&
-				exit_reason != EXIT_REASON_EXCEPTION_NMI )
-		printk(KERN_WARNING "%s: unexpected, valid vectoring info and "
-		       "exit reason is 0x%x\n", __FUNCTION__, exit_reason);
-	kvm_run->instruction_length = vmcs_read32(VM_EXIT_INSTRUCTION_LEN);
-	if (exit_reason < kvm_vmx_max_exit_handlers
-	    && kvm_vmx_exit_handlers[exit_reason])
-		return kvm_vmx_exit_handlers[exit_reason](vcpu, kvm_run);
-	else {
-		kvm_run->exit_reason = KVM_EXIT_UNKNOWN;
-		kvm_run->hw.hardware_exit_reason = exit_reason;
-	}
-	return 0;
-}
-EXPORT_SYMBOL_GPL(kvm_handle_exit);
-
 void kvm_resched(struct kvm_vcpu *vcpu)
 {
 	vcpu_put(vcpu);
@@ -2315,7 +1903,7 @@ static int kvm_dev_ioctl_run(struct kvm 
 		return -ENOENT;
 
 	if (kvm_run->emulated) {
-		skip_emulated_instruction(vcpu);
+		kvm_arch_ops->skip_emulated_instruction(vcpu);
 		kvm_run->emulated = 0;
 	}
 
Index: linux-2.6/drivers/kvm/vmx.c
===================================================================
--- linux-2.6.orig/drivers/kvm/vmx.c
+++ linux-2.6/drivers/kvm/vmx.c
@@ -44,11 +44,24 @@ u64 guest_read_tsc(void);
 void guest_write_tsc(u64 guest_tsc);
 struct vmx_msr_entry *find_msr_entry(struct kvm_vcpu *vcpu, u32 msr);
 
-#ifdef __x86_64__
+static void skip_emulated_instruction(struct kvm_vcpu *vcpu)
+{
+	unsigned long rip;
+	u32 interruptibility;
 
-void set_efer(struct kvm_vcpu *vcpu, u64 efer);
+	rip = vmcs_readl(GUEST_RIP);
+	rip += vmcs_read32(VM_EXIT_INSTRUCTION_LEN);
+	vmcs_writel(GUEST_RIP, rip);
 
-#endif
+	/*
+	 * We emulated an instruction, so temporary interrupt blocking
+	 * should be removed, if set.
+	 */
+	interruptibility = vmcs_read32(GUEST_INTERRUPTIBILITY_INFO);
+	if (interruptibility & 3)
+		vmcs_write32(GUEST_INTERRUPTIBILITY_INFO,
+			     interruptibility & ~3);
+}
 
 static void reload_tss(void)
 {
@@ -521,6 +534,397 @@ static void kvm_guest_debug_pre(struct k
 	}
 }
 
+static int handle_rmode_exception(struct kvm_vcpu *vcpu,
+				  int vec, u32 err_code)
+{
+	if (!vcpu->rmode.active)
+		return 0;
+
+	if (vec == GP_VECTOR && err_code == 0)
+		if (emulate_instruction(vcpu, 0, 0, 0) == EMULATE_DONE)
+			return 1;
+	return 0;
+}
+
+static int handle_exception(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
+{
+	u32 intr_info, error_code;
+	unsigned long cr2, rip;
+	u32 vect_info;
+	enum emulation_result er;
+
+	vect_info = vmcs_read32(IDT_VECTORING_INFO_FIELD);
+	intr_info = vmcs_read32(VM_EXIT_INTR_INFO);
+
+	if ((vect_info & VECTORING_INFO_VALID_MASK) &&
+						!is_page_fault(intr_info)) {
+		printk(KERN_ERR "%s: unexpected, vectoring info 0x%x "
+		       "intr info 0x%x\n", __FUNCTION__, vect_info, intr_info);
+	}
+
+	if (is_external_interrupt(vect_info)) {
+		int irq = vect_info & VECTORING_INFO_VECTOR_MASK;
+		set_bit(irq, vcpu->irq_pending);
+		set_bit(irq / BITS_PER_LONG, &vcpu->irq_summary);
+	}
+
+	if ((intr_info & INTR_INFO_INTR_TYPE_MASK) == 0x200) { /* nmi */
+		asm ("int $2");
+		return 1;
+	}
+	error_code = 0;
+	rip = vmcs_readl(GUEST_RIP);
+	if (intr_info & INTR_INFO_DELIEVER_CODE_MASK)
+		error_code = vmcs_read32(VM_EXIT_INTR_ERROR_CODE);
+	if (is_page_fault(intr_info)) {
+		cr2 = vmcs_readl(EXIT_QUALIFICATION);
+
+		spin_lock(&vcpu->kvm->lock);
+		if (!vcpu->mmu.page_fault(vcpu, cr2, error_code)) {
+			spin_unlock(&vcpu->kvm->lock);
+			return 1;
+		}
+
+		er = emulate_instruction(vcpu, kvm_run, cr2, error_code);
+		spin_unlock(&vcpu->kvm->lock);
+
+		switch (er) {
+		case EMULATE_DONE:
+			return 1;
+		case EMULATE_DO_MMIO:
+			++kvm_stat.mmio_exits;
+			kvm_run->exit_reason = KVM_EXIT_MMIO;
+			return 0;
+		 case EMULATE_FAIL:
+			vcpu_printf(vcpu, "%s: emulate fail\n", __FUNCTION__);
+			break;
+		default:
+			BUG();
+		}
+	}
+
+	if (vcpu->rmode.active &&
+	    handle_rmode_exception(vcpu, intr_info & INTR_INFO_VECTOR_MASK,
+								error_code))
+		return 1;
+
+	if ((intr_info & (INTR_INFO_INTR_TYPE_MASK | INTR_INFO_VECTOR_MASK)) == (INTR_TYPE_EXCEPTION | 1)) {
+		kvm_run->exit_reason = KVM_EXIT_DEBUG;
+		return 0;
+	}
+	kvm_run->exit_reason = KVM_EXIT_EXCEPTION;
+	kvm_run->ex.exception = intr_info & INTR_INFO_VECTOR_MASK;
+	kvm_run->ex.error_code = error_code;
+	return 0;
+}
+
+static int handle_external_interrupt(struct kvm_vcpu *vcpu,
+				     struct kvm_run *kvm_run)
+{
+	++kvm_stat.irq_exits;
+	return 1;
+}
+
+
+static int get_io_count(struct kvm_vcpu *vcpu, u64 *count)
+{
+	u64 inst;
+	gva_t rip;
+	int countr_size;
+	int i, n;
+
+	if ((vmcs_readl(GUEST_RFLAGS) & X86_EFLAGS_VM)) {
+		countr_size = 2;
+	} else {
+		u32 cs_ar = vmcs_read32(GUEST_CS_AR_BYTES);
+
+		countr_size = (cs_ar & AR_L_MASK) ? 8:
+			      (cs_ar & AR_DB_MASK) ? 4: 2;
+	}
+
+	rip =  vmcs_readl(GUEST_RIP);
+	if (countr_size != 8)
+		rip += vmcs_readl(GUEST_CS_BASE);
+
+	n = kvm_read_guest(vcpu, rip, sizeof(inst), &inst);
+
+	for (i = 0; i < n; i++) {
+		switch (((u8*)&inst)[i]) {
+		case 0xf0:
+		case 0xf2:
+		case 0xf3:
+		case 0x2e:
+		case 0x36:
+		case 0x3e:
+		case 0x26:
+		case 0x64:
+		case 0x65:
+		case 0x66:
+			break;
+		case 0x67:
+			countr_size = (countr_size == 2) ? 4: (countr_size >> 1);
+		default:
+			goto done;
+		}
+	}
+	return 0;
+done:
+	countr_size *= 8;
+	*count = vcpu->regs[VCPU_REGS_RCX] & (~0ULL >> (64 - countr_size));
+	return 1;
+}
+
+static int handle_io(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
+{
+	u64 exit_qualification;
+
+	++kvm_stat.io_exits;
+	exit_qualification = vmcs_read64(EXIT_QUALIFICATION);
+	kvm_run->exit_reason = KVM_EXIT_IO;
+	if (exit_qualification & 8)
+		kvm_run->io.direction = KVM_EXIT_IO_IN;
+	else
+		kvm_run->io.direction = KVM_EXIT_IO_OUT;
+	kvm_run->io.size = (exit_qualification & 7) + 1;
+	kvm_run->io.string = (exit_qualification & 16) != 0;
+	kvm_run->io.string_down
+		= (vmcs_readl(GUEST_RFLAGS) & X86_EFLAGS_DF) != 0;
+	kvm_run->io.rep = (exit_qualification & 32) != 0;
+	kvm_run->io.port = exit_qualification >> 16;
+	if (kvm_run->io.string) {
+		if (!get_io_count(vcpu, &kvm_run->io.count))
+			return 1;
+		kvm_run->io.address = vmcs_readl(GUEST_LINEAR_ADDRESS);
+	} else
+		kvm_run->io.value = vcpu->regs[VCPU_REGS_RAX]; /* rax */
+	return 0;
+}
+
+static int handle_invlpg(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
+{
+	u64 address = vmcs_read64(EXIT_QUALIFICATION);
+	int instruction_length = vmcs_read32(VM_EXIT_INSTRUCTION_LEN);
+	spin_lock(&vcpu->kvm->lock);
+	vcpu->mmu.inval_page(vcpu, address);
+	spin_unlock(&vcpu->kvm->lock);
+	vmcs_writel(GUEST_RIP, vmcs_readl(GUEST_RIP) + instruction_length);
+	return 1;
+}
+
+static int handle_cr(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
+{
+	u64 exit_qualification;
+	int cr;
+	int reg;
+
+#ifdef KVM_DEBUG
+	if (guest_cpl() != 0) {
+		vcpu_printf(vcpu, "%s: not supervisor\n", __FUNCTION__);
+		inject_gp(vcpu);
+		return 1;
+	}
+#endif
+
+	exit_qualification = vmcs_read64(EXIT_QUALIFICATION);
+	cr = exit_qualification & 15;
+	reg = (exit_qualification >> 8) & 15;
+	switch ((exit_qualification >> 4) & 3) {
+	case 0: /* mov to cr */
+		switch (cr) {
+		case 0:
+			vcpu_load_rsp_rip(vcpu);
+			set_cr0(vcpu, vcpu->regs[reg]);
+			skip_emulated_instruction(vcpu);
+			return 1;
+		case 3:
+			vcpu_load_rsp_rip(vcpu);
+			set_cr3(vcpu, vcpu->regs[reg]);
+			skip_emulated_instruction(vcpu);
+			return 1;
+		case 4:
+			vcpu_load_rsp_rip(vcpu);
+			set_cr4(vcpu, vcpu->regs[reg]);
+			skip_emulated_instruction(vcpu);
+			return 1;
+		case 8:
+			vcpu_load_rsp_rip(vcpu);
+			set_cr8(vcpu, vcpu->regs[reg]);
+			skip_emulated_instruction(vcpu);
+			return 1;
+		};
+		break;
+	case 1: /*mov from cr*/
+		switch (cr) {
+		case 3:
+			vcpu_load_rsp_rip(vcpu);
+			vcpu->regs[reg] = vcpu->cr3;
+			vcpu_put_rsp_rip(vcpu);
+			skip_emulated_instruction(vcpu);
+			return 1;
+		case 8:
+			printk(KERN_DEBUG "handle_cr: read CR8 "
+			       "cpu erratum AA15\n");
+			vcpu_load_rsp_rip(vcpu);
+			vcpu->regs[reg] = vcpu->cr8;
+			vcpu_put_rsp_rip(vcpu);
+			skip_emulated_instruction(vcpu);
+			return 1;
+		}
+		break;
+	case 3: /* lmsw */
+		lmsw(vcpu, (exit_qualification >> LMSW_SOURCE_DATA_SHIFT) & 0x0f);
+
+		skip_emulated_instruction(vcpu);
+		return 1;
+	default:
+		break;
+	}
+	kvm_run->exit_reason = 0;
+	printk(KERN_ERR "kvm: unhandled control register: op %d cr %d\n",
+	       (int)(exit_qualification >> 4) & 3, cr);
+	return 0;
+}
+
+static int handle_dr(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
+{
+	u64 exit_qualification;
+	unsigned long val;
+	int dr, reg;
+
+	/*
+	 * FIXME: this code assumes the host is debugging the guest.
+	 *        need to deal with guest debugging itself too.
+	 */
+	exit_qualification = vmcs_read64(EXIT_QUALIFICATION);
+	dr = exit_qualification & 7;
+	reg = (exit_qualification >> 8) & 15;
+	vcpu_load_rsp_rip(vcpu);
+	if (exit_qualification & 16) {
+		/* mov from dr */
+		switch (dr) {
+		case 6:
+			val = 0xffff0ff0;
+			break;
+		case 7:
+			val = 0x400;
+			break;
+		default:
+			val = 0;
+		}
+		vcpu->regs[reg] = val;
+	} else {
+		/* mov to dr */
+	}
+	vcpu_put_rsp_rip(vcpu);
+	skip_emulated_instruction(vcpu);
+	return 1;
+}
+
+static int handle_cpuid(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
+{
+	kvm_run->exit_reason = KVM_EXIT_CPUID;
+	return 0;
+}
+
+static int handle_rdmsr(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
+{
+	u32 ecx = vcpu->regs[VCPU_REGS_RCX];
+	u64 data;
+
+	if (vmx_get_msr(vcpu, ecx, &data)) {
+		inject_gp(vcpu);
+		return 1;
+	}
+
+	/* FIXME: handling of bits 32:63 of rax, rdx */
+	vcpu->regs[VCPU_REGS_RAX] = data & -1u;
+	vcpu->regs[VCPU_REGS_RDX] = (data >> 32) & -1u;
+	skip_emulated_instruction(vcpu);
+	return 1;
+}
+
+static int handle_wrmsr(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
+{
+	u32 ecx = vcpu->regs[VCPU_REGS_RCX];
+	u64 data = (vcpu->regs[VCPU_REGS_RAX] & -1u)
+		| ((u64)(vcpu->regs[VCPU_REGS_RDX] & -1u) << 32);
+
+	if (vmx_set_msr(vcpu, ecx, data) != 0) {
+		inject_gp(vcpu);
+		return 1;
+	}
+
+	skip_emulated_instruction(vcpu);
+	return 1;
+}
+
+static int handle_interrupt_window(struct kvm_vcpu *vcpu,
+				   struct kvm_run *kvm_run)
+{
+	/* Turn off interrupt window reporting. */
+	vmcs_write32(CPU_BASED_VM_EXEC_CONTROL,
+		     vmcs_read32(CPU_BASED_VM_EXEC_CONTROL)
+		     & ~CPU_BASED_VIRTUAL_INTR_PENDING);
+	return 1;
+}
+
+static int handle_halt(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
+{
+	skip_emulated_instruction(vcpu);
+	if (vcpu->irq_summary && (vmcs_readl(GUEST_RFLAGS) & X86_EFLAGS_IF))
+		return 1;
+
+	kvm_run->exit_reason = KVM_EXIT_HLT;
+	return 0;
+}
+
+/*
+ * The exit handlers return 1 if the exit was handled fully and guest execution
+ * may resume.  Otherwise they set the kvm_run parameter to indicate what needs
+ * to be done to userspace and return 0.
+ */
+static int (*kvm_vmx_exit_handlers[])(struct kvm_vcpu *vcpu,
+				      struct kvm_run *kvm_run) = {
+	[EXIT_REASON_EXCEPTION_NMI]           = handle_exception,
+	[EXIT_REASON_EXTERNAL_INTERRUPT]      = handle_external_interrupt,
+	[EXIT_REASON_IO_INSTRUCTION]          = handle_io,
+	[EXIT_REASON_INVLPG]                  = handle_invlpg,
+	[EXIT_REASON_CR_ACCESS]               = handle_cr,
+	[EXIT_REASON_DR_ACCESS]               = handle_dr,
+	[EXIT_REASON_CPUID]                   = handle_cpuid,
+	[EXIT_REASON_MSR_READ]                = handle_rdmsr,
+	[EXIT_REASON_MSR_WRITE]               = handle_wrmsr,
+	[EXIT_REASON_PENDING_INTERRUPT]       = handle_interrupt_window,
+	[EXIT_REASON_HLT]                     = handle_halt,
+};
+
+static const int kvm_vmx_max_exit_handlers =
+	sizeof(kvm_vmx_exit_handlers) / sizeof(*kvm_vmx_exit_handlers);
+
+/*
+ * The guest has exited.  See if we can fix it or if we need userspace
+ * assistance.
+ */
+static int kvm_handle_exit(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
+{
+	u32 vectoring_info = vmcs_read32(IDT_VECTORING_INFO_FIELD);
+	u32 exit_reason = vmcs_read32(VM_EXIT_REASON);
+
+	if ( (vectoring_info & VECTORING_INFO_VALID_MASK) &&
+				exit_reason != EXIT_REASON_EXCEPTION_NMI )
+		printk(KERN_WARNING "%s: unexpected, valid vectoring info and "
+		       "exit reason is 0x%x\n", __FUNCTION__, exit_reason);
+	kvm_run->instruction_length = vmcs_read32(VM_EXIT_INSTRUCTION_LEN);
+	if (exit_reason < kvm_vmx_max_exit_handlers
+	    && kvm_vmx_exit_handlers[exit_reason])
+		return kvm_vmx_exit_handlers[exit_reason](vcpu, kvm_run);
+	else {
+		kvm_run->exit_reason = KVM_EXIT_UNKNOWN;
+		kvm_run->hw.hardware_exit_reason = exit_reason;
+	}
+	return 0;
+}
+
 static int vmx_vcpu_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 {
 	u8 fail;
@@ -753,6 +1157,7 @@ static struct kvm_arch_ops vmx_arch_ops 
 	.decache_regs = vcpu_put_rsp_rip,
 
 	.run = vmx_vcpu_run,
+	.skip_emulated_instruction = skip_emulated_instruction,
 	.vmx_return = (unsigned long)kvm_vmx_return,
 };
 
