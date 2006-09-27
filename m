Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031158AbWI0Wcn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031158AbWI0Wcn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 18:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031156AbWI0Wcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 18:32:43 -0400
Received: from mga06.intel.com ([134.134.136.21]:3720 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1031158AbWI0Wcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 18:32:41 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,226,1157353200"; 
   d="scan'208"; a="137311143:sNHT168017605"
Date: Wed, 27 Sep 2006 15:15:07 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: akpm@osdl.org, hugh@veritas.com
Cc: linux-kernel@vger.kernel.org, asit.k.mallick@intel.com
Subject: [patch] mm: fix a race condition under SMC + COW
Message-ID: <20060927151507.A12423@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>

Failing context is a multi threaded process context and the failing
sequence is as follows.

One thread T0 doing self modifying code on page X on processor P0 and
another thread T1 doing COW (breaking the COW setup as part of just happened
fork() in another thread T2) on the same page X on processor P1. T0 doing SMC
can endup modifying  the new page Y (allocated by the T1 doing COW on P1) but
because of different I/D TLB's, P0 ITLB will not see the new mapping till
the flush TLB IPI from  P1 is received. During this interval, if T0 executes
the code created by SMC it can result in an app error (as ITLB still points to
old page X and endup executing the content in page X rather than using
the content in page Y).

Fix this issue by first clearing the PTE and flushing it, before updating it
with new entry.

Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>
---

--- linux-2.6.18/mm/memory.c.orig	2006-09-27 14:59:48.000000000 -0700
+++ linux-2.6.18/mm/memory.c	2006-09-27 15:17:35.000000000 -0700
@@ -1551,7 +1551,14 @@ gotten:
 		entry = mk_pte(new_page, vma->vm_page_prot);
 		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
 		lazy_mmu_prot_update(entry);
-		ptep_establish(vma, address, page_table, entry);
+		/*
+		 * Clear the pte entry and flush it first, before updating the
+		 * pte with the new entry. This will avoid a race condition
+		 * seen in the presence of one thread doing SMC and another
+		 * thread doing COW.
+		 */
+		ptep_clear_flush(vma, address, page_table);
+		set_pte_at(mm, address, page_table, entry);
 		update_mmu_cache(vma, address, entry);
 		lru_cache_add_active(new_page);
 		page_add_new_anon_rmap(new_page, vma, address);
