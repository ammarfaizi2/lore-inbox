Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280825AbRLQP72>; Mon, 17 Dec 2001 10:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280836AbRLQP7S>; Mon, 17 Dec 2001 10:59:18 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:41259 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S280825AbRLQP7F>; Mon, 17 Dec 2001 10:59:05 -0500
Date: Mon, 17 Dec 2001 16:58:45 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Benjamin LaHaise <bcrl@redhat.com>, Rik van Riel <riel@conectiva.com.br>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: mempool design
Message-ID: <20011217165845.C2431@athlon.random>
In-Reply-To: <20011217160426.U2431@athlon.random> <Pine.LNX.4.33.0112171806020.14039-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.33.0112171806020.14039-100000@localhost.localdomain>; from mingo@elte.hu on Mon, Dec 17, 2001 at 06:21:53PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2001 at 06:21:53PM +0100, Ingo Molnar wrote:
> 
> On Mon, 17 Dec 2001, Andrea Arcangeli wrote:
> 
> > This whole long thread can be resumed in two points:
> >
> > 1	mempool reserved memory is "wasted" i.e. not usable as cache
> 
> reservations, as in Ben's published (i know, incomplete) implementation,
> are 'wasted' as well.

yes, I was referring only about his long term design arguments.

> > 2	if the mempool code is moved inside the memory balancing of the
> > 	VM we could use this memory as clean, atomically-freeable cache
> 
> i agree - i proposed something like this to SCT about 3-4 years ago (back
> when the buffer-cache was still reentrant), and it's still not
> implemented. And i'm not betting on it being done soon. Making the
> pagecache structures IRQ-safe looks like the same kind of trouble we had
> with the IRQ-reentrant buffer-cache. It can be done (in fact it's quite
> easy to do the initial bits), but it can bite us in multiple ways. And in
> the real deadlock scenarios we have no clean pages anyway.

in theory those pages should be reserved, so it would be the same like
the pages in the mempool, but while they do nothing they could hold some
cache data, but for example they couldn't be either mapped in any
address space etc... at least unless we're able to atomically unmap
pages and flush tlb in all cpus etc.. :) it would be a mess and it's not
a concidence that Ben's first implementation wasn't taking adantage of
it and that in 3-4 years it's still not there yet :). Plus as you
mentioned it would add the local_save_irq overhead to the common path as
well, to be able to do things from irqs (which I didn't considered in
the previous email). That would hurt performance.

> i personally get the shivers from any global counters where being off by 1
> in 1% of the cases will bite us only in 1 out of 10000 systems.

yes, and as said it's a problem that doesn't affect performance or
scalability, nor it wastes a _percentage_ of ram, it only wastes a
_fixed_ amount of ram.

> > Personally I'm more relaxed with the mempool approch because it
> > reduces the complexity of an order of magnitude, it abstracts the
> > thing without making the memory balancing more complex and it
> > definitely solve the problem (if used correctly i.e. not two alloc_bio
> > in a row from the same pool from multiple tasks at the same time as
> > pointed out by Ingo).
> 
> yep - and as your VM rewrite has proven it as well, reducing complexity
> and interdependencies within the VM is the top priority at the moment and
> brings the most benefits. And the amount of reserved (lost) pool-pages
> does not scale up with more RAM in the system - it scales up with more
> devices (and more mounted filesystems) in the system. And we have
> per-device RAM footprint anyway. So it's not like 'struct page'.

100% agreed (as said above too :).

Andrea
