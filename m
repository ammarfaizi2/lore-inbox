Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964963AbWAHV7h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964963AbWAHV7h (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 16:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964957AbWAHV7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 16:59:37 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:34264 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964965AbWAHV7g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 16:59:36 -0500
Date: Sun, 8 Jan 2006 14:00:04 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, Dipankar Sarma <dipankar@in.ibm.com>,
       Manfred Spraul <manfred@colorfullife.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/5] rcu: don't check ->donelist in __rcu_pending()
Message-ID: <20060108220004.GB11410@us.ibm.com>
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
> 
> [ This patch was tested with rcutorture.ko, I don't understand
>   it's output, but it says "End of test: SUCCESS". So if this
>   patch incorrect blame Paul, not me! ]

;-)

Did you run the newest version of rcutorture.ko that includes
Vatsa's CPU-hotplug additions?

						Thanx, Paul

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
