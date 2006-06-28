Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751393AbWF1USZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbWF1USZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 16:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbWF1USS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 16:18:18 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:57928 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S1751393AbWF1USN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 16:18:13 -0400
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       David Howells <dhowells@redhat.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Christoph Lameter <christoph@lameter.com>,
       Martin Bligh <mbligh@google.com>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>
Date: Wed, 28 Jun 2006 22:18:08 +0200
Message-Id: <20060628201808.8792.44936.sendpatchset@lappy>
In-Reply-To: <20060628201702.8792.69638.sendpatchset@lappy>
References: <20060628201702.8792.69638.sendpatchset@lappy>
Subject: [PATCH 6/6] mm: fixup do_wp_page()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Peter Zijlstra <a.p.zijlstra@chello.nl>

Wrt. the recent modifications in do_wp_page() Hugh Dickins pointed out:

"I now realize it's right to the first
order (normal case) and to the second order (ptrace poke), but not
to the third order (ptrace poke anon page here to be COWed -
perhaps can't occur without intervening mprotects)."

This patch restores the old COW behaviour for anonymous pages.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Acked-by: Hugh Dickins <hugh@veritas.com>

---
 mm/memory.c |   19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

Index: linux-2.6-dirty/mm/memory.c
===================================================================
--- linux-2.6-dirty.orig/mm/memory.c	2006-06-28 20:28:23.000000000 +0200
+++ linux-2.6-dirty/mm/memory.c	2006-06-28 20:33:39.000000000 +0200
@@ -1466,11 +1466,21 @@ static int do_wp_page(struct mm_struct *
 		goto gotten;
 
 	/*
-	 * Only catch write-faults on shared writable pages, read-only
-	 * shared pages can get COWed by get_user_pages(.write=1, .force=1).
+	 * Take out anonymous pages first, anonymous shared vmas are
+	 * not dirty accountable.
 	 */
-	if (unlikely((vma->vm_flags & (VM_WRITE|VM_SHARED)) ==
+	if (PageAnon(old_page)) {
+		if (!TestSetPageLocked(old_page)) {
+			reuse = can_share_swap_page(old_page);
+			unlock_page(old_page);
+		}
+	} else if (unlikely((vma->vm_flags & (VM_WRITE|VM_SHARED)) ==
 					(VM_WRITE|VM_SHARED))) {
+		/*
+		 * Only catch write-faults on shared writable pages,
+		 * read-only shared pages can get COWed by
+		 * get_user_pages(.write=1, .force=1).
+		 */
 		if (vma->vm_ops && vma->vm_ops->page_mkwrite) {
 			/*
 			 * Notify the address space that the page is about to
@@ -1502,9 +1512,6 @@ static int do_wp_page(struct mm_struct *
 		dirty_page = old_page;
 		get_page(dirty_page);
 		reuse = 1;
-	} else if (PageAnon(old_page) && !TestSetPageLocked(old_page)) {
-		reuse = can_share_swap_page(old_page);
-		unlock_page(old_page);
 	}
 
 	if (reuse) {
