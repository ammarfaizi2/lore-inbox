Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964953AbWDGVHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964953AbWDGVHA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 17:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964958AbWDGVHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 17:07:00 -0400
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:50053
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S964953AbWDGVG7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 17:06:59 -0400
Date: Fri, 7 Apr 2006 14:06:33 -0700
To: Darren Hart <darren@dvhart.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       "Stultz, John" <johnstul@us.ibm.com>,
       Peter Williams <pwil3058@bigpond.net.au>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: Re: RT task scheduling
Message-ID: <20060407210633.GA15971@gnuppy.monkey.org>
References: <200604052025.05679.darren@dvhart.com> <20060407091946.GA28421@elte.hu> <20060407103926.GC11706@gnuppy.monkey.org> <200604070756.21625.darren@dvhart.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604070756.21625.darren@dvhart.com>
User-Agent: Mutt/1.5.11+cvs20060126
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2006 at 07:56:20AM -0700, Darren Hart wrote:
> The rt-overload mechanism is distinct from load balancing.  RT overload 
> attempts to make sure the NR_CPUS highest priority runnable tasks are running 
> on each of the available CPUs.  This isn't load balancing, this is "system 
> wide strict realtime priority scheduling" (SWSRPS).  This scheduling should 
> take place even if there are 1000 non RT tasks on CPU 0 and none on all the 
> others.  The load balancer would be responsible for distributing those 1000 
> non rt tasks to all the CPUs.

I'm quite aware of what you're saying as well as a much of the contents of
the -rt patch. Please don't assume that I'm not aware of this. The -rt patch
doesn't do SWSRPS, but it could with more expensive checking. I'm not saying
anything against it. In fact, I'm clearly for it if you read the other posts.
Please read my other posts.

> > RT applications tend to want explicit control over the scheduling of
> > the system with as little interference from the kernel as possible. The
> > general purpose policies (RT rebalancing) of the Linux kernel can impede
> > RT apps from getting at CPU time more directly. 
> 
> I don't feel that SWSRPS in anyway interferes with realtime applications.  If 
> an application does not explicitly set a cpu affinity, then the kernel should 
> assume the task can run on any CPU and should make SWSRPS decisions 
> accordingly.  In fact, in my experience, applications expect this type of 
> scheduling - and don't consider it an interference.

It will with the IPI forcing the rescheduling. I've seen up to 20 usec hits
for the IPI on p3 hardware. Some RT might like tighter guarantees. That
extends the maxium deterministic latency by the time that it does IPI an
along with the response.

> Actually the SWSRPS is what makes the scheduling deterministic.  That 
> determinism comes at a cost, but without it it doesn't exist at all on an SMP 
> machine.  So saying it "adds to the maximum deterministic response time" 
> doesn't really make any sense.

Above comments...

> It's my impression (RT folks please pipe up if it's wrong) that if you don't 
> care about priority scheduling (i.e. it's OK for a lower priority task to run 
> while one with a higher priority sits waiting on another queue), then you 
> don't use SCHED_FIFO.  So I don't think case 2 is really valid.

Yeah, this is not good. There's a serious communication disconnect here and
it's not going to be easily bridged. Please read what I said and think about
the usage scenarios that I've mentioned more carefully. The -rt patch already
has this kind of mechanism whether you're aware of this or not (unless somethings
changed since I last looked). It's not as aggressively doing SWSRPS as what
you're saying but it serves things nicely for now.

Do you understand this ? The -rt patch has yet to be target for a doing strict
RT work and your suggestion/patches might be one step closer to that goal. The
counter effect to that is that you're going to effect the general case latency
case with SCHED_FIFO via that rescheduling hit "all of the time" with IPIs and
stuff. I'm 'ok' with that. In fact, that's what I want. I'm not ok with Ingo
creating a new scheduling class to get around that aggressive rebalancing
policy preserving the current SCHED_FIFO behavior in the main line. It's a hack
IMO and I'll bet you that nobody cared about that behavior in the first place.

I'd much rather see that some kind of SWSRPS go into the main line kernel (RT
scheduling is pretty goofy already so folks probaby won't mind SWSRPS replacing
it) and let thread binding to a CPU restore any loss of latency by bypassing
the SWSRPS logic. Are you tracking me ? My concerns here are the latency
and overhead of SWSRPS and they are definitely significant.

> You've made a lot of references to binding tasks to CPUs (or forbidding them, 
> which is essentially a bind to non-forbidden CPUs).  While application 
> developers can certainly take this approach, the linux kernel should schedule 
> realtime tasks globally according to priority in the generic case.

For a default RT oriented kernel, yes, I agree, but that's not what's in -rt
and it serves the purpose for now. Looser scheduling constraints aren't really
effecting the current crop of RT applications and that's ok since it's a bit
fast than a pure SWSRPS solution. For those apps having a more general, looser,
case semantic doesn't effect things dramatically and might even be useful.

bill

