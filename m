Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbUC3TzB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 14:55:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbUC3TzB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 14:55:01 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:34198 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261158AbUC3Ty5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 14:54:57 -0500
Date: Wed, 31 Mar 2004 01:23:15 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       Robert Olsson <Robert.Olsson@data.slu.se>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, Dave Miller <davem@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Andrew Morton <akpm@osdl.org>
Subject: Re: route cache DoS testing and softirqs
Message-ID: <20040330195315.GB3773@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20040329184550.GA4540@in.ibm.com> <20040329222926.GF3808@dualathlon.random> <20040330144324.GA3778@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040330144324.GA3778@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2004 at 08:13:24PM +0530, Dipankar Sarma wrote:
> On Tue, Mar 30, 2004 at 12:29:26AM +0200, Andrea Arcangeli wrote:
> > So you're simply asking the ksoftirqd offloading to become more
> > aggressive, and to make the softirq even more scheduler friendly,
> > something I never had a reason to do yet, since ksoftirqd already
> > eliminates the starvation issue, and secondly because I did care about
> > the performance of softirq first (delaying softirqs is derimental for
> > performance if it happens frequently w/o this kind of flood-load). I
> > even got a patch for 2.4 doing this kind of changes to the softirqd for
> > similar reasons on embedded systems where the cpu spent on the softirqs
> > would been way too much under attack. I had to back it out since it was
> > causing drop of performance in specweb or something like that and nobody
> > but the embdedded people needed it.  But now here we've a case where it
> > makes even more sense since the hardirq aren't strictly related to this
> > load, this load with the rcu-routing-cache is just about letting the
> > scheduler go together witn an intensive softirq load. So we can try
> > again with a truly userspace throttling of the softirqs (and in 2.4 I
> > didn't change the nice from 19 to -20 so maybe this will just work
> > perfectly).
> 
> Tried it and it didn't work. I still got dst cache overflows. I will dig
> out more numbers about what what happened - is ksoftirqd a pig still or
> we are mostly doing short softirq bursts on the back of a hardirq
> flood.

It doesn't look as if we are processing much from ksoftirqd at
all in this case. I did the following instrumentation -

        if (in_interrupt() && local_softirqd_running())
                return;
        max_restart = MAX_SOFTIRQ_RESTART;
        local_irq_save(flags);

        if (rcu_trace) {
                int cpu = smp_processor_id();
                per_cpu(softirq_count, cpu)++;
                if (local_softirqd_running() && current == __get_cpu_var(ksoftirqd))
                        per_cpu(ksoftirqd_count, cpu)++;
                else if (!in_interrupt())
                        per_cpu(other_softirq_count, cpu)++;
        }
        pending = local_softirq_pending();

A look at the softirq_count, ksoftirqd_count and other_softirq_count shows -

CPU 0 : 638240	554	637686
CPU 1 : 102316 	1 	102315
CPU 2 : 675696 	557 	675139
CPU 3 : 102305 	0 	102305

So, it doesn't seem supprising that your ksoftirqd offloading didn't
really help much. The softirq frequency and grace period graph
looks pretty much same without that patch -

http://lse.sourceforge.net/locking/rcu/rtcache/pktgen/andrea/cpu-softirq.png

We are simply calling do_softirq() too much it seems and not letting
other things run on the system. Perhaps we need to look at real
throttling of softirqs ?

Thanks
Dipankar
