Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751067AbWIHQag@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbWIHQag (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 12:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751068AbWIHQag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 12:30:36 -0400
Received: from taganka54-host.corbina.net ([213.234.233.54]:52705 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S1751024AbWIHQaf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 12:30:35 -0400
Date: Fri, 8 Sep 2006 20:30:22 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: Dipankar Sarma <dipankar@in.ibm.com>,
       Srivatsa Vaddagiri <vatsa@in.ibm.com>,
       Eric Dumazet <dada1@cosmosbay.com>,
       "David S. Miller" <davem@davemloft.net>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, josht@us.ibm.com
Subject: Re: [PATCH] simplify/improve rcu batch tuning
Message-ID: <20060908163022.GA149@oleg>
References: <20060903163419.GA235@oleg> <20060907203727.GE1293@us.ibm.com> <20060908113930.GB250@oleg> <20060908160234.GE1314@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060908160234.GE1314@us.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08, Paul E. McKenney wrote:
>
> On Fri, Sep 08, 2006 at 03:39:30PM +0400, Oleg Nesterov wrote:
> > >
> > Actually I think it also makes sense to do tasklet_schedule(rcu_tasklet)
> > in call_rcu(), this way we can detect that we need to start the next batch
> > earlier.
> 
> As long as we don't do this too often...  One way to prevent doing this
> too often would be to check rcp->completed against rdp->batch similarly
> to __rcu_process_callbacks()'s checks.  In call_rcu(), perhaps something
> like the following inside the ->qlen check:
> 
> 	if (__rcu_pending(&rcu_ctrlblk, rdp) {
> 		tasklet_schedule(&per_cpu(rcu_tasklet, rdp->cpu));
> 	}

Yes.

> > > > @@ -297,6 +294,7 @@ static void rcu_start_batch(struct rcu_c
> > > >  		smp_mb();
> > > >  		cpus_andnot(rcp->cpumask, cpu_online_map, nohz_cpu_mask);
> > > >
> > > > +		rcp->signaled = 0;
> > >
> > > Would it make sense to invoke force_quiescent_state() here in the
> > > case that rdp->qlen is still large?  The disadvantage is that qlen
> > > still counts the number of callbacks that are already slated for
> > > invocation.
> > 
> > This is not easy to do. rcu_start_batch() is "global", we need
> > to scan all per-cpu 'struct rcu_data' and check it's ->qlen.
> 
> My thought was that it might make sense to check only this CPU's struct
> rcu_data.  But I agree that the next approach seems more promising.

Yes, I understood this. And I don't say this is "bad", I just think this is
"not perfect". Because the CPU which actually starts a new grace period and
clears ->signaled may have ->qlen == 0, and the caller is cpu_quiet(), which
is a "response" to some other CPU's force_quiescent_state().

Oleg.

