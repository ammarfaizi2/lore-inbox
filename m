Return-Path: <linux-kernel-owner+w=401wt.eu-S1030216AbXAKKEc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030216AbXAKKEc (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 05:04:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030243AbXAKKEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 05:04:32 -0500
Received: from il.qumranet.com ([62.219.232.206]:44410 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030238AbXAKKEb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 05:04:31 -0500
Subject: [PATCH 2/5] KVM: Fix race between mmio reads and injected interrupts
From: Avi Kivity <avi@qumranet.com>
Date: Thu, 11 Jan 2007 10:04:30 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <45A60B2F.6090901@qumranet.com>
In-Reply-To: <45A60B2F.6090901@qumranet.com>
Message-Id: <20070111100430.33462250595@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The kvm mmio read path looks like:

 1. guest read faults
 2. kvm emulates read, calls emulator_read_emulated()
 3. fails as a read requires userspace help
 4. exit to userspace
 5. userspace emulates read, kvm sets vcpu->mmio_read_completed
 6. re-enter guest, fault again
 7. kvm emulates read, calls emulator_read_emulated()
 8. succeeds as vcpu->mmio_read_emulated is set
 9. instruction completes and guest is resumed

A problem surfaces if the userspace exit (step 5) also requests an interrupt
injection.  In that case, the guest does not re-execute the original
instruction, but the interrupt handler.  The next time an mmio read is
exectued (likely for a different address), step 3 will find
vcpu->mmio_read_completed set and return the value read for the original
instruction.

The problem manifested itself in a few annoying ways:
- little squares appear randomly on console when switching virtual terminals
- ne2000 fails under nfs read load
- rtl8139 complains about "pci errors" even though the device model is
  incapable of issuing them.

Fix by skipping interrupt injection if an mmio read is pending.

A better fix is to avoid re-entry into the guest, and re-emulating immediately
instead.  However that's a bit more complex.

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/svm.c
===================================================================
--- linux-2.6.orig/drivers/kvm/svm.c
+++ linux-2.6/drivers/kvm/svm.c
@@ -1407,7 +1407,8 @@ static int svm_vcpu_run(struct kvm_vcpu 
 	int r;
 
 again:
-	do_interrupt_requests(vcpu, kvm_run);
+	if (!vcpu->mmio_read_completed)
+		do_interrupt_requests(vcpu, kvm_run);
 
 	clgi();
 
Index: linux-2.6/drivers/kvm/vmx.c
===================================================================
--- linux-2.6.orig/drivers/kvm/vmx.c
+++ linux-2.6/drivers/kvm/vmx.c
@@ -1717,7 +1717,8 @@ again:
 	vmcs_writel(HOST_GS_BASE, segment_base(gs_sel));
 #endif
 
-	do_interrupt_requests(vcpu, kvm_run);
+	if (!vcpu->mmio_read_completed)
+		do_interrupt_requests(vcpu, kvm_run);
 
 	if (vcpu->guest_debug.enabled)
 		kvm_guest_debug_pre(vcpu);
