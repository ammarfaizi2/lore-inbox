Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751178AbVK2Nhk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbVK2Nhk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 08:37:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbVK2Nhk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 08:37:40 -0500
Received: from ns.suse.de ([195.135.220.2]:46236 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751178AbVK2Nhj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 08:37:39 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: Steven Rostedt <rostedt@goodmis.org>, acpi-devel@lists.sourceforge.net,
       len.brown@intel.com, nando@ccrma.Stanford.EDU, rlrevell@joe-job.com,
       linux-kernel@vger.kernel.org, paulmck@us.ibm.com, kr@cybsft.com,
       tglx@linutronix.de, pluto@agmk.net, john.cooper@timesys.com,
       bene@linutronix.de, dwalker@mvista.com, trini@kernel.crashing.org,
       george@mvista.com, akpm@osdl.org
Subject: Re: [RFC][PATCH] Runtime switching of the idle function [take 2]
References: <20051118220755.GA3029@elte.hu>
	<1132353689.4735.43.camel@cmn3.stanford.edu>
	<1132367947.5706.11.camel@localhost.localdomain>
	<20051124150731.GD2717@elte.hu>
	<1132952191.24417.14.camel@localhost.localdomain>
	<20051126130548.GA6503@elte.hu>
	<1133232503.6328.18.camel@localhost.localdomain>
	<20051128190253.1b7068d6.akpm@osdl.org>
	<1133235740.6328.27.camel@localhost.localdomain>
	<20051128200108.068b2dcd.akpm@osdl.org>
	<20051129064420.GA15374@elte.hu>
From: Andi Kleen <ak@suse.de>
Date: 29 Nov 2005 11:05:21 -0700
In-Reply-To: <20051129064420.GA15374@elte.hu>
Message-ID: <p73mzjngwim.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > > The way to solve this was to set
> > >  idle=poll.  The original patch I sent was to allow the user to change to
> > >  idle=poll dynamically.  This way they could switch to the poll_idle and
> > >  run there tests (requiring tsc not to drift) and then switch back to the
> > >  default idle to save on electricity.
> > 
> > Use gettimeofday()?
> > 
> > If it's just for some sort of instrumentation, run NR_CPUS instances 
> > of a niced-down busyloop, pin each one to a different CPU?  That way 
> > the idle function doesn't get called at all..
> 
> idle=poll is also frequently done for performance reasons [it reduces 
> idle wakeup latency by 10 usecs] 

And it's obsolete on CPUs with monitor/mwait.
And in practice the CPU will run so hot that only benchmarkers like it.

I think switching idle is the wrong way to do. We should rather
fix the various problems.

For fixing the TSC issue it is 100% the wrong approach Imho.
Basically software has to live with TSCs being unsynchronized
and gettimeofday should do the right thing (and if not it should be fixed)

- while it could be turned off if the 
> system has been idle for some time. E.g. cpufreqd could sample idle time 
> and turn on/off idle=poll. High-performance setups could enable it all 
> the time.

And upgrade their server air condition or issue additional ear protection
to the desktop user? Most likely you will just drive the CPUs into
thermal throttle at some point with that, not get more performance anyways.
  
> as long as it can be done with zero-cost, i dont see why Steven's patch 
> wouldnt be a plus for us. It's a performance thing, and having runtime 
> switches for seemless performance features cannot be bad.

The interface is ugly and I suspect fixing the various obscure race this
obscure feature would undoubtedly add will be a long term maintenance
issue. And it's the wrong thing to do anyways because it just papers
over other problems that should be fixed in the right way.

-Andi
