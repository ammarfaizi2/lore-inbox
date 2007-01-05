Return-Path: <linux-kernel-owner+w=401wt.eu-S1161007AbXAEHxB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161007AbXAEHxB (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 02:53:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161006AbXAEHxB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 02:53:01 -0500
Received: from il.qumranet.com ([62.219.232.206]:39615 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161007AbXAEHxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 02:53:00 -0500
Subject: [PATCH 3/9] KVM: Avoid oom on cr3 switch
From: Avi Kivity <avi@qumranet.com>
Date: Fri, 05 Jan 2007 07:52:45 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <459E02E7.5020407@qumranet.com>
In-Reply-To: <459E02E7.5020407@qumranet.com>
Message-Id: <20070105075245.49930250048@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/mmu.c
===================================================================
--- linux-2.6.orig/drivers/kvm/mmu.c
+++ linux-2.6/drivers/kvm/mmu.c
@@ -905,6 +905,8 @@ static void paging_new_cr3(struct kvm_vc
 {
 	pgprintk("%s: cr3 %lx\n", __FUNCTION__, vcpu->cr3);
 	mmu_free_roots(vcpu);
+	if (unlikely(vcpu->kvm->n_free_mmu_pages < KVM_MIN_FREE_MMU_PAGES))
+		kvm_mmu_free_some_pages(vcpu);
 	mmu_alloc_roots(vcpu);
 	kvm_mmu_flush_tlb(vcpu);
 	kvm_arch_ops->set_cr3(vcpu, vcpu->mmu.root_hpa);
