Return-Path: <linux-kernel-owner+w=401wt.eu-S965184AbWLUJqJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965184AbWLUJqJ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 04:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965183AbWLUJqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 04:46:08 -0500
Received: from il.qumranet.com ([62.219.232.206]:50867 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965181AbWLUJqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 04:46:07 -0500
Subject: [PATCH 1/5] KVM: Use more traditional error handling in kvm_mmu_init()
From: Avi Kivity <avi@qumranet.com>
Date: Thu, 21 Dec 2006 09:46:04 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <458A57A4.9000807@qumranet.com>
In-Reply-To: <458A57A4.9000807@qumranet.com>
Message-Id: <20061221094604.AE498250048@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/mmu.c
===================================================================
--- linux-2.6.orig/drivers/kvm/mmu.c
+++ linux-2.6/drivers/kvm/mmu.c
@@ -647,14 +647,20 @@ int kvm_mmu_init(struct kvm_vcpu *vcpu)
 	ASSERT(!VALID_PAGE(vcpu->mmu.root_hpa));
 	ASSERT(list_empty(&vcpu->free_pages));
 
-	if ((r = alloc_mmu_pages(vcpu)))
-		return r;
+	r = alloc_mmu_pages(vcpu);
+	if (r)
+		goto out;
+
+	r = init_kvm_mmu(vcpu);
+	if (r)
+		goto out_free_pages;
 
-	if ((r = init_kvm_mmu(vcpu))) {
-		free_mmu_pages(vcpu);
-		return r;
-	}
 	return 0;
+
+out_free_pages:
+	free_mmu_pages(vcpu);
+out:
+	return r;
 }
 
 void kvm_mmu_destroy(struct kvm_vcpu *vcpu)
