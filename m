Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264019AbUFBUHL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264019AbUFBUHL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 16:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264012AbUFBUHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 16:07:11 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:13075 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S264019AbUFBUHC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 16:07:02 -0400
Date: Wed, 2 Jun 2004 21:06:51 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Andi Kleen <ak@suse.de>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] follow_page invalid pte_page
In-Reply-To: <Pine.LNX.4.44.0406022103500.27696-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0406022105420.27696-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The follow_page write-access case is relying on pte_page before checking
pfn_valid: rearrange that - and we don't need three struct page *pages.

(I notice mempolicy.c's verify_pages is also relying on pte_page, but
I'll leave that to Andi: maybe it ought to be failing on, or skipping
over, VM_IO or VM_RESERVED vmas?)

Signed-off-by: Hugh Dickins <hugh@veritas.com>

 mm/memory.c |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

--- 2.6.7-rc2/mm/memory.c	2004-05-30 11:36:39.000000000 +0100
+++ linux/mm/memory.c	2004-06-02 16:31:33.037399304 +0100
@@ -637,15 +637,11 @@ follow_page(struct mm_struct *mm, unsign
 	if (pte_present(pte)) {
 		if (write && !pte_write(pte))
 			goto out;
-		if (write && !pte_dirty(pte)) {
-			struct page *page = pte_page(pte);
-			if (!PageDirty(page))
-				set_page_dirty(page);
-		}
 		pfn = pte_pfn(pte);
 		if (pfn_valid(pfn)) {
-			struct page *page = pfn_to_page(pfn);
-			
+			page = pfn_to_page(pfn);
+			if (write && !pte_dirty(pte) && !PageDirty(page))
+				set_page_dirty(page);
 			mark_page_accessed(page);
 			return page;
 		}

