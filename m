Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbUC3UaI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 15:30:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbUC3UaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 15:30:08 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:21394 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261162AbUC3U37
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 15:29:59 -0500
Date: Wed, 31 Mar 2004 01:58:21 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: kuznet@ms2.inr.ac.ru
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, Robert.Olsson@data.slu.se,
       "Paul E. McKenney" <paulmck@us.ibm.com>, Dave Miller <davem@redhat.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: route cache DoS testing and softirqs
Message-ID: <20040330202820.GA3956@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20040329222926.GF3808@dualathlon.random> <200403302005.AAA00466@yakov.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403302005.AAA00466@yakov.inr.ac.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2004 at 12:05:05AM +0400, kuznet@ms2.inr.ac.ru wrote:
> What's about the problem it really splits to two ones:
> 
> 1. The _new_ problem when bad latency of rcu hurts core
>    functionality. This is precise description:

Which essentially happens due to userland starvation during a
softirq flood.

> 
> > to keep up with the softirq load.  This has never been the case so far,
> > and serving softirq as fast as possible is normally a good thing for
> > server/firewalls, the small unfariness (note unfariness != starvation)
> > it generates has never been an issue, because so far the softirq never
> > required the scheduler to work in order to do their work, rcu changed
> > this in the routing cache specific case.
> 
> We had one full solution for this issue not changing anything
> in scheduler/softirq relationship: to run rcu task for the things
> sort of dst cache not from process context, but essentially as part
> of do_softirq(). Simple, stupid and apparently solves new problems
> which rcu created.

Can you be a little bit more specific about this solution ? There
were a number of them discussed during our private emails and I
can't tell which one you are talking about.

> Another solution is just to increase memory consumption limits
> to deal with current rcu latency. F.e. 300ms latency just requires
> additional space for pps*300ms objects, which are handled by RCU.
> The problem with this is that pps is the thing which increases
> when cpu power grows and that 300ms is not a mathematically established
> limit too.

I don't think increasing memory consumption limit is a good idea.

> Andrea, it is experimenatl fact: this "small unfariness" stalls process
> contexts for >=6 seconds and gives them microscopic slices. We could live
> with this (provided RCU problem is solved in some way). Essentially,
> the only trouble for me was that we could use existing rcu bits to make
> offloading to ksoftirqd more smart (not aggressive, _smart_). The absense
> of RCU quiescent states looks too close to absence of forward progress
> in process contexts, it was anticipating similarity. The dumb throttling
> do_softirq made not from ksoftirqd context when starvation is detected
> which we tested the last summer is not only ugly, it really might hurt
> router performance, you are right here too. It is the challenge:
> or we proceed with this idea and invent something, or we just forget
> about this concentrating on RCU.

Exactly. And the throttling will likely  not be enough by ksoftirqd
as indicated by my earlier experiments. We have potential fixes
for RCU through a call_rcu_bh() interface where completion of a
softirq handler is a quiescent state. I am working on forward porting
that old patch from our discussion last year and testing in my
environment. That should increase the number of quiescent state
points significantly and hopefully reduce the grace period significantly.
But this does nothing to help userland starvation.

Thanks
Dipankar
