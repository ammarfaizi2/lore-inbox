Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbWDPQGx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbWDPQGx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Apr 2006 12:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbWDPQGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Apr 2006 12:06:53 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:44494 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750745AbWDPQGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Apr 2006 12:06:52 -0400
Subject: Re: [PATCH 00/05] robust per_cpu allocation for modules
From: Steven Rostedt <rostedt@goodmis.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@suse.de>,
       Martin Mares <mj@atrey.karlin.mff.cuni.cz>, bjornw@axis.com,
       schwidefsky@de.ibm.com, benedict.gaster@superh.com, lethal@linux-sh.org,
       Chris Zankel <chris@zankel.net>, Marc Gauthier <marc@tensilica.com>,
       Joe Taylor <joe@tensilica.com>,
       David Mosberger-Tang <davidm@hpl.hp.com>, rth@twiddle.net,
       spyro@f2s.com, starvik@axis.com, tony.luck@intel.com,
       linux-ia64@vger.kernel.org, ralf@linux-mips.org,
       linux-mips@linux-mips.org, grundler@parisc-linux.org,
       parisc-linux@parisc-linux.org, linuxppc-dev@ozlabs.org,
       paulus@samba.org, linux390@de.ibm.com, davem@davemloft.net
In-Reply-To: <4441ECE6.5010709@yahoo.com.au>
References: <1145049535.1336.128.camel@localhost.localdomain>
	 <4440855A.7040203@yahoo.com.au>
	 <Pine.LNX.4.58.0604151609340.11302@gandalf.stny.rr.com>
	 <4441B02D.4000405@yahoo.com.au>
	 <Pine.LNX.4.58.0604152323560.16853@gandalf.stny.rr.com>
	 <4441ECE6.5010709@yahoo.com.au>
Content-Type: text/plain
Date: Sun, 16 Apr 2006 12:06:21 -0400
Message-Id: <1145203581.27407.112.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-04-16 at 17:06 +1000, Nick Piggin wrote:
> Steven Rostedt wrote:
> > On Sun, 16 Apr 2006, Nick Piggin wrote:
> 
> >>Why is your module using so much per-cpu memory, anyway?
> > 
> > 
> > Wasn't my module anyway. The problem appeared in the -rt patch set, when
> > tracing was turned on.  Some module was affected, and grew it's per_cpu
> > size by quite a bit. In fact we had to increase PERCPU_ENOUGH_ROOM by up
> > to something like 300K.
> 
> Well that's easy then, just configure PERCPU_ENOUGH_ROOM to be larger
> when tracing is on in the -rt patchset? Or use alloc_percpu for the
> tracing data?
> 

Yeah, we already know this.  The -rt patch was what showed the problem,
not the reason I was writing these patches.


> >>I don't think it would have been hard for the original author to make
> >>it robust... just not both fast and robust. PERCPU_ENOUGH_ROOM seems
> >>like an ugly hack at first glance, but I'm fairly sure it was a result
> >>of design choices.
> > 
> > Yeah, and I discovered the reasons for those choices as I worked on this.
> > I've put a little more thought into this and still think there's a
> > solution to not slow things down.
> > 
> > Since the per_cpu_offset section is still smaller than the
> > PERCPU_ENOUGH_ROOM and robust, I could still copy it into a per cpu memory
> > field, and even add the __per_cpu_offset to it.  This would still save
> > quite a bit of space.
> 
> Well I don't think making it per-cpu would help much (presumably it
> is not going to be written to very frequently) -- I guess it would
> be a small advantage on NUMA. The main problem is the extra load in
> the fastpath.
> 
> You can't start the next load until the results of the first come
> back.

Yep, you're right here, and it bothers me too that this slows down
performance.

> 
> > So now I'm asking for advice on some ideas that can be a work around to
> > keep the robustness and speed.
> > 
> > Is there a way (for archs that support it) to allocate memory in a per cpu
> > manner. So each CPU would have its own variable table in the memory that
> > is best of it.  Then have a field (like the pda in x86_64) to point to
> > this section, and use the linker offsets to index and find the per_cpu
> > variables.
> > 
> > So this solution still has one more redirection than the current solution
> > (per_cpu_offset__##var -> __per_cpu_offset -> actual_var where as the
> > current solution is __per_cpu_offset -> actual_var), but all the loads
> > would be done from memory that would only be specified for a particular
> > CPU.
> > 
> > The generic case would still be the same as the patches I already sent,
> > but the archs that can support it, can have something like the above.
> > 
> > Would something like that be acceptible?
> 
> I still don't understand what the justification is for slowing down
> this critical bit of infrastructure for something that is only a
> problem in the -rt patchset, and even then only a problem when tracing
> is enabled.
> 

It's because I'm anal retentive :-)

I noticed that the current solution is somewhat a hack, and thought
maybe it could be done cleaner.  Perhaps I'm wrong and the hack _is_ the
best solution, but it doesn't hurt in trying to improve it.  Or the very
least, prove that the current solution is the way to go.

I'm not trying to solve an issue with the -rt patch and tracing, I'm
just trying to make Linux a little more efficient in saving space. And
you may be right that we cant do that without hurting performance, and
thus we keep things as is.  But I don't want to give up without a fight
and miss something that can solve all this and keep Linux the best OS on
the market! (not to say that it isn't even with the current solution)

-- Steve


