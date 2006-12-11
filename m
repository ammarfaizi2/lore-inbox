Return-Path: <linux-kernel-owner+w=401wt.eu-S1762738AbWLKKQP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762738AbWLKKQP (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 05:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762740AbWLKKQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 05:16:15 -0500
Received: from il.qumranet.com ([62.219.232.206]:45721 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762738AbWLKKQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 05:16:15 -0500
Subject: [PATCH 2/5] KVM: Move find_vmx_entry() to vmx.c
From: Avi Kivity <avi@qumranet.com>
Date: Mon, 11 Dec 2006 10:16:13 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <457D2F6B.8070809@qumranet.com>
In-Reply-To: <457D2F6B.8070809@qumranet.com>
Message-Id: <20061211101613.CD1C92500CF@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -72,17 +72,6 @@ static struct dentry *debugfs_dir;
 #define CR8_RESEVED_BITS (~0x0fULL)
 #define EFER_RESERVED_BITS 0xfffffffffffff2fe
 
-struct vmx_msr_entry *find_msr_entry(struct kvm_vcpu *vcpu, u32 msr)
-{
-	int i;
-
-	for (i = 0; i < vcpu->nmsrs; ++i)
-		if (vcpu->guest_msrs[i].index == msr)
-			return &vcpu->guest_msrs[i];
-	return 0;
-}
-EXPORT_SYMBOL_GPL(find_msr_entry);
-
 #ifdef CONFIG_X86_64
 // LDT or TSS descriptor in the GDT. 16 bytes.
 struct segment_descriptor_64 {
@@ -1124,8 +1113,6 @@ static int get_msr(struct kvm_vcpu *vcpu
 
 void set_efer(struct kvm_vcpu *vcpu, u64 efer)
 {
-	struct vmx_msr_entry *msr;
-
 	if (efer & EFER_RESERVED_BITS) {
 		printk(KERN_DEBUG "set_efer: 0x%llx #GP, reserved bits\n",
 		       efer);
@@ -1140,16 +1127,12 @@ void set_efer(struct kvm_vcpu *vcpu, u64
 		return;
 	}
 
+	kvm_arch_ops->set_efer(vcpu, efer);
+
 	efer &= ~EFER_LMA;
 	efer |= vcpu->shadow_efer & EFER_LMA;
 
 	vcpu->shadow_efer = efer;
-
-	msr = find_msr_entry(vcpu, MSR_EFER);
-
-	if (!(efer & EFER_LMA))
-	    efer &= ~EFER_LME;
-	msr->data = efer;
 }
 EXPORT_SYMBOL_GPL(set_efer);
 
Index: linux-2.6/drivers/kvm/vmx.c
===================================================================
--- linux-2.6.orig/drivers/kvm/vmx.c
+++ linux-2.6/drivers/kvm/vmx.c
@@ -78,8 +78,6 @@ static const u32 vmx_msr_index[] = {
 };
 #define NR_VMX_MSR (sizeof(vmx_msr_index) / sizeof(*vmx_msr_index))
 
-struct vmx_msr_entry *find_msr_entry(struct kvm_vcpu *vcpu, u32 msr);
-
 static inline int is_page_fault(u32 intr_info)
 {
 	return (intr_info & (INTR_INFO_INTR_TYPE_MASK | INTR_INFO_VECTOR_MASK |
@@ -93,6 +91,16 @@ static inline int is_external_interrupt(
 		== (INTR_TYPE_EXT_INTR | INTR_INFO_VALID_MASK);
 }
 
+static struct vmx_msr_entry *find_msr_entry(struct kvm_vcpu *vcpu, u32 msr)
+{
+	int i;
+
+	for (i = 0; i < vcpu->nmsrs; ++i)
+		if (vcpu->guest_msrs[i].index == msr)
+			return &vcpu->guest_msrs[i];
+	return 0;
+}
+
 static void vmcs_clear(struct vmcs *vmcs)
 {
 	u64 phys_addr = __pa(vmcs);
