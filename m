Return-Path: <linux-kernel-owner+w=401wt.eu-S965011AbXADQRL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965011AbXADQRL (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 11:17:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965015AbXADQRK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 11:17:10 -0500
Received: from il.qumranet.com ([62.219.232.206]:51740 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965011AbXADQRJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 11:17:09 -0500
Subject: [PATCH 28/33] KVM: MMU: Free pages on kvm destruction
From: Avi Kivity <avi@qumranet.com>
Date: Thu, 04 Jan 2007 16:17:07 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <459D21DD.5090506@qumranet.com>
In-Reply-To: <459D21DD.5090506@qumranet.com>
Message-Id: <20070104161707.89F1B250048@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Because mmu pages have attached rmap and parent pte chain structures, we need
to zap them before freeing so the attached structures are freed.

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/mmu.c
===================================================================
--- linux-2.6.orig/drivers/kvm/mmu.c
+++ linux-2.6/drivers/kvm/mmu.c
@@ -1065,9 +1065,14 @@ EXPORT_SYMBOL_GPL(kvm_mmu_free_some_page
 
 static void free_mmu_pages(struct kvm_vcpu *vcpu)
 {
-	while (!list_empty(&vcpu->free_pages)) {
-		struct kvm_mmu_page *page;
+	struct kvm_mmu_page *page;
 
+	while (!list_empty(&vcpu->kvm->active_mmu_pages)) {
+		page = container_of(vcpu->kvm->active_mmu_pages.next,
+				    struct kvm_mmu_page, link);
+		kvm_mmu_zap_page(vcpu, page);
+	}
+	while (!list_empty(&vcpu->free_pages)) {
 		page = list_entry(vcpu->free_pages.next,
 				  struct kvm_mmu_page, link);
 		list_del(&page->link);
