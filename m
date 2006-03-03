Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752109AbWCCBEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752109AbWCCBEp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 20:04:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752108AbWCCBEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 20:04:45 -0500
Received: from ozlabs.org ([203.10.76.45]:36254 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1752104AbWCCBEo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 20:04:44 -0500
Date: Fri, 3 Mar 2006 12:04:08 +1100
From: "'David Gibson'" <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Hugh Dickins <hugh@veritas.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       William Irwin <wli@holomorphy.com>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: hugepage: Fix hugepage logic in free_pgtables() harder
Message-ID: <20060303010408.GG23766@localhost.localdomain>
Mail-Followup-To: 'David Gibson' <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, Hugh Dickins <hugh@veritas.com>,
	"Chen, Kenneth W" <kenneth.w.chen@intel.com>,
	William Irwin <wli@holomorphy.com>, linux-ia64@vger.kernel.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sigh.  Turns out the hugepage logic in free_pgtables() was doubly
broken.  The loop coalescing multiple normal page VMAs into one call
to free_pgd_range() had an off by one error, which could mean it would
coalesce one hugepage VMA into the same bundle (checking 'vma' not
'next' in the loop).  I transferred this bug into the new
is_vm_hugetlb_page() based version.  Here's the fix.

This one didn't bite on powerpc previously for the same reason the
is_hugepage_only_range() problem didn't: powerpc's
hugetlb_free_pgd_range() is identical to free_pgd_range().  It didn't
bite on ia64 because the hugepage region is distant enough from any
other region that the separated PMD_SIZE distance test would always
prevent coalescing the two together.

No libhugetlbfs testsuite regressions (ppc64, POWER5).

Signed-off-by: David Gibson <dwg@au1.ibm.com>

Index: working-2.6/mm/memory.c
===================================================================
--- working-2.6.orig/mm/memory.c	2006-03-03 11:39:33.000000000 +1100
+++ working-2.6/mm/memory.c	2006-03-03 11:39:50.000000000 +1100
@@ -285,7 +285,7 @@ void free_pgtables(struct mmu_gather **t
 			 * Optimization: gather nearby vmas into one call down
 			 */
 			while (next && next->vm_start <= vma->vm_end + PMD_SIZE
-			       && !is_vm_hugetlb_page(vma)) {
+			       && !is_vm_hugetlb_page(next)) {
 				vma = next;
 				next = vma->vm_next;
 				anon_vma_unlink(vma);


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
