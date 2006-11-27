Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758144AbWK0Mik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758144AbWK0Mik (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 07:38:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758146AbWK0Mik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 07:38:40 -0500
Received: from il.qumranet.com ([62.219.232.206]:44456 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1758144AbWK0Mik (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 07:38:40 -0500
Subject: [PATCH 28/38] KVM: Add an arch accessor for cs d/b and l bits
From: Avi Kivity <avi@qumranet.com>
Date: Mon, 27 Nov 2006 12:38:38 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <456AD5C6.1090406@qumranet.com>
In-Reply-To: <456AD5C6.1090406@qumranet.com>
Message-Id: <20061127123838.8050B25015E@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These are used for detecting the current processor mode.

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm.h
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm.h
+++ linux-2.6/drivers/kvm/kvm.h
@@ -269,6 +269,7 @@ struct kvm_arch_ops {
 			    struct kvm_segment *var, int seg);
 	void (*set_segment)(struct kvm_vcpu *vcpu,
 			    struct kvm_segment *var, int seg);
+	void (*get_cs_db_l_bits)(struct kvm_vcpu *vcpu, int *db, int *l);
 	void (*set_cr0)(struct kvm_vcpu *vcpu, unsigned long cr0);
 	void (*set_cr3)(struct kvm_vcpu *vcpu, unsigned long cr3);
 	void (*set_cr4)(struct kvm_vcpu *vcpu, unsigned long cr4);
Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -517,15 +517,16 @@ void set_cr0(struct kvm_vcpu *vcpu, unsi
 	if (!is_paging(vcpu) && (cr0 & CR0_PG_MASK)) {
 #ifdef __x86_64__
 		if ((vcpu->shadow_efer & EFER_LME)) {
-			u32 guest_cs_ar;
+			int cs_db, cs_l;
+
 			if (!is_pae(vcpu)) {
 				printk(KERN_DEBUG "set_cr0: #GP, start paging "
 				       "in long mode while PAE is disabled\n");
 				inject_gp(vcpu);
 				return;
 			}
-			guest_cs_ar = vmcs_read32(GUEST_CS_AR_BYTES);
-			if (guest_cs_ar & SEGMENT_AR_L_MASK) {
+			kvm_arch_ops->get_cs_db_l_bits(vcpu, &cs_db, &cs_l);
+			if (cs_l) {
 				printk(KERN_DEBUG "set_cr0: #GP, start paging "
 				       "in long mode while CS.L == 1\n");
 				inject_gp(vcpu);
@@ -1109,18 +1110,18 @@ int emulate_instruction(struct kvm_vcpu 
 {
 	struct x86_emulate_ctxt emulate_ctxt;
 	int r;
-	u32 cs_ar;
+	int cs_db, cs_l;
 
 	kvm_arch_ops->cache_regs(vcpu);
 
-	cs_ar = vmcs_read32(GUEST_CS_AR_BYTES);
+	kvm_arch_ops->get_cs_db_l_bits(vcpu, &cs_db, &cs_l);
 
 	emulate_ctxt.vcpu = vcpu;
 	emulate_ctxt.eflags = kvm_arch_ops->get_rflags(vcpu);
 	emulate_ctxt.cr2 = cr2;
 	emulate_ctxt.mode = (emulate_ctxt.eflags & X86_EFLAGS_VM)
-		? X86EMUL_MODE_REAL : (cs_ar & AR_L_MASK)
-		? X86EMUL_MODE_PROT64 :	(cs_ar & AR_DB_MASK)
+		? X86EMUL_MODE_REAL : cs_l
+		? X86EMUL_MODE_PROT64 :	cs_db
 		? X86EMUL_MODE_PROT32 : X86EMUL_MODE_PROT16;
 
 	if (emulate_ctxt.mode == X86EMUL_MODE_PROT64) {
Index: linux-2.6/drivers/kvm/vmx.c
===================================================================
--- linux-2.6.orig/drivers/kvm/vmx.c
+++ linux-2.6/drivers/kvm/vmx.c
@@ -698,6 +698,14 @@ static void vmx_set_segment(struct kvm_v
 	vmcs_write32(sf->ar_bytes, ar);
 }
 
+static void vmx_get_cs_db_l_bits(struct kvm_vcpu *vcpu, int *db, int *l)
+{
+	u32 ar = vmcs_read32(GUEST_CS_AR_BYTES);
+
+	*db = (ar >> 14) & 1;
+	*l = (ar >> 13) & 1;
+}
+
 static void vmx_get_idt(struct kvm_vcpu *vcpu, struct descriptor_table *dt)
 {
 	dt->limit = vmcs_read32(GUEST_IDTR_LIMIT);
@@ -1730,6 +1738,7 @@ static struct kvm_arch_ops vmx_arch_ops 
 	.get_segment_base = vmx_get_segment_base,
 	.get_segment = vmx_get_segment,
 	.set_segment = vmx_set_segment,
+	.get_cs_db_l_bits = vmx_get_cs_db_l_bits,
 	.set_cr0 = vmx_set_cr0,
 	.set_cr3 = vmx_set_cr3,
 	.set_cr4 = vmx_set_cr4,
