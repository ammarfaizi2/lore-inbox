Return-Path: <linux-kernel-owner+w=401wt.eu-S964998AbXADQOK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964998AbXADQOK (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 11:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964933AbXADQOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 11:14:10 -0500
Received: from il.qumranet.com ([62.219.232.206]:49228 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964998AbXADQOJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 11:14:09 -0500
Subject: [PATCH 25/33] KVM: MMU: Never free a shadow page actively serving as
	a root
From: Avi Kivity <avi@qumranet.com>
Date: Thu, 04 Jan 2007 16:14:07 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <459D21DD.5090506@qumranet.com>
In-Reply-To: <459D21DD.5090506@qumranet.com>
Message-Id: <20070104161407.6383B250048@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We always need cr3 to point to something valid, so if we detect that we're
freeing a root page, simply push it back to the top of the active list.

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/mmu.c
===================================================================
--- linux-2.6.orig/drivers/kvm/mmu.c
+++ linux-2.6/drivers/kvm/mmu.c
@@ -550,8 +550,13 @@ static void kvm_mmu_zap_page(struct kvm_
 		*parent_pte = 0;
 	}
 	kvm_mmu_page_unlink_children(vcpu, page);
-	hlist_del(&page->hash_link);
-	kvm_mmu_free_page(vcpu, page->page_hpa);
+	if (!page->root_count) {
+		hlist_del(&page->hash_link);
+		kvm_mmu_free_page(vcpu, page->page_hpa);
+	} else {
+		list_del(&page->link);
+		list_add(&page->link, &vcpu->kvm->active_mmu_pages);
+	}
 }
 
 static int kvm_mmu_unprotect_page(struct kvm_vcpu *vcpu, gfn_t gfn)
@@ -667,12 +672,15 @@ static int nonpaging_map(struct kvm_vcpu
 static void mmu_free_roots(struct kvm_vcpu *vcpu)
 {
 	int i;
+	struct kvm_mmu_page *page;
 
 #ifdef CONFIG_X86_64
 	if (vcpu->mmu.shadow_root_level == PT64_ROOT_LEVEL) {
 		hpa_t root = vcpu->mmu.root_hpa;
 
 		ASSERT(VALID_PAGE(root));
+		page = page_header(root);
+		--page->root_count;
 		vcpu->mmu.root_hpa = INVALID_PAGE;
 		return;
 	}
@@ -682,6 +690,8 @@ static void mmu_free_roots(struct kvm_vc
 
 		ASSERT(VALID_PAGE(root));
 		root &= PT64_BASE_ADDR_MASK;
+		page = page_header(root);
+		--page->root_count;
 		vcpu->mmu.pae_root[i] = INVALID_PAGE;
 	}
 	vcpu->mmu.root_hpa = INVALID_PAGE;
@@ -691,6 +701,8 @@ static void mmu_alloc_roots(struct kvm_v
 {
 	int i;
 	gfn_t root_gfn;
+	struct kvm_mmu_page *page;
+
 	root_gfn = vcpu->cr3 >> PAGE_SHIFT;
 
 #ifdef CONFIG_X86_64
@@ -700,6 +712,8 @@ static void mmu_alloc_roots(struct kvm_v
 		ASSERT(!VALID_PAGE(root));
 		root = kvm_mmu_get_page(vcpu, root_gfn, 0,
 					PT64_ROOT_LEVEL, 0, NULL)->page_hpa;
+		page = page_header(root);
+		++page->root_count;
 		vcpu->mmu.root_hpa = root;
 		return;
 	}
@@ -715,6 +729,8 @@ static void mmu_alloc_roots(struct kvm_v
 		root = kvm_mmu_get_page(vcpu, root_gfn, i << 30,
 					PT32_ROOT_LEVEL, !is_paging(vcpu),
 					NULL)->page_hpa;
+		page = page_header(root);
+		++page->root_count;
 		vcpu->mmu.pae_root[i] = root | PT_PRESENT_MASK;
 	}
 	vcpu->mmu.root_hpa = __pa(vcpu->mmu.pae_root);
Index: linux-2.6/drivers/kvm/kvm.h
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm.h
+++ linux-2.6/drivers/kvm/kvm.h
@@ -134,6 +134,7 @@ struct kvm_mmu_page {
 				    */
 	int global;              /* Set if all ptes in this page are global */
 	int multimapped;         /* More than one parent_pte? */
+	int root_count;          /* Currently serving as active root */
 	union {
 		u64 *parent_pte;               /* !multimapped */
 		struct hlist_head parent_ptes; /* multimapped, kvm_pte_chain */
