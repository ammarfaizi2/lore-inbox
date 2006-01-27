Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751543AbWA0SlU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751543AbWA0SlU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 13:41:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751544AbWA0SlU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 13:41:20 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:31724 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751541AbWA0SlT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 13:41:19 -0500
Message-ID: <43DA7B47.11D10B09@tv-sign.ru>
Date: Fri, 27 Jan 2006 22:57:59 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch 1/2] rcu batch tuning
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dipankar Sarma wrote:
>
> +static void force_quiescent_state(struct rcu_data *rdp,
> +			struct rcu_ctrlblk *rcp)
> +{
> +	int cpu;
> +	cpumask_t cpumask;
> +	set_need_resched();
> +	if (unlikely(rdp->qlen - rdp->last_rs_qlen > rsinterval)) {
> +		rdp->last_rs_qlen = rdp->qlen;
> +		/*
> +		 * Don't send IPI to itself. With irqs disabled,
> +		 * rdp->cpu is the current cpu.
> +		 */
> +		cpumask = rcp->cpumask;
> +		cpu_clear(rdp->cpu, cpumask);
> +		for_each_cpu_mask(cpu, cpumask)
> +			smp_send_reschedule(cpu);
> +	}
> +}
> [ ... snip ... ]
>
> @@ -92,17 +128,13 @@ void fastcall call_rcu(struct rcu_head *
>  	rdp = &__get_cpu_var(rcu_data);
>  	*rdp->nxttail = head;
>  	rdp->nxttail = &head->next;
> -
> -	if (unlikely(++rdp->count > 10000))
> -		set_need_resched();
> -
> +	if (unlikely(++rdp->qlen > qhimark)) {
> +		rdp->blimit = INT_MAX;
> +		force_quiescent_state(rdp, &rcu_ctrlblk);
> +	}

When ->qlen exceeds qhimark for the first time we send reschedule IPI to
other CPUs and force_quiescent_state() records ->last_rs_qlen = ->qlen.
But we don't reset ->last_rs_qlen when ->qlen goes to 0, this means that
next time we need ++rdp->qlen > qhimark + rsinterval to force other CPUS
to pass quiescent state, no?

Also, it seems to me it's better to have 2 counters, one for length(->donelist)
and another for length(->curlist + ->nxtlist). I think we don't need
force_quiescent_state() when all rcu callbacks are placed in ->donelist,
we only need to increase rdp->blimit in this case.

Oleg.
