Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276162AbRI1Qs3>; Fri, 28 Sep 2001 12:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276158AbRI1QsU>; Fri, 28 Sep 2001 12:48:20 -0400
Received: from chiara.elte.hu ([157.181.150.200]:32271 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S276156AbRI1QsM>;
	Fri, 28 Sep 2001 12:48:12 -0400
Date: Fri, 28 Sep 2001 18:46:16 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Linus Torvalds <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        <bcrl@redhat.com>
Subject: Re: [patch] softirq performance fixes, cleanups, 2.4.10.
In-Reply-To: <20010928183244.K24922@athlon.random>
Message-ID: <Pine.LNX.4.33.0109281835370.8840-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 28 Sep 2001, Andrea Arcangeli wrote:

> he's allowing to repeat the loop more than once to hide it, [...]

it's not done to 'hide' it in any way. I removed the mask method because
it's redundant under the new scheme.

Softirqs *cannot* be handled 'fairly', there is always going to be one
that is called sooner, and one that is called later, and even with the old
code, their position within the bitmask decides which one goes first.

> to do the "mask" with repetition correctly we'd need a per-softirq
> counter, not just a bitmask so it wouldn't be handy to allocate on the
> stack, but it's nothing unfixable.

with a repetition count of 10, there is no difference, and no reason to
add the mask mechanizm again. (In fact it will statistically more fair
because we 'interleave' the softirqs in a fair pattern.)

to make it easier to compare, here are verbal descriptions of the two
mechanizms. (for those who have *cough* trouble understanding the patch.)

the old code's "mask method": it starts processing softirqs in strict
order. It will reprocess any softirq (in strict order again) that got
reactivated meanwhile, but it will only process softirqs that were not
processed yet during this run.

it's not roundrobin, and it's not fair in any way, there is a strict
priority between softirqs, with the additional twist of processing
softirqs that got activated meanwhile. This concept is completely
meaningless, it neither tries to process all pending softirqs, nor does it
try implement some simple policy, like 'process all softirqs that are
active *now* and *once*'.

the new method does a simple loop (in priority order, first HI, then TX,
then RX and LO) over all currently active softirqs, then it does a
(limited) loop over all of them again if some softirq got activated while
these were processed.

	Ingo

