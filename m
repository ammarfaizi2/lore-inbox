Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261795AbVCOTbS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261795AbVCOTbS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 14:31:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbVCOTbS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 14:31:18 -0500
Received: from fire.osdl.org ([65.172.181.4]:45259 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261802AbVCOT0G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 14:26:06 -0500
Date: Tue, 15 Mar 2005 11:25:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: davej@redhat.com, airlied@linux.ie, andrew@digital-domain.net,
       linux-kernel@vger.kernel.org, dri-devel@lists.sourceforge.net
Subject: Re: drm lockups since 2.6.11-bk2
Message-Id: <20050315112530.21bb0922.akpm@osdl.org>
In-Reply-To: <200503151003.39636.jbarnes@engr.sgi.com>
References: <Pine.LNX.4.58.0503151033110.22756@skynet>
	<20050315143629.GA27654@redhat.com>
	<200503151003.39636.jbarnes@engr.sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Barnes <jbarnes@engr.sgi.com> wrote:
>
> I'd be happy to test and fix things, but the page table walker patches broke 
>  ia64...  Once that's cleared up I can go digging.

We're hoping that davem's fix (committed yesterday) fixed that.


ChangeSet 1.2181.1.2, 2005/03/14 21:16:17-08:00, davem@sunset.davemloft.net

	[MM]: Restore pgd_index() iteration to clear_page_range().
	
	Otherwise ia64 and sparc64 explode with the new ptwalk
	iterators.  The pgd level stuff does not handle virtual
	address space holes (sparc64) and region based PGD indexing
	(ia64) properly.  It only matters in functions like
	clear_page_range() which potentially walk over more than
	a single VMA worth of address space.
	
	Signed-off-by: David S. Miller <davem@davemloft.net>



 memory.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)


diff -Nru a/mm/memory.c b/mm/memory.c
--- a/mm/memory.c	2005-03-15 00:06:50 -08:00
+++ b/mm/memory.c	2005-03-15 00:06:50 -08:00
@@ -182,15 +182,19 @@
 				unsigned long addr, unsigned long end)
 {
 	pgd_t *pgd;
-	unsigned long next;
+	unsigned long i, next;
 
 	pgd = pgd_offset(tlb->mm, addr);
-	do {
+	for (i = pgd_index(addr); i <= pgd_index(end-1); i++) {
 		next = pgd_addr_end(addr, end);
 		if (pgd_none_or_clear_bad(pgd))
 			continue;
 		clear_pud_range(tlb, pgd, addr, next);
-	} while (pgd++, addr = next, addr != end);
+		pgd++;
+		addr = next;
+		if (addr == end)
+			break;
+	}
 }
 
 pte_t fastcall * pte_alloc_map(struct mm_struct *mm, pmd_t *pmd, unsigned long address)


