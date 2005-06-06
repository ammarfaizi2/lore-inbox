Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261647AbVFFTtd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261647AbVFFTtd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 15:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261645AbVFFTta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 15:49:30 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:20379 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261639AbVFFTrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 15:47:41 -0400
Date: Mon, 6 Jun 2005 20:48:27 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mbind: fix verify_pages pte_page
Message-ID: <Pine.LNX.4.61.0506062046590.5000@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-OriginalArrivalTime: 06 Jun 2005 19:47:26.0636 (UTC) 
    FILETIME=[90E166C0:01C56AD0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Strict mbind's check that pages already mapped are on right node has been
using pte_page without checking if pfn_valid, and without page_table_lock
to prevent spurious failures when try_to_unmap_one intervenes between the
pte_present and the pte_page.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/mempolicy.c |   19 ++++++++++++++-----
 1 files changed, 14 insertions(+), 5 deletions(-)

--- 2.6.12-rc6/mm/mempolicy.c	2005-05-25 18:09:21.000000000 +0100
+++ linux/mm/mempolicy.c	2005-06-04 20:41:55.000000000 +0100
@@ -242,6 +242,9 @@ static int
 verify_pages(struct mm_struct *mm,
 	     unsigned long addr, unsigned long end, unsigned long *nodes)
 {
+	int err = 0;
+
+	spin_lock(&mm->page_table_lock);
 	while (addr < end) {
 		struct page *p;
 		pte_t *pte;
@@ -268,17 +271,23 @@ verify_pages(struct mm_struct *mm,
 		}
 		p = NULL;
 		pte = pte_offset_map(pmd, addr);
-		if (pte_present(*pte))
-			p = pte_page(*pte);
+		if (pte_present(*pte)) {
+			unsigned long pfn = pte_pfn(*pte);
+			if (pfn_valid(pfn))
+				p = pfn_to_page(pfn);
+		}
 		pte_unmap(pte);
 		if (p) {
 			unsigned nid = page_to_nid(p);
-			if (!test_bit(nid, nodes))
-				return -EIO;
+			if (!test_bit(nid, nodes)) {
+				err = -EIO;
+				break;
+			}
 		}
 		addr += PAGE_SIZE;
 	}
-	return 0;
+	spin_unlock(&mm->page_table_lock);
+	return err;
 }
 
 /* Step 1: check the range */
