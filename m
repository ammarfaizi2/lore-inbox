Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263309AbTF0M2M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 08:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263894AbTF0M2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 08:28:12 -0400
Received: from 216-42-72-146.ppp.netsville.net ([216.42.72.146]:31630 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id S263309AbTF0M2I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 08:28:08 -0400
Subject: Re: [PATCH] io stalls
From: Chris Mason <mason@suse.com>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Andrea Arcangeli <andrea@suse.de>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Jens Axboe <axboe@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Georg Nikodym <georgn@somanetworks.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Matthias Mueller <matthias.mueller@rz.uni-karlsruhe.de>
In-Reply-To: <3EFC122F.3090406@cyberone.com.au>
References: <1055296630.23697.195.camel@tiny.suse.com>
	 <20030611021030.GQ26270@dualathlon.random>
	 <1055353360.23697.235.camel@tiny.suse.com>
	 <20030611181217.GX26270@dualathlon.random>
	 <1055356032.24111.240.camel@tiny.suse.com>
	 <20030611183503.GY26270@dualathlon.random> <3EE7D1AA.30701@cyberone.com.au>
	 <20030612012951.GG1500@dualathlon.random>
	 <1055384547.24111.322.camel@tiny.suse.com> <3EE7E876.80808@cyberone.com.au>
	 <20030612024608.GE1415@dualathlon.random>
	 <1056567822.10097.133.camel@tiny.suse.com>
	 <3EFA8920.8050509@cyberone.com.au>
	 <1056628116.20899.28.camel@tiny.suse.com>
	 <3EFAEF71.1080109@cyberone.com.au>
	 <1056642911.20899.88.camel@tiny.suse.com>
	 <3EFB9C0C.9000600@cyberone.com.au>
	 <1056677984.20904.181.camel@tiny.suse.com>
	 <3EFC122F.3090406@cyberone.com.au>
Content-Type: text/plain
Organization: 
Message-Id: <1056717700.20899.197.camel@tiny.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 27 Jun 2003 08:41:41 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-06-27 at 05:45, Nick Piggin wrote:
> Chris Mason wrote:
> >>>
> >>The read situation is different to write. To fill the read queue,
> >>you need queue_nr_requests / 2-3 (for readahead) reading processes
> >>to fill the queue, more if the reads are random.
> >>If this kernel is being used interactively, its not our fault we
> >>might not give quite as good interactive performance. I'm sure
> >>the fileserver admin would rather take the tripled bandwidth ;)
> >>
> >>That said, I think a lot of interactive programs will want to do
> >>more than 1 request at a time anyway.
> >>
> >>
> >
> >My intuition agrees with yours, but if this is true then andrea's old
> >elevator-lowlatency patch alone is enough, and we don't need q->full at
> >all.  Users continued to complain of bad latencies even with his code
> >applied.
> >
> 
> Didn't that still have the starvation issues in get_request that
> my patch addressed though? This batching is needed due to the
> strict FIFO behaviour that my "q->full" thing did.
> 

Sure, but even though the batch wakeup code didn't have starvation
issues, the overall get_request latency was still high.  The end result
was basically the same, without q->full we've got a higher max wait and
a lower average wait.  With batch wakeup we've got a higher average
(300-400 jiffies) and a lower max (800-900 jiffies).

Especially for things like directory listings, where 2.4 generally does
io a few blocks at a time, the get_request latency is a big part of the
latency an interactive user sees.

> >So, the way I see things, we've got a few choices.
> >
> >1) do nothing.  2.6 isn't that far off.
> >
> >2) add elevator-lowlatency without q->full.  It solves 90% of the
> >problem
> >
> >3) add q->full as well and make it the default.  Great latencies, not so
> >good throughput.  Add userland tunables so people can switch.
> >
> >4) back port some larger chunk of 2.5 and find a better overall
> >solution.
> >
> >I vote for #3, don't care much if q->full is on or off by default, as
> >long as we make an easy way for people to set it.
> >
> 
> 5) include the "q->full" starvation fix; add the concept of a
>    queue owner, the batching process.
> 

I've tried two different approaches to #5, the first is a just a
batch_owner where other procs are still allowed to grab requests and the
owner was allowed to ignore q->full.  The end result was low latencies
but not much better throughput.  With a small number of procs, you've
got a good chance bdflush is going to get ownership and the throughput
is pretty good.  With more procs the probability of that goes down and
the throughput benefit goes away.

My second attempt was the batch wakeup patch from yesterday.  Overall I
don't feel the latencies are significantly better with that patch than
with Andrea's elevator-lowlatency and q->full disabled.

> I'm a bit busy at the moment and so I won't test this, unfortunately.
> I would prefer that if something like #5 doesn't get in, then nothing
> be done for .22 unless its backed up by a few decent benchmarks. But
> its not my call anyway.
> 

Andrea's code without q->full is a good starting point regardless.  The
throughput is good and the latencies are better overall.  q->full is
simple enough that making it available via a tunable is pretty easy.  I
really do wish I could make one patch that works well for both, but I've
honestly run out of ideas ;-)

-chris


