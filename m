Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265871AbSKBD3Q>; Fri, 1 Nov 2002 22:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265872AbSKBD3Q>; Fri, 1 Nov 2002 22:29:16 -0500
Received: from packet.digeo.com ([12.110.80.53]:28837 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265871AbSKBD3P>;
	Fri, 1 Nov 2002 22:29:15 -0500
Message-ID: <3DC34808.A8FE6FAC@digeo.com>
Date: Fri, 01 Nov 2002 19:35:36 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.45 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: linux-kernel@vger.kernel.org, riel@surriel.com, mingo@elte.hu,
       pbadari@us.ibm.com
Subject: Re: idle time & iowait accounting
References: <20021102031810.GA12891@holomorphy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Nov 2002 03:35:37.0174 (UTC) FILETIME=[E88A5760:01C28220]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> 
> ...
> 
> +unsigned long nr_iowait(void)
> +{
> +       unsigned long i, sum = 0;
> +
> +       for (i = 0; i < NR_CPUS; ++i)
> +               sum += atomic_read(&cpu_rq(i)->nr_iowait);
> +
> +       return sum;
> +}
> +

We need to make a habit of checking cpu_online(i) in here.  I'd rather
this consume 4 cachelines than 32, thanks ;)

Also, if we decide to allocate each CPU's per-cpu memory separately
any for-all-CPUs loop which uses per-cpu data MUST make this check,
else it'll oops.

Not applicable in this case, and alas the cpu iterator helper macros
(for_each_online_cpu(), etc) are currently AWOL, but...

> +void io_schedule(void)
> +{
> +       struct runqueue *rq;
> +       preempt_disable();
> +       rq = this_rq();
> +       atomic_inc(&rq->nr_iowait);
> +       schedule();
> +       atomic_dec(&rq->nr_iowait);
> +       preempt_enable();
> +}

"scheduling while atomic".  You'll need to reacquire the runqueue pointer
on waking up.

> +
> +void io_schedule_timeout(long timeout)
> +{
> +       struct runqueue *rq;
> +       preempt_disable();
> +       rq = this_rq();
> +       atomic_inc(&rq->nr_iowait);
> +       schedule_timeout(timeout);
> +       atomic_dec(&rq->nr_iowait);
> +       preempt_enable();
> +}

And here too.

Apart from that, looks very good, thanks.
