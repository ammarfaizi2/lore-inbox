Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932184AbWIJWRN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbWIJWRN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 18:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbWIJWRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 18:17:13 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:14781 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932184AbWIJWRN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 18:17:13 -0400
Date: Mon, 11 Sep 2006 03:47:04 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>,
       Srivatsa Vaddagiri <vatsa@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu_do_batch: make ->qlen decrement irq safe
Message-ID: <20060910221704.GH4690@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20060910150820.GA7433@oleg> <20060910205827.GD4690@in.ibm.com> <20060910213242.GB437@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060910213242.GB437@oleg>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2006 at 01:32:43AM +0400, Oleg Nesterov wrote:
> rcu_do_batch() decrements rdp->qlen with irqs enabled. This is not good,
> it can also be modified by call_rcu() from interrupt.
> 
> Decrement ->qlen once with irqs disabled, after a main loop.
> 
> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>
> 
> --- rc6-mm1/kernel/rcupdate.c~	2006-08-22 16:22:49.000000000 +0400
> +++ rc6-mm1/kernel/rcupdate.c	2006-09-11 01:24:17.000000000 +0400
> @@ -241,12 +241,16 @@ static void rcu_do_batch(struct rcu_data
>  		next = rdp->donelist = list->next;
>  		list->func(list);
>  		list = next;
> -		rdp->qlen--;
>  		if (++count >= rdp->blimit)
>  			break;
>  	}
> +
> +	local_irq_disable();
> +	rdp->qlen -= count;
> +	local_irq_enable();
>  	if (rdp->blimit == INT_MAX && rdp->qlen <= qlowmark)
>  		rdp->blimit = blimit;
> +
>  	if (!rdp->donelist)
>  		rdp->donetail = &rdp->donelist;
>  	else

Looks good to me. 

Thanks
Dipankar
