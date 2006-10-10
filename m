Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030257AbWJJUKc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030257AbWJJUKc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 16:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030259AbWJJUKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 16:10:32 -0400
Received: from excu-mxob-1.symantec.com ([198.6.49.12]:23179 "EHLO
	excu-mxob-1.symantec.com") by vger.kernel.org with ESMTP
	id S1030257AbWJJUKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 16:10:32 -0400
Date: Tue, 10 Oct 2006 21:10:09 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
cc: "'David Gibson'" <david@gibson.dropbear.id.au>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: RE: Hugepage regression
In-Reply-To: <000101c6eca2$7e84fe60$cb34030a@amr.corp.intel.com>
Message-ID: <Pine.LNX.4.64.0610102045190.24759@blonde.wat.veritas.com>
References: <000101c6eca2$7e84fe60$cb34030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 10 Oct 2006 20:09:55.0706 (UTC) FILETIME=[0DD065A0:01C6ECA8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2006, Chen, Kenneth W wrote:
> Hugh Dickins wrote on Tuesday, October 10, 2006 12:18 PM
> 
> > But again, I protest
> > the "if (vma->vm_file)" in your unmap_hugepage_range - how would a
> > hugepage area ever have NULL vma->vm_file?
> 
> It's coming from do_mmap_pgoff(), file->f_op->mmap can fail with error
> code (e.g. not enough hugetlb page) and in the error recovery path, it
> nulls out vma->vm_file first before calls down to unmap_region().

I stand corrected: thanks.

> I asked that question before:

So you did, on Oct 2nd: sorry, that got lost amidst the overload in
my mailbox, I've just forwarded it to myself again, to check later
on what else I may have missed.  (I am aware that I've still not
scrutinized the patches you sent out a day or two later, now in -mm.)

> can we reverse that order (call unmap_region
> and then nulls out vma->vmfile and fput)?

I'm pretty sure we cannot: the ordering is quite intentional, that if
a driver ->mmap failed, then it'd be wrong to call down to driver in
the unmap_region (if a driver is nicely behaved, that unmap_region
shouldn't be unnecessary; but some do rely on us clearing ptes there).

Okay, last refuge of all who've made a fool of themselves:
may I ask you to add a comment in your unmap_hugepage_range,
pointing to how the do_mmap_pgoff error case NULLifies vm_file?

(Or else change hugetlbfs_file_mmap to set VM_HUGETLB only once it's
succeeded: but that smacks of me refusing to accept I was wrong.)

Hugh

> 
> unmap_and_free_vma:
>         if (correct_wcount)
>                 atomic_inc(&inode->i_writecount);
>         vma->vm_file = NULL;
>         fput(file);
> 
>         /* Undo any partial mapping done by a device driver. */
>         unmap_region(mm, vma, prev, vma->vm_start, vma->vm_end);
