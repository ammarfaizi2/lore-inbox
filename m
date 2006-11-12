Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932901AbWKLNw3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932901AbWKLNw3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 08:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932904AbWKLNw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 08:52:29 -0500
Received: from il.qumranet.com ([62.219.232.206]:47790 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S932901AbWKLNw3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 08:52:29 -0500
Subject: [PATCH] KVM: Fix asm constraints
From: Avi Kivity <avi@qumranet.com>
Date: Sun, 12 Nov 2006 13:52:27 -0000
To: kvm-devel@lists.sourceforge.net
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Message-Id: <20061112135227.3D800A0001@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The change to directly encoded vmx opcodes (rather than asm instructions)
forced us to pass the address of phys_addr as an operand, rather than its
contents.  However, nothing forces gcc to commit the contents of the
variable to memory, so add an explicit "m" constraint.

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -371,7 +371,8 @@ static void vmcs_clear(struct vmcs *vmcs
 	u8 error;
 
 	asm volatile (ASM_VMX_VMCLEAR_RAX "; setna %0"
-		       : "=g"(error) : "a"(&phys_addr) : "cc", "memory" );
+		      : "=g"(error) : "a"(&phys_addr), "m"(phys_addr)
+		      : "cc", "memory");
 	if (error)
 		printk(KERN_ERR "kvm: vmclear fail: %p/%llx\n",
 		       vmcs, phys_addr);
@@ -414,7 +415,8 @@ static struct kvm_vcpu *__vcpu_load(stru
 
 		per_cpu(current_vmcs, cpu) = vcpu->vmcs;
 		asm volatile (ASM_VMX_VMPTRLD_RAX "; setna %0"
-			       : "=g"(error) : "a"(&phys_addr) : "cc" );
+			      : "=g"(error) : "a"(&phys_addr), "m"(phys_addr)
+			      : "cc");
 		if (error)
 			printk(KERN_ERR "kvm: vmptrld %p/%llx fail\n",
 			       vcpu->vmcs, phys_addr);
@@ -537,7 +539,8 @@ static __init void kvm_enable(void *garb
 		/* enable and lock */
 		wrmsrl(MSR_IA32_FEATURE_CONTROL, old | 5);
 	write_cr4(read_cr4() | CR4_VMXE); /* FIXME: not cpu hotplug safe */
-	asm volatile (ASM_VMX_VMXON_RAX : : "a"(&phys_addr) : "memory", "cc");
+	asm volatile (ASM_VMX_VMXON_RAX : : "a"(&phys_addr), "m"(phys_addr)
+		      : "memory", "cc");
 }
 
 static void kvm_disable(void *garbage)
