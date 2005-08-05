Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262946AbVHEJMp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262946AbVHEJMp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 05:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262925AbVHEJKA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 05:10:00 -0400
Received: from ozlabs.org ([203.10.76.45]:23238 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262920AbVHEJHG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 05:07:06 -0400
Date: Fri, 5 Aug 2005 19:06:40 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>, torvalds@ozlabs.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix hugepage crash on failing mmap()
Message-ID: <20050805090640.GD2224@localhost.localdomain>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, torvalds@ozlabs.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew/Linus, please apply:

This patch fixes a crash in the hugepage code.  unmap_hugepage_area()
was assuming that (due to prefault) PTEs must exist for all the area
in question.  However, this may not be the case, if mmap() encounters
an error before the prefault and calls unmap_region() to clean up any
partial mapping.

Depending on the hugepage configuration, this crash can be triggered
by an unpriveleged user.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: working-2.6/mm/hugetlb.c
===================================================================
--- working-2.6.orig/mm/hugetlb.c	2005-08-05 18:47:10.000000000 +1000
+++ working-2.6/mm/hugetlb.c	2005-08-05 18:58:09.000000000 +1000
@@ -301,6 +301,7 @@
 {
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long address;
+	pte_t *ptep;
 	pte_t pte;
 	struct page *page;
 
@@ -309,9 +310,17 @@
 	BUG_ON(end & ~HPAGE_MASK);
 
 	for (address = start; address < end; address += HPAGE_SIZE) {
-		pte = huge_ptep_get_and_clear(mm, address, huge_pte_offset(mm, address));
+		ptep = huge_pte_offset(mm, address);
+		if (! ptep)
+			/* This can happen on truncate, or if an
+			 * mmap() is aborted due to an error before
+			 * the prefault */
+			continue;
+
+		pte = huge_ptep_get_and_clear(mm, address, ptep);
 		if (pte_none(pte))
 			continue;
+
 		page = pte_page(pte);
 		put_page(page);
 	}


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/people/dgibson
