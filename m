Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161020AbVLODrY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161020AbVLODrY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 22:47:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161036AbVLODrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 22:47:23 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:17131 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161033AbVLODrW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 22:47:22 -0500
Subject: Re: [patch 15/21] hrtimer core code
From: Matt Helsley <matthltc@us.ibm.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       rostedt@goodmis.org, john stultz <johnstul@us.ibm.com>,
       zippel@linux-m86k.org, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20051206000154.884060000@tglx.tec.linutronix.de>
References: <20051206000126.589223000@tglx.tec.linutronix.de>
	 <20051206000154.884060000@tglx.tec.linutronix.de>
Content-Type: text/plain
Date: Wed, 14 Dec 2005 19:43:01 -0800
Message-Id: <1134618181.7372.8.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-06 at 01:01 +0100, tglx@linutronix.de wrote:
<snip>

> Index: linux-2.6.15-rc5/kernel/hrtimer.c
> ===================================================================
> --- /dev/null
> +++ linux-2.6.15-rc5/kernel/hrtimer.c

<snip>

> +/**
> + * ktime_get_ts - get the monotonic clock in timespec format
> + *
> + * @ts:		pointer to timespec variable
> + *
> + * The function calculates the monotonic clock from the realtime
> + * clock and the wall_to_monotonic offset and stores the result
> + * in normalized timespec format in the variable pointed to by ts.
> + */
> +void ktime_get_ts(struct timespec *ts)
> +{
> +	struct timespec tomono;
> +	unsigned long seq;
> +
> +	do {
> +		seq = read_seqbegin(&xtime_lock);
> +		getnstimeofday(ts);
> +		tomono = wall_to_monotonic;
> +
> +	} while (read_seqretry(&xtime_lock, seq));
> +
> +	set_normalized_timespec(ts, ts->tv_sec + tomono.tv_sec,
> +				ts->tv_nsec + tomono.tv_nsec);
> +}

<snip>

unlike many other places I've seen the loop structure: 
       do {
               seq = read_seqbegin(&xtime_lock);
...
       } while (unlikely(read_seqretry(&xtime_lock, seq)));

This one lacks the unlikely() in the loop condition. Do high res timers
tend to make the branch hint incorrect?

Thanks,
	-Matt Helsley


