Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758087AbWK0MSk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758087AbWK0MSk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 07:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758095AbWK0MSk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 07:18:40 -0500
Received: from il.qumranet.com ([62.219.232.206]:33717 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1758087AbWK0MSj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 07:18:39 -0500
Subject: [PATCH 8/38] KVM: Make the segment accessors arch operations
From: Avi Kivity <avi@qumranet.com>
Date: Mon, 27 Nov 2006 12:18:37 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <456AD5C6.1090406@qumranet.com>
In-Reply-To: <456AD5C6.1090406@qumranet.com>
Message-Id: <20061127121837.527A725015E@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm.h
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm.h
+++ linux-2.6/drivers/kvm/kvm.h
@@ -247,6 +247,10 @@ struct kvm_arch_ops {
 			       struct kvm_debug_guest *dbg);
 	int (*get_msr)(struct kvm_vcpu *vcpu, u32 msr_index, u64 *pdata);
 	int (*set_msr)(struct kvm_vcpu *vcpu, u32 msr_index, u64 data);
+	void (*get_segment)(struct kvm_vcpu *vcpu,
+			    struct kvm_segment *var, int seg);
+	void (*set_segment)(struct kvm_vcpu *vcpu,
+			    struct kvm_segment *var, int seg);
 };
 
 extern struct kvm_stat kvm_stat;
Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -36,6 +36,7 @@
 #include <asm/desc.h>
 
 #include "vmx.h"
+#include "kvm_vmx.h"
 #include "x86_emulate.h"
 
 MODULE_AUTHOR("Qumranet");
@@ -82,7 +83,7 @@ enum {
 		GUEST_##seg##_AR_BYTES,			   	\
 	}
 
