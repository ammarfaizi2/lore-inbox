Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266147AbUF3ASK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266147AbUF3ASK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 20:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266148AbUF3ASK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 20:18:10 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:37537 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266147AbUF3ASG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 20:18:06 -0400
Date: Tue, 29 Jun 2004 17:17:24 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-mm mailing list <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: remap_pte_range
Message-ID: <65600000.1088554644@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have no idea what remap_pte_range is trying to do here, but what it
is doing makes no sense (to me at least). 

If the pfn is not valid, we CANNOT safely call PageReserved on it - 
the *page returned from pfn_to_page is bullshit, and we crash deref'ing
it.

Perhaps this was what it was trying to do? Not sure.

diff -purN -X /home/mbligh/.diff.exclude virgin/mm/memory.c remap_pte_range/mm/memory.c
--- virgin/mm/memory.c	2004-06-16 10:22:15.000000000 -0700
+++ remap_pte_range/mm/memory.c	2004-06-29 17:15:35.000000000 -0700
@@ -908,7 +908,7 @@ static inline void remap_pte_range(pte_t
 	pfn = phys_addr >> PAGE_SHIFT;
 	do {
 		BUG_ON(!pte_none(*pte));
-		if (!pfn_valid(pfn) || PageReserved(pfn_to_page(pfn)))
+		if (pfn_valid(pfn) && !PageReserved(pfn_to_page(pfn)))
  			set_pte(pte, pfn_pte(pfn, prot));
 		address += PAGE_SIZE;
 		pfn++;

