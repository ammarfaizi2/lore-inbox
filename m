Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264082AbUFBUQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264082AbUFBUQm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 16:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264026AbUFBUOy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 16:14:54 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:27778 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S264058AbUFBUOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 16:14:14 -0400
Date: Wed, 2 Jun 2004 21:14:03 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: rmk@arm.linux.org.uk, <paulus@samba.org>, <anton@samba.org>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH] flush TLB when clearing young
In-Reply-To: <Pine.LNX.4.44.0406022103500.27696-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0406022112020.27696-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Traditionally we've not flushed TLB after clearing the young/referenced
bit, it has seemed just a waste of time.  Russell King points out that
on some architectures, with the move from 2.4 mm sweeping to 2.6 rmap,
this may be a serious omission: very frequently referenced pages never
re-marked young, and the worst choices made for unmapping.

So, replace ptep_test_and_clear_young by ptep_clear_flush_young
throughout rmap.c.  Originally I'd imagined making some kind of TLB
gather optimization, but don't see what now: whether worth it rather
depends on how common cross-cpu flushes are, and whether global or not.

ppc and ppc64 have already found this issue, and worked around it by
arranging TLB flush from their ptep_test_and_clear_young: with the aid
of pgtable rmap pointers.  I'm hoping ptep_clear_flush_young will allow
ppc and ppc64 to remove that special code, but won't change them myself.

It's worth noting that it is Andrea's anon_vma rmap which makes the vma
available for ptep_clear_flush_young in page_referenced_one: anonmm and
pte_chains would both need an additional find_vma for that.

Signed-off-by: Hugh Dickins <hugh@veritas.com>

 mm/rmap.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

--- 2.6.7-rc2/mm/rmap.c	2004-05-30 11:36:40.000000000 +0100
+++ linux/mm/rmap.c	2004-06-02 16:32:28.792923176 +0100
@@ -232,7 +232,7 @@ static int page_referenced_one(struct pa
 	if (page_to_pfn(page) != pte_pfn(*pte))
 		goto out_unmap;
 
-	if (ptep_test_and_clear_young(pte))
+	if (ptep_clear_flush_young(vma, address, pte))
 		referenced++;
 
 	(*mapcount)--;
@@ -480,7 +480,7 @@ static int try_to_unmap_one(struct page 
 	 * skipped over this mm) then we should reactivate it.
 	 */
 	if ((vma->vm_flags & (VM_LOCKED|VM_RESERVED)) ||
-			ptep_test_and_clear_young(pte)) {
+			ptep_clear_flush_young(vma, address, pte)) {
 		ret = SWAP_FAIL;
 		goto out_unmap;
 	}
@@ -590,7 +590,7 @@ static int try_to_unmap_cluster(unsigned
 		if (PageReserved(page))
 			continue;
 
-		if (ptep_test_and_clear_young(pte))
+		if (ptep_clear_flush_young(vma, address, pte))
 			continue;
 
 		/* Nuke the page table entry. */

