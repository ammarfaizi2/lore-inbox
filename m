Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758118AbWK0M2k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758118AbWK0M2k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 07:28:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758119AbWK0M2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 07:28:40 -0500
Received: from il.qumranet.com ([62.219.232.206]:26505 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1758118AbWK0M2j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 07:28:39 -0500
Subject: [PATCH 18/38] KVM: Make __set_cr4() an arch operation
From: Avi Kivity <avi@qumranet.com>
Date: Mon, 27 Nov 2006 12:28:37 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <456AD5C6.1090406@qumranet.com>
In-Reply-To: <456AD5C6.1090406@qumranet.com>
Message-Id: <20061127122837.EC47A25015E@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm.h
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm.h
+++ linux-2.6/drivers/kvm/kvm.h
@@ -270,6 +270,7 @@ struct kvm_arch_ops {
 	void (*set_segment)(struct kvm_vcpu *vcpu,
 			    struct kvm_segment *var, int seg);
 	void (*set_cr0)(struct kvm_vcpu *vcpu, unsigned long cr0);
+	void (*set_cr4)(struct kvm_vcpu *vcpu, unsigned long cr4);
 	void (*get_idt)(struct kvm_vcpu *vcpu, struct descriptor_table *dt);
 	void (*set_idt)(struct kvm_vcpu *vcpu, struct descriptor_table *dt);
 	void (*get_gdt)(struct kvm_vcpu *vcpu, struct descriptor_table *dt);
@@ -339,7 +340,6 @@ void set_cr8(struct kvm_vcpu *vcpu, unsi
 void lmsw(struct kvm_vcpu *vcpu, unsigned long msw);
 
 void __set_efer(struct kvm_vcpu *vcpu, u64 efer);
-void __set_cr4(struct kvm_vcpu *vcpu, unsigned long cr0);
 
 void inject_gp(struct kvm_vcpu *vcpu);
 
Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -645,15 +645,6 @@ void lmsw(struct kvm_vcpu *vcpu, unsigne
 }
 EXPORT_SYMBOL_GPL(lmsw);
 
-void __set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
-{
-	vmcs_writel(CR4_READ_SHADOW, cr4);
-	vmcs_writel(GUEST_CR4, cr4 | (vcpu->rmode.active ?
-		    KVM_RMODE_VM_CR4_ALWAYS_ON : KVM_PMODE_VM_CR4_ALWAYS_ON));
-	vcpu->cr4 = cr4;
-}
-EXPORT_SYMBOL_GPL(__set_cr4);
-
 void set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
 {
 	if (cr4 & CR4_RESEVED_BITS) {
@@ -680,7 +671,7 @@ void set_cr4(struct kvm_vcpu *vcpu, unsi
 		inject_gp(vcpu);
 		return;
 	}
-	__set_cr4(vcpu, cr4);
+	kvm_arch_ops->set_cr4(vcpu, cr4);
 	spin_lock(&vcpu->kvm->lock);
 	kvm_mmu_reset_context(vcpu);
 	spin_unlock(&vcpu->kvm->lock);
@@ -1624,7 +1615,7 @@ static int kvm_dev_ioctl_set_sregs(struc
 	vcpu->cr0 = sregs->cr0;
 
 	mmu_reset_needed |= vcpu->cr4 != sregs->cr4;
-	__set_cr4(vcpu, sregs->cr4);
+	kvm_arch_ops->set_cr4(vcpu, sregs->cr4);
 
 	if (mmu_reset_needed)
 		kvm_mmu_reset_context(vcpu);
Index: linux-2.6/drivers/kvm/vmx.c
===================================================================
--- linux-2.6.orig/drivers/kvm/vmx.c
+++ linux-2.6/drivers/kvm/vmx.c
@@ -545,6 +545,14 @@ static void vmx_set_cr0(struct kvm_vcpu 
 	vcpu->cr0 = cr0;
 }
 
+static void vmx_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
+{
+	vmcs_writel(CR4_READ_SHADOW, cr4);
+	vmcs_writel(GUEST_CR4, cr4 | (vcpu->rmode.active ?
+		    KVM_RMODE_VM_CR4_ALWAYS_ON : KVM_PMODE_VM_CR4_ALWAYS_ON));
+	vcpu->cr4 = cr4;
+}
+
 static u64 vmx_get_segment_base(struct kvm_vcpu *vcpu, int seg)
 {
 	struct kvm_vmx_segment_field *sf = &kvm_vmx_segment_fields[seg];
@@ -872,7 +880,7 @@ static int vmx_vcpu_setup(struct kvm_vcp
 
 	vcpu->cr0 = 0x60000010;
 	vmx_set_cr0(vcpu, vcpu->cr0); // enter rmode
-	__set_cr4(vcpu, 0);
+	vmx_set_cr4(vcpu, 0);
 #ifdef __x86_64__
 	__set_efer(vcpu, 0);
 #endif
@@ -1597,6 +1605,7 @@ static struct kvm_arch_ops vmx_arch_ops 
 	.get_segment = vmx_get_segment,
 	.set_segment = vmx_set_segment,
 	.set_cr0 = vmx_set_cr0,
+	.set_cr4 = vmx_set_cr4,
 	.get_idt = vmx_get_idt,
 	.set_idt = vmx_set_idt,
 	.get_gdt = vmx_get_gdt,
