Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423569AbWJZR17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423569AbWJZR17 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 13:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423698AbWJZR17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 13:27:59 -0400
Received: from il.qumranet.com ([62.219.232.206]:47548 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1423570AbWJZR16 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 13:27:58 -0400
Subject: [PATCH 6/13] KVM: memory slot management
From: Avi Kivity <avi@qumranet.com>
Date: Thu, 26 Oct 2006 17:27:56 -0000
To: linux-kernel@vger.kernel.org, kvm-devel@lists.sourceforge.net
References: <4540EE2B.9020606@qumranet.com>
In-Reply-To: <4540EE2B.9020606@qumranet.com>
Message-Id: <20061026172756.D0649A0209@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kvm defines memory in "slots", more or less corresponding to the DIMM slots.

this allows us to:
 - avoid the VGA hole at 640K
 - add a pci framebuffer at runtime
 - hotplug memory

Signed-off-by: Yaniv Kamay <yaniv@qumranet.com>
Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -1182,6 +1182,68 @@ out:
 	return r;
 }
 
+/*
+ * Get (and clear) the dirty memory log for a memory slot.
+ */
+static int kvm_dev_ioctl_get_dirty_log(struct kvm *kvm,
+				       struct kvm_dirty_log *log)
+{
+	struct kvm_memory_slot *memslot;
+	int r, i;
+	int n;
+	unsigned long any = 0;
+
+	spin_lock(&kvm->lock);
+
+	/*
+	 * Prevent changes to guest memory configuration even while the lock
+	 * is not taken.
+	 */
+	++kvm->busy;
+	spin_unlock(&kvm->lock);
+	r = -EINVAL;
+	if (log->slot >= KVM_MEMORY_SLOTS)
+		goto out;
+
+	memslot = &kvm->memslots[log->slot];
+	r = -ENOENT;
+	if (!memslot->dirty_bitmap)
+		goto out;
+
+	n = ALIGN(memslot->npages, 8) / 8;
+
+	for (i = 0; !any && i < n; ++i)
+		any = memslot->dirty_bitmap[i];
+
+	r = -EFAULT;
+	if (copy_to_user(log->dirty_bitmap, memslot->dirty_bitmap, n))
+		goto out;
+
+
+	if (any) {
+		spin_lock(&kvm->lock);
+		kvm_mmu_slot_remove_write_access(kvm, log->slot);
+		spin_unlock(&kvm->lock);
+		memset(memslot->dirty_bitmap, 0, n);
+		for (i = 0; i < KVM_MAX_VCPUS; ++i) {
+			struct kvm_vcpu *vcpu = vcpu_load(kvm, i);
+
+			if (!vcpu)
+				continue;
+			flush_guest_tlb(vcpu);
+			vcpu_put(vcpu);
+		}
+	}
+
+	r = 0;
+
+out:
+	spin_lock(&kvm->lock);
+	--kvm->busy;
+	spin_unlock(&kvm->lock);
+	return r;
+}
+
 struct kvm_memory_slot *gfn_to_memslot(struct kvm *kvm, gfn_t gfn)
 {
 	int i;
@@ -1344,6 +1406,28 @@ static long kvm_dev_ioctl(struct file *f
 	int r = -EINVAL;
 
 	switch (ioctl) {
+	case KVM_SET_MEMORY_REGION: {
+		struct kvm_memory_region kvm_mem;
+
+		r = -EFAULT;
+		if (copy_from_user(&kvm_mem, (void *)arg, sizeof kvm_mem))
+			goto out;
+		r = kvm_dev_ioctl_set_memory_region(kvm, &kvm_mem);
+		if (r)
+			goto out;
+		break;
+	}
+	case KVM_GET_DIRTY_LOG: {
+		struct kvm_dirty_log log;
+
+		r = -EFAULT;
+		if (copy_from_user(&log, (void *)arg, sizeof log))
+			goto out;
+		r = kvm_dev_ioctl_get_dirty_log(kvm, &log);
+		if (r)
+			goto out;
+		break;
+	}
 	default:
 		;
 	}
