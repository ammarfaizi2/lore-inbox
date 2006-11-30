Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759198AbWK3JIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759198AbWK3JIK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 04:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759195AbWK3JIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 04:08:09 -0500
Received: from il.qumranet.com ([62.219.232.206]:60614 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1759198AbWK3JIH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 04:08:07 -0500
Subject: [PATCH] KVM: More i386 fixes
From: Avi Kivity <avi@qumranet.com>
Date: Thu, 30 Nov 2006 09:08:05 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, akpm@osdl.org
Message-Id: <20061130090805.0539F25017B@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

Signed-off-by: Avi Kivity <avi@qumranet.com>

diff -X /home/avi/kvm/linux-2.6/Documentation/dontdiff --exclude=Makefile -ru /home/avi/kvm/linux-2.6/drivers/kvm/kvm.h /home/avi/kvm-release/kernel/kvm.h
--- linux-2.6/drivers/kvm/kvm.h	2006-11-29 17:50:23.000000000 +0200
+++ linux-2.6/drivers/kvm/kvm.h	2006-11-29 17:59:51.000000000 +0200
@@ -299,7 +299,7 @@
 	void (*set_rflags)(struct kvm_vcpu *vcpu, unsigned long rflags);
 
 	void (*invlpg)(struct kvm_vcpu *vcpu, gva_t addr);
-	void (*flush_tlb)(struct kvm_vcpu *vcpu);
+	void (*tlb_flush)(struct kvm_vcpu *vcpu);
 	void (*inject_page_fault)(struct kvm_vcpu *vcpu,
 				  unsigned long addr, u32 err_code);
 
diff -X /home/avi/kvm/linux-2.6/Documentation/dontdiff --exclude=Makefile -ru /home/avi/kvm/linux-2.6/drivers/kvm/kvm_main.c /home/avi/kvm-release/kernel/kvm_main.c
--- linux-2.6/drivers/kvm/kvm_main.c	2006-11-29 17:52:17.000000000 +0200
+++ linux-2.6/drivers/kvm/kvm_main.c	2006-11-29 17:59:51.000000000 +0200
@@ -725,7 +725,7 @@
 
 			if (!vcpu)
 				continue;
-			kvm_arch_ops->flush_tlb(vcpu);
+			kvm_arch_ops->tlb_flush(vcpu);
 			vcpu_put(vcpu);
 		}
 	}
diff -X /home/avi/kvm/linux-2.6/Documentation/dontdiff --exclude=Makefile -ru /home/avi/kvm/linux-2.6/drivers/kvm/mmu.c /home/avi/kvm-release/kernel/mmu.c
--- linux-2.6/drivers/kvm/mmu.c	2006-11-29 17:50:22.000000000 +0200
+++ linux-2.6/drivers/kvm/mmu.c	2006-11-29 17:59:51.000000000 +0200
@@ -324,7 +324,7 @@
 	if (is_paging(vcpu))
 		root |= (vcpu->cr3 & (CR3_PCD_MASK | CR3_WPT_MASK));
 	kvm_arch_ops->set_cr3(vcpu, root);
-	kvm_arch_ops->flush_tlb(vcpu);
+	kvm_arch_ops->tlb_flush(vcpu);
 }
 
 static gpa_t nonpaging_gva_to_gpa(struct kvm_vcpu *vcpu, gva_t vaddr)
@@ -408,7 +408,7 @@
 		release_pt_page_64(vcpu, page->page_hpa, 1);
 	}
 	++kvm_stat.tlb_flush;
-	kvm_arch_ops->flush_tlb(vcpu);
+	kvm_arch_ops->tlb_flush(vcpu);
 }
 
 static void paging_new_cr3(struct kvm_vcpu *vcpu)
@@ -516,7 +516,7 @@
 			table[index] = 0;
 			release_pt_page_64(vcpu, page_addr, PT_PAGE_TABLE_LEVEL);
 
-			kvm_arch_ops->flush_tlb(vcpu);
+			kvm_arch_ops->tlb_flush(vcpu);
 			return;
 		}
 	}
diff -X /home/avi/kvm/linux-2.6/Documentation/dontdiff --exclude=Makefile -ru /home/avi/kvm/linux-2.6/drivers/kvm/svm.c /home/avi/kvm-release/kernel/svm.c
--- linux-2.6/drivers/kvm/svm.c	2006-11-29 17:50:23.000000000 +0200
+++ linux-2.6/drivers/kvm/svm.c	2006-11-29 17:59:51.000000000 +0200
@@ -115,7 +115,7 @@
 	asm volatile (SVM_INVLPGA :: "a"(addr), "c"(asid));
 }
 
