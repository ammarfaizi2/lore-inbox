Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277371AbRKFCOB>; Mon, 5 Nov 2001 21:14:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277514AbRKFCNv>; Mon, 5 Nov 2001 21:13:51 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:45318 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S277371AbRKFCNr>; Mon, 5 Nov 2001 21:13:47 -0500
Date: Mon, 5 Nov 2001 18:10:47 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [Ext2-devel] disk throughput
In-Reply-To: <Pine.GSO.4.21.0111052029260.27086-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.33.0111051748250.1710-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 5 Nov 2001, Alexander Viro wrote:
>
> Depends on the naming scheme used by admin, for one thing.  Linus, I seriously
> think that getting the real-life traces to play with would be a Good Thing(tm)
> - at least that would allow to test how well would heuristics of that kind do.

Well, we hae some real-life traces. Those particular real-life traces show
that the "switch cylinder groups on mkdir" heuristic sucks.

And you have to realize that _whatever_ we do, it will always be a
heuristic. We don't know what the right behaviour is without being able to
predict the future. Agreed?

Ok, so let's just assume that we had no heuristic in place at all, and we
were looking at improving it for slow-growth situations. I think you'd
agree that decreasing the performance of a CVS checkout five-fold would be
considered _totally_ unacceptable for a new heuristic, no?

So the current heuristic provably sucks. We have cold hard numbers, and
quite frankly, Al, there is very very little point in arguing against
numbers. It's silly. "Gimme an S, gimme a U, gimme a C, gimme a K -
S-U-C-K". The current one sucks.

So the only question on the table is not "do we stay with the current
algorithm", because I dare you, the answer to that question is very
probably a clear "NO". So there's no point in even trying to find out
_why_, in 1984, it was considered a good heuristic.

The question is: "what can we do to improve it?". Not "what arguments can
we come up with to make excuses for a sucky algorithm that clearly does
the wrong thing for real-life loads".

One such improvement has already been put on the table: remove the
algorithm, and make it purely greedy.

We know that works. And yes, we realize that it has downsides too. Which
is why some kind of hybrid is probably called for. Come up with your own
sixth sense. We know the current one is really bad for real-life loads.

I actually bet that the greedy algorithm would work wonderfully well, if
we just had run-time balancing. I bet that the main argument for
"spreading things out" is that it minimizes the risk of overflow in any
particular group, never mind performance.

And if you're stuck with the decision you make forever, minimizing risk is
a good approach.

And maybe the fundamental problem is exactly that: because we're stuck
with our decision forever, people felt that they couldn't afford to risk
doing what was very obviously the right thing.

So I still claim that we should look for short-time profit, and then try
to fix up the problems longer term. With, if required, some kind of
rebalancing.

		Linus

