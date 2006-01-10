Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932357AbWAJSNM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932357AbWAJSNM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 13:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932464AbWAJSNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 13:13:12 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:40836 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932357AbWAJSNK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 13:13:10 -0500
Date: Tue, 10 Jan 2006 23:43:31 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, Manfred Spraul <manfred@colorfullife.com>,
       Linus Torvalds <torvalds@osdl.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/5] rcu: don't check ->donelist in __rcu_pending()
Message-ID: <20060110181330.GB5387@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <43C165BC.F7C6DCF5@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C165BC.F7C6DCF5@tv-sign.ru>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 08, 2006 at 10:19:24PM +0300, Oleg Nesterov wrote:
> ->donelist becomes != NULL only in rcu_process_callbacks().
> 
> So ->donelist != NULL means that rcu_tasklet is either
> TASKLET_STATE_SCHED or TASKLET_STATE_RUN, we don't need to
> check it in __rcu_pending().
> 
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


This may not be a good idea. For example, during cpu hotplug,
a cpu may inherit a set of finished callbacks that need to be
invoked. So, an rcu_pending() check needs to detect that.

Thanks
Dipankar
