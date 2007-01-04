Return-Path: <linux-kernel-owner+w=401wt.eu-S964963AbXADQDK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964963AbXADQDK (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 11:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964972AbXADQDJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 11:03:09 -0500
Received: from il.qumranet.com ([62.219.232.206]:46931 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964963AbXADQDI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 11:03:08 -0500
Subject: [PATCH 14/33] KVM: MMU: If emulating an instruction fails,
	try unprotecting the page
From: Avi Kivity <avi@qumranet.com>
Date: Thu, 04 Jan 2007 16:03:06 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <459D21DD.5090506@qumranet.com>
In-Reply-To: <459D21DD.5090506@qumranet.com>
Message-Id: <20070104160306.AE16D250048@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A page table may have been recycled into a regular page, and so any
instruction can be executed on it.  Unprotect the page and let the cpu
do its thing.

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/mmu.c
===================================================================
--- linux-2.6.orig/drivers/kvm/mmu.c
+++ linux-2.6/drivers/kvm/mmu.c
@@ -478,11 +478,62 @@ static struct kvm_mmu_page *kvm_mmu_get_
 	return page;
 }
 
+static void kvm_mmu_page_unlink_children(struct kvm_vcpu *vcpu,
+					 struct kvm_mmu_page *page)
+{
+	BUG();
+}
+
 static void kvm_mmu_put_page(struct kvm_vcpu *vcpu,
 			     struct kvm_mmu_page *page,
 			     u64 *parent_pte)
 {
 	mmu_page_remove_parent_pte(page, parent_pte);
+	if (page->role.level > PT_PAGE_TABLE_LEVEL)
+		kvm_mmu_page_unlink_children(vcpu, page);
+	hlist_del(&page->hash_link);
+	list_del(&page->link);
+	list_add(&page->link, &vcpu->free_pages);
+}
+
+static void kvm_mmu_zap_page(struct kvm_vcpu *vcpu,
+			     struct kvm_mmu_page *page)
+{
+	u64 *parent_pte;
+
+	while (page->multimapped || page->parent_pte) {
+		if (!page->multimapped)
+			parent_pte = page->parent_pte;
+		else {
+			struct kvm_pte_chain *chain;
+
+			chain = container_of(page->parent_ptes.first,
+					     struct kvm_pte_chain, link);
+			parent_pte = chain->parent_ptes[0];
+		}
+		kvm_mmu_put_page(vcpu, page, parent_pte);
+		*parent_pte = 0;
+	}
+}
+
+static int kvm_mmu_unprotect_page(struct kvm_vcpu *vcpu, gfn_t gfn)
+{
+	unsigned index;
+	struct hlist_head *bucket;
+	struct kvm_mmu_page *page;
+	struct hlist_node *node, *n;
+	int r;
+
+	pgprintk("%s: looking for gfn %lx\n", __FUNCTION__, gfn);
+	r = 0;
+	index = kvm_page_table_hashfn(gfn) % KVM_NUM_MMU_PAGES;
+	bucket = &vcpu->kvm->mmu_page_hash[index];
+	hlist_for_each_entry_safe(page, node, n, bucket, hash_link)
+		if (page->gfn == gfn && !page->role.metaphysical) {
+			kvm_mmu_zap_page(vcpu, page);
+			r = 1;
+		}
+	return r;
 }
 
 static void page_header_update_slot(struct kvm *kvm, void *pte, gpa_t gpa)
@@ -1001,6 +1052,13 @@ void kvm_mmu_post_write(struct kvm_vcpu 
 {
 }
 
+int kvm_mmu_unprotect_page_virt(struct kvm_vcpu *vcpu, gva_t gva)
+{
+	gpa_t gpa = vcpu->mmu.gva_to_gpa(vcpu, gva);
+
+	return kvm_mmu_unprotect_page(vcpu, gpa >> PAGE_SHIFT);
+}
+
 static void free_mmu_pages(struct kvm_vcpu *vcpu)
 {
 	while (!list_empty(&vcpu->free_pages)) {
Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -1063,6 +1063,8 @@ int emulate_instruction(struct kvm_vcpu 
 	}
 
 	if (r) {
+		if (kvm_mmu_unprotect_page_virt(vcpu, cr2))
+			return EMULATE_DONE;
 		if (!vcpu->mmio_needed) {
 			report_emulation_failure(&emulate_ctxt);
 			return EMULATE_FAIL;
Index: linux-2.6/drivers/kvm/kvm.h
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm.h
+++ linux-2.6/drivers/kvm/kvm.h
@@ -450,6 +450,7 @@ unsigned long segment_base(u16 selector)
 
 void kvm_mmu_pre_write(struct kvm_vcpu *vcpu, gpa_t gpa, int bytes);
 void kvm_mmu_post_write(struct kvm_vcpu *vcpu, gpa_t gpa, int bytes);
+int kvm_mmu_unprotect_page_virt(struct kvm_vcpu *vcpu, gva_t gva);
 
 static inline struct page *_gfn_to_page(struct kvm *kvm, gfn_t gfn)
 {
