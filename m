Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265857AbSKKSRl>; Mon, 11 Nov 2002 13:17:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266938AbSKKSRl>; Mon, 11 Nov 2002 13:17:41 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:5391 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id <S265857AbSKKSRi>; Mon, 11 Nov 2002 13:17:38 -0500
Date: Mon, 11 Nov 2002 18:25:25 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: Dave McCracken <dmccr@us.ibm.com>, Rik van Riel <riel@conectiva.com.br>,
       "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] flush_cache_page while pte valid 
Message-ID: <Pine.LNX.4.44.0211111808240.1236-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On some architectures (cachetlb.txt gives HyperSparc as an example)
it is essential to flush_cache_page while pte is still valid: the
rmap VM diverged from the base 2.4 VM before that fix was made,
so this error has crept back into 2.5.

Patch below applies to 2.5.47 or 2.5.47-mm1 - needs more work over
shared pagetables, but they've silently fallen out of 2.5.47-mm1:
oversight?  I'll send Alan the equivalent for 2.4-ac shortly.

(I wonder, what happens if userspace now modifies the page
after the flush_cache_page, before the pte is invalidated?)

--- 2.5.47/mm/rmap.c	Mon Oct  7 20:37:50 2002
+++ linux/mm/rmap.c	Mon Nov 11 17:01:27 2002
@@ -393,9 +393,9 @@
 	}
 
 	/* Nuke the page table entry. */
+	flush_cache_page(vma, address);
 	pte = ptep_get_and_clear(ptep);
 	flush_tlb_page(vma, address);
-	flush_cache_page(vma, address);
 
 	/* Store the swap location in the pte. See handle_pte_fault() ... */
 	if (PageSwapCache(page)) {

