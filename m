Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263200AbUCXKNB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 05:13:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263214AbUCXKNB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 05:13:01 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:26919 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S263200AbUCXKM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 05:12:58 -0500
Date: Wed, 24 Mar 2004 10:12:58 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrea Arcangeli <andrea@suse.de>
cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: nonlinear swapping w/o pte_chains [Re: VMA_MERGING_FIXUP and
    patch]
In-Reply-To: <20040323214459.GG3682@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0403240931430.7474-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Mar 2004, Andrea Arcangeli wrote:
> 
> I don't think I can use the tlb gather because I've to set the pte back
> immediatly, or can I? The IPI flood and huge pagetable walk with total
> destruction of the address space with huge mappings will be very bad in
> terms of usability during swapping of huge nonlinear vmas, but hey, if
> you want to swap smoothly, you should use the vmas.

Thanks a lot for the preview (or would have been a preview if I'd been
awake - and now I've found it easiest to look at 2.6.5-rc1 patched with
the 2.6.5-rc1-aa2 objrmap and anon_vma you pointed Martin to in other
mail, which includes your latest fixes).

I think you're being too harsh on the nonlinear vmas!  I know you're
not keen on them, but punishing them this hard!  If I read it right,
page_referenced will never (unless PageReferenced, or mapped into
a nonlinear also) report a page from a nonlinear vma as referenced
(I do agree with that part).  So they'll soon reach try_to_unmap,
and each one which gets there will cause every page in every nonlinear
vma of that inode to be unmapped from the nonlinears right then?
Yes, that'll teach 'em to use sys_remap_file_pages without VM_LOCKED.

For mine I'll try to carry on with the less draconian approach I
started yesterday, scanning just a range each time (rather 2.4 style).

At the very least, I think your unmap (and mine) needs to
ptep_test_and_clear_young just before unmap_pte_page, and back out if
the page is young (referenced).  I was going to recommend that anyway:
at last got around to considering that issue of whether the failed
trylocks should report referenced or not (return 1 or 0).  Looking at
how shrink_list goes, even before 2.6.5-rc1, I'd expect it to behave
better your way (proceed to try_to_unmap, which will rightly say
SWAP_AGAIN if it fails the same trylock) than how it was before in
objrmap; but that will behave better with a ptep_test_and_clear_young
check first too.

Sorry to see the #if VMA_MERGING_FIXUPs are still there.  I've a
growing feeling that it won't make enough difference when they're
gone.  But maybe you have a cunning plan to merge all the anon_vmas
which would result from an mmap next page, write data in, mprotect ro,
mmap next page, write data in, mprotect ro, ..... workload.

Hugh

