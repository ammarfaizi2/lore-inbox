Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754103AbWKGPyv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754103AbWKGPyv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 10:54:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754141AbWKGPyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 10:54:51 -0500
Received: from il.qumranet.com ([62.219.232.206]:60618 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1754103AbWKGPyu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 10:54:50 -0500
Subject: [PATCH] KVM: Workaround cr0.cd (cache disable) bit leak from guest to
	host
From: Avi Kivity <avi@qumranet.com>
Date: Tue, 07 Nov 2006 15:54:49 -0000
To: kvm-devel@lists.sourceforge.net
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Message-Id: <20061107155449.839D4A0001@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Core-not-2 processors (or on laptops - not sure what the cause is), the
cache disable bit sometimes leaks from the guest cr0 to the host cr0.  This
leaves the host limping along at a snail's pace long after the guest has
left.  This might be a bug in the processor or in the smm (system management
mode) bios.

Workaround by giving the guest a virtual cr0.cd (and also cr0.nw for good
measure) and keeping the real bits always clear.

This makes sense even without the bug:  the processor cache is a host
resource, not a guest resource, and the guest has no business disabling it.

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm.h
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm.h
+++ linux-2.6/drivers/kvm/kvm.h
@@ -31,8 +31,10 @@
 #define CR4_VMXE_MASK (1ULL << 13)
 
 #define KVM_GUEST_CR0_MASK \
+	(CR0_PG_MASK | CR0_PE_MASK | CR0_WP_MASK | CR0_NE_MASK \
+	 | CR0_NW_MASK | CR0_CD_MASK)
+#define KVM_VM_CR0_ALWAYS_ON \
 	(CR0_PG_MASK | CR0_PE_MASK | CR0_WP_MASK | CR0_NE_MASK)
-#define KVM_VM_CR0_ALWAYS_ON KVM_GUEST_CR0_MASK
 
 #define KVM_GUEST_CR4_MASK \
 	(CR4_PSE_MASK | CR4_PAE_MASK | CR4_PGE_MASK | CR4_VMXE_MASK | CR4_VME_MASK)
Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -870,7 +870,8 @@ static void __set_cr0(struct kvm_vcpu *v
 #endif
 
 	vmcs_writel(CR0_READ_SHADOW, cr0);
-	vmcs_writel(GUEST_CR0, cr0 | KVM_VM_CR0_ALWAYS_ON);
+	vmcs_writel(GUEST_CR0,
+		    (cr0 & ~KVM_GUEST_CR0_MASK) | KVM_VM_CR0_ALWAYS_ON);
 }
 
 static int pdptrs_have_reserved_bits_set(struct kvm_vcpu *vcpu,
@@ -3008,7 +3009,8 @@ static int kvm_dev_ioctl_set_sregs(struc
 	vcpu->rmode.active = ((sregs->cr0 & CR0_PE_MASK) == 0);
 	update_exception_bitmap(vcpu);
 	vmcs_writel(CR0_READ_SHADOW, sregs->cr0);
-	vmcs_writel(GUEST_CR0, sregs->cr0 | KVM_VM_CR0_ALWAYS_ON);
+	vmcs_writel(GUEST_CR0,
+		    (sregs->cr0 & ~KVM_GUEST_CR0_MASK) | KVM_VM_CR0_ALWAYS_ON);
 
 	mmu_reset_needed |=  guest_cr4() != sregs->cr4;
 	__set_cr4(vcpu, sregs->cr4);
