Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932411AbWA1RIw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932411AbWA1RIw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 12:08:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbWA1RIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 12:08:52 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:47341 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932411AbWA1RIv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 12:08:51 -0500
Date: Sat, 28 Jan 2006 22:38:19 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch 1/2] rcu batch tuning
Message-ID: <20060128170819.GC5633@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <43DA7B47.11D10B09@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43DA7B47.11D10B09@tv-sign.ru>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2006 at 10:57:59PM +0300, Oleg Nesterov wrote:
> Dipankar Sarma wrote:
> >
> > @@ -92,17 +128,13 @@ void fastcall call_rcu(struct rcu_head *
> >  	rdp = &__get_cpu_var(rcu_data);
> >  	*rdp->nxttail = head;
> >  	rdp->nxttail = &head->next;
> > -
> > -	if (unlikely(++rdp->count > 10000))
> > -		set_need_resched();
> > -
> > +	if (unlikely(++rdp->qlen > qhimark)) {
> > +		rdp->blimit = INT_MAX;
> > +		force_quiescent_state(rdp, &rcu_ctrlblk);
> > +	}
> 
> When ->qlen exceeds qhimark for the first time we send reschedule IPI to
> other CPUs and force_quiescent_state() records ->last_rs_qlen = ->qlen.
> But we don't reset ->last_rs_qlen when ->qlen goes to 0, this means that
> next time we need ++rdp->qlen > qhimark + rsinterval to force other CPUS
> to pass quiescent state, no?

Yes. I have fixed it my code.

> 
> Also, it seems to me it's better to have 2 counters, one for length(->donelist)
> and another for length(->curlist + ->nxtlist). I think we don't need
> force_quiescent_state() when all rcu callbacks are placed in ->donelist,
> we only need to increase rdp->blimit in this case.

We could, but I am not sure that ->qlen is not a good measure of
grace period not happening. In fact, in the past, long donelists
often resulted in longer grace periods. So, no harm in forcing
reschedule and allowing ksoftirq to relinquish cpu.

Thanks
Dipankar
