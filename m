Return-Path: <linux-kernel-owner+w=401wt.eu-S964896AbXADP5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964896AbXADP5O (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 10:57:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964950AbXADP5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 10:57:13 -0500
Received: from il.qumranet.com ([62.219.232.206]:46527 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964896AbXADP5J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 10:57:09 -0500
Subject: [PATCH 8/33] KVM: MMU: Make kvm_mmu_alloc_page() return a
	kvm_mmu_page pointer
From: Avi Kivity <avi@qumranet.com>
Date: Thu, 04 Jan 2007 15:57:06 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <459D21DD.5090506@qumranet.com>
In-Reply-To: <459D21DD.5090506@qumranet.com>
Message-Id: <20070104155706.56A34250048@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This allows further manipulation on the shadow page table.

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/mmu.c
===================================================================
--- linux-2.6.orig/drivers/kvm/mmu.c
+++ linux-2.6/drivers/kvm/mmu.c
@@ -292,12 +292,13 @@ static int is_empty_shadow_page(hpa_t pa
 	return 1;
 }
 
-static hpa_t kvm_mmu_alloc_page(struct kvm_vcpu *vcpu, u64 *parent_pte)
+static struct kvm_mmu_page *kvm_mmu_alloc_page(struct kvm_vcpu *vcpu,
+					       u64 *parent_pte)
 {
 	struct kvm_mmu_page *page;
 
 	if (list_empty(&vcpu->free_pages))
-		return INVALID_PAGE;
+		return NULL;
 
 	page = list_entry(vcpu->free_pages.next, struct kvm_mmu_page, link);
 	list_del(&page->link);
@@ -306,7 +307,7 @@ static hpa_t kvm_mmu_alloc_page(struct k
 	page->slot_bitmap = 0;
 	page->global = 1;
 	page->parent_pte = parent_pte;
-	return page->page_hpa;
+	return page;
 }
 
 static void page_header_update_slot(struct kvm *kvm, void *pte, gpa_t gpa)
@@ -402,19 +403,16 @@ static int nonpaging_map(struct kvm_vcpu
 		}
 
 		if (table[index] == 0) {
-			hpa_t new_table = kvm_mmu_alloc_page(vcpu,
-							     &table[index]);
+			struct kvm_mmu_page *new_table;
 
-			if (!VALID_PAGE(new_table)) {
+			new_table = kvm_mmu_alloc_page(vcpu, &table[index]);
+			if (!new_table) {
 				pgprintk("nonpaging_map: ENOMEM\n");
 				return -ENOMEM;
 			}
 
-			if (level == PT32E_ROOT_LEVEL)
-				table[index] = new_table | PT_PRESENT_MASK;
-			else
-				table[index] = new_table | PT_PRESENT_MASK |
-						PT_WRITABLE_MASK | PT_USER_MASK;
+			table[index] = new_table->page_hpa | PT_PRESENT_MASK
+				| PT_WRITABLE_MASK | PT_USER_MASK;
 		}
 		table_addr = table[index] & PT64_BASE_ADDR_MASK;
 	}
@@ -454,7 +452,7 @@ static void mmu_alloc_roots(struct kvm_v
 		hpa_t root = vcpu->mmu.root_hpa;
 
 		ASSERT(!VALID_PAGE(root));
-		root = kvm_mmu_alloc_page(vcpu, NULL);
+		root = kvm_mmu_alloc_page(vcpu, NULL)->page_hpa;
 		vcpu->mmu.root_hpa = root;
 		return;
 	}
@@ -463,7 +461,7 @@ static void mmu_alloc_roots(struct kvm_v
 		hpa_t root = vcpu->mmu.pae_root[i];
 
 		ASSERT(!VALID_PAGE(root));
-		root = kvm_mmu_alloc_page(vcpu, NULL);
+		root = kvm_mmu_alloc_page(vcpu, NULL)->page_hpa;
 		vcpu->mmu.pae_root[i] = root | PT_PRESENT_MASK;
 	}
 	vcpu->mmu.root_hpa = __pa(vcpu->mmu.pae_root);
Index: linux-2.6/drivers/kvm/paging_tmpl.h
===================================================================
--- linux-2.6.orig/drivers/kvm/paging_tmpl.h
+++ linux-2.6/drivers/kvm/paging_tmpl.h
@@ -179,6 +179,7 @@ static u64 *FNAME(fetch)(struct kvm_vcpu
 	for (; ; level--) {
 		u32 index = SHADOW_PT_INDEX(addr, level);
 		u64 *shadow_ent = ((u64 *)__va(shadow_addr)) + index;
+		struct kvm_mmu_page *shadow_page;
 		u64 shadow_pte;
 
 		if (is_present_pte(*shadow_ent) || is_io_pte(*shadow_ent)) {
@@ -204,9 +205,10 @@ static u64 *FNAME(fetch)(struct kvm_vcpu
 			return shadow_ent;
 		}
 
-		shadow_addr = kvm_mmu_alloc_page(vcpu, shadow_ent);
-		if (!VALID_PAGE(shadow_addr))
+		shadow_page = kvm_mmu_alloc_page(vcpu, shadow_ent);
+		if (!shadow_page)
 			return ERR_PTR(-ENOMEM);
+		shadow_addr = shadow_page->page_hpa;
 		shadow_pte = shadow_addr | PT_PRESENT_MASK | PT_ACCESSED_MASK
 			| PT_WRITABLE_MASK | PT_USER_MASK;
 		*shadow_ent = shadow_pte;
