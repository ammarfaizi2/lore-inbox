Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262126AbRE0UZR>; Sun, 27 May 2001 16:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262163AbRE0UZH>; Sun, 27 May 2001 16:25:07 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:52016 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S262126AbRE0UZB>; Sun, 27 May 2001 16:25:01 -0400
Date: Sun, 27 May 2001 22:24:45 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Subject: Re: [patch] severe softirq handling performance bug, fix, 2.4.5
Message-ID: <20010527222445.C731@athlon.random>
In-Reply-To: <Pine.LNX.4.33.0105261920030.3336-200000@localhost.localdomain> <20010527190700.H676@athlon.random> <15121.13986.987230.445825@pizda.ninka.net> <20010527195619.K676@athlon.random> <15121.20713.676075.980272@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15121.20713.676075.980272@pizda.ninka.net>; from davem@redhat.com on Sun, May 27, 2001 at 12:09:29PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 27, 2001 at 12:09:29PM -0700, David S. Miller wrote:
> "live lock".  What do you hope to avoid by pushing softirq processing
> into a scheduled task?  I think doing that is a stupid idea.

NOTE: I'm not pushing anything out of the atomic context, I'm using
ksoftirqd only to cure the cases that are getting wrong by the fast-path
code.

It fixes the 1/HZ latency with the idle task and it gets right the case
of softirq marked pending again under do_softirq.

> You are saying that if we are getting a lot of soft irqs we should
> defer it so that we can leave the trap handler, to avoid "live lock".

Yes, that is what all kernels out there are doing.

> I think this is a bogus scheme for several reasons.  First of all,
> deferring the processing will only increase the likelyhood that the
> locality of the data will be lost, making the system work harder.

Of course almost all the time the processing is not deferred.

> Secondly, if we are getting softirqs at such a rate, we have other
> problems.  We are likely getting surged with hardware interrupts, and
> until we have Jamals stuff in to move ethernet hardware interrupt
> handling into softirqs your deferrals will be fruitless when they do
> actually trigger.  We will be livelocked in hardware interrupt
> processing instead of being livelocked in softirq processing, what an
> incredible improvement. :-)

The sofitrq could be marked running also from another softirq, it
doesn't need to be an interrupt.

> from trap, no matter what kind, call do_softirq if softirqs are
> pending.

that just happens, I assume you mean you prefer to remove mask &=
~active from do_softirq() internally.

But doing that will hang in irq as soon as a softirq or tasklet or
that marks itself running again in software (and I think this happens
just now in some driver to poll the hardware from atomic context where
you cannot schedule).  Furthmore the softirq is going to take more time
than the irq core itself, so the live lock issue is not so obvious as
you say I think.

> Again, I am totally against ksoftirqd, I think it's a completely dumb
> idea.  Softirqs were meant to be as light weight as possible, don't
> crap on them like this with this heavyweight live lock "solution".
> It isn't even solving live locks, it's rather trading one kind for
> another with zero improvement.

softirq is still as light as possible but without ksoftirq the logic is
wrong in some case, and so it can get a seneless 1/HZ latency sometime.
ksofitrqd fixes all those broken cases in a clean manner.

I'd like to know how much it helps on the gigabit benchmarks. For the
100mbit ethernet that I can test locally it is fine.

Andrea
