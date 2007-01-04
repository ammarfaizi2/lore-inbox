Return-Path: <linux-kernel-owner+w=401wt.eu-S964918AbXADPey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964918AbXADPey (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 10:34:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964925AbXADPex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 10:34:53 -0500
Received: from il.qumranet.com ([62.219.232.206]:45000 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964918AbXADPew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 10:34:52 -0500
Subject: [PATCH] KVM: Prevent stale bits in cr0 and cr4
From: Avi Kivity <avi@qumranet.com>
Date: Thu, 04 Jan 2007 15:34:49 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
Message-Id: <20070104153449.0C8C5250048@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hardware virtualization implementations allow the guests to freely change
some of the bits in cr0 and cr4, but trap when changing the other bits.  This
is useful to avoid excessive exits due to changing, for example, the ts flag.

It also means the kvm's copy of cr0 and cr4 may be stale with respect to these
bits.  most of the time this doesn't matter as these bits are not very
interesting.  Other times, however (for example when returning cr0 to
userspace), they are, so get the fresh contents of these bits from the guest
by means of a new arch operation.

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -390,6 +390,7 @@ EXPORT_SYMBOL_GPL(set_cr0);
 
 void lmsw(struct kvm_vcpu *vcpu, unsigned long msw)
 {
+	kvm_arch_ops->decache_cr0_cr4_guest_bits(vcpu);
 	set_cr0(vcpu, (vcpu->cr0 & ~0x0ful) | (msw & 0x0f));
 }
 EXPORT_SYMBOL_GPL(lmsw);
@@ -917,9 +918,10 @@ int emulate_invlpg(struct kvm_vcpu *vcpu
 
 int emulate_clts(struct kvm_vcpu *vcpu)
 {
-	unsigned long cr0 = vcpu->cr0;
+	unsigned long cr0;
 
-	cr0 &= ~CR0_TS_MASK;
+	kvm_arch_ops->decache_cr0_cr4_guest_bits(vcpu);
+	cr0 = vcpu->cr0 & ~CR0_TS_MASK;
 	kvm_arch_ops->set_cr0(vcpu, cr0);
 	return X86EMUL_CONTINUE;
 }
@@ -1072,6 +1074,7 @@ void realmode_lmsw(struct kvm_vcpu *vcpu
 
 unsigned long realmode_get_cr(struct kvm_vcpu *vcpu, int cr)
 {
+	kvm_arch_ops->decache_cr0_cr4_guest_bits(vcpu);
 	switch (cr) {
 	case 0:
 		return vcpu->cr0;
@@ -1406,6 +1409,7 @@ static int kvm_dev_ioctl_get_sregs(struc
 	sregs->gdt.limit = dt.limit;
 	sregs->gdt.base = dt.base;
 
+	kvm_arch_ops->decache_cr0_cr4_guest_bits(vcpu);
 	sregs->cr0 = vcpu->cr0;
 	sregs->cr2 = vcpu->cr2;
 	sregs->cr3 = vcpu->cr3;
@@ -1470,6 +1474,8 @@ static int kvm_dev_ioctl_set_sregs(struc
 #endif
 	vcpu->apic_base = sregs->apic_base;
 
+	kvm_arch_ops->decache_cr0_cr4_guest_bits(vcpu);
+
 	mmu_reset_needed |= vcpu->cr0 != sregs->cr0;
 	kvm_arch_ops->set_cr0_no_modeswitch(vcpu, sregs->cr0);
 
Index: linux-2.6/drivers/kvm/kvm.h
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm.h
+++ linux-2.6/drivers/kvm/kvm.h
@@ -283,6 +283,7 @@ struct kvm_arch_ops {
 	void (*set_segment)(struct kvm_vcpu *vcpu,
 			    struct kvm_segment *var, int seg);
 	void (*get_cs_db_l_bits)(struct kvm_vcpu *vcpu, int *db, int *l);
+	void (*decache_cr0_cr4_guest_bits)(struct kvm_vcpu *vcpu);
 	void (*set_cr0)(struct kvm_vcpu *vcpu, unsigned long cr0);
 	void (*set_cr0_no_modeswitch)(struct kvm_vcpu *vcpu,
 				      unsigned long cr0);
Index: linux-2.6/drivers/kvm/svm.c
===================================================================
--- linux-2.6.orig/drivers/kvm/svm.c
+++ linux-2.6/drivers/kvm/svm.c
@@ -702,6 +702,10 @@ static void svm_set_gdt(struct kvm_vcpu 
 	vcpu->svm->vmcb->save.gdtr.base = dt->base ;
 }
 
+static void svm_decache_cr0_cr4_guest_bits(struct kvm_vcpu *vcpu)
+{
+}
+
 static void svm_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
 {
 #ifdef CONFIG_X86_64
@@ -1645,6 +1649,7 @@ static struct kvm_arch_ops svm_arch_ops 
 	.get_segment = svm_get_segment,
 	.set_segment = svm_set_segment,
 	.get_cs_db_l_bits = svm_get_cs_db_l_bits,
+	.decache_cr0_cr4_guest_bits = svm_decache_cr0_cr4_guest_bits,
 	.set_cr0 = svm_set_cr0,
 	.set_cr0_no_modeswitch = svm_set_cr0,
 	.set_cr3 = svm_set_cr3,
Index: linux-2.6/drivers/kvm/vmx.c
===================================================================
--- linux-2.6.orig/drivers/kvm/vmx.c
+++ linux-2.6/drivers/kvm/vmx.c
@@ -737,6 +737,15 @@ static void exit_lmode(struct kvm_vcpu *
 
 #endif
 
+static void vmx_decache_cr0_cr4_guest_bits(struct kvm_vcpu *vcpu)
+{
+	vcpu->cr0 &= KVM_GUEST_CR0_MASK;
+	vcpu->cr0 |= vmcs_readl(GUEST_CR0) & ~KVM_GUEST_CR0_MASK;
+
+	vcpu->cr4 &= KVM_GUEST_CR4_MASK;
+	vcpu->cr4 |= vmcs_readl(GUEST_CR4) & ~KVM_GUEST_CR4_MASK;
+}
+
 static void vmx_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
 {
 	if (vcpu->rmode.active && (cr0 & CR0_PE_MASK))
@@ -2002,6 +2011,7 @@ static struct kvm_arch_ops vmx_arch_ops 
 	.get_segment = vmx_get_segment,
 	.set_segment = vmx_set_segment,
 	.get_cs_db_l_bits = vmx_get_cs_db_l_bits,
+	.decache_cr0_cr4_guest_bits = vmx_decache_cr0_cr4_guest_bits,
 	.set_cr0 = vmx_set_cr0,
 	.set_cr0_no_modeswitch = vmx_set_cr0_no_modeswitch,
 	.set_cr3 = vmx_set_cr3,
