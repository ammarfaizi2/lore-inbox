Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316619AbSFPX5o>; Sun, 16 Jun 2002 19:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316621AbSFPX5o>; Sun, 16 Jun 2002 19:57:44 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:38382 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S316619AbSFPX5m>; Sun, 16 Jun 2002 19:57:42 -0400
Subject: Re: [patch] 2.4.19-pre10-ac2: O(1) scheduler merge, -A3.
From: Robert Love <rml@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0206161809480.9633-200000@e2>
References: <Pine.LNX.4.44.0206161809480.9633-200000@e2>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 16 Jun 2002 16:57:24 -0700
Message-Id: <1024271844.1476.26.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-06-16 at 10:00, Ingo Molnar wrote:

> Feature backports:
> 
>  - nr_uninterruptible optimization. (This is a fairly straightforward
>    and risk-less feature, and since it also made the backport easier, i
>    included it.)

Yah, I agree - this is safe and good.

>  - sched_setaffinity() & sched_getaffinity() syscalls on x86.

Do we want to introduce this into 2.4 now?  I realize 2.4-ac is not 2.4
proper, but if there is a chance this interface could change...

> -	BUG_ON(in_interrupt());
> -
> +	if (unlikely(in_interrupt()))
> +		BUG();

Eh, why do this?  BUG_ON is the same effect and it is more readable to
me... seems better that 2.5 gets 2.4-ac's behavior instead of the other
way around.

> +int idle_cpu(int cpu)
> +{
> +	return cpu_curr(cpu) == cpu_rq(cpu)->idle;
> +}
> +

I did not include this in my original O(1) backport update because
nothing in 2.4-ac seems to use it... so why include it?

>  	/*
>  	 * Valid priorities for SCHED_FIFO and SCHED_RR are
> -	 * 1..MAX_USER_RT_PRIO-1, valid priority for SCHED_OTHER is 0.
> +	 * 1..MAX_USER_RT_PRIO, valid priority for SCHED_OTHER is 0.
>  	 */

Another case of 2.4-ac being right: the priority range is
1..MAX_USER_RT_PRIO-1 (i.e. 1 to 99, inclusive).

>  	/*
> -	 * The first migration thread is started on CPU #0. This one can
> -	 * migrate the other migration threads to their destination CPUs.
> +	 * The first migration thread is started on CPU #0. This one can migrate
> +	 * the other migration threads to their destination CPUs.
>  	 */
>  	if (cpu != 0) {
>  		while (!cpu_rq(cpu_logical_map(0))->migration_thread)
>  			yield();
>  		set_cpus_allowed(current, 1UL << cpu);
>  	}
> -	printk("migration_task %d on cpu=%d\n", cpu, smp_processor_id());
> +	printk("migration_task %d on cpu=%d\n",cpu,smp_processor_id());
>  	ret = setscheduler(0, SCHED_FIFO, &param);
>  	rq = this_rq();
> @@ -1632,5 +1813,4 @@
>  		while (!cpu_rq(cpu_logical_map(cpu))->migration_thread)
>  			schedule_timeout(2);
>  }
> -
> -#endif /* CONFIG_SMP */
> +#endif

I think all three of these hunks look better in 2.4-ac... in all three
cases, the formatting seems better than in 2.5 IMO.

	Robert Love

