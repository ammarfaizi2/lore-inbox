Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268920AbRHFRsM>; Mon, 6 Aug 2001 13:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268921AbRHFRsC>; Mon, 6 Aug 2001 13:48:02 -0400
Received: from [63.209.4.196] ([63.209.4.196]:14854 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268920AbRHFRrt>; Mon, 6 Aug 2001 13:47:49 -0400
Date: Mon, 6 Aug 2001 10:46:28 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: "David S. Miller" <davem@redhat.com>, Andrea Arcangeli <andrea@suse.de>,
        David Luyer <david_luyer@pacific.net.au>,
        <linux-kernel@vger.kernel.org>
Subject: Re: /proc/<n>/maps growing...
In-Reply-To: <Pine.LNX.4.33L.0108061311120.1439-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0108061035320.8972-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 6 Aug 2001, Rik van Riel wrote:

> On Mon, 6 Aug 2001, David S. Miller wrote:
> > Andrea Arcangeli writes:
> >  > Can somebody see a problem with this design?
> >
> > As someone who was involved when the merge_segments stuff got tossed
> > by Linus, the reason was that the locking is utterly atrocious.
>
> Mmmm, don't we ONLY need to hold both the mm->mmap_sem for
> write access and the mm->page_table_lock ?

No. We used to merge non-NULL files too in 2.2.x, which meant that we had
to also hold mapping->i_shared_lock.

Also, the locking order for that is (due to the MM layer) _different_ from
the one we'd like: we need to get the "i_shared_lock" before we get the
page table lock.

ALSO, we have the issue of calling the "vm_ops->open()" routine - we need
to call that one with the MM semaphore held, but without any of the
spinlocks held. This one is also kind of interesting: if we merge with an
existing memory map we must _not_ call the open routine at all (it's
already open), while if we add a new one we do have to call it.

This was another reason why I removed the merging: I could not for the
life of me see how that merging could possibly be correct with some of the
special character drivers we have right now. In particular, some drivers
"open()" routines not just increment usage counts, but also check the
limits and allocate backing space.

Which means that there is _no_ way we can merge such a vma - we'd have to
call "->open()" for it to get the security checks etc, but we could not
increment usage counts, or whatever.

So what the old merging code used to do was:
 - ignore the fundamental "->open()" problem, on the theory that it
   doesn't happen in real life (correct, btw. But it can happen if you're
   a cracker trying to break in to the system)
 - get and drop the locks, which meant that we did hold the locks for all
   the operations we did, but we dropped them in between - so the code
   would drop the page table lock, get the i_shared_lock, and re-get the
   page table lock etc.

Did I mention that the old code was buggy and slow? And that fixing it was
hard? Which is, surprise surprise, why 2.4.x takes the approach of merging
only things that it _knows_ are (a) common and (b) safe to merge.

		Linus

