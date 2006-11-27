Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758102AbWK0MVj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758102AbWK0MVj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 07:21:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758105AbWK0MVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 07:21:39 -0500
Received: from il.qumranet.com ([62.219.232.206]:3250 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1758102AbWK0MVj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 07:21:39 -0500
Subject: [PATCH 11/38] KVM: Add get_segment_base() arch accessor
From: Avi Kivity <avi@qumranet.com>
Date: Mon, 27 Nov 2006 12:21:37 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <456AD5C6.1090406@qumranet.com>
In-Reply-To: <456AD5C6.1090406@qumranet.com>
Message-Id: <20061127122137.8446825015E@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This could have been implemented in terms of the existing get_segment(), but
that make unnecessary vmx accesses.

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm.h
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm.h
+++ linux-2.6/drivers/kvm/kvm.h
@@ -248,6 +248,7 @@ struct kvm_arch_ops {
 			       struct kvm_debug_guest *dbg);
 	int (*get_msr)(struct kvm_vcpu *vcpu, u32 msr_index, u64 *pdata);
 	int (*set_msr)(struct kvm_vcpu *vcpu, u32 msr_index, u64 data);
+	u64 (*get_segment_base)(struct kvm_vcpu *vcpu, int seg);
 	void (*get_segment)(struct kvm_vcpu *vcpu,
 			    struct kvm_segment *var, int seg);
 	void (*set_segment)(struct kvm_vcpu *vcpu,
Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -1776,12 +1776,19 @@ static int emulator_cmpxchg_emulated(uns
 	return emulator_write_emulated(addr, new, bytes, ctxt);
 }
 
+static unsigned long get_segment_base(struct kvm_vcpu *vcpu, int seg)
+{
+	return kvm_arch_ops->get_segment_base(vcpu, seg);
+}
+
 static void report_emulation_failure(struct x86_emulate_ctxt *ctxt)
 {
 	static int reported;
 	u8 opcodes[4];
 	unsigned long rip = vmcs_readl(GUEST_RIP);
-	unsigned long rip_linear = rip + vmcs_readl(GUEST_CS_BASE);
+	unsigned long rip_linear;
+
+	rip_linear = rip + get_segment_base(ctxt->vcpu, VCPU_SREG_CS);
 
 	if (reported)
 		return;
@@ -1835,14 +1842,14 @@ static int emulate_instruction(struct kv
 		emulate_ctxt.es_base = 0;
 		emulate_ctxt.ss_base = 0;
 	} else {
-		emulate_ctxt.cs_base = vmcs_readl(GUEST_CS_BASE);
-		emulate_ctxt.ds_base = vmcs_readl(GUEST_DS_BASE);
-		emulate_ctxt.es_base = vmcs_readl(GUEST_ES_BASE);
-		emulate_ctxt.ss_base = vmcs_readl(GUEST_SS_BASE);
+		emulate_ctxt.cs_base = get_segment_base(vcpu, VCPU_SREG_CS);
+		emulate_ctxt.ds_base = get_segment_base(vcpu, VCPU_SREG_DS);
+		emulate_ctxt.es_base = get_segment_base(vcpu, VCPU_SREG_ES);
+		emulate_ctxt.ss_base = get_segment_base(vcpu, VCPU_SREG_SS);
 	}
 
-	emulate_ctxt.gs_base = vmcs_readl(GUEST_GS_BASE);
-	emulate_ctxt.fs_base = vmcs_readl(GUEST_FS_BASE);
+	emulate_ctxt.gs_base = get_segment_base(vcpu, VCPU_SREG_GS);
+	emulate_ctxt.fs_base = get_segment_base(vcpu, VCPU_SREG_FS);
 
 	vcpu->mmio_is_write = 0;
 	r = x86_emulate_memop(&emulate_ctxt, &emulate_ops);
Index: linux-2.6/drivers/kvm/vmx.c
===================================================================
--- linux-2.6.orig/drivers/kvm/vmx.c
+++ linux-2.6/drivers/kvm/vmx.c
@@ -309,6 +309,13 @@ static __exit void hardware_unsetup(void
 	free_kvm_area();
 }
 
+static u64 vmx_get_segment_base(struct kvm_vcpu *vcpu, int seg)
+{
+	struct kvm_vmx_segment_field *sf = &kvm_vmx_segment_fields[seg];
+
+	return vmcs_readl(sf->base);
+}
+
 static void vmx_get_segment(struct kvm_vcpu *vcpu,
 			    struct kvm_segment *var, int seg)
 {
@@ -367,6 +374,7 @@ static struct kvm_arch_ops vmx_arch_ops 
 	.set_guest_debug = set_guest_debug,
 	.get_msr = vmx_get_msr,
 	.set_msr = vmx_set_msr,
+	.get_segment_base = vmx_get_segment_base,
 	.get_segment = vmx_get_segment,
 	.set_segment = vmx_set_segment,
 };
