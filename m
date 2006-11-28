Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933061AbWK1Mlv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933061AbWK1Mlv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 07:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933256AbWK1Mlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 07:41:51 -0500
Received: from il.qumranet.com ([62.219.232.206]:19910 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S933061AbWK1Mlu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 07:41:50 -0500
Subject: [PATCH 3/6] KVM: AMD SVM: Add missing tlb flushes to the guest mmu
From: Avi Kivity <avi@qumranet.com>
Date: Tue, 28 Nov 2006 12:41:49 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, yaniv.kamay@qumranet.com,
       mingo@elte.hu
References: <456C2D89.4050508@qumranet.com>
In-Reply-To: <456C2D89.4050508@qumranet.com>
Message-Id: <20061128124149.5F5D825015E@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a couple of missing mmu flushes.  The Intel tlb is too coarse to be
affected, but they are necessary for AMD.

Signed-off-by: Yaniv Kamay <yaniv@qumranet.com>
Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/mmu.c
===================================================================
--- linux-2.6.orig/drivers/kvm/mmu.c
+++ linux-2.6/drivers/kvm/mmu.c
@@ -324,6 +324,7 @@ static void nonpaging_flush(struct kvm_v
 	if (is_paging(vcpu))
 		root |= (vcpu->cr3 & (CR3_PCD_MASK | CR3_WPT_MASK));
 	kvm_arch_ops->set_cr3(vcpu, root);
+	kvm_arch_ops->flush_tlb(vcpu);
 }
 
 static gpa_t nonpaging_gva_to_gpa(struct kvm_vcpu *vcpu, gva_t vaddr)
@@ -407,6 +408,7 @@ static void kvm_mmu_flush_tlb(struct kvm
 		release_pt_page_64(vcpu, page->page_hpa, 1);
 	}
 	++kvm_stat.tlb_flush;
+	kvm_arch_ops->flush_tlb(vcpu);
 }
 
 static void paging_new_cr3(struct kvm_vcpu *vcpu)
