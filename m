Return-Path: <linux-kernel-owner+w=401wt.eu-S964949AbXADP7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964949AbXADP7K (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 10:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964951AbXADP7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 10:59:10 -0500
Received: from il.qumranet.com ([62.219.232.206]:46539 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964950AbXADP7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 10:59:08 -0500
Subject: [PATCH 10/33] KVM: MMU: Write protect guest pages when a shadow is
	created for them
From: Avi Kivity <avi@qumranet.com>
Date: Thu, 04 Jan 2007 15:59:06 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <459D21DD.5090506@qumranet.com>
In-Reply-To: <459D21DD.5090506@qumranet.com>
Message-Id: <20070104155906.6F975250048@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When we cache a guest page table into a shadow page table, we need to prevent
further access to that page by the guest, as that would render the cache
incoherent.

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/mmu.c
===================================================================
--- linux-2.6.orig/drivers/kvm/mmu.c
+++ linux-2.6/drivers/kvm/mmu.c
@@ -274,6 +274,35 @@ static void rmap_remove(struct kvm *kvm,
 	}
 }
 
+static void rmap_write_protect(struct kvm *kvm, u64 gfn)
+{
+	struct page *page;
+	struct kvm_memory_slot *slot;
+	struct kvm_rmap_desc *desc;
+	u64 *spte;
+
+	slot = gfn_to_memslot(kvm, gfn);
+	BUG_ON(!slot);
+	page = gfn_to_page(slot, gfn);
+
+	while (page->private) {
+		if (!(page->private & 1))
+			spte = (u64 *)page->private;
+		else {
+			desc = (struct kvm_rmap_desc *)(page->private & ~1ul);
+			spte = desc->shadow_ptes[0];
+		}
+		BUG_ON(!spte);
+		BUG_ON((*spte & PT64_BASE_ADDR_MASK) !=
+		       page_to_pfn(page) << PAGE_SHIFT);
+		BUG_ON(!(*spte & PT_PRESENT_MASK));
+		BUG_ON(!(*spte & PT_WRITABLE_MASK));
+		rmap_printk("rmap_write_protect: spte %p %llx\n", spte, *spte);
+		rmap_remove(kvm, spte);
+		*spte &= ~(u64)PT_WRITABLE_MASK;
+	}
+}
+
 static void kvm_mmu_free_page(struct kvm_vcpu *vcpu, hpa_t page_hpa)
 {
 	struct kvm_mmu_page *page_head = page_header(page_hpa);
@@ -444,6 +473,8 @@ static struct kvm_mmu_page *kvm_mmu_get_
 	page->gfn = gfn;
 	page->role = role;
 	hlist_add_head(&page->hash_link, bucket);
+	if (!metaphysical)
+		rmap_write_protect(vcpu->kvm, gfn);
 	return page;
 }
 
@@ -705,6 +736,7 @@ static void kvm_mmu_flush_tlb(struct kvm
 
 static void paging_new_cr3(struct kvm_vcpu *vcpu)
 {
+	pgprintk("%s: cr3 %lx\n", __FUNCTION__, vcpu->cr3);
 	mmu_free_roots(vcpu);
 	mmu_alloc_roots(vcpu);
 	kvm_mmu_flush_tlb(vcpu);
@@ -727,24 +759,11 @@ static inline void set_pte_common(struct
 	*shadow_pte |= access_bits << PT_SHADOW_BITS_OFFSET;
 	if (!dirty)
 		access_bits &= ~PT_WRITABLE_MASK;
-	if (access_bits & PT_WRITABLE_MASK) {
-		struct kvm_mmu_page *shadow;
 
-		shadow = kvm_mmu_lookup_page(vcpu, gaddr >> PAGE_SHIFT);
-		if (shadow)
-			pgprintk("%s: found shadow page for %lx, marking ro\n",
-				 __FUNCTION__, (gfn_t)(gaddr >> PAGE_SHIFT));
-		if (shadow)
-			access_bits &= ~PT_WRITABLE_MASK;
-	}
-
-	if (access_bits & PT_WRITABLE_MASK)
-		mark_page_dirty(vcpu->kvm, gaddr >> PAGE_SHIFT);
+	paddr = gpa_to_hpa(vcpu, gaddr & PT64_BASE_ADDR_MASK);
 
 	*shadow_pte |= access_bits;
 
-	paddr = gpa_to_hpa(vcpu, gaddr & PT64_BASE_ADDR_MASK);
-
 	if (!(*shadow_pte & PT_GLOBAL_MASK))
 		mark_pagetable_nonglobal(shadow_pte);
 
@@ -752,11 +771,28 @@ static inline void set_pte_common(struct
 		*shadow_pte |= gaddr;
 		*shadow_pte |= PT_SHADOW_IO_MARK;
 		*shadow_pte &= ~PT_PRESENT_MASK;
-	} else {
-		*shadow_pte |= paddr;
-		page_header_update_slot(vcpu->kvm, shadow_pte, gaddr);
-		rmap_add(vcpu->kvm, shadow_pte);
+		return;
+	}
+
+	*shadow_pte |= paddr;
+
+	if (access_bits & PT_WRITABLE_MASK) {
+		struct kvm_mmu_page *shadow;
+
+		shadow = kvm_mmu_lookup_page(vcpu, gaddr >> PAGE_SHIFT);
+		if (shadow) {
+			pgprintk("%s: found shadow page for %lx, marking ro\n",
+				 __FUNCTION__, (gfn_t)(gaddr >> PAGE_SHIFT));
+			access_bits &= ~PT_WRITABLE_MASK;
+			*shadow_pte &= ~PT_WRITABLE_MASK;
+		}
 	}
+
+	if (access_bits & PT_WRITABLE_MASK)
+		mark_page_dirty(vcpu->kvm, gaddr >> PAGE_SHIFT);
+
+	page_header_update_slot(vcpu->kvm, shadow_pte, gaddr);
+	rmap_add(vcpu->kvm, shadow_pte);
 }
 
 static void inject_page_fault(struct kvm_vcpu *vcpu,
Index: linux-2.6/drivers/kvm/paging_tmpl.h
===================================================================
--- linux-2.6.orig/drivers/kvm/paging_tmpl.h
+++ linux-2.6/drivers/kvm/paging_tmpl.h
@@ -133,6 +133,7 @@ static void FNAME(walk_addr)(struct gues
 			 walker->level - 1, table_gfn);
 	}
 	walker->ptep = ptep;
+	pgprintk("%s: pte %llx\n", __FUNCTION__, (u64)*ptep);
 }
 
 static void FNAME(release_walker)(struct guest_walker *walker)
