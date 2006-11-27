Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758136AbWK0Mfk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758136AbWK0Mfk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 07:35:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758139AbWK0Mfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 07:35:40 -0500
Received: from il.qumranet.com ([62.219.232.206]:33731 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1758136AbWK0Mfj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 07:35:39 -0500
Subject: [PATCH 25/38] KVM: Move the vmx tsc accessors to vmx.c
From: Avi Kivity <avi@qumranet.com>
Date: Mon, 27 Nov 2006 12:35:38 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <456AD5C6.1090406@qumranet.com>
In-Reply-To: <456AD5C6.1090406@qumranet.com>
Message-Id: <20061127123538.5DD9825015E@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -490,33 +490,6 @@ static void inject_gp(struct kvm_vcpu *v
 	kvm_arch_ops->inject_gp(vcpu, 0);
 }
 
-/*
- * reads and returns guest's timestamp counter "register"
- * guest_tsc = host_tsc + tsc_offset    -- 21.3
- */
-u64 guest_read_tsc(void)
-{
-	u64 host_tsc, tsc_offset;
-
-	rdtscll(host_tsc);
-	tsc_offset = vmcs_read64(TSC_OFFSET);
-	return host_tsc + tsc_offset;
-}
-EXPORT_SYMBOL_GPL(guest_read_tsc);
-
-/*
- * writes 'guest_tsc' into guest's timestamp counter "register"
- * guest_tsc = host_tsc + tsc_offset ==> tsc_offset = guest_tsc - host_tsc
- */
-void guest_write_tsc(u64 guest_tsc)
-{
-	u64 host_tsc;
-
-	rdtscll(host_tsc);
-	vmcs_write64(TSC_OFFSET, guest_tsc - host_tsc);
-}
-EXPORT_SYMBOL_GPL(guest_write_tsc);
-
 static int pdptrs_have_reserved_bits_set(struct kvm_vcpu *vcpu,
 					 unsigned long cr3)
 {
Index: linux-2.6/drivers/kvm/vmx.c
===================================================================
--- linux-2.6.orig/drivers/kvm/vmx.c
+++ linux-2.6/drivers/kvm/vmx.c
@@ -57,8 +57,6 @@ static const u32 vmx_msr_index[] = {
 };
 #define NR_VMX_MSR (sizeof(vmx_msr_index) / sizeof(*vmx_msr_index))
 
-u64 guest_read_tsc(void);
-void guest_write_tsc(u64 guest_tsc);
 struct vmx_msr_entry *find_msr_entry(struct kvm_vcpu *vcpu, u32 msr);
 
 static void skip_emulated_instruction(struct kvm_vcpu *vcpu)
@@ -92,6 +90,31 @@ static void vmx_inject_gp(struct kvm_vcp
 		     INTR_INFO_VALID_MASK);
 }
 
+/*
+ * reads and returns guest's timestamp counter "register"
+ * guest_tsc = host_tsc + tsc_offset    -- 21.3
+ */
+static u64 guest_read_tsc(void)
+{
+	u64 host_tsc, tsc_offset;
+
+	rdtscll(host_tsc);
+	tsc_offset = vmcs_read64(TSC_OFFSET);
+	return host_tsc + tsc_offset;
+}
+
+/*
+ * writes 'guest_tsc' into guest's timestamp counter "register"
+ * guest_tsc = host_tsc + tsc_offset ==> tsc_offset = guest_tsc - host_tsc
+ */
+static void guest_write_tsc(u64 guest_tsc)
+{
+	u64 host_tsc;
+
+	rdtscll(host_tsc);
+	vmcs_write64(TSC_OFFSET, guest_tsc - host_tsc);
+}
+
 static void reload_tss(void)
 {
 #ifndef __x86_64__
