Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161225AbWGNDMh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161225AbWGNDMh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 23:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161219AbWGNDMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 23:12:37 -0400
Received: from sonicyouth.fatport.com ([216.187.77.179]:59778 "EHLO
	sonicyouth.fatport.com") by vger.kernel.org with ESMTP
	id S1161216AbWGNDMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 23:12:36 -0400
Subject: RE: [PATCH] ia64: race flushing icache in COW path
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Jason Baron <jbaron@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
In-Reply-To: <617E1C2C70743745A92448908E030B2A38D779@scsmsx411.amr.corp.intel.com>
References: <617E1C2C70743745A92448908E030B2A38D779@scsmsx411.amr.corp.intel.com>
Content-Type: text/plain
Date: Fri, 14 Jul 2006 05:11:47 +0200
Message-Id: <1152846707.7466.12.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-13 at 13:37 -0700, Luck, Tony wrote:
> > lazy_mmu_prot_update() is used in a number of other places *after* the pte 
> > is established. An explanation as to why this case is different, would be 
> > interesting.
> 
> The other places do need a close look, it seems that some of
> them may not be needed (e.g. the one inside "if (reuse) { }" at
> the top of do_wp_page() ... at the moment I'm struggling to see
> what it manages to achieve).
> 
> Most of the rest are in cases where we are adding a new virtual
> page (comments like "No need to invalidate - it was non-present
> before").  These may also need to have the order shuffled, but
> they seem unlikely to be the cause of a bug (it is unlikely
> that an application has threads that branch to new anonymous
> pages as they are being attached to the process).
> 
> So you are right that there may be some more work here, but
> I wanted to get the one-liner that is a clear and obvious
> bugfix posted without being cluttered with some less obvious
> fixes.

How about something like this.
---

From: Peter Zijlstra <a.p.zijlstra@chello.nl>

Since calling of lazy_mmu_prot_update() while the PTE is already set
could open up a race window wrt. icache coherency, make sure all
invocations are done before setting the PTE.

These call-sites are currently not problematic, the one that was has 
been addressed by a previous patch. This patch just tidies up the
call semantics for lazy_mmu_prot_update().

Signed-Off-By: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 mm/hugetlb.c  |    4 ++--
 mm/memory.c   |   10 +++++-----
 mm/mprotect.c |    2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

Index: linux-2.6/mm/hugetlb.c
===================================================================
--- linux-2.6.orig/mm/hugetlb.c	2006-07-14 04:54:48.000000000 +0200
+++ linux-2.6/mm/hugetlb.c	2006-07-14 05:04:58.000000000 +0200
@@ -313,9 +313,9 @@ static void set_huge_ptep_writable(struc
 	pte_t entry;
 
 	entry = pte_mkwrite(pte_mkdirty(*ptep));
+	lazy_mmu_prot_update(entry);
 	ptep_set_access_flags(vma, address, ptep, entry, 1);
 	update_mmu_cache(vma, address, entry);
-	lazy_mmu_prot_update(entry);
 }
 
 
@@ -634,8 +634,8 @@ void hugetlb_change_protection(struct vm
 		if (!pte_none(*ptep)) {
 			pte = huge_ptep_get_and_clear(mm, address, ptep);
 			pte = pte_mkhuge(pte_modify(pte, newprot));
-			set_huge_pte_at(mm, address, ptep, pte);
 			lazy_mmu_prot_update(pte);
+			set_huge_pte_at(mm, address, ptep, pte);
 		}
 	}
 	spin_unlock(&mm->page_table_lock);
Index: linux-2.6/mm/memory.c
===================================================================
--- linux-2.6.orig/mm/memory.c	2006-07-14 05:00:06.000000000 +0200
+++ linux-2.6/mm/memory.c	2006-07-14 05:02:07.000000000 +0200
@@ -1506,9 +1506,9 @@ static int do_wp_page(struct mm_struct *
 		flush_cache_page(vma, address, pte_pfn(orig_pte));
 		entry = pte_mkyoung(orig_pte);
 		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
+		lazy_mmu_prot_update(entry);
 		ptep_set_access_flags(vma, address, page_table, entry, 1);
 		update_mmu_cache(vma, address, entry);
-		lazy_mmu_prot_update(entry);
 		ret |= VM_FAULT_WRITE;
 		goto unlock;
 	}
@@ -1980,6 +1980,7 @@ static int do_swap_page(struct mm_struct
 	}
 
 	flush_icache_page(vma, page);
+	lazy_mmu_prot_update(pte);
 	set_pte_at(mm, address, page_table, pte);
 	page_add_anon_rmap(page, vma, address);
 
@@ -1997,7 +1998,6 @@ static int do_swap_page(struct mm_struct
 
 	/* No need to invalidate - it was non-present before */
 	update_mmu_cache(vma, address, pte);
-	lazy_mmu_prot_update(pte);
 unlock:
 	pte_unmap_unlock(page_table, ptl);
 out:
@@ -2055,11 +2055,11 @@ static int do_anonymous_page(struct mm_s
 		page_add_file_rmap(page);
 	}
 
+	lazy_mmu_prot_update(entry);
 	set_pte_at(mm, address, page_table, entry);
 
 	/* No need to invalidate - it was non-present before */
 	update_mmu_cache(vma, address, entry);
-	lazy_mmu_prot_update(entry);
 unlock:
 	pte_unmap_unlock(page_table, ptl);
 	return VM_FAULT_MINOR;
@@ -2180,6 +2180,7 @@ retry:
 		entry = mk_pte(new_page, vma->vm_page_prot);
 		if (write_access)
 			entry = maybe_mkwrite(pte_mkdirty(entry), vma);
+		lazy_mmu_prot_update(entry);
 		set_pte_at(mm, address, page_table, entry);
 		if (anon) {
 			inc_mm_counter(mm, anon_rss);
@@ -2197,7 +2198,6 @@ retry:
 
 	/* no need to invalidate: a not-present page shouldn't be cached */
 	update_mmu_cache(vma, address, entry);
-	lazy_mmu_prot_update(entry);
 unlock:
 	pte_unmap_unlock(page_table, ptl);
 	return ret;
@@ -2293,9 +2293,9 @@ static inline int handle_pte_fault(struc
 	}
 	entry = pte_mkyoung(entry);
 	if (!pte_same(old_entry, entry)) {
+		lazy_mmu_prot_update(entry);
 		ptep_set_access_flags(vma, address, pte, entry, write_access);
 		update_mmu_cache(vma, address, entry);
-		lazy_mmu_prot_update(entry);
 	} else {
 		/*
 		 * This is needed only for protection faults but the arch code
Index: linux-2.6/mm/mprotect.c
===================================================================
--- linux-2.6.orig/mm/mprotect.c	2006-07-14 04:54:48.000000000 +0200
+++ linux-2.6/mm/mprotect.c	2006-07-14 05:03:37.000000000 +0200
@@ -43,8 +43,8 @@ static void change_pte_range(struct mm_s
 			 * into place.
 			 */
 			ptent = pte_modify(ptep_get_and_clear(mm, addr, pte), newprot);
-			set_pte_at(mm, addr, pte, ptent);
 			lazy_mmu_prot_update(ptent);
+			set_pte_at(mm, addr, pte, ptent);
 #ifdef CONFIG_MIGRATION
 		} else if (!pte_file(oldpte)) {
 			swp_entry_t entry = pte_to_swp_entry(oldpte);


