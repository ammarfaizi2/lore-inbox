Return-Path: <linux-kernel-owner+w=401wt.eu-S964914AbXADPzJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964914AbXADPzJ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 10:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964935AbXADPzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 10:55:09 -0500
Received: from il.qumranet.com ([62.219.232.206]:39071 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964914AbXADPzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 10:55:07 -0500
Subject: [PATCH 6/33] KVM: MMU: Use the guest pdptrs instead of mapping cr3 in
	pae mode
From: Avi Kivity <avi@qumranet.com>
Date: Thu, 04 Jan 2007 15:55:06 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <459D21DD.5090506@qumranet.com>
In-Reply-To: <459D21DD.5090506@qumranet.com>
Message-Id: <20070104155506.3BAD9250048@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This lets us not write protect a partial page, and is anyway what a
real processor does.

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/paging_tmpl.h
===================================================================
--- linux-2.6.orig/drivers/kvm/paging_tmpl.h
+++ linux-2.6/drivers/kvm/paging_tmpl.h
@@ -67,18 +67,28 @@ static void FNAME(walk_addr)(struct gues
 	hpa_t hpa;
 	struct kvm_memory_slot *slot;
 	pt_element_t *ptep;
+	pt_element_t root;
 
 	walker->level = vcpu->mmu.root_level;
-	walker->table_gfn = (vcpu->cr3 & PT64_BASE_ADDR_MASK) >> PAGE_SHIFT;
+	walker->table = NULL;
+	root = vcpu->cr3;
+#if PTTYPE == 64
+	if (!is_long_mode(vcpu)) {
+		walker->ptep = &vcpu->pdptrs[(addr >> 30) & 3];
+		root = *walker->ptep;
+		if (!(root & PT_PRESENT_MASK))
+			return;
+		--walker->level;
+	}
+#endif
+	walker->table_gfn = (root & PT64_BASE_ADDR_MASK) >> PAGE_SHIFT;
 	slot = gfn_to_memslot(vcpu->kvm, walker->table_gfn);
-	hpa = safe_gpa_to_hpa(vcpu, vcpu->cr3 & PT64_BASE_ADDR_MASK);
+	hpa = safe_gpa_to_hpa(vcpu, root & PT64_BASE_ADDR_MASK);
 	walker->table = kmap_atomic(pfn_to_page(hpa >> PAGE_SHIFT), KM_USER0);
 
 	ASSERT((!is_long_mode(vcpu) && is_pae(vcpu)) ||
 	       (vcpu->cr3 & ~(PAGE_MASK | CR3_FLAGS_MASK)) == 0);
 
-	walker->table = (pt_element_t *)( (unsigned long)walker->table |
-		(unsigned long)(vcpu->cr3 & ~(PAGE_MASK | CR3_FLAGS_MASK)) );
 	walker->inherited_ar = PT_USER_MASK | PT_WRITABLE_MASK;
 
 	for (;;) {
@@ -89,11 +99,8 @@ static void FNAME(walk_addr)(struct gues
 		ASSERT(((unsigned long)walker->table & PAGE_MASK) ==
 		       ((unsigned long)ptep & PAGE_MASK));
 
-		/* Don't set accessed bit on PAE PDPTRs */
-		if (vcpu->mmu.root_level != 3 || walker->level != 3)
-			if ((*ptep & (PT_PRESENT_MASK | PT_ACCESSED_MASK))
-			    == PT_PRESENT_MASK)
-				*ptep |= PT_ACCESSED_MASK;
+		if (is_present_pte(*ptep) && !(*ptep &  PT_ACCESSED_MASK))
+			*ptep |= PT_ACCESSED_MASK;
 
 		if (!is_present_pte(*ptep) ||
 		    walker->level == PT_PAGE_TABLE_LEVEL ||
@@ -116,7 +123,8 @@ static void FNAME(walk_addr)(struct gues
 
 static void FNAME(release_walker)(struct guest_walker *walker)
 {
-	kunmap_atomic(walker->table, KM_USER0);
+	if (walker->table)
+		kunmap_atomic(walker->table, KM_USER0);
 }
 
 static void FNAME(set_pte)(struct kvm_vcpu *vcpu, u64 guest_pte,
Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -1491,6 +1491,8 @@ static int kvm_dev_ioctl_set_sregs(struc
 
 	mmu_reset_needed |= vcpu->cr4 != sregs->cr4;
 	kvm_arch_ops->set_cr4(vcpu, sregs->cr4);
+	if (!is_long_mode(vcpu) && is_pae(vcpu))
+		load_pdptrs(vcpu, vcpu->cr3);
 
 	if (mmu_reset_needed)
 		kvm_mmu_reset_context(vcpu);
