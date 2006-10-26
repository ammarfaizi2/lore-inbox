Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945918AbWJZRaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945918AbWJZRaF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 13:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945908AbWJZRaB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 13:30:01 -0400
Received: from il.qumranet.com ([62.219.232.206]:36019 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1945909AbWJZR37 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 13:29:59 -0400
Subject: [PATCH 8/13] KVM: vcpu execution loop
From: Avi Kivity <avi@qumranet.com>
Date: Thu, 26 Oct 2006 17:29:57 -0000
To: linux-kernel@vger.kernel.org, kvm-devel@lists.sourceforge.net
References: <4540EE2B.9020606@qumranet.com>
In-Reply-To: <4540EE2B.9020606@qumranet.com>
Message-Id: <20061026172957.308C2A0209@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This defines the KVM_RUN ioctl(), which enters guest mode, and a mechnism for
handling exits, either in-kernel or by userspace.  Actual users of the
mechanism are in later patches.

Also introduced are interrupt injection and the guest debugger.

Signed-off-by: Yaniv Kamay <yaniv@qumranet.com>
Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -1740,6 +1740,387 @@ static void set_efer(struct kvm_vcpu *vc
 
 #endif
 
+/*
+ * The exit handlers return 1 if the exit was handled fully and guest execution
+ * may resume.  Otherwise they set the kvm_run parameter to indicate what needs
+ * to be done to userspace and return 0.
+ */
+static int (*kvm_vmx_exit_handlers[])(struct kvm_vcpu *vcpu,
+				      struct kvm_run *kvm_run) = {
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
+static void inject_rmode_irq(struct kvm_vcpu *vcpu, int irq)
+{
+	u16 ent[2];
+	u16 cs;
+	u16 ip;
+	unsigned long flags;
+	unsigned long ss_base = vmcs_readl(GUEST_SS_BASE);
+	u16 sp =  vmcs_readl(GUEST_RSP);
+	u32 ss_limit = vmcs_read32(GUEST_SS_LIMIT);
+
+	if (sp > ss_limit || sp - 6 > sp) {
+		vcpu_printf(vcpu, "%s: #SS, rsp 0x%lx ss 0x%lx limit 0x%x\n",
+			    __FUNCTION__,
+			    vmcs_readl(GUEST_RSP),
+			    vmcs_readl(GUEST_SS_BASE),
+			    vmcs_read32(GUEST_SS_LIMIT));
+		return;
+	}
+
+	if (kvm_read_guest(vcpu, irq * sizeof(ent), sizeof(ent), &ent) !=
+								sizeof(ent)) {
+		vcpu_printf(vcpu, "%s: read guest err\n", __FUNCTION__);
+		return;
+	}
+
+	flags =  vmcs_readl(GUEST_RFLAGS);
+	cs =  vmcs_readl(GUEST_CS_BASE) >> 4;
+	ip =  vmcs_readl(GUEST_RIP);
+
+
+	if (kvm_write_guest(vcpu, ss_base + sp - 2, 2, &flags) != 2 ||
+	    kvm_write_guest(vcpu, ss_base + sp - 4, 2, &cs) != 2 ||
+	    kvm_write_guest(vcpu, ss_base + sp - 6, 2, &ip) != 2) {
+		vcpu_printf(vcpu, "%s: write guest err\n", __FUNCTION__);
+		return;
+	}
+
+	vmcs_writel(GUEST_RFLAGS, flags &
+		    ~( X86_EFLAGS_IF | X86_EFLAGS_AC | X86_EFLAGS_TF));
+	vmcs_write16(GUEST_CS_SELECTOR, ent[1]) ;
+	vmcs_writel(GUEST_CS_BASE, ent[1] << 4);
+	vmcs_writel(GUEST_RIP, ent[0]);
+	vmcs_writel(GUEST_RSP, (vmcs_readl(GUEST_RSP) & ~0xffff) | (sp - 6));
+}
+
+static void kvm_do_inject_irq(struct kvm_vcpu *vcpu)
+{
+	int word_index = __ffs(vcpu->irq_summary);
+	int bit_index = __ffs(vcpu->irq_pending[word_index]);
+	int irq = word_index * BITS_PER_LONG + bit_index;
+
+	clear_bit(bit_index, &vcpu->irq_pending[word_index]);
+	if (!vcpu->irq_pending[word_index])
+		clear_bit(word_index, &vcpu->irq_summary);
+
+	if (vcpu->rmode.active) {
+		inject_rmode_irq(vcpu, irq);
+		return;
+	}
+	vmcs_write32(VM_ENTRY_INTR_INFO_FIELD,
+			irq | INTR_TYPE_EXT_INTR | INTR_INFO_VALID_MASK);
+}
+
+static void kvm_try_inject_irq(struct kvm_vcpu *vcpu)
+{
+	if ((vmcs_readl(GUEST_RFLAGS) & X86_EFLAGS_IF)
+	    && (vmcs_read32(GUEST_INTERRUPTIBILITY_INFO) & 3) == 0)
+		/*
+		 * Interrupts enabled, and not blocked by sti or mov ss. Good.
+		 */
+		kvm_do_inject_irq(vcpu);
+	else
+		/*
+		 * Interrupts blocked.  Wait for unblock.
+		 */
+		vmcs_write32(CPU_BASED_VM_EXEC_CONTROL,
+			     vmcs_read32(CPU_BASED_VM_EXEC_CONTROL)
+			     | CPU_BASED_VIRTUAL_INTR_PENDING);
+}
+
+static void kvm_guest_debug_pre(struct kvm_vcpu *vcpu)
+{
+	struct kvm_guest_debug *dbg = &vcpu->guest_debug;
+
+	set_debugreg(dbg->bp[0], 0);
+	set_debugreg(dbg->bp[1], 1);
+	set_debugreg(dbg->bp[2], 2);
+	set_debugreg(dbg->bp[3], 3);
+
+	if (dbg->singlestep) {
+		unsigned long flags;
+
+		flags = vmcs_readl(GUEST_RFLAGS);
+		flags |= X86_EFLAGS_TF | X86_EFLAGS_RF;
+		vmcs_writel(GUEST_RFLAGS, flags);
+	}
+}
+
+static void load_msrs(struct vmx_msr_entry *e)
+{
+	int i;
+
+	for (i = NUM_AUTO_MSRS; i < NR_VMX_MSR; ++i)
+		wrmsrl(e[i].index, e[i].data);
+}
+
+static void save_msrs(struct vmx_msr_entry *e, int msr_index)
+{
+	for (; msr_index < NR_VMX_MSR; ++msr_index)
+		rdmsrl(e[msr_index].index, e[msr_index].data);
+}
+
+static int kvm_dev_ioctl_run(struct kvm *kvm, struct kvm_run *kvm_run)
+{
+	struct kvm_vcpu *vcpu;
+	u8 fail;
+	u16 fs_sel, gs_sel, ldt_sel;
+	int fs_gs_ldt_reload_needed;
+
+	if (kvm_run->vcpu < 0 || kvm_run->vcpu >= KVM_MAX_VCPUS)
+		return -EINVAL;
+
+	vcpu = vcpu_load(kvm, kvm_run->vcpu);
+	if (!vcpu)
+		return -ENOENT;
+
+	if (kvm_run->emulated) {
+		skip_emulated_instruction(vcpu);
+		kvm_run->emulated = 0;
+	}
+
+	if (kvm_run->mmio_completed) {
+		memcpy(vcpu->mmio_data, kvm_run->mmio.data, 8);
+		vcpu->mmio_read_completed = 1;
+	}
+
+	vcpu->mmio_needed = 0;
+
+again:
+	/*
+	 * Set host fs and gs selectors.  Unfortunately, 22.2.3 does not
+	 * allow segment selectors with cpl > 0 or ti == 1.
+	 */
+	fs_sel = read_fs();
+	gs_sel = read_gs();
+	ldt_sel = read_ldt();
+	fs_gs_ldt_reload_needed = (fs_sel & 7) | (gs_sel & 7) | ldt_sel;
+	if (!fs_gs_ldt_reload_needed) {
+		vmcs_write16(HOST_FS_SELECTOR, fs_sel);
+		vmcs_write16(HOST_GS_SELECTOR, gs_sel);
+	} else {
+		vmcs_write16(HOST_FS_SELECTOR, 0);
+		vmcs_write16(HOST_GS_SELECTOR, 0);
+	}
+
+#ifdef __x86_64__
+	vmcs_writel(HOST_FS_BASE, read_msr(MSR_FS_BASE));
+	vmcs_writel(HOST_GS_BASE, read_msr(MSR_GS_BASE));
+#endif
+
+	if (vcpu->irq_summary &&
+	    !(vmcs_read32(VM_ENTRY_INTR_INFO_FIELD) & INTR_INFO_VALID_MASK))
+		kvm_try_inject_irq(vcpu);
+
+	if (vcpu->guest_debug.enabled)
+		kvm_guest_debug_pre(vcpu);
+
+	fx_save(vcpu->host_fx_image);
+	fx_restore(vcpu->guest_fx_image);
+
+	save_msrs(vcpu->host_msrs, 0);
+	load_msrs(vcpu->guest_msrs);
+
+	asm (
+		/* Store host registers */
+		"pushf \n\t"
+#ifdef __x86_64__
+		"push %%rax; push %%rbx; push %%rdx;"
+		"push %%rsi; push %%rdi; push %%rbp;"
+		"push %%r8;  push %%r9;  push %%r10; push %%r11;"
+		"push %%r12; push %%r13; push %%r14; push %%r15;"
+		"push %%rcx \n\t"
+		"vmwrite %%rsp, %2 \n\t"
+#else
+		"pusha; push %%ecx \n\t"
+		"vmwrite %%esp, %2 \n\t"
+#endif
+		/* Check if vmlaunch of vmresume is needed */
+		"cmp $0, %1 \n\t"
+		/* Load guest registers.  Don't clobber flags. */
+#ifdef __x86_64__
+		"mov %c[cr2](%3), %%rax \n\t"
+		"mov %%rax, %%cr2 \n\t"
+		"mov %c[rax](%3), %%rax \n\t"
+		"mov %c[rbx](%3), %%rbx \n\t"
+		"mov %c[rdx](%3), %%rdx \n\t"
+		"mov %c[rsi](%3), %%rsi \n\t"
+		"mov %c[rdi](%3), %%rdi \n\t"
+		"mov %c[rbp](%3), %%rbp \n\t"
+		"mov %c[r8](%3),  %%r8  \n\t"
+		"mov %c[r9](%3),  %%r9  \n\t"
+		"mov %c[r10](%3), %%r10 \n\t"
+		"mov %c[r11](%3), %%r11 \n\t"
+		"mov %c[r12](%3), %%r12 \n\t"
+		"mov %c[r13](%3), %%r13 \n\t"
+		"mov %c[r14](%3), %%r14 \n\t"
+		"mov %c[r15](%3), %%r15 \n\t"
+		"mov %c[rcx](%3), %%rcx \n\t" /* kills %3 (rcx) */
+#else
+		"mov %c[cr2](%3), %%eax \n\t"
+		"mov %%eax,   %%cr2 \n\t"
+		"mov %c[rax](%3), %%eax \n\t"
+		"mov %c[rbx](%3), %%ebx \n\t"
+		"mov %c[rdx](%3), %%edx \n\t"
+		"mov %c[rsi](%3), %%esi \n\t"
+		"mov %c[rdi](%3), %%edi \n\t"
+		"mov %c[rbp](%3), %%ebp \n\t"
+		"mov %c[rcx](%3), %%ecx \n\t" /* kills %3 (ecx) */
+#endif
+		/* Enter guest mode */
+		"jne launched \n\t"
+		"vmlaunch \n\t"
+		"jmp kvm_vmx_return \n\t"
+		"launched: vmresume \n\t"
+		".globl kvm_vmx_return \n\t"
+		"kvm_vmx_return: "
+		/* Save guest registers, load host registers, keep flags */
+#ifdef __x86_64__
+		"xchg %3,     0(%%rsp) \n\t"
+		"mov %%rax, %c[rax](%3) \n\t"
+		"mov %%rbx, %c[rbx](%3) \n\t"
+		"pushq 0(%%rsp); popq %c[rcx](%3) \n\t"
+		"mov %%rdx, %c[rdx](%3) \n\t"
+		"mov %%rsi, %c[rsi](%3) \n\t"
+		"mov %%rdi, %c[rdi](%3) \n\t"
+		"mov %%rbp, %c[rbp](%3) \n\t"
+		"mov %%r8,  %c[r8](%3) \n\t"
+		"mov %%r9,  %c[r9](%3) \n\t"
+		"mov %%r10, %c[r10](%3) \n\t"
+		"mov %%r11, %c[r11](%3) \n\t"
+		"mov %%r12, %c[r12](%3) \n\t"
+		"mov %%r13, %c[r13](%3) \n\t"
+		"mov %%r14, %c[r14](%3) \n\t"
+		"mov %%r15, %c[r15](%3) \n\t"
+		"mov %%cr2, %%rax   \n\t"
+		"mov %%rax, %c[cr2](%3) \n\t"
+		"mov 0(%%rsp), %3 \n\t"
+
+		"pop  %%rcx; pop  %%r15; pop  %%r14; pop  %%r13; pop  %%r12;"
+		"pop  %%r11; pop  %%r10; pop  %%r9;  pop  %%r8;"
+		"pop  %%rbp; pop  %%rdi; pop  %%rsi;"
+		"pop  %%rdx; pop  %%rbx; pop  %%rax \n\t"
+#else
+		"xchg %3, 0(%%esp) \n\t"
+		"mov %%eax, %c[rax](%3) \n\t"
+		"mov %%ebx, %c[rbx](%3) \n\t"
+		"pushl 0(%%esp); popl %c[rcx](%3) \n\t"
+		"mov %%edx, %c[rdx](%3) \n\t"
+		"mov %%esi, %c[rsi](%3) \n\t"
+		"mov %%edi, %c[rdi](%3) \n\t"
+		"mov %%ebp, %c[rbp](%3) \n\t"
+		"mov %%cr2, %%eax  \n\t"
+		"mov %%eax, %c[cr2](%3) \n\t"
+		"mov 0(%%esp), %3 \n\t"
+
+		"pop %%ecx; popa \n\t"
+#endif
+		"setbe %0 \n\t"
+		"popf \n\t"
+	      : "=g" (fail)
+	      : "r"(vcpu->launched), "r"((unsigned long)HOST_RSP),
+		"c"(vcpu),
+		[rax]"i"(offsetof(struct kvm_vcpu, regs[VCPU_REGS_RAX])),
+		[rbx]"i"(offsetof(struct kvm_vcpu, regs[VCPU_REGS_RBX])),
+		[rcx]"i"(offsetof(struct kvm_vcpu, regs[VCPU_REGS_RCX])),
+		[rdx]"i"(offsetof(struct kvm_vcpu, regs[VCPU_REGS_RDX])),
+		[rsi]"i"(offsetof(struct kvm_vcpu, regs[VCPU_REGS_RSI])),
+		[rdi]"i"(offsetof(struct kvm_vcpu, regs[VCPU_REGS_RDI])),
+		[rbp]"i"(offsetof(struct kvm_vcpu, regs[VCPU_REGS_RBP])),
+#ifdef __x86_64__
+		[r8 ]"i"(offsetof(struct kvm_vcpu, regs[VCPU_REGS_R8 ])),
+		[r9 ]"i"(offsetof(struct kvm_vcpu, regs[VCPU_REGS_R9 ])),
+		[r10]"i"(offsetof(struct kvm_vcpu, regs[VCPU_REGS_R10])),
+		[r11]"i"(offsetof(struct kvm_vcpu, regs[VCPU_REGS_R11])),
+		[r12]"i"(offsetof(struct kvm_vcpu, regs[VCPU_REGS_R12])),
+		[r13]"i"(offsetof(struct kvm_vcpu, regs[VCPU_REGS_R13])),
+		[r14]"i"(offsetof(struct kvm_vcpu, regs[VCPU_REGS_R14])),
+		[r15]"i"(offsetof(struct kvm_vcpu, regs[VCPU_REGS_R15])),
+#endif
+		[cr2]"i"(offsetof(struct kvm_vcpu, cr2))
+	      : "cc", "memory" );
+
+	++kvm_stat.exits;
+
+	save_msrs(vcpu->guest_msrs, NUM_AUTO_MSRS);
+	load_msrs(vcpu->host_msrs);
+
+	fx_save(vcpu->guest_fx_image);
+	fx_restore(vcpu->host_fx_image);
+
+#ifndef __x86_64__
+	asm ("mov %0, %%ds; mov %0, %%es" : : "r"(__USER_DS));
+#endif
+
+	kvm_run->exit_type = 0;
+	if (fail) {
+		kvm_run->exit_type = KVM_EXIT_TYPE_FAIL_ENTRY;
+		kvm_run->exit_reason = vmcs_read32(VM_INSTRUCTION_ERROR);
+	} else {
+		if (fs_gs_ldt_reload_needed) {
+			load_ldt(ldt_sel);
+			load_fs(fs_sel);
+			/*
+			 * If we have to reload gs, we must take care to
+			 * preserve our gs base.
+			 */
+			local_irq_disable();
+			load_gs(gs_sel);
+#ifdef __x86_64__
+			wrmsrl(MSR_GS_BASE, vmcs_readl(HOST_GS_BASE));
+#endif
+			local_irq_enable();
+
+			reload_tss();
+		}
+		vcpu->launched = 1;
+		kvm_run->exit_type = KVM_EXIT_TYPE_VM_EXIT;
+		if (kvm_handle_exit(kvm_run, vcpu)) {
+			/* Give scheduler a change to reschedule. */
+			vcpu_put(vcpu);
+			if (signal_pending(current)) {
+				++kvm_stat.signal_exits;
+				return -EINTR;
+			}
+			cond_resched();
+			/* Cannot fail -  no vcpu unplug yet. */
+			vcpu_load(kvm, vcpu_slot(vcpu));
+			goto again;
+		}
+	}
+
+	vcpu_put(vcpu);
+	return 0;
+}
+
 static int kvm_dev_ioctl_get_regs(struct kvm *kvm, struct kvm_regs *regs)
 {
 	struct kvm_vcpu *vcpu;
@@ -1991,6 +2372,80 @@ static int kvm_dev_ioctl_translate(struc
 	return 0;
 }
 
+static int kvm_dev_ioctl_interrupt(struct kvm *kvm, struct kvm_interrupt *irq)
+{
+	struct kvm_vcpu *vcpu;
+
+	if (irq->vcpu < 0 || irq->vcpu >= KVM_MAX_VCPUS)
+		return -EINVAL;
+	if (irq->irq < 0 || irq->irq >= 256)
+		return -EINVAL;
+	vcpu = vcpu_load(kvm, irq->vcpu);
+	if (!vcpu)
+		return -ENOENT;
+
+	set_bit(irq->irq, vcpu->irq_pending);
+	set_bit(irq->irq / BITS_PER_LONG, &vcpu->irq_summary);
+
+	vcpu_put(vcpu);
+
+	return 0;
+}
+
+static int kvm_dev_ioctl_debug_guest(struct kvm *kvm,
+				     struct kvm_debug_guest *dbg)
+{
+	struct kvm_vcpu *vcpu;
+	unsigned long dr7 = 0x400;
+	u32 exception_bitmap;
+	int old_singlestep;
+
+	if (dbg->vcpu < 0 || dbg->vcpu >= KVM_MAX_VCPUS)
+		return -EINVAL;
+	vcpu = vcpu_load(kvm, dbg->vcpu);
+	if (!vcpu)
+		return -ENOENT;
+
+	exception_bitmap = vmcs_read32(EXCEPTION_BITMAP);
+	old_singlestep = vcpu->guest_debug.singlestep;
+
+	vcpu->guest_debug.enabled = dbg->enabled;
+	if (vcpu->guest_debug.enabled) {
+		int i;
+
+		dr7 |= 0x200;  /* exact */
+		for (i = 0; i < 4; ++i) {
+			if (!dbg->breakpoints[i].enabled)
+				continue;
+			vcpu->guest_debug.bp[i] = dbg->breakpoints[i].address;
+			dr7 |= 2 << (i*2);    /* global enable */
+			dr7 |= 0 << (i*4+16); /* execution breakpoint */
+		}
+
+		exception_bitmap |= (1u << 1);  /* Trap debug exceptions */
+
+		vcpu->guest_debug.singlestep = dbg->singlestep;
+	} else {
+		exception_bitmap &= ~(1u << 1); /* Ignore debug exceptions */
+		vcpu->guest_debug.singlestep = 0;
+	}
+
+	if (old_singlestep && !vcpu->guest_debug.singlestep) {
+		unsigned long flags;
+
+		flags = vmcs_readl(GUEST_RFLAGS);
+		flags &= ~(X86_EFLAGS_TF | X86_EFLAGS_RF);
+		vmcs_writel(GUEST_RFLAGS, flags);
+	}
+
+	vmcs_write32(EXCEPTION_BITMAP, exception_bitmap);
+	vmcs_writel(GUEST_DR7, dr7);
+
+	vcpu_put(vcpu);
+
+	return 0;
+}
+
 static long kvm_dev_ioctl(struct file *filp,
 			  unsigned int ioctl, unsigned long arg)
 {
@@ -2004,6 +2459,21 @@ static long kvm_dev_ioctl(struct file *f
 			goto out;
 		break;
 	}
+	case KVM_RUN: {
+		struct kvm_run kvm_run;
+
+		r = -EFAULT;
+		if (copy_from_user(&kvm_run, (void *)arg, sizeof kvm_run))
+			goto out;
+		r = kvm_dev_ioctl_run(kvm, &kvm_run);
+		if (r < 0)
+			goto out;
+		r = -EFAULT;
+		if (copy_to_user((void *)arg, &kvm_run, sizeof kvm_run))
+			goto out;
+		r = 0;
+		break;
+	}
 	case KVM_GET_REGS: {
 		struct kvm_regs kvm_regs;
 
@@ -2073,6 +2543,30 @@ static long kvm_dev_ioctl(struct file *f
 		r = 0;
 		break;
 	}
+	case KVM_INTERRUPT: {
+		struct kvm_interrupt irq;
+
+		r = -EFAULT;
+		if (copy_from_user(&irq, (void *)arg, sizeof irq))
+			goto out;
+		r = kvm_dev_ioctl_interrupt(kvm, &irq);
+		if (r)
+			goto out;
+		r = 0;
+		break;
+	}
+	case KVM_DEBUG_GUEST: {
+		struct kvm_debug_guest dbg;
+
+		r = -EFAULT;
+		if (copy_from_user(&dbg, (void *)arg, sizeof dbg))
+			goto out;
+		r = kvm_dev_ioctl_debug_guest(kvm, &dbg);
+		if (r)
+			goto out;
+		r = 0;
+		break;
+	}
 	case KVM_SET_MEMORY_REGION: {
 		struct kvm_memory_region kvm_mem;
 
