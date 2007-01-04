Return-Path: <linux-kernel-owner+w=401wt.eu-S964935AbXADQCJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964935AbXADQCJ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 11:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964965AbXADQCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 11:02:09 -0500
Received: from il.qumranet.com ([62.219.232.206]:46925 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964935AbXADQCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 11:02:08 -0500
Subject: [PATCH 13/33] KVM: MMU: Zap shadow page table entries on writes to
	guest page tables
From: Avi Kivity <avi@qumranet.com>
Date: Thu, 04 Jan 2007 16:02:06 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <459D21DD.5090506@qumranet.com>
In-Reply-To: <459D21DD.5090506@qumranet.com>
Message-Id: <20070104160206.A1BDB250048@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Iterate over all shadow pages which correspond to a the given guest page table
and remove the mappings.

A subsequent page fault will reestablish the new mapping.

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/mmu.c
===================================================================
--- linux-2.6.orig/drivers/kvm/mmu.c
+++ linux-2.6/drivers/kvm/mmu.c
@@ -958,7 +958,43 @@ int kvm_mmu_reset_context(struct kvm_vcp
 
 void kvm_mmu_pre_write(struct kvm_vcpu *vcpu, gpa_t gpa, int bytes)
 {
+	gfn_t gfn = gpa >> PAGE_SHIFT;
+	struct kvm_mmu_page *page;
+	struct kvm_mmu_page *child;
+	struct hlist_node *node;
+	struct hlist_head *bucket;
+	unsigned index;
+	u64 *spte;
+	u64 pte;
+	unsigned offset = offset_in_page(gpa);
+	unsigned page_offset;
+	int level;
+
 	pgprintk("%s: gpa %llx bytes %d\n", __FUNCTION__, gpa, bytes);
+	index = kvm_page_table_hashfn(gfn) % KVM_NUM_MMU_PAGES;
+	bucket = &vcpu->kvm->mmu_page_hash[index];
+	hlist_for_each_entry(page, node, bucket, hash_link) {
+		if (page->gfn != gfn || page->role.metaphysical)
+			continue;
+		page_offset = offset;
+		level = page->role.level;
+		if (page->role.glevels == PT32_ROOT_LEVEL) {
+			page_offset <<= 1;          /* 32->64 */
+			page_offset &= ~PAGE_MASK;
+		}
+		spte = __va(page->page_hpa);
+		spte += page_offset / sizeof(*spte);
+		pte = *spte;
+		if (is_present_pte(pte)) {
+			if (level == PT_PAGE_TABLE_LEVEL)
+				rmap_remove(vcpu->kvm, spte);
+			else {
+				child = page_header(pte & PT64_BASE_ADDR_MASK);
+				mmu_page_remove_parent_pte(child, spte);
+			}
+		}
+		*spte = 0;
+	}
 }
 
 void kvm_mmu_post_write(struct kvm_vcpu *vcpu, gpa_t gpa, int bytes)
