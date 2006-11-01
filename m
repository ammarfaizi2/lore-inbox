Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752185AbWKAVVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752185AbWKAVVk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 16:21:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752213AbWKAVVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 16:21:40 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:61062 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1752185AbWKAVVj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 16:21:39 -0500
Message-ID: <45490FDB.3010600@watson.ibm.com>
Date: Wed, 01 Nov 2006 16:21:31 -0500
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Oleg Nesterov <oleg@tv-sign.ru>
CC: Andrew Morton <akpm@osdl.org>, Thomas Graf <tgraf@suug.ch>,
       Balbir Singh <balbir@in.ibm.com>, Jay Lan <jlan@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] taskstats: use nla_reserve() for reply assembling
References: <20061101182703.GA453@oleg>
In-Reply-To: <20061101182703.GA453@oleg>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov wrote:
> Currently taskstats_user_cmd()/taskstats_exit() do:
> 
> 	1) allocate stats
> 	2) fill stats
> 	3) make a temporary copy on stack (236 bytes)
> 	4) copy that copy to skb
> 	5) free stats
> 
> With the help of nla_reserve() we can operate on skb->data directly,
> thus avoiding all these steps except 2).

Good point.
> 
> So, before this patch:
> 
> 	// copy *stats to skb->data
> 	int mk_reply(skb, ..., struct taskstats *stats);
> 
> 	fill_pid(stats);
> 	mk_reply(skb, ..., stats);
> 
> After:
> 	// return a pointer to skb->data
> 	struct taskstats *mk_reply(skb, ...);
> 
> 	stat = mk_reply(skb, ...);
> 	fill_pid(stats);
> 
> Shrinks taskatsks.o by 162 bytes.
> 
> A stupid benchmark (send one million TASKSTATS_CMD_ATTR_PID) shows the
> difference,
> 
> 		real user sys
> 	before:
> 		4.02 0.06 3.96
> 		4.02 0.04 3.98
> 		4.02 0.04 3.97
> 	after:
> 		3.86 0.08 3.78
> 		3.88 0.10 3.77
> 		3.89 0.09 3.80
> 
> but this looks suspiciously good.
> 
> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

Acked-by: Shailabh Nagar <nagar@watson.ibm.com>

