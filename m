Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263522AbTLJN7j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 08:59:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263523AbTLJN7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 08:59:39 -0500
Received: from mail2.bluewin.ch ([195.186.4.73]:24488 "EHLO mail2.bluewin.ch")
	by vger.kernel.org with ESMTP id S263522AbTLJN7d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 08:59:33 -0500
Date: Wed, 10 Dec 2003 14:58:29 +0100
From: Roger Luethi <rl@hellgate.ch>
To: William Lee Irwin III <wli@holomorphy.com>,
       Con Kolivas <kernel@kolivas.org>,
       Chris Vine <chris@cvine.freeserve.co.uk>,
       Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: 2.6.0-test9 - poor swap performance on low end machines
Message-ID: <20031210135829.GA18370@k3.hellgate.ch>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Con Kolivas <kernel@kolivas.org>,
	Chris Vine <chris@cvine.freeserve.co.uk>,
	Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
	"Martin J. Bligh" <mbligh@aracnet.com>
References: <200311031148.40242.kernel@kolivas.org> <200311032113.14462.chris@cvine.freeserve.co.uk> <200311041355.08731.kernel@kolivas.org> <20031208135225.GT19856@holomorphy.com> <20031208194930.GA8667@k3.hellgate.ch> <20031208204817.GA19856@holomorphy.com> <20031209002745.GB8667@k3.hellgate.ch> <20031209040501.GE19856@holomorphy.com> <20031209151103.GA4837@k3.hellgate.ch> <20031209193801.GF19856@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031209193801.GF19856@holomorphy.com>
X-Operating-System: Linux 2.6.0-test11 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Dec 2003 11:38:01 -0800, William Lee Irwin III wrote:
> On Tue, Dec 09, 2003 at 04:11:03PM +0100, Roger Luethi wrote:
> > The more fine-grained work is not complete and I'm not sure it ever
> > will be. Some _preliminary_ results (i.e. take with a grain of salt):
> 
> Okay, it sounds like you're well on our way to cleaning things up.

Actually, I'm rather well on my way wrapping things up. I documented
in detail how much 2.6 sucks in this area and where the potential for
improvements would have likely been, but now I've got a deadline to
meet and other things on my plate.

For me this discussion just confirmed that my approach fails to draw much
interest, either because there are better alternatives or because heavy
paging and medium thrashing are generally not considered interesting
problems.

> > The classic strategies based on these criteria work for transaction and
> > batch systems. They are all but useless, though, for a workstation and
> > even most modern servers, due to assumptions that are incorrect today
> > (remember all the degrees of freedom a scheduler had 30 years ago)
> > and additional factors that only became crucial in the past few decades
> > (latency again).
> 
> This assessment is inaccurate. The performance metrics are not entirely
> useless, and it's rather trivial to recover data useful for modern
> scenarios based on them. The driving notion from the iron age (I guess

I said _strategies_ rather than papers or research because I realize
that the metrics can be an important part of the modern picture. It's
just the ancient recipes that once solved the problem that are useless
for typical modern usage patterns.

> >> Demoting the largest task is one that does worse than random.
> 
> > We only know that to be true for irrelevant optimization criteria.
> 
> The above explains how and why they are relevant.
> 
> It's also not difficult to understand why it goes wrong: the operation
> is too expensive.

What goes wrong is that once you start suspending tasks, you have a
hard time telling the interactive tasks apart from the batch load.
This may not be much of a problem on a 10x overcommit system, because
that's presumably quite unresponsive anyway, but it does matter a lot if
you have an interactive system that just crossed the border to thrashing.

Our apparent differences come from the fact that we try to solve
different problems as you correctly noted: You are concerned with
extreme overcommit, while I am concerned that 2.6 takes several times
longer than 2.4 to complete a task under slight overcommit.

I have no reason to doubt that load control will help you solve your
problem. It may help with medium thrashing and it might even keep
latency within reasonable bounds. I do think, however, that we should
investigate _first_ how we lost over 50% of the performance we had in
2.5.40 for both compile benchmarks.

> (Also, whatever this thread was, the In-Reply-To: chain was broken
> somewhere and the first thing I saw was the post I replied to.)

You can read the whole thread starting from here:
http://groups.google.com/groups?hl=en&lr=&ie=UTF-8&oe=UTF-8&selm=M794.3OE.7%40gated-at.bofh.it

> Well, I guess I might as well help with your paper. If the demotion
> criteria you're using are anything like what you posted, they risk
> invalidating the results, since they're apparently based on something
> worse than random.

Worse than random may still improve throughput, though, compared to
doing nothing, right? And I did measure improvements.

There are variables other than the demotion criteria that I found can
be important, to name a few:

- Trigger: Under which circumstances is suspending any processes
  considered? How often?

- Eviction: Does regular pageout take care of the memory of a suspended
  process, or are pages marked old or even unmapped upon stunning?

- Release: Is the stunning queue a simple FIFO? How long do the
  processes stay there? Does a process get a bonus after it's woken up
  again -- bigger quantum, chunk of free memory, prepaged working set
  before stunning?

There's quite a bit of complexity involved and many variables will depend
on the scenario. Sort of like interactivity, except lots of people were
affected by the interactivity tuning and only few will notice and test
load control.

The key question with regards to load control remains: How do you keep a
load controled system responsive? Cleverly detect interactive processes
and spare them, or wake them up again quickly enough? How? Or is the
plan to use load control where responsiveness doesn't matter anyway?

Roger
