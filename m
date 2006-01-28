Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751474AbWA1Qu1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474AbWA1Qu1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 11:50:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751482AbWA1Qu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 11:50:27 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:59330 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751474AbWA1Qu0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 11:50:26 -0500
Message-ID: <43DBB2D1.8E79F4CE@tv-sign.ru>
Date: Sat, 28 Jan 2006 21:07:13 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: paulmck@us.ibm.com
Cc: Dipankar Sarma <dipankar@in.ibm.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch 1/2] rcu batch tuning
References: <43DA7B47.11D10B09@tv-sign.ru> <20060127234231.GD10075@us.ibm.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Paul E. McKenney" wrote:
> 
> On Fri, Jan 27, 2006 at 10:57:59PM +0300, Oleg Nesterov wrote:
> >
> > When ->qlen exceeds qhimark for the first time we send reschedule IPI to
> > other CPUs and force_quiescent_state() records ->last_rs_qlen = ->qlen.
> > But we don't reset ->last_rs_qlen when ->qlen goes to 0, this means that
> > next time we need ++rdp->qlen > qhimark + rsinterval to force other CPUS
> > to pass quiescent state, no?
> 
> Good catch -- this could well explain Lee's continuing to hit
> latency problems.  Although this would not cause the first
> latency event, only subsequent ones, it seems to me that ->last_rs_qlen
> should be reset whenever ->blimit is reset.

May be it's better to do it in other way?

struct rcu_ctrlblk {
	...
	int signaled;
	...
};

void force_quiescent_state(rdp, rcp)
{
	if (!rcp->signaled) {
		// racy, but tolerable
		rcp->signaled = 1;

		for_each_cpu_mask(cpu, cpumask)
			smp_send_reschedule(cpu);
	}
}

void rcu_start_batch(rcp, rdp)
{
	if (->next_pending && ->completed == ->cur) {
		...
		rcp->signaled = 0;
		...
	}
}

Probably it is also makes sense to tasklet_schedule(rcu_tasklet)
in call_rcu() when ++rdp->qlen > qhimark, this way we can detect
that we need to start the next batch earlier.

> > Also, it seems to me it's better to have 2 counters, one for length(->donelist)
> > and another for length(->curlist + ->nxtlist). I think we don't need
> > force_quiescent_state() when all rcu callbacks are placed in ->donelist,
> > we only need to increase rdp->blimit in this case.
>
> True, currently the patch keeps the sum of the length of all three lists,
> and takes both actions when the sum gets too large.  But the only way
> you would get unneeded IPIs would be if callback processing was
> stalled, but callback generation and grace-period processing was
> still proceeding.  Seems at first glance to be an unusual corner
> case, with the only downside being some extra IPIs.  Or am I missing
> some aspect?

Yes, it is probably not worth to complicate the code.

Oleg.
