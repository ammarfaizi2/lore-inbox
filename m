Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262095AbTE0Azu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 20:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbTE0Azu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 20:55:50 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:10194
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262095AbTE0Azt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 20:55:49 -0400
Date: Tue, 27 May 2003 03:09:03 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: akpm@digeo.com, davidsen@tmr.com, haveblue@us.ibm.com, habanero@us.ibm.com,
       mbligh@aracnet.com, linux-kernel@vger.kernel.org
Subject: Re: userspace irq balancer
Message-ID: <20030527010903.GF3767@dualathlon.random>
References: <20030527000639.GA3767@dualathlon.random> <20030526.171527.35691510.davem@redhat.com> <20030527004115.GD3767@dualathlon.random> <20030526.174841.116378513.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030526.174841.116378513.davem@redhat.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 26, 2003 at 05:48:41PM -0700, David S. Miller wrote:
>    From: Andrea Arcangeli <andrea@suse.de>
>    Date: Tue, 27 May 2003 02:41:15 +0200
> 
>    In 2.4 normally the softirq (of course w/o NAPI) are
>    served in irq context so we didn't face this yet.
>    
> Andrea, whether ksoftirqd processes the softirq work or not has
> nothing to do with what I'm talking about.
> 
> It is all about what does a hardware IRQ mean in terms of work
> processed.  And it can mean anything from 1 to 1000 packets worth
> of work.
> 
> Therefore, any usage of hardware IRQ activity to determine "load" in
> any sense is totally inaccurate.
> 
> So I'm asking you, again, how are you going to measure softirq load in
> making hardware IRQ load balancing decisions?  Watching the scheduling

rdtsc could do it very well, irqs and softirqs can't be rescheduled so
you can tick measure how long you take in each cpu, same goes for each
task before migrating to another cpu (I'm only assuming this is SMP and
not AMT, still if the difference between cpu frequency among cpus isn't
huge it could stil work with AMT, a multiplicator could be applied with
AMT). This "non idle" load could be accounted in a per-cpu array.

I'm not going to implement the above in 2.4, that sounds a 2.5 thing,
but my point is that by just ignoring ksoftirqd in the idle selection
should avoid the biggest of the NAPI issues. I'm approximating, i.e.
better than nothing approch (either that or nothing). I never claimed
that to be a final golden algorihm, just obviously better than the
total-trashing one and even w/o the ksoftirqd and HT last bits, numbers
confirmed that.

And for 2.5 there are many doors open for further optimizations of
course.

> But deciding how to intepret these measurements and what to do in
> response is a userlevel policy decision.  This also coincides with
> how cpufreq works.

you mean you can have slightly different modes selectable by sysctl
right? or do you really want to generate a reschedule per second with
tlb flush and microkernel API between user and kernel in turn total
waste of resources just to avoid admitting irq balancing belongs to the
kernel?

Andrea
