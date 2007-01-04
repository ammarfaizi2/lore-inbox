Return-Path: <linux-kernel-owner+w=401wt.eu-S964938AbXADQJL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964938AbXADQJL (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 11:09:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964980AbXADQJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 11:09:11 -0500
Received: from il.qumranet.com ([62.219.232.206]:47319 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964938AbXADQJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 11:09:10 -0500
Subject: [PATCH 20/33] KVM: MMU: Handle misaligned accesses to write protected
	guest page tables
From: Avi Kivity <avi@qumranet.com>
Date: Thu, 04 Jan 2007 16:09:07 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <459D21DD.5090506@qumranet.com>
In-Reply-To: <459D21DD.5090506@qumranet.com>
Message-Id: <20070104160907.2F843250048@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A misaligned access affects two shadow ptes instead of just one.

Since a misaligned access is unlikely to occur on a real page table, just
zap the page out of existence, avoiding further trouble.

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/mmu.c
===================================================================
--- linux-2.6.orig/drivers/kvm/mmu.c
+++ linux-2.6/drivers/kvm/mmu.c
@@ -954,21 +954,36 @@ void kvm_mmu_pre_write(struct kvm_vcpu *
 	gfn_t gfn = gpa >> PAGE_SHIFT;
 	struct kvm_mmu_page *page;
 	struct kvm_mmu_page *child;
-	struct hlist_node *node;
+	struct hlist_node *node, *n;
 	struct hlist_head *bucket;
 	unsigned index;
 	u64 *spte;
 	u64 pte;
 	unsigned offset = offset_in_page(gpa);
+	unsigned pte_size;
 	unsigned page_offset;
+	unsigned misaligned;
 	int level;
 
 	pgprintk("%s: gpa %llx bytes %d\n", __FUNCTION__, gpa, bytes);
 	index = kvm_page_table_hashfn(gfn) % KVM_NUM_MMU_PAGES;
 	bucket = &vcpu->kvm->mmu_page_hash[index];
-	hlist_for_each_entry(page, node, bucket, hash_link) {
+	hlist_for_each_entry_safe(page, node, n, bucket, hash_link) {
 		if (page->gfn != gfn || page->role.metaphysical)
 			continue;
+		pte_size = page->role.glevels == PT32_ROOT_LEVEL ? 4 : 8;
+		misaligned = (offset ^ (offset + bytes - 1)) & ~(pte_size - 1);
+		if (misaligned) {
+			/*
+			 * Misaligned accesses are too much trouble to fix
+			 * up; also, they usually indicate a page is not used
+			 * as a page table.
+			 */
+			pgprintk("misaligned: gpa %llx bytes %d role %x\n",
+				 gpa, bytes, page->role.word);
+			kvm_mmu_zap_page(vcpu, page);
+			continue;
+		}
 		page_offset = offset;
 		level = page->role.level;
 		if (page->role.glevels == PT32_ROOT_LEVEL) {
