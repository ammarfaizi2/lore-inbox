Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758107AbWK0MXk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758107AbWK0MXk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 07:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758108AbWK0MXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 07:23:40 -0500
Received: from il.qumranet.com ([62.219.232.206]:5298 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1758107AbWK0MXj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 07:23:39 -0500
Subject: [PATCH 13/38] KVM: Make syncing the register file to the vcpu
	structure an arch operation
From: Avi Kivity <avi@qumranet.com>
Date: Mon, 27 Nov 2006 12:23:37 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <456AD5C6.1090406@qumranet.com>
In-Reply-To: <456AD5C6.1090406@qumranet.com>
Message-Id: <20061127122337.9C25125015E@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This copies any general purpose guest registers maintained by the hardware
to the vcpu structure (and back).

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm.h
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm.h
+++ linux-2.6/drivers/kvm/kvm.h
@@ -262,6 +262,8 @@ struct kvm_arch_ops {
 	void (*set_idt)(struct kvm_vcpu *vcpu, struct descriptor_table *dt);
 	void (*get_gdt)(struct kvm_vcpu *vcpu, struct descriptor_table *dt);
 	void (*set_gdt)(struct kvm_vcpu *vcpu, struct descriptor_table *dt);
+	void (*cache_regs)(struct kvm_vcpu *vcpu);
+	void (*decache_regs)(struct kvm_vcpu *vcpu);
 };
 
 extern struct kvm_stat kvm_stat;
Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -1327,26 +1327,6 @@ out:
 }
 
 /*
- * Sync the rsp and rip registers into the vcpu structure.  This allows
- * registers to be accessed by indexing vcpu->regs.
- */
-static void vcpu_load_rsp_rip(struct kvm_vcpu *vcpu)
-{
-	vcpu->regs[VCPU_REGS_RSP] = vmcs_readl(GUEST_RSP);
-	vcpu->rip = vmcs_readl(GUEST_RIP);
-}
-
-/*
- * Syncs rsp and rip back into the vmcs.  Should be called after possible
- * modification.
- */
-static void vcpu_put_rsp_rip(struct kvm_vcpu *vcpu)
-{
-	vmcs_writel(GUEST_RSP, vcpu->regs[VCPU_REGS_RSP]);
-	vmcs_writel(GUEST_RIP, vcpu->rip);
-}
-
-/*
  * Creates some virtual cpus.  Good luck creating more than one.
  */
 static int kvm_dev_ioctl_create_vcpu(struct kvm *kvm, int n)
