Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750787AbWAIRgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbWAIRgj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 12:36:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbWAIRgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 12:36:38 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:18077 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750787AbWAIRgi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 12:36:38 -0500
Date: Mon, 9 Jan 2006 09:36:56 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, Dipankar Sarma <dipankar@in.ibm.com>,
       Manfred Spraul <manfred@colorfullife.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       vatsa@in.ibm.com
Subject: Re: [PATCH 5/5][RFC] rcu: start new grace period from rcu_pending()
Message-ID: <20060109173656.GC14738@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <43C165D7.6EAB8E47@tv-sign.ru> <43C27417.AA1BA306@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C27417.AA1BA306@tv-sign.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2006 at 05:32:55PM +0300, Oleg Nesterov wrote:
> Oleg Nesterov wrote:
> >
> > I think it is better to set ->qs_pending = 1 directly in __rcu_pending():
> 
> This patch has a bug. I am sending a trivial fix, but now I am not
> sure myself that 1 timer tick saved worth the code uglification.

This is indeed an accident waiting to happen -- someone is bound to
replace the "|" with an "||", a change that is too easy for someone
to miss.  Once Vatsa is satisfied with the CPU-hotplug aspects of
this set of patches, if __rcu_pending() still has side-effects, I would
suggest something like the following:

	int rcu_pending(int cpu)
	{
		int retval = 0;

		if (__rcu_pending(&rcu_ctrlblk, &per_cpu(rcu_data, cpu)))
			retval = 1;
 		if (__rcu_pending(&rcu_bh_ctrlblk, &per_cpu(rcu_bh_data, cpu)))
			retval = 1;
		return retval;
	}

A few more lines, but the intent is much more clear.  And I bet that
gcc generates reasonable code in either case.

Or maybe this is just me...

							Thanx, Paul

> [PATCH 6/5] rcu: start new grace period from rcu_pending() fix
> 
> We should not miss __rcu_pending(&rcu_bh_ctrlblk) in rcu_pending().
> 
> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>
> 
> --- 2.6.15/kernel/rcupdate.c~6_FIX	2006-01-09 00:26:44.000000000 +0300
> +++ 2.6.15/kernel/rcupdate.c	2006-01-09 19:19:27.000000000 +0300
> @@ -464,7 +464,7 @@ static int __rcu_pending(struct rcu_ctrl
>  
>  int rcu_pending(int cpu)
>  {
> -	return __rcu_pending(&rcu_ctrlblk, &per_cpu(rcu_data, cpu)) ||
> +	return __rcu_pending(&rcu_ctrlblk, &per_cpu(rcu_data, cpu)) |
>  		__rcu_pending(&rcu_bh_ctrlblk, &per_cpu(rcu_bh_data, cpu));
>  }
> 
