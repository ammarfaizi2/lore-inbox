Return-Path: <linux-kernel-owner+w=401wt.eu-S1161017AbXAEH5s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161017AbXAEH5s (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 02:57:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161018AbXAEH5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 02:57:48 -0500
Received: from il.qumranet.com ([62.219.232.206]:53281 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161017AbXAEH5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 02:57:47 -0500
Subject: [PATCH 8/9] KVM: Simplify mmu_alloc_roots()
From: Avi Kivity <avi@qumranet.com>
Date: Fri, 05 Jan 2007 07:57:45 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <459E02E7.5020407@qumranet.com>
In-Reply-To: <459E02E7.5020407@qumranet.com>
Message-Id: <20070105075745.DF6C9250048@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

Small optimization/cleanup:

    page == page_header(page->page_hpa)

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/mmu.c
===================================================================
--- linux-2.6.orig/drivers/kvm/mmu.c
+++ linux-2.6/drivers/kvm/mmu.c
@@ -820,9 +820,9 @@ static void mmu_alloc_roots(struct kvm_v
 		hpa_t root = vcpu->mmu.root_hpa;
 
 		ASSERT(!VALID_PAGE(root));
-		root = kvm_mmu_get_page(vcpu, root_gfn, 0,
-					PT64_ROOT_LEVEL, 0, NULL)->page_hpa;
-		page = page_header(root);
+		page = kvm_mmu_get_page(vcpu, root_gfn, 0,
+					PT64_ROOT_LEVEL, 0, NULL);
+		root = page->page_hpa;
 		++page->root_count;
 		vcpu->mmu.root_hpa = root;
 		return;
@@ -836,10 +836,10 @@ static void mmu_alloc_roots(struct kvm_v
 			root_gfn = vcpu->pdptrs[i] >> PAGE_SHIFT;
 		else if (vcpu->mmu.root_level == 0)
 			root_gfn = 0;
-		root = kvm_mmu_get_page(vcpu, root_gfn, i << 30,
+		page = kvm_mmu_get_page(vcpu, root_gfn, i << 30,
 					PT32_ROOT_LEVEL, !is_paging(vcpu),
-					NULL)->page_hpa;
-		page = page_header(root);
+					NULL);
+		root = page->page_hpa;
 		++page->root_count;
 		vcpu->mmu.pae_root[i] = root | PT_PRESENT_MASK;
 	}
