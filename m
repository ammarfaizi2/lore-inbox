Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263726AbUCXOgk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 09:36:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263727AbUCXOgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 09:36:40 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:33933
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263726AbUCXOgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 09:36:37 -0500
Date: Wed, 24 Mar 2004 15:37:29 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: nonlinear swapping w/o pte_chains [Re: VMA_MERGING_FIXUP and patch]
Message-ID: <20040324143729.GC2065@dualathlon.random>
References: <20040323214459.GG3682@dualathlon.random> <Pine.LNX.4.44.0403240931430.7474-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0403240931430.7474-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2004 at 10:12:58AM +0000, Hugh Dickins wrote:
> On Tue, 23 Mar 2004, Andrea Arcangeli wrote:
> > 
> > I don't think I can use the tlb gather because I've to set the pte back
> > immediatly, or can I? The IPI flood and huge pagetable walk with total
> > destruction of the address space with huge mappings will be very bad in
> > terms of usability during swapping of huge nonlinear vmas, but hey, if
> > you want to swap smoothly, you should use the vmas.
> 
> Thanks a lot for the preview (or would have been a preview if I'd been
> awake - and now I've found it easiest to look at 2.6.5-rc1 patched with
> the 2.6.5-rc1-aa2 objrmap and anon_vma you pointed Martin to in other
> mail, which includes your latest fixes).
> 
> I think you're being too harsh on the nonlinear vmas!  I know you're
> not keen on them, but punishing them this hard!  If I read it right,
> page_referenced will never (unless PageReferenced, or mapped into
> a nonlinear also) report a page from a nonlinear vma as referenced
> (I do agree with that part).  So they'll soon reach try_to_unmap,
> and each one which gets there will cause every page in every nonlinear
> vma of that inode to be unmapped from the nonlinears right then?
> Yes, that'll teach 'em to use sys_remap_file_pages without VM_LOCKED.

Yep ;)

> For mine I'll try to carry on with the less draconian approach I
> started yesterday, scanning just a range each time (rather 2.4 style).

That will DoS real life, that's why I had to be draconian.  after you
finished I'll send a testcase to test, that is a real life testcase not
an exploit. The only way to dominate complexity with a pagetable scan is
to do what 2.4 is doing, that is to drop all ptes we find it in our way
so the vm will stop calling try_to_unmap, we must avoid walking the vma
more than once to swap it out. This will cause a minor fault flood but
that's ok, it doesn't need to be fast at swapping.

> At the very least, I think your unmap (and mine) needs to
> ptep_test_and_clear_young just before unmap_pte_page, and back out if
> the page is young (referenced).  I was going to recommend that anyway:
> at last got around to considering that issue of whether the failed
> trylocks should report referenced or not (return 1 or 0).  Looking at
> how shrink_list goes, even before 2.6.5-rc1, I'd expect it to behave
> better your way (proceed to try_to_unmap, which will rightly say
> SWAP_AGAIN if it fails the same trylock) than how it was before in
> objrmap; but that will behave better with a ptep_test_and_clear_young
> check first too.

cute, I agree we should recheck the young bit inside.

> Sorry to see the #if VMA_MERGING_FIXUPs are still there.  I've a
> growing feeling that it won't make enough difference when they're
> gone.  But maybe you have a cunning plan to merge all the anon_vmas
> which would result from an mmap next page, write data in, mprotect ro,
> mmap next page, write data in, mprotect ro, ..... workload.

problem is that mprotect (and mremap) meging is low prio compared to
nonlinear==mlock and i_mmap{shared} complexity, so it'll address it only
after I've a scalable swapping for huge i_mmap{shared} list too, which
is a pre-requisite for merging, mprotect merging doesn't sounds
prerequisite, though I certainly agree we should fixup it soon (and
after we fix it it'll work for files too, something that never worked
todate, and I feel it'll be as important for files as it was so far for
anon ram, and nobody complained yet that it's not enabled for files ;).
