Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbWAIS73@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbWAIS73 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 13:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750757AbWAIS70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 13:59:26 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:38831 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030262AbWAIS7Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 13:59:24 -0500
Date: Mon, 9 Jan 2006 10:59:44 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, Dipankar Sarma <dipankar@in.ibm.com>,
       Manfred Spraul <manfred@colorfullife.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/5] rcu: don't check ->donelist in __rcu_pending()
Message-ID: <20060109185944.GB15083@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <43C165BC.F7C6DCF5@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C165BC.F7C6DCF5@tv-sign.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 08, 2006 at 10:19:24PM +0300, Oleg Nesterov wrote:
> ->donelist becomes != NULL only in rcu_process_callbacks().
> 
> rcu_process_callbacks() always calls rcu_do_batch() when
> ->donelist != NULL.
> 
> rcu_do_batch() schedules rcu_process_callbacks() again if
> ->donelist was not flushed entirely.
> 
> So ->donelist != NULL means that rcu_tasklet is either
> TASKLET_STATE_SCHED or TASKLET_STATE_RUN, we don't need to
> check it in __rcu_pending().

As Vatsa noted, this is needed if the CPU-hotplug case moves
from ->donelist to ->donelist.  It could be omitted if CPU-hotplug
instead moves from ->donelist to ->nextlist, as is the case in Oleg's
patch.  The extra grace-period delay should not be a problem for the
presumably rare hotplug case, but:

o	the extra test in __rcu_pending() should be quite inexpensive,
	since the cacheline is already loaded given the earlier tests.

o	although tasklet_schedule() looks to be perfectly reliable
	right now, and although any bugs in tasklet_schedule() must
	be fixed, having RCU leakage be the major symptom of
	tasklet_schedule() failure sounds quite unfriendly to me.

So I am not (yet) convinced that this patch is the way to go.

						Thanx, Paul

> [ This patch was tested with rcutorture.ko, I don't understand
>   it's output, but it says "End of test: SUCCESS". So if this
>   patch incorrect blame Paul, not me! ]
> 
> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>
> 
> --- 2.6.15/kernel/rcupdate.c~2_DONE	2006-01-08 21:35:21.000000000 +0300
> +++ 2.6.15/kernel/rcupdate.c	2006-01-08 21:55:45.000000000 +0300
> @@ -454,10 +454,6 @@ static int __rcu_pending(struct rcu_ctrl
>  	if (!rdp->curlist && rdp->nxtlist)
>  		return 1;
>  
> -	/* This cpu has finished callbacks to invoke */
> -	if (rdp->donelist)
> -		return 1;
> -
>  	/* The rcu core waits for a quiescent state from the cpu */
>  	if (rdp->quiescbatch != rcp->cur || rdp->qs_pending)
>  		return 1;
> 
