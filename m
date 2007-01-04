Return-Path: <linux-kernel-owner+w=401wt.eu-S932352AbXADPvJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbXADPvJ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 10:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932372AbXADPvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 10:51:08 -0500
Received: from il.qumranet.com ([62.219.232.206]:39053 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932352AbXADPvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 10:51:07 -0500
Subject: [PATCH 2/33] KVM: MMU: Teach the page table walker to track guest
	page table gfns
From: Avi Kivity <avi@qumranet.com>
Date: Thu, 04 Jan 2007 15:51:05 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <459D21DD.5090506@qumranet.com>
In-Reply-To: <459D21DD.5090506@qumranet.com>
Message-Id: <20070104155105.AD445250048@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Saving the table gfns removes the need to walk the guest and host page tables
in lockstep.

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/paging_tmpl.h
===================================================================
--- linux-2.6.orig/drivers/kvm/paging_tmpl.h
+++ linux-2.6/drivers/kvm/paging_tmpl.h
@@ -52,6 +52,7 @@
  */
 struct guest_walker {
 	int level;
+	gfn_t table_gfn;
 	pt_element_t *table;
 	pt_element_t inherited_ar;
 };
@@ -63,8 +64,8 @@ static void FNAME(init_walker)(struct gu
 	struct kvm_memory_slot *slot;
 
 	walker->level = vcpu->mmu.root_level;
-	slot = gfn_to_memslot(vcpu->kvm,
-			      (vcpu->cr3 & PT64_BASE_ADDR_MASK) >> PAGE_SHIFT);
+	walker->table_gfn = (vcpu->cr3 & PT64_BASE_ADDR_MASK) >> PAGE_SHIFT;
+	slot = gfn_to_memslot(vcpu->kvm, walker->table_gfn);
 	hpa = safe_gpa_to_hpa(vcpu, vcpu->cr3 & PT64_BASE_ADDR_MASK);
 	walker->table = kmap_atomic(pfn_to_page(hpa >> PAGE_SHIFT), KM_USER0);
 
@@ -133,6 +134,8 @@ static pt_element_t *FNAME(fetch_guest)(
 			return &walker->table[index];
 		if (walker->level != 3 || is_long_mode(vcpu))
 			walker->inherited_ar &= walker->table[index];
+		walker->table_gfn = (walker->table[index] & PT_BASE_ADDR_MASK)
+			>> PAGE_SHIFT;
 		paddr = safe_gpa_to_hpa(vcpu, walker->table[index] & PT_BASE_ADDR_MASK);
 		kunmap_atomic(walker->table, KM_USER0);
 		walker->table = kmap_atomic(pfn_to_page(paddr >> PAGE_SHIFT),
