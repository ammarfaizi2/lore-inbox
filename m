Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272820AbRIIRFh>; Sun, 9 Sep 2001 13:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272819AbRIIRF1>; Sun, 9 Sep 2001 13:05:27 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:11017 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S272820AbRIIRFM>; Sun, 9 Sep 2001 13:05:12 -0400
Date: Sun, 9 Sep 2001 10:01:32 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Manfred Spraul <manfred@colorfullife.com>,
        Andrea Arcangeli <andrea@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: Purpose of the mm/slab.c changes
In-Reply-To: <E15g7jk-0007Rb-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0109090952380.14365-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 9 Sep 2001, Alan Cox wrote:
>
> > LIFO is obviously superior due to cache re-use.
>
> Interersting question however. On SMP without sufficient per CPU slab caches
> is tht still the case ?

That _should_ be fairly easily testable by just changing the cpucache
tuning, which yu can do through /proc. The default parameters look
reasonable, though.

Note, however, that as far as the slab is concerned, this issue never
exists, if only because all the lists are per-CPU. So the only way you can
get cross-CPU cache behaviour is (a) when the actual _use_ of the slab is
moved across CPU's and (b) when you have a page that ends up moving from
one CPU to the other through page allocation when the slab caches run out.

Case (a) is clearly rather independent of the actual slab allocation
logic, and depends on the _user_ of the allocation, not on the allocator
itself.

Case (b) implies that the page allocator might also should also find
per-CPU LIFO queues in front of the actual allocator useful. That might
certainly be worth-while looking into - although it would also increase
the risk of fragementation.

(Doing per-CPU LIFO queues for the actual page allocator would potentially
make page alloc/de-alloc much faster due to lower locking requirements
too. So you might have a double performance win if anybody wants to try
this out).

		Linus

