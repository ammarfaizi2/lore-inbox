Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932747AbWKILI4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932747AbWKILI4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 06:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932769AbWKILI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 06:08:56 -0500
Received: from il.qumranet.com ([62.219.232.206]:48303 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S932747AbWKILIz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 06:08:55 -0500
Subject: [PATCH] KVM: Avoid using vmx instruction directly
From: Avi Kivity <avi@qumranet.com>
Date: Thu, 09 Nov 2006 11:08:52 -0000
To: kvm-devel@lists.sourceforge.net
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Message-Id: <20061109110852.A6B712500F7@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some users have an older assembler installed which doesn't grok the
vmx instructions.

Fix by encoding the instruction opcodes directly.

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm.h
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm.h
+++ linux-2.6/drivers/kvm/kvm.h
@@ -377,6 +377,16 @@ static inline struct kvm_mmu_page *page_
 	return (struct kvm_mmu_page *)page->private;
 }
 
+#define ASM_VMX_VMCLEAR_RAX       ".byte 0x66, 0x0f, 0xc7, 0x30"
+#define ASM_VMX_VMLAUNCH          ".byte 0x0f, 0x01, 0xc2"
+#define ASM_VMX_VMRESUME          ".byte 0x0f, 0x01, 0xc3"
+#define ASM_VMX_VMPTRLD_RAX       ".byte 0x0f, 0xc7, 0x30"
+#define ASM_VMX_VMREAD_RDX_RAX    ".byte 0x0f, 0x78, 0xd0"
+#define ASM_VMX_VMWRITE_RAX_RDX   ".byte 0x0f, 0x79, 0xd0"
+#define ASM_VMX_VMWRITE_RSP_RDX   ".byte 0x0f, 0x79, 0xd4"
+#define ASM_VMX_VMXOFF            ".byte 0x0f, 0x01, 0xc4"
+#define ASM_VMX_VMXON_RAX         ".byte 0xf3, 0x0f, 0xc7, 0x30"
+
 #ifdef __x86_64__
 
 /*
Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -369,8 +369,8 @@ static void vmcs_clear(struct vmcs *vmcs
 	u64 phys_addr = __pa(vmcs);
 	u8 error;
 
-	asm volatile ("vmclear %1; setna %0"
-		       : "=m"(error) : "m"(phys_addr) : "cc", "memory" );
+	asm volatile (ASM_VMX_VMCLEAR_RAX "; setna %0"
+		       : "=g"(error) : "a"(&phys_addr) : "cc", "memory" );
 	if (error)
 		printk(KERN_ERR "kvm: vmclear fail: %p/%llx\n",
 		       vmcs, phys_addr);
@@ -412,8 +412,8 @@ static struct kvm_vcpu *__vcpu_load(stru
 		u8 error;
 
 		per_cpu(current_vmcs, cpu) = vcpu->vmcs;
-		asm volatile ("vmptrld %1; setna %0"
-			       : "=m"(error) : "m"(phys_addr) : "cc" );
+		asm volatile (ASM_VMX_VMPTRLD_RAX "; setna %0"
+			       : "=g"(error) : "a"(&phys_addr) : "cc" );
 		if (error)
 			printk(KERN_ERR "kvm: vmptrld %p/%llx fail\n",
 			       vcpu->vmcs, phys_addr);
@@ -536,12 +536,12 @@ static __init void kvm_enable(void *garb
 		/* enable and lock */
 		wrmsrl(MSR_IA32_FEATURE_CONTROL, old | 5);
 	write_cr4(read_cr4() | CR4_VMXE); /* FIXME: not cpu hotplug safe */
-	asm volatile ("vmxon %0" : : "m"(phys_addr) : "memory", "cc");
+	asm volatile (ASM_VMX_VMXON_RAX : : "a"(&phys_addr) : "memory", "cc");
 }
 
 static void kvm_disable(void *garbage)
 {
-	asm volatile ("vmxoff" : : : "cc");
+	asm volatile (ASM_VMX_VMXOFF : : : "cc");
 }
 
 static int kvm_dev_open(struct inode *inode, struct file *filp)
@@ -633,7 +633,8 @@ unsigned long vmcs_readl(unsigned long f
 {
 	unsigned long value;
 
-	asm volatile ("vmread %1, %0" : "=g"(value) : "r"(field) : "cc");
+	asm volatile (ASM_VMX_VMREAD_RDX_RAX
+		      : "=a"(value) : "d"(field) : "cc");
 	return value;
 }
 
@@ -641,8 +642,8 @@ void vmcs_writel(unsigned long field, un
 {
 	u8 error;
 
-	asm volatile ("vmwrite %1, %2; setna %0"
-		       : "=g"(error) : "r"(value), "r"(field) : "cc" );
+	asm volatile (ASM_VMX_VMWRITE_RAX_RDX "; setna %0"
+		       : "=q"(error) : "a"(value), "d"(field) : "cc" );
 	if (error)
 		printk(KERN_ERR "vmwrite error: reg %lx value %lx (err %d)\n",
 		       field, value, vmcs_read32(VM_INSTRUCTION_ERROR));
@@ -2634,10 +2635,10 @@ again:
 		"push %%r8;  push %%r9;  push %%r10; push %%r11;"
 		"push %%r12; push %%r13; push %%r14; push %%r15;"
 		"push %%rcx \n\t"
-		"vmwrite %%rsp, %2 \n\t"
+		ASM_VMX_VMWRITE_RSP_RDX "\n\t"
 #else
 		"pusha; push %%ecx \n\t"
-		"vmwrite %%esp, %2 \n\t"
+		ASM_VMX_VMWRITE_RSP_RDX "\n\t"
 #endif
 		/* Check if vmlaunch of vmresume is needed */
 		"cmp $0, %1 \n\t"
@@ -2673,9 +2674,9 @@ again:
 #endif
 		/* Enter guest mode */
 		"jne launched \n\t"
-		"vmlaunch \n\t"
+		ASM_VMX_VMLAUNCH "\n\t"
 		"jmp kvm_vmx_return \n\t"
-		"launched: vmresume \n\t"
+		"launched: " ASM_VMX_VMRESUME "\n\t"
 		".globl kvm_vmx_return \n\t"
 		"kvm_vmx_return: "
 		/* Save guest registers, load host registers, keep flags */
@@ -2722,7 +2723,7 @@ again:
 		"setbe %0 \n\t"
 		"popf \n\t"
 	      : "=g" (fail)
-	      : "r"(vcpu->launched), "r"((unsigned long)HOST_RSP),
+	      : "r"(vcpu->launched), "d"((unsigned long)HOST_RSP),
 		"c"(vcpu),
 		[rax]"i"(offsetof(struct kvm_vcpu, regs[VCPU_REGS_RAX])),
 		[rbx]"i"(offsetof(struct kvm_vcpu, regs[VCPU_REGS_RBX])),
