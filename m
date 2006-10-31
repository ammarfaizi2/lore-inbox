Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752026AbWJaDDJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752026AbWJaDDJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 22:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752028AbWJaDDJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 22:03:09 -0500
Received: from mta2.srv.hcvlny.cv.net ([167.206.4.197]:3522 "EHLO
	mta2.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S1752026AbWJaDDI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 22:03:08 -0500
Date: Mon, 30 Oct 2006 22:03:03 -0500
From: Shailabh Nagar <nagar@watson.ibm.com>
Subject: Re: [PATCH] taskstats: fix sub-threads accounting
In-reply-to: <20061030213749.GA3035@oleg>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, Balbir Singh <balbir@in.ibm.com>,
       Jay Lan <jlan@sgi.com>, linux-kernel@vger.kernel.org
Message-id: <4546BCE7.6020800@watson.ibm.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
References: <20061030213749.GA3035@oleg>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Oleg Nesterov wrote:
> If there are no listeners, taskstats_exit_send() just returns because
> taskstats_exit_alloc() didn't allocate *tidstats. This is wrong, each
> sub-thread should do fill_tgid_exit() on exit, otherwise its ->delays
> is not recorded in ->signal->stats and lost.

Good catch. Thanks for the detailed look at the delay accounting code.



> 
> Q: We don't send TASKSTATS_TYPE_AGGR_TGID when single-threaded process
> exits. Is it good? How can the listener figure out that it was actually
> a process exit, not sub-thread?

We had a detailed discussion on this on lkml earlier. The overhead of
sending essentially the same data twice (once as AGGR_TGID and once as
PID) was deemed too heavy esp. as the taskstats structure size grew.
Also, single threaded exit is a common case.

Using process events, its possible for user space to distinguish single
threaded process exits.

> 
> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

Acked-by: Shailabh Nagar <nagar@watson.ibm.com>

> 
> --- STATS/kernel/taskstats.c~2_send	2006-10-30 23:47:46.000000000 +0300
> +++ STATS/kernel/taskstats.c	2006-10-31 00:14:42.000000000 +0300
> @@ -446,10 +446,9 @@ void taskstats_exit_send(struct task_str
>  	int is_thread_group;
>  	struct nlattr *na;
>  
> -	if (!family_registered || !tidstats)
> +	if (!family_registered)
>  		return;
>  
> -	rc = 0;
>  	/*
>  	 * Size includes space for nested attributes
>  	 */
> @@ -457,8 +456,15 @@ void taskstats_exit_send(struct task_str
>  		nla_total_size(sizeof(struct taskstats)) + nla_total_size(0);
>  
>  	is_thread_group = (tsk->signal->stats != NULL);
> -	if (is_thread_group)
> -		size = 2 * size;	/* PID + STATS + TGID + STATS */
> +	if (is_thread_group) {
> +		/* PID + STATS + TGID + STATS */
> +		size = 2 * size;
> +		/* fill the tsk->signal->stats structure */
> +		fill_tgid_exit(tsk);
> +	}
> +
> +	if (!tidstats)
> +		return;
>  
>  	rc = prepare_reply(NULL, TASKSTATS_CMD_NEW, &rep_skb, &reply, size);
>  	if (rc < 0)
> @@ -478,11 +484,8 @@ void taskstats_exit_send(struct task_str
>  		goto send;
>  
>  	/*
> -	 * tsk has/had a thread group so fill the tsk->signal->stats structure
>  	 * Doesn't matter if tsk is the leader or the last group member leaving
>  	 */
> -
> -	fill_tgid_exit(tsk);
>  	if (!group_dead)
>  		goto send;
>  
> 

