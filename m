Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932162AbVIXKbO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbVIXKbO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 06:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbVIXKbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 06:31:14 -0400
Received: from silver.veritas.com ([143.127.12.111]:94 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S932162AbVIXKbN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 06:31:13 -0400
Date: Sat, 24 Sep 2005 11:30:43 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
Subject: [PATCH] mremap move ZERO_PAGE fix
Message-ID: <Pine.LNX.4.61.0509241127420.11579@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 24 Sep 2005 10:31:09.0041 (UTC) FILETIME=[13B91610:01C5C0F3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix nasty little bug we've missed in Nick's mremap move ZERO_PAGE patch.
The "pte" at that point may be a swap entry or a pte_file entry: we must
check pte_present before perhaps corrupting such an entry.

Patch below against 2.6.14-rc2-mm1, but the same bug is in 2.6.14-rc2's
mm/mremap.c, and more dangerous there since it's affecting all arches:
I think the safest course is to send Nick's patch and Yoichi's build fix
and this fix (build tested) on to Linus - so only MIPS can be affected.

Signed-off-by: Hugh Dickins <hugh@veritas.com>

--- 2.6.14-rc2-mm1/include/asm-generic/pgtable.h	2005-09-22 12:32:00.000000000 +0100
+++ linux/include/asm-generic/pgtable.h	2005-09-24 10:51:41.000000000 +0100
@@ -164,7 +164,8 @@ static inline void ptep_set_wrprotect(st
 #define move_pte(pte, prot, old_addr, new_addr)				\
 ({									\
  	pte_t newpte = (pte);						\
-	if (pfn_valid(pte_pfn(pte)) && pte_page(pte) == ZERO_PAGE(old_addr)) \
+	if (pte_present(pte) && pfn_valid(pte_pfn(pte)) &&		\
+			pte_page(pte) == ZERO_PAGE(old_addr))		\
 		newpte = mk_pte(ZERO_PAGE(new_addr), (prot));		\
 	newpte;								\
 })
