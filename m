Return-Path: <linux-kernel-owner+w=401wt.eu-S1030246AbXAKKHc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030246AbXAKKHc (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 05:07:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030243AbXAKKHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 05:07:32 -0500
Received: from il.qumranet.com ([62.219.232.206]:44587 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030246AbXAKKHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 05:07:31 -0500
Subject: [PATCH 5/5] KVM: Fix bogus pagefault on writable pages
From: Avi Kivity <avi@qumranet.com>
Date: Thu, 11 Jan 2007 10:07:30 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <45A60B2F.6090901@qumranet.com>
In-Reply-To: <45A60B2F.6090901@qumranet.com>
Message-Id: <20070111100730.6B6C1250595@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If a page is marked as dirty in the guest pte, set_pte_common() can set the
writable bit on newly-instantiated shadow pte.  This optimization avoids
a write fault after the initial read fault.

However, if a write fault instantiates the pte, fix_write_pf() incorrectly
reports the fault as a guest page fault, and the guest oopses on what appears
to be a correctly-mapped page.

Fix is to detect the condition and only report a guest page fault on a user
access to a kernel page.

With the fix, a kvm guest can survive a whole night of running the kernel
hacker's screensaver (make -j9 in a loop).

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/paging_tmpl.h
===================================================================
--- linux-2.6.orig/drivers/kvm/paging_tmpl.h
+++ linux-2.6/drivers/kvm/paging_tmpl.h
@@ -274,7 +274,7 @@ static int FNAME(fix_write_pf)(struct kv
 	struct kvm_mmu_page *page;
 
 	if (is_writeble_pte(*shadow_ent))
-		return 0;
+		return !user || (*shadow_ent & PT_USER_MASK);
 
 	writable_shadow = *shadow_ent & PT_SHADOW_WRITABLE_MASK;
 	if (user) {
