Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277366AbRJ3SRh>; Tue, 30 Oct 2001 13:17:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277363AbRJ3SRX>; Tue, 30 Oct 2001 13:17:23 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:31776 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S277330AbRJ3SQK>; Tue, 30 Oct 2001 13:16:10 -0500
Date: Tue, 30 Oct 2001 19:16:12 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Hugh Dickins <hugh@veritas.com>,
        Frank Dekervel <Frank.dekervel@student.kuleuven.ac.Be>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: need help interpreting 'free' output.
Message-ID: <20011030191612.S1340@athlon.random>
In-Reply-To: <20011030183912.P1340@athlon.random> <Pine.LNX.4.33.0110300943070.8603-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.33.0110300943070.8603-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Oct 30, 2001 at 09:53:28AM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2001 at 09:53:28AM -0800, Linus Torvalds wrote:
> 
> On Tue, 30 Oct 2001, Andrea Arcangeli wrote:
> >
> > On Tue, Oct 30, 2001 at 09:28:29AM -0800, Linus Torvalds wrote:
> > > Does anybody see why we have to remove it from the swap cache at all?
> >
> > the only reason is to avoid wasting the swap space, so at least Rik's
> > vm_swap_full logic should be added to it.
> 
> I agree, but that's true both for reads and writes, and then we want to

yes.

> delete it. So the logic might be something like
> 
> 	remove = 0;
> 	if ((vm_swap_full() && (remove = exclusive_swap_cache_delete())) ||
> 	    only_swap_user()) {

I preferred the previous exclusive_swap_page logic. It couldn't race
because we had the lock on the page, it's equivalent and it looked
cleaner and simpler to me, we had to bother about the rest only if the
page was exclusive.  Now this only_swap_user replaces the
exclusive_swap_cache check basically and you will end doing the double
of the work if the vm is full and the page isn't exclusive, so both
exclusive_swap_cache_delete and only_swap_user will have to work and
fail.

> 		pte = mk_pte(page, vma->vm_page_prot);
> 		if (remove || write_access)
> 			pte = pte_mkdirty(pte);
> 		if (vma->vm_page_prot & VM_WRITE)
> 			pte = pte_mkwrite(pte);
> 		install_pte();
> 		return;
> 	}
> 
> ie we _remove_ it if we're low on swap entries and it is exclusive (that
> doesn't really save memory, but it allows us to re-use the swap entries
> for "better" pages), and we just re-use it without removing it if we're
> the only users (it doesn't even have to be a write access - we can do it
> even for reads, as if we're the only user we might as well just give the
> page to the process anyway - and let fork() do the thing it does in any
> case.
> 
> Then we'll just trust the dirty bit when shared, like we always have done
> before anyway (we need to set it on removal, and we want to set it early
> on a write access to avoid unnecessary faults on architectures which do
> the dirty bit in software - that's why we have the "remove ||
> write_access"  test there.

ok.

> 
> > The only advantage of dirty swap cache persistence is that it will
> > maintain the same position on disk across a swapin/swapout cycle.
> 
> Well, the _big_ advantage is not the persistence, but the fact that the
> page might be in-flight when the user wants to use it, and the swap cache
> is just busy. Right now we _wait_ for the write to complete, which is
> silly. We might as well just let the user start using the page (including
> writing more stuff to it), and later on write it again.

if we remove all write-swapins from the swap cache those pages cannot be
in flight, we cannot do I/O on anon memory if it's not in the swapcache
or we would race badly. all I/O to the swap space have to pass through
the swap cache to be safe. So I don't see how an anonymous page can be
in flight.

> So right now the "remove from swap cache" is actually a IO-serializing
> operation, and we're doing it for no really good reason.

I think this is not true. remove_from_swap_cache can be run only if:

1) we hold the lock on the page
2) this mean all I/O is complete and so we can safely convert this
   non in-flight page to an anonymous page clean where any further
   I/O will be impossible

So I still think the only advantage is to keep the swap position
persistent across a swapin/swapout cycle.

Andrea
