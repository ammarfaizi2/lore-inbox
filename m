Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291194AbSBYUDK>; Mon, 25 Feb 2002 15:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292327AbSBYUDD>; Mon, 25 Feb 2002 15:03:03 -0500
Received: from bitmover.com ([192.132.92.2]:51894 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S292331AbSBYUCn>;
	Mon, 25 Feb 2002 15:02:43 -0500
Date: Mon, 25 Feb 2002 12:02:42 -0800
From: Larry McVoy <lm@bitmover.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Larry McVoy <lm@bitmover.com>, lse-tech@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] NUMA scheduling
Message-ID: <20020225120242.F22497@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Bill Davidsen <davidsen@tmr.com>, Larry McVoy <lm@bitmover.com>,
	lse-tech@lists.sourceforge.net,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020225110327.A22497@work.bitmover.com> <Pine.LNX.3.96.1020225142845.17391A-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.3.96.1020225142845.17391A-100000@gatekeeper.tmr.com>; from davidsen@tmr.com on Mon, Feb 25, 2002 at 02:49:40PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2002 at 02:49:40PM -0500, Bill Davidsen wrote:
> On Mon, 25 Feb 2002, Larry McVoy wrote:
> 
> > If you read the early hardware papers on SMP, they all claim "Symmetric
> > Multi Processor", i.e., you can run any process on any CPU.  Skip forward
> > 3 years, now read the cache affinity papers from the same hardware people.
> > You have to step back and squint but what you'll see is that these papers
> > could be summarized on one sentence:
> > 
> > 	"Oops, we lied, it's not really symmetric at all"
> > 
> > You should treat each CPU as a mini system and think of a process reschedule
> > someplace else as a checkpoint/restart and assume that is heavy weight.  In
> > fact, I'd love to see the scheduler code forcibly sleep the process for 
> > 500 milliseconds each time it lands on a different CPU.  Tune the system
> > to work well with that, then take out the sleep, and you'll have the right
> > answer.
> 
>   Unfortunately this is an overly simple view of how SMP works. The only
> justification for CPU latency is to preserve cache contents. Trying to
> express this as a single number is bound to produce suboptimal results.

And here is the other side of the coin.  Remember what we are doing.
We're in the middle of a context switch, trying to figure out where we
should run this process.  We would like context switches to be fast.
Any work we do here is at direct odds with our goals.  SGI took the
approach that your statements would imply, i.e., approximate the 
cache footprint, figure out if it was big or small, and use that to
decide where to land the process.  This has two fatal flaws:
a) Because there is no generic hardware interface to say "how many cache
   lines are mine", you approximate that by looking at how much of the
   process timeslice this process used, if it used a lot, you guess it
   filled the cache.  This doesn't work at all for I/O bound processes,
   who typically run in short bursts.  So IRIX would bounce these around
   for no good reason, resulting in crappy I/O perf.  I got about another
   20% in BDS by locking down the processes (BDS delivered 3.2GBytes/sec
   of NFS traffic, sustained, in 1996).
b) all of the "thinking" you do to figure out where to land the process
   contributes directly to the cost of the context switch.  Linux has 
   nice light context switches, let's keep it that way.

Summary: SGI managed to get optimal usage out of their caches for long
running, CPU bound fortran jobs at the expense of time sharing and
I/O jobs.  I'm happy to let SGI win in that space.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
