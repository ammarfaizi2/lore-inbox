Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161709AbWKEUeh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161709AbWKEUeh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 15:34:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161712AbWKEUeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 15:34:37 -0500
Received: from il.qumranet.com ([62.219.232.206]:28316 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1161709AbWKEUeg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 15:34:36 -0500
Subject: [PATCH 6/14] KVM: memory slot management
From: Avi Kivity <avi@qumranet.com>
Date: Sun, 05 Nov 2006 20:34:35 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <454E4941.7000108@qumranet.com>
In-Reply-To: <454E4941.7000108@qumranet.com>
Message-Id: <20061105203435.2FA912500A7@cleopatra.q>
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
@@ -1039,6 +1039,211 @@ static void vcpu_put_rsp_rip(struct kvm_
 	vmcs_writel(GUEST_RIP, vcpu->rip);
 }
 
+/*
+ * Allocate some memory and give it an address in the guest physical address
+ * space.
+ *
+ * Discontiguous memory is allowed, mostly for framebuffers.
+ */
+static int kvm_dev_ioctl_set_memory_region(struct kvm *kvm,
+					   struct kvm_memory_region *mem)
+{
+	int r;
+	gfn_t base_gfn;
+	unsigned long npages;
+	unsigned long i;
+	struct kvm_memory_slot *memslot;
+	struct kvm_memory_slot old, new;
+	int memory_config_version;
+
+	r = -EINVAL;
+	/* General sanity checks */
+	if (mem->memory_size & (PAGE_SIZE - 1))
+		goto out;
+	if (mem->guest_phys_addr & (PAGE_SIZE - 1))
+		goto out;
+	if (mem->slot >= KVM_MEMORY_SLOTS)
+		goto out;
+	if (mem->guest_phys_addr + mem->memory_size < mem->guest_phys_addr)
+		goto out;
+
+	memslot = &kvm->memslots[mem->slot];
+	base_gfn = mem->guest_phys_addr >> PAGE_SHIFT;
+	npages = mem->memory_size >> PAGE_SHIFT;
+
+	if (!npages)
+		mem->flags &= ~KVM_MEM_LOG_DIRTY_PAGES;
+
+raced:
+	spin_lock(&kvm->lock);
+
+	memory_config_version = kvm->memory_config_version;
+	new = old = *memslot;
+
+	new.base_gfn = base_gfn;
+	new.npages = npages;
+	new.flags = mem->flags;
+
+	/* Disallow changing a memory slot's size. */
+	r = -EINVAL;
+	if (npages && old.npages && npages != old.npages)
+		goto out_unlock;
+
+	/* Check for overlaps */
+	r = -EEXIST;
+	for (i = 0; i < KVM_MEMORY_SLOTS; ++i) {
+		struct kvm_memory_slot *s = &kvm->memslots[i];
+
+		if (s == memslot)
+			continue;
+		if (!((base_gfn + npages <= s->base_gfn) ||
+		      (base_gfn >= s->base_gfn + s->npages)))
+			goto out_unlock;
+	}
+	/*
+	 * Do memory allocations outside lock.  memory_config_version will
+	 * detect any races.
+	 */
+	spin_unlock(&kvm->lock);
+
+	/* Deallocate if slot is being removed */
+	if (!npages)
+		new.phys_mem = 0;
+
+	/* Free page dirty bitmap if unneeded */
+	if (!(new.flags & KVM_MEM_LOG_DIRTY_PAGES))
+		new.dirty_bitmap = 0;
+
+	r = -ENOMEM;
+
+	/* Allocate if a slot is being created */
+	if (npages && !new.phys_mem) {
+		new.phys_mem = vmalloc(npages * sizeof(struct page *));
+
+		if (!new.phys_mem)
+			goto out_free;
+
+		memset(new.phys_mem, 0, npages * sizeof(struct page *));
+		for (i = 0; i < npages; ++i) {
+			new.phys_mem[i] = alloc_page(GFP_HIGHUSER);
+			if (!new.phys_mem[i])
+				goto out_free;
+		}
+	}
+
+	/* Allocate page dirty bitmap if needed */
+	if ((new.flags & KVM_MEM_LOG_DIRTY_PAGES) && !new.dirty_bitmap) {
+		unsigned dirty_bytes = ALIGN(npages, BITS_PER_LONG) / 8;
+
+		new.dirty_bitmap = vmalloc(dirty_bytes);
+		if (!new.dirty_bitmap)
+			goto out_free;
+		memset(new.dirty_bitmap, 0, dirty_bytes);
+	}
+
+	spin_lock(&kvm->lock);
+
+	if (memory_config_version != kvm->memory_config_version) {
+		spin_unlock(&kvm->lock);
+		kvm_free_physmem_slot(&new, &old);
+		goto raced;
+	}
+
+	r = -EAGAIN;
+	if (kvm->busy)
+		goto out_unlock;
+
+	if (mem->slot >= kvm->nmemslots)
+		kvm->nmemslots = mem->slot + 1;
+
+	*memslot = new;
+	++kvm->memory_config_version;
+
+	spin_unlock(&kvm->lock);
+
+	for (i = 0; i < KVM_MAX_VCPUS; ++i) {
+		struct kvm_vcpu *vcpu;
+
+		vcpu = vcpu_load(kvm, i);
+		if (!vcpu)
+			continue;
+		kvm_mmu_reset_context(vcpu);
+		vcpu_put(vcpu);
+	}
+
+	kvm_free_physmem_slot(&old, &new);
+	return 0;
+
+out_unlock:
+	spin_unlock(&kvm->lock);
+out_free:
+	kvm_free_physmem_slot(&new, &old);
+out:
+	return r;
+}
+
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
@@ -1201,6 +1406,28 @@ static long kvm_dev_ioctl(struct file *f
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
