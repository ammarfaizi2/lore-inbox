Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758130AbWK0Mgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758130AbWK0Mgl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 07:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758137AbWK0Mgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 07:36:41 -0500
Received: from il.qumranet.com ([62.219.232.206]:42408 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1758130AbWK0Mgk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 07:36:40 -0500
Subject: [PATCH 26/38] KVM: Access rflags through an arch operation
From: Avi Kivity <avi@qumranet.com>
Date: Mon, 27 Nov 2006 12:36:38 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <456AD5C6.1090406@qumranet.com>
In-Reply-To: <456AD5C6.1090406@qumranet.com>
Message-Id: <20061127123638.69BBA25015E@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm.h
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm.h
+++ linux-2.6/drivers/kvm/kvm.h
@@ -279,6 +279,8 @@ struct kvm_arch_ops {
 	void (*set_gdt)(struct kvm_vcpu *vcpu, struct descriptor_table *dt);
 	void (*cache_regs)(struct kvm_vcpu *vcpu);
 	void (*decache_regs)(struct kvm_vcpu *vcpu);
+	unsigned long (*get_rflags)(struct kvm_vcpu *vcpu);
+	void (*set_rflags)(struct kvm_vcpu *vcpu, unsigned long rflags);
 
 	void (*flush_tlb)(struct kvm_vcpu *vcpu);
 	void (*inject_page_fault)(struct kvm_vcpu *vcpu,
Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -1141,7 +1141,7 @@ int emulate_instruction(struct kvm_vcpu 
 	cs_ar = vmcs_read32(GUEST_CS_AR_BYTES);
 
 	emulate_ctxt.vcpu = vcpu;
-	emulate_ctxt.eflags = vmcs_readl(GUEST_RFLAGS);
+	emulate_ctxt.eflags = kvm_arch_ops->get_rflags(vcpu);
 	emulate_ctxt.cr2 = cr2;
 	emulate_ctxt.mode = (emulate_ctxt.eflags & X86_EFLAGS_VM)
 		? X86EMUL_MODE_REAL : (cs_ar & AR_L_MASK)
@@ -1182,7 +1182,7 @@ int emulate_instruction(struct kvm_vcpu 
 	}
 
 	kvm_arch_ops->decache_regs(vcpu);
-	vmcs_writel(GUEST_RFLAGS, emulate_ctxt.eflags);
+	kvm_arch_ops->set_rflags(vcpu, emulate_ctxt.eflags);
 
 	if (vcpu->mmio_is_write)
 		return EMULATE_DO_MMIO;
@@ -1214,7 +1214,7 @@ void realmode_lmsw(struct kvm_vcpu *vcpu
 		   unsigned long *rflags)
 {
 	lmsw(vcpu, msw);
-	*rflags = vmcs_readl(GUEST_RFLAGS);
+	*rflags = kvm_arch_ops->get_rflags(vcpu);
 }
 
 unsigned long realmode_get_cr(struct kvm_vcpu *vcpu, int cr)
@@ -1240,7 +1240,7 @@ void realmode_set_cr(struct kvm_vcpu *vc
 	switch (cr) {
 	case 0:
 		set_cr0(vcpu, mk_cr_64(vcpu->cr0, val));
-		*rflags = vmcs_readl(GUEST_RFLAGS);
+		*rflags = kvm_arch_ops->get_rflags(vcpu);
 		break;
 	case 2:
 		vcpu->cr2 = val;
@@ -1401,7 +1401,7 @@ static int kvm_dev_ioctl_get_regs(struct
 #endif
 
 	regs->rip = vcpu->rip;
-	regs->rflags = vmcs_readl(GUEST_RFLAGS);
+	regs->rflags = kvm_arch_ops->get_rflags(vcpu);
 
 	/*
 	 * Don't leak debug flags in case they were set for guest debugging
@@ -1445,7 +1445,7 @@ static int kvm_dev_ioctl_set_regs(struct
 #endif
 
 	vcpu->rip = regs->rip;
-	vmcs_writel(GUEST_RFLAGS, regs->rflags);
+	kvm_arch_ops->set_rflags(vcpu, regs->rflags);
 
 	kvm_arch_ops->decache_regs(vcpu);
 
Index: linux-2.6/drivers/kvm/vmx.c
===================================================================
--- linux-2.6.orig/drivers/kvm/vmx.c
+++ linux-2.6/drivers/kvm/vmx.c
@@ -59,6 +59,16 @@ static const u32 vmx_msr_index[] = {
 
 struct vmx_msr_entry *find_msr_entry(struct kvm_vcpu *vcpu, u32 msr);
 
+static unsigned long vmx_get_rflags(struct kvm_vcpu *vcpu)
+{
+	return vmcs_readl(GUEST_RFLAGS);
+}
+
+static void vmx_set_rflags(struct kvm_vcpu *vcpu, unsigned long rflags)
+{
+	vmcs_writel(GUEST_RFLAGS, rflags);
+}
+
 static void skip_emulated_instruction(struct kvm_vcpu *vcpu)
 {
 	unsigned long rip;
@@ -1713,6 +1723,8 @@ static struct kvm_arch_ops vmx_arch_ops 
 	.set_gdt = vmx_set_gdt,
 	.cache_regs = vcpu_load_rsp_rip,
 	.decache_regs = vcpu_put_rsp_rip,
+	.get_rflags = vmx_get_rflags,
+	.set_rflags = vmx_set_rflags,
 
 	.flush_tlb = vmx_flush_tlb,
 	.inject_page_fault = vmx_inject_page_fault,
