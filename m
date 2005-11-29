Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932366AbVK2Txv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932366AbVK2Txv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 14:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbVK2Txv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 14:53:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:14268 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932366AbVK2Txu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 14:53:50 -0500
Date: Tue, 29 Nov 2005 20:53:37 +0100
From: Andi Kleen <ak@suse.de>
To: "Brown, Len" <len.brown@intel.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Steven Rostedt <rostedt@goodmis.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, acpi-devel@lists.sourceforge.net,
       nando@ccrma.Stanford.EDU, rlrevell@joe-job.com,
       linux-kernel@vger.kernel.org, paulmck@us.ibm.com, kr@cybsft.com,
       tglx@linutronix.de, pluto@agmk.net, john.cooper@timesys.com,
       bene@linutronix.de, dwalker@mvista.com, trini@kernel.crashing.org,
       george@mvista.com
Subject: Re: [RFC][PATCH] Runtime switching of the idle function [take 2]
Message-ID: <20051129195336.GP19515@wotan.suse.de>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005456F00@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B3005456F00@hdsmsx401.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2005 at 02:37:53PM -0500, Brown, Len wrote:
> idle=poll is a really bad way to go from a power perspective.
> While it is diminishing returns to get into deeper C-states,
> getting into at least C1 (HALT or MONITOR/MWAIT) is very important
> on many processors.
> 
> Note that if the issue at hand is the TSC stopping in deep
> ACPI C-states, that there is a flag already available to limit
> how deep the C-states go.  eg.

No i think they tried to work around the fact that
it's not synchronized on AMD systems - in particular
it drifts slightly even on single socket dual core
A64 X2s and disabling C1 works around that.

But idle=poll is too big an hammer for this. Vojtech
is working on a solution anyways that should address this
better.


> processor.max_cstate=2 will disable C3, C4 etc
> You can do this at run-time by writing to
> /sys/module/processor/parameters/max_cstate

In this case it's already C1 that's the problem,
so that won't help them.

> I agree with Andi that we have some work to do to address
> the issue directly, which is that the TSC is not reliable
> under all conditions on all processors.  I think we need

We're mostly addressing it - there are problems left, but
overall it's looking good. The remaining problem is 
an education issue of users to not use RDTSC directly, 
but use gettimeofday/clock_gettime

One remaining use is measurements, but for that it is
already dubious (e.g. due to ticking at a possible
different frequency than the CPU). For that I want
to establish the RDPMC 0 convention.

Probably need better documentation for all of this though...

> some modes for TSC to detect and handle the cases where it either
> stops in C3 or changes speeds, vs the systems where it actually
> works the way we want it to -- constant rate that never stops.
>  
> >Why not just slightly cleanup and extend (eg. to ACPI) the
> >hlt_counter thingy that many architectures already have?
> 
> Hmmm, I see the floppy driver invoking hlt_counter,
> but it isn't clear what the general semantics and general
> users are supposd to be.  Can you clue me in?

It's an ancient hack for an ancient machine chipset bug, but AFAIK 
not used/needed on anything modern. 

Should probably remove it from x86-64 too.

-Andi
