Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbUC3VIa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 16:08:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbUC3VIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 16:08:30 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:57069 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261231AbUC3VI2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 16:08:28 -0500
Date: Wed, 31 Mar 2004 02:36:48 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       Robert Olsson <Robert.Olsson@data.slu.se>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, Dave Miller <davem@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Andrew Morton <akpm@osdl.org>
Subject: Re: route cache DoS testing and softirqs
Message-ID: <20040330210648.GB3956@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20040329184550.GA4540@in.ibm.com> <20040329222926.GF3808@dualathlon.random> <20040330144324.GA3778@in.ibm.com> <20040330195315.GB3773@in.ibm.com> <20040330204731.GG3808@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040330204731.GG3808@dualathlon.random>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2004 at 10:47:32PM +0200, Andrea Arcangeli wrote:
> I see what's going on now, yes my patch cannot help. the workload is
> simply generating too much hardirq load, and it's like if we don't use
> softirq at all but that we process the packet inside the hardirq for
> this matter. As far as RCU is concerned it's like if there a no softirq
> at all but that we process everything in the hardirq.
> 
> so what you're looking after is a new feature then:
> 
> 1) rate limit the hardirqs
> 2) rate limit only part of the irq load (i.e. the softirq, that's handy
>    since it's already splitted out) to scheduler-aware context (not
>    inside irq context anymore)

There were a number of somewhat ugly softirq limiting patches that
Robert tried out (not spitting them to scheduler-aware context) and some 
combination of that worked well in Robert's setup. I will see if I can 
revive that. That said, we would need to find out how badly we affect network
performance with that thing.

> 3) stop processing packets in irqs in the first place (NAPI or similar)
> 
> however I start to think they can be all wrong, and that rcu is simply
> not suitable for purerely irq usages like this. w/o rcu there would be
> no need of the scheduler keeping up with the irq load, and in some usage
> I can imagine that it is a feature to prioritize heavily on the
> irq load vs scheduler-aware context.

Not necessarily, we can do a call_rcu_bh() just for softirqs with 
softirq handler completion as a quiescent state. That will likely
help with the route cache overflow problem atleast.

Thanks
Dipankar
