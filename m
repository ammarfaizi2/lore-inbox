Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277756AbRJ3U0a>; Tue, 30 Oct 2001 15:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278004AbRJ3U0U>; Tue, 30 Oct 2001 15:26:20 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:520 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S277756AbRJ3U0Q>; Tue, 30 Oct 2001 15:26:16 -0500
Date: Tue, 30 Oct 2001 12:25:36 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Hugh Dickins <hugh@veritas.com>,
        Frank Dekervel <Frank.dekervel@student.kuleuven.ac.Be>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        <linux-kernel@vger.kernel.org>
Subject: Re: need help interpreting 'free' output.
In-Reply-To: <20011030210553.A1340@athlon.random>
Message-ID: <Pine.LNX.4.33.0110301213080.1281-100000@athlon.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 30 Oct 2001, Andrea Arcangeli wrote:
>
> incidentally if trylock fails do_wp_page doesn't even try to check the
> swap count, it just lefts the swap cache there. same thing do_swap_page
> can do at the early-cow stage. this is the only point I'm making.

Yes.

At some point we need to lock the page _if_ we actually decide we have to
do something with it. The current strategy is along the lines: if we can
obviously share it, let's do so, but let's not wait for it to be
unsharable.

> Go ahead and implement this thing in do_swap_page:
>
>         remove = 0;
>         if ((vm_swap_full() && (remove = exclusive_swap_cache_delete())) ||
>             only_swap_user()) {
>                 pte = mk_pte(page, vma->vm_page_prot);
>                 if (remove || write_access)
>                         pte = pte_mkdirty(pte);
>                 if (vma->vm_page_prot & VM_WRITE)
>                         pte = pte_mkwrite(pte);
>                 install_pte();
>                 return;
>         }
>
> and you'll find yourself grabbing the page lock somehow first in the
> do_swap_page path, or exclusive_swap_cache_delete will obviously BUG()
> on you.

We'll trylock it yes, but that has nothing to do with the page count
protections. We'll trylock it if we end up _deleting_ the page, but not
for count reasons, but because deletion needs the lock in order to wait
for pages.

And realize that that is the really rare case, where we really don't care
for performance - we've just realized that we don't even have enough swap
for the kind of load the machine is under.

So your point is that the "we're out of swap space" case is a bit slower
because we potentially take the swapspace spinlocks twice? Sure.

But look at the fast paths: no waiting anywhere, and no unnecessary locks.

> This is why I'm saying the real magic is to conver the lock_page of pre4
> in a TryLockPage, all other changes are not interesting in real load

NO NO NO.

Read my mails again.

Th epage lock used to protect the integrity of the "swap_count()" test
(which is part of the old "exclusive_swap_page()"). The ruls was: the
swap count cannot change on a page when it is locked.

Making the lock_page() be a TryLockPage, and doing the "swap_free()"
without holding the page lock means that that integrity NO LONEGR EXISTS.

Which means that the old "exclusive_swap_page()" DOES NOT WORK RELIABLY.
It tested "page_count()" and "swap_count()" in ways that were no longer
guaranteed to be meaningful - swap_count() could go down to 1 _after_
somebody else had incremented "page_count()" on another CPU due to a
swap-in of another process that shared the swap entry (or even another
thread on the same MM - we don't hold the page table spinlock there)..

Do you get it now?

By making the unconditional "always lock the page on swap-in" be a "try to
lock the page if you _need_ to", exclusive_swap_page() no longer worked,
and had to be gotten rid of or at least changed to do the right thing.
Considering that all users of the function also wanted to remove the page,
the change was obvious.

Might we want to split it up differently if we do the "only_user()"?
Maybe.  But _please_ realize that the changes in pre5 are correctness
fixes, not some random movement of code.

		Linus

