Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262208AbUF3UIp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262208AbUF3UIp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 16:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbUF3UHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 16:07:36 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:43360 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262208AbUF3UGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 16:06:32 -0400
Date: Wed, 30 Jun 2004 21:06:23 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Ingo Molnar <mingo@elte.hu>, "E. Gryaznova" <grev@namesys.com>,
       <linux-kernel@vger.kernel.org>, <reiserfs-dev@namesys.com>
Subject: Re: [2.6.7-mm4: OOPS] kernel BUG at mm/mmap.c:1793
In-Reply-To: <20040630114157.59258adf.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0406302049500.21421-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jun 2004, Andrew Morton wrote:
> "E. Gryaznova" <grev@namesys.com> wrote:
> >
> > this is reproducible for me problem:
> >  This wilson mmap test (attached) causes the kernel BUG at mm/mmap.c:1793 
> >  immediately after running.
> 
> I cannot trigger it here.  Does it happen every time?  How much memory does
> that machine have?

I get it as easily as Lena does, perhaps you've a smallish stack rlimit.

The problem is in the flexible mmap patch: arch_get_unmapped_area_topdown
is liable to give your mmap vm_start above TASK_SIZE with vm_end wrapped;
which is confusing, and ends up as that BUG_ON(mm->map_count).

The patch below stops that behaviour, but it's not the full solution:
wilson_mmap_test -s 1000 then simply cannot allocate memory for the
large mmap, whereas it works fine non-top-down.

I think it's wrong to interpret a large or rlim_infinite stack rlimit
as an inviolable request to reserve that much for the stack: it makes
much less VM available than bottom up, not what was intended.  Perhaps
top down should go bottom up (instead of belly up) when it fails -
but I'd probably better leave that to Ingo.

Or perhaps the default should place stack below text (as WLI suggested
and ELF intended, with its text defaulting to 0x08048000, small progs
sharing page table between stack and text and data); with a further
personality for those needing bigger stack.

Hugh

--- 2.6.7-mm4/mm/mmap.c	2004-06-29 12:18:55.000000000 +0100
+++ linux/mm/mmap.c	2004-06-30 20:20:50.026826472 +0100
@@ -1100,12 +1100,12 @@ arch_get_unmapped_area_topdown(struct fi
 			return addr;
 	}
 
+try_again:
 	/* make sure it can fit in the remaining address space */
 	if (mm->free_area_cache < len)
 		goto fail;
 
 	/* either no address requested or cant fit in requested address hole */
-try_again:
 	addr = (mm->free_area_cache - len) & PAGE_MASK;
 	do {
 		/*


