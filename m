Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751074AbVKRWco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbVKRWco (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 17:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751073AbVKRWco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 17:32:44 -0500
Received: from styx.suse.cz ([82.119.242.94]:51379 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1750800AbVKRWco (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 17:32:44 -0500
Date: Fri, 18 Nov 2005 23:32:33 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       "Paul E. McKenney" <paulmck@us.ibm.com>, "K.R. Foley" <kr@cybsft.com>,
       Steven Rostedt <rostedt@goodmis.org>,
       Thomas Gleixner <tglx@linutronix.de>, pluto@agmk.net,
       john cooper <john.cooper@timesys.com>,
       Benedikt Spranger <bene@linutronix.de>,
       Daniel Walker <dwalker@mvista.com>,
       Tom Rini <trini@kernel.crashing.org>,
       George Anzinger <george@mvista.com>
Subject: Re: 2.6.14-rt13
Message-ID: <20051118223233.GA7794@midnight.suse.cz>
References: <20051115090827.GA20411@elte.hu> <1132336954.20672.11.camel@cmn3.stanford.edu> <1132350882.6874.23.camel@mindpipe> <1132351533.4735.37.camel@cmn3.stanford.edu> <1132351984.6874.29.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132351984.6874.29.camel@mindpipe>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2005 at 05:13:03PM -0500, Lee Revell wrote:
> On Fri, 2005-11-18 at 14:05 -0800, Fernando Lopez-Lezcano wrote:
> > On Fri, 2005-11-18 at 16:54 -0500, Lee Revell wrote:
> > > On Fri, 2005-11-18 at 10:02 -0800, Fernando Lopez-Lezcano wrote:
> > > > You mentioned before that the TSC's from both cpus could drift from
> > > > each other over time. Assuming that is the source of timing (I have no
> > > > idea) that could explain the behavior of Jack, it gets a reference
> > > > time from one of the cpus and then compares that with what it gets
> > > > from either cpu depending on where it is running at a given time. If
> > > > it is the same cpu all is fine, if it is the other and it has drifted
> > > > then the warning is printed.  
> > > 
> > > Yes, JACK uses rdtsc() for microsecond resolution timing and assumes
> > > that the TSCs are in sync.
> > > 
> > > I've asked on this list what a better time source could be and didn't
> > > get any useful responses, people just told me "use gettimeofday()" which
> > > is WAY too slow.
> > 
> > Arghhh, at least I take this as a confirmation that the TSCs do drift
> > and there is no workaround. It currently makes the -rt/Jack combination
> > not very useful, at least in my tests. 
> > 
> > Is there a way to resync the TSCs?
> 
> I don't think so.  A better question is what mechanism have the hardware
> vendors provided to replace the apparently-no-longer-reliable TSC for
> cheap high res timing on modern machines.  Unfortunately I suspect the
> answer at this point is "nothing, you're screwed".

There are many mechanisms to keep time:

1) RTC: 0.5 sec resolution, interrupts
2) PIT: takes ages to read, overflows at each timer interrupt
3) PMTMR: takes ages to read, overflows in approx 4 seconds, no interrupt
4) HPET: slow to read, overflows in 5 minutes. Nice, but usually not present.
5) TSC: fast, completely unreliable. Frequency changes, CPUs diverge over time.
6) LAPIC: reasonably fast, unreliable, per-cpu

Userspace can only use 1), 4) and 5). mplayer uses the RTC to
synchronize, using it as a 1 kHz interrupt source.

The kernel does quite a lot of magic and jumps through many hoops to
make a reliable and fast time source combining these.

> I've read that gettimeofday() does not have to enter the kernel on
> x86-64, maybe it's fast enough, though almost certainly orders of
> magnitude slower than rdtsc(). 

It depends on the hardware config, and kernel version. With my latest
patch it takes approximately 175 ns on a reasonably fast CPU to do
gettimeofday() from userspace. And much better results will be possible
(~5x better) when RDTSCP enabled CPUs become available.

This patch still has problems, and as such I'll still have to rewrite
significant portions before I release it.

Anyway, current gettimeofday() on SMP AMD x86-64 can be as bad as 1500ns.

> It seems like a huge step backwards for
> any apps with high res timing requirements.

gettimeofday() is the only guaranteed working mechanism. And it's as
fast as the hardware allows.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
