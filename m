Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964859AbWJWNdT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964859AbWJWNdT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 09:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964857AbWJWNdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 09:33:14 -0400
Received: from il.qumranet.com ([62.219.232.206]:28117 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S964855AbWJWNat (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 09:30:49 -0400
Subject: [PATCH 7/13] KVM: vcpu creation and maintenance
From: Avi Kivity <avi@qumranet.com>
Date: Mon, 23 Oct 2006 13:30:46 -0000
To: avi@qumranet.com, linux-kernel@vger.kernel.org
References: <453CC390.9080508@qumranet.com>
In-Reply-To: <453CC390.9080508@qumranet.com>
Message-Id: <20061023133046.A9E25250143@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Create a vcpu and initialize it for real-mode bootstrap.

Also provide accessors to get/set vcpu registers.

Signed-off-by: Yaniv Kamay <yaniv@qumranet.com>
Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -655,6 +655,299 @@ static void vmcs_write64(unsigned long f
 #endif
 }
 
+static int rmode_tss_base(struct kvm* kvm)
+{
+	gfn_t base_gfn = kvm->memslots[0].base_gfn + kvm->memslots[0].npages - 3;
+	return base_gfn << PAGE_SHIFT;
+}
+
+static int init_rmode_tss(struct kvm* kvm)
+{
+	struct page *p1, *p2, *p3;
+	gfn_t fn = rmode_tss_base(kvm) >> PAGE_SHIFT;
+	char *page;
+
+	p1 = _gfn_to_page(kvm, fn++);
+	p2 = _gfn_to_page(kvm, fn++);
+	p3 = _gfn_to_page(kvm, fn);
+
+	if (!p1 || !p2 || !p3) {
+		kvm_printf(kvm,"%s: gfn_to_page failed\n", __FUNCTION__);
+		return 0;
+	}
+
+	page = kmap_atomic(p1, KM_USER0);
+	memset(page, 0, PAGE_SIZE);
+	*(u16*)(page + 0x66) = TSS_BASE_SIZE + TSS_REDIRECTION_SIZE;
+	kunmap_atomic(page, KM_USER0);
+
+	page = kmap_atomic(p2, KM_USER0);
+	memset(page, 0, PAGE_SIZE);
+	kunmap_atomic(page, KM_USER0);
+
+	page = kmap_atomic(p3, KM_USER0);
+	memset(page, 0, PAGE_SIZE);
+	*(page + RMODE_TSS_SIZE - 2 * PAGE_SIZE - 1) = ~0;
+	kunmap_atomic(page, KM_USER0);
+
+	return 1;
+}
+
+static u32 get_rdx_init_val(void)
+{
+	u32 val;
+
+	asm ("movl $1, %%eax \n\t"
+	     "movl %%eax, %0 \n\t" : "=g"(val) );
+	return val;
+
+}
+
+static void fx_init(struct kvm_vcpu *vcpu)
+{
+	struct __attribute__ ((__packed__)) fx_image_s {
+		u16 control; //fcw
+		u16 status; //fsw
+		u16 tag; // ftw
+		u16 opcode; //fop
+		u64 ip; // fpu ip
+		u64 operand;// fpu dp
+		u32 mxcsr;
+		u32 mxcsr_mask;
+
+	} *fx_image;
+
+	fx_save(vcpu->host_fx_image);
+	fpu_init();
+	fx_save(vcpu->guest_fx_image);
+	fx_restore(vcpu->host_fx_image);
+
+	fx_image = (struct fx_image_s *)vcpu->guest_fx_image;
+	fx_image->mxcsr = 0x1f80;
+	memset(vcpu->guest_fx_image + sizeof(struct fx_image_s),
+	       0, FX_IMAGE_SIZE - sizeof(struct fx_image_s));
+}
+
+static void vmcs_write32_fixedbits(u32 msr, u32 vmcs_field, u32 val)
+{
+	u32 msr_high, msr_low;
+
+	rdmsr(msr, msr_low, msr_high);
+
+	val &= msr_high;
+	val |= msr_low;
+	vmcs_write32(vmcs_field, val);
+}
+
+/*
+ * Sets up the vmcs for emulated real mode.
+ */
+static int kvm_vcpu_setup(struct kvm_vcpu *vcpu)
+{
+	extern asmlinkage void kvm_vmx_return(void);
+	u32 host_sysenter_cs;
+	u32 junk;
+	unsigned long a;
+	struct descriptor_table dt;
+	int i;
+	int ret;
+	u64 tsc;
+
+
+	if (!init_rmode_tss(vcpu->kvm)) {
+		ret = 0;
+		goto out;
+	}
+
+	memset(vcpu->regs, 0, sizeof(vcpu->regs));
+	vcpu->regs[VCPU_REGS_RDX] = get_rdx_init_val();
+	vcpu->cr8 = 0;
+	vcpu->apic_base = 0xfee00000 |
+			/*for vcpu 0*/ MSR_IA32_APICBASE_BSP |
+			MSR_IA32_APICBASE_ENABLE;
+
+	fx_init(vcpu);
+
+#define SEG_SETUP(seg) do {					\
+		vmcs_write16(GUEST_##seg##_SELECTOR, 0);	\
+		vmcs_writel(GUEST_##seg##_BASE, 0);		\
+		vmcs_write32(GUEST_##seg##_LIMIT, 0xffff);	\
+		vmcs_write32(GUEST_##seg##_AR_BYTES, 0x93); 	\
+	} while (0)
+
+	/*
+	 * GUEST_CS_BASE should really be 0xffff0000, but VT vm86 mode
+	 * insists on having GUEST_CS_BASE == GUEST_CS_SELECTOR << 4.  Sigh.
+	 */
+	vmcs_write16(GUEST_CS_SELECTOR, 0xf000);
+	vmcs_writel(GUEST_CS_BASE, 0x000f0000);
+	vmcs_write32(GUEST_CS_LIMIT, 0xffff);
+	vmcs_write32(GUEST_CS_AR_BYTES, 0x9b);
+
+	SEG_SETUP(DS);
+	SEG_SETUP(ES);
+	SEG_SETUP(FS);
+	SEG_SETUP(GS);
+	SEG_SETUP(SS);
+
+	vmcs_write16(GUEST_TR_SELECTOR, 0);
+	vmcs_writel(GUEST_TR_BASE, 0);
+	vmcs_write32(GUEST_TR_LIMIT, 0xffff);
+	vmcs_write32(GUEST_TR_AR_BYTES, 0x008b);
+
+	vmcs_write16(GUEST_LDTR_SELECTOR, 0);
+	vmcs_writel(GUEST_LDTR_BASE, 0);
+	vmcs_write32(GUEST_LDTR_LIMIT, 0xffff);
+	vmcs_write32(GUEST_LDTR_AR_BYTES, 0x00082);
+
+	vmcs_write32(GUEST_SYSENTER_CS, 0);
+	vmcs_writel(GUEST_SYSENTER_ESP, 0);
+	vmcs_writel(GUEST_SYSENTER_EIP, 0);
+
+	vmcs_writel(GUEST_RFLAGS, 0x02);
+	vmcs_writel(GUEST_RIP, 0xfff0);
+	vmcs_writel(GUEST_RSP, 0);
+
+	vmcs_writel(GUEST_CR3, 0);
+
+	//todo: dr0 = dr1 = dr2 = dr3 = 0; dr6 = 0xffff0ff0
+	vmcs_writel(GUEST_DR7, 0x400);
+
+	vmcs_writel(GUEST_GDTR_BASE, 0);
+	vmcs_write32(GUEST_GDTR_LIMIT, 0xffff);
+
+	vmcs_writel(GUEST_IDTR_BASE, 0);
+	vmcs_write32(GUEST_IDTR_LIMIT, 0xffff);
+
+	vmcs_write32(GUEST_ACTIVITY_STATE, 0);
+	vmcs_write32(GUEST_INTERRUPTIBILITY_INFO, 0);
+	vmcs_write32(GUEST_PENDING_DBG_EXCEPTIONS, 0);
+
+	/* I/O */
+	vmcs_write64(IO_BITMAP_A, 0);
+	vmcs_write64(IO_BITMAP_B, 0);
+
+	rdtscll(tsc);
+	vmcs_write64(TSC_OFFSET, -tsc);
+
+	vmcs_write64(VMCS_LINK_POINTER, -1ull); /* 22.3.1.5 */
+
+	/* Special registers */
+	vmcs_write64(GUEST_IA32_DEBUGCTL, 0);
+
+	/* Control */
+	vmcs_write32_fixedbits(MSR_IA32_VMX_PINBASED_CTLS_MSR,
+			       PIN_BASED_VM_EXEC_CONTROL,
+			       PIN_BASED_EXT_INTR_MASK   /* 20.6.1 */
+			       | PIN_BASED_NMI_EXITING   /* 20.6.1 */
+			);
+	vmcs_write32_fixedbits(MSR_IA32_VMX_PROCBASED_CTLS_MSR,
+			       CPU_BASED_VM_EXEC_CONTROL,
+			       CPU_BASED_HLT_EXITING         /* 20.6.2 */
+			       | CPU_BASED_CR8_LOAD_EXITING    /* 20.6.2 */
+			       | CPU_BASED_CR8_STORE_EXITING   /* 20.6.2 */
+			       | CPU_BASED_UNCOND_IO_EXITING   /* 20.6.2 */
+			       | CPU_BASED_INVDPG_EXITING
+			       | CPU_BASED_MOV_DR_EXITING
+			       | CPU_BASED_USE_TSC_OFFSETING   /* 21.3 */
+			);
+
+	vmcs_write32(EXCEPTION_BITMAP, 1 << PF_VECTOR);
+	vmcs_write32(PAGE_FAULT_ERROR_CODE_MASK, 0);
+	vmcs_write32(PAGE_FAULT_ERROR_CODE_MATCH, 0);
+	vmcs_write32(CR3_TARGET_COUNT, 0);           /* 22.2.1 */
+
+	vmcs_writel(HOST_CR0, read_cr0());  /* 22.2.3 */
+	vmcs_writel(HOST_CR4, read_cr4());  /* 22.2.3, 22.2.5 */
+	vmcs_writel(HOST_CR3, read_cr3());  /* 22.2.3  FIXME: shadow tables */
+
+	vmcs_write16(HOST_CS_SELECTOR, __KERNEL_CS);  /* 22.2.4 */
+	vmcs_write16(HOST_DS_SELECTOR, __KERNEL_DS);  /* 22.2.4 */
+	vmcs_write16(HOST_ES_SELECTOR, __KERNEL_DS);  /* 22.2.4 */
+	vmcs_write16(HOST_FS_SELECTOR, read_fs());    /* 22.2.4 */
+	vmcs_write16(HOST_GS_SELECTOR, read_gs());    /* 22.2.4 */
+	vmcs_write16(HOST_SS_SELECTOR, __KERNEL_DS);  /* 22.2.4 */
+#ifdef __x86_64__
+	rdmsrl(MSR_FS_BASE, a);
+	vmcs_writel(HOST_FS_BASE, a); /* 22.2.4 */
+	rdmsrl(MSR_GS_BASE, a);
+	vmcs_writel(HOST_GS_BASE, a); /* 22.2.4 */
+#else
+	vmcs_writel(HOST_FS_BASE, 0); /* 22.2.4 */
+	vmcs_writel(HOST_GS_BASE, 0); /* 22.2.4 */
+#endif
+
+	vmcs_write16(HOST_TR_SELECTOR, GDT_ENTRY_TSS*8);  /* 22.2.4 */
+
+	get_idt(&dt);
+	vmcs_writel(HOST_IDTR_BASE, dt.base);   /* 22.2.4 */
+
+
+	vmcs_writel(HOST_RIP, (unsigned long)kvm_vmx_return); /* 22.2.5 */
+
+	rdmsr(MSR_IA32_SYSENTER_CS, host_sysenter_cs, junk);
+	vmcs_write32(HOST_IA32_SYSENTER_CS, host_sysenter_cs);
+	rdmsrl(MSR_IA32_SYSENTER_ESP, a);
+	vmcs_writel(HOST_IA32_SYSENTER_ESP, a);   /* 22.2.3 */
+	rdmsrl(MSR_IA32_SYSENTER_EIP, a);
+	vmcs_writel(HOST_IA32_SYSENTER_EIP, a);   /* 22.2.3 */
+
+	vmcs_write32_fixedbits(MSR_IA32_VMX_EXIT_CTLS_MSR, VM_EXIT_CONTROLS,
+		     	       (HOST_IS_64 << 9));  /* 22.2,1, 20.7.1 */
+	vmcs_write32(VM_EXIT_MSR_STORE_COUNT, NUM_AUTO_MSRS); /* 22.2.2 */
+	vmcs_write32(VM_EXIT_MSR_LOAD_COUNT, NUM_AUTO_MSRS);  /* 22.2.2 */
+	vmcs_write32(VM_ENTRY_MSR_LOAD_COUNT, NUM_AUTO_MSRS); /* 22.2.2 */
+
+	ret = -ENOMEM;
+	vcpu->guest_msrs = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!vcpu->guest_msrs)
+		goto out;
+	vcpu->host_msrs = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!vcpu->host_msrs)
+		goto out_free_guest_msrs;
+
+	for (i = 0; i < NR_VMX_MSR; ++i) {
+		u32 index = vmx_msr_index[i];
+		u64 data;
+
+		rdmsrl(index, data);
+		vcpu->host_msrs[i].index = index;
+		vcpu->host_msrs[i].reserved = 0;
+		vcpu->host_msrs[i].data = data;
+		vcpu->guest_msrs[i] = vcpu->host_msrs[i];
+	}
+
+	vmcs_writel(VM_ENTRY_MSR_LOAD_ADDR, virt_to_phys(vcpu->guest_msrs));
+	vmcs_writel(VM_EXIT_MSR_STORE_ADDR, virt_to_phys(vcpu->guest_msrs));
+	vmcs_writel(VM_EXIT_MSR_LOAD_ADDR, virt_to_phys(vcpu->host_msrs));
+
+	/* 22.2.1, 20.8.1 */
+	vmcs_write32_fixedbits(MSR_IA32_VMX_ENTRY_CTLS_MSR,
+                               VM_ENTRY_CONTROLS, 0);
+	vmcs_write32(VM_ENTRY_INTR_INFO_FIELD, 0);  /* 22.2.1 */
+
+	vmcs_writel(VIRTUAL_APIC_PAGE_ADDR, 0);
+	vmcs_writel(TPR_THRESHOLD, 0);
+
+	vmcs_writel(CR0_GUEST_HOST_MASK, KVM_GUEST_CR0_MASK);
+	vmcs_writel(CR4_GUEST_HOST_MASK, KVM_GUEST_CR4_MASK);
+
+	__set_cr0(vcpu, 0x60000010); // enter rmode
+	__set_cr4(vcpu, 0);
+#ifdef __x86_64__
+	__set_efer(vcpu, 0);
+#endif
+
+	ret = kvm_mmu_init(vcpu);
+
+	return ret;
+
+out_free_guest_msrs:
+	kfree(vcpu->guest_msrs);
+out:
+	return ret;
+}
+
 /*
  * Sync the rsp and rip registers into the vcpu structure.  This allows
  * registers to be accessed by indexing vcpu->regs.
@@ -676,6 +969,60 @@ static void vcpu_put_rsp_rip(struct kvm_
 }
 
 /*
+ * Creates some virtual cpus.  Good luck creating more than one.
+ */
+static int kvm_dev_ioctl_create_vcpu(struct kvm *kvm, int n)
+{
+	int r;
+	struct kvm_vcpu *vcpu;
+	struct vmcs *vmcs;
+
+	r = -EINVAL;
+	if (n < 0 || n >= KVM_MAX_VCPUS)
+		goto out;
+
+	vcpu = &kvm->vcpus[n];
+
+	mutex_lock(&vcpu->mutex);
+
+	if (vcpu->vmcs) {
+		mutex_unlock(&vcpu->mutex);
+		return -EEXIST;
+	}
+
+	vcpu->host_fx_image = (char*)ALIGN((hva_t)vcpu->fx_buf,
+					   FX_IMAGE_ALIGN);
+	vcpu->guest_fx_image = vcpu->host_fx_image + FX_IMAGE_SIZE;
+
+	vcpu->cpu = -1;  /* First load will set up TR */
+	vcpu->kvm = kvm;
+	vmcs = alloc_vmcs();
+	if (!vmcs) {
+		mutex_unlock(&vcpu->mutex);
+		goto out_free_vcpus;
+	}
+	vmcs_clear(vmcs);
+	vcpu->vmcs = vmcs;
+	vcpu->launched = 0;
+
+	__vcpu_load(vcpu);
+
+	r = kvm_vcpu_setup(vcpu);
+
+	vcpu_put(vcpu);
+
+	if (r < 0)
+		goto out_free_vcpus;
+
+	return 0;
+
+out_free_vcpus:
+	kvm_free_vcpu(vcpu);
+out:
+	return r;
+}
+
+/*
  * Allocate some memory and give it an address in the guest physical address
  * space.
  *
@@ -1284,6 +1631,254 @@ static void save_msrs(struct vmx_msr_ent
 		rdmsrl(e[msr_index].index, e[msr_index].data);
 }
 
+static int kvm_dev_ioctl_get_regs(struct kvm *kvm, struct kvm_regs *regs)
+{
+	struct kvm_vcpu *vcpu;
+
+	if (regs->vcpu < 0 || regs->vcpu >= KVM_MAX_VCPUS)
+		return -EINVAL;
+
+	vcpu = vcpu_load(kvm, regs->vcpu);
+	if (!vcpu)
+		return -ENOENT;
+
+	regs->rax = vcpu->regs[VCPU_REGS_RAX];
+	regs->rbx = vcpu->regs[VCPU_REGS_RBX];
+	regs->rcx = vcpu->regs[VCPU_REGS_RCX];
+	regs->rdx = vcpu->regs[VCPU_REGS_RDX];
+	regs->rsi = vcpu->regs[VCPU_REGS_RSI];
+	regs->rdi = vcpu->regs[VCPU_REGS_RDI];
+	regs->rsp = vmcs_readl(GUEST_RSP);
+	regs->rbp = vcpu->regs[VCPU_REGS_RBP];
+#ifdef __x86_64__
+	regs->r8 = vcpu->regs[VCPU_REGS_R8];
+	regs->r9 = vcpu->regs[VCPU_REGS_R9];
+	regs->r10 = vcpu->regs[VCPU_REGS_R10];
+	regs->r11 = vcpu->regs[VCPU_REGS_R11];
+	regs->r12 = vcpu->regs[VCPU_REGS_R12];
+	regs->r13 = vcpu->regs[VCPU_REGS_R13];
+	regs->r14 = vcpu->regs[VCPU_REGS_R14];
+	regs->r15 = vcpu->regs[VCPU_REGS_R15];
+#endif
+
+	regs->rip = vmcs_readl(GUEST_RIP);
+	regs->rflags = vmcs_readl(GUEST_RFLAGS);
+
+	/*
+	 * Don't leak debug flags in case they were set for guest debugging
+	 */
+	if (vcpu->guest_debug.enabled && vcpu->guest_debug.singlestep)
+		regs->rflags &= ~(X86_EFLAGS_TF | X86_EFLAGS_RF);
+
+	vcpu_put(vcpu);
+
+	return 0;
+}
+
+static int kvm_dev_ioctl_set_regs(struct kvm *kvm, struct kvm_regs *regs)
+{
+	struct kvm_vcpu *vcpu;
+
+	if (regs->vcpu < 0 || regs->vcpu >= KVM_MAX_VCPUS)
+		return -EINVAL;
+
+	vcpu = vcpu_load(kvm, regs->vcpu);
+	if (!vcpu)
+		return -ENOENT;
+
+	vcpu->regs[VCPU_REGS_RAX] = regs->rax;
+	vcpu->regs[VCPU_REGS_RBX] = regs->rbx;
+	vcpu->regs[VCPU_REGS_RCX] = regs->rcx;
+	vcpu->regs[VCPU_REGS_RDX] = regs->rdx;
+	vcpu->regs[VCPU_REGS_RSI] = regs->rsi;
+	vcpu->regs[VCPU_REGS_RDI] = regs->rdi;
+	vmcs_writel(GUEST_RSP, regs->rsp);
+	vcpu->regs[VCPU_REGS_RBP] = regs->rbp;
+#ifdef __x86_64__
+	vcpu->regs[VCPU_REGS_R8] = regs->r8;
+	vcpu->regs[VCPU_REGS_R9] = regs->r9;
+	vcpu->regs[VCPU_REGS_R10] = regs->r10;
+	vcpu->regs[VCPU_REGS_R11] = regs->r11;
+	vcpu->regs[VCPU_REGS_R12] = regs->r12;
+	vcpu->regs[VCPU_REGS_R13] = regs->r13;
+	vcpu->regs[VCPU_REGS_R14] = regs->r14;
+	vcpu->regs[VCPU_REGS_R15] = regs->r15;
+#endif
+
+	vmcs_writel(GUEST_RIP, regs->rip);
+	vmcs_writel(GUEST_RFLAGS, regs->rflags);
+
+	vcpu_put(vcpu);
+
+	return 0;
+}
+
+static int kvm_dev_ioctl_get_sregs(struct kvm *kvm, struct kvm_sregs *sregs)
+{
+	struct kvm_vcpu *vcpu;
+
+	if (sregs->vcpu < 0 || sregs->vcpu >= KVM_MAX_VCPUS)
+		return -EINVAL;
+	vcpu = vcpu_load(kvm, sregs->vcpu);
+	if (!vcpu)
+		return -ENOENT;
+
+#define get_segment(var, seg) \
+	do { \
+		u32 ar; \
+		\
+		sregs->var.base = vmcs_readl(GUEST_##seg##_BASE); \
+		sregs->var.limit = vmcs_read32(GUEST_##seg##_LIMIT); \
+		sregs->var.selector = vmcs_read16(GUEST_##seg##_SELECTOR); \
+		ar = vmcs_read32(GUEST_##seg##_AR_BYTES); \
+		if (ar & AR_UNUSABLE_MASK) ar = 0; \
+		sregs->var.type = ar & 15; \
+		sregs->var.s = (ar >> 4) & 1; \
+		sregs->var.dpl = (ar >> 5) & 3; \
+		sregs->var.present = (ar >> 7) & 1; \
+		sregs->var.avl = (ar >> 12) & 1; \
+		sregs->var.l = (ar >> 13) & 1; \
+		sregs->var.db = (ar >> 14) & 1; \
+		sregs->var.g = (ar >> 15) & 1; \
+		sregs->var.unusable = (ar >> 16) & 1; \
+	} while (0);
+
+	get_segment(cs, CS);
+	get_segment(ds, DS);
+	get_segment(es, ES);
+	get_segment(fs, FS);
+	get_segment(gs, GS);
+	get_segment(ss, SS);
+
+	get_segment(tr, TR);
+	get_segment(ldt, LDTR);
+#undef get_segment
+
+#define get_dtable(var, table) \
+	sregs->var.limit = vmcs_read32(GUEST_##table##_LIMIT), \
+		sregs->var.base = vmcs_readl(GUEST_##table##_BASE)
+
+	get_dtable(idt, IDTR);
+	get_dtable(gdt, GDTR);
+#undef get_dtable
+
+	sregs->cr0 = guest_cr0();
+	sregs->cr2 = vcpu->cr2;
+	sregs->cr3 = vcpu->cr3;
+	sregs->cr4 = guest_cr4();
+	sregs->cr8 = vcpu->cr8;
+	sregs->efer = vcpu->shadow_efer;
+	sregs->apic_base = vcpu->apic_base;
+
+	sregs->pending_int = vcpu->irq_summary != 0;
+
+	vcpu_put(vcpu);
+
+	return 0;
+}
+
+static int kvm_dev_ioctl_set_sregs(struct kvm *kvm, struct kvm_sregs *sregs)
+{
+	struct kvm_vcpu *vcpu;
+	int mmu_reset_needed = 0;
+
+	if (sregs->vcpu < 0 || sregs->vcpu >= KVM_MAX_VCPUS)
+		return -EINVAL;
+	vcpu = vcpu_load(kvm, sregs->vcpu);
+	if (!vcpu)
+		return -ENOENT;
+
+#define set_segment(var, seg) \
+	do { \
+		u32 ar; \
+		\
+		vmcs_writel(GUEST_##seg##_BASE, sregs->var.base);  \
+		vmcs_write32(GUEST_##seg##_LIMIT, sregs->var.limit); \
+		vmcs_write16(GUEST_##seg##_SELECTOR, sregs->var.selector); \
+		if (sregs->var.unusable) { \
+			ar = (1 << 16); \
+		} else { \
+			ar = (sregs->var.type & 15); \
+			ar |= (sregs->var.s & 1) << 4; \
+			ar |= (sregs->var.dpl & 3) << 5; \
+			ar |= (sregs->var.present & 1) << 7; \
+			ar |= (sregs->var.avl & 1) << 12; \
+			ar |= (sregs->var.l & 1) << 13; \
+			ar |= (sregs->var.db & 1) << 14; \
+			ar |= (sregs->var.g & 1) << 15; \
+		} \
+		vmcs_write32(GUEST_##seg##_AR_BYTES, ar); \
+	} while (0);
+
+	set_segment(cs, CS);
+	set_segment(ds, DS);
+	set_segment(es, ES);
+	set_segment(fs, FS);
+	set_segment(gs, GS);
+	set_segment(ss, SS);
+
+	set_segment(tr, TR);
+
+	set_segment(ldt, LDTR);
+#undef set_segment
+
+#define set_dtable(var, table) \
+	vmcs_write32(GUEST_##table##_LIMIT, sregs->var.limit), \
+	vmcs_writel(GUEST_##table##_BASE, sregs->var.base)
+
+	set_dtable(idt, IDTR);
+	set_dtable(gdt, GDTR);
+#undef set_dtable
+
+	vcpu->cr2 = sregs->cr2;
+	mmu_reset_needed |= vcpu->cr3 != sregs->cr3;
+	vcpu->cr3 = sregs->cr3;
+
+	vcpu->cr8 = sregs->cr8;
+
+	mmu_reset_needed |= vcpu->shadow_efer != sregs->efer;
+#ifdef __x86_64__
+	__set_efer(vcpu, sregs->efer);
+#endif
+	vcpu->apic_base = sregs->apic_base;
+
+	mmu_reset_needed |= guest_cr0() != sregs->cr0;
+	__set_cr0(vcpu, sregs->cr0);
+
+	mmu_reset_needed |=  guest_cr4() != sregs->cr4;
+	__set_cr4(vcpu, sregs->cr4);
+
+	if (mmu_reset_needed)
+		kvm_mmu_reset_context(vcpu);
+	vcpu_put(vcpu);
+
+	return 0;
+}
+
+/*
+ * Translate a guest virtual address to a guest physical address.
+ */
+static int kvm_dev_ioctl_translate(struct kvm *kvm, struct kvm_translation *tr)
+{
+	unsigned long vaddr = tr->linear_address;
+	struct kvm_vcpu *vcpu;
+	gpa_t gpa;
+
+	vcpu = vcpu_load(kvm, tr->vcpu);
+	if (!vcpu)
+		return -ENOENT;
+	spin_lock(&kvm->lock);
+	gpa = vcpu->mmu.gva_to_gpa(vcpu, vaddr);
+	tr->physical_address = gpa;
+	tr->valid = gpa != UNMAPPED_GVA;
+	tr->writeable = 1;
+	tr->usermode = 0;
+	spin_unlock(&kvm->lock);
+	vcpu_put(vcpu);
+
+	return 0;
+}
+
 static long kvm_dev_ioctl(struct file *filp,
 			  unsigned int ioctl, unsigned long arg)
 {
@@ -1291,6 +1886,81 @@ static long kvm_dev_ioctl(struct file *f
 	int r = -EINVAL;
 
 	switch (ioctl) {
+	case KVM_CREATE_VCPU: {
+		r = kvm_dev_ioctl_create_vcpu(kvm, arg);
+		if (r)
+			goto out;
+		break;
+	}
+	case KVM_GET_REGS: {
+		struct kvm_regs kvm_regs;
+
+		r = -EFAULT;
+		if (copy_from_user(&kvm_regs, (void *)arg, sizeof kvm_regs))
+			goto out;
+		r = kvm_dev_ioctl_get_regs(kvm, &kvm_regs);
+		if (r)
+			goto out;
+		r = -EFAULT;
+		if (copy_to_user((void *)arg, &kvm_regs, sizeof kvm_regs))
+			goto out;
+		r = 0;
+		break;
+	}
+	case KVM_SET_REGS: {
+		struct kvm_regs kvm_regs;
+
+		r = -EFAULT;
+		if (copy_from_user(&kvm_regs, (void *)arg, sizeof kvm_regs))
+			goto out;
+		r = kvm_dev_ioctl_set_regs(kvm, &kvm_regs);
+		if (r)
+			goto out;
+		r = 0;
+		break;
+	}
+	case KVM_GET_SREGS: {
+		struct kvm_sregs kvm_sregs;
+
+		r = -EFAULT;
+		if (copy_from_user(&kvm_sregs, (void *)arg, sizeof kvm_sregs))
+			goto out;
+		r = kvm_dev_ioctl_get_sregs(kvm, &kvm_sregs);
+		if (r)
+			goto out;
+		r = -EFAULT;
+		if (copy_to_user((void *)arg, &kvm_sregs, sizeof kvm_sregs))
+			goto out;
+		r = 0;
+		break;
+	}
+	case KVM_SET_SREGS: {
+		struct kvm_sregs kvm_sregs;
+
+		r = -EFAULT;
+		if (copy_from_user(&kvm_sregs, (void *)arg, sizeof kvm_sregs))
+			goto out;
+		r = kvm_dev_ioctl_set_sregs(kvm, &kvm_sregs);
+		if (r)
+			goto out;
+		r = 0;
+		break;
+	}
+	case KVM_TRANSLATE: {
+		struct kvm_translation tr;
+
+		r = -EFAULT;
+		if (copy_from_user(&tr, (void *)arg, sizeof tr))
+			goto out;
+		r = kvm_dev_ioctl_translate(kvm, &tr);
+		if (r)
+			goto out;
+		r = -EFAULT;
+		if (copy_to_user((void *)arg, &tr, sizeof tr))
+			goto out;
+		r = 0;
+		break;
+	}
 	case KVM_SET_MEMORY_REGION: {
 		struct kvm_memory_region kvm_mem;
 
