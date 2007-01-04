Return-Path: <linux-kernel-owner+w=401wt.eu-S964969AbXADQFK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964969AbXADQFK (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 11:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964972AbXADQFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 11:05:10 -0500
Received: from il.qumranet.com ([62.219.232.206]:46939 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964969AbXADQFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 11:05:09 -0500
Subject: [PATCH 16/33] KVM: MMU: kvm_mmu_put_page() only removes one link to
	the page
From: Avi Kivity <avi@qumranet.com>
Date: Thu, 04 Jan 2007 16:05:06 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <459D21DD.5090506@qumranet.com>
In-Reply-To: <459D21DD.5090506@qumranet.com>
Message-Id: <20070104160506.F256E250048@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

... and so must not free it unconditionally.

Move the freeing to kvm_mmu_zap_page().

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/mmu.c
===================================================================
--- linux-2.6.orig/drivers/kvm/mmu.c
+++ linux-2.6/drivers/kvm/mmu.c
@@ -521,10 +521,6 @@ static void kvm_mmu_put_page(struct kvm_
 			     u64 *parent_pte)
 {
 	mmu_page_remove_parent_pte(page, parent_pte);
-	kvm_mmu_page_unlink_children(vcpu, page);
-	hlist_del(&page->hash_link);
-	list_del(&page->link);
-	list_add(&page->link, &vcpu->free_pages);
 }
 
 static void kvm_mmu_zap_page(struct kvm_vcpu *vcpu,
@@ -546,6 +542,10 @@ static void kvm_mmu_zap_page(struct kvm_
 		kvm_mmu_put_page(vcpu, page, parent_pte);
 		*parent_pte = 0;
 	}
+	kvm_mmu_page_unlink_children(vcpu, page);
+	hlist_del(&page->hash_link);
+	list_del(&page->link);
+	list_add(&page->link, &vcpu->free_pages);
 }
 
 static int kvm_mmu_unprotect_page(struct kvm_vcpu *vcpu, gfn_t gfn)
