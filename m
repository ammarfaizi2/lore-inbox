Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758108AbWK0MYm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758108AbWK0MYm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 07:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758110AbWK0MYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 07:24:42 -0500
Received: from il.qumranet.com ([62.219.232.206]:6066 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1758108AbWK0MYk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 07:24:40 -0500
Subject: [PATCH 14/38] KVM: Make the vcpu execution loop an arch operation
From: Avi Kivity <avi@qumranet.com>
Date: Mon, 27 Nov 2006 12:24:37 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <456AD5C6.1090406@qumranet.com>
In-Reply-To: <456AD5C6.1090406@qumranet.com>
Message-Id: <20061127122437.ACBEB25015E@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm.h
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm.h
+++ linux-2.6/drivers/kvm/kvm.h
@@ -264,6 +264,9 @@ struct kvm_arch_ops {
 	void (*set_gdt)(struct kvm_vcpu *vcpu, struct descriptor_table *dt);
 	void (*cache_regs)(struct kvm_vcpu *vcpu);
 	void (*decache_regs)(struct kvm_vcpu *vcpu);
+
+	int (*run)(struct kvm_vcpu *vcpu, struct kvm_run *run);
+	unsigned long vmx_return; /* temporary hack */
 };
 
 extern struct kvm_stat kvm_stat;
@@ -306,6 +309,11 @@ unsigned long realmode_get_cr(struct kvm
 void realmode_set_cr(struct kvm_vcpu *vcpu, int cr, unsigned long value,
 		     unsigned long *rflags);
 
+void load_msrs(struct vmx_msr_entry *e, int n);
+void save_msrs(struct vmx_msr_entry *e, int n);
+void kvm_resched(struct kvm_vcpu *vcpu);
+int kvm_handle_exit(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu);
+
 int kvm_read_guest(struct kvm_vcpu *vcpu,
 	       gva_t addr,
 	       unsigned long size,
@@ -398,6 +406,69 @@ static inline struct kvm_mmu_page *page_
 	return (struct kvm_mmu_page *)page->private;
 }
 
+static inline u16 read_fs(void)
+{
+	u16 seg;
+	asm ("mov %%fs, %0" : "=g"(seg));
+	return seg;
+}
+
+static inline u16 read_gs(void)
+{
+	u16 seg;
+	asm ("mov %%gs, %0" : "=g"(seg));
+	return seg;
+}
+
+static inline u16 read_ldt(void)
+{
+	u16 ldt;
+	asm ("sldt %0" : "=g"(ldt));
+	return ldt;
+}
+
+static inline void load_fs(u16 sel)
+{
+	asm ("mov %0, %%fs" : : "rm"(sel));
+}
+
+static inline void load_gs(u16 sel)
+{
+	asm ("mov %0, %%gs" : : "rm"(sel));
+}
+
+#ifndef load_ldt
+static inline void load_ldt(u16 sel)
+{
+	asm ("lldt %0" : : "g"(sel));
+}
+#endif
+
+#ifdef __x86_64__
+static inline unsigned long read_msr(unsigned long msr)
+{
+	u64 value;
+
+	rdmsrl(msr, value);
+	return value;
+}
+#endif
+
+static inline void fx_save(void *image)
+{
+	asm ("fxsave (%0)":: "r" (image));
+}
+
+static inline void fx_restore(void *image)
+{
+	asm ("fxrstor (%0)":: "r" (image));
+}
+
+static inline void fpu_init(void)
+{
+	asm ("finit");
+}
+
 #define ASM_VMX_VMCLEAR_RAX       ".byte 0x66, 0x0f, 0xc7, 0x30"
 #define ASM_VMX_VMLAUNCH          ".byte 0x0f, 0x01, 0xc2"
 #define ASM_VMX_VMRESUME          ".byte 0x0f, 0x01, 0xc3"
Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -44,6 +44,7 @@ MODULE_LICENSE("GPL");
 
 struct kvm_arch_ops *kvm_arch_ops;
 struct kvm_stat kvm_stat;
+EXPORT_SYMBOL_GPL(kvm_stat);
 
 static struct kvm_stats_debugfs_item {
 	const char *name;
@@ -108,16 +109,6 @@ static const u32 vmx_msr_index[] = {
 };
 #define NR_VMX_MSR (sizeof(vmx_msr_index) / sizeof(*vmx_msr_index))
 
-#ifdef __x86_64__
-/*
- * avoid save/load MSR_SYSCALL_MASK and MSR_LSTAR by std vt
- * mechanism (cpu bug AA24)
- */
-#define NR_BAD_MSRS 2
-#else
-#define NR_BAD_MSRS 0
-#endif
-
 #define TSS_IOPB_BASE_OFFSET 0x66
 #define TSS_BASE_SIZE 0x68
 #define TSS_IOPB_SIZE (65536 / 8)
@@ -165,59 +156,6 @@ static void get_idt(struct descriptor_ta
 	asm ("sidt %0" : "=m"(*table));
 }
 
-static u16 read_fs(void)
-{
-	u16 seg;
-	asm ("mov %%fs, %0" : "=g"(seg));
-	return seg;
-}
-
-static u16 read_gs(void)
-{
-	u16 seg;
-	asm ("mov %%gs, %0" : "=g"(seg));
-	return seg;
-}
-
-static u16 read_ldt(void)
-{
-	u16 ldt;
-	asm ("sldt %0" : "=g"(ldt));
-	return ldt;
-}
-
-static void load_fs(u16 sel)
-{
-	asm ("mov %0, %%fs" : : "rm"(sel));
-}
-
-static void load_gs(u16 sel)
-{
-	asm ("mov %0, %%gs" : : "rm"(sel));
-}
-
-#ifndef load_ldt
-static void load_ldt(u16 sel)
-{
-	asm ("lldt %0" : : "g"(sel));
-}
-#endif
-
-static void fx_save(void *image)
-{
-	asm ("fxsave (%0)":: "r" (image));
-}
-
-static void fx_restore(void *image)
-{
-	asm ("fxrstor (%0)":: "r" (image));
-}
-
-static void fpu_init(void)
-{
-	asm ("finit");
-}
-
 struct segment_descriptor {
 	u16 limit_low;
 	u16 base_low;
@@ -278,23 +216,6 @@ static unsigned long read_tr_base(void)
 	return segment_base(tr);
 }
 
-static void reload_tss(void)
-{
-#ifndef __x86_64__
-
-	/*
-	 * VT restores TR but not its size.  Useless.
-	 */
-	struct descriptor_table gdt;
-	struct segment_descriptor *descs;
-
-	get_gdt(&gdt);
-	descs = (void *)gdt.base;
-	descs[GDT_ENTRY_TSS].type = 9; /* available TSS */
-	load_TR_desc();
-#endif
-}
-
 DEFINE_PER_CPU(struct vmcs *, vmxarea);
 EXPORT_SYMBOL_GPL(per_cpu__vmxarea); /* temporary hack */
 static DEFINE_PER_CPU(struct vmcs *, current_vmcs);
@@ -306,24 +227,12 @@ struct vmcs_descriptor {
 } vmcs_descriptor;
 EXPORT_SYMBOL_GPL(vmcs_descriptor);
 
-#ifdef __x86_64__
-static unsigned long read_msr(unsigned long msr)
-{
-	u64 value;
-
-	rdmsrl(msr, value);
-	return value;
-}
-#endif
-
 static inline struct page *_gfn_to_page(struct kvm *kvm, gfn_t gfn)
 {
 	struct kvm_memory_slot *slot = gfn_to_memslot(kvm, gfn);
 	return (slot) ? slot->phys_mem[gfn - slot->base_gfn] : 0;
 }
 
-
-
 int kvm_read_guest(struct kvm_vcpu *vcpu,
 			     gva_t addr,
 			     unsigned long size,
@@ -357,6 +266,7 @@ int kvm_read_guest(struct kvm_vcpu *vcpu
 	}
 	return req_size - size;
 }
+EXPORT_SYMBOL_GPL(kvm_read_guest);
 
 int kvm_write_guest(struct kvm_vcpu *vcpu,
 			     gva_t addr,
@@ -390,6 +300,7 @@ int kvm_write_guest(struct kvm_vcpu *vcp
 	}
 	return req_size - size;
 }
+EXPORT_SYMBOL_GPL(kvm_write_guest);
 
 static void vmcs_clear(struct vmcs *vmcs)
 {
@@ -1120,7 +1031,6 @@ static void seg_setup(int seg)
  */
 static int kvm_vcpu_setup(struct kvm_vcpu *vcpu)
 {
-	extern asmlinkage void kvm_vmx_return(void);
 	u32 host_sysenter_cs;
 	u32 junk;
 	unsigned long a;
@@ -1251,7 +1161,7 @@ static int kvm_vcpu_setup(struct kvm_vcp
 	vmcs_writel(HOST_IDTR_BASE, dt.base);   /* 22.2.4 */
 
 
-	vmcs_writel(HOST_RIP, (unsigned long)kvm_vmx_return); /* 22.2.5 */
+	vmcs_writel(HOST_RIP, kvm_arch_ops->vmx_return); /* 22.2.5 */
 
 	rdmsr(MSR_IA32_SYSENTER_CS, host_sysenter_cs, junk);
 	vmcs_write32(HOST_IA32_SYSENTER_CS, host_sysenter_cs);
@@ -2344,7 +2254,7 @@ static const int kvm_vmx_max_exit_handle
  * The guest has exited.  See if we can fix it or if we need userspace
  * assistance.
  */
-static int kvm_handle_exit(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
+int kvm_handle_exit(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
 {
 	u32 vectoring_info = vmcs_read32(IDT_VECTORING_INFO_FIELD);
 	u32 exit_reason = vmcs_read32(VM_EXIT_REASON);
@@ -2363,127 +2273,39 @@ static int kvm_handle_exit(struct kvm_ru
 	}
 	return 0;
 }
+EXPORT_SYMBOL_GPL(kvm_handle_exit);
 
-static void inject_rmode_irq(struct kvm_vcpu *vcpu, int irq)
+void kvm_resched(struct kvm_vcpu *vcpu)
 {
-	u16 ent[2];
-	u16 cs;
-	u16 ip;
-	unsigned long flags;
-	unsigned long ss_base = vmcs_readl(GUEST_SS_BASE);
-	u16 sp =  vmcs_readl(GUEST_RSP);
-	u32 ss_limit = vmcs_read32(GUEST_SS_LIMIT);
-
-	if (sp > ss_limit || sp - 6 > sp) {
-		vcpu_printf(vcpu, "%s: #SS, rsp 0x%lx ss 0x%lx limit 0x%x\n",
-			    __FUNCTION__,
-			    vmcs_readl(GUEST_RSP),
-			    vmcs_readl(GUEST_SS_BASE),
-			    vmcs_read32(GUEST_SS_LIMIT));
-		return;
-	}
-
-	if (kvm_read_guest(vcpu, irq * sizeof(ent), sizeof(ent), &ent) !=
-								sizeof(ent)) {
-		vcpu_printf(vcpu, "%s: read guest err\n", __FUNCTION__);
-		return;
-	}
-
-	flags =  vmcs_readl(GUEST_RFLAGS);
-	cs =  vmcs_readl(GUEST_CS_BASE) >> 4;
-	ip =  vmcs_readl(GUEST_RIP);
-
-
-	if (kvm_write_guest(vcpu, ss_base + sp - 2, 2, &flags) != 2 ||
-	    kvm_write_guest(vcpu, ss_base + sp - 4, 2, &cs) != 2 ||
-	    kvm_write_guest(vcpu, ss_base + sp - 6, 2, &ip) != 2) {
-		vcpu_printf(vcpu, "%s: write guest err\n", __FUNCTION__);
-		return;
-	}
-
-	vmcs_writel(GUEST_RFLAGS, flags &
-		    ~( X86_EFLAGS_IF | X86_EFLAGS_AC | X86_EFLAGS_TF));
-	vmcs_write16(GUEST_CS_SELECTOR, ent[1]) ;
-	vmcs_writel(GUEST_CS_BASE, ent[1] << 4);
-	vmcs_writel(GUEST_RIP, ent[0]);
-	vmcs_writel(GUEST_RSP, (vmcs_readl(GUEST_RSP) & ~0xffff) | (sp - 6));
-}
-
-static void kvm_do_inject_irq(struct kvm_vcpu *vcpu)
-{
-	int word_index = __ffs(vcpu->irq_summary);
-	int bit_index = __ffs(vcpu->irq_pending[word_index]);
-	int irq = word_index * BITS_PER_LONG + bit_index;
-
-	clear_bit(bit_index, &vcpu->irq_pending[word_index]);
-	if (!vcpu->irq_pending[word_index])
-		clear_bit(word_index, &vcpu->irq_summary);
-
-	if (vcpu->rmode.active) {
-		inject_rmode_irq(vcpu, irq);
-		return;
-	}
-	vmcs_write32(VM_ENTRY_INTR_INFO_FIELD,
-			irq | INTR_TYPE_EXT_INTR | INTR_INFO_VALID_MASK);
-}
-
-static void kvm_try_inject_irq(struct kvm_vcpu *vcpu)
-{
-	if ((vmcs_readl(GUEST_RFLAGS) & X86_EFLAGS_IF)
-	    && (vmcs_read32(GUEST_INTERRUPTIBILITY_INFO) & 3) == 0)
-		/*
-		 * Interrupts enabled, and not blocked by sti or mov ss. Good.
-		 */
-		kvm_do_inject_irq(vcpu);
-	else
-		/*
-		 * Interrupts blocked.  Wait for unblock.
-		 */
-		vmcs_write32(CPU_BASED_VM_EXEC_CONTROL,
-			     vmcs_read32(CPU_BASED_VM_EXEC_CONTROL)
-			     | CPU_BASED_VIRTUAL_INTR_PENDING);
-}
-
-static void kvm_guest_debug_pre(struct kvm_vcpu *vcpu)
-{
-	struct kvm_guest_debug *dbg = &vcpu->guest_debug;
-
-	set_debugreg(dbg->bp[0], 0);
-	set_debugreg(dbg->bp[1], 1);
-	set_debugreg(dbg->bp[2], 2);
-	set_debugreg(dbg->bp[3], 3);
-
-	if (dbg->singlestep) {
-		unsigned long flags;
-
-		flags = vmcs_readl(GUEST_RFLAGS);
-		flags |= X86_EFLAGS_TF | X86_EFLAGS_RF;
-		vmcs_writel(GUEST_RFLAGS, flags);
-	}
+	vcpu_put(vcpu);
+	cond_resched();
+	/* Cannot fail -  no vcpu unplug yet. */
+	vcpu_load(vcpu->kvm, vcpu_slot(vcpu));
 }
+EXPORT_SYMBOL_GPL(kvm_resched);
 
-static void load_msrs(struct vmx_msr_entry *e, int n)
+void load_msrs(struct vmx_msr_entry *e, int n)
 {
 	int i;
 
 	for (i = 0; i < n; ++i)
 		wrmsrl(e[i].index, e[i].data);
 }
+EXPORT_SYMBOL_GPL(load_msrs);
 
-static void save_msrs(struct vmx_msr_entry *e, int n)
+void save_msrs(struct vmx_msr_entry *e, int n)
 {
 	int i;
 
 	for (i = 0; i < n; ++i)
 		rdmsrl(e[i].index, e[i].data);
 }
+EXPORT_SYMBOL_GPL(save_msrs);
 
 static int kvm_dev_ioctl_run(struct kvm *kvm, struct kvm_run *kvm_run)
 {
 	struct kvm_vcpu *vcpu;
-	u8 fail;
-	u16 fs_sel, gs_sel, ldt_sel;
-	int fs_gs_ldt_reload_needed;
+	int r;
 
 	if (kvm_run->vcpu < 0 || kvm_run->vcpu >= KVM_MAX_VCPUS)
 		return -EINVAL;
@@ -2504,211 +2326,10 @@ static int kvm_dev_ioctl_run(struct kvm 
 
 	vcpu->mmio_needed = 0;
 
-again:
-	/*
-	 * Set host fs and gs selectors.  Unfortunately, 22.2.3 does not
-	 * allow segment selectors with cpl > 0 or ti == 1.
-	 */
-	fs_sel = read_fs();
-	gs_sel = read_gs();
-	ldt_sel = read_ldt();
-	fs_gs_ldt_reload_needed = (fs_sel & 7) | (gs_sel & 7) | ldt_sel;
-	if (!fs_gs_ldt_reload_needed) {
-		vmcs_write16(HOST_FS_SELECTOR, fs_sel);
-		vmcs_write16(HOST_GS_SELECTOR, gs_sel);
-	} else {
-		vmcs_write16(HOST_FS_SELECTOR, 0);
-		vmcs_write16(HOST_GS_SELECTOR, 0);
-	}
-
-#ifdef __x86_64__
-	vmcs_writel(HOST_FS_BASE, read_msr(MSR_FS_BASE));
-	vmcs_writel(HOST_GS_BASE, read_msr(MSR_GS_BASE));
-#endif
-
-	if (vcpu->irq_summary &&
-	    !(vmcs_read32(VM_ENTRY_INTR_INFO_FIELD) & INTR_INFO_VALID_MASK))
-		kvm_try_inject_irq(vcpu);
-
-	if (vcpu->guest_debug.enabled)
-		kvm_guest_debug_pre(vcpu);
-
-	fx_save(vcpu->host_fx_image);
-	fx_restore(vcpu->guest_fx_image);
-
-	save_msrs(vcpu->host_msrs, vcpu->nmsrs);
-	load_msrs(vcpu->guest_msrs, NR_BAD_MSRS);
-
-	asm (
-		/* Store host registers */
-		"pushf \n\t"
-#ifdef __x86_64__
-		"push %%rax; push %%rbx; push %%rdx;"
-		"push %%rsi; push %%rdi; push %%rbp;"
-		"push %%r8;  push %%r9;  push %%r10; push %%r11;"
-		"push %%r12; push %%r13; push %%r14; push %%r15;"
-		"push %%rcx \n\t"
-		ASM_VMX_VMWRITE_RSP_RDX "\n\t"
-#else
-		"pusha; push %%ecx \n\t"
-		ASM_VMX_VMWRITE_RSP_RDX "\n\t"
-#endif
-		/* Check if vmlaunch of vmresume is needed */
-		"cmp $0, %1 \n\t"
-		/* Load guest registers.  Don't clobber flags. */
-#ifdef __x86_64__
-		"mov %c[cr2](%3), %%rax \n\t"
-		"mov %%rax, %%cr2 \n\t"
-		"mov %c[rax](%3), %%rax \n\t"
-		"mov %c[rbx](%3), %%rbx \n\t"
-		"mov %c[rdx](%3), %%rdx \n\t"
-		"mov %c[rsi](%3), %%rsi \n\t"
-		"mov %c[rdi](%3), %%rdi \n\t"
-		"mov %c[rbp](%3), %%rbp \n\t"
-		"mov %c[r8](%3),  %%r8  \n\t"
-		"mov %c[r9](%3),  %%r9  \n\t"
-		"mov %c[r10](%3), %%r10 \n\t"
-		"mov %c[r11](%3), %%r11 \n\t"
-		"mov %c[r12](%3), %%r12 \n\t"
-		"mov %c[r13](%3), %%r13 \n\t"
-		"mov %c[r14](%3), %%r14 \n\t"
-		"mov %c[r15](%3), %%r15 \n\t"
-		"mov %c[rcx](%3), %%rcx \n\t" /* kills %3 (rcx) */
-#else
-		"mov %c[cr2](%3), %%eax \n\t"
-		"mov %%eax,   %%cr2 \n\t"
-		"mov %c[rax](%3), %%eax \n\t"
-		"mov %c[rbx](%3), %%ebx \n\t"
-		"mov %c[rdx](%3), %%edx \n\t"
-		"mov %c[rsi](%3), %%esi \n\t"
-		"mov %c[rdi](%3), %%edi \n\t"
-		"mov %c[rbp](%3), %%ebp \n\t"
-		"mov %c[rcx](%3), %%ecx \n\t" /* kills %3 (ecx) */
-#endif
-		/* Enter guest mode */
-		"jne launched \n\t"
-		ASM_VMX_VMLAUNCH "\n\t"
-		"jmp kvm_vmx_return \n\t"
-		"launched: " ASM_VMX_VMRESUME "\n\t"
-		".globl kvm_vmx_return \n\t"
-		"kvm_vmx_return: "
-		/* Save guest registers, load host registers, keep flags */
-#ifdef __x86_64__
-		"xchg %3,     0(%%rsp) \n\t"
-		"mov %%rax, %c[rax](%3) \n\t"
-		"mov %%rbx, %c[rbx](%3) \n\t"
-		"pushq 0(%%rsp); popq %c[rcx](%3) \n\t"
-		"mov %%rdx, %c[rdx](%3) \n\t"
-		"mov %%rsi, %c[rsi](%3) \n\t"
-		"mov %%rdi, %c[rdi](%3) \n\t"
-		"mov %%rbp, %c[rbp](%3) \n\t"
-		"mov %%r8,  %c[r8](%3) \n\t"
-		"mov %%r9,  %c[r9](%3) \n\t"
-		"mov %%r10, %c[r10](%3) \n\t"
-		"mov %%r11, %c[r11](%3) \n\t"
-		"mov %%r12, %c[r12](%3) \n\t"
-		"mov %%r13, %c[r13](%3) \n\t"
-		"mov %%r14, %c[r14](%3) \n\t"
-		"mov %%r15, %c[r15](%3) \n\t"
-		"mov %%cr2, %%rax   \n\t"
-		"mov %%rax, %c[cr2](%3) \n\t"
-		"mov 0(%%rsp), %3 \n\t"
-
-		"pop  %%rcx; pop  %%r15; pop  %%r14; pop  %%r13; pop  %%r12;"
-		"pop  %%r11; pop  %%r10; pop  %%r9;  pop  %%r8;"
-		"pop  %%rbp; pop  %%rdi; pop  %%rsi;"
-		"pop  %%rdx; pop  %%rbx; pop  %%rax \n\t"
-#else
-		"xchg %3, 0(%%esp) \n\t"
-		"mov %%eax, %c[rax](%3) \n\t"
-		"mov %%ebx, %c[rbx](%3) \n\t"
-		"pushl 0(%%esp); popl %c[rcx](%3) \n\t"
-		"mov %%edx, %c[rdx](%3) \n\t"
-		"mov %%esi, %c[rsi](%3) \n\t"
-		"mov %%edi, %c[rdi](%3) \n\t"
-		"mov %%ebp, %c[rbp](%3) \n\t"
-		"mov %%cr2, %%eax  \n\t"
-		"mov %%eax, %c[cr2](%3) \n\t"
-		"mov 0(%%esp), %3 \n\t"
-
-		"pop %%ecx; popa \n\t"
-#endif
-		"setbe %0 \n\t"
-		"popf \n\t"
-	      : "=g" (fail)
-	      : "r"(vcpu->launched), "d"((unsigned long)HOST_RSP),
-		"c"(vcpu),
-		[rax]"i"(offsetof(struct kvm_vcpu, regs[VCPU_REGS_RAX])),
-		[rbx]"i"(offsetof(struct kvm_vcpu, regs[VCPU_REGS_RBX])),
-		[rcx]"i"(offsetof(struct kvm_vcpu, regs[VCPU_REGS_RCX])),
-		[rdx]"i"(offsetof(struct kvm_vcpu, regs[VCPU_REGS_RDX])),
-		[rsi]"i"(offsetof(struct kvm_vcpu, regs[VCPU_REGS_RSI])),
-		[rdi]"i"(offsetof(struct kvm_vcpu, regs[VCPU_REGS_RDI])),
-		[rbp]"i"(offsetof(struct kvm_vcpu, regs[VCPU_REGS_RBP])),
-#ifdef __x86_64__
-		[r8 ]"i"(offsetof(struct kvm_vcpu, regs[VCPU_REGS_R8 ])),
-		[r9 ]"i"(offsetof(struct kvm_vcpu, regs[VCPU_REGS_R9 ])),
-		[r10]"i"(offsetof(struct kvm_vcpu, regs[VCPU_REGS_R10])),
-		[r11]"i"(offsetof(struct kvm_vcpu, regs[VCPU_REGS_R11])),
-		[r12]"i"(offsetof(struct kvm_vcpu, regs[VCPU_REGS_R12])),
-		[r13]"i"(offsetof(struct kvm_vcpu, regs[VCPU_REGS_R13])),
-		[r14]"i"(offsetof(struct kvm_vcpu, regs[VCPU_REGS_R14])),
-		[r15]"i"(offsetof(struct kvm_vcpu, regs[VCPU_REGS_R15])),
-#endif
-		[cr2]"i"(offsetof(struct kvm_vcpu, cr2))
-	      : "cc", "memory" );
-
-	++kvm_stat.exits;
-
-	save_msrs(vcpu->guest_msrs, NR_BAD_MSRS);
-	load_msrs(vcpu->host_msrs, NR_BAD_MSRS);
-
-	fx_save(vcpu->guest_fx_image);
-	fx_restore(vcpu->host_fx_image);
-
-#ifndef __x86_64__
-	asm ("mov %0, %%ds; mov %0, %%es" : : "r"(__USER_DS));
-#endif
-
-	kvm_run->exit_type = 0;
-	if (fail) {
-		kvm_run->exit_type = KVM_EXIT_TYPE_FAIL_ENTRY;
-		kvm_run->exit_reason = vmcs_read32(VM_INSTRUCTION_ERROR);
-	} else {
-		if (fs_gs_ldt_reload_needed) {
-			load_ldt(ldt_sel);
-			load_fs(fs_sel);
-			/*
-			 * If we have to reload gs, we must take care to
-			 * preserve our gs base.
-			 */
-			local_irq_disable();
-			load_gs(gs_sel);
-#ifdef __x86_64__
-			wrmsrl(MSR_GS_BASE, vmcs_readl(HOST_GS_BASE));
-#endif
-			local_irq_enable();
-
-			reload_tss();
-		}
-		vcpu->launched = 1;
-		kvm_run->exit_type = KVM_EXIT_TYPE_VM_EXIT;
-		if (kvm_handle_exit(kvm_run, vcpu)) {
-			/* Give scheduler a change to reschedule. */
-			vcpu_put(vcpu);
-			if (signal_pending(current)) {
-				++kvm_stat.signal_exits;
-				return -EINTR;
-			}
-			cond_resched();
-			/* Cannot fail -  no vcpu unplug yet. */
-			vcpu_load(kvm, vcpu_slot(vcpu));
-			goto again;
-		}
-	}
+	r = kvm_arch_ops->run(vcpu, kvm_run);
 
 	vcpu_put(vcpu);
-	return 0;
+	return r;
 }
 
 static int kvm_dev_ioctl_get_regs(struct kvm *kvm, struct kvm_regs *regs)
Index: linux-2.6/drivers/kvm/kvm_vmx.h
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_vmx.h
+++ linux-2.6/drivers/kvm/kvm_vmx.h
@@ -17,4 +17,14 @@ static inline void vmcs_write64(unsigned
 #endif
 }
 
+#ifdef __x86_64__
+/*
+ * avoid save/load MSR_SYSCALL_MASK and MSR_LSTAR by std vt
+ * mechanism (cpu bug AA24)
+ */
+#define NR_BAD_MSRS 2
+#else
+#define NR_BAD_MSRS 0
+#endif
+
 #endif
Index: linux-2.6/drivers/kvm/vmx.c
===================================================================
--- linux-2.6.orig/drivers/kvm/vmx.c
+++ linux-2.6/drivers/kvm/vmx.c
@@ -50,6 +50,22 @@ void set_efer(struct kvm_vcpu *vcpu, u64
 
 #endif
 
+static void reload_tss(void)
+{
+#ifndef __x86_64__
+
+	/*
+	 * VT restores TR but not its size.  Useless.
+	 */
+	struct descriptor_table gdt;
+	struct segment_descriptor *descs;
+
+	get_gdt(&gdt);
+	descs = (void *)gdt.base;
+	descs[GDT_ENTRY_TSS].type = 9; /* available TSS */
+	load_TR_desc();
+#endif
+}
 
 /*
  * Reads an msr value (of 'msr_index') into 'pdata'.
@@ -407,6 +423,314 @@ static void vmx_set_gdt(struct kvm_vcpu 
 	vmcs_writel(GUEST_GDTR_BASE, dt->base);
 }
 
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
+static int vmx_vcpu_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
+{
+	u8 fail;
+	u16 fs_sel, gs_sel, ldt_sel;
+	int fs_gs_ldt_reload_needed;
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
+	save_msrs(vcpu->host_msrs, vcpu->nmsrs);
+	load_msrs(vcpu->guest_msrs, NR_BAD_MSRS);
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
+		ASM_VMX_VMWRITE_RSP_RDX "\n\t"
+#else
+		"pusha; push %%ecx \n\t"
+		ASM_VMX_VMWRITE_RSP_RDX "\n\t"
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
+		ASM_VMX_VMLAUNCH "\n\t"
+		"jmp kvm_vmx_return \n\t"
+		"launched: " ASM_VMX_VMRESUME "\n\t"
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
+	      : "r"(vcpu->launched), "d"((unsigned long)HOST_RSP),
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
+	save_msrs(vcpu->guest_msrs, NR_BAD_MSRS);
+	load_msrs(vcpu->host_msrs, NR_BAD_MSRS);
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
+			if (signal_pending(current)) {
+				++kvm_stat.signal_exits;
+				return -EINTR;
+			}
+			kvm_resched(vcpu);
+			goto again;
+		}
+	}
+	return 0;
+}
+
+extern asmlinkage void kvm_vmx_return(void);
+
 static struct kvm_arch_ops vmx_arch_ops = {
 	.cpu_has_kvm_support = cpu_has_kvm_support,
 	.disabled_by_bios = vmx_disabled_by_bios,
@@ -427,6 +751,9 @@ static struct kvm_arch_ops vmx_arch_ops 
 	.set_gdt = vmx_set_gdt,
 	.cache_regs = vcpu_load_rsp_rip,
 	.decache_regs = vcpu_put_rsp_rip,
+
+	.run = vmx_vcpu_run,
+	.vmx_return = (unsigned long)kvm_vmx_return,
 };
 
 static int __init vmx_init(void)
