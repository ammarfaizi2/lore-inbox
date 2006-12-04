Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936979AbWLDO6u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936979AbWLDO6u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 09:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936973AbWLDO6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 09:58:07 -0500
Received: from il.qumranet.com ([62.219.232.206]:45114 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936969AbWLDO5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 09:57:37 -0500
Subject: [PATCH] KVM: mmu: honor global bit on huge pages
From: Avi Kivity <avi@qumranet.com>
Date: Mon, 04 Dec 2006 14:57:35 -0000
To: kvm-devel@lists.sourceforge.net
Cc: akpm@osdl.org, mingo@elte.hu, linux-kernel@vger.kernel.org
Message-Id: <20061204145735.89391A0016@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The kvm mmu attempts to cache global translations, however it misses on
global huge page translation (which is what most global pages are).

By caching global huge page translations, boot time of fc5 i386 on i386
is reduced from ~35 seconds to ~24 seconds.

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/paging_tmpl.h
===================================================================
--- linux-2.6.orig/drivers/kvm/paging_tmpl.h
+++ linux-2.6/drivers/kvm/paging_tmpl.h
@@ -105,7 +105,7 @@ static void FNAME(set_pde)(struct kvm_vc
 	if (PTTYPE == 32 && is_cpuid_PSE36())
 		gaddr |= (guest_pde & PT32_DIR_PSE36_MASK) <<
 			(32 - PT32_DIR_PSE36_SHIFT);
-	*shadow_pte = (guest_pde & PT_NON_PTE_COPY_MASK) |
+	*shadow_pte = (guest_pde & (PT_NON_PTE_COPY_MASK | PT_GLOBAL_MASK)) |
 		          ((guest_pde & PT_DIR_PAT_MASK) >>
 			            (PT_DIR_PAT_SHIFT - PT_PAT_SHIFT));
 	set_pte_common(vcpu, shadow_pte, gaddr,
