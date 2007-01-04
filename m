Return-Path: <linux-kernel-owner+w=401wt.eu-S964940AbXADP4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964940AbXADP4J (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 10:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964935AbXADP4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 10:56:08 -0500
Received: from il.qumranet.com ([62.219.232.206]:46523 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964937AbXADP4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 10:56:07 -0500
Subject: [PATCH 7/33] KVM: MMU: Make the shadow page tables also special-case
	pae
From: Avi Kivity <avi@qumranet.com>
Date: Thu, 04 Jan 2007 15:56:06 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <459D21DD.5090506@qumranet.com>
In-Reply-To: <459D21DD.5090506@qumranet.com>
Message-Id: <20070104155606.49BCF250048@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/paging_tmpl.h
===================================================================
--- linux-2.6.orig/drivers/kvm/paging_tmpl.h
+++ linux-2.6/drivers/kvm/paging_tmpl.h
@@ -170,6 +170,11 @@ static u64 *FNAME(fetch)(struct kvm_vcpu
 
 	shadow_addr = vcpu->mmu.root_hpa;
 	level = vcpu->mmu.shadow_root_level;
+	if (level == PT32E_ROOT_LEVEL) {
+		shadow_addr = vcpu->mmu.pae_root[(addr >> 30) & 3];
+		shadow_addr &= PT64_BASE_ADDR_MASK;
+		--level;
+	}
 
 	for (; ; level--) {
 		u32 index = SHADOW_PT_INDEX(addr, level);
@@ -202,10 +207,8 @@ static u64 *FNAME(fetch)(struct kvm_vcpu
 		shadow_addr = kvm_mmu_alloc_page(vcpu, shadow_ent);
 		if (!VALID_PAGE(shadow_addr))
 			return ERR_PTR(-ENOMEM);
-		shadow_pte = shadow_addr | PT_PRESENT_MASK;
-		if (vcpu->mmu.root_level > 3 || level != 3)
-			shadow_pte |= PT_ACCESSED_MASK
-				| PT_WRITABLE_MASK | PT_USER_MASK;
+		shadow_pte = shadow_addr | PT_PRESENT_MASK | PT_ACCESSED_MASK
+			| PT_WRITABLE_MASK | PT_USER_MASK;
 		*shadow_ent = shadow_pte;
 		prev_shadow_ent = shadow_ent;
 	}
