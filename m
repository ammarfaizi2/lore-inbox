Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267505AbTAQNy6>; Fri, 17 Jan 2003 08:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267516AbTAQNy6>; Fri, 17 Jan 2003 08:54:58 -0500
Received: from mx1.elte.hu ([157.181.1.137]:62175 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S267505AbTAQNy5>;
	Fri, 17 Jan 2003 08:54:57 -0500
Date: Fri, 17 Jan 2003 15:07:51 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Erich Focht <efocht@ess.nec.de>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Christoph Hellwig <hch@infradead.org>, Robert Love <rml@tech9.net>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Andrew Theurer <habanero@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH 2.5.58] new NUMA scheduler: fix
In-Reply-To: <200301171210.03567.efocht@ess.nec.de>
Message-ID: <Pine.LNX.4.44.0301171459430.9021-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 17 Jan 2003, Erich Focht wrote:

> I prefer a single point of entry called load_balance() to multiple
> functionally different balancers. [...]

agreed - my cleanup patch keeps that property.

> [...] IIRC, his conclusion for the multi-queue scheduler was that an
> order of magnitude of 10ms is long enough, below you start feeling the
> balancing overhead, above you waste useful cycles.

this is one reason why we do the idle rebalancing at 1 msec granularity
right now.

> On a NUMA system this is even more important: the longer you leave fresh
> tasks on an overloaded node, the more probable it is that they allocate
> their memory there. And then they will run with poor performance on the
> node which stayed idle for 200-400ms before stealing them. So one wastes
> 200-400ms on each CPU of the idle node and at the end gets tasks which
> perform poorly, anyway. If the tasks are "old", at least we didn't waste
> too much time beeing idle. The long-term target should be that the tasks
> should remember where their memory is and return to that node.

i'd much rather vote for fork() and exec() time 'pre-balancing' and then
making it quite hard to move a task across nodes.

> > The inter-node balancing (which is heavier than even the global SMP
> > balancer), should never be triggered from the high-frequency path.
> 
> Hmmm, we made it really slim. [...]

this is a misunderstanding. I'm not worried about the algorithmic overhead
_at all_, i'm worried about the effect of too frequent balancing - tasks
being moved between runqueues too often. That has shown to be a problem on
SMP. The prev_load type of statistic measurement relies on a constant
frequency - it can lead to over-balancing if it's called too often.

> So if the CPU is idle, it won't go through schedule(), except we get an
> interrupt from time to time... [...]

(no, it's even better than that, we never leave the idle loop except when
we _know_ that there is scheduling work to be done. Hence the
need_resched() test. But i'm not worried about balancing overhead at all.)

	Ingo

