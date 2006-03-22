Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932882AbWCVWgO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932882AbWCVWgO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 17:36:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932894AbWCVWfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 17:35:37 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:6858 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S932882AbWCVWfP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 17:35:15 -0500
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Bob Picco <bob.picco@hp.com>, Andrew Morton <akpm@osdl.org>,
       IWAMOTO Toshihiro <iwamoto@valinux.co.jp>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Christoph Lameter <christoph@lameter.com>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, Rik van Riel <riel@redhat.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-Id: <20060322223441.12658.17738.sendpatchset@twins.localnet>
In-Reply-To: <20060322223107.12658.14997.sendpatchset@twins.localnet>
References: <20060322223107.12658.14997.sendpatchset@twins.localnet>
Subject: [PATCH 21/34] mm: page-replace-nonresident.patch
Date: Wed, 22 Mar 2006 23:35:13 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Peter Zijlstra <a.p.zijlstra@chello.nl>

Add hooks for nonresident page tracking.
The policy has to define MM_POLICY_HAS_NONRESIDENT when it makes
use of these.

API:
	void page_replace_remember(struct zone *, struct page *);

Remeber a page - insert it into the nonresident page tracking.

	void page_replace_forget(struct address_space *, unsigned long);

Forget about a page - remove it from the nonresident page tracking.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Signed-off-by: Marcelo Tosatti <marcelo.tosatti@cyclades.com>

---

 include/linux/mm_page_replace.h    |    2 ++
 include/linux/mm_use_once_policy.h |    3 +++
 mm/memory.c                        |   28 ++++++++++++++++++++++++++++
 mm/swapfile.c                      |   13 +++++++++++--
 mm/vmscan.c                        |    2 ++
 5 files changed, 46 insertions(+), 2 deletions(-)

Index: linux-2.6-git/include/linux/mm_use_once_policy.h
===================================================================
--- linux-2.6-git.orig/include/linux/mm_use_once_policy.h
+++ linux-2.6-git/include/linux/mm_use_once_policy.h
@@ -161,6 +161,9 @@ static inline int page_replace_is_active
 	return PageActive(page);
 }
 
+#define page_replace_remember(z, p) do { } while (0)
+#define page_replace_forget(m, i) do { } while (0)
+
 static inline unsigned long __page_replace_nr_pages(struct zone *zone)
 {
 	return zone->policy.nr_active + zone->policy.nr_inactive;
Index: linux-2.6-git/include/linux/mm_page_replace.h
===================================================================
--- linux-2.6-git.orig/include/linux/mm_page_replace.h
+++ linux-2.6-git/include/linux/mm_page_replace.h
@@ -96,6 +96,8 @@ extern void page_replace_shrink(struct z
 /* void page_replace_copy_state(struct page *, struct page *); */
 /* void page_replace_clear_state(struct page *); */
 /* int page_replace_is_active(struct page *); */
+/* void page_replace_remember(struct zone *, struct page*); */
+/* void page_replace_forget(struct address_space *, unsigned long); */
 extern void page_replace_show(struct zone *);
 extern void page_replace_zoneinfo(struct zone *, struct seq_file *);
 extern void __page_replace_counts(unsigned long *, unsigned long *,
Index: linux-2.6-git/mm/memory.c
===================================================================
--- linux-2.6-git.orig/mm/memory.c
+++ linux-2.6-git/mm/memory.c
@@ -606,6 +606,31 @@ int copy_page_range(struct mm_struct *ds
 	return 0;
 }
 
+#if defined MM_POLICY_HAS_NONRESIDENT
+static void free_file(struct vm_area_struct *vma,
+				unsigned long offset)
+{
+	struct address_space *mapping;
+	struct page *page;
+
+	if (!vma ||
+	    !vma->vm_file ||
+	    !vma->vm_file->f_mapping)
+		return;
+
+	mapping = vma->vm_file->f_mapping;
+	page = find_get_page(mapping, offset);
+	if (page) {
+		page_cache_release(page);
+		return;
+	}
+
+	page_replace_forget(mapping, offset);
+}
+#else
+#define free_file(a,b) do { } while (0)
+#endif
+
 static unsigned long zap_pte_range(struct mmu_gather *tlb,
 				struct vm_area_struct *vma, pmd_t *pmd,
 				unsigned long addr, unsigned long end,
@@ -621,6 +646,7 @@ static unsigned long zap_pte_range(struc
 	do {
 		pte_t ptent = *pte;
 		if (pte_none(ptent)) {
+			free_file(vma, pte_to_pgoff(ptent));
 			(*zap_work)--;
 			continue;
 		}
@@ -679,6 +705,8 @@ static unsigned long zap_pte_range(struc
 			continue;
 		if (!pte_file(ptent))
 			free_swap_and_cache(pte_to_swp_entry(ptent));
+		else
+			free_file(vma, pte_to_pgoff(ptent));
 		pte_clear_full(mm, addr, pte, tlb->fullmm);
 	} while (pte++, addr += PAGE_SIZE, (addr != end && *zap_work > 0));
 
Index: linux-2.6-git/mm/swapfile.c
===================================================================
--- linux-2.6-git.orig/mm/swapfile.c
+++ linux-2.6-git/mm/swapfile.c
@@ -28,6 +28,7 @@
 #include <linux/mutex.h>
 #include <linux/capability.h>
 #include <linux/syscalls.h>
+#include <linux/mm_page_replace.h>
 
 #include <asm/pgtable.h>
 #include <asm/tlbflush.h>
@@ -300,7 +301,8 @@ void swap_free(swp_entry_t entry)
 
 	p = swap_info_get(entry);
 	if (p) {
-		swap_entry_free(p, swp_offset(entry));
+		if (!swap_entry_free(p, swp_offset(entry)))
+			page_replace_forget(&swapper_space, entry.val);
 		spin_unlock(&swap_lock);
 	}
 }
@@ -397,8 +399,15 @@ void free_swap_and_cache(swp_entry_t ent
 
 	p = swap_info_get(entry);
 	if (p) {
-		if (swap_entry_free(p, swp_offset(entry)) == 1)
+		switch (swap_entry_free(p, swp_offset(entry))) {
+		case 1:
 			page = find_trylock_page(&swapper_space, entry.val);
+			break;
+
+		case 0:
+			page_replace_forget(&swapper_space, entry.val);
+			break;
+		}
 		spin_unlock(&swap_lock);
 	}
 	if (page) {
Index: linux-2.6-git/mm/vmscan.c
===================================================================
--- linux-2.6-git.orig/mm/vmscan.c
+++ linux-2.6-git/mm/vmscan.c
@@ -315,6 +315,7 @@ static int remove_mapping(struct address
 
 	if (PageSwapCache(page)) {
 		swp_entry_t swap = { .val = page_private(page) };
+		page_replace_remember(page_zone(page), page);
 		__delete_from_swap_cache(page);
 		write_unlock_irq(&mapping->tree_lock);
 		swap_free(swap);
@@ -322,6 +323,7 @@ static int remove_mapping(struct address
 		return 1;
 	}
 
+	page_replace_remember(page_zone(page), page);
 	__remove_from_page_cache(page);
 	write_unlock_irq(&mapping->tree_lock);
 	__put_page(page);
