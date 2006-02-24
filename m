Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932223AbWBXBpZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbWBXBpZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 20:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932377AbWBXBpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 20:45:25 -0500
Received: from fmr21.intel.com ([143.183.121.13]:21682 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S932223AbWBXBpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 20:45:24 -0500
Message-Id: <200602240145.k1O1jEg05475@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'David Gibson'" <david@gibson.dropbear.id.au>,
       "'Hugh Dickins'" <hugh@veritas.com>, "Luck, Tony" <tony.luck@intel.com>
Cc: <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [patch] fix ia64 hugetlb_free_pgd_range
Date: Thu, 23 Feb 2006 17:45:14 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcY41y6fwRCNtdgVQDm9X59Q/+P3CAAAQTiwAAJZmlA=
In-Reply-To: 
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've looked at hugetlb_free_pgd_range() right side up, right side
down, up side up, up side down.  And it just doesn't look correct
to me at all.

In that function, we do address transformation before calling
free_pgd_range, so the generic function can traverse to right set
of page table page.  There is no need to do any range check.

Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>

--- ./arch/ia64/mm/hugetlbpage.c.orig	2006-02-23 18:21:28.202422392 -0800
+++ ./arch/ia64/mm/hugetlbpage.c	2006-02-23 18:26:28.256129654 -0800
@@ -125,9 +125,9 @@ void hugetlb_free_pgd_range(struct mmu_g
 
 	addr = htlbpage_to_page(addr);
 	end  = htlbpage_to_page(end);
-	if (is_hugepage_only_range(tlb->mm, floor, HPAGE_SIZE))
+	if (REGION_NUMBER(floor) == RGN_HPAGE)
 		floor = htlbpage_to_page(floor);
-	if (is_hugepage_only_range(tlb->mm, ceiling, HPAGE_SIZE))
+	if (REGION_NUMBER(ceiling) == RGN_HPAGE)
 		ceiling = htlbpage_to_page(ceiling);
 
 	free_pgd_range(tlb, addr, end, floor, ceiling);


