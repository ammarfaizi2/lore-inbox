Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758146AbWK0Mjk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758146AbWK0Mjk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 07:39:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758147AbWK0Mjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 07:39:40 -0500
Received: from il.qumranet.com ([62.219.232.206]:45480 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1758146AbWK0Mjj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 07:39:39 -0500
Subject: [PATCH 29/38] KVM: Add a set_cr0_no_modeswitch() arch accessor
From: Avi Kivity <avi@qumranet.com>
Date: Mon, 27 Nov 2006 12:39:38 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <456AD5C6.1090406@qumranet.com>
In-Reply-To: <456AD5C6.1090406@qumranet.com>
Message-Id: <20061127123938.A0A5925015E@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A side effect of using vm86 mode to simulate real mode is that we mangle
the segment registers on mode switching.  The new set_cr0_no_modeswitch()
accessor avoids the mangling when the restore is due to loading the virtual
machine from a file.

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm.h
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm.h
+++ linux-2.6/drivers/kvm/kvm.h
@@ -271,6 +271,8 @@ struct kvm_arch_ops {
 			    struct kvm_segment *var, int seg);
 	void (*get_cs_db_l_bits)(struct kvm_vcpu *vcpu, int *db, int *l);
 	void (*set_cr0)(struct kvm_vcpu *vcpu, unsigned long cr0);
+	void (*set_cr0_no_modeswitch)(struct kvm_vcpu *vcpu,
+				      unsigned long cr0);
 	void (*set_cr3)(struct kvm_vcpu *vcpu, unsigned long cr3);
 	void (*set_cr4)(struct kvm_vcpu *vcpu, unsigned long cr4);
 	void (*set_efer)(struct kvm_vcpu *vcpu, u64 efer);
@@ -292,8 +294,6 @@ struct kvm_arch_ops {
 	int (*run)(struct kvm_vcpu *vcpu, struct kvm_run *run);
 	int (*vcpu_setup)(struct kvm_vcpu *vcpu);
 	void (*skip_emulated_instruction)(struct kvm_vcpu *vcpu);
-
-	void (*update_exception_bitmap)(struct kvm_vcpu *vcpu); /* hack */
 };
 
 extern struct kvm_stat kvm_stat;
Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -1529,12 +1529,7 @@ static int kvm_dev_ioctl_set_sregs(struc
 	vcpu->apic_base = sregs->apic_base;
 
 	mmu_reset_needed |= vcpu->cr0 != sregs->cr0;
-	vcpu->rmode.active = ((sregs->cr0 & CR0_PE_MASK) == 0);
-	kvm_arch_ops->update_exception_bitmap(vcpu);
-	vmcs_writel(CR0_READ_SHADOW, sregs->cr0);
-	vmcs_writel(GUEST_CR0,
-		    (sregs->cr0 & ~KVM_GUEST_CR0_MASK) | KVM_VM_CR0_ALWAYS_ON);
-	vcpu->cr0 = sregs->cr0;
+	kvm_arch_ops->set_cr0_no_modeswitch(vcpu, sregs->cr0);
 
 	mmu_reset_needed |= vcpu->cr4 != sregs->cr4;
 	kvm_arch_ops->set_cr4(vcpu, sregs->cr4);
Index: linux-2.6/drivers/kvm/vmx.c
===================================================================
--- linux-2.6.orig/drivers/kvm/vmx.c
+++ linux-2.6/drivers/kvm/vmx.c
@@ -607,6 +607,19 @@ static void vmx_set_cr0(struct kvm_vcpu 
 	vcpu->cr0 = cr0;
 }
 
+/*
+ * Used when restoring the VM to avoid corrupting segment registers
+ */
+static void vmx_set_cr0_no_modeswitch(struct kvm_vcpu *vcpu, unsigned long cr0)
+{
+	vcpu->rmode.active = ((cr0 & CR0_PE_MASK) == 0);
+	update_exception_bitmap(vcpu);
+	vmcs_writel(CR0_READ_SHADOW, cr0);
+	vmcs_writel(GUEST_CR0,
+		    (cr0 & ~KVM_GUEST_CR0_MASK) | KVM_VM_CR0_ALWAYS_ON);
+	vcpu->cr0 = cr0;
+}
+
 static void vmx_set_cr3(struct kvm_vcpu *vcpu, unsigned long cr3)
 {
 	vmcs_writel(GUEST_CR3, cr3);
@@ -1740,6 +1753,7 @@ static struct kvm_arch_ops vmx_arch_ops 
 	.set_segment = vmx_set_segment,
 	.get_cs_db_l_bits = vmx_get_cs_db_l_bits,
 	.set_cr0 = vmx_set_cr0,
+	.set_cr0_no_modeswitch = vmx_set_cr0_no_modeswitch,
 	.set_cr3 = vmx_set_cr3,
 	.set_cr4 = vmx_set_cr4,
 	.set_efer = vmx_set_efer,
@@ -1760,8 +1774,6 @@ static struct kvm_arch_ops vmx_arch_ops 
 	.run = vmx_vcpu_run,
 	.skip_emulated_instruction = skip_emulated_instruction,
 	.vcpu_setup = vmx_vcpu_setup,
-
-	.update_exception_bitmap = update_exception_bitmap,
 };
 
 static int __init vmx_init(void)
