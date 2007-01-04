Return-Path: <linux-kernel-owner+w=401wt.eu-S964948AbXADQEJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964948AbXADQEJ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 11:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964965AbXADQEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 11:04:09 -0500
Received: from il.qumranet.com ([62.219.232.206]:46935 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964948AbXADQEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 11:04:08 -0500
Subject: [PATCH 15/33] KVM: MMU: Implement child shadow unlinking
From: Avi Kivity <avi@qumranet.com>
Date: Thu, 04 Jan 2007 16:04:06 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <459D21DD.5090506@qumranet.com>
In-Reply-To: <459D21DD.5090506@qumranet.com>
Message-Id: <20070104160406.E660A250048@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When removing a page table, we must maintain the parent_pte field all child
shadow page tables.

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/mmu.c
===================================================================
--- linux-2.6.orig/drivers/kvm/mmu.c
+++ linux-2.6/drivers/kvm/mmu.c
@@ -402,12 +402,21 @@ static void mmu_page_remove_parent_pte(s
 				break;
 			if (pte_chain->parent_ptes[i] != parent_pte)
 				continue;
-			while (i + 1 < NR_PTE_CHAIN_ENTRIES) {
+			while (i + 1 < NR_PTE_CHAIN_ENTRIES
+				&& pte_chain->parent_ptes[i + 1]) {
 				pte_chain->parent_ptes[i]
 					= pte_chain->parent_ptes[i + 1];
 				++i;
 			}
 			pte_chain->parent_ptes[i] = NULL;
+			if (i == 0) {
+				hlist_del(&pte_chain->link);
+				kfree(pte_chain);
+				if (hlist_empty(&page->parent_ptes)) {
+					page->multimapped = 0;
+					page->parent_pte = NULL;
+				}
+			}
 			return;
 		}
 	BUG();
@@ -481,7 +490,30 @@ static struct kvm_mmu_page *kvm_mmu_get_
 static void kvm_mmu_page_unlink_children(struct kvm_vcpu *vcpu,
 					 struct kvm_mmu_page *page)
 {
-	BUG();
+	unsigned i;
+	u64 *pt;
+	u64 ent;
+
+	pt = __va(page->page_hpa);
+
+	if (page->role.level == PT_PAGE_TABLE_LEVEL) {
+		for (i = 0; i < PT64_ENT_PER_PAGE; ++i) {
+			if (pt[i] & PT_PRESENT_MASK)
+				rmap_remove(vcpu->kvm, &pt[i]);
+			pt[i] = 0;
+		}
+		return;
+	}
+
+	for (i = 0; i < PT64_ENT_PER_PAGE; ++i) {
+		ent = pt[i];
+
+		pt[i] = 0;
+		if (!(ent & PT_PRESENT_MASK))
+			continue;
+		ent &= PT64_BASE_ADDR_MASK;
+		mmu_page_remove_parent_pte(page_header(ent), &pt[i]);
+	}
 }
 
 static void kvm_mmu_put_page(struct kvm_vcpu *vcpu,
@@ -489,8 +521,7 @@ static void kvm_mmu_put_page(struct kvm_
 			     u64 *parent_pte)
 {
 	mmu_page_remove_parent_pte(page, parent_pte);
-	if (page->role.level > PT_PAGE_TABLE_LEVEL)
-		kvm_mmu_page_unlink_children(vcpu, page);
+	kvm_mmu_page_unlink_children(vcpu, page);
 	hlist_del(&page->hash_link);
 	list_del(&page->link);
 	list_add(&page->link, &vcpu->free_pages);
@@ -511,6 +542,7 @@ static void kvm_mmu_zap_page(struct kvm_
 					     struct kvm_pte_chain, link);
 			parent_pte = chain->parent_ptes[0];
 		}
+		BUG_ON(!parent_pte);
 		kvm_mmu_put_page(vcpu, page, parent_pte);
 		*parent_pte = 0;
 	}
@@ -530,6 +562,8 @@ static int kvm_mmu_unprotect_page(struct
 	bucket = &vcpu->kvm->mmu_page_hash[index];
 	hlist_for_each_entry_safe(page, node, n, bucket, hash_link)
 		if (page->gfn == gfn && !page->role.metaphysical) {
+			pgprintk("%s: gfn %lx role %x\n", __FUNCTION__, gfn,
+				 page->role.word);
 			kvm_mmu_zap_page(vcpu, page);
 			r = 1;
 		}
