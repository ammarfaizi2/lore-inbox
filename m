Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751459AbWJ3NuL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbWJ3NuL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 08:50:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751581AbWJ3NuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 08:50:10 -0500
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:17350 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP
	id S1751459AbWJ3NuI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 08:50:08 -0500
Message-ID: <45460302.4080904@in.ibm.com>
Date: Mon, 30 Oct 2006 19:19:54 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: Oleg Nesterov <oleg@tv-sign.ru>
CC: Andrew Morton <akpm@osdl.org>, Shailabh Nagar <nagar@watson.ibm.com>,
       Jay Lan <jlan@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] fill_tgid: fix task_struct leak and possible oops
References: <20061026232052.GA520@oleg>
In-Reply-To: <20061026232052.GA520@oleg>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov wrote:
> 1. fill_tgid() forgets to do put_task_struct(first).
> 

Looks good!

> 2. release_task(first) can happen after fill_tgid() drops tasklist_lock,
>    it is unsafe to dereference first->signal.
> 

But, we have a reference to first via get_task_struct(). release_task()
would do just a put_task_struct(). Am I missing something?


> This is a temporary fix, imho the locking should be reworked.
> 
> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>
> 
> --- STATS/kernel/taskstats.c~1_fix_sig	2006-10-22 18:24:03.000000000 +0400
> +++ STATS/kernel/taskstats.c	2006-10-26 23:44:32.000000000 +0400
> @@ -237,14 +237,17 @@ static int fill_tgid(pid_t tgid, struct 
>  	} else
>  		get_task_struct(first);
>  
> -	/* Start with stats from dead tasks */
> -	spin_lock_irqsave(&first->signal->stats_lock, flags);
> -	if (first->signal->stats)
> -		memcpy(stats, first->signal->stats, sizeof(*stats));
> -	spin_unlock_irqrestore(&first->signal->stats_lock, flags);
>  
>  	tsk = first;
>  	read_lock(&tasklist_lock);
> +	/* Start with stats from dead tasks */
> +	if (first->signal) {
> +		spin_lock_irqsave(&first->signal->stats_lock, flags);
> +		if (first->signal->stats)
> +			memcpy(stats, first->signal->stats, sizeof(*stats));
> +		spin_unlock_irqrestore(&first->signal->stats_lock, flags);
> +	}
> +
>  	do {
>  		if (tsk->exit_state == EXIT_ZOMBIE && thread_group_leader(tsk))
>  			continue;
> @@ -264,7 +267,7 @@ static int fill_tgid(pid_t tgid, struct 
>  	 * Accounting subsytems can also add calls here to modify
>  	 * fields of taskstats.
>  	 */
> -
> +	put_task_struct(first);
>  	return 0;
>  }
>  
> 


-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