@@ -1819,7 +1799,7 @@ static int emulate_instruction(struct kv
 	int r;
 	u32 cs_ar;
 
-	vcpu_load_rsp_rip(vcpu);
+	kvm_arch_ops->cache_regs(vcpu);
 
 	cs_ar = vmcs_read32(GUEST_CS_AR_BYTES);
 
@@ -1864,7 +1844,7 @@ static int emulate_instruction(struct kv
 		return EMULATE_DO_MMIO;
 	}
 
-	vcpu_put_rsp_rip(vcpu);
+	kvm_arch_ops->decache_regs(vcpu);
 	vmcs_writel(GUEST_RFLAGS, emulate_ctxt.eflags);
 
 	if (vcpu->mmio_is_write)
@@ -2134,22 +2114,22 @@ static int handle_cr(struct kvm_vcpu *vc
 	case 0: /* mov to cr */
 		switch (cr) {
 		case 0:
-			vcpu_load_rsp_rip(vcpu);
+			kvm_arch_ops->cache_regs(vcpu);
 			set_cr0(vcpu, vcpu->regs[reg]);
 			skip_emulated_instruction(vcpu);
 			return 1;
 		case 3:
-			vcpu_load_rsp_rip(vcpu);
+			kvm_arch_ops->cache_regs(vcpu);
 			set_cr3(vcpu, vcpu->regs[reg]);
 			skip_emulated_instruction(vcpu);
 			return 1;
 		case 4:
-			vcpu_load_rsp_rip(vcpu);
+			kvm_arch_ops->cache_regs(vcpu);
 			set_cr4(vcpu, vcpu->regs[reg]);
 			skip_emulated_instruction(vcpu);
 			return 1;
 		case 8:
-			vcpu_load_rsp_rip(vcpu);
+			kvm_arch_ops->cache_regs(vcpu);
 			set_cr8(vcpu, vcpu->regs[reg]);
 			skip_emulated_instruction(vcpu);
 			return 1;
@@ -2158,17 +2138,17 @@ static int handle_cr(struct kvm_vcpu *vc
 	case 1: /*mov from cr*/
 		switch (cr) {
 		case 3:
-			vcpu_load_rsp_rip(vcpu);
+			kvm_arch_ops->cache_regs(vcpu);
 			vcpu->regs[reg] = vcpu->cr3;
-			vcpu_put_rsp_rip(vcpu);
+			kvm_arch_ops->decache_regs(vcpu);
 			skip_emulated_instruction(vcpu);
 			return 1;
 		case 8:
 			printk(KERN_DEBUG "handle_cr: read CR8 "
 			       "cpu erratum AA15\n");
-			vcpu_load_rsp_rip(vcpu);
+			kvm_arch_ops->cache_regs(vcpu);
 			vcpu->regs[reg] = vcpu->cr8;
-			vcpu_put_rsp_rip(vcpu);
+			kvm_arch_ops->decache_regs(vcpu);
 			skip_emulated_instruction(vcpu);
 			return 1;
 		}
@@ -2200,7 +2180,7 @@ static int handle_dr(struct kvm_vcpu *vc
 	exit_qualification = vmcs_read64(EXIT_QUALIFICATION);
 	dr = exit_qualification & 7;
 	reg = (exit_qualification >> 8) & 15;
-	vcpu_load_rsp_rip(vcpu);
+	kvm_arch_ops->cache_regs(vcpu);
 	if (exit_qualification & 16) {
 		/* mov from dr */
 		switch (dr) {
@@ -2217,7 +2197,7 @@ static int handle_dr(struct kvm_vcpu *vc
 	} else {
 		/* mov to dr */
 	}
-	vcpu_put_rsp_rip(vcpu);
+	kvm_arch_ops->decache_regs(vcpu);
 	skip_emulated_instruction(vcpu);
 	return 1;
 }
Index: linux-2.6/drivers/kvm/vmx.c
===================================================================
--- linux-2.6.orig/drivers/kvm/vmx.c
+++ linux-2.6/drivers/kvm/vmx.c
@@ -180,6 +180,26 @@ static int vmx_set_msr(struct kvm_vcpu *
 	return 0;
 }
 
+/*
+ * Sync the rsp and rip registers into the vcpu structure.  This allows
+ * registers to be accessed by indexing vcpu->regs.
+ */
+static void vcpu_load_rsp_rip(struct kvm_vcpu *vcpu)
+{
+	vcpu->regs[VCPU_REGS_RSP] = vmcs_readl(GUEST_RSP);
+	vcpu->rip = vmcs_readl(GUEST_RIP);
+}
+
+/*
+ * Syncs rsp and rip back into the vmcs.  Should be called after possible
+ * modification.
+ */
+static void vcpu_put_rsp_rip(struct kvm_vcpu *vcpu)
+{
+	vmcs_writel(GUEST_RSP, vcpu->regs[VCPU_REGS_RSP]);
+	vmcs_writel(GUEST_RIP, vcpu->rip);
+}
+
 static int set_guest_debug(struct kvm_vcpu *vcpu, struct kvm_debug_guest *dbg)
 {
 	unsigned long dr7 = 0x400;
@@ -405,6 +425,8 @@ static struct kvm_arch_ops vmx_arch_ops 
 	.set_idt = vmx_set_idt,
 	.get_gdt = vmx_get_gdt,
 	.set_gdt = vmx_set_gdt,
+	.cache_regs = vcpu_load_rsp_rip,
+	.decache_regs = vcpu_put_rsp_rip,
 };
 
 static int __init vmx_init(void)
