Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277322AbRJ3Rz0>; Tue, 30 Oct 2001 12:55:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277316AbRJ3RzR>; Tue, 30 Oct 2001 12:55:17 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:61712 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S277152AbRJ3RzF>; Tue, 30 Oct 2001 12:55:05 -0500
Date: Tue, 30 Oct 2001 09:53:28 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Hugh Dickins <hugh@veritas.com>,
        Frank Dekervel <Frank.dekervel@student.kuleuven.ac.Be>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        <linux-kernel@vger.kernel.org>
Subject: Re: need help interpreting 'free' output.
In-Reply-To: <20011030183912.P1340@athlon.random>
Message-ID: <Pine.LNX.4.33.0110300943070.8603-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 30 Oct 2001, Andrea Arcangeli wrote:
>
> On Tue, Oct 30, 2001 at 09:28:29AM -0800, Linus Torvalds wrote:
> > Does anybody see why we have to remove it from the swap cache at all?
>
> the only reason is to avoid wasting the swap space, so at least Rik's
> vm_swap_full logic should be added to it.

I agree, but that's true both for reads and writes, and then we want to
delete it. So the logic might be something like

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

ie we _remove_ it if we're low on swap entries and it is exclusive (that
doesn't really save memory, but it allows us to re-use the swap entries
for "better" pages), and we just re-use it without removing it if we're
the only users (it doesn't even have to be a write access - we can do it
even for reads, as if we're the only user we might as well just give the
page to the process anyway - and let fork() do the thing it does in any
case.

Then we'll just trust the dirty bit when shared, like we always have done
before anyway (we need to set it on removal, and we want to set it early
on a write access to avoid unnecessary faults on architectures which do
the dirty bit in software - that's why we have the "remove ||
write_access"  test there.

> The only advantage of dirty swap cache persistence is that it will
> maintain the same position on disk across a swapin/swapout cycle.

Well, the _big_ advantage is not the persistence, but the fact that the
page might be in-flight when the user wants to use it, and the swap cache
is just busy. Right now we _wait_ for the write to complete, which is
silly. We might as well just let the user start using the page (including
writing more stuff to it), and later on write it again.

So right now the "remove from swap cache" is actually a IO-serializing
operation, and we're doing it for no really good reason.

		Linus