> 
>  taskstats.c |   86 ++++++++++++++++++++++++++++++------------------------------
>  1 files changed, 44 insertions(+), 42 deletions(-)
> 
> --- STATS/kernel/taskstats.c~6_nla	2006-11-01 14:00:03.000000000 +0300
> +++ STATS/kernel/taskstats.c	2006-11-01 21:14:39.000000000 +0300
> @@ -190,6 +190,7 @@ static int fill_pid(pid_t pid, struct ta
>  	} else
>  		get_task_struct(tsk);
>  
> +	memset(stats, 0, sizeof(*stats));
>  	/*
>  	 * Each accounting subsystem adds calls to its functions to
>  	 * fill in relevant parts of struct taskstsats as follows
> @@ -232,6 +233,8 @@ static int fill_tgid(pid_t tgid, struct 
>  
>  	if (first->signal->stats)
>  		memcpy(stats, first->signal->stats, sizeof(*stats));
> +	else
> +		memset(stats, 0, sizeof(*stats));
>  
>  	tsk = first;
>  	do {
> @@ -348,9 +351,9 @@ static int parse(struct nlattr *na, cpum
>  	return ret;
>  }
>  
> -static int mk_reply(struct sk_buff *skb, int type, u32 pid, struct taskstats *stats)
> +static struct taskstats *mk_reply(struct sk_buff *skb, int type, u32 pid)
>  {
> -	struct nlattr *na;
> +	struct nlattr *na, *ret;
>  	int aggr;
>  
>  	aggr = TASKSTATS_TYPE_AGGR_TGID;
> @@ -358,20 +361,23 @@ static int mk_reply(struct sk_buff *skb,
>  		aggr = TASKSTATS_TYPE_AGGR_PID;
>  
>  	na = nla_nest_start(skb, aggr);
> -	NLA_PUT_U32(skb, type, pid);
> -	NLA_PUT_TYPE(skb, struct taskstats, TASKSTATS_TYPE_STATS, *stats);
> +	if (nla_put(skb, type, sizeof(pid), &pid) < 0)
> +		goto err;
> +	ret = nla_reserve(skb, TASKSTATS_TYPE_STATS, sizeof(struct taskstats));
> +	if (!ret)
> +		goto err;
>  	nla_nest_end(skb, na);
>  
> -	return 0;
> -nla_put_failure:
> -	return -1;
> +	return nla_data(ret);
> +err:
> +	return NULL;
>  }
>  
>  static int taskstats_user_cmd(struct sk_buff *skb, struct genl_info *info)
>  {
>  	int rc = 0;
>  	struct sk_buff *rep_skb;
> -	struct taskstats stats;
> +	struct taskstats *stats;
>  	void *reply;
>  	size_t size;
>  	cpumask_t mask;
> @@ -394,36 +400,36 @@ static int taskstats_user_cmd(struct sk_
>  	size = nla_total_size(sizeof(u32)) +
>  		nla_total_size(sizeof(struct taskstats)) + nla_total_size(0);
>  
> -	memset(&stats, 0, sizeof(stats));
>  	rc = prepare_reply(info, TASKSTATS_CMD_NEW, &rep_skb, &reply, size);
>  	if (rc < 0)
>  		return rc;
>  
> +	rc = -EINVAL;
>  	if (info->attrs[TASKSTATS_CMD_ATTR_PID]) {
>  		u32 pid = nla_get_u32(info->attrs[TASKSTATS_CMD_ATTR_PID]);
> -		rc = fill_pid(pid, NULL, &stats);
> -		if (rc < 0)
> -			goto err;
> +		stats = mk_reply(rep_skb, TASKSTATS_TYPE_PID, pid);
> +		if (!stats)
> +			goto nla_err;
>  
> -		if (mk_reply(rep_skb, TASKSTATS_TYPE_PID, pid, &stats))
> -			goto nla_put_failure;
> +		rc = fill_pid(pid, NULL, stats);
> +		if (rc < 0)
> +			goto nla_err;
>  	} else if (info->attrs[TASKSTATS_CMD_ATTR_TGID]) {
>  		u32 tgid = nla_get_u32(info->attrs[TASKSTATS_CMD_ATTR_TGID]);
> -		rc = fill_tgid(tgid, NULL, &stats);
> -		if (rc < 0)
> -			goto err;
> +		stats = mk_reply(rep_skb, TASKSTATS_TYPE_TGID, tgid);
> +		if (!stats)
> +			goto nla_err;
>  
> -		if (mk_reply(rep_skb, TASKSTATS_TYPE_TGID, tgid, &stats))
> -			goto nla_put_failure;
> -	} else {
> -		rc = -EINVAL;
> +		rc = fill_tgid(tgid, NULL, stats);
> +		if (rc < 0)
> +			goto nla_err;
> +	} else
>  		goto err;
> -	}
>  
>  	return send_reply(rep_skb, info->snd_pid);
>  
> -nla_put_failure:
> -	rc = genlmsg_cancel(rep_skb, reply);
> +nla_err:
> +	genlmsg_cancel(rep_skb, reply);
>  err:
>  	nlmsg_free(rep_skb);
>  	return rc;
> @@ -458,7 +464,7 @@ void taskstats_exit(struct task_struct *
>  {
>  	int rc;
>  	struct listener_list *listeners;
> -	struct taskstats *tidstats;
> +	struct taskstats *stats;
>  	struct sk_buff *rep_skb;
>  	void *reply;
>  	size_t size;
> @@ -485,20 +491,17 @@ void taskstats_exit(struct task_struct *
>  	if (list_empty(&listeners->list))
>  		return;
>  
> -	tidstats = kmem_cache_zalloc(taskstats_cache, SLAB_KERNEL);
> -	if (!tidstats)
> -		return;
> -
>  	rc = prepare_reply(NULL, TASKSTATS_CMD_NEW, &rep_skb, &reply, size);
>  	if (rc < 0)
> -		goto free_stats;
> +		return;
>  
> -	rc = fill_pid(tsk->pid, tsk, tidstats);
> -	if (rc < 0)
> -		goto err_skb;
> +	stats = mk_reply(rep_skb, TASKSTATS_TYPE_PID, tsk->pid);
> +	if (!stats)
> +		goto nla_err;
>  
> -	if (mk_reply(rep_skb, TASKSTATS_TYPE_PID, tsk->pid, tidstats))
> -		goto nla_put_failure;
> +	rc = fill_pid(tsk->pid, tsk, stats);
> +	if (rc < 0)
> +		goto nla_err;
>  
>  	/*
>  	 * Doesn't matter if tsk is the leader or the last group member leaving
> @@ -506,20 +509,19 @@ void taskstats_exit(struct task_struct *
>  	if (!is_thread_group || !group_dead)
>  		goto send;
>  
> -	if (mk_reply(rep_skb, TASKSTATS_TYPE_TGID, tsk->tgid, tsk->signal->stats))
> -		goto nla_put_failure;
> +	stats = mk_reply(rep_skb, TASKSTATS_TYPE_TGID, tsk->tgid);
> +	if (!stats)
> +		goto nla_err;
> +
> +	memcpy(stats, tsk->signal->stats, sizeof(*stats));
>  
>  send:
>  	send_cpu_listeners(rep_skb, listeners);
> -free_stats:
> -	kmem_cache_free(taskstats_cache, tidstats);
>  	return;
>  
> -nla_put_failure:
> +nla_err:
>  	genlmsg_cancel(rep_skb, reply);
> -err_skb:
>  	nlmsg_free(rep_skb);
> -	goto free_stats;
>  }
>  
>  static struct genl_ops taskstats_ops = {
> 