-static struct kvm_vmx_segment_field {
+struct kvm_vmx_segment_field {
 	unsigned selector;
 	unsigned base;
 	unsigned limit;
@@ -97,6 +98,7 @@ static struct kvm_vmx_segment_field {
 	VMX_SEGMENT_FIELD(TR),
 	VMX_SEGMENT_FIELD(LDTR),
 };
+EXPORT_SYMBOL_GPL(kvm_vmx_segment_fields);
 
 static const u32 vmx_msr_index[] = {
 #ifdef __x86_64__
@@ -625,22 +627,6 @@ void vmcs_writel(unsigned long field, un
 }
 EXPORT_SYMBOL_GPL(vmcs_writel);
 
-static void vmcs_write16(unsigned long field, u16 value)
-{
-	vmcs_writel(field, value);
-}
-
-static void vmcs_write64(unsigned long field, u64 value)
-{
-#ifdef __x86_64__
-	vmcs_writel(field, value);
-#else
-	vmcs_writel(field, value);
-	asm volatile ("");
-	vmcs_writel(field+1, value >> 32);
-#endif
-}
-
 static void inject_gp(struct kvm_vcpu *vcpu)
 {
 	printk(KERN_DEBUG "inject_general_protection: rip 0x%lx\n",
@@ -2821,26 +2807,10 @@ static int kvm_dev_ioctl_set_regs(struct
 	return 0;
 }
 
-static void get_segment(struct kvm_segment *var, int seg)
+static void get_segment(struct kvm_vcpu *vcpu,
+			struct kvm_segment *var, int seg)
 {
-	struct kvm_vmx_segment_field *sf = &kvm_vmx_segment_fields[seg];
-	u32 ar;
-
-	var->base = vmcs_readl(sf->base);
-	var->limit = vmcs_read32(sf->limit);
-	var->selector = vmcs_read16(sf->selector);
-	ar = vmcs_read32(sf->ar_bytes);
-	if (ar & AR_UNUSABLE_MASK)
-		ar = 0;
-	var->type = ar & 15;
-	var->s = (ar >> 4) & 1;
-	var->dpl = (ar >> 5) & 3;
-	var->present = (ar >> 7) & 1;
-	var->avl = (ar >> 12) & 1;
-	var->l = (ar >> 13) & 1;
-	var->db = (ar >> 14) & 1;
-	var->g = (ar >> 15) & 1;
-	var->unusable = (ar >> 16) & 1;
+	return kvm_arch_ops->get_segment(vcpu, var, seg);
 }
 
 static int kvm_dev_ioctl_get_sregs(struct kvm *kvm, struct kvm_sregs *sregs)
@@ -2853,15 +2823,15 @@ static int kvm_dev_ioctl_get_sregs(struc
 	if (!vcpu)
 		return -ENOENT;
 
-	get_segment(&sregs->cs, VCPU_SREG_CS);
-	get_segment(&sregs->ds, VCPU_SREG_DS);
-	get_segment(&sregs->es, VCPU_SREG_ES);
-	get_segment(&sregs->fs, VCPU_SREG_FS);
-	get_segment(&sregs->gs, VCPU_SREG_GS);
-	get_segment(&sregs->ss, VCPU_SREG_SS);
+	get_segment(vcpu, &sregs->cs, VCPU_SREG_CS);
+	get_segment(vcpu, &sregs->ds, VCPU_SREG_DS);
+	get_segment(vcpu, &sregs->es, VCPU_SREG_ES);
+	get_segment(vcpu, &sregs->fs, VCPU_SREG_FS);
+	get_segment(vcpu, &sregs->gs, VCPU_SREG_GS);
+	get_segment(vcpu, &sregs->ss, VCPU_SREG_SS);
 
-	get_segment(&sregs->tr, VCPU_SREG_TR);
-	get_segment(&sregs->ldt, VCPU_SREG_LDTR);
+	get_segment(vcpu, &sregs->tr, VCPU_SREG_TR);
+	get_segment(vcpu, &sregs->ldt, VCPU_SREG_LDTR);
 
 #define get_dtable(var, table) \
 	sregs->var.limit = vmcs_read32(GUEST_##table##_LIMIT), \
@@ -2887,27 +2857,10 @@ static int kvm_dev_ioctl_get_sregs(struc
 	return 0;
 }
 
-static void set_segment(struct kvm_segment *var, int seg)
+static void set_segment(struct kvm_vcpu *vcpu,
+			struct kvm_segment *var, int seg)
 {
-	struct kvm_vmx_segment_field *sf = &kvm_vmx_segment_fields[seg];
-	u32 ar;
-
-	vmcs_writel(sf->base, var->base);
-	vmcs_write32(sf->limit, var->limit);
-	vmcs_write16(sf->selector, var->selector);
-	if (var->unusable)
-		ar = 1 << 16;
-	else {
-		ar = var->type & 15;
-		ar |= (var->s & 1) << 4;
-		ar |= (var->dpl & 3) << 5;
-		ar |= (var->present & 1) << 7;
-		ar |= (var->avl & 1) << 12;
-		ar |= (var->l & 1) << 13;
-		ar |= (var->db & 1) << 14;
-		ar |= (var->g & 1) << 15;
-	}
-	vmcs_write32(sf->ar_bytes, ar);
+	return kvm_arch_ops->set_segment(vcpu, var, seg);
 }
 
 static int kvm_dev_ioctl_set_sregs(struct kvm *kvm, struct kvm_sregs *sregs)
@@ -2922,15 +2875,15 @@ static int kvm_dev_ioctl_set_sregs(struc
 	if (!vcpu)
 		return -ENOENT;
 
-	set_segment(&sregs->cs, VCPU_SREG_CS);
-	set_segment(&sregs->ds, VCPU_SREG_DS);
-	set_segment(&sregs->es, VCPU_SREG_ES);
-	set_segment(&sregs->fs, VCPU_SREG_FS);
-	set_segment(&sregs->gs, VCPU_SREG_GS);
-	set_segment(&sregs->ss, VCPU_SREG_SS);
+	set_segment(vcpu, &sregs->cs, VCPU_SREG_CS);
+	set_segment(vcpu, &sregs->ds, VCPU_SREG_DS);
+	set_segment(vcpu, &sregs->es, VCPU_SREG_ES);
+	set_segment(vcpu, &sregs->fs, VCPU_SREG_FS);
+	set_segment(vcpu, &sregs->gs, VCPU_SREG_GS);
+	set_segment(vcpu, &sregs->ss, VCPU_SREG_SS);
 
-	set_segment(&sregs->tr, VCPU_SREG_TR);
-	set_segment(&sregs->ldt, VCPU_SREG_LDTR);
+	set_segment(vcpu, &sregs->tr, VCPU_SREG_TR);
+	set_segment(vcpu, &sregs->ldt, VCPU_SREG_LDTR);
 
 #define set_dtable(var, table) \
 	vmcs_write32(GUEST_##table##_LIMIT, sregs->var.limit), \
Index: linux-2.6/drivers/kvm/vmx.c
===================================================================
--- linux-2.6.orig/drivers/kvm/vmx.c
+++ linux-2.6/drivers/kvm/vmx.c
@@ -17,6 +17,8 @@
 
 #include "kvm.h"
 #include <linux/module.h>
+#include "vmx.h"
+#include "kvm_vmx.h"
 
 #define MSR_IA32_FEATURE_CONTROL 		0x03a
 
@@ -31,6 +33,13 @@ extern struct vmcs_descriptor {
 	u32 revision_id;
 } vmcs_descriptor;
 
+extern struct kvm_vmx_segment_field {
+	unsigned selector;
+	unsigned base;
+	unsigned limit;
+	unsigned ar_bytes;
+} kvm_vmx_segment_fields[];
+
 u64 guest_read_tsc(void);
 void guest_write_tsc(u64 guest_tsc);
 struct vmx_msr_entry *find_msr_entry(struct kvm_vcpu *vcpu, u32 msr);
@@ -300,6 +309,53 @@ static __exit void hardware_unsetup(void
 	free_kvm_area();
 }
 
+static void vmx_get_segment(struct kvm_vcpu *vcpu,
+			    struct kvm_segment *var, int seg)
+{
+	struct kvm_vmx_segment_field *sf = &kvm_vmx_segment_fields[seg];
+	u32 ar;
+
+	var->base = vmcs_readl(sf->base);
+	var->limit = vmcs_read32(sf->limit);
+	var->selector = vmcs_read16(sf->selector);
+	ar = vmcs_read32(sf->ar_bytes);
+	if (ar & AR_UNUSABLE_MASK)
+		ar = 0;
+	var->type = ar & 15;
+	var->s = (ar >> 4) & 1;
+	var->dpl = (ar >> 5) & 3;
+	var->present = (ar >> 7) & 1;
+	var->avl = (ar >> 12) & 1;
+	var->l = (ar >> 13) & 1;
+	var->db = (ar >> 14) & 1;
+	var->g = (ar >> 15) & 1;
+	var->unusable = (ar >> 16) & 1;
+}
+
+static void vmx_set_segment(struct kvm_vcpu *vcpu,
+			    struct kvm_segment *var, int seg)
+{
+	struct kvm_vmx_segment_field *sf = &kvm_vmx_segment_fields[seg];
+	u32 ar;
+
+	vmcs_writel(sf->base, var->base);
+	vmcs_write32(sf->limit, var->limit);
+	vmcs_write16(sf->selector, var->selector);
+	if (var->unusable)
+		ar = 1 << 16;
+	else {
+		ar = var->type & 15;
+		ar |= (var->s & 1) << 4;
+		ar |= (var->dpl & 3) << 5;
+		ar |= (var->present & 1) << 7;
+		ar |= (var->avl & 1) << 12;
+		ar |= (var->l & 1) << 13;
+		ar |= (var->db & 1) << 14;
+		ar |= (var->g & 1) << 15;
+	}
+	vmcs_write32(sf->ar_bytes, ar);
+}
+
 static struct kvm_arch_ops vmx_arch_ops = {
 	.cpu_has_kvm_support = cpu_has_kvm_support,
 	.disabled_by_bios = vmx_disabled_by_bios,
@@ -311,6 +367,8 @@ static struct kvm_arch_ops vmx_arch_ops 
 	.set_guest_debug = set_guest_debug,
 	.get_msr = vmx_get_msr,
 	.set_msr = vmx_set_msr,
+	.get_segment = vmx_get_segment,
+	.set_segment = vmx_set_segment,
 };
 
 static int __init vmx_init(void)
