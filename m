Return-Path: <linux-kernel-owner+w=401wt.eu-S965010AbXADQQZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965010AbXADQQZ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 11:16:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965011AbXADQQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 11:16:25 -0500
Received: from il.qumranet.com ([62.219.232.206]:51734 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965010AbXADQQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 11:16:09 -0500
Subject: [PATCH 27/33] KVM: MMU: Treat user-mode faults as a hint that a page
	is no longer a page table
From: Avi Kivity <avi@qumranet.com>
Date: Thu, 04 Jan 2007 16:16:07 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <459D21DD.5090506@qumranet.com>
In-Reply-To: <459D21DD.5090506@qumranet.com>
Message-Id: <20070104161607.7DF5B250048@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/paging_tmpl.h
===================================================================
--- linux-2.6.orig/drivers/kvm/paging_tmpl.h
+++ linux-2.6/drivers/kvm/paging_tmpl.h
@@ -271,6 +271,7 @@ static int FNAME(fix_write_pf)(struct kv
 	pt_element_t *guest_ent;
 	int writable_shadow;
 	gfn_t gfn;
+	struct kvm_mmu_page *page;
 
 	if (is_writeble_pte(*shadow_ent))
 		return 0;
@@ -303,7 +304,17 @@ static int FNAME(fix_write_pf)(struct kv
 	}
 
 	gfn = walker->gfn;
-	if (kvm_mmu_lookup_page(vcpu, gfn)) {
+
+	if (user) {
+		/*
+		 * Usermode page faults won't be for page table updates.
+		 */
+		while ((page = kvm_mmu_lookup_page(vcpu, gfn)) != NULL) {
+			pgprintk("%s: zap %lx %x\n",
+				 __FUNCTION__, gfn, page->role.word);
+			kvm_mmu_zap_page(vcpu, page);
+		}
+	} else if (kvm_mmu_lookup_page(vcpu, gfn)) {
 		pgprintk("%s: found shadow page for %lx, marking ro\n",
 			 __FUNCTION__, gfn);
 		*write_pt = 1;
