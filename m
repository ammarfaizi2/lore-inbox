Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946223AbWKAF4Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946223AbWKAF4Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 00:56:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946163AbWKAFgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 00:36:08 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:17607 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1946155AbWKAFf2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 00:35:28 -0500
Message-Id: <20061101053516.482625000@sous-sol.org>
References: <20061101053340.305569000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 31 Oct 2006 21:33:44 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Suresh Siddha <suresh.b.siddha@intel.com>,
       "David S Miller" <davem@davemloft.net>, Hugh Dickins <hugh@veritas.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 04/61] mm: fix a race condition under SMC + COW
Content-Disposition: inline; filename=mm-fix-a-race-condition-under-smc-cow.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Suresh Siddha <suresh.b.siddha@intel.com>

Failing context is a multi threaded process context and the failing
sequence is as follows.

One thread T0 doing self modifying code on page X on processor P0 and
another thread T1 doing COW (breaking the COW setup as part of just
happened fork() in another thread T2) on the same page X on processor P1.
T0 doing SMC can endup modifying the new page Y (allocated by the T1 doing
COW on P1) but because of different I/D TLB's, P0 ITLB will not see the new
mapping till the flush TLB IPI from P1 is received.  During this interval,
if T0 executes the code created by SMC it can result in an app error (as
ITLB still points to old page X and endup executing the content in page X
rather than using the content in page Y).

Fix this issue by first clearing the PTE and flushing it, before updating
it with new entry.

Hugh sayeth:

  I was a bit sceptical, in the habit of thinking that Self Modifying Code
  must look such issues itself: but I guess there's nothing it can do to avoid
  this one.

  Fair enough, what you're changing it to is pretty much what powerpc and
  s390 were already doing, and is a more robust way of proceeding, consistent
  with how ptes are set everywhere else.

  The ptep_clear_flush is a bit heavy-handed (it's anxious to return the pte
  that was atomically cleared), but we'd have to wander through lots of arches
  to get the right minimal behaviour.  It'd also be nice to eliminate
  ptep_establish completely, now only used to define other macros/inlines: it
  always seemed obfuscation to me, what you've got there now is clearer.
  Let's put those cleanups on a TODO list.

Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>
Acked-by: "David S. Miller" <davem@davemloft.net>
Acked-by: Hugh Dickins <hugh@veritas.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 mm/memory.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- linux-2.6.18.1.orig/mm/memory.c
+++ linux-2.6.18.1/mm/memory.c
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

--
