Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280531AbRLQPYw>; Mon, 17 Dec 2001 10:24:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280448AbRLQPYn>; Mon, 17 Dec 2001 10:24:43 -0500
Received: from mx2.elte.hu ([157.181.151.9]:10122 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S280387AbRLQPY1>;
	Mon, 17 Dec 2001 10:24:27 -0500
Date: Mon, 17 Dec 2001 18:21:53 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Benjamin LaHaise <bcrl@redhat.com>, Rik van Riel <riel@conectiva.com.br>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: mempool design
In-Reply-To: <20011217160426.U2431@athlon.random>
Message-ID: <Pine.LNX.4.33.0112171806020.14039-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 17 Dec 2001, Andrea Arcangeli wrote:

> This whole long thread can be resumed in two points:
>
> 1	mempool reserved memory is "wasted" i.e. not usable as cache

reservations, as in Ben's published (i know, incomplete) implementation,
are 'wasted' as well.

> 2	if the mempool code is moved inside the memory balancing of the
> 	VM we could use this memory as clean, atomically-freeable cache

i agree - i proposed something like this to SCT about 3-4 years ago (back
when the buffer-cache was still reentrant), and it's still not
implemented. And i'm not betting on it being done soon. Making the
pagecache structures IRQ-safe looks like the same kind of trouble we had
with the IRQ-reentrant buffer-cache. It can be done (in fact it's quite
easy to do the initial bits), but it can bite us in multiple ways. And in
the real deadlock scenarios we have no clean pages anyway.

i personally get the shivers from any global counters where being off by 1
in 1% of the cases will bite us only in 1 out of 10000 systems.

> Personally I'm more relaxed with the mempool approch because it
> reduces the complexity of an order of magnitude, it abstracts the
> thing without making the memory balancing more complex and it
> definitely solve the problem (if used correctly i.e. not two alloc_bio
> in a row from the same pool from multiple tasks at the same time as
> pointed out by Ingo).

yep - and as your VM rewrite has proven it as well, reducing complexity
and interdependencies within the VM is the top priority at the moment and
brings the most benefits. And the amount of reserved (lost) pool-pages
does not scale up with more RAM in the system - it scales up with more
devices (and more mounted filesystems) in the system. And we have
per-device RAM footprint anyway. So it's not like 'struct page'.

	Ingo

