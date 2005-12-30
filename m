Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964875AbVL3Wnj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964875AbVL3Wnj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 17:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964855AbVL3Wnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 17:43:31 -0500
Received: from amsfep14-int.chello.nl ([213.46.243.21]:15693 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S964867AbVL3Wm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 17:42:57 -0500
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Christoph Lameter <christoph@lameter.com>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>, Nick Piggin <npiggin@suse.de>,
       Marijn Meijles <marijn@bitpit.net>, Rik van Riel <riel@redhat.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-Id: <20051230224233.765.82740.sendpatchset@twins.localnet>
In-Reply-To: <20051230223952.765.21096.sendpatchset@twins.localnet>
References: <20051230223952.765.21096.sendpatchset@twins.localnet>
Subject: [PATCH 2/9] clockpro-nonresident-del.patch
Date: Fri, 30 Dec 2005 23:42:54 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Peter Zijlstra <a.p.zijlstra@chello.nl>

Since the coupling of the resident and nonresident clocks depend on the 
actual number of nonresident pages present, stale entries influence the
actual behaviour. Hence we remove the nonresident pages from the map.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
 
 mm/memory.c   |   24 ++++++++++++++++++++++++
 mm/swapfile.c |   12 ++++++++++--
 2 files changed, 34 insertions(+), 2 deletions(-)

Index: linux-2.6-git/mm/swapfile.c
===================================================================
--- linux-2.6-git.orig/mm/swapfile.c
+++ linux-2.6-git/mm/swapfile.c
@@ -278,7 +278,8 @@ void swap_free(swp_entry_t entry)
 
 	p = swap_info_get(entry);
 	if (p) {
-		swap_entry_free(p, swp_offset(entry));
+		if (!swap_entry_free(p, swp_offset(entry)))
+			nonresident_get(&swapper_space, entry.val);
 		spin_unlock(&swap_lock);
 	}
 }
@@ -375,8 +376,15 @@ void free_swap_and_cache(swp_entry_t ent
 
 	p = swap_info_get(entry);
 	if (p) {
-		if (swap_entry_free(p, swp_offset(entry)) == 1)
+		switch (swap_entry_free(p, swp_offset(entry))) {
+		case 1:
 			page = find_trylock_page(&swapper_space, entry.val);
+			break;
+
+		case 0:
+			nonresident_get(&swapper_space, entry.val);
+			break;
+		}
 		spin_unlock(&swap_lock);
 	}
 	if (page) {
Index: linux-2.6-git/mm/memory.c
===================================================================
--- linux-2.6-git.orig/mm/memory.c
+++ linux-2.6-git/mm/memory.c
@@ -595,6 +595,27 @@ int copy_page_range(struct mm_struct *ds
 	return 0;
 }
 
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
+	nonresident_get(mapping, offset);
+}
+
 static unsigned long zap_pte_range(struct mmu_gather *tlb,
 				struct vm_area_struct *vma, pmd_t *pmd,
 				unsigned long addr, unsigned long end,
@@ -610,6 +631,7 @@ static unsigned long zap_pte_range(struc
 	do {
 		pte_t ptent = *pte;
 		if (pte_none(ptent)) {
+			free_file(vma, pte_to_pgoff(ptent));
 			(*zap_work)--;
 			continue;
 		}
@@ -668,6 +690,8 @@ static unsigned long zap_pte_range(struc
 			continue;
 		if (!pte_file(ptent))
 			free_swap_and_cache(pte_to_swp_entry(ptent));
+		else
+			free_file(vma, pte_to_pgoff(ptent));
 		pte_clear_full(mm, addr, pte, tlb->fullmm);
 	} while (pte++, addr += PAGE_SIZE, (addr != end && *zap_work > 0));
 
