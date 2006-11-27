Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758105AbWK0MWk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758105AbWK0MWk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 07:22:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758107AbWK0MWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 07:22:40 -0500
Received: from il.qumranet.com ([62.219.232.206]:4274 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1758105AbWK0MWj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 07:22:39 -0500
Subject: [PATCH 12/38] KVM: Add idt and gdt descriptor accessors
From: Avi Kivity <avi@qumranet.com>
Date: Mon, 27 Nov 2006 12:22:37 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <456AD5C6.1090406@qumranet.com>
In-Reply-To: <456AD5C6.1090406@qumranet.com>
Message-Id: <20061127122237.9034625015E@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm.h
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm.h
+++ linux-2.6/drivers/kvm/kvm.h
@@ -236,6 +236,11 @@ struct kvm_stat {
 	u32 irq_exits;
 };
 
+struct descriptor_table {
+	u16 limit;
+	unsigned long base;
+} __attribute__((packed));
+
 struct kvm_arch_ops {
 	int (*cpu_has_kvm_support)(void);          /* __init */
 	int (*disabled_by_bios)(void);             /* __init */
@@ -253,6 +258,10 @@ struct kvm_arch_ops {
 			    struct kvm_segment *var, int seg);
 	void (*set_segment)(struct kvm_vcpu *vcpu,
 			    struct kvm_segment *var, int seg);
+	void (*get_idt)(struct kvm_vcpu *vcpu, struct descriptor_table *dt);
+	void (*set_idt)(struct kvm_vcpu *vcpu, struct descriptor_table *dt);
+	void (*get_gdt)(struct kvm_vcpu *vcpu, struct descriptor_table *dt);
+	void (*set_gdt)(struct kvm_vcpu *vcpu, struct descriptor_table *dt);
 };
 
 extern struct kvm_stat kvm_stat;
Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -155,11 +155,6 @@ struct vmx_msr_entry *find_msr_entry(str
 }
 EXPORT_SYMBOL_GPL(find_msr_entry);
 
-struct descriptor_table {
-	u16 limit;
-	unsigned long base;
-} __attribute__((packed));
-
 static void get_gdt(struct descriptor_table *table)
 {
 	asm ("sgdt %0" : "=m"(*table));
@@ -2827,6 +2822,7 @@ static void get_segment(struct kvm_vcpu 
 static int kvm_dev_ioctl_get_sregs(struct kvm *kvm, struct kvm_sregs *sregs)
 {
 	struct kvm_vcpu *vcpu;
+	struct descriptor_table dt;
 
 	if (sregs->vcpu < 0 || sregs->vcpu >= KVM_MAX_VCPUS)
 		return -EINVAL;
@@ -2844,13 +2840,12 @@ static int kvm_dev_ioctl_get_sregs(struc
 	get_segment(vcpu, &sregs->tr, VCPU_SREG_TR);
 	get_segment(vcpu, &sregs->ldt, VCPU_SREG_LDTR);
 
-#define get_dtable(var, table) \
-	sregs->var.limit = vmcs_read32(GUEST_##table##_LIMIT), \
-		sregs->var.base = vmcs_readl(GUEST_##table##_BASE)
-
-	get_dtable(idt, IDTR);
-	get_dtable(gdt, GDTR);
-#undef get_dtable
+	kvm_arch_ops->get_idt(vcpu, &dt);
+	sregs->idt.limit = dt.limit;
+	sregs->idt.base = dt.base;
+	kvm_arch_ops->get_gdt(vcpu, &dt);
+	sregs->gdt.limit = dt.limit;
+	sregs->gdt.base = dt.base;
 
 	sregs->cr0 = vcpu->cr0;
 	sregs->cr2 = vcpu->cr2;
@@ -2879,6 +2874,7 @@ static int kvm_dev_ioctl_set_sregs(struc
 	struct kvm_vcpu *vcpu;
 	int mmu_reset_needed = 0;
 	int i;
+	struct descriptor_table dt;
 
 	if (sregs->vcpu < 0 || sregs->vcpu >= KVM_MAX_VCPUS)
 		return -EINVAL;
@@ -2896,13 +2892,12 @@ static int kvm_dev_ioctl_set_sregs(struc
 	set_segment(vcpu, &sregs->tr, VCPU_SREG_TR);
 	set_segment(vcpu, &sregs->ldt, VCPU_SREG_LDTR);
 
-#define set_dtable(var, table) \
-	vmcs_write32(GUEST_##table##_LIMIT, sregs->var.limit), \
-	vmcs_writel(GUEST_##table##_BASE, sregs->var.base)
-
-	set_dtable(idt, IDTR);
-	set_dtable(gdt, GDTR);
-#undef set_dtable
+	dt.limit = sregs->idt.limit;
+	dt.base = sregs->idt.base;
+	kvm_arch_ops->set_idt(vcpu, &dt);
+	dt.limit = sregs->gdt.limit;
+	dt.base = sregs->gdt.base;
+	kvm_arch_ops->set_gdt(vcpu, &dt);
 
 	vcpu->cr2 = sregs->cr2;
 	mmu_reset_needed |= vcpu->cr3 != sregs->cr3;
Index: linux-2.6/drivers/kvm/vmx.c
===================================================================
--- linux-2.6.orig/drivers/kvm/vmx.c
+++ linux-2.6/drivers/kvm/vmx.c
@@ -363,6 +363,30 @@ static void vmx_set_segment(struct kvm_v
 	vmcs_write32(sf->ar_bytes, ar);
 }
 
+static void vmx_get_idt(struct kvm_vcpu *vcpu, struct descriptor_table *dt)
+{
+	dt->limit = vmcs_read32(GUEST_IDTR_LIMIT);
+	dt->base = vmcs_readl(GUEST_IDTR_BASE);
+}
+
+static void vmx_set_idt(struct kvm_vcpu *vcpu, struct descriptor_table *dt)
+{
+	vmcs_write32(GUEST_IDTR_LIMIT, dt->limit);
+	vmcs_writel(GUEST_IDTR_BASE, dt->base);
+}
+
+static void vmx_get_gdt(struct kvm_vcpu *vcpu, struct descriptor_table *dt)
+{
+	dt->limit = vmcs_read32(GUEST_GDTR_LIMIT);
+	dt->base = vmcs_readl(GUEST_GDTR_BASE);
+}
+
+static void vmx_set_gdt(struct kvm_vcpu *vcpu, struct descriptor_table *dt)
+{
+	vmcs_write32(GUEST_GDTR_LIMIT, dt->limit);
+	vmcs_writel(GUEST_GDTR_BASE, dt->base);
+}
+
 static struct kvm_arch_ops vmx_arch_ops = {
 	.cpu_has_kvm_support = cpu_has_kvm_support,
 	.disabled_by_bios = vmx_disabled_by_bios,
@@ -377,6 +401,10 @@ static struct kvm_arch_ops vmx_arch_ops 
 	.get_segment_base = vmx_get_segment_base,
 	.get_segment = vmx_get_segment,
 	.set_segment = vmx_set_segment,
+	.get_idt = vmx_get_idt,
+	.set_idt = vmx_set_idt,
+	.get_gdt = vmx_get_gdt,
+	.set_gdt = vmx_set_gdt,
 };
 
 static int __init vmx_init(void)
