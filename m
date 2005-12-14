Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964810AbVLNQWK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbVLNQWK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 11:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964813AbVLNQWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 11:22:10 -0500
Received: from gold.veritas.com ([143.127.12.110]:56179 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S964810AbVLNQWJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 11:22:09 -0500
Date: Wed, 14 Dec 2005 16:21:38 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Brice Oliver <boxofunix@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: process creation time increases linearly with shmem
In-Reply-To: <c4b74edb0512140607kb4a722aka461e76ad60dc682@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0512141616230.3162@goblin.wat.veritas.com>
References: <c4b74edb0512140607kb4a722aka461e76ad60dc682@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 14 Dec 2005 16:21:21.0572 (UTC) FILETIME=[6BA09E40:01C600CA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Dec 2005, Brice Oliver wrote:

> Sorry if this is a bit of an unusual request, but I am just trying to
> get more information.
> 
> I was working with Ray on this issue, and in order to get the
> appropriate patch, I need to get the bugzilla number for this
> particular patch so that I
> can turn that in to RedHat so they will include this fix in their
> release (as they will not allow the kernel patch to be applied unless
> they apply it to their source and then distribute to their customers).
> 
> Is that something that can be provided to me here?

I didn't realize there ever was a bugzilla number for it.
This is the actual patch, which Linus put into his tree on 30th August:

From: Nick Piggin <nickpiggin@yahoo.com.au>
Date: Sun, 28 Aug 2005 06:49:11 +0000 (+1000)
Subject: [PATCH] Lazy page table copies in fork()
X-Git-Tag: v2.6.14-rc1
X-Git-Url: http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=d992895ba2b27cf5adf1ba0ad6d27662adc54c5e

[PATCH] Lazy page table copies in fork()

Defer copying of ptes until fault time when it is possible to reconstruct
the pte from backing store. Idea from Andi Kleen and Nick Piggin.

Thanks to input from Rik van Riel and Linus and to Hugh for correcting
my blundering.

Ray Fucillo <fucillo@intersystems.com> reports:

  "I applied this latest patch to a 2.6.12 kernel and found that it does
   resolve the problem.  Prior to the patch on this machine, I was
   seeing about 23ms spent in fork for ever 100MB of shared memory
   segment.

   After applying the patch, fork is taking about 1ms regardless of the
   shared memory size."

Signed-off-by: Nick Piggin <npiggin@suse.de>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

--- a/mm/memory.c
+++ b/mm/memory.c
@@ -498,6 +498,17 @@ int copy_page_range(struct mm_struct *ds
 	unsigned long addr = vma->vm_start;
 	unsigned long end = vma->vm_end;
 
+	/*
+	 * Don't copy ptes where a page fault will fill them correctly.
+	 * Fork becomes much lighter when there are big shared or private
+	 * readonly mappings. The tradeoff is that copy_page_range is more
+	 * efficient than faulting.
+	 */
+	if (!(vma->vm_flags & (VM_HUGETLB|VM_NONLINEAR|VM_RESERVED))) {
+		if (!vma->anon_vma)
+			return 0;
+	}
+
 	if (is_vm_hugetlb_page(vma))
 		return copy_hugetlb_page_range(dst_mm, src_mm, vma);
 
