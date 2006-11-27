Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758122AbWK0M3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758122AbWK0M3k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 07:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758120AbWK0M3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 07:29:40 -0500
Received: from il.qumranet.com ([62.219.232.206]:27529 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1758122AbWK0M3j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 07:29:39 -0500
Subject: [PATCH 19/38] KVM: Make __set_efer() an arch operation
From: Avi Kivity <avi@qumranet.com>
Date: Mon, 27 Nov 2006 12:29:38 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <456AD5C6.1090406@qumranet.com>
In-Reply-To: <456AD5C6.1090406@qumranet.com>
Message-Id: <20061127122938.0518325015E@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm.h
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm.h
+++ linux-2.6/drivers/kvm/kvm.h
@@ -271,6 +271,7 @@ struct kvm_arch_ops {
 			    struct kvm_segment *var, int seg);
 	void (*set_cr0)(struct kvm_vcpu *vcpu, unsigned long cr0);
 	void (*set_cr4)(struct kvm_vcpu *vcpu, unsigned long cr4);
+	void (*set_efer)(struct kvm_vcpu *vcpu, u64 efer);
 	void (*get_idt)(struct kvm_vcpu *vcpu, struct descriptor_table *dt);
 	void (*set_idt)(struct kvm_vcpu *vcpu, struct descriptor_table *dt);
 	void (*get_gdt)(struct kvm_vcpu *vcpu, struct descriptor_table *dt);
@@ -339,8 +340,6 @@ void set_cr4(struct kvm_vcpu *vcpu, unsi
 void set_cr8(struct kvm_vcpu *vcpu, unsigned long cr0);
 void lmsw(struct kvm_vcpu *vcpu, unsigned long msw);
 
-void __set_efer(struct kvm_vcpu *vcpu, u64 efer);
-
 void inject_gp(struct kvm_vcpu *vcpu);
 
 #ifdef __x86_64__
Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -525,31 +525,6 @@ void guest_write_tsc(u64 guest_tsc)
 }
 EXPORT_SYMBOL_GPL(guest_write_tsc);
 
-#ifdef __x86_64__
-
-void __set_efer(struct kvm_vcpu *vcpu, u64 efer)
-{
-	struct vmx_msr_entry *msr = find_msr_entry(vcpu, MSR_EFER);
-
-	vcpu->shadow_efer = efer;
-	if (efer & EFER_LMA) {
-		vmcs_write32(VM_ENTRY_CONTROLS,
-				     vmcs_read32(VM_ENTRY_CONTROLS) |
-				     VM_ENTRY_CONTROLS_IA32E_MASK);
-		msr->data = efer;
-
-	} else {
-		vmcs_write32(VM_ENTRY_CONTROLS,
-				     vmcs_read32(VM_ENTRY_CONTROLS) &
-				     ~VM_ENTRY_CONTROLS_IA32E_MASK);
-
-		msr->data = efer & ~EFER_LME;
-	}
-}
-EXPORT_SYMBOL_GPL(__set_efer);
-
-#endif
-
 static int pdptrs_have_reserved_bits_set(struct kvm_vcpu *vcpu,
 					 unsigned long cr3)
 {
@@ -1602,7 +1577,7 @@ static int kvm_dev_ioctl_set_sregs(struc
 
 	mmu_reset_needed |= vcpu->shadow_efer != sregs->efer;
 #ifdef __x86_64__
-	__set_efer(vcpu, sregs->efer);
+	kvm_arch_ops->set_efer(vcpu, sregs->efer);
 #endif
 	vcpu->apic_base = sregs->apic_base;
 
Index: linux-2.6/drivers/kvm/vmx.c
===================================================================
--- linux-2.6.orig/drivers/kvm/vmx.c
+++ linux-2.6/drivers/kvm/vmx.c
@@ -553,6 +553,30 @@ static void vmx_set_cr4(struct kvm_vcpu 
 	vcpu->cr4 = cr4;
 }
 
+#ifdef __x86_64__
+
+static void vmx_set_efer(struct kvm_vcpu *vcpu, u64 efer)
+{
+	struct vmx_msr_entry *msr = find_msr_entry(vcpu, MSR_EFER);
+
+	vcpu->shadow_efer = efer;
+	if (efer & EFER_LMA) {
+		vmcs_write32(VM_ENTRY_CONTROLS,
+				     vmcs_read32(VM_ENTRY_CONTROLS) |
+				     VM_ENTRY_CONTROLS_IA32E_MASK);
+		msr->data = efer;
+
+	} else {
+		vmcs_write32(VM_ENTRY_CONTROLS,
+				     vmcs_read32(VM_ENTRY_CONTROLS) &
+				     ~VM_ENTRY_CONTROLS_IA32E_MASK);
+
+		msr->data = efer & ~EFER_LME;
+	}
+}
+
+#endif
+
 static u64 vmx_get_segment_base(struct kvm_vcpu *vcpu, int seg)
 {
 	struct kvm_vmx_segment_field *sf = &kvm_vmx_segment_fields[seg];
@@ -882,7 +906,7 @@ static int vmx_vcpu_setup(struct kvm_vcp
 	vmx_set_cr0(vcpu, vcpu->cr0); // enter rmode
 	vmx_set_cr4(vcpu, 0);
 #ifdef __x86_64__
-	__set_efer(vcpu, 0);
+	vmx_set_efer(vcpu, 0);
 #endif
 
 	return 0;
@@ -1606,6 +1630,7 @@ static struct kvm_arch_ops vmx_arch_ops 
 	.set_segment = vmx_set_segment,
 	.set_cr0 = vmx_set_cr0,
 	.set_cr4 = vmx_set_cr4,
+	.set_efer = vmx_set_efer,
 	.get_idt = vmx_get_idt,
 	.set_idt = vmx_set_idt,
 	.get_gdt = vmx_get_gdt,
