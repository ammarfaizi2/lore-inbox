Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316293AbSEQQJg>; Fri, 17 May 2002 12:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316295AbSEQQJf>; Fri, 17 May 2002 12:09:35 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:50298 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S316293AbSEQQJe>; Fri, 17 May 2002 12:09:34 -0400
Date: Fri, 17 May 2002 17:17:56 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@zip.com.au>, Paul Faure <paul@engsoc.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Process priority in 2.4.18 (RedHat 7.3)
Message-ID: <20020517151755.GH11512@dualathlon.random>
In-Reply-To: <20020517143537.GG11512@dualathlon.random> <E178jAR-0006gD-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2002 at 03:57:15PM +0100, Alan Cox wrote:
> Hardly takes a flood of IRQ's. A tiny burst of interrupts will happily
> trigger it 

hmm, tiny != burst. of course sometime ksoftirqd will kick in when it
notices a burst. But it is irrelevant to this thread about SCHED_FIFO +
ksoftirqd.

If there's SCHED_FIFO app in loop, ksoftirqd never runs and we only rely
on the support from irq that we had in 2.4.0 and previous too.

returning to the other issue about the fake burst that stops immediatly,
it should be easy to write a small heuristic to avoid scheduling
ksoftirqd in those cases, two different ways could be to simply count
the number of do_softirq invocations outside ksofitrqd per jiffy and to
skip waking up ksoftirqd if the frequency is high enough, this would fix
the minor schedule overhead during the fake burst, however this may not
be optimal for NAPI if for whatever reason there's an irq flood from
some other device in background, so I would actually prefer to detect
when ksoftirqd stops immediatly, it's a bit more complicated but more
generic, if it always stops immediatly then we make it harder to kick it
in. Note that I also benchmarked the effect softirqd in the early days
and I couldn't notice any performance drawback with using netpipe on
100Mbit tulip both on the small fragments (higher burst) and on the big
fragments, so whatever regression it is it is a minor issue and it
definitely pays off the polishing of all the other important cases so
cleanly (NAPI, rcu-poll, ppa, irq flood even on 10Mbit, even if you
block the hard irq with ratelimit you still can hang in the softirq code
without ksofitrqd otherwise you risk to introduce a 10msec latency to
the softirq processing, you don't know how long the softirq load takes
etc..).  It is true that even with ksoftirqd you may hang if the softirq
load takes exactly the same frequency of the do_softirq calls, but
that's not a pratical case, you cannot stay exactly on the border for a
relevant time, while you can pratically go over the border as long as
you want.

Andrea
