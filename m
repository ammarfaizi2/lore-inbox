Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751002AbWC3FFQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002AbWC3FFQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 00:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750997AbWC3FFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 00:05:13 -0500
Received: from smtp.osdl.org ([65.172.181.4]:27860 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750854AbWC3FE6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 00:04:58 -0500
Date: Wed, 29 Mar 2006 21:04:06 -0800
From: Andrew Morton <akpm@osdl.org>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, tgraf@suug.ch,
       hadi@cyberus.ca
Subject: Re: [Patch 5/8] generic netlink interface for delay accounting
Message-Id: <20060329210406.08d1c929.akpm@osdl.org>
In-Reply-To: <442B2BB6.9020309@watson.ibm.com>
References: <442B271D.10208@watson.ibm.com>
	<442B2BB6.9020309@watson.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shailabh Nagar <nagar@watson.ibm.com> wrote:
>
> delayacct-genetlink.patch
> 
> Create a generic netlink interface (NETLINK_GENERIC family),
> called "taskstats", for getting delay and cpu statistics of
> tasks and thread groups during their lifetime and when they exit.
> 
> 

It's be best to have a netlink person review the netlinkisms here.

> +static inline int delayacct_add_tsk(struct taskstats *d,
> +				    struct task_struct *tsk)
> +{
> +	if (!tsk->delays)
> +		return -EINVAL;
> +	return __delayacct_add_tsk(d, tsk);
> +}

hm.  It's a worry that this can return an error if delay accounting simply
isn't enabled.

> +struct taskstats {
> +	/* Maintain 64-bit alignment while extending */
> +	/* Version 1 */
> +
> +	/* XXX_count is number of delay values recorded.
> +	 * XXX_total is corresponding cumulative delay in nanoseconds
> +	 */
> +
> +#define TASKSTATS_NOCPUSTATS	1
> +	__u64	cpu_count;
> +	__u64	cpu_delay_total;	/* wait, while runnable, for cpu */
> +	__u64	blkio_count;
> +	__u64	blkio_delay_total;	/* sync,block io completion wait*/
> +	__u64	swapin_count;
> +	__u64	swapin_delay_total;	/* swapin page fault wait*/
> +
> +	__u64	cpu_run_total;		/* cpu running time
> +					 * no count available/provided */
> +};

What locking is used to make updates to these u64's appear to be atomic? 
Maybe it's deliberately nonatomic.  Either way, it needs a comment.

>  void __delayacct_tsk_exit(struct task_struct *tsk)
>  {
> +	/*
> +	 * Protect against racing thread group exits
> +	 */
> +	mutex_lock(&delayacct_exit_mutex);
> +	taskstats_exit_pid(tsk);
>  	if (tsk->delays) {
>  		kmem_cache_free(delayacct_cache, tsk->delays);
>  		tsk->delays = NULL;
>  	}
> +	mutex_unlock(&delayacct_exit_mutex);
>  }

hm, I wonder how contended that lock is likely to be.

The kmem_cache_free() can happen outside the lock.

> +#ifdef CONFIG_TASKSTATS
> +int __delayacct_add_tsk(struct taskstats *d, struct task_struct *tsk)
> +{
> +	nsec_t tmp;
> +	struct timespec ts;
> +	unsigned long t1,t2;
> +
> +	/* zero XXX_total,non-zero XXX_count implies XXX stat overflowed */
> +
> +	tmp = (nsec_t)d->cpu_run_total ;

stray space before semicolon.

> +	tmp += (u64)(tsk->utime+tsk->stime)*TICK_NSEC;
> +	d->cpu_run_total = (tmp < (nsec_t)d->cpu_run_total)? 0: tmp;

Missing space before ?, missing space before :

> +	d->blkio_delay_total = (tmp < d->blkio_delay_total)? 0: tmp;
> +	d->swapin_delay_total = (tmp < d->swapin_delay_total)? 0: tmp;

dittos.

> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6.16/kernel/taskstats.c	2006-03-29 18:13:18.000000000 -0500
> @@ -0,0 +1,292 @@
> +/*
> + * taskstats.c - Export per-task statistics to userland
> + *
> + * Copyright (C) Shailabh Nagar, IBM Corp. 2006
> + *           (C) Balbir Singh,   IBM Corp. 2006
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/taskstats.h>
> +#include <linux/delayacct.h>
> +#include <net/genetlink.h>
> +#include <asm/atomic.h>
> +
> +const int taskstats_version = TASKSTATS_VERSION;

Odd.  It'd be better to put TASKSTATS_VERSION in the header file, use that
directly.

> +
> +static inline int fill_pid(pid_t pid, struct task_struct *pidtsk,
> +			   struct taskstats *stats)
> +{
> +	int rc;
> +	struct task_struct *tsk = pidtsk;
> +
> +	if (!pidtsk) {
> +		read_lock(&tasklist_lock);
> +		tsk = find_task_by_pid(pid);
> +		if (!tsk) {
> +			read_unlock(&tasklist_lock);
> +			return -ESRCH;
> +		}
> +		get_task_struct(tsk);
> +		read_unlock(&tasklist_lock);
> +	} else
> +		get_task_struct(tsk);
> +
> +	rc = delayacct_add_tsk(stats, tsk);
> +	put_task_struct(tsk);
> +
> +	return rc;
> +
> +}

Has two callsites, should be uninlined.

> +static inline int fill_tgid(pid_t tgid, struct task_struct *tgidtsk,
> +			    struct taskstats *stats)
> +{
> +	int rc;
> +	struct task_struct *tsk, *first;
> +
> +	first = tgidtsk;
> +	read_lock(&tasklist_lock);
> +	if (!first) {
> +		first = find_task_by_pid(tgid);
> +		if (!first) {
> +			read_unlock(&tasklist_lock);
> +			return -ESRCH;
> +		}
> +	}
> +	tsk = first;
> +	do {
> +		rc = delayacct_add_tsk(stats, tsk);
> +		if (rc)
> +			break;
> +	} while_each_thread(first, tsk);
> +	read_unlock(&tasklist_lock);
> +
> +	return rc;
> +}

Ditto.

It's somewhat similar to fill_pid() - perhaps they can be combined, halving
the overhead?

> +static int taskstats_send_stats(struct sk_buff *skb, struct genl_info *info)
> +{
> +	int rc = 0;
> +	struct sk_buff *rep_skb;
> +	struct taskstats stats;
> +	void *reply;
> +	size_t size;
> +	struct nlattr *na;
> +
> +	/*
> +	 * Size includes space for nested attribute as well
> +	 * The returned data is of the format
> +	 * TASKSTATS_TYPE_AGGR_PID/TGID
> +	 * --> TASKSTATS_TYPE_PID/TGID
> +	 * --> TASKSTATS_TYPE_STATS
> +	 */
> +	size = nla_total_size(sizeof(u32)) +
> +		nla_total_size(sizeof(struct taskstats)) + nla_total_size(0);
> +
> +	memset(&stats, 0, sizeof(stats));
> +	rc = prepare_reply(info, TASKSTATS_CMD_NEW, &rep_skb, &reply, size);
> +	if (rc < 0)
> +		return rc;
> +
> +	if (info->attrs[TASKSTATS_CMD_ATTR_PID]) {
> +		u32 pid = nla_get_u32(info->attrs[TASKSTATS_CMD_ATTR_PID]);
> +		rc = fill_pid((pid_t)pid, NULL, &stats);

We shouldn't have a typecast here.  If it generates a warning then we need
to get in there and find out why.

> +		if (rc < 0)
> +			goto err;
> +
> +		na = nla_nest_start(rep_skb, TASKSTATS_TYPE_AGGR_PID);
> +		NLA_PUT_U32(rep_skb, TASKSTATS_TYPE_PID, pid);
> +	} else if (info->attrs[TASKSTATS_CMD_ATTR_TGID]) {
> +		u32 tgid = nla_get_u32(info->attrs[TASKSTATS_CMD_ATTR_TGID]);
> +		rc = fill_tgid((pid_t)tgid, NULL, &stats);

Ditto.

> +		if (rc < 0)
> +			goto err;
> +
> +		na = nla_nest_start(rep_skb, TASKSTATS_TYPE_AGGR_TGID);
> +		NLA_PUT_U32(rep_skb, TASKSTATS_TYPE_TGID, tgid);
> +	} else {
> +		rc = -EINVAL;
> +		goto err;
> +	}
> +
> +	NLA_PUT_TYPE(rep_skb, struct taskstats, TASKSTATS_TYPE_STATS, stats);
> +	nla_nest_end(rep_skb, na);
> +
> +	return send_reply(rep_skb, info->snd_pid, TASKSTATS_MSG_UNICAST);
> +
> +nla_put_failure:
> +	return  genlmsg_cancel(rep_skb, reply);

Extra space.

> +err:
> +	nlmsg_free(rep_skb);
> +	return rc;
> +}
> +
> +
> +/* Send pid data out on exit */
> +void taskstats_exit_pid(struct task_struct *tsk)
> +{
> +	int rc = 0;
> +	struct sk_buff *rep_skb;
> +	void *reply;
> +	struct taskstats stats;
> +	size_t size;
> +	int is_thread_group = !thread_group_empty(tsk);
> +	struct nlattr *na;
> +
> +	/*
> +	 * tasks can start to exit very early. Ensure that the family
> +	 * is registered before notifications are sent out
> +	 */
> +	if (!family_registered)
> +		return;

This code risks evaluating thread_group_empty() even if !family_registered.
The compiler will most likely sort that out in this case, but it's a risk
when using these initialisers.

> +
> +static int __init taskstats_init(void)
> +{
> +	if (genl_register_family(&family))
> +		return -EFAULT;

EFAULT?

> +        family_registered = 1;

whitespace broke.

> +
> +	if (genl_register_ops(&family, &taskstats_ops))
> +		goto err;
> +
> +	return 0;
> +err:
> +	genl_unregister_family(&family);
> +	family_registered = 0;
> +	return -EFAULT;
> +}
> +
> +late_initcall(taskstats_init);

Why late_initcall()?  (A comment would be appropriate)

