Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbUCXXMx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 18:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262080AbUCXXMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 18:12:52 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:53158 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261154AbUCXXMu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 18:12:50 -0500
Date: Thu, 25 Mar 2004 04:41:45 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>,
       Arjan van de Ven <arjanv@redhat.com>, tiwai@suse.de,
       Robert Love <rml@ximian.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RCU for low latency (experimental)
Message-ID: <20040324231145.GB12035@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20040323101755.GC3676@in.ibm.com> <1080038105.5296.8.camel@laptop.fenrus.com> <20040323123105.GI22639@dualathlon.random> <20040323124002.GH3676@in.ibm.com> <20040323125044.GL22639@dualathlon.random> <20040324172657.GA1303@us.ibm.com> <20040324175142.GW2065@dualathlon.random> <20040324213914.GD4539@in.ibm.com> <20040324225326.GH2065@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040324225326.GH2065@dualathlon.random>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2004 at 11:53:26PM +0100, Andrea Arcangeli wrote:
> On Thu, Mar 25, 2004 at 03:09:15AM +0530, Dipankar Sarma wrote:
> > 
> > The difference here is that during the callbacks in the kernel thread, 
> > I don't disable softirqs unlike ksoftirqd thus giving it more opportunity for
> > preemption.
> 
> preemption where? in irq? softirqd will preempt just fine.
> 
> Also not that while we process the callbacks in softirqd, the irqs will
> stop running the callbacks, just like in your scenario. the callbacks
> and the other softirqs will be processed from user context, and it won't
> be different from scheduling krcud first and ksoftirqd later.

It is different because the heart of ksoftirqd - do_softirq() is
run with local_bh_disable(). Sure, you get chances to preempt
there, but not as much as krcud which runs completely in process
context. Of course, it depends on how long we stay with
softirqs disabled in do_softirq().

> > I had already been testing this for the DoS issue, but I tried it
> > with amlat on a 2.4 GHz (UP) P4 xeon with 256MB ram and dbench 32 in a
> > loop. Here are the results (CONFIG_PREEMPT = y) -
> > 
> > 2.6.0 vanilla 		- 711 microseconds
> > 2.6.0 + throttle-rcu 	- 439 microseconds
> > 2.6.0 + rcu-low-lat 	- 413 microseconds
> > 
> > So under dbench workload atleast, throttling RCU works just as
> > good as offloading them to a kernel thread (krcud) as rcu-low-lat
> > does.
> 
> very nice.

Yes. BTW, throttle-rcu too can't avoid route cache overflow under
DoS stress test. Different problem, but I just wanted to mention
this. I will publish those results separately.


> > I used the following throttle-rcu patch with rcupdate.rcumaxbatch
> > set to 16 and rcupdate.rcuplugticks set to 0. That is essentially
> > equvalent to Andrea's earler suggestion. I have so many knobs in
> > the patch because I had written it earlier for other experiments.
> > Anyway, if throttling works as well as this in terms of latency
> > for other workloads as well and there isn't any OOM situations,
> > it is preferable to creating another per-cpu thread.
> 
> I don't think this is enough (it is enough for the above workload
> though, maybe for the dcache too, but it's not generic enough), 16
> callbacks per tick too low frequency, it may not keep up, that's why I

That was not 16 callbacks per tick, it was 16 callbacks in one
batch of a single softirq. And then I reschedule the RCU tasklet
to process the rest. I am planning to vary this and see if we
should do even less per softirq.

> But I certainly agree this is a nice solution in practice (at least with
> all the common usages).

Needs more testing with other workloads. I will have some more results
with the tiny files test.

Thanks
Dipankar
