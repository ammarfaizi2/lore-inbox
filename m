Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423165AbWKPSCY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423165AbWKPSCY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 13:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423750AbWKPSCY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 13:02:24 -0500
Received: from il.qumranet.com ([62.219.232.206]:3745 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1423165AbWKPSCX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 13:02:23 -0500
Subject: [PATCH 1/3] KVM: Expose interrupt bitmap
From: Avi Kivity <avi@qumranet.com>
Date: Thu, 16 Nov 2006 18:02:21 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, uril@qumranet.com
References: <455CA70C.9060307@qumranet.com>
In-Reply-To: <455CA70C.9060307@qumranet.com>
Message-Id: <20061116180221.D69FC25015E@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Uri Lublin <uril@qumranet.com>

Expose all not-yet-delivered interrupts to userspace.  This allows a guest
to be saved and resumed even if some interrupts are yet pending.

Signed-off-by: Uri Lublin <uril@qumranet.com>
Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm.h
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm.h
+++ linux-2.6/drivers/kvm/kvm.h
@@ -13,6 +13,7 @@
 #include <linux/mm.h>
 
 #include "vmx.h"
+#include <linux/kvm.h>
 
 #define CR0_PE_MASK (1ULL << 0)
 #define CR0_TS_MASK (1ULL << 3)
@@ -164,7 +165,7 @@ struct kvm_vcpu {
 	int   cpu;
 	int   launched;
 	unsigned long irq_summary; /* bit vector: 1 per word in irq_pending */
-#define NR_IRQ_WORDS (256 / BITS_PER_LONG)
+#define NR_IRQ_WORDS KVM_IRQ_BITMAP_SIZE(unsigned long)
 	unsigned long irq_pending[NR_IRQ_WORDS];
 	unsigned long regs[NR_VCPU_REGS]; /* for rsp: vcpu_load_rsp_rip() */
 	unsigned long rip;      /* needs vcpu_load_rsp_rip() */
Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -3000,7 +3000,8 @@ static int kvm_dev_ioctl_get_sregs(struc
 	sregs->efer = vcpu->shadow_efer;
 	sregs->apic_base = vcpu->apic_base;
 
-	sregs->pending_int = vcpu->irq_summary != 0;
+	memcpy(sregs->interrupt_bitmap, vcpu->irq_pending,
+	       sizeof sregs->interrupt_bitmap);
 
 	vcpu_put(vcpu);
 
@@ -3034,6 +3035,7 @@ static int kvm_dev_ioctl_set_sregs(struc
 {
 	struct kvm_vcpu *vcpu;
 	int mmu_reset_needed = 0;
+	int i;
 
 	if (sregs->vcpu < 0 || sregs->vcpu >= KVM_MAX_VCPUS)
 		return -EINVAL;
@@ -3083,6 +3085,14 @@ static int kvm_dev_ioctl_set_sregs(struc
 
 	if (mmu_reset_needed)
 		kvm_mmu_reset_context(vcpu);
+
+	memcpy(vcpu->irq_pending, sregs->interrupt_bitmap,
+	       sizeof vcpu->irq_pending);
+	vcpu->irq_summary = 0;
+	for (i = 0; i < NR_IRQ_WORDS; ++i)
+		if (vcpu->irq_pending[i])
+			__set_bit(i, &vcpu->irq_summary);
+
 	vcpu_put(vcpu);
 
 	return 0;
Index: linux-2.6/include/linux/kvm.h
===================================================================
--- linux-2.6.orig/include/linux/kvm.h
+++ linux-2.6/include/linux/kvm.h
@@ -11,6 +11,15 @@
 #include <asm/types.h>
 #include <linux/ioctl.h>
 
+/*
+ * Architectural interrupt line count, and the size of the bitmap needed
+ * to hold them.
+ */
+#define KVM_NR_INTERRUPTS 256
+#define KVM_IRQ_BITMAP_SIZE_BYTES    ((KVM_NR_INTERRUPTS + 7) / 8)
+#define KVM_IRQ_BITMAP_SIZE(type)    (KVM_IRQ_BITMAP_SIZE_BYTES / sizeof(type))
+
+
 /* for KVM_CREATE_MEMORY_REGION */
 struct kvm_memory_region {
 	__u32 slot;
@@ -129,10 +138,7 @@ struct kvm_sregs {
 	__u64 cr0, cr2, cr3, cr4, cr8;
 	__u64 efer;
 	__u64 apic_base;
-
-	/* out (KVM_GET_SREGS) */
-	__u32 pending_int;
-	__u32 padding2;
+	__u64 interrupt_bitmap[KVM_IRQ_BITMAP_SIZE(__u64)];
 };
 
 /* for KVM_TRANSLATE */
