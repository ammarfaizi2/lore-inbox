Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbUCXWwr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 17:52:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261154AbUCXWwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 17:52:47 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:57259
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261179AbUCXWwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 17:52:34 -0500
Date: Wed, 24 Mar 2004 23:53:26 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>,
       Arjan van de Ven <arjanv@redhat.com>, tiwai@suse.de,
       Robert Love <rml@ximian.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RCU for low latency (experimental)
Message-ID: <20040324225326.GH2065@dualathlon.random>
References: <20040323101755.GC3676@in.ibm.com> <1080038105.5296.8.camel@laptop.fenrus.com> <20040323123105.GI22639@dualathlon.random> <20040323124002.GH3676@in.ibm.com> <20040323125044.GL22639@dualathlon.random> <20040324172657.GA1303@us.ibm.com> <20040324175142.GW2065@dualathlon.random> <20040324213914.GD4539@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040324213914.GD4539@in.ibm.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2004 at 03:09:15AM +0530, Dipankar Sarma wrote:
> On Wed, Mar 24, 2004 at 06:51:42PM +0100, Andrea Arcangeli wrote:
> > On Wed, Mar 24, 2004 at 09:26:57AM -0800, Paul E. McKenney wrote:
> > running 1 callback per softirq (and in turn 10 callbacks per hardware
> > irq) shouldn't be measurable compared to the cost of the hardware
> > handling, skb memory allocation, iommu mapping etc... 
> > 
> > why do you care about this specific irq-flood corner case where the load
> > is lost in the noise and there's no way to make it scheduler-friendy
> > either since hardware irqs are involved?
> 
> We are looking at two different problems. Scheduling latency and
> DoS on route cache that results in dst cache overflows. The second
> one is an irq-flood, but latency is the least of the problems there.

agreed.

> > > > > In my DoS testing setup, I see that limiting RCU softirqs 
> > > > > and re-arming tasklets has no effect on user process starvation.
> > > > 
> > > > in an irq flood load that stalls userspace anyways it's ok to spread the
> > > > callback load into the irqs, 10 tasklets and in turn 10 callbacks per
> > > > irqs or so. That load isn't scheduler friendly anyways.
> > > 
> > > The goal is to run reasonably, even under this workload, which, as you
> > > say is not scheduler friendly.  Scheduler hostile, in fact.  ;-)
> > 
> > Indeed it is, and I'm simply expecting not any real difference by
> > running 10 callbacks per hardware irq, so I find it a non very
> > interesting workload to choose between a softirq or the kernel thread,
> > but maybe I'm overlooking something.
> 
> The difference here is that during the callbacks in the kernel thread, 
> I don't disable softirqs unlike ksoftirqd thus giving it more opportunity for
> preemption.

preemption where? in irq? softirqd will preempt just fine.

Also not that while we process the callbacks in softirqd, the irqs will
stop running the callbacks, just like in your scenario. the callbacks
and the other softirqs will be processed from user context, and it won't
be different from scheduling krcud first and ksoftirqd later.

> I had already been testing this for the DoS issue, but I tried it
> with amlat on a 2.4 GHz (UP) P4 xeon with 256MB ram and dbench 32 in a
> loop. Here are the results (CONFIG_PREEMPT = y) -
> 
> 2.6.0 vanilla 		- 711 microseconds
> 2.6.0 + throttle-rcu 	- 439 microseconds
> 2.6.0 + rcu-low-lat 	- 413 microseconds
> 
> So under dbench workload atleast, throttling RCU works just as
> good as offloading them to a kernel thread (krcud) as rcu-low-lat
> does.

very nice.

> I used the following throttle-rcu patch with rcupdate.rcumaxbatch
> set to 16 and rcupdate.rcuplugticks set to 0. That is essentially
> equvalent to Andrea's earler suggestion. I have so many knobs in
> the patch because I had written it earlier for other experiments.
> Anyway, if throttling works as well as this in terms of latency
> for other workloads as well and there isn't any OOM situations,
> it is preferable to creating another per-cpu thread.

I don't think this is enough (it is enough for the above workload
though, maybe for the dcache too, but it's not generic enough), 16
callbacks per tick too low frequency, it may not keep up, that's why I
suggested to offload the work to a re-arming tasklet that will finish it
ASAP (but in a scheduler-friendly way) instead of waiting the next tick.

But I certainly agree this is a nice solution in practice (at least with
all the common usages).

thanks!
