Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964842AbWJWNbg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964842AbWJWNbg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 09:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964852AbWJWNbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 09:31:24 -0400
Received: from il.qumranet.com ([62.219.232.206]:28629 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S964856AbWJWNbA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 09:31:00 -0400
Subject: [PATCH 8/13] KVM: vcpu execution loop
From: Avi Kivity <avi@qumranet.com>
Date: Mon, 23 Oct 2006 13:30:56 -0000
To: avi@qumranet.com, linux-kernel@vger.kernel.org
References: <453CC390.9080508@qumranet.com>
In-Reply-To: <453CC390.9080508@qumranet.com>
Message-Id: <20061023133056.B3615250143@cleopatra.q>
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
@@ -1266,6 +1266,25 @@ void mark_page_dirty(struct kvm *kvm, gf
 	}
 }
 
+static void skip_emulated_instruction(struct kvm_vcpu *vcpu)
+{
+	unsigned long rip;
+	u32 interruptibility;
+
+	rip = vmcs_readl(GUEST_RIP);
+	rip += vmcs_read32(VM_EXIT_INSTRUCTION_LEN);
+	vmcs_writel(GUEST_RIP, rip);
+
+	/*
+	 * We emulated an instruction, so temporary interrupt blocking
+	 * should be removed, if set.
+	 */
+	interruptibility = vmcs_read32(GUEST_INTERRUPTIBILITY_INFO);
+	if (interruptibility & 3)
+		vmcs_write32(GUEST_INTERRUPTIBILITY_INFO,
+			     interruptibility & ~3);
+}
+
 static int pdptrs_have_reserved_bits_set(struct kvm_vcpu *vcpu,
 					 unsigned long cr3)
 {
@@ -1537,6 +1524,42 @@ static void __set_efer(struct kvm_vcpu *
 }
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
+		printk("%s: unexpected, valid vectoring info and exit"
+		       " reason is 0x%x\n", __FUNCTION__, exit_reason);
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
 static void inject_rmode_irq(struct kvm_vcpu *vcpu, int irq)
 {
 	u16 ent[2];
@@ -1617,6 +1640,24 @@ static void kvm_try_inject_irq(struct kv
 			     | CPU_BASED_VIRTUAL_INTR_PENDING);
 }
 
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
 static void load_msrs(struct vmx_msr_entry *e)
 {
 	int i;
@@ -1631,6 +1672,239 @@ static void save_msrs(struct vmx_msr_ent
 		rdmsrl(e[msr_index].index, e[msr_index].data);
 }
 
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
+	asm ( "mov %0, %%ds; mov %0, %%es" : : "r"(__USER_DS) );
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
@@ -1879,6 +2153,80 @@ static int kvm_dev_ioctl_translate(struc
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
@@ -1892,6 +2240,21 @@ static long kvm_dev_ioctl(struct file *f
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
 
@@ -1961,6 +2324,30 @@ static long kvm_dev_ioctl(struct file *f
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
 
