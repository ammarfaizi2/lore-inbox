Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262120AbUCLOOx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 09:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262121AbUCLOOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 09:14:53 -0500
Received: from colin2.muc.de ([193.149.48.15]:64525 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S262120AbUCLOOv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 09:14:51 -0500
Date: 12 Mar 2004 15:14:50 +0100
Date: Fri, 12 Mar 2004 15:14:50 +0100
From: Andi Kleen <ak@muc.de>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Andi Kleen <ak@muc.de>, "Nakajima, Jun" <jun.nakajima@intel.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm1
Message-ID: <20040312141450.GB80958@colin2.muc.de>
References: <7F740D512C7C1046AB53446D37200173FEB851@scsmsx402.sc.intel.com> <20040312031452.GA41598@colin2.muc.de> <40513B8B.9010301@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40513B8B.9010301@cyberone.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2004 at 03:24:43PM +1100, Nick Piggin wrote:
> 
> 
> Andi Kleen wrote:
> 
> >On Thu, Mar 11, 2004 at 07:04:50PM -0800, Nakajima, Jun wrote:
> >
> >>As we can have more complex architectures in the future, the scheduler
> >>is flexible enough to represent various scheduling domains effectively,
> >>and yet keeps the common scheduler code simple.
> >>
> >
> >I think for SMT alone it's too complex and for NUMA it doesn't do
> >the right thing for "modern NUMAs" (where NUMA factor is very low
> >and you have a small number of CPUs for each node). 
> >
> >
> 
> For SMT it is a less complex than shared runqueues, it is actually
> less lines of code and smaller object size.

By moving all the complexity into arch/* ?

> 
> It is also more flexible than shared runqueues in that you can still
> have control over each sibling's runqueue. Con's SMT nice patch for
> example would probably be more difficult to do with shared runqueues.
> Shared runqueues also gives zero affinity to siblings. While current
> implementations may not (do they?) care, future ones might.
> 
> For Opteron type NUMA, it actually balances much more aggressively
> than the default NUMA scheduler, especially when a CPU is idle. I
> don't doubt you aren't seeing great performance, but it should be
> able to be fixed.
> 
> The problem is just presumably your lack of time to investigate
> further, and my lack of problem descriptions or Opterons.

I didn't investigate further on your scheduler because I have my 
doubts about it being the right approach and it seems to have
some obvious design bugs (like the racy SMT setup) 

The problem description is still the same as it was in the past.

Basically it is: schedule as on SMP, but avoid local affinity for newly
created tasks and balance early. Allow to disable all old style NUMA 
heuristics.

Longer term some homenode scheduling affinity may be still useful,
but I tried to get that to work on 2.4 and failed, so I'm not sure
it can be done. The right way may be to keep track how much memory
each thread allocated on each node and preferably schedule on
the node with the most memory. But that's future work.

> 
> One thing you definitely want is a sched_balance_fork, is that right?
> Have you been able to do any benchmarks on recent -mm kernels?

I sent the last benchmarks I did to you (including the tweaks you
suggested). All did worse than the standard scheduler. Did you 
change anything significant that makes rebenchmarking useful?

-Andi
