Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759720AbWLDIxa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759720AbWLDIxa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 03:53:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759735AbWLDIxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 03:53:30 -0500
Received: from il.qumranet.com ([62.219.232.206]:38596 "EHLO il.qumranet.com")
	by vger.kernel.org with ESMTP id S1759696AbWLDIx3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 03:53:29 -0500
Message-ID: <4573E206.6090809@qumranet.com>
Date: Mon, 04 Dec 2006 10:53:26 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Matt Reuther <mreuther@umich.edu>
CC: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Compile Error - 2.6.19-rc6-mm2
References: <200612031617.27731.mreuther@umich.edu>
In-Reply-To: <200612031617.27731.mreuther@umich.edu>
Content-Type: multipart/mixed;
 boundary="------------010902070707020103050501"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010902070707020103050501
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Matt Reuther wrote:
> I tried compiling 2.6.19-rc6-mm2 and got an error:
>
>   CC [M]  drivers/input/serio/parkbd.o
>   CC [M]  drivers/input/serio/serport.o
>   CC [M]  drivers/input/serio/serio_raw.o
>   LD      drivers/kvm/built-in.o
>   CC [M]  drivers/kvm/vmx.o
>   CC [M]  drivers/kvm/kvm_main.o
> drivers/kvm/kvm_main.c:739:32: macro "flush_tlb" passed 1 arguments, but takes 
> just 0
> drivers/kvm/kvm_main.c: In function `kvm_dev_ioctl_get_dirty_log':
> drivers/kvm/kvm_main.c:739: warning: statement with no effect
> make[2]: *** [drivers/kvm/kvm_main.o] Error 1
> make[1]: *** [drivers/kvm] Error 2
> make: *** [drivers] Error 2
>   

You will need the attached i386 compile fixes, and in the event you want 
to run it, the further attached segment reload fix (kvm bug exposed by 
pda patches).


-- 
error compiling committee.c: too many arguments to function


--------------010902070707020103050501
Content-Type: text/x-patch;
 name="kvm-i386-ingo-fixes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kvm-i386-ingo-fixes.patch"

KVM: More i386 fixes

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

--------------010902070707020103050501
Content-Type: text/x-patch;
 name="kvm-load-i386-segment-bases.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kvm-load-i386-segment-bases.patch"

Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -90,6 +90,9 @@ unsigned long segment_base(u16 selector)
 	typedef unsigned long ul;
 	unsigned long v;
 
+	if (selector == 0)
+		return 0;
+
 	asm ("sgdt %0" : "=m"(gdt));
 	table_base = gdt.base;
 
Index: linux-2.6/drivers/kvm/vmx.c
===================================================================
--- linux-2.6.orig/drivers/kvm/vmx.c
+++ linux-2.6/drivers/kvm/vmx.c
@@ -1702,6 +1702,9 @@ again:
 #ifdef __x86_64__
 	vmcs_writel(HOST_FS_BASE, read_msr(MSR_FS_BASE));
 	vmcs_writel(HOST_GS_BASE, read_msr(MSR_GS_BASE));
+#else
+	vmcs_writel(HOST_FS_BASE, segment_base(fs_sel));
+	vmcs_writel(HOST_GS_BASE, segment_base(gs_sel));
 #endif
 
 	if (vcpu->irq_summary &&

--------------010902070707020103050501--
