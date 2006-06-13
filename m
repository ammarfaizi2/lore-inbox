Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751068AbWFMLXG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068AbWFMLXG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 07:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750990AbWFMLWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 07:22:50 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:1841 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S1751024AbWFMLWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 07:22:47 -0400
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       David Howells <dhowells@redhat.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Christoph Lameter <christoph@lameter.com>,
       Martin Bligh <mbligh@google.com>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>
Date: Tue, 13 Jun 2006 13:22:23 +0200
Message-Id: <20060613112223.27913.72206.sendpatchset@lappy>
In-Reply-To: <20060613112120.27913.71986.sendpatchset@lappy>
References: <20060613112120.27913.71986.sendpatchset@lappy>
Subject: [PATCH 6/6] mm: remove some update_mmu_cache() calls
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Christoph Lameter <clameter@sgi.com>

This may be a bit controversial but it does not seem to
make sense to use the update_mmu_cache macro when we reuse
the page. We are only fiddling around with the protections,
the dirty and accessed bits.

With the call to update_mmu_cache the way of using the macros
would be different from mprotect() and page_mkclean(). I'd
rather have everything work the same way. If this breaks on some
arches then also mprotect and page_mkclean() are broken.
The use of mprotect() is rare, we may have breakage in some
arches that we just have not seen yet.

Signed-off-by: Christoph Lameter <clameter@sgi.com>
Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 mm/memory.c |    2 --
 1 file changed, 2 deletions(-)

Index: linux-2.6/mm/memory.c
===================================================================
--- linux-2.6.orig/mm/memory.c	2006-06-13 10:33:21.000000000 +0200
+++ linux-2.6/mm/memory.c	2006-06-13 10:36:31.000000000 +0200
@@ -1477,7 +1477,6 @@ static int do_wp_page(struct mm_struct *
 		entry = pte_mkyoung(orig_pte);
 		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
 		ptep_set_access_flags(vma, address, page_table, entry, 1);
-		update_mmu_cache(vma, address, entry);
 		lazy_mmu_prot_update(entry);
 		ret |= VM_FAULT_WRITE;
 		goto unlock;
@@ -2263,7 +2262,6 @@ static inline int handle_pte_fault(struc
 	entry = pte_mkyoung(entry);
 	if (!pte_same(old_entry, entry)) {
 		ptep_set_access_flags(vma, address, pte, entry, write_access);
-		update_mmu_cache(vma, address, entry);
 		lazy_mmu_prot_update(entry);
 	} else {
 		/*
