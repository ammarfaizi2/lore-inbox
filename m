Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267046AbRGIMVq>; Mon, 9 Jul 2001 08:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267049AbRGIMVh>; Mon, 9 Jul 2001 08:21:37 -0400
Received: from www.wen-online.de ([212.223.88.39]:55055 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S267046AbRGIMVZ>;
	Mon, 9 Jul 2001 08:21:25 -0400
Date: Mon, 9 Jul 2001 14:20:21 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Christoph Rohland <cr@sap.com>
cc: Rik van Riel <riel@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: VM in 2.4.7-pre hurts...
In-Reply-To: <m3vgl28huc.fsf@linux.local>
Message-ID: <Pine.LNX.4.33.0107091329390.318-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 Jul 2001, Christoph Rohland wrote:

> Hi Mike,
>
> On Mon, 9 Jul 2001, Mike Galbraith wrote:
> >> But still this may be a hint. You are not running out of swap,
> >> aren't you?
> >
> > I'm running oom whether I have swap enabled or not.  The inactive
> > dirty list starts growing forever, until it's full of (aparantly)
> > dirty pages and I'm utterly oom.
> >
> > With swap enabled, I keep allocating until there's nothing left.
> > Actual space usage is roughly 30mb (of 256mb), but when you can't
> > allocate anymore you're toast too, with the same dirt buildup.
>
> AFAIU you are running oom without the oom killer kicking in.

Yes.

> That's reasonable with tmpfs: the tmpfs pages are accounted to the
> page cache, but are not freeable if there is no free swap space. So
> the vm tries to free memory without success. (The same should be true
> for ramfs but exaggerated by the fact that ramfs can never free the
> page)

Why is it growing from stdout output?  (last message.. mail lag)

> In the -ac series I introduced separate accounting for shmem pages and
> do reduce the page cache size by this count for meminfo and
> vm_enough_memory. Perhaps the oom coding needs also some knowledge
> about this?

It doesn't _look_ like that would make a difference.

This is how the oom looks from here:

Start tar -rvf /dev/null /usr/local; box has 128mb ram/256mb swap

We have many dirty and many clean pages at first.  As the dcache/icache
etc grow beneath, we start consuming clean/dirty pages, but we don't
have a free shortage at first, so the caches bloat up.  We finally start
shrinking caches, but it's too late, and we allocate some swap.  (This
cannot be prevented even by VERY agressive aging/shrinking, even with
a hard limit to start shrinking caches whether we have a free shortage
or not)  It is impossible (or I can't get there from here anyway) to
keep the dirty list long enough to keep inactive_shortage happy.. we're
at full memory pressure, so we have to have a full 25% of ram inactive.

We keep allocating much swap and writing a little of it until slowly
but surely, we run out of allocatable swap.  In two runs taring up
an fs with 341057 inodes, swapspace is gone (but hardly used).

If I stop the tar _well_ before oom, and try to do swapoff, oom.

There is very little in /tmp, and tar isn't touching any of it.  X must
be pouring pages down a socket to my client, coz that's the only thing
in /tmp.  It seems to be leaking away whether we have swap active or not..
just a question of what we run out of first.. swapspace or pages to put
there.

	-Mike

