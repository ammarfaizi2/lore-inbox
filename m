Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758113AbWK0M0m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758113AbWK0M0m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 07:26:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758114AbWK0M0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 07:26:42 -0500
Received: from il.qumranet.com ([62.219.232.206]:24457 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1758113AbWK0M0k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 07:26:40 -0500
Subject: [PATCH 16/38] KVM: Make vcpu_setup() an arch operation
From: Avi Kivity <avi@qumranet.com>
Date: Mon, 27 Nov 2006 12:26:37 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <456AD5C6.1090406@qumranet.com>
In-Reply-To: <456AD5C6.1090406@qumranet.com>
Message-Id: <20061127122637.CA81925015E@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm.h
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm.h
+++ linux-2.6/drivers/kvm/kvm.h
@@ -153,6 +153,17 @@ enum {
 	NR_VCPU_REGS
 };
 
+enum {
+	VCPU_SREG_CS,
+	VCPU_SREG_DS,
+	VCPU_SREG_ES,
+	VCPU_SREG_FS,
+	VCPU_SREG_GS,
+	VCPU_SREG_SS,
+	VCPU_SREG_TR,
+	VCPU_SREG_LDTR,
+};
+
 struct kvm_vcpu {
 	struct kvm *kvm;
 	struct vmcs *vmcs;
@@ -266,8 +277,8 @@ struct kvm_arch_ops {
 	void (*decache_regs)(struct kvm_vcpu *vcpu);
 
 	int (*run)(struct kvm_vcpu *vcpu, struct kvm_run *run);
+	int (*vcpu_setup)(struct kvm_vcpu *vcpu);
 	void (*skip_emulated_instruction)(struct kvm_vcpu *vcpu);
-	unsigned long vmx_return; /* temporary hack */
 };
 
 extern struct kvm_stat kvm_stat;
@@ -324,12 +335,18 @@ void set_cr4(struct kvm_vcpu *vcpu, unsi
 void set_cr8(struct kvm_vcpu *vcpu, unsigned long cr0);
 void lmsw(struct kvm_vcpu *vcpu, unsigned long msw);
 
+void __set_efer(struct kvm_vcpu *vcpu, u64 efer);
+void __set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0);
+void __set_cr4(struct kvm_vcpu *vcpu, unsigned long cr0);
+
+int rmode_tss_base(struct kvm* kvm); /* temporary hack */
 void inject_gp(struct kvm_vcpu *vcpu);
 
 #ifdef __x86_64__
 void set_efer(struct kvm_vcpu *vcpu, u64 efer);
 #endif
 
+void fx_init(struct kvm_vcpu *vcpu);
 
 void load_msrs(struct vmx_msr_entry *e, int n);
 void save_msrs(struct vmx_msr_entry *e, int n);
@@ -348,6 +365,12 @@ int kvm_write_guest(struct kvm_vcpu *vcp
 void vmcs_writel(unsigned long field, unsigned long value);
 unsigned long vmcs_readl(unsigned long field);
 
+static inline struct page *_gfn_to_page(struct kvm *kvm, gfn_t gfn)
+{
+	struct kvm_memory_slot *slot = gfn_to_memslot(kvm, gfn);
+	return (slot) ? slot->phys_mem[gfn - slot->base_gfn] : 0;
+}
+
 static inline u16 vmcs_read16(unsigned long field)
 {
 	return vmcs_readl(field);
@@ -465,6 +488,11 @@ static inline void load_ldt(u16 sel)
 }
 #endif
 
+static inline void get_idt(struct descriptor_table *table)
+{
+	asm ("sidt %0" : "=m"(*table));
+}
+
 #ifdef __x86_64__
 static inline unsigned long read_msr(unsigned long msr)
 {
@@ -490,6 +518,11 @@ static inline void fpu_init(void)
 	asm ("finit");
 }
 
+static inline u32 get_rdx_init_val(void)
+{
+	return 0x600; /* P6 family */
+}
+
 #define ASM_VMX_VMCLEAR_RAX       ".byte 0x66, 0x0f, 0xc7, 0x30"
 #define ASM_VMX_VMLAUNCH          ".byte 0x0f, 0x01, 0xc2"
 #define ASM_VMX_VMRESUME          ".byte 0x0f, 0x01, 0xc3"
@@ -502,6 +535,12 @@ static inline void fpu_init(void)
 
 #define MSR_IA32_TIME_STAMP_COUNTER		0x010
 
+#define TSS_IOPB_BASE_OFFSET 0x66
+#define TSS_BASE_SIZE 0x68
+#define TSS_IOPB_SIZE (65536 / 8)
+#define TSS_REDIRECTION_SIZE (256 / 8)
+#define RMODE_TSS_SIZE (TSS_BASE_SIZE + TSS_REDIRECTION_SIZE + TSS_IOPB_SIZE + 1)
+
 #ifdef __x86_64__
 
 /*
Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -65,17 +65,6 @@ static struct kvm_stats_debugfs_item {
 
 static struct dentry *debugfs_dir;
 
-enum {
-	VCPU_SREG_CS,
-	VCPU_SREG_DS,
-	VCPU_SREG_ES,
-	VCPU_SREG_FS,
-	VCPU_SREG_GS,
-	VCPU_SREG_SS,
-	VCPU_SREG_TR,
-	VCPU_SREG_LDTR,
-};
-
 #define VMX_SEGMENT_FIELD(seg)					\
 	[VCPU_SREG_##seg] {                                     \
 		GUEST_##seg##_SELECTOR,				\
@@ -101,26 +90,6 @@ struct kvm_vmx_segment_field {
 };
 EXPORT_SYMBOL_GPL(kvm_vmx_segment_fields);
 
-static const u32 vmx_msr_index[] = {
-#ifdef __x86_64__
-	MSR_SYSCALL_MASK, MSR_LSTAR, MSR_CSTAR, MSR_KERNEL_GS_BASE,
-#endif
-	MSR_EFER, MSR_K6_STAR,
-};
-#define NR_VMX_MSR (sizeof(vmx_msr_index) / sizeof(*vmx_msr_index))
-
-#define TSS_IOPB_BASE_OFFSET 0x66
-#define TSS_BASE_SIZE 0x68
-#define TSS_IOPB_SIZE (65536 / 8)
-#define TSS_REDIRECTION_SIZE (256 / 8)
-#define RMODE_TSS_SIZE (TSS_BASE_SIZE + TSS_REDIRECTION_SIZE + TSS_IOPB_SIZE + 1)
-
-#define MSR_IA32_FEATURE_CONTROL 		0x03a
-#define MSR_IA32_VMX_PINBASED_CTLS_MSR		0x481
-#define MSR_IA32_VMX_PROCBASED_CTLS_MSR		0x482
-#define MSR_IA32_VMX_EXIT_CTLS_MSR		0x483
-#define MSR_IA32_VMX_ENTRY_CTLS_MSR		0x484
-
 #define MAX_IO_MSRS 256
 
 #define CR0_RESEVED_BITS 0xffffffff1ffaffc0ULL
@@ -129,12 +98,6 @@ static const u32 vmx_msr_index[] = {
 #define CR8_RESEVED_BITS (~0x0fULL)
 #define EFER_RESERVED_BITS 0xfffffffffffff2fe
 
-#ifdef __x86_64__
-#define HOST_IS_64 1
-#else
-#define HOST_IS_64 0
-#endif
-
 struct vmx_msr_entry *find_msr_entry(struct kvm_vcpu *vcpu, u32 msr)
 {
 	int i;
@@ -151,11 +114,6 @@ static void get_gdt(struct descriptor_ta
 	asm ("sgdt %0" : "=m"(*table));
 }
 
-static void get_idt(struct descriptor_table *table)
-{
-	asm ("sidt %0" : "=m"(*table));
-}
-
 struct segment_descriptor {
 	u16 limit_low;
 	u16 base_low;
@@ -227,12 +185,6 @@ struct vmcs_descriptor {
 } vmcs_descriptor;
 EXPORT_SYMBOL_GPL(vmcs_descriptor);
 
-static inline struct page *_gfn_to_page(struct kvm *kvm, gfn_t gfn)
-{
-	struct kvm_memory_slot *slot = gfn_to_memslot(kvm, gfn);
-	return (slot) ? slot->phys_mem[gfn - slot->base_gfn] : 0;
-}
-
 int kvm_read_guest(struct kvm_vcpu *vcpu,
 			     gva_t addr,
 			     unsigned long size,
@@ -630,11 +582,12 @@ static void enter_pmode(struct kvm_vcpu 
 	vmcs_write32(GUEST_CS_AR_BYTES, 0x9b);
 }
 
-static int rmode_tss_base(struct kvm* kvm)
+int rmode_tss_base(struct kvm* kvm)
 {
 	gfn_t base_gfn = kvm->memslots[0].base_gfn + kvm->memslots[0].npages - 3;
 	return base_gfn << PAGE_SHIFT;
 }
+EXPORT_SYMBOL_GPL(rmode_tss_base);
 
 static void fix_rmode_seg(int seg, struct kvm_save_segment *save)
 {
@@ -686,41 +639,9 @@ static void enter_rmode(struct kvm_vcpu 
 	fix_rmode_seg(VCPU_SREG_FS, &vcpu->rmode.fs);
 }
 
-static int init_rmode_tss(struct kvm* kvm)
-{
-	struct page *p1, *p2, *p3;
-	gfn_t fn = rmode_tss_base(kvm) >> PAGE_SHIFT;
-	char *page;
-
-	p1 = _gfn_to_page(kvm, fn++);
-	p2 = _gfn_to_page(kvm, fn++);
-	p3 = _gfn_to_page(kvm, fn);
-
-	if (!p1 || !p2 || !p3) {
-		kvm_printf(kvm,"%s: gfn_to_page failed\n", __FUNCTION__);
-		return 0;
-	}
-
-	page = kmap_atomic(p1, KM_USER0);
-	memset(page, 0, PAGE_SIZE);
-	*(u16*)(page + 0x66) = TSS_BASE_SIZE + TSS_REDIRECTION_SIZE;
-	kunmap_atomic(page, KM_USER0);
-
-	page = kmap_atomic(p2, KM_USER0);
-	memset(page, 0, PAGE_SIZE);
-	kunmap_atomic(page, KM_USER0);
-
-	page = kmap_atomic(p3, KM_USER0);
-	memset(page, 0, PAGE_SIZE);
-	*(page + RMODE_TSS_SIZE - 2 * PAGE_SIZE - 1) = ~0;
-	kunmap_atomic(page, KM_USER0);
-
-	return 1;
-}
-
 #ifdef __x86_64__
 
-static void __set_efer(struct kvm_vcpu *vcpu, u64 efer)
+void __set_efer(struct kvm_vcpu *vcpu, u64 efer)
 {
 	struct vmx_msr_entry *msr = find_msr_entry(vcpu, MSR_EFER);
 
@@ -739,6 +660,7 @@ static void __set_efer(struct kvm_vcpu *
 		msr->data = efer & ~EFER_LME;
 	}
 }
+EXPORT_SYMBOL_GPL(__set_efer);
 
 static void enter_lmode(struct kvm_vcpu *vcpu)
 {
@@ -772,7 +694,7 @@ static void exit_lmode(struct kvm_vcpu *
 
 #endif
 
-static void __set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
+void __set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
 {
 	if (vcpu->rmode.active && (cr0 & CR0_PE_MASK))
 		enter_pmode(vcpu);
@@ -794,6 +716,7 @@ static void __set_cr0(struct kvm_vcpu *v
 		    (cr0 & ~KVM_GUEST_CR0_MASK) | KVM_VM_CR0_ALWAYS_ON);
 	vcpu->cr0 = cr0;
 }
+EXPORT_SYMBOL_GPL(__set_cr0);
 
 static int pdptrs_have_reserved_bits_set(struct kvm_vcpu *vcpu,
 					 unsigned long cr3)
@@ -899,13 +822,14 @@ void lmsw(struct kvm_vcpu *vcpu, unsigne
 }
 EXPORT_SYMBOL_GPL(lmsw);
 
-static void __set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
+void __set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
 {
 	vmcs_writel(CR4_READ_SHADOW, cr4);
 	vmcs_writel(GUEST_CR4, cr4 | (vcpu->rmode.active ?
 		    KVM_RMODE_VM_CR4_ALWAYS_ON : KVM_PMODE_VM_CR4_ALWAYS_ON));
 	vcpu->cr4 = cr4;
 }
+EXPORT_SYMBOL_GPL(__set_cr4);
 
 void set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
 {
@@ -981,12 +905,7 @@ void set_cr8(struct kvm_vcpu *vcpu, unsi
 }
 EXPORT_SYMBOL_GPL(set_cr8);
 
-static u32 get_rdx_init_val(void)
-{
-	return 0x600; /* P6 family */
-}
-
-static void fx_init(struct kvm_vcpu *vcpu)
+void fx_init(struct kvm_vcpu *vcpu)
 {
 	struct __attribute__ ((__packed__)) fx_image_s {
 		u16 control; //fcw
@@ -1010,237 +929,7 @@ static void fx_init(struct kvm_vcpu *vcp
 	memset(vcpu->guest_fx_image + sizeof(struct fx_image_s),
 	       0, FX_IMAGE_SIZE - sizeof(struct fx_image_s));
 }
-
-static void vmcs_write32_fixedbits(u32 msr, u32 vmcs_field, u32 val)
-{
-	u32 msr_high, msr_low;
-
-	rdmsr(msr, msr_low, msr_high);
-
-	val &= msr_high;
-	val |= msr_low;
-	vmcs_write32(vmcs_field, val);
-}
-
-static void seg_setup(int seg)
-{
-	struct kvm_vmx_segment_field *sf = &kvm_vmx_segment_fields[seg];
-
-	vmcs_write16(sf->selector, 0);
-	vmcs_writel(sf->base, 0);
-	vmcs_write32(sf->limit, 0xffff);
-	vmcs_write32(sf->ar_bytes, 0x93);
-}
-
-/*
- * Sets up the vmcs for emulated real mode.
- */
-static int kvm_vcpu_setup(struct kvm_vcpu *vcpu)
-{
-	u32 host_sysenter_cs;
-	u32 junk;
-	unsigned long a;
-	struct descriptor_table dt;
-	int i;
-	int ret;
-	int nr_good_msrs;
-
-
-	if (!init_rmode_tss(vcpu->kvm)) {
-		ret = 0;
-		goto out;
-	}
-
-	memset(vcpu->regs, 0, sizeof(vcpu->regs));
-	vcpu->regs[VCPU_REGS_RDX] = get_rdx_init_val();
-	vcpu->cr8 = 0;
-	vcpu->apic_base = 0xfee00000 |
-			/*for vcpu 0*/ MSR_IA32_APICBASE_BSP |
-			MSR_IA32_APICBASE_ENABLE;
-
-	fx_init(vcpu);
-
-	/*
-	 * GUEST_CS_BASE should really be 0xffff0000, but VT vm86 mode
-	 * insists on having GUEST_CS_BASE == GUEST_CS_SELECTOR << 4.  Sigh.
-	 */
-	vmcs_write16(GUEST_CS_SELECTOR, 0xf000);
-	vmcs_writel(GUEST_CS_BASE, 0x000f0000);
-	vmcs_write32(GUEST_CS_LIMIT, 0xffff);
-	vmcs_write32(GUEST_CS_AR_BYTES, 0x9b);
-
-	seg_setup(VCPU_SREG_DS);
-	seg_setup(VCPU_SREG_ES);
-	seg_setup(VCPU_SREG_FS);
-	seg_setup(VCPU_SREG_GS);
-	seg_setup(VCPU_SREG_SS);
-
-	vmcs_write16(GUEST_TR_SELECTOR, 0);
-	vmcs_writel(GUEST_TR_BASE, 0);
-	vmcs_write32(GUEST_TR_LIMIT, 0xffff);
-	vmcs_write32(GUEST_TR_AR_BYTES, 0x008b);
-
-	vmcs_write16(GUEST_LDTR_SELECTOR, 0);
-	vmcs_writel(GUEST_LDTR_BASE, 0);
-	vmcs_write32(GUEST_LDTR_LIMIT, 0xffff);
-	vmcs_write32(GUEST_LDTR_AR_BYTES, 0x00082);
-
-	vmcs_write32(GUEST_SYSENTER_CS, 0);
-	vmcs_writel(GUEST_SYSENTER_ESP, 0);
-	vmcs_writel(GUEST_SYSENTER_EIP, 0);
-
-	vmcs_writel(GUEST_RFLAGS, 0x02);
-	vmcs_writel(GUEST_RIP, 0xfff0);
-	vmcs_writel(GUEST_RSP, 0);
-
-	vmcs_writel(GUEST_CR3, 0);
-
-	//todo: dr0 = dr1 = dr2 = dr3 = 0; dr6 = 0xffff0ff0
-	vmcs_writel(GUEST_DR7, 0x400);
-
-	vmcs_writel(GUEST_GDTR_BASE, 0);
-	vmcs_write32(GUEST_GDTR_LIMIT, 0xffff);
-
-	vmcs_writel(GUEST_IDTR_BASE, 0);
-	vmcs_write32(GUEST_IDTR_LIMIT, 0xffff);
-
-	vmcs_write32(GUEST_ACTIVITY_STATE, 0);
-	vmcs_write32(GUEST_INTERRUPTIBILITY_INFO, 0);
-	vmcs_write32(GUEST_PENDING_DBG_EXCEPTIONS, 0);
-
-	/* I/O */
-	vmcs_write64(IO_BITMAP_A, 0);
-	vmcs_write64(IO_BITMAP_B, 0);
-
-	guest_write_tsc(0);
-
-	vmcs_write64(VMCS_LINK_POINTER, -1ull); /* 22.3.1.5 */
-
-	/* Special registers */
-	vmcs_write64(GUEST_IA32_DEBUGCTL, 0);
-
-	/* Control */
-	vmcs_write32_fixedbits(MSR_IA32_VMX_PINBASED_CTLS_MSR,
-			       PIN_BASED_VM_EXEC_CONTROL,
-			       PIN_BASED_EXT_INTR_MASK   /* 20.6.1 */
-			       | PIN_BASED_NMI_EXITING   /* 20.6.1 */
-			);
-	vmcs_write32_fixedbits(MSR_IA32_VMX_PROCBASED_CTLS_MSR,
-			       CPU_BASED_VM_EXEC_CONTROL,
-			       CPU_BASED_HLT_EXITING         /* 20.6.2 */
-			       | CPU_BASED_CR8_LOAD_EXITING    /* 20.6.2 */
-			       | CPU_BASED_CR8_STORE_EXITING   /* 20.6.2 */
-			       | CPU_BASED_UNCOND_IO_EXITING   /* 20.6.2 */
-			       | CPU_BASED_INVDPG_EXITING
-			       | CPU_BASED_MOV_DR_EXITING
-			       | CPU_BASED_USE_TSC_OFFSETING   /* 21.3 */
-			);
-
-	vmcs_write32(EXCEPTION_BITMAP, 1 << PF_VECTOR);
-	vmcs_write32(PAGE_FAULT_ERROR_CODE_MASK, 0);
-	vmcs_write32(PAGE_FAULT_ERROR_CODE_MATCH, 0);
-	vmcs_write32(CR3_TARGET_COUNT, 0);           /* 22.2.1 */
-
-	vmcs_writel(HOST_CR0, read_cr0());  /* 22.2.3 */
-	vmcs_writel(HOST_CR4, read_cr4());  /* 22.2.3, 22.2.5 */
-	vmcs_writel(HOST_CR3, read_cr3());  /* 22.2.3  FIXME: shadow tables */
-
-	vmcs_write16(HOST_CS_SELECTOR, __KERNEL_CS);  /* 22.2.4 */
-	vmcs_write16(HOST_DS_SELECTOR, __KERNEL_DS);  /* 22.2.4 */
-	vmcs_write16(HOST_ES_SELECTOR, __KERNEL_DS);  /* 22.2.4 */
-	vmcs_write16(HOST_FS_SELECTOR, read_fs());    /* 22.2.4 */
-	vmcs_write16(HOST_GS_SELECTOR, read_gs());    /* 22.2.4 */
-	vmcs_write16(HOST_SS_SELECTOR, __KERNEL_DS);  /* 22.2.4 */
-#ifdef __x86_64__
-	rdmsrl(MSR_FS_BASE, a);
-	vmcs_writel(HOST_FS_BASE, a); /* 22.2.4 */
-	rdmsrl(MSR_GS_BASE, a);
-	vmcs_writel(HOST_GS_BASE, a); /* 22.2.4 */
-#else
-	vmcs_writel(HOST_FS_BASE, 0); /* 22.2.4 */
-	vmcs_writel(HOST_GS_BASE, 0); /* 22.2.4 */
-#endif
-
-	vmcs_write16(HOST_TR_SELECTOR, GDT_ENTRY_TSS*8);  /* 22.2.4 */
-
-	get_idt(&dt);
-	vmcs_writel(HOST_IDTR_BASE, dt.base);   /* 22.2.4 */
-
-
-	vmcs_writel(HOST_RIP, kvm_arch_ops->vmx_return); /* 22.2.5 */
-
-	rdmsr(MSR_IA32_SYSENTER_CS, host_sysenter_cs, junk);
-	vmcs_write32(HOST_IA32_SYSENTER_CS, host_sysenter_cs);
-	rdmsrl(MSR_IA32_SYSENTER_ESP, a);
-	vmcs_writel(HOST_IA32_SYSENTER_ESP, a);   /* 22.2.3 */
-	rdmsrl(MSR_IA32_SYSENTER_EIP, a);
-	vmcs_writel(HOST_IA32_SYSENTER_EIP, a);   /* 22.2.3 */
-
-	ret = -ENOMEM;
-	vcpu->guest_msrs = kmalloc(PAGE_SIZE, GFP_KERNEL);
-	if (!vcpu->guest_msrs)
-		goto out;
-	vcpu->host_msrs = kmalloc(PAGE_SIZE, GFP_KERNEL);
-	if (!vcpu->host_msrs)
-		goto out_free_guest_msrs;
-
-	for (i = 0; i < NR_VMX_MSR; ++i) {
-		u32 index = vmx_msr_index[i];
-		u32 data_low, data_high;
-		u64 data;
-		int j = vcpu->nmsrs;
-
-		if (rdmsr_safe(index, &data_low, &data_high) < 0)
-			continue;
-		data = data_low | ((u64)data_high << 32);
-		vcpu->host_msrs[j].index = index;
-		vcpu->host_msrs[j].reserved = 0;
-		vcpu->host_msrs[j].data = data;
-		vcpu->guest_msrs[j] = vcpu->host_msrs[j];
-		++vcpu->nmsrs;
-	}
-	printk("msrs: %d\n", vcpu->nmsrs);
-
-	nr_good_msrs = vcpu->nmsrs - NR_BAD_MSRS;
-	vmcs_writel(VM_ENTRY_MSR_LOAD_ADDR,
-		    virt_to_phys(vcpu->guest_msrs + NR_BAD_MSRS));
-	vmcs_writel(VM_EXIT_MSR_STORE_ADDR,
-		    virt_to_phys(vcpu->guest_msrs + NR_BAD_MSRS));
-	vmcs_writel(VM_EXIT_MSR_LOAD_ADDR,
-		    virt_to_phys(vcpu->host_msrs + NR_BAD_MSRS));
-	vmcs_write32_fixedbits(MSR_IA32_VMX_EXIT_CTLS_MSR, VM_EXIT_CONTROLS,
-		     	       (HOST_IS_64 << 9));  /* 22.2,1, 20.7.1 */
-	vmcs_write32(VM_EXIT_MSR_STORE_COUNT, nr_good_msrs); /* 22.2.2 */
-	vmcs_write32(VM_EXIT_MSR_LOAD_COUNT, nr_good_msrs);  /* 22.2.2 */
-	vmcs_write32(VM_ENTRY_MSR_LOAD_COUNT, nr_good_msrs); /* 22.2.2 */
-
-
-	/* 22.2.1, 20.8.1 */
-	vmcs_write32_fixedbits(MSR_IA32_VMX_ENTRY_CTLS_MSR,
-                               VM_ENTRY_CONTROLS, 0);
-	vmcs_write32(VM_ENTRY_INTR_INFO_FIELD, 0);  /* 22.2.1 */
-
-	vmcs_writel(VIRTUAL_APIC_PAGE_ADDR, 0);
-	vmcs_writel(TPR_THRESHOLD, 0);
-
-	vmcs_writel(CR0_GUEST_HOST_MASK, KVM_GUEST_CR0_MASK);
-	vmcs_writel(CR4_GUEST_HOST_MASK, KVM_GUEST_CR4_MASK);
-
-	__set_cr0(vcpu, 0x60000010); // enter rmode
-	__set_cr4(vcpu, 0);
-#ifdef __x86_64__
-	__set_efer(vcpu, 0);
-#endif
-
-	ret = kvm_mmu_init(vcpu);
-
-	return ret;
-
-out_free_guest_msrs:
-	kfree(vcpu->guest_msrs);
-out:
-	return ret;
-}
+EXPORT_SYMBOL_GPL(fx_init);
 
 /*
  * Creates some virtual cpus.  Good luck creating more than one.
@@ -1281,7 +970,9 @@ static int kvm_dev_ioctl_create_vcpu(str
 
 	__vcpu_load(vcpu);
 
-	r = kvm_vcpu_setup(vcpu);
+	r = kvm_arch_ops->vcpu_setup(vcpu);
+	if (r >= 0)
+		r = kvm_mmu_init(vcpu);
 
 	vcpu_put(vcpu);
 
@@ -1514,6 +1205,7 @@ struct kvm_memory_slot *gfn_to_memslot(s
 	}
 	return 0;
 }
+EXPORT_SYMBOL_GPL(gfn_to_memslot);
 
 void mark_page_dirty(struct kvm *kvm, gfn_t gfn)
 {
Index: linux-2.6/drivers/kvm/vmx.c
===================================================================
--- linux-2.6.orig/drivers/kvm/vmx.c
+++ linux-2.6/drivers/kvm/vmx.c
@@ -19,6 +19,9 @@
 #include <linux/module.h>
 #include "vmx.h"
 #include "kvm_vmx.h"
+#include <linux/mm.h>
+#include <linux/highmem.h>
+#include <asm/io.h>
 
 #define MSR_IA32_FEATURE_CONTROL 		0x03a
 
@@ -27,6 +30,12 @@ MODULE_LICENSE("GPL");
 
 DECLARE_PER_CPU(struct vmcs *, vmxarea);
 
+#ifdef __x86_64__
+#define HOST_IS_64 1
+#else
+#define HOST_IS_64 0
+#endif
+
 extern struct vmcs_descriptor {
 	int size;
 	int order;
@@ -40,6 +49,14 @@ extern struct kvm_vmx_segment_field {
 	unsigned ar_bytes;
 } kvm_vmx_segment_fields[];
 
+static const u32 vmx_msr_index[] = {
+#ifdef __x86_64__
+	MSR_SYSCALL_MASK, MSR_LSTAR, MSR_CSTAR, MSR_KERNEL_GS_BASE,
+#endif
+	MSR_EFER, MSR_K6_STAR,
+};
+#define NR_VMX_MSR (sizeof(vmx_msr_index) / sizeof(*vmx_msr_index))
+
 u64 guest_read_tsc(void);
 void guest_write_tsc(u64 guest_tsc);
 struct vmx_msr_entry *find_msr_entry(struct kvm_vcpu *vcpu, u32 msr);
@@ -436,6 +453,267 @@ static void vmx_set_gdt(struct kvm_vcpu 
 	vmcs_writel(GUEST_GDTR_BASE, dt->base);
 }
 
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
+static void seg_setup(int seg)
+{
+	struct kvm_vmx_segment_field *sf = &kvm_vmx_segment_fields[seg];
+
+	vmcs_write16(sf->selector, 0);
+	vmcs_writel(sf->base, 0);
+	vmcs_write32(sf->limit, 0xffff);
+	vmcs_write32(sf->ar_bytes, 0x93);
+}
+
+/*
+ * Sets up the vmcs for emulated real mode.
+ */
+static int vmx_vcpu_setup(struct kvm_vcpu *vcpu)
+{
+	u32 host_sysenter_cs;
+	u32 junk;
+	unsigned long a;
+	struct descriptor_table dt;
+	int i;
+	int ret = 0;
+	int nr_good_msrs;
+	extern asmlinkage void kvm_vmx_return(void);
+
+	if (!init_rmode_tss(vcpu->kvm)) {
+		ret = -ENOMEM;
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
+	/*
+	 * GUEST_CS_BASE should really be 0xffff0000, but VT vm86 mode
+	 * insists on having GUEST_CS_BASE == GUEST_CS_SELECTOR << 4.  Sigh.
+	 */
+	vmcs_write16(GUEST_CS_SELECTOR, 0xf000);
+	vmcs_writel(GUEST_CS_BASE, 0x000f0000);
+	vmcs_write32(GUEST_CS_LIMIT, 0xffff);
+	vmcs_write32(GUEST_CS_AR_BYTES, 0x9b);
+
+	seg_setup(VCPU_SREG_DS);
+	seg_setup(VCPU_SREG_ES);
+	seg_setup(VCPU_SREG_FS);
+	seg_setup(VCPU_SREG_GS);
+	seg_setup(VCPU_SREG_SS);
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
+	guest_write_tsc(0);
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
+		u32 data_low, data_high;
+		u64 data;
+		int j = vcpu->nmsrs;
+
+		if (rdmsr_safe(index, &data_low, &data_high) < 0)
+			continue;
+		data = data_low | ((u64)data_high << 32);
+		vcpu->host_msrs[j].index = index;
+		vcpu->host_msrs[j].reserved = 0;
+		vcpu->host_msrs[j].data = data;
+		vcpu->guest_msrs[j] = vcpu->host_msrs[j];
+		++vcpu->nmsrs;
+	}
+	printk("msrs: %d\n", vcpu->nmsrs);
+
+	nr_good_msrs = vcpu->nmsrs - NR_BAD_MSRS;
+	vmcs_writel(VM_ENTRY_MSR_LOAD_ADDR,
+		    virt_to_phys(vcpu->guest_msrs + NR_BAD_MSRS));
+	vmcs_writel(VM_EXIT_MSR_STORE_ADDR,
+		    virt_to_phys(vcpu->guest_msrs + NR_BAD_MSRS));
+	vmcs_writel(VM_EXIT_MSR_LOAD_ADDR,
+		    virt_to_phys(vcpu->host_msrs + NR_BAD_MSRS));
+	vmcs_write32_fixedbits(MSR_IA32_VMX_EXIT_CTLS_MSR, VM_EXIT_CONTROLS,
+		     	       (HOST_IS_64 << 9));  /* 22.2,1, 20.7.1 */
+	vmcs_write32(VM_EXIT_MSR_STORE_COUNT, nr_good_msrs); /* 22.2.2 */
+	vmcs_write32(VM_EXIT_MSR_LOAD_COUNT, nr_good_msrs);  /* 22.2.2 */
+	vmcs_write32(VM_ENTRY_MSR_LOAD_COUNT, nr_good_msrs); /* 22.2.2 */
+
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
+	return 0;
+
+out_free_guest_msrs:
+	kfree(vcpu->guest_msrs);
+out:
+	return ret;
+}
+
 static void inject_rmode_irq(struct kvm_vcpu *vcpu, int irq)
 {
 	u16 ent[2];
@@ -1133,8 +1411,6 @@ again:
 	return 0;
 }
 
-extern asmlinkage void kvm_vmx_return(void);
-
 static struct kvm_arch_ops vmx_arch_ops = {
 	.cpu_has_kvm_support = cpu_has_kvm_support,
 	.disabled_by_bios = vmx_disabled_by_bios,
@@ -1158,7 +1434,7 @@ static struct kvm_arch_ops vmx_arch_ops 
 
 	.run = vmx_vcpu_run,
 	.skip_emulated_instruction = skip_emulated_instruction,
-	.vmx_return = (unsigned long)kvm_vmx_return,
+	.vcpu_setup = vmx_vcpu_setup,
 };
 
 static int __init vmx_init(void)
Index: linux-2.6/drivers/kvm/vmx.h
===================================================================
--- linux-2.6.orig/drivers/kvm/vmx.h
+++ linux-2.6/drivers/kvm/vmx.h
@@ -287,5 +287,10 @@ enum vmcs_field {
 #define CR4_VMXE 0x2000
 
 #define MSR_IA32_VMX_BASIC_MSR   		0x480
+#define MSR_IA32_FEATURE_CONTROL 		0x03a
+#define MSR_IA32_VMX_PINBASED_CTLS_MSR		0x481
+#define MSR_IA32_VMX_PROCBASED_CTLS_MSR		0x482
+#define MSR_IA32_VMX_EXIT_CTLS_MSR		0x483
+#define MSR_IA32_VMX_ENTRY_CTLS_MSR		0x484
 
 #endif
