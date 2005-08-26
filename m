Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965026AbVHZLrg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965026AbVHZLrg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 07:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965030AbVHZLrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 07:47:36 -0400
Received: from gold.veritas.com ([143.127.12.110]:29532 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S965026AbVHZLrf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 07:47:35 -0400
Date: Fri, 26 Aug 2005 12:49:35 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, Rik van Riel <riel@redhat.com>,
       Ray Fucillo <fucillo@intersystems.com>, linux-kernel@vger.kernel.org
Subject: Re: process creation time increases linearly with shmem
In-Reply-To: <Pine.LNX.4.58.0508252055370.3317@g5.osdl.org>
Message-ID: <Pine.LNX.4.61.0508261220230.4697@goblin.wat.veritas.com>
References: <430CBFD1.7020101@intersystems.com> <430D0D6B.100@yahoo.com.au>
 <Pine.LNX.4.63.0508251331040.25774@cuia.boston.redhat.com>
 <430E6FD4.9060102@yahoo.com.au> <Pine.LNX.4.58.0508252055370.3317@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 26 Aug 2005 11:47:35.0032 (UTC) FILETIME=[F3350780:01C5AA33]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Aug 2005, Linus Torvalds wrote:
> On Fri, 26 Aug 2005, Nick Piggin wrote:
> > 
> > > Skipping MAP_SHARED in fork() sounds like a good idea to me...
> > 
> > Indeed. Linus, can you remember why we haven't done this before?
> 
> Hmm. Historical reasons. Also, if the child ends up needing it, it will 
> now have to fault them in.
> 
> That said, I think it's a valid optimization. Especially as the child 
> _probably_ doesn't need it (ie there's at least some likelihood of an 
> execve() or similar).

I agree, seems a great idea to me (sulking because I was too dumb
to get it, even when Nick and Andi first posted their patches).

It won't just save on the copying at fork time, it'll save on
undoing it all again when the child mm is torn down for exec.

The refaulting will hurt the performance of something: let's
just hope that something doesn't turn out to be a show-stopper.

I see some flaws in the various patches posted, including Rik's.
Here's another version - doing it inside copy_page_range, so this
kind of vma special-casing is over in mm/ rather than kernel/.

No point in testing vm_file, the vm_flags cover the cases.
Test VM_MAYSHARE rather than VM_SHARED to include the never-can-be-
written MAP_SHARED cases too.  Must exclude VM_NONLINEAR, their ptes
are essential for defining the file offsets.  Must exclude VM_RESERVED,
faults on remap_pfn_range areas would usually put in anon zeroed pages
instead of the driver pages - or perhaps would be better as a test
against VM_IO, or vma->vm_ops->nopage?

Having to exclude the VM_NONLINEAR seems rather a shame, since those
are always shared and likely enormous.  The InfiniBand people's idea 
of a way for the app to set VM_DONTCOPY (to avoid rdma get_user_pages
problems) becomes attractive as a way for apps to speed their forks.

Hugh

--- 2.6.13-rc7/mm/memory.c	2005-08-24 11:13:41.000000000 +0100
+++ linux/mm/memory.c	2005-08-26 10:09:50.000000000 +0100
@@ -498,6 +498,14 @@ int copy_page_range(struct mm_struct *ds
 	unsigned long addr = vma->vm_start;
 	unsigned long end = vma->vm_end;
 
+	/*
+	 * Assume the fork will probably exec: don't waste time copying
+	 * ptes where a page fault will fill them correctly afterwards.
+	 */
+	if ((vma->vm_flags & (VM_MAYSHARE|VM_HUGETLB|VM_NONLINEAR|VM_RESERVED))
+								== VM_MAYSHARE)
+		return 0;
+
 	if (is_vm_hugetlb_page(vma))
 		return copy_hugetlb_page_range(dst_mm, src_mm, vma);
 
