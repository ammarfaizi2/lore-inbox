Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964773AbWJ1UEd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964773AbWJ1UEd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 16:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964774AbWJ1UEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 16:04:33 -0400
Received: from 1wt.eu ([62.212.114.60]:16644 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S964773AbWJ1UEd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 16:04:33 -0400
Date: Sat, 28 Oct 2006 22:04:39 +0200
From: Willy Tarreau <w@1wt.eu>
To: Andi Kleen <ak@suse.de>
Cc: Lee Revell <rlrevell@joe-job.com>, thockin@hockin.org,
       Luca Tettamanti <kronos.it@gmail.com>, linux-kernel@vger.kernel.org,
       john stultz <johnstul@us.ibm.com>
Subject: Re: AMD X2 unsynced TSC fix?
Message-ID: <20061028200439.GB1603@1wt.eu>
References: <1161969308.27225.120.camel@mindpipe> <200610281137.22451.ak@suse.de> <20061028191515.GA1603@1wt.eu> <200610281233.27588.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610281233.27588.ak@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 28, 2006 at 12:33:27PM -0700, Andi Kleen wrote:
> On Saturday 28 October 2006 12:15, Willy Tarreau wrote:
> 
> > Yes it was, because the small gain of using a dual core with such
> > a workload was clearly lost by that change. IIRC, I reached 25000
> > sessions/s on dual core with TSC if I didn't care about the clock,
> > 20000 without TSC, and 18000 on single core+TSC. But with the sniffer,
> > it was even worse : I had 500 kpps in dual-core+TSC, 70kpps without
> > TSC and 300 kpps with single-core+TSC. Since I had to buy the same
> > machines for both uses, this last argument was enough for me to stick
> > to a single core.
> 
> Ok, but it is a very specialized situation not applicable to most
> others. I just say this for all the other people following the thread.
> Again most workloads are not that gtod intensive.

100% agreed (fortunately !).

> BTW if you don't use powernow and don't use blades with thermal clock ramping 
> and use idle=poll then the TSCs should be synchronized on AMD dual core
> and TSC gtod can be used. But it will burn a lot of power and make the system 
> run very hot.

I tried to make it run like this. I once was said that by racking pizza boxes,
you get a pizza oven. I was prepared to accept it :-)

But I would not manage to keep them in sync. I even remember running
background loops to ensure that there was no idle at all, and the clocks
still managed to get out of sync ! I tried to disable a lot of devices,
starting with everything susceptible to send interrupts with long processing
time (eg: USB, SATA, ...), but with no success. I once thought that I
succeeded by sticking all interrupts to one core and the tasks to the
other one, but was proved wrong after several minutes.

I really think that the hardware was doing tricks far beyond my knowledge,
because on another Sun (a V40Z), there were 4 dual cores which I never saw
out of sync even after hours of testing. But the HPET was available in it,
I don't remember if it's used by default when detected.

> > > > I initially considered buying one dual-core
> > > > AMD for my own use, but after seeing this, I'm definitely sure I won't
> > > > ever buy one as long as this problem is not fixed, as it causes too
> > > > many problems.
> > >
> > > It's somewhat slower, but I'm not sure what "too many problems" you're
> > > refering to.
> >
> > Anticipated or delayed timeouts on the proxy, time measurement errors
> > (when the logs show that a session finishes before it begins, there's
> > a real problem, particularly because we use those logs for
> > troubleshooting). And for the sniffer, getting wrong times by about 2s was
> > a real problem too. I would have preferred to get something monotonic with
> > little accuracy than out of order packets !
> 
> Ah you mean you forced the kernel to use a unsynchronized TSC 
> for gtod during your tuning attempts and then discovered that it didn't work?
> Call me surprised.

No I did not "force" anything at first. You take the RHEL3 CD, you install
it, reboot and watch your logs report negative times, then scratch your
head, first call red hat dumb ass, and after a few tests, apologize to the
poor innocent red hat and call the box a total crap. To put it shortly
(might be useful for people who Google for it) : Dual-core Sun x2100 is
unreliable out of the box under Linux.

> In the default configuration there shouldn't be any problems
> like this, it will just run slower because the kernel falls back to a slower
> time source.

You have to specify "notsc" for this. As an alternative, a NUMA kernel
worked fine too (because TSC is disabled), but it's not obvious for
anyone why a dual-core, single proc system should be considered "NUMA" !

> > This is definitely a design problem on those chips, probably because
> > marketting targets gamers only.
> 
> Last time I checked Dual core Opterons weren't marketed to gamers.

Not "opterons" under this name, but AMD X2 yes. Ask google for "AMD X2"
and click on the first non-AMD site (3rd link), then check how it's
benchmarked... On the other hand, if you look for "opteron", you
immediately find more serious usages.

> > And that's very sad, because they are 
> > excellent processors !
> 
> Lots of various parties are to blame here, not just AMD.
> 
> The BIOS vendors for not exposing HPET even when it is available in the 
> hardware. While HPET is slower than TSC too it definitely isn't nearly as 
> slow as pmtimer.

I'm sure that the BIOS is buggy there, because I too found it strange
that there was no HPET reported in such a system. But I found no way
to enable it by force either, as I did not know where to start looking
at.

> Possibly the Linux people for not getting per CPU TSC going quicker.
> 
> The writers of software who uses gtod too often or force the kernel
> to call it for each packet by carelessly using the timestamp ioctl.

You can't use gtod less than once in a poll() loop unfortunately. And
believe me, I do count my syscalls because each one hits performance
by a few percent. When it comes to getting time on each packet, the
problem is the same : you're dependant on the frequency of external
events. You need to get the time once for each event. But I agree
that a per-CPU TSC could help a lot at getting monotonic clocks. I
think that using the local TSC to measure non-accurate time and
decide when to call an external source would be a great improvement.

Regards,
Willy

