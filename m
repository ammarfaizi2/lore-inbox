Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932393AbVK2UyA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393AbVK2UyA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 15:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932401AbVK2UyA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 15:54:00 -0500
Received: from www.swissdisk.com ([216.144.233.50]:32682 "EHLO
	swissweb.swissdisk.com") by vger.kernel.org with ESMTP
	id S932393AbVK2Ux7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 15:53:59 -0500
Date: Tue, 29 Nov 2005 11:45:26 -0800
From: Ben Collins <bcollins@debian.org>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 2.6.15-rc3] Fix missing pfn variables caused by vm changes
Message-ID: <20051129194526.GF6288@swissdisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I image this showed up because of "unused var..." when the changes
occured, because flush_cache_page() is a noop in most places. This showed
up for me on parisc however, where flush_cache_page() is a real function.

diff --git a/mm/memory.c b/mm/memory.c
index 6c1eac9..74839b3 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1345,7 +1345,7 @@ static int do_wp_page(struct mm_struct *
 		int reuse = can_share_swap_page(old_page);
 		unlock_page(old_page);
 		if (reuse) {
-			flush_cache_page(vma, address, pfn);
+			flush_cache_page(vma, address, pte_pfn(orig_pte));
 			entry = pte_mkyoung(orig_pte);
 			entry = maybe_mkwrite(pte_mkdirty(entry), vma);
 			ptep_set_access_flags(vma, address, page_table, entry, 1);
@@ -1389,7 +1389,7 @@ gotten:
 			}
 		} else
 			inc_mm_counter(mm, anon_rss);
-		flush_cache_page(vma, address, pfn);
+		flush_cache_page(vma, address, pte_pfn(orig_pte));
 		entry = mk_pte(new_page, vma->vm_page_prot);
 		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
 		ptep_establish(vma, address, page_table, entry);
diff --git a/mm/rmap.c b/mm/rmap.c
index 491ac35..f853c6d 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -641,7 +641,7 @@ static void try_to_unmap_cluster(unsigne
 			continue;
 
 		/* Nuke the page table entry. */
-		flush_cache_page(vma, address, pfn);
+		flush_cache_page(vma, address, pte_pfn(*pte));
 		pteval = ptep_clear_flush(vma, address, pte);
 
 		/* If nonlinear, store the file page offset in the pte. */

-- 
Ubuntu     - http://www.ubuntu.com/
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
SwissDisk  - http://www.swissdisk.com/
