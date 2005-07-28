Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261800AbVG1URF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261800AbVG1URF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 16:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261703AbVG1UHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 16:07:13 -0400
Received: from graphe.net ([209.204.138.32]:32193 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261565AbVG1UGL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 16:06:11 -0400
Date: Thu, 28 Jul 2005 13:06:04 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3-mm3
In-Reply-To: <20050728205215.A10867@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.62.0507281303320.12958@graphe.net>
References: <20050728025840.0596b9cb.akpm@osdl.org> <Pine.LNX.4.62.0507281006320.1262@graphe.net>
 <20050728205215.A10867@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jul 2005, Russell King wrote:

> ARM can't support atomic page table operations as such - the Linux view
> of the page table is separate from the hardware view, and there's some
> CPU specific code which translates from the Linux view to the hardware
> view.

Yes. The patches fall back to nonatomic operations for ARM.

> Looking at the actual patches, particularly pte_xchg-and-pte_cmpxchg.patch
> combined with the above, the ARM solution would be to go back to using
> non-atomic operations here (since we can't do this atomically.)  Also,
> since the MMU will only ever read from the page tables, I don't think
> we need to play any games with clearing out ptes before we replace the
> value.

Ok. Then you can use a part of the patches. Define ptep_xchg and 
ptep_cmpxchg for ARM so that you do can avoid intermittently clearing 
ptes.

Here is the patch that I sent to Andrew in the morning:

Index: linux-2.6.13-rc3/mm/memory.c
===================================================================
--- linux-2.6.13-rc3.orig/mm/memory.c	2005-07-27 15:34:41.000000000 -0700
+++ linux-2.6.13-rc3/mm/memory.c	2005-07-28 09:24:05.000000000 -0700
@@ -2071,6 +2071,7 @@
 	 */
 	page_table_atomic_start(mm);
 	pgd = pgd_offset(mm, address);
+#ifndef __PAGETABLE_PUD_FOLDED
 	if (unlikely(pgd_none(*pgd))) {
 		pud_t *new;
 
@@ -2084,6 +2085,7 @@
 		if (!pgd_test_and_populate(mm, pgd, new))
 			pud_free(new);
 	}
+#endif
 
 	pud = pud_offset(pgd, address);
 	if (unlikely(pud_none(*pud))) {
