Return-Path: <linux-kernel-owner+w=401wt.eu-S964950AbXADQBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964950AbXADQBK (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 11:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964935AbXADQBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 11:01:09 -0500
Received: from il.qumranet.com ([62.219.232.206]:46920 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964950AbXADQBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 11:01:08 -0500
Subject: [PATCH 12/33] KVM: MMU: Support emulated writes into RAM
From: Avi Kivity <avi@qumranet.com>
Date: Thu, 04 Jan 2007 16:01:06 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <459D21DD.5090506@qumranet.com>
In-Reply-To: <459D21DD.5090506@qumranet.com>
Message-Id: <20070104160106.8E509250048@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As the mmu write protects guest page table, we emulate those writes.  Since
they are not mmio, there is no need to go to userspace to perform them.

So, perform the writes in the kernel if possible, and notify the mmu about
them so it can take the approriate action.

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/mmu.c
===================================================================
--- linux-2.6.orig/drivers/kvm/mmu.c
+++ linux-2.6/drivers/kvm/mmu.c
@@ -956,6 +956,15 @@ int kvm_mmu_reset_context(struct kvm_vcp
 	return init_kvm_mmu(vcpu);
 }
 
+void kvm_mmu_pre_write(struct kvm_vcpu *vcpu, gpa_t gpa, int bytes)
+{
+	pgprintk("%s: gpa %llx bytes %d\n", __FUNCTION__, gpa, bytes);
+}
+
+void kvm_mmu_post_write(struct kvm_vcpu *vcpu, gpa_t gpa, int bytes)
+{
+}
+
 static void free_mmu_pages(struct kvm_vcpu *vcpu)
 {
 	while (!list_empty(&vcpu->free_pages)) {
Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -877,6 +877,27 @@ static int emulator_read_emulated(unsign
 	}
 }
 
+static int emulator_write_phys(struct kvm_vcpu *vcpu, gpa_t gpa,
+			       unsigned long val, int bytes)
+{
+	struct kvm_memory_slot *m;
+	struct page *page;
+	void *virt;
+
+	if (((gpa + bytes - 1) >> PAGE_SHIFT) != (gpa >> PAGE_SHIFT))
+		return 0;
+	m = gfn_to_memslot(vcpu->kvm, gpa >> PAGE_SHIFT);
+	if (!m)
+		return 0;
+	page = gfn_to_page(m, gpa >> PAGE_SHIFT);
+	kvm_mmu_pre_write(vcpu, gpa, bytes);
+	virt = kmap_atomic(page, KM_USER0);
+	memcpy(virt + offset_in_page(gpa), &val, bytes);
+	kunmap_atomic(virt, KM_USER0);
+	kvm_mmu_post_write(vcpu, gpa, bytes);
+	return 1;
+}
+
 static int emulator_write_emulated(unsigned long addr,
 				   unsigned long val,
 				   unsigned int bytes,
@@ -888,6 +909,9 @@ static int emulator_write_emulated(unsig
 	if (gpa == UNMAPPED_GVA)
 		return X86EMUL_PROPAGATE_FAULT;
 
+	if (emulator_write_phys(vcpu, gpa, val, bytes))
+		return X86EMUL_CONTINUE;
+
 	vcpu->mmio_needed = 1;
 	vcpu->mmio_phys_addr = gpa;
 	vcpu->mmio_size = bytes;
Index: linux-2.6/drivers/kvm/kvm.h
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm.h
+++ linux-2.6/drivers/kvm/kvm.h
@@ -448,6 +448,9 @@ int kvm_write_guest(struct kvm_vcpu *vcp
 
 unsigned long segment_base(u16 selector);
 
+void kvm_mmu_pre_write(struct kvm_vcpu *vcpu, gpa_t gpa, int bytes);
+void kvm_mmu_post_write(struct kvm_vcpu *vcpu, gpa_t gpa, int bytes);
+
 static inline struct page *_gfn_to_page(struct kvm *kvm, gfn_t gfn)
 {
 	struct kvm_memory_slot *slot = gfn_to_memslot(kvm, gfn);
