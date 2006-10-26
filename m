Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945905AbWJZRbB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945905AbWJZRbB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 13:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945909AbWJZRbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 13:31:00 -0400
Received: from il.qumranet.com ([62.219.232.206]:36787 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1945905AbWJZRa7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 13:30:59 -0400
Subject: [PATCH 9/13] KVM: define exit handlers
From: Avi Kivity <avi@qumranet.com>
Date: Thu, 26 Oct 2006 17:30:57 -0000
To: linux-kernel@vger.kernel.org, kvm-devel@lists.sourceforge.net
References: <4540EE2B.9020606@qumranet.com>
In-Reply-To: <4540EE2B.9020606@qumranet.com>
Message-Id: <20061026173057.3C070A0209@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This defines exit handlers for:

- exceptions (only page faults normally)
- control register access
- invlpg
- I/O instructions
- interrupt window management (exit when guest interrupts are enabled)

Signed-off-by: Yaniv Kamay <yaniv@qumranet.com>
Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -1643,6 +1643,210 @@ static void skip_emulated_instruction(st
 			     interruptibility & ~3);
 }
 
+static int emulator_read_std(unsigned long addr,
+			     unsigned long *val,
+			     unsigned int bytes,
+			     struct x86_emulate_ctxt *ctxt)
+{
+	struct kvm_vcpu *vcpu = ctxt->vcpu;
+	void *data = val;
+
+	while (bytes) {
+		gpa_t gpa = vcpu->mmu.gva_to_gpa(vcpu, addr);
+		unsigned offset = addr & (PAGE_SIZE-1);
+		unsigned tocopy = min(bytes, (unsigned)PAGE_SIZE - offset);
+		unsigned long pfn;
+		struct kvm_memory_slot *memslot;
+		void *page;
+
+		if (gpa == UNMAPPED_GVA)
+			return X86EMUL_PROPAGATE_FAULT;
+		pfn = gpa >> PAGE_SHIFT;
+		memslot = gfn_to_memslot(vcpu->kvm, pfn);
+		if (!memslot)
+			return X86EMUL_UNHANDLEABLE;
+		page = kmap_atomic(gfn_to_page(memslot, pfn), KM_USER0);
+
+		memcpy(data, page + offset, tocopy);
+
+		kunmap_atomic(page, KM_USER0);
+
+		bytes -= tocopy;
+		data += tocopy;
+		addr += tocopy;
+	}
+
+	return X86EMUL_CONTINUE;
+}
+
+static int emulator_write_std(unsigned long addr,
+			      unsigned long val,
+			      unsigned int bytes,
+			      struct x86_emulate_ctxt *ctxt)
+{
+	printk(KERN_ERR "emulator_write_std: addr %lx n %d\n",
+	       addr, bytes);
+	return X86EMUL_UNHANDLEABLE;
+}
+
+static int emulator_read_emulated(unsigned long addr,
+				  unsigned long *val,
+				  unsigned int bytes,
+				  struct x86_emulate_ctxt *ctxt)
+{
+	struct kvm_vcpu *vcpu = ctxt->vcpu;
+
+	if (vcpu->mmio_read_completed) {
+		memcpy(val, vcpu->mmio_data, bytes);
+		vcpu->mmio_read_completed = 0;
+		return X86EMUL_CONTINUE;
+	} else if (emulator_read_std(addr, val, bytes, ctxt)
+		   == X86EMUL_CONTINUE)
+		return X86EMUL_CONTINUE;
+	else {
+		gpa_t gpa = vcpu->mmu.gva_to_gpa(vcpu, addr);
+		if (gpa == UNMAPPED_GVA)
+			return vcpu_printf(vcpu, "not present\n"), X86EMUL_PROPAGATE_FAULT;
+		vcpu->mmio_needed = 1;
+		vcpu->mmio_phys_addr = gpa;
+		vcpu->mmio_size = bytes;
+		vcpu->mmio_is_write = 0;
+
+		return X86EMUL_UNHANDLEABLE;
+	}
+}
+
+static int emulator_write_emulated(unsigned long addr,
+				   unsigned long val,
+				   unsigned int bytes,
+				   struct x86_emulate_ctxt *ctxt)
+{
+	struct kvm_vcpu *vcpu = ctxt->vcpu;
+	gpa_t gpa = vcpu->mmu.gva_to_gpa(vcpu, addr);
+
+	if (gpa == UNMAPPED_GVA)
+		return X86EMUL_PROPAGATE_FAULT;
+
+	vcpu->mmio_needed = 1;
+	vcpu->mmio_phys_addr = gpa;
+	vcpu->mmio_size = bytes;
+	vcpu->mmio_is_write = 1;
+	memcpy(vcpu->mmio_data, &val, bytes);
+
+	return X86EMUL_CONTINUE;
+}
+
+static int emulator_cmpxchg_emulated(unsigned long addr,
+				     unsigned long old,
+				     unsigned long new,
+				     unsigned int bytes,
+				     struct x86_emulate_ctxt *ctxt)
+{
+	static int reported;
+
+	if (!reported) {
+		reported = 1;
+		printk(KERN_WARNING "kvm: emulating exchange as write\n");
+	}
+	return emulator_write_emulated(addr, new, bytes, ctxt);
+}
+
+static void report_emulation_failure(struct x86_emulate_ctxt *ctxt)
+{
+	static int reported;
+	u8 opcodes[4];
+	unsigned long rip = vmcs_readl(GUEST_RIP);
+	unsigned long rip_linear = rip + vmcs_readl(GUEST_CS_BASE);
+
+	if (reported)
+		return;
+
+	emulator_read_std(rip_linear, (void *)opcodes, 4, ctxt);
+
+	printk(KERN_ERR "emulation failed but !mmio_needed?"
+	       " rip %lx %02x %02x %02x %02x\n",
+	       rip, opcodes[0], opcodes[1], opcodes[2], opcodes[3]);
+	reported = 1;
+}
+
+struct x86_emulate_ops emulate_ops = {
+	.read_std            = emulator_read_std,
+	.write_std           = emulator_write_std,
+	.read_emulated       = emulator_read_emulated,
+	.write_emulated      = emulator_write_emulated,
+	.cmpxchg_emulated    = emulator_cmpxchg_emulated,
+};
+
+enum emulation_result {
+	EMULATE_DONE,       /* no further processing */
+	EMULATE_DO_MMIO,      /* kvm_run filled with mmio request */
+	EMULATE_FAIL,         /* can't emulate this instruction */
+};
+
+static int emulate_instruction(struct kvm_vcpu *vcpu,
+			       struct kvm_run *run,
+			       unsigned long cr2,
+			       u16 error_code)
+{
+	struct x86_emulate_ctxt emulate_ctxt;
+	int r;
+	u32 cs_ar;
+
+	vcpu_load_rsp_rip(vcpu);
+
+	cs_ar = vmcs_read32(GUEST_CS_AR_BYTES);
+
+	emulate_ctxt.vcpu = vcpu;
+	emulate_ctxt.eflags = vmcs_readl(GUEST_RFLAGS);
+	emulate_ctxt.cr2 = cr2;
+	emulate_ctxt.mode = (emulate_ctxt.eflags & X86_EFLAGS_VM)
+		? X86EMUL_MODE_REAL : (cs_ar & AR_L_MASK)
+		? X86EMUL_MODE_PROT64 :	(cs_ar & AR_DB_MASK)
+		? X86EMUL_MODE_PROT32 : X86EMUL_MODE_PROT16;
+
+	if (emulate_ctxt.mode == X86EMUL_MODE_PROT64) {
+		emulate_ctxt.cs_base = 0;
+		emulate_ctxt.ds_base = 0;
+		emulate_ctxt.es_base = 0;
+		emulate_ctxt.ss_base = 0;
+		emulate_ctxt.gs_base = 0;
+		emulate_ctxt.fs_base = 0;
+	} else {
+		emulate_ctxt.cs_base = vmcs_readl(GUEST_CS_BASE);
+		emulate_ctxt.ds_base = vmcs_readl(GUEST_DS_BASE);
+		emulate_ctxt.es_base = vmcs_readl(GUEST_ES_BASE);
+		emulate_ctxt.ss_base = vmcs_readl(GUEST_SS_BASE);
+		emulate_ctxt.gs_base = vmcs_readl(GUEST_GS_BASE);
+		emulate_ctxt.fs_base = vmcs_readl(GUEST_FS_BASE);
+	}
+
+	vcpu->mmio_is_write = 0;
+	r = x86_emulate_memop(&emulate_ctxt, &emulate_ops);
+
+	if ((r || vcpu->mmio_is_write) && run) {
+		run->mmio.phys_addr = vcpu->mmio_phys_addr;
+		memcpy(run->mmio.data, vcpu->mmio_data, 8);
+		run->mmio.len = vcpu->mmio_size;
+		run->mmio.is_write = vcpu->mmio_is_write;
+	}
+
+	if (r) {
+		if (!vcpu->mmio_needed) {
+			report_emulation_failure(&emulate_ctxt);
+			return EMULATE_FAIL;
+		}
+		return EMULATE_DO_MMIO;
+	}
+
+	vcpu_put_rsp_rip(vcpu);
+	vmcs_writel(GUEST_RFLAGS, emulate_ctxt.eflags);
+
+	if (vcpu->mmio_is_write)
+		return EMULATE_DO_MMIO;
+
+	return EMULATE_DONE;
+}
+
 static u64 mk_cr_64(u64 curr_cr, u32 new_val)
 {
 	return (curr_cr & ~((1ULL << 32) - 1)) | new_val;
@@ -1706,6 +1910,257 @@ void realmode_set_cr(struct kvm_vcpu *vc
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
 #ifdef __x86_64__
 
 static void set_efer(struct kvm_vcpu *vcpu, u64 efer)
@@ -1740,6 +2195,26 @@ static void set_efer(struct kvm_vcpu *vc
 
 #endif
 
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
 /*
  * The exit handlers return 1 if the exit was handled fully and guest execution
  * may resume.  Otherwise they set the kvm_run parameter to indicate what needs
@@ -1747,6 +2222,13 @@ static void set_efer(struct kvm_vcpu *vc
  */
 static int (*kvm_vmx_exit_handlers[])(struct kvm_vcpu *vcpu,
 				      struct kvm_run *kvm_run) = {
+	[EXIT_REASON_EXCEPTION_NMI]           = handle_exception,
+	[EXIT_REASON_EXTERNAL_INTERRUPT]      = handle_external_interrupt,
+	[EXIT_REASON_IO_INSTRUCTION]          = handle_io,
+	[EXIT_REASON_INVLPG]                  = handle_invlpg,
+	[EXIT_REASON_CR_ACCESS]               = handle_cr,
+	[EXIT_REASON_PENDING_INTERRUPT]       = handle_interrupt_window,
+	[EXIT_REASON_HLT]                     = handle_halt,
 };
 
 static const int kvm_vmx_max_exit_handlers =
