Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261677AbVFFUdP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261677AbVFFUdP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 16:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261664AbVFFUcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 16:32:43 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:42386 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261662AbVFFUCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 16:02:47 -0400
Date: Mon, 6 Jun 2005 21:03:23 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Abhijit Karmarkar <abhijitk@veritas.com>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] msync: check pte dirty earlier
Message-ID: <Pine.LNX.4.61.0506062100560.5000@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-OriginalArrivalTime: 06 Jun 2005 20:02:23.0520 (UTC) 
    FILETIME=[A7770A00:01C56AD2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abhijit Karmarkar <abhijitk@veritas.com>

It's common practice to msync a large address range regularly, in which
often only a few ptes have actually been dirtied since the previous pass.

sync_pte_range then goes much faster if it tests whether pte is dirty
before locating and accessing each struct page cacheline; and it is hardly
slowed by ptep_clear_flush_dirty repeating that test in the opposite case,
when every pte actually is dirty.

But beware, s390's pte_dirty always says false, since its dirty bit is
kept in the storage key, located via the struct page address.  So skip
this optimization in its case: use a pte_maybe_dirty macro which just
says true if page_test_and_clear_dirty is implemented.

Signed-off-by: Abhijit Karmarkar <abhijitk@veritas.com>
Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 include/asm-generic/pgtable.h |    3 +++
 mm/msync.c                    |    2 ++
 2 files changed, 5 insertions(+)

--- 2.6.12-rc6/include/asm-generic/pgtable.h	2005-05-25 18:09:09.000000000 +0100
+++ linux/include/asm-generic/pgtable.h	2005-06-04 20:41:55.000000000 +0100
@@ -125,6 +125,9 @@ static inline void ptep_set_wrprotect(st
 
 #ifndef __HAVE_ARCH_PAGE_TEST_AND_CLEAR_DIRTY
 #define page_test_and_clear_dirty(page) (0)
+#define pte_maybe_dirty(pte)		pte_dirty(pte)
+#else
+#define pte_maybe_dirty(pte)		(1)
 #endif
 
 #ifndef __HAVE_ARCH_PAGE_TEST_AND_CLEAR_YOUNG
--- 2.6.12-rc6/mm/msync.c	2005-05-25 18:09:21.000000000 +0100
+++ linux/mm/msync.c	2005-06-04 20:41:55.000000000 +0100
@@ -34,6 +34,8 @@ static void sync_pte_range(struct vm_are
 
 		if (!pte_present(*pte))
 			continue;
+		if (!pte_maybe_dirty(*pte))
+			continue;
 		pfn = pte_pfn(*pte);
 		if (!pfn_valid(pfn))
 			continue;
