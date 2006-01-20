Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751134AbWATSUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbWATSUP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 13:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbWATSUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 13:20:15 -0500
Received: from [63.81.120.158] ([63.81.120.158]:39665 "EHLO hermes.mvista.com")
	by vger.kernel.org with ESMTP id S1751134AbWATSUN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 13:20:13 -0500
Subject: Re: BUG in check_monotonic_clock()
From: Daniel Walker <dwalker@mvista.com>
To: george@wildturkeyranch.net
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org, tglx@linutronix.de
In-Reply-To: <43D126C4.8040006@wildturkeyranch.net>
References: <1137779515.3202.3.camel@localhost.localdomain>
	 <43D126C4.8040006@wildturkeyranch.net>
Content-Type: text/plain
Date: Fri, 20 Jan 2006 10:20:11 -0800
Message-Id: <1137781211.3202.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


No . I'll try it though .

Daniel


On Fri, 2006-01-20 at 10:07 -0800, George Anzinger wrote:
> Daniel Walker wrote:
> > 
> > This is off a dual P3 during boot with 2.6.15-rt6. I'll send the .config
> > privately . I had a fair amount of debugging on.
> 
> Has the attached patch been applied?  Fixed this for me....
> 
> George
> -- 
> > 
> > 
> > check_monotonic_clock: monotonic inconsistency detected!
> >         from        1a27e7384 (7021163396) to        19f92d748 (6972168008).
> > udev/238[CPU#1]: BUG in check_monotonic_clock at kernel/time/timeofday.c:160
> >  [<c0105b03>] dump_stack+0x23/0x30 (20)
> >  [<c0129e43>] __WARN_ON+0x63/0x80 (40)
> >  [<c0148584>] check_monotonic_clock+0xd4/0xe0 (52)
> >  [<c01489b8>] get_monotonic_clock+0xc8/0x100 (56)
> >  [<c014475d>] __hrtimer_start+0xdd/0x100 (40)
> >  [<c0400046>] schedule_hrtimer+0x46/0xd0 (48)
> >  [<c0144f0f>] hrtimer_nanosleep+0x5f/0x130 (104)
> >  [<c0145053>] sys_nanosleep+0x73/0x80 (36)
> >  [<c0104b2a>] syscall_call+0x7/0xb (-4020)
> > ---------------------------
> > | preempt count: 00000002 ]
> > | 2-level deep critical section nesting:
> > ----------------------------------------
> > .. [<c014cf1c>] .... add_preempt_count+0x1c/0x20
> > .....[<c0143e2a>] ..   ( <= lock_hrtimer_base+0x2a/0x60)
> > .. [<c014cf1c>] .... add_preempt_count+0x1c/0x20
> > .....[<c0129df6>] ..   ( <= __WARN_ON+0x16/0x80)
> > 
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
> plain text document attachment (ktime_conversion.patch)
>  kernel/time.c |   13 ++++++++-----
>  1 files changed, 8 insertions(+), 5 deletions(-)
> 
> Index: linux-2.6.16-rc/kernel/time.c
> ===================================================================
> --- linux-2.6.16-rc.orig/kernel/time.c
> +++ linux-2.6.16-rc/kernel/time.c
> @@ -702,16 +702,19 @@ void set_normalized_timespec(struct time
>   *
>   * Returns the timespec representation of the nsec parameter.
>   */
> -inline struct timespec ns_to_timespec(const nsec_t nsec)
> +struct timespec ns_to_timespec(const nsec_t nsec)
>  {
>  	struct timespec ts;
>  
> -	if (nsec)
> +	if (!nsec) return (struct timespec){0, 0};
> +
> +	if (nsec < 0) {
> +		ts.tv_sec = div_long_long_rem_signed(-nsec, NSEC_PER_SEC,
> +						     &ts.tv_nsec);
> +		set_normalized_timespec(&ts, -ts.tv_sec, -ts.tv_nsec);
> +	} else
>  		ts.tv_sec = div_long_long_rem_signed(nsec, NSEC_PER_SEC,
>  						     &ts.tv_nsec);
> -	else
> -		ts.tv_sec = ts.tv_nsec = 0;
> -
>  	return ts;
>  }
>  

