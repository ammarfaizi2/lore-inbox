Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751103AbVH1EZI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbVH1EZI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 00:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750988AbVH1EZI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 00:25:08 -0400
Received: from silver.veritas.com ([143.127.12.111]:1620 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1751103AbVH1EZH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 00:25:07 -0400
Date: Sun, 28 Aug 2005 05:26:55 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Linus Torvalds <torvalds@osdl.org>, Rik van Riel <riel@redhat.com>,
       Ray Fucillo <fucillo@intersystems.com>, linux-kernel@vger.kernel.org
Subject: Re: process creation time increases linearly with shmem
In-Reply-To: <43108136.1000102@yahoo.com.au>
Message-ID: <Pine.LNX.4.61.0508280500450.3323@goblin.wat.veritas.com>
References: <430CBFD1.7020101@intersystems.com> <430D0D6B.100@yahoo.com.au>
 <Pine.LNX.4.63.0508251331040.25774@cuia.boston.redhat.com>
 <430E6FD4.9060102@yahoo.com.au> <Pine.LNX.4.58.0508252055370.3317@g5.osdl.org>
 <Pine.LNX.4.61.0508261220230.4697@goblin.wat.veritas.com>
 <Pine.LNX.4.58.0508261052330.3317@g5.osdl.org>
 <Pine.LNX.4.61.0508261917360.8477@goblin.wat.veritas.com>
 <Pine.LNX.4.63.0508261910080.8057@cuia.boston.redhat.com>
 <Pine.LNX.4.58.0508261621410.3317@g5.osdl.org> <43108136.1000102@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 28 Aug 2005 04:24:58.0771 (UTC) FILETIME=[7344AE30:01C5AB88]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Aug 2005, Nick Piggin wrote:
> 
> This is the condition I ended up with. Any good?
> 
> if (!(vma->vm_flags & (VM_HUGETLB|VM_NONLINEAR|VM_RESERVED))) {
> if (vma->vm_flags & VM_MAYSHARE)
>  return 0;
> if (vma->vm_file && !vma->anon_vma)
>    return 0;
> }

It's not bad, and practical timings are unlikely to differ, but your
VM_MAYSHARE test is redundant (VM_MAYSHARE areas don't have anon_vmas *),
and your vm_file test is unnecessary, excluding pure anonymous areas
which haven't yet taken a fault.

Please do send Andrew the patch for -mm, Nick: you were one of the
creators of this (don't omit credit to Ray, Parag, Andi, Rik, Linus),
much better that it go in your name (heh, heh, heh, can you trust me?)

Hugh

* That's ignoring, as we do everywhere else, the case which came up
a couple of weeks back in discussions with Linus, ptrace writing to
an area the process does not have write access to, creating an anon
page within a shared vma: that's an awkward case currently mishandled,
but the patch below does it no harm.

--- 2.6.13-rc7/mm/memory.c	2005-08-24 11:13:41.000000000 +0100
+++ linux/mm/memory.c	2005-08-28 04:48:34.000000000 +0100
@@ -498,6 +498,15 @@ int copy_page_range(struct mm_struct *ds
 	unsigned long addr = vma->vm_start;
 	unsigned long end = vma->vm_end;
 
+	/*
+	 * Assume the fork will probably exec: don't waste time copying
+	 * ptes where a page fault will fill them correctly afterwards.
+	 */
+	if (!(vma->vm_flags & (VM_HUGETLB|VM_NONLINEAR|VM_RESERVED))) {
+		if (!vma->anon_vma)
+			return 0;
+	}
+
 	if (is_vm_hugetlb_page(vma))
 		return copy_hugetlb_page_range(dst_mm, src_mm, vma);
 
