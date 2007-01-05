Return-Path: <linux-kernel-owner+w=401wt.eu-S1161009AbXAEHzr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161009AbXAEHzr (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 02:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161018AbXAEHzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 02:55:47 -0500
Received: from il.qumranet.com ([62.219.232.206]:39630 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161009AbXAEHzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 02:55:46 -0500
Subject: [PATCH 6/9] KVM: MMU: Add missing dirty bit
From: Avi Kivity <avi@qumranet.com>
Date: Fri, 05 Jan 2007 07:55:45 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <459E02E7.5020407@qumranet.com>
In-Reply-To: <459E02E7.5020407@qumranet.com>
Message-Id: <20070105075545.83E2F250048@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If we emulate a write, we fail to set the dirty bit on the guest pte, leading
the guest to believe the page is clean, and thus lose data.  Bad.

Fix by setting the guest pte dirty bit under such conditions.

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/paging_tmpl.h
===================================================================
--- linux-2.6.orig/drivers/kvm/paging_tmpl.h
+++ linux-2.6/drivers/kvm/paging_tmpl.h
@@ -317,6 +317,7 @@ static int FNAME(fix_write_pf)(struct kv
 	} else if (kvm_mmu_lookup_page(vcpu, gfn)) {
 		pgprintk("%s: found shadow page for %lx, marking ro\n",
 			 __FUNCTION__, gfn);
+		*guest_ent |= PT_DIRTY_MASK;
 		*write_pt = 1;
 		return 0;
 	}
