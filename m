Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750997AbVLaE3e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997AbVLaE3e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 23:29:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbVLaE3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 23:29:33 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:62924 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750990AbVLaE3d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 23:29:33 -0500
Date: Fri, 30 Dec 2005 20:29:03 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Dave Jones <davej@redhat.com>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Eric Dumazet <dada1@cosmosbay.com>,
       Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: [patch] latency tracer, 2.6.15-rc7
Message-ID: <20051231042902.GA3428@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <1135887072.6804.9.camel@mindpipe> <1135887966.6804.11.camel@mindpipe> <20051229202848.GC29546@elte.hu> <1135908980.4568.10.camel@mindpipe> <20051230080032.GA26152@elte.hu> <1135990270.31111.46.camel@mindpipe> <Pine.LNX.4.64.0512301701320.3249@g5.osdl.org> <1135991732.31111.57.camel@mindpipe> <Pine.LNX.4.64.0512301726190.3249@g5.osdl.org> <1136001615.3050.5.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136001615.3050.5.camel@mindpipe>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 30, 2005 at 11:00:15PM -0500, Lee Revell wrote:
> On Fri, 2005-12-30 at 17:39 -0800, Linus Torvalds wrote:
> > diff --git a/kernel/rcupdate.c b/kernel/rcupdate.c
> > index 48d3bce..b107562 100644
> > --- a/kernel/rcupdate.c
> > +++ b/kernel/rcupdate.c
> > @@ -149,11 +149,10 @@ void fastcall call_rcu_bh(struct rcu_hea
> >         *rdp->nxttail = head;
> >         rdp->nxttail = &head->next;
> >         rdp->count++;
> > -/*
> > - *  Should we directly call rcu_do_batch() here ?
> > - *  if (unlikely(rdp->count > 10000))
> > - *      rcu_do_batch(rdp);
> > - */
> > +
> > +       if (unlikely(++rdp->count > 100))
> > +               set_need_resched();

This should help in UP configurations, or in SMP configurations where
all CPUs are doing call_rcu_bh() very frequently.  I would not expect
it to help in cases where one of several CPUs is frequently executing
call_rcu_bh(), but where the other CPUs are either CPU-bound in user
space or are in a tickful idle state.

My guess is that Lee would be running a UP kernel.

> >         local_irq_restore(flags);
> >  } 
> 
> This increments rdp->count twice - is that intentional?

If it was intentional, I would argue instead for

	if (unlikely(rdp->count > 50))

> Also what was the story deal with the commented out code?

Any number of people, myself included, have been seduced by the thought
of invoking callbacks from call_rcu() or call_rcu_bh() context.  When I
first un-seduced myself from this approach, I documented the reasons
why it is a bad idea in Documentation/RCU/UP.txt -- the gist of it is
that there are a number of self-deadlock traps that are easy to fall into.

						Thanx, Paul
