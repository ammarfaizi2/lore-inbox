Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316852AbSE1RGp>; Tue, 28 May 2002 13:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316853AbSE1RGo>; Tue, 28 May 2002 13:06:44 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:59597 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S316852AbSE1RGo>;
	Tue, 28 May 2002 13:06:44 -0400
Date: Tue, 28 May 2002 22:39:45 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Robert Love <rml@tech9.net>
Cc: "David S. Miller" <davem@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Paul McKenney <paul.mckenney@us.ibm.com>,
        Andrea Arcangeli <andrea@suse.de>
Subject: Re: 8-CPU (SMP) #s for lockfree rtcache
Message-ID: <20020528223945.A22573@in.ibm.com>
Reply-To: dipankar@in.ibm.com
In-Reply-To: <20020528171104.D19734@in.ibm.com> <20020528.042514.92633856.davem@redhat.com> <20020528182806.A21303@in.ibm.com> <1022600998.20317.44.camel@sinai> <20020528215535.A22328@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2002 at 09:55:35PM +0530, Dipankar Sarma wrote:
> Hi Robert,
> 
> On Tue, May 28, 2002 at 08:49:58AM -0700, Robert Love wrote:
> > 
> > > Well, the last time RCU was discussed, Linus said that he would
> > > like to see someplace where RCU clearly helps.
> > 
> > I agree the numbers posted are nice, but I remain skeptical like Linus. 
> > Sure, the locking overhead is nearly gone in the profiled function where
> > RCU is used.  But the overhead has just been _moved_ to wherever the RCU
> > work is now done.  Any benchmark needs to include the damage done there,
> > too.
> 
> Have you looked at the rt_rcu patch ? Where do you think there
> is overhead compared to what route cache alread does ? In my
> profiles, rcu routines and kernel mechanisms that it uses
> don't show high up. If you have any suggestions, then I can
> do an investigation.

Hi Robert,

While we are at it, I think this is good point to analyze.
So here is an brief analysis of rt_rcu patch from the overhead
standpoint -

1. Read side has no overhead, we just don't take the per-bucket lock.
2. For just the route cache portion of code, RCU comes into picture
   only when dst entries are deleted. This however has two issues -
   a> expiry of dst entries is checked through a non-frequent
   timer b>lease for recently used dst entries are extended.
   So we don't do frequent RCU based deletion of dst entries.
   Periodically a set of dst entries expire and instead of
   freeing them immediately, we just put them in RCU queue(s)
   for freeing after the grace period (call_rcu() in rt_free()).

Coming to the RCU mechanism -

1. Grace period detection : Different RCU algorithms do it
   differently, however if there is no RCU pending *nothing*
   is done regarding this. One rcu implementation uses
   a 10ms timer to check for grace period completion and another
   rcu_poll uses a repeating tasklet to poll for it. The grace period
   detection is based on a per-cpu context switch counter. I have not seen
   signficant profile counts for grace period detection scheme, but
   nevertheless I will put up the profile counts for Dave's test
   at the LSE website.

2. Actual update : RCU processes the batched update callbacks from tasklet
   context. The rt_rcu callbacks don't do anything other than
   call dst_free(), which would have been called by non-RCU
   code under lock in any case. I am not sure doing this from
   tasklet context adds any overhead and I suspect that it doesn't.

Comments/suggestions ?

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
