Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266236AbUGOQNR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266236AbUGOQNR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 12:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266240AbUGOQNR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 12:13:17 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:7862 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S266236AbUGOQNA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 12:13:00 -0400
Date: Thu, 15 Jul 2004 21:40:54 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Chris Wright <chrisw@osdl.org>, Ravikiran G Thirumalai <kiran@in.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Lock free fd lookup
Message-ID: <20040715161054.GB3957@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20040714045345.GA1220@obelix.in.ibm.com> <20040714045640.GB1220@obelix.in.ibm.com> <20040714081737.N1973@build.pdx.osdl.net> <200407151022.53084.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407151022.53084.jbarnes@engr.sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2004 at 10:22:53AM -0400, Jesse Barnes wrote:
> On Wednesday, July 14, 2004 11:17 am, Chris Wright wrote:
> > I'm curious, how much of the performance improvement is from RCU usage
> > vs. making the basic syncronization primitive aware of a reader and
> > writer distinction?  Do you have benchmark for simply moving to rwlock_t?
> 
> That's a good point.  Also, even though the implementation may be 'lockless', 
> there are still a lot of cachelines bouncing around, whether due to atomic 
> counters or cmpxchg (in fact the latter will be worse than simple atomics).

Chris raises an interesting issue. There are two ways we can benefit from
lock-free lookup - avoidance of atomic ops in lock acquisition/release
and avoidance of contention. The latter can also be provided by
rwlocks in read-mostly situations like this, but rwlock still has
two atomic ops for acquisition/release. So, in another
thread, I have suggested looking into the contention angle. IIUC,
tiobench is threaded and shares fd table. 

That said, atomic counters weren't introduced in this patch,
they are already there for refcounting. cmpxchg is costly,
but if you are replacing read_lock/atomic_inc/read_unlock,
lock-free + cmpxchg, it might not be all that bad. Atleast,
we can benchmark it and see if it is worth it. And in heavily
contended cases, unlike rwlocks, you are not going to have
starvation.

> 
> It seems to me that RCU is basically rwlocks on steroids, which means that 
> using it requires the same care to avoid starvation and/or other scalability 
> problems (i.e. we'd better be really sure that a given codepath really should 
> be using rwlocks before we change it).

The starvation is a problem with rwlocks in linux, not RCU. The
reader's do not impede writers at all with RCU. There are other
issues with RCU that one needs to be careful about, but certainly
not this one.

Thanks
Dipankar
