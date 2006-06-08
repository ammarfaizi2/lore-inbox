Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964906AbWFHQyJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964906AbWFHQyJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 12:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964908AbWFHQyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 12:54:09 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:59319 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S964906AbWFHQyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 12:54:08 -0400
Date: Thu, 8 Jun 2006 09:53:47 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
cc: Hugh Dickins <hugh@veritas.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       David Howells <dhowells@redhat.com>, Martin Bligh <mbligh@google.com>,
       Nick Piggin <npiggin@suse.de>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] mm: tracking dirty pages -v6
In-Reply-To: <1149770654.4408.71.camel@lappy>
Message-ID: <Pine.LNX.4.64.0606080938250.5695@schroedinger.engr.sgi.com>
References: <20060525135534.20941.91650.sendpatchset@lappy> 
 <Pine.LNX.4.64.0606062056540.1507@blonde.wat.veritas.com> <1149770654.4408.71.camel@lappy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. The case that a vma is shared is not likely.

2. Typo fix in mmap.c

3. This may be a bit controversial but it does not seem to
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

Index: linux-2.6/mm/memory.c
===================================================================
--- linux-2.6.orig/mm/memory.c	2006-06-08 09:12:13.000000000 -0700
+++ linux-2.6/mm/memory.c	2006-06-08 09:50:17.000000000 -0700
@@ -1452,7 +1452,7 @@ static int do_wp_page(struct mm_struct *
 	if (!old_page)
 		goto gotten;
 
-	if (vma->vm_flags & VM_SHARED) {
+	if (unlikely(vma->vm_flags & VM_SHARED)) {
 		reuse = 1;
 		dirty_page = old_page;
 		get_page(dirty_page);
@@ -1466,7 +1466,6 @@ static int do_wp_page(struct mm_struct *
 		entry = pte_mkyoung(orig_pte);
 		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
 		ptep_set_access_flags(vma, address, page_table, entry, 1);
-		update_mmu_cache(vma, address, entry);
 		lazy_mmu_prot_update(entry);
 		ret |= VM_FAULT_WRITE;
 		goto unlock;
Index: linux-2.6/mm/mmap.c
===================================================================
--- linux-2.6.orig/mm/mmap.c	2006-06-08 09:15:54.000000000 -0700
+++ linux-2.6/mm/mmap.c	2006-06-08 09:17:41.000000000 -0700
@@ -1092,7 +1092,7 @@ munmap_back:
 		 * f_op->mmap() - modifies vm_page_prot; but will not reset
 		 *                from vm_flags.
 		 *
-		 * Hence between the two calls (here) it is save to modify
+		 * Hence between the two calls (here) it is safe to modify
 		 * vm_page_prot depending on backing_dev_info capabilities.
 		 *
 		 * shmem_backing_dev_info does have BDI_CAP_NO_ACCT_DIRTY.
