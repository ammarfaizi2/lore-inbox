Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276021AbRI1SbS>; Fri, 28 Sep 2001 14:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276229AbRI1SbK>; Fri, 28 Sep 2001 14:31:10 -0400
Received: from chiara.elte.hu ([157.181.150.200]:43279 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S276021AbRI1Sa4>;
	Fri, 28 Sep 2001 14:30:56 -0400
Date: Fri, 28 Sep 2001 20:28:59 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, <bcrl@redhat.com>,
        Andrea Arcangeli <andrea@suse.de>
Subject: Re: [patch] softirq performance fixes, cleanups, 2.4.10.
In-Reply-To: <200109281756.VAA04730@ms2.inr.ac.ru>
Message-ID: <Pine.LNX.4.33.0109281956200.9978-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 28 Sep 2001 kuznet@ms2.inr.ac.ru wrote:

> > Is your point to make the softirq loop to be sysctl-tunable?
>
> No. My point is to make it correctly eventually.

there is no 'technically correct' way but to process all softirqs
immediately. Ie. an infinite loop. The only reason why we are doing less
than that is to be nice to systems that can be overloaded.

> > show you slow enough systems which can be overloaded via hardirqs alone.)
>
> This problem has been solved ages ago. The only remaining question is
> how to make this more nicely.

this problem has not been solved. hardirqs have properties unlike to
softirqs that make it harder to overload them.

> > I think the technically most reasonable approach is to process softirqs
> > *as soon as possible*,
> ...
> > please point out flaws in this thinking.
>
> They are processed as soon as possible.

they are *not*. The old code deliberately ignores newly pending softirqs.

> Ingo, I told net_rx_action() is small do_softirq() restarting not 10,
> but not less than 300 times in row.

net_rx_action is 'small' in code, but not small in terms of cachemisses
and other, unavoidable overhead. It goes over device-side skbs which can
and will take several microseconds per packet.

> If this logic is wrong, you should explain why it is wrong. Looping
> dozen of times may look like cure, but for me it still looks rather
> like steroids.

the fundamental issue here that makes looping inevitable is the following
one. (not that looping itself is anything bad.) We enable hardirqs during
the processing of softirqs. We also guarantee exclusivity of softirq
processing. We also have multiple 'queues of work'. Ie. if a hardirq adds
some new work while we were off doing other work, then we have no choice
but look at this other work as well.  Ie. we have to loop. q.e.d.

in fact even the current code is a mini-loop of ~1.5 iterations, due to
the mask code. (which has the effect of processing 'a little bit more
work'.)

looping can of course be avoided - but only by breaking any of the above
assumptions. My patch took the 2.4 semantics of softirqs more or less as
cast into stone - for obvious reasons.

Some more radical options:

 - do not use split softirqs, use one global (but per-cpu) 'work to be
   done' queue, that lists multiple things. The downside: no 'priority'
   between softirqs.

(sidenote: i do think that priority of softirqs is overdesign and a fad,
or, in the best case, implemented incorrectly. It has no practical effect
in any workload i saw. *If* a higher-priority work queue is higher
priority, then we should abort softirq processing immediately if a
higher-priority softirq is activated. Ie. we should break out of
net_rx_action as soon as a higher priority, ie. any of the SOFTIRQ_HI or
SOFTIRQ_TX softirqs is activated. We dont do that - in fact we didnt even
go to the higher priority active softirq within the inner loop. So i
consider the softirq priority arguments to be pulled here by their hair.
softirq priorities never existed in any realistic form, for any serious
softirq load.)

so this is option #1: get rid of distrinction between 'work', and just do
a global (as in type, but per-CPU) work-FIFO. This concept works really
well in a number of other design areas within the Linux kernel.

advantage: no fancy priorities. We process work as it comes. More work
means a straightforward loop over all work that need to be done. We can
break out of this loop very easily and in a finegrained way: eg. if
current->need_resched is set, or if we spend more than 1-2 jiffies
processing softirqs then we break out of the loop. 'Measuring'
softirq-related load becomes much easier as well - and if it ever becomes
a problem we can throttle it artificially. (but normal systems would never
see this throttling.)

disadvantage: there is some cost to build 'context' of processing an
event. The current method of looping over pending events that are sorted
by event type (HI, TX, RX, LO) has the advantage of preserving this
'context'. OTOH, most of the event processing cost right now is not
related to building of context, but related to all sorts of cachemisses
like touching device-DMA-ed headers first time, or touching long-untouched
skbs and sockets.

unless you have strong arguments against this approach, i will start
coding this. It's a pretty intrusive change, because all current softirq
users will have to agree on a generic event format + callback that can be
queued. This has to be embedded into skbs and bh-handling structs. What do
you think?

	Ingo

