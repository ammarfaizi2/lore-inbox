Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288485AbSBIGyA>; Sat, 9 Feb 2002 01:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288512AbSBIGxv>; Sat, 9 Feb 2002 01:53:51 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:59389 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S288485AbSBIGxe>;
	Sat, 9 Feb 2002 01:53:34 -0500
Date: Sat, 9 Feb 2002 12:26:10 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Robert Love <rml@tech9.net>
Cc: Mark Hahn <hahn@physics.mcmaster.ca>, linux-kernel@vger.kernel.org,
        Paul McKenney <paul.mckenney@us.ibm.com>
Subject: Re: [PATCH] Read-Copy Update 2.5.4-pre2
Message-ID: <20020209122610.D19737@in.ibm.com>
Reply-To: dipankar@in.ibm.com
In-Reply-To: <Pine.LNX.4.33.0202081847020.30304-100000@coffee.psychology.mcmaster.ca> <1013212443.806.196.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1013212443.806.196.camel@phantasy>; from rml@tech9.net on Fri, Feb 08, 2002 at 06:54:02PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2002 at 06:54:02PM -0500, Robert Love wrote:
> On Fri, 2002-02-08 at 18:51, Mark Hahn wrote:
> 
> > yes, but have you evaluated whether it's noticably better than
> > other forms of locking?  for instance, couldn't your dcache example
> > simply use BR locks?
> 
> Good point.
> 
> One of the things with implicit locking schemes like RCU is that the
> performance hit merely shifts.  Reading the data may no longer have any
> overhead, but the hit is taken elsewhere.  One most be careful in
> benchmarking RCU locking.

I agree that it is a valid concern and a large part of our effort
has been to understand the effect of RCU in linux.

Theoritically overheads can come from the following places -

1. RCU  implementation itself
2. Introduction of additional finer-grain locking to support RCU
3. Re-organization of algorithm to support RCU

I will address #1. The points #2 and #3 will have to be decided
on case-to-case basis, RCU by itself doesn't force #2 and #3.
If you have a concern about any RCU application regarding 
#2 and #3, raise it and we can have a discussion.

Coming to #1 - 

We have experimented with a number of algorithms
to understand the impact of RCU overhead. There was one observation
throughout - performance depends predominantly on being able
to quickly queue the RCU callback and move on. call_rcu()
achieves that. 

The overhead of generating/detecting a "quiescent cycle" is
another area we have looked at. The rcu_poll patch essentially
forces a quiescent cycle, but that too can be avoided. We have
implemented another method where quiecent cycle is not forced
and we detect it by periodic checking. This period can be
significantly long (our implementation uses 50ms).

http://prdownloads.sf.net/lse/rcu-2.5.3-2.patch uses per-CPU
queues and a 50ms timer to periodically check for RCU completion.

http://lse.sf.net/locking/patches/X-rcu-2.5.3-4.patch also
uses per-CPU queues and 50ms timer, but doesn't use krcuds.
It however depends on Rusty's per-CPU area patch and
smptimers patch.

Both of these patches add only infrequent bottom-half processing
doing some work most of which would have been done in fast path
in the absense of RCU anyway.

Thanks
Dipankar
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
