Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277729AbRJ3UIh>; Tue, 30 Oct 2001 15:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277756AbRJ3UI1>; Tue, 30 Oct 2001 15:08:27 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:56627 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S277729AbRJ3UIH>; Tue, 30 Oct 2001 15:08:07 -0500
Date: Tue, 30 Oct 2001 21:05:53 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Hugh Dickins <hugh@veritas.com>,
        Frank Dekervel <Frank.dekervel@student.kuleuven.ac.Be>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: need help interpreting 'free' output.
Message-ID: <20011030210553.A1340@athlon.random>
In-Reply-To: <20011030195828.X1340@athlon.random> <Pine.LNX.4.33.0110301117220.12145-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.33.0110301117220.12145-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Oct 30, 2001 at 11:21:46AM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2001 at 11:21:46AM -0800, Linus Torvalds wrote:
> 
> On Tue, 30 Oct 2001, Andrea Arcangeli wrote:
> >
> > So in short we only need to replace the lock_page with a TryLockPage
> > (plus your wait_on_page if page is not uptodate to catch the major
> > faults) and here we go, faster than pre5.
> 
> Wrong.
> 
> If _anybody_ accesses the page unlocked, you cannot do the swap_count() at
> all, because then you don't have anything that serializes the accesses to
> swap_count vs page_count any more.

incidentally if trylock fails do_wp_page doesn't even try to check the
swap count, it just lefts the swap cache there. same thing do_swap_page
can do at the early-cow stage. this is the only point I'm making.

and as said if you want to do any remove_exclusive_swap_page() in
do_swap_page as you claimed in earlier email you also need to get the
page lock.

As far I can tell here the magic key is "trylock" and nothing else, it's
not that the remove_exclusive_swap_page or the avoidance of the
early-cow per se can make any difference (let's ignore swapoff) except
running slower, here the only improvement during swapout load is that
you're delegating the work of remove_exclusive_swap_page to do_wp_page
that will do a trylock instead of a lock_page as far I can tell. This is
the only point I'm making.

Go ahead and implement this thing in do_swap_page:

        remove = 0;
        if ((vm_swap_full() && (remove = exclusive_swap_cache_delete())) ||
            only_swap_user()) {
                pte = mk_pte(page, vma->vm_page_prot);
                if (remove || write_access)
                        pte = pte_mkdirty(pte);
                if (vma->vm_page_prot & VM_WRITE)
                        pte = pte_mkwrite(pte);
                install_pte();
                return;
        }

and you'll find yourself grabbing the page lock somehow first in the
do_swap_page path, or exclusive_swap_cache_delete will obviously BUG()
on you.

This is why I'm saying the real magic is to conver the lock_page of pre4
in a TryLockPage, all other changes are not interesting in real load and
I obviously agree that's very good idea to fix the minor faults, that
in pre4 (and all previous kernels including all -ac and -aa) are running
as slow as major faults!

Now about the real need of exclusive_swap_cache_delete compared to
exclusive_swap_page I need to think a little more about it to be sure.

In sort previously we run exclusive_swap_page only with the page lock,
page->buffers is constant if the page is locked. And swap count and page
count _can't_ increase under us if the page happen to be exclusive once.
This was the previous rule at least, but as usual there's the swapoff
evil caming out and doing the lookup on a exclusive swap page... Hugh
may provide more hints on this case.

Andrea
