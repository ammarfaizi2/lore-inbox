Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266763AbSLDAfA>; Tue, 3 Dec 2002 19:35:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266765AbSLDAfA>; Tue, 3 Dec 2002 19:35:00 -0500
Received: from cda1.e-mind.com ([195.223.140.107]:18048 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S266763AbSLDAe6>;
	Tue, 3 Dec 2002 19:34:58 -0500
Date: Wed, 4 Dec 2002 01:42:34 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Christoph Hellwig <hch@sgi.com>,
       marcelo@connectiva.com.br.munich.sgi.com, rml@tech9.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] set_cpus_allowed() for 2.4
Message-ID: <20021204004234.GL11730@dualathlon.random>
References: <20021202192652.A25938@sgi.com> <1919608311.1038822649@[10.10.2.3]> <3DEBB4BD.F64B6ADC@digeo.com> <20021202195003.GC28164@dualathlon.random> <3DED18CC.5770EA90@digeo.com> <20021204000618.GG11730@dualathlon.random> <3DED4CA4.5B9A20EA@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DED4CA4.5B9A20EA@digeo.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2002 at 04:30:28PM -0800, Andrew Morton wrote:
> load is just one or more busywaits.  It has to be a compilation.  It
> could be something to do with all the short-lived processes, or gcc -pipe)

could be that we think they're very interactive or something like that.

> 
> > ...
> > > With a `make -j1' running:
> > >
> > > - Normal O(1) behaviour in StarOffice 5.2 is 15-30 second delays between
> > >   actions.
> > >
> > > - With 2.4.20aa1, typing into a text document typically had a 2-3 character
> > >   delay.
> > >
> > > - With the standard 2.4 scheduler the delay is zero characters.
> > 
> > again, I guess that's SMP and that's quite a pain to fix it to be 100%
> > equivalent to 2.4 without hurting scalability.
> 
> This problem is the "changed sched_yield semantics".  It was actually
> tested on uniprocessor.  The difference between 2.4 and 2.4-aa is
> still noticeable here, but it is not a terrible problem now.

strange, the algorithm should be nearly the same now (modulo RT). Still
I wonder that's something else on the short lived gcc processes side.

> > ..
> > 
> > Overall I don't see any showstopper with openoffice (or staroffice) on
> > my version of the o1 scheduler.
> 
> I'd agree that it's not a showstopper.  It's in the "could be improved
> a bit sometime" department.
> 
> Post-2.4, well, spinning on sched_yield() is a silly way to implement
> a graphical application and I don't believe we need to struggle to
> support such a thing.
> 
> The Open Group say
> 
>      The sched_yield() function shall force the running thread to relinquish
>      the processor until it again becomes the head of its thread list. It
>      takes no arguments.
> 
> That's a bit vague, but it does tend to imply that a yield could
> relinquish the CPU for a very long time.

the right implementation would be probably to let all the other task
run, so it can't waste entire timeslices if two tasks runs sched_yield
in a loop and the holder waits behind them, but that proven to be quite
slow in pratice for apps like openoffice (really when we tested that
algorithm there were still various bugs but I still think letting all
tasks to run before staroffice could make progress was the major reason
of the slowdown, think all gcc spending their timeslice before you can
take a mutex etc...).

Andrea
