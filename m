Return-Path: <linux-kernel-owner+w=401wt.eu-S1760565AbWLJJMn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760565AbWLJJMn (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 04:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760567AbWLJJMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 04:12:42 -0500
Received: from il.qumranet.com ([62.219.232.206]:43343 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760565AbWLJJMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 04:12:41 -0500
Subject: [PATCH] KVM: AMD SVM: 32-bit host support
From: Avi Kivity <avi@qumranet.com>
Date: Sun, 10 Dec 2006 09:12:38 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu,
       anthony@codemonkey.ws
Message-Id: <20061210091238.573962500CF@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anthony Liguori <anthony@codemonkey.ws>

This patch enables kvm support for 32-bit AMD SVM hosts.

Signed-off-by: Anthony Liguori <anthony@codemonkey.ws>
Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm_svm.h
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_svm.h
+++ linux-2.6/drivers/kvm/kvm_svm.h
@@ -9,11 +9,13 @@
 #include "kvm.h"
 
 static const u32 host_save_msrs[] = {
+#ifdef __x86_64__
 	MSR_STAR, MSR_LSTAR, MSR_CSTAR, MSR_SYSCALL_MASK, MSR_KERNEL_GS_BASE,
+	MSR_FS_BASE, MSR_GS_BASE,
+#endif
 	MSR_IA32_SYSENTER_CS, MSR_IA32_SYSENTER_ESP, MSR_IA32_SYSENTER_EIP,
 	MSR_IA32_DEBUGCTLMSR, /*MSR_IA32_LASTBRANCHFROMIP,
 	MSR_IA32_LASTBRANCHTOIP, MSR_IA32_LASTINTFROMIP,MSR_IA32_LASTINTTOIP,*/
-	MSR_FS_BASE, MSR_GS_BASE,
 };
 
 #define NR_HOST_SAVE_MSRS (sizeof(host_save_msrs) / sizeof(*host_save_msrs))
Index: linux-2.6/drivers/kvm/svm.c
===================================================================
--- linux-2.6.orig/drivers/kvm/svm.c
+++ linux-2.6/drivers/kvm/svm.c
@@ -39,16 +39,28 @@ MODULE_LICENSE("GPL");
 #define SEG_TYPE_LDT 2
 #define SEG_TYPE_BUSY_TSS16 3
 
+#define KVM_EFER_LMA (1 << 10)
+#define KVM_EFER_LME (1 << 8)
+
 unsigned long iopm_base;
 unsigned long msrpm_base;
 
+struct kvm_ldttss_desc {
+	u16 limit0;
+	u16 base0;
+	unsigned base1 : 8, type : 5, dpl : 2, p : 1;
+	unsigned limit1 : 4, zero0 : 3, g : 1, base2 : 8;
+	u32 base3;
+	u32 zero1;
+} __attribute__((packed));
+
 struct svm_cpu_data {
 	int cpu;
 
 	uint64_t asid_generation;
 	uint32_t max_asid;
 	uint32_t next_asid;
-	struct ldttss_desc *tss_desc;
+	struct kvm_ldttss_desc *tss_desc;
 
 	struct page *save_area;
 };
@@ -156,7 +168,7 @@ static inline void write_dr7(unsigned lo
 
 static inline int svm_is_long_mode(struct kvm_vcpu *vcpu)
 {
-	return vcpu->svm->vmcb->save.efer & EFER_LMA;
+	return vcpu->svm->vmcb->save.efer & KVM_EFER_LMA;
 }
 
 static inline void force_new_asid(struct kvm_vcpu *vcpu)
@@ -171,8 +183,8 @@ static inline void flush_guest_tlb(struc
 
 static void svm_set_efer(struct kvm_vcpu *vcpu, u64 efer)
 {
-	if (!(efer & EFER_LMA))
-		efer &= ~EFER_LME;
+	if (!(efer & KVM_EFER_LMA))
+		efer &= ~KVM_EFER_LME;
 
 	vcpu->svm->vmcb->save.efer = efer | MSR_EFER_SVME_MASK;
 	vcpu->shadow_efer = efer;
@@ -275,7 +287,11 @@ static void svm_hardware_enable(void *ga
 
 	struct svm_cpu_data *svm_data;
 	uint64_t efer;
+#ifdef __x86_64__
 	struct desc_ptr gdt_descr;
+#else
+	struct Xgt_desc_struct gdt_descr;
+#endif
 	struct desc_struct *gdt;
 	int me = raw_smp_processor_id();
 
@@ -297,7 +313,7 @@ static void svm_hardware_enable(void *ga
 
 	asm volatile ( "sgdt %0" : "=m"(gdt_descr) );
 	gdt = (struct desc_struct *)gdt_descr.address;
-	svm_data->tss_desc = (struct ldttss_desc *)(gdt + GDT_ENTRY_TSS);
+	svm_data->tss_desc = (struct kvm_ldttss_desc *)(gdt + GDT_ENTRY_TSS);
 
 	rdmsrl(MSR_EFER, efer);
 	wrmsrl(MSR_EFER, efer | MSR_EFER_SVME_MASK);
@@ -381,6 +397,7 @@ static __init int svm_hardware_setup(voi
 	memset(msrpm_va, 0xff, PAGE_SIZE * (1 << MSRPM_ALLOC_ORDER));
 	msrpm_base = page_to_pfn(msrpm_pages) << PAGE_SHIFT;
 
+#ifdef __x86_64__
 	set_msr_interception(msrpm_va, MSR_GS_BASE, 1, 1);
 	set_msr_interception(msrpm_va, MSR_FS_BASE, 1, 1);
 	set_msr_interception(msrpm_va, MSR_KERNEL_GS_BASE, 1, 1);
@@ -388,6 +405,7 @@ static __init int svm_hardware_setup(voi
 	set_msr_interception(msrpm_va, MSR_LSTAR, 1, 1);
 	set_msr_interception(msrpm_va, MSR_CSTAR, 1, 1);
 	set_msr_interception(msrpm_va, MSR_SYSCALL_MASK, 1, 1);
+#endif
 	set_msr_interception(msrpm_va, MSR_IA32_SYSENTER_CS, 1, 1);
 	set_msr_interception(msrpm_va, MSR_IA32_SYSENTER_ESP, 1, 1);
 	set_msr_interception(msrpm_va, MSR_IA32_SYSENTER_EIP, 1, 1);
@@ -687,15 +705,15 @@ static void svm_set_gdt(struct kvm_vcpu 
 static void svm_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
 {
 #ifdef __x86_64__
-	if (vcpu->shadow_efer & EFER_LME) {
+	if (vcpu->shadow_efer & KVM_EFER_LME) {
 		if (!is_paging(vcpu) && (cr0 & CR0_PG_MASK)) {
-			vcpu->shadow_efer |= EFER_LMA;
-			vcpu->svm->vmcb->save.efer |= EFER_LMA | EFER_LME;
+			vcpu->shadow_efer |= KVM_EFER_LMA;
+			vcpu->svm->vmcb->save.efer |= KVM_EFER_LMA | KVM_EFER_LME;
 		}
 
 		if (is_paging(vcpu) && !(cr0 & CR0_PG_MASK) ) {
-			vcpu->shadow_efer &= ~EFER_LMA;
-			vcpu->svm->vmcb->save.efer &= ~(EFER_LMA | EFER_LME);
+			vcpu->shadow_efer &= ~KVM_EFER_LMA;
+			vcpu->svm->vmcb->save.efer &= ~(KVM_EFER_LMA | KVM_EFER_LME);
 		}
 	}
 #endif
@@ -1079,6 +1097,7 @@ static int svm_get_msr(struct kvm_vcpu *
 	case MSR_IA32_APICBASE:
 		*data = vcpu->apic_base;
 		break;
+#ifdef __x86_64__
 	case MSR_STAR:
 		*data = vcpu->svm->vmcb->save.star;
 		break;
@@ -1088,6 +1107,13 @@ static int svm_get_msr(struct kvm_vcpu *
 	case MSR_CSTAR:
 		*data = vcpu->svm->vmcb->save.cstar;
 		break;
+	case MSR_KERNEL_GS_BASE:
+		*data = vcpu->svm->vmcb->save.kernel_gs_base;
+		break;
+	case MSR_SYSCALL_MASK:
+		*data = vcpu->svm->vmcb->save.sfmask;
+		break;
+#endif
 	case MSR_IA32_SYSENTER_CS:
 		*data = vcpu->svm->vmcb->save.sysenter_cs;
 		break;
@@ -1097,12 +1123,6 @@ static int svm_get_msr(struct kvm_vcpu *
 	case MSR_IA32_SYSENTER_ESP:
 		*data = vcpu->svm->vmcb->save.sysenter_esp;
 		break;
-	case MSR_KERNEL_GS_BASE:
-		*data = vcpu->svm->vmcb->save.kernel_gs_base;
-		break;
-	case MSR_SYSCALL_MASK:
-		*data = vcpu->svm->vmcb->save.sfmask;
-		break;
 	default:
 		printk(KERN_ERR "kvm: unhandled rdmsr: 0x%x\n", ecx);
 		return 1;
@@ -1152,6 +1172,7 @@ static int svm_set_msr(struct kvm_vcpu *
 	case MSR_IA32_APICBASE:
 		vcpu->apic_base = data;
 		break;
+#ifdef __x86_64___
 	case MSR_STAR:
 		vcpu->svm->vmcb->save.star = data;
 		break;
@@ -1161,6 +1182,13 @@ static int svm_set_msr(struct kvm_vcpu *
 	case MSR_CSTAR:
 		vcpu->svm->vmcb->save.cstar = data;
 		break;
+	case MSR_KERNEL_GS_BASE:
+		vcpu->svm->vmcb->save.kernel_gs_base = data;
+		break;
+	case MSR_SYSCALL_MASK:
+		vcpu->svm->vmcb->save.sfmask = data;
+		break;
+#endif
 	case MSR_IA32_SYSENTER_CS:
 		vcpu->svm->vmcb->save.sysenter_cs = data;
 		break;
@@ -1170,12 +1198,6 @@ static int svm_set_msr(struct kvm_vcpu *
 	case MSR_IA32_SYSENTER_ESP:
 		vcpu->svm->vmcb->save.sysenter_esp = data;
 		break;
-	case MSR_KERNEL_GS_BASE:
-		vcpu->svm->vmcb->save.kernel_gs_base = data;
-		break;
-	case MSR_SYSCALL_MASK:
-		vcpu->svm->vmcb->save.sfmask = data;
-		break;
 	default:
 		printk(KERN_ERR "kvm: unhandled wrmsr: %x\n", ecx);
 		return 1;
@@ -1323,6 +1345,7 @@ static void kvm_reput_irq(struct kvm_vcp
 
 static void save_db_regs(unsigned long *db_regs)
 {
+#ifdef __x86_64__
 	asm ("mov %%dr0, %%rax \n\t"
 	     "mov %%rax, %[dr0] \n\t"
 	     "mov %%dr1, %%rax \n\t"
@@ -1336,6 +1359,21 @@ static void save_db_regs(unsigned long *
 	       [dr2] "=m"(db_regs[2]),
 	       [dr3] "=m"(db_regs[3])
 	     : : "rax");
+#else
+	asm ("mov %%dr0, %%eax \n\t"
+	     "mov %%eax, %[dr0] \n\t"
+	     "mov %%dr1, %%eax \n\t"
+	     "mov %%eax, %[dr1] \n\t"
+	     "mov %%dr2, %%eax \n\t"
+	     "mov %%eax, %[dr2] \n\t"
+	     "mov %%dr3, %%eax \n\t"
+	     "mov %%eax, %[dr3] \n\t"
+	     : [dr0] "=m"(db_regs[0]),
+	       [dr1] "=m"(db_regs[1]),
+	       [dr2] "=m"(db_regs[2]),
+	       [dr3] "=m"(db_regs[3])
+	     : : "eax");
+#endif
 }
 
 static void load_db_regs(unsigned long *db_regs)
@@ -1349,7 +1387,11 @@ static void load_db_regs(unsigned long *
 	       [dr1] "r"(db_regs[1]),
 	       [dr2] "r"(db_regs[2]),
 	       [dr3] "r"(db_regs[3])
+#ifdef __x86_64__
 	     : "rax");
+#else
+	     : "eax");
+#endif
 }
 
 static int svm_vcpu_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
@@ -1414,6 +1456,7 @@ again:
 		"mov %c[rbp](%[vcpu]), %%ebp \n\t"
 #endif
 
+#ifdef __x86_64__
 		/* Enter guest mode */
 		"push %%rax \n\t"
 		"mov %c[svm](%[vcpu]), %%rax \n\t"
@@ -1422,6 +1465,16 @@ again:
 		SVM_VMRUN "\n\t"
 		SVM_VMSAVE "\n\t"
 		"pop %%rax \n\t"
+#else
+		/* Enter guest mode */
+		"push %%eax \n\t"
+		"mov %c[svm](%[vcpu]), %%eax \n\t"
+		"mov %c[vmcb](%%eax), %%eax \n\t"
+		SVM_VMLOAD "\n\t"
+		SVM_VMRUN "\n\t"
+		SVM_VMSAVE "\n\t"
+		"pop %%eax \n\t"
+#endif
 
 		/* Save guest registers, load host registers */
 #ifdef __x86_64__
@@ -1445,12 +1498,12 @@ again:
 		"pop  %%rbp; pop  %%rdi; pop  %%rsi;"
 		"pop  %%rdx; pop  %%rcx; pop  %%rbx; \n\t"
 #else
-		"mov %%ebx, %c[rbx](%3) \n\t"
-		"mov %%ecx, %c[rcx](%3) \n\t"
-		"mov %%edx, %c[rdx](%3) \n\t"
-		"mov %%esi, %c[rsi](%3) \n\t"
-		"mov %%edi, %c[rdi](%3) \n\t"
-		"mov %%ebp, %c[rbp](%3) \n\t"
+		"mov %%ebx, %c[rbx](%[vcpu]) \n\t"
+		"mov %%ecx, %c[rcx](%[vcpu]) \n\t"
+		"mov %%edx, %c[rdx](%[vcpu]) \n\t"
+		"mov %%esi, %c[rsi](%[vcpu]) \n\t"
+		"mov %%edi, %c[rdi](%[vcpu]) \n\t"
+		"mov %%ebp, %c[rbp](%[vcpu]) \n\t"
 
 		"pop  %%ebp; pop  %%edi; pop  %%esi;"
 		"pop  %%edx; pop  %%ecx; pop  %%ebx; \n\t"
Index: linux-2.6/drivers/kvm/Kconfig
===================================================================
--- linux-2.6.orig/drivers/kvm/Kconfig
+++ linux-2.6/drivers/kvm/Kconfig
@@ -27,7 +27,7 @@ config KVM_INTEL
 
 config KVM_AMD
 	tristate "KVM for AMD processors support"
-	depends on KVM && X86_64
+	depends on KVM
 	---help---
 	  Provides support for KVM on AMD processors equipped with the AMD-V
 	  (SVM) extensions.
