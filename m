Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268848AbUJEGnx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268848AbUJEGnx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 02:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268849AbUJEGnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 02:43:53 -0400
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:18046 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268848AbUJEGnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 02:43:50 -0400
Message-ID: <416242A1.3060203@yahoo.com.au>
Date: Tue, 05 Oct 2004 16:43:45 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Roland McGrath <roland@redhat.com>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ulrich Drepper <drepper@redhat.com>,
       Christoph Lameter <clameter@sgi.com>
Subject: Re: [PATCH] CPU time clock support in clock_* syscalls
References: <200410050515.i955Fa15004063@magilla.sf.frob.com>
In-Reply-To: <200410050515.i955Fa15004063@magilla.sf.frob.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland McGrath wrote:

>  /*
> + * This is called on clock ticks and on context switches.
> + * Bank in p->sched_time the ns elapsed since the last tick or switch.
> + */
> +static void update_cpu_clock(task_t *p, runqueue_t *rq,
> +			     unsigned long long now)
> +{
> +	unsigned long long last = max(p->timestamp, rq->timestamp_last_tick);
> +	p->sched_time += now - last;
> +}

This looks wrong. But update_cpu_clock is never called from another
CPU. In which case you don't need to worry about timestamp_last_tick.

> +
> +/*
> + * Return current->sched_time plus any more ns on the sched_clock
> + * that have not yet been banked.
> + */
> +unsigned long long current_sched_time(const task_t *tsk)
> +{
> +	unsigned long long ns;
> +	local_irq_disable();
> +	ns = max(tsk->timestamp, task_rq(tsk)->timestamp_last_tick);
> +	ns = tsk->sched_time + (sched_clock() - ns);
> +	local_irq_enable();
> +	return ns;
> +}
> +

This doesn't perform the timestamp_last_tick "normalisation" properly
either.

It also seems to conveniently ignore locking when reading those values
off another CPU. Not a big deal for dynamic load calculations, but I'm
not so sure about your usage...?

Lastly, even when using timestamp_last_tick correctly, I think sched_clock
will still drift around slightly, especially if a task switches CPUs a lot
(but not restricted to moving CPUs). Again this is something that I
haven't thought about much because it is not a big deal for current usage.

