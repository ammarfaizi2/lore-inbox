Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422643AbWHDXJ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422643AbWHDXJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 19:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422644AbWHDXJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 19:09:58 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:20592 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1422643AbWHDXJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 19:09:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=rMsqZ3JzWx9Ij8gprLnY/SsiXj1M8yMsXQSmFowYGX/E3/yq1p5BMQHxaQIPJtWnYTWfk32nYdQvKP8OSqyiuCzriSLdeNC/Zth7au/QfgGvc2NU9w+Ez1ATtd1eAbuI31D1SSDWD6ev36obRonNX0naxjaVxv1OC13nOQwojI0=
Message-ID: <44D3D3D2.3090802@gmail.com>
Date: Sat, 05 Aug 2006 01:09:47 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: vatsa@in.ibm.com
CC: Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Sam Vilain <sam@vilain.net>, linux-kernel@vger.kernel.org,
       Kirill Korotaev <dev@openvz.org>, Mike Galbraith <efault@gmx.de>,
       Balbir Singh <balbir@in.ibm.com>, sekharan@us.ibm.com,
       Andrew Morton <akpm@osdl.org>, nagar@watson.ibm.com,
       haveblue@us.ibm.com, pj@sgi.com
Subject: Re: [ RFC, PATCH 2/5 ] CPU controller - Define group operations
References: <20060804050753.GD27194@in.ibm.com> <20060804051023.GF27194@in.ibm.com>
In-Reply-To: <20060804051023.GF27194@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa Vaddagiri wrote:
> Define these operations for a task-group:
> 
> 	- create new group
> 	- destroy existing group
> 	- assign bandwidth (quota) for a group
> 	- get bandwidth (quota) of a group
> 
> 
> Signed-off-by : Srivatsa Vaddagiri <vatsa@in.ibm.com>
> 
> 
> 
>  include/linux/sched.h |   12 +++++++
>  kernel/sched.c        |   79 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 91 insertions(+)
> 
> diff -puN kernel/sched.c~cpu_ctlr_grp_ops kernel/sched.c
> --- linux-2.6.18-rc3/kernel/sched.c~cpu_ctlr_grp_ops	2006-08-04 07:58:50.000000000 +0530
> +++ linux-2.6.18-rc3-root/kernel/sched.c	2006-08-04 07:58:50.000000000 +0530
> @@ -7063,3 +7063,82 @@ void set_curr_task(int cpu, struct task_
>  }
>  
>  #endif
> +
> +#ifdef CONFIG_CPUMETER
> +
> +/* Allocate runqueue structures for the new task-group */
> +void *sched_alloc_group(void)
> +{
> +	struct task_grp *tg;
> +	struct task_grp_rq *tgrq;
> +	int i;
> +
> +	tg = kzalloc(sizeof(*tg), GFP_KERNEL);
> +	if (!tg)
> +		return NULL;
> +
> +	tg->ticks = -1;		/* No limit */
> +
> +	for_each_possible_cpu(i) {
> +		tgrq = kzalloc(sizeof(*tgrq), GFP_KERNEL);
> +		if (!tgrq)
> +			goto oom;
> +		tg->rq[i] = tgrq;
> +		task_grp_rq_init(tgrq, tg->ticks);
> +	}
> +
> +	return (void *)tg;

unneeded cast

> +oom:
> +	while (i--)
> +		kfree(tg->rq[i]);
> +
> +	kfree(tg);
> +	return NULL;
> +}
> +
> +/* Deallocate runqueue structures */
> +void sched_dealloc_group(void *grp)
> +{
> +	struct task_grp *tg = (struct task_grp *)grp;

again

> +	int i;
> +
> +	for_each_possible_cpu(i)
> +		kfree(tg->rq[i]);
> +
> +	kfree(tg);
> +}
> +
> +/* Assign quota to this group */
> +void sched_assign_quota(void *grp, int quota)
> +{
> +	struct task_grp *tg = (struct task_grp *)grp;

and one more time

> +	int i;
> +
> +	tg->ticks = (quota * 5 * HZ) / 100;
> +
> +	for_each_possible_cpu(i)
> +		tg->rq[i]->ticks = tg->ticks;
> +
> +}
> +
> +/* Return assigned quota for this group */
> +int sched_get_quota(void *grp)
> +{
> +	struct task_grp *tg = (struct task_grp *)grp;

...

> +	int quota;
> +
> +	quota = (tg->ticks * 100) / (5 * HZ);
> +
> +	return quota;

what about to just
return (tg->ticks * 100) / (5 * HZ);

regards,
-- 
<a href="http://www.fi.muni.cz/~xslaby/">Jiri Slaby</a>
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
