Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbWAPRit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbWAPRit (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 12:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbWAPRit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 12:38:49 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:146 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750768AbWAPRis (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 12:38:48 -0500
Date: Mon, 16 Jan 2006 23:09:30 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       dada1@cosmobay1.com
Subject: Re: [RFC][PATCH] RCU tuning for latency/OOM
Message-ID: <20060116173930.GA4521@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20060106181148.GB6897@in.ibm.com> <20060116165441.GA5683@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060116165441.GA5683@us.ibm.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2006 at 08:54:41AM -0800, Paul E. McKenney wrote:
> On Fri, Jan 06, 2006 at 11:41:49PM +0530, Dipankar Sarma wrote:
> > +++ linux-2.6.15-rc5-rcu-dipankar/kernel/rcupdate.c	2006-01-06 22:41:46.000000000 +0530
> > @@ -71,7 +71,10 @@ DEFINE_PER_CPU(struct rcu_data, rcu_bh_d
> >  
> >  /* Fake initialization required by compiler */
> >  static DEFINE_PER_CPU(struct tasklet_struct, rcu_tasklet) = {NULL};
> > -static int maxbatch = 10000;
> > +static int blimit = 10;
> > +static int qhimark = 10000;
> > +static int qlowmark = 100;
> > +static int rsinterval = 1000;
> 
> My kneejerk reaction is that rsinterval would normally need to be
> about the same size as qhimark, but must defer to real-world experience.

In the absence of real-world results, this is probably as good
a guess as any. BTW, I picked the 1000 value from your "send
forcible resched" patch some time earlier :)


> > +static inline void force_quiescent_state(struct rcu_data *rdp,
> > +			struct rcu_state *rsp)
> > +{
> > +	int cpu;
> > +	set_need_resched();
> > +	if (unlikely(rdp->qlen - rdp->last_rs_qlen > rsinterval)) {
> > +		rdp->last_rs_qlen = rdp->qlen;
> > +		for_each_cpu_mask(cpu, rsp->cpumask)
> > +			smp_send_reschedule(cpu);
> 
> This sends an unneeded IPI to the sending CPU as well -- perhaps check
> for cpu==smp_processor_id()?

I will soon have a newer version that resets the current cpu's
bit as well as makes all but the set_need_resched() go away
when CONFIG_SMP=n.


> >  	*rdp->nxttail = head;
> >  	rdp->nxttail = &head->next;
> >  
> > -	if (unlikely(++rdp->count > 10000))
> > -		set_need_resched();
> > +	if (unlikely(++rdp->qlen > qhimark)) {
> > +		rdp->blimit = INT_MAX;
> 
> I believe I understand what you are doing here, entering a sort of 
> "desperation mode" to avoid an OOM event.  But this means that the
> softirq function can spend an arbitrary amount of time processing
> callbacks.
> 
> So, I agree that you need to do this when in "desperation mode".
> But shouldn't this be in response to OOM or something, rather than
> the first response to hitting the high-water mark?

There is no easy way to detect "OOM" from RCU perspective - each
subsystem using RCU has its own "OOM" situation. Unless we put
hooks in each of those (which we could, but that shouldn't be
the first thing to try IMO), there is no easy way to detect it.
We could look at a more gradual increase and decrease of ->blimit, 
if we see serious latency problems with real-world workloads.


> > @@ -176,10 +193,12 @@ static void rcu_do_batch(struct rcu_data
> >  		next = rdp->donelist = list->next;
> >  		list->func(list);
> >  		list = next;
> > -		rdp->count--;
> > -		if (++count >= maxbatch)
> > +		rdp->qlen--;
> > +		if (++count >= rdp->blimit)
> 
> Cute -- but doesn't this want to be something like:
> 
> 		if (++count > rdp->blimit)
> 
> so that you go forever in the "rdp->blimit == INTMAX" case?  Or do you
> really want to stop after 2^31 repetitions?  Hmmm...  I guess that it
> is -really- hard to argue that this matters either way.  If you really
> go through 2^31 repetitions, the system is really cranking memory through
> RCU, so there is some question in my mind as to whether it is getting
> any real work done anyway...

->blimit == INTMAX is just a way of letting the system process
a very large number of RCUs, it doesn't really matter. It is either
we get to this "desperation mode" on high water mark or use
a gradual increase in ->blimit. Some actual data from RT
workloads would be nice here.

> >  	}
> > +	if (rdp->blimit == INT_MAX && rdp->qlen <= qlowmark)
> > +		rdp->blimit = blimit;
> 
> Would it make sense to cap rdp->blimit to max(blimit,rdp->qlen)?

I am not sure how that would make a difference. Anyway we can't
have more than ->qlen to process.

> If it makes sense to increase blimit slowly, seems like it also
> makes sense to decrease it slowly.  Not sure what the correct
> algorithm is, though.

I agree with the former and not  sure myself about what would
be a good algorithm for ->blimit. However, this is the simplest
thing I could think of and anything further should probably
be based on real-world measurements.

Thanks
Dipankar
