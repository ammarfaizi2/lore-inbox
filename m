Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264212AbTE0WNd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 18:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264215AbTE0WNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 18:13:33 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:59265
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264212AbTE0WNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 18:13:31 -0400
Date: Wed, 28 May 2003 00:27:12 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: akpm@digeo.com, davidsen@tmr.com, haveblue@us.ibm.com, habanero@us.ibm.com,
       mbligh@aracnet.com, linux-kernel@vger.kernel.org
Subject: Re: userspace irq balancer
Message-ID: <20030527222712.GB1453@dualathlon.random>
References: <20030527012617.GH3767@dualathlon.random> <20030526.231120.26504389.davem@redhat.com> <20030527115314.GU3767@dualathlon.random> <20030527.150449.08322270.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030527.150449.08322270.davem@redhat.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 27, 2003 at 03:04:49PM -0700, David S. Miller wrote:
>    From: Andrea Arcangeli <andrea@suse.de>
>    Date: Tue, 27 May 2003 13:53:14 +0200
> 
>    in case it wasn't obvious (that is the whole point of ksoftirqd) what
>    accomplishes in a single word is "fairness" and "not starving userspace
>    during networking".
> 
> The problem is that is gives up and goes to ksoftirqd far too easily.

I see your point, please try with 2.4.21rc4aa1 or with this patch:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.21rc4aa1/00_ksoftirqd-max-loop-networking-1

you can put a printk in the ksoftirqd loop and tune the N until it
behaves as you want.

> Also, if a softirq is triggered between when we wake up ksoftirqd and
> ksoftirqd actually runs, we just run the loop again in do_softirq().

but the loop will do nothing, I mean ksoftirqd is checking if some work
has to be done, and that's achieved in do_softirq, exactly the same that
each irq does before returning to userspace. no difference.

> This situation is even more likely if we are being "softirq bombed".
> In fact in such a situation it is almost a certainty that do_softirq()
> will execute multiple times before we schedule to any task.
> 
> In fact, and here is the important part, we probably won't run very
> much userspace at all if we are being "softirq bombed".  Every trap,
> softirq causing or not, is going to cause us to drop into do_softirq()
> again and again and again.
> 
> Perhaps even, we will drain the pending softirqs before ksoftirqd even
> gets to execute.  In this case the ksoftirqd wakeup and context switch
> is a total waste of cpu cycles.
> 
> You are trying to apply flow control in an odd way to softirqs.
> But the problem with such schemes is that they absolutely do not
> make the problem go away.  You are merely moving the work from one
> place to another, and in many cases added more useless work.  The one
> thing you don't do when you are resource limited is take more of those
> resources away and that is exactly what the ksoftirqd scheme does.

That's a purerly theorical case that also Ingo made once, but you should
do all the theory and also compute the probability of the irqs arriving
at the exact timing that forbids userspace to make progress with the
ksoftirqd design for a significant amount of time. That is too low to
care about it.  While when you're flooded at max speed ksoftirqd
generates a fair load, plus it allows NAPI to work at all which is
needed on firewalls.

The only problem I can see is that the spikes of load may generate
spurious ksoftirqd reschedules, I acknowledge that, and for those we can
just change the #define in teh above patch. I flooded my boxes through
100mbit and ksoftirqd apparently isn't running at all (not that I ever
noticed it running significantly though ;). I don't have gigabit to test
that's why I ask.

Andrea
