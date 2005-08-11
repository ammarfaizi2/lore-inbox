Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750946AbVHKOOJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750946AbVHKOOJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 10:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750949AbVHKOOJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 10:14:09 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:36504 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750946AbVHKOOI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 10:14:08 -0400
Date: Thu, 11 Aug 2005 07:14:41 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, dipankar@in.ibm.com, rusty@au1.ibm.com,
       bmark@us.ibm.com, Thomas Gleixner <tglx@linutronix.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC,PATCH] Use RCU to protect tasklist for unicast signals
Message-ID: <20050811141441.GB1300@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050810171145.GA1945@us.ibm.com> <20050811095634.GA19342@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050811095634.GA19342@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2005 at 11:56:34AM +0200, Ingo Molnar wrote:
> 
> * Paul E. McKenney <paulmck@us.ibm.com> wrote:
> 
> > Hello!
> > 
> > This patch is an experiment in use of RCU for individual code paths 
> > that read-acquire the tasklist lock, in this case, unicast signal 
> > delivery. It passes five kernbenches on 4-CPU x86, but obviously needs 
> > much more testing before it is considered for serious use, let alone 
> > inclusion.
> > 
> > My main question is whether I have the POSIX semantics covered.  I 
> > believe that I do, but thought I should check with people who are more 
> > familiar with POSIX than am I.
> > 
> > For the record, some shortcomings of this patch:
> > 
> > o	Needs lots more testing on more architectures.
> > 
> > o	Needs performance and stress testing.
> > 
> > o	Needs testing in Ingo's PREEMPT_RT environment.
> 
> cool patch! I have integrated it into my PREEMPT_RT tree, and all it 
> needed to boot was the patch below (doesnt affect the upstream kernel).  
> Using the raw IRQ flag isnt an issue in the RCU code, all the affected 
> codepaths are small and deterministic.
> 
> (without this patch it locked up after detecting IRQ7 - not sure why.)

Without this patch on an older version of PREEMPT_RT (V0.7.52-12),
it would boot, pass kernbench, but fail LTP.  Passed both on a stock
kernel.

Will re-run with your patch.  ;-)

> kernel still works fine after some (mostly light) testing.

Cool!  Next step for me is to run some focussed stress tests.

						Thanx, Paul

> 	Ingo
> 
> Index: linux/kernel/rcupdate.c
> ===================================================================
> --- linux.orig/kernel/rcupdate.c
> +++ linux/kernel/rcupdate.c
> @@ -134,11 +134,11 @@ void fastcall call_rcu(struct rcu_head *
>  
>  	head->func = func;
>  	head->next = NULL;
> -	local_irq_save(flags);
> +	raw_local_irq_save(flags);
>  	rdp = &__get_cpu_var(rcu_data);
>  	*rdp->nxttail = head;
>  	rdp->nxttail = &head->next;
> -	local_irq_restore(flags);
> +	raw_local_irq_restore(flags);
>  }
>  
>  /**
> @@ -165,11 +165,11 @@ void fastcall call_rcu_bh(struct rcu_hea
>  
>  	head->func = func;
>  	head->next = NULL;
> -	local_irq_save(flags);
> +	raw_local_irq_save(flags);
>  	rdp = &__get_cpu_var(rcu_bh_data);
>  	*rdp->nxttail = head;
>  	rdp->nxttail = &head->next;
> -	local_irq_restore(flags);
> +	raw_local_irq_restore(flags);
>  }
>  
>  /*
> @@ -305,11 +305,11 @@ static void rcu_check_quiescent_state(st
>  static void rcu_move_batch(struct rcu_data *this_rdp, struct rcu_head *list,
>  				struct rcu_head **tail)
>  {
> -	local_irq_disable();
> +	raw_local_irq_disable();
>  	*this_rdp->nxttail = list;
>  	if (list)
>  		this_rdp->nxttail = tail;
> -	local_irq_enable();
> +	raw_local_irq_enable();
>  }
>  
>  static void __rcu_offline_cpu(struct rcu_data *this_rdp,
> @@ -362,13 +362,13 @@ static void __rcu_process_callbacks(stru
>  		rdp->curtail = &rdp->curlist;
>  	}
>  
> -	local_irq_disable();
> +	raw_local_irq_disable();
>  	if (rdp->nxtlist && !rdp->curlist) {
>  		rdp->curlist = rdp->nxtlist;
>  		rdp->curtail = rdp->nxttail;
>  		rdp->nxtlist = NULL;
>  		rdp->nxttail = &rdp->nxtlist;
> -		local_irq_enable();
> +		raw_local_irq_enable();
>  
>  		/*
>  		 * start the next batch of callbacks
> @@ -388,7 +388,7 @@ static void __rcu_process_callbacks(stru
>  			spin_unlock(&rsp->lock);
>  		}
>  	} else {
> -		local_irq_enable();
> +		raw_local_irq_enable();
>  	}
>  	rcu_check_quiescent_state(rcp, rsp, rdp);
>  	if (rdp->donelist)
> 
