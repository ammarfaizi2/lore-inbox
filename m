Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272329AbRIKIrB>; Tue, 11 Sep 2001 04:47:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272330AbRIKIqv>; Tue, 11 Sep 2001 04:46:51 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:17904 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S272329AbRIKIqk>; Tue, 11 Sep 2001 04:46:40 -0400
Date: Tue, 11 Sep 2001 14:21:58 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: hch@caldera.de
Cc: linux-kernel@vger.kernel.org, Paul Mckenney <paul.mckenney@us.ibm.com>,
        Andrea Arcangeli <andrea@suse.de>
Subject: Re: 2.4.10pre7aa1
Message-ID: <20010911142158.A1537@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

In article <20010910205250.B22889@caldera.de> you wrote:

> Hmm, I don't see why latency is important for rcu - we only want to
> free datastructures.. (mm load?).

While it is not important for RCU to do the updates quickly, it is
still necessary that updates are not completely starved out by
high-priority tasks. So, the idea behind using high-priority
krcuds is to ensure that they don't get starved thereby delaying
updates for unreasonably long periods of time which could lead
to memory pressure or other performance problems depending on
how RCU is being used. 


> On the other hands they are the experts on RCU, not I so I'll believe them.

>> So in short if you really are in pain for 8k per cpu to get the best
>> runtime behaviour and cleaner code I'd at least suggest to use the
>> ksoftirqd way that should be the next best step.

> My problem with this appropech is just that we use kernel threads for
> more and more stuff - always creating new ones.  I think at some point
> they will sum up badly.

> 	Christoph

I agree that it is not always a good idea to use kernel threads for
everything, but in this case this seems to be the safest and
most reasonable option.

FYI, there are a couple of other implementations, but they all affect
code in fast paths even if there is no RCU going on in the system.
One of them is from Rusty that keeps track of CPUs going through
quiescent state from the scheduler context and also executes the
callbacks from the scheduler context. The other patch is based
on our old DYNIX/ptx implementation - it uses one per-cpu context
switch counter to detect quiescent state and checks for completion
of RCU in local timer interrupt handler. Once all the CPUs go
through a quiescent state, the callbacks are processed using
a tasklet. 

Thanks
Dipankar
-- 
Dipankar Sarma  <dipankar@in.ibm.com> Project: http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
