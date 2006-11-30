Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967795AbWK3BYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967795AbWK3BYK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 20:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967794AbWK3BYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 20:24:10 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:55767 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S967795AbWK3BYJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 20:24:09 -0500
Date: Wed, 29 Nov 2006 17:25:28 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Andrew Morton <akpm@osdl.org>, Dipankar Sarma <dipankar@in.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RCU] adds a prefetch() in rcu_do_batch()
Message-ID: <20061130012528.GJ2335@us.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <a769871e0611211233n20eb9d74j661cd73e9315fade@mail.gmail.com> <20061121224613.548207f9.akpm@osdl.org> <200611221602.29597.dada1@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611221602.29597.dada1@cosmosbay.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2006 at 04:02:29PM +0100, Eric Dumazet wrote:
> On some workloads, (for example when lot of close() syscalls are done), RCU
> qlen can be quite large, and RCU heads are no longer in cpu cache when
> rcu_do_batch() is called.
> 
> This patches adds a prefetch() in rcu_do_batch() to give CPU a hint to bring
> back cache lines containing 'struct rcu_head's.
> 
> Most list manipulations macros include prefetch(), but not open coded ones (at
> least with current C compilers :) )
> 
> I got a nice speedup on a trivial benchmark  (3.48 us per iteration instead of
> 3.95 us on a 1.6 GHz Pentium-M)
> while (1) { pipe(p); close(fd[0]); close(fd[1]);}

Interesting!  How much of the speedup was due to the prefetch() and how
much to removing the extra store to rdp->donelist?

							Thanx, Paul

> Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>

> --- linux-2.6.19-rc6/kernel/rcupdate.c	2006-11-16 05:03:40.000000000 +0100
> +++ linux-2.6.19-rc6-ed/kernel/rcupdate.c	2006-11-22 15:12:09.000000000 +0100
> @@ -235,12 +235,14 @@ static void rcu_do_batch(struct rcu_data
> 
>  	list = rdp->donelist;
>  	while (list) {
> -		next = rdp->donelist = list->next;
> +		next = list->next;
> +		prefetch(next);
>  		list->func(list);
>  		list = next;
>  		if (++count >= rdp->blimit)
>  			break;
>  	}
> +	rdp->donelist = list;
> 
>  	local_irq_disable();
>  	rdp->qlen -= count;

