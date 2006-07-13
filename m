Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030259AbWGMRJj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030259AbWGMRJj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 13:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030258AbWGMRJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 13:09:39 -0400
Received: from mga03.intel.com ([143.182.124.21]:28054 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1030256AbWGMRJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 13:09:38 -0400
X-IronPort-AV: i="4.06,221,1149490800"; 
   d="scan'208"; a="65482481:sNHT7860000778"
Date: Thu, 13 Jul 2006 10:00:38 -0700
Message-Id: <200607131700.k6DH0c5t001038@agluck-lia64.sc.intel.com>
From: "Luck, Tony" <tony.luck@intel.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: [PATCH] ia64: race flushing icache in COW path
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anil Keshavamurthy <anil.s.keshavamurthy@intel.com>

There is a race condition that showed up in a threaded JIT environment. The
situation is that a process with a JIT code page forks, so the page is marked
read-only, then some threads are created in the child.  One of the threads
attempts to add a new code block to the JIT page, so a copy-on-write fault is
taken, and the kernel allocates a new page, copies the data, installs the new
pte, and then calls lazy_mmu_prot_update() to flush caches to make sure that
the icache and dcache are in sync.  Unfortunately, the other thread runs right
after the new pte is installed, but before the caches have been flushed. It
tries to execute some old JIT code that was already in this page, but it sees
some garbage in the i-cache from the previous users of the new physical page.

Fix: we must make the caches consistent before installing the pte. This is
an ia64 only fix because lazy_mmu_prot_update() is a no-op on all other
architectures.

Signed-off-by: Anil Keshavamurthy <anil.s.keshavamurthy@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>

---

diff --git a/mm/memory.c b/mm/memory.c
index dc0d82c..de8bc85 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1549,9 +1549,9 @@ gotten:
 		flush_cache_page(vma, address, pte_pfn(orig_pte));
 		entry = mk_pte(new_page, vma->vm_page_prot);
 		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
+		lazy_mmu_prot_update(entry);
 		ptep_establish(vma, address, page_table, entry);
 		update_mmu_cache(vma, address, entry);
-		lazy_mmu_prot_update(entry);
 		lru_cache_add_active(new_page);
 		page_add_new_anon_rmap(new_page, vma, address);
 
