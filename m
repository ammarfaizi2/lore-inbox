Return-Path: <linux-kernel-owner+w=401wt.eu-S964996AbXADQNK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964996AbXADQNK (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 11:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964933AbXADQNK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 11:13:10 -0500
Received: from il.qumranet.com ([62.219.232.206]:49223 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964996AbXADQNJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 11:13:09 -0500
Subject: [PATCH 24/33] KVM: MMU: Page table write flood protection
From: Avi Kivity <avi@qumranet.com>
Date: Thu, 04 Jan 2007 16:13:07 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <459D21DD.5090506@qumranet.com>
In-Reply-To: <459D21DD.5090506@qumranet.com>
Message-Id: <20070104161307.569E5250048@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In fork() (or when we protect a page that is no longer a page table), we can
experience floods of writes to a page, which have to be emulated.  This is
expensive.

So, if we detect such a flood, zap the page so subsequent writes can proceed
natively.

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/mmu.c
===================================================================
--- linux-2.6.orig/drivers/kvm/mmu.c
+++ linux-2.6/drivers/kvm/mmu.c
@@ -969,8 +969,17 @@ void kvm_mmu_pre_write(struct kvm_vcpu *
 	unsigned page_offset;
 	unsigned misaligned;
 	int level;
+	int flooded = 0;
 
 	pgprintk("%s: gpa %llx bytes %d\n", __FUNCTION__, gpa, bytes);
+	if (gfn == vcpu->last_pt_write_gfn) {
+		++vcpu->last_pt_write_count;
+		if (vcpu->last_pt_write_count >= 3)
+			flooded = 1;
+	} else {
+		vcpu->last_pt_write_gfn = gfn;
+		vcpu->last_pt_write_count = 1;
+	}
 	index = kvm_page_table_hashfn(gfn) % KVM_NUM_MMU_PAGES;
 	bucket = &vcpu->kvm->mmu_page_hash[index];
 	hlist_for_each_entry_safe(page, node, n, bucket, hash_link) {
@@ -978,11 +987,16 @@ void kvm_mmu_pre_write(struct kvm_vcpu *
 			continue;
 		pte_size = page->role.glevels == PT32_ROOT_LEVEL ? 4 : 8;
 		misaligned = (offset ^ (offset + bytes - 1)) & ~(pte_size - 1);
-		if (misaligned) {
+		if (misaligned || flooded) {
 			/*
 			 * Misaligned accesses are too much trouble to fix
 			 * up; also, they usually indicate a page is not used
 			 * as a page table.
+			 *
+			 * If we're seeing too many writes to a page,
+			 * it may no longer be a page table, or we may be
+			 * forking, in which case it is better to unmap the
+			 * page.
 			 */
 			pgprintk("misaligned: gpa %llx bytes %d role %x\n",
 				 gpa, bytes, page->role.word);
Index: linux-2.6/drivers/kvm/kvm.h
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm.h
+++ linux-2.6/drivers/kvm/kvm.h
@@ -238,6 +238,9 @@ struct kvm_vcpu {
 	struct kvm_mmu_page page_header_buf[KVM_NUM_MMU_PAGES];
 	struct kvm_mmu mmu;
 
+	gfn_t last_pt_write_gfn;
+	int   last_pt_write_count;
+
 	struct kvm_guest_debug guest_debug;
 
 	char fx_buf[FX_BUF_SIZE];
