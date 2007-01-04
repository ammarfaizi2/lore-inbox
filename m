Return-Path: <linux-kernel-owner+w=401wt.eu-S964951AbXADQAK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964951AbXADQAK (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 11:00:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964950AbXADQAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 11:00:10 -0500
Received: from il.qumranet.com ([62.219.232.206]:46543 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964935AbXADQAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 11:00:08 -0500
Subject: [PATCH 11/33] KVM: MMU: Let the walker extract the target page gfn
	from the pte
From: Avi Kivity <avi@qumranet.com>
Date: Thu, 04 Jan 2007 16:00:06 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <459D21DD.5090506@qumranet.com>
In-Reply-To: <459D21DD.5090506@qumranet.com>
Message-Id: <20070104160006.7B5EC250048@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a problem where set_pte_common() looked for shadowed pages based
on the page directory gfn (a huge page) instead of the actual gfn being
mapped.

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/mmu.c
===================================================================
--- linux-2.6.orig/drivers/kvm/mmu.c
+++ linux-2.6/drivers/kvm/mmu.c
@@ -752,7 +752,8 @@ static inline void set_pte_common(struct
 			     u64 *shadow_pte,
 			     gpa_t gaddr,
 			     int dirty,
-			     u64 access_bits)
+			     u64 access_bits,
+			     gfn_t gfn)
 {
 	hpa_t paddr;
 
@@ -779,10 +780,10 @@ static inline void set_pte_common(struct
 	if (access_bits & PT_WRITABLE_MASK) {
 		struct kvm_mmu_page *shadow;
 
-		shadow = kvm_mmu_lookup_page(vcpu, gaddr >> PAGE_SHIFT);
+		shadow = kvm_mmu_lookup_page(vcpu, gfn);
 		if (shadow) {
 			pgprintk("%s: found shadow page for %lx, marking ro\n",
-				 __FUNCTION__, (gfn_t)(gaddr >> PAGE_SHIFT));
+				 __FUNCTION__, gfn);
 			access_bits &= ~PT_WRITABLE_MASK;
 			*shadow_pte &= ~PT_WRITABLE_MASK;
 		}
Index: linux-2.6/drivers/kvm/paging_tmpl.h
===================================================================
--- linux-2.6.orig/drivers/kvm/paging_tmpl.h
+++ linux-2.6/drivers/kvm/paging_tmpl.h
@@ -62,6 +62,7 @@ struct guest_walker {
 	pt_element_t *table;
 	pt_element_t *ptep;
 	pt_element_t inherited_ar;
+	gfn_t gfn;
 };
 
 /*
@@ -113,12 +114,23 @@ static void FNAME(walk_addr)(struct gues
 		if (is_present_pte(*ptep) && !(*ptep &  PT_ACCESSED_MASK))
 			*ptep |= PT_ACCESSED_MASK;
 
-		if (!is_present_pte(*ptep) ||
-		    walker->level == PT_PAGE_TABLE_LEVEL ||
-		    (walker->level == PT_DIRECTORY_LEVEL &&
-		     (*ptep & PT_PAGE_SIZE_MASK) &&
-		     (PTTYPE == 64 || is_pse(vcpu))))
+		if (!is_present_pte(*ptep))
+			break;
+
+		if (walker->level == PT_PAGE_TABLE_LEVEL) {
+			walker->gfn = (*ptep & PT_BASE_ADDR_MASK)
+				>> PAGE_SHIFT;
+			break;
+		}
+
+		if (walker->level == PT_DIRECTORY_LEVEL
+		    && (*ptep & PT_PAGE_SIZE_MASK)
+		    && (PTTYPE == 64 || is_pse(vcpu))) {
+			walker->gfn = (*ptep & PT_DIR_BASE_ADDR_MASK)
+				>> PAGE_SHIFT;
+			walker->gfn += PT_INDEX(addr, PT_PAGE_TABLE_LEVEL);
 			break;
+		}
 
 		if (walker->level != 3 || is_long_mode(vcpu))
 			walker->inherited_ar &= walker->table[index];
@@ -143,30 +155,29 @@ static void FNAME(release_walker)(struct
 }
 
 static void FNAME(set_pte)(struct kvm_vcpu *vcpu, u64 guest_pte,
-			   u64 *shadow_pte, u64 access_bits)
+			   u64 *shadow_pte, u64 access_bits, gfn_t gfn)
 {
 	ASSERT(*shadow_pte == 0);
 	access_bits &= guest_pte;
 	*shadow_pte = (guest_pte & PT_PTE_COPY_MASK);
 	set_pte_common(vcpu, shadow_pte, guest_pte & PT_BASE_ADDR_MASK,
-		       guest_pte & PT_DIRTY_MASK, access_bits);
+		       guest_pte & PT_DIRTY_MASK, access_bits, gfn);
 }
 
 static void FNAME(set_pde)(struct kvm_vcpu *vcpu, u64 guest_pde,
-			   u64 *shadow_pte, u64 access_bits,
-			   int index)
+			   u64 *shadow_pte, u64 access_bits, gfn_t gfn)
 {
 	gpa_t gaddr;
 
 	ASSERT(*shadow_pte == 0);
 	access_bits &= guest_pde;
-	gaddr = (guest_pde & PT_DIR_BASE_ADDR_MASK) + PAGE_SIZE * index;
+	gaddr = (gpa_t)gfn << PAGE_SHIFT;
 	if (PTTYPE == 32 && is_cpuid_PSE36())
 		gaddr |= (guest_pde & PT32_DIR_PSE36_MASK) <<
 			(32 - PT32_DIR_PSE36_SHIFT);
 	*shadow_pte = guest_pde & PT_PTE_COPY_MASK;
 	set_pte_common(vcpu, shadow_pte, gaddr,
-		       guest_pde & PT_DIRTY_MASK, access_bits);
+		       guest_pde & PT_DIRTY_MASK, access_bits, gfn);
 }
 
 /*
@@ -214,10 +225,12 @@ static u64 *FNAME(fetch)(struct kvm_vcpu
 					*prev_shadow_ent |= PT_SHADOW_PS_MARK;
 				FNAME(set_pde)(vcpu, *guest_ent, shadow_ent,
 					       walker->inherited_ar,
-				          PT_INDEX(addr, PT_PAGE_TABLE_LEVEL));
+					       walker->gfn);
 			} else {
 				ASSERT(walker->level == PT_PAGE_TABLE_LEVEL);
-				FNAME(set_pte)(vcpu, *guest_ent, shadow_ent, walker->inherited_ar);
+				FNAME(set_pte)(vcpu, *guest_ent, shadow_ent,
+					       walker->inherited_ar,
+					       walker->gfn);
 			}
 			return shadow_ent;
 		}
@@ -291,7 +304,7 @@ static int FNAME(fix_write_pf)(struct kv
 		return 0;
 	}
 
-	gfn = (*guest_ent & PT64_BASE_ADDR_MASK) >> PAGE_SHIFT;
+	gfn = walker->gfn;
 	if (kvm_mmu_lookup_page(vcpu, gfn)) {
 		pgprintk("%s: found shadow page for %lx, marking ro\n",
 			 __FUNCTION__, gfn);
