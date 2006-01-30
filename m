Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750831AbWA3Dat@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbWA3Dat (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 22:30:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750713AbWA3Dat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 22:30:49 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:13191 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750831AbWA3Das
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 22:30:48 -0500
Date: Sun, 29 Jan 2006 19:30:00 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Dipankar Sarma <dipankar@in.ibm.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch 1/2] rcu batch tuning
Message-ID: <20060130032959.GC16585@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <43DA7B47.11D10B09@tv-sign.ru> <20060127234231.GD10075@us.ibm.com> <43DBB2D1.8E79F4CE@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43DBB2D1.8E79F4CE@tv-sign.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2006 at 09:07:13PM +0300, Oleg Nesterov wrote:
> "Paul E. McKenney" wrote:
> > 
> > On Fri, Jan 27, 2006 at 10:57:59PM +0300, Oleg Nesterov wrote:
> > >
> > > When ->qlen exceeds qhimark for the first time we send reschedule IPI to
> > > other CPUs and force_quiescent_state() records ->last_rs_qlen = ->qlen.
> > > But we don't reset ->last_rs_qlen when ->qlen goes to 0, this means that
> > > next time we need ++rdp->qlen > qhimark + rsinterval to force other CPUS
> > > to pass quiescent state, no?
> > 
> > Good catch -- this could well explain Lee's continuing to hit
> > latency problems.  Although this would not cause the first
> > latency event, only subsequent ones, it seems to me that ->last_rs_qlen
> > should be reset whenever ->blimit is reset.
> 
> May be it's better to do it in other way?
> 
> struct rcu_ctrlblk {
> 	...
> 	int signaled;
> 	...
> };
> 
> void force_quiescent_state(rdp, rcp)
> {
> 	if (!rcp->signaled) {
> 		// racy, but tolerable
> 		rcp->signaled = 1;
> 
> 		for_each_cpu_mask(cpu, cpumask)
> 			smp_send_reschedule(cpu);
> 	}
> }
> 
> void rcu_start_batch(rcp, rdp)
> {
> 	if (->next_pending && ->completed == ->cur) {
> 		...
> 		rcp->signaled = 0;
> 		...
> 	}
> }

Possibly...  But the best thing would be for you and Dipankar to
get together to work out the best strategy for this.

							Thanx, Paul

> Probably it is also makes sense to tasklet_schedule(rcu_tasklet)
> in call_rcu() when ++rdp->qlen > qhimark, this way we can detect
> that we need to start the next batch earlier.
> 
> > > Also, it seems to me it's better to have 2 counters, one for length(->donelist)
> > > and another for length(->curlist + ->nxtlist). I think we don't need
> > > force_quiescent_state() when all rcu callbacks are placed in ->donelist,
> > > we only need to increase rdp->blimit in this case.
> >
> > True, currently the patch keeps the sum of the length of all three lists,
> > and takes both actions when the sum gets too large.  But the only way
> > you would get unneeded IPIs would be if callback processing was
> > stalled, but callback generation and grace-period processing was
> > still proceeding.  Seems at first glance to be an unusual corner
> > case, with the only downside being some extra IPIs.  Or am I missing
> > some aspect?
> 
> Yes, it is probably not worth to complicate the code.
> 
> Oleg.
> 
