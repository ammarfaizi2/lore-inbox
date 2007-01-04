Return-Path: <linux-kernel-owner+w=401wt.eu-S964780AbXADPxK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964780AbXADPxK (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 10:53:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbXADPxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 10:53:09 -0500
Received: from il.qumranet.com ([62.219.232.206]:39063 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932372AbXADPxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 10:53:08 -0500
Subject: [PATCH 4/33] KVM: MMU: Fold fetch_guest() into init_walker()
From: Avi Kivity <avi@qumranet.com>
Date: Thu, 04 Jan 2007 15:53:05 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <459D21DD.5090506@qumranet.com>
In-Reply-To: <459D21DD.5090506@qumranet.com>
Message-Id: <20070104155305.DC4E1250048@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It is never necessary to fetch a guest entry from an intermediate page table
level (except for large pages), so avoid some confusion by always descending
into the lowest possible level.

Rename init_walker() to walk_addr() as it is no longer restricted to
initialization.

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/paging_tmpl.h
===================================================================
--- linux-2.6.orig/drivers/kvm/paging_tmpl.h
+++ linux-2.6/drivers/kvm/paging_tmpl.h
@@ -54,14 +54,19 @@ struct guest_walker {
 	int level;
 	gfn_t table_gfn;
 	pt_element_t *table;
+	pt_element_t *ptep;
 	pt_element_t inherited_ar;
 };
 
-static void FNAME(init_walker)(struct guest_walker *walker,
-			       struct kvm_vcpu *vcpu)
+/*
+ * Fetch a guest pte for a guest virtual address
+ */
+static void FNAME(walk_addr)(struct guest_walker *walker,
+			     struct kvm_vcpu *vcpu, gva_t addr)
 {
 	hpa_t hpa;
 	struct kvm_memory_slot *slot;
+	pt_element_t *ptep;
 
 	walker->level = vcpu->mmu.root_level;
 	walker->table_gfn = (vcpu->cr3 & PT64_BASE_ADDR_MASK) >> PAGE_SHIFT;
@@ -75,6 +80,38 @@ static void FNAME(init_walker)(struct gu
 	walker->table = (pt_element_t *)( (unsigned long)walker->table |
 		(unsigned long)(vcpu->cr3 & ~(PAGE_MASK | CR3_FLAGS_MASK)) );
 	walker->inherited_ar = PT_USER_MASK | PT_WRITABLE_MASK;
+
+	for (;;) {
+		int index = PT_INDEX(addr, walker->level);
+		hpa_t paddr;
+
+		ptep = &walker->table[index];
+		ASSERT(((unsigned long)walker->table & PAGE_MASK) ==
+		       ((unsigned long)ptep & PAGE_MASK));
+
+		/* Don't set accessed bit on PAE PDPTRs */
+		if (vcpu->mmu.root_level != 3 || walker->level != 3)
+			if ((*ptep & (PT_PRESENT_MASK | PT_ACCESSED_MASK))
+			    == PT_PRESENT_MASK)
+				*ptep |= PT_ACCESSED_MASK;
+
+		if (!is_present_pte(*ptep) ||
+		    walker->level == PT_PAGE_TABLE_LEVEL ||
+		    (walker->level == PT_DIRECTORY_LEVEL &&
+		     (*ptep & PT_PAGE_SIZE_MASK) &&
+		     (PTTYPE == 64 || is_pse(vcpu))))
+			break;
+
+		if (walker->level != 3 || is_long_mode(vcpu))
+			walker->inherited_ar &= walker->table[index];
+		walker->table_gfn = (*ptep & PT_BASE_ADDR_MASK) >> PAGE_SHIFT;
+		paddr = safe_gpa_to_hpa(vcpu, *ptep & PT_BASE_ADDR_MASK);
+		kunmap_atomic(walker->table, KM_USER0);
+		walker->table = kmap_atomic(pfn_to_page(paddr >> PAGE_SHIFT),
+					    KM_USER0);
+		--walker->level;
+	}
+	walker->ptep = ptep;
 }
 
 static void FNAME(release_walker)(struct guest_walker *walker)
@@ -110,41 +147,6 @@ static void FNAME(set_pde)(struct kvm_vc
 }
 
 /*
- * Fetch a guest pte from a specific level in the paging hierarchy.
- */
-static pt_element_t *FNAME(fetch_guest)(struct kvm_vcpu *vcpu,
-					struct guest_walker *walker,
-					int level,
-					gva_t addr)
-{
-
-	ASSERT(level > 0  && level <= walker->level);
-
-	for (;;) {
-		int index = PT_INDEX(addr, walker->level);
-		hpa_t paddr;
-
-		ASSERT(((unsigned long)walker->table & PAGE_MASK) ==
-		       ((unsigned long)&walker->table[index] & PAGE_MASK));
-		if (level == walker->level ||
-		    !is_present_pte(walker->table[index]) ||
-		    (walker->level == PT_DIRECTORY_LEVEL &&
-		     (walker->table[index] & PT_PAGE_SIZE_MASK) &&
-		     (PTTYPE == 64 || is_pse(vcpu))))
-			return &walker->table[index];
-		if (walker->level != 3 || is_long_mode(vcpu))
-			walker->inherited_ar &= walker->table[index];
-		walker->table_gfn = (walker->table[index] & PT_BASE_ADDR_MASK)
-			>> PAGE_SHIFT;
-		paddr = safe_gpa_to_hpa(vcpu, walker->table[index] & PT_BASE_ADDR_MASK);
-		kunmap_atomic(walker->table, KM_USER0);
-		walker->table = kmap_atomic(pfn_to_page(paddr >> PAGE_SHIFT),
-					    KM_USER0);
-		--walker->level;
-	}
-}
-
-/*
  * Fetch a shadow pte for a specific level in the paging hierarchy.
  */
 static u64 *FNAME(fetch)(struct kvm_vcpu *vcpu, gva_t addr,
@@ -153,6 +155,10 @@ static u64 *FNAME(fetch)(struct kvm_vcpu
 	hpa_t shadow_addr;
 	int level;
 	u64 *prev_shadow_ent = NULL;
+	pt_element_t *guest_ent = walker->ptep;
+
+	if (!is_present_pte(*guest_ent))
+		return NULL;
 
 	shadow_addr = vcpu->mmu.root_hpa;
 	level = vcpu->mmu.shadow_root_level;
@@ -160,7 +166,6 @@ static u64 *FNAME(fetch)(struct kvm_vcpu
 	for (; ; level--) {
 		u32 index = SHADOW_PT_INDEX(addr, level);
 		u64 *shadow_ent = ((u64 *)__va(shadow_addr)) + index;
-		pt_element_t *guest_ent;
 		u64 shadow_pte;
 
 		if (is_present_pte(*shadow_ent) || is_io_pte(*shadow_ent)) {
@@ -171,21 +176,6 @@ static u64 *FNAME(fetch)(struct kvm_vcpu
 			continue;
 		}
 
-		if (PTTYPE == 32 && level > PT32_ROOT_LEVEL) {
-			ASSERT(level == PT32E_ROOT_LEVEL);
-			guest_ent = FNAME(fetch_guest)(vcpu, walker,
-						       PT32_ROOT_LEVEL, addr);
-		} else
-			guest_ent = FNAME(fetch_guest)(vcpu, walker,
-						       level, addr);
-
-		if (!is_present_pte(*guest_ent))
-			return NULL;
-
-		/* Don't set accessed bit on PAE PDPTRs */
-		if (vcpu->mmu.root_level != 3 || walker->level != 3)
-			*guest_ent |= PT_ACCESSED_MASK;
-
 		if (level == PT_PAGE_TABLE_LEVEL) {
 
 			if (walker->level == PT_DIRECTORY_LEVEL) {
@@ -253,7 +243,7 @@ static int FNAME(fix_write_pf)(struct kv
 			*shadow_ent &= ~PT_USER_MASK;
 		}
 
-	guest_ent = FNAME(fetch_guest)(vcpu, walker, PT_PAGE_TABLE_LEVEL, addr);
+	guest_ent = walker->ptep;
 
 	if (!is_present_pte(*guest_ent)) {
 		*shadow_ent = 0;
@@ -296,7 +286,7 @@ static int FNAME(page_fault)(struct kvm_
 	 * Look up the shadow pte for the faulting address.
 	 */
 	for (;;) {
-		FNAME(init_walker)(&walker, vcpu);
+		FNAME(walk_addr)(&walker, vcpu, addr);
 		shadow_pte = FNAME(fetch)(vcpu, addr, &walker);
 		if (IS_ERR(shadow_pte)) {  /* must be -ENOMEM */
 			nonpaging_flush(vcpu);
@@ -357,9 +347,8 @@ static gpa_t FNAME(gva_to_gpa)(struct kv
 	pt_element_t guest_pte;
 	gpa_t gpa;
 
-	FNAME(init_walker)(&walker, vcpu);
-	guest_pte = *FNAME(fetch_guest)(vcpu, &walker, PT_PAGE_TABLE_LEVEL,
-					vaddr);
+	FNAME(walk_addr)(&walker, vcpu, vaddr);
+	guest_pte = *walker.ptep;
 	FNAME(release_walker)(&walker);
 
 	if (!is_present_pte(guest_pte))
