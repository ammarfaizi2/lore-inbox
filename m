Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293459AbSBYTya>; Mon, 25 Feb 2002 14:54:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293460AbSBYTyW>; Mon, 25 Feb 2002 14:54:22 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:22545 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S293459AbSBYTyM>; Mon, 25 Feb 2002 14:54:12 -0500
Date: Mon, 25 Feb 2002 14:49:40 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Larry McVoy <lm@bitmover.com>
cc: lse-tech@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] NUMA scheduling
In-Reply-To: <20020225110327.A22497@work.bitmover.com>
Message-ID: <Pine.LNX.3.96.1020225142845.17391A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Feb 2002, Larry McVoy wrote:

> If you read the early hardware papers on SMP, they all claim "Symmetric
> Multi Processor", i.e., you can run any process on any CPU.  Skip forward
> 3 years, now read the cache affinity papers from the same hardware people.
> You have to step back and squint but what you'll see is that these papers
> could be summarized on one sentence:
> 
> 	"Oops, we lied, it's not really symmetric at all"
> 
> You should treat each CPU as a mini system and think of a process reschedule
> someplace else as a checkpoint/restart and assume that is heavy weight.  In
> fact, I'd love to see the scheduler code forcibly sleep the process for 
> 500 milliseconds each time it lands on a different CPU.  Tune the system
> to work well with that, then take out the sleep, and you'll have the right
> answer.

  Unfortunately this is an overly simple view of how SMP works. The only
justification for CPU latency is to preserve cache contents. Trying to
express this as a single number is bound to produce suboptimal results.
Consider:

+ the benefit from staying on the same processor drops with the number of
cache lines reloaded, not the the time. On some systems you probably can
measure this, I don't know of any use currently made of it. Actually given
varying cache sizes you care about the lines not changed, still another
thing (big cache doesn't devaluate as fast).

+ the cost of going to another processor is hardware and application
dependent. It depends on memory bandwidth and the size of the working set.
In addition, some hardware has several processors on a card, with
both individual and shared cache. And the Intel hyperthreading provides
two CPUs with totally shared cache (if I read the blurb right). This means
that the cost of going to one processor isn't always the same as going to
another.

+ tuning depends on what you want to optimize. If I have low memory and
few processes, having a process using memory but not getting CPU is bad, I
don't ever want a CPU idle when I don't have enough to go around. I don't
even want a CPU idle if I have tons of memory, switch is actually not all
THAT heavy an operation, if I have a small working set the cost is low, if
I have a working set larger than cache the benefit of addinity is reduced. 
And, if I have lots of memory and processes, and not much CPU, and limited
memory bandwidth, then waiting for a CPU is fine, it keeps the CPUs
running as fast as possible. 

  I believe there is room for improvement here, but I don't think setting
affinity to some large values and then tuning the system to work well with
that is even possible, given the benefits in responsiveness I see with low
latency and preempt changes, I think it would lead to a dog-slow system no
matter how you tune it.

  To paraphrase one of my old sig files, simplify the algorithm as much as
possible. Then stop.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

