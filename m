Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964852AbWJWNbg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964852AbWJWNbg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 09:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964857AbWJWNbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 09:31:22 -0400
Received: from il.qumranet.com ([62.219.232.206]:29141 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S964852AbWJWNbK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 09:31:10 -0400
Subject: [PATCH 9/13] KVM: define exit handlers
From: Avi Kivity <avi@qumranet.com>
Date: Mon, 23 Oct 2006 13:31:06 -0000
To: avi@qumranet.com, linux-kernel@vger.kernel.org
References: <453CC390.9080508@qumranet.com>
In-Reply-To: <453CC390.9080508@qumranet.com>
Message-Id: <20061023133106.C19DB250143@cleopatra.q>
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
@@ -32,6 +32,7 @@
 #include <linux/file.h>
 
 #include "vmx.h"
+#include "x86_emulate.h"
 
 MODULE_AUTHOR("Qumranet");
 MODULE_LICENSE("GPL");
@@ -655,6 +656,93 @@ static void vmcs_write64(unsigned long f
 #endif
 }
 
+#ifdef __x86_64__
+#define HOST_IS_64 1
+#else
+#define HOST_IS_64 0
+#endif
+
+#define GUEST_IS_64 HOST_IS_64
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
+			(vmcs_readl(CR0_READ_SHADOW) & CR4_VME_MASK) );
+
+	vmcs_write32(EXCEPTION_BITMAP, 1 << PF_VECTOR);
+
+	#define FIX_PMODE_DATASEG(seg, save) {				\
+			vmcs_write16(GUEST_##seg##_SELECTOR, 0); 	\
+			vmcs_writel(GUEST_##seg##_BASE, 0); 		\
+			vmcs_write32(GUEST_##seg##_LIMIT, 0xffff);	\
+			vmcs_write32(GUEST_##seg##_AR_BYTES, 0x93);	\
+	}
+
+	FIX_PMODE_DATASEG(SS, vcpu->rmode.ss);
+	FIX_PMODE_DATASEG(ES, vcpu->rmode.es);
+	FIX_PMODE_DATASEG(DS, vcpu->rmode.ds);
+	FIX_PMODE_DATASEG(GS, vcpu->rmode.gs);
+	FIX_PMODE_DATASEG(FS, vcpu->rmode.fs);
+
+	vmcs_write16(GUEST_CS_SELECTOR,
+		     vmcs_read16(GUEST_CS_SELECTOR) & ~SELECTOR_RPL_MASK);
+	vmcs_write32(GUEST_CS_AR_BYTES, 0x9b);
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
+	vmcs_write32(EXCEPTION_BITMAP, ~0);
+
+	#define FIX_RMODE_SEG(seg, save) {				   \
+		vmcs_write16(GUEST_##seg##_SELECTOR, 			   \
+					vmcs_readl(GUEST_##seg##_BASE) >> 4); \
+		vmcs_write32(GUEST_##seg##_LIMIT, 0xffff);		   \
+		vmcs_write32(GUEST_##seg##_AR_BYTES, 0xf3);		   \
+	}
+
+	vmcs_write32(GUEST_CS_AR_BYTES, 0xf3);
+	vmcs_write16(GUEST_CS_SELECTOR, vmcs_readl(GUEST_CS_BASE) >> 4);
+
+	FIX_RMODE_SEG(ES, vcpu->rmode.es);
+	FIX_RMODE_SEG(DS, vcpu->rmode.ds);
+	FIX_RMODE_SEG(SS, vcpu->rmode.ss);
+	FIX_RMODE_SEG(GS, vcpu->rmode.gs);
+	FIX_RMODE_SEG(FS, vcpu->rmode.fs);
+}
+
 static int rmode_tss_base(struct kvm* kvm)
 {
 	gfn_t base_gfn = kvm->memslots[0].base_gfn + kvm->memslots[0].npages - 3;
@@ -1285,6 +1373,464 @@ static void skip_emulated_instruction(st
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
+static u64 mk_cr_64(u64 curr_cr, u32 new_val)
+{
+	return (curr_cr & ~((1ULL << 32) - 1)) | new_val;
+}
+
+void realmode_lgdt(struct kvm_vcpu *vcpu, u16 limit, unsigned long base)
+{
+	vmcs_writel(GUEST_GDTR_BASE, base);
+	vmcs_write32(GUEST_GDTR_LIMIT, limit);
+}
+
+void realmode_lidt(struct kvm_vcpu *vcpu, u16 limit, unsigned long base)
+{
+	vmcs_writel(GUEST_IDTR_BASE, base);
+	vmcs_write32(GUEST_IDTR_LIMIT, limit);
+}
+
+void realmode_lmsw(struct kvm_vcpu *vcpu, unsigned long msw,
+		   unsigned long *rflags)
+{
+	lmsw(vcpu, msw);
+	*rflags = vmcs_readl(GUEST_RFLAGS);
+}
+
+unsigned long realmode_get_cr(struct kvm_vcpu *vcpu, int cr)
+{
+	switch (cr) {
+	case 0:
+		return guest_cr0();
+	case 2:
+		return vcpu->cr2;
+	case 3:
+		return vcpu->cr3;
+	case 4:
+		return guest_cr4();
+	default:
+		vcpu_printf(vcpu, "%s: unexpected cr %u\n", __FUNCTION__, cr);
+		return 0;
+	}
+}
+
+void realmode_set_cr(struct kvm_vcpu *vcpu, int cr, unsigned long val,
+		     unsigned long *rflags)
+{
+	switch (cr) {
+	case 0:
+		set_cr0(vcpu, mk_cr_64(guest_cr0(), val));
+		*rflags = vmcs_readl(GUEST_RFLAGS);
+		break;
+	case 2:
+		vcpu->cr2 = val;
+		break;
+	case 3:
+		set_cr3(vcpu, val);
+		break;
+	case 4:
+		set_cr4(vcpu, mk_cr_64(guest_cr4(), val));
+		break;
+	default:
+		vcpu_printf(vcpu, "%s: unexpected cr %u\n", __FUNCTION__, cr);
+	}
+}
+
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
+		printk("%s: unexpected, vectoring info 0x%x intr info 0x%x\n",
+			       __FUNCTION__, vect_info, intr_info);
+	}
+
+	if (is_external_interrupt(vect_info)) {
+		int irq = vect_info & VECTORING_INFO_VECTOR_MASK;
+		set_bit(irq, vcpu->irq_pending);
+		set_bit(irq / BITS_PER_LONG, &vcpu->irq_summary);
+	}
+
+	if ((intr_info & INTR_INFO_INTR_TYPE_MASK) == 0x200) { /* nmi */
+		asm ( "int $2" );
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
+
+static void inject_gp(struct kvm_vcpu *vcpu)
+{
+	printk("inject_general_protection: rip 0x%lx\n",
+		 vmcs_readl(GUEST_RIP));
+	vmcs_write32(VM_ENTRY_EXCEPTION_ERROR_CODE, 0);
+	vmcs_write32(VM_ENTRY_INTR_INFO_FIELD,
+		     GP_VECTOR |
+		     INTR_TYPE_EXCEPTION |
+		     INTR_INFO_DELIEVER_CODE_MASK |
+		     INTR_INFO_VALID_MASK);
+}
+
 static int pdptrs_have_reserved_bits_set(struct kvm_vcpu *vcpu,
 					 unsigned long cr3)
 {
@@ -1503,6 +2049,79 @@ static void __set_cr4(struct kvm_vcpu *v
 		    KVM_RMODE_VM_CR4_ALWAYS_ON : KVM_PMODE_VM_CR4_ALWAYS_ON));
 }
 
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
+			printk("handle_cr: read CR8 cpu bug (AA15) !!!!!!!!!!!!!!!!!\n");
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
 #define EFER_RESERVED_BITS 0xfffffffffffff2fe
 
@@ -1556,6 +2175,26 @@ static void __set_efer(struct kvm_vcpu *
 }
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
@@ -1563,6 +2202,13 @@ static void __set_efer(struct kvm_vcpu *
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