-static inline unsigned long read_cr2(void)
+static inline unsigned long kvm_read_cr2(void)
 {
 	unsigned long cr2;
 
@@ -123,7 +123,7 @@
 	return cr2;
 }
 
-static inline void write_cr2(unsigned long val)
+static inline void kvm_write_cr2(unsigned long val)
 {
 	asm volatile ("mov %0, %%cr2" :: "r" (val));
 }
@@ -1129,9 +1129,11 @@
 static int svm_set_msr(struct kvm_vcpu *vcpu, unsigned ecx, u64 data)
 {
 	switch (ecx) {
+#ifdef __x86_64__
 	case MSR_EFER:
 		set_efer(vcpu, data);
 		break;
+#endif
 	case MSR_IA32_MC0_STATUS:
 		printk(KERN_WARNING "%s: MSR_IA32_MC0_STATUS 0x%llx, nop\n"
 			    , __FUNCTION__, data);
@@ -1367,7 +1369,7 @@
 	fs_selector = read_fs();
 	gs_selector = read_gs();
 	ldt_selector = read_ldt();
-	vcpu->svm->host_cr2 = read_cr2();
+	vcpu->svm->host_cr2 = kvm_read_cr2();
 	vcpu->svm->host_dr6 = read_dr6();
 	vcpu->svm->host_dr7 = read_dr7();
 	vcpu->svm->vmcb->save.cr2 = vcpu->cr2;
@@ -1384,7 +1386,7 @@
 		"push %%r8;  push %%r9;  push %%r10; push %%r11;"
 		"push %%r12; push %%r13; push %%r14; push %%r15;"
 #else
-		"push %%ebx; push %%rcx push %%edx;"
+		"push %%ebx; push %%ecx; push %%edx;"
 		"push %%esi; push %%edi; push %%ebp;"
 #endif
 
@@ -1462,9 +1464,9 @@
 		  [rdx]"i"(offsetof(struct kvm_vcpu, regs[VCPU_REGS_RDX])),
 		  [rsi]"i"(offsetof(struct kvm_vcpu, regs[VCPU_REGS_RSI])),
 		  [rdi]"i"(offsetof(struct kvm_vcpu, regs[VCPU_REGS_RDI])),
-		  [rbp]"i"(offsetof(struct kvm_vcpu, regs[VCPU_REGS_RBP])),
+		  [rbp]"i"(offsetof(struct kvm_vcpu, regs[VCPU_REGS_RBP]))
 #ifdef __x86_64__
-		  [r8 ]"i"(offsetof(struct kvm_vcpu, regs[VCPU_REGS_R8 ])),
+		  ,[r8 ]"i"(offsetof(struct kvm_vcpu, regs[VCPU_REGS_R8 ])),
 		  [r9 ]"i"(offsetof(struct kvm_vcpu, regs[VCPU_REGS_R9 ])),
 		  [r10]"i"(offsetof(struct kvm_vcpu, regs[VCPU_REGS_R10])),
 		  [r11]"i"(offsetof(struct kvm_vcpu, regs[VCPU_REGS_R11])),
@@ -1482,7 +1484,7 @@
 
 	write_dr6(vcpu->svm->host_dr6);
 	write_dr7(vcpu->svm->host_dr7);
-	write_cr2(vcpu->svm->host_cr2);
+	kvm_write_cr2(vcpu->svm->host_cr2);
 
 	load_fs(fs_selector);
 	load_gs(gs_selector);
@@ -1596,7 +1598,7 @@
 	.set_rflags = svm_set_rflags,
 
 	.invlpg = svm_invlpg,
-	.flush_tlb = svm_flush_tlb,
+	.tlb_flush = svm_flush_tlb,
 	.inject_page_fault = svm_inject_page_fault,
 
 	.inject_gp = svm_inject_gp,
diff -X /home/avi/kvm/linux-2.6/Documentation/dontdiff --exclude=Makefile -ru /home/avi/kvm/linux-2.6/drivers/kvm/vmx.c /home/avi/kvm-release/kernel/vmx.c
--- linux-2.6/drivers/kvm/vmx.c	2006-11-29 17:52:17.000000000 +0200
+++ linux-2.6/drivers/kvm/vmx.c	2006-11-29 17:59:51.000000000 +0200
@@ -1984,7 +1984,7 @@
 	.get_rflags = vmx_get_rflags,
 	.set_rflags = vmx_set_rflags,
 
-	.flush_tlb = vmx_flush_tlb,
+	.tlb_flush = vmx_flush_tlb,
 	.inject_page_fault = vmx_inject_page_fault,
 
 	.inject_gp = vmx_inject_gp,
